Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE744A3396
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 04:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353917AbiA3Dox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 22:44:53 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:37539 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353905AbiA3Dot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 22:44:49 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 4E9C33200E79;
        Sat, 29 Jan 2022 22:44:48 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sat, 29 Jan 2022 22:44:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; bh=hB9+7EnNhFV5urMiaRwrW1JWlNFko0
        oUlOFnMx58nQQ=; b=iYA0jYPFdtehRSviRbf0H4zU/5xDFTxR0odwA8pldJZq+/
        SZ0XVL8FwcZBipulosOpGx1DGjvomva9XsbxeK4e1AbXcvmoQG4ZPI19Mp9NmytZ
        anEcZbh6F3qO3vvxUY8BolJTYn65c0jn4bJmNW7b8brQPBtbpSu7Dk9eNeJUxim1
        WnH/W3lfQJoRDusOpRBhxvau0MiieO9BYyul+bcNmuKHk7Qg7VzwAN4riWgMA7Jd
        bxh20zVFXR93Xo0+56yVx3Qofn462X5PCH2oAGJwFOjD+L37QuzH5f8u9rxTdofc
        pluaFUphzFgE8QjzweAKu3JJJi0Ypgo0/NwL06pQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=hB9+7E
        nNhFV5urMiaRwrW1JWlNFko0oUlOFnMx58nQQ=; b=PZdX55XE23fa3RVZ+nBbcI
        ZESXKFYIHaSh51Y3t7GiS8pYz0r+O3M+t89o3w3dm6u4/+XfmF5h9Oq2Dr60DkTg
        eMdjOah/KAm2u8Ip6QvE01uAhVo7UGGlGmXfAC5ZjhUfNZ6mJfTQstWh5/a1kKTd
        hl+USDG3uzBua0+F9KsEinSkJIBSD/cukB5d/7OFHqNjfViFmb3kuCKU6qK01P90
        F/ikUn8HFLW7KbIT6B/8Mzk/I+AHsWR9HZHDQ1E0rpmJZwkdQOpPEDJ97q6Q/BKZ
        Hm1Jd7MrVRP2oaG7zRpiYXZyd53dV2Vn6guLQdO+zzaKUMcv2XGf75iagVMRVPBQ
        ==
X-ME-Sender: <xms:rwn2YW0ehjy3lx-5EcCm6Q2sO23fKbvbp53IU56qPyUslKg8fmyLJQ>
    <xme:rwn2YZH-4h54C-3Z7eeq_Zn9S0xVWV4hy9g2DA8SF9c0DZjmv71KyKAPd3g4b1qlK
    c47C5gmWF8QnylZnQ>
X-ME-Received: <xmr:rwn2Ye4BaXpFrYtelFkjUJXH_cGpdyyqUQrsKuHBEtpNQ_vmoPjOKjuA05IGtzfW7DhPcsKrLtNQlInZe3vw0dH3kzK6gkN979MwEo2JIZC5mIc8C2WuPKcqgEv_680_HGqo-Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrfeekgdegvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepvdeiteevueettdehuedvueduhfelhffgjeduleeiudevhedugfdttefg
    heelhefhnecuffhomhgrihhnpehsihhlrghnrdgtohhmrdgtnhenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgr
    nhgurdhorhhg
X-ME-Proxy: <xmx:rwn2YX0SveZC5LCo2VIyKSatElGbnLVUowibA055yNs8Y6sLdgRvPA>
    <xmx:rwn2YZHxnMqqn61UN6VOFPVjcWuQjB23P0CNoT5eVdOAmcXdSwIr4w>
    <xmx:rwn2YQ-9bTYNAGoTF-9TCbZXcOhkVq5gcVCgcwHWivRhewJCJ0eCMg>
    <xmx:rwn2YQ1PvUkBi6264kXtCYbjLn3BVr8R6hzdFWbsmPBYfeqMK875LQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 29 Jan 2022 22:44:47 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Denis Ciocca <denis.ciocca@st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 1/3] dt-bindings: vendor-prefixes: Add silan vendor prefix
Date:   Sat, 29 Jan 2022 21:44:39 -0600
Message-Id: <20220130034441.15474-2-samuel@sholland.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220130034441.15474-1-samuel@sholland.org>
References: <20220130034441.15474-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hangzhou Silan Microelectronics Co., Ltd. (http://www.silan.com.cn/) is
a manufacturer of ICs, including MEMS sensors.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 294093d45a23..b923be2c8172 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1082,6 +1082,8 @@ patternProperties:
     description: Silicon Image
   "^silabs,.*":
     description: Silicon Laboratories
+  "^silan,.*":
+    description: Hangzhou Silan Microelectronics Co., Ltd.
   "^silead,.*":
     description: Silead Inc.
   "^silergy,.*":
-- 
2.33.1

