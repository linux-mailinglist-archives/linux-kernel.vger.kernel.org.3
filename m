Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84AB5ABACA
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 00:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbiIBWV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 18:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbiIBWV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 18:21:56 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7258DDAA0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 15:21:55 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id l6so1884527ilk.13
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 15:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=hZnGj6v02RVk4APJJv49iwTbJS3M4L2UDSCCo6WD1eA=;
        b=f04FCL8by75A1k3qVLDknsxn74b0fSzdY0CXc+hJUVWNGjOz0vKA2EO5A+y7tLuW1W
         VBX17ixNfVrPVbSw1bWr1afDszNpCH+HsNYh5jsCku4W13qLev4ENQ850+h8BOkl3Efw
         zzHUzebyIZG80gN9CVYF8AKphCBQ4qI7D9/pc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=hZnGj6v02RVk4APJJv49iwTbJS3M4L2UDSCCo6WD1eA=;
        b=TwlIMEmTbRVOTFPjzUXvAGiPvtb1KE2QmwWjgzjDlLmq0K77Xtr+bEuVNpzWMhZ/1A
         hozbKU02pvj6YqyLgZvkfypd/K/+tAZuhDsw2rXuGz6cmc34M7DK2epuxTPAdTEVwVBQ
         FAP58E3/D0dtjZEmIeIHHWQCnkfClCSWSMrh/r7NFYw9nX2ug8Yx7Mv1Q/zLl0g01caT
         CkLd/o1ee739pmG4AtALorfHtg7bf6hp8SMizq/VOHw7DjtxcL6gxa3fa2Et30rADeik
         n2D03ChFoLhWXGNHIxo3oshkqwXf6lMXvj4mOyabIck7j/iVcR3zKyeGvg/9GMSrtx2x
         k4PQ==
X-Gm-Message-State: ACgBeo21H5O1n/dqtMumexNd/6Dtdo9+wPkFxb7GnnWiDWlwp/OctACE
        SxBTIcm/OEnv/Ah4rFaHT1p6aQ==
X-Google-Smtp-Source: AA6agR4gY82cFFj0ovBrACWBBZM9GadG/GK9ZuvAKTxcxQxh9GwzZLq9p5GpzqhL1Ppa+HBxQvxJgQ==
X-Received: by 2002:a92:c561:0:b0:2ed:a26a:8c65 with SMTP id b1-20020a92c561000000b002eda26a8c65mr4507207ilj.23.1662157315250;
        Fri, 02 Sep 2022 15:21:55 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id z16-20020a92d6d0000000b002e8cae157adsm1290656ilp.2.2022.09.02.15.21.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Sep 2022 15:21:54 -0700 (PDT)
Message-ID: <2b76c23b-7c1c-65d8-c18b-e10ea52a0c4a@linuxfoundation.org>
Date:   Fri, 2 Sep 2022 16:21:54 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 4.19 00/56] 4.19.257-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220902121400.219861128@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20220902121400.219861128@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/2/22 06:18, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.257 release.
> There are 56 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 04 Sep 2022 12:13:47 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.257-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
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
