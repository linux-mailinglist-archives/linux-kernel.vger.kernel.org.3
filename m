Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C1059FB62
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 15:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237247AbiHXN25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 09:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238271AbiHXN2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 09:28:52 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB7A7333B;
        Wed, 24 Aug 2022 06:28:43 -0700 (PDT)
X-QQ-mid: bizesmtp89t1661347670tno5dbrc
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 24 Aug 2022 21:27:48 +0800 (CST)
X-QQ-SSF: 01000000002000C0E000B00A0000000
X-QQ-FEAT: CR3LFp2JE4lVtJqGAORANqiWrRevsg+dieOK12peJxs2yEGyZUhWECAnOnNqJ
        MZLX2vJX1MpnKW3M8wDrxMK9+tj26mG0q4eGSlgozF/CTscRjNSEsK00RBXQiLaQA/6xoo0
        KjnjX/KzliG+aIcrcvCofG8B/Pqeqm6pHLiQ/jzFKR+b6UmfQzprP8Xw1DtbF95mX8HpJ9M
        kygev5/m0XTYAaTmqZKyM++4XSU0ghyhHgPXh3AONWnwgP1fz+T0xtKZw6ZPTFjrp3/M0Oy
        xcc6/F+zuhElebHu67y3skXwDP5ExBLiB4PIRCi+84C0Z9ZeEK1OR0sYjYS8uBmRwOYYblq
        FDWjKOKGQkIKe7MDGIwwG92dR2akgyIDNe9YRQHh0rhITlsc5hIstMwOSF7QXtlu/19AoqN
        oei+Szaqc9g=
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     awalls@md.metrocast.net, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] pci/cx18: fix repeated words in comments
Date:   Wed, 24 Aug 2022 21:27:42 +0800
Message-Id: <20220824132742.62005-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Delete the redundant word 'is'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/media/pci/cx18/cx18-av-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/pci/cx18/cx18-av-core.c b/drivers/media/pci/cx18/cx18-av-core.c
index 76e5a504df8c..0ac62d3e85de 100644
--- a/drivers/media/pci/cx18/cx18-av-core.c
+++ b/drivers/media/pci/cx18/cx18-av-core.c
@@ -339,7 +339,7 @@ void cx18_av_std_setup(struct cx18 *cx)
 
 		/*
 		 * For a 13.5 Mpps clock and 15,625 Hz line rate, a line is
-		 * is 864 pixels = 720 active + 144 blanking.  ITU-R BT.601
+		 * 864 pixels = 720 active + 144 blanking.  ITU-R BT.601
 		 * specifies 12 luma clock periods or ~ 0.9 * 13.5 Mpps after
 		 * the end of active video to start a horizontal line, so that
 		 * leaves 132 pixels of hblank to ignore.
@@ -399,7 +399,7 @@ void cx18_av_std_setup(struct cx18 *cx)
 
 		/*
 		 * For a 13.5 Mpps clock and 15,734.26 Hz line rate, a line is
-		 * is 858 pixels = 720 active + 138 blanking.  The Hsync leading
+		 * 858 pixels = 720 active + 138 blanking.  The Hsync leading
 		 * edge should happen 1.2 us * 13.5 Mpps ~= 16 pixels after the
 		 * end of active video, leaving 122 pixels of hblank to ignore
 		 * before active video starts.
-- 
2.36.1

