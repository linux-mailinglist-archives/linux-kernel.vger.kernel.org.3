Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9BC64D6556
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 16:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236433AbiCKPyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 10:54:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350112AbiCKPw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 10:52:58 -0500
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFB21CCB27;
        Fri, 11 Mar 2022 07:51:22 -0800 (PST)
Received: by mail-oo1-f46.google.com with SMTP id r41-20020a4a966c000000b0031bf85a4124so11018115ooi.0;
        Fri, 11 Mar 2022 07:51:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hPWhM8gN2fHMMyrikld9pWWRJCFMx1eu3IDjtAq9vSg=;
        b=bLNnlcmx1yY6tkxKNV3LaAIdIQU6jPji20D8dn7YJwjQeTnClhMeCwfcrngDe9g69F
         IZ386x1tODjpNYj6U+UD5bWff7MPBv7Ex2zHVMTitHhJVxIKTFBspl/JBvlOYY+sDAa5
         hRU2PookygcbD38u6mURCI17Kt6IZtVZUPjrrUh9mJq5pSVtyBOeELPDw1SDZoQu5xkd
         RyRMHbSzFYXVgCtUWXzxg1YKQaeza+oeSiYnny8DRxfKeC78Ebcd1ZvKYbL4N5EQALpI
         sT0NoFkSn+YaHIQ1TCf07vllAmyaHKicS66Am3y/QjV66vVcxUW3Un5PiZBvmLMjKVIi
         oWPQ==
X-Gm-Message-State: AOAM5303M7LlIazYskOyALGS0S8ekEQNjxrO/wHliatRO9Rz6HO/N0aj
        kWiZ3Wp0lBx/dATHIht3NA==
X-Google-Smtp-Source: ABdhPJz2sr1dPO2TtCSOl0PyLmP0mZIX3n1FVaxV/vXDtF9QhVnqHd4tRPJROZ4bwmk+VGMkC8zkjw==
X-Received: by 2002:a05:6870:2318:b0:d9:a0fb:cec5 with SMTP id w24-20020a056870231800b000d9a0fbcec5mr11325663oao.77.1647013875390;
        Fri, 11 Mar 2022 07:51:15 -0800 (PST)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v10-20020a9d7d0a000000b005b229f99815sm3660710otn.80.2022.03.11.07.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 07:51:14 -0800 (PST)
Received: (nullmailer pid 3868129 invoked by uid 1000);
        Fri, 11 Mar 2022 15:51:13 -0000
Date:   Fri, 11 Mar 2022 09:51:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-mediatek@lists.infradead.org,
        Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>,
        hsinyi@chromium.org, Wim Van Sebroeck <wim@linux-watchdog.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/4] dt-bindings: arm: Add compatible for Mediatek
 MT8186
Message-ID: <Yitv8TKk8KJkVg9Y@robh.at.kernel.org>
References: <20220311130732.22706-1-allen-kh.cheng@mediatek.com>
 <20220311130732.22706-4-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220311130732.22706-4-allen-kh.cheng@mediatek.com>
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

On Fri, 11 Mar 2022 21:07:31 +0800, Allen-KH Cheng wrote:
> From: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
> 
> This commit adds dt-binding documentation for the Mediatek MT8186
> reference board.
> 
> Signed-off-by: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
> ---
>  Documentation/devicetree/bindings/arm/mediatek.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
