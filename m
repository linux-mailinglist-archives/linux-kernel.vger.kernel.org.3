Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD98B53DE88
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 00:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348294AbiFEWFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 18:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348227AbiFEWFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 18:05:32 -0400
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0353B3DD;
        Sun,  5 Jun 2022 15:05:27 -0700 (PDT)
Received: by mail-qk1-f174.google.com with SMTP id x65so9785990qke.2;
        Sun, 05 Jun 2022 15:05:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Rg3RgKIBXamNR9v7mxieWFauvb14cauJ3M376uS4CVo=;
        b=ZmT/6OKhxCSWhGu1sCjxi+52ZLup2fs24jz4gbNHFX19VVO1aEBNEz8aOszOIfDLQZ
         41/8IhNgZMdmbNWGme+2ZE26nGyAMAvsWghsFx5CqFp3pFJzP/6qvl42DBxb9yvzQ8Zo
         Om8mlld0xN+C9j6FEzDeXge/cziEQDwqvO1rn+DvTYHMisbawkmPfUUveHcZ2L+yu6MO
         O6qSRaxVg39JyYqi3/7uFluFwQ5aFUhZVNcE02XflxAyBhziI3+Xw0WJL2Tye19yRQsN
         Kv2WIn/MfJnuW6flsRagbX4NOR1/voxFqplitgge5XPt7JzW0mRoiAOFI9bA6abvXBNx
         L0pg==
X-Gm-Message-State: AOAM5302xzhmiZpy2t3EG5WLBdpgSuRsuflN7G8NWYTccyHii5TY40Ev
        oMsykG9svcpfNg+ia6am4A==
X-Google-Smtp-Source: ABdhPJxw4Q7xRoj+FRRLau1BUn28VPlMUykk9chhacog0H3umTnuHtNBiI15cyz0mNtGuZOr7R7nUw==
X-Received: by 2002:a05:620a:c52:b0:6a6:6b8f:eac2 with SMTP id u18-20020a05620a0c5200b006a66b8feac2mr13950454qki.643.1654466726041;
        Sun, 05 Jun 2022 15:05:26 -0700 (PDT)
Received: from robh.at.kernel.org ([2607:fb90:1bd0:10c3:c77a:8738:16cb:8d08])
        by smtp.gmail.com with ESMTPSA id bl8-20020a05622a244800b00304e3c85b3dsm4320647qtb.93.2022.06.05.15.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 15:05:25 -0700 (PDT)
Received: (nullmailer pid 3580163 invoked by uid 1000);
        Sun, 05 Jun 2022 21:48:26 -0000
Date:   Sun, 5 Jun 2022 16:48:26 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>,
        David Heidelberg <david@ixit.cz>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: power: supply: bq24190: use regulator
 schema for child node
Message-ID: <20220605214826.GA3580104-robh@kernel.org>
References: <20220601071911.6435-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220601071911.6435-1-krzysztof.kozlowski@linaro.org>
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

On Wed, 01 Jun 2022 09:19:08 +0200, Krzysztof Kozlowski wrote:
> The 'usb-otg-vbus' child node is a regulator so reference the regulator
> schema for proper evaluation.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/power/supply/bq24190.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
