Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C940F532084
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 04:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbiEXCBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 22:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232871AbiEXCBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 22:01:07 -0400
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8FB10EF;
        Mon, 23 May 2022 19:01:04 -0700 (PDT)
Received: by mail-oi1-f177.google.com with SMTP id q10so19912147oia.9;
        Mon, 23 May 2022 19:01:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c4giYbPNIH7g7Y76hLicS+hGBBEopepvtOywRplLSr0=;
        b=Mf/pqRr3hU+yhANKaJxEevb6Ausze7Df6Bx96I22ucnvMnavSXdzM6FeJ3VEIcF3NI
         erd+LjU76oNlDuSX7PPteDPu3+uUi2gkwng+14GErI2yBuoXr+yhmyr9aVO9XolDBfJf
         LakXkC884KUYzCcw6fEPa/++eQp7Nfkguu0xztiEhe4ViuDcWJdaOLGfD4OnxIyX8A8K
         ZB3HTHPtKJbo/ZEXTf/nkUkUrOhD90WUJQQnitQWR4b3cVb5SAaRlEegc+Nq5qNwgevE
         lJOXcfQUsoLOBgNYlFek8//7x3Gk5iUjemhrFeUYw+IRiUTnCDQ81qD4HOYvDu/zIzvJ
         983A==
X-Gm-Message-State: AOAM532LDLyH2hRn4jwGT74OSbQGLDXvbxcQJIXBNq7gwmkvdn7iLJMQ
        BGNZUQOtv0knvt1oP+GmAMmKt9QH7A==
X-Google-Smtp-Source: ABdhPJwunOxW+pSPVgQOr8FWb3/m6E/fl3a1UFwGAMujh8dvWDKRCvjj2LXyhvaChE8fqt7OaAzy+Q==
X-Received: by 2002:a05:6808:f01:b0:32a:ef93:b955 with SMTP id m1-20020a0568080f0100b0032aef93b955mr1070571oiw.212.1653357663380;
        Mon, 23 May 2022 19:01:03 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k5-20020a056870870500b000e686d1386fsm4457738oam.9.2022.05.23.19.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 19:01:02 -0700 (PDT)
Received: (nullmailer pid 2597403 invoked by uid 1000);
        Tue, 24 May 2022 02:01:01 -0000
Date:   Mon, 23 May 2022 21:01:01 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/12] dt-bindings: arm: qcom: add missing MSM8998 board
 compatibles
Message-ID: <20220524020101.GA2597370-robh@kernel.org>
References: <20220521164550.91115-1-krzysztof.kozlowski@linaro.org>
 <20220521164550.91115-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220521164550.91115-2-krzysztof.kozlowski@linaro.org>
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

On Sat, 21 May 2022 18:45:40 +0200, Krzysztof Kozlowski wrote:
> Document board compatibles already present in Linux kernel.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
