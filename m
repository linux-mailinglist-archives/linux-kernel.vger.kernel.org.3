Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDF3A476C0D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 09:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234900AbhLPIfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 03:35:30 -0500
Received: from smtpbg604.qq.com ([59.36.128.82]:39650 "EHLO smtpbg604.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229739AbhLPIfa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 03:35:30 -0500
X-QQ-mid: bizesmtp42t1639643591t2wqagec
Received: from wangx.lan (unknown [218.88.124.63])
        by esmtp6.qq.com (ESMTP) with 
        id ; Thu, 16 Dec 2021 16:33:04 +0800 (CST)
X-QQ-SSF: 0100000000200090C000000A0000000
X-QQ-FEAT: 3uawQE1sH+3zorxK16b2U3h6zpzpeZk3B/nEX8RAutKOb06jgtfo0MhcLoUzX
        ntE9sw3AHToNqGmUa1vNX544/C5xpkLhwBAH2kMj0GjcU6/w7aV/wGYZJv+liXhkHXQIikv
        4SUIpGndU7eBB3TLkdS6h+U+kq5y+BIDi8G3J74QfXBU4kDF50keElPOSIrau2Ko8Nx/6WW
        dul0ix7j8+7621vzgdfkat5lfKuczi0vA/V6uKlB/bw0lfjoKChMC2TYbA0gmFEkuitN0TB
        iQdcpnWhGxqq+vJg80fq31EkwU3I2wUh3QxDWqxcRkKHf6dfsQGvy/CANIKlIbDr4+EFZQ8
        vvS8TEBCddi5I2v2U2412pX9La9Bw==
X-QQ-GoodBg: 0
From:   Xiang wangx <wangxiang@cdjrlc.com>
To:     will@kernel.org
Cc:     jean-philippe@linaro.org, joro@8bytes.org,
        virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH] iommu/virtio: Fix typo in a comment
Date:   Thu, 16 Dec 2021 16:33:02 +0800
Message-Id: <20211216083302.18049-1-wangxiang@cdjrlc.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `as' in a comment is repeated, thus it should be removed.

Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
---
 drivers/iommu/virtio-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index c9e8367d2962..162bd07e32fe 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -743,7 +743,7 @@ static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 
 	/*
 	 * In the virtio-iommu device, when attaching the endpoint to a new
-	 * domain, it is detached from the old one and, if as as a result the
+	 * domain, it is detached from the old one and, if as a result the
 	 * old domain isn't attached to any endpoint, all mappings are removed
 	 * from the old domain and it is freed.
 	 *
-- 
2.20.1

