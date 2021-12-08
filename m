Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 863C546DB16
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 19:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238903AbhLHSdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 13:33:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235074AbhLHSdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 13:33:20 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67DBCC0617A1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 10:29:47 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id n33-20020a05600c502100b0032fb900951eso4817817wmr.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 10:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=g4sFNhovUglXvlR4AfEFcmvmuAeEZqhIvv1BAUKDmJI=;
        b=wFQGzF4w0zTNVutgJFOE4CkYAOmC/PNqOaUx8RAbXbvJ6dVXcO11ui3AYaD7gVzFwk
         TaNi2p9o5z//6ugGJRLJcNzlxMk93grhsuo5a9F1kFf0KHh7stVOgoAMu+HdXRzk4o0K
         0OGss3iig3NYeMff+CybClm/8uDZQ0JZQFduaHLY1L3Hvh3dZa3AfFyT6+q5rjUWtlCV
         otrCevvfLb1lUXoSXRVFf7KOOVArIT5yE6pchyrAYPqeq4ZqVgY309mADJXN+S5FT6/1
         sze5pnzwkX9H/s0WtsCSiFZUzs+xZJafgQljppt1nrtxhKRV35ZqUcoAta/m35+iC6Ql
         gwYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g4sFNhovUglXvlR4AfEFcmvmuAeEZqhIvv1BAUKDmJI=;
        b=qPf+fr4MA7PgWBqKpXazUd/56putlO7wm36499WxM3jgvVDRCznlrN5fQIOw7yp3ZH
         k8dcimFMfJA4WrZG4+VfOgVjsWZWvT9xzORgILtKtzsjlJYbpFjErk9JsnFwX/UVRb19
         Qak+CtKU2TIw2ye6isEYcqxR4Z86FGVQAUej6Mrjpjb/navktgyK5FqFMcuOQ7qWadvI
         FZ6LUAk05r/yp9eYlDQqlkdMdG+CWjz1I95vaB7a5j9NnZp8BWHxtQwK99sR0C3Whd30
         1Q407JmVgnrPBF03rKW1+n5aZjez2IPnkRzIkx/9e4FBnPgztgBNe4bhc8VqYqB/UCGu
         jvrQ==
X-Gm-Message-State: AOAM532/bFH9pFvf0g2dJc42DQeZOIjV+Yzx57N07MrTONj36igMFLTc
        /5v6+/LSVhhPZTFZ9Z+YBxANAA==
X-Google-Smtp-Source: ABdhPJx/nEvhPuXQtJNG519q1+BbnasBvjDSUx/PHl3HELepooDtGhF6bh5cRg5tFr6+BnKrHVpVmQ==
X-Received: by 2002:a1c:4b17:: with SMTP id y23mr458138wma.135.1638988185737;
        Wed, 08 Dec 2021 10:29:45 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:8ae8:ca1f:ff1a:a23d? ([2a01:e34:ed2f:f020:8ae8:ca1f:ff1a:a23d])
        by smtp.googlemail.com with ESMTPSA id d2sm6970935wmb.24.2021.12.08.10.29.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Dec 2021 10:29:45 -0800 (PST)
Subject: Re: [PATCH v4 1/5] dt-bindings: Powerzone new bindings
To:     Rob Herring <robh@kernel.org>
Cc:     arnd@linaro.org, heiko@sntech.de, ulf.hansson@linaro.org,
        rjw@rjwysocki.net, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        lukasz.luba@arm.com, Arnd Bergmann <arnd@arndb.de>
References: <20211205231558.779698-1-daniel.lezcano@linaro.org>
 <CAL_Jsq+JgudbhJVyGWB0RJ2LPQ6xZFJ7TxWzjNtWXky-kCxA4Q@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <1cdd9874-9ea7-ad1c-1351-8729453cd478@linaro.org>
Date:   Wed, 8 Dec 2021 19:29:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+JgudbhJVyGWB0RJ2LPQ6xZFJ7TxWzjNtWXky-kCxA4Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Rob,

thanks for taking the time to review the bindings.

