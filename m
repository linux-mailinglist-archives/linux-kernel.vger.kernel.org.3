Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 296A6512AD5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 07:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242878AbiD1FUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 01:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233104AbiD1FUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 01:20:15 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD5A1009
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 22:17:00 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220428051656epoutp02d6e9cc9801542203269ca42d20777a00~p96LJQUnT3003330033epoutp02L
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 05:16:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220428051656epoutp02d6e9cc9801542203269ca42d20777a00~p96LJQUnT3003330033epoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651123016;
        bh=T+ZM/kcFpX2WmttKp+rOfsPvKxBlmqXv40PhSNL3xJY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lDYJ4W4ePn94/XnXkn2Hm+zC/XelPd95ZUSRReE4Zx/ikKnsZt08EZaxWmq0NfP7c
         kED4D4zXLD9bCBJx9+7ADvsXoacFzX461qxt7VORQxubLLCZzL5SYlX1pJGaIma0tq
         wqhK11CkMIJj2HPf/b3P2L5FGUmj03TWfT8PYfeo=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20220428051656epcas2p142a7d6b6db8e3f942f63b08331d42411~p96KvpICn3272732727epcas2p1d;
        Thu, 28 Apr 2022 05:16:56 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.97]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4KpkPd09xnz4x9Pr; Thu, 28 Apr
        2022 05:16:53 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        0D.1E.10028.3432A626; Thu, 28 Apr 2022 14:16:51 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20220428051651epcas2p2080f9f1148ccc15aa4217c02e7bd471a~p96GF7qZM0564305643epcas2p2X;
        Thu, 28 Apr 2022 05:16:51 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220428051651epsmtrp1fccfa9280bb7bda5aac5645ea7abbcea~p96GFEWdU1994619946epsmtrp1M;
        Thu, 28 Apr 2022 05:16:51 +0000 (GMT)
X-AuditID: b6c32a47-573ff7000000272c-5c-626a23432213
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        BE.5E.08924.3432A626; Thu, 28 Apr 2022 14:16:51 +0900 (KST)
Received: from ubuntu (unknown [10.229.95.128]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220428051651epsmtip2db8c1f9084c54070ebd87a4211edf767~p96F54SrY1340913409epsmtip2V;
        Thu, 28 Apr 2022 05:16:51 +0000 (GMT)
Date:   Thu, 28 Apr 2022 14:15:22 +0900
From:   Jung Daehwan <dh10.jung@samsung.com>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Howard Yen <howardyen@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        Puma Hsu <pumahsu@google.com>,
        "J . Avila" <elavila@google.com>, sc.suh@samsung.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH v4 5/5] usb: host: add xhci-exynos driver
