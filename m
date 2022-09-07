Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEA925B0E50
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 22:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbiIGUlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 16:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbiIGUkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 16:40:55 -0400
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2FE3BFAB2;
        Wed,  7 Sep 2022 13:40:51 -0700 (PDT)
Received: by mail-ot1-f46.google.com with SMTP id br15-20020a056830390f00b0061c9d73b8bdso11043906otb.6;
        Wed, 07 Sep 2022 13:40:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=x1B4jSIY/AQnnqw7XKJJPKGfC9EkoKcXHp71AXl8YYY=;
        b=YjokQUk76dLQvIwJHHQdMeUJ5TaN+Mk/dKrsgpHT3VqBfEyggk+PxZs9XLYETRMw8J
         bGR4ceIxwYznyQBJ1AaoJTBZu+XvNQOOcMwZuwYrddTshBzR6FXeQdnFrRtrpOA5lLq1
         HS56L0cAaN+kgF5aVvn4aC8lAMybrrRRPSSSBoSr6K3e6bjB6WCPkYHkpYnbtMRl0RNP
         TU2NWKMC9+z7eUSRT7+4ypuo9bPjHKDp5Q6F6yRhV6JF/XWihd3N2pTpWlzl2xhZTRZX
         Lucz4qJuw75Qqms4JZ+cK+52LDC2Z2S1MToHZJHvJFncxyIpf35QFaPwjS3fIm3r2rOG
         QGOw==
X-Gm-Message-State: ACgBeo3X0xhoA+Za/NfPRoMDALlM3UyJhutF96U/+jNXPAZseN0R3sQx
        XxAoljN8idppJncKyfmmfw==
X-Google-Smtp-Source: AA6agR63OkJ3F/uzwYlGi8A95/gNftwSE50ItUVMi2nuE2W+J16i0uqZ0trOVlUr7p/55EjQDXWc4A==
X-Received: by 2002:a05:6830:18d8:b0:638:969c:1eef with SMTP id v24-20020a05683018d800b00638969c1eefmr2257128ote.49.1662583250853;
        Wed, 07 Sep 2022 13:40:50 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b10-20020a05687051ca00b0011e73536301sm8677585oaj.52.2022.09.07.13.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 13:40:50 -0700 (PDT)
Received: (nullmailer pid 303564 invoked by uid 1000);
        Wed, 07 Sep 2022 20:40:49 -0000
Date:   Wed, 7 Sep 2022 15:40:49 -0500
From:   Rob Herring <robh@kernel.org>
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Tero Kristo <kristo@kernel.org>, linux-kernel@vger.kernel.org,
        Nishanth Menon <nm@ti.com>, Bryan Brattlof <bb@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 1/5] dt-bindings: arm: ti: Rearrange IOPAD macros
 alphabetically
Message-ID: <20220907204049.GA303529-robh@kernel.org>
References: <20220901141328.899100-1-vigneshr@ti.com>
 <20220901141328.899100-2-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901141328.899100-2-vigneshr@ti.com>
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

On Thu, 01 Sep 2022 19:43:24 +0530, Vignesh Raghavendra wrote:
> Rearrange SOC specific IOPAD macros alphabetically, so that its easier
> to read. No functional change intended.
> 
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
>  include/dt-bindings/pinctrl/k3.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
