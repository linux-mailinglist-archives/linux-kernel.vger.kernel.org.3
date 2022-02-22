Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79CBB4C00D3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 19:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234839AbiBVSAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 13:00:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234262AbiBVSAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 13:00:37 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D6417225B
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 10:00:09 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id d17so77810wrc.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 10:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=G+GM8RfUkIYQaKPhgzSaPQ7PCISARa7ZPGAAjEVpg/A=;
        b=t4e1WDk22c+yVdoHNOHQ3dox+uqCTy2J48fujelIDG4OyOuAodvvbovrHRmSd6Y3Al
         vcsuYiDyEIcu2MXsKV+SGUxk81isMNJQQHrg+iptHRIMDG5uguDtPUp6E8ueNfNrMPSU
         1xb9iB4dHSklQvL3DnhZj4HYMaUOjKdeZBiHubSzUQ5dhAM8QbHAI83IUhDHwsmkbDsG
         BdJaMHZHCPIF9r4L980MzVTEYfJAkzJMKBNSCh3YJuPqJSIcF3i0OBJFT9qt518oYE35
         HYWHp7tqEZN54wfRs1owRQEsmtsWGu0VvuD1DyqLpQXL4SbIHormPj6/tRqFlxcNYZG/
         hMEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=G+GM8RfUkIYQaKPhgzSaPQ7PCISARa7ZPGAAjEVpg/A=;
        b=xc4DqOtb/qoOrzWjZ4wwdFei5LlVOQcDNucP8jOMEkOTAJMl2nAEpyRLzPti7uce5J
         xGs15t5R0s3DVIeuzDpRsJ6/66L8zBE5zPCNt2ApuXxOAajOzGlxoEHDRIogiZG3dSRz
         js1g+9Bp5/VNxev95ijRvX0mEIDwaUnLBtFa1xCGdpY+xl3WlKTAo72c4BpvXM0Jfu6p
         SvyvRcXuc7gchd2TXXiN54klYVW6+jgH5bqZvgSAq06/FSeqeLG+W53J/2/dX/WMm/Nv
         LwtOCcqKX8h7/550H5CAdxbKbQ3DfUkP2HV3JTFSrFi7jbPXqdu45EvwrZ5ptUciG6uL
         Dddg==
X-Gm-Message-State: AOAM531Z5brwYntQo2bloNN1b3U5mlnMkSoCnN1AhV36IrIhHpfz+Eiw
        iASf2PE4YCdOdDJM6nRmJyntbwgjcHNGfA==
X-Google-Smtp-Source: ABdhPJyxcQp8MOSypKDIU2F+SGzA6D4/LpK2JVw4eBNmXwUFORbPuRLGpy7MlMiEL+p8O8gxfYNOPw==
X-Received: by 2002:a5d:6d8f:0:b0:1dd:1ced:4050 with SMTP id l15-20020a5d6d8f000000b001dd1ced4050mr20359373wrs.549.1645552808134;
        Tue, 22 Feb 2022 10:00:08 -0800 (PST)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id f63sm1765012wma.17.2022.02.22.10.00.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 10:00:07 -0800 (PST)
Message-ID: <942eb442-ce48-52cb-6472-c15d048b29d7@linaro.org>
Date:   Tue, 22 Feb 2022 18:00:06 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 0/2] Add driver for OCOTP in Sunplus SP7021 SoC
Content-Language: en-US
To:     Vincent Shih <vincent.sunplus@gmail.com>,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, wells.lu@sunplus.com,
        vincent.shih@sunplus.com
References: <1640164346-26818-1-git-send-email-vincent.sunplus@gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <1640164346-26818-1-git-send-email-vincent.sunplus@gmail.com>
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



On 22/12/2021 09:12, Vincent Shih wrote:
> This is a patch series for OCOTP driver for Sunplus SP7021 SoC.
> 
> Sunplus SP7021 is an ARM Cortex A7 (4 cores) based SoC. It integrates
> many peripherals (ex: UART, I2C, SPI, SDIO, eMMC, USB, SD Card and
> etc.) into a single chip. It is designed for industrial control.
> 
> Refer to:
> https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
> https://tibbo.com/store/plus1.html
> 
> Vincent Shih (2):
>    nvmem: Add driver for OCOTP in Sunplus SP7021
>    dt-bindings: nvmem: Add bindings doc for Sunplus OCOTP driver


Applied thanks,

--srini
> 
>   .../bindings/nvmem/sunplus,sp7021-ocotp.yaml       |  86 ++++++++
>   MAINTAINERS                                        |   6 +
>   drivers/nvmem/Kconfig                              |  12 ++
>   drivers/nvmem/Makefile                             |   2 +
>   drivers/nvmem/sunplus-ocotp.c                      | 228 +++++++++++++++++++++
>   5 files changed, 334 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/nvmem/sunplus,sp7021-ocotp.yaml
>   create mode 100644 drivers/nvmem/sunplus-ocotp.c
> 
