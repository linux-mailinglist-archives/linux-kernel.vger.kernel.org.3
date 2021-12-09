Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACE7C46E8E4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 14:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237662AbhLINSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 08:18:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237584AbhLINSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 08:18:50 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CB6C061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 05:15:17 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id a9so9618244wrr.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 05:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vQIKAcfBu1dkYvoY0jVP/2jXyuBYmg73U6KviSVXPKc=;
        b=OJGyC6/OEaScMUBAZhIf584Di1zvzHTrY17sVXm2ACV9G3J2c6/iupNfbRNwbzZn/5
         TuDJNE8gAEX7rBHAefCv/mcxEB5YWVKxaS+8WJvKoSs2zi7wg2k4WazEYUhLmkcBmkUy
         ik3S8dSDU2mS4cmwTTUglvD08Mhku/jwqZBO5jzBabBhV9Bo1Muc2lSzHMmyUvErtFYh
         etn6ANhu6MLKF/dPdpn83mR8JQUnLiQaaDXZFxjvPx9/y2Vbl0SnAUjRpoE/8VnaCOCK
         LuJjz4t6+WERONkcF6um3BTy28B+CP5ptrrBzi4BfYllpT4jBPie7CV+PzoYy9itSbum
         dGnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vQIKAcfBu1dkYvoY0jVP/2jXyuBYmg73U6KviSVXPKc=;
        b=7T7eVZGe6/21mZ/BWiwm49NW9BE9jtYl/U/tHWDs+zBeBYfK1XeSuFepVfSEd5XsWc
         ADffzVxZ912PneS/db/gyx8nKUDwNG7XhIulq+/Der5gWd7jv2mJ/F4oOfzlQhukw/+I
         sKLS4RD4LELpLHpZ4reH2t0bxiduXTw5qz32KPHuJSqeYLACkfm88lTKmy9IRV6KxDd0
         d9OFJH8oGjecIoQyihEdXAVoyUBO9kX8dpDbDZ30OSMdtvRYy/a5HrMLnD7zjaWVD/yd
         OZfzyzD6qnlPBwx80UMbu1UxMwwug/44ocEDXihDO1KeiU/0ah7lts/Htd8akKsrUC1D
         ot4Q==
X-Gm-Message-State: AOAM532fIv5D8yC2P3i2w8AsrZYy+5AxuBJ2YRGinC68S/XTTMSeiUfv
        5pLUV0TRx4GnJAdCk3sOvbSJIYgRElJzyg==
X-Google-Smtp-Source: ABdhPJxkxtTFidpZjh1h3BcWn5jXBx57iON7ivgMKWsyWR8xgiu41qiu9V19DgiVdktISEFv8lWi/g==
X-Received: by 2002:a5d:4a0a:: with SMTP id m10mr6213261wrq.221.1639055715802;
        Thu, 09 Dec 2021 05:15:15 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:8ae8:ca1f:ff1a:a23d? ([2a01:e34:ed2f:f020:8ae8:ca1f:ff1a:a23d])
        by smtp.googlemail.com with ESMTPSA id j40sm5744437wms.16.2021.12.09.05.15.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Dec 2021 05:15:15 -0800 (PST)
Subject: Re: [PATCH 1/2] clocksource/drivers/imx-sysctr: mark two variable
 with __ro_after_init
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, tglx@linutronix.de,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        van.freenix@gmail.com, Peng Fan <peng.fan@nxp.com>,
        Kees Cook <keescook@chromium.org>
References: <20211201125030.2307746-1-peng.fan@oss.nxp.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <1c7ecec9-6a1c-3940-4b4e-e9011c916870@linaro.org>
Date:   Thu, 9 Dec 2021 14:15:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211201125030.2307746-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/12/2021 13:50, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> sys_ctr_base and cmpcr will not be updated after init, so mark
> as __ro_after_init.
> 
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/clocksource/timer-imx-sysctr.c | 4 ++--

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
