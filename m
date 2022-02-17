Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDC64BAD60
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 00:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiBQXsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 18:48:08 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:60742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiBQXsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 18:48:07 -0500
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47EFE2CE821;
        Thu, 17 Feb 2022 15:47:42 -0800 (PST)
Received: by mail-pg1-f170.google.com with SMTP id h125so6351273pgc.3;
        Thu, 17 Feb 2022 15:47:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M0cpps6fIOkrz70XNTnOiubUyvmOKMtcIh+3ek+Nhnc=;
        b=qTGw5PLygC6onAO6udjN6MLd2Qwt0B79c6BbOMx/aNe5WmBGPEqgPTnKwjjqBgn1v4
         WSkq+ccmXP4dDVhqp21fPyl5bwuftECsAO8ZVwpb67+YM4a/Px6oOEM/IWiwXQd8enY6
         moOJbGollQCBRtCqsnQ0Xr7bGuUusgwhpb58xTzBJqzv3qysTPri+QHhkaCj7oPxWPCx
         6DxoZB4XSmy900vOpmqCqe5AE81SXmVWvyPKuNEMVFd5Xs/WOq/OvdR2kPssCtas2Shv
         X9wggE1l9yyV4r5mzRMRfOXCflCEX5AkX8/0WTsjc9TzXwHuWIzaYwIGWsMWasilYKOS
         5sGg==
X-Gm-Message-State: AOAM5315OY7cyUqVuCxnYoQ35L8g1MN9GdqtujCsi4Xh67p2HXr+2t0s
        KFE1RMaUk8Warx2gh0z8CsOS85D3Rg==
X-Google-Smtp-Source: ABdhPJxRXAu4lWlnrSyMuVGGUIlIwZ78D9qKrd5IMvKHicwBT5UyQPvXTfjdsYdS0a6np8p0LN6ibA==
X-Received: by 2002:a92:3406:0:b0:2be:a7b8:4efb with SMTP id b6-20020a923406000000b002bea7b84efbmr3590748ila.67.1645141034281;
        Thu, 17 Feb 2022 15:37:14 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id o13sm2841220iou.3.2022.02.17.15.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 15:37:13 -0800 (PST)
Received: (nullmailer pid 3984027 invoked by uid 1000);
        Thu, 17 Feb 2022 23:37:11 -0000
Date:   Thu, 17 Feb 2022 17:37:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski@canonical.com,
        richard@nod.at, linux-mtd@lists.infradead.org,
        linus.walleij@linaro.org, vigneshr@ti.com,
        linux-arm-kernel@lists.infradead.org, miquel.raynal@bootlin.com
Subject: Re: [PATCH v3] dt-bindings: mtd: drop mtd/cortina,gemini-flash.txt
Message-ID: <Yg7cJzAsGo4pcb25@robh.at.kernel.org>
References: <20220211120842.3388592-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211120842.3388592-1-clabbe@baylibre.com>
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

On Fri, 11 Feb 2022 12:08:42 +0000, Corentin Labbe wrote:
> Drop mtd/cortina,gemini-flash.txt since it is nearly already handled by
> Documentation/devicetree/bindings/mtd/mtd-physmap.yaml.
> 
> We add jedec-flash to list of compatible because one board (gemini-dlink-dns-313.dts) needs it.
> See commit a10d862e585e ("ARM: dts: Fix the DNS-313 flash compatible")
> The flash on the DNS-313 needs to be probed as JEDEC, it does not conform to the common CFI standard.
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
> Change since v1
> - fixed typo in syscon
> 
> Change since v2
> - Added reason of adding jedec-flash
> 
>  .../bindings/mtd/cortina,gemini-flash.txt     | 24 -------------------
>  .../devicetree/bindings/mtd/mtd-physmap.yaml  | 18 +++++++++++++-
>  2 files changed, 17 insertions(+), 25 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mtd/cortina,gemini-flash.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
