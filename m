Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00388478ACC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 13:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235783AbhLQMGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 07:06:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235463AbhLQMGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 07:06:21 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92231C061574;
        Fri, 17 Dec 2021 04:06:20 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id br40so1716668lfb.1;
        Fri, 17 Dec 2021 04:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FDG0QRu1oWME9x0G+hGYpYXqzKBkpeCRyLSLI3ohny0=;
        b=iqvPkpSb+gCcK4T6PxilBYWAPmZ4umzvjmZTiUA2GzJiNCbdbpDQW7BOHM8rcgZjAo
         nB9iy+VMcbaD4X1E8F+gq4cUKLbRWjbPqZtvx1A5f4PmhS+nrLGRagpJr/j6fGvVNwr3
         l0wvENro/wryUGvzVfCF0dXc8b+ue8WLPg2EH6ofY43Cowi7QepRdxSu2rex9m1ltn5v
         EL6BXXFNaSlItrQE3K/SHZa5l28qlV5L9oS1HMPdI6E4ZqjMcFeRT9IioICALFlQEeAh
         SFJNF0zoZhgkPcOTkJLejvsbFPLcgSjw8nLLfyC9xmd0HGfJkGNRVipE9bnUgrIbX1ON
         SvfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FDG0QRu1oWME9x0G+hGYpYXqzKBkpeCRyLSLI3ohny0=;
        b=A9qeVnUxzMYA1U/14S1LBgXGhRllRJ1FMWyHwWaAdokxFddEftz8/djmdpuKA7it/g
         sIWgT6yXGV9t6V7E26NmCzPF5ew8kL+Qw9k+OM0rwrr1iTi5v/5Tp7Bvcsi281rrvX9U
         olO3kY3JCG9MJCfd650bbtfKx+Z2VIk9IbEVMSXL4n+csonL0wnyeixWL5FUlfPSK7YW
         1KCdnit49GVQlVsU/jphvYLmTgmKnOJlCOqoMPGrPvGYnIMiXw8mz0vu8b4foRTneWj6
         ypsxLophWeSg4AEkV/9eSgFvBQx3BIa0gsBjvZzhETmOvPwQLNxF5BisdHv0Xoc3l2Yg
         MR5w==
X-Gm-Message-State: AOAM532MBanJavw54qGoSJnSAfVOVM/KcFcHi0qGTeNIC25jbkwmGUHT
        D0CizxMMyuEhcyEs56yGX53PRZPSsB0=
X-Google-Smtp-Source: ABdhPJzyAlxm9pnGeQ6YUFxsstA4V0G49vMUGYXzMsoPQUA1vN54MupqFmFaGUeFh/0+RT89Nyha9g==
X-Received: by 2002:a19:c3d5:: with SMTP id t204mr2630608lff.303.1639742778557;
        Fri, 17 Dec 2021 04:06:18 -0800 (PST)
Received: from [192.168.2.145] (94-29-63-156.dynamic.spd-mgts.ru. [94.29.63.156])
        by smtp.googlemail.com with ESMTPSA id t3sm1000266lfe.65.2021.12.17.04.06.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 04:06:17 -0800 (PST)
Subject: Re: [PATCH v4 04/22] dt-bindings: host1x: Document optional HDMI
 sound-dai-cells
To:     Thierry Reding <thierry.reding@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Agneli <poczt@protonmail.ch>, linux-tegra@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20211204143725.31646-1-digetx@gmail.com>
 <20211204143725.31646-5-digetx@gmail.com> <YbtLJeIxXlVyQhd3@orome>
 <Ybxwovlw2GARzqUO@sirena.org.uk>
 <4edfbff2-ffd9-1c33-de0c-013a29dc286c@gmail.com> <Ybx8XdLGGiQsNMTq@orome>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <36972e00-0eb9-acb7-d537-3b9a4b53386d@gmail.com>
Date:   Fri, 17 Dec 2021 15:06:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <Ybx8XdLGGiQsNMTq@orome>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

17.12.2021 15:02, Thierry Reding пишет:
> On Fri, Dec 17, 2021 at 02:55:48PM +0300, Dmitry Osipenko wrote:
>> 17.12.2021 14:12, Mark Brown пишет:
>>> On Thu, Dec 16, 2021 at 03:20:21PM +0100, Thierry Reding wrote:
>>>> On Sat, Dec 04, 2021 at 05:37:07PM +0300, Dmitry Osipenko wrote:
>>>>> Document new optional sound-dai-cells property of HDMI node. This node will
>>>>> be used as endpoint of HDMI sound DAI graph.
>>>
>>>> It's probably best for this to go through ASoC along with the other
>>>> audio-related bindings.
>>>
>>>> Alternatively, I've just sent out a patch that converts the host1x
>>>> bindings to json-schema, so I could work this into that as well.
>>>
>>> It doesn't apply to the ASoC tree for whatever reason so probably best
>>> to roll it in with those JSON updates.
>>>
>>
>> This hos1tx binding patch indeed will conflict with the Thierry's patch.
>>
>> Thierry, will you be able to take the binding patches into the Tegra
>> tree and resolve all those hos1tx binding conflicts there?
> 
> Yes, I'll resolve all of those conflicts in the Tegra tree.

Thank you!

Mark, then you may apply patches 5-13 to ASoC on top of the Vinod's
branch, skipping patch #6. Thanks in advance!
