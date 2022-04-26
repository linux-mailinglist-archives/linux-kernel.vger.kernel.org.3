Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56CB4510A13
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 22:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354309AbiDZURu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 16:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354118AbiDZURs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 16:17:48 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808691A3242
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 13:14:38 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id m13so8253123iob.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 13:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3ZRttf/U2CPkMsmdwAz9Q/AlEKBoW2uqMf7iGu455RE=;
        b=KbYufQdIxBgeN14b87nS4XfHAeLZOHi1VXCG+QnH+J5qernIBHEgyXKvhOqpdwBVkT
         nIS+qFFKIaSw+OaRpZZXY9xIUNPWH8dNcdFWHt8EvLMc/XLYlTQHKE7mdh3qejDWT2L+
         /8PGrBFpcO3PiidYmDk7Z/wwNgCb3pdFLs2pU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3ZRttf/U2CPkMsmdwAz9Q/AlEKBoW2uqMf7iGu455RE=;
        b=guGnFzPFERFxulqcKzfqXKxqaLRGmx4LER35KjkJBLLPPpiRxJ0IzTuIW2FzEf1IBc
         UYLYGW2CrbZyPLP+E+H0sQ7U5RhRGmbxN7+mvXO/FDzVQTj/fDPqdkNcLhpMGa6gcAhu
         QMePb9glCkYil1lYjy6Auy64GGMKgaNmFqSzoqdE9Aa1Wkzpj1hu0ZwoRKqhlTf22HSw
         kS6y4DLDFBPg2qTJpY9ccZFOrHrVi0cz3VLQJ2YvPiaa0WkGNDfRYLJbfebH5R1VtnEF
         6BVUuVitBhSzpN+YReCYF2NBvwppkWOPdo+Vnw5CR+CiU9eBjt4vIKckWAQznhrtMrGy
         zsfQ==
X-Gm-Message-State: AOAM531ZLloO99Y7xC+9/mNUXKg1r/K1EqK3bzIeirb5lvvZUKIpF1nN
        BUnGcaAU2lGvae7Q7nWS5kZCfg==
X-Google-Smtp-Source: ABdhPJwA9FzSWWsii3nbszNxaqJY14bYrfy1LWGN6/PaspOIrAcnkSgoY8W77ie6olQGMiVbr7H+xA==
X-Received: by 2002:a05:6638:25c2:b0:32a:9cfc:1d7b with SMTP id u2-20020a05663825c200b0032a9cfc1d7bmr11631255jat.22.1651004077839;
        Tue, 26 Apr 2022 13:14:37 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id y4-20020a92d0c4000000b002cd8a7db5f5sm5587715ila.11.2022.04.26.13.14.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 13:14:37 -0700 (PDT)
Subject: Re: [PATCH 5.10 00/86] 5.10.113-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220426081741.202366502@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <094fe3fa-edb7-f326-cbf1-11618c2c0182@linuxfoundation.org>
Date:   Tue, 26 Apr 2022 14:14:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220426081741.202366502@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/22 2:20 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.113 release.
> There are 86 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 28 Apr 2022 08:17:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.113-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
