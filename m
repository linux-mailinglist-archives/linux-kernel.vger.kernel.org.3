Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C3E4FEF8D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 08:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233075AbiDMGLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 02:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232986AbiDMGLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 02:11:08 -0400
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE8535DC4;
        Tue, 12 Apr 2022 23:08:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1649830109; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=GZgJzAj84MkQLWH09OwLISskLWuQeAVaNJijhuQHMFsS/xzv6LFRcPiCqpMkhD1pt2qLQN0/GuCFvW5T+5Li/R6jRjY/2U4wokTMvq0aXoP6N3Gg7xKhfvLSr7of9kf7VYnmUd2ozaNtEXR1FXpDfkuEVEvtLxARKWKx+7kMwJc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1649830109; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=YE6b1mo8I5azClKQbd0b86QgxZKJjLu5JgfZBC1QyRE=; 
        b=WZ8W4EbwI3lgFD4RJZUKzagDncGXgy66CS7ZnuaCBMUil9uahq1w2Ev1ifEcSYJsepqcwSg+nkEaYjJ5iE50+JEDdCvX3t9n9EUY32SRkb1OlzIt41KJrGslycAYlHxkX4FSkWHQtKVyAqIQgF3v9zsGFwVYxGD+/7mogv53lew=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1649830109;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Reply-To;
        bh=YE6b1mo8I5azClKQbd0b86QgxZKJjLu5JgfZBC1QyRE=;
        b=Lg8Kg6NuECM6lv2h2GGM73CLqjmGRkRaW88+6CmB3D8G9sjF/prZ/q8NvZEUBjJe
        WJqgB/3yCJL5Lqf7q6B8iBloe7gVd7QKG6CNiKiPjUqcGKS9qpVk/5SOcb+w1RUPXAN
        GDKgrWPzpsvAgYhjSM5axeIEwx79T1AbVPEFSxyY=
Received: from arinc9-PC.localdomain (85.117.236.245 [85.117.236.245]) by mx.zohomail.com
        with SMTPS id 1649830108091536.530591428714; Tue, 12 Apr 2022 23:08:28 -0700 (PDT)
From:   =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     erkin.bozoglu@xeront.com,
        =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: [PATCH 08/14] MAINTAINERS: add Ralink pinctrl driver
Date:   Wed, 13 Apr 2022 09:07:23 +0300
Message-Id: <20220413060729.27639-9-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220413060729.27639-1-arinc.unal@arinc9.com>
References: <20220413060729.27639-1-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new section for the Ralink pinctrl driver and add me and Sergio as
the maintainers.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fd768d43e048..cbd0c3e180bf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16502,6 +16502,13 @@ L:	linux-mips@vger.kernel.org
 S:	Maintained
 F:	arch/mips/boot/dts/ralink/mt7621*
 
+RALINK PINCTRL DRIVER
+M:	Arınç ÜNAL <arinc.unal@arinc9.com>
+M:	Sergio Paracuellos <sergio.paracuellos@gmail.com>
+L:	linux-mips@vger.kernel.org
+S:	Maintained
+F:	drivers/pinctrl/ralink/*
+
 RALINK RT2X00 WIRELESS LAN DRIVER
 M:	Stanislaw Gruszka <stf_xl@wp.pl>
 M:	Helmut Schaa <helmut.schaa@googlemail.com>
-- 
2.25.1

