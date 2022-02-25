Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11EE84C4330
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 12:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239990AbiBYLS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 06:18:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235085AbiBYLSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 06:18:23 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC69E18E412
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 03:17:50 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id s13so3945005wrb.6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 03:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=AGZPzwXXXM3kWSJkhQCvj7q8PtLYtNxvFjpKuqr14Nc=;
        b=G5I0GWI3LHse6Ga941cf8053INdtQRgr13xMQtJxbusoTCE+mRmUPCNOYZcPBbNWnx
         7+1fKXhNK/DW3GXQxSHwPB1H9VH7O6TevhsAeeOK2ddfOnFhyaY+sDKpPIEVnSQ9aOzv
         P0++bome/ky/Ep/vN1kypm9DTJazF1Cmi//EtGcAwgK2RdsW8+MGMbmZns/MhV6lbyhY
         CTAQ+cGjhWhEmdAtUmpQD2tzhIx1H06bdgFf+Dyio8sHKrDk7pcPbpp7OXS8eCsZL+e+
         NPPfK5GqqJQnNdsu+DVl35LoS2TNV5+8ctY6HMUAq1Tqzn/vc0mfFJbrAKcpiW7ia/Tw
         1rrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=AGZPzwXXXM3kWSJkhQCvj7q8PtLYtNxvFjpKuqr14Nc=;
        b=oHy6AUfg0uNt9d/Y+pbL4UADrZpvYZuDLPyU1GBnP+qqEM6xai/FgZNsf3CuFc/Rts
         owJLn7FH62DfrDel+FEXUea5mVAL7sbv1jkEMPFc6/2Ao2bcwPzPDdW7xrfmwDtlsT1r
         ktlR2wcvBrYKQOCecYCyI2RazKBuoPpB602iKb6ZKzOvbQDlugW9a1DOeMJrDF3onwzP
         bg+1SPQCGoZutRAcKcURew6idD4EwFAj9ZHbGTgVxpM76WJh2ZoLnvpU/qxAuVscEyqq
         bSNWd6swTP9D12z7aeMgIy3kjx2Iz2L3q+YZ3yurKEKwZqFfve1BTohakpx/Y7XWR83e
         9kuw==
X-Gm-Message-State: AOAM532uFc+MiwO9D4Q+c6hAneVfx06w4FP083D+kEoQ8wOXsP4OMmOM
        3WeW1QLahiCJp2frocgJU2uN6rDT+S+z9Q==
X-Google-Smtp-Source: ABdhPJxf6r6PuXt15JzE1wfker2HBabOsjaL0MlsNLDgTIu/e31hxgAj7NVpra0d0LuGfrHRev/msw==
X-Received: by 2002:a05:6000:1a8e:b0:1ef:6ef0:7a47 with SMTP id f14-20020a0560001a8e00b001ef6ef07a47mr1467027wry.504.1645787869525;
        Fri, 25 Feb 2022 03:17:49 -0800 (PST)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id k10-20020adfe3ca000000b001e3894ee3aasm1863201wrm.98.2022.02.25.03.17.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 03:17:49 -0800 (PST)
Message-ID: <e8f4af89-97f1-88d6-05ae-32246f1de57e@linaro.org>
Date:   Fri, 25 Feb 2022 11:17:47 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 0/3] nvmem: patches (set 2) for 5.18
Content-Language: en-US
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
References: <20220223223502.29454-1-srinivas.kandagatla@linaro.org>
 <35d2d1b2-07b1-ba54-c804-9622a0f94d4c@linaro.org>
In-Reply-To: <35d2d1b2-07b1-ba54-c804-9622a0f94d4c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/02/2022 10:52, Srinivas Kandagatla wrote:
> Hi Greg,
> 
> On 23/02/2022 22:34, Srinivas Kandagatla wrote:
>> Hi Greg,
>>
>> Here is final set of nvmem patches for 5.18 which includes
>>
>> - Add new Sunplus nvmem provider and bindings.
>> - fix in qfprom to increase blow timeout.
>>
>> Can you please queue them up for 5.18.
>>
>> thanks for you help,
>> srini
>>
>> Knox Chiou (1):
>>    nvmem: qfprom: Increase fuse blow timeout to prevent write fail
>>
>> Vincent Shih (2):
>>    nvmem: Add driver for OCOTP in Sunplus SP7021
>>    dt-bindings: nvmem: Add bindings doc for Sunplus OCOTP driver
> 
> Sorry for inconvenience, but can you please ignore this set if you have 
> not already applied them.
> 
Opps, It looks like these were just applied.

I can send other patches along with fix to yaml as next set, if that 
works for you?


thanks,
srini


> There seems to be a issue with yaml file which fails dt-bindings check 
> and there are few more patches that can go for 5.18.
> 
> I will a send new set soon.
> 
> Thanks for your help
> --srini
> 
>>
>>   .../bindings/nvmem/sunplus,sp7021-ocotp.yaml  |  86 +++++++
>>   MAINTAINERS                                   |   6 +
>>   drivers/nvmem/Kconfig                         |  12 +
>>   drivers/nvmem/Makefile                        |   2 +
>>   drivers/nvmem/qfprom.c                        |   2 +-
>>   drivers/nvmem/sunplus-ocotp.c                 | 228 ++++++++++++++++++
>>   6 files changed, 335 insertions(+), 1 deletion(-)
>>   create mode 100644 
>> Documentation/devicetree/bindings/nvmem/sunplus,sp7021-ocotp.yaml
>>   create mode 100644 drivers/nvmem/sunplus-ocotp.c
>>
