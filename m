Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E574CFC5D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 12:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237070AbiCGLLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 06:11:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237782AbiCGLK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 06:10:56 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D945549E
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 02:33:04 -0800 (PST)
Received: from epcas3p4.samsung.com (unknown [182.195.41.22])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220307103302epoutp01bb4f8678611f00199aada29685d44d00~aErUGbt2V1552315523epoutp01Z
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 10:33:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220307103302epoutp01bb4f8678611f00199aada29685d44d00~aErUGbt2V1552315523epoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1646649182;
        bh=fZlgU1nbX7F2XKQr2SixygYb5L+8CKc3dsNWy01m7+E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BwywJxE5cAHxdgkDe+Q7HVQB3HTd9zIxpyq8h6f53x65JUbhTut77M1ov6CMcfj1d
         mMN5RlOhrayzcwXdEwcf2WFQ9i0GCNG6MUFxs/Aj6uSQVMXlCUjAriFCVCE1WsNG9Q
         BmdhyFy9vROKkIIbwj5J0C2Xk/9ISQsqM33KFbA8=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas3p4.samsung.com (KnoxPortal) with ESMTP id
        20220307103301epcas3p42a0d12ad0ab318c6b3df330fe90e526f~aErTh6_l22736127361epcas3p4A;
        Mon,  7 Mar 2022 10:33:01 +0000 (GMT)
Received: from epcpadp4 (unknown [182.195.40.18]) by epsnrtp4.localdomain
        (Postfix) with ESMTP id 4KBvtP5ltVz4x9Q6; Mon,  7 Mar 2022 10:33:01 +0000
        (GMT)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20220307102715epcas2p3dbe8b3cd5683daa900849e208bb6406e~aEmRUI9fZ3131931319epcas2p3F;
        Mon,  7 Mar 2022 10:27:15 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220307102715epsmtrp2c799d1036d4f3796c5e0405e400d20b7~aEmRTIPQs3120831208epsmtrp2L;
        Mon,  7 Mar 2022 10:27:15 +0000 (GMT)
