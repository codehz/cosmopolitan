#-*-mode:makefile-gmake;indent-tabs-mode:t;tab-width:8;coding:utf-8-*-┐
#── vi: set et ft=make ts=8 sw=8 fenc=utf-8 :vi ──────────────────────┘

PKGS += THIRD_PARTY_READLINE

THIRD_PARTY_READLINE_ARTIFACTS += THIRD_PARTY_READLINE_A
THIRD_PARTY_READLINE = $(THIRD_PARTY_READLINE_A_DEPS) $(THIRD_PARTY_READLINE_A)
THIRD_PARTY_READLINE_A = o/$(MODE)/third_party/readline/readline.a
THIRD_PARTY_READLINE_A_FILES := $(wildcard third_party/readline/*)
THIRD_PARTY_READLINE_A_HDRS = $(filter %.h,$(THIRD_PARTY_READLINE_A_FILES))
THIRD_PARTY_READLINE_A_INCS = $(filter %.inc,$(THIRD_PARTY_READLINE_A_FILES))
THIRD_PARTY_READLINE_A_SRCS = $(filter %.c,$(THIRD_PARTY_READLINE_A_FILES))
THIRD_PARTY_READLINE_A_OBJS = $(THIRD_PARTY_READLINE_A_SRCS:%.c=o/$(MODE)/%.o)
THIRD_PARTY_READLINE_A_CHECKS = $(THIRD_PARTY_READLINE_A).pkg

THIRD_PARTY_READLINE_A_DIRECTDEPS =			\
	LIBC_CALLS					\
	LIBC_FMT					\
	LIBC_INTRIN					\
	LIBC_MEM					\
	LIBC_NEXGEN32E					\
	LIBC_PROC					\
	LIBC_RUNTIME					\
	LIBC_STDIO					\
	LIBC_STR					\
	LIBC_SYSV					\
	THIRD_PARTY_MUSL				\
	THIRD_PARTY_NCURSES

THIRD_PARTY_READLINE_A_DEPS :=				\
	$(call uniq,$(foreach x,$(THIRD_PARTY_READLINE_A_DIRECTDEPS),$($(x))))

$(THIRD_PARTY_READLINE_A):				\
		third_party/readline/			\
		$(THIRD_PARTY_READLINE_A).pkg		\
		$(THIRD_PARTY_READLINE_A_OBJS)

$(THIRD_PARTY_READLINE_A).pkg:				\
		$(THIRD_PARTY_READLINE_A_OBJS)		\
		$(foreach x,$(THIRD_PARTY_READLINE_A_DIRECTDEPS),$($(x)_A).pkg)

$(THIRD_PARTY_READLINE_A_OBJS): private			\
		CPPFLAGS +=				\
			-DHAVE_CONFIG_H			\
			-DRL_LIBRARY_VERSION=\"8.2\"	\
			-DBRACKETED_PASTE_DEFAULT=1

$(THIRD_PARTY_READLINE_A_OBJS): private			\
		CFLAGS +=				\
			-Wno-unused-but-set-variable	\
			-Wno-stringop-truncation	\
			-Wno-maybe-uninitialized	\
			-Wno-unused-variable		\
			-Wno-unused-label		\
			-Wno-parentheses		\
			-fportcosmo

THIRD_PARTY_READLINE_BINS = $(THIRD_PARTY_READLINE_COMS) $(THIRD_PARTY_READLINE_COMS:%=%.dbg)
THIRD_PARTY_READLINE_LIBS = $(foreach x,$(THIRD_PARTY_READLINE_ARTIFACTS),$($(x)))
THIRD_PARTY_READLINE_SRCS = $(foreach x,$(THIRD_PARTY_READLINE_ARTIFACTS),$($(x)_SRCS))
THIRD_PARTY_READLINE_HDRS = $(foreach x,$(THIRD_PARTY_READLINE_ARTIFACTS),$($(x)_HDRS))
THIRD_PARTY_READLINE_INCS = $(foreach x,$(THIRD_PARTY_READLINE_ARTIFACTS),$($(x)_INCS))
THIRD_PARTY_READLINE_CHECKS = $(foreach x,$(THIRD_PARTY_READLINE_ARTIFACTS),$($(x)_CHECKS))
THIRD_PARTY_READLINE_OBJS = $(foreach x,$(THIRD_PARTY_READLINE_ARTIFACTS),$($(x)_OBJS))
$(THIRD_PARTY_READLINE_A_OBJS): $(BUILD_FILES) third_party/readline/BUILD.mk

.PHONY: o/$(MODE)/third_party/readline
o/$(MODE)/third_party/readline:				\
		$(THIRD_PARTY_READLINE_A)		\
		$(THIRD_PARTY_READLINE_BINS)		\
		$(THIRD_PARTY_READLINE_CHECKS)
