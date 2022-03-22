Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3C34E36AB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 03:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235573AbiCVCdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 22:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235557AbiCVCdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 22:33:12 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723F13E5C1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 19:31:45 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220322023143epoutp01b031eb93de23d585172d9d627c244893~ekyWuTK001570315703epoutp018
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 02:31:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220322023143epoutp01b031eb93de23d585172d9d627c244893~ekyWuTK001570315703epoutp018
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1647916303;
        bh=Wg8ulElWefjUy8WdToGEm+k8v4gQftkGZswy6AnLq/o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UyxvlZugqtOJcYki3Qgc4ERzxrBbACb7BL42ZYkXI0dHffmJuRB1UncnxDTdVR8tj
         sN4JYRjEKggqM/z5oQ2OQ0uKZ+uMe4LUEYglcQ5acljc8D6r/veJPmKEKAovAPjV0e
         LvV5RmJqjWqbT6yGeKWD6TDhl1wPT7YaX9NkeXoE=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20220322023143epcas2p2b7b26fb7daf01ff136c85ae978dcc6d0~ekyWP4OA-1336213362epcas2p2v;
        Tue, 22 Mar 2022 02:31:43 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.98]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4KMwV06yTtz4x9QY; Tue, 22 Mar
        2022 02:31:36 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        BC.7A.10444.80539326; Tue, 22 Mar 2022 11:31:36 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20220322023135epcas2p1e01c89cf0a307b20f5aeb9a9cf2a419a~ekyPfb2Zd2973129731epcas2p1t;
        Tue, 22 Mar 2022 02:31:35 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220322023135epsmtrp26f301602e1fb4ca3e9ca5b4ced0def5a~ekyPesrEz0789107891epsmtrp2s;
        Tue, 22 Mar 2022 02:31:35 +0000 (GMT)
