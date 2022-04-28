Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFA95129C7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 05:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241854AbiD1DIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 23:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241857AbiD1DIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 23:08:23 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1D325C40
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 20:05:03 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220428030457epoutp0332693af1ed0a3fb1c737c8bfb3295705~p8G7aSkQC0770907709epoutp03j
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 03:04:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220428030457epoutp0332693af1ed0a3fb1c737c8bfb3295705~p8G7aSkQC0770907709epoutp03j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651115097;
        bh=B+5CEfbSfpEtTG6Obz/BtMXLa3Bionkf6cQCEOZvwtA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gDzS3zAkJKFO/drdvx/QhBFyN66zIUHXnJZwYfub9z5zcGcCyuXwX6bl20QP9QKAl
         pbDfsV1eI5Ae+BHDRWox2ANVSrfETqTeJ89vHm4EW9TzCV7NVBb2AGy3rSOhtbz8JJ
         4sB3on2tB6b5mAj61kQrtSrdH6MfqCpoVj03YITg=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20220428030455epcas2p2d9f5aabb4436bb8abf735ce9f57f6fa9~p8G5UVHPY2351823518epcas2p2w;
        Thu, 28 Apr 2022 03:04:55 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.89]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4KpgTH5FxJz4x9QB; Thu, 28 Apr
        2022 03:04:51 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        B1.36.09694.3540A626; Thu, 28 Apr 2022 12:04:51 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20220428030451epcas2p382c27351df0c017856057aad541270b9~p8G1t4Tzb2812228122epcas2p3L;
        Thu, 28 Apr 2022 03:04:51 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220428030451epsmtrp18349622269b438a1d9a412232b64fe57~p8G1tH2OZ0714407144epsmtrp1v;
        Thu, 28 Apr 2022 03:04:51 +0000 (GMT)
