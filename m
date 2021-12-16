Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD6B477C30
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 20:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240851AbhLPTIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 14:08:16 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:44998 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240836AbhLPTIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 14:08:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 789F461F4D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 19:08:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5123C36AE7;
        Thu, 16 Dec 2021 19:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639681693;
        bh=z8RfWHlxYoaJccJ5Gvi2rpWAAIFFF1L8l5IOgcQ6RUk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p40WsmFNy5YIuu7lCuM2pnxvJ3pvSdxvlNNO99ZUPRzp1YlOaW0CCj8flnNBa1Ode
         V0fz6M3a1RoW3f+39MOU2VNHUjtPLbry63d4JpqCKMG58hL8fKBw3iY+C2jJDlaprS
         6MWgkh0B3KtkXMabOF+jxQrqqGm/+Qb5wmHZdDYfZvRUA/o1fwmgIRIMgGKIED2pzz
         /gBbtpmVCSyBnlvl+6k3N+q0zCN9OoBfcX9uZCQkFmmRBo9al+J5CdfTauSoWyJlWH
         UDoS7e8ZJ0LvbA6zNCZH59VqiGFBVXkpbxnsQUNm/fmyOXXC1iXhVTo+YLdVYcceUG
         kzUmJz+tLhr+g==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     James Lo <james.lo@mediatek.com>, linux-kernel@vger.kernel.org,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 2/6] dt-bindings: spmi: remove the constraint of reg property
Date:   Thu, 16 Dec 2021 11:08:08 -0800
Message-Id: <20211216190812.1574801-3-sboyd@kernel.org>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
In-Reply-To: <20211216190812.1574801-1-sboyd@kernel.org>
References: <20211216190812.1574801-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Lo <james.lo@mediatek.com>

'reg' is controller specific so we shouldn't even be specifying it here.
Just remove it.

Signed-off-by: James Lo <james.lo@mediatek.com>
Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20211119034613.32489-2-james.lo@mediatek.com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 Documentation/devicetree/bindings/spmi/spmi.yaml | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/spmi/spmi.yaml b/Documentation/devicetree/bindings/spmi/spmi.yaml
index 1d243faef2f8..c1b06fa5c631 100644
--- a/Documentation/devicetree/bindings/spmi/spmi.yaml
+++ b/Documentation/devicetree/bindings/spmi/spmi.yaml
@@ -24,9 +24,6 @@ properties:
   $nodename:
     pattern: "^spmi@.*"
 
-  reg:
-    maxItems: 1
-
   "#address-cells":
     const: 2
 
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

