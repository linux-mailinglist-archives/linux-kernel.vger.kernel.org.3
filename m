Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3884B71A8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239663AbiBOPXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 10:23:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbiBOPXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 10:23:07 -0500
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1838A6ED;
        Tue, 15 Feb 2022 07:22:55 -0800 (PST)
Received: by mail-io1-f50.google.com with SMTP id h5so512007ioj.3;
        Tue, 15 Feb 2022 07:22:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=9J4rDa9s4wmqYQBOVueBwn1a76vdE1euAb2VZB7wcmc=;
        b=L/hkRf5XzSp29Ns6yINvxtgTJ/3cmfF9QhlZHfEgHHqG6lIP2ELC+IWQUcVmccaT5A
         pAlZ1Sk8NidzZJTrfg1vQuHtzwOB2ihl2J4otPyzsGCNEXFq7wQClgpOCH5FbMkOORbs
         a3eh3OwTu6HKcWk3w+RKifj+89W7ZXd94GCJ9EXnSLyJeZ9k5YQGcaqY+4XyORrls5DM
         BP0ZfulAGcqJSbbIn0gRZBZORNwMDax65/VhFpjQ2IgJ+ebVZEn7X8V2J/n/soeSFczo
         tWqlB18OYzqlxoN4L/rxVRk7d6Ad7EN6c/apVAmiQ4hhPnc4xmPorzxo0rYUBvyhXljB
         6Zrg==
X-Gm-Message-State: AOAM530NDyD77V1SshvUHpNeVvg4XJAQn80GjA/B6pIG/7vhWpEPYt+l
        HM8WbPF1MUUbYhDvmavKGw==
X-Google-Smtp-Source: ABdhPJwWfDOErqZzCQjf54gJc9fHJ8Up5VXN1xQ8G+SwjgqvNHngDAkHgslyzJpOfgzzODVEJusx8g==
X-Received: by 2002:a6b:5a07:: with SMTP id o7mr2716438iob.9.1644938575136;
        Tue, 15 Feb 2022 07:22:55 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id m12sm23475626iow.54.2022.02.15.07.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 07:22:53 -0800 (PST)
Received: (nullmailer pid 3450866 invoked by uid 1000);
        Tue, 15 Feb 2022 15:22:45 -0000
From:   Rob Herring <robh@kernel.org>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     linus.walleij@linaro.org, richard@nod.at,
        linux-arm-kernel@lists.infradead.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski@canonical.com, miquel.raynal@bootlin.com,
        vigneshr@ti.com, devicetree@vger.kernel.org, robh+dt@kernel.org
In-Reply-To: <20220211120842.3388592-1-clabbe@baylibre.com>
References: <20220211120842.3388592-1-clabbe@baylibre.com>
Subject: Re: [PATCH v3] dt-bindings: mtd: drop mtd/cortina,gemini-flash.txt
Date:   Tue, 15 Feb 2022 09:22:45 -0600
Message-Id: <1644938565.093416.3450865.nullmailer@robh.at.kernel.org>
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

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/1591614


flash@0: compatible: 'oneOf' conditional failed, one must be fixed:
	arch/arm/boot/dts/r8a73a4-ape6evm.dt.yaml

nor@20000000: compatible: 'oneOf' conditional failed, one must be fixed:
	arch/arm/boot/dts/bcm53340-ubnt-unifi-switch8.dt.yaml

