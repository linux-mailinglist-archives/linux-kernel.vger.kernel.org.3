Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B765700F5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 13:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbiGKLns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 07:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbiGKLnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:43:04 -0400
Received: from sonic312-23.consmr.mail.gq1.yahoo.com (sonic312-23.consmr.mail.gq1.yahoo.com [98.137.69.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FCECE00
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 04:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netscape.net; s=a2048; t=1657539521; bh=w/ukMm5iwQWAeG3BAhYL3RaptUVhXqOYbZbqYfz4OBM=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=sigCv5NtbCmuRMFy8E9TL10fWV6Mh6L/vwwQTQzX/S4+tju4GRDtGa5QKcHjQ6efV82JsKcLjJqsKtIU/oOZv7nURu2iW7ehYTlG12JSSZCmCQwA8UD4oOxvEJK59LW9w3erLeZ3sxBOFgHkNyat4pNRCrsORwMafAMgG0TCBsYaAV8EM2sJTYbJfIpmsxu6bNOpWHjagHX4j1sySB8Rife2POZjuVAiLVVcONsdJfoxZXs93yNP5JaE73yyrf+XxlAUn/6/CQKi1mcqE+LcYtOlg34L8qsW0cA2WrsbG7T72q4d10Q7d+s4GX/fttnnzJv26l65jk2obmkuEPpaag==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1657539521; bh=mGozHT5h7zDYiUQg4KfZcbWrKhfFoSRR5f34X62/Xhn=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=kWCMBTqGUo34tUjsJTDbrjJxNVoKXiTyjOejeuiioasfOcRPe6QUoXITih8zqmrb2at9+lEg2TAQmtCGgARANfvA+h4R6gKmRCXmq2KA8hl8sRxTxPzPgGq1M73RVqMAAFN08gz1zXcNHXA1D9oBGgHi50mYjuDpwNjyglHjZ4OeCFcJiomxeb0I79TFOdfaqVHLi9gz0etLsk/ZO7VbDSH2D08O29kjz9H4cbP/NeP2m+fvBCm/zHIR4jyuV8QpQn1gE/6XPMIUiOYMxmmwNpbbQ3nSllqUYX4QcHKEQUiXoYu7ZmR1hyNXlHlEhO50OZS4JT1GZI7GpzB5EEgdKw==
X-YMail-OSG: Ynrj1a0VM1kbZ5mDA11QppCioN22lv89ZLTgz652Y2gBXOBdaO2Ji8sovCmqZbY
 6imIkVY.eDlrBXJAE_1uEP6r2gqGKo1tDMyhcdY4G6QAn99sg50AdupHfuIPmAMxaFtGhIeXoEvJ
 7AzWY58U527WHrLDwGeW5iL2orK.mj2s4Z4OvRpqgEUd458LWFoRRYmtd9fZDF5eOZCoI8khhy18
 ZPUXun.g.1cu8guQe13v9Au0.KfL88tskR8YQM4OLs3iV8cWi6_vz8ROAKre_D14Xq5JfGb6.OlZ
 FapNeA9h.Fy8stJa3i5lY9C5b7PXPKBPPIhbTfI9SgzMsEiucFl0gejFBRpkUJzu.queVDIemSFT
 aHbSbSZL5PDuiSu5mrgbHhAtTbxbjZV_FUMWY_nJjC0JU.p3EQxIlAQSEB4TnHcYDnpAiGWfZ3o8
 Aq2GtUq.x4qh0_qbj9iamuh2ZJp7J7W9Yl2PbHhtnaWE09vjhHJld47UPzFiPu6KsWIdWcOy17rN
 uspch7iGYEzRA_u1xZ8c39SZ03j3hSUV3hFeJvNPVd91cwvxNYq3QpYf7Klavfst4eZ3.yoJ71Xj
 VCNmM1eZ5InzpZpJcmBrT1PXa7cFV1p8wV8_Ud7HT.5sblvmwceogARlmik69EBSlhLmgJL0_ulv
 PyD44AgyM8Aus2mWIcddCiaBsBoanuvs7_t_VS4xtcc6bCITtvY.hdjB5Kdp6YVS8kvM_DUfrSYN
 k5jPuqRymFZSnuV0.wac5o8TxLBHLSX9jOntUB2O1QNy7ix4cHwVylcqWB7NOtQ8CwV8QM0dqYbb
 Fb3V50c7Z7HX3X1trBm4AX9vOuIDaOBk78KlDVwvqvrDvATLrUE70pOdH0mwVtvM66XLhph6orOY
 XEs.KlO7jI3oqIReZu8ir5t3o.ZhggtnPPl01U_3XVXK03gW6scacUra4kTWpXWqMsUWH7YMMT1U
 Cw2jIyvsdcNcPABDcz77rrCC8wZjqtDVDwjWYn5qKNEfY6uXG7Vp9B9DM5ppTeGr9wmFY86q0mP2
 D07IRDzL2e4ugzD8o6wsqQ03ur8YYA2FZiNeULlfPuNlAcQRh2iNtbTHUbiPFtKxQgf34K_UQkgp
 FyteWIYPN44G5N7_70Wci4n1P_RpA1mERVyQDHkuljrWo8rusonC8jQ3WiImXKa00MnVV0t4skS7
 Z4b_4O3tJTClfYtEos2FFKBBwPQklkK5UK7xbZiwclKuNKqAigj8i3EQeaiI.0ZY3hCFkK9lB8y7
 1pln1UVuL8M5iBGYWZAayOdW6uyc7nA.b8_VNPpIW2VBoWSTfgnvT91ttorEfjCUHWHnEGQhtvSj
 NDy4NJB0hAi1LGJW3MQ8OeoElrZVAe9KjOoLzfBem4_7.7MTQnybyzSLEJhE.Dv0MWn2alNF9hPq
 IBV.pOoO5nd3ogRJ04L2J_I6FuIBV.9T_t2CyG45VZS3H6QbkXCgnX2VLr5AjE.DpOtwqDh_JYLw
 eL15IHGVVM0zEA3f89.VIk3RcMIPCU.yIQfxIPykQjU1G1JplkNL7dkx4vG2bN63UJ0VfutodKZ9
 k_zIgLxkTr.ZKhzZ_qeYIYy.n6N_zrlYmVZgeKIt9JL74zgjR2hwNVtJxqNI47u4NNbNx6w3DvZj
 .OaWBZ7R74GZDy5PJKBVJnn6_0ndGjhxFgItWqVS2XZJ5dkgfB_0twyAB58i4VNgTeC03OKsMtBs
 2i0P5xK1ErezWMXO1EwaTsA6n6IIeLEvlVk8j8OeSqBM21iBluQkE1f.XEu4lz0ZkSKSQ17pwTrx
 hvR0HG84kt9k5e8FfUKOFv0lWuoG_ccW6aBxbTff.tgjHKOb4tlOhmMgSlfUtPry90dqMPs5GPWc
 XjXJZyX5WQKa4_VEKxDSsHKwkUS81E3XVJq7HdSbMN9omI2v_3huY2jpZv9Snh4P0915qCqmoYpT
 MWMF7m.PAwEELGpC1pOTVsCzQ3TWNs_.OvL0ijcglGE9wD0BFfHQ9uH_1F57RqbpDS6lfJMhund3
 2uZ2gFYCb5WQmw19wTRptXJeW9_2s0Ew7_thqFEe1hpgoqRjuSijXd9qvTUMkRS5c_FkRMUJN7ab
 cGxXBz_nQIj81552ETlipWpITEa5cDZqtvauaN7j0zZAIaUeKcbDmWRY7pkQGmvyPFjFYhzl62JC
 aCeB4zgV9wlA7J7juEFGmxDyXvmkOCOv19_y5O_JWlrDqUa.irJZG_A4trI2auXipXRVwts6zlj1
 VfcVfk6de4Q--
X-Sonic-MF: <brchuckz@aim.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.gq1.yahoo.com with HTTP; Mon, 11 Jul 2022 11:38:41 +0000
Received: by hermes--production-bf1-58957fb66f-dd4hs (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8f307d8659d7a819d3d711f175c166e1;
          Mon, 11 Jul 2022 11:38:37 +0000 (UTC)
Message-ID: <e818a621-dfeb-cde2-332c-ba1e4a632192@netscape.net>
Date:   Mon, 11 Jul 2022 07:38:35 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] x86/PAT: have pat_enabled() properly reflect state when
 running on e.g. Xen
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>, Jan Beulich <jbeulich@suse.com>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
References: <9385fa60-fa5d-f559-a137-6608408f88b0@suse.com>
 <YsRTAGI2PhfZ5V7M@zn.tnic> <016d281b-7e40-f1bd-66ee-c19c3cc56efe@suse.com>
 <YsRjX/U1XN8rq+8u@zn.tnic>
From:   Chuck Zmudzinski <brchuckz@netscape.net>
In-Reply-To: <YsRjX/U1XN8rq+8u@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.20381 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/5/22 12:14 PM, Borislav Petkov wrote:
> On Tue, Jul 05, 2022 at 05:56:36PM +0200, Jan Beulich wrote:
> > Re-using pat_disabled like you do in your suggestion below won't
> > work, because mtrr_bp_init() calls pat_disable() when MTRRs
> > appear to be disabled (from the kernel's view). The goal is to
> > honor "nopat" without honoring any other calls to pat_disable().

I think Jan is speaking of the narrow goal of the patch
that is causing the regression at hand:

Commit bdd8b6c98239cad3a976d6f197afc2c794d3cef8
("drm/i915: replace X86_FEATURE_PAT with pat_enabled()")


The author of that commit expressed the desire to
more readily handle the nopat option in Linux in an
architecture-independent way. in the commit message.
The patch was not intended to cause a functional
change, but it did - it caused a regression in Xen
Dom0s running certain Intel graphics devices.

>
> Actually, the current goal is to adjust Xen dom0 because:
>
> 1. it uses the PAT code
>
> 2. but then it does something special and hides the MTRRs
>
> which is not something real hardware does.
>
> So this one-off thing should be prominent, visible and not get in the
> way.

Actually, this is probably the most insightful comment in all
the words that have been written about this regression. This
is a one-off thing, peculiar to Xen PV, but it is not visible
enough and gets overlooked when changes are made. I guess
I agree it should not get in the way either, and it doesn't,
except when the lack of visibility of this one-off thing causes
the author of a patch to overlook it and cause unforeseen
problems for users of Xen on Linux. That is precisely what
happened five years ago with commit 99c13b8c8896d7bcb92753bf
("x86/mm/pat: Don't report PAT on CPUs that don't support it")

Have you looked at that patch? That is the one that introduced
the regression that causes pat_enabled() to return a false negative
on Xen Dom0 today, and it hid in the code for four and a half years
and was only exposed as a regression with commit
bdd8b6c98239cad3a9 last December, which again was written in
a way that caused the regression on Xen because this one-off
thing that Xen does was not visible enough to the author of the
recent patch from last December that exposed this problem as a
regression with Xen PV domains and certain Intel graphics adpapters.

That patch did not take into account this not-visible-enough Xen
case when MTRR is disabled but PAT is still supported by the
CPU in Xen PV domains. So the proper way to fix this regression
is by fixing that commit from five years ago. It is very simple.
After some code re-factoring and other changes, today that
commit can be fixed by something like:

--- a/arch/x86/mm/pat/memtype.c    2022-06-16 07:32:05.000000000 -0400
+++ b/arch/x86/mm/pat/memtype.c    2022-07-09 17:51:56.783050765 -0400
@@ -315,6 +315,20 @@
               PAT(4, WB) | PAT(5, WT) | PAT(6, UC_MINUS) | PAT(7, UC);
     }
 
+    else if (!pat_bp_enabled) {
+        /*
+         * In some environments, specifically Xen PV, PAT
+         * initialization is skipped because MTRRs are
+         * disabled even though PAT is available. In such
+         * environments, set PAT to enabled to correctly
+         * indicate to callers of pat_enabled() that CPU
+         * support for PAT is available.
+         */
+        pat_bp_enabled = true;
+        pr_info("x86/PAT: PAT enabled by init_cache_modes\n");
+    }
+
     __init_cache_modes(pat);
 }
 
Like Jan's approach, it implements the fix in init_cache_modes(),
but unlike Jan's approach, it only sets pat_bp_enabled and
pat_bp_initialized to true if boot_cpu_has(X86_FEATURE_PAT)
is true and rdmsrl(MSR_IA32_CR_PAT, pat) returns a valid
value. No need to check for a hypervisor, just check if
the CPU supports PAT here and that PAT MSR returns something
valid here. If both are true, then set pat_bp_enabled to true.
Regression solved.

And that leaves the bigger goal of dealing with this one-off
thing that Xen does in a more sane way for another day. I
am working on a patch series that attempts to start the process
by first re-factoring the currently confusing pat_disable functions
and variables that will hopefully make this one-off Xen thing
more visible and easier to understand so when someone wants
to play around with the current way of deciding whether or
not PAT is enabled on X86, no regression will occur on Xen
or in any other environment.

Best Regards,

Chuck
