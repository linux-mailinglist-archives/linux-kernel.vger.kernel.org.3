Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D563C4BF4A5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 10:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbiBVJ1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 04:27:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbiBVJ1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 04:27:39 -0500
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6944EAC925;
        Tue, 22 Feb 2022 01:27:14 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id qx21so40840177ejb.13;
        Tue, 22 Feb 2022 01:27:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hozujUNDxQYWs0z4Yohi78rvGC8YWWcZ/HA3dpl2q7E=;
        b=bVOuxCn8ZCxUJ8R71qARPlCiRaIvC8bQyUT/u/je5vmx7tB9UrZ+5SU5xtQMl5lB/V
         KSxoHvjhd/0z286QiwM83I6OduRjlRtZJ4cz+q93UTfHc9BqTrNCAKIMIawdlV0QNa7x
         al6qtN8cAH+GYDwbQsntac0d4c1rdabpHNa/gCZurpNZ5eCYLmAj7dwSlzi0ZXnW0Kjg
         ify1Bs9L2BA0vvW8vTu1MGXUSY26VfkOv3f3BQRmR89Tk2FGT0b1fDiBcAwmDWfYwqR9
         pYx/g+Qk9BWgRatBhigNkpXWXszxhlQa3rIkdSiW7u5rpFSiR3E58h4mZf7qlvrq9vzk
         pwnw==
X-Gm-Message-State: AOAM532Zdub0UldDPV4iK4NG6vrUzKQDipnqk8qoCvEJj1IQcOJLp9/r
        RZFr4jabG/AjXW0Pqavm+TVkEui8K0Y=
X-Google-Smtp-Source: ABdhPJySyXFu/4L5OU/8cKuytxrd02nUbQ50nye4mtpUoe7hIbFWYgfioRnOnAG5v842r3HAjhPAOw==
X-Received: by 2002:a17:907:765a:b0:6d1:bc6:df10 with SMTP id kj26-20020a170907765a00b006d10bc6df10mr10611324ejc.254.1645522032710;
        Tue, 22 Feb 2022 01:27:12 -0800 (PST)
Received: from [192.168.0.122] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.googlemail.com with ESMTPSA id q16sm5691100ejc.21.2022.02.22.01.27.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 01:27:11 -0800 (PST)
Message-ID: <e9ef5936-63dc-f959-13f3-6ab3e9bf140b@kernel.org>
Date:   Tue, 22 Feb 2022 10:27:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH 0/1] dt-bindings: arm: Add scmi_devid paramter for
Content-Language: en-US
To:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1645460043.git.oleksii_moisieiev@epam.com>
 <2546477f-4190-e838-3095-f47b31802445@kernel.org>
 <20220221213932.GA164964@EPUAKYIW015D>
 <7f17ab8f-429f-d2e0-8f5f-bfa2dd19cc49@kernel.org>
 <20220222085532.GA439897@EPUAKYIW015D>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220222085532.GA439897@EPUAKYIW015D>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/02/2022 09:55, Oleksii Moisieiev wrote:
> 
>>
>> 2. Does your example work properly? Passes dt_binding_check? Reg looks
>> different than unit-address.
>>
> dt_bindings_check passes without errors. Also I've checked this file
> explicitly by using command:
> yamllint -c Documentation/devicetree/bindings/.yamllint Documentation/devicetree/bindings/firmware/arm,scmi-devid.yaml
> 
> Reg value, if you mean reg parameter from an Example, was taken from
> r8a77961.dtsi file.
The check does not pass. You have an error there:

Documentation/devicetree/bindings/firmware/arm,scmi-devid.example.dt.yaml:
example-0: usb@ee0a0000:reg:0: [0, 3993632768, 0, 256] is too long



> 
>>
>>>
>>>> 2. Your schema does is not selected by anything. How is it intended to
>>>> be used? Nothing is including it, either...
>>>>
>>>
>>> The idea is to use this parameter to set the device_id for the device in
>>> the device-tree, which matches to the device mapping in the Firmware, so
>>> Trusted Agent can use it to the device permissions.
>>> Please see Sections 4.2.2.10 and 4.2.1 [0] (Link was provided in the
>>> cover letter).
>>>
>>> I'm currently propose the new feature, called SCI mediator to Xen-devel
>>> community. Please see link [1] from cover letter for the details.
>>> In this feature - Xen is the Trusted Agent, which uses scmi_devid
>>> parameter to set the device permissions.
>>> We think that this parameter will be useful for other possible SCMI
>>> implementations, such as other hypervisor or SCMI backend server etc.
>>
>> We talk about different things, I think. I was asking how is this schema
>> selected?
>>
>> I gave it a fast try (dtbs_check) and it confirmed - schema does not
>> have an effect. It's a noop. You need something like "select: true", see:
>> Documentation/devicetree/bindings/nvmem/nvmem-consumer.yaml
>> or this schema should be included by other schemas... but then I would
>> be happy to see actual usage in this patchset (more commits...).
>>
> 
> I think select: true will work for me. I'll do dtbs_check and
> dt_bindings_check after making all changes and prepare v2 if there will
> be no further comments.
> 
> Also what do you think about maintainers: field? Is it correct? I'm not
> sure if I used it correctly.


I think you should add arm,scmi maintainer next to you.


Best regards,
Krzysztof
