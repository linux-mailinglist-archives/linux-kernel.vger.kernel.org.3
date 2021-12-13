Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22A5D472E35
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 14:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238465AbhLMN4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 08:56:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234036AbhLMN4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 08:56:23 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF08FC061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 05:56:22 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id y13so51932763edd.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 05:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zrtRpR8eA02n90RUwfo1A3PioW6t9aLRijcZi5AYw44=;
        b=Gr/l8gjmasnhOeyi4byACXdu1YfG5jl2KSTRaw5qc2izpQ4Ojz71h7I1rmOXQmK27R
         97zOBvJZL/2Rd6XJTZOAmihFqO0gNx2kvVoKZkI4+Wqq1HVhybjtwkd84yTUWDRSf7mR
         ZrLl/MUwAexAV8V1+UZ/zprNEKooaryECmfhpwNYDBPjaXJ7WdPdcM1J9sq3/EjnlzEV
         N6EnBSPlgu5cpLhc0/Sb5QDJZs0TQkfIqQU2kYk4sBaDCI8RYtmvG0BYFC/qCMG2vK7j
         KeDzTQidnMTl77ctP6WQ47yaa2Kl/O1cBsv2RP43UrlXeF7c03u2ZeRwxKDc1hfAOcsv
         nWKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zrtRpR8eA02n90RUwfo1A3PioW6t9aLRijcZi5AYw44=;
        b=g9ET3vSnuGFKN0VIUnWHc3L4OQSmsoh58mibiWrfd7DrUo0WkNWFIYy5NU713zUea1
         W9uJPmqLwFDMGwyfxci995y4slMmlU0PlFXJ4MZ9A9HtV/VGW0OFRGksm+hjrYxbJXXr
         eZaLYm2lXD6h13nfj6Z4+tB1LdmFA7wnFwjLBl5Q0CoEeCobfXo1Ebk0DKoWa7LBOfGo
         994LJzwiiV7f+ToP9Kh9dDAt2ApC6hcoGOcFtlZd12+VYHDI2OqjQ7blbYveULjHUK6f
         Pjm1K8SZHg0csyj2yfphRkZxGBiXJWwqWPeilXfpUbT3mt+e6X3kzIZnPDLDo2Nscj84
         ewmA==
X-Gm-Message-State: AOAM533y08rHeYP5cEdUXukSHjnnoIx6Tg71FcoVRSImyMyGYrItiWek
        7+ORjn5fX43z1Xy+AbvZzyhO9m5bhmjP7PDg47L+7W/09YAfggVH
X-Google-Smtp-Source: ABdhPJzu6Sy0E4ASvjWdK04f3wVR79VFUqLTwERbCTzG1yv15MbFMEi1BYmN3V3vffxNAKrnuq7q+wxehLaP0obMRJ4=
X-Received: by 2002:aa7:c415:: with SMTP id j21mr65957272edq.357.1639403781408;
 Mon, 13 Dec 2021 05:56:21 -0800 (PST)
MIME-Version: 1.0
References: <1638619795-71451-1-git-send-email-wang.yong12@zte.com.cn>
 <Yax01zjuzmNyyJK/@balbir-desktop> <CAOH5QeDhjyjAkS1bUju2cv67KFukUr0ov8uG+z3bM6Oa=iFrMA@mail.gmail.com>
 <Ya7uQingLC3fMJlt@balbir-desktop> <CAOH5QeC+0xDrgO+t3zwN4o48F9Q2CiTnzQDO78kuJLfyNJwoLA@mail.gmail.com>
In-Reply-To: <CAOH5QeC+0xDrgO+t3zwN4o48F9Q2CiTnzQDO78kuJLfyNJwoLA@mail.gmail.com>
From:   yong w <yongw.pur@gmail.com>
Date:   Mon, 13 Dec 2021 21:56:08 +0800
Message-ID: <CAOH5QeCO_EZzkU=B3L1=1OPiZa7XxnWZK87GbwXNOQXxZqYcoQ@mail.gmail.com>
Subject: Re: [PATCH v2 linux-next] delayacct: track delays from memory compact
To:     Balbir Singh <bsingharora@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, mingo@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        yang.yang29@zte.com.cn, wang.yong12@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,  is this patch OK?

Thanks.

yong w <yongw.pur@gmail.com> =E4=BA=8E2021=E5=B9=B412=E6=9C=888=E6=97=A5=E5=
=91=A8=E4=B8=89 00:50=E5=86=99=E9=81=93=EF=BC=9A
>
> Balbir Singh <bsingharora@gmail.com> =E4=BA=8E2021=E5=B9=B412=E6=9C=887=
=E6=97=A5=E5=91=A8=E4=BA=8C 13:16=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Sun, Dec 05, 2021 at 07:08:02PM +0800, yong w wrote:
> > > Balbir Singh <bsingharora@gmail.com> =E4=BA=8E2021=E5=B9=B412=E6=9C=
=885=E6=97=A5=E5=91=A8=E6=97=A5 16:17=E5=86=99=E9=81=93=EF=BC=9A
> > > >
> > > > On Sat, Dec 04, 2021 at 04:09:55AM -0800, yongw.pur@gmail.com wrote=
:
> > > > > From: wangyong <wang.yong12@zte.com.cn>
> > > > >
> > > > > Delay accounting does not track the delay of memory compact.
> > > > > When there is not enough free memory, tasks can spend
> > > > > a amount of their time waiting for compact.
> > > > >
> > > > > To get the impact of tasks in direct memory compact, measure
> > > > > the delay when allocating memory through memory compact.
> > > > >
> > > >
> > > > Should we call this DIRECT_COMPACT and through documentation
> > > > or name change imply that this won't work for kcompactd the
> > > > kernel thread - based on my reading of the patches.
> > > >
> > > Using DIRECT_COMPACT is a little redundant=EF=BC=8Cbecause the
> > > delayacct stats of delay accounting is specific to tasks, it has
> > > nothing to do with kcompactd, which is similar to the RECLAIM field.
> > >
> >
> > What would we expect when we call delayacct -p <pidof kcompactd>
> > to be output?
> If the slow path of memory allocation is invoked in the kcompacd process,
> there may be delays being recorded.
>
> > Don't feel to strongly, but it can be confusing that kcompactd
> > has spent no time in compact'ing? Not that delayacct is used for
> > kernel threads, but I am not sure if that use case exists today.
> Yes, delayacct does not restrict the process of obtaining information=EF=
=BC=8C
> but kcompactd is used for  compaction,  the compact delay of
> kcompatd is not actually a delay.Maybe it can be added to the
> document later to make it clearer.
>
> Thanks for your reply!
