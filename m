Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16BE74C51DF
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 00:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239087AbiBYXAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 18:00:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239037AbiBYXAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 18:00:16 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA98B1AAFC8;
        Fri, 25 Feb 2022 14:59:43 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 6C8B21F46806
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645829982;
        bh=nr1KVl2X25oUfWhFk5/6RiJ6luvzbcYX7imnkK6NuYk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n8mZqCzJ8n/gjPmuBLhnWNCCV83zAMAuM91qaZHehEhei06y/9z4lXA1OexfjTcZa
         H4pia2ycWxBrINxiMTHi8nUpGTuz/4zTcZjX3XMhoQ0aRlfAgiYVKk6cZkudgZHnOb
         Yj0U1ym2lpo7l6Ova/NdYa8hqswmA07JOmunrVSAgzX/dezujbDrgKJt1Fynj5Ybb/
         Fu8z7bXwo9/SvgYeC0PJ5Y4CiTk3XmzzWTuldSVFt679Sq6XrTr353IdnfjtdH2xlS
         AjfydbzoE/8dpW8n5fRNYKsEOMPWXXs9+TlauJC03J5JeBBmBNfcpxfGaeMXYafYpr
         PFaSW2kMcjShg==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-usb@vger.kernel.org
Subject: [PATCH v1 2/3] dt-bindings: usb: mtk-xhci: Allow wakeup interrupt-names to be optional
Date:   Fri, 25 Feb 2022 17:58:53 -0500
Message-Id: <20220225225854.81038-3-nfraprado@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220225225854.81038-1-nfraprado@collabora.com>
References: <20220225225854.81038-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing 'minItems: 1' to the interrupt-names property to allow the
second interrupt-names, 'wakeup', to be optional.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---

 Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
index 41efb51638d1..f069c1d77e62 100644
--- a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
+++ b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
@@ -56,6 +56,7 @@ properties:
       - description: optional, wakeup interrupt used to support runtime PM
 
   interrupt-names:
+    minItems: 1
     items:
       - const: host
       - const: wakeup
-- 
2.35.1

