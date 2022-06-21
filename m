Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 218795537C3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 18:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351675AbiFUQVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 12:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350635AbiFUQVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 12:21:41 -0400
Received: from smtpbg.qq.com (smtpbg139.qq.com [175.27.65.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BD52B276;
        Tue, 21 Jun 2022 09:21:34 -0700 (PDT)
X-QQ-mid: bizesmtp66t1655828481tgne2ii8
Received: from ubuntu.localdomain ( [106.117.99.68])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 22 Jun 2022 00:21:17 +0800 (CST)
X-QQ-SSF: 0100000000700090B000B00A0000000
X-QQ-FEAT: geCjBjpTnm62kzfs4G+/3uQWYNnyK3sHojGhU6VG3bJbQ5kfXJvwmbrgA9JMm
        2pA57LdCxCEK8wuodC1DB/ioFAACe7lPY1bC59tmJAxF3FnpGYW0D+IR+GMCpw59SSqmpMY
        /vf0OLcOmIh6oIZLgdlXoAQN3nK/eEMzvmaBuXtN0Ifx2WWbRPzOeEfIe48EyGKDrNst96T
        rN3MKSbBa9DL3ru0/BY1D8dyVCz5KwKjx0jcPalTl5e5j4mYLJcmcYc2idzXVzG7LmBxLgk
        8E/++zYampkbkSjJhaDkuxAA/2JuvAXHKxluQeBVWuAU4PC9NhgvqE1Kuuv40qppLluxPJ8
        M4Usuzq+f5Kxn2HIz0=
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     tsbogend@alpha.franken.de
Cc:     srinivas.kandagatla@linaro.org, rafael@kernel.org,
        sudeep.holla@arm.com, alexandre.belloni@bootlin.com,
        xkernel.wang@foxmail.com, u.kleine-koenig@pengutronix.de,
        jiangjian@cdjrlc.com, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mips: sgi-ip22: Remove duplicate 'of' in two places.
Date:   Wed, 22 Jun 2022 00:21:14 +0800
Message-Id: <20220621162114.23723-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

file: ./arch/mips/sgi-ip22/ip22-gio.c
line: 44
  * @ids: array of of device match structures to search in
changed to
  * @ids: array of device match structures to search in

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 arch/mips/sgi-ip22/ip22-gio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/sgi-ip22/ip22-gio.c b/arch/mips/sgi-ip22/ip22-gio.c
index 38d12f417e48..03d96638f957 100644
--- a/arch/mips/sgi-ip22/ip22-gio.c
+++ b/arch/mips/sgi-ip22/ip22-gio.c
@@ -41,7 +41,7 @@ static struct device gio_bus = {
 /**
  * gio_match_device - Tell if an of_device structure has a matching
  * gio_match structure
- * @ids: array of of device match structures to search in
+ * @ids: array of device match structures to search in
  * @dev: the of device structure to match against
  *
  * Used by a driver to check whether an of_device present in the
-- 
2.17.1

