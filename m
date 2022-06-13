Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0609E549F18
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 22:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351494AbiFMUaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 16:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350921AbiFMU22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:28:28 -0400
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471EB193EF;
        Mon, 13 Jun 2022 12:15:53 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id d123so7114587iof.10;
        Mon, 13 Jun 2022 12:15:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GEjnnN//JiCiI3GuISH4q5FQJvUbVSJXakhhE2GaPqM=;
        b=X4XZQjcFSwzrT2dTWKMZCYoOzlEd1iBWL7ZmKn+AkxDkLG3zyQrLCa54WfShIIOs/5
         0xJxk98naeSWwF1UsdMVD6f5k5GxBGNK1MzQHv3bk4E16RyE0TPqT1/I7nU2QMRrbb5q
         K/j+6ByYESVMZ79+74aiQi6lTn6Os7e2wJ/ZRvCsLW92nMlIggKHSSLgX9ifep52GOoI
         R7pQSZtBXKvd+6BrpA4FBwPZcJeAfNVhPHx1EDiMFXEertanPV4jnx0qxgdhYXyYB2gb
         yxPxXN1AydswkoIjlVjXj4YAlvOIfkdD4dlqRLDw0GRHGNp5k3JoB43qNncuNYyzFUcN
         LWgg==
X-Gm-Message-State: AOAM53244m6kI/dgT6RHdJZ9h4kyT/U3XSPhlS3YxcF2srPvu0vHr3SY
        Zu9NnxhBrV+SOar1efNfMw==
X-Google-Smtp-Source: ABdhPJyN8sGx8YDVJ+QgIaLBk8J2Ux3lzoOGfBNp9bkBBkXjzA5iwt1QoG43IxfbO+ZX/BdUykJ0NA==
X-Received: by 2002:a02:6619:0:b0:32e:25b7:d9ed with SMTP id k25-20020a026619000000b0032e25b7d9edmr771680jac.30.1655147752566;
        Mon, 13 Jun 2022 12:15:52 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id d29-20020a023f1d000000b0032e5205f4e7sm678930jaa.4.2022.06.13.12.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 12:15:52 -0700 (PDT)
Received: (nullmailer pid 4108636 invoked by uid 1000);
        Mon, 13 Jun 2022 19:15:49 -0000
Date:   Mon, 13 Jun 2022 13:15:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Max Krummenacher <max.oss.09@gmail.com>
Cc:     max.krummenacher@toradex.com, Ulf Hansson <ulf.hansson@linaro.org>,
        linux-pm@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Fabio Estevam <festevam@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/5] power: domain: Add driver for a PM domain
 provider which controls
Message-ID: <20220613191549.GA4092455-robh@kernel.org>
References: <20220609150851.23084-1-max.oss.09@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220609150851.23084-1-max.oss.09@gmail.com>
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

On Thu, Jun 09, 2022 at 05:08:46PM +0200, Max Krummenacher wrote:
> From: Max Krummenacher <max.krummenacher@toradex.com>
> 
> its power enable by using a regulator.
> 
> The currently implemented PM domain providers are all specific to
> a particular system on chip.

Yes, power domains tend to be specific to an SoC... 'power-domains' is 
supposed to be power islands in a chip. Linux 'PM domains' can be 
anything...

> This series adds a PM domain provider driver which enables/disables
> a regulator to control its power state. Additionally, marked with RFC,
> it adds two commits which actually make use of the new driver to
> instantiate a power domain provider and have a number of power
> domain consumers use the power domain.
> 
> The perceived use case is to control a common power domain used by
> several devices for which not all device drivers nessesarily have
> a means to control a regulator.

Why wouldn't they have means?

> It also handles the suspend / resume use case for such devices,
> the generic power domain framework will disable the domain once the
> last device has been suspend and will enable it again before resuming
> the first device.
> The generic power domain code handles a power domain consumer
> generically outside of the driver's code. (assuming the 'power-domains'
> property references exactly one power domain).

That's Linux implementation details.

> This allows to use the "regulator-pm-pd" driver with an arbitrary
> device just by adding the 'power-domains' property to the devices
> device tree node. However the device's dt-bindings schema likely does
> not allow the property 'power-domains'.
> One way to solve this would be to allow 'power-domains' globally
> similarly how 'status' and other common properties are allowed as
> implicit properties.

No. For 'power-domains' bindings have to define how many there are and 
what each one is.

Rob
