Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6012F47E409
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 14:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348623AbhLWNUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 08:20:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348613AbhLWNUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 08:20:43 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842CAC061756
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 05:20:43 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id s1so11433964wra.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 05:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IeWWgFUpDxL4XHVhcJHTGPTnXsO6GVnksgWFNTbGDHs=;
        b=z0fvxsqA0NAl2tBkKhm6Ku8bNZU9/NJXf5W5jeKyotrlyZcr3L09JyZ2W+jYLGgYlt
         RvOIurRn9+FjQN4CBh0f6cwoXACOSAtEWOKqO60qOPmEenfYTbJh9C+3mwyOXVN6wO08
         AUEwj6yi8wyEFeBmGhdf+qOoRIhxE8cTULf3ZNwFcsvfzaUJfIHWapV3ujGQvfBtl9De
         WaD2ojdU/lqO5eU0pCVTKISkepK4NBzNobBHAsIvyltH8VUC/lPzDjYqEF5wAAvwdP1Y
         UnQGibtyslp9KzK+Z0p1PNn2FSMtPfUlqQ2nuIidO/Su+cehsn/20ltYzle+/3FJqWlD
         or8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IeWWgFUpDxL4XHVhcJHTGPTnXsO6GVnksgWFNTbGDHs=;
        b=DwgEPPTlA3bygjD/LUwdxMB5pQZGpzqiOKri6G6lTYnyPWx/eW0RxVRpRCflZofSKt
         Tlo8R3yLS/LrOSydzVlu5Cbq65+QlhOt284EpU6KfVfkPR9Ewevfgx3zxv3hYEd6RrQ3
         hxXnB7t5uxDMQu1tBHdkuZay34QW55bTkudo9E9EdPnwaTVbSEIgpq9t0EBrJUziSTaQ
         czfb0Qx9c6TK+0hGtrjPbIJDpEK0Q7n52X86Yv2rv5+pD6hHJVnfLupUiY1wtJCHNRMf
         4AgDamRxpJVRi3zijSQChKZUDnrXUcwlRlgG6OSFUifRHOPWgumU4pXpAKCOmnEhXCkO
         xnqw==
X-Gm-Message-State: AOAM530ggJpvCbrn66zI+K4+0McCTR2Y9yapL6fFdFSGXrnA7AJASBN4
        h04nodvrlox/qEpGbhkmMBcxkQ==
X-Google-Smtp-Source: ABdhPJw4TKi4oHUWZhWvD1KOht0oYxvcDfAg0Gvn0f3onCmQH26Y5Q9dKK6kNVLG9K6vi7I6KSn3/g==
X-Received: by 2002:a5d:5348:: with SMTP id t8mr1739246wrv.439.1640265641891;
        Thu, 23 Dec 2021 05:20:41 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:34ca:f67b:b782:1949? ([2a01:e34:ed2f:f020:34ca:f67b:b782:1949])
        by smtp.googlemail.com with ESMTPSA id i9sm5229082wrb.84.2021.12.23.05.20.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Dec 2021 05:20:41 -0800 (PST)
Subject: Re: [PATCH v5 0/6] powercap/drivers/dtpm: Create the dtpm hierarchy
To:     rjw@rjwysocki.net
Cc:     lukasz.luba@arm.com, robh@kernel.org, heiko@sntech.de,
        arnd@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, ulf.hansson@linaro.org
References: <20211218130014.4037640-1-daniel.lezcano@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <3badc321-381d-a48c-8abd-7702639304bb@linaro.org>
Date:   Thu, 23 Dec 2021 14:20:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211218130014.4037640-1-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

any comments on this series. Is it fine if I merge it without patch 6/6?

Heiko, is the description fine for you in the SoC specific code?

Thanks
  -- Daniel

