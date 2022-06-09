Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7FD54555E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 22:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240042AbiFIUNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 16:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238643AbiFIUNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 16:13:21 -0400
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7C76572;
        Thu,  9 Jun 2022 13:13:18 -0700 (PDT)
Received: by mail-io1-f44.google.com with SMTP id a10so23280119ioe.9;
        Thu, 09 Jun 2022 13:13:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U+XVqkGl1216NwGHDcD5Ngd9nvqMHfeDnXNSteurP74=;
        b=CYNnfkXxgA7uKOKYy7OKOIPstgFOwBwtiXyEVt8IDSMI1HKwKNt0Z26+nllpai11CZ
         0HLPIOpWj/3sFwJdRbX6PaKQd5bnQcEaAUtUKe5WhRTrCljcM/EKsZQf6RKex7U06FEW
         jMlWKIOEbnhsyEu/xNQTfRM2c6Y5FLGAaDwnYkTGPsYINrn71uTOaRfM9hYhnjQVd+aH
         hIHvVraR/1WARRa+XLUfg78KTmTlgef+jMtnWMXJWDWeV3weGCvqo9JIZkwSxgaFyCtf
         kBEJ8nvhIXpQDjm2Yp5AdtN9Dm+ixFGjNBdLl8NKJzzOZEp1mlG3U+HvMh8FWZDXjKXA
         n4HQ==
X-Gm-Message-State: AOAM530NYQhRxQ4H+Bvt87tNw64OawP29KzjSwurXBgz3xNTrdeEPBjT
        LuyhaSE6UAFx0vjpl3q1Ow==
X-Google-Smtp-Source: ABdhPJyHDkp/wYSMURLFzLrcDYGk6UwE5zGDsJMuhixGMTa4vUrDc818wEJE3jTTI4JRuOnx3OZVzg==
X-Received: by 2002:a05:6638:40a6:b0:331:cd97:8629 with SMTP id m38-20020a05663840a600b00331cd978629mr8425069jam.304.1654805597707;
        Thu, 09 Jun 2022 13:13:17 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id i7-20020a925407000000b002cde6e352e5sm10838693ilb.47.2022.06.09.13.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 13:13:17 -0700 (PDT)
Received: (nullmailer pid 26524 invoked by uid 1000);
        Thu, 09 Jun 2022 20:13:15 -0000
Date:   Thu, 9 Jun 2022 14:13:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krishna Yarlagadda <kyarlagadda@nvidia.com>
Cc:     broonie@kernel.org, thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        ashishsingha@nvidia.com, skomatineni@nvidia.com,
        ldewangan@nvidia.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Patch V3 2/3] spi: dt-bindings: split peripheral prods
Message-ID: <20220609201315.GA24169-robh@kernel.org>
References: <20220607114659.54314-1-kyarlagadda@nvidia.com>
 <20220607114659.54314-3-kyarlagadda@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607114659.54314-3-kyarlagadda@nvidia.com>
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

On Tue, Jun 07, 2022 at 05:16:58PM +0530, Krishna Yarlagadda wrote:
> Move peripheral properties for Tegra QSPI controller to
> nvidia,tegra210-quad-peripheral-props.yaml and add reference
> to spi-peripheral-props.yaml file.

What are 'peripheral prods'?

> 
> Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> ---
>  ...nvidia,tegra210-quad-peripheral-props.yaml | 33 +++++++++++++++++++
>  .../bindings/spi/nvidia,tegra210-quad.yaml    | 21 ------------
>  .../bindings/spi/spi-peripheral-props.yaml    |  1 +
>  3 files changed, 34 insertions(+), 21 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/nvidia,tegra210-quad-peripheral-props.yaml

Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>