Message-ID: <20220428051522.GE151827@ubuntu>
MIME-Version: 1.0
In-Reply-To: <b9fcc518-cc0d-d346-774e-3a9472e664bc@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGJsWRmVeSWpSXmKPExsWy7bCmha6zclaSwd7vJhZPjixit2hevJ7N
        4vqf94wW7c8vsFlsfPuDyeLyrjlsFouWtTJbNG+awmrx+kMTi8XMtcoWXXdvMDpwe8xq6GXz
        uNzXy+SxYFOpx+I9L5k85p0M9Ng/dw27R9+WVYwenzfJBXBEZdtkpCampBYppOYl56dk5qXb
        KnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAJ2ppFCWmFMKFApILC5W0rezKcovLUlV
        yMgvLrFVSi1IySkwL9ArTswtLs1L18tLLbEyNDAwMgUqTMjOuLGmlbFguU7F6nsHGBsYnyh1
        MXJwSAiYSGy/K9PFyMUhJLCDUeL7lb1MEM4nRonmE/9YIZzPjBId+86ywnQ8exYGEd/FKPFu
        0wyojieMEqsubGPrYuTkYBFQlZi86S8riM0moCVx78cJZhBbRMBQ4tul7YwgDcwCc5glri25
        wQKSEBawlfi1dScjyAZeAR2JDz9cQMK8AoISJ2c+ASvhFHCWWD5jOxtIiaiAisSrg/UgYyQE
        1nJI3Ox7yghSIyHgIrFxwwRmCFtY4tXxLewQtpTEy/42KLtYYtenViaI5gZGicYHJ6AajCVm
        PWsHG8QskCGxt+0KG8THyhJHbrFAhPkkOg7/ZYcI80p0tAlBdCpLTL88gRXClpQ4+Poc1EQP
        iW9PN7JBwmcCk8Suxc+ZJjDKz0Ly2iwk2yBsHYkFuz8B2RxAtrTE8n8cEKamxPpd+gsYWVcx
        iqUWFOempxYbFRjD4zo5P3cTIzgBa7nvYJzx9oPeIUYmDsZDjBIczEoivF92ZyQJ8aYkVlal
        FuXHF5XmpBYfYjQFxtNEZinR5HxgDsgriTc0sTQwMTMzNDcyNTBXEuf1StmQKCSQnliSmp2a
        WpBaBNPHxMEp1cAkdW5WS7vkf5Fby267/Vk09eDdFXrv5okt6Pc8wKLazstxjvfLOqkjG99u
        qw1+l2GwscDr8K7JoRc3MaScDL6n9nSaul/ZW85n141001I8Ki+f2B1j3Ou946RgSeXLvuZG
        jm3MUobNKoa1dnb/c1cvKPuqWC62qHbXnLRbm/53rN646kfupUP655UzjhX0f973qyDO8vu7
        sL0yt9UO1/Bfn5kxNbVB5tfUb32h+bGKj/jyNBbXN2w2VEm/nJOkzF9w6u2z1b88Ws/+Ovfi
        caTDo0ZW7iYWv71VETOCpmusPM798+CBo+lfZb4u4kjYLpx3cuNpdxYlV8/V3uGX1GoKHuzN
        mVHxQmdFzNZZzp/ilFiKMxINtZiLihMBOyh0zUkEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNLMWRmVeSWpSXmKPExsWy7bCSvK6zclaSwbOtkhZPjixit2hevJ7N
        4vqf94wW7c8vsFlsfPuDyeLyrjlsFouWtTJbNG+awmrx+kMTi8XMtcoWXXdvMDpwe8xq6GXz
        uNzXy+SxYFOpx+I9L5k85p0M9Ng/dw27R9+WVYwenzfJBXBEcdmkpOZklqUW6dslcGVcmbyM
        ueC5ZsWjsyUNjHsVuhg5OCQETCSePQvrYuTiEBLYwSjROOsdcxcjJ1BcUmLp3BvsELawxP2W
        I6wQRY8YJSadaGYESbAIqEpM3vSXFcRmE9CSuPfjBFiziIChxLdL2xlBGpgFFjBLnGubxwaS
        EBawlfi1dScjyGZeAR2JDz9cIIZOYJK4fe4oC0gNr4CgxMmZT8BsZqChN/69ZAKpZxaQllj+
        jwMkzCngLLF8xnY2kLCogIrEq4P1ExgFZyFpnoWkeRZC8wJG5lWMkqkFxbnpucWGBUZ5qeV6
        xYm5xaV56XrJ+bmbGMHxo6W1g3HPqg96hxiZOBgPMUpwMCuJ8H7ZnZEkxJuSWFmVWpQfX1Sa
        k1p8iFGag0VJnPdC18l4IYH0xJLU7NTUgtQimCwTB6dUA5PRgxt+Nem+JfM//K24vL553v7K
        JSck7ALEbnHPFBMzXCxa9vCLecLkCTlbI95Hzgnd5BCka6eeeE6Rm//i9a6/1iVr3hReZOJy
        dV507xHz6usZBbIO/vt8WJQv7rnYo1js9jd/WWrYnAf3sry4T8Yuz+3J8PmnMHW+s7H2ccm5
        zCc9yvT3FQcVlT/7smLaC3+b1v6jcdlf5k7hf8PFUp8n+/XXhRnXXuTqlt/7G67DXfe0I2Bq
        x3TtlIn7PC6JzFp11jwunnltWFPP6ovcAZ/lfBeu3/SsPdxCKEzOc//k20GHXR+48pufjWYT
        Sq9/8u1nafvSK5e/Roo8VkpnbPxu1TRheXMsl5PHTuW8KUosxRmJhlrMRcWJAOgvMb8OAwAA
