Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9945570DF4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 01:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbiGKXJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 19:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbiGKXJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 19:09:03 -0400
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635DD23172;
        Mon, 11 Jul 2022 16:09:03 -0700 (PDT)
Received: by mail-il1-f169.google.com with SMTP id a20so3897514ilk.9;
        Mon, 11 Jul 2022 16:09:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Esny3LkF85JNW9zTHN7u+n4M88LU/ALgn7WC/LhVj9E=;
        b=jbTIh6i+o9J6W4rDgPYft+DGbrSuA2VFmxSB3Vcc59AvLnVXfOM8vOgIcOg0WTW0wF
         P1zpBiMqhTO0GEU6oCIZvCuWD4NQIYmap20u66WmVXWAa6S6QbaCahBZK6JmBkiXFrvy
         cx79TWcZ7oYwSDFcFLJ/6/4C15wsHjqGSx28prE6DPdg2OIQ6cHd5QdfcjOqsz8GpHD0
         f72CBxC3Q7RuLGdwjtknvoiI6YSAd5A5aJJc6kIyH6fE40bRud+kjeFSuXTwErLT37SS
         ySTjA7p0V1HvFGI8uWjy593cq7QEs6cEXR5/o6F6IcMMcwdIs1G/Y+3cBQwyADFcbmtf
         B98Q==
X-Gm-Message-State: AJIora9CHjkkc42JHxdVxm/jW1Xc8gUAZj0yT72cG5BR9FWtrz+iAxPK
        Oo9WnnKNuVjl4GtV9Jh0Mw==
X-Google-Smtp-Source: AGRyM1s5y8ZgGxtrbdQ/DZFSTnnUHa2DE04OhdsqCIX+T7smvOnyEr5stdEJB8VfnL77vsXLAT0y6w==
X-Received: by 2002:a05:6e02:1b01:b0:2dc:7472:a5d1 with SMTP id i1-20020a056e021b0100b002dc7472a5d1mr5462931ilv.62.1657580942544;
        Mon, 11 Jul 2022 16:09:02 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id t2-20020a92c902000000b002cc20b48163sm3191864ilp.3.2022.07.11.16.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 16:09:02 -0700 (PDT)
Received: (nullmailer pid 442504 invoked by uid 1000);
        Mon, 11 Jul 2022 23:09:01 -0000
Date:   Mon, 11 Jul 2022 17:09:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andy Yan <andyshrk@163.com>
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        heiko@sntech.de, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 2/3] dt-bindings: arm: rockchip: Add EAIDK-610
Message-ID: <20220711230901.GA442449-robh@kernel.org>
References: <20220709102902.2753851-1-andyshrk@163.com>
 <20220709103001.2753992-1-andyshrk@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220709103001.2753992-1-andyshrk@163.com>
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

On Sat, 09 Jul 2022 18:30:01 +0800, Andy Yan wrote:
> EAIDK-610 is a rk3399 based board from OPEN AI LAB
> and popularly used by university students.
> 
> Specification:
> - Rockchip RK3399
> - LPDDR3 4GB
> - TF sd scard slot
> - eMMC
> - AP6255 for WiFi + BT
> - Gigabit ethernet
> - HDMI out
> - 40 pin header
> - USB 2.0 x 2
> - USB 3.0 x 1
> - USB 3.0 Type-C x 1
> - 12V DC Power supply
> 
> Signed-off-by: Andy Yan <andyshrk@163.com>
> ---
> 
> (no changes since v1)
> 
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
