Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5AE753546B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 22:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234682AbiEZUac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 16:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiEZUaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 16:30:30 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49191AEE25
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:30:29 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id b7so2484432vsq.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EaE2PBM7SrEMgBvdnMAtayVc5vqDLRWV6AQ1zZGxiDo=;
        b=SSNeGJIxApDm2h40uEBy/HSo391DliMhXNVkX29boHJM56E7d96b0hvA8B4hTbNy7B
         oEN0F/LKpb0vOog37WypcErBnrC5h20z6ztPSRarI7wFvFJpEQOk20FYNEUeX5I+7pTn
         ShnfUr35Feys7k7NIopZEsHPVu7/lAv0aTbg5iB2Vhusbt9QGIiCCuFZ2lcsDvdqcCG0
         GAPXSk9V3cZ3J/LC3t+pkIvVkDDyZV2mRhOWvxrnD6LOkt/NwiqirC+XXK092r2xyIBh
         IivAgXwe2WErTPRuCZJN2kmVLzoC2jKuqT/PLAc2ZHpjPRzWIkAKg3iPpOnhU2GTV7fn
         HS+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EaE2PBM7SrEMgBvdnMAtayVc5vqDLRWV6AQ1zZGxiDo=;
        b=vu+QC/8G1w2dlcudtPH9FhnY0aNFOTMCHR9XHJA4x/lq0Cu+wGrfZRn2HePuFHfFL2
         kQwQLydbynjp1ExBi8v6TtVws6R+OFwbMKdcZdqsAOdJoosp6eLWTrvoG6vUm/Uz89UD
         qNYtqLwcDI+wUts/4m+Mnq5iwGu+0Ah8z+B1A5k7Orw9+wofuhxywD+q7B/lWy2kZxWS
         mmAou2L3In8G20ovqH+AD6vdNnTywmlwL4oReL3cug2yNUsbIwd9fc6J7FZXYUBcZ8ue
         f0K2uaizZie+RHHqGLaHPwWhn76UfOmrBl3KjaVouB83yT75FCPIV3dzLu+ZXqgweGuR
         936A==
X-Gm-Message-State: AOAM530ub33yQLQNUPGEaZjqWf0hquVn3PW+btmxOMg3WD3OZ8LakeAk
        BZqXQLUWIPKt6fJ7EYnVWoVBb46+eW3E+IZXmk/qWw==
X-Google-Smtp-Source: ABdhPJwaBZhRqMrcVuzxYbXuBoasFB0Tja+S/DnWk8uW5rJQmCo/GD0KItdpLl9LtUoYgfNgKUCymZKZcXY94hftSTU=
X-Received: by 2002:a05:6102:3ecf:b0:320:7c27:5539 with SMTP id
 n15-20020a0561023ecf00b003207c275539mr17824111vsv.59.1653597028254; Thu, 26
 May 2022 13:30:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAAPL-u-DGLcKRVDnChN9ZhxPkfxQvz9Sb93kVoX_4J2oiJSkUw@mail.gmail.com>
 <20220512160010.00005bc4@Huawei.com> <CAAPL-u_diGYEb7+WsgqNBLRix-nRCk2SsDj6p9r8j5JZwOABZQ@mail.gmail.com>
 <6b7c472b50049592cde912f04ca47c696caa2227.camel@intel.com>
 <CAAPL-u-NAJkSXHzQr8OtEEGnnUrsCE9US6c5S5Rv0xutASxv1Q@mail.gmail.com>
 <ad1bc96a86b21b8f46d356f0c0b7449be38b2220.camel@intel.com>
 <CAAPL-u8XzJnrew4vuFq7GgwgjjBff8MwRFGTDmUc9DOwa+q=FA@mail.gmail.com>
 <6ce724e5c67d4f7530457897fa08d0a8ba5dd6d0.camel@intel.com>
 <594046f8-9ab3-786a-fc48-8a61f1238f52@linux.ibm.com> <CAAPL-u-3-iOoSK07TE=gUN8a+TsXNNEiFaEArf7+zvTgxDJnRQ@mail.gmail.com>
 <20220526103211.000001ad@Huawei.com>
In-Reply-To: <20220526103211.000001ad@Huawei.com>
From:   Wei Xu <weixugc@google.com>
Date:   Thu, 26 May 2022 13:30:16 -0700
Message-ID: <CAAPL-u_aDgVm0D=0d+hzc0o_f1vV3whHn9fAVW2RAYNz4mqG9A@mail.gmail.com>
Subject: Re: RFC: Memory Tiering Kernel Interfaces (v2)
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>,
        Ying Huang <ying.huang@intel.com>,
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

