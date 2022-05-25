Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC9053406B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 17:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244871AbiEYPd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 11:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbiEYPd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 11:33:57 -0400
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED82019C15
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 08:33:55 -0700 (PDT)
Received: by mail-vk1-xa32.google.com with SMTP id d132so10073371vke.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 08:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=L/HY259bVjGUdiARIFEb7gVit9w/Zkrf9kFmEOh5p/U=;
        b=Br7XN5sO4nabySMnczCeP5za9dMJNdr9gwLuivgSSSnA50/FkjJwB96mDayUI8QRES
         hO/toJToNOC6dV58kDbdPK5ItMV8R0isjxTMf2HJ2HIVhuAb0tx6aWJbEzCZgiurJj4S
         8IRHPIYQjxxtpmRzL0jjEQza+3NTJwxlVn33rL9E0wVOCDA7o4MsUbehJxJipL/8H/64
         7jnBCIQjfuVEfFDHxd0ZyPtKsoiyJ8EPTs3JwkbjZd4zNUS0LGi0TThTp0srN66qrMUL
         j9/vWXZGsBaQP6JAbzjVacpgNqLaVZ2+x2Q93KUiELXkWJf6GS9jC0Fq/uvSxkmKJlvy
         BXvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=L/HY259bVjGUdiARIFEb7gVit9w/Zkrf9kFmEOh5p/U=;
        b=zswrXgPjSogS1UTbQJxoFlQZenUIHp0y7y5/Br5zuX6ZpIJLmdr8TiO89ekdnUmVSq
         WM7b+2EmTVrkO7br7K9TnRfjsGoTF9hnH3D3c8Wu4FT4QVablGCQYD02VEf+dhNN2u4K
         KLUj6JaNTjXx4+Dd6s6qvjr3VSqINoOT1s0t5L74sBfIi1Pb2zXePGv+GZS5H1cTJtIY
         JFbBHeo+dO3NeZnWixPoGID0aJeG38zPq83L9y+ZX62ZXMPlkXpYxBnxi01mRyvabHqo
         cVwoo1SgmzmdJJnD3dIsRML4INca/i3mCPnOAv6X6wiPw/TpKZIifjkHa5aid5zQv9ZR
         zMyA==
X-Gm-Message-State: AOAM532eJ/tKYJ2OYo9GOtyG/8KBiIWeAMT+zhLV2LP53uKUWDBLC3G/
        TqyDja45ywSGlzksmwoBsXvogl5fJs1zgbHK61AW3Q==
X-Google-Smtp-Source: ABdhPJxsBryrDmT00sVFdPgNC8WS5tL2SlJYLuVJpna+dMdvH9lsPuVChzXc3nFL/7AEPsCRF0ASCrzJxFpRB4uUMV0=
X-Received: by 2002:a05:6122:17a1:b0:357:840c:48c1 with SMTP id
 o33-20020a05612217a100b00357840c48c1mr7129196vkf.38.1653492834969; Wed, 25
 May 2022 08:33:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAAPL-u-DGLcKRVDnChN9ZhxPkfxQvz9Sb93kVoX_4J2oiJSkUw@mail.gmail.com>
 <20220512160010.00005bc4@Huawei.com> <CAAPL-u_diGYEb7+WsgqNBLRix-nRCk2SsDj6p9r8j5JZwOABZQ@mail.gmail.com>
 <6b7c472b50049592cde912f04ca47c696caa2227.camel@intel.com>
 <CAAPL-u-NAJkSXHzQr8OtEEGnnUrsCE9US6c5S5Rv0xutASxv1Q@mail.gmail.com>
 <ad1bc96a86b21b8f46d356f0c0b7449be38b2220.camel@intel.com>
 <CAAPL-u8XzJnrew4vuFq7GgwgjjBff8MwRFGTDmUc9DOwa+q=FA@mail.gmail.com>
 <6ce724e5c67d4f7530457897fa08d0a8ba5dd6d0.camel@intel.com>
 <594046f8-9ab3-786a-fc48-8a61f1238f52@linux.ibm.com> <2d06932c-7d80-94c7-89ab-78375e58d3cc@redhat.com>
In-Reply-To: <2d06932c-7d80-94c7-89ab-78375e58d3cc@redhat.com>
From:   Wei Xu <weixugc@google.com>
Date:   Wed, 25 May 2022 08:33:43 -0700
Message-ID: <CAAPL-u_CHVQ=jL0PonW4iFCgBM5wxmfRz7idYoen-H6etonH3Q@mail.gmail.com>
Subject: Re: RFC: Memory Tiering Kernel Interfaces (v2)
To:     =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>
Cc:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>,
        Ying Huang <ying.huang@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Thelen <gthelen@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Michal Hocko <mhocko@kernel.org>,
        Tim C Chen <tim.c.chen@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Alistair Popple <apopple@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Feng Tang <feng.tang@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dan Williams <dan.j.williams@intel.com>,
        David Rientjes <rientjes@google.com>,
        Linux MM <linux-mm@kvack.org>,
        Brice Goglin <brice.goglin@gmail.com>,
        Hesham Almatary <hesham.almatary@huawei.com>
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

