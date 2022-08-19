Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D295599D3E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 15:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348948AbiHSN4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 09:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349044AbiHSN4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 09:56:38 -0400
Received: from sonic312-23.consmr.mail.gq1.yahoo.com (sonic312-23.consmr.mail.gq1.yahoo.com [98.137.69.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EDFC100956
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 06:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netscape.net; s=a2048; t=1660917396; bh=tnM+zKSjH7L19hIHm0z0BtpfQ0AKAz/TaSXrO5bzA+U=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=OKG0dQmV4pWc04Z0AI8XAnWuZjsMaoihRM6i8K8YFUnJzzyzX+sON9KJCt6Tdcsz3kQMuRcfsDvV8m18klmt+aOJoBfD+aYUsDhJ+47Q24/EozJpv6e/rM2Js3yc3o38PoIK8RoTIJs97LVsI1UhKQVCSx8G6h5vxvlw18sJp1l3EpGyypwhrwiNSHhjt2r6ZwLWCHbReBVXXqQWE/93B48wNtB/up+umk4bFXC1Lg7pkeR2mCVxSkUgVTf3BPrhdfbHT5BEQPuV7r74VLNMZSzNLTZKgT8Pdk7qMr9qAZARiKUd8Z5DI1N0KwGm8e4WtLIK0jmKcbGoJVuTDoxdJg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1660917396; bh=Ss0gHKmViXvwxcGimleM2UmcX74g9nVFtiIriA+Lz08=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=Gv051tmAuo/E+LJNLmBAvYb9Sphv4/Ra2YqRID8OCTDrzlZvaDttxtwsxmjDkOl/9WV9ZJSg1qiUulYzsLibmjun8T03kj9ArwnO8P8l/DWkl3IFVgt4BpO4jw0RzWar1el3SNCIEvtm6XtPvbI1REuhofU98Ji0VqbjKX8vwItVkYdATiRkBU40uMuYaSbdu6mlQyBJEsfCjoh6MCd3hBysh4mvJkmRxNjBzbFS3mFAr9hwEDAC0PZsfJo3H1Z4sB7gH8030WABstWM87cUmPTbe+rf47QuB8MzFixBnwd3MV+Uq1QbtPGxyvte02dSLGDwUcjZUVLuACeg9taqwA==
X-YMail-OSG: Fbh1HnQVM1n0LIs_8_mWIhpaUhyi8g9pYCDGqGrXQI924ZBOAzxd61GrL1S3HG7
 JDwJH1FMJi_r1ta8J9Yr38u5v82RRJutbFdVBuzbjQCvifRSTZU6avnSsgJmYEY6wM57Iff8kW30
 2y0zfIQJN3xGBGy6WcXOjrxOSgljozG_6T1KdnSyhrhtQvpmPtHiy9UfvkX0rKlNVwWDAtHm5Rc5
 HaTSfObDnavkwAq1p.i78SFNbD9prUNh87we.0XDSZjWguDw1_13F2OIM_aKcKK0jqnD5rLq9snm
 lNsriq1H2mqASj0Gaxk9qN4bn.LaHGKxHbv0VSulMVdWeSETmbvEC.RJtusmPy01MVRI1MFSRlp1
 akYbAzK_0HgjGgw_nmRO8ME2QBkamhbT2Oobuv5tgglgZ_EVgyDXDC4SE7UG6sJmAb3mcgMybIjZ
 UemiHHei6VTKE3JAIgL6292ngzrQpQDu35nrNz31kVZMravHBPsV9BSKwSDldBA5X2_W1.lUHiEV
 EHKOHtIkCvOhNp1XcVpdseFa4.icLzp9j5TLKeZ6.G6k8frXsQFT7WyIGRqIdSZcpa7R0Jr9HYoL
 QiJ5Ssm4RJgASXzM_EFu1iL35RGUoWIGfLKuOt4Cj22Zec9p4yPC5EVLx2mgNTWyDLCNVcgI5fDs
 6qLffISScOgBTdjF9U4xdUixjZamQYfIklHInea7EzxROnK4ML6c674JhvuI9.Lgfj60CZohmvQM
 mbiWqOTIJ1NxMTrYDu_i5img9oa1RzFfjV6RmDLLo0F6PMg1b4TUDPny.QMAySojvbWG2Fi3ErfW
 ivXRQxkcmV1GFb84uzcpxfPmHV4BaNfSVAEN0jxMM.iT0_9JXh3vEQzkPaVRfDq5hNy3FLDZz6Oo
 rhBK3EyRFF_gF.XBomlrQfMPyHU5_If7y0Gmx8NcUNzCb1oMtghInR.JBEk9kUovfYm1FmGjdwdc
 bYT3ATfkl9XpzW1kKyAKmgaA.IvHkVF8XNIqMuUTBrwCGo.eXCv95mnE.IYn9ueM9JsmOKByBeQy
 EN07n30JMnToeEvXPCk9UkuFumO65gNU2vYmLKNL2P4Wp0LxS.E85XT3tYnnZAKUg_dA2P2jecJO
 SDjRAz8Zt3faGFLATrUyfll3O0wARyjXUmD5QI_MApK5vbbh7ZcBfvoWc0DVRjwlhWMXU04qi0BC
 FaguMbjyRdL5pEFKERcdLF7OhksPb8CKJS9RGtXw05eD9vcZmWFAJXcK1LaK3DUKGWFzcIk9Rabe
 oH0nqKks6bmcljSR5W_NXtx8LQAHFszMgto0.tT2P.Rgqrsf1LTdqQoz6R5znjCAtYe9fUklfAq9
 znB3YNeCiCYNv.OM.jfnKcr8gw5RZwmHFoHk5WmhMbU89gezP_yrOsvW2SoBPYDTTkkiBSsEhANg
 lmjmHld5V3AwkdlKn53WLSGwunQtSy7yFcA67JOf4i9jh3Wnt4L8Ud8ApZZPFbFiAcIVqGrVREZG
 gTP4s4v6fATL_5vAFFDAqA9SnJ9YgWFHSZsWiZkqop1nHSdpS3FDY6Bg1KqJ12wj22dDIdck3UCA
 Ll.3kcEYv8UmgwD5nNJTYHZaHwVKKeMJDzc9FBq6aRibK1z7oIcKFsEznOMKXTahOkivWBkdBJ_t
 Cbg98A21ZIrt_3Tr0vj8BNnrzKisk9TfZ1aAoLr6LjHrL9dbo7PNPkhb4HlNq5cyy_.kUz_2hOer
 J0nfkwB7Sg4Yn4ZsGP3ibVA97iC2dkMQ73F8_FaKxcwHT0R9OE9ez6B2rxv6XVFBaCZ8OF3gdjEA
 bHpZyRc7QZ69V4L8PVGyHI9EVhXswU2upRBg4zsObuxwZh_t_FK0JFWySxWlRqWRwTFnK4.Mfys4
 IXQDleaS9paD6mA431YbzBTl6IBH74ar1Q0fI_HSFx7y21Pq4iNFj11u6YUkPab4siXj5XlMbbzr
 8PGQyT6t.Ybv0jK3mlsikAjRqqozq.bYBidK9rFimI3sbQl.xOnfy90WwUy75dvj3h.4sDo3zjEM
 Tg3xN19wBV.KdHy0ngSJvJlpf3_mKC_eFllip7SNAnVKIHGyRx20l_JJ83vTGDYZ3rnvWcB.kprN
 wAOxB3vnrsyyycgAcQvJGE36RangqnJU6L41ZVdcya_Hawxl9j8Vtv7v2Ag1PhVAPdWxwuAO1hmy
 Abhylu8O7u5fVP1tRN3L3tCOiSrpotEqkQ_HSS5q.eOJSfiDyW6HqX4J09s5d00V8OHzDHOkXJX6
 kOhuoTnYrvwOphE_DWvO125zvSA--
X-Sonic-MF: <brchuckz@aim.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.gq1.yahoo.com with HTTP; Fri, 19 Aug 2022 13:56:36 +0000
Received: by hermes--production-ne1-6649c47445-sp72j (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 3bc1d4565e6c9a7637f3a291096d4067;
          Fri, 19 Aug 2022 13:56:30 +0000 (UTC)
Message-ID: <a0950172-aab0-a771-0255-d3654f217ce8@netscape.net>
Date:   Fri, 19 Aug 2022 09:56:26 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] perf scripts python: Let script to be python2 compliant
To:     Leo Yan <leo.yan@linaro.org>, Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alan Bartlett <ajb@elrepo.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-perf-users@vger.kernel.org, ElRepo <contact@elrepo.org>,
        Akemi Yagi <toracat@elrepo.org>, Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
References: <CA+_WhHyZZC=3gtzetEAQQrjtGujHmY5azwtQNZEc90gyOAwUDg@mail.gmail.com>
 <CAP-5=fWiNdnEawdj_3ExCrcwRSnRxeV8=8RhA6pwbw_bJdPJFg@mail.gmail.com>
 <YuBDw/+7McESS05X@kernel.org>
 <CAP-5=fV4+KeGcyyODTNjS01dw1iTXpFyaLXwZ8nBkek+NHL37w@mail.gmail.com>
 <11781d7e-d9de-f889-ff57-9d26d92ada44@netscape.net>
 <16cb5f73-ac85-5094-3cd1-ec91cb47fb99@netscape.net>
 <CAP-5=fXjBBbU3EHD5iY6VMKMo3wj+dJteeqBf5B9m464HtdF3Q@mail.gmail.com>
 <806d152f-358b-572a-64f2-798fe7783f93@netscape.net>
 <20220818030335.GB30503@leoy-huanghe>
 <CAP-5=fX8OVBFGXAgshstMBMFo4ULvMBdZnE_2h-RsamJ6q1qow@mail.gmail.com>
 <Yv8yRv2BMVgmb/n+@leoy-yangtze.lan>
Content-Language: en-US
From:   Chuck Zmudzinski <brchuckz@netscape.net>
In-Reply-To: <Yv8yRv2BMVgmb/n+@leoy-yangtze.lan>
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

On 8/19/2022 2:48 AM, Leo Yan wrote:
> On Thu, Aug 18, 2022 at 07:52:22AM -0700, Ian Rogers wrote:
>
> [...]
>
> > > > I see this has already been committed. I agree it should not
> > > > stay in the kernel tree for long. At some point in the future
> > > > it will most likely cause problems if it is not reverted.
> > >
>
>
> It's fine for me to revert this patch in an appropriate time.

An appropriate time presumably means when there is no more significant
demand for mainline kernel support on older distros like RHEL 7 and clones
that are still using python2. I also presume you plan to post the proposed
revert to the appropriate mailing lists before committing it, giving time for
anyone who wants to keep python2 compatibility a chance to make their
case.

Thanks,

Chuck
