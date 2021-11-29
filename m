Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7E7461167
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 10:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349934AbhK2Jx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 04:53:57 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:34610 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245377AbhK2JvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 04:51:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 11201B80E70;
        Mon, 29 Nov 2021 09:47:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3D3AC58334;
        Mon, 29 Nov 2021 09:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638179276;
        bh=saFeHFW6YIuQRRVUW9F5rGW6Xsrq+9cWY9rHYQr/MjA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kgyMz/XtYIHS5P2y6KuGpHbvSkMIx48H8roSDgkCoqmRWtoXUa8cWwjivaDYCWo8Q
         DJ9VE5fWGMc6y6CHIamWtXUkCtg7hLZYc9wMQnIyAMrMySsBc/uuUd3kwy+cbVxo23
         T708FErwhWzgJD1Tbn9OEA4qyV4gQATWvMePATH7ISoIG50h/X+JyRKZk8Rx5k5V6n
         y8MmlkXuefjtGTi7C/D4VF9gKe15SgacupDBCBBQdJtNsp9l8YzsuPiGZhVlJRVtsy
         MBUH3sx0siWX+lTxv74mQD7sIBqTp5zzxmrQWSsMmzLmMpzXvGHfHCLkTonEUsaf5L
         U7nvyUoIRsQNw==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mrdGM-000RBe-Ko; Mon, 29 Nov 2021 10:47:54 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH v2 12/20] media: au0828-i2c: drop a duplicated function
Date:   Mon, 29 Nov 2021 10:47:44 +0100
Message-Id: <644a5d27b84bfc10219c2c9583fa61d06615de1f.1638179135.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1638179135.git.mchehab+huawei@kernel.org>
References: <cover.1638179135.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function is not used, so, just drop it.

Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

See [PATCH v2 00/20] at: https://lore.kernel.org/all/cover.1638179135.git.mchehab+huawei@kernel.org/

 drivers/media/usb/au0828/au0828-i2c.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/media/usb/au0828/au0828-i2c.c b/drivers/media/usb/au0828/au0828-i2c.c
index 708f01ab47fa..749f90d73b5b 100644
--- a/drivers/media/usb/au0828/au0828-i2c.c
+++ b/drivers/media/usb/au0828/au0828-i2c.c
@@ -23,13 +23,6 @@ MODULE_PARM_DESC(i2c_scan, "scan i2c bus at insmod time");
 #define I2C_WAIT_DELAY 25
 #define I2C_WAIT_RETRY 1000
 
-static inline int i2c_slave_did_write_ack(struct i2c_adapter *i2c_adap)
-{
-	struct au0828_dev *dev = i2c_adap->algo_data;
-	return au0828_read(dev, AU0828_I2C_STATUS_201) &
-		AU0828_I2C_STATUS_NO_WRITE_ACK ? 0 : 1;
-}
-
 static inline int i2c_slave_did_read_ack(struct i2c_adapter *i2c_adap)
 {
 	struct au0828_dev *dev = i2c_adap->algo_data;
-- 
2.33.1

