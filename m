Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFADF5A87A9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 22:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbiHaUn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 16:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbiHaUnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 16:43:24 -0400
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C83EA14E;
        Wed, 31 Aug 2022 13:43:23 -0700 (PDT)
Received: by mail-oo1-f44.google.com with SMTP id p48-20020a4a95f3000000b0044b0f5a8d17so2716267ooi.0;
        Wed, 31 Aug 2022 13:43:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=6cREWEaH7JuMoFkOJaAV+wZb4Hzj/gjJoNoTpNexxm0=;
        b=YSa1QHunH5FCf8JvnlNkCF8tQuRp+uYqb9BHFQDzna+4SJ9LJG6YaH/m+7xX3zcl5D
         MDM5Lw2u2Z9GhmcpJ/lsvUU30qtN4FBXsatY+46BVThcCCX5wRSOIe9mztx1y63n1zo0
         P+Xm4FUQ74LSitEhPrzVooYHXzyd+xlkSueHiQzEmVbg9gWlKw7YKeMVX0Jv/19r4JQK
         j3lHpvtQwfCxzeeEWm9VB50/L7Ihk8rHvDBDp31Dx7To9S2v2+bMvjCc6zqnrQGkUQoa
         WLoAovl/+GQ9mub3arKlTZYilU9kpjHnsKuRrPI036pxNBBch1mKIRbyuk6nBz6W+OyL
         h6DQ==
X-Gm-Message-State: ACgBeo39L2ajIM7lK7elplT5pO52w4ztJ3X3z1jP1JbeXtOPnNg2DtPe
        r4DK1HsXdx0DaqBv52nEvc5Crz+bog==
X-Google-Smtp-Source: AA6agR7RWiy6oxyf1BgHjNtAORW02Qatgh3U1udrfxASlxdVKSsHTAFCE/Xh7X57BVJfibWJcaAlww==
X-Received: by 2002:a4a:e0d8:0:b0:44a:e39b:26d4 with SMTP id e24-20020a4ae0d8000000b0044ae39b26d4mr9591958oot.2.1661978602738;
        Wed, 31 Aug 2022 13:43:22 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k14-20020a056870d38e00b0011e4c574dfcsm10252181oag.40.2022.08.31.13.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 13:43:22 -0700 (PDT)
Received: (nullmailer pid 211276 invoked by uid 1000);
        Wed, 31 Aug 2022 20:43:21 -0000
Date:   Wed, 31 Aug 2022 15:43:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH] dt-bindings: power: Add missing
 (unevaluated|additional)Properties on child nodes
Message-ID: <20220831204321.GA211204-robh@kernel.org>
References: <20220823145649.3118479-15-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823145649.3118479-15-robh@kernel.org>
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

On Tue, 23 Aug 2022 09:56:46 -0500, Rob Herring wrote:
> In order to ensure only documented properties are present, node schemas
> must have unevaluatedProperties or additionalProperties set to false
> (typically).
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/power/domain-idle-state.yaml          | 10 ++++++++++
>  .../devicetree/bindings/power/fsl,imx-gpc.yaml     | 14 ++++++++++++++
>  .../devicetree/bindings/power/fsl,imx-gpcv2.yaml   | 14 ++++++++++++++
>  3 files changed, 38 insertions(+)
> 

Applied, thanks!
