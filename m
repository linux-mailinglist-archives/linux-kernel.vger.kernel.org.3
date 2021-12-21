Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4AE47C61D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 19:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241087AbhLUSPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 13:15:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241021AbhLUSPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 13:15:15 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034F0C061574;
        Tue, 21 Dec 2021 10:15:15 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id bn20so22755939ljb.8;
        Tue, 21 Dec 2021 10:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rGlhGYi7c9JFZAs90lb+S8aDlBU/W750jjxARuJX2+M=;
        b=JUt+MrsyFxQklIoUIT4pV5yzp+XK3eXrKwgHYOSzSuVh2z6eRilPd/TOs+710UFBIH
         ArQaGW3hA8gmXDMLSfeZceTijix+xnOk3CZbSaNP3lMEch4yqP6u0iUwkEvX3YtK0+io
         5t7YuqjsI2YEVkSKgCADJ6G/leKK+qstYUmtL95nAY0eYwOu6NOWMBrRBEUFNKkkJd3K
         PiCxfdbqxcauBcEnAGwpwKoTDKnazhLroJLRufJFL4EHdUyksSngPQMe0WfABrhCGgX2
         AOahhbRdJa8OKcTzWnmrml4Htny/mR9IZO9IhBi2t6PoLM8uixux9bPc3fFh6rSi5aKh
         K+Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rGlhGYi7c9JFZAs90lb+S8aDlBU/W750jjxARuJX2+M=;
        b=eZvcsA+27N3L0abghwdnuby/PyQR27KXOagWJkN9Ckclmi2sICdMCX8uxJQ9OO+ZG3
         dpe8i9xYfokUIVO5LTY4ao5EW1/3M9Hi1bCqezQbqTgeUnvJmf4stOlqmZY0zkjC/+lg
         8Vcq/Phn6tkeIYkRSMtAIQ9ESXmjVG1xkY1UqCKOsvHHAeuQS+c6FxBGV2nmFyn3yyU6
         Ve/pu8BomuACsZ1lSJ6mb9T/IC0oUXXcCHjPX1/YKj86enVgFI0REOEn2X+OX5KfmKNl
         DHR8bsCs7w0wHMdIWhGfmPmDoX8UHZ8Ub5Fo5nSjG83OlkcV0oc8DY+bH49q+6/0z8Np
         cv1g==
X-Gm-Message-State: AOAM530dYz2oEsbvhOqx+YbCL2is2kZPtj764AeW5Bxbr+jmhIWwNvAn
        kWS7KaxkQrCkiZmlsKAo6tRPmW8qxp0=
X-Google-Smtp-Source: ABdhPJynGnhbhNwiivGaod1p0Su4ja3s2R0c4x90ptRc7pL2XdvSrcCA4gOoBZT/M4xHVrzuaPKaFg==
X-Received: by 2002:a2e:b0ca:: with SMTP id g10mr3291206ljl.491.1640110513110;
        Tue, 21 Dec 2021 10:15:13 -0800 (PST)
Received: from [192.168.2.145] (46-138-43-24.dynamic.spd-mgts.ru. [46.138.43.24])
        by smtp.googlemail.com with ESMTPSA id m15sm317882lfg.291.2021.12.21.10.15.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Dec 2021 10:15:12 -0800 (PST)
Subject: Re: [PATCH v1 0/5] Improvements for TC358768 DSI bridge driver
To:     Robert Foss <robert.foss@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Andreas Westman Dorcsak <hedmoo@yahoo.com>,
        =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-tegra@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20211002233447.1105-1-digetx@gmail.com>
 <CAG3jFysa8G_fuGDfSLze-ovft3=gc5PXLaPtwTkC2_e0itQYNw@mail.gmail.com>
 <c09bd552-767e-e783-3f9f-114b8cedb475@gmail.com>
 <a999b141-4b14-cdd0-f6fa-3d861c0f381f@gmail.com>
 <CAG3jFytG110MN=AjnY3mz4pHtLYaTTXVWr9z_1=qpCo8hJoM2g@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <1aeaf8f2-a65e-5142-65ae-e3ca7f42fc55@gmail.com>
Date:   Tue, 21 Dec 2021 21:15:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAG3jFytG110MN=AjnY3mz4pHtLYaTTXVWr9z_1=qpCo8hJoM2g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

21.12.2021 21:10, Robert Foss пишет:
> Hey Dmitry,
> 
> On Sun, 19 Dec 2021 at 17:02, Dmitry Osipenko <digetx@gmail.com> wrote:
>>
>> 19.10.2021 23:37, Dmitry Osipenko пишет:
>>> 19.10.2021 12:47, Robert Foss пишет:
>>>> Applied to drm-misc-next
>>>>
>>>> On Sun, 3 Oct 2021 at 01:35, Dmitry Osipenko <digetx@gmail.com> wrote:
>>>>>
>>>>> This series adds couple improvements to the TC358768 DSI bridge driver,
>>>>> enabling Panasonic VVX10F004B00 DSI panel support. This panel is used by
>>>>> ASUS Transformer TF700T tablet, which is ready for upstream kernel and
>>>>> display panel support is the biggest missing part.
>>>>>
>>>>> Dmitry Osipenko (5):
>>>>>   drm/bridge: tc358768: Enable reference clock
>>>>>   drm/bridge: tc358768: Support pulse mode
>>>>>   drm/bridge: tc358768: Calculate video start delay
>>>>>   drm/bridge: tc358768: Disable non-continuous clock mode
>>>>>   drm/bridge: tc358768: Correct BTACNTRL1 programming
>>>>>
>>>>>  drivers/gpu/drm/bridge/tc358768.c | 94 +++++++++++++++++++++++--------
>>>>>  1 file changed, 71 insertions(+), 23 deletions(-)
>>>>>
>>>>> --
>>>>> 2.32.0
>>>>>
>>>
>>> Robert, thank you for taking care of these patches! Now nothing is
>>> holding us from upstreaming the device-tree of the Transformer tablet.
>>>
>>
>> Hello Robert,
>>
>> These patches spent 2 months in drm-misc-next, will they graduate into
>> v5.17 or something special needs to be done for that?
> 
> They series has landed in linux-next, and will be in v5.17 if nothing
> catastrophic happens.

Very good to know, thank you!
