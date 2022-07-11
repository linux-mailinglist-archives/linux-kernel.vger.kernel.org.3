Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B89C570540
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 16:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiGKOSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 10:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiGKOSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 10:18:20 -0400
Received: from sonic306-20.consmr.mail.gq1.yahoo.com (sonic306-20.consmr.mail.gq1.yahoo.com [98.137.68.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD06A62485
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 07:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netscape.net; s=a2048; t=1657549096; bh=R/XMnj1qIU9tgCHkr7IC0xOtwixzIp8+uQb/ugngDu4=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=OMwACxHT0Brt4IwXkS2dQ8yifnA9WdjEkO44sGRfNkXY+E+Rf04exnhE9EsWQd6Ox/wyLPW3916HQIP1ej5LUNmFoqE9EfmVRjYV2dAOgb81wPWeAkBmzOxArC+2LoZdSKCCyxrazEflZESRH+5jM4UM5sH1IJpPm9Mps3wMaEqtNAV0sK2J9x1+iiloBShMyS6DDOV6zA0jkUi6Xf2/XcvIjyXz1j9iP6o6u9KeWL09cLsSNP4GDvJvjM8t/jBMN5nYWWYqKsxb19uiknusJgffFwntdXdh8BfNkzUGd6G0rOUIdwryfgaohH3TIXF7wX5w23zuZ63k7c5d3blWVQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1657549096; bh=ZdXLxkl/Eo6HEtCnr/qRivqI9jPbOdRlWFPqnEqhM+4=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=Tn2PQwU/alVRwy+mqt8F0wefvrQ3Hmy9m7bOiylRRahz9nNIdPpPsANTYl3V/mFoHpG5lNMoEAPyrRlefbjRWGXCjt/jQYG9OHy/DtowN/dL8QtXKpD3DGhblrSDUcRi9dwSRG+e6G0yKZGPH1XvrSP2XRM1ytXTNhXIBjTd+hos3h8pOWOKkxP/oyYKZkjzImjJk9DlUsAAwnzWjaKGBXmw+kVIW2fLAfWyI8NvPGC6+147YDVSSWgdCqCdAFD2mR++kiFFTSsP6klx1JwQTjg3rUX85NcBkkgZnEtnoYaj2A5AAjIkHs1mkYUY7O1Uyjf5oKilTlnSYUdRT34dQg==
X-YMail-OSG: 8V.DSTEVM1mrc4lotEROYeiaCxEjKspywy8V9Kld6BBifq53SFVi7nBgOAc0xnJ
 jB2Q6XgvUJxY1Ft5S0fc.7qXuepA6sozMwzEn1SZeGT_pqvy1uICE.b7PbBt.UpUf2P7386Ky5Rn
 Csae4Ub8odZl3EuNzB9lzFsZfZVOKVIajWMw0QnKtqEyzZcuC.OqmDxNxeGmnUFZoH4nHKFwYf7P
 wA9jWZMbaPWpSx0niM2diIzV0nN3bgKmj.VthVCeyNai9qbOHo8i1WCsLAjJ46im9qN2Nn6riol3
 S3nUDB13GbhWCCizO7htDWUz4gU8duJQInBun.j4_MvNdcz.txVKVj0egSDpm6jgueGXd2T_kT.B
 E3pekACI5Ifpy9wmYVB48j7vGwPMhnYX0YTMT8LE_KNHdyx4UippxXOt6Z3j4OTQzXTJsihe9P9b
 zQcORHpUYSonBBsFSYDO8qrNzICyFFXfuR3XHfMatly7pVXs5uHEshZ0_FzNCYTRN8liCq72ieeD
 c0B8mxrOc4OpK.5e9rKzqUXAmsjB3mBa5BpXgAbMxY3kJuxPMEEgu9yGqFKUEQgQoE4mA7TwWJs7
 s5GcX8x3zdYD_id_D74CppAWc.ZfAEnIho2ULkjVrGkUUfoSHKeuZwI54MUpbiBnJrOH6.rwb01V
 40jaxzN0E.FG9LIqQA0Kem0QvqCcxKXR36T7TFAmQt8W.fxpGdROfAgkzNSOKjh6FsSl7YtvzaG_
 sakTHfLIg9CKJehfZajePzJl6BqslFmjYkpRFsQL1XdS9adTfA7dRqchSw5m87A_fcjRdKrazt4B
 RgOsADWZ8LIAQhwjTS_iHQdu_wg1F6nhZnzGgvWEFLPWxkSIhIq2HYyevDDDob3H1OPxeWDZzkga
 i9vVxw.pI8pUZmfNDDqiOv0P0998DZZsAoR0Az85ntu4VJUSaRfK873sFgiHPENKXgGS5rRpdTw3
 8Rm_1FUWv.IX4znaO5NbcNIsHlXOghrniWaS.guPu0LX7R8Z7bK7D3YZrglSZcn6oWZKwsON3Qlm
 0hJLrlsgE.xPP2x6IxJv5qxYaInzZTeIfb4bFdl6.mmeAWPV5ZjGmP2l12EBUso2XrzrUBQdRFb5
 n2iVeYKKhnbUS6g68yhRljBh9sXthC0hk4W_3qZlVFkrjdNDEcerlpZhU0o.FR0u6LbHJ8oVm7jT
 ZaCC1t4lcuPXP._xoGwYb.A_MtpY8vIjYZQQoIuSxtbjE.X_022DTjIWreGPhdJFX58P5izmQiF3
 LQyq0ozBhv3RsdddChTY3DnVsJkiCpkxPQ5asWEVCCyGljfcrUyDREugRrE6jBkXn_e7LxSdU_yo
 6TIPr0IObbKVAFBmL9fSgVZOlUfSU4P_5cooJ1EMKgVXmsRdLOAL0PhC0mpci0sCjPG9N4IujYkH
 .gLbELb5Y_OUc1rSIzEx7I1Km65448ACNkydL6L37pDMe1SUJcBayn0n6R93IkiuUAC1_33InfOV
 JPIgHV3oOz07RCnUcu906v8UdEP5WUBt_xkRCZA94lLEmxo5LX0AYeZvaixh2xMBEIE1ars_V2Ie
 6Uh81AiHw_Ou7gKYongCMWEYAp8aBDK2qdypHRa06_u08ALCAtjgP4ZWB_3bn9BhvWqymqdwf2h4
 OR4Bxlb9tS0fb.RRZ.tc.dd5Vcl9a5xe10B6932xh5WGeF_DFaiUV1iCKkjxL8MbCH4YBMbzI_uq
 k39XP4olWl5p4GgKyRWLtWZrVx39UbdaiF5_K_c_OkM1gqhfzIoJO6wOvUZDIGk4CjpS7MKDjxtI
 Asv9XnlX8F8M6yCuT.IQSS84V8UlSx.nHQuoC39gPB5.WgjOp7zL7UXbzI3y2Ic2M.dw_x89kDi7
 sxyvMgyO4FyBz9jzqmCrA27OGCOKii55sFtHK32QAkFnjtKURRqOEzmlsBHcVArpZdoOnvDymPi1
 I7vmn2BlqrfgNLnyi7ZVQBGiC8kmfOtVsJOf.JPa7CupAWVCOWDyHPWvcixnNzP1DOxk0UAhrZSo
 4PHQt7LIm209G_bTxJXuKLAwvOmjazal4b_M.u935ITTjkMk4gIsJPvSSBABy_c5pJ3WrUXvW5pR
 xRcBipqsGnJUi8d99R5iNtRTMHOj_Zf3oBH8H4npttulelXOtp_SwGesRyjWVykutleOKEI5iUHn
 IWmif0M4Ze8OmjjI_X8gfAjD0mSwATatwOzXcyT05Z.uNjtHED_x2S761fSIiEmm2U.yvHUdl4cy
 LvpknkcsYhNa4WtndJ9wKUQ--
X-Sonic-MF: <brchuckz@aim.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.gq1.yahoo.com with HTTP; Mon, 11 Jul 2022 14:18:16 +0000
Received: by hermes--production-ne1-7864dcfd54-8q7fk (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 393f9d76813cf2fb95aa8646fdc67e8e;
          Mon, 11 Jul 2022 14:18:10 +0000 (UTC)
Message-ID: <4e099e2d-e429-252b-ceeb-678066d85e61@netscape.net>
Date:   Mon, 11 Jul 2022 10:18:08 -0400
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
Content-Transfer-Encoding: 7bit
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

Hello,

I have spent a fair amount of time this past weekend
investigating this regression and what might have caused
it and I also have done several tests on my Xen workstation
that exhibits the regression to verify my understanding
of the problem and also raise other problematic points.

I think, in addition to immediately fixing the regression by
fixing the now five-year-old commit that is the root cause
of the recently exposed regression, as discussed in my
earlier message which proposes a simple patch to fix that
five-year-old broken commit,

https://lore.kernel.org/lkml/63583497-152f-5880-4c8f-d47e2a81f5a6@netscape.net/

there needs to be a decision about how best to deal with
this very aptly described "one-off Xen thing" in the future.

One problem in x86/mm/pat/memtype.c is the fact that there
exist two functions, pat_init(), and init_cache_modes(), that
do more or less the same thing, so that when one of those
functions needs to be updated, the other also needs to
be updated. In the past, when changes to the pat_enable
and pat_disable functions and variables were made, all
too often, the change was only applied to pat_init() and not
to init_cache_modes() and the one-off Xen case was simply
not addressed and dealt with properly.

So I propose the following:

1) Identify those things that always need to be done in
either pat_init() or init_cache_modes() and try to combine
those things into a single function so that changes will
be applied for both cases. We sort of have that now with
__init_cache_modes(), but it is not really good enough to
prevent the regressions we sometimes get in Xen PV
domains such as the current regression we have with
Xen Dom0 and certain particular Intel graphics devices.

2) If it is not possible to do what is proposed in 1), at least
re-factor the code to make it very clear that whenever
either pat_init() needs to be adjusted or init_cache_modes()
needs to be adjusted, care must be taken to ensure that
all cases are properly dealt with, including the
one-off Xen case of enabling PAT with MTRR disabled,
Currently, AIUI, all one really needs to know is that
init_cached_modes() handles two special cases:
First, when PAT is disabled for any reason, including when
the "nopat" boot option is set, and second, the one-off
Xen case of MTRR being disabled but PAT being enabled.

I am trying to do number 2 with a patch series I am
working on. It is up to the experts to decide if it
is possible or even desirable to improve the code so
that any changes to the caching configuration are more
likely to be properly implemented for all supported platforms
by successfully combining the two functions pat_init() and
init_cache_modes() into a single function. The new function
would probably need to be renamed and include bits from
mtrr_bp_enabled, etc. for it to function properly.

If anyone wants to argue that it is not desirable to try
combine pat_init() and init_cache_modes() into a single
function, I think the burden of proof rests on that
person to demonstrate why it is good and clean
coding practice to continue to have them separate
and independent from each other in the code when
they both essentially do the same thing in the end, which
is call __init_cache_modes() and determine the PAT
state, and also probably the MTRR state.

Best Regards,

Chuck
