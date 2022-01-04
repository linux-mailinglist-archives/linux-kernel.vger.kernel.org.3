Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCF9E484223
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 14:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbiADNLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 08:11:00 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:58335 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229568AbiADNK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 08:10:59 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 6E3405C01CF;
        Tue,  4 Jan 2022 08:10:58 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 04 Jan 2022 08:10:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=18TDmxuulZJ82bw/4QiI1lkvE7
        HMf8V3nqn+LBojWio=; b=C4/U7nkhnDKch+7Xl6rRXBdGerFtX0g5/xOE5erzcE
        FT8N5uuQUXjXXb/j0XFuqUJWNuHEP7fNcZlgJ+LNoJzsmOp7g4+gE0dAze2OQKTP
        6Zz7hvm9X9TJVxZd3rbVdA2TpAgfug87tvZaqZMLR9rkgzT/99wQ4QbuXhcebO17
        iQ78/DxrAxtKj6a92mHp9UGxaBrj0ZA2/1pU2EBA5WL4zFvshtIZ4sFQJ3SIV/j9
        E5ZwMixaqszLGfECwTXnbHp3DgpyIEcLEEyrUYzySEIDdk6NiYpI/BVWsK05XftU
        DRktdIvcIAw3UjHJlo1+TqTO2lUG+HWsSwtKfPrUlwJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=18TDmxuulZJ82bw/4
        QiI1lkvE7HMf8V3nqn+LBojWio=; b=QfvHLe8ZZxPrtuuXgycelj/6P01jhk6tW
        FKDcVHrd4AA5wgz7obx91YmRVO5/4PD4gJ5PEWtxFqXJfbvpOwiOuAKqT3h6xIpg
        ImREp4VJvgFeN/tmsFKEESjiv3uYECrXS7uT1s4o2z7Uj4KL+zubX7GVQVvSfYGo
        G1uA0YaZnApyyf9D7uTB/fMXYDXc1FR/Ny5vvfWWNNGFkNaSU5dgdVYzDusjuYn6
        NKgC1kcwnl6giv2ga1bJBV5tCm4R0zGlHrT9BV1I/cMm4w527tKpV8ULdolzKitC
        WfuRSWVpnpMpQ+bDKPss4k3cpOBVWyKPpy2h7YbFWnZLIxyNifzfA==
X-ME-Sender: <xms:YkfUYYJw0xBgxtC4o_pNdu7yac_MzXO7LJaL1kKJ-YtI_ZXON__Wqg>
    <xme:YkfUYYLP6dyy7ZqL8ChnDWVLkRJzQK0jbcY9hN0lKqGri2vZ8_9Ontkz6FEApl1CX
    b9LEZiadITS375gow>
X-ME-Received: <xmr:YkfUYYt-NB96C6Etm7oDfaVkWDjoS8iwe4vfUS2kBdvuK-9woqcrY41xcoVLWCokkd9f5eGdemch_O8n9eecEzIRr3M3X6Nn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudeffedggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeetlhihshhsrgcu
    tfhoshhsuceohhhisegrlhihshhsrgdrihhsqeenucggtffrrghtthgvrhhnpeeijeelie
    eihffgleeuheegieehueevudetheeujeeufeeiteeiuefhteeiveelffenucffohhmrghi
    nheprghnthhmihgtrhhordgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepqhihlhhishhsseigvddvtddrqhihlhhishhsrdhnvght
X-ME-Proxy: <xmx:YkfUYVYvEupZ431DO_7VrfvVTAk1T1XjtH0UaxrYwz5RGzfZt_zwag>
    <xmx:YkfUYfYv0XMVjt6JU2hpcqm7Hcs-t16y3IC9-v5yigs4FbnA_IIeeg>
    <xmx:YkfUYRAM10xsANMOVUjlo4b7H0TbMYw5kn_uYYYzU6wGt0dp9Y80Gw>
    <xmx:YkfUYUP65VK6sc3D_r2UB4ixlEfCCvPw98yqrIpc7Ah1otfBUe1YXg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Jan 2022 08:10:57 -0500 (EST)
Received: by x220.qyliss.net (Postfix, from userid 1000)
        id 70363488; Tue,  4 Jan 2022 13:10:56 +0000 (UTC)
From:   Alyssa Ross <hi@alyssa.is>
To:     Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Filip Kokosinski <fkokosinski@antmicro.com>,
        Stafford Horne <shorne@gmail.com>
Cc:     Alyssa Ross <hi@alyssa.is>,
        linux-serial@vger.kernel.org (open list:SERIAL DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] serial: liteuart: fix MODULE_ALIAS
Date:   Tue,  4 Jan 2022 13:10:28 +0000
Message-Id: <20220104131030.1674733-1-hi@alyssa.is>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

modprobe can't handle spaces in aliases.

Fixes: 1da81e5562fa ("drivers/tty/serial: add LiteUART driver")
Signed-off-by: Alyssa Ross <hi@alyssa.is>
---
 drivers/tty/serial/liteuart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
index 2941659e5274..7f74bf7bdcff 100644
--- a/drivers/tty/serial/liteuart.c
+++ b/drivers/tty/serial/liteuart.c
@@ -436,4 +436,4 @@ module_exit(liteuart_exit);
 MODULE_AUTHOR("Antmicro <www.antmicro.com>");
 MODULE_DESCRIPTION("LiteUART serial driver");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform: liteuart");
+MODULE_ALIAS("platform:liteuart");

base-commit: c9e6606c7fe92b50a02ce51dda82586ebdf99b48
-- 
2.33.0

