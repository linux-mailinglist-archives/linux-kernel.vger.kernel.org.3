Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B60A523F7D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 23:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348205AbiEKVes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 17:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236560AbiEKVep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 17:34:45 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFE072225;
        Wed, 11 May 2022 14:34:44 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id bq30so5821491lfb.3;
        Wed, 11 May 2022 14:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dkXitGd+HBwWP0BrRmMn4GOcEWAupdlYdgwnIyYYKm8=;
        b=DkVXOGzNB1qNE0XvArz6clezkHzUFTA+/bHkUwLQbjO2pg/YLc4Rimbv8c1sie5NCN
         PvwjLDJtWhuIvvl63J9+V1eioKpHzAIqNijLXV21lcU1KY72dLv+Do4/d/p5R1jfD8LT
         SByT8e9K914f6sWXbZxkEgh7aLr605RIY1PddkpXywnE7eQ7n00vLyYVPc5wBDoJp4aw
         q7CgeMKGhlRxD/UZt5E2Qb7GzG6n4e5vhC8aEV587MYK592tDnF5iKG63gz2MN/wFr7T
         NpBx78okZh8ocaxv3znzdI9tO2TSNTqB6sU08geGcliRcBEXXSi2LmFMeOdKxgleu0xY
         RwjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dkXitGd+HBwWP0BrRmMn4GOcEWAupdlYdgwnIyYYKm8=;
        b=lbzJH5JcknO18K4jPP7+pRm1ru5m1b09NOgvogkYN2aS8+A4tgHHmuyhz3OTE/XqU1
         UelxNPdOThPcv3z5W7CL6ngL2U4dcTLsa81A9FaUqnK8BYfaY9mOkgtVHBercWQFVV7g
         H7j/nRIMd8QTasYspdtH5s5bRSd7A1/rSeqHZLaS3pT7lP20GMC4aLMKzVHXPWDuLtId
         nC/coyGME4/hgtC3mWozCjsOriTNnKlLz0Mvcw54VOSYKUc+XqMbxsu7tL/7szinkqJJ
         s3IIum1um4PVhyX+7gEnOo3zChqfnXyr7rJx12PhtEAQ82e1ZsH53RX+SK/GYKkypzIF
         2kzw==
X-Gm-Message-State: AOAM533UoRP6ZpBl/dkG9Vof1wsT8EgovfZf/3jKQmXfQIon4SLNqNdU
        2EhPfxtz23zd2Rz9v6V54RBiU9l5gNWOg7bVw/0=
X-Google-Smtp-Source: ABdhPJytbw5z0Ik8FAPUOw+tWwgubew6nL311yZ3ED/hQRTLcKxwAZrZ+D/r8tlUcZ6OBNpMjKduuQT/1Z4sD0iNfps=
X-Received: by 2002:a05:6512:34cc:b0:472:5c4e:34cb with SMTP id
 w12-20020a05651234cc00b004725c4e34cbmr21704041lfr.94.1652304883056; Wed, 11
 May 2022 14:34:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220510191549.76105-1-mosescb.dev@gmail.com> <20220511205959.10514-1-mosescb.dev@gmail.com>
In-Reply-To: <20220511205959.10514-1-mosescb.dev@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 11 May 2022 23:34:06 +0200
Message-ID: <CAHp75Vcy7+ebAeCfUx5w3i1_=G6n2HkdzXtQcRBFv87X2wZ3vQ@mail.gmail.com>
Subject: Re: [PATCH v2] drivers: gpio: zevio: drop of_gpio.h header
To:     Moses Christopher Bollavarapu <mosescb.dev@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Wed, May 11, 2022 at 11:00 PM Moses Christopher Bollavarapu
<mosescb.dev@gmail.com> wrote:
>
> Remove of_gpio.h header file, replace of_* functions and structs
> with appropriate alternatives.

...

>  V1 -> V2: Move gpio_chip member to top of the struct
>            Use dev_error_probe instead of dev_err
>            Minor style fixes

Almost, see below.

...

> +       controller->regs = devm_platform_ioremap_resource(pdev, 0);
> +       if (IS_ERR(controller->regs))
> +               dev_err_probe(&pdev->dev, PTR_ERR(controller->regs),
> +                             "failed to ioremap memory resource\n");

You forgot 'return'.

-- 
With Best Regards,
Andy Shevchenko
