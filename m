Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7F355A852
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 11:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbiFYJFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 05:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbiFYJFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 05:05:12 -0400
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C44F33E06
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 02:05:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1656147003; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=Pljd/awPP1rhutkfPAS31EW6oN+Bp67f/143fcxHSukDwZavKDzNR9WE4vrQJY86mQzE9VcQmZwxmUcrqza3TA1fWKlv0Sd3kWAnewklYD6CYh43JVD5y+tvH4f4BoLfsaKUT2jXuLq3rppXQfHdt6GaqfQgSnQBtjqpO914QMk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1656147003; h=Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=fnspOYc3t+/42Tg1YX2ErJZ25N1I+LrcKkp6cY76wXA=; 
        b=ew9ls0YoxYguB24N5tRBxPFyi0qch+hfXkSI1qBNe/oiy0CiDrj7d3JlOrpZpos5I7jCAFfdiQwQbv/oBVtyqm/7XsA0HE4JdZ2EI6bVSjTETdlZJ14uwawRf4p98IWJRRIFLs+E1eAGWUfnfceijbSpAR0SOPWhmFE+tLMSjLM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=gvisoc.com;
        spf=pass  smtp.mailfrom=gabriel@gvisoc.com;
        dmarc=pass header.from=<gabriel@gvisoc.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1656147003;
        s=zoho; d=gvisoc.com; i=gabriel@gvisoc.com;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=fnspOYc3t+/42Tg1YX2ErJZ25N1I+LrcKkp6cY76wXA=;
        b=AEWZUBfOEXWdMhCRpFbE7Zi5siZubTR8738E/vwLJIdTDTQZOyzUY05v1tXCC1XU
        E7CsCGkbDJJHeFo2otzobhmvkrzfYFL9JpFvePVkuR27RGn4hsg0rhjRZfN7eMp/gKE
        KJEfcuBoj2syq6uFbqu3wh0fEdOuDFsfqYrNC6DY=
Received: from localhost (124-171-144-237.tpgi.com.au [124.171.144.237]) by mx.zohomail.com
        with SMTPS id 165614700268011.66864093033962; Sat, 25 Jun 2022 01:50:02 -0700 (PDT)
From:   Gabriel Viso Carrera <gabriel@gvisoc.com>
To:     andreas.noever@gmail.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gabriel Viso Carrera <gabriel@gvisoc.com>
Subject: [PATCH 2/3] staging: Thunderbolt: ctl.c: Fixed blank line coding style issues
Date:   Sat, 25 Jun 2022 18:49:12 +1000
Message-Id: <20220625084913.603556-3-gabriel@gvisoc.com>
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

Added blank lines after variable declarations as per checkpatch.pl
(all issues of that kind in the file).

Signed-off-by: Gabriel Viso Carrera <gabriel@gvisoc.com>
---
 drivers/thunderbolt/ctl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/thunderbolt/ctl.c b/drivers/thunderbolt/ctl.c
index 4b841fbb3628..6c973fdf7b36 100644
--- a/drivers/thunderbolt/ctl.c
+++ b/drivers/thunderbolt/ctl.c
@@ -232,6 +232,7 @@ static struct tb_cfg_result decode_error(const struct ctl_pkg *response)
 	struct cfg_error_pkg *pkg = response->buffer;
 	struct tb_ctl *ctl = response->ctl;
 	struct tb_cfg_result res = { 0 };
+
 	res.response_route = tb_cfg_get_route(&pkg->header);
 	res.response_port = 0;
 	res.err = check_header(response, sizeof(*pkg), TB_CFG_PKG_ERROR,
@@ -327,6 +328,7 @@ static void tb_ctl_pkg_free(struct ctl_pkg *pkg)
 static struct ctl_pkg *tb_ctl_pkg_alloc(struct tb_ctl *ctl)
 {
 	struct ctl_pkg *pkg = kzalloc(sizeof(*pkg), GFP_KERNEL);
+
 	if (!pkg)
 		return NULL;
 	pkg->ctl = ctl;
@@ -346,6 +348,7 @@ static void tb_ctl_tx_callback(struct tb_ring *ring, struct ring_frame *frame,
 			       bool canceled)
 {
 	struct ctl_pkg *pkg = container_of(frame, typeof(*pkg), frame);
+
 	tb_ctl_pkg_free(pkg);
 }
 
@@ -361,6 +364,7 @@ static int tb_ctl_tx(struct tb_ctl *ctl, const void *data, size_t len,
 {
 	int res;
 	struct ctl_pkg *pkg;
+
 	if (len % 4 != 0) { /* required for le->be conversion */
 		tb_ctl_WARN(ctl, "TX: invalid size: %zu\n", len);
 		return -EINVAL;
@@ -627,6 +631,7 @@ struct tb_ctl *tb_ctl_alloc(struct tb_nhi *nhi, int timeout_msec, event_cb cb,
 {
 	int i;
 	struct tb_ctl *ctl = kzalloc(sizeof(*ctl), GFP_KERNEL);
+
 	if (!ctl)
 		return NULL;
 	ctl->nhi = nhi;
@@ -700,6 +705,7 @@ void tb_ctl_free(struct tb_ctl *ctl)
 void tb_ctl_start(struct tb_ctl *ctl)
 {
 	int i;
+
 	tb_ctl_dbg(ctl, "control channel starting...\n");
 	tb_ring_start(ctl->tx); /* is used to ack hotplug packets, start first */
 	tb_ring_start(ctl->rx);
-- 
2.36.1

