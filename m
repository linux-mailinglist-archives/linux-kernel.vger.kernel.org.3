Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 003355A54DD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 21:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiH2Ty6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 15:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiH2Typ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 15:54:45 -0400
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F30B83BF5;
        Mon, 29 Aug 2022 12:54:41 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-11eb44f520dso7525075fac.10;
        Mon, 29 Aug 2022 12:54:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=en3iithyevFDMatFS08w+upETMWdwpkw/XCDou7WR5U=;
        b=f4Hv5QmhipB8SbORPr1H8E7v7UkNsTV0UozNfeC+lW8XIG3hk9NXIY+fYkLC7yaq10
         ovysxeu+RGmnzh+UhvwqSCUqDcfY28kkFcWsfwiOvjYw5ItstcYPtqWBR52sgHqpC9ck
         tYuKKIXjCqFa9OzbH/iV84mPJmQgVjSbM/MBwFotWkdN2V6NXt2ycAdTxHgPFRs3hYCO
         4KkRxFldZyM/rxPKjIeIoi4YK/0rW1ayIEyOCNs3W8rMLgwhUN8UkqHiMj44yGf3qAKg
         zy5QLhA+JhTRiXWA3NKD84otxBRBvqi36Qm8D3moFYSLaIAOwNlFypf6Amqm9XN8dS1X
         xSbA==
X-Gm-Message-State: ACgBeo0T5K+FGB6pcdv+Iop58z7zjs5hQd3/l5p3Mw/UcgS03GtsSNfM
        HeEnG/1gVa1+Pi8FDA45MA==
X-Google-Smtp-Source: AA6agR7rAR5OhLrkKvgL0sKFBxfUGYd4vR/SwtAF4HU/wjmE/n1PKq6py+EqKTY+iSpPcaT9UGHZ7Q==
X-Received: by 2002:a05:6870:4606:b0:10d:c8b2:7f7d with SMTP id z6-20020a056870460600b0010dc8b27f7dmr8443721oao.238.1661802880370;
        Mon, 29 Aug 2022 12:54:40 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bk9-20020a056830368900b006370b948974sm5942235otb.32.2022.08.29.12.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 12:54:40 -0700 (PDT)
Received: (nullmailer pid 2309224 invoked by uid 1000);
        Mon, 29 Aug 2022 19:54:38 -0000
Date:   Mon, 29 Aug 2022 14:54:38 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <robert.foss@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH] dt-bindings: display: synopsys, dw-hdmi: drop ref from
 reg-io-width
Message-ID: <20220829195438.GA2309143-robh@kernel.org>
References: <20220823101031.387082-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823101031.387082-1-krzysztof.kozlowski@linaro.org>
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

On Tue, 23 Aug 2022 13:10:31 +0300, Krzysztof Kozlowski wrote:
> reg-io-width is a standard property, so no need for defining its type
> with $ref.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/display/bridge/synopsys,dw-hdmi.yaml     | 1 -
>  1 file changed, 1 deletion(-)
> 

Applied, thanks!
