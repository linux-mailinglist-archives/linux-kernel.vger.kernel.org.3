Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC55597ADD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 03:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242508AbiHRBMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 21:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242500AbiHRBMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 21:12:34 -0400
Received: from sonic304-25.consmr.mail.gq1.yahoo.com (sonic304-25.consmr.mail.gq1.yahoo.com [98.137.68.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1C491D05
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 18:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netscape.net; s=a2048; t=1660785152; bh=ZPSBhv+BnUzQui1sj0KSyre9cw3BlEcE00TKx62Iiyc=; h=Date:From:Subject:To:Cc:References:In-Reply-To:From:Subject:Reply-To; b=kSckY4DLDPsH4hgqo82qguxPZyaUIGIuqZNWLToR/CcH78AcZm60i7RIeV2x31r2zq0Ea3VcbbH7yGsx5Pb/bA1AnFMTJLmAjsnbowoiVy+76DRc7YMY81N/a2uQbr3AxDxKm0KYwcao1zWPuTcpeDWTLVNbl6Kx4y7x0fE1mPc01S98YBmr40KqrmYSKlEre25ik+OSUKFnxA1sMDeg/RBjxscQ1mBakBjC/dThSt/1yXd6hhbH1wtuioQNL0Qex1+3HesBwcEP/rGC2di8biKvnOU+AE09rBG/6KcxfXWMR3ND8nyDimQg+i8gJ6mnUSB2DtZZ3oXVQaz1B6/FHw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1660785152; bh=admdHDUpxj5NaiIMdcMo0kjU1Onetw/KXQG1ptgbH4o=; h=X-Sonic-MF:Date:From:Subject:To:From:Subject; b=FnbGIA34JBg8XTdquv2ZX3nfW61JycQSkOm+bSKk9P5XS35Gef2Voe4/ptGxauT8qUb5MH5pwF/gk6lC15ZRKt+QfAvJBuT2E00er3jlkxRjrfVoeUwHtPchg0lxMsL5pu+ZzQWNV7VjzKnodrpH2slfxawLvb600woA/vWkzy7J6L5+8+V2EnrmuCex/pLXoCjco33fp8b3pmqvWKxTaoboy5T6swfFu0H3QPWVkhRy+xBgDJq2pug2cX44FpDZlSHtlassTT03S10Xz7M93QhSBmVd6jnjfVHCCzMH6BtAzl1mC6P2NqlyUEjhWr4nDrjI+akEpxdLNgIzOT+T+g==
X-YMail-OSG: EEmkZlEVM1lWtvjVqxnMLi1LD5rMMNribr2QvgyFICAQL9sNJEMqzJzPIx7jqAR
 uouUEStHzxMTQ4HKs93.ZPIaKdhjSV2UtHoIwhbtnsj9.XKMa0ZM4BxlV.6Vc5ueauBo9YT7PAna
 YP0Lq4573EfgIrZ08s99Ks9ccRyk8sHwNV.9XHfpQ_kpELcyPx8wljHE9u0a_pPXFEpq0iz7v9RN
 bnI3OW.b4OiDjubLx5gWeyp26RU2TBwM.ABzsRUtZ1iCsMNgZDwEwReHfUJN6vvmN.RIksrqgm3v
 inEFUn._bKtj9yIo2bpJZGLxDEYCNuzn1g5wmeEgGvOx0p7unwArrpoksf_fBUia7ToG5oHcZ2Aq
 TSzM.pSGV6ujf4GczM1w1Y9wz.zLS7uqcUEBxfxGA158.GaBG9cMfpQxrAN7Nievy3QYUDxAbud8
 mmnECuSLtgqXLizSAfBYJCuhNSRIo6w6cLjL.36TulK1dLPcMJ9wxVLkomQ.68RIZHnGyiyjKVcA
 GZ9K4FcTA.6QMmzi23LPKw.hcdXVUXHd.YZ3DlcK__liSGl_iiVy6vBwUu2k34Tmu0CbiMTKSsTB
 PqyUKwWXZoyzQVtZH7yhOVRlnAERnn.anf4fzqb0L8ABisttyucj849eQVN0CN3.uw9ppWMdScgu
 54mMpnoCgF.KX.ZJUPkhmxNIvmBwkoRyffPtSBHshwpMlmenvvkOo72EMTGPaYHP7tHreXG6mmpi
 ArSBPmR0kKdhGCg6R9_O.8EqHRNISeuTujQOz70uqZhrRlyzGoCuzK.0_tOrN5XhIF1H0f9_pVVg
 s8qZ_XGNB1C2mwlY0DlJD6pTylPWQAUAahF2xyJ9fBSoy.Iqk81950kgoJDQHE27gyvmCdLgzit4
 c7Br4jSxYN7awbjyHwJRmepkjZdP6kFmjmUsqFC.5vcezwJQ5pDoVuG3nTBjC9_TxmSepSzBCqP5
 22aiyyl6ME5.WjNmSp87hYAYYPo3302.TLLOnN4TEmdkkzCFZdh8EgmEei0MbpsxS_.yLycXJWtp
 LDlgALv06NEzoBvB8nPIa9xoFhw8dU7.Ar.lxNPEK8kGjV.QNYp56MTnX5S.g1zndMmTjWhB1whD
 mLdi02wOsBr3GD.ryJHqXC2EJGWolFoxqu8n9q1E5JBrysvWCTqd_a3Mw6ySQHRcE34APZF5J82e
 7aWvAmAESu_SEbtwR_1_jc9jitM1WgXnd9ZtXFqLEYuITiuPflbTxZqdhn70SsuxS4nwyxpllir4
 hNsW2sXOfyvCd2ezDo1_Qo41IN.Oy19XfKeuepATI0K8YdOQxP_T4Xi64ct_4wRlgJ.GsNDGKwSE
 dGFk1EdaAlB9nIcZZwXVpHWBStsh2I7DgKLbM6XBW8lLmMQ0hcI_8vWJCeZwn1n0abPWcuBoyPk7
 iTrW3ie9UvCL4DUDknKJaocgDkSqqTWPgsMyUR5GkRp2Qj6d_xJ0rYiIdZ17ZsC.A2ImDpjYv.8P
 QRd7P2FkW35KpoPmUVI3hwfZDAXAORjjfHtuOtTgMtHo5CCK05Q8ViX55.9RVRuMjDKat7L3JRxF
 ixnLDXxJDYKk7Ndx186BKC7rMAk3Z8W0Vsvc46uHf2k8L06ScyyH4NVANsagl4BYJsTuFC0eue.q
 2hCwJFhbCR.oBhW.9.WNbEyvJrhszcKx482FHrOrs60Ij4PKk_FSp1vC5Up7sUie7djRZPatjMXX
 9iq1Tj7ID6rhTena9ZluMCFSnYBrlNPQxDaRexCSksgruleHX.9TIUTkCmDPR9DvdQHlViXJX7u8
 9YAJAMJ72QxzwxQwGMxK17oOXZmIQf6GYbPttEdkbMJSodV1woQdr.lBfAReMrIkGbirRVUsz74L
 vltuIkMFml5qLER6G_veG5vL4iYIsBbCPnO3Fu9FronL1lRGZw5INmwocT6bGrksPHOSXqXVL4Nf
 QVAZUnD6k4qaRdRajkMlRxMsd._CTZ2WzB0Q8gv5_4s7dwL2uhg2naAYJsruO_5AqF7Meq51Uahp
 vb6VH9il_KLycqCZcYlaOyvMk1kyk2NPuFNJQm5A0Gtmrix80pkEzPjOQu.oNIQWIZpQbUSmir6P
 BWXCTWX346vALsnWFlKKyZRXoVs5RdVhsOqqSi1gUj9vl9z0HIoVP4fgUkpGzqt6m3ZMzqzzE0Wl
 ceEqO.vuRd5oDBGackPG80txqIgin4mLcBhcP3zoqZiOobT4scIDJ8LKnXV.J9kuuHhL_Dn9NtYg
 dAcN8Jx7di3y3iU1lUbN1
X-Sonic-MF: <brchuckz@aim.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.gq1.yahoo.com with HTTP; Thu, 18 Aug 2022 01:12:32 +0000
Received: by hermes--production-ne1-6649c47445-tz6bb (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c51a6b35f6c872b1b78e2e9f4a32680b;
          Thu, 18 Aug 2022 01:12:28 +0000 (UTC)
Message-ID: <806d152f-358b-572a-64f2-798fe7783f93@netscape.net>
Date:   Wed, 17 Aug 2022 21:12:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
From:   Chuck Zmudzinski <brchuckz@netscape.net>
Subject: Re: [PATCH] perf scripts python: Let script to be python2 compliant
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alan Bartlett <ajb@elrepo.org>, Leo Yan <leo.yan@linaro.org>,
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
 <16cb5f73-ac85-5094-3cd1-ec91cb47fb99@netscape.net>
 <CAP-5=fXjBBbU3EHD5iY6VMKMo3wj+dJteeqBf5B9m464HtdF3Q@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAP-5=fXjBBbU3EHD5iY6VMKMo3wj+dJteeqBf5B9m464HtdF3Q@mail.gmail.com>
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

On 8/17/22 6:36 PM, Ian Rogers wrote:
> On Wed, Aug 17, 2022 at 3:13 PM Chuck Zmudzinski <brchuckz@netscape.net> wrote:
> >
> > On 8/17/2022 3:52 PM, Chuck Zmudzinski wrote:
> > > On 7/26/22 4:43 PM, Ian Rogers wrote:
> > > > On Tue, Jul 26, 2022 at 12:43 PM Arnaldo Carvalho de Melo
> > > > <acme@kernel.org> wrote:
> > > > >
> > > > > Em Tue, Jul 26, 2022 at 10:52:31AM -0700, Ian Rogers escreveu:
> > > > > > On Tue, Jul 26, 2022 at 9:57 AM Alan Bartlett <ajb@elrepo.org> wrote:
> > > > > > >
> > > > > > > On Mon, 25 Jul 2022 at 16:51, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > > > > > >
> > > > > > > > Em Mon, Jul 25, 2022 at 06:42:20PM +0800, Leo Yan escreveu:
> > > > > > > > > The mainline kernel can be used for relative old distros, e.g. RHEL 7.
> > > > > > > > > The distro doesn't upgrade from python2 to python3, this causes the
> > > > > > > > > building error that the python script is not python2 compliant.
> > > > > > > > >
> > > > > > > > > To fix the building failure, this patch changes from the python f-string
> > > > > > > > > format to traditional string format.
> > > > > > > >
> > > > > > > > Thanks, applied.
> > > > > > > >
> > > > > > > > - Arnaldo
> > > > > > >
> > > > > > > Leo / Arnaldo,
> > > > > > >
> > > > > > > Applying the patch on top of -5.19-rc8 fixes the problem that we (the
> > > > > > > ELRepo Project) experienced when attempting to build on RHEL7.
> > > > > > >
> > > > > > > So --
> > > > > > >
> > > > > > > Tested-by: Alan Bartlett <ajb@elrepo.org>
> > > > > > >
> > > > > > > Hopefully you will get it to Linus in time for -5.19 GA.
> > > > >
> > > > > > So I'm somewhat concerned about perf supporting unsupported
> > > > > > distributions and this holding the code base back. RHEL7 was launched
> > > > > > 8 years ago (June 10, 2014) and full support ended 3 years ago (August
> > > > > > 6, 2019) [1]. Currently RHEL7 is in "Maintenance Support or
> > > > > > Maintenance Support 2" phase which is defined to mean [2]:
> > > > > >
> > > > > > ```
> > > > > > During the Maintenance Support Phase for Red Hat Enterprise Linux
> > > > > > Version 8 & 9, and Maintenance Support 2 Phase for Red Hat Enterprise
> > > > > > Linux version 7, Red Hat defined Critical and Important impact
> > > > > > Security Advisories (RHSAs) and selected (at Red Hat discretion)
> > > > > > Urgent Priority Bug Fix Advisories (RHBAs) may be released as they
> > > > > > become available. Other errata advisories may be delivered as
> > > > > > appropriate.
> > > > > >
> > > > > > New functionality and new hardware enablement are not planned for
> > > > > > availability in the Maintenance Support (RHEL 8 & 9) Phase and
> > > > > > Maintenance Support 2 (RHEL 7) Phase.
> > > > > > ```
> > > > > >
> > > > > > >From this definition, why would RHEL7 pick up a new perf tool? I don't
> > > > > > think they would and as such we don't need to worry about supporting
> > > > > > it. RHEL8 defaults to python 3 and full support ends for it next year.
> > > > > > Let's set the bar at RHEL8 and not worry about RHEL7 breakages like
> > > > > > this in future. I think the bar for caring should be "will the distro
> > > > > > pick up our code", if we don't do this then we're signing up to not
> > > > > > allowing tools to update for 10 years! If someone is building a kernel
> > > > > > and perf tool on RHEL7 then they should be signing up to also deal
> > > > > > with tool chain issues, which in this case can mean installing
> > > > > > python3.
> > > > >
> > > > > In this specific supporting things that people report using, like was
> > > > > done in this case, isn't such a big problem.
> > > >
> > > > So there are linters will fire for this code and say it is not
> > > > pythonic. It is only a linter warning vs asking to support an 8 year
> > > > old out of support distribution. There are other cases, such as
> > > > improving the C code structure, where we've failed to land changes
> > > > because of build errors on old distributions. This could indicate perf
> > > > code is wrong or the distribution is wrong. I'm saying that if we
> > > > believe in the perf code being correct and the distribution is out of
> > > > support, then we should keep the perf code as-is and the issue is one
> > > > for user of the out-of-support distribution.
> > > >
> > > > > Someone reported a problem in a system they used, the author of the code
> > > > > in question posted a patch allowing perf to be used in such old systems,
> > > > > doesn't get in the way of newer systems, small patch, merged, life goes
> > > > > on.
> > >
> > > Considering the proposed patch, can you be sure that replacing the
> > > f-string format with the legacy format won't cause a regression for
> > > some python3 user somewhere when this hits the real world? Even
> > > if it does not cause a regression today, as new versions and features
> > > are added to python3, can you be sure none of those new features
> > > will depend on the upgrade from the legacy format to the f-string
> > > format here to work properly? So many regressions happen because
> > > the people who write patches cannot possibly foresee how their
> > > patch is going to affect the millions of Linux users out there, but still
> > > they are certain it will not cause a regression somewhere. So how
> > > can the chances that this patch will cause a regression be minimized?
> > >
> > > It seems to me for this to be suitable for the Linux kernel, the
> > > default should be to use the modern python3 format and only
> > > enable python2 compatibility via a sysctl setting and/or kernel boot
> > > option for those who are still using python2. There should be no
> > > change to the behavior of the kernel for users who have upgraded
> > > to python3. But I don't see any such consideration for python3
> > > users in this patch.
> >
> > Sorry, I didn't see this is a script, LOL! So obviously a sysctl or boot option
> > does not apply. But can't the script implement this simple logic:
> >
> > If python version = 3 use f-string format
> > if python version = 2 use traditional string format
>
> Doing this in the script would be noisy, having two scripts less than
> ideal. I'd suggest we wait two weeks, declare the official death of
> RHEL7 without "rpm -i python3" and then revert the python3 to python2
> patch. There are plenty of things to worry about and python2 shouldn't
> be one of them (it died over 2 years ago).

I see this has already been committed. I agree it should not
stay in the kernel tree for long. At some point in the future
it will most likely cause problems if it is not reverted.

Chuck

>
> Thanks,
> Ian
>
> > Best regards,
> >
> > Chuck

