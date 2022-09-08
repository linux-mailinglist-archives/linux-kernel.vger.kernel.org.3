Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE8525B2828
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 23:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiIHVKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 17:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiIHVKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 17:10:51 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916E8AFADF;
        Thu,  8 Sep 2022 14:10:50 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-1225219ee46so47870821fac.2;
        Thu, 08 Sep 2022 14:10:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=zfndm6ZjNK+nyBAXm1bE++mugJgmz7n8011cfYpE7ng=;
        b=s+q5zDn9b3NJxAd78aj1E95qgyueJ7k13iJ5mbJ3qYQYMETRvz62Cu4zEtHvwcp4O0
         4gOcO50t80VfcKKxUkTdtkhBgC01ky9xpI7hNRpbfl4S2aNopmDa+PxYFVoN9gdcmfKm
         nrzZPBahJG+CHztI1gDGX2ocHq3OfofACN/l67FJapfFiBrTFwqI0NsGJuDMPOHRGOQX
         aAJ+PadrbxV6iMO2H/Vp+47lwz3iUc4hCZkhpkidDdfU2hVhJktRHCzhcMo5GdYDScNl
         1YRTe1dYlWZDaQi8jnjaiwzXazWklC3mYol+hj6SLwAjr7ipWm3yeX3k9szw6M9hJDZf
         vjuA==
X-Gm-Message-State: ACgBeo1jaUVI19DeAFfMCc2nfujBU3lkDAvH6f7vQ+1fC7q6PmdjMd5a
        c/V7U+HJJlIO+6MMHo0QOg==
X-Google-Smtp-Source: AA6agR7uIvfdL0AQHlvEdsBw7yQFmAYFl8s5B05xSx+ae1R3SgNo7MqtvEIDvM02GimT6ULcs/kHgQ==
X-Received: by 2002:a05:6870:d625:b0:127:db0a:c4ac with SMTP id a37-20020a056870d62500b00127db0ac4acmr2997971oaq.75.1662671449845;
        Thu, 08 Sep 2022 14:10:49 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s65-20020acac244000000b0034d8b1b3c4bsm473392oif.36.2022.09.08.14.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 14:10:49 -0700 (PDT)
Received: (nullmailer pid 3347339 invoked by uid 1000);
        Thu, 08 Sep 2022 21:10:48 -0000
Date:   Thu, 8 Sep 2022 16:10:48 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jerry Ray <jerry.ray@microchip.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] ARM: dts: at91: Adding documentation for
 SAMA5D3-EDS
Message-ID: <20220908211048.GA3344136-robh@kernel.org>
References: <20220902192236.14862-1-jerry.ray@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220902192236.14862-1-jerry.ray@microchip.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 02:22:35PM -0500, Jerry Ray wrote:
> Adding the SAMA5D3-EDS board from Microchip into the atmel AT91 board
> description yaml file.
> 
> Signed-off-by: Jerry Ray <jerry.ray@microchip.com>
> ---
> v5->v6:
>  - No code change - patch prefix naming modified to match with others.

You did 'git log --oneline Documentation/devicetree/bindings/arm/' for 
inspiration?

'ARM: dts' would be an arm32 .dts file which this is not.

Rob
