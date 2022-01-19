Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 840304936E1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 10:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352852AbiASJKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 04:10:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352266AbiASJKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 04:10:47 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3694C061574;
        Wed, 19 Jan 2022 01:10:46 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 093B71F44374
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1642583445;
        bh=IY0TsKf1sV4zasOINyvJyjE0S/SNcaARx1RJpjSFlFk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QRaDfysl0CJDjDqq1df7gr4YfD5pUJ/xuCpGRFmr/VcaXM2I9N53LwquKHDYsicm9
         p0IsntKGidGnWVE05v4hmWB8wS9PTjB99UvQSIPgTPPy40CVnW0iH9YhJwCCa3DDKM
         NZA+cqg9iWPcNvyxUzggA3YC/HR8UICU3F5w1Z9U585EGhnX6yGOtRPH5H87a5EQto
         b9NmHyS42x44nQs1ffP9pSYOYqbAhEtIxBB6gvJC+4vKPOwvWtCAA8ty4Xy3r45Rwz
         6dV6zIaSzdsR7PIMUXo0MxYAfM7CiNBTgfZohfRLss/VCUib54N/Sq+2XZuRgpFxDw
         p7ri8JuH97fxw==
Subject: Re: [PATCH] media: platform: mtk-vcodec: Do not force /dev/videoX
 node number
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        tiffany.lin@mediatek.com, andrew-ct.chen@mediatek.com,
        mchehab@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.co.uk
Cc:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20220118150717.706074-1-benjamin.gaignard@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <72ac959b-ad5f-8f4e-38d1-3da9d9866290@collabora.com>
Date:   Wed, 19 Jan 2022 10:10:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220118150717.706074-1-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 18/01/22 16:07, Benjamin Gaignard ha scritto:
> Let's v4l2 framework use a free /dev/videoX node for decode and encoder.
> For the decoder call video_register_device() before register the media
> controller device so the mapping between ins correctly done.
> Since the registering sequence has changed rework exiting errors case too.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>

Hello Benjamin,
please add the following Fixes tags to this commit:

Fixes: 590577a4e525 ("[media] vcodec: mediatek: Add Mediatek V4L2 Video Decoder 
Driver")

Fixes: 4e855a6efa54 ("[media] vcodec: mediatek: Add Mediatek V4L2 Video Encoder 
Driver")

After that..

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

