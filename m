Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F00584BF322
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 09:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiBVIG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 03:06:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiBVIGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 03:06:55 -0500
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522E6BE;
        Tue, 22 Feb 2022 00:06:30 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id vz16so40401725ejb.0;
        Tue, 22 Feb 2022 00:06:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HN8iQ48TFLf5TAJFPvpzMrdS4ER89HB927MvRfaxKLQ=;
        b=lhD2ASO6iIKxsFTgRm6+aEZmuXEdUNCYArCIFHiO53emIqTlBzzDS70dsIP4SCwIIm
         ImXs2An/6Y93lMPMPq4jKIcwdOloi9zzEpd++ddXNJWlQSBOrjpX/8JvdDZa7apehlzI
         xegmnS0l/2ieO54HtlZ2q3E8PpcCfk1lpBZIwhOrpElnAFzvA0Uckk4zXnaNFbF7BkZt
         3U9vVZyui1XhbFKCR1kWpyRm0RyuplDdflQMRuxRw9eNGYA9r2jezt+yYL89uydLwmKZ
         tGC6UV3+OLWdNrU6Tqtdzv7u52KKtht1k3pKWfVCrLueisrOxPuJlU0YkFXwqswtaQ8D
         ywVw==
X-Gm-Message-State: AOAM531uJSEJmE6gnhusGKt7Td9ae5a//fWDEj3lyFg92wnr7BQq29sk
        CXkXOWrpBs0wzCiY6w27+nNxDkRLQ9A=
X-Google-Smtp-Source: ABdhPJw8lk6p+R8nygZLxTy2ou48SBS/IXDH881ulump5Nl3GLTOrPreVBmc7IeZYvVjQb8NzPDueQ==
X-Received: by 2002:a17:906:4ccd:b0:6b7:75ca:3eac with SMTP id q13-20020a1709064ccd00b006b775ca3eacmr18490885ejt.167.1645517188871;
        Tue, 22 Feb 2022 00:06:28 -0800 (PST)
Received: from [192.168.0.122] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.googlemail.com with ESMTPSA id kw5sm6098484ejc.140.2022.02.22.00.06.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 00:06:28 -0800 (PST)
Message-ID: <7f17ab8f-429f-d2e0-8f5f-bfa2dd19cc49@kernel.org>
Date:   Tue, 22 Feb 2022 09:06:25 +0100
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
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220221213932.GA164964@EPUAKYIW015D>
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

On 21/02/2022 22:39, Oleksii Moisieiev wrote:
> Hi Krzysztof,
> 
> On Mon, Feb 21, 2022 at 10:01:43PM +0100, Krzysztof Kozlowski wrote:
>> On 21/02/2022 18:26, Oleksii Moisieiev wrote:
>>> Introducing new parameter called scmi_devid to the device-tree bindings.
>>> This parameter should be set for the device nodes, which has
>>> clocks/power-domains/resets working through SCMI.
>>> Given parameter should set the device_id, needed to set device
>>> permissions in the Firmware. This feature will be extremely useful for
>>> the virtualized systems, which has more that one Guests running on the
>>> system at the same time or for the syestems, which require several
>>> agents with different permissions. Trusted agent will use scmi_devid to
>>> set the Device permissions for the Firmware (See Section 4.2.2.10 [0]
>>> for details).
>>> Agents concept is described in Section 4.2.1 [0].
>>>
>>> scmi_devid in Device-tree node example:
>>> usb@e6590000
>>> {
>>>     scmi_devid = <19>;
>>>     clocks = <&scmi_clock 3>, <&scmi_clock 2>;
>>>     resets = <&scmi_reset 10>, <&scmi_reset 9>;
>>>     power-domains = <&scmi_power 0>;
>>> };
>>
>> And how do you prevent DT overlay adding such devid to any other node
>> thus allowing any other device to send requests with given devid?
>>
> Thank you for the quick response.
> scmi_devid value will be used only by Trusted Agent when the device
> permissions are set. Non-trusted agents, which in our case are
> represented as Guest OS are using scmi drivers, already present in linux
> kernel, ignores scmi_devid and uses scmi_clocks, scmi_power, scmi_reset
> nodes to access to SCMI protocol.

Ah, ok.

> 
>> Plus few technicalities:
>> 1. Hyphen, not underscore in property name, so scmi-devid.
> 
> Thanks for the tip, I will change that in v2.

Few more thoughts:
1. This looks specific to ARM SCMI, so you also need vendor prefix, so
something like:
arm,scmi-devid
arm,scmi-device-id

2. Does your example work properly? Passes dt_binding_check? Reg looks
different than unit-address.


> 
>> 2. Your schema does is not selected by anything. How is it intended to
>> be used? Nothing is including it, either...
>>
> 
> The idea is to use this parameter to set the device_id for the device in
> the device-tree, which matches to the device mapping in the Firmware, so
> Trusted Agent can use it to the device permissions.
> Please see Sections 4.2.2.10 and 4.2.1 [0] (Link was provided in the
> cover letter).
> 
> I'm currently propose the new feature, called SCI mediator to Xen-devel
> community. Please see link [1] from cover letter for the details.
> In this feature - Xen is the Trusted Agent, which uses scmi_devid
> parameter to set the device permissions.
> We think that this parameter will be useful for other possible SCMI
> implementations, such as other hypervisor or SCMI backend server etc.

We talk about different things, I think. I was asking how is this schema
selected?

I gave it a fast try (dtbs_check) and it confirmed - schema does not
have an effect. It's a noop. You need something like "select: true", see:
Documentation/devicetree/bindings/nvmem/nvmem-consumer.yaml
or this schema should be included by other schemas... but then I would
be happy to see actual usage in this patchset (more commits...).


Best regards,
Krzysztof
