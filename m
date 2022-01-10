Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33C4D48992A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 14:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236223AbiAJNC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 08:02:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234718AbiAJNA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 08:00:59 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB793C061756;
        Mon, 10 Jan 2022 05:00:05 -0800 (PST)
Date:   Mon, 10 Jan 2022 13:00:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1641819604;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lCo07g1Znfpz0lYy1Qed2eAadMwCdwfxYlZqwyowRhk=;
        b=spSOr2w5DBDpooRAKglYikxjntMG+mYDibk5DeGLVBYrEmBUwNVv279p7HERbRFjmuTy48
        eIfG7xoCvZ/oGL1GFVLqLuk5keblVSFwSp/JNYADJE81jI+YlPYj9E9oicpqniI7EoM7LY
        LabbboXMLUEmxvhghP+Ll1oosOmlkjKC0+4JCeFay5F9X+BT9PDC9sfNp+A6bv/NiObKMR
        6kJV0mc6xV5ywMmvJmLGZcQqlZdZfwAseOhml3LgVF2Xq4uwADNiVotdZtzEOnRDJh2E+x
        AvjnQWbC568QsL72nv1wul125wr/hZur3vd0fp45DRys2afWnWq+ytwzmsajCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1641819604;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lCo07g1Znfpz0lYy1Qed2eAadMwCdwfxYlZqwyowRhk=;
        b=aIov/RAleIkSDGNYaKBxezxlyJaUF8kKRoNTFDf6tNY1c/aaUD2RWunSVpxHc+67MXh2qG
        XMrhmSPgW99bHtCw==
From:   "tip-bot2 for Michal Simek" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] dt-bindings: timer: cadence_ttc: Add power-domains
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Rob Herring <robh@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Ccc655a72b20790f6d7408b1aaf81c4bf878aafb4=2E16342?=
 =?utf-8?q?86552=2Egit=2Emichal=2Esimek=40xilinx=2Ecom=3E?=
References: =?utf-8?q?=3Ccc655a72b20790f6d7408b1aaf81c4bf878aafb4=2E163428?=
 =?utf-8?q?6552=2Egit=2Emichal=2Esimek=40xilinx=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <164181960275.16921.16550710534449933629.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     557804a81d256b15952dcd179280ede92a5bfae1
Gitweb:        https://git.kernel.org/tip/557804a81d256b15952dcd179280ede92a5bfae1
Author:        Michal Simek <michal.simek@xilinx.com>
AuthorDate:    Fri, 15 Oct 2021 10:29:14 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 02 Nov 2021 10:03:25 +01:00

dt-bindings: timer: cadence_ttc: Add power-domains

Describe optional power-domain property to fix dts_check warnings.
The similar change was done by commit 8c0aa567146b ("dt-bindings: gpio:
fsl-imx-gpio: Add power-domains").

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Acked-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/cc655a72b20790f6d7408b1aaf81c4bf878aafb4.1634286552.git.michal.simek@xilinx.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/timer/cdns,ttc.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/cdns,ttc.yaml b/Documentation/devicetree/bindings/timer/cdns,ttc.yaml
index 8615353..c338607 100644
--- a/Documentation/devicetree/bindings/timer/cdns,ttc.yaml
+++ b/Documentation/devicetree/bindings/timer/cdns,ttc.yaml
@@ -25,6 +25,9 @@ properties:
   clocks:
     maxItems: 1
 
+  power-domains:
+    maxItems: 1
+
   timer-width:
     $ref: "/schemas/types.yaml#/definitions/uint32"
     description: |
