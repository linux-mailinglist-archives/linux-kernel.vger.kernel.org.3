Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 292514A4B7F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 17:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245196AbiAaQK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 11:10:59 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34408 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbiAaQK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 11:10:57 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 6C90F1F42963
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643645456;
        bh=CffkeDPQIGKCT7zt9bvQS9kahLagWK5zgsg2gxOqyoE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=iMA15jgISWEGuW3lv7B7QDjXEtx4X4aZPCOlkNNkIl43zLQtSHnpfPwt+xq+yDeZ5
         +TDbK5oNPhKQgGDuX8eZvPihSaw7EIgP3oWAi27KcXY7abCoG2QQZUpWaq/xoTxM7Q
         X+f27m4EVb3oaW6R5Wcuqn05IMPaQZODbG9z3JpFQQ/BQgkuno3c1NdBk9pRE/fAxN
         fgG5J5qbqr2nrA7sVRKIWDG5fmRc8keGyJxa+jiw0lO1e2wgb0cuos06/CEnL8SeTS
         EFAWq+1B9ms3kfw+st1YPmCG4EefAONHtgXtcLyuLij5O4l7IPsPbef3ryxpR1pjYn
         wu3wUYQbZoicw==
Message-ID: <797cebd4-c367-e220-8ed3-6c1a69df4eb4@collabora.com>
Date:   Mon, 31 Jan 2022 17:10:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v6 1/1] firmware: mediatek: add adsp ipc protocol
 interface
Content-Language: en-US
To:     "allen-kh.cheng" <allen-kh.cheng@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>, tzungbi@google.com,
        Chen-Yu Tsai <wenst@chromium.org>, cujomalainey@google.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        sound-open-firmware@alsa-project.org
References: <20220128111832.22989-1-allen-kh.cheng@mediatek.com>
 <20220128111832.22989-2-allen-kh.cheng@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220128111832.22989-2-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 28/01/22 12:18, allen-kh.cheng ha scritto:
> From: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
> 
> Some of mediatek processors contain
> the Tensilica HiFix DSP for audio processing.
> 
> The communication between Host CPU and DSP firmware is
> taking place using a shared memory area for message passing.
> 
> ADSP IPC protocol offers (send/recv) interfaces using
> mediatek-mailbox APIs.
> 
> We use two mbox channels to implement a request-reply protocol.
> 
> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Reviewed-by: Curtis Malainey <cujomalainey@chromium.org>
> Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>
> Reviewed-by: YC Hung <yc.hung@mediatek.com>
> Signed-off-by: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>


Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
