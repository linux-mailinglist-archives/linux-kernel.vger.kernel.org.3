Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D4C5AC64E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 22:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234299AbiIDUPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 16:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbiIDUPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 16:15:12 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30CD8175AE
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 13:15:11 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id t5so8945787edc.11
        for <linux-kernel@vger.kernel.org>; Sun, 04 Sep 2022 13:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=B0UcNE6NxxIEK/T2D5tC9KfKA9gJ+JcocCKLSydu1+k=;
        b=QsMqX+zGDd8becR5YbPdz3CvjWgJ/Ff19vFQlLyPQ1h1Kuu8+IMWsZh1cB7Cait8+n
         iE31bT2THSSmgkd9BAPM62u9HgLpoB1OIkfmnjLwBx3HL1mtltQxljzmt0ZCgScik2bH
         LIY2BMNdc/M7NzorgLISf5/k8DTT+V+ovxQWLFizYjrrdbKfCUi7JfH7Qx/t+cZormJ4
         rJ6FYsmDBXA9t/2xAEiMnkLTz7mUfab3Z+yr8u+YSRaO/+SSncW3jCFIGLB8vSJQ64Bg
         P184azlGAFE8liXKeaqsa0Dqpukvura38GhIqJb1/LaPKOMNEU8cml2AjGBiQcBcrQpi
         vWqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=B0UcNE6NxxIEK/T2D5tC9KfKA9gJ+JcocCKLSydu1+k=;
        b=DpQOHx0EQB3JJ+ECFTgjbsx1RIWVyPE5CO59GxnrVTb7ZGBKO0t3Xa5Ig+IdBOGymS
         Xw5AXySbG0/k6mn3bXacbi4dNiB4MiWHiAj36MNeLTYK2gAThtO6dzio3OjM1WflZoYv
         Sbm+DEykgLOpXdZ0R8cTFZ6krD+XS+3oNm81rB+2VELEuahtRhBi7KUee9vzIU6mtKhq
         RVPEmXDvEUExDD63cUTD+TMXNfFfH0L0NU0bC1sH9VJ+oTeIAKTf8aHTz9Xg47/Argmy
         4uK6hllJmYygrrGc3w6vXEs9RJCk020R3HEcKKBckuRxma6YqY453ZQEvXVehVE87BKU
         +M9g==
X-Gm-Message-State: ACgBeo2DdAsLMs4lLDjB9zpSa1+iXNv1okgS/VfLByNRGtworBlUoERT
        1auGS1S4/cTaZ5y2FIs90lCbO7bJ6jL16q+e7qOm1t5U4wk=
X-Google-Smtp-Source: AA6agR4HhRTeC470jwaUuyblo5zi9/wv7ouI3w+gC3QMbRTKnsiWG+DY/w8S3Xw5JC5qq+/xDHtQjaSrzSEIDNoXhjY=
X-Received: by 2002:a05:6402:4007:b0:448:6c4c:b40 with SMTP id
 d7-20020a056402400700b004486c4c0b40mr29495975eda.422.1662322509795; Sun, 04
 Sep 2022 13:15:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220902-get_gpiod_from_child-remove-v1-0-1e47125df20f@gmail.com> <20220902-get_gpiod_from_child-remove-v1-3-1e47125df20f@gmail.com>
In-Reply-To: <20220902-get_gpiod_from_child-remove-v1-3-1e47125df20f@gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Sun, 4 Sep 2022 22:14:59 +0200
Message-ID: <CAMRc=Md=uOtULefxLRD_t2+o1_qcr5aSZe6Tzy+i+hOeNMejWQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] gpiolib: remove devm_fwnode_get_[index_]gpiod_from_child()
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Pavel Machek <pavel@ucw.cz>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 3, 2022 at 2:56 AM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Now that there are no more users of these APIs in the kernel we can
> remove them.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>
> diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
> index fe0f460d9a3b..2ccda8567533 100644
> --- a/include/linux/gpio/consumer.h
> +++ b/include/linux/gpio/consumer.h
> @@ -594,27 +594,6 @@ struct gpio_desc *devm_fwnode_gpiod_get(struct device *dev,
>                                            flags, label);
>  }
>
> -static inline
> -struct gpio_desc *devm_fwnode_get_index_gpiod_from_child(struct device *dev,
> -                                               const char *con_id, int index,
> -                                               struct fwnode_handle *child,
> -                                               enum gpiod_flags flags,
> -                                               const char *label)
> -{
> -       return devm_fwnode_gpiod_get_index(dev, child, con_id, index,
> -                                          flags, label);
> -}
> -
> -static inline
> -struct gpio_desc *devm_fwnode_get_gpiod_from_child(struct device *dev,
> -                                                  const char *con_id,
> -                                                  struct fwnode_handle *child,
> -                                                  enum gpiod_flags flags,
> -                                                  const char *label)
> -{
> -       return devm_fwnode_gpiod_get_index(dev, child, con_id, 0, flags, label);
> -}
> -
>  #if IS_ENABLED(CONFIG_GPIOLIB) && IS_ENABLED(CONFIG_OF_GPIO)
>  struct device_node;
>
>
> --
> b4 0.10.0-dev-fc921

Either:

Acked-by: Bartosz Golaszewski <brgl@bgdev.pl>

Or I can take pull an immutable branch from the leds tree.

Bart
