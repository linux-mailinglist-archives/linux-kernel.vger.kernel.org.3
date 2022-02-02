Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A10F4A7BEB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 00:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348161AbiBBXvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 18:51:09 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:41693 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241124AbiBBXux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 18:50:53 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id C586B5C0103;
        Wed,  2 Feb 2022 18:50:52 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 02 Feb 2022 18:50:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; bh=Y4pzDtLO4vUepP7Uh68a3ypkFiKmDj
        xHf96nex3DW40=; b=CNg4SLD7rgwPkGjZF3UUq4/+O0T7FRClwVbWnJNIO6fwRk
        lcc1AWTuBwVwKTJ05PZWrWH+o0SJIQ1/OO8cNPvafXwj3e6PwH4pCEkzY8cPU09z
        92Z+sZ95qwwaOuib8fStDG38PEeP+A3Ku8OIxunm3n7kFtNSHOsNf+7SBab0oEFm
        eEQOQa1XjBiH13zqgfXPE53YlkEd60HKWdIstXH1/nQgl2o7LzFdpAcDdOL0CIF1
        KQxVVCstj30Y3ECZCQLMBT1rDJf3jrlQwl5gWTJwxyx99T925J2nhKPBij7ZVyYP
        t+hglVlN38rmaXbpXTf+LAKRFW2nldC1cXbwVfnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=Y4pzDt
        LO4vUepP7Uh68a3ypkFiKmDjxHf96nex3DW40=; b=lTzTA9o9RDigso8X4eWERB
        EOipfZxPOKxTov5vk4Pon/+vM+TBMQE3TV36xNLLPv9QX6I5jflA0dDCaUp/5jZU
        rklQMkhr05UnJNYxB1BevN2fPGQ8d0np/K8gMWw7r8a9hWcNoNO2AMSIEHaEdBxY
        1axiYWzK0rdlXeV8ocw0XmeS0WgJtw1FHhTd+zN8oBq/Hztsq6liIEEjam+/97cj
        g1S8v4/T9b3JdicAf3gAEB64sR7HCh3DLDi6iAjbfcLOxMiDauLX+rkuBkUFsU9L
        kn9w6mUn8XFtV2RPqaWuhlD0fZT3FNBAvaCJNgjlm2cYc6mkPym0kM5Id3Pzldpg
        ==
X-ME-Sender: <xms:3Bj7YTbqV8EQI6uxqVRy6nn6HiiIWAXzG546PrvoKVuERmx-pesk5w>
    <xme:3Bj7YSZZmVS4m1Rz7C3Ku82EgjiyzTqgVbJ2xPgENFu-bC5lGWQkMt962Z5pOfQk-
    LFlpZ5DmElT8hri7A>
X-ME-Received: <xmr:3Bj7YV9xy-XxoPtvTOfb3yyGTSTbLNqyVEo5WqF_MlvdRVrzyyTdssN_sfMvEr49nnT9Z-cc4eoTmhoR2h65zti94Ni_-PgSqLsUXl5YdsUUjgIpANX3QL4i0zvcOVEChG5CdA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrgeeigddufecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepvdeiteevueettdehuedvueduhfelhffgjeduleeiudevhedugfdttefg
    heelhefhnecuffhomhgrihhnpehsihhlrghnrdgtohhmrdgtnhenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgr
    nhgurdhorhhg
X-ME-Proxy: <xmx:3Bj7YZoL8slz44RH_nzIAkLlr5l5fVStjUXiwhovgDjVAmy5Zk-aFg>
    <xmx:3Bj7YeoQt-zovmLtoQBvn0PyyaWaFG_L8gwl8O6i3LrdUYKG5kpz0A>
    <xmx:3Bj7YfQLw0coX07rhCaCyLx9W-9zN9NoKxTl4LbJmPyBcJZHD-PsAw>
    <xmx:3Bj7YeJ4Q0UGvp2RJ2Vyz8TQQSgXYJ1vWu9vMZ6qel1QXTVpcqUlKg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Feb 2022 18:50:52 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Denis Ciocca <denis.ciocca@st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v2 1/3] dt-bindings: vendor-prefixes: Add silan vendor prefix
Date:   Wed,  2 Feb 2022 17:50:46 -0600
Message-Id: <20220202235049.8051-2-samuel@sholland.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220202235049.8051-1-samuel@sholland.org>
References: <20220202235049.8051-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hangzhou Silan Microelectronics Co., Ltd. (http://www.silan.com.cn/) is
a manufacturer of ICs, including MEMS sensors.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

(no changes since v1)

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

