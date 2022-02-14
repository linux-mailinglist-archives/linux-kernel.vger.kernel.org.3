Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D944B40AD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 05:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240193AbiBNEXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 23:23:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbiBNEXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 23:23:11 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30CF24F447;
        Sun, 13 Feb 2022 20:23:05 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 4F18A3200EE0;
        Sun, 13 Feb 2022 23:23:04 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sun, 13 Feb 2022 23:23:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; bh=lVaHFA9dpN1+ualx0PERcky6iFY7uk
        r9+kD1f5ekw6E=; b=kQgks+vZrkTaqzD7F+mnHp/WsWLKA1dZwpVHW/z4ClsBnc
        cIKlTe9p0R4ggYP5N92CDJy90WA5TBENWf84bRH8pYxydu38XAUifHMcwsplUZ53
        RyMl4gx7jbgFsTgN7yU19F2OzU4emCJEt99oGc6xcATP7rFOkxEsLGvS9YaJF4DQ
        tZc9SH4J29p85OxW9WQrwX3p9feKM6gnJotuJi58DGe8yPpQPrWq8EpkPwtlUJE6
        PgFzaY0m8KNcKtl7n8YwD+5fCBXNeckJtI89qWkLBblp3OyB2wSbOKUZL5/Tnwkp
        XYJ2rzrTbBRqBdmlbwsnXChfuRTzpJvt38rK5A2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=lVaHFA
        9dpN1+ualx0PERcky6iFY7ukr9+kD1f5ekw6E=; b=coEvEt3GqFsUIt4cNTULaL
        N0kQF1iZCMqFXnX8jn2b9ipGsKU8Jy4B9g64aWpYp494HHiUUx8/3LyfVfwEuQcL
        YoyZfM0VEnlgBnf0q+4VXRIxCkk47WOqvZU9r7TiMUr1AqOUgRD9vzirzrpItGqf
        XmFCGDlzyso7udxC00IhQZJ1gaOLldAeGnYtn+6b5mdNfGbyc+Edr/6d+pp23qdY
        no8id2Cw/4Qg0zFtuKjbt9UJx/OlIsJ2kvv0YhEmSYwZ8+bgeFf8cna3XSllc0rO
        u2P1uV5+ce+dCrpLG7Xsegv4svYAWRlx0uTHhw7Y6VlQpcXUbqflneVGDXpqpL8Q
        ==
X-ME-Sender: <xms:J9kJYnzzb_SusJtDBezV-U8mXH6_6phOGFhLDWcrkhWTKSdPFLhFgw>
    <xme:J9kJYvQvsu4oppxBARWqtNp4WOORxVxHk3RMwoPN5bIytYQNUUy3xge7YFwiUoDZa
    Doy50WHoKoTpMWJYw>
X-ME-Received: <xmr:J9kJYhX7Q30gTjY7niuCh3r36bNBqyZbNX7boGK3FoZvMqZshreFL_lf0rBK32BGLb-VS8Vn_SaRD8YKxPVl0kq9VI5NMynj18KWMful0johmJ_3xVxLu6zE1_XzNaAB9nL0bQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrjedugdejtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepudfhjeefvdfhgfefheetgffhieeigfefhefgvddvveefgeejheejvdfg
    jeehueeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:J9kJYhgyxltB_0ijXDFIbxzYBmK6oE9uE4l1h1Mv6p3JdU-FkC7A8g>
    <xmx:J9kJYpCoyF70B2M1tnlTBmzeITZyAno-VVyiotnH7JBtMe-VIyioyA>
    <xmx:J9kJYqLBh2gPZXTMi_Z0t40G6SooyPEO2kbfHU0uRN0ymYqC4iGtVQ>
    <xmx:J9kJYk-OnpIcVAZ4tkdkCOg-dRj09dfvgBXK7KaWvEa2IC9g61kknw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 13 Feb 2022 23:23:03 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Ondrej Jirman <x@xff.cz>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Samuel Holland <samuel@sholland.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 2/3] dt-bindings: trivial-devices: Add Injoinic power bank ICs
Date:   Sun, 13 Feb 2022 22:22:58 -0600
Message-Id: <20220214042259.6646-2-samuel@sholland.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220214042259.6646-1-samuel@sholland.org>
References: <20220214042259.6646-1-samuel@sholland.org>
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

Some Injoinic power bank ICs feature an I2C interface which allows
monitoring and controlling the battery charger and boost converter.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

(no changes since v1)

 Documentation/devicetree/bindings/trivial-devices.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 091792ba993e..a045d627a297 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -141,6 +141,14 @@ properties:
           - infineon,xdpe12254
             # Infineon Multi-phase Digital VR Controller xdpe12284
           - infineon,xdpe12284
+            # Injoinic IP5108 2.0A Power Bank IC with I2C
+          - injoinic,ip5108
+            # Injoinic IP5109 2.1A Power Bank IC with I2C
+          - injoinic,ip5109
+            # Injoinic IP5207 1.2A Power Bank IC with I2C
+          - injoinic,ip5207
+            # Injoinic IP5209 2.4A Power Bank IC with I2C
+          - injoinic,ip5209
             # Inspur Power System power supply unit version 1
           - inspur,ipsps1
             # Intersil ISL29028 Ambient Light and Proximity Sensor
-- 
2.33.1

