Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506C44E4C15
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 06:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241398AbiCWFUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 01:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiCWFUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 01:20:33 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C15752E71
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 22:19:03 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220323051857epoutp037257cb9849a5e3473787f7bc8a4056b7~e6tpd9_vQ2765327653epoutp03U
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 05:18:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220323051857epoutp037257cb9849a5e3473787f7bc8a4056b7~e6tpd9_vQ2765327653epoutp03U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1648012737;
        bh=kJghBK4LTx2n1yJ480vWQtgkrlThAH3ekZoBQS/Yp9E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vZT/pg2IErlbHPxe7+xPpNTreLwwAOb+YZhPFSOf8/zdLlDfDW4NSfPeaN42Rg840
         mBLGXMmWIdjFG8UQFMwG97KZ81vzYFhJ1vi5ffJ0EmihTXonKBXGs+AAGUzGfDxtdW
         e0xTcn1DKK24ae3AFdAWQl65N4jQ5PSTkO4Z2Kic=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20220323051856epcas2p377dbe6877a169c2e038df6f42b3ed74c~e6tobubWb1159711597epcas2p3B;
        Wed, 23 Mar 2022 05:18:56 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.98]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4KNc8Y3SJGz4x9Q9; Wed, 23 Mar
        2022 05:18:53 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        8B.AF.16040.ABDAA326; Wed, 23 Mar 2022 14:18:51 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20220323051850epcas2p325992720abc4f04f59e8974eb30bf6b1~e6tjVjXid1192411924epcas2p3y;
        Wed, 23 Mar 2022 05:18:50 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220323051850epsmtrp2d343039b857d3b5f38c1e8da0ce89b03~e6tjUtkQb0466304663epsmtrp2_;
        Wed, 23 Mar 2022 05:18:50 +0000 (GMT)
