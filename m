Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC4B947A13D
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 17:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236092AbhLSQCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 11:02:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233204AbhLSQCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 11:02:09 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9975C061574;
        Sun, 19 Dec 2021 08:02:08 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id m12so11938202ljj.6;
        Sun, 19 Dec 2021 08:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lOJVwY5jpStaCZAdlI9r7F578YcqW449P/YXre+J0tQ=;
        b=pjA90ue/y2GqwI2z14nTc67a4m47280O/yxsM3rbaOR0jXnST/2OFTz7rnBTTlDTiD
         yrSS6Y7Bxy5Uf9WLx+PToztObgQKrfnS007NXaKbF1DUQCVehT4AnS1J7HTmnU7awlAL
         DXhtAkhd+90jcpkSK2sqOdfRMlJLZpli8dT1Wfmv7t9H3OW0hfWcIR8ZJ9CJdh9XdZuw
         7icknWh9L06pnfWketuwEXCRVG8syJqoUQNyQPMz4ty1kgX9w/NGWOI7mKzhhWsPBcOX
         4N/kDK7AWqIhtjAnv2ccV2MxIBxJs7xIUxRl6HdKTaaidslm/H9merf2IgHYxbdeB7zI
         1UQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lOJVwY5jpStaCZAdlI9r7F578YcqW449P/YXre+J0tQ=;
        b=nukQnlIUETnHs3kLbiRm57Hj79FrCbLIwu11HG40CV4Pvo9zHUHN57o6+sAaCI5MiP
         KKT7avgLsyBd4CIMOFH+3JxKPikcXgXevVMCrVv/TrvvvaUUkGGbcmINSq0TQljhQ7q7
         kb0kHg3L5CRvl0tIaPZ4zGSxf1dOTbxhv8O3ijmxbS8Q/RznsxSQw4vob65sUxXGAiee
         Xz7NWRtRnBpjQt/BFaLv8mcbg5/x0NvmMiQfXlveU7VgsjKsulrRjpFMjF/E98DmRjT+
         0GXxOutKZM0wuuJBSBhs2Z+yDlwkBT/CxcoEcOMtRrYlzS3PNlIT2PUj3c90pAbNId8K
         sjNA==
X-Gm-Message-State: AOAM532S38ckN03fdm8G3TX+eYu1cWtUs9qFB63bKWNeb96bZepmlQn2
        r+vdxVkblPkniLbsknlbpcI7QerGt3Q=
X-Google-Smtp-Source: ABdhPJx1ZWsrVE8ULcM6usPQM1yX8t+9VcsmDxvcl3oZQN3xvGSoTr7yvW/BSd8mrcEdFyMmhUUbjw==
X-Received: by 2002:a2e:b177:: with SMTP id a23mr11100264ljm.2.1639929726863;
        Sun, 19 Dec 2021 08:02:06 -0800 (PST)
Received: from [192.168.2.145] (46-138-43-24.dynamic.spd-mgts.ru. [46.138.43.24])
        by smtp.googlemail.com with ESMTPSA id 76sm2196162ljj.69.2021.12.19.08.02.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Dec 2021 08:02:06 -0800 (PST)
Subject: Re: [PATCH v1 0/5] Improvements for TC358768 DSI bridge driver
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Robert Foss <robert.foss@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
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
Message-ID: <a999b141-4b14-cdd0-f6fa-3d861c0f381f@gmail.com>
Date:   Sun, 19 Dec 2021 19:02:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <c09bd552-767e-e783-3f9f-114b8cedb475@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

19.10.2021 23:37, Dmitry Osipenko пишет:
> 19.10.2021 12:47, Robert Foss пишет:
>> Applied to drm-misc-next
>>
>> On Sun, 3 Oct 2021 at 01:35, Dmitry Osipenko <digetx@gmail.com> wrote:
>>>
>>> This series adds couple improvements to the TC358768 DSI bridge driver,
>>> enabling Panasonic VVX10F004B00 DSI panel support. This panel is used by
>>> ASUS Transformer TF700T tablet, which is ready for upstream kernel and
>>> display panel support is the biggest missing part.
>>>
>>> Dmitry Osipenko (5):
>>>   drm/bridge: tc358768: Enable reference clock
>>>   drm/bridge: tc358768: Support pulse mode
>>>   drm/bridge: tc358768: Calculate video start delay
>>>   drm/bridge: tc358768: Disable non-continuous clock mode
>>>   drm/bridge: tc358768: Correct BTACNTRL1 programming
>>>
>>>  drivers/gpu/drm/bridge/tc358768.c | 94 +++++++++++++++++++++++--------
>>>  1 file changed, 71 insertions(+), 23 deletions(-)
>>>
>>> --
>>> 2.32.0
>>>
> 
> Robert, thank you for taking care of these patches! Now nothing is
> holding us from upstreaming the device-tree of the Transformer tablet.
> 

Hello Robert,

These patches spent 2 months in drm-misc-next, will they graduate into
v5.17 or something special needs to be done for that?
