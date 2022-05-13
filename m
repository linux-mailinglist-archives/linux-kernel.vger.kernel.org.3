Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76041525C06
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 09:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352731AbiEMHAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 03:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377607AbiEMHAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 03:00:19 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774651EEE3B
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 00:00:17 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id q136so3762823vke.10
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 00:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zSQtsKCtwMYCMAV1h8dxEmMkmLjgLgdq8u/If5PWyoo=;
        b=ghMK2HcrDTMpFO6IVO2QFoxB3sSruYjPWtgLSUU0nZAzAVWbjZR/I92Jcca5YBBd02
         r6WXn2DlpPBcjtfKLYUsM3rJbujVUZpo9B+6oBmlT6fTD2ebulJNtpFWY0KI9ozq+F+H
         tjqsFvAMfaFSO6urR6ZsPMcHj49NE/SdB4lobuQ2ep22BNmxralwTYHKlx7bXPanzpna
         rFnsjjSsyw6fwfG58NPn/7xSS5p/Xt8qy5LUi1chzrJd1x6Bjw/ycI4X5FJBShd6dkhq
         ugGKY6arD6j3N9GJRI4szNel9G+zRyCErU6lq5vEMiWan5DjnrIJrDOaIzZ+taTMG6wL
         Id3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zSQtsKCtwMYCMAV1h8dxEmMkmLjgLgdq8u/If5PWyoo=;
        b=AM06CnMoTpGqohfybf7kZ3R/ivel8I/5KAJWl7jDhIs4si46kM479gOMOQrMUR6EK4
         oEG0mNsXKF7PsywMkY4dY1XV8pedAe29Z3RYSrQ1wE+OwH3yZkGj6LYM7L+5x7LSoo/M
         xgRqf/eP+S76NLyoXp/3PIgRHl2PtNCaLv1YmIvB1adrqBLzKzl/IB1HsgWUPqsMRC/d
         +zLsJtLO2d0unY8H4Yajd5U3tMPcNWxBcfh50e7492cWIgteSJfh1NOPLNGp3KkzpzV0
         eyFsfx0sep/FHCTSbHuT6S13PfPqsPBVYI9UXtCOdhqXhXZYQUtlR/mD2HPVTEqm/e2/
         1xqg==
X-Gm-Message-State: AOAM531QZVW89CPJFxFhfbx0ZVBSPcQ9RceifN2h6wPHRuPZKsDhTWEs
        +Nq6icplRsQZFGy0jJZn2cp2QfQ0/prWGSeEkRGZpw==
X-Google-Smtp-Source: ABdhPJyLkJEi/QkxDrR4cj9GzGNh4STOHakEoAIWSXBYUyEbDuYdxNMvlEFO7t6AjmE67KVluFtpr9ivOtYKtnvQ2XI=
X-Received: by 2002:a1f:9b85:0:b0:32d:4d56:cf64 with SMTP id
 d127-20020a1f9b85000000b0032d4d56cf64mr1480204vke.31.1652425216408; Fri, 13
 May 2022 00:00:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAAPL-u-DGLcKRVDnChN9ZhxPkfxQvz9Sb93kVoX_4J2oiJSkUw@mail.gmail.com>
 <56b41ce6922ed5f640d9bd46a603fa27576532a9.camel@intel.com>
 <c5d55131-76ff-7354-2954-7cfac365a9a5@linux.ibm.com> <CAAPL-u-g86QqHaHGGtVJMER8ENC2dpekK+2qOkxoRFmC0F_80g@mail.gmail.com>
 <87y1z7jj85.fsf@linux.ibm.com> <CAAPL-u90Gzrepbsdpc62FGRBYOx1LAVwZWHg1E7UyVD_CmcROw@mail.gmail.com>
 <c8f253839505adec4d68cd2aa3f3769866915ad3.camel@intel.com> <f36273d9a2fa09342972cd49e31bf2fe91e7c9e4.camel@intel.com>
In-Reply-To: <f36273d9a2fa09342972cd49e31bf2fe91e7c9e4.camel@intel.com>
From:   Wei Xu <weixugc@google.com>
Date:   Fri, 13 May 2022 00:00:05 -0700
Message-ID: <CAAPL-u-vPgCKVYOLqiScYu5Q_jApPsoHZnNGNfN+k2YuFFR_nw@mail.gmail.com>
Subject: Re: RFC: Memory Tiering Kernel Interfaces (v2)
To:     "ying.huang@intel.com" <ying.huang@intel.com>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
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

