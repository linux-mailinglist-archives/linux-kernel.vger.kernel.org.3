Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0B01478AD0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 13:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235838AbhLQMGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 07:06:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235463AbhLQMGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 07:06:35 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DEFC061574;
        Fri, 17 Dec 2021 04:06:35 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id cf39so4123991lfb.8;
        Fri, 17 Dec 2021 04:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6M3MbQrHoUjpUccStJD6KzaqR/l6BqhCgeKQWrlruZU=;
        b=TZoCeDKclfMpf9fXGrtQCub/8jPtGVwgTkHKJbppoixs0pKtAcjoKpemgHi/i3x8rS
         draQrX0MrzCl9R7MruTD0r1GYRg2S7vYYc4K3KXhhKiWsyCKGWutKYWR+mCWCNFYGJf/
         KbnH7XQPb/zrqU35iwF7arFogANOLfPAR7baPxccUPXXZbmBZLr0b+fpufMqiSqP+3Ny
         UQI0zFAX4RsY8bnVxq8oAOsUrTQEmhuDG0xpx0dnsJx4jyFBDrJG79i+/v5sPhjEmIu1
         oGEqtvRPrNQF/DN7SOMMxX2aY1ca2dSmacvnRY5ZxNZ6aJW9CwAjWWzQkqmWDGEvjmJh
         b8Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6M3MbQrHoUjpUccStJD6KzaqR/l6BqhCgeKQWrlruZU=;
        b=Agro+9RDa6cqcwg0UOJf3GbUqdaoS5lpUMutARJNNDsb6pgHynkIw3XgY9McAqPf/K
         fGhnvpgiWxVaz+R9XR9WsjQjMVSJjA9mCGcbL+UlwmirJJXDs+fENlXPAL4zePstUDGJ
         NfyQILGesGEGwvNXkix/6sd9n3svkWgs65BHg3HvmDwNq61tyNhU5KOBOWXR2gN+wCD5
         idIwaQ/Yb4yrSF9w+rxHekzD3vJUwC95HealBfPW0Urx5YvNvbqlJDLCJVazgrmKm1af
         72z88Du2/3W8SNW0GFl/sqStrRcnoTaSuw8h8SmINdE16PyMWlwCybW2prBG8JE+Bg3q
         Uc8g==
X-Gm-Message-State: AOAM5329V2/wVRzaRXkeo5hfzVtzUHWY2npXwMfl/USovLuFmivLtwRd
        uJTXAdJYprIi7AXLTq4ZMuY=
X-Google-Smtp-Source: ABdhPJzKPM2snRZWBtYCKCXoiHebfGyxJ1l/pZ0YDKpe0OrL1gH62lsc4wfcprtQcDHiIm2pjUUsqg==
X-Received: by 2002:a05:6512:3053:: with SMTP id b19mr2655278lfb.276.1639742793705;
        Fri, 17 Dec 2021 04:06:33 -0800 (PST)
Received: from [192.168.2.145] (94-29-63-156.dynamic.spd-mgts.ru. [94.29.63.156])
        by smtp.googlemail.com with ESMTPSA id h6sm1688183ljb.130.2021.12.17.04.06.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 04:06:33 -0800 (PST)
Subject: Re: [PATCH v4 00/22] Support HDMI audio on NVIDIA Tegra20
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Agneli <poczt@protonmail.ch>, linux-tegra@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20211204143725.31646-1-digetx@gmail.com>
 <Ybo6tsnQM6OacoZs@sirena.org.uk>
 <26af30a6-9606-72d0-9258-cf9627ddfe77@gmail.com>
 <7179a409-d838-0e9e-4600-785e69c3e3a6@gmail.com> <YbwoWhg6h8ChE5Xs@matsya>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <4be76f91-17dc-520c-fe3b-bdfc13437da4@gmail.com>
Date:   Fri, 17 Dec 2021 15:06:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YbwoWhg6h8ChE5Xs@matsya>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

