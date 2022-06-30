Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2702561F1A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 17:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234885AbiF3PUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 11:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235686AbiF3PUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 11:20:04 -0400
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42037637F;
        Thu, 30 Jun 2022 08:20:03 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id p69so19429164iod.10;
        Thu, 30 Jun 2022 08:20:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DkXqk+AePfbA7pH+z9Dn++p1/AQn3KVd9XT2RKpV41k=;
        b=TYwUVwOwsDFSfrc5pphA4IIjc6Gs9XzAo40Ex9L8Yt5L/1GJ+Ak504Sn10Otec2ZKL
         H2Wp79KPSriI6opNI4hFxuG6Wnh+Y0e9sWHE/MmQWg23m5sUpkF+EiPYP8dLtbgzQd3m
         HTZFIo0PZUEIAHGAihIV42ugUczVFSD1FhT9O3trMBiIu7VIHOSvvbni98CmthFFDPyF
         R5c4musBhH4I5ZtUhQhoRrkp/uTAY1VVkftjcRwu3HBngOWrzZKdhyxYYHB/M18SzEQh
         Ew95/FmpNT4HskITL3Ka5o6LzErYDF/xtcPJUzzhMRsXA3K40QralIyY05eAesxXgi4b
         tScw==
X-Gm-Message-State: AJIora/Lo3LT4fHjIrvU+GyF051mXK1tFomlqHEuC6HG9lkHr/z0TX5a
        k9IiKyNLJ2rQ3JsDPs3FXw==
X-Google-Smtp-Source: AGRyM1twz4YnNC+zp+pMABb329bCZNDTct+Lv1bu/S1PkCwpdSDxo7ZeosSO8CRnMziG9bEm4OnGDg==
X-Received: by 2002:a02:ac1:0:b0:339:ce43:bc25 with SMTP id 184-20020a020ac1000000b00339ce43bc25mr5684411jaw.308.1656602402556;
        Thu, 30 Jun 2022 08:20:02 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id bw14-20020a056638460e00b0033ca26010besm4600362jab.148.2022.06.30.08.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 08:20:02 -0700 (PDT)
Received: (nullmailer pid 2729804 invoked by uid 1000);
        Thu, 30 Jun 2022 15:20:01 -0000
Date:   Thu, 30 Jun 2022 09:20:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mikko Perttunen <cyndis@kapsi.fi>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7/v3 10/22] dt-bindings: host1x: Fix bracketing in
 example
Message-ID: <20220630152001.GB2722229-robh@kernel.org>
References: <20220627142008.2072474-1-cyndis@kapsi.fi>
 <20220627142008.2072474-11-cyndis@kapsi.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627142008.2072474-11-cyndis@kapsi.fi>
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

On Mon, Jun 27, 2022 at 05:19:56PM +0300, Mikko Perttunen wrote:
> From: Mikko Perttunen <mperttunen@nvidia.com>
> 
> The bracketing for the interrupts property in the device tree
> example is incorrect. Fix it.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>  .../bindings/display/tegra/nvidia,tegra20-host1x.yaml         | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
