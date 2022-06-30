Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2697656269B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 01:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbiF3XPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 19:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232370AbiF3XPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 19:15:40 -0400
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F79F25F3;
        Thu, 30 Jun 2022 16:15:38 -0700 (PDT)
Received: by mail-il1-f170.google.com with SMTP id p13so403445ilq.0;
        Thu, 30 Jun 2022 16:15:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KbKoF7QVYBmq2AlkSxV5k4lgb1s7hwhdeCtoubmk3Gs=;
        b=jBhunu26yKkgLjouCcuSSHE6ypKqfQ6QPs78OUywdGNsC6ja+z+lLWiqHuJsiV1jqh
         gORxuy6w3yy6FQSmaiSo1gmuTgeF6ntj0jP80xLJmCpEOf5Xc0LhRVe2vJuHgyI4FM8u
         QzdI6A2ZYN1LXKthm0Cj1OusTNehYUDtpVMXEMR5JnbYVLaFhM0XhVMBogizc6AnMIKo
         P4tfJsMMOsTJ0+kWJneBGHe43XoWUC9U5Rf2Fdx6NJVCTx1cFhuTxlzZZ3UhFT5cV8HD
         yEhAq8j3kiK8ldJWDoBPh+uCd3vAm0rS8SV+E62iGM6J2b+rpGQ+px8h/b4pF02Z/7JY
         1WAQ==
X-Gm-Message-State: AJIora/g2ynwNgJI2DI/jg1s4+xwm+i4ezD1YLxx79pFccsKI1DACkLe
        slitFWuavlspaTodb1UCCg==
X-Google-Smtp-Source: AGRyM1vZy3Jmsw2q9GC4kAnlyLXpaf0K8vwy4daLOXGv4iZ6PHja3Um5ewE62KIMBmU6l+z65fCQBw==
X-Received: by 2002:a05:6e02:19ca:b0:2da:a2d8:38c0 with SMTP id r10-20020a056e0219ca00b002daa2d838c0mr6867324ill.148.1656630937867;
        Thu, 30 Jun 2022 16:15:37 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id e24-20020a022118000000b00331d764e5b5sm9163571jaa.97.2022.06.30.16.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 16:15:37 -0700 (PDT)
Received: (nullmailer pid 3512196 invoked by uid 1000);
        Thu, 30 Jun 2022 23:15:35 -0000
Date:   Thu, 30 Jun 2022 17:15:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        Jaehoon Chung <jh80.chung@samsung.com>,
        linux-mmc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 5/5] dt-bindings: mmc: samsung,s3c6410-sdhci: convert to
 dtschema
Message-ID: <20220630231535.GA3512163-robh@kernel.org>
References: <20220626120342.38851-1-krzysztof.kozlowski@linaro.org>
 <20220626120342.38851-6-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220626120342.38851-6-krzysztof.kozlowski@linaro.org>
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

On Sun, 26 Jun 2022 14:03:42 +0200, Krzysztof Kozlowski wrote:
> Convert the Samsung SoC SDHCI Controller bindings to DT schema.
> 
> The original bindings were quite old and incomplete, so add during
> conversion typical (already used) properties like reg, clocks,
> interrupts.
> 
> The bindings were not precising the clocks, although the upstream DTS
> and Linux driver were expecting bus clocks in certain patterns in any
> order.  Document the status quo even though it is not a proper approach
> for bindings.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/mmc/samsung,s3c6410-sdhci.yaml   | 81 +++++++++++++++++++
>  .../devicetree/bindings/mmc/samsung-sdhci.txt | 32 --------
>  2 files changed, 81 insertions(+), 32 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/samsung,s3c6410-sdhci.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mmc/samsung-sdhci.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
