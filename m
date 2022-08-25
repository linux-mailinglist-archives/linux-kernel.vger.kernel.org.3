Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F3F5A1654
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 18:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242918AbiHYQFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 12:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242120AbiHYQFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 12:05:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E80B72BF;
        Thu, 25 Aug 2022 09:05:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EEEDCB82A2C;
        Thu, 25 Aug 2022 16:05:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A16BFC43470;
        Thu, 25 Aug 2022 16:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661443510;
        bh=6iCpl0Hcs3sEp5yCjW0MZq2TPzAobeG7OT/sl8vuJnk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tjKD/WBK2xg9bSRHOp7laO2gkYDoqPH3/vVbGtN5jVqRUpKFaZrHQ7J39rznD0dWf
         Q8upnWyH0eDXiu46LyFkDAg+f1B1s+XbBxfxOwZWT2J/Dpuf8QH6JE6wN6x90rU0J5
         ggRU7gJJdr+tmJUGYHvtdgWUUSeU3VS89bWadNC2VtxvQh+B3g3HCwZ8YxPBkq6yom
         Au8232gLSw5ae5uO7uYLsmrVBXlm4UCHLSCEVdH161iPWw/b8VIt1IQAaObnDAkJDp
         rORO6LwRVV3BfRuK6LxjQibbJll+KMZxbvboI7RoyWD31X+Zih7IKFvWRKgMIUj7NM
         0gDi/JHsnE1nA==
Received: by mail-vs1-f44.google.com with SMTP id 190so13116662vsz.7;
        Thu, 25 Aug 2022 09:05:10 -0700 (PDT)
X-Gm-Message-State: ACgBeo1YDsD6viQBZAJc6pXxjimlqpo7kNdRb8WyuktbO9s6aZTk4QmI
        bNCEvc+y5r19CEvyrwybDEzzquyFWANGzlo6CQ==
X-Google-Smtp-Source: AA6agR6++ST1e9+x73UkATqQpmOKAHJYkkfidUHtKFPnK8KzTQGUzp235lErg/ikL/FVEQG/vhuoz9apf53yKGV+Jpo=
X-Received: by 2002:a67:c182:0:b0:390:3fa6:6afd with SMTP id
 h2-20020a67c182000000b003903fa66afdmr1905098vsj.53.1661443509560; Thu, 25 Aug
 2022 09:05:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220825104505.79718-1-etienne.carriere@linaro.org>
In-Reply-To: <20220825104505.79718-1-etienne.carriere@linaro.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 25 Aug 2022 11:04:58 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLWQC-drkWdgiM4TnsZCa6h6vcMmCvrUC_E7z5=gYtcJw@mail.gmail.com>
Message-ID: <CAL_JsqLWQC-drkWdgiM4TnsZCa6h6vcMmCvrUC_E7z5=gYtcJw@mail.gmail.com>
Subject: Re: [PATCH] dt-binding: gpio: publish binding IDs under dual license
To:     Etienne Carriere <etienne.carriere@linaro.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Stephen Warren <swarren@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Charles Keepax <ckeepax@opensource.wolfsonmicro.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 5:45 AM Etienne Carriere
<etienne.carriere@linaro.org> wrote:
>
> Changes gpio.h DT binding header file to be published under GPLv2 or
> BSD-3-Clause license terms. This change allows these GPIO generic
> bindings header file to be used in software components as bootloaders
> and OSes that are not published under GPLv2 terms.
>
> All contributors to gpio.h file in copy.
>
> Cc: Stephen Warren <swarren@nvidia.com>

We have NVIDIA permission for anything in bindings and NVIDIA
relicensed the irq headers, so I think it shouldn't be a problem.

> Cc: Linus Walleij <linus.walleij@linaro.org>

FYI, There is blanket approval from Linaro to relicense DT files.

> Cc: Laxman Dewangan <ldewangan@nvidia.com>
> Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

I don't think a blank line is copyrightable.

> Cc: Andrew Jeffery <andrew@aj.id.au>
> Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> Cc: Nuno S=C3=A1 <nuno.sa@analog.com>
> Cc: Bartosz Golaszewski <brgl@bgdev.pl>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
>
> Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> ---
>  include/dt-bindings/gpio/gpio.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
