Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60BFE4D6C5C
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 04:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbiCLDsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 22:48:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiCLDsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 22:48:22 -0500
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6545C2396BD;
        Fri, 11 Mar 2022 19:47:18 -0800 (PST)
Received: by mail-oi1-f179.google.com with SMTP id w127so11512978oig.10;
        Fri, 11 Mar 2022 19:47:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=94UTeEsxQuooHcLqoJmGpm1RqHEvtqCyl7TCKVVAmBw=;
        b=zTRp+sca5kv7Ii3UsP1Jv2frkMPiTFJ6UZ2h09vR9hiG2XVdRJnLpgF3hHbZGNdS6e
         KQqPSTGTdIeAwdbXAIvADZTAgqzZ8bTY9iN/U+jvagHWti5N/9uL9R5dQkPLzLgpHK5b
         J2kiRSPuZr1nCwlryzetrv9i8pQI0J7PU3H2ToKxA5u8TPqFHDbN8Olb1fNgEayvIAuM
         DqLmSpFWUrhbONvTwFGSmnad+AaJRdmlR13AbaihFJVN1M+YGMyhNN75EOJQ/r7JsraW
         bmIGKS4YDhWBE4PQAisGjQt4b+uHjBQcV/bCTur4e0d/sDNOIwGd2dI4FTnX5sKD6tmV
         S1gw==
X-Gm-Message-State: AOAM5336grwEXgMj9Y+atrt8rqj+Dn/FgM856ew/nHu3LezYIlS5fdhk
        3reHshq1TON1qNAeK0nakw==
X-Google-Smtp-Source: ABdhPJx24b680DkwCLg7OQiUAd6Fu1rngGBgr+3t7LTwV5jrOQ3Up0BSQcCoCG9PmVjlG40knsS6Xg==
X-Received: by 2002:a05:6808:1208:b0:2cf:48c1:bfb9 with SMTP id a8-20020a056808120800b002cf48c1bfb9mr15004632oil.15.1647056837728;
        Fri, 11 Mar 2022 19:47:17 -0800 (PST)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t7-20020a9d5907000000b005afa4058a4csm4543405oth.1.2022.03.11.19.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 19:47:16 -0800 (PST)
Received: (nullmailer pid 733348 invoked by uid 1000);
        Sat, 12 Mar 2022 03:47:14 -0000
Date:   Fri, 11 Mar 2022 21:47:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Christophe Branchereau <cbranchereau@gmail.com>
Cc:     linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org, Sam Ravnborg <sam@ravnborg.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>
Subject: Re: [PATCH v4 4/4] dt-bindings: display/panel: Add Leadtek
 ltk035c5444t
Message-ID: <YiwXwlFJgSKaBFqI@robh.at.kernel.org>
References: <20220311170240.173846-1-cbranchereau@gmail.com>
 <20220311170240.173846-5-cbranchereau@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220311170240.173846-5-cbranchereau@gmail.com>
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

On Fri, 11 Mar 2022 18:02:40 +0100, Christophe Branchereau wrote:
> Add binding for the leadtek ltk035c5444t, which is a 640x480
> mipi-dbi over spi / 24-bit RGB panel based on the newvision
> NV03052C chipset.
> 
> It is found in the Anbernic RG350M mips handheld.
> 
> Signed-off-by: Christophe Branchereau <cbranchereau@gmail.com>
> ---
>  .../display/panel/leadtek,ltk035c5444t.yaml   | 59 +++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/leadtek,ltk035c5444t.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
