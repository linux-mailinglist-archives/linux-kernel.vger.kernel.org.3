Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8D24F5043
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1841052AbiDFBPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 21:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1572982AbiDERkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 13:40:06 -0400
X-Greylist: delayed 1196 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Apr 2022 10:38:06 PDT
Received: from 16.mo581.mail-out.ovh.net (16.mo581.mail-out.ovh.net [46.105.72.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED701B8202
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 10:38:06 -0700 (PDT)
Received: from player771.ha.ovh.net (unknown [10.110.208.183])
        by mo581.mail-out.ovh.net (Postfix) with ESMTP id DFE52239A6
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 16:59:10 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player771.ha.ovh.net (Postfix) with ESMTPSA id 79485293E35B3;
        Tue,  5 Apr 2022 16:59:06 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-106R0065628e882-527f-4d1e-a890-3f76ab6a3621,
                    8AF55017BACD44284FC599BC4826E0280D36FCC4) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
From:   Stephen Kitt <steve@sk2.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Wolfram Sang <wsa@kernel.org>, linux-kernel@vger.kernel.org,
        Stephen Kitt <steve@sk2.org>
Subject: [PATCH 00/14] ASoC: remaining simple i2c probe changes
Date:   Tue,  5 Apr 2022 18:58:22 +0200
Message-Id: <20220405165836.2165310-1-steve@sk2.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 8457197150388913798
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudejgedguddtgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufhtvghphhgvnhcumfhithhtuceoshhtvghvvgesshhkvddrohhrgheqnecuggftrfgrthhtvghrnhepteegudfgleekieekteeggeetveefueefteeugfduieeitdfhhedtfeefkedvfeefnecukfhppedtrddtrddtrddtpdekvddrieehrddvhedrvddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepphhlrgihvghrjeejuddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehsthgvvhgvsehskhdvrdhorhhgpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series covers all the remaining changes to migrate
sound/soc/codecs i2c probes to probe_new, where the const struct
i2c_client * argument is unused; there are a few remaining files which
use the argument and will need i2c_match_id migration.

These are all files without a more specific maintainer than Liam and
Mark as SoC supporters (unlike all my previous patches).

Stephen Kitt (14):
  ASoC: ak4*: use simple i2c probe function
  ASoC: cx2072x: use simple i2c probe function
  ASoC: es83*: use simple i2c probe function
  ASoC: lm4857: use simple i2c probe function
  ASoC: max9*: use simple i2c probe function
  ASoC: ml26124: use simple i2c probe function
  ASoC: nau8*: use simple i2c probe function
  ASoC: pcm*: use simple i2c probe function
  ASoC: sta*: use simple i2c probe function
  ASoC: tas*: use simple i2c probe function
  ASoC: tda7419: use simple i2c probe function
  ASoC: tlv320*: use simple i2c probe function
  ASoC: ts3a227e: use simple i2c probe function
  ASoC: uda1380: use simple i2c probe function

 sound/soc/codecs/ak4118.c          | 5 ++---
 sound/soc/codecs/ak4535.c          | 5 ++---
 sound/soc/codecs/ak4641.c          | 5 ++---
 sound/soc/codecs/ak4671.c          | 5 ++---
 sound/soc/codecs/cx2072x.c         | 5 ++---
 sound/soc/codecs/es8316.c          | 5 ++---
 sound/soc/codecs/es8328-i2c.c      | 5 ++---
 sound/soc/codecs/lm4857.c          | 5 ++---
 sound/soc/codecs/max9768.c         | 5 ++---
 sound/soc/codecs/max98371.c        | 5 ++---
 sound/soc/codecs/max98373-i2c.c    | 5 ++---
 sound/soc/codecs/max98390.c        | 5 ++---
 sound/soc/codecs/max9850.c         | 5 ++---
 sound/soc/codecs/max98504.c        | 5 ++---
 sound/soc/codecs/max98520.c        | 4 ++--
 sound/soc/codecs/max9867.c         | 5 ++---
 sound/soc/codecs/max9877.c         | 5 ++---
 sound/soc/codecs/max98925.c        | 5 ++---
 sound/soc/codecs/max98926.c        | 5 ++---
 sound/soc/codecs/max98927.c        | 5 ++---
 sound/soc/codecs/ml26124.c         | 5 ++---
 sound/soc/codecs/nau8540.c         | 5 ++---
 sound/soc/codecs/nau8810.c         | 5 ++---
 sound/soc/codecs/nau8821.c         | 5 ++---
 sound/soc/codecs/nau8822.c         | 5 ++---
 sound/soc/codecs/nau8824.c         | 5 ++---
 sound/soc/codecs/nau8825.c         | 5 ++---
 sound/soc/codecs/pcm1681.c         | 5 ++---
 sound/soc/codecs/pcm1789-i2c.c     | 5 ++---
 sound/soc/codecs/pcm179x-i2c.c     | 5 ++---
 sound/soc/codecs/pcm3168a-i2c.c    | 5 ++---
 sound/soc/codecs/pcm512x-i2c.c     | 5 ++---
 sound/soc/codecs/sta32x.c          | 5 ++---
 sound/soc/codecs/sta350.c          | 5 ++---
 sound/soc/codecs/sta529.c          | 5 ++---
 sound/soc/codecs/tas2552.c         | 5 ++---
 sound/soc/codecs/tas2764.c         | 5 ++---
 sound/soc/codecs/tas2770.c         | 5 ++---
 sound/soc/codecs/tas5086.c         | 5 ++---
 sound/soc/codecs/tas6424.c         | 5 ++---
 sound/soc/codecs/tda7419.c         | 5 ++---
 sound/soc/codecs/tlv320adcx140.c   | 5 ++---
 sound/soc/codecs/tlv320aic23-i2c.c | 5 ++---
 sound/soc/codecs/tlv320dac33.c     | 5 ++---
 sound/soc/codecs/ts3a227e.c        | 5 ++---
 sound/soc/codecs/uda1380.c         | 5 ++---
 46 files changed, 92 insertions(+), 137 deletions(-)

-- 
2.27.0