On Thu, May 12, 2022 at 7:53 PM ying.huang@intel.com
<ying.huang@intel.com> wrote:
>
> On Thu, 2022-05-12 at 16:37 +0800, ying.huang@intel.com wrote:
> > On Thu, 2022-05-12 at 01:15 -0700, Wei Xu wrote:
> > > On Thu, May 12, 2022 at 12:36 AM Aneesh Kumar K.V
> > > <aneesh.kumar@linux.ibm.com> wrote:
> > > >
> > > > Wei Xu <weixugc@google.com> writes:
> > > >
> > > > > On Thu, May 12, 2022 at 12:12 AM Aneesh Kumar K V
> > > > > <aneesh.kumar@linux.ibm.com> wrote:
> > > > > >
> > > > > > On 5/12/22 12:33 PM, ying.huang@intel.com wrote:
> > > > > > > On Wed, 2022-05-11 at 23:22 -0700, Wei Xu wrote:
> > > > > > > > Sysfs Interfaces
> > > > > > > > ================
> > > > > > > >
> > > > > > > > * /sys/devices/system/memtier/memtierN/nodelist
> > > > > > > >
> > > > > > > >    where N = 0, 1, 2 (the kernel supports only 3 tiers for now).
> > > > > > > >
> > > > > > > >    Format: node_list
> > > > > > > >
> > > > > > > >    Read-only.  When read, list the memory nodes in the specified tier.
> > > > > > > >
> > > > > > > >    Tier 0 is the highest tier, while tier 2 is the lowest tier.
> > > > > > > >
> > > > > > > >    The absolute value of a tier id number has no specific meaning.
> > > > > > > >    What matters is the relative order of the tier id numbers.
> > > > > > > >
> > > > > > > >    When a memory tier has no nodes, the kernel can hide its memtier
> > > > > > > >    sysfs files.
> > > > > > > >
> > > > > > > > * /sys/devices/system/node/nodeN/memtier
> > > > > > > >
> > > > > > > >    where N = 0, 1, ...
> > > > > > > >
> > > > > > > >    Format: int or empty
> > > > > > > >
> > > > > > > >    When read, list the memory tier that the node belongs to.  Its value
> > > > > > > >    is empty for a CPU-only NUMA node.
> > > > > > > >
> > > > > > > >    When written, the kernel moves the node into the specified memory
> > > > > > > >    tier if the move is allowed.  The tier assignment of all other nodes
> > > > > > > >    are not affected.
> > > > > > > >
> > > > > > > >    Initially, we can make this interface read-only.
> > > > > > >
> > > > > > > It seems that "/sys/devices/system/node/nodeN/memtier" has all
> > > > > > > information we needed.  Do we really need
> > > > > > > "/sys/devices/system/memtier/memtierN/nodelist"?
> > > > > > >
> > > > > > > That can be gotten via a simple shell command line,
> > > > > > >
> > > > > > > $ grep . /sys/devices/system/node/nodeN/memtier | sort -n -k 2 -t ':'
> > > > > > >
> > > > > >
> > > > > > It will be really useful to fetch the memory tier node list in an easy
> > > > > > fashion rather than reading multiple sysfs directories. If we don't have
> > > > > > other attributes for memorytier, we could keep
> > > > > > "/sys/devices/system/memtier/memtierN" a NUMA node list there by
> > > > > > avoiding /sys/devices/system/memtier/memtierN/nodelist
> > > > > >
> > > > > > -aneesh
> > > > >
> > > > > It is harder to implement memtierN as just a file and doesn't follow
> > > > > the existing sysfs pattern, either.  Besides, it is extensible to have
> > > > > memtierN as a directory.
> > > >
> > > > diff --git a/drivers/base/node.c b/drivers/base/node.c
> > > > index 6248326f944d..251f38ec3816 100644
> > > > --- a/drivers/base/node.c
> > > > +++ b/drivers/base/node.c
> > > > @@ -1097,12 +1097,49 @@ static struct attribute *node_state_attrs[] = {
> > > >         NULL
> > > >  };
> > > >
> > > > +#define MAX_TIER 3
> > > > +nodemask_t memory_tier[MAX_TIER];
> > > > +
> > > > +#define _TIER_ATTR_RO(name, tier_index)                                        \
> > > > +       { __ATTR(name, 0444, show_tier, NULL), tier_index, NULL }
> > > > +
> > > > +struct memory_tier_attr {
> > > > +       struct device_attribute attr;
> > > > +       int tier_index;
> > > > +       int (*write)(nodemask_t nodes);
> > > > +};
> > > > +
> > > > +static ssize_t show_tier(struct device *dev,
> > > > +                        struct device_attribute *attr, char *buf)
> > > > +{
> > > > +       struct memory_tier_attr *mt = container_of(attr, struct memory_tier_attr, attr);
> > > > +
> > > > +       return sysfs_emit(buf, "%*pbl\n",
> > > > +                         nodemask_pr_args(&memory_tier[mt->tier_index]));
> > > > +}
> > > > +
> > > >  static const struct attribute_group memory_root_attr_group = {
> > > >         .attrs = node_state_attrs,
> > > >  };
> > > >
> > > > +
> > > > +#define TOP_TIER 0
> > > > +static struct memory_tier_attr memory_tiers[] = {
> > > > +       [0] = _TIER_ATTR_RO(memory_top_tier, TOP_TIER),
> > > > +};
> > > > +
> > > > +static struct attribute *memory_tier_attrs[] = {
> > > > +       &memory_tiers[0].attr.attr,
> > > > +       NULL
> > > > +};
> > > > +
> > > > +static const struct attribute_group memory_tier_attr_group = {
> > > > +       .attrs = memory_tier_attrs,
> > > > +};
> > > > +
> > > >  static const struct attribute_group *cpu_root_attr_groups[] = {
> > > >         &memory_root_attr_group,
> > > > +       &memory_tier_attr_group,
> > > >         NULL,
> > > >  };
> > > >
> > > >
> > > > As long as we have the ability to see the nodelist, I am good with the
> > > > proposal.
> > > >
> > > > -aneesh
> > >
> > > I am OK with moving back the memory tier nodelist into node/.  When
> > > there are more memory tier attributes needed, we can then create the
> > > memory tier subtree and replace the tier nodelist in node/ with
> > > symlinks.
> >
> > What attributes do you imagine that we may put in memory_tierX/ sysfs
> > directory?  If we have good candidates in mind, we may just do that.
> > What I can imagine now is "demote", like "memory_reclaim" in nodeX/ or
> > node/ directory you proposed before.  Is it necessary to show something
> > like "meminfo", "vmstat" there?
>
> My words may be confusing, so let me say it in another way.

