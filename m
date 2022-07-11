Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4340570203
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 14:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiGKM2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 08:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiGKM2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 08:28:31 -0400
Received: from sonic301-21.consmr.mail.gq1.yahoo.com (sonic301-21.consmr.mail.gq1.yahoo.com [98.137.64.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6AE29A
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 05:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netscape.net; s=a2048; t=1657542510; bh=bkyH/2yEtsetdxmue4dlbWNa1NmKY5t/YHv6BZ96HxY=; h=Date:From:Subject:To:Cc:References:In-Reply-To:From:Subject:Reply-To; b=GTLIiN5fXmFB1C1BaPAx0SFI9AP04mdVHbZU/k0HfrHd2y+3PAc+SKx1Gp3mQnrNxUA9AsqFxPhec17O7g+roP7EC2u8pgAXAdAxrnuA8ZPmf/6I3NCTud1nQfPmWk67LgIEihqZfX1w3Wq65fMzPYRXKmSbxrfvM6YcvAynHiV74UihnPWetqicQePfBeB7GEEvGCppeeB/itVk7rPeq1Ml5nzWvkWvSx4iyXNWDIRv9TILZVYWqTtRfZh1QR88vXPHCJTd3OGbfCsFMaDnH9sdAPTAWQnVPxw5jHnz/ZVVi/77Yw+ZNIvqNdonDwbufcaiB/4G6xc/a4PommFEbA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1657542510; bh=rKBwDKvOdcW0IXB0d2qgnDfP+2/IXQxx9Rz8JinpEDY=; h=X-Sonic-MF:Date:From:Subject:To:From:Subject; b=syjCYX+7xEuWmiENfAvcXceGPVibVZgEVJL+6ZHaqcik5TyXhXj658E7JPnjXb6yPj/wvJeAtgrqMaBaVCrKqCDlqBPbQCsxlPtBqX4PZaPevRi/WVg5ao3JsmvKVBF0h/l4mptWD4oezlz6TBt0G4qwOFvaKmG0XS+pcbgNJCGPY9P7Rl/XFziorASUN/RIBEv1auazfG9QX1C+p2zwyxEAf/vzbbIVVUMoxjkoL0tbN476un5MQD0eWgeFiT9V4pdXR2f0WvIlfNbkd4xN/7G7tnPnrJX4KbRwp6TEnejN4jcjQu30ZsMJ9jgbBCO5MFaxv+JPTMMZ+RQgbdLSRg==
X-YMail-OSG: ljkONEYVM1nH882XyMvvMTZEG7U2TFqZe4hNcHqpvO7Oh8iFE55axji95cREcTU
 lQlMiUHgAcIW7xsdWAtaR6ltBhH01VcjxnMjkcwKYs1SdSspV6DrgwRM6Le_6hnKYi5yxPmpJq8Z
 ESoFIqeMAvMLXc.Yg4PO8SKQImqEZUc6KWYh4xDlrYXu2x7bD2uX8ww4qnAkCW.sfPQUQyJpDtgW
 98jec3J3ntU5XroBufFy5Z29Lr6w9yyG1dETUL3zy1KVONJIbq_Bo3WRrD3l65ctLeI.K77hmxRj
 uvtIOOGlz6kJ.PvhrW6IzDBhK98Xu_J1lss6d7MfKiIr0MqUtI8Ga15cZ73P2ciAbMdJJP9RnBfC
 cROkIIMKr69kiXdGdI7eqgqo16i1ZmBlfICEh0V4PfpE16OC18U48aImTcdJGAnMY3LqBCjiN1Ob
 vO.69tLWqvGbNDDA57prB9yMmll7vJkCp7x_KoluF3JhRyLTCno9st9Ck77mjPdJqf9U0SQElSRZ
 3Fi5fR7QwSG5l7guvQZxNe_1nnme1ErWS90sWGP0ThBI7vG39FfRQbWc5G_D.0EdSMl4YY.8PSO2
 .CaJFEJyiOzRm9MNM22MF7sq1oqdi..kD_1AdOKB03sznOm31Vz2IMMLJ5HKVf8vii3B_ErkaZ3P
 ekNzZ4lcbOm9RNwONsuDa3BGxK0MRbO1hReG27CjlLRL2eFsm.vhM543BJKu8bqt1RAAW0UXgiVv
 d2YSOcxF3WY2.7rk7OyCJHcmLvLEkguFRTXGDHA2vAb_YBpt7ubsISmA_MXTNV4NmsKke8ZQwa28
 M2_jhYw2nHMiVhL4Fx.WtVJWL1gnwSvnYd6LKS_DMhOx1ZckfrFgnxvdtbF1U90Bs2zUYDoVJieg
 BCnVaNnvV3Ez6wbNc.42iYOa0nG5OrvI4rzwKEklhn_.ZJqNU6y6DnFxZYc7YuwcRgqTGCdo2bQX
 TCvIhJie4gYW0qtO6.gxWpmIh4s55kc5L0B5l0fdKCPWjBFJJDgZTMmvOoT2zmKU1ts7hd3GA4rA
 _Ncvo26UKhytD58kupg.e_EolU1JR.oAKTFk0zF7f6x26oOpjD422QwwM8OsMeOiadEFTjuOYM7W
 qhKq9YF1xeMcteKRVqy8ZaOFALRgSGTGCW2BLZpRo5R9j7VjAiyopChAB7Vrw.Orqp4mxgigeq0f
 jV18X17SRZzqJIyR.qQzJFqgLRAsAyVD.4h8n9EFbMTTjeTdkDq2_51vJL56k1ftWNpckMmFOaam
 kKmUm0zdFSFhvVEucaisF5VZDzX8vLI_AjWjOQqc0NgQX_5xU6mVHFYMCjG_08HBiMKT4wxgZ1qT
 p1pq4EGiyvB0aFFRcDgQ1V8XzXLPv1y4Yue.LEQhawncZzxcLlhqZSGiGzftF8IpZf4PUEWPAsqh
 GJHvZq_xtp3_HKSAnomni8vBusPicdbZ8.xf4xGJjOMydarh1yVTkfo_.wWq.hRhxoQWGAX3WjA6
 sbZ8tFXlubTyuKVMQHBQBYj.SjmEZQ8b2FcHplReORAfTApLuSM1ITg8bqs1hsNVDlk59_S_Kbtk
 yqo3DzTpweTkVYvYfrLMfT7liZLlsqZ_eOVpulMKKkZXC62fGF0mqcZUkldb9IhBxdQ9y7ls3kkK
 rikm8x9BbUnutghYZvj2kyJDKJD8iv9aiuDlxh03H9TKxO4mNxjh_DLrDu6nfNK8tfpYUGIzL8IA
 s4JTYaKI7TKw5Q4m2ZHSUFbA_VreILzyT4jht_D93f__OHxHSZvZEhjB.wOL5EsvLngxprhPMgyG
 VwltPAPc_qawIBdtD48ah5WjF3V7dmIR3L9SvOVHp2rmuuVXPRQNDFBupagPG_3i_6uypm4eUaFB
 nmUDLKm2F.AM1QLL5kc8US3VUmOobV.ZaZv7jrz7IRv2rl1Zl.SS9EpxoN6dz488eqYjb3vkQTXi
 8GgrryN24MpIgHJ.p8HWz1K5vqMEbOC3aPHgg42O_
X-Sonic-MF: <brchuckz@aim.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.gq1.yahoo.com with HTTP; Mon, 11 Jul 2022 12:28:30 +0000
Received: by hermes--production-bf1-58957fb66f-2wrgg (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID edfbbd6fa8ecbc3209f72e28e8d17388;
          Mon, 11 Jul 2022 12:28:25 +0000 (UTC)
Message-ID: <63583497-152f-5880-4c8f-d47e2a81f5a6@netscape.net>
Date:   Mon, 11 Jul 2022 08:28:23 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From:   Chuck Zmudzinski <brchuckz@netscape.net>
Subject: Re: [PATCH] x86/PAT: have pat_enabled() properly reflect state when
 running on e.g. Xen, with corrected patch
To:     Borislav Petkov <bp@alien8.de>, Jan Beulich <jbeulich@suse.com>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
References: <9385fa60-fa5d-f559-a137-6608408f88b0@suse.com>
 <YsRTAGI2PhfZ5V7M@zn.tnic> <016d281b-7e40-f1bd-66ee-c19c3cc56efe@suse.com>
 <YsRjX/U1XN8rq+8u@zn.tnic>
Content-Language: en-US
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
@@ -315,6 +315,19 @@
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
 
[N.B. I am re-sending this message because this patch in the
earlier message would be malformed because I deleted an inserted
line without editing the line in the patch that defines how
many new lines are inserted into the patched file. The change from
the proposed patch in the previous message is:

@@ -315,6 +315,20 @@ -> @@ -315,6 +315,19 @@

Sorry for the confusion.]

Like Jan's approach, this patch implements the fix in
init_cache_modes(), but unlike Jan's approach, it only sets
pat_bp_enabled and pat_bp_initialized to true if
boot_cpu_has(X86_FEATURE_PAT) is true and
rdmsrl(MSR_IA32_CR_PAT, pat) returns a valid
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
