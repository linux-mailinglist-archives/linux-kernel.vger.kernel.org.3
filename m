Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F30A746B8FD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 11:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235133AbhLGKbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 05:31:44 -0500
Received: from www.linuxtv.org ([130.149.80.248]:40880 "EHLO www.linuxtv.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235124AbhLGKbn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 05:31:43 -0500
Received: from mchehab by www.linuxtv.org with local (Exim 4.92)
        (envelope-from <mchehab@linuxtv.org>)
        id 1muXhi-00APIy-JM; Tue, 07 Dec 2021 10:28:10 +0000
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Date:   Tue, 07 Dec 2021 10:27:08 +0000
Subject: [git:media_stage/master] media: b2c2: flexcop: Convert to SPDX identifier
To:     linuxtv-commits@linuxtv.org
Cc:     linux-kernel@vger.kernel.org, Cai Huoqing <caihuoqing@baidu.com>
Mail-followup-to: linux-media@vger.kernel.org
Forward-to: linux-media@vger.kernel.org
Reply-to: linux-media@vger.kernel.org
Message-Id: <E1muXhi-00APIy-JM@www.linuxtv.org>
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
