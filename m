Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B96253B9F4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 15:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232632AbiFBNiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 09:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235467AbiFBNiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 09:38:04 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B02212AB0F;
        Thu,  2 Jun 2022 06:38:03 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id i66so6514525oia.11;
        Thu, 02 Jun 2022 06:38:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Dr24Ejh5fpMmf0OXFd+psIEWSpHZUsdswYJ3//zAfIo=;
        b=3UGi1c7+leEQkUdI5U4R/kOBeRmtP5ONZlcxzRZeRg6sLeja6492GXyE8D2gI4NyXf
         sh+9XEkyOltEfCVBCcRziQoifnbVeoufqcpkxIhbyf9gYk8r2gF0dOnlbM2gRcwMevNR
         2LJMbbSnHhry+B+ctjOuYnnacQdQNmdAKwQTOYuP3OARnjCRGe179uibYWp7fzmQjoK7
         PT6fZPFsDSMljL2WA1in2Y1xw/CWYPS6BzCUE5dlIDkOoyBQfUU8MB4YMK+7lNRHvgF/
         rXy6BRZlcpSDY+pFXkqFCl5yaM+JBiYV+DRQv+fWFZMRRSSRCJWzcRvaZIOdJ2lMXmP1
         cGeQ==
X-Gm-Message-State: AOAM531Sc/9dLpolpUg31eJyqMVU5Hh12qdg5zY4PD8XGXoNVf40HAUT
        3G1zwY6tJuF6S8eJcbvwHg==
X-Google-Smtp-Source: ABdhPJzJ1iMtezenD3KFf8yAadDOCOru3p9siXWTblKEYzkCHiU5Af93l/ltWLDlihAGNcNd23R/3A==
X-Received: by 2002:a05:6808:1b2a:b0:32b:ce3d:7429 with SMTP id bx42-20020a0568081b2a00b0032bce3d7429mr2575849oib.221.1654177082778;
        Thu, 02 Jun 2022 06:38:02 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id mv26-20020a0568706a9a00b000f5701f240csm1906520oab.19.2022.06.02.06.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 06:38:02 -0700 (PDT)
Received: (nullmailer pid 2165669 invoked by uid 1000);
        Thu, 02 Jun 2022 13:38:01 -0000
Date:   Thu, 2 Jun 2022 08:38:01 -0500
From:   Rob Herring <robh@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, swboyd@chromium.org,
        devicetree@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        mka@chromium.org
Subject: Re: [PATCH v2 1/2] dt-bindings: HID: i2c-hid: elan: Introduce
 bindings for Elan eKTH6915
Message-ID: <20220602133801.GA2165636-robh@kernel.org>
References: <20220523142257.v2.1.Iedc61f9ef220a89af6a031200a7850a27a440134@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523142257.v2.1.Iedc61f9ef220a89af6a031200a7850a27a440134@changeid>
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

On Mon, 23 May 2022 14:23:23 -0700, Douglas Anderson wrote:
> Like many i2c-hid touchscreen controllers, the Elan eKTH6915
> controller has a reset gpio. For the Goodix GT7375P touchscreen the
> decision was to add a new binding rather than trying to add a new GPIO
> to the existing i2c-hid binding. We'll follow the lead and do it here,
> too.
> 
> SIDE NOTE: the Elan eKTH6915 is a touchscreen _controller_ that's
> included as a part on some touchscreens. The reset line isn't truly
> necessary for the functioning of the touchscreen, so it's possible
> that some designs won't have it hooked up and will just guarantee the
> power sequencing requirements with RLC circuits. Thus, we'll mark the
> reset gpio as optional.
> 
> Note that if the reset GPIO isn't used there's actually no true need
> to use the "elan,ekth6915" compatible instead of the "hid-over-i2c" on
> Linux. However:
> - Officially using just "hid-over-i2c" for this device violates the
>   existing "hid-over-i2c" bindings. The bindings say that you're not
>   supposed to use "post-power-on-delay-ms" without specifying a more
>   specific compatible. Currently the Linux driver doesn't enforce
>   this, but it violates the bindings to just use
>   "hid-over-i2c". ...and if you're going to add a more specific
>   compatible anyway, might as well do it right.
> - Using this compatible means we don't need to specify
>   "hid-descr-addr" since it's inferred from the compatible.
> - Using this compatible means that the regulator names match the names
>   on the Elan datasheet (vcc33 / vccio) vs the generic hid-over-i2c
>   (vdd / vddl).
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
> (no changes since v1)
> 
>  .../bindings/input/elan,ekth6915.yaml         | 65 +++++++++++++++++++
>  1 file changed, 65 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/elan,ekth6915.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
