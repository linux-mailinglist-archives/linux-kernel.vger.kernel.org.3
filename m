Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C53E53209D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 04:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233057AbiEXCEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 22:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233023AbiEXCEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 22:04:36 -0400
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420309969A;
        Mon, 23 May 2022 19:04:35 -0700 (PDT)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-e656032735so20738333fac.0;
        Mon, 23 May 2022 19:04:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aHBVH9Z4v4NoMthP073OuScPWyYnaN4dj20XRgp0m30=;
        b=w5fV5kpwirmQsHVLAwKJ3JUhnr01b1xOd6pBpAJdmgkd691rR6VRMBCWBGr2qPOUvW
         qqz7qBn3WW2vqfguf6Xx8XHIDEeJyRa0G3rfzFnNb5pylicSZ0czosryhu0dhbVz4BjB
         wn65MkqMnnnKPS9WDmV5lYX6DsR/cX4iId8aLnXXqza12ISk7XSq02GFPYRv/hVM0jGa
         IBS7BIeCQlhVyN3y8f1VN0lsbywX6GW0zRwHM2w1hA8QG8h//EXPNTYrRIAPw+5kIaHo
         pGCc5QxvrM+klhiQKrrT4D825qQd08QmxBADMD7WZ+sQlkscAJkljAT7ekdIcBilsH02
         ZfwA==
X-Gm-Message-State: AOAM5326amDiecxV2pQCK977I7eGzIhnMwDaXYrysMFEFGNnO//ndfKV
        dJqhykvrbZc/ctFQo/f+ZNTRCKuMFA==
X-Google-Smtp-Source: ABdhPJwPcIpntDGIIzKu1/uBNXSyHRFZ/w04XIH9gY0cP6Nt5dV7v91RLlQovS8A19P1KTaNBYDewA==
X-Received: by 2002:a05:6870:14c5:b0:e9:3ce0:47e0 with SMTP id l5-20020a05687014c500b000e93ce047e0mr1195566oab.274.1653357874470;
        Mon, 23 May 2022 19:04:34 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r4-20020a05687002c400b000ee2bb503d0sm4462208oaf.50.2022.05.23.19.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 19:04:33 -0700 (PDT)
Received: (nullmailer pid 2603694 invoked by uid 1000);
        Tue, 24 May 2022 02:04:32 -0000
Date:   Mon, 23 May 2022 21:04:32 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 09/12] dt-bindings: arm: qcom: add missing SM6350 board
 compatibles
Message-ID: <20220524020432.GA2603667-robh@kernel.org>
References: <20220521164550.91115-1-krzysztof.kozlowski@linaro.org>
 <20220521164550.91115-9-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220521164550.91115-9-krzysztof.kozlowski@linaro.org>
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

On Sat, 21 May 2022 18:45:47 +0200, Krzysztof Kozlowski wrote:
> Document board compatibles already present in Linux kernel.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
