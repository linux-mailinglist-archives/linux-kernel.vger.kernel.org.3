Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E4955C2A4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241186AbiF0VgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 17:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236180AbiF0Vf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 17:35:57 -0400
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D07B10FF;
        Mon, 27 Jun 2022 14:35:56 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id l24so10974560ion.13;
        Mon, 27 Jun 2022 14:35:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J4+Oe1+Ks7fs9x2qE+51qC+TASVHbNeF5ScNp5f4ruk=;
        b=EibB9LequOFxvmyHizVXszRFJ2tQx3k42XNQIO1JfvMIrsbOJU4wFMM9A5J8yQIjx4
         9UYJ1iPcsdrvQ7KUSYToCp9JEDH8Y9ydvgTHDpRgri+RcRJaeBdd+p5OeoF66yluLFdX
         8bD6xhOb8+4qunEF/evlW7TdBQTD37XolQ4HKm1WSlGlfJdqAQ3pkptwDZCgM1NkHvXk
         58aWw8YCTf4csKgtusyOqRPouKHNdM+DOWDoXvQ4EatIabBHIJ8F/dOWdzCoiXU3ehes
         Fkj76GUpsV9os0tjmmDJvK0w7l9tv3t7bLohofg+TbICW8Hm4qzU3bXsBPMdLQoGP6gP
         LMNg==
X-Gm-Message-State: AJIora+xkzueQb5HJ0p6N803IDyNd67L1MRn4DjhWoOCjWXPm59/NrHH
        pKzqXa8qzOpjviZnofmGal0NCs+cYQ==
X-Google-Smtp-Source: AGRyM1uNj7R49wFEo8bf5b1jSrlWjqwGl6lXAK8Bb4OHTyG3386pOh86YFZokhZsHfXb3M5MIOxHQA==
X-Received: by 2002:a05:6638:16ce:b0:332:44e:af98 with SMTP id g14-20020a05663816ce00b00332044eaf98mr8778280jat.112.1656365755798;
        Mon, 27 Jun 2022 14:35:55 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id b13-20020a026f4d000000b00335b403c3b4sm5263466jae.48.2022.06.27.14.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 14:35:55 -0700 (PDT)
Received: (nullmailer pid 3004663 invoked by uid 1000);
        Mon, 27 Jun 2022 21:35:53 -0000
Date:   Mon, 27 Jun 2022 15:35:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Guenter Roeck <groeck@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        chrome-platform@lists.linux.dev,
        Benson Leung <bleung@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Craig Hesling <hesling@chromium.org>,
        devicetree@vger.kernel.org, patches@lists.linux.dev,
        Tom Hughes <tomhughes@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v6 1/2] dt-bindings: cros-ec: Reorganize property
 availability
Message-ID: <20220627213553.GA3004606-robh@kernel.org>
References: <20220614195144.2794796-1-swboyd@chromium.org>
 <20220614195144.2794796-2-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614195144.2794796-2-swboyd@chromium.org>
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

On Tue, 14 Jun 2022 12:51:43 -0700, Stephen Boyd wrote:
> Various properties in the cros-ec binding only apply to different
> compatible strings. For example, the interrupts and reg property are
> required for all cros-ec devices except for the rpmsg version. Add some
> conditions to update the availability of properties so that they can't
> be used with compatibles that don't support them.
> 
> Cc: Rob Herring <robh@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: <devicetree@vger.kernel.org>
> Cc: <chrome-platform@lists.linux.dev>
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Craig Hesling <hesling@chromium.org>
> Cc: Tom Hughes <tomhughes@chromium.org>
> Cc: Alexandru M Stan <amstan@chromium.org>
> Cc: Tzung-Bi Shih <tzungbi@kernel.org>
> Cc: Matthias Kaehlcke <mka@chromium.org>
> Cc: Benson Leung <bleung@chromium.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  .../bindings/chrome/google,cros-ec-typec.yaml |  1 +
>  .../bindings/extcon/extcon-usbc-cros-ec.yaml  |  1 +
>  .../i2c/google,cros-ec-i2c-tunnel.yaml        |  1 +
>  .../bindings/mfd/google,cros-ec.yaml          | 29 +++++++++++++------
>  .../bindings/pwm/google,cros-ec-pwm.yaml      |  1 +
>  .../regulator/google,cros-ec-regulator.yaml   |  1 +
>  .../bindings/sound/google,cros-ec-codec.yaml  |  1 +
>  7 files changed, 26 insertions(+), 9 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
