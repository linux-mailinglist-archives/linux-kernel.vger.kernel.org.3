Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6145046E251
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 07:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbhLIGOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 01:14:46 -0500
Received: from mail.pr-group.ru ([178.18.215.3]:58758 "EHLO mail.pr-group.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230221AbhLIGOp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 01:14:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-type:in-reply-to:
         references;
        bh=2ievsv+Pi9EcsCik6OtDMThaORs4vt2G2gNNZVLnLvc=;
        b=InreG1UTyTn+fX/6/HgJYoVDqtAQHWNkIdd7oxytOlsue3y+bKsSf6YuO+2X5IZlRhXIHNDo8HWH9
         OjIGfaoCzr+3QMP1m1u49jG08wfuc+LWBFCuc3uGjCOSPNRi3i2D5CmKHDnxwZn5/AR9IOcftaNh6+
         tFFj1qRsdX72hg6Rot5ItZqARXlY0cxgitZC3lPuLBgUEzI6ufFKnb9OKBXfN8voFQAK38we+DbpL6
         bmk5IvkaGkm3++cnFTkikmEMWM/BahS9bTv6koxyG/8dosfMFoDmrMJLlpw4O964/OEwXRFjRxKznD
         Ic6GTGnMF4C8Dg3o5pDZ5ru6uxaqY9Q==
X-Spam-Status: No, hits=0.0 required=3.4
        tests=BAYES_00: -1.665, CUSTOM_RULE_FROM: ALLOW, TOTAL_SCORE: -1.665,autolearn=ham
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from dhcp-179.ddg ([85.143.252.66])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Thu, 9 Dec 2021 09:10:51 +0300
Date:   Thu, 9 Dec 2021 09:10:41 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     i.bornyakov@metrotek.ru
Cc:     system@metrotek.ru, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 0/2] bus: imx-weim: optionally enable continuous burst
 clock
Message-ID: <20211209061041.zuhdx5ctukfkdylz@dhcp-179.ddg>
References: <20211202055724.4416-1-i.bornyakov@metrotek.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211202055724.4416-1-i.bornyakov@metrotek.ru>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 08:57:22AM +0300, Ivan Bornyakov wrote:
> Introduce option to enable continuous burst clock, if burst clock itself
> is enabled.
> 
> Changelog:
>   v1 -> v2:
>     * documentation about this option added to
>       Documentation/devicetree/bindings/bus/imx-weim.txt
>   v2 -> v3:
>     * added missing Signed-off-by line
> 
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

Kindly ping.

