Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869A14E4B8E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 04:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241585AbiCWDjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 23:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241568AbiCWDji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 23:39:38 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D07A1AE
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 20:38:07 -0700 (PDT)
Received: from epcas3p1.samsung.com (unknown [182.195.41.19])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220323033802epoutp01eefde4ef54516fbc29ef472cf2cdaa3b~e5ViP32MT0914309143epoutp01x
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 03:38:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220323033802epoutp01eefde4ef54516fbc29ef472cf2cdaa3b~e5ViP32MT0914309143epoutp01x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1648006682;
        bh=FQaLKd2erici8vsoO9zSyNtJCqO3u0HXcPrt9iVrkYA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mrBjBkRdVQsT9rp6blo/tOexX3R5bVLOvdKgOnH0QEHhQwQSRL88WwRMMWICTVogI
         o9gY4BVeUifBmWf5pybWbhLaqDep5UI/dhhMpP90TQRUzi2Pcplwq/9ncYatuHtyIc
         7Wvlj7P0tJ5C7m7U1S8KFjOWgyVT7Ifagelzoi2E=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas3p3.samsung.com (KnoxPortal) with ESMTP id
        20220323033801epcas3p395dca4e3b7fd2113bad3ab1ed400bf4b~e5Vh2IHKq0245902459epcas3p3p;
        Wed, 23 Mar 2022 03:38:01 +0000 (GMT)
Received: from epcpadp4 (unknown [182.195.40.18]) by epsnrtp4.localdomain
        (Postfix) with ESMTP id 4KNYw951Qqz4x9Q6; Wed, 23 Mar 2022 03:38:01 +0000
        (GMT)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20220323025940epcas2p36e925e1bd3dff09a4731681a21af834f~e40CtTTqt0982309823epcas2p3w;
        Wed, 23 Mar 2022 02:59:40 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220323025940epsmtrp24771a1c1981c24b47822abf031f8c421~e40CsgtOg1462614626epsmtrp2q;
        Wed, 23 Mar 2022 02:59:40 +0000 (GMT)
