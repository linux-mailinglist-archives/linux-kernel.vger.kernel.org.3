Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE10501714
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 17:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239942AbiDNPTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 11:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347775AbiDNN7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 09:59:32 -0400
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508E0A94E2;
        Thu, 14 Apr 2022 06:53:34 -0700 (PDT)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-de3eda6b5dso5358057fac.0;
        Thu, 14 Apr 2022 06:53:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b1fmOcvfq0NdewvcCb3vlwr8j3wXB3tS/OMfuj5UtlU=;
        b=B4G9li+gyic+mSIfiDt75rSpudFsnOWwJ7ui948V4BCvvQ9ogMh576WM3NT7WVQawS
         qH7jiCfqSLZHNzxzb2VglvSjOMPdXLFiscWNQSBiw7abCELKFIFBii7QbntOdMGIfIIt
         fhKtB1hw9sumOC28HIv9OCu9rJeVV/CCKxwEr1QSjX2q/6AQF6bRmT3czZKIWyHGhOWF
         Z6CBdz6+aF/m07kkftdrnMK+Wphqobs0Uz55I9kb3RFt1Xbb0ow2cDboF7V1tswoz2tR
         YO25DI9Vr/YXVeURLOCnW41JQ1gwzW2O4VmTzgLOegLtGsEpcEXUylrTl7JFguScQFef
         y5gg==
X-Gm-Message-State: AOAM533q/uDNCmCuldrfwio48l45CZOY9PB6AdNMAj95uQraIkC0ItCA
        G6QUtFuiUMt0sxNRwXPS4JDMFURt0w==
X-Google-Smtp-Source: ABdhPJww3qRkZtGwfjpNEzvqRQvkbI1fLP9z/+5tzeS5Pt2GbgkyVjc2xc9Y0mylgugZ+aaXYPsliQ==
X-Received: by 2002:a05:6870:5712:b0:de:2cbd:c39b with SMTP id k18-20020a056870571200b000de2cbdc39bmr1331317oap.180.1649944413585;
        Thu, 14 Apr 2022 06:53:33 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t14-20020a05683014ce00b005b23657f66esm30059otq.31.2022.04.14.06.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 06:53:33 -0700 (PDT)
Received: (nullmailer pid 1898802 invoked by uid 1000);
        Thu, 14 Apr 2022 13:53:32 -0000
Date:   Thu, 14 Apr 2022 08:53:32 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kartik <kkartik@nvidia.com>
Cc:     jassisinghbrar@gmail.com, krzk+dt@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: tegra186-hsp: add type for shared
 mailboxes
Message-ID: <YlgnXKGHqcCgItlb@robh.at.kernel.org>
References: <1649921757-16919-1-git-send-email-kkartik@nvidia.com>
 <1649921757-16919-3-git-send-email-kkartik@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1649921757-16919-3-git-send-email-kkartik@nvidia.com>
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

On Thu, Apr 14, 2022 at 01:05:56PM +0530, Kartik wrote:
> Tegra234 supports sending/receiving 32-bit and 128-bit data over
> a shared mailbox. Based on the data size to be used, clients need
> to specify the type of shared mailbox in the device tree.
> 
> Add a macro for 128-bit shared mailbox. Mailbox clients can use this
> macro as a flag in device tree to enable 128-bit data support for a
> shared mailbox.
> 
> Signed-off-by: Kartik <kkartik@nvidia.com>

Need a full name here.

> ---
>  .../devicetree/bindings/mailbox/nvidia,tegra186-hsp.yaml | 9 +++++++++
>  include/dt-bindings/mailbox/tegra186-hsp.h               | 5 +++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.yaml b/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.yaml
> index 9f7a7296b57f..a3e87516d637 100644
> --- a/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.yaml
> +++ b/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.yaml
> @@ -26,6 +26,15 @@ description: |
>    second cell is used to identify the mailbox that the client is going
>    to use.
>  
> +  For shared mailboxes, the first cell composed of two fields:
> +    - bits 15..8:
> +        A bit mask of flags that further specifies the type of shared
> +        mailbox to be used (based on the data size). If no flag is
> +        specified then, 32-bit shared mailbox is used.
> +    - bits 7..0:
> +        Defines the type of the mailbox to be used. This field should be
> +        TEGRA_HSP_MBOX_TYPE_SM for shared mailboxes.
> +
>    For doorbells, the second cell specifies the index of the doorbell to
>    use.
>  
> diff --git a/include/dt-bindings/mailbox/tegra186-hsp.h b/include/dt-bindings/mailbox/tegra186-hsp.h
> index 3bdec7a84d35..b9ccae2aa9e2 100644
> --- a/include/dt-bindings/mailbox/tegra186-hsp.h
> +++ b/include/dt-bindings/mailbox/tegra186-hsp.h
> @@ -15,6 +15,11 @@
>  #define TEGRA_HSP_MBOX_TYPE_SS 0x2
>  #define TEGRA_HSP_MBOX_TYPE_AS 0x3
>  
> +/*
> + * These define the types of shared mailbox supported based on data size.
> + */
> +#define TEGRA_HSP_MBOX_TYPE_SM_128BIT (1 << 8)
> +
>  /*
>   * These defines represent the bit associated with the given master ID in the
>   * doorbell registers.
> -- 
> 2.17.1
> 
> 
