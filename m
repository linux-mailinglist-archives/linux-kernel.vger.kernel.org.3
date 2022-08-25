Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 640905A1364
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 16:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238801AbiHYOWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 10:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238272AbiHYOWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 10:22:44 -0400
Received: from hutie.ust.cz (hutie.ust.cz [185.8.165.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBA5ADCF9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 07:22:42 -0700 (PDT)
From:   =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1661437361; bh=NxfL7BUBZRZjKHn+bafHeFTQ77WmuTUX7XmfRatnADw=;
        h=From:To:Cc:Subject:Date;
        b=XVN2bs+ShScc4q35n+QEmIl1CFddsNl4YBBB7w5G+nPRV7TqYwH01sWNG6lG/OEvv
         q0Fl63hfCvsWMrKjlUrW0La30vD+ndF1aKyuCpSEZeJmOeFMoUGUPHJP5ljH2FFOvl
         boWq2pdFvlJfGcubwzzy1LeddXEo5OHc3n1pdMGY=
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     navada@ti.com, shenghao-ding@ti.com, asyrus@ti.com,
        raphael-xu@ti.com,
        =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>,
        Stephen Kitt <steve@sk2.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Untested TAS2562 power setting fixes
Date:   Thu, 25 Aug 2022 16:22:24 +0200
Message-Id: <20220825142226.80929-1-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tas2562 driver does the same thing with the setting of PWR_CTRL
field as the tas2764/tas2770 drivers were doing.
Link: https://lore.kernel.org/alsa-devel/20220808141246.5749-1-povik+lin@cutebit.org/T/#t
Link: https://lore.kernel.org/alsa-devel/20220825140241.53963-1-povik+lin@cutebit.org/T/#t

These are blindly written patches without testing since I don't have
the hardware. (I even tried TI's formal sample request program but
was refused there. CCing @ti.com addresses I found on other series
recently submitted.)

Martin Povišer (2):
  ASoC: tas2562: Drop conflicting set_bias_level power setting
  ASoC: tas2562: Fix mute/unmute

 sound/soc/codecs/tas2562.c | 90 ++++++++++++--------------------------
 1 file changed, 29 insertions(+), 61 deletions(-)

-- 
2.33.0