X-AuditID: b6c32a2a-36bff70000000d2a-2b-623a8d1c6f36
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        11.26.03370.C1D8A326; Wed, 23 Mar 2022 11:59:40 +0900 (KST)
Received: from ubuntu (unknown [12.36.155.120]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220323025940epsmtip15d246c2b6046272ca91721ef18ab83bc~e40Cecu7y1182711827epsmtip1i;
        Wed, 23 Mar 2022 02:59:40 +0000 (GMT)
Date:   Wed, 23 Mar 2022 11:58:22 +0900
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
Message-ID: <1983025922.01648006681661.JavaMail.epsvc@epcpadp4>
MIME-Version: 1.0
In-Reply-To: <b33d8497-d6d5-18e2-93a9-e0564a84c1c5@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjkeLIzCtJLcpLzFFi42LZdlhJTlem1yrJ4OlRaYsVh+cxWrw8pGmx
        +eEVNosnRxaxWzQvXs9mcf3Pe0aL9ucX2CzOn9/AbnF51xw2i0XLWpktmjdNYbWYuVbZouvu
        DUYHXo/Lfb1MHgs2lXos3vOSyWPTqk42j/1z17B7tJzcz+LRt2UVo8fnTXIBHFFcNimpOZll
        qUX6dglcGac/7GEu2CxQ8bqrma2BcRdPFyMnh4SAicSex/9Zuxi5OIQEdjBKXNzQwQaRkJRY
        OvcGO4QtLHG/5QgriC0k8IhRYuVB/y5GDg4WAVWJf0vFQcJsAloS936cYAaxRQQ0Ja7//Q42
        k1lgP7PE9/1nwRLCAl4SP599A5vDK6At8eXMLhaIxU1MEv3/GpkgEoISJ2c+YQGxmYGm3vj3
        kglkGbOAtMTyfxwgYU4BO4ml7RBhUQEViVcH6ycwCs5C0jwLSfMshOYFjMyrGCVTC4pz03OL
        DQuM8lLL9YoTc4tL89L1kvNzNzGCo0pLawfjnlUf9A4xMnEwHmKU4GBWEuFd/ME8SYg3JbGy
        KrUoP76oNCe1+BCjNAeLkjjvha6T8UIC6YklqdmpqQWpRTBZJg5OqQamqPSp56T5kqQ0mGIa
        oxgX5P1+efTnlO0hu84E56tq/tqjExyRPf/ZO9bLe3y3aduZPD9/o/xrZ25Js626YIhgy7Yl
        h7SUxGRvnjX+L7rh4/Qun5192qzzN1cvmTNjtv8E1hbPpd6sT+S/nzIuPra1eGPDo/+sjye9
        Fma5sTB9XWCY9M0dnTx/ViixLt755dShrICmL0dlGKrjUw6fmDife7b5OjPPWSmvbePMFRes
        uC+qmF3wV+DnRmspvetZ2+0TmYI3PTpnde+rX/SBC58jAlZ9bj6sdS3w+yb7t4LVPexup7f4
        tp+Wv6li7ef45snDUOZvVrFfQh/1X43ZKvnD+k6JThj/9VwLw7KKJQ6JSizFGYmGWsxFxYkA
        yRQrVhkDAAA=
X-CMS-MailID: 20220323025940epcas2p36e925e1bd3dff09a4731681a21af834f
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----.rW42XXn7_Ji6OxwuAF4RAMbP.qed.OeqKlvEhSLhB3noATS=_238f9d_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20220304062617epcas2p2084161966aaa66d07f4c25720ec18088
References: <1646375038-72082-1-git-send-email-dh10.jung@samsung.com>
        <CGME20220304062617epcas2p2084161966aaa66d07f4c25720ec18088@epcas2p2.samsung.com>
        <252651381.41646375583002.JavaMail.epsvc@epcpadp4>
        <b33d8497-d6d5-18e2-93a9-e0564a84c1c5@kernel.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------.rW42XXn7_Ji6OxwuAF4RAMbP.qed.OeqKlvEhSLhB3noATS=_238f9d_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Mon, Mar 07, 2022 at 10:59:06AM +0100, Krzysztof Kozlowski wrote:
> On 04/03/2022 07:23, Daehwan Jung wrote:
> > Export symbols for xhci hooks usage:
> > 	xhci_ring_free
> > 	- Allow xhci hook to free xhci_ring.
> 
> Instead of copying-pasting the name of function, please explain why do
> you need these symbols exported.
> 
> The "Why" is actually one of most important questions, because "what is
> this patch doing" we can easily see...
> 
> > 
> > 	xhci_get_slot_ctx
> > 	- Allow xhci hook to get slot_ctx from the xhci_container_ctx
> > 	  for getting the slot_ctx information to know which slot is
> > 	  offloading and compare the context in remote subsystem memory
> > 	  if needed.
> > 
> 
> 
> Best regards,
> Krzysztof
> 

Hi Krzysztof

xhci_ring_free has been removed from v3..
The reason why I want to export is for managing vendor specific ring.
I want to alloc and free vendor specific ring on specific address.
It's done with xhci hooks.

Below is the patch of v3

Export symbols for xhci hooks usage:
    xhci_get_slot_ctx
    xhci_get_endpoint_address
    - Allow xhci hook to get ep_ctx from the xhci_container_ctx for
      getting the ep_ctx information to know which ep is offloading and
      comparing the context in remote subsystem memory if needed.

    xhci_ring_alloc
    - Allow xhci hook to allocate vendor specific ring.

    xhci_trb_virt_to_dma
    - Used to retrieve the DMA address of vendor specific ring.

    xhci_segment_free
    xhci_link_segments
    - Allow xhci hook to handle vendor specific segment.

    xhci_initialize_ring_info
    - Allow xhci hook to initialize vendor specific ring.

    xhci_check_trb_in_td_math
    - Allow xhci hook to Check TRB math for validation.

    xhci_address_device
    - Allow override to give configuration info to Co-processor.

    xhci_bus_suspend
    xhci_bus_resume
    - Allow override of suspend and resume for power scenario.

    xhci_remove_stream_mapping
    - Allow xhci hook to remove stream mapping.

Best Regards,
Jung Daehwan.

------.rW42XXn7_Ji6OxwuAF4RAMbP.qed.OeqKlvEhSLhB3noATS=_238f9d_
Content-Type: text/plain; charset="utf-8"


------.rW42XXn7_Ji6OxwuAF4RAMbP.qed.OeqKlvEhSLhB3noATS=_238f9d_--

