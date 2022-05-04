Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D64B951AF78
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 22:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353541AbiEDUnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 16:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378299AbiEDUnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 16:43:09 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE89850B1F;
        Wed,  4 May 2022 13:39:30 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-e656032735so2425845fac.0;
        Wed, 04 May 2022 13:39:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=S4POjd6sez9oc9aUZY3gXfVuFYOsA352dcoVpMWV9Qo=;
        b=0cXytjSXBtE3/Oq6QtGVveb77MUvH6DUHLgOnaJYP+Cd5D+VkJOCBASK0GhRg6/hOc
         Aj1lzU0sUoR/fK6+MVxtRiQyWu3CALGLZHtBL+wwizLN7KtcpsEU7XwaC5Vgk7koLzPN
         YTt+W2HNSXQwoHbXQKLjcsZMb6QdY2heYrO30h8nA3H3DV+siwwBHJ1JPXaWwr/jcPvm
         04ZLB9+JD7IUyTU2LEMR+nKwpC5JiS9gjNvg/O/WHh7PJgL1iLlUCRSC0VsZ9LwUCIo3
         pwjyDioR7uuTyNqCRsAttZb9SPjfMWIdO13PO58CcMuu9euCnjlYjHKwPw4K2cXyF7qS
         ULxA==
X-Gm-Message-State: AOAM530/mlAaH4MkIZqtmGyd2VlmdpflDbBfgGbz0uR2XLlto68WY3IT
        0gInOUU8KqpAww/jYzLXFw==
X-Google-Smtp-Source: ABdhPJxFuyd/aXmgVJNfTzeAlb5W8QgkzRYxK7rdQuOk1wYb+Q5RtOkuQoOPEWwEq/vnwU4scBvAqQ==
X-Received: by 2002:a05:6870:a107:b0:ed:9a88:88b8 with SMTP id m7-20020a056870a10700b000ed9a8888b8mr718350oae.298.1651696770246;
        Wed, 04 May 2022 13:39:30 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a4-20020a05687073c400b000e90b37d2f5sm8373047oan.24.2022.05.04.13.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 13:39:29 -0700 (PDT)
Received: (nullmailer pid 2188096 invoked by uid 1000);
        Wed, 04 May 2022 20:39:29 -0000
Date:   Wed, 4 May 2022 15:39:29 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado 
        <nfraprado@collabora.com>
Cc:     alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] ASoC: dt-bindings: rt1015p: Add #sound-dai-cells
Message-ID: <YnLkgd95msrSPpVe@robh.at.kernel.org>
References: <20220429203039.2207848-1-nfraprado@collabora.com>
 <20220429203039.2207848-3-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220429203039.2207848-3-nfraprado@collabora.com>
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

On Fri, 29 Apr 2022 16:30:38 -0400, Nícolas F. R. A. Prado wrote:
> The rt1015p codec can be pointed to through a sound-dai property to be
> used as part of a machine sound driver. dtc expects #sound-dai-cells to
> be defined in the codec's node in those cases, so add it in the
> dt-binding and set it to 0.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
> 
>  Documentation/devicetree/bindings/sound/realtek,rt1015p.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
