Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5110532086
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 04:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbiEXCB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 22:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232925AbiEXCBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 22:01:22 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788C513FBB;
        Mon, 23 May 2022 19:01:18 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id v66so19916694oib.3;
        Mon, 23 May 2022 19:01:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5qo6oIZWbq4qWvahiEhRnoALTtCaoaxc3DmWDmrh6ks=;
        b=PovWt+SHqzil9fbiL2EyDVuo8nULph9zprKA2JRVLdRf3RMtZ3t56oO1Zmoxd3Uwjk
         gIsQhojIFcVN3IRpuIvphLWNvAeVYWASrU8ku1WByY5RNfhhxVaOE+VYj80Z20l/EYFy
         aK1V0AM2Gp9RYBhG0hbSAWSF+yZ1q+fMwsHydKZF9i6LUTRc2eYqJ34QugswgyDl50b6
         Iv+hzYuag+g5OMUjkegU+y8X8tdyxFEZ5Su+HRwHxy48zlcfgJkiVl3kT1R+ZVjlB7gG
         NK9Qg7Yd2/2kiMwt7OdeRwbmrHn6fBLtsXC/UEVd/KlS7jxk4oyRx10ly0bjJ53s327I
         EU+A==
X-Gm-Message-State: AOAM533/P68PCj73GR/RweGtYNFRopsdTGzFYuo/FwRcNCYJJmitoGv7
        fYGQyQi/gVXCFxxzJkQGKg==
X-Google-Smtp-Source: ABdhPJx34W9B5vH7ruc+ne9Isp1RvUiKS0lIcO5Ge5TcrX7D1pot8FDCw3Bk9obY4NDoLvFQ4e5EBQ==
X-Received: by 2002:aca:1014:0:b0:32b:2825:ad28 with SMTP id 20-20020aca1014000000b0032b2825ad28mr1099628oiq.238.1653357677472;
        Mon, 23 May 2022 19:01:17 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k5-20020a056870870500b000e686d1386fsm4457946oam.9.2022.05.23.19.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 19:01:16 -0700 (PDT)
Received: (nullmailer pid 2597857 invoked by uid 1000);
        Tue, 24 May 2022 02:01:16 -0000
Date:   Mon, 23 May 2022 21:01:16 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 03/12] dt-bindings: arm: qcom: add missing MSM8992 board
 compatibles
Message-ID: <20220524020116.GA2597807-robh@kernel.org>
References: <20220521164550.91115-1-krzysztof.kozlowski@linaro.org>
 <20220521164550.91115-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220521164550.91115-3-krzysztof.kozlowski@linaro.org>
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

On Sat, 21 May 2022 18:45:41 +0200, Krzysztof Kozlowski wrote:
> Document board compatibles already present in Linux kernel.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
