Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC7F4EA1CC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 22:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345555AbiC1Uqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 16:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345674AbiC1Un1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 16:43:27 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD02F674C6;
        Mon, 28 Mar 2022 13:41:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3D807CE170A;
        Mon, 28 Mar 2022 20:41:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F28FC34110;
        Mon, 28 Mar 2022 20:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648500102;
        bh=ft/j7/WhsjRUi+JdwMB/hMOMQ2xpIYrqeUUh6Om1GRw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ki3LZwpu2O7qQbprfnWJ3nFGzA/en7aBrGFRu9sF3Rp1wNr7NW15s47YwLSaHxyCf
         hrd0l6xK8OhNkExb0l8GURlNHHNQUOHmhWBWSXHhopN4+QgQnk7OaPThFOehqc1RVG
         yd/cYuTfSFfSIWpa1nho/cA3TOeit9KZa9b1ASOF1kimCExxURGEUqtJNoJTmtmLpV
         XWxjivSDgkKLChGhcg+8Q1fzHpw8dBFLhmGciyEi3MKVx8I+vWhSy4s583TvNiw+wH
         HLTbodjnz5rOspxC5a6Cykh2hZvIg2KspNCZHPU00D7GIPk0mSao2hIoedKAgHSS3f
         ZTQqO12nr6hGw==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nYwBI-000lc0-14; Mon, 28 Mar 2022 22:41:40 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dongliang Mu <mudongliangabcd@gmail.com>,
        Sean Young <sean@mess.org>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH 03/26] media: dvb-usb: vp702x: reference to usb ID table
Date:   Mon, 28 Mar 2022 22:41:15 +0200
Message-Id: <fe9ee24510431e6baad5244d8a27e56ce167fc36.1648499509.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1648499509.git.mchehab@kernel.org>
References: <cover.1648499509.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two commented entries that are pointing to the wrong
places. Fix them.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/26] at: https://lore.kernel.org/all/cover.1648499509.git.mchehab@kernel.org/

 drivers/media/usb/dvb-usb/vp702x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/dvb-usb/vp702x.c b/drivers/media/usb/dvb-usb/vp702x.c
index a1d9e4801a2b..8e9e3b494367 100644
--- a/drivers/media/usb/dvb-usb/vp702x.c
+++ b/drivers/media/usb/dvb-usb/vp702x.c
@@ -425,8 +425,8 @@ static struct dvb_usb_device_properties vp702x_properties = {
 		  .warm_ids = { NULL },
 		},
 /*		{ .name = "TwinhanDTV StarBox DVB-S USB2.0 (VP7020)",
-		  .cold_ids = { &vp702x_usb_table[2], NULL },
-		  .warm_ids = { &vp702x_usb_table[3], NULL },
+		  .cold_ids = { &vp702x_usb_table[1], NULL },
+		  .warm_ids = { &vp702x_usb_table[2], NULL },
 		},
 */		{ NULL },
 	}
-- 
2.35.1

