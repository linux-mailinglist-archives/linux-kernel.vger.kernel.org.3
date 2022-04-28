Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC26C512A03
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 05:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242329AbiD1Dfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 23:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242396AbiD1DfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 23:35:19 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600A79A986
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 20:31:56 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220428033154epoutp029695d5698a5248d5dfaa8bd6b373ba66~p8edLJ05w2722727227epoutp02c
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 03:31:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220428033154epoutp029695d5698a5248d5dfaa8bd6b373ba66~p8edLJ05w2722727227epoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651116714;
        bh=yW8CHbr/rcY8rtM8g2wfKNGos7IWO4oYlOGRfL453RY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DsvcMFoDj6EJ4tNPXBOmOh25NKmBABdZ3XqIo7fU95VdtXhIAq9RMEKKoNNk7e8Wg
         eFP/JZC/nyLbwuN/DAQETKjyeYMuIg5aePSCBjmFM61xOwkcaCX6n/79pwmz9CLlIV
         Aw9ggavrxPQbC9lJoyYvCdiqPax2YcKC2u9zxBDw=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20220428033153epcas2p3e85a6cb642ec074b3a4edb3161421d5a~p8ecdk4_G0281402814epcas2p3f;
        Thu, 28 Apr 2022 03:31:53 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.69]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Kph4Q23Wbz4x9QD; Thu, 28 Apr
        2022 03:31:50 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        B8.3C.10069.6AA0A626; Thu, 28 Apr 2022 12:31:50 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20220428033149epcas2p239a3afa7cd987de5aaabc9cdc5f0267b~p8eY5SIUA0242802428epcas2p2K;
        Thu, 28 Apr 2022 03:31:49 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220428033149epsmtrp13722a0004b92c3c4cae55b7e7e58ab69~p8eY35lLv2309623096epsmtrp19;
        Thu, 28 Apr 2022 03:31:49 +0000 (GMT)
X-AuditID: b6c32a45-a79ff70000002755-a3-626a0aa63733
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        3C.B2.08924.5AA0A626; Thu, 28 Apr 2022 12:31:49 +0900 (KST)
Received: from ubuntu (unknown [10.229.95.128]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220428033149epsmtip14340a819eeabbbc93135ace5688d0d7f~p8eYqdpMs2408224082epsmtip1B;
        Thu, 28 Apr 2022 03:31:49 +0000 (GMT)
Date:   Thu, 28 Apr 2022 12:30:20 +0900
From:   Jung Daehwan <dh10.jung@samsung.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Howard Yen <howardyen@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        Puma Hsu <pumahsu@google.com>,
        "J . Avila" <elavila@google.com>, sc.suh@samsung.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH v4 1/5] usb: host: export symbols for xhci-exynos to use
 xhci hooks
