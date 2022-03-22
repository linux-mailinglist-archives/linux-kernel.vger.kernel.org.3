Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D774E368A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 03:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235453AbiCVCSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 22:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235439AbiCVCS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 22:18:28 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8234827B24
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 19:16:14 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220322021608epoutp01bafb5c14aeffc4eb280fcfacf41bb617~ekkwHPRgI3155131551epoutp01f
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 02:16:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220322021608epoutp01bafb5c14aeffc4eb280fcfacf41bb617~ekkwHPRgI3155131551epoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1647915368;
        bh=YkyXc49blA5j2YgNtVL9LfMTogUrkHGCfnzHkF2IvSs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=K/XWEpQoZwgCSlJwGa8u7G5/s/Ys7v5D1oWUkd9sBrzEToW60OLWKhTZv9WweN18r
         vfSSUVncIfmbAO9NZcTZ2l7sruKaTrP3vwhkwent49gLVbwKH5vhJ44AgZoooErAD3
         s3oabUsYUtIFcVn9X4gMPXFvwPXTQuyGiPuza5d4=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20220322021608epcas2p3485b283f589044bd6ea1cd37e6ee32ba~ekkvf2lwq1317813178epcas2p3A;
        Tue, 22 Mar 2022 02:16:08 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.68]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4KMw851l6Vz4x9QV; Tue, 22 Mar
        2022 02:16:05 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        80.37.16040.36139326; Tue, 22 Mar 2022 11:16:03 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20220322021603epcas2p2fb2d8ac144fc59ff2b75b416f9e2b650~ekkq8Mvex2873328733epcas2p2v;
        Tue, 22 Mar 2022 02:16:03 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220322021603epsmtrp161310519870a8e08a7a8fd9faa151af6~ekkq7T8jN2314223142epsmtrp1I;
        Tue, 22 Mar 2022 02:16:03 +0000 (GMT)
