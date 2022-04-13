Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F5B4FFD97
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 20:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237611AbiDMSP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 14:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233601AbiDMSPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 14:15:24 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 059DA36E0C;
        Wed, 13 Apr 2022 11:13:03 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-d6ca46da48so2806677fac.12;
        Wed, 13 Apr 2022 11:13:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EaNvx9WI08WE4w/5fhJh/+LgqxdrGCkOVNyF+cCJYJY=;
        b=wMpzL6c2MoUmxONcvmcM8ifvFlRLjquqQjMmZ53IS/23zPYM0g+4fJAqUaBgDH2e9F
         hDkGYiSIGPrDYgozCZXNVr8XEeegr0bA0eDMzrHMSbNNQa4D1hZUdzpP162gIUW8i2vd
         +K3zmtiAwdrNtCmabGj+h7+70B1t2EKHX4zOQFFm5bJpKKv0nr9VDoF+ZOef5TecljSa
         hPpu1XBsZPeq1VQcN3tbWmp7ISHAGO6q4JZoWHuT7KFjfHgu5EqczFBuEJlCiiuqlJWd
         6ffo0y86a53Wm+wjbflJv0pFz5ji2671lNPUL0hYJdqcGrhENxiG/l7FiArK6GwAVlgK
         w1vA==
X-Gm-Message-State: AOAM532yeT9M1P4dTJvy0wTCVdOF8zsFZhcqvDL/2AlfpFK3vH7Qzqhn
        Sm5qk7eS1941S3Lsjvd0XQKsApgklg==
X-Google-Smtp-Source: ABdhPJzYPoKmHHmKrndbzmIMKA5MgGd/hjXVyPdpD0ukSYO7eqETW/4pUX012z3LusznCxAKWW08jQ==
X-Received: by 2002:a05:6870:5b97:b0:e2:5d6:8bbb with SMTP id em23-20020a0568705b9700b000e205d68bbbmr2877oab.82.1649873582226;
        Wed, 13 Apr 2022 11:13:02 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j16-20020a544810000000b002fa6ba4317esm1077992oij.44.2022.04.13.11.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 11:13:01 -0700 (PDT)
Received: (nullmailer pid 3578070 invoked by uid 1000);
        Wed, 13 Apr 2022 18:13:00 -0000
Date:   Wed, 13 Apr 2022 13:13:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     Camel Guo <camel.guo@axis.com>
Cc:     linux-hwmon@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-kernel@vger.kernel.org, kernel@axis.com,
        Jean Delvare <jdelvare@suse.com>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: hwmon: Add TMP401, TMP411 and TMP43x
Message-ID: <YlcSrOPf45ht1njU@robh.at.kernel.org>
References: <20220413114014.2204623-1-camel.guo@axis.com>
 <20220413114014.2204623-2-camel.guo@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413114014.2204623-2-camel.guo@axis.com>
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

On Wed, 13 Apr 2022 13:40:12 +0200, Camel Guo wrote:
> Document the TMP401, TMP411 and TMP43x device devicetree bindings
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Camel Guo <camel.guo@axis.com>
> ---
> 
> Notes:
>     v3:
>     - Remove unneeded address-cells and size-cells;
>     - Change range of ti,n-factor to [-128, 127];
>     - Remove unneeded 'items' of ti,beta-compensation;
>     - Got Reviewed-by from Krzysztof.
> 
>     v2:
>     - Fix format and describe hardware properties instead of programming
>       models
> 
>  .../devicetree/bindings/hwmon/ti,tmp401.yaml  | 105 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 106 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/ti,tmp401.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
