Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C04984ACBEA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 23:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244039AbiBGWPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 17:15:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233534AbiBGWPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 17:15:32 -0500
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05FAC061355;
        Mon,  7 Feb 2022 14:15:31 -0800 (PST)
Received: by mail-oi1-f177.google.com with SMTP id ay7so4670180oib.8;
        Mon, 07 Feb 2022 14:15:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0PV4HeoPHyKxyJK+Cen0YeHP4HwTJe1tl9BLVocuArQ=;
        b=BP3qL54Ot8LPVkGJWJW/ckqd4f7q2vzBieqdGWQlMxP+OalSdgxl9yJ9sVxK0yJW2j
         G5whBilInYghD/dfKVy6sZIxPUd75TANVuBXVEnyjPOjJRrhXVQoRV2jlowr14wi5R+X
         5B19fPEMhzLVnlrZ17ijzDgBc5Db1z08mjE6ETlzysQ6RUHcS1YmlT+Y8H369E6FRl79
         BfFSE798SHEz3x6GoSwFUunX5er+dEq5365JR2buwUIttrd42/3VDJKkCyLiHxsWqXQK
         j+S+xhVjNeE+an93xfrcaPYCfsJzCTF+pm6X1VEpUtd/lAlCPjNH++JeztlPs/Stb9ZJ
         Q/IQ==
X-Gm-Message-State: AOAM533CW3MlO/Do/F8uYxQQ+0EKL5+l0a/84f+nUWqkeeh5nLF0FEiq
        rGhRYMo/644igIAgkWU0NA==
X-Google-Smtp-Source: ABdhPJz9aWY+u9C0GkaHH8DOjPZWltUVHGIUnCtuIieVh5g9dlpzaor9gMSlbvw6WHRZFJ3bfr0Btg==
X-Received: by 2002:a05:6808:2386:: with SMTP id bp6mr492103oib.152.1644272131239;
        Mon, 07 Feb 2022 14:15:31 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id t31sm4902258oaa.9.2022.02.07.14.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 14:15:30 -0800 (PST)
Received: (nullmailer pid 1022275 invoked by uid 1000);
        Mon, 07 Feb 2022 22:15:28 -0000
Date:   Mon, 7 Feb 2022 16:15:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Qianggui Song <qianggui.song@amlogic.com>
Cc:     Marc Zyngier <maz@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: interrupt-controller: New binding
 for Meson-S4 SoCs
Message-ID: <YgGaAH2+xiNmTjIR@robh.at.kernel.org>
References: <20220119070809.15563-1-qianggui.song@amlogic.com>
 <20220119070809.15563-2-qianggui.song@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220119070809.15563-2-qianggui.song@amlogic.com>
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

On Wed, 19 Jan 2022 15:08:06 +0800, Qianggui Song wrote:
> Update dt-binding document for GPIO interrupt controller of Meson-S4 SoCs
> 
> Signed-off-by: Qianggui Song <qianggui.song@amlogic.com>
> ---
>  .../bindings/interrupt-controller/amlogic,meson-gpio-intc.txt    | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
