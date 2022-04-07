Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80BDA4F7C28
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 11:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244032AbiDGJuQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 7 Apr 2022 05:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244027AbiDGJuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 05:50:12 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190D1205BC6
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 02:48:10 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1ncOk7-0007qa-3m; Thu, 07 Apr 2022 11:47:55 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1ncOk7-001aNQ-Ph; Thu, 07 Apr 2022 11:47:54 +0200
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1ncOk5-0004HR-NQ; Thu, 07 Apr 2022 11:47:53 +0200
Message-ID: <e60722e4faf2b1a949431fad107eed08fdc695d9.camel@pengutronix.de>
Subject: Re: [PATCH v2 04/10] dt-bindings: reset: add sama7g5 definitions
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>, robh+dt@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        linux@armlinux.org.uk, sre@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org
Date:   Thu, 07 Apr 2022 11:47:53 +0200
In-Reply-To: <20220407071708.3848812-5-claudiu.beznea@microchip.com>
References: <20220407071708.3848812-1-claudiu.beznea@microchip.com>
         <20220407071708.3848812-5-claudiu.beznea@microchip.com>
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

On Do, 2022-04-07 at 10:17 +0300, Claudiu Beznea wrote:
> Add reset bindings for SAMA7G5. At the moment only USB PHYs are
> included.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

to be merged with this series.

regards
Philipp
