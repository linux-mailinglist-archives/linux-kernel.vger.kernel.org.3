Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEA44F9385
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 13:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbiDHLMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 07:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiDHLL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 07:11:58 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316541F9;
        Fri,  8 Apr 2022 04:09:54 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id l7so11192447ejn.2;
        Fri, 08 Apr 2022 04:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=918u9S2PhfmGwhTKyqYKA9YXzqxdHFTZDcAn11BmImU=;
        b=G+DuWB37PrwAEULcdvBxilvoCWAN02EDgldDQUGMSSQqfj9ZDSXVHz+4+6cXyA9EQW
         scEiwNRs82zknRJTAip04cErtewExi1Lme43KUO+xHxQLF7PDLel9cr+05UHyH4fHn/K
         9k2oPP8D75yxFs7YKV5oQPR5CzyO5yQV9a8EE93RhEwq/t4FiPdsDzUFmpdplgc6T4W4
         9xdaYXDa0EMbIJMoHJplkPGfuBxGqSSv3G+JYpIHmu0EmCTyNDR438dOo54l8VMRwHIC
         fQeTn5AgDrXavUpxAt9hQTK8iqzUI73eBK35zN6ep9B+EZMRFnRoC+JdADvTTJpshBek
         Gx/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=918u9S2PhfmGwhTKyqYKA9YXzqxdHFTZDcAn11BmImU=;
        b=gQd6ltVFXKSOt1/Mn8vZs6IMmb24eT9e0VT3C+dEoFadWqSF2j8doUD6msxa8wiz2O
         2DtFuV7Y649+IAVB3ybjGkcfNIHTd6AuPpcb489fEIg0XHshwmqdxPnQSV+ZyGwbI8sy
         7LLfdNGkpu+HVkF+j2AQ1/F5k5o3OZ+YZUjspe5BOoPtbp4VAcL0LefMQrme9+Ae6C/J
         NHD3DHGpUQVwYEaAUdq2TEscqvDfTwWh4hrae+TWLxQ7t5N9b7UW6fW3vOELxmEp+Jok
         KwoZ+TULIZlnibcRMPnMdMjN+3Wd70IPrxy0ABO+f4fbAbaRFSQIFRzY2RQLY3DsNByF
         i/Gw==
X-Gm-Message-State: AOAM5307ZUQwWHLjVyp0dShi7OfSokChGMCecko1gANIjyG9H37tyDOI
        i7rYuCh6lV7Gvj+6wd0T4Fp4VwFk04bvg3PmR+A=
X-Google-Smtp-Source: ABdhPJx7dSmNNuGyDMucpcenHMHbI3t4J35CIGAwuf++Br+nt2ZKUQLR9k/derUEvtPK4ZddUQexkbI8ChLXgKIbrPA=
X-Received: by 2002:a17:907:728e:b0:6e7:edf7:f0a4 with SMTP id
 dt14-20020a170907728e00b006e7edf7f0a4mr18029233ejc.497.1649416190704; Fri, 08
 Apr 2022 04:09:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220407115126.69293-1-markuss.broks@gmail.com> <20220407115126.69293-3-markuss.broks@gmail.com>
In-Reply-To: <20220407115126.69293-3-markuss.broks@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 8 Apr 2022 14:05:33 +0300
Message-ID: <CAHp75VcpPvU7Nh5XBx7Xo7LyQS36Um+6z0u-KkU1185W-fgfRA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] leds: ktd2692: Make aux-gpios optional
To:     Markuss Broks <markuss.broks@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        phone-devel@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
        <devicetree@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy
        Shevchenko <andy.shevchenko@gmail.com>," 
        <~postmarketos/upstreaming@lists.sr.ht>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
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

On Thu, Apr 7, 2022 at 9:03 PM Markuss Broks <markuss.broks@gmail.com> wrote:
>
> Make the AUX pin optional, since it isn't a core part of functionality,
> and the device is designed to be operational with only one CTRL pin.
>
> Also pick up maintainership for the LED driver and the yaml bindings.

Same comments as per v1 are still applicable here.

-- 
With Best Regards,
Andy Shevchenko
