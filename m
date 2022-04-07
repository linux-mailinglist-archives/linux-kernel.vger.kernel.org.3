Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65E6A4F8221
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 16:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344255AbiDGOvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 10:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241089AbiDGOvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 10:51:39 -0400
X-Greylist: delayed 1295 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 07 Apr 2022 07:49:39 PDT
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079C51BFDE2;
        Thu,  7 Apr 2022 07:49:38 -0700 (PDT)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.94.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1ncT6r-0000NC-PG; Thu, 07 Apr 2022 16:27:41 +0200
Date:   Thu, 7 Apr 2022 15:27:35 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        cujomalainey@google.com, Kevin Hilman <khilman@baylibre.com>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        tzungbi@google.com, linux-mediatek@lists.infradead.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        linux-kernel@vger.kernel.org, sound-open-firmware@alsa-project.org
Subject: Re: [PATCH v7 0/1] firmware: mtk: add adsp ipc protocol for SOF
Message-ID: <Yk701wLNKQs1DEVx@makrotopia.org>
References: <20220407130338.28939-1-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407130338.28939-1-allen-kh.cheng@mediatek.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 09:03:37PM +0800, Allen-KH Cheng wrote:
> This patch provides mediatek adsp ipc support for SOF.
> ADSP IPC protocol offers (send/recv) interfaces using
> mediatek-mailbox APIs.
> 
> This patch was tested and confirmed to with SOF fw on MT8195
> cherry board.

... confirmed to **work** with ...
is probably what you meant to write here.


> 
> Based on matthias.bgg/linux.git, v5.18-next/soc
> changes since v6:
> - rebase to matthias.bgg/linux.git, v5.18-next/soc
> - Prefer "GPL" over "GPL v2" for MODULE_LICENSE
> 
> changes since v5:
> - fix WARNING: modpost: missing MODULE_LICENSE() in drivers/mailbox
>   /mtk-adsp-mailbox.o. Add MODULE_LICENSE in the last line.
> - Due to WARNING: Missing or malformed SPDX-License-Identifier tag
>   in line 1 in checkpatch, we don't remove SPDX-License in line 1.
> 
> changes since v4:
> - add error message for wrong mbox chan
> 
> changes since v3:
> - rebase on v5.16-rc8
> - update reviewers
> 
> changes since v2:
> - add out tag for two memory free phases
> 
> changes since v1:
> - add comments for mtk_adsp_ipc_send and mtk_adsp_ipc_recv
> - remove useless MODULE_LICENSE
> - change label name to out_free
> 
> 
> Allen-KH Cheng (1):
>   firmware: mediatek: add adsp ipc protocol interface
> 
>  drivers/firmware/Kconfig                      |   1 +
>  drivers/firmware/Makefile                     |   1 +
>  drivers/firmware/mediatek/Kconfig             |   9 +
>  drivers/firmware/mediatek/Makefile            |   2 +
>  drivers/firmware/mediatek/mtk-adsp-ipc.c      | 161 ++++++++++++++++++
>  .../linux/firmware/mediatek/mtk-adsp-ipc.h    |  65 +++++++
>  6 files changed, 239 insertions(+)
>  create mode 100644 drivers/firmware/mediatek/Kconfig
>  create mode 100644 drivers/firmware/mediatek/Makefile
>  create mode 100644 drivers/firmware/mediatek/mtk-adsp-ipc.c
>  create mode 100644 include/linux/firmware/mediatek/mtk-adsp-ipc.h
> 
> -- 
> 2.18.0
> 
