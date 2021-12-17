Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D431D47887A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 11:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234758AbhLQKM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 05:12:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234738AbhLQKM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 05:12:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BEAAC06173E;
        Fri, 17 Dec 2021 02:12:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 06DB6620E5;
        Fri, 17 Dec 2021 10:12:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C8ECC36AEA;
        Fri, 17 Dec 2021 10:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639735975;
        bh=dH8n7XUB1hLxYi6SAGbwQxNYY+TqA+ySoHz3F9+B+do=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cQzyhvI5KJkFziFEyLauhMS8wcVOFeE007vOX8MrViQtCpyuUd2WxMSDRRuxWxBuW
         D9MrOGC82RmQ4bhs3j3XMObXD0DExnJD4XnxjYOaeaUSwKoIw0fPjhGqNSX9u+FIqC
         j+DvpSymDKCjsd9AyIRF7Fnz05sCmLm7VHdIKV5eAYDsep5DB18sYr+9cOk0katxM1
         z0v6LrnOLGHczpW3Pc+2aeiSOfoZQEJ/WgHQOyvE1mTt+/tn4/tpIwMfWuKBKofUQp
         1TPxz95FZimnV9CDD6nlf7VJM7zvw1uWK8RyxPdzanaDN1GP4zEqfbmTLbPcno88uD
         Ef4hxz57kyE5Q==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1myAEP-000g6B-6k; Fri, 17 Dec 2021 11:12:53 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH v2 2/7] dt-bindings: clock: hi3670-clock.txt: add pmctrl compatible
Date:   Fri, 17 Dec 2021 11:12:46 +0100
Message-Id: <3495df40d10eecb2326cd0ef002cc708244c0fd8.1639735742.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1639735742.git.mchehab@kernel.org>
References: <cover.1639735742.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Add a compatible for the Power Management domain controller,
which is needed in order to control power for the PCI devices
on HiKey 970.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

See [PATCH v2 0/7] at: https://lore.kernel.org/all/cover.1639735742.git.mchehab@kernel.org/

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

