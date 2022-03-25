Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 820F64E6C27
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 02:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357600AbiCYBm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 21:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357626AbiCYBkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 21:40:47 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B62F186F1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 18:38:09 -0700 (PDT)
Received: from epcas3p4.samsung.com (unknown [182.195.41.22])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220325013805epoutp01682c680b3821a8c0809fc764208eb935~fe-X9LKbA2166121661epoutp01Y
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 01:38:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220325013805epoutp01682c680b3821a8c0809fc764208eb935~fe-X9LKbA2166121661epoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1648172285;
        bh=910WxcN8pBjdeRXjmpQWK3JOe9qPQxcY642mK+q7DDg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=I9y88AxHcgOhguIXPk/sjuuE8ESJryzRvLJ2doMA0xuSZJsIhNLGSOPhH5F0z1dI7
         I85+C3vbjsotP6OdcQK+lvanqiFNNnOPY8JVvEJM42m28GJu6s4kS4zWLWOXTGtWHM
         JpRgZyz1njIWZekTCc80b+TyPhkQAtTIFmwGnToU=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas3p3.samsung.com (KnoxPortal) with ESMTP id
        20220325013804epcas3p3a71753f89954a903d90d78546b6f1b3e~fe-XX2n8p2534725347epcas3p3J;
        Fri, 25 Mar 2022 01:38:04 +0000 (GMT)
Received: from epcpadp4 (unknown [182.195.40.18]) by epsnrtp2.localdomain
        (Postfix) with ESMTP id 4KPl8r2zRwz4x9QK; Fri, 25 Mar 2022 01:38:04 +0000
        (GMT)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20220325012959epcas2p45d91d20dff6adc0f17dc4305d9e14130~fe4UH5A4L0307203072epcas2p4s;
        Fri, 25 Mar 2022 01:29:59 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220325012959epsmtrp28f6457e9afc0f6d15fc66bf7f2aa3684~fe4UG4etZ0434104341epsmtrp23;
        Fri, 25 Mar 2022 01:29:59 +0000 (GMT)
