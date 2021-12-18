Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A25F24799A5
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 09:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbhLRIP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 03:15:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbhLRIP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 03:15:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829ABC061574;
        Sat, 18 Dec 2021 00:15:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 37606B80176;
        Sat, 18 Dec 2021 08:15:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DECE3C36AE1;
        Sat, 18 Dec 2021 08:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639815355;
        bh=HYrFoZHYUYlXc44YFnFqBufY+oh5rcfMio9k12chSNs=;
        h=From:To:Cc:Subject:Date:From;
        b=hL1oDTStOuDAPwSDvcF+ZbWPQ8xRrjRWonifZ5GZXS+AQafEAEwc3LHXj21hmWt14
         JNEScmKR0C336CcCPxqnKZ9xdYToKhLFntRm1MI67Z8utYfDGnNwX+0idRKmFiPqBr
         hOTwGqZ+JgVPmyZxM5j730jJp/Ad53GtXgxUdwxadTFyrXzyc3dUhQXW2zG5kG7gVb
         U2COcORHFXw/NtqwSzhX0YUBykYy+oJF/+Umk0XiBPCjQV0hlCftWGSmpNlz/itKaj
         p+MHSxSATmxQKIrCmS66o2HySVacfjlNaH0xTCrosBMzmS+rN8aQb7KHoFrWejKv9B
         c3MjD9nbZHCag==
From:   matthias.bgg@kernel.org
To:     lee.jones@linaro.org, robh+dt@kernel.org, bleung@chromium.org,
        groeck@chromium.org
Cc:     matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <mbrugger@suse.com>
Subject: [PATCH] mfd: google,cros-ec: fix property name for MediaTek rpmsg
Date:   Sat, 18 Dec 2021 09:15:43 +0100
Message-Id: <20211218081543.3851-1-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <mbrugger@suse.com>

The MediaTek rpmsg-name is defined as mediatek,rpmsg-name in
mtk,scp.yaml. Fix the binding documentation to match the new property

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 Documentation/devicetree/bindings/mfd/google,cros-ec.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
index d793dd0316b7..0faa4da6c7c8 100644
--- a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
+++ b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
@@ -59,7 +59,7 @@ properties:
       whether this nvram is present or not.
     type: boolean
 
-  mtk,rpmsg-name:
+  mediatek,rpmsg-name:
     description:
       Must be defined if the cros-ec is a rpmsg device for a Mediatek
       ARM Cortex M4 Co-processor. Contains the name pf the rpmsg
-- 
2.33.1

