Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75FF656706E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 16:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233071AbiGEOK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 10:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbiGEOJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 10:09:49 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2AFD25C4;
        Tue,  5 Jul 2022 07:01:14 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 251922223E;
        Tue,  5 Jul 2022 16:01:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1657029672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BufwydC3gNQB0ICZ0UOD1tKDxwySMEp3LR8WaS4Z4zs=;
        b=fYcpBUFyOUG+LwIiR0lDML0iXn23L3u5Ir6BdbqPLeAJ6zuOIvEnxM0DeAq1IexEL51w3w
        J/yuiP2d4qHswkKIh/aMnShDG7OMS/JDi0Ln8y3avECMjWDHnLHW8mlSajaEXifahs5XtA
        FWEhq9qD4KYrPWK3OTzYkxrUsOXnuaA=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 05 Jul 2022 16:01:12 +0200
From:   Michael Walle <michael@walle.cc>
To:     haibo.chen@nxp.com
Cc:     ashish.kumar@nxp.com, yogeshgaur.83@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        han.xu@nxp.com, singh.kuldeep87k@gmail.com,
        tudor.ambarus@microchip.com, p.yadav@ti.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, zhengxunli@mxic.com.tw
Subject: Re: [PATCH 01/11] spi: spi-nxp-fspi: enable runtime pm for fspi
In-Reply-To: <1657012303-6464-1-git-send-email-haibo.chen@nxp.com>
References: <1657012303-6464-1-git-send-email-haibo.chen@nxp.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <fc7d7ffe775feb1d9fde19a5dadbca1f@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-07-05 11:11, schrieb haibo.chen@nxp.com:
> From: Haibo Chen <haibo.chen@nxp.com>
> 
> Enable the runtime PM in fspi driver.
> Also for system PM, On some board like i.MX8ULP-EVK board,
> after system suspend, IOMUX module will lost power, so all
> the pinctrl setting will lost when system resume back, need
> driver to save/restore the pinctrl setting.

On a side note: The mails to Ashish Kumar bounces. He is currently
listed as the maintainer for the FlexSPI driver. Will someone from
NXP take over?

-michael
