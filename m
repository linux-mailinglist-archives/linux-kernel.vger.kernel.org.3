Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 061AC4E3699
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 03:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235362AbiCVC1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 22:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235297AbiCVC1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 22:27:17 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4098F3ED622
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 19:25:37 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220322021907epoutp0428d81f40d18cbcc0853a6ea9093c5537~eknWs7MH93276332763epoutp04d
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 02:19:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220322021907epoutp0428d81f40d18cbcc0853a6ea9093c5537~eknWs7MH93276332763epoutp04d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1647915547;
        bh=nGSRQy06lskincvbpgfI2D9wc05q1WJ8V6ti+BDrsEA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UpM6VyTyCvKG8pRkXFLisWKDRY/kHTwMyYYsiXSqtlgSKQpavgMzyQgUk6J3xvEEP
         3WaywVrG3BeMVEzh98HNp2tG2VEGslpcybVUfLaJHkEwROCjTT0GC6gPNeViCmJAlJ
         Dexo2Wh2oWFI20/qfj8b72HVpwVBe1VO8rOxnCtQ=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20220322021907epcas2p1e5887624c46dfe87ee32be90235291d7~eknWTbY6N0429904299epcas2p1G;
        Tue, 22 Mar 2022 02:19:07 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.100]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4KMwCW1Bdtz4x9QL; Tue, 22 Mar
        2022 02:19:03 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        B1.99.16040.41239326; Tue, 22 Mar 2022 11:19:00 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20220322021900epcas2p3c371eaa923e240f45ed627e067fd9899~eknPe6pas1315813158epcas2p3O;
        Tue, 22 Mar 2022 02:19:00 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220322021900epsmtrp1acfde2da721f6b61bfb80bf0f7afb9b2~eknPeJtBV2487424874epsmtrp1D;
        Tue, 22 Mar 2022 02:19:00 +0000 (GMT)
