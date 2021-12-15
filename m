Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1108B475A90
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 15:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243331AbhLOOTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 09:19:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243292AbhLOOTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 09:19:14 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19317C06173E;
        Wed, 15 Dec 2021 06:19:14 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id k37so43533219lfv.3;
        Wed, 15 Dec 2021 06:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wgEoOe80ydYoYhOrnQFTmgFp/fiiDyl6aBseAyf2+vA=;
        b=lG/cn4qdGgxDXdA6SBGobZm7+BTvpVBZmhUM94+PsJ/S0qWUNi7wGzUOTVZvf/GcsC
         GhvYEPV+89gkNkF7dWorWTchvKOKwr2B6KS9DwxWAnekaaG2Q3wM3OH6Jut4Gewz0i5I
         KL4byysJzIoH42kOEazdZBZr4svNeMsWWUkwYFdOj3HQHbw+ESwfcveKs339cHlHNlB4
         IZCDRod5PvJswr83iiXGaXuN2HNqnu0rKYdw0eRWg4wu6pwQ036z4bW1imn1To02DEy3
         lGIg5dJ8jf6SvKCJV+8kUwhS7xKffkqEgwHAg/N+AEH9OizB3n0vNf99OYgRml7zGzHm
         vOTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wgEoOe80ydYoYhOrnQFTmgFp/fiiDyl6aBseAyf2+vA=;
        b=1hy6ETpwQb//t1t8V7SsbSk7CM2RJK+vPxvKSVkm4AvCOmE7UTeQUk0fS22J3EAG6p
         xFsZ2KYd71na3Ka+Vj/hUjubYoE2dkOP3amtkPXd3SGpg3jgQW5/2ErFowQLBXF+W/LP
         YIY6fxt4CLSPpUli8aqc6BvsSJL32iKC6DgkzbLE9XAzw5jD75P95MNYA4sLz1htmZTi
         jnnDSGA185o//Pt2ZFLwDN5z1NI2S9AccQAPxixWNWSKfNpHE+MsNHBdToHNVIi14xm6
         HBQGXysabH5CmpfneR0B2/szIJx3+5uYS1uY/SpwVkMYqac8az5hljVtr2Uxjr9U5hYV
         v8ZQ==
X-Gm-Message-State: AOAM531JL+49ATRIjeV5JcREjiWJv7XF5OEzp7zvSbrue4xJiox2DvcR
        0CL/CdcEm0BrWHPiDnF6VjmR039BkBE=
X-Google-Smtp-Source: ABdhPJzWqv4rzu/nRAZ3WfSzaLPuAvty+2g7LYK/Ea0zstxzmdgT3qe6/jbOatdKz+jIqN5XdJ1LNQ==
X-Received: by 2002:a05:6512:1289:: with SMTP id u9mr9892434lfs.273.1639577952153;
        Wed, 15 Dec 2021 06:19:12 -0800 (PST)
Received: from [192.168.2.145] (94-29-63-156.dynamic.spd-mgts.ru. [94.29.63.156])
        by smtp.googlemail.com with ESMTPSA id o26sm340685lfb.242.2021.12.15.06.19.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Dec 2021 06:19:11 -0800 (PST)
Subject: Re: [PATCH v6 08/28] ARM: tegra: Add device-tree for ASUS Transformer
 Prime TF201
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        David Heidelberg <david@ixit.cz>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Anton Bambura <jenneron@protonmail.com>,
        Antoni Aloy Torrens <aaloytorrens@gmail.com>,
        Nikola Milosavljevic <mnidza@outlook.com>,
        Ion Agorria <ion@agorria.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Ihor Didenko <tailormoon@rambler.ru>,
        Andreas Westman Dorcsak <hedmoo@yahoo.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Raffaele Tranquillini <raffaele.tranquillini@gmail.com>,
        Jasper Korten <jja2000@gmail.com>,
        Thomas Graichen <thomas.graichen@gmail.com>,
        Stefan Eichenberger <stefan.eichenberger@toradex.com>,
        Stefan Agner <stefan@agner.ch>,
        Peter Geis <pgwipeout@gmail.com>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211211211412.10791-1-digetx@gmail.com>
 <20211211211412.10791-9-digetx@gmail.com> <Ybntiedyo353hMxm@orome>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <373613c6-2c3b-522c-ac63-371304b79bb9@gmail.com>
Date:   Wed, 15 Dec 2021 17:19:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <Ybntiedyo353hMxm@orome>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

15.12.2021 16:28, Thierry Reding пишет:
> On Sun, Dec 12, 2021 at 12:13:52AM +0300, Dmitry Osipenko wrote:
> [...]
>> +	display-panel {
>> +		compatible = "hannstar,hsd101pww2";
> 
> There doesn't seem to be a DT binding for this and I can't find any
> patches where this would be added. Is there a patch somewhere to do
> this?

Are you trolling me? :/ Please search the "Tegra kernel patches for
5.17" email in your inbox, it must be there. Please read and answer to it.

All patches are in the Tegra patchwork. Who marked them "Not Applicable"?

https://patchwork.ozlabs.org/project/linux-tegra/patch/20211211213653.17700-3-digetx@gmail.com/

https://patchwork.ozlabs.org/project/linux-tegra/list/?series=276358
