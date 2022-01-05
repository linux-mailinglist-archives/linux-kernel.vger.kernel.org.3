Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBBB485A22
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 21:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244133AbiAEUkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 15:40:16 -0500
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:64667 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244112AbiAEUkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 15:40:09 -0500
Received: from [192.168.1.18] ([90.11.185.88])
        by smtp.orange.fr with ESMTPA
        id 5D4nnyvDrBazo5D4nn0JZy; Wed, 05 Jan 2022 21:40:08 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Wed, 05 Jan 2022 21:40:08 +0100
X-ME-IP: 90.11.185.88
Message-ID: <7d9a565e-5a5c-003a-b1e1-7bdf72f29efa@wanadoo.fr>
Date:   Wed, 5 Jan 2022 21:40:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] drm/msm/dp: Fix a potential double free in an error
 handling path
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>, airlied@linux.ie,
        bjorn.andersson@linaro.org, daniel@ffwll.ch,
        quic_abhinavk@quicinc.com, quic_khsieh@quicinc.com,
        robdclark@gmail.com, sean@poorly.run
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <6fd20c8779d6b03a5b54509af25b478049482087.1640531508.git.christophe.jaillet@wanadoo.fr>
 <CAE-0n52jDxkfYbsQPzKjSeD4rimTz1p2gaDRFpK-LLxxNV31Ow@mail.gmail.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <CAE-0n52jDxkfYbsQPzKjSeD4rimTz1p2gaDRFpK-LLxxNV31Ow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 05/01/2022 à 21:09, Stephen Boyd a écrit :
> Quoting Christophe JAILLET (2021-12-26 07:14:05)
>> 'dp_bridge' is devm_alloc'ed, so there is no need to free it explicitly or
>> there will be a double free().
>>
>> Fixes: 8a3b4c17f863 ("drm/msm/dp: employ bridge mechanism for display enable and disable")
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
> 
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> 

and

 >
 > Reviewed-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
 >


Hi,

Just for your information, it has also been reported by Dan Carpenter 1 
or 2 weeks before me and is part of -next in commit 48d0cf4a7cf2.

CJ
