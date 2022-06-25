Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3D7255A840
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 11:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbiFYJFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 05:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232418AbiFYJFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 05:05:16 -0400
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E6E340FF
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 02:05:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1656147009; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=bckmVqAIFAQNFCUWf9zkVWIKa0qmv+89FpiYMjpbhBlmnKbmeBDKJAuE5vw5IqpGH/UmV61atpzKfOoxKw+awseHSKfl1hQLW4+ADpqpDK61LCoD3obq6tHDegeDeFy4kDpFTJZRjMX5EnVrn9OMCFd+vmgYQOxR5fC+leVPiTY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1656147009; h=Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=4UMGpmnDr90V/zwk67wYZZmzKHcnh/fQWLLmg0NOGYU=; 
        b=VPw5vwLan2WwXsFO2ylcyH2UswZMYEGl8+axbs2DFzo8JW4CLbgOK3iaMvuMUSrtV3d3h6qz8G57mionxpQYMSHAPJUpRCSR0VDeycCLW7Fs/2jKeOL1bScXqtNBLzQTHjC8RbuRIhOZsD6RPasFzYed/q0mjDaz/SLpBDZkZEA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=gvisoc.com;
        spf=pass  smtp.mailfrom=gabriel@gvisoc.com;
        dmarc=pass header.from=<gabriel@gvisoc.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1656147009;
        s=zoho; d=gvisoc.com; i=gabriel@gvisoc.com;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=4UMGpmnDr90V/zwk67wYZZmzKHcnh/fQWLLmg0NOGYU=;
        b=EFUkmV8grgPqSVH5Dh2CRmTdnNYqeNVWx3VD+W3HLJWLe/REroZ7IOvSr+OOtWG3
        2O/xMck3LO8Q6gq0W5Yf78He0JxZyr3gRZMwXNmQCLZ+Ef/mH/G/dqPV2n2foAb5oHw
        IjsPOOVrRzHMfn6tZz2LoAYtMUiDcKlnJEY5R9sU=
Received: from localhost (124-171-144-237.tpgi.com.au [124.171.144.237]) by mx.zohomail.com
        with SMTPS id 1656147007457304.1853474145885; Sat, 25 Jun 2022 01:50:07 -0700 (PDT)
From:   Gabriel Viso Carrera <gabriel@gvisoc.com>
To:     andreas.noever@gmail.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gabriel Viso Carrera <gabriel@gvisoc.com>
Subject: [PATCH 3/3] staging: Thunderbolt: ctl.c: Fixed comment coding style issues
Date:   Sat, 25 Jun 2022 18:49:13 +1000
Message-Id: <20220625084913.603556-4-gabriel@gvisoc.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220625084913.603556-1-gabriel@gvisoc.com>
References: <20220625084913.603556-1-gabriel@gvisoc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed a couple of comment aligment & formatting coding style issues.

Signed-off-by: Gabriel Viso Carrera <gabriel@gvisoc.com>
---
 drivers/thunderbolt/ctl.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/thunderbolt/ctl.c b/drivers/thunderbolt/ctl.c
index 6c973fdf7b36..5c6c62867b9c 100644
--- a/drivers/thunderbolt/ctl.c
+++ b/drivers/thunderbolt/ctl.c
@@ -276,7 +276,8 @@ static void tb_cfg_print_error(struct tb_ctl *ctl,
 	switch (res->tb_error) {
 	case TB_CFG_ERROR_PORT_NOT_CONNECTED:
 		/* Port is not connected. This can happen during surprise
-		 * removal. Do not warn. */
+		 * removal. Do not warn.
+		 */
 		return;
 	case TB_CFG_ERROR_INVALID_CONFIG_SPACE:
 		/*
@@ -402,11 +403,11 @@ static bool tb_ctl_handle_event(struct tb_ctl *ctl, enum tb_cfg_pkg_type type,
 static void tb_ctl_rx_submit(struct ctl_pkg *pkg)
 {
 	tb_ring_rx(pkg->ctl->rx, &pkg->frame); /*
-					     * We ignore failures during stop.
-					     * All rx packets are referenced
-					     * from ctl->rx_packets, so we do
-					     * not loose them.
-					     */
+						* We ignore failures during stop.
+						* All rx packets are referenced
+						* from ctl->rx_packets, so we do
+						* not loose them.
+						*/
 }
 
 static int tb_async_error(const struct ctl_pkg *pkg)
-- 
2.36.1

