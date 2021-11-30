Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD54F462F80
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 10:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240137AbhK3J2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 04:28:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240134AbhK3J17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 04:27:59 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC24CC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 01:24:40 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id u1so42841888wru.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 01:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yB0eWfE4eeemBgIkAqSMbGTWDerG7jyNQ2dFqY6J6Iw=;
        b=aWaKTO/tUiOdel7w7i49eEDCCTHBWt76TvmKCMvsR0kJu1ICOrGglzBYV7sJ4wAEVV
         HEu4abOrsMHg7WjvjE5Alvwiiulpoo8fHfKhhon/0fexy5E3gSah9RWGYHELAuIWxuLM
         9BC7mJ5eu/7hmjSfvd+XFgWCdfi0g6xqjUleWTfXKLx/FgfJSgGezhwwOFuAUzOAW6gK
         rXHhJNN1ElK3jYJhK7mRTk6Cp3M6YVde80PMT1j66j5bpYhalj2l1b3faPPgnQP6ZGnW
         fNLLpQaOU3Q6N0kJjWzOZEKmAey3XZ60BOnjgoeEDzW60NGNei/ApL0Jmh4oeWGdEYHS
         JVVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yB0eWfE4eeemBgIkAqSMbGTWDerG7jyNQ2dFqY6J6Iw=;
        b=PnoXkzXCsqxd2x8CkG0CvmK42PgLpiovnTYPlfaJPWHrFt1sNzMyBjLTzWQZXJLw0c
         lw8ky8xEN1OfCeS4M22yxVeIlUEwGlWEtIMVxqDM9uSjatjqan+F6WNS8pi9UZqfNpxk
         QTZAW5ZpPZFclUFQj7D472eSaRy4jQCUfXr8YP529ejDoz9Pycm5iskbU3Hq/ZADfI3o
         9kpT1SjEaIwfPUae7vre8Oyfrwck1f/id7aN+C+OThIoc9BMR2dJnueJmrfQnC2/jtEJ
         ZPrYRCkFg6Xwc10dp+bd3bFSCZTEyTiiwuc7wTya8gHqtLHYTQvLM9Adu6sCVGcfyMpp
         XXPQ==
X-Gm-Message-State: AOAM532Dhxx8NNpoHr/VQlnRbawRbvDS3ZTh4yT0FKjVJiTeCAXr55XK
        BPIdyZqEIVePIy201BXD0wWwOWCdwNbBIA==
X-Google-Smtp-Source: ABdhPJwtkbhBHUtQ/K6qf88p2EgqL4dRD3bgO+PKHEoiEabkzpxApR+DYjMi2jEb7cv2c7pNk4pFrw==
X-Received: by 2002:adf:f151:: with SMTP id y17mr39346595wro.153.1638264279264;
        Tue, 30 Nov 2021 01:24:39 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:7880:daae:2d50:bb5e? ([2a01:e34:ed2f:f020:7880:daae:2d50:bb5e])
        by smtp.googlemail.com with ESMTPSA id r8sm20090958wrz.43.2021.11.30.01.24.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Nov 2021 01:24:38 -0800 (PST)
Subject: Re: [PATCH 1/7] x86/Documentation: Describe the Intel Hardware
 Feedback Interface
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pm@vger.kernel.org
Cc:     x86@kernel.org, linux-doc@vger.kernel.org,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        linux-kernel@vger.kernel.org
References: <20211106013312.26698-1-ricardo.neri-calderon@linux.intel.com>
 <20211106013312.26698-2-ricardo.neri-calderon@linux.intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <81bca26d-eac8-31ed-e5ec-81812664d671@linaro.org>
Date:   Tue, 30 Nov 2021 10:24:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211106013312.26698-2-ricardo.neri-calderon@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,

