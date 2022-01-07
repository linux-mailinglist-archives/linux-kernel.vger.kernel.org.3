Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED328487476
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 10:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346345AbiAGJFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 04:05:20 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38484 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346247AbiAGJFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 04:05:19 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id BF4F91F45F92
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641546317;
        bh=rdXiAe9ghAS4SWFr5mc31jwEuvWu/wJvN9Ci8eVD2QU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Vacvfxe05tDpadRq7/p5lRr3rsC+hvEjbGBg8AdSRh6uJZFwUsCH7sQryL+tsxwwg
         S19T8S4pXeHyGH1M+vbZ7AHQkdMAIatUbJ0KAkNRJu2c9ztBwaK783YAkL2wCwTsxa
         8EC4XQ+9njrIyh9sv6vz9hPUo9sKGpBxHHD5kqaJpasjqz9jkozwpCiSXsUtZAD624
         q+akR7tL2E0Nyu2ST7Wm9thG7vrDveDZWsQdbJfsRuXK22iqh2eBEzCR/idsk75SJG
         bwRm8FTuBrfE0NMK9ObC1d1awxs64nSaZka7mtLYeCOxFuosJGmBKNXXGwQb0OixUd
         BKbNGQ9kamE0w==
Subject: Re: [PATCH 1/2] drm/msm/gpu: Wait for idle before suspending
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20220106181449.696988-1-robdclark@gmail.com>
 <20220106181449.696988-2-robdclark@gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <d67e7c42-769c-9e15-e69b-c560e3be402c@collabora.com>
Date:   Fri, 7 Jan 2022 10:05:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220106181449.696988-2-robdclark@gmail.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 06/01/22 19:14, Rob Clark ha scritto:
> From: Rob Clark <robdclark@chromium.org>
> 
> System suspend uses pm_runtime_force_suspend(), which cheekily bypasses
> the runpm reference counts.  This doesn't actually work so well when the
> GPU is active.  So add a reasonable delay waiting for the GPU to become
> idle.
> 
> Alternatively we could just return -EBUSY in this case, but that has the
> disadvantage of causing system suspend to fail.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