X-AuditID: b6c32a45-513ff700000228cc-72-623935081f11
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FD.AB.29871.70539326; Tue, 22 Mar 2022 11:31:35 +0900 (KST)
Received: from ubuntu (unknown [12.36.155.120]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220322023135epsmtip244cf20c177cf6796cce3b6f64947a76c~ekyPQ-wGC0206302063epsmtip2j;
        Tue, 22 Mar 2022 02:31:35 +0000 (GMT)
Date:   Tue, 22 Mar 2022 11:30:18 +0900
From:   Jung Daehwan <dh10.jung@samsung.com>
To:     =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Howard Yen <howardyen@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        Puma Hsu <pumahsu@google.com>,
        "J . Avila" <elavila@google.com>, sc.suh@samsung.com
Subject: Re: [PATCH v3 4/4] usb: host: add xhci-exynos driver
Message-ID: <20220322023018.GC67215@ubuntu>
MIME-Version: 1.0
In-Reply-To: <87r16v9uo2.fsf@miraculix.mork.no>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBJsWRmVeSWpSXmKPExsWy7bCmmS6HqWWSwe1fwhY/t7NZPDmyiN2i
        efF6Novrf94zWrQ/v8BmcXnXHDaLRctamS2aN01htZi5Vtmi6+4NRgcuj8t9vUweCzaVeize
        85LJY//cNeweBxdMZfTo27KK0ePzJrkA9qhsm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwND
        XUNLC3MlhbzE3FRbJRefAF23zByg45QUyhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkqpBSk5
        BeYFesWJucWleel6eaklVoYGBkamQIUJ2RnfN59mKZikWLF+3QTWBsYuqS5GTg4JAROJH1Mv
        soPYQgI7GCXm/jXvYuQCsj8xSjTtXcwMkfjGKPFsEi9Mw57uhywQRXsZJX7M+MIEUfSEUWLm
        V08Qm0VAVWLaW4g4m4CWxL0fJ8AGiQgYStze8h+smVlgO5PEyjWvwFYLC9hKXL95D8zmFdCW
        +HHmKSOELShxcuYTFhCbU0BfonP7BKChHByiAioSrw7Wg8yREFjJIfHh0gNWiOtcJL717WGC
        sIUlXh3fwg5hS0l8freXDcIultj1qZUJormBUaLxAcR1EgLGErOetYMtZhbIlJjc85sVZJmE
        gLLEkVssEGE+iY7Df9khwrwSHW1CEJ3KEtMvT4A6QVLi4OtzUBM9JKZ/Ow4NrF+MEquavrNN
        YJSfheS1WUi2Qdh6EjemTmGDsOUlmrfOZp4FtI5ZQFpi+T8OCFNTYv0u/QWMbKsYxVILinPT
        U4uNCgzh8Z6cn7uJEZyEtVx3ME5++0HvECMTB+MhRgkOZiUR3sUfzJOEeFMSK6tSi/Lji0pz
        UosPMZoCI20is5Rocj4wD+SVxBuaWBqYmJkZmhuZGpgrifN6pWxIFBJITyxJzU5NLUgtgulj
        4uCUamAqT/Y47rbnVPCbkB8ylbr6Bsoz2bdt+Kpoeiy5UEdq09r/CUfTE63P2HkdNL+W9Ht9
        xKN5TKaiXVqyi1/tzr9bUqfVvj3Q/qzMKck51/YuWJUQw+JdfvBasasGi7tn1nffL7XPTNer
        npHt4GriSzu24dCBm6ulApKEtuRc4fp45NfiTSvDZP8w28pM+PO/dXtgT1xjW5uNgHHBVG6e
        fa8/KtTEHqvnPPrn3mxOy7Ohy9ysGZ5NmXv695qdFwvX5t3erMPhKS1ktL/eUp+p7t0M7SeR
        Ioq7n6fuYFHXkW+vt+ssDluUnG/6d1H+5v2LVd2q1wp13U60vb0xeF5kr7Qk83mxz/fKO11t
        euZIqSmxFGckGmoxFxUnAgBvcCBwSwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupikeLIzCtJLcpLzFFi42LZdlhJXpfd1DLJ4PsiQ4uf29ksnhxZxG7R
        vHg9m8X1P+8ZLdqfX2CzuLxrDpvFomWtzBbNm6awWsxcq2zRdfcGowOXx+W+XiaPBZtKPRbv
        ecnksX/uGnaPgwumMnr0bVnF6PF5k1wAexSXTUpqTmZZapG+XQJXxuydm5kL1shV3HrWydjA
        eEC8i5GTQ0LARGJP90MWEFtIYDejRMumCIi4pMTSuTfYIWxhifstR1i7GLmAah4xSvxdPpsR
        JMEioCox7e0XJhCbTUBL4t6PE8wgtoiAocTtLf/BhjIL7GSS2DsxHcQWFrCVuH7zHthQXgFt
        iR9nnjJCDP3FKPFpaysbREJQ4uTMJ1DNOhI7t94BinMA2dISy/9xQITlJZq3zgbbxSmgL9G5
        fQITSImogIrEq4P1ExiFZiEZNAvJoFkIg2YhGbSAkWUVo2RqQXFuem6xYYFhXmq5XnFibnFp
        Xrpecn7uJkZwdGlp7mDcvuqD3iFGJg7GQ4wSHMxKIryLP5gnCfGmJFZWpRblxxeV5qQWH2KU
        5mBREue90HUyXkggPbEkNTs1tSC1CCbLxMEp1cCUa52wUO/132NXTm+Um3H9902+a6HKZy4u
        eqrNxyO8zSFy7aonT35nVvZ5dm1JXjNVbuf9Bq4fncfvKjnP8r268GyDu7hT1t7GST4M9wqt
        l03zX2Xv/d+5NlTWyb30Q7H+E6ZLxl0lteUOF24ou/ut7mrzefvu4rSQMGtB+YJNHYvD9yhN
        YrH185629pLcnfBOsU6v2+2RO6Zs+5QmoiaTf+uv38IdUU/L9KSZbKaF+K7e28z+aeW/v6tP
        3TONktbmNjhwN70vI2fu9TuyXPMWWEn+yrks8fkR35lF/A1H1l/c6OBRP49RP02EKybvSJ3v
        6ZLzrBwrYvXcfu4N/uS7qUnlmnrf3kDOSz8m3T6rxFKckWioxVxUnAgApwoBFx0DAAA=
X-CMS-MailID: 20220322023135epcas2p1e01c89cf0a307b20f5aeb9a9cf2a419a
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----.rW42XXn7_Ji6OxwuAF4RAMbP.qed.OeqKlvEhSLhB3noATS=_22cbc0_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220321090205epcas2p15ac16f281554b663062e0e31666defab
References: <1647853194-62147-1-git-send-email-dh10.jung@samsung.com>
        <CGME20220321090205epcas2p15ac16f281554b663062e0e31666defab@epcas2p1.samsung.com>
        <1647853194-62147-5-git-send-email-dh10.jung@samsung.com>
        <87r16v9uo2.fsf@miraculix.mork.no>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------.rW42XXn7_Ji6OxwuAF4RAMbP.qed.OeqKlvEhSLhB3noATS=_22cbc0_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

On Mon, Mar 21, 2022 at 04:45:01PM +0100, Bjørn Mork wrote:
> Daehwan Jung <dh10.jung@samsung.com> writes:
> 
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
> The xhci-plat.c file is Copyright (C) 2012 Texas Instruments Incorporated
> You can't just steal it.
> 
> Besides, even if you could, this isn't about copying as much code as
> posible from A to B.  The point is to add as *little* code as possible
> to support your hardware.
> 

Hi bjorn,

Thanks for your comment. I will write more detail about copyright on
next submission.

> > +static int xhci_exynos_vendor_init(struct xhci_hcd *xhci)
> > +{
> > +	/* TODO */
> > +	return 0;
> > +}
> 
> And you didn't even add that?
> 
> > +static int xhci_exynos_wake_lock(struct xhci_hcd_exynos *xhci_exynos,
> > +				   int is_main_hcd, int is_lock)
> > +{
> > +	struct usb_hcd	*hcd = xhci_exynos->hcd;
> > +	struct xhci_hcd *xhci = hcd_to_xhci(hcd);
> > +	struct wakeup_source *main_wakelock, *shared_wakelock;
> > +
> > +	main_wakelock = xhci_exynos->main_wakelock;
> > +	shared_wakelock = xhci_exynos->shared_wakelock;
> 
> Are these fields initialized anywhere?
> 
> 
> > +
> > +	if (xhci->xhc_state & XHCI_STATE_REMOVING)
> > +		return -ESHUTDOWN;
> > +
> > +	if (is_lock) {
> 
> bool?
> 

Yes, Currently I use it as if bool. 

> > +		if (is_main_hcd)
> 
> another bool?

Same

> 
> > +			__pm_stay_awake(main_wakelock);
> > +		else
> > +			__pm_stay_awake(shared_wakelock);
> > +	} else {
> > +		if (is_main_hcd)
> > +			__pm_relax(main_wakelock);
> > +		else
> > +			__pm_relax(shared_wakelock);
> > +	}
> 
> Looks interesting.   Are you signalling relax/wakeups events to the PM
> core on device suspend/resume?  Why?

I want to enter system sleep if possible at this point. It's related to
power scenario on my SOC.

> 
> > +static int xhci_exynos_address_device(struct usb_hcd *hcd, struct usb_device *udev)
> > +{
> > +	struct xhci_hcd *xhci;
> > +	int ret;
> > +
> > +	ret = xhci_address_device(hcd, udev);
> > +	xhci = hcd_to_xhci(hcd);
> > +
> > +	return ret;
> > +}
> 
> What's left here if we drop the unused parts?
> 

There's some missing code. Thanks..


> > +#ifdef CONFIG_OF
> > +static const struct xhci_plat_priv xhci_plat_marvell_armada = {
> > +	.init_quirk = xhci_mvebu_mbus_init_quirk,
> > +};
> > +
> > +static const struct xhci_plat_priv xhci_plat_marvell_armada3700 = {
> > +	.plat_setup = xhci_mvebu_a3700_plat_setup,
> > +	.init_quirk = xhci_mvebu_a3700_init_quirk,
> > +};
> 
> 
> Right...
> 
> > +#ifdef CONFIG_ACPI
> > +static const struct acpi_device_id usb_xhci_acpi_match[] = {
> > +	/* XHCI-compliant USB Controller */
> > +	{ "PNP0D10", },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(acpi, usb_xhci_acpi_match);
> > +#endif
> 
> Nice one
> 
> There's no need to copy me if you plan to resend any of this.  I'm just
> a drive-by reader here anyway, and I've seen enough.
> 
> Good luck!
> 
> 
> 
> 
> Bjørn
> 

------.rW42XXn7_Ji6OxwuAF4RAMbP.qed.OeqKlvEhSLhB3noATS=_22cbc0_
Content-Type: text/plain; charset="utf-8"


------.rW42XXn7_Ji6OxwuAF4RAMbP.qed.OeqKlvEhSLhB3noATS=_22cbc0_--
