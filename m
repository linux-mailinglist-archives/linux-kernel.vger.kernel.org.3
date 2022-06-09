Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D401A54558C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 22:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240858AbiFIUZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 16:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiFIUY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 16:24:57 -0400
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129F61C2D59;
        Thu,  9 Jun 2022 13:24:56 -0700 (PDT)
Received: by mail-il1-f175.google.com with SMTP id u2so18634480iln.2;
        Thu, 09 Jun 2022 13:24:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3gzLa7UFwCFZsq+e9Nmv+9/zeZm6wTMqpqjdJSLEQNo=;
        b=6TOxtsEAg5kedseg8b43fRvONFy14B6bltQmyJX6gp095i/0WUfErTV1uyeKnyY2kV
         p6b9jTntKO1rJLcFm7YBk2VPobMpHT12kci4l3dvWLaWbvjSSAA7vUwgyNMng+UCb4xy
         L4TOBif8VhWR3tZVnjH0aFBSa4v6jQXb5XFyHrvfnbeBCq0gnC5QakIQjttVpbVY/v0r
         xS+6wElJTXN5BXuC9wiK1tFBkwu50+YSuB07tl53jScxEaBXncLK2T3LZ01PMPcqOXXL
         UYekJeMac8tB4CSfHP5YJBxPMh4gyPXPrHBorNzTKj2y2l2qlLysESst+0iS8gtADyD7
         sCbg==
X-Gm-Message-State: AOAM531axKzCx5ANTj0R/rlTguWu992gTGlwxeFxL8TGwRP+uaNhbTZk
        v3SSTEcfbli1TFrdAWd7jA==
X-Google-Smtp-Source: ABdhPJxy6ETnyfQ4Pw5rJbmhIgNPv0+kJ+uoK8is5QFGNewfoVKGQEp27HCEqJIk0jXTpc2z0bjBUg==
X-Received: by 2002:a92:a041:0:b0:2d7:7935:effa with SMTP id b1-20020a92a041000000b002d77935effamr695227ilm.222.1654806295325;
        Thu, 09 Jun 2022 13:24:55 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id ay24-20020a056638411800b00331ce22e1e4sm4065691jab.2.2022.06.09.13.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 13:24:55 -0700 (PDT)
Received: (nullmailer pid 43066 invoked by uid 1000);
        Thu, 09 Jun 2022 20:24:52 -0000
Date:   Thu, 9 Jun 2022 14:24:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     linux-gpio@vger.kernel.org, quic_gurus@quicinc.com,
        devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org,
        linux-iio@vger.kernel.org, lee.jones@linaro.org,
        linux-kernel@vger.kernel.org, sre@kernel.org, broonie@kernel.org,
        rafael@kernel.org, lgirdwood@gmail.com, linus.walleij@linaro.org,
        jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        linux-pm@vger.kernel.org, brgl@bgdev.pl
Subject: Re: [PATCH v2 07/17] dt-bindings: power: axp20x-battery: Add AXP192
 compatible
Message-ID: <20220609202452.GA42970-robh@kernel.org>
References: <20220607155324.118102-1-aidanmacdonald.0x0@gmail.com>
 <20220607155324.118102-8-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607155324.118102-8-aidanmacdonald.0x0@gmail.com>
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

On Tue, 07 Jun 2022 16:53:14 +0100, Aidan MacDonald wrote:
> The AXP192's battery charger is similar to the others supported by
> the axp20x_battery driver.
> 
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
>  .../power/supply/x-powers,axp20x-battery-power-supply.yaml       | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
