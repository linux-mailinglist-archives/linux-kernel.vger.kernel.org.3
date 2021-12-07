Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5F746B5FC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 09:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232856AbhLGIci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 03:32:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhLGIch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 03:32:37 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5A9C061746;
        Tue,  7 Dec 2021 00:29:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id AA931CE19FC;
        Tue,  7 Dec 2021 08:29:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEBC1C341C6;
        Tue,  7 Dec 2021 08:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638865743;
        bh=Jyne4LKUAq3BVvN2/aaEgD7olzdlQToMeMzYv2oyrHY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pdpqQkBSOLuZ3tMb4PW5ip4CRKVrF1WatuDjFMKKKS3wy24qywPrw7ic1gjIcDi7H
         ggoAoodHve18NoJ4QApXatrBe47UksvlZG/ZIhVNipfrzk99tsmoDuiOodLCw7Q7ou
         6HpEb9Nfo6NCwixbBcBieQai9i+NGXTU+pUC6qJLkBTqVn68iWYg5mSWWZc7BTm5Qa
         EzO1HfCmjezQtCAl4PIENR5/7IVkipsA55o91FCqY1ALC+bOSXGK+tFoTrv/ITCaeL
         7aGv4/CmNmOyAtkJDqCzlvxdqEhv/rt5ZPl/nkIcXxe3xqdpKRYBUNkv8UwG9B7pHs
         /YZ7mRkXONF0w==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1muVqO-00BUe6-VW; Tue, 07 Dec 2021 09:29:00 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Wei Xu" <xuwei5@hisilicon.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] bindings: clock: hi3670-clock.txt: add pmctrl compatible
Date:   Tue,  7 Dec 2021 09:28:59 +0100
Message-Id: <3bea78162ce721fff2d14ff83b11d3f982c25f2f.1638865711.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <61AF16AC.1080506@hisilicon.com>
References: <61AF16AC.1080506@hisilicon.com>
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

