Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF2655794BD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 09:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233880AbiGSH7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 03:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiGSH7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 03:59:10 -0400
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCB13718B;
        Tue, 19 Jul 2022 00:59:09 -0700 (PDT)
Received: by mail-qk1-f169.google.com with SMTP id e16so6669693qka.5;
        Tue, 19 Jul 2022 00:59:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SinWpubHQ2i2HLeUGrf7mRkcL390c6uJOjds3tWCIu8=;
        b=RwM9+NOQRQhaHO1MtO40MGQ4PHsUrxhDbAz3BI/1/9AxCrGON84ODiWnW+daA/YeBb
         Sm9X1ALJ4dwhP+Kb45Uc7CL7vIAZDf+kofMB9rLi/vLHggQTW6/w8RplpFH2o9VLWMNb
         2Ag35AWt5j6lAEo+9Nf7tJGUee+2zIsw3WRuIvKTpo42pZ5GYfsb701tQM1KKwcK6stW
         nu6fDnDZozELzIkm2RAH00bgRbJmzMwwY4uCR+OFblHA9mMbaEf5Q8VZEG6pISnjKR3f
         ntCjCqUsjV7OnHs49PkjbesOE1/qsLcUhow1QXC7H0Fo9oYcMckDPJcawbhs187jolBh
         8uZw==
X-Gm-Message-State: AJIora8CNKo03n+nl5ost38M7pcqCPjuOU7aN5qlgX+gRWVJ3f6sR27G
        +MTbI564l/m95xZ9cD2lTeffS8uocw1rwg==
X-Google-Smtp-Source: AGRyM1t1St5mlw8s9IWuhFxKjJ8/hFb+wGiAT+OlshRqO2V1slilyx/3fns9G3BBFpESc51b1eCz0g==
X-Received: by 2002:a05:620a:808a:b0:6b5:4d1b:c0f5 with SMTP id ef10-20020a05620a808a00b006b54d1bc0f5mr19826362qkb.713.1658217548661;
        Tue, 19 Jul 2022 00:59:08 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id y17-20020a05620a25d100b006b46a78bc0fsm13024719qko.118.2022.07.19.00.59.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 00:59:08 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-31e560aa854so20340437b3.6;
        Tue, 19 Jul 2022 00:59:08 -0700 (PDT)
X-Received: by 2002:a0d:dd09:0:b0:31c:e3b9:7442 with SMTP id
 g9-20020a0ddd09000000b0031ce3b97442mr35319389ywe.47.1658217547996; Tue, 19
 Jul 2022 00:59:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220713100603.3391-1-wsa+renesas@sang-engineering.com> <20220713100603.3391-3-wsa+renesas@sang-engineering.com>
In-Reply-To: <20220713100603.3391-3-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 19 Jul 2022 09:58:56 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVio5-ap_=igQXChyZgd3g-78srd3WbBRj=GJuw=yS3xg@mail.gmail.com>
Message-ID: <CAMuHMdVio5-ap_=igQXChyZgd3g-78srd3WbBRj=GJuw=yS3xg@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: timer: renesas,cmt: R-Car V3U is R-Car Gen4
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 12:06 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Despite the name, R-Car V3U is the first member of the R-Car Gen4
> family. Hence move its compatible value to the R-Car Gen4 section.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
