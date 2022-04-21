Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4931050AAB1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 23:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441916AbiDUVYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 17:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240192AbiDUVYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 17:24:16 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5205C4BFE3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 14:21:25 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id e189so6953169oia.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 14:21:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kCJdiFVySz3ZBRZQEgE+lVkDnd9MX7+W0ULxHOPXzMU=;
        b=ksXYuWxK7LJFIAH2oo4QnU1NFaiHEd6xxrQhfIzmlMURFMHMRelmnM4jDduWc5U8B3
         sH7F214R7B3T6Ow6ccnoPgUJDPAwtd4XRnSCr2Innxhzfh/mA+99o/YJvDRGpDFRK/m3
         wDOi01ToZdjY2RQbI4BZra9YMhFoxoKKsSWZE9RvcSBE2lAUCFBQYTKWBeTzWUBfMCka
         C/1RCnw3buu0vcfLPOAEhOglefABy2D5YpGyOVJz8UfjKlTMX+WMFL7Fsl9TCPpg4Z5d
         6HCDKO5Q3srqztZdAkMkSFf+qx9fe9ENWJZeNbcGdYYg7YlKZpSL4gW5HnjYW9ABAbgF
         9+dg==
X-Gm-Message-State: AOAM532RO1XfIvQSd00yGQ+j9xOC9z0aJBvd5epbvZRTTIcEpWdKyg0l
        iXRdzJeKpWtSgLjcpWTkvfWL75ddvA==
X-Google-Smtp-Source: ABdhPJwhfeGFzzUge0j3Sk5rX41y12JDOFWnU6XMEigRK/9G2DBGOowqlmfresqtc9kB3YLSYXGyaA==
X-Received: by 2002:a05:6808:1189:b0:322:3293:4b30 with SMTP id j9-20020a056808118900b0032232934b30mr728919oil.277.1650576084612;
        Thu, 21 Apr 2022 14:21:24 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id oq12-20020a0568707d8c00b000e2deaf9a65sm22415oab.40.2022.04.21.14.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 14:21:24 -0700 (PDT)
Received: (nullmailer pid 127292 invoked by uid 1000);
        Thu, 21 Apr 2022 21:21:23 -0000
Date:   Thu, 21 Apr 2022 16:21:23 -0500
From:   Rob Herring <robh@kernel.org>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     matthias.bgg@gmail.com, lee.jones@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Subject: Re: [PATCH resend] dt-bindings: mfd: mediatek: Add bindings for
 MT6360 PMIC
Message-ID: <YmHK02g1pC19Oyh6@robh.at.kernel.org>
References: <1608779989-9641-1-git-send-email-gene.chen.richtek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1608779989-9641-1-git-send-email-gene.chen.richtek@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 24, 2020 at 11:19:49AM +0800, Gene Chen wrote:
> From: Gene Chen <gene_chen@richtek.com>
> 
> Add bindings for MT6360 PMIC
> 
> Signed-off-by: Gene Chen <gene_chen@richtek.com>
> ---
>  Documentation/devicetree/bindings/mfd/mt6360.yaml | 69 +++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/mt6360.yaml

Applying this old patch as "mediatek,mt6360" is used, but not documented 
(causing warnings). Please send a follow-up patch adding the child 
nodes as promised.

Rob
