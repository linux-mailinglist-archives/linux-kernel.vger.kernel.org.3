Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013444B4C6A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 11:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349839AbiBNKl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 05:41:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348550AbiBNKhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 05:37:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D9FA8881;
        Mon, 14 Feb 2022 02:03:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E0CA60C76;
        Mon, 14 Feb 2022 10:03:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B9CFC340EF;
        Mon, 14 Feb 2022 10:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644833024;
        bh=PWC4MiolHqPxzZqlrPZg8QnjhC1NnQ1cEiBb2jdkjgg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wl34C9gt6QZdt3G4KclWS093pA1v+MmPqn6mKVAtyXBCo/155/1HXW5rQuV6RY0/A
         lh8UST8xs+QJS5Wr0Nl/fcmHqvWSoEB/Xl24UpxBUCJLohjZyE7HtRf3swJjhIpu9h
         et+xJlpqbJ0Cvb6PkdeybmHMH10w80AAEUHifyII=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 5.16 199/203] arm64: dts: imx8mq: fix lcdif port node
Date:   Mon, 14 Feb 2022 10:27:23 +0100
Message-Id: <20220214092517.138672593@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220214092510.221474733@linuxfoundation.org>
References: <20220214092510.221474733@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Stein <alexander.stein@ew.tq-group.com>

commit 91f6d5f181f6629dd74ab71759fe92d3f4eff966 upstream.

The port node does not have a unit-address, remove it.
This fixes the warnings:
lcd-controller@30320000: 'port' is a required property
lcd-controller@30320000: 'port@0' does not match any of the regexes:
'pinctrl-[0-9]+'

Fixes: commit d0081bd02a03 ("arm64: dts: imx8mq: Add NWL MIPI DSI controller")
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -526,7 +526,7 @@
 				assigned-clock-rates = <0>, <0>, <0>, <594000000>;
 				status = "disabled";
 
-				port@0 {
+				port {
 					lcdif_mipi_dsi: endpoint {
 						remote-endpoint = <&mipi_dsi_lcdif_in>;
 					};


