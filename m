Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 934CA567873
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 22:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbiGEUbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 16:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbiGEUbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 16:31:04 -0400
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3F51C934;
        Tue,  5 Jul 2022 13:31:04 -0700 (PDT)
Received: by mail-il1-f170.google.com with SMTP id p18so2920755ilm.4;
        Tue, 05 Jul 2022 13:31:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GBoKp7b5qnasD5EVBeBmBvPwuf7kIJMBjmwIRdc6aOk=;
        b=5nSwZKlIbHLW+zBMRhjnlKCK4uejTffnoQwAZfHOem2aYlMjgy8A51lS+mbcbvqHTy
         uWXAAIeNwb6SmsuWxYRwWWpJ1UCghGbbL6/kXYkCQGxfOBiy+i5tghyZnl6+Stm4CjOe
         r635EefqvrC/Lc6aHEk+fsM0pTeFNmQXmf3ZTKjZTxVsyyKLVQ+G935LPlW10fc/iXPE
         P8lpKGO8XKuW71J3SJd9hq+OsKzQ9z1EWGFVVTgYTBd/hSCFd1xMQYICevMwHrv0uBaJ
         f3uFDBI20IgiNgCn3co+iUBBhPhcqO+/mOTaqLASuC9U+41YImdcB4UK5gaQ+lbi54aW
         oD6w==
X-Gm-Message-State: AJIora/V3TVCeDUyG8J+Q4WAQaOrh+rsTUQQcXRyTok2BKoeijgDUXX0
        vgHU6pnzZZfdrlToOnL9hw==
X-Google-Smtp-Source: AGRyM1sv62Rsxnc0NMQUy/zTtbvNFhaXFxAjV8+DiQnB+mrYMvYYoP3LuKlavOxxZohXg22LXKkOrw==
X-Received: by 2002:a05:6e02:1a87:b0:2db:f29f:9c93 with SMTP id k7-20020a056e021a8700b002dbf29f9c93mr13241468ilv.232.1657053063287;
        Tue, 05 Jul 2022 13:31:03 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id z18-20020a92bf12000000b002d11c598e12sm13636718ilh.61.2022.07.05.13.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 13:31:02 -0700 (PDT)
Received: (nullmailer pid 2573868 invoked by uid 1000);
        Tue, 05 Jul 2022 20:31:01 -0000
Date:   Tue, 5 Jul 2022 14:31:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        rtanwar@maxlinear.com, miquel.raynal@bootlin.com, richard@nod.at,
        tlanger@maxlinear.com, vigneshr@ti.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/8] dt-bindings: mtd: intel: lgm-nand: Fix compatible
 string
Message-ID: <20220705203101.GA2573805-robh@kernel.org>
References: <20220702231227.1579176-1-martin.blumenstingl@googlemail.com>
 <20220702231227.1579176-2-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220702231227.1579176-2-martin.blumenstingl@googlemail.com>
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

On Sun, 03 Jul 2022 01:12:20 +0200, Martin Blumenstingl wrote:
> The driver which was added at the same time as the dt-bindings uses the
> compatible string "intel,lgm-ebunand". Use the same compatible string
> also in the dt-bindings and rename the bindings file accordingly.
> 
> Fixes: 2f9cea8eae44f5 ("dt-bindings: mtd: Add Nand Flash Controller support for Intel LGM SoC")
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  .../mtd/{intel,lgm-nand.yaml => intel,lgm-ebunand.yaml}     | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>  rename Documentation/devicetree/bindings/mtd/{intel,lgm-nand.yaml => intel,lgm-ebunand.yaml} (92%)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
