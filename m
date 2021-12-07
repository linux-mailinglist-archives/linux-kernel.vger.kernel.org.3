Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04BBC46BA9C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 13:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236021AbhLGMFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 07:05:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbhLGMFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 07:05:48 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7936BC061574;
        Tue,  7 Dec 2021 04:02:18 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id m12so26968963ljj.6;
        Tue, 07 Dec 2021 04:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=r9fkipqnPp4f5GIDB2CeCpczHVdjwOS7jyMrYOGJkF0=;
        b=GqsVf1hNAe43Bt6PyvC0QWChB1UjYKkxYX9URxZLfpdXvzC6fMLwXnx71FOfonXyt5
         F7zQlK9GPRC+MFH2s0yllhIN9t/Ss3r29tEeGKbHSDqxVRhx+vBR9Oc2dJuDAoAt3eQZ
         2oQTy6DVwGjkjZw/ZG82kHwPpvg9AWdFOm/EYJ8HAdzmFrAt925lkQWKzRlb05B+zZj3
         9Ss6dcp3JpKy1o3OxOxPZLC9KAlrruzmklV39eyCRFHOUahIRUV8DznZZxtx2w6R5L5x
         QuLumVQxniEJq0tj5sdj7UE34yRpeqRy59debQkWFGCNpzhBwl2W3HHl+eg5RbMqZ5/b
         qxEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r9fkipqnPp4f5GIDB2CeCpczHVdjwOS7jyMrYOGJkF0=;
        b=GyHTwWHjWQYDHjwMvm6OGJlZSmd5j/SEACQCKZiSlSQumEGYsiF75Szi7jDXk9EE0+
         zD2xLn4ZOeCW1m3SxyaDAzVyl3iZ4/RU5/FyPx4HuvL6v4yXsI5o4WNapsyjqtfgzZbr
         U5UVMAPGvz04hi0skGShD4A83V2QSZEaYTCtsnz7YVMFihOmxcYS+FdRZ/PU1TW1hFCS
         Clbkie3t4tkbL6jCqItG4m5VZuIxItoThxnkBI16hT4yny+NQI3flTABRx9Gf0P+AQUW
         tHqpDoSkYOYldtwN6QlkpGm3yrwvQPS6c8kSjJZNwnPpfYzTuprI/N9mlepxXp9WvGfD
         d8XA==
X-Gm-Message-State: AOAM531VJZG86SVIDD1CqD6B7rbPJGzzJaOBrdx4D36ZfokJ7e6IM0cm
        WQMClb1Tl4RibSvN+ifgxFdA8SsnR2U=
X-Google-Smtp-Source: ABdhPJyQT9CYRiC9vZmuQJvr0YvSDl7dobRPVo6l6llkAAPAyU1myeVZ+7YuQSDslv8PspRPRDxvTQ==
X-Received: by 2002:a2e:8091:: with SMTP id i17mr42642170ljg.64.1638878536336;
        Tue, 07 Dec 2021 04:02:16 -0800 (PST)
Received: from [192.168.2.145] (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.googlemail.com with ESMTPSA id k13sm1812530lfo.300.2021.12.07.04.02.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 04:02:15 -0800 (PST)
Subject: Re: [PATCH 2/3] dt-bindings: sound: tegra: Update HDA resets
To:     Sameer Pujar <spujar@nvidia.com>, tiwai@suse.com,
        broonie@kernel.org, lgirdwood@gmail.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, perex@perex.cz
Cc:     jonathanh@nvidia.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1638858770-22594-1-git-send-email-spujar@nvidia.com>
 <1638858770-22594-3-git-send-email-spujar@nvidia.com>
 <13d20227-ec6b-03db-01dc-b4b00038a15c@gmail.com>
 <03a5094c-0c53-98ab-97cb-4b27ed1b7a38@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <42161fd5-f3bb-a71d-710e-b7078e294a0d@gmail.com>
Date:   Tue, 7 Dec 2021 15:02:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <03a5094c-0c53-98ab-97cb-4b27ed1b7a38@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

07.12.2021 14:04, Sameer Pujar пишет:
> 
> 
> On 12/7/2021 3:44 PM, Dmitry Osipenko wrote:
>> 07.12.2021 09:32, Sameer Pujar пишет:
>>> Tegra194 HDA has only two resets unlike the previous generations of
>>> Tegra SoCs. Hence update the reset list accordingly.
>>>
>>> Fixes: 2d8f8955fe02 ("dt-bindings: tegra: Convert HDA doc to
>>> json-schema")
>> The original txt binding was already wrong, this "fixes" tag is wrong.
> 
> The text didn't document "nvidia,tegra194-hda" compatibile support until
> the json-schema conversion happened. Perhaps the text doc was not
> updated when Tegra194 support was added. So wouldn't this be right to
> use json-schema commit as a base for this?

This problem didn't exist when the binding was converted. Should be
better to drop this tag since it doesn't add much value and creates
confusion, IMO.
