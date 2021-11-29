Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB00461287
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 11:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238394AbhK2Kiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 05:38:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbhK2Kgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 05:36:45 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E6BC08EA6C
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 02:02:27 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id o13so35355236wrs.12
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 02:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0P1DBQCz6Re487E8k4zSiqVVuB28Lrg52FapbU18jpo=;
        b=FaMMR9yWiYxcazApHQ/wg9yKC+NVzoM8Vwo2xVOxiFnNQDm0cdh54iKMf/CKTcaVBi
         3v0V2JSIftMr20OKDj2qRUUxchnnN6VnmRLtkxZXy10G83MeHoqUxhevvdBYaZi54eKe
         3ORoI2GGQ1BYzjtd8UwdlW+nDkoYEOSE1wRJVYCHLXFv2q5CUH/SwrEQHJDAo0gfhgRi
         iVII4IF7xmSWTw91dL3E+EkV+gucjbh5wQhMQNwAtnirzBG1yXdjkr+EUD9T0W5Fikou
         dr+m0d3Y7+cRy0yHzrk+SPJHgUYX0eiJgjgJZDgqoT6K6yUgzwXLqT8mNzYLZciIrPRm
         cOow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0P1DBQCz6Re487E8k4zSiqVVuB28Lrg52FapbU18jpo=;
        b=rjmiFZT3OBdcdHl0ocvIxpHIRo6LL2DpL5EqBqW1b3fZbJI0ab+LOouQ70PgBktOUg
         cxtE6Ic34Dwxs0T4bZLh6GwIQQbMxnQNlUy8rTmCFKTlJWxljptU+VEw2Cf6z/gJg0hp
         RfQlL+Jni4s006ulwqgic7K6y8S0SvI94PC4CpIqwdbRUydu6sgcWOcvbQ7niGlHKyJb
         k2Vhfxm5VhZvffej0JH+GgTLHYbybmk4ctcF0gOzeVrquLsl16CYd5IaND36yEp+2mqv
         4nAnYcGcPSS3iTYHMXbXB1gpjfEN6ODVxKwo3yr5XSi6TAt55NXmVwZ4IlF5kURtpdsa
         8i7Q==
X-Gm-Message-State: AOAM532h07dxRoFVTNkbKis1hbmHSsGe5cAfBkbvrUIZBWfEf6Hp46ko
        ILaG1xxDeiWDBQK5dMQT6UBBRQ==
X-Google-Smtp-Source: ABdhPJxW8KDLLi9B5knbiZGRFmjeaSoYfXl8Bf8QIeqm1eg6FgSQrPWaHsYoimlSs5TggZT1/ujJSQ==
X-Received: by 2002:adf:8010:: with SMTP id 16mr32377814wrk.559.1638180146284;
        Mon, 29 Nov 2021 02:02:26 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:8236:a2e5:8d62:e9cd? ([2a01:e34:ed2f:f020:8236:a2e5:8d62:e9cd])
        by smtp.googlemail.com with ESMTPSA id g5sm17498490wri.45.2021.11.29.02.02.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Nov 2021 02:02:25 -0800 (PST)
Subject: Re: [PATCH V6 3/7] dt-bindings: timer: tpm-timer: Add imx8ulp
 compatible string
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, robh+dt@kernel.org,
        aisheng.dong@nxp.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        ulf.hansson@linaro.org, broonie@kernel.org, linux@roeck-us.net,
        wim@linux-watchdog.org, linux@rempel-privat.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Jacky Bai <ping.bai@nxp.com>, Rob Herring <robh@kernel.org>,
        Peng Fan <peng.fan@nxp.com>
References: <20211126074002.1535696-1-peng.fan@oss.nxp.com>
 <20211126074002.1535696-4-peng.fan@oss.nxp.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <d075b19a-c82b-9732-2034-1837a303c072@linaro.org>
Date:   Mon, 29 Nov 2021 11:02:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211126074002.1535696-4-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/11/2021 08:39, Peng Fan (OSS) wrote:
> From: Jacky Bai <ping.bai@nxp.com>
> 
> The tpm timer on i.MX8ULP is derived from i.MX7ULP, it use two
> compatible strings, so update the compatible string for it.
> 
> Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Jacky Bai <ping.bai@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
