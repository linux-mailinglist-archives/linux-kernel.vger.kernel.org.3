Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14033501A2E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 19:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343705AbiDNRnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 13:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245382AbiDNRmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 13:42:50 -0400
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA0DCBE65;
        Thu, 14 Apr 2022 10:40:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1649958013; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=SxT+YysqHldEASIpwf+tgvOGcVdWDRXovqqKgD0hLrA7ET3Oszn2HcnWPrDDe36kh6ikPi1NC7YXD9lS70UP0mXHRAUkjyhiU6wzX/3nVgJVsxo6UMrSUGxdbZcwTqfebE1IgPu0OHiKfwsf/ScaxLbzD+FwrgmjIK9nTyB8jBs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1649958013; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=NG1xjMeRvySQG6QrVBIRKQOBl6ROVJFrGcd25yzx2/k=; 
        b=AH52jsCC0XdOv8tm5kgTUdB3ZP1WbXMQZFDpd8o1pyZgks4dLwctGI8R3kcpbD0kx6V9a6Vla2wVVxqU+deD8Q/D9gfGLfX23V/GYfmak/Notx65PyBhivvGApxKEheHts3cY/ThNBOg0eLYfmidKti9wzhhQhoLSvOTCz2oYI4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1649958013;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Reply-To;
        bh=NG1xjMeRvySQG6QrVBIRKQOBl6ROVJFrGcd25yzx2/k=;
        b=JrskM3nhTEfYpOqLfbJH0NzrxUmKDl2KP50GspS53tmUJE8rLQkZabkOwgyycfyc
        khDvq4C7yyETDQtvOOrEYkIynQJ5R0ivD4lDbfA4/R8ib9z1YG1vdINhkVD1edFvZfr
        SXGmjBQT46aVmQEYbcR8V6OCjnIG6NXTr0NHy0XM=
Received: from arinc9-PC.localdomain (85.117.236.245 [85.117.236.245]) by mx.zohomail.com
        with SMTPS id 1649958012254748.8245005807139; Thu, 14 Apr 2022 10:40:12 -0700 (PDT)
From:   =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Joe Perches <joe@perches.com>
Cc:     erkin.bozoglu@xeront.com,
        =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: [PATCH v2 08/14] MAINTAINERS: add Ralink pinctrl driver
Date:   Thu, 14 Apr 2022 20:39:10 +0300
Message-Id: <20220414173916.5552-9-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220414173916.5552-1-arinc.unal@arinc9.com>
References: <20220414173916.5552-1-arinc.unal@arinc9.com>
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
Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fd768d43e048..27bfecaa00ae 100644
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
+F:	drivers/pinctrl/ralink/
+
 RALINK RT2X00 WIRELESS LAN DRIVER
 M:	Stanislaw Gruszka <stf_xl@wp.pl>
 M:	Helmut Schaa <helmut.schaa@googlemail.com>
-- 
2.25.1

