Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8A554FFE6
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 00:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350694AbiFQW3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 18:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbiFQW3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 18:29:25 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0382661634;
        Fri, 17 Jun 2022 15:29:24 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (pool-98-113-53-228.nycmny.fios.verizon.net [98.113.53.228])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 020CA6601797;
        Fri, 17 Jun 2022 23:29:20 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655504963;
        bh=RUtkDl+kWjurrUM7JaIercsTTzu0XKltvnmwlVJ3WMo=;
        h=From:To:Cc:Subject:Date:From;
        b=Ta20+N4xzU3IVSjLZxfAKClCXe/Tx+0FvcfeR6qQsRpsK8QwQ0unBhGIsxBEYiMZ3
         4rXwu20Fa/s4prn8TER8Vz+tTOVq1s/EWdqAgbp0g7QSZ9QW9eM90wktAgeDs0j3w5
         knnwZULMssfXibYNiKNMmmP2y8EyP81Ih+8+NHTxa3E26y5c33CE/w6Cv2rHz0QyPM
         fWLwIq4a1kq2EllM9ypOtgx5wVDwASMcJZ4EVxJiV1Yot9xB4LAkmTHvw9nUI1YTAh
         m+m7PJPnd03t9pxpyvlWupQvK+2cyaMy/77/ayGU3R26yyRwikBPABXICk9+XZjrbZ
         2mBQ2z2XaZCxQ==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-usb@vger.kernel.org
Subject: [PATCH 0/3] Fixes for dtbs_check warnings on Mediatek XHCI nodes
Date:   Fri, 17 Jun 2022 18:29:13 -0400
Message-Id: <20220617222916.2435618-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The two first patches fix inconsistencies in the mtk-xhci dt-binding,
while the third patch is a DTS change to use the clock order required by
the binding (and that was fixed in patch 2).

This series gets rid of a couple dtbs_check warnings on mt8192.dtsi and
another on mt8195.dtsi.


Nícolas F. R. A. Prado (3):
  dt-bindings: usb: mtk-xhci: Allow wakeup interrupt-names to be
    optional
  dt-bindings: usb: mtk-xhci: Allow middle optional clocks to be missing
  arm64: dts: mt8192: Follow clock order for XHCI

 .../devicetree/bindings/usb/mediatek,mtk-xhci.yaml     | 10 ++++++++--
 arch/arm64/boot/dts/mediatek/mt8192.dtsi               |  6 +++---
 2 files changed, 11 insertions(+), 5 deletions(-)

-- 
2.36.1

