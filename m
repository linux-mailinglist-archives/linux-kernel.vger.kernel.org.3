Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02F5568EF5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 18:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233823AbiGFQVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 12:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232523AbiGFQVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 12:21:16 -0400
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC24313D1E;
        Wed,  6 Jul 2022 09:21:15 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id v185so14445190ioe.11;
        Wed, 06 Jul 2022 09:21:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=46WFx0LHKHo7IAjx9SQsto+DNFSa6rkI9h3YC0DlQ/0=;
        b=bgqFOdwH1VqsnFwXFXuF1zFEqPWatdgv33CfgxiZsS8XU8CMuzOUktLEQpgTgOgonF
         qvBVKpWCD0dNEmRpJyFsDSiufxKgNuxnobBZUpy5P8iq5FxLdVwLfItn8nlbgBrLP3j4
         u80fGIs1fLIIpzxDh/EETpEkVhX+UnsdEHT2iVI1iLPMRxiiGKYIhlPxEKhAnwru3RGm
         AX3i14Q9wNERuWjJfWtM2KGTWi7dj1QSGLf3Hp2qyKmrDfs70OnOBKrDsscaHCpNnaHL
         wvI5fhlBUChtK+0gsjBUTBHQ7SaX8KHqKMO/KvU5yvBYZJOeU18htsDhmdoaWE5o5RTI
         YlhA==
X-Gm-Message-State: AJIora/IBopWcz2zOIwKf3gVmWzkzzg4ZLeJ+iTHqrUhyrCRZYGrK6wP
        l2clu6N2KvfrGexh1k9ApjINNYNYdw==
X-Google-Smtp-Source: AGRyM1uzgpPbhEro+IwOoGJCq5wslAcjXi1VJdWM93SO/U9U4sSTIx/BH4UE5y/3LRenbByBT6eqIw==
X-Received: by 2002:a05:6638:2110:b0:33b:b100:551e with SMTP id n16-20020a056638211000b0033bb100551emr26646242jaj.116.1657124473556;
        Wed, 06 Jul 2022 09:21:13 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id r16-20020a02b110000000b0032e271a558csm15967124jah.168.2022.07.06.09.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 09:21:13 -0700 (PDT)
Received: (nullmailer pid 151818 invoked by uid 1000);
        Wed, 06 Jul 2022 16:21:11 -0000
Date:   Wed, 6 Jul 2022 10:21:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: leds: register-bit-led: Add value
 property
Message-ID: <20220706162111.GA145516-robh@kernel.org>
References: <20220706112828.27278-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220706112828.27278-1-pali@kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 01:28:27PM +0200, Pali Rohár wrote:
> Allow to define inverted logic (0 - enable LED, 1 - disable LED) via value
> property. This property name is already used by other syscon drivers, e.g.
> syscon-reboot.

Yes, but those are potentially multi-bit values. This is a single bit 
value, and the only value that's ever needed is 0. Why not just use 
'active-low' here?

> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---
>  .../devicetree/bindings/leds/register-bit-led.yaml    | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/leds/register-bit-led.yaml b/Documentation/devicetree/bindings/leds/register-bit-led.yaml
> index 79b8fc0f9d23..d6054a3f9087 100644
> --- a/Documentation/devicetree/bindings/leds/register-bit-led.yaml
> +++ b/Documentation/devicetree/bindings/leds/register-bit-led.yaml
> @@ -43,6 +43,17 @@ properties:
>          0x100000, 0x200000, 0x400000, 0x800000, 0x1000000, 0x2000000, 0x4000000,
>          0x8000000, 0x10000000, 0x20000000, 0x40000000, 0x80000000 ]
>  
> +  value:
> +    description:
> +      bit value of ON state for the bit controlling this LED in the register
> +      when not specified it is same as the mask
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum:
> +      [ 0x0, 0x1, 0x2, 0x4, 0x8, 0x10, 0x20, 0x40, 0x80, 0x100, 0x200, 0x400, 0x800,
> +        0x1000, 0x2000, 0x4000, 0x8000, 0x10000, 0x20000, 0x40000, 0x80000,
> +        0x100000, 0x200000, 0x400000, 0x800000, 0x1000000, 0x2000000, 0x4000000,
> +        0x8000000, 0x10000000, 0x20000000, 0x40000000, 0x80000000 ]
> +
>    offset:
>      description:
>        register offset to the register controlling this LED
> -- 
> 2.20.1
> 
> 
