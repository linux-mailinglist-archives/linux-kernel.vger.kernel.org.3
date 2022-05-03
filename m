Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6B05182AC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 12:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234373AbiECK6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 06:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233634AbiECK55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 06:57:57 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA7E37BE8;
        Tue,  3 May 2022 03:54:14 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 9CC871F43E0F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651575250;
        bh=tUFa36FJdRvQXQNs914k7i3npmd0tCRASCn8j1c9KiY=;
        h=From:To:Cc:Subject:Date:From;
        b=AMt6Snv6vPYTd7c3E2G7yqqwWbnRDUHSlYpZZC1P8p/FugIfPFswzeD2JnE6wCmRX
         ybb6fW3xghNYm0GbmRW/25uiVKUPgfqKskaRNTnfx6msZyZxcoZ7RVwsqiyyoR05vb
         pv6spBVYHYFjDoi0jLBPIe5I0OsAPQvZUYIp1Fqz+oDxAJdr4htpkacXVb5sxkzjAj
         G5BP3OuBEynmBBVVy+BA3hUpdKlWIxW4B6SI5Kyi9eRKHNummoTU2X9mfmSh0Vb0Pq
         YVPa4ioOZdhUbi+lRNO7AkQ8xkZh4fWJgWS9iikXn9IcIP7+xmyXsA0E8hAIApvFWH
         lSpyjSjKb2fRg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     thierry.reding@gmail.com
Cc:     u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        nfraprado@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 0/2] MediaTek Helio X10 MT6795 - PWM driver
Date:   Tue,  3 May 2022 12:54:03 +0200
Message-Id: <20220503105405.54832-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
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

In an effort to give some love to the apparently forgotten MT6795 SoC,
I am upstreaming more components that are necessary to support platforms
powered by this one apart from a simple boot to serial console.

This series introduces support for the PWMs found in Helio X10.

Tested on a Sony Xperia M5 (codename "Holly") smartphone.

AngeloGioacchino Del Regno (2):
  pwm: pwm-mediatek: Add support for MediaTek Helio X10 MT6795
  dt-bindings: pwm: pwm-mediatek: Add documentation for MT6795 SoC

 Documentation/devicetree/bindings/pwm/pwm-mediatek.txt | 1 +
 drivers/pwm/pwm-mediatek.c                             | 7 +++++++
 2 files changed, 8 insertions(+)

-- 
2.35.1

