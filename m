Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252FF4D637D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 15:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349365AbiCKOey convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 11 Mar 2022 09:34:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245567AbiCKOev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:34:51 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6471C8868
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 06:33:45 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nSgKp-0008D9-Tb; Fri, 11 Mar 2022 15:33:39 +0100
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nSgKp-0004KX-FI; Fri, 11 Mar 2022 15:33:38 +0100
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nSgKn-0008oR-9P; Fri, 11 Mar 2022 15:33:37 +0100
Message-ID: <f5d38f7f26a7993bcf933eacf4a99eb20aa6012c.camel@pengutronix.de>
Subject: Re: [PATCH v2 13/38] media: platform: coda: move config to its own
 file
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Niklas =?ISO-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Dmitry Osipenko <digetx@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ming Qian <ming.qian@nxp.com>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Date:   Fri, 11 Mar 2022 15:33:37 +0100
In-Reply-To: <8471590ec0809292a61396dd7d2af1f3ac8a3174.1647006877.git.mchehab@kernel.org>
References: <cover.1647006877.git.mchehab@kernel.org>
         <8471590ec0809292a61396dd7d2af1f3ac8a3174.1647006877.git.mchehab@kernel.org>
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

On Fr, 2022-03-11 at 15:07 +0100, Mauro Carvalho Chehab wrote:
> In order to better organize the platform/Kconfig, place
> coda-specific config stuff on a separate Kconfig file.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>

One should be enough? The contents are

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