On Wed, May 25, 2022 at 4:37 AM Mika Penttil=C3=A4 <mpenttil@redhat.com> wr=
ote:
>
>
>
> On 25.5.2022 13.01, Aneesh Kumar K V wrote:
> > On 5/25/22 2:33 PM, Ying Huang wrote:
> >> On Tue, 2022-05-24 at 22:32 -0700, Wei Xu wrote:
> >>> On Tue, May 24, 2022 at 1:24 AM Ying Huang <ying.huang@intel.com> wro=
te:
> >>>>
> >>>> On Tue, 2022-05-24 at 00:04 -0700, Wei Xu wrote:
> >>>>> On Thu, May 19, 2022 at 8:06 PM Ying Huang <ying.huang@intel.com>
> >>>>> wrote:
> >>>>>>
> >
> > ...
> >
> >>
> >> OK.  Just to confirm.  Does this mean that we will have fixed device I=
D,
> >> for example,
> >>
> >> GPU            memtier255
> >> DRAM (with CPU)        memtier0
> >> PMEM            memtier1
> >>
> >> When we add a new memtier, it can be memtier254, or memter2?  The rank
> >> value will determine the real demotion order.
> >>
> >> I think you may need to send v3 to make sure everyone is at the same
> >> page.
> >>
> >
> > What we have implemented which we will send as RFC shortly is below.
> >
> > cd /sys/dekvaneesh@ubuntu-guest:~$ cd /sys/devices/system/
> > kvaneesh@ubuntu-guest:/sys/devices/system$ pwd
> > /sys/devices/system
> > kvaneesh@ubuntu-guest:/sys/devices/system$ ls
> > clockevents  clocksource  container  cpu  edac  memory  memtier  mpic
> > node  power
> > kvaneesh@ubuntu-guest:/sys/devices/system$ cd memtier/
> > kvaneesh@ubuntu-guest:/sys/devices/system/memtier$ pwd
> > /sys/devices/system/memtier
> > kvaneesh@ubuntu-guest:/sys/devices/system/memtier$ ls
> > default_rank  max_rank  memtier1  power  uevent
> > kvaneesh@ubuntu-guest:/sys/devices/system/memtier$ cat default_rank
> > 1
> > kvaneesh@ubuntu-guest:/sys/devices/system/memtier$ cat max_rank
> > 3
> > kvaneesh@ubuntu-guest:/sys/devices/system/memtier$ cd memtier1/
> > kvaneesh@ubuntu-guest:/sys/devices/system/memtier/memtier1$ ls
> > nodelist  power  rank  subsystem  uevent
> > kvaneesh@ubuntu-guest:/sys/devices/system/memtier/memtier1$ cat nodelis=
t
> > 0-3
> > kvaneesh@ubuntu-guest:/sys/devices/system/memtier/memtier1$ cat rank
> > 1
> > kvaneesh@ubuntu-guest:/sys/devices/system/memtier/memtier1$ cd
> > ../../node/node1/
> > kvaneesh@ubuntu-guest:/sys/devices/system/node/node1$ cat memtier
> > 1
> > kvaneesh@ubuntu-guest:/sys/devices/system/node/node1$
> > root@ubuntu-guest:/sys/devices/system/node/node1# echo 0 > memtier
> > root@ubuntu-guest:/sys/devices/system/node/node1# cat memtier
> > 0
> > root@ubuntu-guest:/sys/devices/system/node/node1# cd ../../memtier/
> > root@ubuntu-guest:/sys/devices/system/memtier# ls
> > default_rank  max_rank  memtier0  memtier1  power  uevent
> > root@ubuntu-guest:/sys/devices/system/memtier# cd memtier0/
> > root@ubuntu-guest:/sys/devices/system/memtier/memtier0# cat nodelist
> > 1
> > root@ubuntu-guest:/sys/devices/system/memtier/memtier0# cat rank
> > 0
> > root@ubuntu-guest:/sys/devices/system/memtier/memtier0# echo 4 > rank
> > bash: rank: Permission denied
> > root@ubuntu-guest:/sys/devices/system/memtier/memtier0#
> >
>
> Just to confirm, unlike today's demotion code, the demotion target
> allocation is planned to honor mempolicies?

Yes, though there will be some limitations in the beginning,
specifically for per-thread mempolicy.

>
> --Mika
>
>
