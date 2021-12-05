Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96D59468AF9
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 14:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234033AbhLENNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 08:13:18 -0500
Received: from smtpbg604.qq.com ([59.36.128.82]:58285 "EHLO smtpbg604.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233993AbhLENNR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 08:13:17 -0500
X-QQ-mid: bizesmtp43t1638709778t9ucelgj
Received: from wangx.lan (unknown [218.88.126.113])
        by esmtp6.qq.com (ESMTP) with 
        id ; Sun, 05 Dec 2021 21:09:36 +0800 (CST)
X-QQ-SSF: 0100000000600050B000B00A0000000
X-QQ-FEAT: LNU+aC6pWiX0Ea2evqaKvOBfzY29XxGCsTq33aafLBeBBVEFXO02z1pxw8XC1
        Y26habIse4EFBQ5ev50A8izqZkKjiyXEcRZC0k/9kcC4AZ2sjjcqNCrnMIwax8pBYTehvNi
        UWUDpZiIFT06K7cMy7qhyR9BwknnWogbWqoTkKCYPm4G59SUevZS91yUf+PZdp/ZbimBgA7
        2W+gDCnu2WATQoKl4VWuGMg9ejoqRiCtqYGjzKWFmjIxGD9TWpV9jXwzIxdOtwGh6DDfNU+
        FZj/TQvgpg4orIeJeQmBbXuiFeTpHpCbEnVRNRhsAMwikx0YqvRSs4MccA2Z+7Zo4F/m5Fi
        xmOBi7qR66OBLYwhbFYmNDJk/B9nw==
X-QQ-GoodBg: 0
From:   Xiang wangx <wangxiang@cdjrlc.com>
To:     benh@kernel.crashing.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH] macintosh:add const to of_device_id
Date:   Sun,  5 Dec 2021 21:09:25 +0800
Message-Id: <20211205130925.28389-1-wangxiang@cdjrlc.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct of_device_id should normally be const

Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
---
 drivers/macintosh/mediabay.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/macintosh/mediabay.c b/drivers/macintosh/mediabay.c
index eab7e83c11c4..b17660c022eb 100644
--- a/drivers/macintosh/mediabay.c
+++ b/drivers/macintosh/mediabay.c
@@ -703,7 +703,7 @@ static const struct mb_ops keylargo_mb_ops = {
  * Therefore we do it all by polling the media bay once each tick.
  */
 
-static struct of_device_id media_bay_match[] =
+static const struct of_device_id media_bay_match[] =
 {
 	{
 	.name		= "media-bay",
-- 
2.20.1

