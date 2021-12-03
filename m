Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1A594670FF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 04:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378458AbhLCEA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 23:00:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243269AbhLCEA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 23:00:58 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1AEDC06174A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 19:57:34 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id g28so2163308qkk.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 19:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=b1g6znamP/o+sXqh0MmEbs0eNjMFa6xH7xXeAUhEo3E=;
        b=MdinDDH4OFVcc5jcWF/c10RduGORbHRokRkClxhNTV2BBCOMdtiovEB/GuNCnjFN5Z
         I/qQWcft9TT/Aa730JCaAkrExTPFykLEIz/CJeV3OUPX+K3Dg+2IGiDj6ceEoatg/8UL
         PZvbzXFFAzqzcUbMm5qTz/YFExiGsMhwlK+SZgraDw90c8T9Ex+GbAHr1696ft7HTsdS
         uF/uPJvIefaYcIcxxhOqqtTj31Lnx4smqmhDNbfI4jJ6SS7C8X38rr/39n8YX2Z4Gfg1
         tSrF3ts6yil9+qySTA/ar+SY4l781/EmoGYJczUeUyVB2Ry8L3dJ0V2w6Ugu/83oZrtO
         pM+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=b1g6znamP/o+sXqh0MmEbs0eNjMFa6xH7xXeAUhEo3E=;
        b=tLDnR4xqzxIfV/F1M1FIm916EpO8E2OIXOlW/1rNMwZoQT8TQQZcXp7zYmO8RWinvV
         naB7wFsLXQu0m6SH/vUGBXhee7TplhISoNGFpdKZIeCoWdxxsWKJeaOdBuYbhJgtZ4fe
         gOnM74QnEQom7kUJlQlYW1yYWkW4q6jhWSnihXDbmvA+Esz1Gu1+B3slJXDs1y3PTPRI
         9qY3P3XEdKHN8cBDgxljS182kosbLOxIPwLLGa/LEm5lmp/ZIsglpcZfqT96NgvfigQ3
         Dttbm7y4O+wxLbhPBwAwqOhLUJ77O2hWuhpixMrZTow7gDMj9mqtER/7s8AEAmKSgUtz
         EEJA==
X-Gm-Message-State: AOAM530NYD6Iy95FJo4mV6/pkoBZzT2XsF+D0Xu7ecK5f+BQE7Nmmbdu
        zlJ3UArpELoGoo1pOc1sWppksQ==
X-Google-Smtp-Source: ABdhPJzutcbpudZeo05rbBZZri45oX+slCqUqFIbN1dJ2eUHHNM6A31VnwVHxXSkG/j9FF7+yyb6UQ==
X-Received: by 2002:a05:620a:2a05:: with SMTP id o5mr15885891qkp.527.1638503853879;
        Thu, 02 Dec 2021 19:57:33 -0800 (PST)
Received: from nicolas-tpx395.localdomain (173-246-12-168.qc.cable.ebox.net. [173.246.12.168])
        by smtp.gmail.com with ESMTPSA id e17sm1473192qtw.18.2021.12.02.19.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 19:57:32 -0800 (PST)
Message-ID: <b30924749421fe30df8a559e9a9ecd21b8d257e6.camel@ndufresne.ca>
Subject: Re: [RFC V3 0/2] arm64: imx8mm: Enable Hantro VPUs
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Adam Ford <aford173@gmail.com>, linux-media@vger.kernel.org
Cc:     ezequiel@vanguardiasur.com.ar, tharvey@gateworks.com,
        aford@beaconembedded.com, hverkuil-cisco@xs4all.nl,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev
Date:   Thu, 02 Dec 2021 22:57:30 -0500
In-Reply-To: <20211202041627.291625-1-aford173@gmail.com>
References: <20211202041627.291625-1-aford173@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1 (3.42.1-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mercredi 01 décembre 2021 à 22:16 -0600, Adam Ford a écrit :
> The i.MX8M has two Hantro video decoders, called G1 and G2 which appear
> to be related to the video decoders used on the i.MX8MQ, but because of
> how the Mini handles the power domains, the VPU driver does not need to
> handle all the functions, so a new compatible flag is required.
> 
> V3 is rebased from git://linuxtv.org/hverkuil/media_tree.git for-v5.17c
> This branch has support for VP9.
> 
> I set cma=512M, but this may not be enough memory as some tests appeard to run out of memory

Consider passing -j1 to fluster and using patience, this will spare some memory.
You can also increase the timeout (like -t 60), that often helps when CMA is
involved (due to software conversion happening). Thanks for the serious testing,
this is really appreciated that your submission really reflects the state.

> 
> V3 of this series has several changes:
> 
> Update imx8m_vpu_hw to add missing 'reg' reference names for G2 and include references to VP9
> Update device tree to remove IMX8MQ_VPU_RESET, remove some duplicate vpu clock parenting
> Fix missing reg-names from vpu_g2 node.
> Apply patch [1] to manage the power domains powering down.
> [1] - https://lore.kernel.org/linux-arm-kernel/20211016210547.171717-1-marex@denx.de/t/
> 
> With the above, the following Fluster scores are produced:
> 
> G1:
> ./fluster.py run -dGStreamer-H.264-V4L2SL-Gst1.0
> Ran 90/135 tests successfully               in 74.406 secs

This matches my results on imx8mq.

> 
> ./fluster.py run -d GStreamer-VP8-V4L2SL-Gst1.0
> Ran 55/61 tests successfully               in 8.080 secs

Idem.

> 
> G2:
> ./fluster.py run -d GStreamer-VP9-V4L2SL-Gst1.0
> Ran 127/303 tests successfully               in 203.873 secs

Benjamin reports 129, it could be flux. This is still a bit early, hence the low
score. But most streams do playback normally.

> 
> Fluster and G-Streamer were both built from their respective git repos using their respective master/main branches.

That gave me an idea, I'll try and print the GStreamer version/commit inside
fluster along with fluster own commit (ideally in the short summary).

> 
> 
> Adam Ford (2):
>   media: hantro: Add support for i.MX8M Mini
>   arm64: dts: imx8mm: Enable VPU-G1 and VPU-G2
> 
>  arch/arm64/boot/dts/freescale/imx8mm.dtsi   | 41 +++++++++++++
>  drivers/staging/media/hantro/hantro_drv.c   |  2 +
>  drivers/staging/media/hantro/hantro_hw.h    |  2 +
>  drivers/staging/media/hantro/imx8m_vpu_hw.c | 65 +++++++++++++++++++++
>  4 files changed, 110 insertions(+)
> 

