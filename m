Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4344EBE9D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 12:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238015AbiC3KZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 06:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232733AbiC3KZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 06:25:28 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B1B22B26
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 03:23:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9D0121F37B;
        Wed, 30 Mar 2022 10:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1648635817; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SutU6NtJAmcvVDw7i47SPK0xcm6dOxLZHlPN45bee54=;
        b=PkFKO9wpNJaTq7DrYcMFPtlefJ9kj3nlcYwCedENhhQ/1EzYOL7r7+guxAVWoZNzqSP0rD
        KD5O0ataCT9mcq33DdNoEWIHx6IStvpXWcUaP468U+slwx5i+M/QH0rCqG84tl16HcIVt/
        c3yR2XskLwD4eGRxfDvFt6be1wcx0lA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1648635817;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SutU6NtJAmcvVDw7i47SPK0xcm6dOxLZHlPN45bee54=;
        b=0yD1QCIj2M4IWRy9dWcKEl6bAzgE6V7FdqlpsjxCwMIRXss3tt3ym1PNDp2J8e5wt/MLDV
        8v+uDCX2BQtxg+AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9049813AF3;
        Wed, 30 Mar 2022 10:23:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tf8yI6kvRGKUdgAAMHmgww
        (envelope-from <bp@suse.de>); Wed, 30 Mar 2022 10:23:37 +0000
Date:   Wed, 30 Mar 2022 12:23:36 +0200
From:   Borislav Petkov <bp@suse.de>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [ammarfaizi2-block:bp/bp/rc0+ 6/11]
 arch/x86/kernel/cpu/common.c:1415:10: error: 'x86_cap_flags' undeclared; did
 you mean 'x86_cap_flag'?
