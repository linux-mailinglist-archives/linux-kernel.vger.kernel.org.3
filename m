Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4A551BFEB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 14:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378232AbiEEM5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 08:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234636AbiEEM5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 08:57:20 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7981D562D2
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 05:53:40 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id dk23so8538162ejb.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 05:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZDiHbRXep/6+iyVjBExAePFQNEIwfM2Y++lVywpRZIA=;
        b=JmUml4YWHv61GXiXI2JyoF4jHOy53241/JumCqgKvphO8ePrl++Lt2BRghiHYcCvxK
         qD4nUjeFfiL8KGlWm4q1J0JF91/JuU4xySs6PCN3+zNheujLLq0P30PogHwssz1VUEwm
         boBP+lF91KbEZ7nfoF+nUYr93RRXTlpBma/zcWHS4bqco/+Wmh+I5W2Oqzq9MgKac+yW
         MkEietDQx61ArfpOTeE7ubKojSmqv9mqZO/4tOuXYnrVFMKsP+w45aVkQE4t964ZVyE7
         2+ZcpXs1Vsnz3DfmFoGCzTGw9xqhNjzGjLxxWrJyrKtomt6DdTDVOURCeHHFNax8h/Yz
         KQmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZDiHbRXep/6+iyVjBExAePFQNEIwfM2Y++lVywpRZIA=;
        b=JDG6/6ZqzrbO1tuEdoaFN0WPW8FVK+6KhBR3NmmE9L8PwMAzRnPZ7FCbkRlvl8OWm1
         5E3ikvsUjmLs2IqQS8UKYWtjOJBXeNxg1HFOGRXH3kOyFCZyjwYNGab5jZeR2mCzw1Zs
         bbzo929uTON63mQbZwdC+WNZml0ShO9UcvTHTXio7g1ivnFXWF6Gbf74TrwgeBYI+xWv
         Iorpnl615lS843ciLBD1Kf60IpvRrOuAvgDM1I5OJzbjN95OZIDQrFhxFp7QcPqVVBYa
         jY10M4QAvmCSy3Qu3pUjzM4I5mMECq9sP3inL6cf+FBWM5xrx49B4JePmSe8s4Ifw6SA
         iwgw==
X-Gm-Message-State: AOAM532kbxTqLzgZfNSuJt7yzXLgTUturCwxc6d+p+isR+GGsQ9AJj6I
        3U2ZCPzvgVPgr/oVply4fF6eFiJHnimtBjMZ8GuiCA==
X-Google-Smtp-Source: ABdhPJx63A3bP0rjtjyKAom95/TvqkcnzhynHc/l8+zWlqYCcu2m88EFVmKf3AOCUbb+ftsGWYZgQtWf0j+Sf/0+vIc=
X-Received: by 2002:a17:907:7e92:b0:6f4:c553:c734 with SMTP id
 qb18-20020a1709077e9200b006f4c553c734mr8125613ejc.286.1651755219026; Thu, 05
 May 2022 05:53:39 -0700 (PDT)
MIME-Version: 1.0
References: <1651703357-25154-1-git-send-email-justinpopo6@gmail.com>
In-Reply-To: <1651703357-25154-1-git-send-email-justinpopo6@gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 5 May 2022 14:53:28 +0200
Message-ID: <CAMRc=Md811qriKCKR9wO0kq6FBW_Pq6WJ3vLnQ1EFno46gzYUQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Add support for NXP PCA6408
To:     Justin Chen <justinpopo6@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 5, 2022 at 12:30 AM Justin Chen <justinpopo6@gmail.com> wrote:
>
> The NXP PCA6408 is the 8 bit/8 GPIO version of the NXP PCA6416.
>
> Justin Chen (2):
>   gpio: pca953xx: Add support for pca6408
>   dt-bindings: gpio: pca95xx: add entry for pca6408
>
>  Documentation/devicetree/bindings/gpio/gpio-pca95xx.yaml | 1 +
>  drivers/gpio/gpio-pca953x.c                              | 2 ++
>  2 files changed, 3 insertions(+)
>
> --
> 2.7.4
>

Both applied, thanks!

Bart
