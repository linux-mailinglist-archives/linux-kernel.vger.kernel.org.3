Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81AEB5155D0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 22:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380889AbiD2Ulb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 16:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380996AbiD2UlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 16:41:01 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C38C8BC7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 13:37:26 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2eb7d137101so84824967b3.12
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 13:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wn6Fk0jdzmyKcWzAtklzhzbugkNpgCzrIA6neEfx0hw=;
        b=B0ipEFgTHkrk1DW294MGsIOmwMvWMTi7yFa5IvHBScPSSCIQ12inv8qFk9kMkQ+cWo
         Q10QSGBYwQsJ+1mP+2NJRTJ2NZGdpgNoGUiUQ44g1Cr5ZqLcK7SplW9ejQ+/9J/oKRmF
         Gc2BAu/DPl7VA2HzLqre22OeoNpvhHeWjiGMJA4K4ERKRcpd1RZMx8A7GDrxViAyVHpo
         /YbXW0Z+LLwNCzoEK+5FjnolHrsOyMim+pFQeE4KyVUM+oU54jxhjmnYfSZFGTzKELSY
         6uw4QPhNnYwzhdxwvFQ5Yu+rG31zgQ2jWlMVVo+VQskxCMWz5snM1X1IrOKP68SgBaO2
         uqYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wn6Fk0jdzmyKcWzAtklzhzbugkNpgCzrIA6neEfx0hw=;
        b=Dq7MLZaXG/2YhYnUWa7CJGMwcnKGE5GK+MUldCSTPHz47F/hSIisiSILtsrs+GQV91
         kwrg8kBegPqJMR8zYQk7tJcGCOgNmA9XPOxaDQ9M95s232UmD8iG8t6DGczDfOH0rXJA
         x2p0YEcF9ILvMz5bTOFwaz1U4XMy0IQB7ZUnoCd0DR45Ptpa2rhgBHaTTMR7iZ0iVSPU
         aWgq+LsWSxD7c7ofUmJLYt6S1m7kXi1cGT2jsGebkaUkKeHov2hCh1bgef7peC5ZgEdG
         iYWM0OaaKx6/oRYotQtyaFLV9k4Wz3k6ZjDaYIqjzq3ZZJd/WHnBeYh+2+jcV4bcd7/X
         Futw==
X-Gm-Message-State: AOAM533nTW7t+S8XVzzBu8nwBfR2yVIRzbl5uVeSiJBb/MLnBalbrHZ9
        +X+n9JZCUXO2iimfkQaw3690d3SSeMH8G6obhLp9nxbQaLUd9LYVIcTmloh/d1yOXLhEf76f3bW
        FAJyQ09chc+wK4GLtzlOhUQ+ceCT1InTnMcZVvYH4EQ2PS0H8QCjYo23qAmfKj/JkWFaPr8rouF
        /USJf2De4Tqg==
X-Google-Smtp-Source: ABdhPJzIdF+dDHh9hmX3ACfTDHmp2X8oeUP0bceeU1/QL1FSMLv4TzO0/t9MouMPiSEZ/YrjXh5v45gGaX2itQXlRUg=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:351:bea9:f158:1021])
 (user=samitolvanen job=sendgmr) by 2002:a25:7008:0:b0:648:6d04:f4ab with SMTP
 id l8-20020a257008000000b006486d04f4abmr1288105ybc.127.1651264645781; Fri, 29
 Apr 2022 13:37:25 -0700 (PDT)