On 18/12/2021 14:00, Daniel Lezcano wrote:
> The DTPM hierarchy is the base to build on top of it a power budget
> allocator. It reflects the power consumption of the group of devices
> and allows to cap their power.
> 
> The core code is there but there is no way to describe the desired
> hierarchy yet.
> 
> A first proposal introduced the description through configfs [1] but
> was rejected [2].
> 
> A second proposal based on the device tree with a binding similar to
> the power domains [3] was proposed but finally rejected [4].
> 
> This fifth version delegates the hierarchy creation to the SoC with a
> specific and self-encapsulated code using an array to describe the tree. The
> SoC DTPM driver defines an array of nodes pointing to their parents.  The
> hierarchy description can integrate a DT node and in the future a SCMI node,
> that means the description can mix different type of nodes.
> 
> In addition to the hierarchy creation, the devfreq dtpm support is also
> integrated into this series.
> 
> This series was tested on a rock960 (revision B - rk3399 based) and a
> db845c (Qualcomm sdm845 based).
> 
> [1] https://lore.kernel.org/all/20210401183654.27214-1-daniel.lezcano@linaro.org/
> [2] https://lore.kernel.org/all/YGYg6ZeZ1181%2FpXk@kroah.com/
> [3] https://lore.kernel.org/all/20211205231558.779698-1-daniel.lezcano@linaro.org/
> [4] https://lore.kernel.org/all/YbfFapsmsjs4qnsg@robh.at.kernel.org/
> 
> Changelog:
>    V5:
>    - Remove DT bindings
>    - Added description with an array
>    - Added simple description for rk3399 and sdm845
>    - Moved dtpm table to the data section
>    
>    V4:
>    - Added missing powerzone-cells
>    - Changed powerzone name to comply with the pattern property
> 
>    V3:
>    - Remove GPU section as no power is available (yet)
>    - Remove '#powerzone-cells' conforming to the bindings change
>    - Removed required property 'compatible'
>    - Removed powerzone-cells from the topmost node
>    - Removed powerzone-cells from cpus 'consumers' in example
>    - Set additionnal property to false
> 
>    V2:
>    - Added pattern properties and stick to powerzone-*
>    - Added required property compatible and powerzone-cells
>    - Added additionnal property
>    - Added compatible
>    - Renamed to 'powerzones'
>    - Added missing powerzone-cells to the topmost node
>    - Fixed errors reported by 'make DT_CHECKER_FLAGS=-m dt_binding_check'
>    - Move description in the SoC dtsi specific file
>    - Fixed missing prototype warning reported by lkp@
> 
>    V1: Initial post
> 
> Daniel Lezcano (6):
>   powercap/drivers/dtpm: Move dtpm table from init to data section
>   powercap/drivers/dtpm: Add hierarchy creation
>   powercap/drivers/dtpm: Add CPU DT initialization support
>   powercap/drivers/dtpm: Add dtpm devfreq with energy model support
>   rockchip/soc/drivers: Add DTPM description for rk3399
>   qcom/soc/drivers: Add DTPM description for sdm845
> 
>  drivers/powercap/Kconfig          |   8 ++
>  drivers/powercap/Makefile         |   1 +
>  drivers/powercap/dtpm.c           | 155 ++++++++++++++++++++++-
>  drivers/powercap/dtpm_cpu.c       |  37 ++++--
>  drivers/powercap/dtpm_devfreq.c   | 201 ++++++++++++++++++++++++++++++
>  drivers/soc/qcom/Kconfig          |   9 ++
>  drivers/soc/qcom/Makefile         |   1 +
>  drivers/soc/qcom/dtpm.c           |  65 ++++++++++
>  drivers/soc/rockchip/Kconfig      |   8 ++
>  drivers/soc/rockchip/Makefile     |   1 +
>  drivers/soc/rockchip/dtpm.c       |  56 +++++++++
>  include/asm-generic/vmlinux.lds.h |   4 +-
>  include/linux/dtpm.h              |  21 +++-
>  13 files changed, 551 insertions(+), 16 deletions(-)
>  create mode 100644 drivers/powercap/dtpm_devfreq.c
>  create mode 100644 drivers/soc/qcom/dtpm.c
>  create mode 100644 drivers/soc/rockchip/dtpm.c
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