X-AuditID: b6c32a29-41fff700000074af-a4-6225de039ad9
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F1.32.29871.30ED5226; Mon,  7 Mar 2022 19:27:15 +0900 (KST)
Received: from ubuntu (unknown [12.36.155.120]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220307102715epsmtip285bb1fbbb799031fc22ac7835679adae~aEmRFvutL1012810128epsmtip2Q;
        Mon,  7 Mar 2022 10:27:15 +0000 (GMT)
Date:   Mon, 7 Mar 2022 19:26:11 +0900
From:   Jung Daehwan <dh10.jung@samsung.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Howard Yen <howardyen@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        Puma Hsu <pumahsu@google.com>,
        "J . Avila" <elavila@google.com>,
        "chihhao . chen" <chihhao.chen@mediatek.com>, sc.suh@samsung.com,
        cpgs@samsung.com, cpgsproxy5@samsung.com
Subject: Re: [PATCH v1 4/4] usb: host: add xhci-exynos module
Message-ID: <1983025922.01646649181793.JavaMail.epsvc@epcpadp4>
MIME-Version: 1.0
In-Reply-To: <32e72657-a43d-0ae1-1bf2-d15b7426765f@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnkeLIzCtJLcpLzFFi42LZdlhJXpf5nmqSwabfuhYrDs9jtHh5SNNi
        88MrbBZPjixit2hevJ7N4vqf94wW7c8vsFmcP7+B3eLyrjlsFouWtTJbNG+awmoxc62yxds7
        01ksuu7eYHTg87jc18vksWBTqcfmFVoei/e8ZPLYtKqTzWP/3DXsHi0n97N49G1ZxejxeZNc
        AGcUl01Kak5mWWqRvl0CV8auU7+ZCxpEK15uVG9g/CLQxcjJISFgInFnwxvGLkYuDiGB3YwS
        19tesUEkJCWWzr3BDmELS9xvOcIKUfSIUWLTvOPMXYwcHCwCKhKTLpeB1LAJaEnc+3GCGcQW
        EdCUuP73O1g9s8BzZonOG5eZQBLCArYSy46/BCviFdCR2HJ2NwvE0GYmib+dIBtAEoISJ2c+
        YQGxmYGm3vj3kglkGbOAtMTyfxwgYU4BO4k9n5exgoRFgW54dbB+AqPgLCTNs5A0z0JoXsDI
        vIpRMrWgODc9t9iwwDAvtVyvODG3uDQvXS85P3cTIzjOtDR3MG5f9UHvECMTB+MhRgkOZiUR
        3vvnVZKEeFMSK6tSi/Lji0pzUosPMUpzsCiJ817oOhkvJJCeWJKanZpakFoEk2Xi4JRqYBJb
        3bFq4RQLzkjFsqZPT615ejvjrd4p77ydbNrtk6jc8SfVmq9BxlV4wq5/X1mzVEwjDpUw2Cdv
        q/TSWpb++e6rpJznuo5FnhMcxcUtbUMrzzLJV+srKM3fFHDr8seKg3Xs/HwOhXenCKvXB52S
        mHBvxu5fBgYxH6exCCfU9Z5L5pzlyyllur75rzD/ij9lBvP7jrzXTnAXEvrDl2E142u++P/5
        Sa8ZdyzpqDKUbo7dHy9S1ii8jH+PddvxmY3s39Y8Vn19Kuj67ysGoQE2JqeXCEy7Es1mqfn+
        6y2WuE//j74QZ3j5Nu9o5e6cB+cvbli5pO/U3kdMSc9/S39aeqvB79UWP44qleqnIWY7lViK
        MxINtZiLihMBuSdceyIDAAA=
X-CMS-MailID: 20220307102715epcas2p3dbe8b3cd5683daa900849e208bb6406e
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----CUqsqxLmMDErsaokmqc0SEMtAD8UUZAtQ-YfwGBggeHIq32N=_19fca8_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20220304062618epcas2p2e3c73b5c4ed0c9bc0ca0c02aa658d3fb
References: <1646375038-72082-1-git-send-email-dh10.jung@samsung.com>
        <CGME20220304062618epcas2p2e3c73b5c4ed0c9bc0ca0c02aa658d3fb@epcas2p2.samsung.com>
        <1027007693.21646375582736.JavaMail.epsvc@epcpadp4>
        <32e72657-a43d-0ae1-1bf2-d15b7426765f@kernel.org>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------CUqsqxLmMDErsaokmqc0SEMtAD8UUZAtQ-YfwGBggeHIq32N=_19fca8_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Mon, Mar 07, 2022 at 11:07:04AM +0100, Krzysztof Kozlowski wrote:
> On 04/03/2022 07:23, Daehwan Jung wrote:
> > Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
> 
> +Cc Randy,
> I guess here is the rest of the patches.
> 
> > ---
> >  drivers/usb/host/xhci-exynos.c | 2025 ++++++++++++++++++++++++++++++++
> >  drivers/usb/host/xhci-exynos.h |  150 +++
> >  2 files changed, 2175 insertions(+)
> >  create mode 100644 drivers/usb/host/xhci-exynos.c
> >  create mode 100644 drivers/usb/host/xhci-exynos.h
> > 
> > diff --git a/drivers/usb/host/xhci-exynos.c b/drivers/usb/host/xhci-exynos.c
> > new file mode 100644
> > index 000000000000..3913c48d4b20
> > --- /dev/null
> > +++ b/drivers/usb/host/xhci-exynos.c
> > @@ -0,0 +1,2025 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * xhci-exynos.c - xHCI host controller driver platform Bus Glue for Exynos.
> > + *
> > + * Copyright (C) 2022 Samsung Electronics Incorporated - http://www.samsung.com
> > + * Author: Daehwan Jung <dh10.jung@samsung.com>
> > + *
> > + * A lot of code borrowed from the Linux xHCI driver.
> 
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/dma-mapping.h>
> > +#include <linux/module.h>
> > +#include <linux/pci.h>
> > +#include <linux/of.h>
> > +#include <linux/of_device.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/usb/phy.h>
> > +#include <linux/slab.h>
> > +#include <linux/phy/phy.h>
> > +#include <linux/acpi.h>
> > +#include <linux/usb/of.h>
> > +#ifdef CONFIG_SND_EXYNOS_USB_AUDIO
> 
> This does not exist.
> 
> Please do not add dead code to Linux kernel.
> 
> > +#include "../../../sound/usb/exynos_usb_audio.h"
> > +#include <linux/types.h>
> > +#include "xhci-trace.h"
> > +#endif
> > +
> > +#include "../core/hub.h"
> > +#include "../core/phy.h"
> > +#include "xhci.h"
> > +#include "xhci-plat.h"
> > +#include "xhci-mvebu.h"
> > +#include "xhci-rcar.h"
> > +#include "../dwc3/dwc3-exynos.h"
> > +#include "../dwc3/exynos-otg.h"
> 
> No, how XHCI is related to dwc3? What if different block provides XHCI,
> not DWC3?
> 
> > +#include "xhci-exynos.h"
> > +#include <soc/samsung/exynos-cpupm.h>
> 
> This does not exist and does not even compile.
> 
> Please do not send code which does not compile... Also, just in case -
> do not send code which compiles but does not work. :)
> 

Hi Krzysztof

I'm sorry to confuse you. But, it's just for reference module to introduce
new feature. That's why I just submitted source code and header without
makefile. It's not going to compiled at all now.

Best Regards,
Jung Deahwan

> 
> Best regards,
> Krzysztof
> 

------CUqsqxLmMDErsaokmqc0SEMtAD8UUZAtQ-YfwGBggeHIq32N=_19fca8_
Content-Type: text/plain; charset="utf-8"


------CUqsqxLmMDErsaokmqc0SEMtAD8UUZAtQ-YfwGBggeHIq32N=_19fca8_--

