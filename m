Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B29E057FBAF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 10:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234095AbiGYIvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 04:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233186AbiGYIvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 04:51:01 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E0964D2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 01:51:00 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1oFtnf-0007uG-AR; Mon, 25 Jul 2022 10:50:51 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1oFtne-0008EH-IC; Mon, 25 Jul 2022 10:50:50 +0200
Date:   Mon, 25 Jul 2022 10:50:50 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, Peng Fan <peng.fan@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: imx: imx93-blk-ctrl: set priority level
Message-ID: <20220725085050.izj7kmgeuxxug6rh@pengutronix.de>
References: <20220725035931.3988435-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220725035931.3988435-1-peng.fan@oss.nxp.com>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng,

thanks for the patch.

On 22-07-25, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> i.MX93 mediamix blk ctrl has registers to set QoS(priority) value.
> It support default QoS value and cfg QoS value. Set an initial
> value from i.MX design team. If LCDIF/ISI/PXP wanna a different QoS
> value in future, they could use interconnect to request bandwidth.

I need to ask here. Does the iMX93 use the same interconnect as the
iMX8M* does?

Regards,
  Marco
