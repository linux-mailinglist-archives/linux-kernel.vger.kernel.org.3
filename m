Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B725B0E56
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 22:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiIGUlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 16:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbiIGUl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 16:41:29 -0400
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8330AC2284;
        Wed,  7 Sep 2022 13:41:26 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-127dca21a7dso11708578fac.12;
        Wed, 07 Sep 2022 13:41:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=CEdjOwMmeA08vXzpoa6WynZhk52OwalyiCa+4vlnpn8=;
        b=03Lr6y3NgSDhxvZVNYffJheLddDtemt3G3dbvs6voCnXyrrbbLziMMQENbsVPRcSY4
         NcClwJWaYkDfHM3t7iBM3LO1J2jRkzMuxNCUYLagMD8PrHRa5wUo2EIJTKSkpWl+LyRo
         IIhsxWK2ednb/WyumZ0mJQAAgcE+/D+mAruWdhBy+tF4ytS5dqY0848ondS/cwHKB+HY
         O6fgenhiSOR3dbuxgLAELDJ4grHdJTngTvuZlvylrZMEGuv0PIzm02077xXz7e2vYrRi
         OwLIlT79WzWOvHqZ+ti1n3V9g4Sch45cNXUKxB7VXH6UFnbAMQnHpX3xUy+vU0CgvkmX
         45fw==
X-Gm-Message-State: ACgBeo3I65ssEzB3uZsj612bWxc4PwlmIxfpuCtmqnpvR5znmdhLUs8O
        Ta80YJUggEk1v+nKljIafA==
X-Google-Smtp-Source: AA6agR4hg/qke5ywPjxL40jP4Lg1PyGJ0LaUfLNHDKid6j59uZVTmHBu1wtjQjtYCYrx92d/pVE+kw==
X-Received: by 2002:a54:4790:0:b0:343:46c5:9b8e with SMTP id o16-20020a544790000000b0034346c59b8emr102575oic.251.1662583285633;
        Wed, 07 Sep 2022 13:41:25 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id d3-20020a4ab203000000b004359da266b4sm5372593ooo.14.2022.09.07.13.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 13:41:25 -0700 (PDT)
Received: (nullmailer pid 304603 invoked by uid 1000);
        Wed, 07 Sep 2022 20:41:24 -0000
Date:   Wed, 7 Sep 2022 15:41:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Tero Kristo <kristo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bryan Brattlof <bb@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 2/5] dt-bindings: arm: ti: Add bindings for AM62A7 SoC
Message-ID: <20220907204124.GA304568-robh@kernel.org>
References: <20220901141328.899100-1-vigneshr@ti.com>
 <20220901141328.899100-3-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901141328.899100-3-vigneshr@ti.com>
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

On Thu, 01 Sep 2022 19:43:25 +0530, Vignesh Raghavendra wrote:
> This adds bindings for TI's AM62A7 family of devices.
> 
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
>  Documentation/devicetree/bindings/arm/ti/k3.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
