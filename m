Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB6354A3253
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 23:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351324AbiA2WY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 17:24:29 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:43301 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243417AbiA2WY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 17:24:28 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 441263201D2B;
        Sat, 29 Jan 2022 17:24:27 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sat, 29 Jan 2022 17:24:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm1; bh=ZLs+SrcrQEFpnx7GAQjwvG0vzMrTPmwfGUpg9Qy+1mA=; b=bYzTm
        ayaqyj0EbSBgRC2hsjHmQm6+ykSfyZbydWZMFa3+P8vxt7hmPk6guod1qFHiUD5Y
        gktp2Qf64wMJp/sgmi99n2WS6/+TTz7AvPHS3RE8Jt3tCWfcnHPLOBRmS2hQgLWP
        aRh/LXe8pcAprSYr6k5bppn3PkqyIYHfc2is3z72+l19OdekFXWJPrknE0hPsP/o
        qOiQy/J4nJhI89V25Y9jgLvCHL07PkuoBMR0QzvRmMNO5zLkJTVuEVDRe8f4fPcQ
        8KrFUN361964rk6a945pXUE4H/9/slFhOb4WCk6lOQUGLBy1Xd1tqc2pGEi1GV73
        +AvvE7Fuf6JaHJW0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=ZLs+SrcrQEFpnx7GAQjwvG0vzMrTP
        mwfGUpg9Qy+1mA=; b=AtAuvuvoOF4swnHI/85OnNEv7rcZ73zd65m4AxNUTisAL
        V+fJYC3R/lQRwm3PiXSBIUzwzZIiSEO8vI76zKI+hK5SPouvRwtJxAd0zXX5Q/cT
        PAwMMipAgIJctjcDp9pTzkoiMslJPA7epZDEiwqBQW7EZ6i0CGQqz9NruLxk4sjW
        Au/rZVZHSVvjWxuYZF+100K1M21ZLVpiY9qQ2d/CUGlpksnnorUGabHC4paCt9Xt
        DMBrhudiHBJq77XbhxOAUC4tC8mDyM95kcjlwKaLp/LZwewbxy6/lvNHzdDN3YMs
        x2qc9O1kPd0yYMZsB3YmDb+tQ5XdvYvUEP8HDrMBQ==
X-ME-Sender: <xms:mr71Ybzs2KKdKarx9vWJeiDxW-hT-GEWWt8yK4LGSinSOXiBvzOt5g>
    <xme:mr71YTTQU8jFNYauTTFjw1lCD3k9qgQJOI8A62pNTfpBNL8t1YmO2R-pdS866HEgl
    NWzk3XH3IfLhJ982w>
X-ME-Received: <xmr:mr71YVW2DpheJYSDfYb9qGbOaUyL2oP-VTd7g2xr63HdGMrdWErqhVwomJ8Fr-rxiVZuT_gTyBKY6d1hNo1qYztEcalFJB1Dd-UBGMAOk1hyLL-l1yDLIxO9waosPNfaFTsM1g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrfeejgdduiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
    jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtffrrg
    htthgvrhhnpeetuddugeeihfehueduueehjeehleetiedvudegfeevveeuieeflefhueeg
    gefftdenucffohhmrghinhepihhnjhhoihhnihgtrdgtohhmnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:mr71YVhsUwciSJqYRfxMafOM3p1F26iHb9fJ2oUShcNbWTha9VL-9A>
    <xmx:mr71YdD1P3_59RWhiNHnXwmcs4SNpBFj4NvgEYHODvOvfrBDJA20Cw>
    <xmx:mr71YeIluyGD8a0IpCbA3IMNwoQe4SVymtPugLQCDdZ1GmBIAwKLug>
    <xmx:mr71YQ6u1huPS0PUkYehcM1GHsv172IpMLyAXwLGqnVSORTDYqrdwA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 29 Jan 2022 17:24:25 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ondrej Jirman <megous@megous.com>,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 1/3] dt-bindings: vendor-prefixes: Add Injoinic
Date:   Sat, 29 Jan 2022 16:24:22 -0600
Message-Id: <20220129222424.45707-1-samuel@sholland.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add prefix for Injoinic Technology Corp. (http://www.injoinic.com/)

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 294093d45a23..3a1a7b2fbe52 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -561,6 +561,8 @@ patternProperties:
     description: InfoVision Optoelectronics Kunshan Co. Ltd.
   "^ingenic,.*":
     description: Ingenic Semiconductor
+  "^injoinic,.*":
+    description: Injoinic Technology Corp.
   "^innolux,.*":
     description: Innolux Corporation
   "^inside-secure,.*":
-- 
2.33.1