On 07/12/2021 20:58, Rob Herring wrote:
> On Sun, Dec 5, 2021 at 5:16 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>> The proposed bindings are describing a set of powerzones.
>>
>> A power zone is the logical name for a component which is capable of
>> power capping and where we can measure the power consumption.
> 
> How is the power consumption measured? I don't see anything in the
> binding allowing for that.

Mmh, good point.

It is based on the energy model which is built from the
"dynamic-power-coefficient" but this one provides only for CPUs and GPUs
ATM.

In the future, SCMI will provide get/set power/level

What would you suggest?

>> A power zone can aggregate several power zones in terms of power
>> measurement and power limitations. That allows to apply power
>> constraint to a group of components and let the system balance the
>> allocated power in order to comply with the constraint.
>>
>> The ARM System Control and Management Interface (SCMI) can provide a
>> power zone description.
> 
> Instead of DT?

It can use DT or SCMI protocol. That is what I understood from the white
paper [1] page 6

Lukasz may confirm / elaborate ?


>> The powerzone semantic is also found on the Intel platform with the
>> RAPL register.
> 
> That means nothing to me...

The Running Average Power Limit [2]. Each powerzone has a RAPL register
where you can read the power and set the power limit.

>> The Linux kernel powercap framework deals with the powerzones:
>>
>> https://www.kernel.org/doc/html/latest/power/powercap/powercap.html
>>
>> The powerzone can also represent a group of children powerzones, hence
>> the description can result on a hierarchy. Such hierarchy already
>> exists with the hardware or can be represented and computed from the
>> kernel.
>>
>> The hierarchical description was initially proposed but not desired
>> given there are other descriptions like the power domain proposing
>> almost the same description.
>>
>> https://lore.kernel.org/all/CAL_JsqLuLcHj7525tTUmh7pLqe7T2j6UcznyhV7joS8ipyb_VQ@mail.gmail.com/
>>
>> The description gives the power constraint dependencies to apply on a
>> specific group of logically or physically aggregated devices. They do
>> not represent the physical location or the power domains of the SoC
>> even if the description could be similar.
>>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Ulf Hansson <ulf.hansson@linaro.org>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>    V3:
>>      - Removed required property 'compatible'
>>      - Removed powerzone-cells from the topmost node
>>      - Removed powerzone-cells from cpus 'consumers' in example
>>      - Set additionnal property to false
>>    V2:
>>      - Added pattern properties and stick to powerzone-*
>>      - Added required property compatible and powerzone-cells
>>      - Added additionnal property
>>      - Added compatible
>>      - Renamed to 'powerzones'
>>      - Added missing powerzone-cells to the topmost node
>>      - Fixed errors reported by 'make DT_CHECKER_FLAGS=-m dt_binding_check'
>>    V1: Initial post
>> ---
>>  .../devicetree/bindings/power/powerzones.yaml | 97 +++++++++++++++++++
>>  1 file changed, 97 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/power/powerzones.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/power/powerzones.yaml b/Documentation/devicetree/bindings/power/powerzones.yaml
>> new file mode 100644
>> index 000000000000..ddb790acfea6
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/powerzones.yaml
>> @@ -0,0 +1,97 @@
>> +# SPDX-License-Identifier: GPL-2.0
> 
> New bindings should be dual licensed (add BSD-2-Clause).
> 
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/power/powerzones.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Power zones description
>> +
>> +maintainers:
>> +  - Daniel Lezcano <daniel.lezcano@linaro.org>
>> +
>> +description: |+
>> +
>> +  A System on Chip contains a multitude of active components and each
>> +  of them is a source of heat. Even if a temperature sensor is not
>> +  present, a source of heat can be controlled by acting on the
>> +  consumed power via different techniques.
>> +
>> +  A powerzone describes a component or a group of components where we
>> +  can control the maximum power consumption. For instance, a group of
>> +  CPUs via the performance domain, a LCD screen via the brightness,
>> +  etc ...
>> +
>> +  Different components when they are used together can significantly
>> +  increase the overall temperature, so the description needs to
>> +  reflect this dependency in order to assign a power budget for a
>> +  group of powerzones.
>> +
>> +  This description is done via a hierarchy and the DT reflects it. It
>> +  does not represent the physical location or a topology, eg. on a
>> +  big.Little system, the little CPUs may not be represented as they do
>> +  not contribute significantly to the heat, however the GPU can be
>> +  tied with the big CPUs as they usually have a connection for
>> +  multimedia or game workloads.
> 
> Can't most of this just be assumed. We have some DT data already for
> capacity and power per mhz along with opp tables. Isn't that enough
> information?

