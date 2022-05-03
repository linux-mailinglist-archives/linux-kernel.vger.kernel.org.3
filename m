Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3223519063
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 23:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243067AbiECVqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 17:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbiECVqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 17:46:34 -0400
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C4F24968;
        Tue,  3 May 2022 14:43:01 -0700 (PDT)
Received: by mail-ot1-f45.google.com with SMTP id y14-20020a9d460e000000b00605ee347da1so9960425ote.8;
        Tue, 03 May 2022 14:43:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7Hu0gsr8Y6PWp2FP45L7+RGtOMCVNeN3hbCuvJ2usXo=;
        b=S1uvi1+HzU2UxJgwdW039AXe8ZKhsF1uBkThEaKk+N+xLyda4IwzUiGo2jDapYR4V/
         Z9sChaH3+fyFGeqt+ajhSFiGxsdzcWwRvO4Tfk16f16gDoz3+LjqJ1dBstECk7O5RnEZ
         NL81ZmWih+fRj6GM7ZjC/BVhmCqIizljduaUZ2Leky7H4XiEDbP+gpBLXfCN085Zj3S6
         rWcZ77tEC7XYYJDDPWRp07bfBUickLoT2WtGmKyKWoueFo3GN7gOywuPA7Vw5m0kv4fQ
         24FNRUyqSlVet9J2hu4n55jmFn66KNYV3sRUuQVnuQmZ23oxY6nCBxK7P9SIXgr9i9sq
         M6zg==
X-Gm-Message-State: AOAM532W01jeXoUGHVNNjH7/cUljsvdwYCVool03vUWrBv1o7oXwweb3
        eeQtKJqDO0m9aB8JTPPSvQ==
X-Google-Smtp-Source: ABdhPJz4N4R764kPo+v++/Y+BmcZqqzXF0v6pZHNpMo6V//OxOtU550cg4XA4nzAnBjeZQ2Nv/molw==
X-Received: by 2002:a9d:1714:0:b0:606:eaf:fa95 with SMTP id i20-20020a9d1714000000b006060eaffa95mr5217807ota.180.1651614180748;
        Tue, 03 May 2022 14:43:00 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bg1-20020a056808178100b00326414c1bb7sm686470oib.35.2022.05.03.14.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 14:43:00 -0700 (PDT)
Received: (nullmailer pid 82356 invoked by uid 1000);
        Tue, 03 May 2022 21:42:58 -0000
Date:   Tue, 3 May 2022 16:42:58 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jesse Taube <mr.bossman075@gmail.com>
Cc:     sboyd@kernel.org, linux-clk@vger.kernel.org,
        daniel.lezcano@linaro.org, leoyang.li@nxp.com,
        giulio.benetti@benettiengineering.com, festevam@gmail.com,
        clin@suse.com, s.hauer@pengutronix.de, linux-imx@nxp.com,
        stefan@agner.ch, tharvey@gateworks.com,
        linux-arm-kernel@lists.infradead.org, aisheng.dong@nxp.com,
        robh+dt@kernel.org, tglx@linutronix.de, abel.vesa@nxp.com,
        sebastian.reichel@collabora.com, dev@lynxeye.de,
        Mr.Bossman075@gmail.com, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, olof@lixom.net, mturquette@baylibre.com,
        linux@armlinux.org.uk, linus.walleij@linaro.org,
        cniedermaier@dh-electronics.com, soc@kernel.org,
        linux-gpio@vger.kernel.org, shawnguo@kernel.org,
        marcel.ziswiler@toradex.com, arnd@arndb.de,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 03/15] dt-bindings: gpio: fsl-imx-gpio: Add i.MXRT
 compatibles
Message-ID: <YnGh4oZOm9eHO9z2@robh.at.kernel.org>
References: <20220428214838.1040278-1-Mr.Bossman075@gmail.com>
 <20220428214838.1040278-4-Mr.Bossman075@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220428214838.1040278-4-Mr.Bossman075@gmail.com>
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

On Thu, 28 Apr 2022 17:48:26 -0400, Jesse Taube wrote:
> Both the i.MXRT1170 and 1050 have the same gpio controller as
> "fsl,imx35-gpio". Add i.MXRT to the compatible list.
> 
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
> ---
> V1 -> V2:
>  - New commit to fix dtbs_check
> ---
>  Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
