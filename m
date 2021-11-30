Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD993463C3A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 17:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238425AbhK3Qws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 11:52:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244378AbhK3Qwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 11:52:31 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A891C061748
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 08:48:50 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id n33-20020a05600c502100b0032fb900951eso20042085wmr.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 08:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:cc:references:to:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fUtjjnW/Xur7zV2zhkBycInNirXdYIMaImNBHYOml7c=;
        b=Lc7eZfadSX8PFumt4lkRky52U9gNWQ6KUsR07sNJLsHu9SoP/vEVnMGM4BQnitfw3+
         2/C+nNGybN0JGe8UPI05/nb7ueoGYIYzQCeGJfEY3YC9y3rU1xZu6deuv5XNPVzMbc++
         4iJ+tkZk9q6JQiXSU7vKzr96dyZrwfqxVvlqlQCyUkKp9cXQdHBhWWcpNJi28ZbRdetG
         V4CziyMGXe/0l8yceVShfUT4JqijymTvhi05pJl49URULVpy7Tf4+pljp4YBV2pfL7nU
         OhprbZwE5yQCZNoA5VRcgNSOYgZ9chGo6z49Mo9ZDg6wYmPYune6mhmxjs9DLS2STEDL
         S2tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:cc:references:to:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fUtjjnW/Xur7zV2zhkBycInNirXdYIMaImNBHYOml7c=;
        b=2mnMb7Q2Cfmzar1Gyr6MEf95ObsTABqWAwqsN84srWm6aWrldhOYFPviD8RfKYxvv+
         eG1nbGD6P2hbiM/9+fby5VLJATqpgQy9tALMY8CQTsa/5QQBhw6sboXYy/2mWDx1JWiG
         Xn02CWJLWRYeyY872G4Xl8gJOHycpV+2Vsq8usdrmRtGuXXoa77WxWLq9NJsyKjr+hPh
         Gidr8UQmL7yg7byEG6VFvqoFLWkMeLMItPnoM3/qC4MLoEIdTfW/Kf24r+wS/1BKIbbQ
         KUURVBb8zRvMv3pZww/irs6YZJvFSvlZ4F86LCIQwHFhS+6lm8JdMs6c83Fn3DL2JDfy
         avxA==
X-Gm-Message-State: AOAM532S/dzJr8fXoRyDeZk6NSb7duE1T3XNRZFTPKpqg4+s9KwW/Zfc
        udFIwSrA9E6pOunf4DAgzZCinw==
X-Google-Smtp-Source: ABdhPJzHsW0Cm+sJwXLAWaU0mkh/35WP9qjf5GLiAU2FFMaPO7gtVcUwQ3esKftfeF7Ziew/X3aEMg==
X-Received: by 2002:a05:600c:510d:: with SMTP id o13mr723422wms.104.1638290928598;
        Tue, 30 Nov 2021 08:48:48 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:ae29:582a:93e5:4eb8? ([2a01:e34:ed2f:f020:ae29:582a:93e5:4eb8])
        by smtp.googlemail.com with ESMTPSA id s8sm17833568wra.9.2021.11.30.08.48.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Nov 2021 08:48:48 -0800 (PST)
Subject: Re: [PATCH v2 1/5] dt-bindings: Powerzone new bindings
Cc:     heiko@sntech.de, rjw@rjwysocki.net, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        lukasz.luba@arm.com, Arnd Bergmann <arnd@arndb.de>
References: <20211126181500.3404129-1-daniel.lezcano@linaro.org>
To:     robh@kernel.org, arnd@linaro.org, ulf.hansson@linaro.org,
        Rob Herring <robh+dt@kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <46496cb1-9707-e9c7-3c06-3248a433bafe@linaro.org>
Date:   Tue, 30 Nov 2021 17:48:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211126181500.3404129-1-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I believe I took into account all the comments, is this bindings fine?

Thanks
   -- D.

