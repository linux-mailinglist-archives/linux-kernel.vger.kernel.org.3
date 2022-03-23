Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48C34E598E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 21:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbiCWUHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 16:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242564AbiCWUHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 16:07:34 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C381C8596F;
        Wed, 23 Mar 2022 13:06:04 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id q129so2797194oif.4;
        Wed, 23 Mar 2022 13:06:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xJAiyJpQqYMzE45B4+4Ip3dFo7/yY92VkX/LiqX9660=;
        b=XevktBZOQlWe/ThAIjPK6RVgY9H1dh1T+G60gcQC3tNjLsJ9sZL8qsPMqmPK+0rmeO
         MadMgxRZ/Vf30taNiZtTM2aYOHaNiy7pBWS59DVOS16eYSxqqqA1+Ezr7nBNTlEsALje
         QHIm0AZFbg/H58knMRpMz1cz4icaISd2HcA9lCa9NAtsCjyGRidUhOJlgiup1SZsAreL
         odpdU34rtsl31jz7pFyrxKXdqzwTLn/DqQJPP1UWyP7xJhjZUbwJElV9+XQBwl+fHnEM
         RIrloIMFizmtFaDJ4RZ0sIXtGN5cQeeiWGT1E3nYxH/zlabVl2GjcjQPCMzCuqJfuURw
         EBfQ==
X-Gm-Message-State: AOAM532f+5BZ+rNiTckDElCFNevkwr25eb6e7hsDhb0TcFEXHs85dBPQ
        FJM+rq+XwFCHB+Ie8XanYw==
X-Google-Smtp-Source: ABdhPJyEg+a3Qvv1SXv6BAjqSqkcktrlf4VnWVfiwkpussCQzsTjMRsK/CDQ1DJSXP2e4dHsgVNAtg==
X-Received: by 2002:a05:6808:30a0:b0:2da:3e03:5620 with SMTP id bl32-20020a05680830a000b002da3e035620mr5445003oib.264.1648065964085;
        Wed, 23 Mar 2022 13:06:04 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o10-20020aca410a000000b002ecf2a4fda5sm395637oia.10.2022.03.23.13.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 13:06:03 -0700 (PDT)
Received: (nullmailer pid 362658 invoked by uid 1000);
        Wed, 23 Mar 2022 20:06:02 -0000
Date:   Wed, 23 Mar 2022 15:06:02 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nicolas Belin <nbelin@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, andrzej.hajda@intel.com,
        robert.foss@linaro.org, Laurent.pinchart@ideasonboard.com,
        narmstrong@baylibre.com, devicetree@vger.kernel.org,
        jonas@kwiboo.se, jernej.skrabec@gmail.com,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/3] dt-bindings: display: bridge: it66121: Add audio
 support
Message-ID: <Yjt9qrPP7UsvDkq7@robh.at.kernel.org>
References: <20220316135733.173950-1-nbelin@baylibre.com>
 <20220316135733.173950-2-nbelin@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316135733.173950-2-nbelin@baylibre.com>
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

On Wed, 16 Mar 2022 14:57:31 +0100, Nicolas Belin wrote:
> Update the ITE bridge HDMI it66121 bindings in order to
> support audio.
> 
> Signed-off-by: Nicolas Belin <nbelin@baylibre.com>
> ---
>  .../devicetree/bindings/display/bridge/ite,it66121.yaml        | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