X-AuditID: b6c32a48-495ff700000025de-2d-626a0453819c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B9.6E.08853.3540A626; Thu, 28 Apr 2022 12:04:51 +0900 (KST)
Received: from ubuntu (unknown [10.229.95.128]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220428030450epsmtip2fb347867c4083072bfc5327a43a449fb~p8G1gzPSM3146431464epsmtip2B;
        Thu, 28 Apr 2022 03:04:50 +0000 (GMT)
Date:   Thu, 28 Apr 2022 12:03:19 +0900
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
Message-ID: <20220428030319.GA139938@ubuntu>
MIME-Version: 1.0
In-Reply-To: <b9fcc518-cc0d-d346-774e-3a9472e664bc@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOJsWRmVeSWpSXmKPExsWy7bCmhW4wS1aSwe43KhZPjixit2hevJ7N
        4vqf94wW7c8vsFlsfPuDyeLyrjlsFouWtTJbNG+awmrx+kMTi8XMtcoWXXdvMDpwe8xq6GXz
        uNzXy+SxYFOpx+I9L5k85p0M9Ng/dw27R9+WVYwenzfJBXBEZdtkpCampBYppOYl56dk5qXb
        KnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAJ2ppFCWmFMKFApILC5W0rezKcovLUlV
        yMgvLrFVSi1IySkwL9ArTswtLs1L18tLLbEyNDAwMgUqTMjOOHJLt+CDTkXfuVcsDYyzlLsY
        OTkkBEwkZjT9Y+pi5OIQEtjBKHF/wUoo5xOjxI77z1ghnG+MEqufTGSFaflx5Q8zRGIvo8TF
        16ugWp4wSkyctZwdpIpFQFViw8zJYB1sAloS936cYAaxRQQMJb5d2s4I0sAsMIdZ4tqSGywg
        CWEBW4lfW3cygti8AjoSc9o/sUPYghInZz4Bq+EUcJZYPmM7WxcjB4eogIrEq4P1EBet5ZCY
        ecMEwnaR2Ph5GyOELSzx6vgWdghbSuJlfxuUXSyx61Mr2NESAg2MEo0PII6TEDCWmPWsHayZ
        WSBD4v/Wk2C7JASUJY7cYoEI80l0HP7LDhHmlehoE4LoVJaYfnkCNIAkJQ6+Pgc10UPi29ON
        bJDwmcAksWvxc6YJjPKzkHw2C8k2CFtHYsHuT0A2B5AtLbH8HweEqSmxfpf+AkbWVYxiqQXF
        uempxUYFJvDITs7P3cQITsFaHjsYZ7/9oHeIkYmD8RCjBAezkgjvl90ZSUK8KYmVValF+fFF
        pTmpxYcYTYHxNJFZSjQ5H5gF8kriDU0sDUzMzAzNjUwNzJXEeb1SNiQKCaQnlqRmp6YWpBbB
        9DFxcEo1MGXHrMpRU3NeXzzphn/NOm1FTUOp0jszj83QOl9x6Vht0KIbDluetEppazltLctq
        rXl6SelmQegia9lpKnqMPxfOyPdoPnd+ypSc5hWly/+90TX59SXn4J/AkORv9/bXz8jzUT7L
        e+e5f9E3hzlHjE5wci57H35Eev+0ktenTotKLOt5bNFfxSHfvv75T6+jU1ftCD7a+cQh/pc7
        2zzXm04KO4VXeDkHN7QoBh1869ScaLVF9efhu89E9826bOEXvbo++PCfx1uvVM8u12GS91La
        lbP98KvN17ZfLRZYIuD2cemthRNTvs3/bGEVmDyV4StvlK3F00y3muzZHNIhldMWeM99bW5/
        Yh9jfL3GvjolluKMREMt5qLiRACr3H/lSgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDLMWRmVeSWpSXmKPExsWy7bCSvG4wS1aSQdt3FosnRxaxWzQvXs9m
        cf3Pe0aL9ucX2Cw2vv3BZHF51xw2i0XLWpktmjdNYbV4/aGJxWLmWmWLrrs3GB24PWY19LJ5
        XO7rZfJYsKnUY/Gel0we804Geuyfu4bdo2/LKkaPz5vkAjiiuGxSUnMyy1KL9O0SuDIuHp7B
        XLBBq+LUimusDYyfFboYOTkkBEwkflz5wwxiCwnsZpRY8TcPIi4psXTuDXYIW1jifssRVoia
        R4wSPQ+tQWwWAVWJDTMng8XZBLQk7v04ATZHRMBQ4tul7YxdjFwczAILmCXOtc1jA0kIC9hK
        /Nq6kxHE5hXQkZjT/okdpEhIYAKTxO1zR1kgEoISJ2c+AbOZgabe+PeSqYuRA8iWllj+jwMk
        zCngLLF8xnY2kLCogIrEq4P1ExgFZyFpnoWkeRZC8wJG5lWMkqkFxbnpucWGBYZ5qeV6xYm5
        xaV56XrJ+bmbGMERpKW5g3H7qg96hxiZOBgPMUpwMCuJ8H7ZnZEkxJuSWFmVWpQfX1Sak1p8
        iFGag0VJnPdC18l4IYH0xJLU7NTUgtQimCwTB6dUAxN/y/c9J4/59325/ejrP9ZncU2zk/5x
        XWufvpZfMVfj38S4M/pRCp3J81kaQ/UqT6ZsYJl16cuBxKWuV9QDWTjU1adq5bppbJu3XfYC
        l3XbxX+MXuuO37B+tvv7uQz9Ko+kleImG9Urz7eYLrvIa7vCrmHmkh/Fwt2rrefwvphy6Nd2
        +R/t93dZcS7U/vzrerJAyPUGka8933W/na2PbNjjtzluivjDx/ad5sK5z0UXc1uu/e7sPHVd
        W9zKIxNdPUJ/PFB/It77h2vZs9pH13X+vPTM+nhVrmzi/oM3Pu21NGLS5OL+c/GNctumU4e2
        hIqstTj7flvS/e2st24EzTEQ2+k5857aurUq7TIX3zY6KrEUZyQaajEXFScCAKRpiIMPAwAA
X-CMS-MailID: 20220428030451epcas2p382c27351df0c017856057aad541270b9
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----qfoLneH-bA4OZ9oHdTyx3iGNIh7cCFW1WhPixvfI4kv0vTIJ=_2e85a_"
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
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------qfoLneH-bA4OZ9oHdTyx3iGNIh7cCFW1WhPixvfI4kv0vTIJ=_2e85a_
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

Yes. Only one USB device is supported as you said. I'm going to modify
it following normal sequence from 2nd device.

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

Yes. it's right to return error here.

> 
> Also this whole function never allocates or remaps any memory.

This fuctions is for link segments. Right below function(xhci_ring_alloc_uram)
allocates.

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

Allcation function for trbs are missed. It's done by ioremap.
I will add it on next submission. Thanks for the comment.

> 
> A lot of this code seems to exists just to avoid xhci driver from allocating
> dma capable memory, we can refactor the existing xhci_mem_init() and move
> dcbaa and event ring allocation and other code to their own overridable
> functions.
> 
> This way we can probably get rid of a lot of the code in this series.

Yes right. I think it's proper. Do you agree with it or have better way
to do it?

Best Regards,
Jung Deahwan.
> 
> Thanks
> Mathias
> 

------qfoLneH-bA4OZ9oHdTyx3iGNIh7cCFW1WhPixvfI4kv0vTIJ=_2e85a_
Content-Type: text/plain; charset="utf-8"


------qfoLneH-bA4OZ9oHdTyx3iGNIh7cCFW1WhPixvfI4kv0vTIJ=_2e85a_--
