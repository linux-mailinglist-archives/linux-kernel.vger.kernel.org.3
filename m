Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F6D4F9ED7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 23:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239660AbiDHVMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 17:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239762AbiDHVL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 17:11:57 -0400
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE05160FC6;
        Fri,  8 Apr 2022 14:09:52 -0700 (PDT)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-d6e29fb3d7so11000945fac.7;
        Fri, 08 Apr 2022 14:09:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xL4MCXB2ByKjAaLbtkoyBFo7i1uAlHJGlFCnrKvTWm0=;
        b=l7sHR2ON5r3wuz5J6PgF5TLzmoVP60btoJbFekJHd9mNZYMBB2W15wZ5fgXbxRa5Gi
         EchFQd1Aa5HwoomYnFjjPT5Vgk54uxQFLYmGDSp/2hl2iC3CNqdHOk2kmAwMP4B8Ec7O
         EPjpgqYiynxaQq9WGwdqHLKM8BdD53jz1blg0wyLGbNECz7+MNBSWJqqx+oN7QbGK6bS
         7uBCGg+a50hsPr+mGYlCgf1vWvORhjO12S1rvWMTqMkKaSVDRWzXCh9ygjoIh5kZb/dD
         sinQJPJs99LwFNLZycHWDDgFaaXpDZWv+k/tkjSFMrdLwDL57Ds7QR/w6x9j+7dYN7py
         4QLQ==
X-Gm-Message-State: AOAM53246+EeZunO/orQ3HDpz2YS0CwfPaZFfzKYEuyq/GwWu+8ehzxi
        9lYbyuIiU9yGZ5PeT/N4iQ==
X-Google-Smtp-Source: ABdhPJx6BXvBCFsDpk9BZCUFQ3NiDr3r4r6Gg1a75DYg+JwWmRpPW8LBfw4gcGR3LPw2N5nUl4AGdg==
X-Received: by 2002:a05:6870:b39c:b0:d1:4a9f:35f9 with SMTP id w28-20020a056870b39c00b000d14a9f35f9mr8945896oap.119.1649452192165;
        Fri, 08 Apr 2022 14:09:52 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q83-20020aca5c56000000b002f94910a053sm9080130oib.56.2022.04.08.14.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 14:09:51 -0700 (PDT)
Received: (nullmailer pid 4071047 invoked by uid 1000);
        Fri, 08 Apr 2022 21:09:51 -0000
Date:   Fri, 8 Apr 2022 16:09:51 -0500
From:   Rob Herring <robh@kernel.org>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 08/14] dt-bindings: reset: snps,axs10x-reset: Convert to
 yaml
Message-ID: <YlCkn7GaFI0wpoFc@robh.at.kernel.org>
References: <20220407154338.4190674-1-p.zabel@pengutronix.de>
 <20220407154338.4190674-8-p.zabel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407154338.4190674-8-p.zabel@pengutronix.de>
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

On Thu, 07 Apr 2022 17:43:32 +0200, Philipp Zabel wrote:
> Convert the device tree bindings for the AXS10x reset controller to YAML
> schema to allow participating in DT validation.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> ---
>  .../bindings/reset/snps,axs10x-reset.txt      | 33 -------------
>  .../bindings/reset/snps,axs10x-reset.yaml     | 48 +++++++++++++++++++
>  2 files changed, 48 insertions(+), 33 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/reset/snps,axs10x-reset.txt
>  create mode 100644 Documentation/devicetree/bindings/reset/snps,axs10x-reset.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
