Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E79858D74D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 12:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242292AbiHIKSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 06:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242226AbiHIKSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 06:18:38 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AEC71F2ED;
        Tue,  9 Aug 2022 03:18:37 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 8A776320005D;
        Tue,  9 Aug 2022 06:18:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 09 Aug 2022 06:18:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=undef.tools; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1660040313; x=1660126713; bh=cSaKIuo8NVh4MYoCKJvrALvtp
        B3Wd3w5fB6WP0MFulE=; b=bjVSMc97VVSRBzi5hSU1RTjrxz9pp8XG3pM/3+8db
        UCHHxeiLfl7/OEH4X5H4Mz0ZzXyCUJSoETDrZLnr+nq7RMZpkqqnP2GNnNP2ouoJ
        rCT38ATQbwe10pjOIjLoeNKCm7MRoTd/825AFIW3mOy3sOJSZC91bwWQBLdHJnwe
        AO5DNvhpFQK8W9oHqNK4iVOozwf1Y+TacDH8QE8LjNS/dHhPdiCGwir9OoVywqUk
        yB8A6jC6o3HOL5ON/iK8oPdsW77R7ehvBQJW4R74q80/lzJ0KSXfY37WM7BP8wq2
        8nBoKF5hdnSEjr6o0jTWh6kd45DbgEp8UMjy2B2XvifFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1660040313; x=1660126713; bh=cSaKIuo8NVh4MYoCKJvrALvtpB3Wd3w5fB6
        WP0MFulE=; b=cDXDx/ySgJ5LBTUjuN2h6DHGhxSvhlz6dKm55pjpdBn/NUiQihN
        RpmUXBZjKcxhFoyolL9wytXPmxSG61mg2PIDaNZozYqTHaDWM5GWeS0mbiujafQf
        n14t4cfGgp3jQ+OF8xVuly/XbEaXEBp1W1HhlOA7dCOnDFb39XJ7BGYTztM6rpw1
        SDKCoGTetFbh8TTtiwOUcnLSBKph720RB0s8EOp1nIF+2z2P55FuZBRW5y+3gtS0
        GdPjK/VOszUz9VTZ7bH8xt9fPHjNyo0xShC5CdhUqcZexW3qtCjcq88MYXG8QSAg
        FXTP5ByyRKaBE+Eba2QL0YfTDHTiSPsuwhw==
X-ME-Sender: <xms:eDTyYlymtfXLxhjbJTUyDEvHHpm2NLrWCrf5m6oRUpOnvjq1BGI-xA>
    <xme:eDTyYlSZlD4m9gm7QEu3sjLeQtqK5UvaYJ-_Hdsslnnl0uqEQt_ut4FyYvgFzydon
    IHe9pAqql_Lc9CDucw>
X-ME-Received: <xmr:eDTyYvUY1093cc0QUPnT8Tz85G0MNbcHGuxFb_OcE6QY6lmB9Amzjild0HIodWHzdMJFRUCeL7vg0WDnZ1oKB-DkPeBEqRJHUnajcaeZkwmBU5C6zQAAIHS3vA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdegtddgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpehkvghrnhgvlhesuhhnuggvfhdrthhoohhlshenucggtffrrght
    thgvrhhnpeduleegkeevheeifefhheeluedvjeevvdeuheeuheeuvdduveduhfegffegtd
    dutdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepkhgvrhhnvghlsehunhguvghfrdhtohholh
    hs
X-ME-Proxy: <xmx:eDTyYngqwfuzaVh9wK_O7YbzJrQyW1d1YJJxRyYHQiMIlP1RKCvZpw>
    <xmx:eDTyYnCpSjDezdHwfdF70_WiHy4ctl6Fn3PBqLMjc33HltHOsXekcQ>
    <xmx:eDTyYgJhK3j_9K466iiWlK2q2D7_ehGmd_EAwtcYy1H8dWmMBKHhGA>
    <xmx:eTTyYp1aiVvbH92ciOKSKIjNWNGjujJUdoVvCKfIFnMvbLYcB4FblQ>
Feedback-ID: id76147eb:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Aug 2022 06:18:30 -0400 (EDT)
From:   kernel@undef.tools
To:     hadess@hadess.net, hdegoede@redhat.com, dmitry.torokhov@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     phone-devel@vger.kernel.org, megi@xff.cz,
        Jarrah Gosbell <kernel@undef.tools>
Subject: [PATCH] dt-bindings: input: touchscreen: add compatible string for Goodix GT1158
Date:   Tue,  9 Aug 2022 10:16:34 +0000
Message-Id: <20220809101633.352315-1-kernel@undef.tools>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jarrah Gosbell <kernel@undef.tools>

Goodix GT1158 is a touchscreen chip from Goodix used in the PinePhone
and PinePhone Pro. Patches to correct these devices dts files will be
sent in a later patch series.

This driver was modified to support the GT1158 in the patch linked
below. Add its compatible string to the device tree binding.

Suggested-by: Ondrej Jirman <megi@xff.cz>
Signed-off-by: Jarrah Gosbell <kernel@undef.tools>
Link: https://lore.kernel.org/phone-devel/20220809091200.290492-1-kernel@undef.tools/
---
 Documentation/devicetree/bindings/input/touchscreen/goodix.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.yaml b/Documentation/devicetree/bindings/input/touchscreen/goodix.yaml
index 93f2ce3130ae..19ac9da421df 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/goodix.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.yaml
@@ -16,6 +16,7 @@ properties:
   compatible:
     enum:
       - goodix,gt1151
+      - goodix,gt1158
       - goodix,gt5663
       - goodix,gt5688
       - goodix,gt911
-- 
2.35.1

