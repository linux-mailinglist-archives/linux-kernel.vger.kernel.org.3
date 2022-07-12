Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC01571B0C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 15:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbiGLNWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 09:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiGLNW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 09:22:29 -0400
Received: from sonic301-21.consmr.mail.gq1.yahoo.com (sonic301-21.consmr.mail.gq1.yahoo.com [98.137.64.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BAA41D22
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 06:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netscape.net; s=a2048; t=1657632148; bh=xJ9Sz+y9USDgbyuOjTjsV8ceUXxOwGkS0zUBwjj6SsA=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=LWhmvy+Zc8nU+HFfil/PAT6rBbwGh5tiTFG9m6zxb4Qwi42br+xJ9gDl80Ue+4FJTrJEbsJJoNrlNKDPAENMIJpXVBErt0sQQtSUuOhMCk4c/gc8iH9F/AS5x3AYdMJtQKhDaIsS2ikZ9y50UjERFMGZgj7eOR7Nuxp1SpnFlsLiw8+mkErRuc5cYwK7iiaZ94T53an6dQb0HCS/xI4JGpj6CL4tqFKMx1MH/VSJz6Ff5Djy8m0lNONJbLhHWYX0/yd7bxUxLKACntKQIJfnQgYLMAkZTgu+fxsd1aHsVHDOGQynO0465Rg2tSkX/lQZmOhJwP1uF4cQpt8VoY+wCg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1657632148; bh=nyuhStRwJvNRCLIVsXYVTfe3U6CzGzAAY+XfayCyvK0=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=R5vyqjTR/YlCaaJzHfA5HVtqHRHhSuBJKuoNdy7wsGPMSlrxQocfFIa1tbYlqMwyZkwFFfH8CzR1YMZn4psKgs/l4ai71o8D7Mo7kt4c+Z5WI/l80C3cC+9dh93k2Ri3vCUyKZm26DcJcTJxbcH7xfXcEfe2CbZm9SrtX/i0A7HmAefGbMFYeMC2un2Aj3BC7CvKxnU97fF6Y55KI4ahmxxNA/nYPPaqyWXdqUOpfBbWg9Laj1nf+ppdt6owumSxwMiao6RinFM2rvl6ev2ABZj/TqJvxzZlRvWQrDipwOhyJ+nktnBnkL1hqIFOz2/95Sy88I/xnQKVlvGq8XLzaw==
X-YMail-OSG: A9CSTc8VM1la8yPPD6h918B78emmpPO3796POtupixScIxrK8Jg1kT.1JwjHQIq
 mf9c5mDUph3UkBHfYQJjal9NOkVqXozoIRVzyw7g1_EE739ZQN9UbmKn4jGVbW0g0BshZX6W8nex
 i6wH5SUUY8AM2J7Rk4DScsfepXyidvRmqGLHzQemXdDvLHagSLIkgO7V_HHlGSWyeVHYLUUTIcL8
 M2pfEuXpsQxDf4a0_jn1O3a_XJcaQ1g8pJk2wRydZWDwiyf29TMK7twax32y1BpH6vnSBcjfXwHC
 L72pl2G5Nm.f6Nf8wbNNJLNSh5BYkat9T9X.a3po3d02N3RKWpg9aMNkqP63FMVKXZ77ZSZ8RCyC
 bf_stfpr6ub5jPdV5LV65TCptl1cr9__kJ.cHCURCfTmUrTcI0ZMuAA9P879HRNJAI1L8lBVg7ye
 Y.v9nh9_5wy52BRPEL62sUCXpU0h9tG7uCSy7XGNpP3KXEbw1b.fCsQPL8_YhNbWhk7yYkLOfYJ.
 ZQCt493i_WwsO9LAgujug9xojEy0Vd5YK2hV0d3hTwphWt9Kn7cWrBPB_wqTzlSIS0VuNQV5SHm6
 tcKZQnFTeRQ5WQ6MfVRf008uPg4ulzaWp3oqZEjNqK8GoQ7YpAoPzs6GLhtbiSOBiIHRjqnZtTZk
 iEj4sIQeNERCdMn2XTnFVc1bPs0_SerYYRn7qrryTUVLw0oZRgOruij2ZVxrINjsApCUeoRHA2M7
 OwHUUWGsgl_Z8LKIWAu2JhSo9vNZdCN1eF9sjTQEtook7pTgsdEaaULjhfRjOykADCLWAA1HkzUG
 ii5DXnXgqn4B4RW_jJlQejGg8lm34OMiRAEfxq95YOJA7XCtfm7bLaR1OpkAm3QCFUvNGNRYn1ib
 PxKErqn_vWr.w7k3C5U_tv5G4kKAda_Rz7fsDV1WZnYq.l4ZcYmAROrPv_f6T4vDw_f.7LseY2vO
 mTMrm7idkLj3ZMHYWshLBfpr2gE5w26qaTf8Wpdf13sh2CKC6EQEo.M7q2HDnFaV7flHdlGVpbaX
 2CxREPKjq425Crqx25IYCOZviCBcsNv9eFRy0Ozf908FbOyP9g7bNAjSZYwWrfJABKpgXR4.coTs
 ixuyun9ImbQqA.RbhJGr.lKmyTahc3etbfPOHw6hrmhbuXnvh0GNfh.tvFvfcVmg8F9t02JLULeJ
 TtL9cjDQngPj6aQUv3.u4RL.zpts9zKVPNz1qxvO7ZNypZ3_X9Brnm4kdiChoT.cYSyz4Q22tpeT
 45STrU0_Z_xYRMFVPlCM21EpLhxwBxWLFWMpG7ZqFRZ9HKNlRWq2bWVI9dssq8DvGf4X6wUuKPAy
 _WbUaLv1PVuodRpHtbnkR7ZWHcvBpOlm5APPbq5V_ZA8oBifgAI.Aiw4o8Lb10s3rAfzg_5Sr_0P
 ozmfzOX8Xui1L.bNEjTkbsMpl4W3A4jdrlxalaBubdVIQFaHQPr9D2UIwP70PVXetah982UBuvdP
 mjZaO0NCx1ym2LrO6guHOZdSR7KmYpJyokL63YPBS069B.cbrugmmncDF728SddgFg8meiLFnQLb
 8S4TiEjfdVD6CP2.nY8V63uRpWt4A8NFHFd4T169Tu_yMQmiwX_ieny9WX4EHUNqBU9_sTqxTWwc
 5DJedIQiM_TlAQgW__42T4naUe7njtLNd.NsytgvmpTXHPENtcrzekEsNms0TL5IhX7HIfIKDwPS
 uR85l2q7HhGvxamSJXzaJ5LemWIahqtsTESshNXOg981OtTZwDD4n9KdofZ2gs6svtyNzT9Blzvq
 4GLenke97D003tDZFVC9pctYSO3f7zx.TuFQdMDUasmOIp_oKgSh2E2oiO5fC.ODMhNkNqepZA.9
 p60qEL_fN.02r3WurZLVmf8gETF1gFhDWiTlHdcdv5r6Txp0reuvUmffiUwRfo8TUpiaNZVrf87U
 mM7.zgjoIecaIWaW0zQqYbx4v1isFWPFq1xmB1iu2dIYqnxmjPUOWSeveeF9hKom25OHLqfykKAz
 iLvpYFkGBTT8dYs_aLv9yolJC.Mg2bpjuAZH10V9JEMAzEi2jL4OgqEAQsd7WvkhwLlO.fUVidLN
 l8HEdkyKMbWyEpRBLc9DuuD2yMsp0foCXuySjUg65gvYCM1C9fXUXy70HquI03RMIoAoiq5Bfsmt
 LiYjW7lYGYRrCuRFwZDulNQbHdvOQ.3gtR5YUboFBwCTxSXYGAy3bABlABpBwG4hKMLLEs1oYit.
 Y6FAfWvz_H..6zQ--
X-Sonic-MF: <brchuckz@aim.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.gq1.yahoo.com with HTTP; Tue, 12 Jul 2022 13:22:28 +0000
Received: by hermes--production-ne1-7864dcfd54-hcklt (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 0acdc84b3b441651254eb93653e367b2;
          Tue, 12 Jul 2022 13:22:23 +0000 (UTC)
Message-ID: <8011dff1-6551-898f-7e37-38ede106e2f4@netscape.net>
Date:   Tue, 12 Jul 2022 09:22:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] x86/PAT: have pat_enabled() properly reflect state when
 running on e.g. Xen
Content-Language: en-US
To:     Jan Beulich <jbeulich@suse.com>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        Juergen Gross <jgross@suse.com>, Borislav Petkov <bp@alien8.de>
References: <9385fa60-fa5d-f559-a137-6608408f88b0@suse.com>
 <YsRTAGI2PhfZ5V7M@zn.tnic> <016d281b-7e40-f1bd-66ee-c19c3cc56efe@suse.com>
 <YsRjX/U1XN8rq+8u@zn.tnic>
 <4e099e2d-e429-252b-ceeb-678066d85e61@netscape.net>
 <aa8f99dc-e622-398e-1a68-6b060497e4b3@suse.com>
 <d49e87a0-417d-194d-daa1-952f707f096c@netscape.net>
 <6afa42fd-469d-5b08-1688-5af8a3c9d8fa@suse.com>
From:   Chuck Zmudzinski <brchuckz@netscape.net>
In-Reply-To: <6afa42fd-469d-5b08-1688-5af8a3c9d8fa@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.20407 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol
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

On 7/12/2022 2:04 AM, Jan Beulich wrote:
> On 11.07.2022 19:41, Chuck Zmudzinski wrote:
> > Moreover... (please move to the bottom of the code snippet
> > for more information about my tests in the Xen PV environment...)
> > 
> > void init_cache_modes(void)
> > {
> >     u64 pat = 0;
> > 
> >     if (pat_cm_initialized)
> >         return;
> > 
> >     if (boot_cpu_has(X86_FEATURE_PAT)) {
> >         /*
> >          * CPU supports PAT. Set PAT table to be consistent with
> >          * PAT MSR. This case supports "nopat" boot option, and
> >          * virtual machine environments which support PAT without
> >          * MTRRs. In specific, Xen has unique setup to PAT MSR.
> >          *
> >          * If PAT MSR returns 0, it is considered invalid and emulates
> >          * as No PAT.
> >          */
> >         rdmsrl(MSR_IA32_CR_PAT, pat);
> >     }
> > 
> >     if (!pat) {
> >         /*
> >          * No PAT. Emulate the PAT table that corresponds to the two
> >          * cache bits, PWT (Write Through) and PCD (Cache Disable).
> >          * This setup is also the same as the BIOS default setup.
> >          *
> >          * PTE encoding:
> >          *
> >          *       PCD
> >          *       |PWT  PAT
> >          *       ||    slot
> >          *       00    0    WB : _PAGE_CACHE_MODE_WB
> >          *       01    1    WT : _PAGE_CACHE_MODE_WT
> >          *       10    2    UC-: _PAGE_CACHE_MODE_UC_MINUS
> >          *       11    3    UC : _PAGE_CACHE_MODE_UC
> >          *
> >          * NOTE: When WC or WP is used, it is redirected to UC- per
> >          * the default setup in __cachemode2pte_tbl[].
> >          */
> >         pat = PAT(0, WB) | PAT(1, WT) | PAT(2, UC_MINUS) | PAT(3, UC) |
> >               PAT(4, WB) | PAT(5, WT) | PAT(6, UC_MINUS) | PAT(7, UC);
> >     }
> > 
> >     else if (!pat_bp_enabled) {
> >         /*
> >          * In some environments, specifically Xen PV, PAT
> >          * initialization is skipped because MTRRs are
> >          * disabled even though PAT is available. In such
> >          * environments, set PAT to initialized and enabled to
> >          * correctly indicate to callers of pat_enabled() that
> >          * PAT is available and prevent PAT from being disabled.
> >          */
> >         pat_bp_enabled = true;
> >         pr_info("x86/PAT: PAT enabled by init_cache_modes\n");
> >     }
> > 
> >     __init_cache_modes(pat);
> > }
> > 
> > This function, patched with the extra 'else if' block, fixes the
> > regression on my Xen worksatation, and the pr_info message
> > "x86/PAT: PAT enabled by init_cache_modes" appears in the logs
> > when running this patched kernel in my Xen Dom0. This means
> > that in the Xen PV environment on my Xen Dom0 workstation,
> > rdmsrl(MSR_IA32_CR_PAT, pat) successfully tested for the presence
> > of PAT on the virtual CPU that Xen exposed to the Linux kernel on my
> > Xen Dom0 workstation. At least that is what I think my tests prove.
> > 
> > So why is this not a valid way to test for the existence of
> > PAT in the Xen PV environment? Are the existing comments
> > in init_cache_modes() about supporting both the case when
> > the "nopat" boot option is set and the specific case of Xen and
> > MTRR disabled wrong? My testing confirms those comments are
> > correct.
>
> At the very least this ignores the possible "nopat" an admin may
> have passed to the kernel.

I realize that. The patch I proposed here only fixes the regression. It
would be easy to also modify the patch to also observe the 'nopat"
setting. I think your patch had a force_pat_disable local variable that
is set if pat is disabled by the administrator with "nopat." With that
variable available, modifying the patch so in init_cache_modes we have:

     if (!pat || force_pat_disable) {
         /*
          * No PAT. Emulate the PAT table that corresponds to the two

Instead of:

     if (!pat) {
         /*
          * No PAT. Emulate the PAT table that corresponds to the two

would cause the kernel to respect the "nopat" setting by the administrator
in the Xen PV Dom0 environment.

I agree this needs to be fixed up, because currently the code is very
confusing and the current variable names and function names do not
always accurately describe what they actually do in the code. That is
why I am working on a patch to do some re-factoring, which only consists
of function and variable name changes and comment changes to fix
the places where the comments in the code are misleading or incomplete.

I think perhaps the most misnamed variable here is the  local
variable pat_disabled in memtypes.c and the most misnamed function is the
pat_disable function in memtypes.c. They should be named pat_init_disabled
and pat_init_disable, respectively, because they do not really disable
PAT in
the code but only prevent execution of the pat_init function. That
leaves open
the possibility for PAT to be enabled by init_cache_modes, which actually
occurs in the current code in the Xen PV Dom0 environment, but the current
code neglects to set pat_bp_enabled to true in that case. So we need a patch
to fix that in order to fix the regression.

Chuck
