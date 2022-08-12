Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B50A5914FE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 19:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239526AbiHLRgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 13:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239533AbiHLRgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 13:36:22 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88FD94118
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 10:36:20 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id z20so1600920ljq.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 10:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=sPoCXoEPjVdi3UX8o+CKN3COMpK80dSqlJMLAgMeBSQ=;
        b=w1HNI2SI01RkJsc+GOIrNFu4b55e15l59HLqtxFwT1MGnsEEpeFgw9Rr9hJ5fGV/A+
         2jMURIa5+rFOfXj4CDiVpvYs8Mxm5R42NFJbRuAzediJMHV84H8fLBdqK5KIOKrVKZpc
         g2oFfr4+6+eMwYFMTz/9QIG/o6Z/5nMrmxGPSKa0JhMzENH9e+6ctlyG2RYdY5zWFdD4
         xQIsN9b9+yyUFcfIGTUGFa2y3oYSk+T4i1gmDQh7vcEfFgVPpKL6JXBryovAQtiO7lYV
         AcKcYynUoDfqt+L306v+gKeUlvJmIiK9bd/ilsbQejBSv06InZdL4ytbicXbo7B8rAsT
         4zzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=sPoCXoEPjVdi3UX8o+CKN3COMpK80dSqlJMLAgMeBSQ=;
        b=eIECW6e38YawIRIdZuklQlKVLzsEJog5sFO7/NjUi8lwiRkGMrFroFqwHubg7P3sKo
         dJDEtyaUOQKd8CC8lPExyS6pDf1IWObyT/oQZaAR/0n7Gxxd+sEDZb+Yaj0OYBTbkOMv
         94H+uiJUcSED7uiNqoT+OmWrrYUqw8ImLgEdurC5bqPeiA8DEn+2repCjjnK9IBs2gfQ
         zn7Rh921mZ4fE6UchiADe1SL+FSIsVittqaEow0SxQen9L3s+9RXsjbVdj5CrWckYinO
         GO3tRpX2YDteN3FJGNAv6kCytwjnDnkOeeh3lq1mUOTX/0k0OvwLQApGA5hCqE0++Mbm
         aIAg==
X-Gm-Message-State: ACgBeo3O9YjJBS2K4R8NyeS7/pBN5lzS9F7z27iOy9mISJSW4ozAMmAc
        JDCo+7ccejFgV6Cz26T22ibWPw==
X-Google-Smtp-Source: AA6agR6Ntr7DfLarmW/01EpUFop8S/1w/186IyXW4A2vdYQRBOxkijBIo1rChSEBW8aEp5kxtz5DSA==
X-Received: by 2002:a2e:9b47:0:b0:25e:4887:648b with SMTP id o7-20020a2e9b47000000b0025e4887648bmr1393777ljj.414.1660325779159;
        Fri, 12 Aug 2022 10:36:19 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id a25-20020a056512201900b0048a1f17916esm272753lfb.300.2022.08.12.10.36.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 10:36:18 -0700 (PDT)
Message-ID: <fa283e3c-5b96-b0a4-95c5-a7230d16d8ca@linaro.org>
Date:   Fri, 12 Aug 2022 20:36:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 3/3] memory: Add Broadcom STB memory controller driver
Content-Language: en-US
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
References: <20220801220931.181531-1-f.fainelli@gmail.com>
 <20220801220931.181531-4-f.fainelli@gmail.com>
 <26ad247d-a4b3-4051-b8d9-505c09b76f6b@linaro.org>
 <375eac04-dbfd-080a-3003-cae3eda1f42b@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <375eac04-dbfd-080a-3003-cae3eda1f42b@gmail.com>
Content-Type: text/plain; charset=UTF-8
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

On 12/08/2022 20:29, Florian Fainelli wrote:
> On 8/9/22 02:58, Krzysztof Kozlowski wrote:
>> On 02/08/2022 01:09, Florian Fainelli wrote:
>>> Add support for configuring the Self Refresh Power Down (SRPD)
>>> inactivity timeout on Broadcom STB chips. This is used to conserve power
>>> when the DRAM activity is reduced.
>>>
>>
>>
>>> +static int __maybe_unused brcmstb_memc_resume(struct device *dev)
>>> +{
>>> +	struct brcmstb_memc *memc = dev_get_drvdata(dev);
>>> +
>>> +	if (memc->timeout_cycles == 0)
>>> +		return 0;
>>> +
>>> +	return brcmstb_memc_srpd_config(memc, memc->timeout_cycles);
>>> +}
>>> +
>>> +static SIMPLE_DEV_PM_OPS(brcmstb_memc_pm_ops, brcmstb_memc_suspend,
>>> +			 brcmstb_memc_resume);
>>> +
>>> +static struct platform_driver brcmstb_memc_driver = {
>>> +	.probe = brcmstb_memc_probe,
>>> +	.remove = brcmstb_memc_remove,
>>> +	.driver = {
>>> +		.name		= "brcmstb_memc",
>>> +		.owner		= THIS_MODULE,
>>
>> No need, run coccinelle.
>>
>>> +		.of_match_table	= brcmstb_memc_of_match,
>>> +		.pm		= &brcmstb_memc_pm_ops,
>>
>> Shouldn't this be pm_ptr()? and then no need for __maybe_unused in
>> brcmstb_memc_resume/suspend.
> 
> How can one can remove __maybe_unused without causing a warning for the 
> CONFIG_PM=n case, not that I needed to build to convince myself, but 
> still did anyway:
> 
> drivers/memory/brcmstb_memc.c:275:12: warning: 'brcmstb_memc_resume' 
> defined but not used [-Wunused-function]
>   static int brcmstb_memc_resume(struct device *dev)
>              ^~~~~~~~~~~~~~~~~~~
> drivers/memory/brcmstb_memc.c:252:12: warning: 'brcmstb_memc_suspend' 
> defined but not used [-Wunused-function]
>   static int brcmstb_memc_suspend(struct device *dev)
>              ^~~~~~~~~~~~~~~~~~~~
> 
> unless you also implied enclosing those functions under an #if 
> IS_ENABLED(CONFIG_PM) or something which is IMHO less preferable.

Are you sure you added also pm_ptr()? I don't see such warnings with W=1
and final object does not have the functions (for a different driver but
same principle).

Best regards,
Krzysztof
