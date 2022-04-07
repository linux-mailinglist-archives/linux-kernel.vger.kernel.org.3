Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC3E4F7A03
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 10:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243225AbiDGIpN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 7 Apr 2022 04:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240566AbiDGIpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 04:45:09 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7B031930
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 01:43:10 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1ncNjQ-0002jA-L0; Thu, 07 Apr 2022 10:43:08 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1ncNjP-001Zpn-5x; Thu, 07 Apr 2022 10:43:05 +0200
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1ncNjN-00030L-0S; Thu, 07 Apr 2022 10:43:05 +0200
Message-ID: <cb1e7e1c5527e531a9c864a337aabde1c20b9940.camel@pengutronix.de>
Subject: Re: [PATCH v1 0/5] DRM: Bridge: DW_HDMI: Add new features and bug
 fix
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Sandor.yu@nxp.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, andrzej.hajda@intel.com,
        narmstrong@baylibre.com, robert.foss@linaro.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com
Cc:     shengjiu.wang@nxp.com, amuel@sholland.org, cai.huoqing@linux.dev,
        maxime@cerno.tech, hverkuil-cisco@xs4all.nl
Date:   Thu, 07 Apr 2022 10:43:04 +0200
In-Reply-To: <cover.1649230434.git.Sandor.yu@nxp.com>
References: <cover.1649230434.git.Sandor.yu@nxp.com>
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

Hi Sandor,

On Mi, 2022-04-06 at 16:48 +0800, Sandor.yu@nxp.com wrote:
> From: Sandor Yu <Sandor.yu@nxp.com>
> 
> It is new features and bug fix patch set for DW_HDMI DRM bridge driver
> that has verified by NXP iMX865.

Is that iMX865 or i.MX865? Both are used in different places of this
patchset, I'd pick the official spelling and use it everywhere.

regards
Philipp
