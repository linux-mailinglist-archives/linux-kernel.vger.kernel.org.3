Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542934E4A75
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 02:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241114AbiCWBZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 21:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241099AbiCWBZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 21:25:43 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABF96E8F8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 18:24:13 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220323012410epoutp01010157f5e9c7d5020be477117bd4e4e7~e3gp-HmdG0688806888epoutp01D
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 01:24:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220323012410epoutp01010157f5e9c7d5020be477117bd4e4e7~e3gp-HmdG0688806888epoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1647998650;
        bh=Nepy2ucUg+KNeyoZidOAwwyQCXcwYzlhGse/w2oxHTw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bfufqdgP5224x5acRk4h5zzldZJb/Tm6FmD37TQ9iXdg4U7w92EqoREpkIqYMuYcM
         msRtSQ837DNFgyd+8xXM3rLaoQ0s1QVjNPTKOOxGKfYet6v7yVOZypzzP5k7imAlsu
         bFZdzpDTUFAc95utmdg9H0GFpoHYMu/UzU/9+Td4=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20220323012409epcas2p41415f9736375ab226336f4ff00d44be5~e3gpe6DcF1166811668epcas2p4S;
        Wed, 23 Mar 2022 01:24:09 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.90]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4KNVxf4VlZz4x9QQ; Wed, 23 Mar
        2022 01:24:06 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        90.79.10444.6B67A326; Wed, 23 Mar 2022 10:24:06 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20220323012405epcas2p3cceab92a099b54b3bc76bcdc6a836f1b~e3gl2AWFr0885308853epcas2p3J;
        Wed, 23 Mar 2022 01:24:05 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220323012405epsmtrp2d5114c989ca2a5ca1032d1dc0315d824~e3gl0oofl2037920379epsmtrp2j;
        Wed, 23 Mar 2022 01:24:05 +0000 (GMT)
