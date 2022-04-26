Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314EB510686
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 20:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350821AbiDZSSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 14:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350804AbiDZSSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 14:18:16 -0400
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6803D8BF3E;
        Tue, 26 Apr 2022 11:15:03 -0700 (PDT)
Received: by mail-ot1-f42.google.com with SMTP id r14-20020a9d750e000000b00605446d683eso13598015otk.10;
        Tue, 26 Apr 2022 11:15:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Oib/ExV10ANnQvwwrlprqgTr48+7URKhjUPril72gdM=;
        b=I4ylhvOIn+z31jVzUtEdpVBPnl54CMC8QOpMo+o+5J1HcDmd8AxveZc9WxtKmYaY8V
         BMHXBSIaMDSkcpHbJ59XATBFjqhXhmjSM+rz31KR/IgiRbiBtlK1/ydBKnoCun7+Jx+/
         OBhPSFiAcDqL5uQqYSYJ1dzDC8Y4GqmWBh2pdkb7WTKh+naT0q6ofc2NTAVSPvDIri94
         m7njKiWUNLL3vSxz+fT7Ns7hFUGiO0+6ce84ooUwFEZLsaXTlWEt0jqXfHSKZZDOO055
         U69zDzwbP1ULcHq2TPXNGSHzxaGrzjEpwVd7HwN1B8UJQaVjyw3Nx040yH94Va2N6EXU
         fcYQ==
X-Gm-Message-State: AOAM532mTomAc+ULcPpzo/MgdhUEHdqP8OaiOH9jB3vI3alYTLGBPx4S
        yJugoLxSutjD8pID43CHQg==
X-Google-Smtp-Source: ABdhPJygMH9HvK7IP3j9u7OmyyH6K204kPiiXtsJ5q56r+EUYX7A8yfGg5V4YihTUBZW7KLxXuYhEQ==
X-Received: by 2002:a9d:2a9:0:b0:603:e74c:e4e7 with SMTP id 38-20020a9d02a9000000b00603e74ce4e7mr9031635otl.85.1650996903014;
        Tue, 26 Apr 2022 11:15:03 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v20-20020a056830141400b00604d7cb9bb1sm5332468otp.43.2022.04.26.11.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 11:15:02 -0700 (PDT)
Received: (nullmailer pid 2288840 invoked by uid 1000);
        Tue, 26 Apr 2022 18:15:01 -0000
Date:   Tue, 26 Apr 2022 13:15:01 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: arm: stm32: narrow DH STM32MP1 SoM
 boards
Message-ID: <Ymg2pVs+qijxOmRj@robh.at.kernel.org>
References: <20220425140436.332467-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425140436.332467-1-krzysztof.kozlowski@linaro.org>
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

On Mon, 25 Apr 2022 16:04:35 +0200, Krzysztof Kozlowski wrote:
> The bindings for DH STM32MP1 SoM boards allows invalid combinations,
> e.g. st,stm32mp153 SoC on a dh,stm32mp157c-dhcom-som SoM.
> 
> Split the enums to properly match valid setups.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/arm/stm32/stm32.yaml  | 37 +++++++++++--------
>  1 file changed, 22 insertions(+), 15 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
