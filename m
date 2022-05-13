Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D8B526BD6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 22:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384563AbiEMUsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 16:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384554AbiEMUsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 16:48:42 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0133A5AA71
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 13:48:41 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id o130so1727749ybc.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 13:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OTCIkj90NBygwp7HNsQRRk847EEs9xR8am/5uzEVKWw=;
        b=pBmjymeLQcAMkCc+0EjuC2mm5QmV/BKUBjVyTqWUgDufAx8EPG9llPN2jbimesnfTT
         DGJS2arqGu4epwSKb44DY8dIZpC/Pxl8bTgMS0ROcumvV7bYPJgaXVOZ/1y9PY+XRp72
         fxnhz5CFbIJyYzSXuZsH7AQcdo1UbSBX4s8Qal/ODPUn39UOutPJQDYfN+oR2LUZVK6E
         0ggMQOJ8Xdua4bG45woVaCHB2gjNunAnCuEqd3J5BU6+VjeM57AvVz3CvmoYbF6BSQ40
         EojNTOmbAVv4RHVkSUo4y2X68v1EIJrJvRF+csdmb8Dh4UsqDTP+mz0GD8IQQ2TO8rmj
         KGQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OTCIkj90NBygwp7HNsQRRk847EEs9xR8am/5uzEVKWw=;
        b=g6kN7k1CqSV3HQ9sDGsyvLBGhUw/3u6/35AGGRh36Wb7zPeYqhF03s4aCE8IAJUCIX
         RL/oW7vnxLuZw/4wCB6xVnMG0S/bgfCfWuW/b0RMNiDFelDO2NPEN0CDUH2YhV9reKPX
         dTlwLTWVk2VtgEYNIN5zE4oH+OboNdGGsk9DQTVnTcYFVp2WoGtPuJQiSrF4A9WzVlJw
         OuM041Fu/TPICteoid/AeAccu+VVDt/FiBFhSfDxIZKnmY5m3ytZdSZ0tRdWFcJsMuoZ
         ebj5jqlqnZtsuZkLoymSGIBZQUcu4gHvXA2/mJOiOAJmCzjmq4MBH/vgxnhfMnC3jsE1
         MthA==
X-Gm-Message-State: AOAM531qBijMiEQV7kMgPZcRgyzLzf7pZk5UEHWrUdJ7CY2+VZJKf83J
        r8GdoVY8+h/Z3Np0gXVVfqquPZydOoP/ISKxbUWcYA==
X-Google-Smtp-Source: ABdhPJy1oub1wqNIL+dXWPPAo7G+hsM8kiG6sIqtPN0UqKiA5aDptON108TZ6VrtImzcKpAqrVC3ooWmlESPKuZgCSc=
X-Received: by 2002:a25:2c82:0:b0:64d:62a1:850b with SMTP id
 s124-20020a252c82000000b0064d62a1850bmr138311ybs.291.1652474920207; Fri, 13
 May 2022 13:48:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220511205959.10514-1-mosescb.dev@gmail.com> <20220512071415.2786-1-mosescb.dev@gmail.com>
In-Reply-To: <20220512071415.2786-1-mosescb.dev@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 13 May 2022 22:48:29 +0200
Message-ID: <CACRpkdbuf7t8obNZi9peyx0ku+EHMW1waL3jvJHYCstXztFw0A@mail.gmail.com>
Subject: Re: [PATCH v3] drivers: gpio: zevio: drop of_gpio.h header
To:     Moses Christopher Bollavarapu <mosescb.dev@gmail.com>
Cc:     andy.shevchenko@gmail.com, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 9:14 AM Moses Christopher Bollavarapu
<mosescb.dev@gmail.com> wrote:

> Remove of_gpio.h header file, replace of_* functions and structs
> with appropriate alternatives.
>
> Signed-off-by: Moses Christopher Bollavarapu <mosescb.dev@gmail.com>
> ---
>  V2 -> V3: Add missing return in front of dev_error_probe
>  V1 -> V2: Move gpio_chip member to top of the struct
>            Use dev_error_probe instead of dev_err
>            Minor style fixes

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
