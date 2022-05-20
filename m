Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4687E52ECA7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 14:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349599AbiETMvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 08:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349570AbiETMvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 08:51:45 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B232366AB;
        Fri, 20 May 2022 05:51:43 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 62EEF1F45FDD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653051101;
        bh=3EisikqzrQ9SiBDG8rG2N5qm30MIM4ElapWwrOg92Jw=;
        h=From:To:Cc:Subject:Date:From;
        b=U3k2lxCcKHZ+zfeBezpU56l0hosb77sjUaBAawfj3ZfaQPzhw5q3nJiKwS6T+ow+a
         1RJTJVxD7bUyD4JHWB1nTfMVi51GDhNWyWSex5ShggGhj2cIgP8jGkS9IYxvibNyo5
         00+Li/ZnvwKXSsCsEVApAwdwzZwF9tUvTg6/nh3TpyhsPEAL6lKIIo73NVpjYtyfo7
         ktLfUZ7Z2ikJC/aCr+wjnx1TCuWbrDpdXEsn2NKAn1qqfRqksQQ2zdHe0PVOHPrgXs
         oA8HsGWWW1u8FAGoHfMMFzcsVmICLoC1KwxgQiKzlLtU+MIMtGRMmzjyyWorE0UqX2
         u9K9lXYFRsVZQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     dmitry.torokhov@gmail.com
Cc:     matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        mkorpershoek@baylibre.com, linux-input@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] MediaTek Helio X10 MT6795 - MT6331 PMIC Keys
Date:   Fri, 20 May 2022 14:51:27 +0200
Message-Id: <20220520125132.229191-1-angelogioacchino.delregno@collabora.com>
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

This series performs some cleanups in mtk-pmic-keys and adds support for
the MT6331 PMIC's keys.

Adding support to each driver in each subsystem is done in different
patch series as to avoid spamming uninteresting patches to maintainers.

This series depends on another two series series [1], [2] named
"MediaTek Helio X10 MT6795 - MT6331/6332 PMIC Wrapper" and
"MediaTek Helio X10 MT6795 - MT6331/6332 PMIC MFD integration"

Tested on a MT6795 Sony Xperia M5 (codename "Holly") smartphone.


[1]: https://lore.kernel.org/lkml/20220520124039.228314-1-angelogioacchino.delregno@collabora.com/T/#t
[2]: https://lore.kernel.org/lkml/20220520124617.228808-1-angelogioacchino.delregno@collabora.com/T/#t

AngeloGioacchino Del Regno (5):
  Input: mtk-pmic-keys - Add kerneldoc to driver structures
  Input: mtk-pmic-keys - Use regmap_{set,clear}_bits where possible
  Input: mtk-pmic-keys - Transfer per-key bit in mtk_pmic_keys_regs
  Input: mtk-pmic-keys - Move long press debounce mask to mtk_pmic_regs
  Input: mtk-pmic-keys - Add support for MT6331 PMIC keys

 drivers/input/keyboard/mtk-pmic-keys.c | 128 +++++++++++++++++--------
 1 file changed, 87 insertions(+), 41 deletions(-)

-- 
2.35.1