Message-ID: <20220428033020.GD151827@ubuntu>
MIME-Version: 1.0
In-Reply-To: <Ymg8h6TiH4RpL93t@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDJsWRmVeSWpSXmKPExsWy7bCmqe4yrqwkgznneSyeHFnEbtG8eD2b
        xfU/7xkt2p9fYLPY+PYHk8XlXXPYLBYta2W2aN40hdVi5lpli667NxgduDxmNfSyeVzu62Xy
        WLCp1GPxnpdMHvvnrmH36NuyitHj8ya5APaobJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMD
        Q11DSwtzJYW8xNxUWyUXnwBdt8wcoOuUFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnFJbZKqQUp
        OQXmBXrFibnFpXnpenmpJVaGBgZGpkCFCdkZuxf1sRR8k6ro2/6DvYFxnUgXIyeHhICJxK8v
        M5m7GLk4hAR2MEqcm9bHBOF8YpQ4uXweI0iVkMBnRom+J9owHRse9jBCFO1ilNj/+xoLhPOE
        UWLehiUsIFUsAqoStx/dZwWx2QS0JO79OMEMYosIGEv0n53FDtLALPCSSaL91gQgh4NDWCBS
        YkO/BUgNr4COxO5r11ggbEGJkzOfgNmcApoShzoesIGUiwqoSLw6WA8yRkJgIYfEzKuHmUHi
        EgIuErtnS0IcKizx6vgWdghbSuJlfxuUXSyx61MrE0RvA6NE4wOI2ySAbpv1rB3sY2aBDInv
        l7+xQsxUljhyiwUizCfRcfgvO0SYV6KjTQiiU1li+uUJrBC2pMTB1+egrvGQ2DZDEBI6l5kk
        nn36wTyBUX4WksdmIVkGYetILNj9iW0WUDuzgLTE8n8cEKamxPpd+gsYWVcxiqUWFOempxYb
        FRjCozo5P3cTIzjZarnuYJz89oPeIUYmDsZDjBIczEoivF92ZyQJ8aYkVlalFuXHF5XmpBYf
        YjQFxtJEZinR5Hxgus8riTc0sTQwMTMzNDcyNTBXEuf1StmQKCSQnliSmp2aWpBaBNPHxMEp
        1cBUa9vK2lnmoJtb+tlnhYzpisddK+oaEgpepkh9T+PetVDMsjlN46ig3rr/3xlMHOU52mom
        348OmhL83+rQ95oCNqMPYVk3FrW0qXlE/01nD5673viSoKulxuTUddEBRUqRHiZcZZziZU9+
        pbCGNe8OrXzh4KT7unOmbvfjecwuClFLHJl4mbY4LuAPT/O9YPyeLbouL80vocVq4u2tK62d
        Y/343iVmzNwgk/Q/JmSG1RL5cxJlU3nfOnHnsLWmfXR6fd/v/rn4c7zcC8sf/j54z4hvqtvf
        pFnf+W8xbtfOt07zul0inbku3COmw/w5+/0LLw9EXJxfwrmO5cfC409q/j0Krq9PlRE5uHG2
        EktxRqKhFnNRcSIAdgfiDz8EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMLMWRmVeSWpSXmKPExsWy7bCSnO5SrqwkgyfbxC2eHFnEbtG8eD2b
        xfU/7xkt2p9fYLPY+PYHk8XlXXPYLBYta2W2aN40hdVi5lpli667NxgduDxmNfSyeVzu62Xy
        WLCp1GPxnpdMHvvnrmH36NuyitHj8ya5APYoLpuU1JzMstQifbsEroyp6z6wFGyTqJi2fy17
        A2O7UBcjJ4eEgInEhoc9jCC2kMAORonTDUYQcUmJpXNvsEPYwhL3W46wdjFyAdU8YpR40LGb
        DSTBIqAqcfvRfVYQm01AS+LejxPMILaIgLFE/9lZ7CANzAJvmSQ2TfnA1MXIwSEsECmxod8C
        pIZXQEdi97VrLBBDrzNJ3GxcxwyREJQ4OfMJC4jNDDT0xr+XYL3MAtISy/9xgIQ5BTQlDnU8
        YAMJiwqoSLw6WD+BUXAWkuZZSJpnITQvYGRexSiZWlCcm55bbFhglJdarlecmFtcmpeul5yf
        u4kRHC9aWjsY96z6oHeIkYmD8RCjBAezkgjvl90ZSUK8KYmVValF+fFFpTmpxYcYpTlYlMR5
        L3SdjBcSSE8sSc1OTS1ILYLJMnFwSjUwle+u3SS9fsO6ricajcou712kC/YevbwieobKsccm
        +Qs5pvAWvb95sJrby3Hj/GnCW5ZNO8wR/aU5cFvOch4zxc4eiRRhb4/cWeqan6f7Z5/h51/w
        dPZi4zyLaS9dA89nz5LmFuD9GZSkfCSzP2jK2g6BW6vEvU5duTfvV2LlIZ5Ov03XjE9wzFzu
        7LbAy3DKoTs20+Wz+Z5/fM28vDd7amjavM0vbjx+///y5+azU9imqQvaSUxifPv6gppuh4W6
        ddYs98b+KJal+v/3s23eH/BW7cfPy1be2m3+5w2716y81LhJ8UmvrrMYvwWT371asQPfnRq3
        LTl08NLUeVxruibZii+ounJ0xx6OsuYKJiWW4oxEQy3mouJEAGBxrq4GAwAA
