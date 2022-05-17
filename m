Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3CA5295C0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 02:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233643AbiEQAEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 20:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350544AbiEQAEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 20:04:46 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3CD40A3A;
        Mon, 16 May 2022 17:04:44 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-f17f1acffeso9765005fac.4;
        Mon, 16 May 2022 17:04:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ktn+GEsr0zrnXe8qHlhiFLP6gFGk7mzfKtzVqt6Honk=;
        b=dBtL9+DyydL18LBre4CweksmGN9PLYX2ygPPVirzkeu9V8/CKseMhtH4d1EYTAKqxv
         09vvs+nrDVW9SdL/4G5a5x4pTqph7LWV7TTc9K5TKRRbN06c8eNy3n4mj2SqMIEBvu0q
         DGlVwNk+AA+i/JJErpRMryqsKnF5+NuawczpgQG2+LaMHftAJe2Lt0NQQgl7HntEiCsJ
         Q2fh6iPi6pcKulUIxgK/QUdzGHCLibhuP8VVtnkQIHxTEiiUKFWqnoJd3g87X64DFg6g
         2vilfRvRivnk7U/YLidIx/OSalyMehR/Dxt5/6Vz/oZFcptzvWtqP1tmddT+fsuPS/OT
         8Bzw==
X-Gm-Message-State: AOAM533ndxKxgahK5K5w00fFViPquHoova8vSCpA/o0tJFe/5SCMQFoM
        02kiNZF+2SvY86VIRbgBPg==
X-Google-Smtp-Source: ABdhPJw5Ykn7mqpJerlSm9oss4tkoO30Jq+bqyH2k5jfopC/R6Ike018MB1HEEeakCVeRnWBTSTLuw==
X-Received: by 2002:a05:6870:a1a0:b0:e2:9331:cc30 with SMTP id a32-20020a056870a1a000b000e29331cc30mr10845418oaf.155.1652745883833;
        Mon, 16 May 2022 17:04:43 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z10-20020a056870738a00b000e686d13890sm6112082oam.42.2022.05.16.17.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 17:04:43 -0700 (PDT)
Received: (nullmailer pid 3608251 invoked by uid 1000);
        Tue, 17 May 2022 00:04:42 -0000
Date:   Mon, 16 May 2022 19:04:42 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     linux-rockchip@lists.infradead.org, linux-clk@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-gpio@vger.kernel.org, kernel@collabora.com,
        linux-mmc@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org, kernel@lists.collabora.co.uk,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 17/21] dt-bindings: gpio: rockchip: add gpio-ranges
Message-ID: <20220517000442.GA3608183-robh@kernel.org>
References: <20220504213251.264819-1-sebastian.reichel@collabora.com>
 <20220504213251.264819-18-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504213251.264819-18-sebastian.reichel@collabora.com>
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

On Wed, 04 May 2022 23:32:47 +0200, Sebastian Reichel wrote:
> Allow usage of gpio-ranges with the rockchip gpio controller. The driver
> already had support for this since it has been added to the mainline kernel
> in the first place.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  Documentation/devicetree/bindings/gpio/rockchip,gpio-bank.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
