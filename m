Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3A84757FE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 12:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242139AbhLOLip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 06:38:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242154AbhLOLif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 06:38:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B60C06173E;
        Wed, 15 Dec 2021 03:38:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D87A5618A9;
        Wed, 15 Dec 2021 11:38:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B93DEC34605;
        Wed, 15 Dec 2021 11:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639568314;
        bh=4uMRQl6jrlsCb+mkulMxgC/glcw+odyDDSuOszbDlHk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TZEkl0BRjq3cQ0R68fMM3e3uIAAixV19tqcLChRNtvBo6FfYeERyj/MABOu9vtpGT
         jnnYhj6TEmv1Zk3psmnw309hKpBtkPEPeTBIMScWXd4RPEHvZpIbjDre7RR4m5hdTp
         EISFlus0N9ryfZwt+bRvLk2csNM5ma/R0tTPHuKVXHVwNIaFL2SHMC28aCYnIYZTGT
         8FCKR9ajN3Qy/Mos4GZvcffhgDEtPUtXNbYqjGQQKEJilWo4jjHRP0+h0gDabcGHqt
         6JQoDuEMzMkRdnrrABNynRxBUFriEUcf3cfVlLZse5oiQoW05fZOwmQsYhqlHrJI/W
         Bw872xraUnDag==
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] clk: qcom: q6sstop-qcs404: explicitly include clk-provider.h
Date:   Wed, 15 Dec 2021 17:08:02 +0530
Message-Id: <20211215113803.620032-8-vkoul@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211215113803.620032-1-vkoul@kernel.org>
References: <20211215113803.620032-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Per Stephen, clk providers need to include clk-provider.h, so include in
this driver as well

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/clk/qcom/q6sstop-qcs404.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/qcom/q6sstop-qcs404.c b/drivers/clk/qcom/q6sstop-qcs404.c
index 507386bee07d..780074e05841 100644
--- a/drivers/clk/qcom/q6sstop-qcs404.c
+++ b/drivers/clk/qcom/q6sstop-qcs404.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/bitops.h>
+#include <linux/clk-provider.h>
 #include <linux/err.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
-- 
2.31.1

