Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D10424E3DA0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 12:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234191AbiCVLbp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 22 Mar 2022 07:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbiCVLbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 07:31:43 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2587EB2B
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 04:30:16 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nWci3-0001Jw-Ap; Tue, 22 Mar 2022 12:29:55 +0100
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nWcht-002HV8-1s; Tue, 22 Mar 2022 12:29:47 +0100
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nWchu-0004ia-Vk; Tue, 22 Mar 2022 12:29:46 +0100
Message-ID: <664b287eaeb0e738620cd46f01ad024f72bb01e0.camel@pengutronix.de>
Subject: Re: [PATCH 40/64] media: platform: rename coda/ to chips-media/
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Niklas =?ISO-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Cai Huoqing <caihuoqing@baidu.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Fabio Estevam <festevam@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Martin Weber <martin.weber@br-automation.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Ming Qian <ming.qian@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Date:   Tue, 22 Mar 2022 12:29:46 +0100
In-Reply-To: <fdd97c1b2c76f48170387fa4bafef5bada1f59c7.1647242579.git.mchehab@kernel.org>
References: <cover.1647242578.git.mchehab@kernel.org>
         <fdd97c1b2c76f48170387fa4bafef5bada1f59c7.1647242579.git.mchehab@kernel.org>
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

On Mo, 2022-03-14 at 08:55 +0100, Mauro Carvalho Chehab wrote:
> As the end goal is to have platform drivers split by vendor,
> rename coda/ to chips-media/.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>

This may be a silly nitpick: given that the company website is
chipsnmedia.com, would it be more appropriate to call this directory
chipsnmedia instead of chips-media?

regards
Philipp
