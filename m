Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF07517FE9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 10:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232851AbiECIrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 04:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbiECIrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 04:47:17 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CFD534B9C
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 01:43:44 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220503084340epoutp03cb44c0d8188039a391f3d9b1b81ef7e8~ri9GeW19F3005330053epoutp03q
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 08:43:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220503084340epoutp03cb44c0d8188039a391f3d9b1b81ef7e8~ri9GeW19F3005330053epoutp03q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651567420;
        bh=E/kNS8J6LGsDH5KxU/vYXIpphusvX+Z+Ji7rYA+GplI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oW3cf9zrbeA7GMWe//1IljgwZdec8yTRZlsPVrbRDGDB6j/st5K6ch2+Nyutiduk7
         o3BYWoUlzIsJDELdjbwYbXLKEg4PT0EGs3570pNaw3DQjYe1lkch1SL9gIyMxYXcQI
         UlayzwL9CR741E3pjoKAXY6iSScCJO54jK6JWx4Q=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20220503084340epcas2p3e77cf06771fd036b1571b72c7fb1f235~ri9F-I4OL1935719357epcas2p3e;
        Tue,  3 May 2022 08:43:40 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.100]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Kstls2pMhz4x9Q2; Tue,  3 May
        2022 08:43:37 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        91.9E.09694.93BE0726; Tue,  3 May 2022 17:43:37 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20220503084336epcas2p385b5af3e2bd129a9984c9b6c345b51fc~ri9CcSV0g1184411844epcas2p3b;
        Tue,  3 May 2022 08:43:36 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220503084336epsmtrp2d7ec30bf4e483855e523b6b646a97826~ri9CbfVUF2822328223epsmtrp2x;
        Tue,  3 May 2022 08:43:36 +0000 (GMT)
