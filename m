Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E0250E586
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 18:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243363AbiDYQZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 12:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243350AbiDYQZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 12:25:49 -0400
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE02F74DD4;
        Mon, 25 Apr 2022 09:22:44 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-e656032735so15329653fac.0;
        Mon, 25 Apr 2022 09:22:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NJJ4MlQDWGdcucY/n+jk42HsIAR7AmzGGwh/ZWVfw90=;
        b=H/CIOYgzAe/DdnaRgjdzfUDCOAHLHHkdNkBsdxTl0jy8+ITa/I+BEeXlRZsUn6wP/T
         9YXuxBaj/OiKReVdnOvaRCRPOuc6ij5poue4KWZG0xn1PwAsESEj84AYHzDBpSdUaagR
         WEBMxG7TsvMGT6u/VF+7+R2eCpcpIzL9foQCTwKLyRjIDEMPdwYAqQQkEy4jYGnNGg7Y
         gx5+PdfX4U1sU/QLsF77KLpX4176wx4OvYSfe+JIOU+JR436mBe2n2b2MI6HjaCsbjEa
         i6VUvPdobXZdnT6YpVAgs3aDwROGqnUtVmlMxeleZlmxkKUUXgcLqq1/mFcj8CEgwEqJ
         qTvA==
X-Gm-Message-State: AOAM533cmBb5l6+mLtHPpuse4ovOLzvh+QVUTFFk6erqPSNnzHV5katX
        P0Cu1v+/xzbC8b9gtBhyJA==
X-Google-Smtp-Source: ABdhPJz2Q8h6HJWppCeHvd5QUxPsDsw4tdPTaqARl3xywCV2yPWTYjUrsfGofEGxgbwQJXmVyZ8RPg==
X-Received: by 2002:a05:6870:538e:b0:e6:7957:31ab with SMTP id h14-20020a056870538e00b000e6795731abmr8435293oan.89.1650903764148;
        Mon, 25 Apr 2022 09:22:44 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n62-20020acaef41000000b002ef646e6690sm3922328oih.53.2022.04.25.09.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 09:22:43 -0700 (PDT)
Received: (nullmailer pid 4000023 invoked by uid 1000);
        Mon, 25 Apr 2022 16:22:42 -0000
Date:   Mon, 25 Apr 2022 11:22:42 -0500
From:   Rob Herring <robh@kernel.org>
To:     Peter Rosin <peda@axentia.se>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-hwmon@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: Add Atmel AT30TS74
Message-ID: <YmbK0vQBGjiJIVZC@robh.at.kernel.org>
References: <abe35ea9-1929-941a-6391-2ce1bc047161@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abe35ea9-1929-941a-6391-2ce1bc047161@axentia.se>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Apr 2022 07:59:12 +0200, Peter Rosin wrote:
> Document the Atmel (now Microchip) AT30TS74 which is an LM75 based
> temperature sensor.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>   Documentation/devicetree/bindings/hwmon/lm75.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
