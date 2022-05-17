Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A9E52987F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 06:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234629AbiEQEKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 00:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiEQEKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 00:10:32 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A774550C
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 21:10:30 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id n24so20980453oie.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 21:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CtGP0NZWqONfZ61wBOue9SlylX3RFuK/vGePtQoSLts=;
        b=LbPtgMHtEkNDZopErBd7s15sfHBtP+LaBa3SoZuum0c+5Bg5K/GG18mCEYwaE6RqTl
         JdzweSO+zx6OlwXz9OKjyuqQad7LKqFeRsHAhGtVPC/BxAmTDI1BBeiSh/KTm1ui5Fqe
         tyMn0FSkXhRRUaWZa6WZkO39us8P+2GCo4xIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CtGP0NZWqONfZ61wBOue9SlylX3RFuK/vGePtQoSLts=;
        b=x51nFtgnujebcyfd+1FdzIaDIoGSIMuFYN2sHzmsdgqTmQ/C4CHiQRWFnzZm5wwF7R
         YQlhPxmU71TZ+1RINJSThrgTsGxDvIpPEAS5hxhqxOHUm5XOMvI+TmIN+d/lcZF9kVKd
         GwHpeML/lKVKMIYzf3yDfJ2n7kELBzyGjCjbMG5jLLdoaZPWm1MY/GpAl0+iFvr0Ql9g
         MDu/hs701pKeaJ41bCTtxQViAwNKTsOMHR9SBtL5olB16cBAQGQfAd2JazQ7g7jF3AEa
         Mdu2L54cpa3VGzwkUedNPQo/TYSKUnJyCAW5VTjzrOuPxFL8+XZLZ+qmJh2TGZzMyk3E
         8Qyg==
X-Gm-Message-State: AOAM533M8g9Of+yNvO39IhNbjf7s/RLF0RT92yR/DXLrX7o4VtxK1A8V
        G0SXgn3My4ezsfGsyse68MjzFA==
X-Google-Smtp-Source: ABdhPJzOm+4evDtIqVuYNlIzElK0Tp5nKzjHNkOzlNSwc/fpTQKG79yJc556qcvDpWuycOuDjiTGjQ==
X-Received: by 2002:a05:6808:18a3:b0:326:3851:950a with SMTP id bi35-20020a05680818a300b003263851950amr15732488oib.238.1652760630154;
        Mon, 16 May 2022 21:10:30 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id x28-20020a056830245c00b0060603221253sm4504656otr.35.2022.05.16.21.10.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 21:10:29 -0700 (PDT)
Subject: Re: [PATCH 4.9 00/19] 4.9.315-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220516193613.497233635@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <0b416994-0b01-4e95-ff06-30295aee4607@linuxfoundation.org>
Date:   Mon, 16 May 2022 22:10:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220516193613.497233635@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/16/22 1:36 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.315 release.
> There are 19 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 18 May 2022 19:36:02 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.315-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
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