On 06/11/2021 02:33, Ricardo Neri wrote:
> Start a documentation file to describe the purpose and operation of Intel's
> Hardware Feedback Interface. Describe how this interface is used in Linux
> to relay performance and energy efficiency updates to userspace.
> 
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Aubrey Li <aubrey.li@linux.intel.com>
> Cc: Tim Chen <tim.c.chen@linux.intel.com>
> Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
> Reviewed-by: Len Brown <len.brown@intel.com>
> Suggested-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> ---
>  Documentation/x86/index.rst     |  1 +
>  Documentation/x86/intel-hfi.rst | 68 +++++++++++++++++++++++++++++++++
>  2 files changed, 69 insertions(+)
>  create mode 100644 Documentation/x86/intel-hfi.rst
> 
> diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
> index 383048396336..f103821ee095 100644
> --- a/Documentation/x86/index.rst
> +++ b/Documentation/x86/index.rst
> @@ -21,6 +21,7 @@ x86-specific Documentation
>     tlb
>     mtrr
>     pat
> +   intel-hfi
>     intel-iommu
>     intel_txt
>     amd-memory-encryption
> diff --git a/Documentation/x86/intel-hfi.rst b/Documentation/x86/intel-hfi.rst
> new file mode 100644
> index 000000000000..f5cb738170a5
> --- /dev/null
> +++ b/Documentation/x86/intel-hfi.rst
> @@ -0,0 +1,68 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +============================================================
> +Hardware-Feedback Interface for scheduling on Intel Hardware
> +============================================================
> +
> +Overview
> +--------
> +
> +Intel has described the Hardware Feedback Interface (HFI) in the Intel 64 and
> +IA-32 Architectures Software Developer's Manual (Intel SDM) Volume 3 Section
> +14.6 [1]_.
> +
> +The HFI gives the operating system a performance and energy efficiency
> +capability data for each CPU in the system. Linux can use the information from
> +the HFI to influence task placement decisions.
> +
> +The Hardware Feedback Interface
> +-------------------------------
> +
> +The Hardware Feedback Interface provides to the operating system information
> +about the performance and energy efficiency of each CPU in the system. Each
> +capability is given as a unit-less quantity in the range [0-255]. Higher values
> +indicate higher capability. Energy efficiency and performance are reported in
> +separate capabilities.

Are they linked together (eg. higher energy efficiency => lower
performance)?

> +These capabilities may change at runtime as a result of changes in the
> +operating conditions of the system or the action of external factors.

Is it possible to give examples?

> The rate
> +at which these capabilities are updated is specific to each processor model. On
> +some models, capabilities are set at boot time and never change. On others,
> +capabilities may change every tens of milliseconds.
> +
> +The kernel or a userspace policy daemon can use these capabilities to modify
> +task placement decisions. For instance, if either the performance or energy
> +capabilities of a given logical processor becomes zero, it is an indication that
> +the hardware recommends to the operating system to not schedule any tasks on
> +that processor for performance or energy efficiency reasons, respectively.

How the userspace can be involved in these decisions? If the performance
is impacted then that should be reflected in the CPU capacity. The
scheduler will prevent to put task on CPU with a low capacity, no?

I'm also worried about the overhead of the userspace notifications.

That sounds like similar to the thermal pressure? Wouldn't make sense to
create a generic component where HFI, cpufreq cooling, LMh, etc ... are
the backend?



> +Implementation details for Linux
> +--------------------------------
> +
> +The infrastructure to handle thermal event interrupts has two parts. In the
> +Local Vector Table of a CPU's local APIC, there exists a register for the
> +Thermal Monitor Register. This register controls how interrupts are delivered
> +to a CPU when the thermal monitor generates and interrupt. Further details
> +can be found in the Intel SDM Vol. 3 Section 10.5 [1]_.
> +
> +The thermal monitor may generate interrupts per CPU or per package. The HFI
> +generates package-level interrupts. This monitor is configured and initialized
> +via a set of machine-specific registers. Specifically, the HFI interrupt and
> +status are controlled via designated bits in the IA32_PACKAGE_THERM_INTERRUPT
> +and IA32_PACKAGE_THERM_STATUS registers, respectively. There exists one HFI
> +table per package. Further details can be found in the Intel SDM Vol. 3
> +Section 14.9 [1]_.
> +
> +The hardware issues an HFI interrupt after updating the HFI table and is ready
> +for the operating system to consume it. CPUs receive such interrupt via the
> +thermal entry in the Local APIC's Local Vector Table.
> +
> +When servicing such interrupt, the HFI driver parses the updated table and
> +relays the update to userspace using the thermal notification framework. Given
> +that there may be many HFI updates every second, the updates relayed to
> +userspace are throttled at a rate of CONFIG_HZ jiffies.
> +
> +References
> +----------
> +
> +.. [1] https://www.intel.com/sdm
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
