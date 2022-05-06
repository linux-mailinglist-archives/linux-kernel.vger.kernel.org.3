Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2AA551D296
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 09:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389714AbiEFHzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 03:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389648AbiEFHzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 03:55:47 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04EEBC15
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 00:52:04 -0700 (PDT)
Received: from mail-wr1-f43.google.com ([209.85.221.43]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MPoTl-1nRcTw0K4B-00Mum3 for <linux-kernel@vger.kernel.org>; Fri, 06 May
 2022 09:52:03 +0200
Received: by mail-wr1-f43.google.com with SMTP id c11so8898328wrn.8;
        Fri, 06 May 2022 00:52:03 -0700 (PDT)
X-Gm-Message-State: AOAM530gqc5NG27NEqrWTQBxNWZiFRtdQPPsCaTA5+WlYnkubOC1hAnt
        G5D0bpY7zPzC/6k5O7L4x7EAJM2wAEi627uGN3Y=
X-Google-Smtp-Source: ABdhPJwDQvOXPjSlN7skIa381NhchVwgH8Yl45OAiXGcPLWTFXHTr8DbsSUxsHtsk8T8LQ8/sqwqDN289pNPOOzF2oo=
X-Received: by 2002:adf:e106:0:b0:20a:b31b:213d with SMTP id
 t6-20020adfe106000000b0020ab31b213dmr1568918wrz.219.1651823522731; Fri, 06
 May 2022 00:52:02 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20220506063340epcas2p4c9d88670f9be952f3637e3a545a7d1da@epcas2p4.samsung.com>
 <1651818679-10594-1-git-send-email-dh10.jung@samsung.com> <1651818679-10594-7-git-send-email-dh10.jung@samsung.com>
In-Reply-To: <1651818679-10594-7-git-send-email-dh10.jung@samsung.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 6 May 2022 09:51:46 +0200
X-Gmail-Original-Message-ID: <CAK8P3a22wWExGymOC__KxgMLsh4AMdnRRKUdgD=qqmj6JQZ1KA@mail.gmail.com>
Message-ID: <CAK8P3a22wWExGymOC__KxgMLsh4AMdnRRKUdgD=qqmj6JQZ1KA@mail.gmail.com>
Subject: Re: [PATCH RFC v5 6/6] usb: dwc3: dwc3-exynos: add host init
To:     Daehwan Jung <dh10.jung@samsung.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Juergen Gross <jgross@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        Matthias Kaehlcke <mka@chromium.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DESIGNWARE USB3 DRD IP DRIVER" <linux-usb@vger.kernel.org>,
        "moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>, sc.suh@samsung.com,
        taehyun cho <taehyun.cho@samsung.com>, jh0801.jung@samsung.com,
        eomji.oh@samsung.com
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:llXLQQxS6plLe7tKgrP4wsTvLfVS5V8EaDJtOEg1Wl0TqeU9JWU
 C+GWVTzEX4Mzr/Q+yZMmTFL3GZPKBoqRONzPVmhqo3X1MA5maHa5lgV2rd2QliJRb65kClS
 9FCf4coLA88S8U6Mq0Z0T6Of7NrKRvgxtgIxnUNrFTAZagcqpjpvGHA2wlvX0iqGky9TOJS
 IoLmQVb7GDfTxx4of1Kig==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KLkmFtElyig=:8gfzD3mz5UVFEiPXnZzfij
 JclPc73xV6pp6RWXT1NmOX4DwoNZfVGUAG4hx8Wyn0k/OWNmL/2Riz2xRDDyS+U7r/1fgbdNs
 PSL4Vn48G9DFYJFZeiDkupr+zlwXUDFB8xJfoBs9SENh79X54yQnFuN7ydcj/Db5kxVj2Cf/W
 awJOC0yMpV7wcPWMP+uP2VAr43EA0ETy7+LFYJ9Y6N6e2EfIbGgfgBY9/LlIoviH2KgadEJbL
 qkj1kRQG55PGJssrd30cBdAU8u1CX1xjdCXVttx8oKruWwZPq7+HFNVaAXNRihqlmrvKR2KBk
 9Sz4bAAl4BpJhS8lF5GDEzm3/DvfThnAtID9IZF5JDV6XrCmMPAwVh/skbGhQJiF/0NfCu6sf
 HKzeyfCVy2eApIOMWSSTjkst65bRqMBoK1XGMRQlwj4DdnQOwBOGhfgRDUlN7DsUjW02JIb5w
 ScRJDekQvZ7j0Q+t+SoO3rM9Gf07OIMlPt140fYX9K7CZalLldS0QbC++roW/erWScIiZSbXx
 TsB7keVYu5bb1kzcQGgn8ldEkTTOjVxj+alp+sogOXgTrZD+N/ILrRaaAD7k7BE5erPBbFH3B
 rvXVFbusjweBHKuYITVW9+7srnKWPAnAgyDR3Hit65f/TqVIV0aOMG21JSmQC/5tG+oHjUPgf
 VT68zzuXxqjh+nDnfK5s1ZywUApPZ1LnUQh3VUxJZDmdrMgUL6wV8uf2IIlCEy5gOUX+rxDJM
 +z5E4KFxQ+QZXEpx6KCnoyUjU3ptNQ6Dd98Jg+uk12JKgbXTwZFUyFndBejAqXm+9NVdwbpP1
 1TG2MGAkX6goXIkA15ftkGPKRa9w78VEJ2OYc4enbadvBH14Fc=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 6, 2022 at 8:31 AM Daehwan Jung <dh10.jung@samsung.com> wrote:
>
> This is for xHCI Host Controller driver on Exynos SOC.
> It registers vendor ops before loading xhci platform driver.
>
> Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
> ---
>  drivers/usb/dwc3/dwc3-exynos.c | 100 ++++++++++++++++++++++++++++++++-
>  1 file changed, 99 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exynos.c
> index 0ecf20eeceee..c22ea5cd6ab0 100644
> --- a/drivers/usb/dwc3/dwc3-exynos.c
> +++ b/drivers/usb/dwc3/dwc3-exynos.c
> @@ -17,6 +17,12 @@
>  #include <linux/of_platform.h>
>  #include <linux/regulator/consumer.h>
>
> +#include "core.h"
> +
> +#if IS_ENABLED(CONFIG_USB_XHCI_EXYNOS)
> +int xhci_exynos_register_vendor_ops(void);
> +#endif

Function declarations should always be in a header file, and not guarded
by an #ifdef. This particular one is probably not needed anyway if the
driver is done correctly though, see below.

> @@ -46,12 +53,81 @@ static int dwc3_exynos_remove_child(struct device *dev, void *unused)
>         return 0;
>  }
>
> +#if IS_ENABLED(CONFIG_USB_XHCI_EXYNOS)
> +static int dwc3_exynos_host_init(struct dwc3_exynos *exynos)
> +{
> +       struct dwc3             *dwc = exynos->dwc;
> +       struct device           *dev = exynos->dev;
> +       struct platform_device  *xhci;
> +       struct resource         *res;
> +       struct platform_device  *dwc3_pdev = to_platform_device(dwc->dev);
> +       int                     ret = 0;
> +
> +       /* Configuration xhci resources */
> +       xhci_exynos_register_vendor_ops();
> +
> +       res = platform_get_resource(dwc3_pdev, IORESOURCE_MEM, 0);
> +       if (!res) {
> +               dev_err(dev, "missing memory resource\n");
> +               return -ENODEV;
> +       }
> +       dwc->xhci_resources[0].start = res->start;
> +       dwc->xhci_resources[0].end = dwc->xhci_resources[0].start +
> +                                       DWC3_XHCI_REGS_END;
> +       dwc->xhci_resources[0].flags = res->flags;
> +       dwc->xhci_resources[0].name = res->name;
> +
> +       res = platform_get_resource(dwc3_pdev, IORESOURCE_IRQ, 0);
> +       if (!res) {
> +               dev_err(dev, "missing irq resource\n");
> +               return -ENODEV;
> +       }
> +
> +       dwc->xhci_resources[1].start = dwc->irq_gadget;
> +       dwc->xhci_resources[1].end = dwc->irq_gadget;
> +       dwc->xhci_resources[1].flags = res->flags;
> +       dwc->xhci_resources[1].name = res->name;
> +
> +       xhci = platform_device_alloc("xhci-hcd", PLATFORM_DEVID_AUTO);
> +       if (!xhci) {
> +               dev_err(dwc->dev, "couldn't allocate xHCI device\n");
> +               return -ENOMEM;
> +       }
> +
> +       xhci->dev.parent        = dwc->dev;
> +       ret = dma_set_mask_and_coherent(&xhci->dev, DMA_BIT_MASK(36));
> +       if (ret) {
> +               pr_err("xhci dma set mask ret = %d\n", ret);
> +               return ret;
> +       }

This looks like you have the abstraction backwards from what normal
drivers do. If you need a specialization of a driver that already exists,
create a new driver module with a platform_driver that matches the
specialized of_device_id, and have it call into the more general driver,
do avoid having the general driver know about the specializations.

Allocating a platform_device and making it DMA capable
doesn't generally work correctly, and misses the IOMMU setup, so make
sure you have a device node for it instead and probe it from DT.

        Arnd
