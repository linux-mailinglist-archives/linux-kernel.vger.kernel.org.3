Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F89558842
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 21:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbiFWTCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 15:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbiFWTC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 15:02:29 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4C2F54;
        Thu, 23 Jun 2022 11:07:55 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id by38so46868ljb.10;
        Thu, 23 Jun 2022 11:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pVm8MjXTsJMX8WBaTQ/Z/W23uteGk2WgxtylOJuMvn4=;
        b=ROMSf98OAyUaa6eEUsFo3GNphishFltifgt5QEQzrZNe7sjAM+HfSxcOzzy9W6RXT/
         G9dAp8BarXJwUQv1+UFIl9pO6g0/KNAziFw8OQyNNA2F7tBBoJs6F4EVswlaZ/mtrOUr
         QkvM84BF5zxaVCCNT37WNd2okHNEk6IyyAzwEh1EwAophtbnp7iFhuLKO8Z/XOD1lnUl
         suS5mf6pbLbWkjRhB9QoLtb2LLY0TBOsJTxfjC7JtzRG8wnlujGjvT+fxjiuxQ7n37lq
         7hRGbeT6p1p4iK5XNA2XXK6FCYcJpRLpc3dd/qxtlN637sF3jF8kcCu0NSjABQOuH24p
         9Wcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pVm8MjXTsJMX8WBaTQ/Z/W23uteGk2WgxtylOJuMvn4=;
        b=Xb9S7b6fWd7xdXqlJcaHZ0mN17UuzdgLETMyfyPsOzbSIXeOQp6+/iVwws+I/pefop
         YcHw1CKz4Wo2P4daG0W7JuC4bCRa9tQ3/Kp/WD9ir4CRFVpYZK5Cx2SZcfOvoDeq58n4
         9ZE4n4RLSqhMpKARkRgMBfO7Kk/rueh80F+Te8a5ENYNVm9n0UcSuoyhok6twjCJBrgX
         VILSfPtueDbgzl1ae6o95PI4CW5/VFIhPT0fznaggIeo0G/iMqPkLUSyR9Uk6wZOLZIy
         +Vehxpy7U3qB8k/yDn+behcjHHAMIWYru0OazYS9tvHY++fCsxudiXd/l6R3MtImeDTd
         xSWw==
X-Gm-Message-State: AJIora/4EMHvFVNY1W+j/OE5O81wWrc1KWYvL9KDKMZCDUrdO/vZ44Vm
        q54jlfjIFPPU16SgrrQrIcolAmhoikiLyezzux0=
X-Google-Smtp-Source: AGRyM1vZgKzYKINQvL/hjv/QKJoSpgQjofBcH1c6rGieXJWJEFKaIjpnuwM4pmWPjKf5o83t+GJsAhFvgJCR3nJUMSQ=
X-Received: by 2002:a2e:b8d2:0:b0:255:93e3:6fb2 with SMTP id
 s18-20020a2eb8d2000000b0025593e36fb2mr5737201ljp.334.1656007673996; Thu, 23
 Jun 2022 11:07:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220623115631.22209-1-peterwu.pub@gmail.com> <20220623115631.22209-9-peterwu.pub@gmail.com>
In-Reply-To: <20220623115631.22209-9-peterwu.pub@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 23 Jun 2022 20:07:17 +0200
Message-ID: <CAHp75Vchspgg_VaM+7JHD+2x+-JPkJXSdtLoqQGAx=kg5uAdSg@mail.gmail.com>
Subject: Re: [PATCH v3 08/14] usb: typec: tcpci_mt6370: Add Mediatek MT6370
 tcpci driver
To:     ChiaEn Wu <peterwu.pub@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>,
        Helge Deller <deller@gmx.de>, chiaen_wu@richtek.com,
        alice_chen@richtek.com, cy_huang <cy_huang@richtek.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        szuni chen <szunichen@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 2:00 PM ChiaEn Wu <peterwu.pub@gmail.com> wrote:
>
> From: ChiYuan Huang <cy_huang@richtek.com>
>
> Add chip level mt6370 tcpci driver.

...

> +config TYPEC_TCPCI_MT6370
> +       tristate "Mediatek MT6370 Type-C driver"
> +       depends on MFD_MT6370
> +       help
> +         Mediatek MT6370 is a multi-functional IC that includes
> +         USB Type-C. It works with Type-C Port Controller Manager
> +         to provide USB PD and USB Type-C functionalities.

What will be the module name?

...

> +#include <linux/bits.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>

> +#include <linux/of.h>

No user of this header is found in this file.

> +#include <linux/platform_device.h>
> +#include <linux/pm_wakeup.h>
> +#include <linux/pm_wakeirq.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/usb/tcpm.h>
> +#include "tcpci.h"

...

> +       if (did == MT6370_TCPC_DID_A) {
> +               ret = regmap_write(data->regmap, TCPC_FAULT_CTRL, 0x80);
> +               if (ret)
> +                       return ret;

return regmap_write(...);

> +       }
> +
> +       return 0;

...

> +       if (ret && !source)
> +               ret = regulator_disable(priv->vbus);
> +       else if (!ret && source)
> +               ret = regulator_enable(priv->vbus);
> +       else
> +               ret = 0;
> +
> +       return ret;

Can it be

  if (ret && ...)
    return regulator_disable(...);
  if (!ret && ...)
    return regulator_enable(...);

  return 0;

?

...

> +       if (!priv->tcpci_data.regmap) {
> +               dev_err(&pdev->dev, "Failed to init regmap\n");
> +               return -ENODEV;
> +       }

return dev_err_probe(...); ?

...

> +       if (ret) {
> +               dev_err(&pdev->dev, "Failed to check vendor info (%d)\n", ret);
> +               return ret;
> +       }

Ditto.

...

> +       priv->irq = platform_get_irq(pdev, 0);
> +       if (priv->irq < 0) {

> +               dev_err(&pdev->dev, "Failed to get TCPC irq (%d)\n", priv->irq);

The message like this is printed in case of error inside
platform_get_irq(), no need to duplicate.

> +               return priv->irq;
> +       }

...

> +       priv->tcpci = tcpci_register_port(&pdev->dev, &priv->tcpci_data);
> +       if (IS_ERR(priv->tcpci)) {
> +               dev_err(&pdev->dev, "Failed to register tcpci port\n");
> +               return PTR_ERR(priv->tcpci);

return dev_err_probe(); ?

> +       }

...

> +       if (ret) {
> +               dev_err(&pdev->dev, "Failed to allocate irq (%d)\n", ret);
> +               tcpci_unregister_port(priv->tcpci);
> +               return ret;

Ditto.

> +       }

-- 
With Best Regards,
Andy Shevchenko
