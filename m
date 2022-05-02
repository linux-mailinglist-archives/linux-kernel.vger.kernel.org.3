Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77259517764
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 21:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387087AbiEBT2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 15:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387083AbiEBT16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 15:27:58 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14EC3FF7;
        Mon,  2 May 2022 12:24:29 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 0E93B1F43616
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651519464;
        bh=g/10CsCiiEAtzUkTggO9p2fKiGZMC5fLwF20fgME/00=;
        h=From:To:Cc:Subject:Date:From;
        b=S5AZcx8E4EvtBgUSCN9EWouvAbcZYo0t4YVuYZMr2PdcC1hWzIUhYG/C9OA/w2dTV
         McwPwmNQE7TEj26ozepd0NGY4DLGVlE3VUaoSQoT5493L/6ju2JdwvtvCSOMNwLQk2
         vaUg+xxPDybtP2jvDXrz9BaxAh4gXYm6jtbPR47rhFHtQr3ABJVpHU+XGlzXJmPlU9
         k1JuqK0jL+LLaDoD4iE5YZZzStairRVYGsPXdKQ5ysqoY1nBdEK1w9u3Z0aoBmPWIx
         K+sCCJOeA8eDyMlcPPdxdKa83DluzVt8ocET2HtOJybUPH/9c8vEoGRyT3ZyJybseL
         HT/fhkfx3mNEw==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-remoteproc@vger.kernel.org
Subject: [PATCH v2 0/2] Mediatek SCP dt-binding tweaks
Date:   Mon,  2 May 2022 15:24:18 -0400
Message-Id: <20220502192420.2548512-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.36.0
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


Two simple patches for the Mediatek SCP dt-binding. The first fixes the
reg/reg-names property while the second adds a new optional
memory-region property.

v1: https://lore.kernel.org/all/20220429211111.2214119-1-nfraprado@collabora.com

Changes in v2:
- Dropped type and description from memory-region since it's a
  well-known property
- Set memory-region maxItems to 1

Nícolas F. R. A. Prado (2):
  dt-bindings: remoteproc: mediatek: Fix optional reg-names for mtk,scp
  dt-bindings: remoteproc: mediatek: Add optional memory-region to
    mtk,scp

 .../devicetree/bindings/remoteproc/mtk,scp.yaml   | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

-- 
2.36.0