On Thu, May 26, 2022 at 2:32 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Wed, 25 May 2022 10:27:42 -0700
> Wei Xu <weixugc@google.com> wrote:
>
> > On Wed, May 25, 2022 at 3:01 AM Aneesh Kumar K V
> > <aneesh.kumar@linux.ibm.com> wrote:
> > >
> > > On 5/25/22 2:33 PM, Ying Huang wrote:
> > > > On Tue, 2022-05-24 at 22:32 -0700, Wei Xu wrote:
> > > >> On Tue, May 24, 2022 at 1:24 AM Ying Huang <ying.huang@intel.com> wrote:
> > > >>>
> > > >>> On Tue, 2022-05-24 at 00:04 -0700, Wei Xu wrote:
> > > >>>> On Thu, May 19, 2022 at 8:06 PM Ying Huang <ying.huang@intel.com> wrote:
> > > >>>>>
> > >
> > > ...
> > >
> > > >
> > > > OK.  Just to confirm.  Does this mean that we will have fixed device ID,
> > > > for example,
> > > >
> > > > GPU                   memtier255
> > > > DRAM (with CPU)               memtier0
> > > > PMEM                  memtier1
> > > >
> > > > When we add a new memtier, it can be memtier254, or memter2?  The rank
> > > > value will determine the real demotion order.
> > > >
> > > > I think you may need to send v3 to make sure everyone is at the same
> > > > page.
> > > >
> > >
> > > What we have implemented which we will send as RFC shortly is below.
> > >
> > > cd /sys/dekvaneesh@ubuntu-guest:~$ cd /sys/devices/system/
> > > kvaneesh@ubuntu-guest:/sys/devices/system$ pwd
> > > /sys/devices/system
> > > kvaneesh@ubuntu-guest:/sys/devices/system$ ls
> > > clockevents  clocksource  container  cpu  edac  memory  memtier  mpic
> > > node  power
> > > kvaneesh@ubuntu-guest:/sys/devices/system$ cd memtier/
> > > kvaneesh@ubuntu-guest:/sys/devices/system/memtier$ pwd
> > > /sys/devices/system/memtier
> > > kvaneesh@ubuntu-guest:/sys/devices/system/memtier$ ls
> > > default_rank  max_rank  memtier1  power  uevent
> > > kvaneesh@ubuntu-guest:/sys/devices/system/memtier$ cat default_rank
> > > 1
> > > kvaneesh@ubuntu-guest:/sys/devices/system/memtier$ cat max_rank
> > > 3
> >
> > For flexibility, we don't want max_rank to be interpreted as the
> > number of memory tiers.  Also, we want to leave spaces in rank values
> > to allow new memtiers to be inserted when needed.  So I'd suggest to
> > make max_rank a much larger value (e.g. 255).
> >
> > > kvaneesh@ubuntu-guest:/sys/devices/system/memtier$ cd memtier1/
> > > kvaneesh@ubuntu-guest:/sys/devices/system/memtier/memtier1$ ls
> > > nodelist  power  rank  subsystem  uevent
> > > kvaneesh@ubuntu-guest:/sys/devices/system/memtier/memtier1$ cat nodelist
> > > 0-3
> > > kvaneesh@ubuntu-guest:/sys/devices/system/memtier/memtier1$ cat rank
> > > 1
> > > kvaneesh@ubuntu-guest:/sys/devices/system/memtier/memtier1$ cd
> > > ../../node/node1/
> > > kvaneesh@ubuntu-guest:/sys/devices/system/node/node1$ cat memtier
> > > 1
> > > kvaneesh@ubuntu-guest:/sys/devices/system/node/node1$
> > > root@ubuntu-guest:/sys/devices/system/node/node1# echo 0 > memtier
> > > root@ubuntu-guest:/sys/devices/system/node/node1# cat memtier
> > > 0
> > > root@ubuntu-guest:/sys/devices/system/node/node1# cd ../../memtier/
> > > root@ubuntu-guest:/sys/devices/system/memtier# ls
> > > default_rank  max_rank  memtier0  memtier1  power  uevent
> > > root@ubuntu-guest:/sys/devices/system/memtier# cd memtier0/
> > > root@ubuntu-guest:/sys/devices/system/memtier/memtier0# cat nodelist
> > > 1
> > > root@ubuntu-guest:/sys/devices/system/memtier/memtier0# cat rank
> > > 0
> >
> > It looks like the example here demonstrates the dynamic creation of
> > memtier0.  If so, how is the rank of memtier0 determined?  If we want
> > to support creating new memtiers at runtime, I think an explicit
> > interface that specifies both device ID and rank is preferred to avoid
> > implicit dependencies between device IDs and ranks.
>
> Why make device ID explicit - it's meaningless I think?
> How about a creation interface that is simply writing the rank value
> to create a new one?  The only race I can see would be to get
> two parallel attempts to create a new tier with the same rank.
> That seems unlikely to matter unless we support changing rank later.
>
> Two attempts to create the same device ID tier seems more likely to
> cause fiddly races.

That's right: Device ID is not needed when creating a new memtier. It
should be enough to provide only a rank value.

> Jonathan
>
>
> >
> > > root@ubuntu-guest:/sys/devices/system/memtier/memtier0# echo 4 > rank
> > > bash: rank: Permission denied
> > > root@ubuntu-guest:/sys/devices/system/memtier/memtier0#
>
>
