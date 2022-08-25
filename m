Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 497F95A19FA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 22:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243258AbiHYUD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 16:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiHYUDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 16:03:25 -0400
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B75786C6;
        Thu, 25 Aug 2022 13:03:24 -0700 (PDT)
Received: by mail-ot1-f52.google.com with SMTP id o15-20020a9d718f000000b00638c1348012so14678853otj.2;
        Thu, 25 Aug 2022 13:03:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=NX+kWlu7YzDi1erT8mv3EVrowDzctlnFUR1m+ea6ebM=;
        b=mPOhA7k5qzUm7pSZ+QxP3cuvrby4bhoHvs8cNns0CVoPAgzvb5x0IUUtK8E+ovg8sN
         Ls0pv7IKyFtQ1mBPTCkV0x41k+ehfkmSRwi+8SSo3MLKvistyLXzmRFZgYBI3ZKsWb2Y
         y2Ek8UpMchHmoCMCCRKalFO2jqamDktJ6RMuQaxzwyg7B0tbDe8u0vm5SMWTx3kBKEmW
         S0V668zgqJMCi35aMdIVQsZBwEhF8pM46mYPuf/Oo7xO+uAjh8tc7/pt4Hl/dZRouAR7
         TmvOsijcj3Wpkq7V47bd3hB8C3mGG/TqBNgocgHuLbYAFgNX+bfBKTbwVVr9pYAnbpQO
         7GsA==
X-Gm-Message-State: ACgBeo3v+u9J55rkjsPO5Js1+oGhRMkPA6/qi7mUgqQAPr1SX8f/X8+z
        iKE20G1Krpy8PT3/ebIJCg==
X-Google-Smtp-Source: AA6agR6EYi3++RtEDrELk6ImmynBdGP+rRvJ/VMvskjARhold+xHLeFuDizT0Xo3s+lz8Jth8lG9Qw==
X-Received: by 2002:a05:6830:3699:b0:638:8a49:b83 with SMTP id bk25-20020a056830369900b006388a490b83mr257269otb.13.1661457804218;
        Thu, 25 Aug 2022 13:03:24 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y5-20020a056830208500b00636fd78dd57sm24otq.41.2022.08.25.13.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 13:03:23 -0700 (PDT)
Received: (nullmailer pid 1595917 invoked by uid 1000);
        Thu, 25 Aug 2022 20:03:22 -0000
Date:   Thu, 25 Aug 2022 15:03:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <robert.foss@linaro.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] dt-bindings: display: adi,adv75xx: Add missing graph
 schema references
Message-ID: <20220825200322.GA1595830-robh@kernel.org>
References: <20220823145649.3118479-12-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823145649.3118479-12-robh@kernel.org>
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

On Tue, 23 Aug 2022 09:56:43 -0500, Rob Herring wrote:
> DT bindings using the graph binding must have references to the graph
> binding schema. These are missing from the adi,adv7511 and adi,adv7533
> bindings, so add them.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/display/bridge/adi,adv7511.yaml       | 14 ++++++--------
>  .../bindings/display/bridge/adi,adv7533.yaml       | 14 ++++++--------
>  2 files changed, 12 insertions(+), 16 deletions(-)
> 

Applied, thanks!
