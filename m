Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6810D5210E1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 11:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238806AbiEJJdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 05:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238807AbiEJJdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 05:33:05 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A659328C9E7
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 02:29:07 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id o12-20020a1c4d0c000000b00393fbe2973dso997468wmh.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 02:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=MhAYVo3FRVrEBjsLxRmNmYz+wA6niYBVjv7CpLws+mY=;
        b=zeosEfdIXYcHNN1pUgI0BkmmJUttXywUhQjl7fXULUKNuUouAvYQoPtuoq7EYbvALE
         XuAbOdjiHiZcIA7jAfecgU9jZaLSoB05wXsDeXsEv5z6oDfF6sm/y4WBNZuKb1Mx56xY
         iF+1UW2bPZTc7t5oeTKDpUEEhxNLbx3MHRhAMG81FVy49lBzpoC+gaUFySD33UuVNUrT
         ufS7ux0KoydITb83dE+inItKdL245fppr6pea6kBU2tM/XuyDsm+eVZYU1HmdZMpeXwL
         yxcSRANphL8eD/gC6AKGhSZbHDdZYJLgGwO39UH0uDl/9S8J4V5rsuh2pKnXX5N8AW3p
         qR5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MhAYVo3FRVrEBjsLxRmNmYz+wA6niYBVjv7CpLws+mY=;
        b=o8Ylw07NmrunjywZPvPsesB8yjtK4C3k+bwr/VTpuJoBaGPA602QQZMIVyUyQdo5L2
         cfq2K7eBHrDgqRMRKrqbsz+WQezibG+9p6NhDFLyu7DDaQ55sRG5UsjutjPVE+662Dn9
         q12iJovICsh6mbaT7KHRZ++J69Yp3sl8DV3lOVSp4rawG0yxgIupS8sNNEmDxV1gUxVF
         UTfgfTdLwVzU3glIxPV37zxFpFfJYJR6KZboqgXe7YaNQkFm7+MQ2KEJwEZy9WhIeVxp
         2tDuQXQfhblNRN+9J303UrWt0sPXMDYCs3WQhtyidtJ+sHFrf2HVqd4+OrMLyZGAKSq3
         HcLQ==
X-Gm-Message-State: AOAM530/8+mOlreEfyp+yuIv2z98PbBEROL4VmQmpVCuiWFxEFpEq8FO
        nKSt2JezOJ/dqsyasq6HqitsE6HFDF3S5g==
X-Google-Smtp-Source: ABdhPJwT1rfkvN0EwBtxD2mn2lu+ol6JEg8B6h9VMuHE5iXU9GQroxX6Ttz8RRnjZ8IKjRHcKADqFg==
X-Received: by 2002:a05:600c:4fd4:b0:394:8e96:6d21 with SMTP id o20-20020a05600c4fd400b003948e966d21mr10429150wmq.60.1652174946056;
        Tue, 10 May 2022 02:29:06 -0700 (PDT)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id ay5-20020a05600c1e0500b003942a244ec8sm2055885wmb.13.2022.05.10.02.29.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 02:29:05 -0700 (PDT)
Message-ID: <344a9a7f-a858-6d83-9cd8-ee97a2bd6a74@linaro.org>
Date:   Tue, 10 May 2022 10:29:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 00/16] nvmem: patches (set 1) for 5.19
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
References: <20220429162701.2222-1-srinivas.kandagatla@linaro.org>
 <YnkbcSiOYs0ZpjEP@kroah.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <YnkbcSiOYs0ZpjEP@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/05/2022 14:47, Greg KH wrote:
> On Fri, Apr 29, 2022 at 05:26:45PM +0100, Srinivas Kandagatla wrote:
>> Hi Greg,
>>
>> Here are some nvmem patches for 5.19 which includes
>>
>> - new nvmem provider for Apple efuses.
>> - support for regmap and TA 2.1 devices in sfp provider
>> - add device tree node support in nvmem cell info
>> - brcm_nvram provider to parse cells from dt.
>> - few minor clean ups in qfprom, bcm-ocotp and sunplus-ocotp
>>
>> Can you please queue them up for 5.19.
> 
> Not all of these applied cleanly.  Can you please rebase and resend the
> remaining ones?

Sure, looks like  there is only one patch("nvmem: brcm_nvram: check for 
allocation failure") that needs to be resent and I confirmed that all 
the other patches are already applied.

will resend that one.


--srini
> 
> thanks,
> 
> greg k-h