17.12.2021 09:04, Vinod Koul пишет:
> On 16-12-21, 17:29, Dmitry Osipenko wrote:
>> 15.12.2021 22:19, Dmitry Osipenko пишет:
>>> 15.12.2021 21:57, Mark Brown пишет:
>>>> On Sat, Dec 04, 2021 at 05:37:03PM +0300, Dmitry Osipenko wrote:
>>>>
>>>>> I based S/PDIF patches on Arnd's Bergmann patch from a separate series [1]
>>>>> that removes obsolete slave_id. This eases merging of the patches by
>>>>> removing the merge conflict. This is a note for Mark Brown.
>>>> That's not in my tree so I'll need either a pull request with the series
>>>> or a resend after the merge window.
>>> This patch is included as a part of this series, please see the patch #6.
>>>
>>> I saw that Vinod Koul already merged it into his DMA tree [1] a day ago,
>>> but there is no stable branch there.
>>>
>>> [1]
>>> https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git/log/?h=next
>>>
>>
>> Vinod, will you be a able to create immutable branch for us with the
>> "dmaengine: kill off dma_slave_config->slave_id" patches [1]?
>>
>> [1] https://lore.kernel.org/all/20211122222203.4103644-1-arnd@kernel.org/
> 
> Here you go:
> 
> The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:
> 
>   Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine_topic_slave_id_removal_5.17
> 
> for you to fetch changes up to 3c219644075795a99271d345efdfa8b256e55161:
> 
>   dmaengine: remove slave_id config field (2021-12-17 11:23:56 +0530)
> 
> ----------------------------------------------------------------
> dmaengine_topic_slave_id_removal_5.17
> 
> Tag for dmaengine slave_id removal topic branch which should be merged
> into v5.17
> 
> ----------------------------------------------------------------
> Arnd Bergmann (11):
>       ASoC: tegra20-spdif: stop setting slave_id
>       dmaengine: tegra20-apb: stop checking config->slave_id
>       ASoC: dai_dma: remove slave_id field
>       spi: pic32: stop setting dma_config->slave_id
>       mmc: bcm2835: stop setting chan_config->slave_id
>       dmaengine: shdma: remove legacy slave_id parsing
>       dmaengine: pxa/mmp: stop referencing config->slave_id
>       dmaengine: sprd: stop referencing config->slave_id
>       dmaengine: qcom-adm: stop abusing slave_id config
>       dmaengine: xilinx_dpdma: stop using slave_id field
>       dmaengine: remove slave_id config field
> 
>  drivers/dma/mmp_pdma.c             |  6 ------
>  drivers/dma/pxa_dma.c              |  7 -------
>  drivers/dma/qcom/qcom_adm.c        | 56 +++++++++++++++++++++++++++++++++++++++++++++++++-------
>  drivers/dma/sh/shdma-base.c        |  8 --------
>  drivers/dma/sprd-dma.c             |  3 ---
>  drivers/dma/tegra20-apb-dma.c      |  6 ------
>  drivers/dma/xilinx/xilinx_dpdma.c  | 17 +++++++++++------
>  drivers/gpu/drm/xlnx/zynqmp_disp.c |  9 +++++++--
>  drivers/mmc/host/bcm2835.c         |  2 --
>  drivers/mtd/nand/raw/qcom_nandc.c  | 14 ++++++++++++--
>  drivers/spi/spi-pic32.c            |  2 --
>  drivers/tty/serial/msm_serial.c    | 15 +++++++++++++--
>  include/linux/dma/qcom_adm.h       | 12 ++++++++++++
>  include/linux/dma/xilinx_dpdma.h   | 11 +++++++++++
>  include/linux/dmaengine.h          |  4 ----
>  include/sound/dmaengine_pcm.h      |  2 --
>  sound/core/pcm_dmaengine.c         |  5 ++---
>  sound/soc/tegra/tegra20_spdif.c    |  1 -
>  18 files changed, 117 insertions(+), 63 deletions(-)
>  create mode 100644 include/linux/dma/qcom_adm.h
>  create mode 100644 include/linux/dma/xilinx_dpdma.h

Thank you!