Message-ID: <YkQvqGODzC9yDJrI@zn.tnic>
References: <202203292206.ICsY2RKX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202203292206.ICsY2RKX-lkp@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 10:23:07PM +0800, kernel test robot wrote:
> tree:   https://github.com/ammarfaizi2/linux-block bp/bp/rc0+
> head:   2d784fc7295963360594f3de64446aa32841c694
> commit: c3b9dcd01973935375ca9d0c67044bea7333d4ef [6/11] x86/cpu: Allow feature bit names from /proc/cpuinfo in clearcpuid=
> config: i386-tinyconfig (https://download.01.org/0day-ci/archive/20220329/202203292206.ICsY2RKX-lkp@intel.com/config)
> compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0
> reproduce (this is a W=1 build):
>         # https://github.com/ammarfaizi2/linux-block/commit/c3b9dcd01973935375ca9d0c67044bea7333d4ef
>         git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
>         git fetch --no-tags ammarfaizi2-block bp/bp/rc0+
>         git checkout c3b9dcd01973935375ca9d0c67044bea7333d4ef
>         # save the config file to linux build tree
>         mkdir build_dir
>         make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/kernel/cpu/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>

Thanks for reporting, fixed:

---
From: Borislav Petkov <bp@suse.de>
Date: Thu, 27 Jan 2022 12:56:21 +0100
Subject: [PATCH] x86/cpu: Allow feature bit names from /proc/cpuinfo in
 clearcpuid=

Having to give the X86_FEATURE array indices in order to disable a
feature bit for testing is not really user-friendly. So accept the
feature bit names too.

Some feature bits don't have names so there the array indices are still
accepted, of course.

Clearing CPUID flags is not something which should be done in production
so taint the kernel too.

An exemplary cmdline would then be something like:

  clearcpuid=de,440,smca,succory,bmi1,3dnow

("succory" is wrong on purpose). And it says:

  [   ... ] Clearing CPUID bits: de 13:24 smca (unknown: succory) bmi1 3dnow

  [ Fix CONFIG_X86_FEATURE_NAMES=n build error as reported by the 0day
    robot: https://lore.kernel.org/r/202203292206.ICsY2RKX-lkp@intel.com ]

Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20220127115626.14179-2-bp@alien8.de
---
 .../admin-guide/kernel-parameters.txt         | 11 +++-
 arch/x86/include/asm/cpufeature.h             |  7 +-
 arch/x86/kernel/cpu/common.c                  | 64 +++++++++++++++----
 3 files changed, 65 insertions(+), 17 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b7ccaa2ea867..bdad3dfd6a37 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -631,12 +631,17 @@
 			Defaults to zero when built as a module and to
 			10 seconds when built into the kernel.
 
-	clearcpuid=BITNUM[,BITNUM...] [X86]
+	clearcpuid=X[,X...] [X86]
 			Disable CPUID feature X for the kernel. See
 			arch/x86/include/asm/cpufeatures.h for the valid bit
-			numbers. Note the Linux specific bits are not necessarily
-			stable over kernel options, but the vendor specific
+			numbers X. Note the Linux-specific bits are not necessarily
+			stable over kernel options, but the vendor-specific
 			ones should be.
+			X can also be a string as appearing in the flags: line
+			in /proc/cpuinfo which does not have the above
+			instability issue. However, not all features have names
+			in /proc/cpuinfo.
+			Note that using this option will taint your kernel.
 			Also note that user programs calling CPUID directly
 			or using the feature without checking anything
 			will still see it. This just prevents it from
diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index 1261842d006c..66d3e3b1d24d 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -34,14 +34,17 @@ enum cpuid_leafs
 	CPUID_8000_001F_EAX,
 };
 
+#define X86_CAP_FMT_NUM "%d:%d"
+#define x86_cap_flag_num(flag) ((flag) >> 5), ((flag) & 31)
+
 #ifdef CONFIG_X86_FEATURE_NAMES
 extern const char * const x86_cap_flags[NCAPINTS*32];
 extern const char * const x86_power_flags[32];
 #define X86_CAP_FMT "%s"
 #define x86_cap_flag(flag) x86_cap_flags[flag]
 #else
-#define X86_CAP_FMT "%d:%d"
-#define x86_cap_flag(flag) ((flag) >> 5), ((flag) & 31)
+#define X86_CAP_FMT X86_CAP_FMT_NUM
+#define x86_cap_flag x86_cap_flag_num
 #endif
 
 /*
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index ed4417500700..69c7ea84b005 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1368,8 +1368,8 @@ static void detect_nopl(void)
 static void __init cpu_parse_early_param(void)
 {
 	char arg[128];
-	char *argptr = arg;
-	int arglen, res, bit;
+	char *argptr = arg, *opt;
+	int arglen, taint = 0;
 
 #ifdef CONFIG_X86_32
 	if (cmdline_find_option_bool(boot_command_line, "no387"))
@@ -1397,21 +1397,61 @@ static void __init cpu_parse_early_param(void)
 		return;
 
 	pr_info("Clearing CPUID bits:");
-	do {
-		res = get_option(&argptr, &bit);
-		if (res == 0 || res == 3)
-			break;
 
-		/* If the argument was too long, the last bit may be cut off */
-		if (res == 1 && arglen >= sizeof(arg))
-			break;
+	while (argptr) {
+		bool found __maybe_unused = false;
+		unsigned int bit;
+
+		opt = strsep(&argptr, ",");
+
+		/*
+		 * Handle naked numbers first for feature flags which don't
+		 * have names.
+		 */
+		if (!kstrtouint(opt, 10, &bit)) {
+			if (bit < NCAPINTS * 32) {
+
+#ifdef CONFIG_X86_FEATURE_NAMES
+				/* empty-string, i.e., ""-defined feature flags */
+				if (!x86_cap_flags[bit])
+					pr_cont(" " X86_CAP_FMT_NUM, x86_cap_flag_num(bit));
+				else
+#endif
+					pr_cont(" " X86_CAP_FMT, x86_cap_flag(bit));
+
+				setup_clear_cpu_cap(bit);
+				taint++;
+			}
+			/*
+			 * The assumption is that there are no feature names with only
+			 * numbers in the name thus go to the next argument.
+			 */
+			continue;
+		}
+
+#ifdef CONFIG_X86_FEATURE_NAMES
+		for (bit = 0; bit < 32 * NCAPINTS; bit++) {
+			if (!x86_cap_flag(bit))
+				continue;
 
-		if (bit >= 0 && bit < NCAPINTS * 32) {
-			pr_cont(" " X86_CAP_FMT, x86_cap_flag(bit));
+			if (strcmp(x86_cap_flag(bit), opt))
+				continue;
+
+			pr_cont(" %s", opt);
 			setup_clear_cpu_cap(bit);
+			taint++;
+			found = true;
+			break;
 		}
-	} while (res == 2);
+
+		if (!found)
+			pr_cont(" (unknown: %s)", opt);
+#endif
+	}
 	pr_cont("\n");
+
+	if (taint)
+		add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
 }
 
 /*
-- 
2.35.1

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
