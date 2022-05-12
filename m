Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B0E5246BB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 09:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350871AbiELHTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 03:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350877AbiELHTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 03:19:09 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3EAC5DBA
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 00:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652339947; x=1683875947;
  h=message-id:subject:from:to:date:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=YgDjZJ0GrhB2TixzXN5MHJpkRl2ysRB6/EQ97IsEbNI=;
  b=Sa0gBgNHo6lqWDgovArpaOrwbz2vy84hKq+UtWMKzcTzq0NV+ZDW03PQ
   GmkqmcDL+QGfDqryUwm/T9JgK6CW9leFyyeyFEwPf+BygQtBVx+CpDltz
   CIaraG/L4Hyo0XEs38Q6O6HouwAIN26xU0oCQa/cU6/3h4iJ/I1Sdxr56
   q6sJHDYyedvMmHzfXeJykrAQ3IpoyNJVWs/yykgedV5tPXg3P53TzLwQz
   Qy7FamKRX6erX1xWzOD4UO1QxVSsb7QmYB0iWqyNVtVPjLsTVKqVB1Rir
   ZcwQZ7QNC998BHaKRTJpFF1XJ5XK7ITvUru5L128ojYmHZUQCdh/d2Z+U
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="268753313"
X-IronPort-AV: E=Sophos;i="5.91,219,1647327600"; 
   d="scan'208";a="268753313"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 00:18:36 -0700
X-IronPort-AV: E=Sophos;i="5.91,219,1647327600"; 
   d="scan'208";a="566550286"
Received: from ruonanwa-mobl.ccr.corp.intel.com ([10.254.212.157])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 00:18:30 -0700
Message-ID: <9c93f72ad70687d06e9318f8023ce45d39f742e3.camel@intel.com>
Subject: Re: RFC: Memory Tiering Kernel Interfaces (v2)
From:   "ying.huang@intel.com" <ying.huang@intel.com>
To:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>,
        Wei Xu <weixugc@google.com>,
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
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dan Williams <dan.j.williams@intel.com>,
        David Rientjes <rientjes@google.com>,
        Linux MM <linux-mm@kvack.org>,
        Brice Goglin <brice.goglin@gmail.com>,
        Hesham Almatary <hesham.almatary@huawei.com>
Date:   Thu, 12 May 2022 15:18:27 +0800
In-Reply-To: <c5d55131-76ff-7354-2954-7cfac365a9a5@linux.ibm.com>
References: <CAAPL-u-DGLcKRVDnChN9ZhxPkfxQvz9Sb93kVoX_4J2oiJSkUw@mail.gmail.com>
         <56b41ce6922ed5f640d9bd46a603fa27576532a9.camel@intel.com>
         <c5d55131-76ff-7354-2954-7cfac365a9a5@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-05-12 at 12:42 +0530, Aneesh Kumar K V wrote:
> On 5/12/22 12:33 PM, ying.huang@intel.com wrote:
> > On Wed, 2022-05-11 at 23:22 -0700, Wei Xu wrote:
> > > Sysfs Interfaces
> > > ================
> > > 
> > > * /sys/devices/system/memtier/memtierN/nodelist
> > > 
> > >    where N = 0, 1, 2 (the kernel supports only 3 tiers for now).
> > > 
> > >    Format: node_list
> > > 
> > >    Read-only.  When read, list the memory nodes in the specified tier.
> > > 
> > >    Tier 0 is the highest tier, while tier 2 is the lowest tier.
> > > 
> > >    The absolute value of a tier id number has no specific meaning.
> > >    What matters is the relative order of the tier id numbers.
> > > 
> > >    When a memory tier has no nodes, the kernel can hide its memtier
> > >    sysfs files.
> > > 
> > > * /sys/devices/system/node/nodeN/memtier
> > > 
> > >    where N = 0, 1, ...
> > > 
> > >    Format: int or empty
> > > 
> > >    When read, list the memory tier that the node belongs to.  Its value
> > >    is empty for a CPU-only NUMA node.
> > > 
> > >    When written, the kernel moves the node into the specified memory
> > >    tier if the move is allowed.  The tier assignment of all other nodes
> > >    are not affected.
> > > 
> > >    Initially, we can make this interface read-only.
> > 
> > It seems that "/sys/devices/system/node/nodeN/memtier" has all
> > information we needed.  Do we really need
> > "/sys/devices/system/memtier/memtierN/nodelist"?
> > 
> > That can be gotten via a simple shell command line,
> > 
> > $ grep . /sys/devices/system/node/nodeN/memtier | sort -n -k 2 -t ':'
> > 
> 
> It will be really useful to fetch the memory tier node list in an easy 
> fashion rather than reading multiple sysfs directories. If we don't have 
> other attributes for memorytier, we could keep
> "/sys/devices/system/memtier/memtierN" a NUMA node list there by 
> avoiding /sys/devices/system/memtier/memtierN/nodelist

This will make the interface not extensible.  Even a single file
"/sys/devices/system/node/memtiers" is better.  As an readonly file, it
should be OK to put multiple values in it.

I remember that one rule for sysfs is that it is accessed more via
libsysfs.  Does that make life easier?

Best Regards,
Huang, Ying


