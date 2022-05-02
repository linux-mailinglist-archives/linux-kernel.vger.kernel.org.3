Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA68D517317
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 17:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385956AbiEBPqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 11:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241392AbiEBPql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 11:46:41 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169A5B92;
        Mon,  2 May 2022 08:43:12 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id y3so28448308ejo.12;
        Mon, 02 May 2022 08:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AjFRgeqn9Z/mHKiToXMOXpMUQKhByRvH8NHC9cBSak4=;
        b=dcs05AyxQY0SurUNVWPgJgvK8LLXk9f5qGT2X3c4mI1SS12yrtGRrwFG3bXYAE3HBN
         u/TquAfYlnsgu0CDFAS2IYlgU6UQQtL95oi+Uc/DuyfaSe9JROyR4QO7HYnwKyinduwW
         uRr8EJbqU93Cb9S64XO99OotNGbGHcAuvhR68p+Q6FW5JN7fdrzHAVF5G5AETe+hSGZd
         PuFiNZ6ozMNEtMqS3YUYbDRcNe2fRkGnKXaCQ4CdStGDdLYnvDzKCpk67ivSLan4eoUF
         GIJQbifN4a8MU1EPd/oJaJJ0OHyf/05qVezaHRPoCig7ys808tpalSQhANsINLFcR1P1
         sLKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AjFRgeqn9Z/mHKiToXMOXpMUQKhByRvH8NHC9cBSak4=;
        b=sxlQCOA3YGPGjWsjCNwNi2d8dWN1VnJirQb9NlGYc96SGq1ipfDigO6hy5vVhd7hTH
         BD8PDCNJ+vPUbxP1K2huimMfSyp7m9tlvuj6BjHhrWxBUNozme6LMsjL6DaHZpzaHQet
         Kv4ZraWgdL5jU5QjLd63Sf6zLPLhvewVScvhTi53XQH3UYVFgjujhQtSTQAnQu3BxhOd
         /rRABzwSVByQVX6501/Z6KpXqZ4uaAKxka1LrJ7g/VZGBfy5qzgrBJoQvkQSi5aqGvvB
         2vvcZ0SeWFGW+ufHkEd8FTBrGCCAn3ZqAZoT49SWNP3Xe3jgIL/oEF8U4J/pCQRbJZaH
         w+wQ==
X-Gm-Message-State: AOAM533U37bLAsR4DqoF+kv1zWwROzdU5jqsa9JslNzTn9aknDpGG9T0
        4PqHNlTC2j/UP2cvxKFWosEBKz/LBfkfHfbynvc=
X-Google-Smtp-Source: ABdhPJwmhjZIF781k5jQnI0bM4revnE4BFmfozMQdI1ybDOI+aak+5cGQFZlOlIrri+uALZ6UW56hpaV1qQnjzlOvjM=
X-Received: by 2002:a17:907:968e:b0:6db:aed5:43c8 with SMTP id
 hd14-20020a170907968e00b006dbaed543c8mr11815421ejc.636.1651506190563; Mon, 02
 May 2022 08:43:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220502164557.3cbb18ca@canb.auug.org.au>
In-Reply-To: <20220502164557.3cbb18ca@canb.auug.org.au>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 2 May 2022 17:42:34 +0200
Message-ID: <CAHp75VddQMK7b-xbPy91rQ0QskXerhnY_sRiT0ZfGraRmKpL_Q@mail.gmail.com>
Subject: Re: linux-next: manual merge of the pinctrl tree with the gpio-intel tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Fabien Dessenne <fabien.dessenne@foss.st.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
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

On Mon, May 2, 2022 at 5:39 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the pinctrl tree got a conflict in:
>
>   drivers/pinctrl/stm32/pinctrl-stm32.c
>
> between commit:
>
>   bb949ed9b16b ("pinctrl: stm32: Switch to use for_each_gpiochip_node() helper")
>
> from the gpio-intel tree and commit:
>
>   c954531bc5d8 ("pinctrl: stm32: improve bank clocks management")
>
> from the pinctrl tree.
>
> I fixed it up (I think, see below) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

