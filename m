Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B96F58293C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 17:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbiG0PEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 11:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234418AbiG0PEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 11:04:10 -0400
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B94E2610B;
        Wed, 27 Jul 2022 08:04:07 -0700 (PDT)
Received: by mail-il1-f175.google.com with SMTP id d4so8954236ilc.8;
        Wed, 27 Jul 2022 08:04:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KlPwwX+x3rg9rXQElmnLKECpClBv23qWzZgIbEFswvo=;
        b=Ob/XiIUgsHq3TXwat775OZN+Va4tHF+p7YfgiYhvYnSfEOnwvmYI7/WdVJeBFKmGJC
         SoB8YIhR6D8yiQYgibWLHLAQcbIBbucG1/feUw8v9r/SlDC0Q5wwu8XmXhLhwLwm1vAk
         jbEdQmN0Ky0tPl2B27cQtOBgFA3wpD/VaXB6TbBxXHAf52Rg/tbDkEGx6GS42WXEeA1Z
         V5pvxVWDx1ONSuHJsJ8opzB3zMIV69AahASC/s/GeZiOLr6VYnbnIxebkUNhwq481p8Q
         ppXigNy/lJlcx1fwcKevNG7CviKEO/06cLOAjixzUQoUG7vSAZE7iFm6+Kgp28+IvPJu
         DPeA==
X-Gm-Message-State: AJIora+ey1orc5kaGL+OqfqaYRzzsRMRmpv+NcmET2yOmPbHg65ekJ52
        Tb9/WY95pQ/YQAv8wkeuJzuU0PPZyQ==
X-Google-Smtp-Source: AGRyM1s7YiS0OYAXjRipdCQQji7SDz0C0IgcATGUQ75SHLDRlX4d+JWly1zn4v3rbGpt6KCvaEqF8w==
X-Received: by 2002:a05:6e02:152c:b0:2dc:9b02:b590 with SMTP id i12-20020a056e02152c00b002dc9b02b590mr8711790ilu.320.1658934246586;
        Wed, 27 Jul 2022 08:04:06 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id n11-20020a056e0208eb00b002dcd9ce8316sm6882875ilt.45.2022.07.27.08.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 08:04:06 -0700 (PDT)
Received: (nullmailer pid 2663842 invoked by uid 1000);
        Wed, 27 Jul 2022 15:04:04 -0000
Date:   Wed, 27 Jul 2022 09:04:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-mmc@vger.kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, ulf.hansson@linaro.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        devicetree@vger.kernel.org, agross@kernel.org
Subject: Re: [PATCH v2] dt-bindings: mmc: Set maximum documented operating
 frequency as 384MHz
Message-ID: <20220727150404.GA2663786-robh@kernel.org>
References: <20220726084520.2895454-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726084520.2895454-1-bhupesh.sharma@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jul 2022 14:15:20 +0530, Bhupesh Sharma wrote:
> As Ulf noted in [1], the maximum operating frequency
> documented in the mmc-controller device-tree bindings
> should be updated to the maximum frequency supported
> by the mmc controller(s).
> 
> Without this fix in place, the 'make dtbs_check' reports
> issues with 'max-frequency' value for ipq8074 sdhci node:
> 
>   arch/arm64/boot/dts/qcom/ipq8074-hk01.dtb: mmc@7824900:
>    max-frequency:0:0: 384000000 is greater than the maximum of 200000000
> 
> [1]. https://www.spinics.net/lists/kernel/msg4442049.html
> 
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  - v1 can be viewed here: https://lore.kernel.org/linux-arm-msm/20220725180916.2850228-1-bhupesh.sharma@linaro.org/
>  - Rebased on linux-next/master
> 
>  .../devicetree/bindings/mmc/mmc-controller.yaml     | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
