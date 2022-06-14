Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B15C54B294
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 15:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240927AbiFNNyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 09:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235174AbiFNNyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 09:54:18 -0400
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50BF538BF5;
        Tue, 14 Jun 2022 06:54:17 -0700 (PDT)
Received: by mail-qk1-f171.google.com with SMTP id l192so4234453qke.13;
        Tue, 14 Jun 2022 06:54:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xff5oMuYjLIbpEy0I37sAZKgq+SJdneKw8SbYhPEF5I=;
        b=nRDD3I8h1/FTTPcU8qL+oryXac8KYjQ0f2dJyQsmIFBur17FRVx4EUqW6Xv3ijZXj9
         nV9c9L6VSXuu6cgIGr6PVsxS7BjTT4VWDkhO4bpTj9feQIylpqZr90YN+dpWzL/IKw8A
         +j6Ib4LUjWhPXj2cuC3KYXBAVhJwe1kFBfy5niamAAPIzkPic4h4y+8PpuTw+IPkFZ9o
         r2O+nlZnt7llr/VEDk7qix0dtYrBH6QVfrz8pnLEuYyTfZbJcdFMku7aCs/u3ZaS80FI
         +PhaZ2dKd08xmWCzuV7erO9w0mxdnhGFqiAa4PooheEanY7Tn3zbscD6iusLZUVHXlac
         EcWA==
X-Gm-Message-State: AOAM5316auRire1S1S1uIYW1AMucYqHWMznkL6Qb8ucQhK238APHcgbl
        zQjxgQAAxZl4DKV7k7XxaFXzLHzEBIXcpg==
X-Google-Smtp-Source: ABdhPJwEzp+nvoYhRugOLlCy39LiBYye9UwFah536hRdaTLvWjIcYfu2nJccJn5kXOVn+KcL2t1Q8Q==
X-Received: by 2002:a05:620a:917:b0:6a6:b76b:d6b4 with SMTP id v23-20020a05620a091700b006a6b76bd6b4mr3890055qkv.279.1655214856091;
        Tue, 14 Jun 2022 06:54:16 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id j1-20020a05620a410100b006a65c58db99sm9813084qko.64.2022.06.14.06.54.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 06:54:15 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-3137316bb69so30076547b3.10;
        Tue, 14 Jun 2022 06:54:15 -0700 (PDT)
X-Received: by 2002:a81:1dd2:0:b0:30f:a4fc:315e with SMTP id
 d201-20020a811dd2000000b0030fa4fc315emr5910787ywd.383.1655214855297; Tue, 14
 Jun 2022 06:54:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220610201701.7946-1-wsa+renesas@sang-engineering.com> <20220610201701.7946-2-wsa+renesas@sang-engineering.com>
In-Reply-To: <20220610201701.7946-2-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 14 Jun 2022 15:54:03 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW3uxQHk6SBX5MqnZsYqwY8p+0wmD6gHwS3ESUrkmpWkQ@mail.gmail.com>
Message-ID: <CAMuHMdW3uxQHk6SBX5MqnZsYqwY8p+0wmD6gHwS3ESUrkmpWkQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] dt-bindings: thermal: rcar-gen3-thermal: Add
 r8a779f0 support
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

On Fri, Jun 10, 2022 at 10:17 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Add support for R-Car S4. The S4 IP differs a bit from its siblings in
> such way that it has 3 out of 4 TSC nodes for Linux and the interrupts
> are not routed to the INTC-AP but to the ECM.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>
> Change since V2:
> * make interrupts not required for this SoC

Thanks for the update!

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.yaml
> +++ b/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.yaml

> @@ -79,8 +80,16 @@ else:
>          - description: TSC1 registers
>          - description: TSC2 registers
>          - description: TSC3 registers
> -  required:
> -    - interrupts
> +  if:
> +    not:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - renesas,r8a779f0-thermal
> +  then:
> +    required:
> +      - interrupts

While correct, IMHO adding this check here loses again the improvement
made by "[PATCH v3 1/2] dt-bindings: thermal: rcar-gen3-thermal: use
positive logic".

What about splitting this in two separate checks at the top level:
  - one for regs (R-Car V3U vs. the world), and
  - a second for interrupts (R-Car V3U+S4-8 vs. the world)?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
