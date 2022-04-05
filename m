Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED48D4F4A3B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1454276AbiDEWiS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 5 Apr 2022 18:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1455081AbiDEP7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:59:36 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6EBB1EA281
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 08:09:43 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nbkoF-0007Sl-Ih; Tue, 05 Apr 2022 17:09:31 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nbkoG-001FZ2-2D; Tue, 05 Apr 2022 17:09:30 +0200
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nbkoE-0007ua-0i; Tue, 05 Apr 2022 17:09:30 +0200
Message-ID: <ac31aebdd194fc559c43b08419a649ca32167e6d.camel@pengutronix.de>
Subject: Re: [PATCH 4/8] dt-bindings: reset: add sama7g5 definitions
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>, robh+dt@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        sre@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Date:   Tue, 05 Apr 2022 17:09:29 +0200
In-Reply-To: <20220405112724.2760905-5-claudiu.beznea@microchip.com>
References: <20220405112724.2760905-1-claudiu.beznea@microchip.com>
         <20220405112724.2760905-5-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Di, 2022-04-05 at 14:27 +0300, Claudiu Beznea wrote:
> Add reset bindings for SAMA7G5. At the moment only USB PHYs are
> included.

What do you mean by "at the moment only USB PHYs are included"? Are
those the only reset controls on sama7g5 and later hardware might have
more?

regards
Philipp
