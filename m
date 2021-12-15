Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F310D4754AF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 09:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241017AbhLOIyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 03:54:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240953AbhLOIym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 03:54:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A2EC061574;
        Wed, 15 Dec 2021 00:54:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D781B6185C;
        Wed, 15 Dec 2021 08:54:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23549C34607;
        Wed, 15 Dec 2021 08:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639558480;
        bh=3uWa+msGiwZKGxdA7Po3wkfv5+4QJ6nxjTenaF8FRok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=USWdZKDx1bXymhaIFissnrZeGg7PL5smlCMhE+Wc92Nd2+/wMREj2jKC29m4kjeBj
         4HUHO4jizi9rvDv8hNEZhvWHAwAVD8gpEMVxn/9LtKT9dVQF5Cb7YjXRWcw2NMzRBE
         lHX+MeKVnOtzLizRG3doxZ4xWVzi7FtyllIbfqcP2s2FdyvG4ORnPS9eFmCRrVXJQK
         GnM+uqLxgk5rdX8hqQuPLdhvQRixOXMlb6lmpzhMU0WPLsJWisKJ3X4FvKWu1+eZ32
         jxIyNIeDCS28P2Qpt81Riw+IGyvlmRdH0UTZerP4Pen0OALAWGOCCzCtsLgDfvz6KD
         3ryor3WScbnaQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mxQ3Z-0054Hv-Ln; Wed, 15 Dec 2021 09:54:37 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 2/7] dt-bindings: clock: hi3670-clock.txt: add pmctrl compatible
Date:   Wed, 15 Dec 2021 09:54:28 +0100
Message-Id: <3bbfdbd02eea5af71cb37b525be330c864395285.1639558366.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1639558366.git.mchehab+huawei@kernel.org>
References: <cover.1639558366.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a compatible for the Power Management domain controller,
which is needed in order to control power for the PCI devices
on HiKey 970.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH RESEND 0/7] at: https://lore.kernel.org/all/cover.1639558366.git.mchehab+huawei@kernel.org/

 Documentation/devicetree/bindings/clock/hi3670-clock.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/hi3670-clock.txt b/Documentation/devicetree/bindings/clock/hi3670-clock.txt
index 66f3697eca78..8e9f12a3ba5b 100644
--- a/Documentation/devicetree/bindings/clock/hi3670-clock.txt
+++ b/Documentation/devicetree/bindings/clock/hi3670-clock.txt
@@ -15,6 +15,7 @@ Required Properties:
 	- "hisilicon,hi3670-iomcu"
 	- "hisilicon,hi3670-media1-crg"
 	- "hisilicon,hi3670-media2-crg"
+	- "hisilicon,hi3670-pmctrl"
 
 - reg: physical base address of the controller and length of memory mapped
   region.
-- 
2.33.1

