Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A3953D2D3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 22:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348173AbiFCUaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 16:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiFCUaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 16:30:08 -0400
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96DCE46153;
        Fri,  3 Jun 2022 13:30:06 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-f2cbceefb8so12008772fac.11;
        Fri, 03 Jun 2022 13:30:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aWgRjcIRY9aXR5lMG74PBf5aEP4BmW1ZmceFBkmSQgE=;
        b=7vrCa1qMci7NkH4UpRxFzi7IUGX9BVEKrlVMye55KKV7POJlIjdA9NKU7bUf0IISur
         utddu/qgOzwZ+JYVWu0ntL1PEyQiH8i0l977+Zuq75sczlV+jPsBH9sBrnLcIr2Ry5tb
         MqRX6aysnLtAfxNWNwB6Q3FVyFAnIV3aEMAPSqsIoIms0qyiCcNrTBI7KQ6nzr1+oGiJ
         WrscPD3IkKj9Nj2mgzxiwEX4oMQPtO4ErwzWKCYe6Y3eK+2g/K7RW6emXuOWy24nHCUN
         6ndDCrvWf4VwnCerjF2wM7GqkyMpuDRdIflV4upAKvBqZvaBniJVsbkOdW0lZI3rvUwU
         ekig==
X-Gm-Message-State: AOAM530J5f09FR0+uYyd6SyXlOVvLSyg02DMQN0KqjZ6YAwNXaihCcTY
        qc0kbxzIjCyklVQrEd6OJg==
X-Google-Smtp-Source: ABdhPJzDAK9Ow9YhSMIGcLFMa9uhRDPTC2tuaf29Q6ftaE+O1AaL/YlVV1f1W6fnvsQb1+wkPGINVA==
X-Received: by 2002:a05:6870:d0ce:b0:f3:3856:f552 with SMTP id k14-20020a056870d0ce00b000f33856f552mr7127615oaa.99.1654288204596;
        Fri, 03 Jun 2022 13:30:04 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k10-20020a056830168a00b006068c4af381sm4098088otr.54.2022.06.03.13.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 13:30:04 -0700 (PDT)
Received: (nullmailer pid 855181 invoked by uid 1000);
        Fri, 03 Jun 2022 20:30:03 -0000
Date:   Fri, 3 Jun 2022 15:30:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     broonie@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        thierry.reding@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        perex@perex.cz, tiwai@suse.com, jonathanh@nvidia.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/6] ASoC: tegra: Add binding doc for OPE module
Message-ID: <20220603203003.GA852734-robh@kernel.org>
References: <1654238172-16293-1-git-send-email-spujar@nvidia.com>
 <1654238172-16293-2-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1654238172-16293-2-git-send-email-spujar@nvidia.com>
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

On Fri, Jun 03, 2022 at 12:06:07PM +0530, Sameer Pujar wrote:
> This patch adds YAML schema for DT bindings of Output Processing
> Engine (OPE) module. It consists of Parametric Equalizer (PEQ)
> and Multi Band Dynamic Range Compressor (MBDRC) sub blocks and
> binding doc for these blocks are added as well. The OPE will be
> registered as an ASoC component and can be plugged into an audio
> path as per need via ALSA mixer controls. The DT bindings are
> applicable on Tegra210 and later SoCs where OPE module is present.
> 
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> ---
>  .../bindings/sound/nvidia,tegra210-ahub.yaml       |  4 +
>  .../bindings/sound/nvidia,tegra210-mbdrc.yaml      | 47 ++++++++++++
>  .../bindings/sound/nvidia,tegra210-ope.yaml        | 87 ++++++++++++++++++++++
>  .../bindings/sound/nvidia,tegra210-peq.yaml        | 48 ++++++++++++
>  4 files changed, 186 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra210-mbdrc.yaml
>  create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra210-ope.yaml
>  create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra210-peq.yaml

Doesn't apply for me. I guess there is some undocumented dependency 
here? Resend after the merge window if that solves it.

Rob