X-CMS-MailID: 20220428051651epcas2p2080f9f1148ccc15aa4217c02e7bd471a
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----ibIraZXel8vAP7k4n32fW3YR3bsCcgqvt7YD6UTr0n_RukWR=_300a5_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220426092023epcas2p32946c087135ca4b7e63b03915060c55d
References: <1650964728-175347-1-git-send-email-dh10.jung@samsung.com>
        <CGME20220426092023epcas2p32946c087135ca4b7e63b03915060c55d@epcas2p3.samsung.com>
        <1650964728-175347-6-git-send-email-dh10.jung@samsung.com>
        <b9fcc518-cc0d-d346-774e-3a9472e664bc@linux.intel.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------ibIraZXel8vAP7k4n32fW3YR3bsCcgqvt7YD6UTr0n_RukWR=_300a5_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Wed, Apr 27, 2022 at 07:25:21PM +0300, Mathias Nyman wrote:
> On 26.4.2022 12.18, Daehwan Jung wrote:
> > This driver is for Samsung Exynos xhci host conroller. It uses xhci-plat
> > driver mainly and extends some functions by xhci hooks and overrides.
> > 
> > It supports USB Audio offload with Co-processor. It only cares DCBAA,
> > Device Context, Transfer Ring, Event Ring, and ERST. They are allocated
> > on specific address with xhci hooks. Co-processor could use them directly
> > without xhci driver after then.
> > 
> > Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
> 
> I have to agree with Krzysztof's comments, this is an odd driver stub.
> 
> Perhaps open up a bit how the Exynos offloading works so we can figure out
> in more detail what the hardware needs from software.  
> 
> (...)
> 

I missed replying here on previous one.
OK. It seems to need more detailed explanation. I will explain my driver
more detail on next submission.

