Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19DEB46A071
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 17:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350175AbhLFQE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 11:04:28 -0500
Received: from www.linuxtv.org ([130.149.80.248]:33654 "EHLO www.linuxtv.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1442396AbhLFPzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 10:55:21 -0500
X-Greylist: delayed 2468 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 Dec 2021 10:55:21 EST
Received: from mchehab by www.linuxtv.org with local (Exim 4.92)
        (envelope-from <mchehab@linuxtv.org>)
        id 1muFdZ-009842-Qk; Mon, 06 Dec 2021 15:10:41 +0000
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Date:   Mon, 06 Dec 2021 15:07:04 +0000
Subject: [git:media_stage/master] media: b2c2: flexcop: Convert to SPDX identifier
To:     linuxtv-commits@linuxtv.org
Cc:     linux-kernel@vger.kernel.org, Cai Huoqing <caihuoqing@baidu.com>
Mail-followup-to: linux-media@vger.kernel.org
Forward-to: linux-media@vger.kernel.org
Reply-to: linux-media@vger.kernel.org
Message-Id: <E1muFdZ-009842-Qk@www.linuxtv.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an automatic generated email to let you know that the following patch were queued:

Subject: media: b2c2: flexcop: Convert to SPDX identifier
Author:  Cai Huoqing <caihuoqing@baidu.com>
Date:    Thu Sep 16 04:00:05 2021 +0200

use SPDX-License-Identifier instead of a verbose license text

Link: https://lore.kernel.org/linux-media/20210916020006.8497-1-caihuoqing@baidu.com

CC: Mauro Carvalho Chehab <mchehab@kernel.org>, <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

 drivers/media/common/b2c2/flexcop.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

---

diff --git a/drivers/media/common/b2c2/flexcop.c b/drivers/media/common/b2c2/flexcop.c
index cbaa61f10d5f..e7a88a2d248c 100644
--- a/drivers/media/common/b2c2/flexcop.c
+++ b/drivers/media/common/b2c2/flexcop.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  * Linux driver for digital TV devices equipped with B2C2 FlexcopII(b)/III
  * flexcop.c - main module part
@@ -15,16 +16,6 @@
  *   Uwe Bugla, uwe.bugla at gmx.de (doing tests, restyling code, writing docu)
  *   Niklas Peinecke, peinecke at gdv.uni-hannover.de (hardware pid/mac
  *               filtering)
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public License
- * as published by the Free Software Foundation; either version 2.1
- * of the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include "flexcop.h"
