Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 327F84C42D3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 11:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239851AbiBYKxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 05:53:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238587AbiBYKxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 05:53:34 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CEDC19E705
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 02:53:02 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id d14-20020a05600c34ce00b0037bf4d14dc7so1429829wmq.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 02:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=4+6O+dNZJj2RKRO+eDEVwSqedYiY63BPodTjJrSx078=;
        b=GBxWSrKId+axKi2XG3Ra10c4ruhTUZkGGj21BNP71BMijoE1YkJ9COUmj43I+SGx5o
         K3cgOLqLrQxo+wJHUGCheEUPcuHPhxFOay09Sc7PKzryanRC1ypAR+Z1Tq2KYnJTyTGx
         CjrrVEnfqz7rd+VqodLwCE7P1FfSn39j2fnV4xo/ccEtt2pZarMDUFyd2fQstS8DIb4o
         QqdR7fBM5fRBCHkCe6b+G+P48HL7YkA0oWHQ7OXyaOSxtZPrzRX9h9xFIwSFN/zmsvqi
         va0loWu1FKK4CeIKRXm/SjSBj7Vmx17HN1x/41CaqioOwTExfcukSNUs9XZWfqM7PuYs
         yF4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4+6O+dNZJj2RKRO+eDEVwSqedYiY63BPodTjJrSx078=;
        b=6w8RNZ4P/u1j1pCMIfDJueuv6p159COg9QdUrU0lEklMysO6tV3TxGiWLFFvKSlIkp
         eYOuYNfzW5ySRYLUr2wGzcgZM9qeVDkIYPKbUFrkWbZ4/zZXEXggNlVetTlZPaNHIclf
         rSb0cW5epjZ2xJc935DnaeF0/ThsVycYyQYjEoNbDc01HOTR+8badfVezk2dGogWmxZ2
         ifCWU16+oPQHCa2jcnpWbltA09Sg198n7plTdYeOCFUtICMnXb72jWgfrfnWkJVcKSSc
         tiiV/TrxylQGe6p1HuwzI1VoBnefEiAYxgFAFctft9U/Z+63guKdJLpBPMf8U+Lr0JZ0
         Cfug==
X-Gm-Message-State: AOAM5318QGwSD1aNEDUkzth4OC1KkRJmElO8+dSedRqaY8r/O3pQT0ch
        /shGFTN3E7hCCg9LI/NJ7ih/ugrGG8dQuA==
X-Google-Smtp-Source: ABdhPJyz5ns4FMqlb35d9dHBpBxJSsqxLU/Q/sNKvmQGB9EB9JZYfnvPGDkOqd2lasu5L002KY6AAA==
X-Received: by 2002:a05:600c:1914:b0:37c:fd93:1c68 with SMTP id j20-20020a05600c191400b0037cfd931c68mr2194026wmq.95.1645786380757;
        Fri, 25 Feb 2022 02:53:00 -0800 (PST)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id s16-20020adfecd0000000b001e7be443a17sm2850758wro.27.2022.02.25.02.52.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 02:53:00 -0800 (PST)
Message-ID: <35d2d1b2-07b1-ba54-c804-9622a0f94d4c@linaro.org>
Date:   Fri, 25 Feb 2022 10:52:59 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 0/3] nvmem: patches (set 2) for 5.18
Content-Language: en-US
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
References: <20220223223502.29454-1-srinivas.kandagatla@linaro.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20220223223502.29454-1-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 23/02/2022 22:34, Srinivas Kandagatla wrote:
> Hi Greg,
> 
> Here is final set of nvmem patches for 5.18 which includes
> 
> - Add new Sunplus nvmem provider and bindings.
> - fix in qfprom to increase blow timeout.
> 
> Can you please queue them up for 5.18.
> 
> thanks for you help,
> srini
> 
> Knox Chiou (1):
>    nvmem: qfprom: Increase fuse blow timeout to prevent write fail
> 
> Vincent Shih (2):
>    nvmem: Add driver for OCOTP in Sunplus SP7021
>    dt-bindings: nvmem: Add bindings doc for Sunplus OCOTP driver

Sorry for inconvenience, but can you please ignore this set if you have 
not already applied them.

There seems to be a issue with yaml file which fails dt-bindings check 
and there are few more patches that can go for 5.18.

I will a send new set soon.

Thanks for your help
--srini

> 
>   .../bindings/nvmem/sunplus,sp7021-ocotp.yaml  |  86 +++++++
>   MAINTAINERS                                   |   6 +
>   drivers/nvmem/Kconfig                         |  12 +
>   drivers/nvmem/Makefile                        |   2 +
>   drivers/nvmem/qfprom.c                        |   2 +-
>   drivers/nvmem/sunplus-ocotp.c                 | 228 ++++++++++++++++++
>   6 files changed, 335 insertions(+), 1 deletion(-)
>   create mode 100644 Documentation/devicetree/bindings/nvmem/sunplus,sp7021-ocotp.yaml
>   create mode 100644 drivers/nvmem/sunplus-ocotp.c
> 