X-CMS-MailID: 20220428033149epcas2p239a3afa7cd987de5aaabc9cdc5f0267b
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----hGW09vigct5GtelhzIuvqVc_4Oej0kyi.rk8YCr72wPxMaPi=_2eed2_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220426092021epcas2p4071f2b7621558a015579131990486a3c
References: <1650964728-175347-1-git-send-email-dh10.jung@samsung.com>
        <CGME20220426092021epcas2p4071f2b7621558a015579131990486a3c@epcas2p4.samsung.com>
        <1650964728-175347-2-git-send-email-dh10.jung@samsung.com>
        <YmfBSLDiZGkvu3sG@kroah.com> <20220426102709.GA175152@ubuntu>
        <YmfKBX2m+vOznq5h@kroah.com> <Ymg8h6TiH4RpL93t@kroah.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------hGW09vigct5GtelhzIuvqVc_4Oej0kyi.rk8YCr72wPxMaPi=_2eed2_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Tue, Apr 26, 2022 at 08:40:07PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Apr 26, 2022 at 12:31:33PM +0200, Greg Kroah-Hartman wrote:
> > On Tue, Apr 26, 2022 at 07:27:09PM +0900, Jung Daehwan wrote:
> > > On Tue, Apr 26, 2022 at 11:54:16AM +0200, Greg Kroah-Hartman wrote:
> > > > On Tue, Apr 26, 2022 at 06:18:44PM +0900, Daehwan Jung wrote:
> > > > > Export symbols for xhci hooks usage:
> > > > >     xhci_get_slot_ctx
> > > > >     xhci_get_endpoint_address
> > > > >     - Allow xhci hook to get ep_ctx from the xhci_container_ctx for
> > > > >       getting the ep_ctx information to know which ep is offloading and
> > > > >       comparing the context in remote subsystem memory if needed.
> > > > > 
> > > > >     xhci_ring_alloc
> > > > >     - Allow xhci hook to allocate vendor specific ring. Vendors could
> > > > >       alloc additional event ring.
> > > > > 
> > > > >     xhci_trb_virt_to_dma
> > > > >     - Used to retrieve the DMA address of vendor specific ring. Vendors
> > > > >       could get dequeue address of event ring.
> > > > > 
> > > > >     xhci_segment_free
> > > > >     xhci_link_segments
> > > > >     - Allow xhci hook to handle vendor specific segment. Vendors could
> > > > >       directly free or link segments of vendor specific ring.
> > > > > 
> > > > >     xhci_initialize_ring_info
> > > > >     - Allow xhci hook to initialize vendor specific ring.
> > > > > 
> > > > >     xhci_check_trb_in_td_math
> > > > >     - Allow xhci hook to Check TRB math for validation. Vendors could
> > > > >       check trb when allocating vendor specific ring.
> > > > > 
> > > > >     xhci_address_device
> > > > >     - Allow override to give configuration info to Co-processor.
> > > > > 
> > > > >     xhci_bus_suspend
> > > > >     xhci_bus_resume
> > > > >     - Allow override of suspend and resume for power scenario.
> > > > > 
> > > > >     xhci_remove_stream_mapping
> > > > >     - Allow to xhci hook to remove stream mapping. Vendors need to do it
> > > > >       when free-ing vendor specific ring if it's stream type.
> > > > > 
> > > > 
> > > > For the static functions that you are now exporting, they need to have
> > > > their functions declared in a .h file.  If not, you now get warnings
> > > > when you run sparse after applying this commit, right?
> > > > 
> > > > thanks,
> > > > 
> > > > greg k-h
> > > > 
> > > 
> > > I didn't get warnings in my environment. I tested to build default config +
> > > xhci_exynos by make command. Is there compile option to check it?
> > 
> > make "C=1"
> 
> And now 0-day reported it as well:
> 	https://protect2.fireeye.com/v1/url?k=eb7c3909-8af72c33-eb7db246-74fe4860008a-ea28471ebd7c5af8&q=1&e=c40c7ad3-ab59-48ea-92a0-19c7ed0d5fd9&u=https%3A%2F%2Flore.kernel.org%2Fr%2F202204262306.mzMIKFKO-lkp%40intel.com
> 
>
I agree they should be added in header instead manually including xhci-exynos.
I will modify it on next submission.

I also don't get warnings in my environment when I run sparse.
Let me check my environment again.

Best Regards,
Jung Daehwan


------hGW09vigct5GtelhzIuvqVc_4Oej0kyi.rk8YCr72wPxMaPi=_2eed2_
Content-Type: text/plain; charset="utf-8"


------hGW09vigct5GtelhzIuvqVc_4Oej0kyi.rk8YCr72wPxMaPi=_2eed2_--
