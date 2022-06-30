Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A315D560E65
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 02:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbiF3A5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 20:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiF3A5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 20:57:47 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0F8201A1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 17:57:46 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id l9-20020a056830268900b006054381dd35so13506282otu.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 17:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SKqfiDiYuvfDETXVnoeeg5pQ6AZyqtVKR2qDMSZMeUk=;
        b=MbC6Tw1nfwmIzq9H1rKp+n/UqqIX05yDgOOlpIZdHXKKpP/zyZ6fwpSvAzJ8lYcYlZ
         YIqyVrj6+1G7upZyavcalRFk921/82SZDL0tu+kbZDdrp3N3BRkw2+YCNvyBvYkqe+Z6
         a49VJNtdaXVVd5x52SPZ4zs+wyBDcXV32Mmbq5HeQQJV3ErI64ZXkiDtII1g+jJ+dMkh
         Tgz7TMKzDmDwv9e8+fFx5f8nNR4YDVRJaQKq2XzRQd3G7WQCzRc96Qj/lG0FDtU/wMqL
         PNqTzGaTuRcp8DiuT8CHwAo16HJuuG3v1fKzsv/9AtubCRHbETL8X6/SxKqE7UptDZuZ
         MWsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SKqfiDiYuvfDETXVnoeeg5pQ6AZyqtVKR2qDMSZMeUk=;
        b=WBdFGJIViTz76hUqzTUSu9eO1B8xkM0gC94qI4/AwnPWhN1vDllIsSgSts+s6bllPF
         eJlnYm8PfaLD5szNB01RMX4/GPc5mMfBnp5yglYexPMr1wJxYz4BH5ZDZF6EBQ02D3e7
         4WJLTQqoTAuo3BQRqx3+lDf4RfW4oUNpir25AHA/OE19zNUr+Jhz8hESBI8V7dkcF3/4
         9JNqyisNJQ3toC3+/7d5UZu7Y0o7mb/5RSx+Y+Gsqo6P5/lnjMu3sLNOeq9oUx33n0e/
         UJndFSDXmCJ0J+5s5KyZvCBqUOj8V0YF/m6uUi+qni08w5XNJFL4DzWl7NVyjW2ul9cI
         mUhQ==
X-Gm-Message-State: AJIora/KKylJmkWV0YSGBxt7YrCpnPa1gXn3vNMcQLBOeZrOyEPbs0eF
        Us08VpHNPovlXNEVi9t89dUzSDSLZSnIl8Huj3A=
X-Google-Smtp-Source: AGRyM1uuqNmU1rx2B7OEGgbZcMQT3ivFsBg7sH7fuoVOlpvED76IbLTkh316ZjKbIN9vW844cpjPQkNBZoXKO5IHV/4=
X-Received: by 2002:a05:6830:d13:b0:618:b519:5407 with SMTP id
 bu19-20020a0568300d1300b00618b5195407mr201343otb.219.1656550665471; Wed, 29
 Jun 2022 17:57:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220622082513.467538-1-aneesh.kumar@linux.ibm.com> <20220622082513.467538-12-aneesh.kumar@linux.ibm.com>
In-Reply-To: <20220622082513.467538-12-aneesh.kumar@linux.ibm.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Thu, 30 Jun 2022 06:27:34 +0530
Message-ID: <CAFqt6zYOWURi-U6gsKTf7jjpGjMn0WqeBz1zm-5DAFDQ+Go2xw@mail.gmail.com>
Subject: Re: [PATCH v7 11/12] mm/demotion: Add documentation for memory tiering
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Xu <weixugc@google.com>, Huang Ying <ying.huang@intel.com>,
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
        Jagdish Gediya <jvgediya@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 2:04 PM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> From: Jagdish Gediya <jvgediya@linux.ibm.com>
>
> All N_MEMORY nodes are divided into 3 memoty tiers with tier ID value

s /memoty/ memory

> MEMORY_TIER_HBM_GPU, MEMORY_TIER_DRAM and MEMORY_TIER_PMEM. By default,
> all nodes are assigned to default memory tier.

