Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC04517930
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 23:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387755AbiEBVjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 17:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387727AbiEBVjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 17:39:03 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E728564D6;
        Mon,  2 May 2022 14:35:33 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-e9027efe6aso15505227fac.10;
        Mon, 02 May 2022 14:35:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NT3TCOHAgj+vdyt2sEgp7l3FsjbmObj02EKHyM2g53k=;
        b=K3X14Ia8+PYsae57kHz1c4CtmWvE/7KuGZNpCzxDa0x4Y8jmL3R7Bd0wSAcsZcO3qj
         68ygmRvb5xf89QekgX8wQ1r+IuiGgubrU1ZaerPcWIRsauzQ88AFXfjDzCcJQ+oU9i9Z
         qB0+sZDyigrBqh5vnwtNYnAr6FZzGQEtamiYShhsUF1B3/LkWw1UHtbccDLBNQJk2jjX
         dyxbZI14g35kN3OfB+FQZ1kGLwipH2t43doeTWwOJ3QmSV+G99E2ssWcNQJ7G5+hJUoU
         Rzr8ondXC/rWE5JF4RRuM2x/7rhDXHWR3YMqO3yNDpHnzGV2cKseLB6QynKRrz6bq+bO
         O5TQ==
X-Gm-Message-State: AOAM5307AqEEJeHBjQHVWztJKOOf88NFOR/TO71OTvsip99K4PilAKWp
        jNXdmqYtpGMsNXrA0Fp0ag==
X-Google-Smtp-Source: ABdhPJylq3vUy3dAJvMPmpgnVj4BH7chXBbaFIQei9aSlly/yv1cZ/9zNHEEasLZ4ywd53cUfQWseQ==
X-Received: by 2002:a05:6870:648d:b0:ec:b32d:3e1b with SMTP id cz13-20020a056870648d00b000ecb32d3e1bmr509121oab.283.1651527333236;
        Mon, 02 May 2022 14:35:33 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w5-20020a9d70c5000000b0060603221268sm3260916otj.56.2022.05.02.14.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 14:35:32 -0700 (PDT)
Received: (nullmailer pid 1799513 invoked by uid 1000);
        Mon, 02 May 2022 21:35:31 -0000
Date:   Mon, 2 May 2022 16:35:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     icenowy@outlook.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Samuel Holland <samuel@sholland.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Icenowy Zheng <icenowy@aosc.io>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/12] dt-bindings: arm: sunxi: add compatible strings
 for Sipeed MaixSense
Message-ID: <YnBOoxkKdKLwErxY@robh.at.kernel.org>
References: <20220422140902.1058101-1-icenowy@aosc.io>
 <BYAPR20MB24723FAF3BE29BB7CD8341CCBCF79@BYAPR20MB2472.namprd20.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR20MB24723FAF3BE29BB7CD8341CCBCF79@BYAPR20MB2472.namprd20.prod.outlook.com>
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

On Fri, 22 Apr 2022 23:41:12 +0800, icenowy@outlook.com wrote:
> From: Icenowy Zheng <icenowy@aosc.io>
> 
> Sipeed MaixSense is an Allwinner R329 development kit based on Maix IIA
> SoM.
> 
> Add compatible strings for it.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  Documentation/devicetree/bindings/arm/sunxi.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
