Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFFA849B520
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 14:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1577027AbiAYNaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 08:30:18 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:54506 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1385740AbiAYNZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 08:25:13 -0500
X-IronPort-AV: E=Sophos;i="5.88,314,1635174000"; 
   d="scan'208";a="107606144"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 25 Jan 2022 22:25:11 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id AEAF54295952;
        Tue, 25 Jan 2022 22:25:09 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        Pavel Machek <pavel@denx.de>
Cc:     linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 0/3] ASoC: sh: rz-ssi: Trivial changes
Date:   Tue, 25 Jan 2022 13:24:54 +0000
Message-Id: <20220125132457.14984-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This patch series has trivial changes for rz-ssi driver. Patches 1
(partial) & 2 are from series [3].

patch 1/3 is just a cosmetic change which was part of patch [0] where it
uses a do-while instead of while-do. Patch 2/3 is from series [1] where a
helper function is added and patch 3/3 is a new patch which removes
duplicate macros.

All the patches apply to [2] (sound -next)

[0] https://patchwork.kernel.org/project/alsa-devel/patch/
20220115012303.29651-2-prabhakar.mahadev-lad.rj@bp.renesas.com/
[1] https://patchwork.kernel.org/project/alsa-devel/patch/
20220115012303.29651-6-prabhakar.mahadev-lad.rj@bp.renesas.com/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/log/
[3] https://patchwork.kernel.org/project/alsa-devel/list/?series=605672

Cheers,
Prabhakar

Lad Prabhakar (3):
  ASoC: sh: rz-ssi: Use a do-while loop in rz_ssi_pio_recv()
  ASoC: sh: rz-ssi: Add rz_ssi_set_substream() helper function
  ASoC: sh: rz-ssi: Remove duplicate macros

 sound/soc/sh/rz-ssi.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

-- 
2.17.1

