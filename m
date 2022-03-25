Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E46D94E78AF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 17:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359701AbiCYQK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 12:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356941AbiCYQK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 12:10:26 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A4F8EB5B;
        Fri, 25 Mar 2022 09:08:51 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id j83so8624030oih.6;
        Fri, 25 Mar 2022 09:08:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=9sA/f970KDSavuw4PIMPXAbVVLqXCkGAUp+7iPzZPx0=;
        b=F5Kww+vpGPn2WGhUyqmryKx++LUA78fIQwqkYXvzkTHbEtbHTft1Rj0hZzz8XayXXw
         eLb76lP5Vknj1dli1lrD+3DW5fmhT4Wi071Yuyqa7U8EHLGVdLcPrHwS1xq1wcZEkUE9
         93/o/Bkw+NnT/+irXOFDvLUTG1ETgSORPoRKlFmcUNTZrWrdzzPhxOqLAWuTctLQ+/Jg
         bImh+dJtzpVhMEVNf5ejGHXeYSKJ8g0bbKz6gcNUB82DRDMGGeCdjGHST/EoSoZn3x5W
         hQ9WIR9m/m6veiMPygwUdvlrVDo3HtGO1WjZN6XKovem3QunVdAvAINWkX6izKbc5py5
         jd+g==
X-Gm-Message-State: AOAM5306qQ8QGh3+t5kriqzPehdAUOzUiIhU0svWdemXhDMjv4x8+dgH
        WCw9QjkGCqi7h0/wbOxglQ==
X-Google-Smtp-Source: ABdhPJxF6ALjCXenejf52MCPlMm6FTUtmu7/0p4pfXpY9ef8Mc8C2iFjA8uk8ED3BfuODZKpfzHamQ==
X-Received: by 2002:a05:6808:1592:b0:2d9:fd1a:1a69 with SMTP id t18-20020a056808159200b002d9fd1a1a69mr10415399oiw.110.1648224530868;
        Fri, 25 Mar 2022 09:08:50 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y3-20020a056870e50300b000d9be6436f1sm2708398oag.29.2022.03.25.09.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 09:08:50 -0700 (PDT)
Received: (nullmailer pid 4188975 invoked by uid 1000);
        Fri, 25 Mar 2022 16:08:48 -0000
From:   Rob Herring <robh@kernel.org>
To:     Roger Quadros <rogerq@kernel.org>
Cc:     nm@ti.com, vigneshr@ti.com, miquel.raynal@bootlin.com,
        kishon@ti.com, krzk@kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, richard@nod.at
In-Reply-To: <20220325123707.22020-2-rogerq@kernel.org>
References: <20220325123707.22020-1-rogerq@kernel.org> <20220325123707.22020-2-rogerq@kernel.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: mtd: ti,elm: Convert to yaml
Date:   Fri, 25 Mar 2022 11:08:48 -0500
Message-Id: <1648224528.979879.4188974.nullmailer@robh.at.kernel.org>
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

On Fri, 25 Mar 2022 14:37:05 +0200, Roger Quadros wrote:
> Convert elm.txt to ti,elm.yaml.
> 
> hwmod framework use is deprecated for new platforms
> so mark it so.
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
>  Documentation/devicetree/bindings/mtd/elm.txt | 16 -------
>  .../devicetree/bindings/mtd/ti,elm.yaml       | 47 +++++++++++++++++++
>  2 files changed, 47 insertions(+), 16 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mtd/elm.txt
>  create mode 100644 Documentation/devicetree/bindings/mtd/ti,elm.yaml
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/1609419


elm@0: 'clock-names', 'clocks' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/am437x-cm-t43.dt.yaml
	arch/arm/boot/dts/am437x-gp-evm.dt.yaml
	arch/arm/boot/dts/am437x-idk-evm.dt.yaml
	arch/arm/boot/dts/am437x-sbc-t43.dt.yaml
	arch/arm/boot/dts/am437x-sk-evm.dt.yaml
	arch/arm/boot/dts/am43x-epos-evm.dt.yaml

