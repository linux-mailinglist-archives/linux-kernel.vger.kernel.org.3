Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE495797C0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 12:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237038AbiGSKfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 06:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236818AbiGSKfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 06:35:13 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DDDB5F;
        Tue, 19 Jul 2022 03:35:11 -0700 (PDT)
X-UUID: 96b00be4d7f54c9082adf8077991d24b-20220719
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:0a51c301-39ac-47da-a151-41263705a42b,OB:10,L
        OB:0,IP:0,URL:25,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,A
        CTION:release,TS:70
X-CID-INFO: VERSION:1.1.8,REQID:0a51c301-39ac-47da-a151-41263705a42b,OB:10,LOB
        :0,IP:0,URL:25,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Spam_GS981B3D,A
        CTION:quarantine,TS:70
X-CID-META: VersionHash:0f94e32,CLOUDID:7376b264-0b3f-4b2c-b3a6-ed5c044366a0,C
        OID:06c41254cbeb,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 96b00be4d7f54c9082adf8077991d24b-20220719
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <axe.yang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1926111147; Tue, 19 Jul 2022 18:35:05 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 19 Jul 2022 18:35:04 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 19 Jul 2022 18:35:03 +0800
Message-ID: <621878fea57e70d56640bf6c50f4b723624060ee.camel@mediatek.com>
Subject: Re: [PATCH v13 3/3] mmc: mediatek: add support for SDIO eint wakup
 IRQ
From:   Axe Yang <axe.yang@mediatek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Satya Tangirala <satyat@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Lucas Stach <dev@lynxeye.de>,
        "Eric Biggers" <ebiggers@google.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        "Stephen Boyd" <swboyd@chromium.org>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        Yue Hu <huyue2@yulong.com>, Tian Tao <tiantao6@hisilicon.com>,
        <angelogioacchino.delregno@collabora.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Yong Mao <yong.mao@mediatek.com>
Date:   Tue, 19 Jul 2022 18:35:03 +0800
In-Reply-To: <CAPDyKFr0gy1sNb=U3j1ErSZm+jcAcvg_jwNmodEs7ip4_LjNZg@mail.gmail.com>
References: <20220623090445.1401-1-axe.yang@mediatek.com>
         <20220623090445.1401-4-axe.yang@mediatek.com>
         <CAPDyKFr0gy1sNb=U3j1ErSZm+jcAcvg_jwNmodEs7ip4_LjNZg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-07-18 at 14:21 +0200, Ulf Hansson wrote:
> On Thu, 23 Jun 2022 at 11:05, Axe Yang <axe.yang@mediatek.com> wrote:
> > 
> > Add support for eint IRQ when MSDC is used as an SDIO host. This
> > feature requires SDIO device support async IRQ function. With this
> > feature, SDIO host can be awakened by SDIO card in suspend state,
> > without additional pin.
> > 
> > MSDC driver will time-share the SDIO DAT1 pin. During suspend, MSDC
> > turn off clock and switch SDIO DAT1 pin to GPIO mode. And during
> > resume, switch GPIO function back to DAT1 mode then turn on clock.
> > 
> > Some device tree property should be added or modified in MSDC node
> > to support SDIO eint IRQ. Pinctrls "state_eint" is mandatory. Since
> > this feature depends on asynchronous interrupts, "wakeup-source",
> > "keep-power-in-suspend" and "cap-sdio-irq" flags are necessary, and
> > the interrupts list should be extended(the interrupt named with
> > sdio_wakeup):
> >         &mmcX {
> >                 ...
> >                 interrupt-names = "msdc", "sdio_wakeup";
> >                 interrupts-extended = <...>,
> >                                       <&pio xxx
> > IRQ_TYPE_LEVEL_LOW>;
> >                 ...
> >                 pinctrl-names = "default", "state_uhs",
> > "state_eint";
> >                 ...
> >                 pinctrl-2 = <&mmc2_pins_eint>;
> >                 ...
> >                 cap-sdio-irq;
> >                 keep-power-in-suspend;
> >                 wakeup-source;
> >                 ...
> >         };
> > 
> > Co-developed-by: Yong Mao <yong.mao@mediatek.com>
> > Signed-off-by: Yong Mao <yong.mao@mediatek.com>
> > Signed-off-by: Axe Yang <axe.yang@mediatek.com>
> 
> My apologies for the delay in reviewing this.

It is okay. Glad to receive your reply.

