Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7B2547717D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 13:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235688AbhLPMRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 07:17:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234080AbhLPMRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 07:17:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17276C061574;
        Thu, 16 Dec 2021 04:17:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 60B2A61DB3;
        Thu, 16 Dec 2021 12:17:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA73BC36AE3;
        Thu, 16 Dec 2021 12:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639657058;
        bh=0PblDFUSk6tR9MbKqGi6nRLB+EFheDGBY1aZlUgXFZQ=;
        h=From:To:Cc:Subject:Date:From;
        b=RHVd3kVVaXp6Vwop3VjZhJGZ543u7Ef7W0zfkSAu/tkLojdF4Wg4nFwcz3LkXs5vN
         5Z0WxHoZv2e9cxDtGPJVUgdMLJp5qr2HBUfEEDh6j/uyZK4SJdP6vdf5Yqj0l54p+M
         Xi4XByiErqGTJ/alVGXHyS9Fc1NM9rtY7H/wddPcwIim8TDVBpuJ4DKTLTDJJ+nO3b
         DPJSPCLO8S+0Je0iuV0de2qQykJnaKYWKPY6JwPO9sm65b6Vi9RDIzRhxXJZJDp6me
         lz09SCPXixkH51CaoeY1EU2iXBWv+w06BQ1zyJvkScUaAz3LqOvk4XysG6U6F7CYhG
         V2f/uuUZug9Bw==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mxphY-005chw-Iu; Thu, 16 Dec 2021 13:17:36 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Cai Huoqing" <caihuoqing@baidu.com>,
        "Lukas Bulwahn" <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org, linux-spdx@vger.kernel.org
Subject: [PATCH v3] LICENSES/LGPL-2.1: Add LGPL-2.1-or-later as valid identifiers
Date:   Thu, 16 Dec 2021 13:17:35 +0100
Message-Id: <12f38ebde4dcd8b1ecbd37df1b6ce2018426f6dd.1639657049.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some files have been flagged with the new LGPL-2.1-or-later
identifier which replace the original LGPL-2.1+ in the SPDX license
identifier specification, but the identifiers are not mentioned as
valid in the LGPL-2.1 license file.

Add it, together with the LGPL-2.1-only at the the license file.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 LICENSES/preferred/LGPL-2.1 | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/LICENSES/preferred/LGPL-2.1 b/LICENSES/preferred/LGPL-2.1
index 27bb4342a3e8..b73f9b6230f5 100644
--- a/LICENSES/preferred/LGPL-2.1
+++ b/LICENSES/preferred/LGPL-2.1
@@ -1,5 +1,7 @@
 Valid-License-Identifier: LGPL-2.1
+Valid-License-Identifier: LGPL-2.1-only
 Valid-License-Identifier: LGPL-2.1+
+Valid-License-Identifier: LGPL-2.1-or-later
 SPDX-URL: https://spdx.org/licenses/LGPL-2.1.html
 Usage-Guide:
   To use this license in source code, put one of the following SPDX
-- 
2.33.1

