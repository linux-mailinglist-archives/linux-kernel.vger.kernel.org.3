Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06E38466388
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 13:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358015AbhLBMYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 07:24:40 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:47465 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1357998AbhLBMYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 07:24:06 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 702E858032D;
        Thu,  2 Dec 2021 07:20:43 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 02 Dec 2021 07:20:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=eqhk7Ic8pZPJY
        dazb8fewxiM8e1R86oONtKWbPMz2jg=; b=czQK1kR3ZmVxnmFnnqjw0kXFGZAAN
        xIcptgw9UlmUaQmmO0kiG7d1LNgDplkhaHBU6Dlx92/KvX69Jbccl9H+pXL0Tedl
        SOQVNpR6VPCtaYEBvFU2QS95NXsycoWWLLVIh/Zk2FJVLxyihW+XMEWRjSnuU7gL
        Zu0xIu6eoFTYkLNJKZ6vVswC/AHBvf6F5b7/a8hkPgP3T33fjtSs6bAmO50ySg04
        QSpdGT4Wd46g3iOCt7JX8v7nSKxw2Z/3fIW5j5p5fN24aVX7ZoMk3Q1ORZEy3A6g
        RaBdw+9sHBLEy/LIkrngW1HlxJjIsQfEaQSF5BPVXkSMHK/JfCSr+coiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=eqhk7Ic8pZPJYdazb8fewxiM8e1R86oONtKWbPMz2jg=; b=PKzx/99J
        CcLT5QGliXerC5IoRztrzlI8VqWJ2cARou0yoWiUgVQtsbxC6bnQ14YE+om5YUeo
        L1E22jBacPVcuv5Yd0Zb8MoF3AJSTa5r5IGBjkA/TVdJ3RxpV4Mqt63l/+MivxuY
        Mz2NgK8qk64McZMVJED2fHDWj/CMzhrPl57fys3w+DpmxFTnyZw2HXiAh/bF+CIq
        fAIMg4tg9i4sgMq9nzbCxttWZSfFWK+Dv0IZWpzDirYlGHgyRvqZpkfd1dJ5zg+r
        Ed3KrkcmUF9/sg5iFCtBOdhK2HsgQ1TS+0VFoBO2Pxwe5rvL1B4Ma5GWu6SHb/QD
        MDOEk7c1Mz+Pug==
X-ME-Sender: <xms:G7qoYXbv71SEgPuhsoQ0GNICUSuulqz_-2N1he1ffju99xS7Hemhcg>
    <xme:G7qoYWYVCxgYfEE6ndNXUUVxVbcMzXIpMS3PvI2jbOd2_iDBwz1i3LQza5wWwvvvE
    AB2zXipFQlJQOWjIDs>
X-ME-Received: <xmr:G7qoYZ8YWlcjzZkPY4wu-ofIpdf3z0KsU-4y35LuQQKrwinR-YueBUidkNBpAz5ZFTtWSVWzNOXZLnm6PYXs6g0xffgQZasdum7pruCRsKNhuQA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrieehgdefkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepgeegtdetjeekge
    eguefgheeuvedugedvteejveeiudegvddtkeffkeehtdetudfhnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhish
    htrghirhdvfedrmhgv
X-ME-Proxy: <xmx:G7qoYdrB8vzSjylFLraZbmsbolBkwAtR9bDfNMlwkU1Zr1SoOcDmQQ>
    <xmx:G7qoYSoqwsqV1cADtFXQvRABgCaEQw7gxQfmHny7h0c51znewckJDw>
    <xmx:G7qoYTRMLJKxbjuAl7XE0PO2vTUW4vVAgay8XNbWfxTDCnI3K75Sjw>
    <xmx:G7qoYR0NBNO1AK89EsOGaWiBPPWK3Z0eojRofSI-ekbw_oM6kG5yZg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Dec 2021 07:20:39 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     robh+dt@kernel.org, andreas@kemnade.info, alistair23@gmail.com,
        dmitry.torokhov@gmail.com, linus.walleij@linaro.org,
        rydberg@bitmath.org, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v3 3/4] ARM: imx_v6_v7_defconfig: Enable the cyttsp5 touchscreen
Date:   Thu,  2 Dec 2021 22:20:20 +1000
Message-Id: <20211202122021.43124-4-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211202122021.43124-1-alistair@alistair23.me>
References: <20211202122021.43124-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 1fbb8e45e604..5326bf4b4c43 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -167,6 +167,7 @@ CONFIG_TOUCHSCREEN_ADS7846=y
 CONFIG_TOUCHSCREEN_AD7879=y
 CONFIG_TOUCHSCREEN_AD7879_I2C=y
 CONFIG_TOUCHSCREEN_ATMEL_MXT=y
+CONFIG_TOUCHSCREEN_CYTTSP5=y
 CONFIG_TOUCHSCREEN_DA9052=y
 CONFIG_TOUCHSCREEN_EGALAX=y
 CONFIG_TOUCHSCREEN_GOODIX=y
-- 
2.31.1

