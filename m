Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D70659771E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 21:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241598AbiHQTwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 15:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237162AbiHQTwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 15:52:41 -0400
Received: from sonic317-20.consmr.mail.gq1.yahoo.com (sonic317-20.consmr.mail.gq1.yahoo.com [98.137.66.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDF6A50D2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 12:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netscape.net; s=a2048; t=1660765959; bh=aNpaajDx4kX8zr86sAmhiT2IrTfZbWGWQAhfpprPp/I=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=AU6qFav/fhUhehef0h/O625y2c2NZ2TnjWjGHcH2MHH101w2B/0gYTr/umzxmtHfsVZEordOPSGtrT6NLQv47lvhouPxrU8H2NdvCZ6AYzOPvGMwKVYE8WrA4D3Pq5vpKX1CvsXV7tz20CVED8Bq+Ust7AErTJcu/5mtA5ESPePVq65AANnmR/kx4ubFwxzYxaJbSmQ3jlO3A6ZJPd4/l09uwSFhzrCAahYsw5OgfNDjDDYnMAWEEHYZGoiJq7eUiPpai95tpuKlrJrtLiN4hHbboEu/NGOG1pRy9sofhvYWR/DrXNIZii+MkObs8SYFaSsPOfTuMBpuOVNEqe6jfQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1660765959; bh=EslBBgODz1saw4EldiZPHBdTQwIiRE8K0jO6H1cCpKB=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=UvLMJu/3Iy9xiJFtWGBV0muyxNaK/7ShhGLzJU7KUZsndYh4qnh7vBzwgQpYYA8rxAgW+gb02mTGO0TDqA75db59EgKu1jXCKeMmc9s1a9oCQGt0rTbqB+45syKS/XPhYlJay9HGIoZJa4os5o3658StQ64Hxml/gpsLBkk1rBphLn13haGHv+9NpPdPplOUFaRzuwr3jgXrn6LrXGI+/TA8Na5GLI4FmvEUb6J3b3M31qDr0QMaJhjUgFZ374NWfsbeABigSMnHyzcrdwhMpd2KjYzz2m7X/F/oX6LdycoGuLNuQ3THDKBKA8g6SHx0p+bFd+E3qoEod/lzmS399A==
X-YMail-OSG: i2Z3B8AVM1lxyJCebRbfGq97V1iWfSeZUIBqh2dmAQ9leFJizajjzzZtPElifBf
 bcGMmJzoCg22TNusU1jQPUkmKozTFIRwMI4Rh1pX1PgOZr81Vul3fohRVRG4aa._3XDhrTy.m5y.
 I9sPZ5Jpo0dkUyobd5LCpIm1vSCa0wzKNkkSP7KPf7no0SGolwtwI72wLitcFiSshy6ot9HtjYqc
 nHRt7XHYqhpJtfg29p._PYoEEz.MsKvx_y7g9OIvAE_N38p.EsYkNYifxmMedSesDbfR3niy8TgV
 _GA.IIWslnXihNgR11HX4_sKOieYbo64mAJbJLBty5.3C9OJ422HHVT0c8wFYak5xMtyOYx9M59k
 PSD89fJSzGmshL7eUvhTB7rfsIIAEncxBs5ZvokSnSKoKtwSmXlTr61ZLteJpK8FiWFYXeaxroE4
 tDu6xc_hvKWW4TIviCIimdxI8G86_RNOnfrHecA6ayyfH.AOTZ2HTbMMdnN2WGhf5F4o9eqTCQ86
 UbXVppEduiKR0Jrz5dqIzViNhYHa0OF4s_O1_3r2P7vrsrbvHRV_15y4tmxzmHPUESvzkGejJ_KT
 140TBPKphlXPPOFzae1JSjdALHHCV44KzarFl7GSduvjwkjBWa__HsjZoCbdiYm5LGN21d.ASPLV
 uABSYrc_u.2HjsMg90b7Iam2ci5CicsWF6Ce5rdADEuXg_pKf1wBCORynHqqf.rHLxeb3NMJZ_u0
 3xdqKN1R_ixlyujdskYLw6RH14DIbKLixcGyfenBgjRnawoI5NDeJXNNkARjlWkNYFtRrNg1duCV
 Q5UvxSZ7HOLv9r4zLBbRVYflnaUgPqul5zUq.LUpw3ZjbdvlxFYgFC0gdPKuH6XV0IhZveQ3J0uC
 epZFnfHq4Bo8hPrVMajLH94u0z4okaWaJni5mO6B52cCBOZqkz3faskK3OXVGlFa6MrfYYtXAU2x
 VEJvvn2sZQshV5Cr2nVhORgYg4ixTa8ys_1Rh5K11I4.C_trU49Zc.czbMSljwSZZxkfxDXA4CEY
 tgJnH4hXhA3Vqt8XU4RgI1OJxMDYb7mdT79A2CTurKpHz9Gt_qsJVTQ6uzcRvVIRixsVKE1lwDge
 4jir8NxXFrrdsEemjYI8z0Mg1sELEKx1dYP1.AAiRJKJbnuENfwHadUt7dUZuWm_QUaEn15k668f
 8V58mPytTkDMA9Jllo.Ntqja_nXT7fw4US9YhDT0emaMsLh9eS4tz9dSmotzqpPAOBOnAX_JNk2g
 xlyCtJc7bIKgHuPFJmV_2rkJPJSZqJujA_zlF8uTguOe5C052Lbzi0SzmfO0DbesFxN0O8FqMz4H
 Rb5iq0zSuIGus.4zSC6Npo.8.xl61.1jojg3AZTlYwLokkWarLpPXj.N0j21gqahV_a17cy4vDSP
 pS2ZCYcYAtIvfjm0n96WPIa3yRqhLAvjrnX7SQDU3qnfZOhIp2wXhZGzKsLs.K0pSzY9r8a3ZTFE
 EQisb7nWFGBsMYHTMRkW.Kqq7n_XDgdppqAvw_P5I12aND3l5QP8on61do1o2HuGjyqmJp3AFlQk
 _Nttfft11159AjXnNRVYSOHUALKrWdZ3aaORHDk3LWSobuc9mZZoOjWcmxpAejd3mynjX3NOJYWI
 jetuhVcCjl6mSgKDDJOC0aww20MWIeP_n_RKLsh9bXpCzhAX4jS0_eZjnwxmzg9tiO6EBVQDvHGu
 OSZJdujwJ48YA45za5tj1OY062UsqfONfLX5VeJLmHmYw9_uqHG6ZM.5xc5nrfoH3zXk0cE_P6T2
 wcv6yUwbIVWEKNnCJZ49RiZuTfXsEWb.7FbA7EWxMiaO3R5bmBgVo3S8C9HiCi4fUoBzi.WyD6sI
 cLB0IJVQF6yRvEZJC1covL_zcMo3GVEx3c4MdIqW3SLndpLGIq3PDgGjl2Q1NjSvcKFaIfrdXelS
 MhK5afUDdqLNFHr3iH4Ux5iQokPv4ugEkiAsW8xSu4HizZlCnVsha
X-Sonic-MF: <brchuckz@aim.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.gq1.yahoo.com with HTTP; Wed, 17 Aug 2022 19:52:39 +0000
Received: by hermes--production-bf1-7586675c46-4c6gr (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 660c0aeddb8529668be74dc9b984d7fa;
          Wed, 17 Aug 2022 19:52:36 +0000 (UTC)
Message-ID: <11781d7e-d9de-f889-ff57-9d26d92ada44@netscape.net>
Date:   Wed, 17 Aug 2022 15:52:34 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] perf scripts python: Let script to be python2 compliant
Content-Language: en-US
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
From:   Chuck Zmudzinski <brchuckz@netscape.net>
In-Reply-To: <CAP-5=fV4+KeGcyyODTNjS01dw1iTXpFyaLXwZ8nBkek+NHL37w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20560 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol
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

On 7/26/22 4:43 PM, Ian Rogers wrote:
> On Tue, Jul 26, 2022 at 12:43 PM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Em Tue, Jul 26, 2022 at 10:52:31AM -0700, Ian Rogers escreveu:
> > > On Tue, Jul 26, 2022 at 9:57 AM Alan Bartlett <ajb@elrepo.org> wrote:
> > > >
> > > > On Mon, 25 Jul 2022 at 16:51, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > > >
> > > > > Em Mon, Jul 25, 2022 at 06:42:20PM +0800, Leo Yan escreveu:
> > > > > > The mainline kernel can be used for relative old distros, e.g. RHEL 7.
> > > > > > The distro doesn't upgrade from python2 to python3, this causes the
> > > > > > building error that the python script is not python2 compliant.
> > > > > >
> > > > > > To fix the building failure, this patch changes from the python f-string
> > > > > > format to traditional string format.
> > > > >
> > > > > Thanks, applied.
> > > > >
> > > > > - Arnaldo
> > > >
> > > > Leo / Arnaldo,
> > > >
> > > > Applying the patch on top of -5.19-rc8 fixes the problem that we (the
> > > > ELRepo Project) experienced when attempting to build on RHEL7.
> > > >
> > > > So --
> > > >
> > > > Tested-by: Alan Bartlett <ajb@elrepo.org>
> > > >
> > > > Hopefully you will get it to Linus in time for -5.19 GA.
> >
> > > So I'm somewhat concerned about perf supporting unsupported
> > > distributions and this holding the code base back. RHEL7 was launched
> > > 8 years ago (June 10, 2014) and full support ended 3 years ago (August
> > > 6, 2019) [1]. Currently RHEL7 is in "Maintenance Support or
> > > Maintenance Support 2" phase which is defined to mean [2]:
> > >
> > > ```
> > > During the Maintenance Support Phase for Red Hat Enterprise Linux
> > > Version 8 & 9, and Maintenance Support 2 Phase for Red Hat Enterprise
> > > Linux version 7, Red Hat defined Critical and Important impact
> > > Security Advisories (RHSAs) and selected (at Red Hat discretion)
> > > Urgent Priority Bug Fix Advisories (RHBAs) may be released as they
> > > become available. Other errata advisories may be delivered as
> > > appropriate.
> > >
> > > New functionality and new hardware enablement are not planned for
> > > availability in the Maintenance Support (RHEL 8 & 9) Phase and
> > > Maintenance Support 2 (RHEL 7) Phase.
> > > ```
> > >
> > > >From this definition, why would RHEL7 pick up a new perf tool? I don't
> > > think they would and as such we don't need to worry about supporting
> > > it. RHEL8 defaults to python 3 and full support ends for it next year.
> > > Let's set the bar at RHEL8 and not worry about RHEL7 breakages like
> > > this in future. I think the bar for caring should be "will the distro
> > > pick up our code", if we don't do this then we're signing up to not
> > > allowing tools to update for 10 years! If someone is building a kernel
> > > and perf tool on RHEL7 then they should be signing up to also deal
> > > with tool chain issues, which in this case can mean installing
> > > python3.
> >
> > In this specific supporting things that people report using, like was
> > done in this case, isn't such a big problem.
>
> So there are linters will fire for this code and say it is not
> pythonic. It is only a linter warning vs asking to support an 8 year
> old out of support distribution. There are other cases, such as
> improving the C code structure, where we've failed to land changes
> because of build errors on old distributions. This could indicate perf
> code is wrong or the distribution is wrong. I'm saying that if we
> believe in the perf code being correct and the distribution is out of
> support, then we should keep the perf code as-is and the issue is one
> for user of the out-of-support distribution.
>
> > Someone reported a problem in a system they used, the author of the code
> > in question posted a patch allowing perf to be used in such old systems,
> > doesn't get in the way of newer systems, small patch, merged, life goes
> > on.

Considering the proposed patch, can you be sure that replacing the
f-string format with the legacy format won't cause a regression for
some python3 user somewhere when this hits the real world? Even
if it does not cause a regression today, as new versions and features
are added to python3, can you be sure none of those new features
will depend on the upgrade from the legacy format to the f-string
format here to work properly? So many regressions happen because
the people who write patches cannot possibly foresee how their
patch is going to affect the millions of Linux users out there, but still
they are certain it will not cause a regression somewhere. So how
can the chances that this patch will cause a regression be minimized?

It seems to me for this to be suitable for the Linux kernel, the
default should be to use the modern python3 format and only
enable python2 compatibility via a sysctl setting and/or kernel boot
option for those who are still using python2. There should be no
change to the behavior of the kernel for users who have upgraded
to python3. But I don't see any such consideration for python3
users in this patch.

>
> Right, but we're setting a precedent for supporting out of support
> distributions. If we can say "life goes on" can we land this *current*
> Debian fix?
> https://lore.kernel.org/lkml/20220629034007.332804-1-irogers@google.com/
>
> > Sometimes some organizations are stuck with some distro till they can go
> > thru re-certifications, bidding for new hardware, whatever, and then
> > they want to continue using the latest perf on those systems because
> > they want to benefit from new features we're working on that work on
> > such systems. If the cost is small, like in this case, I see no problems
> > to have perf working on such older systems.
>
> So there's no problem with perf working on old systems. The issue is
> supporting 10 year old unsupported build infrastructure. The fact that
> the build infrastructure is unsupported means we need to carry all the
> fixes in the tools tree and that can mean doing some questionably sane
> things, like supporting python 2 (end of life for 2.5 years) on RHEL7
> (end of full support 3 years ago). RHEL8 still has a year of support,
> so great test that. RHEL7 then fix your tools and perf will work for
> you - where fix means "rpm -i python3", hardly a huge chore.

In large projects, going from python2 to 3 probably involves
a bit more than doing just that and expecting everything to work.
That said, large projects should have the resources to upgrade
to python3 on "old" enterprise systems. So I more or less agree
with Ian here.

Regards,

Chuck