Thanks for the fix. I think the best course of action is that Linus W.
can pull the same branch that GPIO tree has into the pin control tree
and resolve that, because the drivers touched are all pin control
drivers while the core part of GPIO subsystem was updated.

> --
> Cheers,
> Stephen Rothwell
>
> diff --cc drivers/pinctrl/stm32/pinctrl-stm32.c
> index 7aecd0efde07,b308e7bb7487..000000000000
> --- a/drivers/pinctrl/stm32/pinctrl-stm32.c
> +++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
> @@@ -1544,34 -1508,44 +1506,38 @@@ int stm32_pctl_probe(struct platform_de
>                 return -ENOMEM;
>
>         i = 0;
>  -      for_each_available_child_of_node(np, child) {
>  +      for_each_gpiochip_node(dev, child) {
>                 struct stm32_gpio_bank *bank = &pctl->banks[i];
>  +              struct device_node *np = to_of_node(child);
>
>  -              if (of_property_read_bool(child, "gpio-controller")) {
>  -                      bank->rstc = of_reset_control_get_exclusive(child,
>  -                                                                  NULL);
>  -                      if (PTR_ERR(bank->rstc) == -EPROBE_DEFER) {
>  -                              of_node_put(child);
>  -                              return -EPROBE_DEFER;
>  -                      }
>  -
>  -                      bank->clk = of_clk_get_by_name(child, NULL);
>  -                      if (IS_ERR(bank->clk)) {
>  -                              if (PTR_ERR(bank->clk) != -EPROBE_DEFER)
>  -                                      dev_err(dev,
>  -                                              "failed to get clk (%ld)\n",
>  -                                              PTR_ERR(bank->clk));
>  -                              of_node_put(child);
>  -                              return PTR_ERR(bank->clk);
>  -                      }
>  -                      i++;
>  +              bank->rstc = of_reset_control_get_exclusive(np, NULL);
>  +              if (PTR_ERR(bank->rstc) == -EPROBE_DEFER) {
>  +                      fwnode_handle_put(child);
>  +                      return -EPROBE_DEFER;
>                 }
>  -      }
>
>  -      for_each_available_child_of_node(np, child) {
>  -              if (of_property_read_bool(child, "gpio-controller")) {
>  -                      ret = stm32_gpiolib_register_bank(pctl, child);
>  -                      if (ret) {
>  -                              of_node_put(child);
>  +              bank->clk = of_clk_get_by_name(np, NULL);
>  +              if (IS_ERR(bank->clk)) {
>  +                      if (PTR_ERR(bank->clk) != -EPROBE_DEFER)
>  +                              dev_err(dev, "failed to get clk (%ld)\n", PTR_ERR(bank->clk));
>  +                      fwnode_handle_put(child);
>  +                      return PTR_ERR(bank->clk);
>  +              }
>  +              i++;
>  +      }
>
>  -                              for (i = 0; i < pctl->nbanks; i++)
>  -                                      clk_disable_unprepare(pctl->banks[i].clk);
>  +      for_each_gpiochip_node(dev, child) {
>  +              ret = stm32_gpiolib_register_bank(pctl, child);
>  +              if (ret) {
>  +                      fwnode_handle_put(child);
> +
>  -                              return ret;
>  -                      }
> ++                      for (i = 0; i < pctl->nbanks; i++)
> ++                              clk_disable_unprepare(pctl->banks[i].clk);
> +
>  -                      pctl->nbanks++;
>  +                      return ret;
>                 }
>  +
>  +              pctl->nbanks++;
>         }
>
>         dev_info(dev, "Pinctrl STM32 initialized\n");



-- 
With Best Regards,
Andy Shevchenko
