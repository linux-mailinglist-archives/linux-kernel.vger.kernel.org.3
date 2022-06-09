Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A6254509B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 17:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344428AbiFIPVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 11:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344403AbiFIPVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 11:21:19 -0400
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E305F4A3D6;
        Thu,  9 Jun 2022 08:21:18 -0700 (PDT)
Received: by mail-il1-f172.google.com with SMTP id u2so18055667iln.2;
        Thu, 09 Jun 2022 08:21:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aA/410L+9p0xbmxpZ2Mn80L61ojuTJuT5kn/KAJbX/4=;
        b=Ttz/Fk1bveFFH689hqjJKzWS9KQ5KhTf2yeTwqyAGY5h+IvB2MQjGz5lJGwWpYfmBH
         2zplGkITJqNgSrRlFuQebaG9bfVYmPzjEHyurO3oGPTIEFP4ov1HEA5wgkjzxD9n4S4s
         lnex3oyqTDpIHyH2dJ8Y+hexVtZBt8XFZSv1W49437hp2hJq578EAE2aHKqMH7YWKWPO
         TaAwor9oCWKxAjMImGYrPzpkKg5RLA6yWtkoT0aoexB7ojicV7O2NRezADcdXJCdOlH/
         gFCXRiSP5gi1JCLZ2b1svcT/h5eOGrMZNeFx79r/gbDLbsImkg4ABuZP9a52phVhoqfx
         IxNQ==
X-Gm-Message-State: AOAM532jBydMJ6uiqUcubJUKQR6LbLAlKa0x8lB4NjnEGFBnkpLBKjjd
        JT7wzTkypPaXSZinres20dR/y2Y0Uw==
X-Google-Smtp-Source: ABdhPJwS4Z8Uz7/L6+/4oTICgHYgwtFPW/adzsCrE/yk1RazKDvfUEOiTFSooJZLeC437CADIxrnJA==
X-Received: by 2002:a05:6e02:1bae:b0:2d3:a66b:7432 with SMTP id n14-20020a056e021bae00b002d3a66b7432mr21846994ili.185.1654788078227;
        Thu, 09 Jun 2022 08:21:18 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id g23-20020a02bb97000000b0032e1e0ac289sm9687144jan.8.2022.06.09.08.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 08:21:17 -0700 (PDT)
Received: (nullmailer pid 3817707 invoked by uid 1000);
        Thu, 09 Jun 2022 15:21:16 -0000
Date:   Thu, 9 Jun 2022 09:21:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Olof Johansson <olof@lixom.net>, arm@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-input@vger.kernel.org, soc@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 03/48] dt-bindings: input: gpio-keys: accept also
 interrupt-extended
Message-ID: <20220609152115.GA3815878-robh@kernel.org>
References: <20220609113721.379932-1-krzysztof.kozlowski@linaro.org>
 <20220609113911.380368-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220609113911.380368-2-krzysztof.kozlowski@linaro.org>
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

On Thu, 09 Jun 2022 13:39:05 +0200, Krzysztof Kozlowski wrote:
> Each key device node might have interrupts-extended instead of
> interrupts property:
> 
>   fsl-ls1028a-kontron-sl28-var1.dtb: buttons0: power-button: 'anyOf' conditional failed, one must be fixed:
>     'interrupts' is a required property
>     'gpios' is a required property
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/input/gpio-keys.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

The tooling is supposed to take care of this, but it's complicated 
enough that we don't find it. So easier to handle in the schema.

Reviewed-by: Rob Herring <robh@kernel.org>