On 26/11/2021 19:14, Daniel Lezcano wrote:
> The proposed bindings are describing a set of powerzones.
> 
> A power zone is the logical name for a component which is capable of
> power capping and where we can measure the power consumption.
> 
> A power zone can aggregate several power zones in terms of power
> measurement and power limitations. That allows to apply power
> constraint to a group of components and let the system balance the
> allocated power in order to comply with the constraint.
> 
> The ARM System Control and Management Interface (SCMI) can provide a
> power zone description.
> 
> The powerzone semantic is also found on the Intel platform with the
> RAPL register.
> 
> The Linux kernel powercap framework deals with the powerzones:
> 
> https://www.kernel.org/doc/html/latest/power/powercap/powercap.html
> 
> The powerzone can also represent a group of children powerzones, hence
> the description can result on a hierarchy. Such hierarchy already
> exists with the hardware or can be represented an computed from the
> kernel.
> 
> The hierarchical description was initially proposed but not desired
> given there are other descriptions like the power domain proposing
> almost the same description.
> 
> https://lore.kernel.org/all/CAL_JsqLuLcHj7525tTUmh7pLqe7T2j6UcznyhV7joS8ipyb_VQ@mail.gmail.com/
> 
> The description gives the power constraint dependencies to apply on a
> specific group of logically or physically aggregated devices. They do
> not represent the physical location or the power domains of the SoC
> even if the description could be similar.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>    V1: Initial post
>    V2:
>      - Added pattern properties and stick to powerzone-*
>      - Added required property compatible and powerzone-cells
>      - Added additionnal property
>      - Added compatible
>      - Renamed to 'powerzones'
>      - Added missing powerzone-cells to the topmost node
>      - Fixed errors reported by 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> ---
>  .../devicetree/bindings/power/powerzones.yaml | 109 ++++++++++++++++++
>  1 file changed, 109 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/powerzones.yaml
> 
> diff --git a/Documentation/devicetree/bindings/power/powerzones.yaml b/Documentation/devicetree/bindings/power/powerzones.yaml
> new file mode 100644
> index 000000000000..6e63bbc750c6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/powerzones.yaml
> @@ -0,0 +1,109 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/powerzones.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Power zones description
> +
> +maintainers:
> +  - Daniel Lezcano <daniel.lezcano@linaro.org>
> +
> +description: |+
> +
> +  A System on Chip contains a multitude of active components and each
> +  of them is a source of heat. Even if a temperature sensor is not
> +  present, a source of heat can be controlled by acting on the
> +  consumed power via different techniques.
> +
> +  A powerzone describes a component or a group of components where we
> +  can control the maximum power consumption. For instance, a group of
> +  CPUs via the performance domain, a LCD screen via the brightness,
> +  etc ...
> +
> +  Different components when they are used together can significantly
> +  increase the overall temperature, so the description needs to
> +  reflect this dependency in order to assign a power budget for a
> +  group of powerzones.
> +
> +  This description is done via a hierarchy and the DT reflects it. It
> +  does not represent the physical location or a topology, eg. on a
> +  big.Little system, the little CPUs may not be represented as they do
> +  not contribute significantly to the heat, however the GPU can be
> +  tied with the big CPUs as they usually have a connection for
> +  multimedia or game workloads.
> +    
> +properties:
> +  $nodename:
> +    const: powerzones
> +
> +  compatible:
> +    const: powerzones
> +
> +patternProperties:
> +  "^(powerzone)([@-].*)?$":
> +    type: object
> +    description:
> +      A node representing a powerzone acting as an aggregator for all
> +      its children powerzones.
> +
> +    properties:
> +      "#powerzone-cells":
> +        description:
> +          Number of cells in powerzone specifier. Typically 0 for nodes
> +          representing but it can be any number in the future to
> +          describe parameters of the powerzone.
> +
> +      powerzones:
> +        description:
> +          A phandle to a parent powerzone. If no powerzone attribute is
> +          set, the described powerzone is the topmost in the hierarchy.
> +
> +    required:
> +      - "#powerzone-cells"
> +
> +required:
> +  - compatible
> +
> +additionalProperties: true
> +
> +examples:
> +  - |
> +    powerzones {
> +
> +      compatible = "powerzones";
> +
> +      #powerzone-cells = <0>;
> +
> +      SOC_PZ: powerzone-soc {
> +        #powerzone-cells = <0>;
> +      };
> +
> +      PKG_PZ: powerzone-pkg {
> +        #powerzone-cells = <0>;
> +        powerzones = <&SOC_PZ>;
> +      };
> +
> +      GPU_PZ: powerzone-gpu {
> +        #powerzone-cells = <0>;
> +        powerzones = <&PKG_PZ>;
> +      };
> +    };
> +
> +  - |
> +    A57_0: big@0 {
> +      compatible = "arm,cortex-a57";
> +      reg = <0x0 0x0>;
> +      device_type = "cpu";
> +      #powerzone-cells = <0>;
> +      powerzones = <&PKG_PZ>;
> +    };
> +
> +    A57_1: big@1 {
> +      compatible = "arm,cortex-a57";
> +      reg = <0x0 0x0>;
> +      device_type = "cpu";
> +      #powerzone-cells = <0>;
> +      powerzones = <&PKG_PZ>;
> +    };
> +...
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