X-AuditID: b6c32a45-513ff700000228cc-e4-623a76b63dde
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0C.B0.29871.5B67A326; Wed, 23 Mar 2022 10:24:05 +0900 (KST)
Received: from ubuntu (unknown [12.36.155.120]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220323012405epsmtip2fb66f59c9f028ac40f3ede46b11258ec~e3glnSi_K0261502615epsmtip2B;
        Wed, 23 Mar 2022 01:24:05 +0000 (GMT)
Date:   Wed, 23 Mar 2022 10:22:42 +0900
From:   Jung Daehwan <dh10.jung@samsung.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Howard Yen <howardyen@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        Puma Hsu <pumahsu@google.com>,
        "J . Avila" <elavila@google.com>, sc.suh@samsung.com
Subject: Re: [PATCH v3 1/4] usb: host: export symbols for xhci hooks usage
Message-ID: <20220323012242.GA19041@ubuntu>
MIME-Version: 1.0
In-Reply-To: <3c345ba1-8339-e8c2-8d14-b75d1264bb4d@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJJsWRmVeSWpSXmKPExsWy7bCmue62Mqskg5nvRSyeHFnEbtG8eD2b
        xfU/7xkt2p9fYLM4f34Du8XlXXPYLBYta2W2aN40hdVi5lpli667NxgduDwu9/UyeSzYVOqx
        eM9LJo9NqzrZPPbPXcPu0bdlFaPH501yAexR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYG
        hrqGlhbmSgp5ibmptkouPgG6bpk5QNcpKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtS
        cgrMC/SKE3OLS/PS9fJSS6wMDQyMTIEKE7Iz7r1OKDghVLH79wbmBsaVfF2MnBwSAiYSF7o+
        MXcxcnEICexglOh4uosRwvnEKHFq/idWCOcbo8SCbZsZYVpaV61mBrGFBPYySky9mglhP2GU
        +LyqHsRmEVCVWDXjABOIzSagJXHvxwmwehEBTYnrf7+DDWUWeMwk0fJuOjtIQljAS2LR3lVg
        Nq+AtsT6w22MELagxMmZT1hAbE4BO4n2/01ANRwcogIqEq8O1oPMkRCYyyGx/d5bRpC4hICL
        xN6PMhB3Cku8Or6FHcKWkvj8bi8bhF0ssetTKxNEbwOjROMDiOMkBIwlZj1rB5vDLJAp8WWC
        McRIZYkjt8AuYBbgk+g4/JcdIswr0dEmBNGoLDH98gRWCFtS4uDrc1ADPSSW3O1ggoROJ5PE
        2t38ExjlZyH5axbCrllgC3QkFuz+xAYRlpZY/o8DwtSUWL9LfwEj6ypGsdSC4tz01GKjAkN4
        PCfn525iBKdZLdcdjJPfftA7xMjEwXiIUYKDWUmEd/EH8yQh3pTEyqrUovz4otKc1OJDjKbA
        SJrILCWanA9M9Hkl8YYmlgYmZmaG5kamBuZK4rxeKRsShQTSE0tSs1NTC1KLYPqYODilGpgc
        p4dMnP7gMecho9XTmyYefJ56embXvLqT9eKvLNb0Heq8xakR2lnNHNim0PTk6QbtD/YCPtOZ
        OjWalGYH6MyPS9Yoahe9s8s5RHeXl6+U2GoekfOvV59U+dRrZhu2d/beWTVWxfI8V4KMrVke
        9N46VcRzr3jKpzc9Hwx+fppyythj4XcV7nkvVr9q5q48tJu5LSCCxYrD0zLoUKmtaLmkkGHd
        W5MtTc88bnAuVVc9x+J+X/vesrPn51Z7bRVYzm+2Tjn21OVprRPSY7s4BeZEn1L/LZf/Tu1x
        WbCdd+dp6WPuL9hZ2F/xzZf89zDlatQ5ljVHr2iyuoXE/IiTdywKnH6QTWJRvyvDAe+DDUos
        xRmJhlrMRcWJABnqypg8BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKLMWRmVeSWpSXmKPExsWy7bCSvO7WMqskg79XdC2eHFnEbtG8eD2b
        xfU/7xkt2p9fYLM4f34Du8XlXXPYLBYta2W2aN40hdVi5lpli667NxgduDwu9/UyeSzYVOqx
        eM9LJo9NqzrZPPbPXcPu0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBnHj39gKWgVqNh6aAJj
        A+N/7i5GTg4JAROJ1lWrmbsYuTiEBHYzSsydsJkdIiEpsXTuDShbWOJ+yxFWiKJHjBLzeyax
        giRYBFQlVs04wARiswloSdz7cYIZxBYR0JS4/vc7WAOzwFMmicUb28CKhAW8JBbtXQU2lVdA
        W2L94TZGiKmdTBK3p+xkhkgISpyc+YQFxGYGmnrj30ugZg4gW1pi+T8OkDCngJ1E+/8mdpCw
        qICKxKuD9RMYBWchaZ6FpHkWQvMCRuZVjJKpBcW56bnFhgWGeanlesWJucWleel6yfm5mxjB
        MaOluYNx+6oPeocYmTgYDzFKcDArifAu/mCeJMSbklhZlVqUH19UmpNafIhRmoNFSZz3QtfJ
        eCGB9MSS1OzU1ILUIpgsEwenVAPTft8H5gvyC3mfmJ3Oe3Umc/+xDkeT1d5pbxrlQvS0ulc2
        9YtsNC9qcHeeu3NNjQYb74O73V+risKj/gcJCuV2xCu/mxhw6W/5+obdk1dYf7OM6qpRWVS6
        TnnbrQfrp+n/aIllPnlstvnyuZZXFDq+v875khKY5upya636J9vVtaFfEkqexrpG3DO1vTXP
        8bb0i+X+P3Yp3io6H7H781Xny19S3j966ZzQpDvvQZ/sCvOWl4nd83e9eLDtaETuoiNuMUaV
        U3ReMAQ+qe9TEr/vr3nwkevO0MkzbHZt/qd4/uRPvgAm1hOru76bOj20vNt/+kKaXOdZad0j
        mxm7E58ziS17fl4pT+lEgmfQp94oJZbijERDLeai4kQAE1bc3QgDAAA=
X-CMS-MailID: 20220323012405epcas2p3cceab92a099b54b3bc76bcdc6a836f1b
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----.rW42XXn7_Ji6OxwuAF4RAMbP.qed.OeqKlvEhSLhB3noATS=_237b5b_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220321090204epcas2p31e39a4b8b6fc803ceecac5d19e6e39e9
References: <1647853194-62147-1-git-send-email-dh10.jung@samsung.com>
        <CGME20220321090204epcas2p31e39a4b8b6fc803ceecac5d19e6e39e9@epcas2p3.samsung.com>
        <1647853194-62147-2-git-send-email-dh10.jung@samsung.com>
        <3c345ba1-8339-e8c2-8d14-b75d1264bb4d@kernel.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------.rW42XXn7_Ji6OxwuAF4RAMbP.qed.OeqKlvEhSLhB3noATS=_237b5b_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Tue, Mar 22, 2022 at 06:12:58PM +0100, Krzysztof Kozlowski wrote:
> On 21/03/2022 09:59, Daehwan Jung wrote:
> > Export symbols for xhci hooks usage:
> >     xhci_get_slot_ctx
> >     xhci_get_endpoint_address
> >     - Allow xhci hook to get ep_ctx from the xhci_container_ctx for
> >       getting the ep_ctx information to know which ep is offloading and
> >       comparing the context in remote subsystem memory if needed.
> > 
> >     xhci_ring_alloc
> >     - Allow xhci hook to allocate vendor specific ring.
> > 
> >     xhci_trb_virt_to_dma
> >     - Used to retrieve the DMA address of vendor specific ring.
> > 
> >     xhci_segment_free
> >     xhci_link_segments
> >     - Allow xhci hook to handle vendor specific segment.
> > 
> >     xhci_initialize_ring_info
> >     - Allow xhci hook to initialize vendor specific ring.
> > 
> >     xhci_check_trb_in_td_math
> >     - Allow xhci hook to Check TRB math for validation.
> > 
> >     xhci_address_device
> >     - Allow override to give configuration info to Co-processor.
> > 
> >     xhci_bus_suspend
> >     xhci_bus_resume
> >     - Allow override of suspend and resume for power scenario.
> > 
> >     xhci_remove_stream_mapping
> >     - Allow xhci hook to remove stream mapping.
> > 
> 
> NAK, because you ignored my comments from previous submission. It seems
> you prefer to silently skip answering to them, not CC me and then hope I
> will not remember what I asked for.
> 
> I am sorry, but that is not how it works. This is not how Linux kernel
> is developed. Please answer my questions. If they are unclear, ask for
> explanation. Ignoring all my questions/comments and resending without CC
> is a NAK.
> 
> 
> Best regards,
> Krzysztof
> 

Hi Krzysztof

I didn't ignore your comments but focused on your comment to
be in-tree user on previous submission. I've modified my driver to be compiled
as you asked and submitted it.

I'm sorry I missed other comments. I will check them.

Best Regards,
Jung Daehwan

------.rW42XXn7_Ji6OxwuAF4RAMbP.qed.OeqKlvEhSLhB3noATS=_237b5b_
Content-Type: text/plain; charset="utf-8"


------.rW42XXn7_Ji6OxwuAF4RAMbP.qed.OeqKlvEhSLhB3noATS=_237b5b_--
