Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 066644EA568
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 04:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbiC2Ctu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 22:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbiC2Cts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 22:49:48 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80641A1283
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 19:48:04 -0700 (PDT)
Received: from epcas3p1.samsung.com (unknown [182.195.41.19])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220329024802epoutp01fae3517dfe18e2cab3c9d13bf2edb6db~guhmmhQDC0821908219epoutp01H
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 02:48:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220329024802epoutp01fae3517dfe18e2cab3c9d13bf2edb6db~guhmmhQDC0821908219epoutp01H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1648522082;
        bh=1olVSWAEgR/VDjFbhzBg6IiLtOiXutP5xF9bpZypCY8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=V29Uku4VPuEy+h29pL+XscipYSGV+h2Hb39zsUSyZcpr253mdBt0SSH0Jzt2U9vn3
         AQzZoXgTMvngJORAHIc6DVSXScLQ/jTq6lG+acEd73OGOhzNjXK7glRBp61hdgZ/db
         0XhXwE0SoLnDtCnft0So7b/Vvww2Z1SEHW5lStDE=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas3p1.samsung.com (KnoxPortal) with ESMTP id
        20220329024802epcas3p1dfc1df6ab5ae4cacd249ee7454bfb182~guhl9sVTV1195811958epcas3p1N;
        Tue, 29 Mar 2022 02:48:02 +0000 (GMT)
Received: from epcpadp4 (unknown [182.195.40.18]) by epsnrtp2.localdomain
        (Postfix) with ESMTP id 4KSDWk1bNNz4x9Q7; Tue, 29 Mar 2022 02:48:02 +0000
        (GMT)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20220329024519epcas2p18206b61214fcf982708a82df57d0e26b~gufOqaPqk2937829378epcas2p1R;
        Tue, 29 Mar 2022 02:45:19 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220329024519epsmtrp213868e78e14146572244a7b1e3337346~gufOpg8-r0124001240epsmtrp2K;
        Tue, 29 Mar 2022 02:45:19 +0000 (GMT)