X-AuditID: b6c32a48-47fff700000025de-a5-6270eb391658
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        DE.B7.08924.83BE0726; Tue,  3 May 2022 17:43:36 +0900 (KST)
Received: from ubuntu (unknown [10.229.95.128]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220503084336epsmtip1a9e605007c0456735db18148872a076f~ri9CNlw7t1852718527epsmtip1i;
        Tue,  3 May 2022 08:43:36 +0000 (GMT)
Date:   Tue, 3 May 2022 17:41:58 +0900
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
Message-ID: <20220503084158.GA38006@ubuntu>
MIME-Version: 1.0
In-Reply-To: <0f84e8d4-451f-693a-d098-517dc6235a0f@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBJsWRmVeSWpSXmKPExsWy7bCmqa7l64Ikg9srWC2eHFnEbtG8eD2b
        xfU/7xkt2p9fYLPY+PYHk8XlXXPYLBYta2W2aN40hdXi9YcmFouZa5Utuu7eYHTg9pjV0Mvm
        cbmvl8ljwaZSj8V7XjJ5zDsZ6LF/7hp2j74tqxg9Pm+SC+CIyrbJSE1MSS1SSM1Lzk/JzEu3
        VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMATpTSaEsMacUKBSQWFyspG9nU5RfWpKq
        kJFfXGKrlFqQklNgXqBXnJhbXJqXrpeXWmJlaGBgZApUmJCdsXHlDdaCdvWKw3e9GhhvyHUx
        cnJICJhI3NmwkK2LkYtDSGAHo8StvrWMEM4nRonLHe+hnM+MEu8v9DDDtOx4vYMJIrGLUaK3
        /zmU84RR4sXMPjaQKhYBFYl3j6aB2WwCWhL3fpwA6xYRMJT4dmk72FhmgTnMEteW3GABSQgL
        2Er82rqTEcTmFdCWmP5vL5QtKHFy5hOwGk4BZ4kLmx8ADeLgEAVa8OpgPcgcCYGVHBInnh9i
        hzjPReLTt1ZGCFtY4tXxLVBxKYnP7/ayQdjFErs+tTJBNDcwSjQ+OAH1m7HErGftYM3MAhkS
        Wx5eZQNZJiGgLHHkFgtEmE+i4/Bfdogwr0RHmxBEp7LE9MsTWCFsSYmDr89BTfSQ+PZ0IzSA
        3zBJ/Jp4h3kCo/wsJK/NQrINwtaRWLD7E5DNAWRLSyz/xwFhakqs36W/gJF1FaNYakFxbnpq
        sVGBCTy2k/NzNzGCk7CWxw7G2W8/6B1iZOJgPMQowcGsJMLrvLQgSYg3JbGyKrUoP76oNCe1
        +BCjKTCiJjJLiSbnA/NAXkm8oYmlgYmZmaG5kamBuZI4r1fKhkQhgfTEktTs1NSC1CKYPiYO
        TqkGJv3Ec6wPkmWSLhnJiBz2XR8nOa1sWVj4qpCzv87/Waiz75TYG2sOn8qn/Mu1Piot4Vtn
        ZRdfF8auEDVRMmamz9qTl/TjXN/cdfb57+8UnKD9mePfobsTNsrUvGffkKalLSx4Z3J0UkKJ
        QOXasG0PH7+aU5ly09uR7Xbinl9hF45HRXA+eLqQY8mvPXGx6mUfpjRXJ0rkTnbiS22QaZpw
        bPuueVmsfMUdZdM0//ycpvbu2UxhQb7AjVZzPp+ZxvvKim1t/cHVocH7fz5j8do9bXIV672r
        Nb+OfH0xc/tF8bv+/K9FBXddnfu5PWzRLa3jLVJnRdbFz3iq9eO45KSvVpeOuTHsEXnn3nXq
        kcxuw8NKLMUZiYZazEXFiQCykvrBSwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHLMWRmVeSWpSXmKPExsWy7bCSnK7F64Ikg+1ThC2eHFnEbtG8eD2b
        xfU/7xkt2p9fYLPY+PYHk8XlXXPYLBYta2W2aN40hdXi9YcmFouZa5Utuu7eYHTg9pjV0Mvm
        cbmvl8ljwaZSj8V7XjJ5zDsZ6LF/7hp2j74tqxg9Pm+SC+CI4rJJSc3JLEst0rdL4MqY8uQ/
        a8FxlYp1L/awNjBulOli5OSQEDCR2PF6B1MXIxeHkMAORomlr96xQyQkJZbOvQFlC0vcbznC
        ClH0iFFi9dmpbCAJFgEViXePpoHZbAJaEvd+nGAGsUUEDCW+XdrOCNLALLCAWeJc2zywImEB
        W4lfW3cygti8AtoS0//tZYSY+oZJ4u+v9ywQCUGJkzOfgNnMQFNv/HsJdB8HkC0tsfwfB0iY
        U8BZ4sLmB8wgYVGgI14drJ/AKDgLSfMsJM2zEJoXMDKvYpRMLSjOTc8tNiwwykst1ytOzC0u
        zUvXS87P3cQIjiItrR2Me1Z90DvEyMTBeIhRgoNZSYTXeWlBkhBvSmJlVWpRfnxRaU5q8SFG
        aQ4WJXHeC10n44UE0hNLUrNTUwtSi2CyTBycUg1MgpPZPzFxpL8X2J+us76povAKJ9vlPxcX
        l/QlPfLlst+VwxTYN2+zYsHz+mfzb+vPlhCZdcYpZpbniUXK03qvS3eYnUxRuSdQkFrfdOdC
        xsuszf5X1ymaaM7Ld1dqtcrj39d3eRfbt9A7LQHiZlOFJ5w6Zau/nelBs+uCCbceTshmZtq9
        Ob/G5llsrfLD5ZnpPiWF567Oi2bZZSQn9p7jUV6T/HT3p4c+T/arn61xwl9lFsf8U9qvJ0bc
        rbKTiLxy7UXdmv+vFqxqmb5BcKa4l9rbfRusPuaFncgK7U4ui8zf1MO/6d12tmud9q2yK06v
        vX7rkaDU4ym/sjYtSYnqXsscdNXwyBu7/adL1HYfVmIpzkg01GIuKk4EAM8wjLURAwAA
X-CMS-MailID: 20220503084336epcas2p385b5af3e2bd129a9984c9b6c345b51fc
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----kYpNrMA5Q_pRug.oZbu8Kwk_59qkkrrEmQqQB0Vp_jfuzgSx=_60345_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220426092023epcas2p32946c087135ca4b7e63b03915060c55d
References: <1650964728-175347-1-git-send-email-dh10.jung@samsung.com>
        <CGME20220426092023epcas2p32946c087135ca4b7e63b03915060c55d@epcas2p3.samsung.com>
        <1650964728-175347-6-git-send-email-dh10.jung@samsung.com>
        <b9fcc518-cc0d-d346-774e-3a9472e664bc@linux.intel.com>
        <20220428030319.GA139938@ubuntu>
        <0f84e8d4-451f-693a-d098-517dc6235a0f@linux.intel.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------kYpNrMA5Q_pRug.oZbu8Kwk_59qkkrrEmQqQB0Vp_jfuzgSx=_60345_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Thu, Apr 28, 2022 at 03:28:49PM +0300, Mathias Nyman wrote:
> On 28.4.2022 6.03, Jung Daehwan wrote:
> > On Wed, Apr 27, 2022 at 07:25:21PM +0300, Mathias Nyman wrote:
> >> On 26.4.2022 12.18, Daehwan Jung wrote:
> >>> This driver is for Samsung Exynos xhci host conroller. It uses xhci-plat
> >>> driver mainly and extends some functions by xhci hooks and overrides.
> >>>
> >>> It supports USB Audio offload with Co-processor. It only cares DCBAA,
> >>> Device Context, Transfer Ring, Event Ring, and ERST. They are allocated
> >>> on specific address with xhci hooks. Co-processor could use them directly
> >>> without xhci driver after then.
> >>>
> >>> Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
> >>
> >> I have to agree with Krzysztof's comments, this is an odd driver stub.
> >>
> >> Perhaps open up a bit how the Exynos offloading works so we can figure out
> >> in more detail what the hardware needs from software.  
> >>
> >> (...)
> > 
> >>> +static int xhci_alloc_segments_for_ring_uram(struct xhci_hcd *xhci,
> >>> +		struct xhci_segment **first, struct xhci_segment **last,
> >>> +		unsigned int num_segs, unsigned int cycle_state,
> >>> +		enum xhci_ring_type type, unsigned int max_packet, gfp_t flags,
> >>> +		u32 endpoint_type)
> >>> +{
> >>> +	struct xhci_segment *prev;
> >>> +	bool chain_links = false;
> >>> +
> >>> +	while (num_segs > 0) {
> >>> +		struct xhci_segment *next = NULL;
> >>> +
> >>> +		if (!next) {
> >>> +			prev = *first;
> >>> +			while (prev) {
> >>> +				next = prev->next;
> >>> +				xhci_segment_free(xhci, prev);
> >>> +				prev = next;
> >>> +			}
> >>> +			return -ENOMEM;
> >>
> >> This always return -ENOMEM
> > 
> > Yes. it's right to return error here.
> > 
> 
> Still don't think that is the case.
> 
> So if the num_segs value passed to a function named
> xhci_alloc_segments_for_ring_uram() is anything else than 0, it will 
> automatically return -ENOMEM?
> 
> >>
> >> Also this whole function never allocates or remaps any memory.
> > 
> > This fuctions is for link segments. Right below function(xhci_ring_alloc_uram)
> > allocates.
> 
> Still doesn't allocate any ring segments.
> Below function only allocates memory for the
> ring structure that contains pointers to segments.
> 

When I re-check it, it has a problem as you said.
I will modify it on next submission. Thanks.

Best Regards,
Jung Daehwan

> > 
> >>
> >>> +		}
> >>> +		xhci_link_segments(prev, next, type, chain_links);
> >>> +
> >>> +		prev = next;
> >>> +		num_segs--;
> >>> +	}
> >>> +	xhci_link_segments(prev, *first, type, chain_links);
> >>> +	*last = prev;
> >>> +
> >>> +	return 0;
> >>> +}
> >>> +
> >>> +static struct xhci_ring *xhci_ring_alloc_uram(struct xhci_hcd *xhci,
> >>> +		unsigned int num_segs, unsigned int cycle_state,
> >>> +		enum xhci_ring_type type, unsigned int max_packet, gfp_t flags,
> >>> +		u32 endpoint_type)
> >>> +{
> >>> +	struct xhci_ring	*ring;
> >>> +	int ret;
> >>> +	struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
> >>> +
> >>> +	ring = kzalloc_node(sizeof(*ring), flags, dev_to_node(dev));
> >>> +	if (!ring)
> >>> +		return NULL;
> >>> +
> >>> +	ring->num_segs = num_segs;
> >>> +	ring->bounce_buf_len = max_packet;
> >>> +	INIT_LIST_HEAD(&ring->td_list);
> >>> +	ring->type = type;
> >>> +	if (num_segs == 0)
> >>> +		return ring;
> >>> +
> >>> +	ret = xhci_alloc_segments_for_ring_uram(xhci, &ring->first_seg,
> >>> +			&ring->last_seg, num_segs, cycle_state, type,
> >>> +			max_packet, flags, endpoint_type);
> >>> +	if (ret)
> >>> +		goto fail;
> >>> +
> >>> +	/* Only event ring does not use link TRB */
> >>> +	if (type != TYPE_EVENT) {
> >>> +		/* See section 4.9.2.1 and 6.4.4.1 */
> >>> +		ring->last_seg->trbs[TRBS_PER_SEGMENT - 1].link.control |=
> >>> +			cpu_to_le32(LINK_TOGGLE);
> >>
> >> No memory was allocated for trbs
> > 
> > Allcation function for trbs are missed. It's done by ioremap.
> > I will add it on next submission. Thanks for the comment.
> > 
> >>
> >> A lot of this code seems to exists just to avoid xhci driver from allocating
> >> dma capable memory, we can refactor the existing xhci_mem_init() and move
> >> dcbaa and event ring allocation and other code to their own overridable
> >> functions.
> >>
> >> This way we can probably get rid of a lot of the code in this series.
> > 
> > Yes right. I think it's proper. Do you agree with it or have better way
> > to do it?
> 
> Could be, but I don't have a good picture of how this Exynos audio offloading
> works, so it's hard to guess.
> 
> Thanks
> -Mathias
> 

------kYpNrMA5Q_pRug.oZbu8Kwk_59qkkrrEmQqQB0Vp_jfuzgSx=_60345_
Content-Type: text/plain; charset="utf-8"


------kYpNrMA5Q_pRug.oZbu8Kwk_59qkkrrEmQqQB0Vp_jfuzgSx=_60345_--
