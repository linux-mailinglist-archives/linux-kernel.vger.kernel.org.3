Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5194ADE06
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 17:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382785AbiBHQMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 11:12:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343745AbiBHQMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 11:12:43 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4152C061576;
        Tue,  8 Feb 2022 08:12:42 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id d9-20020a17090a498900b001b8bb1d00e7so3298312pjh.3;
        Tue, 08 Feb 2022 08:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=kpkkUdw9hDEbl9iY6JvwiBcPEsX9doMapOLQ7w9SniM=;
        b=nGlONSHPuCP7xrRoZrUZbBlRj2P2slaoa9VOEvHKvmOhuoj+QFf4KwqfJWSWXy/p4a
         uHFFPJAd+ZPfL7qrAmtonuCcPC2uDwoZHYMO1YoM44S0ddpfHLy1qSmEnd13TtpvAQJt
         mbqDGz8D8lxp/UhQNCn+ZWt/OX+fvFgCfXWDlsd9Lb8thViMDHtzwvpBZAew9R8cNwqQ
         67NgfP2V4NeF+gRR/zD1bpocmARpxoH8pRYwoOmTOfb2p1EaJekYrdu3gH0YcYU4TdQ2
         BXc0Fs+frYu1RpXCfpFYoZs2pJciEMqT7OoDiDknHgOB3YkgZKlDXZAYommyTciRf/vV
         AnTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kpkkUdw9hDEbl9iY6JvwiBcPEsX9doMapOLQ7w9SniM=;
        b=QYrC2Qo7u8PX5KTwe8oMQC1sJELGTVpTQLgIVCkEpoCDAbg6vxfPeWn8O/ehZtKqHk
         VO3xHFpBvpON42m22zCT8zASsYCa74J9K8jwdH2hKCmO4Sp2BEwfu3Tf2Dsy/cyLKV6R
         GbcntgHYTWFz1OhKw85qvCVygDAXecxPhBobb8vh0N8587zTYwOqFSo+ZWapiz/unzv9
         hLGXDGmgb0y3h/N1Y2Vf2WcixNIgQjjv7AdYMGySyhXkIhg3Adyn3z9gDHvVqelGhZJy
         aOIUjZVZTODZL8r4TKs2s3B0yqX70JoVugwid7xSd2e+slOn00GkKSh7uHE+lcxE68mF
         cdJQ==
X-Gm-Message-State: AOAM532S2lm8nH/CTKM5uqkEOzK1PCcC1XggSzsUHpkA+KyBm0JC69Qx
        28OvDR2fDkOVcdl9PWxFhHk=
X-Google-Smtp-Source: ABdhPJx129DqQjcqHzJxVGpus0P+6s00wGDBWzZmnmlH/JcFZY8cbXvHrQ/gYfQhK2j8gksYY6pCwA==
X-Received: by 2002:a17:90a:5206:: with SMTP id v6mr2133566pjh.220.1644336762130;
        Tue, 08 Feb 2022 08:12:42 -0800 (PST)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id y4sm6354642pgp.5.2022.02.08.08.12.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Feb 2022 08:12:41 -0800 (PST)
Message-ID: <681e31c1-54d8-8a3e-ff0f-683cd5156685@gmail.com>
Date:   Tue, 8 Feb 2022 08:12:39 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v3 4/8] dt-bindings: firmware: arm,scmi: Add
 atomic_threshold optional property
Content-Language: en-US
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com,
        peter.hilber@opensynergy.com, igor.skalkin@opensynergy.com,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
References: <20220208154452.39428-1-cristian.marussi@arm.com>
 <20220208154452.39428-5-cristian.marussi@arm.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220208154452.39428-5-cristian.marussi@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/8/2022 7:44 AM, Cristian Marussi wrote:
> SCMI protocols in the platform can optionally signal to the OSPM agent
> the expected execution latency for a specific resource/operation pair.
> 
> Introduce an SCMI system wide optional property to describe a global time
> threshold which can be configured on a per-platform base to determine the
> opportunity, or not, for an SCMI command advertised to have a higher
> latency than the threshold, to be considered for atomic operations:
> high-latency SCMI synchronous commands should be preferably issued in the
> usual non-atomic mode.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
> v1 --> v2
> - rephrased the property description
> ---
>   .../devicetree/bindings/firmware/arm,scmi.yaml        | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> index eae15df36eef..646bdf2873b5 100644
> --- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> +++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> @@ -81,6 +81,15 @@ properties:
>     '#size-cells':
>       const: 0
>   
> +  atomic_threshold:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      An optional time value, expressed in microseconds, representing, on this
> +      platform, the threshold above which any SCMI command, advertised to have
> +      an higher-than-threshold execution latency, should not be considered for
> +      atomic mode of operation, even if requested.
> +      If left unconfigured defaults to zero.

Underscores in properties is not usually something that is desired, and 
it might be a good idea to put the unit in the property name, how about: 
atomic-threshold-us?

> +
>     arm,smc-id:
>       $ref: /schemas/types.yaml#/definitions/uint32
>       description:
> @@ -264,6 +273,8 @@ examples:
>               #address-cells = <1>;
>               #size-cells = <0>;
>   
> +            atomic_threshold = <10000>;
> +
>               scmi_devpd: protocol@11 {
>                   reg = <0x11>;
>                   #power-domain-cells = <1>;

-- 
Florian
