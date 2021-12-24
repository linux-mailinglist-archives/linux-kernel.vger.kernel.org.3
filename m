Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5876647EEF1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 14:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352716AbhLXNKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 08:10:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233233AbhLXNKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 08:10:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F46EC061401
        for <linux-kernel@vger.kernel.org>; Fri, 24 Dec 2021 05:10:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC9CE6206C
        for <linux-kernel@vger.kernel.org>; Fri, 24 Dec 2021 13:10:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB494C36AE8;
        Fri, 24 Dec 2021 13:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640351445;
        bh=G2fwsT9NyMtiC86IFcru5bhyB1XzknP0IUgrODzYyrw=;
        h=From:To:Cc:Subject:Date:From;
        b=Oq6AbaAFUyaYwb+5pANVia5grxZ1GtLLmQ/4YYJDsEcTY5zaYqQ95ylZQHP4UALfU
         Wf06HHf5rigxIhmoX/87uBcCt4txHjfZRdHWdk1QFQS0m5OtxXNMM3zLqjRwfLrslm
         aOgtR2mXftOg9mOa1VfPhYahsGdWer1bK0SiWEB5VQ6uyz78qt0RsWtAzSDbda+i8I
         vfC3RQdKJ2esFVkpXspHq1nQ0fZkKy+keh8003jYCC4fBi7E0BruTN8Vu4J9ZFXH3i
         2rdtFwQ7TewzaFGAq1jeLAHU3XFc8QtIPSPe8gvWzUxMkM2QiG0szy9jYcGCeyZW0I
         H1a2+fdRDD7nQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1n0kLK-000UqE-Hd; Fri, 24 Dec 2021 14:10:42 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>, tiwai@suse.de,
        alsa-devel@alsa-project.org, broonie@kernel.org,
        Huajun Li <huajun.li@intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] sound: add quirk for Huawei D15
Date:   Fri, 24 Dec 2021 14:09:48 +0100
Message-Id: <cover.1640351150.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre-Louis,

Based on my tests, Huawei D15 (Intel) uses SSP0 on es8336.

Add a quirk for it.

Please notice that, currently, only the internal speaker is working.
The topology for the internal microphone and for the headphones
is wrong. Enabling/disabling the other two quirks (GPIO and/or DMIC) 
doesn't cause any audible results, nor change the devices listed
on pavucontrol (tested with pipewire-pulse).

Mauro Carvalho Chehab (1):
  ASoC: Intel: sof_es8336: add quirk for Huawei D15 2021

 sound/soc/intel/boards/sof_es8336.c | 8 ++++++++
 1 file changed, 8 insertions(+)

-- 
2.33.1


