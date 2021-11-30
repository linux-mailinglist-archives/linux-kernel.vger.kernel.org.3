Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26D3C463ED6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 20:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240405AbhK3Twl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 14:52:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbhK3Twk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 14:52:40 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E33BC061574;
        Tue, 30 Nov 2021 11:49:21 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id c32so56690191lfv.4;
        Tue, 30 Nov 2021 11:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8K75pVFsuu8ZCXFfc/CjEJw0NCecB4BfF8ToqD8iFqU=;
        b=mNBFAamRrWUChcG1gwN2S41gFDJuZl+hJqwDvHWXC1pAjUfZ73Qy7FxUF/+msZIqt4
         xSsRIv2kantBGIJ0Po01y2iiGpz2kjnLf20fHkcUZvoI1JCdBdzvzUuimKkTJfqnmfvV
         V53d3TdLXTfTH0MQeuuIO3E94J0MahA5HOrJN+3qTLc/IMYdKIWWOWnIdBNEiLskcAt+
         Yt53OOWFGel2vvm4YfCm3MhTFityzuP0epHuFa7MtFZK2wyJc8XTWasVmWT205/OnjR4
         xs5cyLh1aOdJ0J2POgs5DoAOYUYd1H/B9DZAfmZ5RjW37BGEH6HUA5DGp9l0WRZgDl7F
         jMGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8K75pVFsuu8ZCXFfc/CjEJw0NCecB4BfF8ToqD8iFqU=;
        b=e3wYchZxNC0xDYL07hn2wPaOKUdYWpETz88rOy96Tpa3ZmLFWesLOPcH3mVpfa8NtK
         UqrVJtrmoeacX+CPKZENdif7onc4o0zIk3fTS6elpYXcpP+ZJ+VuorQTz9cuGgLSexVr
         BV6Oqxgxph41k0j1Ktqw9lFgd/rN+CdM1j/dNg6cTMce8u5SJLyWmokiTcMvJ2SmEgEd
         ck1R/oHqdHUXUdpkasZeoLq4vlkJ6IqMemZBaaJaWYCW0VUwXaj8uD0LKK1h17f7OpbP
         SSFRcniRPs2CLValD/ebbfuDQ5+ER9oiH3JA6E/Mbh58/zhwZU5IhYnY3pYN2tqEDWUH
         fLOQ==
X-Gm-Message-State: AOAM533BlAa4YGxnJdGP+8w0SB+S8RYZ6XbipScvrh3YPojiKVtkPYxV
        Ti1ImaDzgqMVjYQlxlLccWNbSAo7xzY=
X-Google-Smtp-Source: ABdhPJyfLfsplPH1dyeuTC5k0IL6oVboNjjg/uJwyDib4wGkyfThoCn7gWsr6OdT6/+lwmdIYoxq2Q==
X-Received: by 2002:a19:48d7:: with SMTP id v206mr1311365lfa.102.1638301759348;
        Tue, 30 Nov 2021 11:49:19 -0800 (PST)
Received: from [192.168.2.145] (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.googlemail.com with ESMTPSA id d39sm1814715lfv.78.2021.11.30.11.49.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Nov 2021 11:49:18 -0800 (PST)
Subject: Re: [PATCH v1 1/2] dt-bindings: sharp,lq101r1sx01: Add compatible for
 LQ101R1SX03
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Anton Bambura <jenneron@protonmail.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211114200717.28986-1-digetx@gmail.com>
 <20211114200717.28986-2-digetx@gmail.com>
 <YaVG93LCF6MQYiSi@robh.at.kernel.org>
 <a8f05850-1c18-1a7d-e529-08d9a6bd9923@gmail.com>
Message-ID: <1420eb9f-c5d9-c9c3-b71f-37f4f3475c67@gmail.com>
Date:   Tue, 30 Nov 2021 22:49:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <a8f05850-1c18-1a7d-e529-08d9a6bd9923@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

30.11.2021 18:54, Dmitry Osipenko пишет:
> 30.11.2021 00:32, Rob Herring пишет:
>> On Sun, Nov 14, 2021 at 11:07:16PM +0300, Dmitry Osipenko wrote:
>>> From: Anton Bambura <jenneron@protonmail.com>
>>>
>>> LQ101R1SX03 is compatible with LQ101R1SX01, document it.
>>
>> Then sounds like '"sharp,lq101r1sx03", "sharp,lq101r1sx01"' would be the 
>> appropriate compatible value. Do that, and you don't need a driver 
>> change.
> 
> Apparently you're right. The "sharp,lq101r1sx03" should be a slightly
> improved revision of "sharp,lq101r1sx01". I see now that LQ101R1SX03 is
> sold as a spare part panel for ASUS TF701T, hence these panels should be
> entirely compatible with each other.
> 

I mixed up the panel model which TF701T uses.

I compared datasheets of both panel variants. These panel have
differences in the pins configuration. Hence panels seems aren't
compatible in terms of hardware integration, although the difference is
small. They should be compatible from software perspective.
