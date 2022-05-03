Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CADAB519094
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 23:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243094AbiECVrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 17:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239841AbiECVrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 17:47:13 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7EB2B1B8;
        Tue,  3 May 2022 14:43:38 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id a10so19538921oif.9;
        Tue, 03 May 2022 14:43:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AslExF7FIeWiE1XAfGO7Gr/CjNSAVkdBagVMGjZRKl8=;
        b=3FXaWCv3jZJYnW5jrnm63FflQlvIwxPsLAxGC8m/+//dBptX7bW6ekD+s0wD8bHbab
         uJAuYDdUBIEcy4NXbIblvDl8r0RQiN7ADOpyOOueloZFbjMjRGL7kYG5miwGkn5wNhH2
         BJkXbPRCoaxvn1LeuXmyVPrHGjoTymEjZVO2avlD4dE7KSQaxxubt6LsTkhrCAgBiLnR
         kMWw7YwX+EetS+XwmWMJu+aMWATGfq4EUT4D7mQDoZzSS63E+yo2UBg98LQLNAGHbQXG
         Bp6Xvb6WrTgLt1OinDS3yvYXFusp9ZyMZZgeQuwOLfRmWJ2y2m9qMZCmjbrxTDPzZm+k
         F1MA==
X-Gm-Message-State: AOAM532/KDwYNTemVbOiR3pzyoupVQ9uhTOFwhCLmiTWR0k5qYUelHvP
        13IGTUUR9Nu3FK/LJYhs1hK6rZ29uA==
X-Google-Smtp-Source: ABdhPJyNoO0eggMNyiE7l98v1cDQkC/VjzdrCByZYzlJVVHHsc/h+ndTz6SRfZY6gegAaIjIw8NSKg==
X-Received: by 2002:a05:6808:144c:b0:325:64f3:d428 with SMTP id x12-20020a056808144c00b0032564f3d428mr2786884oiv.210.1651614217929;
        Tue, 03 May 2022 14:43:37 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w3-20020a056830280300b006060322123dsm4307533otu.13.2022.05.03.14.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 14:43:37 -0700 (PDT)
Received: (nullmailer pid 83673 invoked by uid 1000);
        Tue, 03 May 2022 21:43:36 -0000
Date:   Tue, 3 May 2022 16:43:36 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jesse Taube <mr.bossman075@gmail.com>
Cc:     linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        daniel.lezcano@linaro.org, clin@suse.com, festevam@gmail.com,
        linux-imx@nxp.com, mturquette@baylibre.com,
        linus.walleij@linaro.org, devicetree@vger.kernel.org,
        giulio.benetti@benettiengineering.com, kernel@pengutronix.de,
        leoyang.li@nxp.com, robh+dt@kernel.org, linux@armlinux.org.uk,
        olof@lixom.net, arnd@arndb.de, tglx@linutronix.de, dev@lynxeye.de,
        cniedermaier@dh-electronics.com, shawnguo@kernel.org,
        linux-arm-kernel@lists.infradead.org, stefan@agner.ch,
        sebastian.reichel@collabora.com, sboyd@kernel.org, soc@kernel.org,
        Mr.Bossman075@gmail.com, abel.vesa@nxp.com,
        linux-kernel@vger.kernel.org, s.hauer@pengutronix.de,
        tharvey@gateworks.com, marcel.ziswiler@toradex.com,
        aisheng.dong@nxp.com
Subject: Re: [PATCH v2 06/15] dt-bindings: pinctrl: add i.MXRT1170 pinctrl
 Documentation
Message-ID: <YnGiCNvnW86ZIejd@robh.at.kernel.org>
References: <20220428214838.1040278-1-Mr.Bossman075@gmail.com>
 <20220428214838.1040278-7-Mr.Bossman075@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220428214838.1040278-7-Mr.Bossman075@gmail.com>
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

On Thu, 28 Apr 2022 17:48:29 -0400, Jesse Taube wrote:
> Add i.MXRT1170 pinctrl binding Documentation
> 
> Cc: Giulio Benetti <giulio.benetti@benettiengineering.com>
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
> ---
> V1 -> V2:
>  - Nothing done
> ---
>  .../bindings/pinctrl/fsl,imxrt1170.yaml       | 77 +++++++++++++++++++
>  1 file changed, 77 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,imxrt1170.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
