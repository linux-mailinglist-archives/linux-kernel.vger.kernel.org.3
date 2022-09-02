Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B3E5AA722
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 07:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbiIBFJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 01:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiIBFJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 01:09:25 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43BCB5E60
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 22:09:24 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id q3so962791pjg.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 22:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=PmZ+jeHheCTitnwYvU2IM5Mh5fQ9dWuFRDxNtLNgxGM=;
        b=kGybGFCn0r9hnHDD+XlTAUGy+rtoNiikm2mL5bvqn+0h4z1q4yzz3Ns7ajlCHdrdD7
         g0dI/EU/xfSodqQS67E+p+MEscy/R40NUQ6JBx/HWVFnHy3NznELkLnyoGTOVzfThNfN
         XtUV1XgOogkXv8XVLpMF05vdye3kpjHgo0mQCxh2ik+qs/Fir1/o/Fs0PIyRUbXul2GF
         WpSSXSA+kfvF8yT/K0X1P7doQGU6kb6+o2xNezqlefMyIE6/nIfSKGiucjP/yRhloqs7
         J42GoAmP2NFJbOIkChC90ot3MlQapEROsuhYzYMwxk2VNmJGTAj+NBikTfRICRZDlX2v
         B4gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=PmZ+jeHheCTitnwYvU2IM5Mh5fQ9dWuFRDxNtLNgxGM=;
        b=ocrOqE8wEg/jUvcYbV9SZBegRhmlfI/X9v46Wbj9tn5ikhaKOg/E/DS7zi8YzLOW0g
         0nhvoOmj7AnydElnMHHVe3w0IXSZUt86LzQpDTRPime2tvSAncYdHyvYyptPU1xaR1+S
         cEPkrRCGAuIc+2ZoaeDNkln8XqHvuvFnaVuLGtGBcPfPRVcafQt1Ls1HMgnawJ9sIVSJ
         7VdPLH6O3WvT10ILrMEAdmRXTV8/knF+KNwvKIlpaC/LboRxoB3CJNb4sXgAc+fMhAiO
         kFHsl6wjjKT5Ib0c6ACa/74NWpsCvYBzcu3BKrRyfIxM7VTufmgtlioxm5WJbIG0ZLEj
         ynxQ==
X-Gm-Message-State: ACgBeo0u8U7o3uUOe/SgucmIqN+7M+7YmpYuFucW4jkB/abwLcKW7iJA
        yD7j5x6aR1UwFUz19Kz25852yf+bWY/AcxpH2jwNyQ==
X-Google-Smtp-Source: AA6agR4GqC333D5J7oqjHPpAb5xShJJ+b+rwcZLQGvuq6reZtSV2d3zGioXXI/2CJ1KNCtxqT/JIReg7dxj+9v2Mqek=
X-Received: by 2002:a17:90b:3142:b0:1fa:f533:3191 with SMTP id
 ip2-20020a17090b314200b001faf5333191mr2851172pjb.193.1662095364249; Thu, 01
 Sep 2022 22:09:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220830081736.119281-1-aneesh.kumar@linux.ibm.com>
 <87tu5rzigc.fsf@yhuang6-desk2.ccr.corp.intel.com> <ad19e105-9290-922d-59e6-e6813a30f5f0@linux.ibm.com>
 <87pmgezkhp.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87pmgezkhp.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Wei Xu <weixugc@google.com>
Date:   Thu, 1 Sep 2022 22:09:13 -0700
Message-ID: <CAAPL-u8MEs04DkHy6kaS788VjdYZZjAYOgzMnioOzDXbc0ZhhQ@mail.gmail.com>
Subject: Re: [PATCH v3 updated] mm/demotion: Expose memory tier details via sysfs
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        jvgediya.oss@gmail.com, Bharata B Rao <bharata@amd.com>,
        Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 1, 2022 at 5:33 PM Huang, Ying <ying.huang@intel.com> wrote:
>
> Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:
>
> > On 9/1/22 12:31 PM, Huang, Ying wrote:
> >> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
> >>
> >>> This patch adds /sys/devices/virtual/memory_tiering/ where all memory=
 tier
> >>> related details can be found. All allocated memory tiers will be list=
ed
> >>> there as /sys/devices/virtual/memory_tiering/memory_tierN/
> >>>
> >>> The nodes which are part of a specific memory tier can be listed via
> >>> /sys/devices/virtual/memory_tiering/memory_tierN/nodes
> >>
> >> I think "memory_tier" is a better subsystem/bus name than
> >> memory_tiering.  Because we have a set of memory_tierN devices inside.
> >> "memory_tier" sounds more natural.  I know this is subjective, just my
> >> preference.
> >>
> >>>
> >>> A directory hierarchy looks like
> >>> :/sys/devices/virtual/memory_tiering$ tree memory_tier4/
> >>> memory_tier4/
> >>> =E2=94=9C=E2=94=80=E2=94=80 nodes
> >>> =E2=94=9C=E2=94=80=E2=94=80 subsystem -> ../../../../bus/memory_tieri=
ng
> >>> =E2=94=94=E2=94=80=E2=94=80 uevent
> >>>
> >>> All toptier nodes are listed via
> >>> /sys/devices/virtual/memory_tiering/toptier_nodes
> >>>
> >>> :/sys/devices/virtual/memory_tiering$ cat toptier_nodes
> >>> 0,2
> >>> :/sys/devices/virtual/memory_tiering$ cat memory_tier4/nodes
> >>> 0,2
> >>
> >> I don't think that it is a good idea to show toptier information in us=
er
> >> space interface.  Because it is just a in kernel implementation
> >> details.  Now, we only promote pages from !toptier to toptier.  But
> >> there may be multiple memory tiers in toptier and !toptier, we may
> >> change the implementation in the future.  For example, we may promote
> >> pages from DRAM to HBM in the future.
> >>
> >
> >
> > In the case you describe above and others, we will always have a list o=
f
> > NUMA nodes from which memory promotion is not done.
> > /sys/devices/virtual/memory_tiering/toptier_nodes shows that list.
>
> I don't think we will need that interface if we don't restrict promotion
> in the future.  For example, he can just check the memory tier with
> smallest number.
>
> TBH, I don't know why do we need that interface.  What is it for?  We
> don't want to expose unnecessary information to restrict our in kernel
> implementation in the future.
>
> So, please remove that interface at least before we discussing it
> thoroughly.

I have asked for this interface to allow the userspace to query a list
of top-tier nodes as the targets of userspace-driven promotions.  The
idea is that demotion can gradually go down tier by tier, but we
promote hot pages directly to the top-tier and bypass the immediate
tiers.

Certainly, this can be viewed as a policy choice.  Given that now we
have a clearly defined memory tier hierarchy in sysfs and the
toptier_nodes content can be constructed from this memory tier
hierarchy and other information from the node sysfs interfaces, I am
fine if we want to remove toptier_nodes and keep the current memory
tier sysfs interfaces to the minimal.

Wei Xu

> >> Do we need a way to show the default memory tier in sysfs?  That is, t=
he
> >> memory tier that the DRAM nodes belong to.
> >>
> >
> > I will hold adding that until we have support for modifying memory tier=
 details from
> > userspace. That is when userspace would want to know about the default =
memory tier.
> >
> > For now, the user interface is a simpler hierarchy of memory tiers, it'=
s associated
> > nodes and the list of nodes from which promotion is not done.
>
> OK.
>
> Best Regards,
> Huang, Ying