Date:   Fri, 29 Apr 2022 13:36:39 -0700
In-Reply-To: <20220429203644.2868448-1-samitolvanen@google.com>
Message-Id: <20220429203644.2868448-17-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220429203644.2868448-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=10066; h=from:subject;
 bh=5Ub68Ba6efUThwF+cCSBq2rK+XTwq+L6mbSroJ2k1gE=; b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBibExX80UREFSoz+uKGJsMYz1mV8KXavHjkutESBeW
 An4NZkSJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYmxMVwAKCRBMtfaEi7xW7lD+DA
 CQoFQ7kl9gHyGLqmu+nwdDyP/PSkHFFRg3CiJvlC0ZRJ2zLoG5Nzrh/KnIA2TmZQz+sHZTegYwvudJ
 n8i1eZ8VZyWzjuZhZPu/myYCfotxkoUI3gl53m2MOcD0uQYmhDgdubyUDJO9TdtCjwElVp1XY8oMOh
 708PBYVRyPioCZ2nwpzUuQ5IhA+bgW16TblTFxij9BF4gxD8PFKfiBEkkasHhKCbHDcGopUVVyVgQK
 1XqsebLMxBO0UnFaqkvO6MMfbFw+xYbM/h8Yg0y5Q5JTLhdTr+XSj8ZDlryGNJO6xxJr0Q6poc0yMS
 AxYKHb4dsc7u84x/sSBolnBK7bjMSlYRfsMKvI9pnltVYatPZ4diR0DkgbuoIpeRQr6yNT65OyPmP3
 XHDtXL9jv33JBEavuzC9/Gwa8slGA9SwU/jmu1jf/fiWnTL/kWQEQOtXFSKhgu1hVkkk2/RfUvtxWw
 ppG6f/2balDMELLoCNfwzhU7imNi9CsYIwxKYQEOtU/Iw=
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [RFC PATCH 16/21] objtool: Add support for CONFIG_CFI_CLANG
From:   Sami Tolvanen <samitolvanen@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With -fsanitize=kcfi, the compiler injects a type identifier before
each function. Teach objtool to recognize the identifier.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 scripts/Makefile.build                    |   3 +-
 scripts/link-vmlinux.sh                   |   3 +
 tools/objtool/arch/x86/include/arch/elf.h |   2 +
 tools/objtool/builtin-check.c             |   3 +-
 tools/objtool/check.c                     | 128 ++++++++++++++++++++--
 tools/objtool/elf.c                       |  13 +++
 tools/objtool/include/objtool/arch.h      |   1 +
 tools/objtool/include/objtool/builtin.h   |   2 +-
 tools/objtool/include/objtool/elf.h       |   2 +
 9 files changed, 145 insertions(+), 12 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 9717e6f6fb31..c850ac420b60 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -235,7 +235,8 @@ objtool_args =								\
 	$(if $(CONFIG_RETPOLINE), --retpoline)				\
 	$(if $(CONFIG_X86_SMAP), --uaccess)				\
 	$(if $(CONFIG_FTRACE_MCOUNT_USE_OBJTOOL), --mcount)		\
-	$(if $(CONFIG_SLS), --sls)
+	$(if $(CONFIG_SLS), --sls)					\
+	$(if $(CONFIG_CFI_CLANG), --kcfi)
 
 cmd_objtool = $(if $(objtool-enabled), ; $(objtool) $(objtool_args) $@)
 cmd_gen_objtooldep = $(if $(objtool-enabled), { echo ; echo '$@: $$(wildcard $(objtool))' ; } >> $(dot-target).cmd)
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 20f44504a644..d171f8507db2 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -152,6 +152,9 @@ objtool_link()
 		if is_enabled CONFIG_SLS; then
 			objtoolopt="${objtoolopt} --sls"
 		fi
+		if is_enabled CONFIG_CFI_CLANG; then
+			objtoolopt="${objtoolopt} --kcfi"
+		fi
 		info OBJTOOL ${1}
 		tools/objtool/objtool ${objtoolcmd} ${objtoolopt} ${1}
 	fi
diff --git a/tools/objtool/arch/x86/include/arch/elf.h b/tools/objtool/arch/x86/include/arch/elf.h
index 69cc4264b28a..8833d989eec7 100644
--- a/tools/objtool/arch/x86/include/arch/elf.h
+++ b/tools/objtool/arch/x86/include/arch/elf.h
@@ -3,4 +3,6 @@
 
 #define R_NONE R_X86_64_NONE
 
+#define KCFI_TYPEID_LEN	6
+
 #endif /* _OBJTOOL_ARCH_ELF */
diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index fc6975ab8b06..8a662dcc21be 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -21,7 +21,7 @@
 
 bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats,
      lto, vmlinux, mcount, noinstr, backup, sls, dryrun,