We have a lot of information already and that is the reason why there is
few information in the description ATM. We need to describe what is a
powerzone and the constraints hierarchy between the powerzones.

The hierarchy could be in the hardware and immutable like the RAPL as
described above which has a RAPL per package, per memory and one on top
of them reporting their energy consumption.

Here we want to describe how we want to aggregate the powerzones, so the
power constraints will be hierarchically described.

> The correlation with CPU and GPU usage is totally workload dependent
> which has nothing to do with DT. 

I was probably unclear, IMO it is platform specific.

For example, let's imagine we have a *thermal* sensor between the Bigs
and the GPU. There is no way to know which one is contributing and how
to mitigate them.

But if we know the sustainable power for the big+gpu is eg. 5000mW, then
we can group them under the same powerzone parent and set its power to
the sustainable one. From there it is possible to ensure the power limit
and act on the power for each of them.

> Nor it is platform specific really.

The problem is we have devices which are powerzones (CPU, GPU, screen
backlight, memory, DSP, ...) and AFAICT they can be described in the DT
as such (may be just with a property), right?

Unfortunately, we have only a part of the description because we don't
have the relationship between them. Can this relationship be described
in the DT?

  -- D.

[1]
https://developer.arm.com/-/media/Arm%20Developer%20Community/PDF/Arm_Power_and_Performance_Management_SCMI_White_Paper.pdf?revision=15e9d3dd-ecc6-40ab-a8c5-6bb4fa3fc060

[2] https://01.org/blogs/2014/running-average-power-limit-%E2%80%93-rapl

>> +
>> +properties:
>> +  $nodename:
>> +    const: powerzones
>> +
>> +patternProperties:
>> +  "^(powerzone)([@-].*)?$":
>> +    type: object
>> +    description:
>> +      A node representing a powerzone acting as an aggregator for all
>> +      its children powerzones.
>> +
>> +    properties:
>> +      "#powerzone-cells":
>> +        description:
>> +          Number of cells in powerzone specifier. Typically 0 for nodes
>> +          representing but it can be any number in the future to
>> +          describe parameters of the powerzone.
>> +
>> +      powerzones:
>> +        description:
>> +          A phandle to a parent powerzone. If no powerzone attribute is
>> +          set, the described powerzone is the topmost in the hierarchy.
>> +
>> +    required:
>> +      - "#powerzone-cells"
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    powerzones {
>> +
>> +      SOC_PZ: powerzone-soc {
>> +        #powerzone-cells = <0>;
>> +      };
>> +
>> +      PKG_PZ: powerzone-pkg {
>> +        #powerzone-cells = <0>;
>> +        powerzones = <&SOC_PZ>;
>> +      };
>> +
>> +      GPU_PZ: powerzone-gpu {
>> +        #powerzone-cells = <0>;
>> +        powerzones = <&PKG_PZ>;
>> +      };
>> +    };
>> +
>> +  - |
>> +    A57_0: big@0 {
>> +      compatible = "arm,cortex-a57";
>> +      reg = <0x0 0x0>;
>> +      device_type = "cpu";
>> +      powerzones = <&PKG_PZ>;
>> +    };
>> +
>> +    A57_1: big@1 {
>> +      compatible = "arm,cortex-a57";
>> +      reg = <0x0 0x0>;
>> +      device_type = "cpu";
>> +      powerzones = <&PKG_PZ>;
>> +    };
>> +...
>> --
>> 2.25.1
>>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