> > +
> > +static void xhci_exynos_alloc_container_ctx(struct xhci_hcd *xhci, struct xhci_container_ctx *ctx,
> > +						int type, gfp_t flags)
> > +{
> > +	/* Only first Device Context uses URAM */
> > +	int i;
> > +
> > +	ctx->bytes = ioremap(EXYNOS_URAM_DEVICE_CTX_ADDR, EXYNOS_URAM_CTX_SIZE);
> > +	if (!ctx->bytes)
> > +		return;
> > +
> > +	for (i = 0; i < EXYNOS_URAM_CTX_SIZE; i++)
> > +		ctx->bytes[i] = 0;
> > +
> > +	ctx->dma = EXYNOS_URAM_DEVICE_CTX_ADDR;
> 
> This can't work with more than one USB device.
> This hardcodes the same context address for every usb device.
> 
> 
> > +static void xhci_exynos_parse_endpoint(struct xhci_hcd *xhci, struct usb_device *udev,
> > +		struct usb_endpoint_descriptor *desc, struct xhci_container_ctx *ctx)
> > +{
> > +	struct xhci_plat_priv *priv = xhci_to_priv(xhci);
> > +	struct xhci_hcd_exynos *xhci_exynos = priv->vendor_priv;
> > +	struct usb_endpoint_descriptor *d = desc;
> > +	unsigned int ep_index;
> > +	struct xhci_ep_ctx *ep_ctx;
> > +
> > +	ep_index = xhci_get_endpoint_index(d);
> > +	ep_ctx = xhci_get_ep_ctx(xhci, ctx, ep_index);
> > +
> > +	if ((d->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) ==
> > +				USB_ENDPOINT_XFER_ISOC) {
> > +		if (d->bEndpointAddress & USB_ENDPOINT_DIR_MASK)
> > +			xhci_exynos->in_ep = d->bEndpointAddress;
> > +		else
> > +			xhci_exynos->out_ep = d->bEndpointAddress;
> > +	}
> 
> This won't work if more than one device that has isoc endpoints, or even 
> if that device has more than one in/out isoc endpoint pair.
> 
> 

I missed it also on previous mail.
I've never seen a device that has several isoc endpoints.
It needs to add something if it would exist.

In fact, I've found a device that has feedback ep and I'm going to add
it. I've never seen other case yet.

Best Regards,
Jung Daehwan

> > +static int xhci_alloc_segments_for_ring_uram(struct xhci_hcd *xhci,
> > +		struct xhci_segment **first, struct xhci_segment **last,
> > +		unsigned int num_segs, unsigned int cycle_state,
> > +		enum xhci_ring_type type, unsigned int max_packet, gfp_t flags,
> > +		u32 endpoint_type)
> > +{
> > +	struct xhci_segment *prev;
> > +	bool chain_links = false;
> > +
> > +	while (num_segs > 0) {
> > +		struct xhci_segment *next = NULL;
> > +
> > +		if (!next) {
> > +			prev = *first;
> > +			while (prev) {
> > +				next = prev->next;
> > +				xhci_segment_free(xhci, prev);
> > +				prev = next;
> > +			}
> > +			return -ENOMEM;
> 
> This always return -ENOMEM
> 
> Also this whole function never allocates or remaps any memory.
> 
> > +		}
> > +		xhci_link_segments(prev, next, type, chain_links);
> > +
> > +		prev = next;
> > +		num_segs--;
> > +	}
> > +	xhci_link_segments(prev, *first, type, chain_links);
> > +	*last = prev;
> > +
> > +	return 0;
> > +}
> > +
> > +static struct xhci_ring *xhci_ring_alloc_uram(struct xhci_hcd *xhci,
> > +		unsigned int num_segs, unsigned int cycle_state,
> > +		enum xhci_ring_type type, unsigned int max_packet, gfp_t flags,
> > +		u32 endpoint_type)
> > +{
> > +	struct xhci_ring	*ring;
> > +	int ret;
> > +	struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
> > +
> > +	ring = kzalloc_node(sizeof(*ring), flags, dev_to_node(dev));
> > +	if (!ring)
> > +		return NULL;
> > +
> > +	ring->num_segs = num_segs;
> > +	ring->bounce_buf_len = max_packet;
> > +	INIT_LIST_HEAD(&ring->td_list);
> > +	ring->type = type;
> > +	if (num_segs == 0)
> > +		return ring;
> > +
> > +	ret = xhci_alloc_segments_for_ring_uram(xhci, &ring->first_seg,
> > +			&ring->last_seg, num_segs, cycle_state, type,
> > +			max_packet, flags, endpoint_type);
> > +	if (ret)
> > +		goto fail;
> > +
> > +	/* Only event ring does not use link TRB */
> > +	if (type != TYPE_EVENT) {
> > +		/* See section 4.9.2.1 and 6.4.4.1 */
> > +		ring->last_seg->trbs[TRBS_PER_SEGMENT - 1].link.control |=
> > +			cpu_to_le32(LINK_TOGGLE);
> 
> No memory was allocated for trbs
> 
> A lot of this code seems to exists just to avoid xhci driver from allocating
> dma capable memory, we can refactor the existing xhci_mem_init() and move
> dcbaa and event ring allocation and other code to their own overridable
> functions.
> 
> This way we can probably get rid of a lot of the code in this series.
> 
> Thanks
> Mathias
> 

------ibIraZXel8vAP7k4n32fW3YR3bsCcgqvt7YD6UTr0n_RukWR=_300a5_
Content-Type: text/plain; charset="utf-8"


------ibIraZXel8vAP7k4n32fW3YR3bsCcgqvt7YD6UTr0n_RukWR=_300a5_--
