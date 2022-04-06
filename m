Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBAF54F636B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 17:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235812AbiDFP0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 11:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236046AbiDFP0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:26:03 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD794E81FB;
        Wed,  6 Apr 2022 05:24:31 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id n19-20020a9d7113000000b005cd9cff76c3so1608319otj.1;
        Wed, 06 Apr 2022 05:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=encaLqHcBH6foBnrbFxZ2i6K7G7Yn7crS2vxrpfT+uY=;
        b=I/dd6AWAR8pHJ3oZYLJYf9SClhq/KmGq7qylijYmLA77gSBEBddKrBVVTi2VqIRPv3
         qTAnMP4PLty3za3QnwGGwZ5RgC/oqqR1YuBuz6zC0Fd1/F087GI3eu2ybA3hvB/aT4wB
         M/ui8Q+KyKbLliO4U4zum9KYqJxS+75ZNtz/Tpn+rb9EloOLFnzJd5Hi/UwINV3Ssqfn
         wPYuSrwJ7YwG4myQHQlxIcCD9pObfuzwnDYZjloGVwE789CFPHEwyOA4yGeVNEuZOCte
         m87yfGICIk8v8X53GJg+0ZvbBwCDBTiepCniNrij9+GpwPh/1Z9E5s8kGx6RoBoT/gV2
         veOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=encaLqHcBH6foBnrbFxZ2i6K7G7Yn7crS2vxrpfT+uY=;
        b=nk/k83B1WrOMdleKpt/vv42I/dVCHl2x7S6b4YG4+7WkN64H0jFSCNwNIL7QWIAMlK
         YyRFK0vd4DFAVRvM8uTKTpstUD+HaNqRf3IYViMggxiiEEWJ/V/VYfFwB1Fh2Q18H1rA
         eT+uBO2OiPcd6kyiUQwXZlZgtopyiKCsbaO0W260PZR5KK9KFuusA4tvLhw7ry9uWlK9
         +2m2SB/3RA+jMoBQU0Cj5NDdtL8b+EiT8HNdKsCK10tiXP/JXFh225B8eyrIIs2FGV1t
         AEJDx1VUglmYNuV5C7Xuk+eHKj7v1ko2cN0fU/BfJiCP11iS/qmVTctwYbWL1dFS6iA+
         B3Fw==
X-Gm-Message-State: AOAM53141DBhmoUzymqv5HCH71Nvd8db91QMGf6elxm9aWqWoqhMYAcO
        VuHDvp8wtoI0IGxZKbPPtYc=
X-Google-Smtp-Source: ABdhPJzfuUCYVbipdZsd9M6/L296AWUeysgoZNl5fvgy8K8+GU78LuJDiWcSmJzpnPLjDGm4lsi0lw==
X-Received: by 2002:a9d:1b68:0:b0:5c9:5da1:3752 with SMTP id l95-20020a9d1b68000000b005c95da13752mr2811618otl.354.1649247871210;
        Wed, 06 Apr 2022 05:24:31 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x1-20020a4ae781000000b00320d5d238efsm6033772oov.3.2022.04.06.05.24.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 05:24:30 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <18719038-4eef-4792-e961-6550bb9f0d55@roeck-us.net>
Date:   Wed, 6 Apr 2022 05:24:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] hwmon: (tmp401) Support extended temperature range
Content-Language: en-US
From:   Guenter Roeck <linux@roeck-us.net>
To:     Camel Guo <camel.guo@axis.com>, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     kernel@axis.com, Camel Guo <camelg@axis.com>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220406092901.408861-1-camel.guo@axis.com>
 <c2a1776d-1499-8b84-15cd-b09908ebd0e5@roeck-us.net>
In-Reply-To: <c2a1776d-1499-8b84-15cd-b09908ebd0e5@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/22 05:12, Guenter Roeck wrote:
> On 4/6/22 02:29, Camel Guo wrote:
>> From: Camel Guo <camelg@axis.com>
>>
>> This patch only applies to tmp431 and devicetree configuration.
>>
>> Signed-off-by: Camel Guo <camelg@axis.com>
>> ---
>>   Documentation/hwmon/tmp401.rst | 13 +++++++++++++
>>   drivers/hwmon/tmp401.c         |  5 +++++
>>   2 files changed, 18 insertions(+)
>>
>> diff --git a/Documentation/hwmon/tmp401.rst b/Documentation/hwmon/tmp401.rst
>> index 3aacf3d3bdf3..d12e9c9ba40f 100644
>> --- a/Documentation/hwmon/tmp401.rst
>> +++ b/Documentation/hwmon/tmp401.rst
>> @@ -78,3 +78,16 @@ some additional features.
>>   TMP432 is compatible with TMP401 and TMP431. It supports two external
>>   temperature sensors.
>> +
>> +Device tree
>> +-----------
>> +TMP431 has support for the device tree parameter "extended-range" which enables
>> +the extended range in the chip.
>> +
> 
> There is no practical reason to limit support for this to TMP431,
> nor does the actual code make such a distinction.
> 
>> +Example:
>> +
>> +main-temp@4c {
>> +  compatible = "ti,tmp431";
>> +  reg = <0x4c>;
>> +  extended-range;
>> +};
> 
> This is not an acceptable way to describe devicetree properties.
> You would have to write a bindings document
> (Documentation/devicetree/bindings/hwmon/ti,tmp401.yaml)
> and describe the property there.
> 

... and that should be modeled after ti,tmp421.yaml and also support
other configuration parameters, specifically beta compensation and
n-factor correction.

Guenter
