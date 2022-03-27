Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B59DF4E87F0
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 15:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235611AbiC0Nzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 09:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232854AbiC0Nzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 09:55:35 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E3D2AE26
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 06:53:55 -0700 (PDT)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220327135351epoutp01134de3b81ca22fbe055243e814bf7ee6~gQUWttBbt1492014920epoutp01z
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 13:53:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220327135351epoutp01134de3b81ca22fbe055243e814bf7ee6~gQUWttBbt1492014920epoutp01z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1648389231;
        bh=1nz+6cCIa6mz3t+BgJaQhVhLfhOC3PJmKjtzjfk4/so=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=c3MfDQHruH4VhPi2L9X5wDcGHqUStW9hsbgKHsq099xB1yGMC2RWcARs6FN7IDrJp
         UACf4Wbh55/EGB+cHAZNh4kfR71S7MvQfVlTvL6Gaerd3K2W8yrNPvC+C2KyIpGbER
         xNArR4XtrDSIHIahr87Qsn0PJBoVsZarMJaLQctY=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220327135349epcas1p244a7240021cc34203a2298f3dd55bd4e~gQUVfWV221250212502epcas1p2k;
        Sun, 27 Mar 2022 13:53:49 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.38.247]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4KRHNr32Bfz4x9Pp; Sun, 27 Mar
        2022 13:53:48 +0000 (GMT)
X-AuditID: b6c32a38-929ff700000255ac-af-62406c6c99a5
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        21.BF.21932.C6C60426; Sun, 27 Mar 2022 22:53:48 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH 0/8] memblock: introduce memsize showing reserved memory
Reply-To: jaewon31.kim@samsung.com
Sender: Jaewon Kim <jaewon31.kim@samsung.com>
From:   Jaewon Kim <jaewon31.kim@samsung.com>
To:     Mike Rapoport <rppt@kernel.org>,
        Jaewon Kim <jaewon31.kim@samsung.com>
CC:     "vbabka@suse.cz" <vbabka@suse.cz>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        YongTaek Lee <ytk.lee@samsung.com>,
        "jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <YkAU2JlcX7nlvbwp@kernel.org>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220327135347epcms1p13faf0f2b7d98d3b59b25e903678d9c48@epcms1p1>
Date:   Sun, 27 Mar 2022 22:53:47 +0900
X-CMS-MailID: 20220327135347epcms1p13faf0f2b7d98d3b59b25e903678d9c48
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKJsWRmVeSWpSXmKPExsWy7bCmgW5OjkOSQc8/YYs569ewWbw8pGnR
        vXkmo0Xv+1dMFpd3zWGzuLfmP6vFkfXbmSxmN/YxWjxez+3A6bFz1l12j02rOtk8Nn2axO5x
        YsZvFo++LasYPc4sOMLu8XmTXAB7VLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWF
        uZJCXmJuqq2Si0+ArltmDtBhSgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwCswK9
        4sTc4tK8dL281BIrQwMDI1OgwoTsjG8fvrEUnJOv+Pz3AWMD4xGJLkZODgkBE4kj11+xdTFy
        cQgJ7GCUWP9qF1MXIwcHr4CgxN8dwiA1wgI+Eu+bZrGD2EICShJnf1xhh4jrSjR1r2YBsdkE
        tCXeL5jECtIqIuAlceetB8hIZoGlTBIbbjQxQ+zilZjR/pQFwpaW2L58KyNIPaeAlkTfbl+I
        sKjEzdVv2WHs98fmM0LYIhKt985CjRGUePBzN1RcSuJc93GwiyUEIiRe7FGHCOdIvN85hxXC
        Npd4tqEFbCSvgK/EpEsvwVpZBFQl/s6cwQLR6iLxsz0YJMwsIC+x/e0cZpAws4CmxPpd+hBT
        FCV2/p7LCPNHw8bf7OhsZgE+iXdfe1hh4jvmPWGCsNUkWp59hYrLSPz994x1AqPSLEQoz0Ky
        eBbC4gWMzKsYxVILinPTU4sNC0zgEZucn7uJEZw+tSx2MM59+0HvECMTB+MhRgkOZiURXtmz
        9klCvCmJlVWpRfnxRaU5qcWHGE2BPp7ILCWanA9M4Hkl8YYmlgYmZkYmFsaWxmZK4ry9U08n
        CgmkJ5akZqemFqQWwfQxcXBKNTAZZ624esSsuD00o2lddF3M2oufrq2ZnC8qtUuo5c7qaUon
        6rj1WC2iA9pe/p6jbvMwiINP4Zd2zo4HVzObdgU42b5ZmL9qY0d25jKDzfWlwetyTqvNuJqj
        HPfOs+KvZkuJ+Fxno+b5fN37fJOVlpdPuWjPNbl8r4fjEQaD1BnP1jv67FwhWvD3+aS158S2
        /+ctXJsyV2XG7SWNs7zP/+//++2S35Kv4lbvjDVqxL9l113K7dmQoGNZrveW40jA8boND39G
        JEco7DRgiFgxteU452Ml17JrDeHl2x8HrvhX2P9BJ66+8MPi0MVrFtx87fS02vKcw8GtKlnr
        7b3e+q4JzRBkOB0pta5ryfWFEaeUWIozEg21mIuKEwGh5EDeKAQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220324065919epcas1p4c79da5f6ec4fa0311409ca24a38785d8
