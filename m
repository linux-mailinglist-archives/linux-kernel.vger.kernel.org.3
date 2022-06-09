Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE618545556
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 22:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235684AbiFIUKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 16:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiFIUKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 16:10:44 -0400
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E83D6572;
        Thu,  9 Jun 2022 13:10:43 -0700 (PDT)
Received: by mail-il1-f170.google.com with SMTP id r3so19553063ilt.8;
        Thu, 09 Jun 2022 13:10:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hu/KmUyRIWRHw+tVp/TRd7thi4SABOMvdE0DmVGk4P8=;
        b=48zpVDM6ZmbjJWyk+B8ACUALP4eHBKuHE1Xm5bkq0kLt49iFQW3+PsTvPSBOufyoIY
         AqREguKEYmxDrX2yptsMKglhBRX2i8Va6jiDnXKGJCGC3lYvGFWDiSF0M8YtrFIczgON
         SgQI3uLWWjxvyOqAlGxDXL922+oWgW4FrPG5MrXfYRXUM9IywU93O+S/0TYvAqwvhg6X
         Se9DSY5BZULjpY8BlWVZvNZU+LjgIaHjf2TQegvZprKmTwxBIVD1dsD7FqkjGksqdg70
         nC6A/KRlRzU1y0AApNTyl9NuKzMFam8j659sKv8h5BcOnBY4b0EXGfHpXrYQddG3uX67
         LEjg==
X-Gm-Message-State: AOAM533v9CVVYw72pdyYWzunFVAayjyJJW+I94l9VU4C3C0vtrWdSEgW
        mfwalMqLbUSgA9kC8lISr1wooHitaw==
X-Google-Smtp-Source: ABdhPJzbnMgq7DhjNPfGJdQUaIAuCLln7Meofq002rllS6dGJZ9peZBk2+yKLhaDUF4T8eLmBdNoZQ==
X-Received: by 2002:a92:c146:0:b0:2d7:6168:21a0 with SMTP id b6-20020a92c146000000b002d7616821a0mr3515114ilh.120.1654805442533;
        Thu, 09 Jun 2022 13:10:42 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id p3-20020a02c803000000b00331d411da60sm3784259jao.75.2022.06.09.13.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 13:10:42 -0700 (PDT)
Received: (nullmailer pid 22748 invoked by uid 1000);
        Thu, 09 Jun 2022 20:10:40 -0000
Date:   Thu, 9 Jun 2022 14:10:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>, linux-leds@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/3] dt-bindings: leds: skyworks,aat1290: convert to
 dtschema
Message-ID: <20220609201040.GA22636-robh@kernel.org>
References: <20220607085343.72414-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607085343.72414-1-krzysztof.kozlowski@linaro.org>
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

On Tue, 07 Jun 2022 10:53:41 +0200, Krzysztof Kozlowski wrote:
> Convert the Skyworks Solutions, Inc. AAT1290 Current Regulator bindings
> to DT Schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/leds/leds-aat1290.txt | 77 ---------------
>  .../bindings/leds/skyworks,aat1290.yaml       | 96 +++++++++++++++++++
>  2 files changed, 96 insertions(+), 77 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/leds/leds-aat1290.txt
>  create mode 100644 Documentation/devicetree/bindings/leds/skyworks,aat1290.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
