Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76F2B58E0DA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 22:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344314AbiHIUQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 16:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345151AbiHIUPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 16:15:33 -0400
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586E710AD;
        Tue,  9 Aug 2022 13:15:28 -0700 (PDT)
Received: by mail-io1-f47.google.com with SMTP id e69so10516115iof.5;
        Tue, 09 Aug 2022 13:15:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=6MO20EzScGnTRTFMIDq+lQJgeu9wszakkNnV5YIR2mo=;
        b=tGf/lndFs6FHn86DWKPt5hFZZzcrrmWvXeZ1JesiZkwxob3V+Qqm505AdDeNd4MNWp
         g76rgNI4ATL6ndsUauXYi1MuQNwLufVyoytq6UoGxeuZXl1ewVlvXEGc5NSSwfvJYEzU
         fabAPWaDGPxQLix1DI401qiR9qMUiokrPJU4bDPMTQ1Wa9ctd8hzPBtmtuMk29yU+sH5
         rMde3pN4FJSKNV9a54dFePNtRebGWvss3mq4mwrdkK4ndlJNRqLwz2+qN5BETZWcs7nS
         5oaEtjC7F0qDx6zYldXB7jbECk6sQroqAJRZBNRxUevctzpDX6xVu2tDpX45aox6KZe/
         1OvA==
X-Gm-Message-State: ACgBeo3kTI/6wMFnLcc/qvwnFJ1kJ9zdUQdcC3W2t47OcWgOgUPVx+K5
        kAlI/AyMd9oAMFdBJyl1lA==
X-Google-Smtp-Source: AA6agR597B8yeSa4lMVWO5AwtWeuOtTJ6yRuWKBbxenIXOizC9/dKRK5JA5BWW+4WDcWtE8BByaQBg==
X-Received: by 2002:a05:6638:1a8d:b0:342:884f:5a35 with SMTP id ce13-20020a0566381a8d00b00342884f5a35mr10956175jab.289.1660076127579;
        Tue, 09 Aug 2022 13:15:27 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id r5-20020a92cd85000000b002ddafe492e5sm1384795ilb.41.2022.08.09.13.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 13:15:27 -0700 (PDT)
Received: (nullmailer pid 2318869 invoked by uid 1000);
        Tue, 09 Aug 2022 20:15:25 -0000
Date:   Tue, 9 Aug 2022 14:15:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, lgirdwood@gmail.com,
        tiwai@suse.com, robh+dt@kernel.org, broonie@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        perex@perex.cz, kuninori.morimoto.gx@renesas.com,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v3 1/3] ASoC: dt-bindings: Definitions for DAI params
Message-ID: <20220809201525.GA2318816-robh@kernel.org>
References: <1659936452-2254-1-git-send-email-spujar@nvidia.com>
 <1659936452-2254-2-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1659936452-2254-2-git-send-email-spujar@nvidia.com>
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

On Mon, 08 Aug 2022 10:57:30 +0530, Sameer Pujar wrote:
> The "convert-channels" and "convert-rate" bindings are available for
> audio-graph-card and are documented in the audio-graph-port.yaml and
> the audio-graph.yaml. There is duplication of property details at
> multiple places.
> 
> Introduce a new schema to have common definitions for DAI params and
> these can be re-used in other schemas wherever applicable. Presently
> update audio-graph-card bindings to use these definitions. If required
> simple-card bindings can be extended to make use of common definitions.
> 
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  .../bindings/sound/audio-graph-port.yaml           | 13 ++++------
>  .../devicetree/bindings/sound/audio-graph.yaml     |  7 +++--
>  .../devicetree/bindings/sound/dai-params.yaml      | 30 ++++++++++++++++++++++
>  3 files changed, 38 insertions(+), 12 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/dai-params.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
