Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8A04E53F1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 15:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244635AbiCWOHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 10:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244629AbiCWOHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 10:07:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04EB7E09B;
        Wed, 23 Mar 2022 07:05:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78AE1616DB;
        Wed, 23 Mar 2022 14:05:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB3E2C340E8;
        Wed, 23 Mar 2022 14:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648044345;
        bh=1oAteS9kFdrvyEzNGdIhJUXXW3m2qPYEMmS/a468Uzo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oAvdrJwwvv0nTDkqjTkFxUBB0Uv5Xs+zarFCEWHugKri/ymW17SYVahPoE5wAK5fM
         FubYzfJjvyJKx3tzHi7m2z9xh1/fYcZEc0nEkGdjqwUVeTPM/GwZysQgjZmeh6hY4p
         x/JfwA/kwpS2UPYH89Qs+2MLo8DJguNBl36zG7zPzaDubIsO23XtHF/N7U1Su9G9KE
         Q6ldUWSTg26zKTJZtBhchqjoiKVw9zwV9rWakuQe4LS5n2uFEJ/VgOb3Re24xhjiKo
         8Loh6fooVwyMU2w5mZEiuCST/IF08ylTShDUI/xLwbnG04nbLjNySVNpg00aaFuZxM
         5KQ5KAGudir1A==
Received: by mail-ej1-f41.google.com with SMTP id d10so3032633eje.10;
        Wed, 23 Mar 2022 07:05:45 -0700 (PDT)
X-Gm-Message-State: AOAM53074xT6D2BDVdoLmjAE/bvcdWeMP29cQ/0Zo3BsfJLySWp/oQYD
        plmFa8/vcVlxmkHvdCN4E7ciL9puAzJIHJOYvQ==
X-Google-Smtp-Source: ABdhPJy7E6vyxf070rK6ZOCxsK5AWkoUKOUi1IbGT0yD0nul4jRGmi2hr2Mpc0tM9FE9EBpY85DFp3LmxDC9L4QwWts=
X-Received: by 2002:a17:907:1c1b:b0:6e0:6618:8ac with SMTP id
 nc27-20020a1709071c1b00b006e0661808acmr137550ejc.82.1648044344180; Wed, 23
 Mar 2022 07:05:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220301233501.2110047-1-robh@kernel.org>
In-Reply-To: <20220301233501.2110047-1-robh@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 23 Mar 2022 09:05:32 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKs=00e_XdO4W0oML6DVrhR3CsSTD+Cfamcx52i=DAE9g@mail.gmail.com>
Message-ID: <CAL_JsqKs=00e_XdO4W0oML6DVrhR3CsSTD+Cfamcx52i=DAE9g@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: media: mediatek,vcodec: Fix addressing cell sizes
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 1, 2022 at 5:35 PM Rob Herring <robh@kernel.org> wrote:
>
> 'dma-ranges' in the example is written for cell sizes of 2 cells, but
> the schema and example specify sizes of 1 cell. As the h/w has a bus
> address of >32-bits, cell sizes of 2 is correct. Update the schema's
> '#address-cells' and '#size-cells' to be 2 and adjust the example
> throughout.
>
> There's no error currently because dtc only checks 'dma-ranges' is a
> correct multiple number of cells (3) and the schema checking is based on
> bracketing of entries.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> I noticed the driver is checking 'dma-ranges' itself. That's generally
> wrong as the core code should be configuring bus dma masks
> automatically.
> ---
>  .../media/mediatek,vcodec-subdev-decoder.yaml | 122 +++++++++---------
>  1 file changed, 64 insertions(+), 58 deletions(-)

Can this fix be applied for rc1? Still failing in linux-next.

Rob