> 
> > ---
> >  drivers/mmc/host/mtk-sd.c | 84
> > ++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 78 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> > index 195dc897188b..f907b96cfd87 100644
> > --- a/drivers/mmc/host/mtk-sd.c
> > +++ b/drivers/mmc/host/mtk-sd.c
> > @@ -1,6 +1,6 @@
> >  // SPDX-License-Identifier: GPL-2.0-only
> >  /*
> > - * Copyright (c) 2014-2015 MediaTek Inc.
> > + * Copyright (c) 2014-2015, 2022 MediaTek Inc.
> >   * Author: Chaotian.Jing <chaotian.jing@mediatek.com>
> >   */
> > 
> > @@ -20,6 +20,7 @@
> >  #include <linux/platform_device.h>
> >  #include <linux/pm.h>
> >  #include <linux/pm_runtime.h>
> > +#include <linux/pm_wakeirq.h>
> >  #include <linux/regulator/consumer.h>
> >  #include <linux/slab.h>
> >  #include <linux/spinlock.h>
> > @@ -440,8 +441,10 @@ struct msdc_host {
> >         struct pinctrl *pinctrl;
> >         struct pinctrl_state *pins_default;
> >         struct pinctrl_state *pins_uhs;
> > +       struct pinctrl_state *pins_eint;
> >         struct delayed_work req_timeout;
> >         int irq;                /* host interrupt */
> > +       int eint_irq;           /* interrupt from sdio device for
> > waking up system */
> >         struct reset_control *reset;
> > 
> >         struct clk *src_clk;    /* msdc source clock */
> > @@ -1520,17 +1523,46 @@ static void __msdc_enable_sdio_irq(struct
> > msdc_host *host, int enb)
> > 
> >  static void msdc_enable_sdio_irq(struct mmc_host *mmc, int enb)
> >  {
> > -       unsigned long flags;
> >         struct msdc_host *host = mmc_priv(mmc);
> > +       unsigned long flags;
> > +       int ret;
> > 
> >         spin_lock_irqsave(&host->lock, flags);
> >         __msdc_enable_sdio_irq(host, enb);
> >         spin_unlock_irqrestore(&host->lock, flags);
> > 
> > -       if (enb)
> > -               pm_runtime_get_noresume(host->dev);
> > -       else
> > -               pm_runtime_put_noidle(host->dev);
> > +       if (mmc_card_enable_async_irq(mmc->card) && host-
> > >pins_eint) {
> > +               if (enb) {
> > +                       /*
> > +                        * In
> > dev_pm_set_dedicated_wake_irq_reverse(), eint pin will be set to
> > +                        * GPIO mode. We need to restore it to SDIO
> > DAT1 mode after that.
> > +                        * Since the current pinstate is pins_uhs,
> > to ensure pinctrl select take
> > +                        * affect successfully, we change the
> > pinstate to pins_eint firstly.
> > +                        */
> > +                       pinctrl_select_state(host->pinctrl, host-
> > >pins_eint);
> 
> I am sorry, but I don't understand what goes on here. Why do you need
> to change the pinctrl setting to "pins_eint" here?
> 
> The bellow call to dev_pm_set_dedicated_wake_irq_reverse() doesn't
> change the pinctrl setting as the comment suggests above.
> 

Actually, the pinctrl setting is changed:
In dev_pm_set_dedicated_wake_irq_reverse() -> ... ->
request_threaded_irq() -> __setup_irq() -> irq_request_resources() ->
mtk_eint_irq_request_resources()-> mtk_xt_set_gpio_as_eint(), the SDIO
DAT1 pin will be force reset to GPIO mode:

https://elixir.bootlin.com/linux/latest/source/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c#L339

So, I have to call pinctrl_select_state() to restore SDIO DAT1 pin
mode(pins_uhs). But pinctrl_select_state() return directly because MSDC
driver still wrongly thinks current DAT1 state is SDIO DAT1 mode:

https://elixir.bootlin.com/linux/latest/source/drivers/pinctrl/core.c#L1344
, which means I have to call pinctrl_select_state() in pairs: Change
pinctrl to another state(pins_eint), then change it back to pins_uhs
mode.


> dev_pm_set_dedicated_wake_irq_reverse() will register the wakeirq,
> but
> more importantly, it should also leave the wakeirq disabled, right?

Yes. wakeirq will be registered, and disabled. But SDIO DAT1 pin mode
will be changed too.

> 
> > +                       ret =
> > dev_pm_set_dedicated_wake_irq_reverse(host->dev, host->eint_irq);
> > +
> > +                       if (ret) {
> > +                               dev_err(host->dev, "Failed to
> > register SDIO wakeup irq!\n");
> > +                               host->pins_eint = NULL;
> > +                               pm_runtime_get_noresume(host->dev);
> > +                       } else {
> > +                               dev_dbg(host->dev, "SDIO eint irq:
> > %d!\n", host->eint_irq);
> > +                       }
> > +
> > +                       pinctrl_select_state(host->pinctrl, host-
> > >pins_uhs);
> 
> According to my comment above, I also don't understand why you need
> this. Why can't you just leave the pinctrl in the "pins_uhs" state?
> 
I have to call pinctrl_select_state() in pairs.


> > +               } else {
> > +                       dev_pm_clear_wake_irq(host->dev);
> > +               }
> > +       } else {
> > +               if (enb) {
> > +                       /* Ensure host->pins_eint is NULL */
> > +                       host->pins_eint = NULL;
> > +                       pm_runtime_get_noresume(host->dev);
> > +               } else {
> > +                       pm_runtime_put_noidle(host->dev);
> > +               }
> > +       }
> >  }
> > 
> >  static irqreturn_t msdc_cmdq_irq(struct msdc_host *host, u32
> > intsts)
> > @@ -2631,6 +2663,20 @@ static int msdc_drv_probe(struct
> > platform_device *pdev)
> >                 goto host_free;
> >         }
> > 
> > +       /* Support for SDIO eint irq ? */
> > +       if ((mmc->pm_caps & MMC_PM_WAKE_SDIO_IRQ) && (mmc->pm_caps
> > & MMC_PM_KEEP_POWER)) {
> > +               host->eint_irq = platform_get_irq_byname(pdev,
> > "sdio_wakeup");
> > +               if (host->eint_irq > 0) {
> > +                       host->pins_eint =
> > pinctrl_lookup_state(host->pinctrl, "state_eint");
> > +                       if (IS_ERR(host->pins_eint)) {
> > +                               dev_err(&pdev->dev, "Cannot find
> > pinctrl eint!\n");
> > +                               host->pins_eint = NULL;
> > +                       } else {
> > +                               device_init_wakeup(&pdev->dev,
> > true);
> > +                       }
> > +               }
> > +       }
> > +
> >         msdc_of_property_parse(pdev, host);
> > 
> >         host->dev = &pdev->dev;
> > @@ -2845,6 +2891,13 @@ static int __maybe_unused
> > msdc_runtime_suspend(struct device *dev)
> >         struct msdc_host *host = mmc_priv(mmc);
> > 
> >         msdc_save_reg(host);
> > +
> > +       if (host->pins_eint) {
> > +               disable_irq(host->irq);
> > +               pinctrl_select_state(host->pinctrl, host-
> > >pins_eint);
> > +               if (sdio_irq_claimed(mmc))
> > +                       __msdc_enable_sdio_irq(host, 0);
> > +       }
> 
> This above code isn't entirely correct. Just because you have
> "pins_eint", doesn't mean that you have a wakeirq being registered,
> as
> that also depends on whether there is an SDIO irq claimed.
> 
> So, I think this should rather be:
> 
> if (sdio_irq_claimed(mmc)) {
>     if (host->pins_eint) {
>         disable_irq(host->irq);
>         pinctrl_select_state(host->pinctrl, host->pins_eint);
>     }
> 
>     __msdc_enable_sdio_irq(host, 0);
> }
> 
Agree, will adjust the logic in next version. Thanks.


> >         msdc_gate_clock(host);
> >         return 0;
> >  }
> > @@ -2860,12 +2913,18 @@ static int __maybe_unused
> > msdc_runtime_resume(struct device *dev)
> >                 return ret;
> > 
> >         msdc_restore_reg(host);
> > +
> > +       if (host->pins_eint) {
> 
> Similar comment as above. You need to check sdio_irq_claimed() here
> too.

Okay.

> 
> > +               pinctrl_select_state(host->pinctrl, host-
> > >pins_uhs);
> > +               enable_irq(host->irq);
> > +       }
> >         return 0;
> >  }
> > 
> >  static int __maybe_unused msdc_suspend(struct device *dev)
> >  {
> >         struct mmc_host *mmc = dev_get_drvdata(dev);
> > +       struct msdc_host *host = mmc_priv(mmc);
> >         int ret;
> > 
> >         if (mmc->caps2 & MMC_CAP2_CQE) {
> > @@ -2874,11 +2933,24 @@ static int __maybe_unused
> > msdc_suspend(struct device *dev)
> >                         return ret;
> >         }
> > 
> > +       /*
> > +        * Bump up runtime PM usage counter otherwise dev-
> > >power.needs_force_resume will
> > +        * not be marked as 1, pm_runtime_force_resume() will go
> > out directly.
> > +        */
> > +       if (host->pins_eint)
> 
> This works, but can be improved by checking sdio_irq_claimed() too.

Sure. Will update it in next version.

> 
> > +               pm_runtime_get_noresume(dev);
> > +
> >         return pm_runtime_force_suspend(dev);
> >  }
> > 
> >  static int __maybe_unused msdc_resume(struct device *dev)
> >  {
> > +       struct mmc_host *mmc = dev_get_drvdata(dev);
> > +       struct msdc_host *host = mmc_priv(mmc);
> > +
> > +       if (host->pins_eint)
> > +               pm_runtime_put_noidle(dev);
> 
> Ditto.

Will update it in next version.

> 
> > +
> >         return pm_runtime_force_resume(dev);
> >  }
> > 
> 
> Kind regards
> Uffe

Regards,
Axe


