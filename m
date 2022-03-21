Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC9B4E2B2B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 15:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349578AbiCUOsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 10:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349574AbiCUOss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 10:48:48 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968704AE3B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 07:47:22 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id k6so5781549plg.12
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 07:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=DI931SHT8PLoR2b0985LjRSgydsX5XwJB3yBC5uPVpw=;
        b=V2Bt1vVbuNPaOBrhiG3nd+vde62QgkBY2PCDuzHZa9B2CmmJjKYhV5LGA4KB6Szm2b
         OaO6FNQ29vXOCcxW6UASCWv+QVizFwLxTTyECELPkHQC4lKclVlp+kafssAV4e+YqOMs
         y5GnLKiXJxZ5kHvpewxVFJqLXRWDTRNxVx9AogE2d0p1nRCxO/HpRQ5RgHOhZzfixJn+
         mTM3sRNMmrqENQSZgJTbHPdPyQrEWoZQZ26SvlsO0Bv6SZAlGBQm08bHWCvai0FurKmv
         /4/1MsKYcw8etMQW3GFSkheW5JzO5/j0Oj7usQdJRPVcm6pOMycO7wZDIkEVb2uj9R1S
         ewgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DI931SHT8PLoR2b0985LjRSgydsX5XwJB3yBC5uPVpw=;
        b=XJxRp6kwOB88LWyiBnA6RtdzgAUCKdYmw6xYfgywFNldMTBsCn7zY2rzzXVjo2d9pf
         NyNdMGqAY7v4f/fljL7i/ypEeM3U0jP1A3poV750/658PykDFpGzomxfS0ZTX5784PY/
         wt62gYHPIxhA2O1itjls44+gi2a8xMqAdQCSuqn5xPEhPjI8AGBIHOmiNrSgMYdrezNn
         z8RMuSL/4VqbbZ00C2XC+CIowXVcgr2ezwyqHD298w3JUzP0eA+cokZzhhkWBLL2Bmbz
         uHBSPKAQ0RZXd3icTVFEYZQFwn67pwOgnEqcCGBTqGXg/ooy8uNlmxquvuDdnko4DTkR
         FVpA==
X-Gm-Message-State: AOAM532NtVmhkRx/ePQoPpf4yv6aJhqoFiYKkfd2g2caOTH5Vhhm70wL
        M0FDkgK47l0lx1cYc1pvnCplMA==
X-Google-Smtp-Source: ABdhPJzDn7LmDfPB9FD6z0YvaFDFY/E/hSp8cjgb9YKq0A7GMsyyioUEF2qAcqq5sD5xyyrCUzT7iA==
X-Received: by 2002:a17:902:7d93:b0:14d:d401:f59b with SMTP id a19-20020a1709027d9300b0014dd401f59bmr13473073plm.14.1647874041969;
        Mon, 21 Mar 2022 07:47:21 -0700 (PDT)
Received: from [192.168.254.36] ([50.39.160.154])
        by smtp.gmail.com with ESMTPSA id u204-20020a6279d5000000b004fa58625a80sm14762922pfc.53.2022.03.21.07.47.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 07:47:21 -0700 (PDT)
Message-ID: <97b7e9f3-8ec3-b824-1301-9cea0a4d3437@linaro.org>
Date:   Mon, 21 Mar 2022 07:47:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: Patch "esp: Fix possible buffer overflow in ESP transformation"
 has been added to the 4.19-stable tree
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
Cc:     sec@valis.email, steffen.klassert@secunet.com,
        stable-commits@vger.kernel.org
References: <16478662281158@kroah.com> <Yjh5rcxI/VW40j1+@kroah.com>
From:   Tadeusz Struk <tadeusz.struk@linaro.org>
In-Reply-To: <Yjh5rcxI/VW40j1+@kroah.com>
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

On 3/21/22 06:12, Greg KH wrote:
> On Mon, Mar 21, 2022 at 01:37:08PM +0100, gregkh@linuxfoundation.org wrote:
>>
>> This is a note to let you know that I've just added the patch titled
>>
>>      esp: Fix possible buffer overflow in ESP transformation
>>
>> to the 4.19-stable tree which can be found at:
>>      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>>
>> The filename of the patch is:
>>       esp-fix-possible-buffer-overflow-in-esp-transformation.patch
>> and it can be found in the queue-4.19 subdirectory.
>>
>> If you, or anyone else, feels it should not be added to the stable tree,
>> please let <stable@vger.kernel.org> know about it.
> 
> Oops, nope, sorry this breaks the build on 5.4 and older kernels, now
> dropped.

Yes, that is for 5.10 only.

-- 
Thanks,
Tadeusz
