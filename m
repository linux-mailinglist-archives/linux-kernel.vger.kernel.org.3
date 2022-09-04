Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C57545AC64A
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 22:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235089AbiIDUM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 16:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234482AbiIDUMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 16:12:54 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783C22A737
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 13:12:52 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id r4so8973596edi.8
        for <linux-kernel@vger.kernel.org>; Sun, 04 Sep 2022 13:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=wc+Wz38j60Q7l1csFn+LeKvfSEVzWwyMdA8x0tTNYDU=;
        b=hVb7tdmwazu5pkbV6qFjL1GEHrl1kx/9pXjgESq2R/SXYgg3b1BCCycnFo0I4aTv72
         qA1tLsAPDmGIfWm3v6xjFuPst3sgaYwOMl6Hx2XUW4XBx4MeBrt9NYjsKcnt1Li3dAcz
         0vmCHt44/4Cqbfai5bW2p8i7evMawEoewYuz99bD5Pep8TVpgN/0PBxurC4BWtdEUMMj
         jmkihigLI24idoLLpr+zXy4lR0IYEvWJ8xCl0ceHHvXR/KM01QPET5O523Bvxm4+ome6
         ZC49Qrfyx3jfAvh9fn5wJTcV/CUwOZSvtBYJWabGtEvN3/irW1uwufThu+9KJc0MXGvl
         5y/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=wc+Wz38j60Q7l1csFn+LeKvfSEVzWwyMdA8x0tTNYDU=;
        b=23dzwRMITZLf3aN0/ZTNYUd7zRrSDXBzA3BRoW08ryAY7RrHOZie//dLEm4O43UBMD
         tOGwHetLkEFMqLRzcqC9QG9rzaX9nSDbP6m28JcH6gFyd+QTiOYUTc4DY46eMac+vqg/
         r/tHLwDjInCovCrEYpbwSuBOvso6fX1PWrsFALG+48QC/yRi7tXve6DYNUNAY48IPS8t
         8n2m9EJlk0Rgh3hYyAU1FyB3egxregu9hWtmP228B+gCWfGDHy1NnGvY0TArNhfDLBLw
         vYImMASep6MBe55rI+qRHHocg2biKIeG9Zdg8nPtHdfW3PSwYdGSBTcEk/adn+fqRLt0
         qkrQ==
X-Gm-Message-State: ACgBeo15s9RoIVprVOmBv75emeU/cscThIuOrYeTGyZCDvZNBy4LrcIy
        NDs1zd8bybGyLzx4zDoLjzyX2ug/PQueaFoISFhZlA==
X-Google-Smtp-Source: AA6agR4HfZragLapKkUjZzy4TZmv6ATE2JGl7SwGjuVIiL+0XwxHvpfhtc/5VoGeTkXZNhjZdh47ayKNxwRyfvYNWvg=
X-Received: by 2002:a05:6402:2073:b0:44e:3555:5fcd with SMTP id
 bd19-20020a056402207300b0044e35555fcdmr4044581edb.82.1662322371057; Sun, 04
 Sep 2022 13:12:51 -0700 (PDT)
MIME-Version: 1.0
References: <YxRDRx3oubAISIB0@google.com>
In-Reply-To: <YxRDRx3oubAISIB0@google.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Sun, 4 Sep 2022 22:12:40 +0200
Message-ID: <CAMRc=Me+4xEgH8S9C594rrd=2_oBe4wqC+ay5iS0YqmEBCuDPQ@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: make fwnode_get_named_gpiod() static
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Sun, Sep 4, 2022 at 8:18 AM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> There are no external users of fwnode_get_named_gpiod() anymore, so
> let's stop exporting it and mark it as static.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---

Applied, thanks!

Bart
