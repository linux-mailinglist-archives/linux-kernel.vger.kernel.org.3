Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 792EB51AF7F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 22:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378267AbiEDUnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 16:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378242AbiEDUnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 16:43:16 -0400
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3702B5045F;
        Wed,  4 May 2022 13:39:39 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id e189so2378638oia.8;
        Wed, 04 May 2022 13:39:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=4qEjMBGyn6Ax7kk135DQcxU8nStaVR1F7LoMbwMuoWg=;
        b=1EmbmdMvVyhHoTXaZkwdIBgZKqfIRjSoWaXlbcLeJ9+U5hzrrR6VDgrdDzS/w20Fg7
         PxvS4DgXB0BGVWQZsRcc7ZtLY6fv/yDL8yusERkUE30kyukbd71O11K0I1wnBFgTrx6e
         0FDJwZxB1Rp3Cf2qaiaMWAf9u5Ff1mM1s+JeczcRhDxsSpec7+3pPhzgEtxXMBlyqns+
         QyIysdj7+GY2P8EC1UYYc8mTYlg9prUByDoFUph2YE0PSSP1iRmvR52gjcSBT898u0X9
         sXTmDMD33aHNkUzvtPv1Wj+3arA/+VVtzpAlmX8CyKTo5medd+gx5F2M0ayOnMQzOMy6
         gWgw==
X-Gm-Message-State: AOAM533wa6e6PrXi+7uwTWjZNc6hRDc5SsxGx1X10VE7hiCnY1oaBr3h
        7BVf8xZKPCyz95J7mv47vg==
X-Google-Smtp-Source: ABdhPJwDMlqxoLd2JwDyv6kHNDs81yJUYwFkx2lp9aIStnjbEDAFyQyot+1S4H/D417GQgMWDXaJhw==
X-Received: by 2002:a05:6808:170d:b0:2f7:338b:1fc2 with SMTP id bc13-20020a056808170d00b002f7338b1fc2mr712692oib.60.1651696778437;
        Wed, 04 May 2022 13:39:38 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y3-20020a056870e50300b000e686d13884sm1413116oag.30.2022.05.04.13.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 13:39:38 -0700 (PDT)
Received: (nullmailer pid 2188386 invoked by uid 1000);
        Wed, 04 May 2022 20:39:37 -0000
Date:   Wed, 4 May 2022 15:39:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado 
        <nfraprado@collabora.com>
Cc:     devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, kernel@collabora.com,
        alsa-devel@alsa-project.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH 3/3] ASoC: dt-bindings: rt5682: Add #sound-dai-cells
Message-ID: <YnLkieDO1QJtWFQC@robh.at.kernel.org>
References: <20220429203039.2207848-1-nfraprado@collabora.com>
 <20220429203039.2207848-4-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220429203039.2207848-4-nfraprado@collabora.com>
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

On Fri, 29 Apr 2022 16:30:39 -0400, Nícolas F. R. A. Prado wrote:
> The rt5682 codec can be pointed to through a sound-dai property to be
> used as part of a machine sound driver. dtc expects #sound-dai-cells to
> be defined in the codec's node in those cases, so add it in the
> dt-binding and set it to 0.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
> 
>  Documentation/devicetree/bindings/sound/rt5682.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
