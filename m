Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D42D4E5853
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 19:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245651AbiCWSYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 14:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231986AbiCWSYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 14:24:47 -0400
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F5C6583;
        Wed, 23 Mar 2022 11:23:16 -0700 (PDT)
Received: by mail-ot1-f50.google.com with SMTP id y3-20020a056830070300b005cd9c4d03feso1650776ots.3;
        Wed, 23 Mar 2022 11:23:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IBKbGB+pt9Zh8RRqE0uQmOCyVj+jNoLop9r8WmBsrLs=;
        b=jQhT3dywNQF2XrEWbDvv2rZzIN5rIQANM5xgcGFI4WztO97wuZZuDPvbxM0X9WEfvk
         UndBnS7sBLb6gnxL4Pl6NJaKV3qHhQemyk6HwzOZu4BqPQfU22MPdvbwtunt3NB+vMgz
         Beel3ELM5T+dlvkS7Ym6h2m6IX+x5I5VmNQlcAFXDD7RlD1qfqn0J3Opw0RKO08qqmVQ
         AGtUw5m84K69WEZCRg/Os4DnUjBcaNnNwOm8ssPkIx7i4Fw0k8X4Wpg9jKS/1A5O5hqM
         7Il1zN/2HKeUeTVhtOcF8N9UHuhpUfYKErRThgTpQGNAcN8YPSkqM0tDZ3gYPyxXyNb8
         r1EQ==
X-Gm-Message-State: AOAM533uVMioGV16AkmFhbREgh3sYR8WjOu1p9rQxrTohwut6i/U5yLu
        6BVAFWm/xxaBtR3JPzVr7w==
X-Google-Smtp-Source: ABdhPJzo/c5tb80wxEAYG/WuNLFuZWT7lHLuNXFR3TQzzebDK/VmeVlx4R7iB0ElQ9MwjuY0bCP4FA==
X-Received: by 2002:a9d:7751:0:b0:5b2:49ae:76c6 with SMTP id t17-20020a9d7751000000b005b249ae76c6mr588309otl.18.1648059795879;
        Wed, 23 Mar 2022 11:23:15 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k124-20020aca3d82000000b002ef4c5bb9dbsm267714oia.0.2022.03.23.11.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 11:23:15 -0700 (PDT)
Received: (nullmailer pid 205240 invoked by uid 1000);
        Wed, 23 Mar 2022 18:23:14 -0000
Date:   Wed, 23 Mar 2022 13:23:14 -0500
From:   Rob Herring <robh@kernel.org>
To:     Max Krummenacher <max.oss.09@gmail.com>
Cc:     Ariel D'Alessandro <ariel.dalessandro@collabora.com>,
        Lucas Stach <dev@lynxeye.de>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Tim Harvey <tharvey@gateworks.com>,
        Li Yang <leoyang.li@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        max.krummenacher@toradex.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Fabio Estevam <festevam@gmail.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 01/14] dt-bindings: arm: fsl: imx6dl-colibri: Drop
 dedicated v1.1 bindings
Message-ID: <YjtlkqKq7Yta0nv4@robh.at.kernel.org>
References: <20220314162958.40361-1-max.krummenacher@toradex.com>
 <20220314162958.40361-2-max.krummenacher@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220314162958.40361-2-max.krummenacher@toradex.com>
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

On Mon, 14 Mar 2022 17:29:45 +0100, Max Krummenacher wrote:
> The dedicated device tree for V1.1 modules has been dropped. Remove
> its bindings too.
> 
> Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
> ---
> 
>  Documentation/devicetree/bindings/arm/fsl.yaml | 8 --------
>  1 file changed, 8 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
