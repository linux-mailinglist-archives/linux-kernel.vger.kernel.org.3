Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 023A3574E9A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 15:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238956AbiGNNFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 09:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238893AbiGNNFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 09:05:46 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C144F671
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 06:05:44 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id bn33so2063668ljb.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 06:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=u+3rknmtb2dZGdFRfj+HaAmrjmjmI4vZwsXBVfJYyoA=;
        b=sVGUiDjf0lNmV8joR1NFJJB73ewZQ7mfpDQ/NHORpp33c46ryiRzI5L+UTJP+rirVv
         RLGbciQ1diEymQa0jxdXJDXcxr10hC4Yl9iqHCuYpyXDu/8j1C23rwZNDawbpAKUl6X1
         QhFW/X7OifcXq8C/sXuY3Kd1fmKSgl6+8pgbrYYjJSsbwQLKG5eubgJ/xvwHbTmuZoA3
         DBFIfoMIM9IMZlbe0uNp0rUfmvmJi3FuDuPIVyUlZgT1mknXNNVwF+ZPRwB0SSUmg4fz
         RW6wgyGPbJzuBWNI/HjY2ER+znlWmW0BL663K/qaBtROGyl/yIW4tajNMfyjCSy6RhJS
         0Sfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=u+3rknmtb2dZGdFRfj+HaAmrjmjmI4vZwsXBVfJYyoA=;
        b=2oWoUi6HyOdU1WIGsOkmztdXdpDISTNvKZRqxr86KCgwIwi62/AZ+qdNfle4cXxypc
         X9vcVLyxSuKwlb5p9gV/JVe3sDnoym/3bxytCTZBtsJ2pKfKwji4zKVabkNLmhubkXkE
         IzJDEVVIAf/FAmSvJpBYtp7tMaIK1PxnkXeSYNV0+r+Gq2oA/7AyqjhEle+zdKo21eoY
         B/nHvn4G+ErosH91Hf4cc08tPUQtcabxvs4REcgEYF7gOlZgpeTn8JcVEulDgKLPJ1q7
         j+Al4O0gV+ap3y0ywiDAGWjEYGWYu9kdyJXOQfFS0h3XepLcByN1OoS0MDmULruvCDeN
         eOMQ==
X-Gm-Message-State: AJIora9oCFBPcxirNMQyWudJTbBfKL2h6sufxw7peW9vGPzj6A81rVK2
        fVOvaPeZMcuI4njmMAPiDJYOrQ==
X-Google-Smtp-Source: AGRyM1utuosbogphj/pZJQ0Zu/oq61N+cuIDtO7V7ISXg8NE0sxYlKJ7AyfdosnfkcsEkXstj2yjjw==
X-Received: by 2002:a2e:9bd6:0:b0:25d:8712:64f6 with SMTP id w22-20020a2e9bd6000000b0025d871264f6mr4403216ljj.337.1657803942958;
        Thu, 14 Jul 2022 06:05:42 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id u1-20020ac258c1000000b0047f943112e3sm350866lfo.285.2022.07.14.06.05.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 06:05:42 -0700 (PDT)
Message-ID: <9ef036db-2ac8-2723-93de-ac841d94ba51@linaro.org>
Date:   Thu, 14 Jul 2022 16:05:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] PCI: qcom: Add support for modular builds
Content-Language: en-GB
To:     Stanimir Varbanov <svarbanov@mm-sol.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220519094646.23009-1-johan+linaro@kernel.org>
 <cc7c90aa-6705-7493-2f58-5112f7d663a3@mm-sol.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <cc7c90aa-6705-7493-2f58-5112f7d663a3@mm-sol.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stanimir,

On 14/07/2022 15:19, Stanimir Varbanov wrote:
> Hi Johan,
> 
> Please take a look why we made it built-in first [1].
> 
> If arguments there are still valid I don't see why to make it a module
> again.
> 
> [1] https://lkml.org/lkml/2016/8/24/694

It looks like there is a move to make all non-essential drivers 
buildable as modules. For example, the Kirin, dra7xx, Meson PCI 
controllers are now buildable as modules. So I think we can follow that 
and allow building the pcie-qcom as a module.

> 
> On 5/19/22 12:46, Johan Hovold wrote:
>> Allow the Qualcomm PCIe controller driver to be built as a module, which
>> is useful for multi-platform kernels as well as during development.
>>
>> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
>> ---
>>   drivers/pci/controller/dwc/Kconfig     |  2 +-
>>   drivers/pci/controller/dwc/pcie-qcom.c | 36 +++++++++++++++++++++++---
>>   2 files changed, 34 insertions(+), 4 deletions(-)
>>
> 
> 


-- 
With best wishes
Dmitry
