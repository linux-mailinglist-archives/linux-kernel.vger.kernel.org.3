Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33D2F475D0B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 17:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244514AbhLOQMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 11:12:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244559AbhLOQL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 11:11:56 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EEEEC061574;
        Wed, 15 Dec 2021 08:11:56 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id k2so34063666lji.4;
        Wed, 15 Dec 2021 08:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xVG5B7SYBr3u6P2qpHezZS1RRrCpJWiliz1cwjgXHPU=;
        b=MfLIVsUVi+6UjKkeOfI0SWNq8AXH2YggFu7ywHP79o0QYXM9HVXCVGjCAk+oNn9NqZ
         NYCRvxnhWtZHwZ4emtwGdoZjRamabsNU42OtclVmR/5CTOZ7sZgYPgVwywMvu+kF4mUS
         aJNvX2mOII/VEiLV83CfHaHbwj6zorAqRfm2cjUKs1Fa9iCNQrDPXMqIzxJ3rgPWTuLX
         GjzNF1zdf6H31DQ4DWeLg43Fa3WgXEViRaZ+gRq/t/OmoFeO32V9dbtuJpgKE5iMU6Pf
         u+OUQIbVNgsZ6US518XBPac+7esIc24pXvcwYUUqy5ecAQ2c3jDkQxnQ1rvoMr27iyGT
         QpgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xVG5B7SYBr3u6P2qpHezZS1RRrCpJWiliz1cwjgXHPU=;
        b=uKNOLBGUZ/EIOzKo9VB1fScpsBXW9vlmtzZaTnkq08by9RVUxmyxkKDTwZ/M5e0MY9
         /k1nSTnFFStfzjsDHK6ZSjGTjtYr+tiYpQvwh+6GdPpe58B6UXtVl4Gr28XLygTshgxl
         yl49crLih3PiubtOFAOWNEerELWMG0gfpGtlc8kJ+XQWzNZkPwFJWKoTgA20JLQmcS1U
         RlH6ieVhwKfPBQ4u5CmVc849KU6JolFirO0UIFS3+NioL1P1nCL+eOW9urDE8E8FqiHS
         SfPBnN9MnjLXYQPqKiY1AA1McIP5visiUT2nyIUd95j90nomYFfAlehBB8gN8kSmxu2q
         ceVg==
X-Gm-Message-State: AOAM532b8M8osTeZg2zDqifxedROQVok1dKm6UdcPj/miXuNXAWK9zZO
        zW3W3xG9HsGdne+v5vgURL8=
X-Google-Smtp-Source: ABdhPJyW91GoZwqnrgyCst9/kcQTSRAGzVshAjgCuHC7JMUDYihZ1zeSVLqBM/gdk2wHRVzlCGewUw==
X-Received: by 2002:a2e:3012:: with SMTP id w18mr10494861ljw.217.1639584714625;
        Wed, 15 Dec 2021 08:11:54 -0800 (PST)
Received: from [192.168.2.145] (94-29-63-156.dynamic.spd-mgts.ru. [94.29.63.156])
        by smtp.googlemail.com with ESMTPSA id l4sm503086ljg.60.2021.12.15.08.11.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Dec 2021 08:11:54 -0800 (PST)
Subject: Re: [PATCH v16 00/40] NVIDIA Tegra power management patches for 5.17
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Nishanth Menon <nm@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-mmc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-clk@vger.kernel.org, David Heidelberg <david@ixit.cz>
References: <20211130232347.950-1-digetx@gmail.com> <YboP9IFMUrUnEzrU@orome>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <6baf6013-fbb2-b42f-5b26-2d10a2ca9374@gmail.com>
Date:   Wed, 15 Dec 2021 19:11:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YboP9IFMUrUnEzrU@orome>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

15.12.2021 18:55, Thierry Reding пишет:
> On Wed, Dec 01, 2021 at 02:23:07AM +0300, Dmitry Osipenko wrote:
>> This series adds runtime PM support to Tegra drivers and enables core
>> voltage scaling for Tegra20/30 SoCs, resolving overheating troubles.
>>
>> All patches in this series are interdependent and should go via Tegra tree
>> for simplicity.
> 
> So these can be applied in any order without breaking anything?

Please notice that the word is *inter* dependent, not *in* dependent.

There is a build dependency for the patches. The first two "soc/tegra"
must be applied first.

The "soc/tegra: pmc: Enable core domain support for Tegra20 and Tegra30"
*must* be the last applied patch if we want to preserve bisectability.
The core voltage scaling can be enabled only once all the drivers got
the power management support.

The rest could be applied out-of-order.
