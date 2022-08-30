Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 144165A6EF6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 23:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbiH3VNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 17:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiH3VNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 17:13:32 -0400
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3157486C09;
        Tue, 30 Aug 2022 14:13:31 -0700 (PDT)
Received: by mail-ot1-f49.google.com with SMTP id t8-20020a9d5908000000b0063b41908168so921117oth.8;
        Tue, 30 Aug 2022 14:13:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=byDOrU2vKaQRF5W/gJnDjybU7ear3HV0O8mJgPS799M=;
        b=j8OYXpF33TnlkYaXaJ5nJkn7wqyGk7VZptgBUAv4WDt/kbjrv/gUduj64Dqqjf10lq
         f+swQSgcriqYhw5kC00mI2k04YuqZkre0M7TYkwh5BcM94cnvPfA2f0fK2UrLIlsnYQo
         6y8xiKTuVu57ClnRVdUs2eGKeb/8LoXKhrhiUmfYHsLFC9/5rNmrL3zOQiR7Jpq7uzbl
         paZcNUDZIdXZgKNXHhqtLrC/ae759Ie1To69YZuAFys5Ug7xAZTfadxkLaHEwFDL562t
         5dpd9RL7JAinMhZp0TJp9rkd5KUgUq51vp1LB7HXpOy1w2PeZC0WGh/EEsW+fyqc6cZt
         WNhw==
X-Gm-Message-State: ACgBeo1rsNonU8P8aIKV4B9EEzKKQUmETJwY2WaW/JCYzkIg0gQF+8cK
        sG49yjmdLMFLerVk3n8P3UbxbqJoFw==
X-Google-Smtp-Source: AA6agR7/x6mk00s04aDRrxzP2z5QrzMD+nm+UxNGLFXZ0BTEWK0r2I5rTZb8OSgyF4dYcGmD4odGLA==
X-Received: by 2002:a05:6830:9c6:b0:60c:7352:2c03 with SMTP id y6-20020a05683009c600b0060c73522c03mr8958723ott.138.1661894010457;
        Tue, 30 Aug 2022 14:13:30 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b35-20020a056870392300b0011f400edb17sm1757857oap.4.2022.08.30.14.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 14:13:29 -0700 (PDT)
Received: (nullmailer pid 2080829 invoked by uid 1000);
        Tue, 30 Aug 2022 21:13:28 -0000
Date:   Tue, 30 Aug 2022 16:13:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 4/5] clk: imx6sll: add proper spdx license identifier
Message-ID: <20220830211328.GA2080761-robh@kernel.org>
References: <20220826192252.794651-1-marcel@ziswiler.com>
 <20220826192252.794651-5-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220826192252.794651-5-marcel@ziswiler.com>
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

On Fri, 26 Aug 2022 21:22:51 +0200, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> This fixes the following error:
> 
> include/dt-bindings/clock/imx6sll-clock.h:1: warning: Improper SPDX
>  comment style for 'include/dt-bindings/clock/imx6sll-clock.h', please
>  use '/*' instead
> include/dt-bindings/clock/imx6sll-clock.h:1: warning: Missing or
>  malformed SPDX-License-Identifier tag in line 1
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> ---
> 
>  include/dt-bindings/clock/imx6sll-clock.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
