Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC4E4E9705
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 14:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242645AbiC1MxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 08:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242641AbiC1Mww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 08:52:52 -0400
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A733ED3E;
        Mon, 28 Mar 2022 05:51:12 -0700 (PDT)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-deb9295679so7821828fac.6;
        Mon, 28 Mar 2022 05:51:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=GP1bdWVmsBSkAlGr/Gp2UnisAPKv1M13pEpomMv6UjQ=;
        b=34iRuX7v98YsGgMuCZcu3ahfBcnI0ZtkR1TkfhKxI7/sTdEfORIy/Tv8d6TUjcRYlB
         QUMyeCAjjflXqRKGIdmxb0vbqlTRN3ndVnp6RK7llXPtoAJiDplhmKy5pVMranYf5pYG
         5TF6skor1HQYgo4xnWcQyxLjiaomVvesDwYkjGeimnbr36V0MEUJZsxXta8SGdNNCu0x
         5SwAJLPqKtbsa+dOg/g0NBlfYjWDwaWupVZv7L+UtriSNKnHjqSgaiOqoJWot8DbUpbU
         A8IElb7XuMd5jy+BAyEIXrJ5RCWsJRYdkMKkXDxY4d74xQiOAOnA3tUIxAzxI+a4Bzmi
         p0fA==
X-Gm-Message-State: AOAM530e7v26vHEuO/s9fZjSwW8TuE7ODmdkesoi8DP3pSIUP8Mi7HAS
        9NH3qzjWKnq0iPo+U3NASb6wAbrJsA==
X-Google-Smtp-Source: ABdhPJwT3yYx6LIv4tBCmidDkpcH2xuaILIymk6sDk/mQOiMYgThNK+zceGc8kgIC3YCSqd7omS/7w==
X-Received: by 2002:a05:6870:65ab:b0:de:37be:30a6 with SMTP id fp43-20020a05687065ab00b000de37be30a6mr14525453oab.70.1648471871476;
        Mon, 28 Mar 2022 05:51:11 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n15-20020aca240f000000b002da2fc73741sm6940329oic.33.2022.03.28.05.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 05:51:10 -0700 (PDT)
Received: (nullmailer pid 2153576 invoked by uid 1000);
        Mon, 28 Mar 2022 12:51:05 -0000
From:   Rob Herring <robh@kernel.org>
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     broonie@kernel.org, robh+dt@kernel.org,
        linux-tegra@vger.kernel.org, tiwai@suse.com, krzk+dt@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        oder_chiou@realtek.com, linux-kernel@vger.kernel.org,
        peter.ujfalusi@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz
In-Reply-To: <1648448050-15237-2-git-send-email-spujar@nvidia.com>
References: <1648448050-15237-1-git-send-email-spujar@nvidia.com> <1648448050-15237-2-git-send-email-spujar@nvidia.com>
Subject: Re: [RFC PATCH v2 1/6] ASoC: dt-bindings: Convert rt5659 bindings to YAML schema
Date:   Mon, 28 Mar 2022 07:51:05 -0500
Message-Id: <1648471865.814225.2153575.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Mar 2022 11:44:05 +0530, Sameer Pujar wrote:
> Convert rt5659.txt DT binding to YAML schema. This binding is applicable
> to rt5658 and rt5659 audio CODECs.
> 
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> Cc: Oder Chiou <oder_chiou@realtek.com>
> ---
>  .../devicetree/bindings/sound/realtek,rt5659.yaml  | 112 +++++++++++++++++++++
>  Documentation/devicetree/bindings/sound/rt5659.txt |  89 ----------------
>  2 files changed, 112 insertions(+), 89 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/realtek,rt5659.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/rt5659.txt
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/1610026


audio-codec@1a: 'port' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dt.yaml

