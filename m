Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E64DD54BCB9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 23:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351655AbiFNVYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 17:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiFNVX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 17:23:58 -0400
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6180850B1A;
        Tue, 14 Jun 2022 14:23:58 -0700 (PDT)
Received: by mail-il1-f181.google.com with SMTP id y17so7514809ilj.11;
        Tue, 14 Jun 2022 14:23:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Hq5jY2gZQ+GI4RJwV7jJ4smdcAMW3q3lL2AtnS6Hr7A=;
        b=xpZ/ZllV883e9lyZUMxfbPyL/DU9NM5l/wa75DZf0QLiVI2tRnaPl0Y96fqHlbExA1
         u2LWd5kv++5BmBbxGG2ohXPUixpnH0kza4Ez3+xgNgKuJGTnEyL3oC5IdC6f1DplOXd0
         ammMoTcfqs4NeUv//7dq5p7iy1Xw4G11gDs6/MCdPzBUP15XuLY18D7dr0bg0MNq7Ym6
         PrGkT1D/3vdmpJ4KJMI7IO6SCAio9oBbA3WIUxFWXD0aqUG9TNpWmdi5kTQ3JPpVFq22
         Ac2+Z3PT1TaDbbk3v5P2WZzpeFBBdX5v7sLBPJ73OQ1gqhJANw5M2bgQntwb96fL9+Z+
         DUoQ==
X-Gm-Message-State: AJIora9Bim/KFgiFe3PmKRPxkT4ai3wJIKUH2u79GkHwMXP/3t2E4qhM
        igrrLS9vlXFjeqlXwCm4sg==
X-Google-Smtp-Source: AGRyM1vBQ1BJvuEDDUj83sBOu4PDH8zuDSITX92kjRdsWUsWXDvrdpWo9TH8mDBVexF8Rz60CmexbA==
X-Received: by 2002:a05:6e02:1d8a:b0:2d3:cfe9:4d89 with SMTP id h10-20020a056e021d8a00b002d3cfe94d89mr4349873ila.322.1655241837584;
        Tue, 14 Jun 2022 14:23:57 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id x17-20020a029091000000b0033195fabca4sm5309440jaf.175.2022.06.14.14.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 14:23:57 -0700 (PDT)
Received: (nullmailer pid 2656667 invoked by uid 1000);
        Tue, 14 Jun 2022 21:23:54 -0000
Date:   Tue, 14 Jun 2022 15:23:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Brad Larson <brad@pensando.io>
Cc:     p.yadav@ti.com, ulf.hansson@linaro.org, robh+dt@kernel.org,
        lee.jones@linaro.org, andy.shevchenko@gmail.com,
        p.zabel@pengutronix.de, yamada.masahiro@socionext.com,
        alcooperx@gmail.com, devicetree@vger.kernel.org, blarson@amd.com,
        arnd@arndb.de, piotrs@cadence.com, rdunlap@infradead.org,
        brijeshkumar.singh@amd.com, suravee.suthikulpanit@amd.com,
        linux-mmc@vger.kernel.org, gsomlo@gmail.com,
        thomas.lendacky@amd.com, linux-arm-kernel@lists.infradead.org,
        will@kernel.org, fancer.lancer@gmail.com, gerg@linux-m68k.org,
        catalin.marinas@arm.com, krzysztof.kozlowski+dt@linaro.org,
        samuel@sholland.org, krzk@kernel.org, broonie@kernel.org,
        adrian.hunter@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 04/15] dt-bindings: spi: dw: Add AMD Pensando Elba SoC
 SPI Controller bindings
Message-ID: <20220614212354.GA2656516-robh@kernel.org>
References: <20220613195658.5607-1-brad@pensando.io>
 <20220613195658.5607-5-brad@pensando.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613195658.5607-5-brad@pensando.io>
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

On Mon, 13 Jun 2022 12:56:47 -0700, Brad Larson wrote:
> From: Brad Larson <blarson@amd.com>
> 
> The AMD Pensando Elba SoC has integrated the DW APB SPI Controller
> 
> Signed-off-by: Brad Larson <blarson@amd.com>
> ---
>  Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
