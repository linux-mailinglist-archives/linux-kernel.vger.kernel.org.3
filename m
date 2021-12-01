Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 225CA464B92
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 11:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348637AbhLAK3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 05:29:10 -0500
Received: from mail.pr-group.ru ([178.18.215.3]:61660 "EHLO mail.pr-group.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242715AbhLAK3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 05:29:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-type:in-reply-to:
         references;
        bh=vXS+J9Nh+wEUQHCt1sy4EBGBrQ1eqDW2ciFrAcJFNew=;
        b=tIzlvSsrlT9k8/GgYR2rCZNwyiQrS/2AimjdDGlB4gi8pksv8+2AnyqxvH3jyCvjVipPe40jTRJX0
         hbvPFjJC7pcAT/ElTGEmxr3OxBqGZ+4dcj5CplAP5vMgD0X3+0+OES0jabn5r6dh23sBy276guYU1v
         LU9reYPzTPQRd3GEeqhkSjXDrnPkwKYFS060hBVk/Z6fGHERksMcWOB+SXR2tvecLgebeAbYWk/Eyf
         97jVLjOsMMGoOyPr5NEhICY5wnOdy0v1P1RrW5RxtgAIn23CXPtdrWAN0blrg41eyQ9HWEeKXc2KLZ
         8IoicSZt1kwoISOYvWMpq11sh6UV1Uw==
X-Spam-Status: No, hits=0.0 required=3.4
        tests=BAYES_00: -1.665, CUSTOM_RULE_FROM: ALLOW, TOTAL_SCORE: -1.665,autolearn=ham
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from dhcp-179.ddg ([85.143.252.66])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Wed, 1 Dec 2021 13:25:30 +0300
Date:   Wed, 1 Dec 2021 13:25:19 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     i.bornyakov@metrotek.ru
Cc:     system@metrotek.ru, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/2] bus: imx-weim: optionally enable continuous burst
 clock
Message-ID: <20211201102518.sxjctvnizsrint2r@dhcp-179.ddg>
References: <20211124175542.2772-1-i.bornyakov@metrotek.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211124175542.2772-1-i.bornyakov@metrotek.ru>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2021 at 08:55:40PM +0300, Ivan Bornyakov wrote:
> Introduce option to enable continuous burst clock, if burst clock itself
> is enabled.
> 
> Changelog:
>   v1 -> v2:
>     * documentation about this option added to
>       Documentation/devicetree/bindings/bus/imx-weim.txt
> 
> Ivan Bornyakov (2):
>   bus: imx-weim: optionally enable continuous burst clock
>   dt-bindings: bus: imx-weim: add words about continuous bclk
> 
>  .../devicetree/bindings/bus/imx-weim.txt       |  5 +++++
>  drivers/bus/imx-weim.c                         | 18 ++++++++++++++++--
>  2 files changed, 21 insertions(+), 2 deletions(-)
> 
> -- 
> 2.32.0
> 

Friendly ping.
Any feedback?

