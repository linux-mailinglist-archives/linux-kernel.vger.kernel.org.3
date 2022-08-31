Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C585A7D82
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 14:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbiHaMgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 08:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbiHaMgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 08:36:18 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40308B876
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 05:36:16 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id cu2so28145219ejb.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 05:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=bZkxF4Gl7HNi0Mqc4gHedXGK3/+SxeeOcfWRC406sbo=;
        b=A+n1vyg3eprzIxpMneJW5BYxflkNBNYo8THCJvZ9xyjLASpNyYAvf3xetDBETyNrIr
         xlw3mz9xAN7ex8K69lyg5lPXsZJhjzKt0sGgN38hM6h23j0q5X1IaTbjYnu3oXYcG4hc
         PznUX+kEVc080tf3qliOWyp0iwtEqFZIpzZq+2lembFvM5HxRhuprGcIvr6QwJ7nKLdr
         s+JJufinCTUpn6aH9iK8sGd8czF5O9Wz7BkJ/ZrDJRUi6Zf5NvfWcRttgPGt66IGywNr
         UxwxpoAjcwP6y63qQjM0I6xk/9/+9NtsUt1SXbmkLel5BhXLrcSUzHr9sfmVJGCqS5RX
         XDRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=bZkxF4Gl7HNi0Mqc4gHedXGK3/+SxeeOcfWRC406sbo=;
        b=sB4Ivgbpuogg/fpSQMS0C/SNF/KDPKqajifAbeAn33nnLdZL0LKFhMKbalhG3sTHAc
         LaH1CzQQ2BH7MBxaHIRVEzUiEApoWafkE3zK6Di6+cwrX40S3pUgNOO/+im20ENvaXyu
         iIm0hrUvmHQo0j0Peix3oLV/+n4GFTrwjt+WbnRX7NDiPPYCYxe8xr0WPEgmi5u1wUTT
         8JVWn/iqqcDD7l0K/raUH5wqQnJZvgOTKLcg3grODEoRfCl3oWU1yHu1exioPScwNRL7
         IdO4Lj4YfSMbJQAFRBrC6uk8WCQxfUubPxST3omFDeaqDbtwCQ4pLoTrXi1vvA2h7d8I
         nD3g==
X-Gm-Message-State: ACgBeo35d2wFe7A3VmvZsVnKyli+r/GYu/+H8k6uxB3ptk73qy6OkKKn
        uYEnsSNQJNsSqCPMqoVs39V9iZkEAZUeSwxhkcXC/w==
X-Google-Smtp-Source: AA6agR7cDw7/rNYVCBnV+wpKD7yxHY4xbXJinDh5Q+MpNkwHa5nKWYWP4NhScX8IlWT01Z5Ps/yfPe8zvwY1JV0zEI8=
X-Received: by 2002:a17:906:8a4e:b0:730:9fcd:d988 with SMTP id
 gx14-20020a1709068a4e00b007309fcdd988mr20162081ejc.636.1661949362413; Wed, 31
 Aug 2022 05:36:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1660839809.git.william.gray@linaro.org>
In-Reply-To: <cover.1660839809.git.william.gray@linaro.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 31 Aug 2022 14:35:51 +0200
Message-ID: <CAMRc=Md5Et-T++mZVw+jXnOWQS23o5hUOATYqs6b+pR1zr57Yw@mail.gmail.com>
Subject: Re: [PATCH 0/6] isa: Ensure number of irq matches number of base
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     linux-iio <linux-iio@vger.kernel.or>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,SUSPICIOUS_RECIPS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022 at 1:11 AM William Breathitt Gray
<william.gray@linaro.org> wrote:
>
> Several ISA drivers support IRQ and call devm_request_irq() in their
> device probe callbacks. These drivers typically provide an "irq" array
> module parameter, which matches with the respective "base" array module
> parameter, to specify what IRQ lines are used for each device. To reduce
> code repetition, a module_isa_driver_with_irq helper macro is introduced
> providing a check ensuring that the number of "irq" passed to the module
> matches with the respective number of "base". The relevant ISA drivers
> are updated accordingly to utilize the new module_isa_driver_with_irq
> macro.
>
> William Breathitt Gray (6):
>   isa: Introduce the module_isa_driver_with_irq helper macro
>   counter: 104-quad-8: Ensure number of irq matches number of base
>   gpio: 104-dio-48e: Ensure number of irq matches number of base
>   gpio: 104-idi-48: Ensure number of irq matches number of base
>   gpio: 104-idio-16: Ensure number of irq matches number of base
>   gpio: ws16c48: Ensure number of irq matches number of base
>
>  drivers/counter/104-quad-8.c    |  5 ++--
>  drivers/gpio/gpio-104-dio-48e.c |  5 ++--
>  drivers/gpio/gpio-104-idi-48.c  |  5 ++--
>  drivers/gpio/gpio-104-idio-16.c |  5 ++--
>  drivers/gpio/gpio-ws16c48.c     |  5 ++--
>  include/linux/isa.h             | 52 ++++++++++++++++++++++++++-------
>  6 files changed, 57 insertions(+), 20 deletions(-)
>
>
> base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
> --
> 2.37.2
>

Looks good to me, do you send your PRs directly to Linus? Do you want
me to take this through the GPIO tree?

Bart
