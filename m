Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E803F563AC6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 22:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbiGAUK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 16:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbiGAUKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 16:10:24 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1B9BE35;
        Fri,  1 Jul 2022 13:10:23 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-3137316bb69so33586107b3.10;
        Fri, 01 Jul 2022 13:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=utyP+gW8w/zeBm0+6+NM0znJpU7g6tr/t7I1UbtVGt4=;
        b=laU/KbuDQOSS+qlK8j8j4hCXySZcASO5qCA4O6qMJMW7FQsJqM3FXVI8D+ApqbdH+B
         rJ9JL+u5ifEq5kKOZMA+lWEK3irpBNsm5llw79PkUG0XciCk9TErbtFPB/H9zTmUzj0h
         USqtCr3L+HjTAhoV3OK/kUMTjxCtEaHqeVGj5D5w85p8/RAybt4jQgco9dT5jcV6BdFn
         ePbkB9gV+nPhE1yzr511JYkuQy2QNBrxG48LfLgdPQPTpJMEHBg9UnabZa4FE2qGGvtp
         DFg9wpAh/xm3XMrYEjCtWwjAL3sCo3DnCh6qVzGnKLZXJP0MmZ+NUtUaVp/zXp6vvphh
         PbZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=utyP+gW8w/zeBm0+6+NM0znJpU7g6tr/t7I1UbtVGt4=;
        b=FadVAvfDJkG/Wl7/lbX+xFW6zL8RhJOYl1rEdsyshZrTJJP5NVo3F2I711nWrFOr8y
         aL4ZuVqa0LlpD4Fh7CynLCgqQnR7oAnZJKjrH06l2WCMaI/Nd+tZ8tdFH6heAHh7DqTm
         kZ7uZ8yrlFQSo5tdlVbZPn/jT5GBLsqPBVle3mR6fpqliPDNWdM9Pi5sDA6X27j2QYe/
         T3htc6scSsYRnF2DDVa61HZgya4cc04UveQRuc+2pV3bkdjefR2bcjt+rZsXpYdvMcB0
         eldC9+L5gxfThrYCwqkrMYk8MhDvoNVK+O+NX2phjP3umzCzU1qEDeSOB4S6bfxxTOLs
         JxrA==
X-Gm-Message-State: AJIora/Zn7bgNfNSiRtTpFzLh+lmgyw6k6A7Y0VlKgI+37jeSG61PigA
        Q85/+2pUF2MePPmtvEDVYZjUG086IhdRkFogv6teAfCui17ZljBk
X-Google-Smtp-Source: AGRyM1uEu6VegSBTokYQH+7hvDzaQu/WtoEKg034JQ+h8z4eg6LBkbP+qCluEWRH8zldUlXU/0csfyfSgRuI0f89kJE=
X-Received: by 2002:a81:cd3:0:b0:317:861c:ac07 with SMTP id
 202-20020a810cd3000000b00317861cac07mr19105481ywm.486.1656706222839; Fri, 01
 Jul 2022 13:10:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220630075155.2718293-1-o.rempel@pengutronix.de>
In-Reply-To: <20220630075155.2718293-1-o.rempel@pengutronix.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 1 Jul 2022 22:09:46 +0200
Message-ID: <CAHp75VevTsk_LBf+B17-81NMxf-oAJEFZJW+noYbRJyQqThgPQ@mail.gmail.com>
Subject: Re: [PATCH net-next v1 1/1] iio: adc: tsc2046: silent spi_device_id warning
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
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

On Thu, Jun 30, 2022 at 9:59 AM Oleksij Rempel <o.rempel@pengutronix.de> wrote:
>
> Add spi_device_id to silent following warning:
>  SPI driver tsc2046 has no spi_device_id for ti,tsc2046e-adc

...

> +static const struct spi_device_id tsc2046_adc_spi_ids[] = {
> +       { "tsc2046e-adc" },
> +       { },

No comma needed for terminator lines.

> +};

-- 
With Best Regards,
Andy Shevchenko