-     ibt;
+     ibt, kcfi;
 
 static const char * const check_usage[] = {
 	"objtool check [<options>] file.o",
@@ -49,6 +49,7 @@ const struct option check_options[] = {
 	OPT_BOOLEAN('S', "sls", &sls, "validate straight-line-speculation"),
 	OPT_BOOLEAN(0, "dry-run", &dryrun, "don't write the modifications"),
 	OPT_BOOLEAN(0, "ibt", &ibt, "validate ENDBR placement"),
+	OPT_BOOLEAN('k', "kcfi", &kcfi, "detect control-flow integrity type identifiers"),
 	OPT_END(),
 };
 
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index bd0c2c828940..e6bee2f2996a 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -27,6 +27,12 @@ struct alternative {
 	bool skip_orig;
 };
 
+struct kcfi_type {
+	struct section *sec;
+	unsigned long offset;
+	struct hlist_node hash;
+};
+
 static unsigned long nr_cfi, nr_cfi_reused, nr_cfi_cache;
 
 static struct cfi_init_state initial_func_cfi;
@@ -143,6 +149,99 @@ static bool is_sibling_call(struct instruction *insn)
 	return (is_static_jump(insn) && insn->call_dest);
 }
 
+static int kcfi_bits;
+static struct hlist_head *kcfi_hash;
+
+static void *kcfi_alloc_hash(unsigned long size)
+{
+	kcfi_bits = max(10, ilog2(size));
+	kcfi_hash = mmap(NULL, sizeof(struct hlist_head) << kcfi_bits,
+			PROT_READ|PROT_WRITE,
+			MAP_PRIVATE|MAP_ANON, -1, 0);
+	if (kcfi_hash == (void *)-1L) {
+		WARN("mmap fail kcfi_hash");
+		kcfi_hash = NULL;
+	}  else if (stats) {
+		printf("kcfi_bits: %d\n", kcfi_bits);
+	}
+
+	return kcfi_hash;
+}
+
+static void add_kcfi_type(struct kcfi_type *type)
+{
+	hlist_add_head(&type->hash,
+		&kcfi_hash[hash_min(
+			sec_offset_hash(type->sec, type->offset),
+			kcfi_bits)]);
+}
+
+static bool add_kcfi_types(struct section *sec)
+{
+	struct reloc *reloc;
+
+	list_for_each_entry(reloc, &sec->reloc_list, list) {
+		struct kcfi_type *type;
+
+		if (reloc->sym->type != STT_SECTION) {
+			WARN("unexpected relocation symbol type in %s", sec->name);
+			return false;
+		}
+
+		type = malloc(sizeof(*type));
+		if (!type) {
+			perror("malloc");
+			return false;
+		}
+
+		type->sec = reloc->sym->sec;
+		type->offset = reloc->addend;
+
+		add_kcfi_type(type);
+	}
+
+	return true;
+}
+
+static int read_kcfi_types(struct objtool_file *file)
+{
+	if (!kcfi)
+		return 0;
+
+	if (!kcfi_alloc_hash(file->elf->text_size / 16))
+		return -1;
+
+	if (!for_each_section_by_name(file->elf, ".rela.kcfi_types", add_kcfi_types))
+		return -1;
+
+	return 0;
+}
+
+static bool is_kcfi_typeid(struct elf *elf, struct instruction *insn)
+{
+	struct hlist_head *head;
+	struct kcfi_type *type;
+	struct reloc *reloc;
+
+	if (!kcfi)
+		return false;
+
+	/* Compiler-generated annotation in .kcfi_types. */
+	head = &kcfi_hash[hash_min(sec_offset_hash(insn->sec, insn->offset), kcfi_bits)];
+
+	hlist_for_each_entry(type, head, hash)
+		if (type->sec == insn->sec && type->offset == insn->offset)
+			return true;
+
+	/* Manual annotation (in assembly code). */
+	reloc = find_reloc_by_dest(elf, insn->sec, insn->offset);
+
+	if (reloc && !strncmp(reloc->sym->name, "__kcfi_typeid_", 14))
+		return true;
+
+	return false;
+}
+
 /*
  * This checks to see if the given function is a "noreturn" function.
  *
@@ -388,13 +487,18 @@ static int decode_instructions(struct objtool_file *file)
 			insn->sec = sec;
 			insn->offset = offset;
 
-			ret = arch_decode_instruction(file, sec, offset,
-						      sec->sh.sh_size - offset,
-						      &insn->len, &insn->type,
-						      &insn->immediate,
-						      &insn->stack_ops);
-			if (ret)
-				goto err;
+			if (is_kcfi_typeid(file->elf, insn)) {
+				insn->type = INSN_KCFI_TYPEID;
+				insn->len = KCFI_TYPEID_LEN;
+			} else {
+				ret = arch_decode_instruction(file, sec, offset,
+							      sec->sh.sh_size - offset,
+							      &insn->len, &insn->type,
+							      &insn->immediate,
+							      &insn->stack_ops);
+				if (ret)
+					goto err;
+			}
 
 			/*
 			 * By default, "ud2" is a dead end unless otherwise
@@ -420,7 +524,8 @@ static int decode_instructions(struct objtool_file *file)
 			}
 
 			sym_for_each_insn(file, func, insn) {
-				insn->func = func;
+				if (insn->type != INSN_KCFI_TYPEID)
+					insn->func = func;
 				if (insn->type == INSN_ENDBR && list_empty(&insn->call_node)) {
 					if (insn->offset == insn->func->offset) {
 						list_add_tail(&insn->call_node, &file->endbr_list);
@@ -2219,6 +2324,10 @@ static int decode_sections(struct objtool_file *file)
 	if (ret)
 		return ret;
 
+	ret = read_kcfi_types(file);
+	if (ret)
+		return ret;
+
 	ret = decode_instructions(file);
 	if (ret)
 		return ret;
@@ -3595,7 +3704,8 @@ static bool ignore_unreachable_insn(struct objtool_file *file, struct instructio
 	int i;
 	struct instruction *prev_insn;
 
-	if (insn->ignore || insn->type == INSN_NOP || insn->type == INSN_TRAP)
+	if (insn->ignore || insn->type == INSN_NOP || insn->type == INSN_TRAP ||
+			insn->type == INSN_KCFI_TYPEID)
 		return true;
 
 	/*
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index d7b99a737496..c4e277d41fd2 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -120,6 +120,19 @@ struct section *find_section_by_name(const struct elf *elf, const char *name)
 	return NULL;
 }
 
+bool for_each_section_by_name(const struct elf *elf, const char *name,
+			      bool (*callback)(struct section *))
+{
+	struct section *sec;
+
+	elf_hash_for_each_possible(section_name, sec, name_hash, str_hash(name)) {
+		if (!strcmp(sec->name, name) && !callback(sec))
+			return false;
+	}
+
+	return true;
+}
+
 static struct section *find_section_by_index(struct elf *elf,
 					     unsigned int idx)
 {
diff --git a/tools/objtool/include/objtool/arch.h b/tools/objtool/include/objtool/arch.h
index 9b19cc304195..3db5951e7aa9 100644
--- a/tools/objtool/include/objtool/arch.h
+++ b/tools/objtool/include/objtool/arch.h
@@ -28,6 +28,7 @@ enum insn_type {
 	INSN_CLD,
 	INSN_TRAP,
 	INSN_ENDBR,
+	INSN_KCFI_TYPEID,
 	INSN_OTHER,
 };
 
diff --git a/tools/objtool/include/objtool/builtin.h b/tools/objtool/include/objtool/builtin.h
index c39dbfaef6dc..68409070bca5 100644
--- a/tools/objtool/include/objtool/builtin.h
+++ b/tools/objtool/include/objtool/builtin.h
@@ -10,7 +10,7 @@
 extern const struct option check_options[];
 extern bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats,
 	    lto, vmlinux, mcount, noinstr, backup, sls, dryrun,
-	    ibt;
+	    ibt, kcfi;
 
 extern int cmd_parse_options(int argc, const char **argv, const char * const usage[]);
 
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index 22ba7e2b816e..7fd3462ce32a 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -148,6 +148,8 @@ int elf_write(struct elf *elf);
 void elf_close(struct elf *elf);
 
 struct section *find_section_by_name(const struct elf *elf, const char *name);
+bool for_each_section_by_name(const struct elf *elf, const char *name,
+			      bool (*callback)(struct section *));
 struct symbol *find_func_by_offset(struct section *sec, unsigned long offset);
 struct symbol *find_symbol_by_offset(struct section *sec, unsigned long offset);
 struct symbol *find_symbol_by_name(const struct elf *elf, const char *name);
-- 
2.36.0.464.gb9c8b46e94-goog

