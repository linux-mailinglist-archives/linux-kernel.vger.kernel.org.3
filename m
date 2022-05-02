Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86EFB5178C9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 23:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236906AbiEBVLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 17:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbiEBVLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 17:11:09 -0400
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFA9B7FF;
        Mon,  2 May 2022 14:07:39 -0700 (PDT)
Received: by mail-oo1-f50.google.com with SMTP id y22-20020a4acb96000000b0035eb01f5b65so2037652ooq.5;
        Mon, 02 May 2022 14:07:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a371VTHbSEYi79+z15TeJoB6mz5PgVgi7zKHT0xX1Kk=;
        b=GhX3UgmnDtcfEU9Ang1A4+quExwXkfIA6A+hv5BGzkUXQAAMb4AMrAEoO1NjxjSLQR
         RB3HDbBSMAgzFF6xgxFQoRy88vX83iQlNAN0IWkig+SvvW6kBh3AIi4CGkhuXbrhCsqz
         8+3Ix9rMEAo430ND5VfO3I6B45TRI+nvA8vHl0tNbHCL02W8GTX1KyLkxTP+GAg4v0ZV
         7gSgLUGWZ59k/GK8z6XEUr8CCQToMDPQje5w053h63nqZ2DrrxTQb/44OXETVYdQ5UUe
         DFpefgILxDIEFh9p2C8BRvmnQaJG+n7iG8ykneJ/vW7eAQwTuatHYsH6N4wC4D9Vtyie
         DiVA==
X-Gm-Message-State: AOAM532iOR5341u17JOV1ztXkFMtSyWk9redmlul9U9srEK/+Ld8tg35
        YnWEi0GTcDeR7HVsrmE7nQ==
X-Google-Smtp-Source: ABdhPJy6gQDKkHfAjtBO138VnCai1byqDYuCDzwBFDj3hayyiSHN7IKBKJSlh5E+ccDtYeuAvkjfMQ==
X-Received: by 2002:a4a:d48c:0:b0:35e:aa26:b720 with SMTP id o12-20020a4ad48c000000b0035eaa26b720mr4702936oos.12.1651525658914;
        Mon, 02 May 2022 14:07:38 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x108-20020a9d37f5000000b006060322123csm3242660otb.12.2022.05.02.14.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 14:07:38 -0700 (PDT)
Received: (nullmailer pid 1752385 invoked by uid 1000);
        Mon, 02 May 2022 21:07:37 -0000
Date:   Mon, 2 May 2022 16:07:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     Xin Ji <xji@analogixsemi.com>
Cc:     Jonas Karlman <jonas@kwiboo.se>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, bliang@analogixsemi.com,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>,
        qwen@analogixsemi.com, linux-kernel@vger.kernel.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Robert Foss <robert.foss@linaro.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/4] dt-bindings:drm/bridge:anx7625: add port@0
 property
Message-ID: <YnBIGY+EWuZ2/rGI@robh.at.kernel.org>
References: <20220422084720.959271-1-xji@analogixsemi.com>
 <20220422084720.959271-3-xji@analogixsemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422084720.959271-3-xji@analogixsemi.com>
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

On Fri, 22 Apr 2022 16:47:17 +0800, Xin Ji wrote:
> Add 'bus-type' and 'data-lanes' define, bus-type 7 for MIPI DPI
> input, others for DSI input.
> 
> Signed-off-by: Xin Ji <xji@analogixsemi.com>
> 
> ---
> V1 -> V2: rebase on the latest code.
> ---
>  .../display/bridge/analogix,anx7625.yaml      | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