X-AuditID: b6c32a46-bffff70000023ea8-e5-623931638fae
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F5.A9.29871.36139326; Tue, 22 Mar 2022 11:16:03 +0900 (KST)
Received: from ubuntu (unknown [12.36.155.120]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220322021603epsmtip1e44bf2b3722a9e8d09a985503f5b1425~ekkqy2_080819308193epsmtip1S;
        Tue, 22 Mar 2022 02:16:03 +0000 (GMT)
Date:   Tue, 22 Mar 2022 11:14:42 +0900
From:   Jung Daehwan <dh10.jung@samsung.com>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Howard Yen <howardyen@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        Puma Hsu <pumahsu@google.com>,
        "J . Avila" <elavila@google.com>, sc.suh@samsung.com
Subject: Re: [PATCH v3 2/4] usb: host: add xhci hooks for USB offload
Message-ID: <20220322021442.GA67215@ubuntu>
MIME-Version: 1.0
In-Reply-To: <8f34e9ee-4f50-9028-34ba-444090acf48c@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJJsWRmVeSWpSXmKPExsWy7bCmmW6yoWWSweRb5hZPjixit2hevJ7N
        4vqf94wW7c8vsFlc3jWHzWLRslZmi+ZNU1gtXn9oYrGYuVbZouvuDUYHLo/Lfb1MHgs2lXos
        3vOSyWPeyUCP/XPXsHv0bVnF6PF5k1wAe1S2TUZqYkpqkUJqXnJ+SmZeuq2Sd3C8c7ypmYGh
        rqGlhbmSQl5ibqqtkotPgK5bZg7QcUoKZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6XUgpSc
        AvMCveLE3OLSvHS9vNQSK0MDAyNToMKE7IynbX/ZCvrsKo7u421gvG3YxcjJISFgIvHk4EG2
        LkYuDiGBHYwSP44tZwZJCAl8YpTYd9ccIvGNUeLjpC6gBAdYx6P7iRDxvYwS+4/1sUM4Txgl
        rm5/zdTFyM7BIqAq8SEGZA6bgJbEvR8nwGaKCBhKfLu0nRGknFngMZNEy7vp7CAJYQFXicWb
        DrGCzOcV0Jb40pQOEuYVEJQ4OfMJC4jNKeAs8e3RBEaQElEBFYlXB+tBxkgILOWQmDdvMhvE
        My4S+//0MkLYwhKvjm9hh7ClJF72t0HZxRK7PrUyQTQ3MEo0PoA4TkLAWGLWs3awZmaBTIn3
        S28zQfyrLHHkFgtEmE+i4/Bfdogwr0RHmxBEp7LE9MsTWCFsSYmDr89BTfSQaL26Fxq2fUwS
        nxruskxglJ+F5LVZSLZB2DoSC3Z/YpsFtIJZQFpi+T8OCFNTYv0u/QWMrKsYxVILinPTU4uN
        CozgEZ2cn7uJEZxmtdx2ME55+0HvECMTB+MhRgkOZiUR3sUfzJOEeFMSK6tSi/Lji0pzUosP
        MZoCY2kis5Rocj4w0eeVxBuaWBqYmJkZmhuZGpgrifN6pWxIFBJITyxJzU5NLUgtgulj4uCU
        amBa3tQVfuZy34zELDPPEI/AIrtdeuf/8usbVD5auPjezKlVxmt95l1fmLY4ofJ/198AG4tJ
        mb/mvqmcKdS+YpPQrXttDQzdc9z3RdulXElMsOS+rV1sGdR5Zk6E/uu5b1QbvbnbpPky3vLb
        mNqylH4SZbiuvNowr4Zxy1KBnj9LmDM5r55qPdp16HeBkFf2hKVx26R/rg1S2SyyRTfn6/Wd
        N+QaL4ldXZ51ICF0C+v2S9Y975b2KKVb8Pru2exy0/TX2f3X9jZIOEQazG8/IKJa1SQxVcPI
        0NUvNXqq3Ors03nfrqQuK2NkSeTktgx7lcnd3SnI/y60gvH+ORv37mw27ilnK7IPfwnol72z
        UomlOCPRUIu5qDgRAJfngNs8BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPLMWRmVeSWpSXmKPExsWy7bCSnG6yoWWSwbQHghZPjixit2hevJ7N
        4vqf94wW7c8vsFlc3jWHzWLRslZmi+ZNU1gtXn9oYrGYuVbZouvuDUYHLo/Lfb1MHgs2lXos
        3vOSyWPeyUCP/XPXsHv0bVnF6PF5k1wAexSXTUpqTmZZapG+XQJXxv1Fh1gKTltXrGzuYW1g
        3KjfxcjBISFgIvHofmIXIyeHkMBuRon1jwVAbAkBSYmlc2+wQ9jCEvdbjrB2MXIB1TxilDi3
        fTOQw87BIqAq8SEGpIRNQEvi3o8TzCC2iIChxLdL2xlBypkFnjJJLN7YxgSSEBZwlVi86RAr
        yFpeAW2JL03pECP7mCS2nLvJBlLDKyAocXLmExYQmxlo6I1/L5lA6pkFpCWW/+MACXMKOEt8
        ezSBESQsKqAi8epg/QRGwVlImmchaZ6F0LyAkXkVo2RqQXFuem6xYYFhXmq5XnFibnFpXrpe
        cn7uJkZwnGhp7mDcvuqD3iFGJg7GQ4wSHMxKIryLP5gnCfGmJFZWpRblxxeV5qQWH2KU5mBR
        Eue90HUyXkggPbEkNTs1tSC1CCbLxMEp1cDEqCju4mEVUX74xPOAWYZ17T239u7yZnRkvSsh
        Jn2IJSZ4Xs76/1PTF8smSt7m/GyZVn74XhCPcR77zY8zXD/kKRySimQ8+SNr0v9T8vJGcg01
        xy7ynshsXLf5F/tiz2+Cs3NfqV/1ChZasXTO6rWn3y3wmnZ0ar1WtGIo4wJXN4PPl0ImKl+T
        dH7Lqqqlo3gz4PHTKdaBuhnHnuod2+Rx5s+a+663/fmzzr707dHf67VuIlPNyRvi1TrbTb/2
        L+B48Tsqc94FyVXXfvj/rAm67WRUF+Pnx3a3dAu78+6A85/nZ+7/pGvOFnNrRe41F5Hzkcrn
        mRhaNU6eE0z8O33TRPH7S4z/1nOGXAyYLf5CiaU4I9FQi7moOBEAz0e+JQIDAAA=
X-CMS-MailID: 20220322021603epcas2p2fb2d8ac144fc59ff2b75b416f9e2b650
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----GSQR3kPPEyoeEG69Vah8YifR26QqWy9Bp_qtiefWPF7qlfBd=_22cc65_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220321090204epcas2p3b2be5c6b131240e408d12d40c517395c
References: <1647853194-62147-1-git-send-email-dh10.jung@samsung.com>
        <CGME20220321090204epcas2p3b2be5c6b131240e408d12d40c517395c@epcas2p3.samsung.com>
        <1647853194-62147-3-git-send-email-dh10.jung@samsung.com>
        <8f34e9ee-4f50-9028-34ba-444090acf48c@linux.intel.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------GSQR3kPPEyoeEG69Vah8YifR26QqWy9Bp_qtiefWPF7qlfBd=_22cc65_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Mon, Mar 21, 2022 at 07:00:55PM +0200, Mathias Nyman wrote:
> On 21.3.2022 10.59, Daehwan Jung wrote:
> > To enable supporting for USB offload, define "offload" in usb controller
> > node of device tree. "offload" value can be used to determine which type
> > of offload was been enabled in the SoC.
> > 
> > For example:
> > 
> > &usbdrd_dwc3 {
> > 	...
> > 	/* support usb offloading, 0: disabled, 1: audio */
> > 	offload = <1>;
> > 	...
> > };
> > 
> > There are several vendor_ops introduced by this patch:
> > 
> > struct xhci_vendor_ops - function callbacks for vendor specific operations
> > {
> > 	@vendor_init:
> > 		- called for vendor init process during xhci-plat-hcd
> > 		  probe.
> > 	@vendor_cleanup:
> > 		- called for vendor cleanup process during xhci-plat-hcd
> > 		  remove.
> 
> The vendor_init() and vendor_cleanup() aren't really useful.
> you are calling them from platform_probe() and platform_remove(),
> just modify the probe and remove functions of the xhci-exynos driver directly.
> 
>

OK. I agree with you and I'm going to modify it on next submission.

> > 	@is_usb_offload_enabled:
> > 		- called to check if usb offload enabled.
> 
> Looks like this is being used more like a quirk bit.
> I think we can get rid of this as well
> 

Yes. I don't need it if I could get a quirk bit.

> > 	@alloc_dcbaa:
> > 		- called when allocating vendor specific dcbaa during
> > 		  memory initializtion.
> > 	@free_dcbaa:
> > 		- called to free vendor specific dcbaa when cleanup the
> > 		  memory.
> > 	@alloc_transfer_ring:
> > 		- called when vendor specific transfer ring allocation is required
> > 	@free_transfer_ring:
> > 		- called to free vendor specific transfer ring
> > 	@sync_dev_ctx:
> > 		- called when synchronization for device context is required
> > }
> > 
> > The xhci hooks with prefix "xhci_vendor_" on the ops in xhci_vendor_ops.
> > For example, vendor_init ops will be invoked by xhci_vendor_init() hook,
> > is_usb_offload_enabled ops will be invoked by
> > xhci_vendor_is_usb_offload_enabled(), and so on.
> > 
> > Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
> > Signed-off-by: J. Avila <elavila@google.com>
> > Signed-off-by: Puma Hsu <pumahsu@google.com>
> > Signed-off-by: Howard Yen <howardyen@google.com>
> > ---
> >  drivers/usb/host/xhci-hub.c  |   5 ++
> >  drivers/usb/host/xhci-mem.c  | 131 +++++++++++++++++++++++++++++++----
> >  drivers/usb/host/xhci-plat.c |  43 +++++++++++-
> >  drivers/usb/host/xhci-plat.h |   7 ++
> >  drivers/usb/host/xhci.c      |  80 ++++++++++++++++++++-
> >  drivers/usb/host/xhci.h      |  46 ++++++++++++
> >  6 files changed, 295 insertions(+), 17 deletions(-)
> > 
> > diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
> > index 56546aaa93c7..aea72ffce820 100644
> > --- a/drivers/usb/host/xhci-hub.c
> > +++ b/drivers/usb/host/xhci-hub.c
> > @@ -535,8 +535,13 @@ static int xhci_stop_device(struct xhci_hcd *xhci, int slot_id, int suspend)
> >  	    cmd->status == COMP_COMMAND_RING_STOPPED) {
> >  		xhci_warn(xhci, "Timeout while waiting for stop endpoint command\n");
> >  		ret = -ETIME;
> > +		goto cmd_cleanup;
> >  	}
> >  
> > +	ret = xhci_vendor_sync_dev_ctx(xhci, slot_id);
> > +	if (ret)
> > +		xhci_warn(xhci, "Sync device context failed, ret=%d\n", ret);
> > +
> >  cmd_cleanup:
> >  	xhci_free_command(xhci, cmd);
> >  	return ret;
> > diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
> > index 82b9f90c0f27..5ee0ffb676d3 100644
> > --- a/drivers/usb/host/xhci-mem.c
> > +++ b/drivers/usb/host/xhci-mem.c
> > @@ -365,6 +365,54 @@ static int xhci_alloc_segments_for_ring(struct xhci_hcd *xhci,
> >  	return 0;
> >  }
> >  
> > +static void xhci_vendor_free_container_ctx(struct xhci_hcd *xhci, struct xhci_container_ctx *ctx)
> > +{
> > +	struct xhci_vendor_ops *ops = xhci_vendor_get_ops(xhci);
> > +
> > +	if (ops && ops->free_container_ctx)
> > +		ops->free_container_ctx(xhci, ctx);
> > +}
> 
> 
> Looks suspicious, we always need to free container contexts, why this much checking?
> 
> 

