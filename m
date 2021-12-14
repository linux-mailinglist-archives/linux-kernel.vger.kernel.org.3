Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5B5B4745AB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 15:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235085AbhLNOyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 09:54:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235063AbhLNOyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 09:54:07 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E8AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 06:54:06 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id u17so32847623wrt.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 06:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=QHcUAfEad7WKaEaeKkLn7LFVZww3lXYZUw4oQRq9+tU=;
        b=BECO94Qf+icNNuF+N/ts4ObCn6Ncn4/JdMOyQl4d3TMSz3OV1aRdYNCeSgVO4HwMNq
         DWReQKBIgjgwr9qr9IrJ/WXkov6RV5Pgd38M1W9UfdWeiQ+UYiJI5K46SPV3wZ2jFR1X
         2NCz/xQfNhQcoZaItIchM4Zq2nQUBCB7BxS0tD33MX5q1rlgLlqsu3zIK8h0gisVdnQ4
         RxYeEASInhwmW2sW3uGJL6ozbUpZl7jPSzCkddiNbqzXsVfgiM6CW4SFrYD48ysY1fnj
         lWPITR0znyQoPMhDjXCvz/mOqOl2IqhxtOvRhqz0Lj0dH6zrqrk86OCeIChRKyKZZsOW
         5wYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=QHcUAfEad7WKaEaeKkLn7LFVZww3lXYZUw4oQRq9+tU=;
        b=NfX09c4hA1G/CZT1bm9ji22Pp70sfvDCkjxXKzytfx+lJIVOXBequVmDUbcRJ7ofz2
         R0LaL/Xcz9Ywpyf3/PuQvm0skYlmOIRRPtTlP/+KYtR/0TPjZKYLSHrONcJM6fYfSlMJ
         W5ecLltiok3+hiE9VyFcLV29xJsvm/1yRZx1J9QyocMS7+FxR/ZCuisH0PnZEUfi7fms
         hiL1WTw+hgK30G17c5i5DUqfGSh/rgBmlgrrqzf8J1zyVKbSMez0DQm99wKe/kBhnoy1
         qlC7i3G3l9Dq577Sbi0KXi1HahtEXqW7p4T3qqAH7la7heljBLYp/+5nZNCoom/ewJsX
         9TFA==
X-Gm-Message-State: AOAM533ccvvrWmAgMwaWzsrrKFFDlNgm3BqJIephZCnFUzL9j9g4M1Cs
        wq4I7tk+Re75hg5EzwC0iWs=
X-Google-Smtp-Source: ABdhPJx51kLMiGT+xWuWKMZmjb7/M74p4GAa3jGXnjWTY3hsaSdXQfh6sVj/tCHskuH56l3fj/t67A==
X-Received: by 2002:a5d:4084:: with SMTP id o4mr6432264wrp.47.1639493645360;
        Tue, 14 Dec 2021 06:54:05 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:65ee:6e65:8955:bfe8? ([2a02:908:1252:fb60:65ee:6e65:8955:bfe8])
        by smtp.gmail.com with ESMTPSA id d8sm91994wrm.76.2021.12.14.06.54.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Dec 2021 06:54:04 -0800 (PST)
Subject: Re: [PATCH] drm/radeon: Fix syntax errors in comments
To:     Xiang wangx <wangxiang@cdjrlc.com>, airlied@linux.ie
Cc:     Xinhui.Pan@amd.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        daniel@ffwll.ch, alexander.deucher@amd.com,
        christian.koenig@amd.com
References: <20211214135217.24444-1-wangxiang@cdjrlc.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <ba96bb4f-1666-32a2-68a9-8fe3d6e2c10e@gmail.com>
Date:   Tue, 14 Dec 2021 15:54:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211214135217.24444-1-wangxiang@cdjrlc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 14.12.21 um 14:52 schrieb Xiang wangx:
> Delete the redundant word 'we'.
>
> Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>

Well not a syntax error in the sense of a coding error, but valid fix 
anyway :)

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/radeon/radeon_vce.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_vce.c b/drivers/gpu/drm/radeon/radeon_vce.c
> index 511a942e851d..ca4a36464340 100644
> --- a/drivers/gpu/drm/radeon/radeon_vce.c
> +++ b/drivers/gpu/drm/radeon/radeon_vce.c
> @@ -513,7 +513,7 @@ int radeon_vce_cs_reloc(struct radeon_cs_parser *p, int lo, int hi,
>    * @allocated: allocated a new handle?
>    *
>    * Validates the handle and return the found session index or -EINVAL
> - * we we don't have another free session index.
> + * we don't have another free session index.
>    */
>   static int radeon_vce_validate_handle(struct radeon_cs_parser *p,
>   				      uint32_t handle, bool *allocated)

