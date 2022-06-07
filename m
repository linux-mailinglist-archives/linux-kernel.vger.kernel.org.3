Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0676D53F645
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 08:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237087AbiFGGil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 02:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237051AbiFGGib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 02:38:31 -0400
X-Greylist: delayed 1631 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 06 Jun 2022 23:38:29 PDT
Received: from challenge-bot.com (challenge-bot.com [IPv6:2602:fffa:fff:108a:0:16:3e15:92b8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1624880D8
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 23:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=challenge-bot.com; s=20180430; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=NDHKKSmM/1awbA139++eN0BK1p5M4NDk8HA8lGCAbmY=; b=SNJKp+iyI1ltJjQhHkpFDpcoHV
        Rn52ZpilNAVcmQ8COz/zmDXKCpDomonDTUL0IZTTnGmuZI3bJFQEPWjjOITvZOcS0ZdWwn7kVkWx5
        nfvaq28AjcPebA2xD62m2Y4tIKyUIUOVUqhpWkRgOtXaNterNabTaf+T3h8GItepTivA=;
Received: from ozzloy by challenge-bot.com with local (Exim 4.92)
        (envelope-from <ozzloy@challenge-bot.com>)
        id 1nySQt-0008Vi-6s; Mon, 06 Jun 2022 23:11:15 -0700
From:   daniel watson <ozzloy@challenge-bot.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Daniel Watson <ozzloy@challenge-bot.com>
Subject: [PATCH] staging: r8188eu: fix declaration to match 'foo *bar'
Date:   Mon,  6 Jun 2022 23:11:13 -0700
Message-Id: <20220607061113.32633-1-ozzloy@challenge-bot.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Watson <ozzloy@challenge-bot.com>

put '*' next to variable to match kernel style from checkpatch

Signed-off-by: Daniel Watson <ozzloy@challenge-bot.com>
---
 drivers/staging/r8188eu/include/rtw_io.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/include/rtw_io.h b/drivers/staging/r8188eu/include/rtw_io.h
index 6910e2b430e24..0e390eda5b4d3 100644
--- a/drivers/staging/r8188eu/include/rtw_io.h
+++ b/drivers/staging/r8188eu/include/rtw_io.h
@@ -283,7 +283,7 @@ void free_io_queue(struct adapter *adapter);
 void async_bus_io(struct io_queue *pio_q);
 void bus_sync_io(struct io_queue *pio_q);
 u32 _ioreq2rwmem(struct io_queue *pio_q);
-void dev_power_down(struct adapter * Adapter, u8 bpwrup);
+void dev_power_down(struct adapter *Adapter, u8 bpwrup);
 
 #define PlatformEFIOWrite1Byte(_a,_b,_c)		\
 	rtw_write8(_a,_b,_c)
-- 
2.34.1

