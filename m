Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5E857FB45
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 10:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233803AbiGYI0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 04:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233661AbiGYI0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 04:26:16 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E7413EBD
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 01:26:15 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1oFtPb-0004BL-K5; Mon, 25 Jul 2022 10:25:59 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1oFtPa-0007JY-Ar; Mon, 25 Jul 2022 10:25:58 +0200
Date:   Mon, 25 Jul 2022 10:25:58 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de,
        l.stach@pengutronix.de, marex@denx.de, devicetree@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, Markus.Niebel@ew.tq-group.com,
        alexander.stein@ew.tq-group.com, aford173@gmail.com,
        paul.elder@ideasonboard.com, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de, festevam@gmail.com,
        aisheng.dong@nxp.com, linux-arm-kernel@lists.infradead.org,
        laurent.pinchart@ideasonboard.com
Subject: Re: [PATCH V4 5/8] soc: imx: add i.MX8MP HDMI blk ctrl HDCP/HRV
Message-ID: <20220725082558.prowncgliwfa2egq@pengutronix.de>
References: <20220722125730.3428017-1-peng.fan@oss.nxp.com>
 <20220722125730.3428017-6-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722125730.3428017-6-peng.fan@oss.nxp.com>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 22-07-22, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> i.MX8MP HDMI supports HDCP and HRV, so add them.

Out of curiosity what is this HRV? Is it a HDMI receive block? The
reference manual has only a few references to a few bits but says
nothing about this block.

Regards,
  Marco
