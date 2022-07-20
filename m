Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED6457ABB8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 03:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240943AbiGTBOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 21:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240964AbiGTBOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 21:14:07 -0400
Received: from sonic316-55.consmr.mail.gq1.yahoo.com (sonic316-55.consmr.mail.gq1.yahoo.com [98.137.69.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A29675B0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 18:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netscape.net; s=a2048; t=1658279575; bh=iWifEwj9jXr+OJlYWHhKvQEskuKfIAM/4zntUXILFnY=; h=Date:From:Subject:To:Cc:References:In-Reply-To:From:Subject:Reply-To; b=exWkcLCPxO+hW4q4nym5lwdLYXXGPKihrdkNPqFWPQ0bJlQpL2z1Shc/S7+USYQz8x+IclfSyEU2gRSi2JDzq7hfz9ooYxGMX3+HjZsb7tmVp+hhQ7i3xv7JXQrPB1TqKKvvlsxzAZ3Lfsg35ntOJWeHgqGAoWDu5f1cCmu/5r1j58r+6alQ8qBh85Tc3wZZeFaKv1H5AEsqFBbQ8iwg3IV/W+c1sVYS2Dba7ZwAo9IhJ6jVmyJEXbj107v2q4L5BvdhIDjI72ZYUd35/nF0T+AUe+L3aOcx03AHzhBMlHlFink3K+ZFDq2me8t85yUYMKfq8a4dgbZ5LLnnjHT/YA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1658279575; bh=ltLZEA8eNzEprIbhzvJZSEYmOFXhbEoexjddTnHQJe0=; h=X-Sonic-MF:Date:From:Subject:To:From:Subject; b=o04QgON2jXIorVudFo+weZ1JqkUDUyf0LhDxLtasf+wfwbVi3bimjfGZdaQfRa/5CZ+edusKouC0GGdnMfP+2DCOdFuVH17BdN7rozKS7Xj0S23TuN8e+pLkNJFJjzIkCwkM784sh/nDzs0mm8zQOp94SZy4sGHkL/F7HvHA/KObD/I0YDn52L+cedlcoMH6UyIQGzKmtUwKDRmSlFS/pZh03jgWVlncN4KepPoupQD5WHGW1YZVhEpnYzwRmkOsC1CqbAwqMfdoGFOf6vZR09M3/aK4GX13robVyo8yJcXdaJjbtzIg2rTcnNC3GjUZ9S7EQbjMT4gInZGGFoltNg==
X-YMail-OSG: _YxVZCIVM1mdVS.6PZEvKwtUn9DEZEiI_daZt3JoDahEStm86JT2j22U.LY4Mu4
 4XXxbUOFQBSoI73wQ0WRjNTy3tN8GBI0NnEI80mK0SMpFLCN6JcTtuDCWQ.2IlrBfYiO0MeqRePh
 Eoz89uwJzVyVkhrTemBnLPx69lJu1sXoPebXkn4cNjk1935_ULAkty375.YUBtVP1bKclIu3.mXR
 BpVaOer9yweN.ayTZNccxid5wOs7EyqUsP4NA9DZu6kCFy9AvNNC6xNoFU8BfgnifrgS8IWrlXNZ
 HBz0VAVv.AtJHcmplK8QWjMj9VhB5ZmdxVGpI4AsfEAB8_fBmu07JCcqz.CyVPodNRJ8.LkrOSY7
 MkCWhM1t9j1CljJRdx40ggqbZ54EAZ0XFpuEDTidw3hnyixrilMY_QM59FEC6gCVvSB2MjFwmqAv
 M_AtSaxNLyX3VqFy_GyUavaG9fAijYPzYEa44EjHNSKWu3Bg5DtrNLoVBJ6bxg5BMSYgJf4okDfd
 vBojJnA42UVVa56BYMH9GtVfQpKOpBf.JCCLR7apCCkkqq6HrH5oQUh20ges5cPC9baGC853yQ1g
 IfFgVSRSYEgllHqtC6yyC.2Xf2sdYvCfls3DcEtkcbySvhLIKBHAn6GkSJFtgYqu_famxfI7mSEL
 sL4fC5Q2Ao5d2JKaNJTdYszCyI540GTaujpA8qTYmRoCplfU5Ff5u_dVDHUoKROZ8MueFiKDcO0E
 qn7TEUVo9NaOp_HYaQ7BreHgYKQsb6OSpUbzU3lhKhZ6x69LRQll7xkZWUANck3cMW5B72lOuqrB
 JRJGmdBn8T.8VOzJM6xvQKqVUK2HdSbLcr8vdTYGyU7xzP1vHOlINaW6DI5fYfl_glupCKDBNeIj
 ZTEL8pSR_uuTzN_Z8M8DC5TBGF0lgNtDjYi4ZQxlJj.j3yW23RVdchi67N7LXez9Vbq16kKgiAy8
 oOLcvtPiolij9UrvDVcdarHj93mrTCSAbzaV7PZbRm5hfa4yCkRzgHhCfrQRzKzwp.TTzb7CnTct
 yyHNrevjmlrImhXd47cHrv1LzaSu8GnqyIHOPBgdYg1lApUkUug7Ur7L.07BM9_hTwbu3UNWIAl5
 b8CFvBAdIVFtIRTDTxHreK2ldCj.Vy9emehQI3mY2scsMCCjfOXa6SSctkGJQ3rTRYPXuY198sq3
 eaoPmL7EcQzXnJHfO7nBkDMax4RyF8Ys_tv3mHz7ckZ4MXDOHwJYZAuAbrtRFMBFoNHLCS1FpI_c
 aHmkN8pjWLuy.gR.3rX_IBZZspifZayK9wla5l2NQozQQyo6HzkkysynXU5bdeA6atJrELPYnLvt
 LXV2W2fhnTj86b9zWVwrll..1UkKc6GGXYdAvLp9W20n9R_joWPK0P7.RWNaMZqS28yGX1nUJyKl
 NHKaGZKJi_8OnWmyVPTHlhAO67XJyJi4NLMvAYSUCNF4LMNSDtBUtoIGk7ncLYMPcJsJ_d6eDnKY
 We2TQja26tJLDoZJNVHhfr4oRS853WgkEFkeF7JMUvQSuem3xYrRUT4B_pKRPhXm1EhwIU0btxtj
 wA6FZMCo8_UHy5A9cfJbb9AdZNfweKL_liXHVmte_G0A1.llvkmSYi8X1U0uNFPscrNHLwSp3a3_
 et7rnJjR17uhd7DveJ.PkQYJRNqFG86tD9VnKUEa6syH3FRAIDxHqQWKYwXraOY_BWGzPfsgJiiF
 CWgdIxUAjGTdSLxnZfxlyK7I62xMFJ8TJ6L5TBiQT3Vz939813izWLknZrWHfHxjrMZVqyCpP9NI
 OrKPqlTwlxTbeQ1patAdbgSgiuCPSy4w8oL9vyjtx_QB11w6b55EzUJ.iYFYBcRKUQ_HIcN5Pvca
 29d1nhQ_1qdge_UMyTnbd4rPJzV7x6oRQmQfd2vF7Fg3cK3WK5bWOvzOvfBJi4R4nsDJI2vZ.hcT
 ETselLdMobEQZRd2GLJJYlq7aXgkkqqSsVffkv0vbymKzhFrFVFTsSD8I1mpoWKrUHYUOg9nQlMm
 2klFKDl0YxZuaHaA7LTkMZLovoBEELcsSuNreV9lRUXSwK789N4XdHBwBqXZ58kAtbN6nkbx2Z8N
 1XlFWaRFtI8zZvZn16mnDbRuQZjQNX4L5TIhdLkP_JSVHWeRZdsXphT2S0n8Zka8xB.YO39bAWUN
 Cm_1n1esOcoUCNwroUf3eGp91Nh3ayLsc3skJcxKsHppkhyNawAx3D7W7Yd3XNy8iKGB59RTldFr
 h0E4otvnGgXKBo_37ahHG5fA-
X-Sonic-MF: <brchuckz@aim.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.gq1.yahoo.com with HTTP; Wed, 20 Jul 2022 01:12:55 +0000
Received: by hermes--production-ne1-7864dcfd54-dxcrc (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID da1c1059c6f58b1197fb62eedc118138;
          Wed, 20 Jul 2022 01:12:51 +0000 (UTC)
Message-ID: <9487b1ef-bc7c-b9c5-929f-0953756e9bd5@netscape.net>
Date:   Tue, 19 Jul 2022 21:12:48 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From:   Chuck Zmudzinski <brchuckz@netscape.net>
Subject: Re: [PATCH 3/3] x86: decouple pat and mtrr handling
To:     Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     jbeulich@suse.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Borislav Petkov <bp@alien8.de>,
        Thorsten Leemhuis <regressions@leemhuis.info>
References: <20220715142549.25223-1-jgross@suse.com>
 <20220715142549.25223-4-jgross@suse.com>
Content-Language: en-US
In-Reply-To: <20220715142549.25223-4-jgross@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20407 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/15/22 10:25 AM, Juergen Gross wrote:
> Today PAT is usable only with MTRR being active, with some nasty tweaks
> to make PAT usable when running as Xen PV guest, which doesn't support
> MTRR.
>
> The reason for this coupling is, that both, PAT MSR changes and MTRR
> changes, require a similar sequence and so full PAT support was added
> using the already available MTRR handling.
>
> Xen PV PAT handling can work without MTRR, as it just needs to consume
> the PAT MSR setting done by the hypervisor without the ability and need
> to change it. This in turn has resulted in a convoluted initialization
> sequence and wrong decisions regarding cache mode availability due to
> misguiding PAT availability flags.
>
> Fix all of that by allowing to use PAT without MTRR and by adding an
> environment dependent PAT init function.
>
> Cc: <stable@vger.kernel.org> # 5.17
> Fixes: bdd8b6c98239 ("drm/i915: replace X86_FEATURE_PAT with pat_enabled()")
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
...
> diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
> index d5ef64ddd35e..3d4bc27ffebb 100644
> --- a/arch/x86/mm/pat/memtype.c
> +++ b/arch/x86/mm/pat/memtype.c
> ...
>  
> +void pat_init_noset(void)
> +{
> +	pat_bp_enabled = true;
> +	init_cache_modes();
> +}

This is what should fix the regression caused by commit
bdd8b6c98239 ("drm/i915: replace X86_FEATURE_PAT
with pat_enabled()"). Thanks for including this.

This function might need a better name. Does noset
refer to the fact that when we use this function, we do
not set or write to the PAT MSR? Maybe it should be
pat_init_noset_msr. Is Xen PV Dom0 the only case when
this function will be called or is it also for unprivileged
Xen PV domains? Then maybe it should be named
pat_init_xen_pv_dom0 or maybe just pat_init_xen_pv
if it is also used with unprivileged Xen PV domains. Or,
if you want to keep the name as pat_init_noset, maybe
it should be preceded by a comment clearly explaining
this function is currently only for the Xen PV and/or the Xen
PV Dom0 case when we don't write to the PAT MSR and we
still want to report PAT as enabled in those cases.

Chuck