X-AuditID: b6c32a29-b05ff70000005f16-59-624272bfa9ba
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D5.21.24342.FB272426; Tue, 29 Mar 2022 11:45:19 +0900 (KST)
Received: from ubuntu (unknown [12.36.155.120]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220329024519epsmtip2e407ed617a9e57d75e9576ee5a09afbb~gufOeBXM12802128021epsmtip2X;
        Tue, 29 Mar 2022 02:45:19 +0000 (GMT)
Date:   Tue, 29 Mar 2022 11:43:51 +0900
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
Message-ID: <1983025922.01648522082197.JavaMail.epsvc@epcpadp4>
MIME-Version: 1.0
In-Reply-To: <382c4fae-95c5-af26-5d54-fa7ae7422b37@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplkeLIzCtJLcpLzFFi42LZdlhJXnd/kVOSwa+b2hYrDs9jtHh5SNNi
        88MrbBZPjixit2hevJ7N4vqf94wW7c8vsFmcP7+B3eLyrjlsFouWtTJbNG+awmoxc62yRdfd
        G4wOvB6X+3qZPBZsKvVYvOclk8emVZ1sHvvnrmH3aDm5n8Wjb8sqRo/Pm+QCOKK4bFJSczLL
        Uov07RK4Mk5M9yxYK1Rxd/NG1gbG9XxdjJwcEgImEh0r1rGC2EICuxklmheaQMQlJZbOvcEO
        YQtL3G85AlXziFHi3fw6EJtFQFXiT/MTNhCbTUBL4t6PE8wgtoiApsT1v9+B6rk4mAX2M0t8
        338WLCEs4CXx89k3sEG8AjoSa74+ZgYpEhK4xixxdNd6FoiEoMTJmU/AbGagqTf+vWTqYuQA
        sqUllv/jAAlzCthJLNnwmQ0kLCqgIvHqYP0ERsFZSJpnIWmehdC8gJF5FaNkakFxbnpusWGB
        YV5quV5xYm5xaV66XnJ+7iZGcExpae5g3L7qg94hRiYOxkOMEhzMSiK8smftk4R4UxIrq1KL
        8uOLSnNSiw8xSnOwKInzXug6GS8kkJ5YkpqdmlqQWgSTZeLglGpgWr8yt8LEd1N2mplMxvYZ
        /9c8lbp+JK/24fTMhbw/b1ceTOkvtfF7cfzy1l+1pWuLa/IPhNTtV8yt3XT+5LMp+SeOTowS
        +jPtVckSn/5ft3eW6p/Zs6B4f3J+fOmk8oSgPrbsEvm7hX/sotZt/eGlMfPafo6t78UL2h48
        6zh6RYTfoWiqld7PkzFfHnBv+n13LcfKJnMb1ptv734Oi+fbECW0JsXmxefw/ytm+10Lsrfn
        e/XK9sWdUz86J3D1fP/q/2jPTY6SZc/FrQr3ikrGGZ2KObr5toUSg4XWraI1qbclvt6wVus0
        Euu6t/PjgZ6goqm+v8Wr3xT3ndKuFZ6ZdGqDf3zB3znNTfxxvznff1ViKc5INNRiLipOBABk
        ebAfGAMAAA==
X-CMS-MailID: 20220329024519epcas2p18206b61214fcf982708a82df57d0e26b
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----5UEmwHbbA6AZTFHXI7vBSuA.tpbU4PvcG6ycPLnmUYkKA_Gh=_2773e_"
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
        <1295226194.41648172284403.JavaMail.epsvc@epcpadp4>
        <382c4fae-95c5-af26-5d54-fa7ae7422b37@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------5UEmwHbbA6AZTFHXI7vBSuA.tpbU4PvcG6ycPLnmUYkKA_Gh=_2773e_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Fri, Mar 25, 2022 at 12:36:20PM +0100, Krzysztof Kozlowski wrote:
> On 25/03/2022 02:28, Jung Daehwan wrote:
> > On Wed, Mar 23, 2022 at 10:41:23AM +0100, Krzysztof Kozlowski wrote:
> >> On 23/03/2022 03:58, Jung Daehwan wrote:
> >>> On Mon, Mar 07, 2022 at 10:59:06AM +0100, Krzysztof Kozlowski wrote:
> >>>> On 04/03/2022 07:23, Daehwan Jung wrote:
> >>>>> Export symbols for xhci hooks usage:
> >>>>> 	xhci_ring_free
> >>>>> 	- Allow xhci hook to free xhci_ring.
> >>>>
> >>>> Instead of copying-pasting the name of function, please explain why do
> >>>> you need these symbols exported.
> >>>>
> >>>> The "Why" is actually one of most important questions, because "what is
> >>>> this patch doing" we can easily see...
> >>>>
> >>>>>
> >>>>> 	xhci_get_slot_ctx
> >>>>> 	- Allow xhci hook to get slot_ctx from the xhci_container_ctx
> >>>>> 	  for getting the slot_ctx information to know which slot is
> >>>>> 	  offloading and compare the context in remote subsystem memory
> >>>>> 	  if needed.
> >>>>>
> >>>>
> >>>>
> >>>> Best regards,
> >>>> Krzysztof
> >>>>
> >>>
> >>> Hi Krzysztof
> >>>
> >>> xhci_ring_free has been removed from v3..
> >>> The reason why I want to export is for managing vendor specific ring.
> >>> I want to alloc and free vendor specific ring on specific address.
> >>> It's done with xhci hooks.
> >>
> >> It's better, but still does not explain why these have to be exported.
> >> Please mention where are these hooks going to be. Where are they
> >> implemented. I actually expect all of these exports to be used in your
> >> patchset.
> >>
> >> Best regards,
> >> Krzysztof
> >>
> > 
> > OK. How about adding call stack like below?
> > 
> > xhci_free_endpoint_ring -> xhci_vendor_free_transfer_ring(xhck hooks
> > ops) -> xhci_ring_free
> 
> What I would like to see is high level explanation, why do you need
> these functions exported. Such call trace does not answer this, because
> you do not need to export functions just to call the. You need to export
> them for modules, so this means that some modules (which - need names)
> will be using these functions. Three or four sentences are usually
> enough to explain it.
> 
> 
> Best regards,
> Krzysztof
> 

I got it. I'm going to modify it on next submission.

Best Regards,
Jung Daehwan

------5UEmwHbbA6AZTFHXI7vBSuA.tpbU4PvcG6ycPLnmUYkKA_Gh=_2773e_
Content-Type: text/plain; charset="utf-8"


------5UEmwHbbA6AZTFHXI7vBSuA.tpbU4PvcG6ycPLnmUYkKA_Gh=_2773e_--

