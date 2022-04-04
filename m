Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDAC14F12F0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 12:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356778AbiDDKTQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 4 Apr 2022 06:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242615AbiDDKTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 06:19:13 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29DB33353
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 03:17:17 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nbJlj-000280-Vt; Mon, 04 Apr 2022 12:17:08 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nbJlk-0010WL-IW; Mon, 04 Apr 2022 12:17:07 +0200
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nbJli-0006gF-Ep; Mon, 04 Apr 2022 12:17:06 +0200
Message-ID: <de4755da238b7333ea32785d0d5d47d7008a296d.camel@pengutronix.de>
Subject: Re: [PATCH 0/3] reset: meson-s4: add reset driver
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Zelong Dong <zelong.dong@amlogic.com>, robh+dt@kernel.org,
        khilman@baylibre.com, narmstrong@baylibre.com,
        martin.blumenstingl@googlemail.com
Cc:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, jbrunet@baylibre.com,
        devicetree@vger.kernel.org
Date:   Mon, 04 Apr 2022 12:17:06 +0200
In-Reply-To: <20220107023931.13251-1-zelong.dong@amlogic.com>
References: <20220107023931.13251-1-zelong.dong@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fr, 2022-01-07 at 10:39 +0800, Zelong Dong wrote:
> 
> This patchset adds Reset controller driver support for Meson-S4 SoC.
> Meson-S4 Reset Controller has 6 banks (the number of reset register)
> and the level-reset register offset is 0x40.
> 
> 
> Zelong Dong (3):
>   dt-bindings: reset: Add compatible for Meson-S4 Reset Controller
>   dt-bindings: reset: add bindings for the Meson-S4 SoC Reset
> Controller
>   reset: reset-meson: add support for the Meson-S4 SoC Reset
> Controller
> 
>  .../bindings/reset/amlogic,meson-reset.yaml   |   1 +
>  drivers/reset/reset-meson.c                   |   6 +
>  .../reset/amlogic,meson-s4-reset.h            | 125
> ++++++++++++++++++
>  3 files changed, 132 insertions(+)
>  create mode 100644 include/dt-bindings/reset/amlogic,meson-s4-
> reset.h

Thank you, applied to reset/next.

regards
Philipp
