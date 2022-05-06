Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85BB51DF73
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 21:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388891AbiEFTJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 15:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386675AbiEFTJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 15:09:13 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DF51115B
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 12:05:28 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id o69so7796050pjo.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 12:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XY52lokW3Gz896dORyk3XbXtZ36Z+nGvhDg4ZfkIyOw=;
        b=nrZYCL9vNGmBRbVEBTZhmaePhgNibPPAvI1Ko/g0AOz0bOG4W9sIEtGysQh3cEmzBs
         zXGxN0uMR+Orc2tDBLFiEfS/yb48EqYdNmEE6CwZHTJpjavlfVk9w4BiZRSR+0VzdKBK
         28QbwtVSMjLavuMay9vGRa81DfVb3cv8CgOl6vdELBAyk7WWjv7fBq8I3tWaoRzvDgJk
         pZ95y0n6N4qBhzWRiTQnMFQv+ZTFXbFjxAb1CNW7Db4sSyEiNS13b6kPAkrH+ReLf+g8
         +YQybLKwPlyDZ00e6pYM00rWFSOaf2FHX1h8c0jLr0wNxhYjn8UyQ2nszC6707Kej2Gh
         GzxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XY52lokW3Gz896dORyk3XbXtZ36Z+nGvhDg4ZfkIyOw=;
        b=LguR+Ycq+iNrT/O548r3ZuV7m+CDWfkBMcOUGgszq/ttxuXd5znebYcHE383B0s6hM
         NFmNL4gBBjkxg3dOP61MwQjf7f+u5dsZkgd7Ur3eTvw0gr9lgwVDZTDyth+5p9kBNcrA
         GWB1J79dR6syDgaBMBh2zSWRtsJYPLfJ86ieupdSs3RBnR2NsDmx60LHy3DqlwlELrql
         9qvHQXAW3ZQRkJ6t8cr0ylwSDsZ55PxeOWiydGYFdHXFP0Ix7K6AhEH3sPqNQbF59aRm
         lGqvlc08ikrgX4dQMwvOcWHqKth7ow6kuZkVivDQVkLuke9F+KZy+E65ZVL+Cx9gYDGQ
         cufg==
X-Gm-Message-State: AOAM530KRRZyY8VmP1k++0VgeUvUVtsXhPjl+B9+otcIMLM9JBVhAjHE
        FUdj2buF51sqefFF/VNfSWlVwBwNgLLzf7TUKc0=
X-Google-Smtp-Source: ABdhPJyd+cRv1GOJhxyYaGhWmVSwV+3xawEPq8StjvWp2gy3AptjgQf6GqaQLBqehGf7+oR/DcvFTkbbqoE8JKCoGXY=
X-Received: by 2002:a17:902:e851:b0:15e:93ac:41db with SMTP id
 t17-20020a170902e85100b0015e93ac41dbmr5065327plg.26.1651863928520; Fri, 06
 May 2022 12:05:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAAPL-u9sVx94ACSuCVN8V0tKp+AMxiY89cro0japtyB=xNfNBw@mail.gmail.com>
 <CAHbLzkq1YXXLMiREpGnzhJjPssu4WpSsnkTmrLJ=hAEhZVUr9w@mail.gmail.com> <CAPcyv4g7kyPsSKGT1rR4yy680VD6UJ8V7wzj0OUqN2y2-PjOpQ@mail.gmail.com>
In-Reply-To: <CAPcyv4g7kyPsSKGT1rR4yy680VD6UJ8V7wzj0OUqN2y2-PjOpQ@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 6 May 2022 12:05:16 -0700
Message-ID: <CAHbLzko9PxCzDUdVGOFQuy0o8R4H2k5Qo_+gkMUSdd3=b1tSWw@mail.gmail.com>
Subject: Re: RFC: Memory Tiering Kernel Interfaces
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Wei Xu <weixugc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Linux MM <linux-mm@kvack.org>,
        Greg Thelen <gthelen@google.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alistair Popple <apopple@nvidia.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Michal Hocko <mhocko@kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Feng Tang <feng.tang@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 1, 2022 at 11:35 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Fri, Apr 29, 2022 at 8:59 PM Yang Shi <shy828301@gmail.com> wrote:
> >
> > Hi Wei,
> >
> > Thanks for the nice writing. Please see the below inline comments.
> >
> > On Fri, Apr 29, 2022 at 7:10 PM Wei Xu <weixugc@google.com> wrote:
> > >
> > > The current kernel has the basic memory tiering support: Inactive
> > > pages on a higher tier NUMA node can be migrated (demoted) to a lower
> > > tier NUMA node to make room for new allocations on the higher tier
> > > NUMA node.  Frequently accessed pages on a lower tier NUMA node can be
> > > migrated (promoted) to a higher tier NUMA node to improve the
> > > performance.
> > >
> > > A tiering relationship between NUMA nodes in the form of demotion path
> > > is created during the kernel initialization and updated when a NUMA
> > > node is hot-added or hot-removed.  The current implementation puts all
> > > nodes with CPU into the top tier, and then builds the tiering hierarchy
> > > tier-by-tier by establishing the per-node demotion targets based on
> > > the distances between nodes.
> > >
> > > The current memory tiering interface needs to be improved to address
> > > several important use cases:
> > >
> > > * The current tiering initialization code always initializes
> > >   each memory-only NUMA node into a lower tier.  But a memory-only
> > >   NUMA node may have a high performance memory device (e.g. a DRAM
> > >   device attached via CXL.mem or a DRAM-backed memory-only node on
> > >   a virtual machine) and should be put into the top tier.
> > >
> > > * The current tiering hierarchy always puts CPU nodes into the top
> > >   tier. But on a system with HBM (e.g. GPU memory) devices, these
> > >   memory-only HBM NUMA nodes should be in the top tier, and DRAM nodes
> > >   with CPUs are better to be placed into the next lower tier.
> > >
> > > * Also because the current tiering hierarchy always puts CPU nodes
> > >   into the top tier, when a CPU is hot-added (or hot-removed) and
> > >   triggers a memory node from CPU-less into a CPU node (or vice
> > >   versa), the memory tiering hierarchy gets changed, even though no
> > >   memory node is added or removed.  This can make the tiering
> > >   hierarchy much less stable.
> >
> > I'd prefer the firmware builds up tiers topology then passes it to
> > kernel so that kernel knows what nodes are in what tiers. No matter
> > what nodes are hot-removed/hot-added they always stay in their tiers
> > defined by the firmware. I think this is important information like
> > numa distances. NUMA distance alone can't satisfy all the usecases
> > IMHO.
>
> Just want to note here that the platform firmware can only describe
> the tiers of static memory present at boot. CXL hotplug breaks this
> model and the kernel is left to dynamically determine the device's
> performance characteristics and the performance of the topology to
> reach that device. Now, the platform firmware does set expectations
> for the perfomance class of different memory ranges, but there is no
> way to know in advance the performance of devices that will be asked
> to be physically or logically added to the memory configuration. That
> said, it's probably still too early to define ABI for those
> exceptional cases where the kernel needs to make a policy decision
> about a device that does not fit into the firmware's performance
> expectations, but just note that there are limits to the description
> that platform firmware can provide.

Thanks, Dan. I don't know too much about CXL. Is it possible to make
it static? For example, put it into a default tier (for example, the
lowest tier) as long as CXL is available regardless of whether there
is any device connected or not? Then the kernel driver could probe
some information and move it to the proper tier once the device is hot
plugged. Anyway, just off the top of my head.

>
> I agree that NUMA distance alone is inadequate and the kernel needs to
> make better use of data like ACPI HMAT to determine the default
> tiering order.

Yeah, we are on the same page.