X-AuditID: b6c32a29-41fff700000074af-d7-623d1b1709f0
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A4.BA.29871.71B1D326; Fri, 25 Mar 2022 10:29:59 +0900 (KST)
Received: from ubuntu (unknown [12.36.155.120]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220325012959epsmtip144d1117d67e9abd83c5da9cceb5cf0b5~fe4T41NUs0578005780epsmtip1o;
        Fri, 25 Mar 2022 01:29:59 +0000 (GMT)
Date:   Fri, 25 Mar 2022 10:28:36 +0900
From:   Jung Daehwan <dh10.jung@samsung.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Howard Yen <howardyen@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        Puma Hsu <pumahsu@google.com>,
        "J . Avila" <elavila@google.com>,
        "chihhao . chen" <chihhao.chen@mediatek.com>, sc.suh@samsung.com,
        cpgs@samsung.com, cpgsproxy5@samsung.com
Subject: Re: [PATCH v1 1/4] usb: host: export symbols for xhci hooks usage
Message-ID: <1295226194.41648172284403.JavaMail.epsvc@epcpadp4>
MIME-Version: 1.0
In-Reply-To: <105eaeec-d77e-b0eb-86ad-a88c7446ca98@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgkeLIzCtJLcpLzFFi42LZdlhJTldc2jbJ4MVzA4sVh+cxWrw8pGmx
        +eEVNosnRxaxWzQvXs9mcf3Pe0aL9ucX2CzOn9/AbnF51xw2i0XLWpktmjdNYbWYuVbZouvu
        DUYHXo/Lfb1MHgs2lXos3vOSyWPTqk42j/1z17B7tJzcz+LRt2UVo8fnTXIBHFFcNimpOZll
        qUX6dglcGae2PWMsuM9TseneKbYGxu+cXYycHBICJhJXey+wdDFycQgJ7GaUaHtwjgUiISmx
        dO4NdghbWOJ+yxFWiKJHjBLXNk5iAkmwCKhK9Cz7xwxiswloSdz7cQLMFhHQlLj+9ztYA7PA
        fmaJ7/vPgiWEBbwkfj77xgpi8wI1nF92iBFi6hsmid8tx1kgEoISJ2c+AbOZgYpu/HsJtI0D
        yJaWWP6PAyTMKWAnsbljE1hYVEBF4tXB+gmMgrOQNM9C0jwLoXkBI/MqRsnUguLc9NxiwwLD
        vNRyveLE3OLSvHS95PzcTYzgyNLS3MG4fdUHvUOMTByMhxglOJiVRHjvX7ZOEuJNSaysSi3K
        jy8qzUktPsQozcGiJM57oetkvJBAemJJanZqakFqEUyWiYNTqoFp2sacAL1lJQ2BZownvp4M
        vxcYVdb1tHIDv/LGuO17+gqtbmVpGTGYSKr6qDvNEL/VVbU6bepe/WulL9TWeS/6qsjSFdYY
        kphxvV9D1C/Jv2XG2QtZFhuPy2lssms5IfV327SD3TeVDubon7mgLnaG5eBRx/PHdl1z6Pl3
        Rjbm/euqCdEZNRdc136Ti/Fi124ODfNbZnFCrUH4BafJGsH19fN1TvzoW2thEeE1+Yrqx0Mf
        Mj1vMUz9Ebvz4Z3M5Ap7qVy3WVEfJz2a/WW2mI1E/1qjT5fji/MWpP5d3pdxbmXw09UL3k/i
        t6/7YdXHpW24yN1faEd5ihqf1cvf2TVmz7f8aM2oD0vRNF73JlKJpTgj0VCLuag4EQBxtVcf
        GwMAAA==
X-CMS-MailID: 20220325012959epcas2p45d91d20dff6adc0f17dc4305d9e14130
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----FxW1adctUC2Ba58hBscSmKlxeMgdXQkzmfCwtO.kn3Xz82SJ=_5685_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20220304062617epcas2p2084161966aaa66d07f4c25720ec18088
References: <1646375038-72082-1-git-send-email-dh10.jung@samsung.com>
        <CGME20220304062617epcas2p2084161966aaa66d07f4c25720ec18088@epcas2p2.samsung.com>
        <252651381.41646375583002.JavaMail.epsvc@epcpadp4>
        <b33d8497-d6d5-18e2-93a9-e0564a84c1c5@kernel.org>
        <1983025922.01648006681661.JavaMail.epsvc@epcpadp4>
        <105eaeec-d77e-b0eb-86ad-a88c7446ca98@kernel.org>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------FxW1adctUC2Ba58hBscSmKlxeMgdXQkzmfCwtO.kn3Xz82SJ=_5685_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Wed, Mar 23, 2022 at 10:41:23AM +0100, Krzysztof Kozlowski wrote:
> On 23/03/2022 03:58, Jung Daehwan wrote:
> > On Mon, Mar 07, 2022 at 10:59:06AM +0100, Krzysztof Kozlowski wrote:
> >> On 04/03/2022 07:23, Daehwan Jung wrote:
> >>> Export symbols for xhci hooks usage:
> >>> 	xhci_ring_free
> >>> 	- Allow xhci hook to free xhci_ring.
> >>
> >> Instead of copying-pasting the name of function, please explain why do
> >> you need these symbols exported.
> >>
> >> The "Why" is actually one of most important questions, because "what is
> >> this patch doing" we can easily see...
> >>
> >>>
> >>> 	xhci_get_slot_ctx
> >>> 	- Allow xhci hook to get slot_ctx from the xhci_container_ctx
> >>> 	  for getting the slot_ctx information to know which slot is
> >>> 	  offloading and compare the context in remote subsystem memory
> >>> 	  if needed.
> >>>
> >>
> >>
> >> Best regards,
> >> Krzysztof
> >>
> > 
> > Hi Krzysztof
> > 
> > xhci_ring_free has been removed from v3..
> > The reason why I want to export is for managing vendor specific ring.
> > I want to alloc and free vendor specific ring on specific address.
> > It's done with xhci hooks.
> 
> It's better, but still does not explain why these have to be exported.
> Please mention where are these hooks going to be. Where are they
> implemented. I actually expect all of these exports to be used in your
> patchset.
> 
> Best regards,
> Krzysztof
> 

OK. How about adding call stack like below?

xhci_free_endpoint_ring -> xhci_vendor_free_transfer_ring(xhck hooks
ops) -> xhci_ring_free

Best Regards,
Jung Daehwan

------FxW1adctUC2Ba58hBscSmKlxeMgdXQkzmfCwtO.kn3Xz82SJ=_5685_
Content-Type: text/plain; charset="utf-8"


------FxW1adctUC2Ba58hBscSmKlxeMgdXQkzmfCwtO.kn3Xz82SJ=_5685_--

