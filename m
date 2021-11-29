Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83B124611CB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 11:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346915AbhK2KLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 05:11:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbhK2KJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 05:09:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30A3C0698C6;
        Mon, 29 Nov 2021 01:47:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 547F361290;
        Mon, 29 Nov 2021 09:47:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A30A6C58331;
        Mon, 29 Nov 2021 09:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638179276;
        bh=2LbnBBSEprT+n2sIqoaoyoxqkrmW/XjL0iFXZjWwGek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ONVt5nNkK6jo1KHw1IDlOZ0hsEptJV1u/0U0OYNV1rzYP5++IA9TZKc75QK7fIMq6
         pqwNiCT1hdgoLNc9HOpUfJqXaTVd6CCkh0cPoKc5RfNA1DixTj4/l/R1PAwSDo1Khe
         mTVKBbQFPke0kx0ywPOf+NuDaAfa7ZkpRdKzE8ThNgcfZDxUBV9NHQ+9cdTLys8nCK
         j3h6TjYjQlfpQb8u7ON2bU4mvtTrH1vy90J4Br//5GjFDJcQzQFSLtYyll6+SdTa2H
         OLnHWN7IzEhHCIsCHCObQPoTv5O3ZCqlRS19KhZeLGRftVkMXq+iovRH5TxFNQbY6E
         u56UMEkf5zEjw==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mrdGM-000RBW-I2; Mon, 29 Nov 2021 10:47:54 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Xiaofeng Cao <caoxiaofeng@yulong.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH v2 10/20] media: radio-si476x: drop a container_of() abstraction macro
Date:   Mon, 29 Nov 2021 10:47:42 +0100
Message-Id: <494171479348cc4d7aea22c51256d8028cbb249b.1638179135.git.mchehab+huawei@kernel.org>
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

This isn't used anywhere. So, drop it.

Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

See [PATCH v2 00/20] at: https://lore.kernel.org/all/cover.1638179135.git.mchehab+huawei@kernel.org/

 drivers/media/radio/radio-si476x.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/media/radio/radio-si476x.c b/drivers/media/radio/radio-si476x.c
index b39a68f83c5f..0bf99e1cd1d8 100644
--- a/drivers/media/radio/radio-si476x.c
+++ b/drivers/media/radio/radio-si476x.c
@@ -312,12 +312,6 @@ struct si476x_radio {
 	u32 audmode;
 };
 
-static inline struct si476x_radio *
-v4l2_dev_to_radio(struct v4l2_device *d)
-{
-	return container_of(d, struct si476x_radio, v4l2dev);
-}
-
 static inline struct si476x_radio *
 v4l2_ctrl_handler_to_radio(struct v4l2_ctrl_handler *d)
 {
-- 
2.33.1

