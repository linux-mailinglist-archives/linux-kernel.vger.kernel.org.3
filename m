Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18827597986
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 00:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238732AbiHQWNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 18:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235858AbiHQWNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 18:13:20 -0400
Received: from sonic316-55.consmr.mail.gq1.yahoo.com (sonic316-55.consmr.mail.gq1.yahoo.com [98.137.69.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154CC2DA
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 15:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netscape.net; s=a2048; t=1660774389; bh=Ya3ixTHK6s4uo7ZSMA4MXCZMMPXyKlfwDOMQpejuekQ=; h=Date:Subject:From:To:Cc:References:In-Reply-To:From:Subject:Reply-To; b=tkfuTuNchfeVQ023lJaRH1hm/J5pCN3KQiWfXzotdltYVXf12If0zTavRhbw3meiGnieDJKMC8hFZQrKBS06R4d6e047i6bfZQHEkhBOlBMIWUPIUso9Pg6dkttCkO9J+9yxxtSKGuHw1sERRfceMNHTzHcDpNR1ifYLyL3bhD9ojXU+F0912z9t+o09t80JC1YNVBuf5yt6W4V3Nd5uwSedb0TJUNepNvfj/vV7NVqvMazCpWqEj2xLlFHqYRqaBIEK7l+bxwULSRtiBk48pvvFWwnyVuKKMKSV/701vCATx7dKdwqOavxaRbZ5lOYhd2Hz3ALBus9yfwDPh0ENTQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1660774389; bh=OG+giEXQA/ebWGbk2Hy3i/H1aRj65/6Ai/kzb+21EPS=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=My+hPwuWcFMV2euyRvdETZMSAf7RpPZI0RGv0lr8xGA59nqCua50k+VNJIxICWiadLmC3/T09pAkOBgBK8nNyIMvI7uKuzGqxCEB0iUdo/y4pd2uJcQ+J+k3UNP8ojzaYkt9UXBVn6/8KjefYml4g5VnNjbaAeAqwwbLLr9DWjjF3QPRa4V6iHTw/iRbxyR1Imp7WXUY91bFllRu2v6mXfQsdjVNWKn5INFSB5pLcOPsa0QTlQwnimD7PTmDcc/Xs1EmX3fuy8LGPt8yO1q64hTUn+hf7u4QQ57oRYrVYJ5vARVh9rCg5WvLVR1q9hVclbIIomADV1AEiNvThFt0cQ==
X-YMail-OSG: z6P62F4VM1mcBmqHekAHTfeE4IvJIl5u4zlTEVO6q0FmkAmXk3pRMuldpAcEfKt
 8GPSrzwrDzDhf5NR30UBDr21I4tppCFvhJvF9hHX8AlwI_SHogSJ4XyR6mMsYa2tn.siiTJ026po
 Vt61Ho2sQxyP8rk.rJsNVCto0f_f5kcIKJsu.ecy1JdjuChgHlxW14awP9MDDEfvJnApuqZdvOcg
 KfPlfmIYc0jefd8qcZPRsckUGULTa08YKIA7y.rgIkI0i55bQk4CZBmPIzUleGbKGJUA5125ff.Z
 TTOb7seHAW8RD08huySaYmS6SSygEwBgBGqT_GF7qHcoommN1M2r8UN_hUiM8KaalBsaxQwIKXpp
 KmxeAe8CSH7o.KcX58koU6rXxvPpLZ6dRVwf4Ko1aAluwxZsn4eNJ3hy2o7y.hAg7Okf1vWbffAu
 FMfAWHLCZMs3gZgBeqM4FMxAR_CoNlZQpt3yrs8QH7IgYaoJMSbFxKfX_TLOnqRv5CO.SYgspTe7
 emk97jfNdPN5xDj0VP_Ng0MDM0xnnBUda9Ix8824XNvJuxFBjilVJTQRBcmz6Teu870glpBC3p8r
 5n9Hf.aI6op5yvI3ogLnfiLeN08niK.dX30Xaq1PWKLWzCdQtrBudDGs3pxQO4qIaX.lnpUHQ.qu
 NYq6XOlI.bUqAueb.46ObeYKYIOpm5PYPm4g0jWmEauqwmxMK6yiV7BzNf6tZuMpn0VsaFzBvmsr
 kR6qsrstguGiu.jaFpCJxyozCUSxhGARNztGYLKyCtpnM_CZ7hkxM02Wtf54cIPHXxoFHBhxLeXN
 .FDPstgwPz6bOHJ46pB6AsGLub4_kRcY_ncJQSd5TXVOXoBLLB7poCTCy5VwqPmJ8WbydEYIFnAj
 hhDqqEoT9HirB50NC1vjkVDEkfP93EXASW2W1GtZniWDfzPJtiPk_QAfihIcYrp1mW7Ny8cwbsip
 ywVEUl3Dl2pqSonSYeb3xpBd9qv6IP7ow.qrfRvwpQ3.g_j3LFzapwKwZH_KVJ0d78w04jPfKKFk
 p5LTOjN3Jguj9PoKALkpk7CmR_wXMNHgsZDzKG111Rs264_QGyZPD5a8xxiKcTx9rKch67yBVzdE
 ywJW1rbpL5YDpBIbIX2M2nBGuiiYHBBbAxaCJMbdJy0f2F32GqO3mpu3qB3eEP4qtBcUv0stzIAC
 R5Co2Ci.xRWJxXFkaPm5HvM1au7eRT0raYb1pNHNhFw0Xs5pYaBh9_e7ASZQfswj3H7PrMZUBK4h
 apb4lZ89qHBdqRXZa606GfkbBcrRD1EJJjMxzGc68IALAKynEVsbpOKt19sC.lsC_8Zr7J75S0kt
 F7LocKrFjVtCLHfmAWW3XwQgxOtwS4.08IRveKk0uywG_OPTxmh.KM6JCf59xN3jM032PBr546wE
 hpatRb2hKcHFotdu6QLSqmMbuIBSokHml.2.LSrwp5hCoZ86mlHWoiuzqUGwNcdB2SIEOOIUltPz
 aXDJIJLY4wouWWaCs5CDwkZeUiIyIEzJSxtSneCSHwBA5rX8ZGLeKu_IgXRcXiRylhljSH11LLnf
 rS7Wot.EornloPLUbmmBorf_Yk.7tDUQ5xTweMmB3jAAio1NF8yZEi7my48NWns2CFP8duonIsJs
 PojuDq5iuuvAWCsO1z908C7cKjUplRLPMffjE.D.uCT8rkkPxjCjNrW7ZqUvGA0ghtCpc8ZoMrz0
 8nHd97lZMcwgKrLQmVNjnDrFenVkpIGUvTkfDAjgtwnDJZwdEF_.J5uF4oJEESIh7YTmXEAdNNaC
 LDMgv2jobQnKuqzToBC0ObLPNDzVfZ2o9xweNzUlGI6B4iRiHyz0LAyNEBbiT_CDMu.vpfuLd8GC
 1aJF6BqZKRQWW9Q..YKjaJRLQdbkBgmVaUVwY1aXIW0gLWv3dYUbNPwnnxIFs0WuacnIqraQCDVa
 gvNaQBmjMwLXKhgHoA6BQO5bAlk29UCEaR3KDydDGe9Ik5pxKrj83rF.5wRZh_gQOVpQxCAWZZbR
 OJ4VTx7ZUCMzcHZ7EmHTdCBFbq7U6SBtcs4cPeqmGWs12DLxNikxLJgswXHocP2s5DnJv5rSLSNR
 viAhfjUz0e.aWcG_YRKD3E2qlbyStd2ZW6Q1BAmHKFQcHVrCtMeKwrndIqKaeoBGBxrWXIRePZR3
 pSWT.PbBMayaUoXD9bzk_DPH2L.vmyGtUtkYujtP43OIExerooRZ5VUeYSiVGBgugVJQxyjsTyFK
 WVgrwCvYxYqHAWEEurDneCQPxOsn4
X-Sonic-MF: <brchuckz@aim.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.gq1.yahoo.com with HTTP; Wed, 17 Aug 2022 22:13:09 +0000
Received: by hermes--production-ne1-6649c47445-kh29z (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 1df4e63e39d2d83da836396c40c3d921;
          Wed, 17 Aug 2022 22:13:05 +0000 (UTC)
Message-ID: <16cb5f73-ac85-5094-3cd1-ec91cb47fb99@netscape.net>
Date:   Wed, 17 Aug 2022 18:13:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] perf scripts python: Let script to be python2 compliant
From:   Chuck Zmudzinski <brchuckz@netscape.net>
To:     Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Alan Bartlett <ajb@elrepo.org>, Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-perf-users@vger.kernel.org, ElRepo <contact@elrepo.org>,
        Akemi Yagi <toracat@elrepo.org>, Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20220725104220.1106663-1-leo.yan@linaro.org>
 <Yt68AZA2VV9d02xZ@kernel.org>
 <CA+_WhHyZZC=3gtzetEAQQrjtGujHmY5azwtQNZEc90gyOAwUDg@mail.gmail.com>
 <CAP-5=fWiNdnEawdj_3ExCrcwRSnRxeV8=8RhA6pwbw_bJdPJFg@mail.gmail.com>
 <YuBDw/+7McESS05X@kernel.org>
 <CAP-5=fV4+KeGcyyODTNjS01dw1iTXpFyaLXwZ8nBkek+NHL37w@mail.gmail.com>
 <11781d7e-d9de-f889-ff57-9d26d92ada44@netscape.net>
Content-Language: en-US
In-Reply-To: <11781d7e-d9de-f889-ff57-9d26d92ada44@netscape.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20531 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/17/2022 3:52 PM, Chuck Zmudzinski wrote:
> On 7/26/22 4:43 PM, Ian Rogers wrote:
> > On Tue, Jul 26, 2022 at 12:43 PM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > Em Tue, Jul 26, 2022 at 10:52:31AM -0700, Ian Rogers escreveu:
> > > > On Tue, Jul 26, 2022 at 9:57 AM Alan Bartlett <ajb@elrepo.org> wrote:
> > > > >
> > > > > On Mon, 25 Jul 2022 at 16:51, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > > > >
> > > > > > Em Mon, Jul 25, 2022 at 06:42:20PM +0800, Leo Yan escreveu:
> > > > > > > The mainline kernel can be used for relative old distros, e.g. RHEL 7.
> > > > > > > The distro doesn't upgrade from python2 to python3, this causes the
> > > > > > > building error that the python script is not python2 compliant.
> > > > > > >
> > > > > > > To fix the building failure, this patch changes from the python f-string
> > > > > > > format to traditional string format.
> > > > > >
> > > > > > Thanks, applied.
> > > > > >
> > > > > > - Arnaldo
> > > > >
> > > > > Leo / Arnaldo,
> > > > >
> > > > > Applying the patch on top of -5.19-rc8 fixes the problem that we (the
> > > > > ELRepo Project) experienced when attempting to build on RHEL7.
> > > > >
> > > > > So --
> > > > >
> > > > > Tested-by: Alan Bartlett <ajb@elrepo.org>
> > > > >
> > > > > Hopefully you will get it to Linus in time for -5.19 GA.
> > >
> > > > So I'm somewhat concerned about perf supporting unsupported
> > > > distributions and this holding the code base back. RHEL7 was launched
> > > > 8 years ago (June 10, 2014) and full support ended 3 years ago (August
> > > > 6, 2019) [1]. Currently RHEL7 is in "Maintenance Support or
> > > > Maintenance Support 2" phase which is defined to mean [2]:
> > > >
> > > > ```
> > > > During the Maintenance Support Phase for Red Hat Enterprise Linux
> > > > Version 8 & 9, and Maintenance Support 2 Phase for Red Hat Enterprise
> > > > Linux version 7, Red Hat defined Critical and Important impact
> > > > Security Advisories (RHSAs) and selected (at Red Hat discretion)
> > > > Urgent Priority Bug Fix Advisories (RHBAs) may be released as they
> > > > become available. Other errata advisories may be delivered as
> > > > appropriate.
> > > >
> > > > New functionality and new hardware enablement are not planned for
> > > > availability in the Maintenance Support (RHEL 8 & 9) Phase and
> > > > Maintenance Support 2 (RHEL 7) Phase.
> > > > ```
> > > >
> > > > >From this definition, why would RHEL7 pick up a new perf tool? I don't
> > > > think they would and as such we don't need to worry about supporting
> > > > it. RHEL8 defaults to python 3 and full support ends for it next year.
> > > > Let's set the bar at RHEL8 and not worry about RHEL7 breakages like
> > > > this in future. I think the bar for caring should be "will the distro
> > > > pick up our code", if we don't do this then we're signing up to not
> > > > allowing tools to update for 10 years! If someone is building a kernel
> > > > and perf tool on RHEL7 then they should be signing up to also deal
> > > > with tool chain issues, which in this case can mean installing
> > > > python3.
> > >
> > > In this specific supporting things that people report using, like was
> > > done in this case, isn't such a big problem.
> >
> > So there are linters will fire for this code and say it is not
> > pythonic. It is only a linter warning vs asking to support an 8 year
> > old out of support distribution. There are other cases, such as
> > improving the C code structure, where we've failed to land changes
> > because of build errors on old distributions. This could indicate perf
> > code is wrong or the distribution is wrong. I'm saying that if we
> > believe in the perf code being correct and the distribution is out of
> > support, then we should keep the perf code as-is and the issue is one
> > for user of the out-of-support distribution.
> >
> > > Someone reported a problem in a system they used, the author of the code
> > > in question posted a patch allowing perf to be used in such old systems,
> > > doesn't get in the way of newer systems, small patch, merged, life goes
> > > on.
>
> Considering the proposed patch, can you be sure that replacing the
> f-string format with the legacy format won't cause a regression for
> some python3 user somewhere when this hits the real world? Even
> if it does not cause a regression today, as new versions and features
> are added to python3, can you be sure none of those new features
> will depend on the upgrade from the legacy format to the f-string
> format here to work properly? So many regressions happen because
> the people who write patches cannot possibly foresee how their
> patch is going to affect the millions of Linux users out there, but still
> they are certain it will not cause a regression somewhere. So how
> can the chances that this patch will cause a regression be minimized?
>
> It seems to me for this to be suitable for the Linux kernel, the
> default should be to use the modern python3 format and only
> enable python2 compatibility via a sysctl setting and/or kernel boot
> option for those who are still using python2. There should be no
> change to the behavior of the kernel for users who have upgraded
> to python3. But I don't see any such consideration for python3
> users in this patch.

Sorry, I didn't see this is a script, LOL! So obviously a sysctl or boot option
does not apply. But can't the script implement this simple logic:

If python version = 3 use f-string format
if python version = 2 use traditional string format

Best regards,

Chuck
