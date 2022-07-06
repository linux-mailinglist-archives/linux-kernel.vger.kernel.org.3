Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5A5568C03
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 16:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233352AbiGFO7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 10:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbiGFO67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 10:58:59 -0400
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB8C2623;
        Wed,  6 Jul 2022 07:58:58 -0700 (PDT)
Received: by mail-io1-f47.google.com with SMTP id r133so14237771iod.3;
        Wed, 06 Jul 2022 07:58:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eJuCMMC+uG44dO4wxsO1vA2dIitIOk6v906C6snfprE=;
        b=RmGMOx+Z78NWbndyk/RTYlg3HG/zlkVInawq2n3kYnBGfsiE727tgtdXk3HIqNS8kH
         fxGDev/Fb5sIMakh8IzdS7TYX7KoOTtV840BHi1H/MsodXciAmjEbGrBmxJV7De/uUB6
         BWoq5K/isF4tf1BC/5+TNZig2YEWqIRwfG+enD+FF6JpuR6Yq+r3ESCjAaeB3zKdJHxz
         9ixQYDHCk2VrdBLhTXrFlV2pzFK9EKGQc4UHoGJ5OUyJuwUdmQ4jL+LfCbgX3dfKZRS0
         qQGFboG1alEq204hiL6QpStuVgWW1rPS+3cWqfx7NgHvraFYGKVsoTW9qp0GC/WM4ASh
         +9tg==
X-Gm-Message-State: AJIora8Dxht9piKx59W5oG18oIgT+lG1mp5VR/22JbU4yX8eLP7PGvhp
        7Uav8LWiLbDC+woNMTqg6g==
X-Google-Smtp-Source: AGRyM1sLkECkvLx1Pzirwnr9rkq9jdtJYd/dHEiClAa1S8JByZc7hbWHf0n+VMoW+xWxpHl0MVej4Q==
X-Received: by 2002:a5e:c60a:0:b0:674:fd9d:e31f with SMTP id f10-20020a5ec60a000000b00674fd9de31fmr21676785iok.148.1657119537942;
        Wed, 06 Jul 2022 07:58:57 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id h8-20020a92d848000000b002da9f82c703sm10517036ilq.5.2022.07.06.07.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 07:58:57 -0700 (PDT)
Received: (nullmailer pid 36413 invoked by uid 1000);
        Wed, 06 Jul 2022 14:58:55 -0000
Date:   Wed, 6 Jul 2022 08:58:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rahul T R <r-ravikumar@ti.com>
Cc:     vigneshr@ti.com, lee.jones@linaro.org, andrzej.hajda@intel.com,
        mparab@cadence.com, laurent.pinchart@ideasonboard.com,
        linux-kernel@vger.kernel.org, a-bhatia1@ti.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, narmstrong@baylibre.com,
        robert.foss@linaro.org, tomi.valkeinen@ideasonboard.com,
        krzysztof.kozlowski+dt@linaro.org, dri-devel@lists.freedesktop.org,
        jernej.skrabec@gmail.com, p.zabel@pengutronix.de, daniel@ffwll.ch,
        sjakhade@cadence.com, jonas@kwiboo.se, jpawar@cadence.com,
        airlied@linux.ie
Subject: Re: [PATCH v5 2/5] dt-bindings: display: bridge: cdns,dsi: Add
 compatible for dsi on j721e
Message-ID: <20220706145855.GA36360-robh@kernel.org>
References: <20220706114053.3454-1-r-ravikumar@ti.com>
 <20220706114053.3454-3-r-ravikumar@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706114053.3454-3-r-ravikumar@ti.com>
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

On Wed, 06 Jul 2022 17:10:50 +0530, Rahul T R wrote:
> Add compatible to support dsi bridge on j721e
> 
> Signed-off-by: Rahul T R <r-ravikumar@ti.com>
> ---
>  .../bindings/display/bridge/cdns,dsi.yaml     | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