X-AuditID: b6c32a46-be9ff70000023ea8-4b-623aadba1c6f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        8D.66.03370.ABDAA326; Wed, 23 Mar 2022 14:18:50 +0900 (KST)
Received: from ubuntu (unknown [12.36.155.120]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220323051850epsmtip2abd9a1cf13d7ebe80362dda8a34c1e2b~e6tjKrx5S2204422044epsmtip28;
        Wed, 23 Mar 2022 05:18:50 +0000 (GMT)
Date:   Wed, 23 Mar 2022 14:17:32 +0900
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
Subject: Re: [PATCH v3 4/4] usb: host: add xhci-exynos driver
Message-ID: <20220323051732.GE19041@ubuntu>
MIME-Version: 1.0
In-Reply-To: <d5161e80-789b-8481-3b8f-bf0cfd9875b6@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPJsWRmVeSWpSXmKPExsWy7bCmhe7utVZJBjObmSyeHFnEbtG8eD2b
        xfU/7xkt2p9fYLM4f34Du8XlXXPYLBYta2W2aN40hdVi5lpli667NxgduDwu9/UyeSzYVOqx
        eM9LJo9NqzrZPPbPXcPu0bdlFaPH501yAexR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYG
        hrqGlhbmSgp5ibmptkouPgG6bpk5QNcpKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtS
        cgrMC/SKE3OLS/PS9fJSS6wMDQyMTIEKE7Izbk7fx16wXKHi3/oW5gbGiVJdjBwcEgImElPv
        JHcxcnEICexglDh2+ykrhPOJUeLOxkYWCOczo8SMWauZuxg5wTquv77KDJHYxSixsO01VMsT
        oKrNG9lBqlgEVCX2N/9gArHZBLQk7v04AdYtIqApcf3vd7AGZoHHTBIt76aDNQgL2Epcv3kP
        zOYV0JZYc3sTI4QtKHFy5hMWEJtTwE7i9aKNLCCHiwqoSLw6WA8yR0JgJofE95ufGSHOc5Fo
        n/WFFcIWlnh1fAs7hC0l8fndXjYIu1hi16dWJojmBkaJxgcnoH4zlpj1rB1sELNApsSq++eZ
        IKGkLHHkFgtEmE+i4/Bfdogwr0RHmxBEp7LE9MsToNZKShx8fQ5qoofE9G/HocHYySTR/Wop
        6wRG+VlIXpuFZBuErSOxYPcntllAK5gFpCWW/+OAMDUl1u/SX8DIuopRLLWgODc9tdiowAge
        28n5uZsYwSlXy20H45S3H/QOMTJxMB5ilOBgVhLhXfzBPEmINyWxsiq1KD++qDQntfgQoykw
        oiYyS4km5wOTfl5JvKGJpYGJmZmhuZGpgbmSOK9XyoZEIYH0xJLU7NTUgtQimD4mDk6pBqZN
        zGveRk55O9f1vUrai6qah1+CjwZM5bCfYVooHZKd/er0D29WgQlXGfYlVCh3XHjy9VlJqrDZ
        xbp3W5+z6wqde7j0wSHljG1cp3obn9j2fXywIuiPzLbAPZ8XT9Z8KGbyQFLkmpaaYtVfDX9d
        Zj7Jk9euVcc5OaVGu+jy1E+4a5C9q1oiyVRv87Y1iUe+7F57bkPyKUHfMqvzr+z63FXae44K
        TzDpEH4cIFg+P/lrytK/YW8iI1ZuYVviMX+LvbR1146le509/t99yXze/oW8z+vLy7YZcE7v
        /PY+zINP3WT7Tlu7EHGl2vUde4zXV5hMSVrWwnLWJ3TlwaKC0jSX9JBLD8RE3v7n1Phru1uJ
        pTgj0VCLuag4EQA5e2LzQgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrELMWRmVeSWpSXmKPExsWy7bCSvO6utVZJBn/OqFg8ObKI3aJ58Xo2
        i+t/3jNatD+/wGZx/vwGdovLu+awWSxa1sps0bxpCqvFzLXKFl13bzA6cHlc7utl8liwqdRj
        8Z6XTB6bVnWyeeyfu4bdo2/LKkaPz5vkAtijuGxSUnMyy1KL9O0SuDK+H+EoeCJb8fdqYgPj
        c/EuRk4OCQETieuvrzKD2EICOxgl+qeXQsQlJZbOvcEOYQtL3G85wtrFyAVU84hRouvQakaQ
        BIuAqsT+5h9MIDabgJbEvR8nwAaJCGhKXP/7HayBWeApk8TijW1gRcICthLXb94Dm8oroC2x
        5vYmRoipnUwS56ddg0oISpyc+YQFxGYGmnrj30ugZg4gW1pi+T8OkDCngJ3E60UbWUDCogIq
        Eq8O1k9gFJyFpHkWkuZZCM0LGJlXMUqmFhTnpucWGxYY5aWW6xUn5haX5qXrJefnbmIER4uW
        1g7GPas+6B1iZOJgPMQowcGsJMK7+IN5khBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeC10n44UE
        0hNLUrNTUwtSi2CyTBycUg1MbAFJB27Ll71qXRn4TWfVhN965Z3qC6q+85hpvzRZmnx8e+t9
        m506LVo750277HGa1/GgyO+u+Ul/3ZVbPmoKFlv2+PGrZic0x7JunBRx5uKXu+dVD0x7cNQt
        VjG70MF86dH1qrNMKvKSVBKryz9IuRm1FyUnmG4uS2J5pMjw1Oa4VtYqc8kJi7felXr+cPWr
        eTbeS7qeHGXh+7Lk2+tkv8ZvrxZltOjvOjXZKeOR1NdekTUTIibM/KJgtN630+lEmmL/yunx
        r7a82nbaKn2imJTuwoSkwx+0d6hdmibm/KloT1v2lln5KvKux5yztwlM6ClKZmv5F23PaXVb
        kD38gmr6y2+9UkfSzy9n17ykxFKckWioxVxUnAgAxr3VjgUDAAA=
X-CMS-MailID: 20220323051850epcas2p325992720abc4f04f59e8974eb30bf6b1
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----Jd1PkHJvbSWK3nTfpzLY69px07-gfkp_xqPU6voikj1qGUH4=_23a535_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220321090205epcas2p15ac16f281554b663062e0e31666defab
References: <1647853194-62147-1-git-send-email-dh10.jung@samsung.com>
        <CGME20220321090205epcas2p15ac16f281554b663062e0e31666defab@epcas2p1.samsung.com>
        <1647853194-62147-5-git-send-email-dh10.jung@samsung.com>
        <d5161e80-789b-8481-3b8f-bf0cfd9875b6@kernel.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------Jd1PkHJvbSWK3nTfpzLY69px07-gfkp_xqPU6voikj1qGUH4=_23a535_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Tue, Mar 22, 2022 at 06:16:58PM +0100, Krzysztof Kozlowski wrote:
> On 21/03/2022 09:59, Daehwan Jung wrote:
> > This driver supports USB Audio offload with Co-processor.
> > It only cares DCBAA, Device Context, Transfer Ring, Event Ring, and ERST.
> > They are allocated on specific address with xhci hooks.
> > Co-processor could use them directly without xhci driver after then.
> > 
> > Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
> > ---
> >  drivers/usb/host/Kconfig       |   9 +
> >  drivers/usb/host/Makefile      |   1 +
> >  drivers/usb/host/xhci-exynos.c | 982 +++++++++++++++++++++++++++++++++
> >  drivers/usb/host/xhci-exynos.h |  63 +++
> >  4 files changed, 1055 insertions(+)
> >  create mode 100644 drivers/usb/host/xhci-exynos.c
> >  create mode 100644 drivers/usb/host/xhci-exynos.h
> > 
> > diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> > index 57ca5f97a3dc..850e6b71fac5 100644
> > --- a/drivers/usb/host/Kconfig
> > +++ b/drivers/usb/host/Kconfig
> > @@ -783,3 +783,12 @@ config USB_XEN_HCD
> >  	  by the Xen host (usually Dom0).
> >  	  Only needed if the kernel is running in a Xen guest and generic
> >  	  access to a USB device is needed.
> > +
> > +config USB_XHCI_EXYNOS
> > +	tristate "XHCI support for Samsung Exynos SoC Series"
> > +	depends on ARCH_EXYNOS || COMPILE_TEST
> > +	help
> > +	  Enable support for the Samsung Exynos SOC's on-chip XHCI
> > +	  controller.
> > +
> > +	  If unsure, say N.
> > diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
> > index 2948983618fb..300f22b6eb1b 100644
> > --- a/drivers/usb/host/Makefile
> > +++ b/drivers/usb/host/Makefile
> > @@ -86,3 +86,4 @@ obj-$(CONFIG_USB_HCD_SSB)	+= ssb-hcd.o
> >  obj-$(CONFIG_USB_FOTG210_HCD)	+= fotg210-hcd.o
> >  obj-$(CONFIG_USB_MAX3421_HCD)	+= max3421-hcd.o
> >  obj-$(CONFIG_USB_XEN_HCD)	+= xen-hcd.o
> > +obj-$(CONFIG_USB_XHCI_EXYNOS)	+= xhci-exynos.o
> > diff --git a/drivers/usb/host/xhci-exynos.c b/drivers/usb/host/xhci-exynos.c
> > new file mode 100644
> > index 000000000000..19ee21f1d024
> > --- /dev/null
> > +++ b/drivers/usb/host/xhci-exynos.c
> > @@ -0,0 +1,982 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * xhci-exynos.c - xHCI host controller driver platform Bus Glue for Exynos.
> > + *
> > + * Copyright (C) 2022 Samsung Electronics Incorporated - http://www.samsung.com
> > + * Author: Daehwan Jung <dh10.jung@samsung.com>
> > + *
> > + * A lot of code borrowed from the Linux xHCI driver.
> > + */
> > +#include <linux/clk.h>
> > +#include <linux/dma-mapping.h>
> > +#include <linux/module.h>
> > +#include <linux/pci.h>
> > +#include <linux/of.h>
> > +#include <linux/of_device.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/usb/phy.h>
> > +#include <linux/slab.h>
> > +#include <linux/acpi.h>
> > +#include <linux/usb/of.h>
> > +
> > +#include "xhci.h"
> > +#include "xhci-plat.h"
> > +#include "xhci-mvebu.h"
> > +#include "xhci-rcar.h"
> 
> Could you explain why do you need RCAR and Marvell code in Exynos? Is it
> even a real driver here? On what platforms this can be tested? Where are
> the bindings?

2 headers you said are not needed. I'm going to remove it on next
submission. I tested on Exynos platform and it's real driver. I haven't
made bindings.

> 
> 
> (...)
> 
> 
> > +static const struct of_device_id usb_xhci_of_match[] = {
> > +	{
> > +		.compatible = "generic-xhci",
> > +	}, {
> > +		.compatible = "xhci-platform",
> > +	},
> > +	{},
> > +};
> > +MODULE_DEVICE_TABLE(of, usb_xhci_of_match);
> > +#endif
> 
> No, this not generic-xhci but Exynos driver. This does not make any sense.
> 

I agree with you and I'm going to remove it.

> 
> Best regards,
> Krzysztof
> 

------Jd1PkHJvbSWK3nTfpzLY69px07-gfkp_xqPU6voikj1qGUH4=_23a535_
Content-Type: text/plain; charset="utf-8"


------Jd1PkHJvbSWK3nTfpzLY69px07-gfkp_xqPU6voikj1qGUH4=_23a535_--
