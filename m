Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53B8B5B243C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 19:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbiIHRME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 13:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiIHRMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 13:12:01 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E49CC59F1;
        Thu,  8 Sep 2022 10:12:00 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (unknown [70.107.189.129])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 581D76601F99;
        Thu,  8 Sep 2022 18:11:57 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662657118;
        bh=VsIS3dSMx2WzTOtjQQmlSmAEX/x9faKlbCRiz+4NKNw=;
        h=From:To:Cc:Subject:Date:From;
        b=A1KrYxAOUiuEfd46COkVb6W0Kqr9Nu9YHu7+D7QGOeb+QgNwPVdIW/SgVgFBslfQj
         yu+fEDL4nyJqGuCxUiLoxLn2mEPXn0pOg7p6ZhmCSTU4p4JYYSlB9NW2ZI8Ps1dL+z
         VMUAjxVGbG5LwuPp/iUPN3Zq/DIjwWsE06RS9EqSWA482jx6n1EyZuv4yDY7WeaQZ8
         BhFEsZ9Fx61mOHFIj6mJ0ty4I+fft5L3p0OTZw0oWSvcAkYGhCMnH9wfF5YbPqKz5u
         P/AfW1kLKk3B7OdY6v7zz8Il68CJazVndWoP85wxRXKm85QSWni6PqB6jAp5yp213Z
         tEH1s1o1Tm8Ww==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 0/3] arm64: dts: mediatek: asurada: Enable internal display
Date:   Thu,  8 Sep 2022 13:11:50 -0400
Message-Id: <20220908171153.670762-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.37.3
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


This series adds and enables all components required to have a working
internal display on the Asurada platform.


Nícolas F. R. A. Prado (3):
  arm64: dts: mediatek: asurada: Add display regulators
  arm64: dts: mediatek: asurada: Add display backlight
  arm64: dts: mediatek: asurada: Enable internal display

 .../boot/dts/mediatek/mt8192-asurada.dtsi     | 215 ++++++++++++++++++
 1 file changed, 215 insertions(+)

-- 
2.37.3