X-AuditID: b6c32a46-bffff70000023ea8-1c-623932147a4d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        94.F9.29871.31239326; Tue, 22 Mar 2022 11:18:59 +0900 (KST)
Received: from ubuntu (unknown [12.36.155.120]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220322021859epsmtip2bed7626382597c0b49ab1f7624725434~eknPUGjpi2692926929epsmtip2a;
        Tue, 22 Mar 2022 02:18:59 +0000 (GMT)
Date:   Tue, 22 Mar 2022 11:17:42 +0900
From:   Jung Daehwan <dh10.jung@samsung.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Howard Yen <howardyen@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        Puma Hsu <pumahsu@google.com>,
        "J . Avila" <elavila@google.com>, sc.suh@samsung.com
Subject: Re: [PATCH v3 0/4] support USB offload feature
Message-ID: <20220322021742.GB67215@ubuntu>
MIME-Version: 1.0
In-Reply-To: <YjhQg4I7eYWXIfgr@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMJsWRmVeSWpSXmKPExsWy7bCmha6IkWWSwbmn4hZPjixit2hevJ7N
        4vqf94wW7c8vsFlc3jWHzWLRslZmi+ZNU1gtZq5Vtui6e4PRgdPjcl8vk8eCTaUei/e8ZPLY
        P3cNu0ffllWMHp83yQWwRWXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXm
        ptoqufgE6Lpl5gDdpKRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMC/QK07MLS7N
        S9fLSy2xMjQwMDIFKkzIzrg9/QVTwRbZisa/D5kaGDeIdTFyckgImEgs3TWPvYuRi0NIYAej
        xO62W4wQzidGiS/TlrNBON8YJZY/nMwE0/J33zEWiMReRol/fYdZQBJCAk8YJTZfZwexWQRU
        JWbumMUIYrMJaEnc+3GCGcQWETCW6D87C2wfs8AGJokTd56DJYQFzCVmT+kDa+YV0JZY+GsZ
        G4QtKHFy5hOwBZwCmhITJs8AuoKDQ1RAReLVwXqQORICEzkkZt9tYYO4zkVixpdNUJcKS7w6
        voUdwpaSeNnfBmUXS+z61MoE0dzAKNH4AOI6CaDrZj1rZwRZwCyQKXH9kgKIKSGgLHHkFtgJ
        zAJ8Eh2H/7JDhHklOtqEIBqVJaZfnsAKYUtKHHx9Dmqgh8S05vnQ4N0G9O6LjcwTGOVnIfls
        FsKyWWAbdCQW7P7EBhGWllj+jwPC1JRYv0t/ASPrKkax1ILi3PTUYqMCI3hcJ+fnbmIEp1Yt
        tx2MU95+0DvEyMTBeIhRgoNZSYR38QfzJCHelMTKqtSi/Pii0pzU4kOMpsBomsgsJZqcD0zu
        eSXxhiaWBiZmZobmRqYG5krivF4pGxKFBNITS1KzU1MLUotg+pg4OKUamKS3G4p+lJr0drcu
        o/ubnBnqFe48aXO258U9P/Cr/7BkcXfkJc9Lpz63rbSbuN3d+7TLmwXc4Sph22WuOvc1V609
        IJ6jPqnuVsRWO8FLveWnlpZaSbwLT3nS5t02uWPlzKl/Iyq2vmRPzFYK2pokGmawdCfjEvOS
        Vp8NHzSWtW/R4beOKlI7tWLmw4ei7bxXDT56Zr18cWresi2dOyR7o+c3vUjyP3ia+1/oA8vU
        DycUe26IJ3/lmXTExDJLauu/jd3fm9Ti7yzzO/ppz/uvTRMMxdXOpyz13rF3K+vm7RN39hUf
        d8u8esZ5wfzQ0xM/q1+5Kvs1dpbtxTr1+su/Fq6zK/XbybaJ2fX3M45964KVWIozEg21mIuK
        EwFm0tGJNgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNLMWRmVeSWpSXmKPExsWy7bCSvK6wkWWSwaHzlhZPjixit2hevJ7N
        4vqf94wW7c8vsFlc3jWHzWLRslZmi+ZNU1gtZq5Vtui6e4PRgdPjcl8vk8eCTaUei/e8ZPLY
        P3cNu0ffllWMHp83yQWwRXHZpKTmZJalFunbJXBl9CzpZyr4KFWx69AqlgbGNpEuRk4OCQET
        ib/7jrF0MXJxCAnsZpTo6J7ICpGQlFg69wY7hC0scb/lCCtE0SNGidefbzCDJFgEVCVm7pjF
        CGKzCWhJ3PtxAiwuImAs0X92FjtIA7PAJiaJ2b/XgiWEBcwlZk/pA5vKK6AtsfDXMjaIqbuY
        JI72tLBAJAQlTs58AmYzA0298e8lUxcjB5AtLbH8HwdImFNAU2LC5BlgYVEBFYlXB+snMArO
        QtI8C0nzLITmBYzMqxglUwuKc9Nziw0LDPNSy/WKE3OLS/PS9ZLzczcxguNDS3MH4/ZVH/QO
        MTJxMB5ilOBgVhLhXfzBPEmINyWxsiq1KD++qDQntfgQozQHi5I474Wuk/FCAumJJanZqakF
        qUUwWSYOTqkGJgaTOQ+TnVjjvnIHTGo+/uFF94eMosf7lPvNvkWZR/ncncdezzRz8r4Op7Mr
        V5aveivBdHlauJLG3ulnj23e/eJ3WbyZ+TbJ7yrWP7OKrpeu6NXTbarg3e/X+7rujaVtrd7s
        qaoZv+8HLDA7seqGcZvjmQMTp39K3Ggx0W1Gfc0Ur0mKB/6sWXGxv9wo+Gbz82cZTZu+Pmtl
        n5YoHCNpMWHK0d7/T6OvWul8VFn98Uak8MR26cCWnTMWsO1p89rbs+yq65OXR27JMT/gqVcJ
        EFn0N3WZVrvv/+9z5pzIUlj0ZHnEjVRG7Yl1EXFH3T5etL0d++72cdtL0W07b5/6IhkhaHOk
        Itxnx2fuWsbGRHUlluKMREMt5qLiRAABHf8k/gIAAA==
X-CMS-MailID: 20220322021900epcas2p3c371eaa923e240f45ed627e067fd9899
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----_7s4r-glDYfHz5mV2FGmC11V_HCNsCeqJGxaGPxgMNZjUkbW=_22cd97_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220321090202epcas2p1bfa78db059c1f6f6acbbb015e4bf991c
References: <CGME20220321090202epcas2p1bfa78db059c1f6f6acbbb015e4bf991c@epcas2p1.samsung.com>
        <1647853194-62147-1-git-send-email-dh10.jung@samsung.com>
        <YjhB7+AaEXvuUmdi@kroah.com> <20220321092409.GA62265@ubuntu>
        <YjhGKVKuPsKG80wZ@kroah.com> <20220321100631.GB62265@ubuntu>
        <YjhQg4I7eYWXIfgr@kroah.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------_7s4r-glDYfHz5mV2FGmC11V_HCNsCeqJGxaGPxgMNZjUkbW=_22cd97_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Mon, Mar 21, 2022 at 11:16:35AM +0100, Greg Kroah-Hartman wrote:
> On Mon, Mar 21, 2022 at 07:06:31PM +0900, Jung Daehwan wrote:
> > On Mon, Mar 21, 2022 at 10:32:25AM +0100, Greg Kroah-Hartman wrote:
> > > On Mon, Mar 21, 2022 at 06:24:09PM +0900, Jung Daehwan wrote:
> > > > On Mon, Mar 21, 2022 at 10:14:23AM +0100, Greg Kroah-Hartman wrote:
> > > > > On Mon, Mar 21, 2022 at 05:59:50PM +0900, Daehwan Jung wrote:
> > > > > > This patchset is for USB offload feature, which makes Co-processor to use
> > > > > > some memories of xhci. Especially it's useful for USB Audio scenario.
> > > > > > Audio stream would get shortcut because Co-processor directly write/read
> > > > > > data in xhci memories. It could get speed-up using faster memory like SRAM.
> > > > > > That's why this gives vendors flexibilty of memory management.
> > > > > > Several pathches have been merged in AOSP kernel(android12-5.10) and I put
> > > > > > together and split into 3 patches. Plus let me add user(xhci-exynos)
> > > > > > module to see how user could use it.
> > > > > > 
> > > > > > To sum up, it's for providing xhci memories to Co-Processor.
> > > > > > It would cover DCBAA, Device Context, Transfer Ring, Event Ring, ERST.
> > > > > > It needs xhci hooks and to export some xhci symbols.
> > > > > > 
> > > > > > Changes in v2 :
> > > > > > - Fix commit message by adding Signed-off-by in each patch.
> > > > > > - Fix conflict on latest.
> > > > > > 
> > > > > > Changes in v3 :
> > > > > > - Remove export symbols and xhci hooks which xhci-exynos don't need.
> > > > > > - Modify commit message to clarify why it needs to export symbols.
> > > > > > - Check compiling of xhci-exynos.
> > > > > 
> > > > > As I asked for in the previous submission, you MUST have a user for
> > > > > these hooks, otherwise we can not accept them (nor would you WANT us to
> > > > > accept them).  Please fix that up and add them to the next submission as
> > > > > we can not do anything with this one.
> > > > > 
> > > > > thanks,
> > > > > 
> > > > > greg k-h
> > > > > 
> > > > 
> > > > Hi greg,
> > > > 
> > > > I've submitted the user(xhci-exynos) together on the last patch of the patchset.
> > > > You can see xhci-exynos uses these hooks and symbols.
> > > > 
> > > > [PATCH v3 4/4] usb: host: add xhci-exynos driver
> > > 
> > > Then this is not "offload" hooks at all.  They are merely "support
> > > another xhci platform driver, right?
> > 
> > Yes, right.
> > 
> > > 
> > > I see a lot of exports and function hooks added, are they _ALL_ used by
> > > the xhci driver?  If so, please reword this series as it is not very
> > > obvious at all what you are doing.
> > 
> > Yes, they are all used by the xhci driver. Is it OK for me to use "xhci-exynos"
> > instead of "USB offload" on series like below?
> > 
> > [v3, 0/4] add xhci-exynos driver
> > 
> > This patchset is for support xhci-exynos driver....
> > ....
> > 
> >   usb: host: export symbols for xhci-exynos to use xhci hooks
> >   usb: host: add xhci hooks for xhci-exynos
> >   usb: host: add some to xhci overrides for xhci-exynos
> >   usb: host: add xhci-exynos driver
> 
> Yes, that makes much more sense.  What would you want to see if you had
> to review such a series?
> 
> thanks,
> 
> greg k-h
> 

Thanks for your comment. I'm going to modify it on next submission.

Best Regards,
Jung Daehwan

------_7s4r-glDYfHz5mV2FGmC11V_HCNsCeqJGxaGPxgMNZjUkbW=_22cd97_
Content-Type: text/plain; charset="utf-8"


------_7s4r-glDYfHz5mV2FGmC11V_HCNsCeqJGxaGPxgMNZjUkbW=_22cd97_--