I can understand. :)

> Just for brainstorm, if we have
>
>   /sys/devices/system/memtier/memtierN/
>
> What can we put in it in addition to "nodelist" or links to the nodes?
> For example,
>
>   /sys/devices/system/memtier/memtierN/demote
>
> When write a page number to it, the specified number of pages will be
> demoted from memtierN to memtierN+1, like the
> /sys/devices/system/node/memory_reclaim interface you proposed before.

"demote" might be fine to add there.  Just to clarify, we (Google)
currently don't yet have the need for an interface to do system-wide
demotion from one tier to another.  What we need is memory.demote
(similar to memory.reclaim) for memory cgroup based demotions.

Other things that might be added include tier-specific properties
(e.g. expected latency and bandwidth when available) and tier-specific
stats.

Under /sys/devices/system/memtier/, we may add global properties about
memory tiers, e.g. max number of tiers, min/max tier ids (which might
be useful if we hide unpopulated memory tiers).

> Or, is it necessary to add
>
>   /sys/devices/system/memtier/memtierN/meminfo
>   /sys/devices/system/memtier/memtierN/vmstat

The userspace can aggregate such data from node/nodeN/{meminfo,
vmstat} based on the memory tier nodelist. But I am not against adding
these files to memtierN/ for user convenience.

> I don't mean to propose these.  Just want to know whether there's
> requirement for these kind of stuff?  And what else may be required.

This sounds good.  I think a memtier directory may eventually become a
necessity, though I don't feel too strongly about adding it right now.

> Best Regards,
> Huang, Ying
>
> > >
> > > So the revised sysfs interfaces are:
> > >
> > > * /sys/devices/system/node/memory_tierN (read-only)
> > >
> > >   where N = 0, 1, 2
> > >
> > >   Format: node_list
> > >
> > > * /sys/devices/system/node/nodeN/memory_tier (read/write)
> > >
> > >   where N = 0, 1, ...
> > >
> > >   Format: int or empty
> >
>
>
>
