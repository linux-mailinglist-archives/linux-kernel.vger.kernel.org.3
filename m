Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A685649A85D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1318150AbiAYDEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 22:04:41 -0500
Received: from msg-1.mailo.com ([213.182.54.11]:38846 "EHLO msg-1.mailo.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S3415606AbiAYBsy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 20:48:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailoo.org; s=mailo;
        t=1643059591; bh=z2N8AFm6BKjIW6yLTb4o2Nvq1Bhr1Z1MkQ0IL+yIuDw=;
        h=X-EA-Auth:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
         References:MIME-Version:Content-Transfer-Encoding;
        b=A58/lCoBYsCKzvo2qIUZFX5RSk8D6qhkHqqzPjBdVRTvZBeFIUpO0XMCwr8KTriCg
         zxJtdR1GK/+sh1rYi8FVr55BQ2fflKTJKesK3/g0DvdaNq4+OAkL2nfkUKPTtMKm70
         vtsmcQ6zj6Yj/PqYBklLY2alKbYClXa05XRfsuQk=
Received: by b-5.in.mailobj.net [192.168.90.15] with ESMTP
        via proxy.mailoo.org [213.182.55.207]
        Mon, 24 Jan 2022 22:26:31 +0100 (CET)
X-EA-Auth: xN/soZ7g5/FwWb7FyMsA8grkgZp7zMu0jHmpPenAVYqC9/vvQcjEQNdQbQUVICgJMytb0GNfJ5JW0blANF72ExR5NwoqP3SlWQSmW7LtIvA=
From:   Vincent Knecht <vincent.knecht@mailoo.org>
To:     dmitry.torokhov@gmail.com, stephan@gerhold.net
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 4/5] dt-bindings: input: touchscreen: msg2638: Document keys support
Date:   Mon, 24 Jan 2022 22:26:10 +0100
Message-Id: <20220124212611.752603-5-vincent.knecht@mailoo.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124212611.752603-1-vincent.knecht@mailoo.org>
References: <20220124212611.752603-1-vincent.knecht@mailoo.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document optional linux,keycodes support.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
---
v2:
- picked up Rob's Ack
---
 .../devicetree/bindings/input/touchscreen/mstar,msg2638.yaml  | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/mstar,msg2638.yaml b/Documentation/devicetree/bindings/input/touchscreen/mstar,msg2638.yaml
index 2fb7e01bb65a..af4f954de958 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/mstar,msg2638.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/mstar,msg2638.yaml
@@ -36,6 +36,10 @@ properties:
   touchscreen-size-x: true
   touchscreen-size-y: true
 
+  linux,keycodes:
+    minItems: 1
+    maxItems: 4
+
 additionalProperties: false
 
 required:
-- 
2.34.1



