Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D383F4D5E68
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 10:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347569AbiCKJ2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 04:28:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235453AbiCKJ1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 04:27:51 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D1B1BD071;
        Fri, 11 Mar 2022 01:26:47 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 4EB961F46323
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646990806;
        bh=VrFTl14kcVqcYYACUB4vzGhspKA0SIhAgvXA9pmJvX4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Wt65MNKN9/56BVKEQ7gs6zGHjV4yVDE4WPD3sfXznCU8tFdO1RdwKYhcI1jW9bYYU
         tQaIkTQxQl5NrPQQUYeRMGZbV1a5SVUD77O593lhzpy5tNhzr4jaVl6VvgckqoPkAD
         HcoVkRKxBWJNiKlq3zMW5wvn52SDcAtw6Htb6D/FUyOzKQwVCbR0qW6aE3QnYL7il+
         68MmKGoGxW7jQNpbDybZQ4bwrgfOJqFqiprBLhVgZTjWlkfVaaUEkhin5dXzkeP947
         1JYUW6mcU9XI1iW5Hbk2JcZvmRqRevLrHKDBW9atoLf84+r9gEbJe0kGra1rxgvHeT
         NLxleKWo/UaRA==
Message-ID: <c4ff9715-f390-0adb-cee6-1812d7308cb4@collabora.com>
Date:   Fri, 11 Mar 2022 10:26:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 1/3] drm/msm/gpu: Rename runtime suspend/resume functions
Content-Language: en-US
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20220310234611.424743-1-robdclark@gmail.com>
 <20220310234611.424743-2-robdclark@gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220310234611.424743-2-robdclark@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 11/03/22 00:46, Rob Clark ha scritto:
> From: Rob Clark <robdclark@chromium.org>
> 

Hey Rob,
looks like you've somehow lost the commit description on this one!

Cheers,
Angelo

> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>   drivers/gpu/drm/msm/adreno/adreno_device.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
