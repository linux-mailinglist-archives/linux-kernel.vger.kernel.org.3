Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5665A5500C9
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 01:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237048AbiFQXcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 19:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbiFQXb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 19:31:59 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD2866F8B;
        Fri, 17 Jun 2022 16:31:58 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (pool-98-113-53-228.nycmny.fios.verizon.net [98.113.53.228])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AE5D2660172C;
        Sat, 18 Jun 2022 00:31:54 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655508716;
        bh=7wdR9GvFJ2bRNSzgrHreRp4aQnYXr82CkaIfrcIiHjg=;
        h=From:To:Cc:Subject:Date:From;
        b=Q8LbSG0W5fF0m/cSGiv8xa0mqAZWTpbMvxYMD+7BSbtVKTdbrvoUtaQDDXzk9qFt7
         fMM1UNhnfH9do5G/E98ALoY3I4NZ44MS/4FZ/IfXRhIISn10CY2ZVnslNsWw8YdPMG
         33frzXAIMwX1To78f+RkByZBhCGCzMKB2BbCmlaF6fvG5XBIZh6Bbg7nB8HZ5/DRWz
         xLwCOVDNEhIcFOV/D63AAroGoqCbADVEy44ANEL3PEpoO7TeJolA8Db4f+FL6Eccsz
         aCRPOwS2JPZpEGGP0DEiqvzQT05sDIbyhYeWCT15Bc29+eBklYb3R/RUHnzm5qgarT
         wPd6KS4pdsT1Q==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, James Liao <jamesjj.liao@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 0/2] dtbs_check warning fixes for idle-states nodes in mt8192.dtsi
Date:   Fri, 17 Jun 2022 19:31:48 -0400
Message-Id: <20220617233150.2466344-1-nfraprado@collabora.com>
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


A couple of simple changes to get rid of dtbs_check warnings on
idle-states nodes in mt8192.dtsi.


Nícolas F. R. A. Prado (2):
  arm64: dts: mt8192: Fix idle-states nodes naming scheme
  arm64: dts: mt8192: Fix idle-states entry-method

 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 26 ++++++++++++------------
 1 file changed, 13 insertions(+), 13 deletions(-)

-- 
2.36.1