Calling funcion could cause a problem if some functions haven't been mapped
on ops yet. Others below are same.

> > +
> > +static void xhci_vendor_alloc_container_ctx(struct xhci_hcd *xhci, struct xhci_container_ctx *ctx,
> > +					    int type, gfp_t flags)
> > +{
> > +	struct xhci_vendor_ops *ops = xhci_vendor_get_ops(xhci);
> > +
> > +	if (ops && ops->alloc_container_ctx)
> > +		ops->alloc_container_ctx(xhci, ctx, type, flags);
> > +}
> 
> same, there should always be a function to allocate container context..
> 
> > +
> > +static struct xhci_ring *xhci_vendor_alloc_transfer_ring(struct xhci_hcd *xhci,
> > +		u32 endpoint_type, enum xhci_ring_type ring_type,
> > +		unsigned int max_packet, gfp_t mem_flags)
> > +{
> > +	struct xhci_vendor_ops *ops = xhci_vendor_get_ops(xhci);
> > +
> > +	if (ops && ops->alloc_transfer_ring)
> > +		return ops->alloc_transfer_ring(xhci, endpoint_type, ring_type,
> > +				max_packet, mem_flags);
> > +	return 0;
> 
> same, looks like a lot of extra code.
> 
> > +}
> > +
> > +void xhci_vendor_free_transfer_ring(struct xhci_hcd *xhci,
> > +		struct xhci_ring *ring, unsigned int ep_index)
> > +{
> > +	struct xhci_vendor_ops *ops = xhci_vendor_get_ops(xhci);
> > +
> > +	if (ops && ops->free_transfer_ring)
> > +		ops->free_transfer_ring(xhci, ring, ep_index);
> > +}
> > +
> 
> same.
> 
> > +bool xhci_vendor_is_usb_offload_enabled(struct xhci_hcd *xhci,
> > +		struct xhci_virt_device *virt_dev, unsigned int ep_index)
> > +{
> > +	struct xhci_vendor_ops *ops = xhci_vendor_get_ops(xhci);
> > +
> > +	if (ops && ops->is_usb_offload_enabled)
> > +		return ops->is_usb_offload_enabled(xhci, virt_dev, ep_index);
> > +	return false;
> > +}
> > +
> >  /*
> >   * Create a new ring with zero or more segments.
> >   *
> > @@ -417,7 +465,11 @@ void xhci_free_endpoint_ring(struct xhci_hcd *xhci,
> >  		struct xhci_virt_device *virt_dev,
> >  		unsigned int ep_index)
> >  {
> > -	xhci_ring_free(xhci, virt_dev->eps[ep_index].ring);
> > +	if (xhci_vendor_is_usb_offload_enabled(xhci, virt_dev, ep_index))
> > +		xhci_vendor_free_transfer_ring(xhci, virt_dev->eps[ep_index].ring, ep_index);
> > +	else
> > +		xhci_ring_free(xhci, virt_dev->eps[ep_index].ring);
> > +
> >  	virt_dev->eps[ep_index].ring = NULL;
> >  }
> 
> Ok, I see.
> So idea is to override some functions that allocate and free DMA memory.
> Your vendor_ops structure filled with function callbacks could be a 
> mem_ops structure that allows your driver to directly override those
> functions.
> 
> For example here we would only call
> 
> xhci->mem_ops->ring_free(...);
> This would set to xhci_ring_free() by default, but your xhci-exonys driver could
> set it to xhci_exonys_free_ring(), which would do any needed is_offload_enabled()
> checks and custom freeing.
> 
> Same goes for most most of the other functions in this patch
> 

Exactly. I'm appreciate for your understanding my patch.

> If possible see if it's enough to override the existing callbacks in
> struct hc_driver instead of creating new function pointers.
> 
> -Mathias
>

I've used override for reset, start, add_endpoint, address_device, bus_suspend,
and bus_resume in hc_driver. I could use reset_bandwidth more but I don't
think override is better in this case because allocation / free of ep ring are
always done with xhci hooks on others.

Best Regards,
Jung Daehwan

------GSQR3kPPEyoeEG69Vah8YifR26QqWy9Bp_qtiefWPF7qlfBd=_22cc65_
Content-Type: text/plain; charset="utf-8"


------GSQR3kPPEyoeEG69Vah8YifR26QqWy9Bp_qtiefWPF7qlfBd=_22cc65_--
