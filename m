Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4902D534C8A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 11:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346854AbiEZJcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 05:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234289AbiEZJcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 05:32:18 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31610C8BDF
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 02:32:16 -0700 (PDT)
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4L82fZ1dZnz67yBh;
        Thu, 26 May 2022 17:28:06 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 26 May 2022 11:32:14 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 26 May
 2022 10:32:13 +0100
Date:   Thu, 26 May 2022 10:32:11 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Wei Xu <weixugc@google.com>
CC:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>,
        Ying Huang <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Greg Thelen" <gthelen@google.com>, Yang Shi <shy828301@gmail.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Michal Hocko <mhocko@kernel.org>,
        Tim C Chen <tim.c.chen@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Alistair Popple" <apopple@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Feng Tang <feng.tang@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Dan Williams" <dan.j.williams@intel.com>,
        David Rientjes <rientjes@google.com>,
        Linux MM <linux-mm@kvack.org>,
        Brice Goglin <brice.goglin@gmail.com>,
        "Hesham Almatary" <hesham.almatary@huawei.com>
Subject: Re: RFC: Memory Tiering Kernel Interfaces (v2)
Message-ID: <20220526103211.000001ad@Huawei.com>
In-Reply-To: <CAAPL-u-3-iOoSK07TE=gUN8a+TsXNNEiFaEArf7+zvTgxDJnRQ@mail.gmail.com>
References: <CAAPL-u-DGLcKRVDnChN9ZhxPkfxQvz9Sb93kVoX_4J2oiJSkUw@mail.gmail.com>
        <20220512160010.00005bc4@Huawei.com>
        <CAAPL-u_diGYEb7+WsgqNBLRix-nRCk2SsDj6p9r8j5JZwOABZQ@mail.gmail.com>
        <6b7c472b50049592cde912f04ca47c696caa2227.camel@intel.com>
        <CAAPL-u-NAJkSXHzQr8OtEEGnnUrsCE9US6c5S5Rv0xutASxv1Q@mail.gmail.com>
        <ad1bc96a86b21b8f46d356f0c0b7449be38b2220.camel@intel.com>
        <CAAPL-u8XzJnrew4vuFq7GgwgjjBff8MwRFGTDmUc9DOwa+q=FA@mail.gmail.com>
        <6ce724e5c67d4f7530457897fa08d0a8ba5dd6d0.camel@intel.com>
        <594046f8-9ab3-786a-fc48-8a61f1238f52@linux.ibm.com>
        <CAAPL-u-3-iOoSK07TE=gUN8a+TsXNNEiFaEArf7+zvTgxDJnRQ@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhreml740-chm.china.huawei.com (10.201.108.190) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 May 2022 10:27:42 -0700
Wei Xu <weixugc@google.com> wrote:

> On Wed, May 25, 2022 at 3:01 AM Aneesh Kumar K V
> <aneesh.kumar@linux.ibm.com> wrote:
> >
> > On 5/25/22 2:33 PM, Ying Huang wrote:  
> > > On Tue, 2022-05-24 at 22:32 -0700, Wei Xu wrote:  
> > >> On Tue, May 24, 2022 at 1:24 AM Ying Huang <ying.huang@intel.com> wrote:  
> > >>>
> > >>> On Tue, 2022-05-24 at 00:04 -0700, Wei Xu wrote:  
> > >>>> On Thu, May 19, 2022 at 8:06 PM Ying Huang <ying.huang@intel.com> wrote:  
> > >>>>>  
> >
> > ...
> >  
> > >
> > > OK.  Just to confirm.  Does this mean that we will have fixed device ID,
> > > for example,
> > >
> > > GPU                   memtier255
> > > DRAM (with CPU)               memtier0
> > > PMEM                  memtier1
> > >
> > > When we add a new memtier, it can be memtier254, or memter2?  The rank
> > > value will determine the real demotion order.
> > >
> > > I think you may need to send v3 to make sure everyone is at the same
> > > page.
> > >  
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
> 
> For flexibility, we don't want max_rank to be interpreted as the
> number of memory tiers.  Also, we want to leave spaces in rank values
> to allow new memtiers to be inserted when needed.  So I'd suggest to
> make max_rank a much larger value (e.g. 255).
> 
> > kvaneesh@ubuntu-guest:/sys/devices/system/memtier$ cd memtier1/
> > kvaneesh@ubuntu-guest:/sys/devices/system/memtier/memtier1$ ls
> > nodelist  power  rank  subsystem  uevent
> > kvaneesh@ubuntu-guest:/sys/devices/system/memtier/memtier1$ cat nodelist
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
> 
> It looks like the example here demonstrates the dynamic creation of
> memtier0.  If so, how is the rank of memtier0 determined?  If we want
> to support creating new memtiers at runtime, I think an explicit
> interface that specifies both device ID and rank is preferred to avoid
> implicit dependencies between device IDs and ranks.

Why make device ID explicit - it's meaningless I think?
How about a creation interface that is simply writing the rank value
to create a new one?  The only race I can see would be to get
two parallel attempts to create a new tier with the same rank.
That seems unlikely to matter unless we support changing rank later.

Two attempts to create the same device ID tier seems more likely to
cause fiddly races.

Jonathan


> 
> > root@ubuntu-guest:/sys/devices/system/memtier/memtier0# echo 4 > rank
> > bash: rank: Permission denied
> > root@ubuntu-guest:/sys/devices/system/memtier/memtier0#  