References: <YkAU2JlcX7nlvbwp@kernel.org> <Yj1zVkryTVoAnxsX@kernel.org>
        <20220324070158.22969-1-jaewon31.kim@samsung.com>
        <20220325083846epcms1p372559472ceb511cc45d39c110563063a@epcms1p3>
        <CGME20220324065919epcas1p4c79da5f6ec4fa0311409ca24a38785d8@epcms1p1>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> 
>--------- Original Message ---------
>Sender : Mike Rapoport <rppt@kernel.org>
>Date : 2022-03-27 16:40 (GMT+9)
>Title : Re: [PATCH 0/8] memblock: introduce memsize showing reserved memory
> 
>Hi,
> 
>On Fri, Mar 25, 2022 at 05:38:46PM +0900, Jaewon Kim wrote:
> 
>> >--------- Original Message ---------
>> >Sender : Mike Rapoport <rppt@kernel.org>
>> >Date : 2022-03-25 16:46 (GMT+9)
>> >Title : Re: [PATCH 0/8] memblock: introduce memsize showing reserved memory
>> > 
>> >Hi,
>> > 
>> >On Thu, Mar 24, 2022 at 04:01:50PM +0900, Jaewon Kim wrote:
>> >> Some of memory regions can be reserved for a specific purpose. They are
>> >> usually defined through reserved-memory in device tree. If only size
>> >> without address is specified in device tree, the address of the region
>> >> will be determined at boot time.
>> >> 
>> >> We may find the address of the memory regions through booting log, but
>> >> it does not show all. And it could be hard to catch the very beginning
>> >> log. The memblock_dump_all shows all memblock status but it does not
>> >> show region name and its information is difficult to summarize.
>> >> 
>> >> This patch introduce a debugfs node, memblock/memsize, to see reserved
>> >> memory easily.
>> >> 
>> >> Here's an example
>> >> 
>> >> $ cat debugfs/memblock/memsize
>> >> 0x0f9000000-0x0fb000000 0x02000000 (   32768 KB )   map reusable linux,cma
>> >> 0x0b1900000-0x0b1b00000 0x00200000 (    2048 KB ) nomap unusable test1
>> >> 0x0b0200000-0x0b0400000 0x00200000 (    2048 KB )   map unusable test2
>> >>  (snipped)
>> >> 
>> >> Reserved    :  746924 KB
>> >>  .kernel    :  137027 KB
>> >>   .text     :   28158 KB
>> >>   .rwdata   :    3238 KB
>> >>   .rodata   :   13468 KB
>> >>   .bss      :   12570 KB
>> >>   .etc      :   79593 KB
>> >>  .unusable  :  609897 KB
>> >> System      : 3447380 KB
>> >>  .common    : 3152468 KB
>> >>  .reusable  :  294912 KB
>> >> Total       : 4194304 KB (  4096.00 MB )
>> > 
>> >Most of this information information is already available at various
>> >places, like the existing memblock debugfs, /proc/iomem and DT sysfs.
>> > 
>> >I don't see why we need yet another debugfs file to expose it.
>> 
>> Hi.
>> Thank you for your reply.
>> 
>> I don't think existing memblock debugfs or /proc/iomem shows information I want.
>> They don't show name and actually allocated address and size. And it does not
>> handle pages freed to buddy allocator after boot.
>> 
>> And which DT sysfs do you mean? If it is /proc/device-tree/reserved-memory, it
>> shows name and size, but it does not show address for only size defined regions.
>> It does not recognize the freed pages, either.
>> 
>> Especially I'd like to create a node showing all reserved memory status, their 
>> total size is same as the physical memory size. This was very useful when I 
>> compare reserved memory and kernel init time memory between different chipsets,
>> or between different sw release versions.
> 
>I'm still not following. The reserved region sizes are available in the
>existing memblock debugfs.
>Why the names are important? What is the value of having names for *some*
>of the reserved regions?

Hi

There are many memory regions in memblock debugfs memory/reserved, and some might
be splited or merged with other region. Among regions in debugfs, we can't find 
the one we defined in device tree. Especially it is difficult to find the region we
described size only without start address.

On mobile environment, memory is used by not only CPU but also GPU, Camera, Secure
world, Audio, ETC. To support them, there are many reserved regions described in
device tree. So the name is quite important to recognize a region. And with thename
we can compare reserved memory map with other map.

Additionally as I said, we need one simple knob to look overall reservecd memory
status.

Thank you
Jaewon Kim

> 
>> Thank you
>> Jaewon Kim
> 
>-- 
>Sincerely yours,
>Mike.
> 
