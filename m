Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 893E64FE09F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 14:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350910AbiDLMnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 08:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353900AbiDLMmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 08:42:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E0113DEF;
        Tue, 12 Apr 2022 05:07:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9EC83B818BB;
        Tue, 12 Apr 2022 12:07:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45D77C385A9;
        Tue, 12 Apr 2022 12:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649765236;
        bh=ogE5ybnNzjbeaUs8XfhvgUoIApTax4ov6E7K92asMNs=;
        h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
        b=D0eLDKVUOEryqXyU30wgT0oTEy0cz/IBaKwg4xHwd+6zv6MHtDFJdDgz5RoGilSzn
         wtTvZ9lQMiF/VuljH7jAAEFKCiUKlWUH0htyeFlif5dgbPJlc5jbaAiIy8/Wual4pY
         dt/zfJWayDw6bcWo3oxKz8ku+NdWPo8xHTOWSAWh5fk47gtku9hhwzxwbvpME1k28g
         sF/MepEwB7/h7R4oHkMDGRrMF2/EGQ9oJJ0pM/fcJ710znASgvZfTpTAV9V46bH07Z
         ybe7bKFYcKiK8Om358xyiV67yCbz1YdOWEWwt3OAZ6mKejFeiNZLkB2fRoM5gkpcxY
         8ErR7+RY+Bf+A==
Received: by mail-vs1-f41.google.com with SMTP id u2so14017745vsl.6;
        Tue, 12 Apr 2022 05:07:16 -0700 (PDT)
X-Gm-Message-State: AOAM5309oIEfuOy4YTUes1u9SkB5WY9zW45XbBLMKDurRpumRH6/Ev9x
        S7Bzh5rpKSsbduID0i1o9a5mt1USvXJ1WVUfCJo=
X-Google-Smtp-Source: ABdhPJzjEEHJ1j3lKpjqp/WFdHMDZcR/5QTgBJgXwmPXWsXCZQHuWZkG7PxraL3PSeHLZ50+5phOm6ZKNJy+juNEIBM=
X-Received: by 2002:a05:6102:3098:b0:328:1825:61f8 with SMTP id
 l24-20020a056102309800b00328182561f8mr7138726vsb.39.1649765235208; Tue, 12
 Apr 2022 05:07:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220411211243.11121-1-javierm@redhat.com> <20220411211243.11121-2-javierm@redhat.com>
In-Reply-To: <20220411211243.11121-2-javierm@redhat.com>
Reply-To: wens@kernel.org
From:   Chen-Yu Tsai <wens@kernel.org>
Date:   Tue, 12 Apr 2022 20:07:03 +0800
X-Gmail-Original-Message-ID: <CAGb2v65CBZp3DZFGX0GMTaQQPYMKJTJMNoU2V5u7MxsLN7ONKQ@mail.gmail.com>
Message-ID: <CAGb2v65CBZp3DZFGX0GMTaQQPYMKJTJMNoU2V5u7MxsLN7ONKQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] dt-bindings: display: ssd1307fb: Deprecate "-i2c"
 compatible strings
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 5:12 AM Javier Martinez Canillas
<javierm@redhat.com> wrote:
>
> The current compatible strings for SSD130x I2C controllers contain both an
> "fb" and "-i2c" suffixes. It seems to indicate that are for a fbdev driver
> and also that are for devices that can be accessed over an I2C bus.
>
> But a DT is supposed to describe the hardware and not Linux implementation
> details. So let's deprecate those compatible strings and add new ones that
> only contain the vendor and device name, without any of these suffixes.
>
> These will just describe the device and can be matched by both I2C and SPI
> DRM drivers.
>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> Acked-by: Mark Brown <broonie@kernel.org>
> ---
>
> Changes in v2:
> - Drop the -i2c suffixes from the compatible strings too (Geert Uytterhoeven).
>
>  .../bindings/display/solomon,ssd1307fb.yaml   | 37 ++++++++++++-------
>  1 file changed, 24 insertions(+), 13 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml b/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
> index ade61d502edd..6b9d0c72739a 100644
> --- a/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
> +++ b/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
> @@ -12,12 +12,23 @@ maintainers:
>
>  properties:
>    compatible:
> -    enum:
> -      - sinowealth,sh1106-i2c
> -      - solomon,ssd1305fb-i2c
> -      - solomon,ssd1306fb-i2c
> -      - solomon,ssd1307fb-i2c
> -      - solomon,ssd1309fb-i2c
> +    oneOf:
> +      # Deprecated compatible strings
> +      - items:
> +          - enum:
> +              - sinowealth,sh1106-i2c

I think you can just drop this one, since it was just merged and isn't
part of any release yet. It's not even in -rc.

ChenYu
