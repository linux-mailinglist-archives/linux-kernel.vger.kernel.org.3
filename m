Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2B4B54297A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 10:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbiFHIch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 04:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbiFHIbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 04:31:04 -0400
Received: from sender4-op-o18.zoho.com (sender4-op-o18.zoho.com [136.143.188.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B083BC3EB
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 00:53:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1654671927; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=cpfPiy1oP6qeyu346ymxsJ7shCsbjhbf6cLbMgiYSAbtOzc/t75Oli8vQCvUz3lk36Lk3/bGt19dIEoZb5TwAhkhMIUzewEq5tFGdLKdFKXUeyMG0xkBr6KuWrhm0thG9Yj4hSHKCk/xdXmn/+02wp6f33+p+JUM462hItgBhUE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1654671927; h=Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=MtfJNwoHvECpOHH8HhSZ1SO+XHfKXwwR1b5+QWHvHTo=; 
        b=Zy+FhDx1LtjdGAPjDg+Q+l6vjrap1WTpgRZRulO9Saz2UdS8Nu2qdZYPk6ebkwnxomTD/vZzd493vgswV6psSUo2uLcj4SvgRNlD/o+mk2Y+kFtENJlqR83SAyUwK3EY+zqbnc4Oo0RuSAveB+XoW1pWR/1fQKiGXR5fqa7Jz2g=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1654671927;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=MtfJNwoHvECpOHH8HhSZ1SO+XHfKXwwR1b5+QWHvHTo=;
        b=GQybyZFTdzqeCuwxJzFyGpHsh6ITCeokWQjKuilXYSudSAW3YtAA1nVTCMU8irgc
        EaUKZ+qb5Kp1ohVWU9OXh4q6MiFJN+qpTzf2EI+uHoKvLcdya2uVgM/gdTJ/8cMFd7V
        Sl+J05D2H82qV52UshkicHNCQ/DWcpXbiQnI6tzk=
Received: from edelgard.icenowy.me (59.41.163.66 [59.41.163.66]) by mx.zohomail.com
        with SMTPS id 165467192492424.387571387580692; Wed, 8 Jun 2022 00:05:24 -0700 (PDT)
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bin Liu <b-liu@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-usb@vger.kernel.org,
        Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH 3/7] dt-bindings: usb: sunxi-musb: add F1C100s MUSB compatible string
Date:   Wed,  8 Jun 2022 15:04:48 +0800
Message-Id: <20220608070452.338006-4-uwu@icenowy.me>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220608070452.338006-1-uwu@icenowy.me>
References: <20220608070452.338006-1-uwu@icenowy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner F1C100s has a hybrid MUSB controller between the A10 one and
the A33 one.

Add a compatible string for it.

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
---
 .../devicetree/bindings/usb/allwinner,sun4i-a10-musb.yaml        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/allwinner,sun4i-a10-musb.yaml b/Documentation/devicetree/bindings/usb/allwinner,sun4i-a10-musb.yaml
index 933fa356d2ce..144f562f2591 100644
--- a/Documentation/devicetree/bindings/usb/allwinner,sun4i-a10-musb.yaml
+++ b/Documentation/devicetree/bindings/usb/allwinner,sun4i-a10-musb.yaml
@@ -17,6 +17,7 @@ properties:
       - const: allwinner,sun6i-a31-musb
       - const: allwinner,sun8i-a33-musb
       - const: allwinner,sun8i-h3-musb
+      - const: allwinner,suniv-f1c100s-musb
       - items:
           - enum:
               - allwinner,sun8i-a83t-musb
-- 
2.36.0

