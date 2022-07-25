Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 940E65807BC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 00:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237648AbiGYWpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 18:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237610AbiGYWou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 18:44:50 -0400
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0BBF2611C;
        Mon, 25 Jul 2022 15:43:38 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-10d8880d055so16617160fac.8;
        Mon, 25 Jul 2022 15:43:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=414OPFPqm7yiKu0XCIZIVb72Nf4LXIt1k0i8OrjquNM=;
        b=zqXQz2+Xql+I20zJJzdZeY1qMy0hR3UZ0kbxAcPIU+X6HyIGANlRem1dyhuiU0g8+Q
         /4mXSu10Mx/JcH1QZ0G5g+bP/Ouz7QImf2xHIMUm7avERpupO+PWrJ2t5S7dRTp1ySdM
         mFQEpAhva4XwLwKZpPyFRnbOzV7TZwFlLnVwSiUPS/y6SeGje1O6B816SS9G9mD2ET8l
         7F/DUNXRqzepRphGdTcecuzmiDrR4PiezQsZaSR5yFUibGncbsc7PD6ftFerQIabJ52A
         Q53Je+xM79k9veCW0juTjjhPitaGu+PrfGgjM3Ge1qlc4shwCl3/m52Zj3lRsmv7UK0A
         6aTA==
X-Gm-Message-State: AJIora+GiGVi/Sh/pIbtMbf6bVmKK4GRWrs4zmEGoZ61Qrt2fgL0WAEh
        V2ZgonpgEqedU19tMQHJYA==
X-Google-Smtp-Source: AGRyM1sbb07YDLb2nNG3D5ni7t9o/Imo9DVsOQtpEXAJ+WQHpVXMdKmFq3rpH6uepyz4rLi1sRM1gQ==
X-Received: by 2002:a05:6870:3399:b0:10d:5b33:566f with SMTP id w25-20020a056870339900b0010d5b33566fmr7457280oae.266.1658788997533;
        Mon, 25 Jul 2022 15:43:17 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id cm36-20020a056870b62400b000fb2aa6eef2sm6763107oab.32.2022.07.25.15.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 15:43:17 -0700 (PDT)
Received: (nullmailer pid 2883124 invoked by uid 1000);
        Mon, 25 Jul 2022 22:43:15 -0000
Date:   Mon, 25 Jul 2022 16:43:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Runyang Chen <Runyang.Chen@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Runyang Chen <runyang.chen@mediatek.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>, nfraprado@collabora.com,
        devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        angelogioacchino.delregno@collabora.com
Subject: Re: [PATCH] [1/3] dt-bindings: watchdog: Add compatible for MediaTek
 MT8188
Message-ID: <20220725224315.GA2883086-robh@kernel.org>
References: <20220722072316.582-1-Runyang.Chen@mediatek.com>
 <20220722072316.582-2-Runyang.Chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722072316.582-2-Runyang.Chen@mediatek.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jul 2022 15:23:14 +0800, Runyang Chen wrote:
> From: Runyang Chen <runyang.chen@mediatek.com>
> 
> Add dt-binding documentation of watchdog for MediaTek MT8188 SoC
> 
> Signed-off-by: Runyang Chen <runyang.chen@mediatek.com>
> ---
>  Documentation/devicetree/bindings/watchdog/mtk-wdt.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
