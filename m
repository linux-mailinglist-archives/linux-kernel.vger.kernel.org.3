Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16F7B4AE79A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 04:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234897AbiBIDIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 22:08:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235951AbiBIDFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 22:05:08 -0500
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83F4C03E942;
        Tue,  8 Feb 2022 19:04:02 -0800 (PST)
Received: by mail-oo1-f49.google.com with SMTP id u47-20020a4a9732000000b00316d0257de0so979692ooi.7;
        Tue, 08 Feb 2022 19:04:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9WxSx+PhSoNOK7Va3SOOiKpYlGJipFHoYDAnRzf0rEU=;
        b=yjPf7b7dMoATHvCrWRfCh26704ofnNBr0AtZM7MvdWX7LUFEeNk5rnn88EImE18SLq
         7E3GiCBCujeaODwkF/tNMsh2KvEtGKvnKHUcR1Go+BHmA7r9YkJXwxsuUiUsnkG1jADI
         oh6TOhokS9s/+i8zbu+qTt9wxDdDO8CU9X2IHVW1TarW1G3yPbsnqqZ78euLG5H2YgY/
         N3Fk9UGTsniHnSxVL1nKWRhOWK9vQhkIhT05lxdZ9nWntA7UvhZhomK63zXdyt6TKxpZ
         rMc+Fi5s8w/ADPqAJ3g0ZF/C7tMcifLU1LbxYP/vfWrIl8fTHB6EedCfnqjdu2dGsd7n
         ZmWg==
X-Gm-Message-State: AOAM533FmkjkyxUL11Xzk3FRe0lBBHhR3I2qCKPyZ6n3g0zirs2BySdS
        yW23En5V3d8kPVWuvYjhTg==
X-Google-Smtp-Source: ABdhPJxz2Kc/1R1MFOvpiJkeFhlo3yjJLGr1Vk/RpOOKjTnQ0snSdqTnlGoVchdxbZOKxx6quNK/dQ==
X-Received: by 2002:a05:6870:1010:: with SMTP id 16mr103247oai.281.1644375842063;
        Tue, 08 Feb 2022 19:04:02 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id a128sm6151603oob.17.2022.02.08.19.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 19:04:01 -0800 (PST)
Received: (nullmailer pid 3542310 invoked by uid 1000);
        Wed, 09 Feb 2022 03:04:00 -0000
Date:   Tue, 8 Feb 2022 21:04:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        linux-pm@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: thermal: samsung: convert to dtschema
Message-ID: <YgMvIIKqXygIHK4k@robh.at.kernel.org>
References: <20220122132554.65192-1-krzysztof.kozlowski@canonical.com>
 <20220122132554.65192-2-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220122132554.65192-2-krzysztof.kozlowski@canonical.com>
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

On Sat, 22 Jan 2022 14:25:53 +0100, Krzysztof Kozlowski wrote:
> Convert the Samsung Exynos SoC Thermal Management Unit bindings to DT
> schema format.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../bindings/thermal/exynos-thermal.txt       | 106 ----------
>  .../thermal/samsung,exynos-thermal.yaml       | 184 ++++++++++++++++++
>  2 files changed, 184 insertions(+), 106 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/thermal/exynos-thermal.txt
>  create mode 100644 Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
