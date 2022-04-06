Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59ACD4F6B6C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 22:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233232AbiDFUaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 16:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234732AbiDFU3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 16:29:49 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A47D35917D;
        Wed,  6 Apr 2022 11:51:39 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id q129so3369668oif.4;
        Wed, 06 Apr 2022 11:51:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Gozy76Oz1wSXA73FeGE7SmqQLAsoVOY+2sTGF1aa6Zw=;
        b=fE7TexvMuLOaLXKK6EJNxA2vmmayp5QSrYZI/MnurdJ55hJ+Py0CVtE6dZvcUps7rV
         fzk0Cd/zGQrRsqlA+F+vsiTIoK6GcYCm9BTVEzC4htL7PNQU9ji+WW0AGV1w6VyOEyxm
         1eoNmFFgbAA1Yorn38Mq1jvnBWAML+UlRTJy9F8WikrFOF91Hm2M+hYjkZ9k9yndWG8c
         Rf75OiifImh0lYOP4vQljoTpJsDxJeMayool18TBqC9qiBtc6g+Ez1WGflos+FftI19y
         hmtpJw9GLvO0AhU0W3b5KHKwoTiKxE3roc5qFDRrWOt76/c8lw/YanvANIrw57O/VpHR
         j0pQ==
X-Gm-Message-State: AOAM530pEjf1hXo46Tm7rJqxtE+xFCP2BrYotBmtTP+g1lCbzAebCOc0
        NPkL1N4pE91RpqlU60MKJw==
X-Google-Smtp-Source: ABdhPJx7UbafJNQyyivVdWkXjR46A1bh1Oaa+gC8ZwvqpNeu9q5dFGeK8oeuLmNIra2NA7b2IOOAYA==
X-Received: by 2002:a05:6808:2386:b0:2f9:a7fb:54f5 with SMTP id bp6-20020a056808238600b002f9a7fb54f5mr396861oib.33.1649271098704;
        Wed, 06 Apr 2022 11:51:38 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p11-20020acabf0b000000b002ef93581a46sm6655340oif.2.2022.04.06.11.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 11:51:38 -0700 (PDT)
Received: (nullmailer pid 2576022 invoked by uid 1000);
        Wed, 06 Apr 2022 18:51:37 -0000
Date:   Wed, 6 Apr 2022 13:51:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     sanjayc@nvidia.com, bbasu@nvidia.com, linux-tegra@vger.kernel.org,
        ksitaraman@nvidia.com, treding@nvidia.com, jonathanh@nvidia.com,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, viresh.kumar@linaro.org, krzk+dt@kernel.org
Subject: Re: [Patch v4 1/4] dt-bindings: Document Tegra CCPLEX Cluster
Message-ID: <Yk3hOafGDk/W1qPA@robh.at.kernel.org>
References: <20220405130119.4697-1-sumitg@nvidia.com>
 <20220405130119.4697-2-sumitg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405130119.4697-2-sumitg@nvidia.com>
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

On Tue, 05 Apr 2022 18:31:16 +0530, Sumit Gupta wrote:
> The Tegra CPU COMPLEX CLUSTER area contains memory-mapped
> registers that initiate CPU frequency/voltage transitions.
> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  .../tegra/nvidia,tegra-ccplex-cluster.yaml    | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra-ccplex-cluster.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