I think adding the default memory tier name will be helpful.

>
> Demotion path for all N_MEMORY nodes is prepared based on the tier ID value
> of memory tiers.
>
> This patch adds documention for memory tiering introduction, its sysfs
> interfaces and how demotion is performed based on memory tiers.
>
> Suggested-by: Wei Xu <weixugc@google.com>
> Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  Documentation/admin-guide/mm/index.rst        |   1 +
>  .../admin-guide/mm/memory-tiering.rst         | 182 ++++++++++++++++++
>  2 files changed, 183 insertions(+)
>  create mode 100644 Documentation/admin-guide/mm/memory-tiering.rst
>
> diff --git a/Documentation/admin-guide/mm/index.rst b/Documentation/admin-guide/mm/index.rst
> index c21b5823f126..3f211cbca8c3 100644
> --- a/Documentation/admin-guide/mm/index.rst
> +++ b/Documentation/admin-guide/mm/index.rst
> @@ -32,6 +32,7 @@ the Linux memory management.
>     idle_page_tracking
>     ksm
>     memory-hotplug
> +   memory-tiering
>     nommu-mmap
>     numa_memory_policy
>     numaperf
> diff --git a/Documentation/admin-guide/mm/memory-tiering.rst b/Documentation/admin-guide/mm/memory-tiering.rst
> new file mode 100644
> index 000000000000..142c36651f5d
> --- /dev/null
> +++ b/Documentation/admin-guide/mm/memory-tiering.rst
> @@ -0,0 +1,182 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +.. _admin_guide_memory_tiering:
> +
> +===========
> +Memory tiers
> +============
> +
> +This document describes explicit memory tiering support along with
> +demotion based on memory tiers.
> +
> +Introduction
> +============
> +
> +Many systems have multiple types of memory devices e.g. GPU, DRAM and
> +PMEM. The memory subsystem of these systems can be called a memory
> +tiering system because the performance of the different types of
> +memory is different. Memory tiers are defined based on the hardware
> +capabilities of memory nodes. Each memory tier is assigned a tier ID
> +value that determines the memory tier position in demotion order.
> +
> +The memory tier assignment of each node is independent of each
> +other. Moving a node from one tier to another tier doesn't affect
> +the tier assignment of any other node.
> +
> +Memory tiers are used to build the demotion targets for nodes. A node
> +can demote its pages to any node of any lower tiers.
> +
> +Memory tier rank
> +=================
> +
> +Memory nodes are divided into 3 types of memory tiers with tier ID
> +value as shown based on their hardware characteristics.
> +
> +
> +MEMORY_TIER_HBM_GPU
> +MEMORY_TIER_DRAM
> +MEMORY_TIER_PMEM
> +
> +Memory tiers initialization and (re)assignments
> +===============================================
> +
> +By default, all nodes are assigned to the memory tier with the default tier ID
> +DEFAULT_MEMORY_TIER which is 200 (MEMORY_TIER_DRAM). The memory tier of
> +the memory node can be either modified through sysfs or from the driver. On
> +hotplug, the memory tier with default tier ID is assigned to the memory node.
> +
> +
> +Sysfs interfaces
> +================
> +
> +Nodes belonging to specific tier can be read from,
> +/sys/devices/system/memtier/memtierN/nodelist (Read-Only)
> +
> +Where N is 0 - 2.
> +
> +Example 1:
> +For a system where Node 0 is CPU + DRAM nodes, Node 1 is HBM node,
> +node 2 is a PMEM node an ideal tier layout will be
> +
> +$ cat /sys/devices/system/memtier/memtier0/nodelist
> +1
> +$ cat /sys/devices/system/memtier/memtier1/nodelist
> +0
> +$ cat /sys/devices/system/memtier/memtier2/nodelist
> +2
> +
> +Example 2:
> +For a system where Node 0 & 1 are CPU + DRAM nodes, node 2 & 3 are PMEM
> +nodes.
> +
> +$ cat /sys/devices/system/memtier/memtier0/nodelist
> +cat: /sys/devices/system/memtier/memtier0/nodelist: No such file or
> +directory
> +$ cat /sys/devices/system/memtier/memtier1/nodelist
> +0-1
> +$ cat /sys/devices/system/memtier/memtier2/nodelist
> +2-3
> +
> +Default memory tier can be read from,
> +/sys/devices/system/memtier/default_tier (Read-Only)
> +
> +e.g.
> +$ cat /sys/devices/system/memtier/default_tier
> +memtier200
> +
> +Max memory tier ID supported can be read from,
> +/sys/devices/system/memtier/max_tier (Read-Only)
> +
> +e.g.
> +$ cat /sys/devices/system/memtier/max_tier
> +400
> +
> +Individual node's memory tier can be read of set using,
> +/sys/devices/system/node/nodeN/memtier (Read-Write)
> +
> +where N = node id
> +
> +When this interface is written, Node is moved from the old memory tier
> +to new memory tier and demotion targets for all N_MEMORY nodes are
> +built again.
> +
> +For example 1 mentioned above,
> +$ cat /sys/devices/system/node/node0/memtier
> +1
> +$ cat /sys/devices/system/node/node1/memtier
> +0
> +$ cat /sys/devices/system/node/node2/memtier
> +2
> +
> +Additional memory tiers can be created by writing a tier ID value to this file.
> +This results in a new memory tier creation and moving the specific NUMA node to
> +that memory tier.
> +
> +Demotion
> +========
> +
> +In a system with DRAM and persistent memory, once DRAM
> +fills up, reclaim will start and some of the DRAM contents will be
> +thrown out even if there is a space in persistent memory.
> +Consequently, allocations will, at some point, start falling over to the slower
> +persistent memory.
> +
> +That has two nasty properties. First, the newer allocations can end up in
> +the slower persistent memory. Second, reclaimed data in DRAM are just
> +discarded even if there are gobs of space in persistent memory that could
> +be used.
> +
> +Instead of a page being discarded during reclaim, it can be moved to
> +persistent memory. Allowing page migration during reclaim enables
> +these systems to migrate pages from fast(higher) tiers to slow(lower)
> +tiers when the fast(higher) tier is under pressure.
> +
> +
> +Enable/Disable demotion
> +-----------------------
> +
> +By default demotion is disabled, it can be enabled/disabled using
> +below sysfs interface,
> +
> +$ echo 0/1 or false/true > /sys/kernel/mm/numa/demotion_enabled
> +
> +preferred and allowed demotion nodes
> +------------------------------------
> +
> +Preferred nodes for a specific N_MEMORY node are the best nodes
> +from the next possible lower memory tier. Allowed nodes for any
> +node are all the nodes available in all possible lower memory
> +tiers.
> +
> +Example:
> +
> +For a system where Node 0 & 1 are CPU + DRAM nodes, node 2 & 3 are PMEM
> +nodes,
> +
> +node distances:
> +node   0    1    2    3
> +   0  10   20   30   40
> +   1  20   10   40   30
> +   2  30   40   10   40
> +   3  40   30   40   10
> +
> +memory_tiers[0] = <empty>
> +memory_tiers[1] = 0-1
> +memory_tiers[2] = 2-3
> +
> +node_demotion[0].preferred = 2
> +node_demotion[0].allowed   = 2, 3
> +node_demotion[1].preferred = 3
> +node_demotion[1].allowed   = 3, 2
> +node_demotion[2].preferred = <empty>
> +node_demotion[2].allowed   = <empty>
> +node_demotion[3].preferred = <empty>
> +node_demotion[3].allowed   = <empty>
> +
> +Memory allocation for demotion
> +------------------------------
> +
> +If a page needs to be demoted from any node, the kernel 1st tries
> +to allocate a new page from the node's preferred node and fallbacks to
> +node's allowed targets in allocation fallback order.
> +
> --
> 2.36.1
>
>
