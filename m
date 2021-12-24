Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00A8747F04B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 18:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353281AbhLXRLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 12:11:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbhLXRLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 12:11:42 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48278C061401
        for <linux-kernel@vger.kernel.org>; Fri, 24 Dec 2021 09:11:42 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id u20so8167736pfi.12
        for <linux-kernel@vger.kernel.org>; Fri, 24 Dec 2021 09:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=1AGcBsnzvy5lyVMqgyfzAtPvXS7sOctvHHP5fe6m0Vk=;
        b=gvGi9kDjBlHdfCwbY2/Ul+0imv8s6dTjZpjxEobKK61pD27Xp5W40n8Jg9IeNjzjxR
         8v24Nbq7MF17PpPtu2lXhu3x9sXZ7Vg67L1MjDferOmju9qWwg1tc5Evft++FtrAH1mt
         KUUj/zzoR4GtuF8OHR8W+GtQlYZedvq2ZapZEBtnWF7Vz8txDmVPpvGkVPifDvigHuMJ
         r8NKIUMV7LDzY5bhelLQGKFZ//1QC6Li00hOXmitWDpRtra0vJHUZEYh9N1w1fGU/TJT
         xP1IjIJ3hVE5GCaSBdichn4B+Jn+371z0ffLg0Y09dbT24HPvXh2QuJvw6KtKyfK+sFw
         ICWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1AGcBsnzvy5lyVMqgyfzAtPvXS7sOctvHHP5fe6m0Vk=;
        b=MLQqyTnqBGI+jPyrOx+OnqKeFbipaxs7OxmSXTSxeatRGc9FS+hrDB/GE/Afxlqwvl
         EC9SDEAqax3r12KsSIYFuiZWqDiLVqSp4C3jc4yYJHO15ZsskfGVrx2/kA5k4lFkdjzX
         VCafjO77bJlpsEFvAy5UJPjf6ahdVDcxfQxtMlt4iN+tw72OKg10JeDQErBp6P5xyjUt
         zo7I1KOeSSmfLnradekG1wawECv8c0Y/tauB5oHC/N4TenF+l6MDzcCFiigJTkxuwXRC
         lgbpQBc8+W21lFU1qODHlsLzjEtBtkYneU3DxojYV1g5Zw23LIqhdTg9MhoRghFGOOgJ
         rChw==
X-Gm-Message-State: AOAM533MEANKT5i3eCFPt5I8NGfDVSw5pdGYnPwR/r1F1S+GP7a8wZTj
        m1580QH7Q6pjUU4MCz/YdnY=
X-Google-Smtp-Source: ABdhPJzZ1vyB3OCSJEQ/BQzyEkEkQF25dIlgc8xh3ERnuBsBfZMeJ91Qw3UGMMuEse41Lf4HEj+V6w==
X-Received: by 2002:a62:6dc2:0:b0:4af:98e:1d3b with SMTP id i185-20020a626dc2000000b004af098e1d3bmr7691497pfc.52.1640365901764;
        Fri, 24 Dec 2021 09:11:41 -0800 (PST)
Received: from ?IPV6:2600:8802:b00:4a48:81cd:f5a9:7f89:a39c? ([2600:8802:b00:4a48:81cd:f5a9:7f89:a39c])
        by smtp.gmail.com with ESMTPSA id p13sm1685987pgl.23.2021.12.24.09.11.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Dec 2021 09:11:41 -0800 (PST)
Message-ID: <7e480da8-0d54-2d62-0a8e-184901c974b6@gmail.com>
Date:   Fri, 24 Dec 2021 09:11:39 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [GIT PULL 0/5] SoC changes for 5.17
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Olof Johansson <olof@lixom.net>
Cc:     SoC Team <soc@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <CAK8P3a0RDZpLtWjMEU1QVWSjOoqRAH6QxQ+ZQnJc8LwaV7m+JQ@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <CAK8P3a0RDZpLtWjMEU1QVWSjOoqRAH6QxQ+ZQnJc8LwaV7m+JQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd, Olof,

On 12/23/2021 13:31, Arnd Bergmann wrote:
> I'm sending out the pull requests for 5.17 early, as I won't have access to
> my workstation for the next two weeks. With only 760 non-merge commits,
> this again feels quieter than the massive previous merge window, but the
> number of changed lines was actually slightly higher.
> 
> There are very few changes aside from devicetree patches, most of
> which are for the i.MX, Tegra, Qualcomm, Apple, K3 and Aspeed
> platforms.
> 
> We have a couple of new SoCs in existing families:
> 
>   - Qualcomm Snapdragon 8 Gen1
>   - Qualcomm Snapdragon SDX65
>   - NXP i.MX8ULP
>   - Texas Instruments j721s2
>   - Renesas R-Car S4-8
> 
> The time between product announcement and kernel support is fairly short
> for all of these, which is nice. In particular the two Snapdragons were only
> announced this month and are the current high end of Qualcomm's products.
> On the other end of the spectrum, we also add support for ST SPEAr320s,
> which was launched 10 years ago.
> 
> Aside from the Arm chips, there is also a pull request for a new RISC-V SoC,
> the Starfive JH7100, including some of the basic drivers to make it boot.

There seems to half of the submitted Broadcom SoCs pull request missing 
in this one, was there issues with those below:

defconfigs:

https://lore.kernel.org/linux-arm-kernel/20211221220642.2862218-1-f.fainelli@gmail.com/
https://lore.kernel.org/linux-arm-kernel/20211221220642.2862218-2-f.fainelli@gmail.com/

drivers:

https://lore.kernel.org/linux-arm-kernel/20211221220642.2862218-5-f.fainelli@gmail.com/

Should I resend or fix something in those? Thanks!

Happy holidays!
-- 
Florian
