Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C483853AF94
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 00:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbiFAVJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 17:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbiFAVJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 17:09:43 -0400
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E228439689;
        Wed,  1 Jun 2022 14:09:40 -0700 (PDT)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-f33f0f5b1dso4350502fac.8;
        Wed, 01 Jun 2022 14:09:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lz9YkXmluzI1p168QLYr9xM1kRCaRjaM0/FGvCuSWY8=;
        b=ApHmYzwBrnWG6LVxH/M/lR0INi2hZThiS4EvtczgX+lEEvZ2h88L1oL99Y3mBoBnb+
         1FQpBm2QeIGkoHYOJaEoaDYClhliS1TYWspYFyHehq97WWleJ7b3yCP4QOSTL3s8NlVU
         IGoQsal5GuMZpG3jRasGXYUEEVEtDdPGE38J1toLAm4Gk7zzjS+z1tzTFE+67LeokNEZ
         5ry7lN5ZFg/W8zeX2CM4oR+fRspuPebxSHNSlseaIGDMgif9rw0lYqWqcH6FoPxHsGvc
         x9u0F9XAEwhWPU2cXHhVD80sImN/u8a8l6bUOQmk/F/vPJNZuddt00QXRDfZ5f+rZvRf
         /g1Q==
X-Gm-Message-State: AOAM5329QLotnAEfov6yzxloEoa0+SiJonQQhrEHVsqoFTNyLn0PTZHi
        eVUf1LvXwJSRNprM1NqIgw==
X-Google-Smtp-Source: ABdhPJzrWF2c69+FrFYHc/YQUqCI9lL1oAgA5F5TgXFwkCpLR8CEM1a7l1cxJ8pd4y096o7Y6Bbn3w==
X-Received: by 2002:a05:6870:f587:b0:f5:eee4:d01c with SMTP id eh7-20020a056870f58700b000f5eee4d01cmr2201713oab.117.1654117780078;
        Wed, 01 Jun 2022 14:09:40 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q8-20020a056830440800b0060aeccf6b44sm1367078otv.41.2022.06.01.14.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 14:09:39 -0700 (PDT)
Received: (nullmailer pid 457426 invoked by uid 1000);
        Wed, 01 Jun 2022 21:09:38 -0000
Date:   Wed, 1 Jun 2022 16:09:38 -0500
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Rob Herring <robh+dt@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
        Neil Armstrong <narmstrong@baylibre.com>,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Boris Brezillon <bbrezillon@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v3] dt-bindings: display: bridge: sil,sii9022: Convert to
 json-schema
Message-ID: <20220601210938.GA457343-robh@kernel.org>
References: <2f8e12b4980a82788c1dd413ceedf8d144fdca91.1652967387.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f8e12b4980a82788c1dd413ceedf8d144fdca91.1652967387.git.geert+renesas@glider.be>
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

On Thu, 19 May 2022 15:41:06 +0200, Geert Uytterhoeven wrote:
> Convert the Silicon Image sii902x HDMI bridge Device Tree binding
> documentation to json-schema.
> 
> Add missing sil,sii9022-cpi and sil,sii9022-tpi compatible values.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v3:
>   - Add comments clarifying CPI/TPI,
>   - Improve wording,
>   - Drop port@2,
>   - Add port descriptions,
>   - Add schema references to individual ports.
> 
> v2:
>   - Rework sil,i2s-data-lanes,
>   - Add schema reference to ports.
> ---
>  .../bindings/display/bridge/sii902x.txt       |  78 -----------
>  .../bindings/display/bridge/sil,sii9022.yaml  | 131 ++++++++++++++++++
>  2 files changed, 131 insertions(+), 78 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/bridge/sii902x.txt
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/sil,sii9022.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
