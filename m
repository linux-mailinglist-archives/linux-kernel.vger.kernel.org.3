Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 581475076B9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356001AbiDSRpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 13:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236067AbiDSRph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 13:45:37 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6B736E26
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 10:42:53 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id q22so11994438iod.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 10:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4aH3gKWL2+XEPvC8NucpuidR5DgS4elyTzSSEh3Z93U=;
        b=ZWY2pdxoeqFhH6vQY4NOEN3NdXLOR5jLi12fAlHDlh9+Hats311D+d1DuOjmuFCExb
         v+repEHJiECIxxQRNSpVdNRHZGMocf4+cLoSvgoF4qhxh6vFi+TGSBlOktXn3FBybq3z
         G2szLshEKuCFJ3IMZMgyY+DKcok1Q0ZgCw15c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4aH3gKWL2+XEPvC8NucpuidR5DgS4elyTzSSEh3Z93U=;
        b=Qe9lRSs5xFM3G9Qhh2Iu0n3d8U2SVadV5Cu2ez913HZzw7Ae9tuLGuIOKW451g0bvZ
         7kISBJFadEArqbT97z9kHtQ8OTX/D1HdVr4t9vGCJhAAPlpWWwIe6TxsqC/ryAfsaE50
         ipCuOZxWAXRBqxQe1C3616tgiTXs9txJy+LV+P5+xSXSnWGH5VVIJscpikIa5a5r5wEe
         SQtjt5/r6pmzhehaigjVCTvaiZTknaoW2zrfpHNPZQ6zbz0bUFZQ18h6LQD6ky6guOrF
         QT1cwQNPMuh1WkqlIF/9jRQpok93v7fBAJTeggtirNN2b6LIxBD9uclDXFihC9hEx86t
         mtEQ==
X-Gm-Message-State: AOAM533u1OphZQlBO6XiGXlYn8WME4DMdMVcG8ZS8LL0quawg1gzfdh+
        X6edpd8YKdip1EUFD74If7EwwA==
X-Google-Smtp-Source: ABdhPJwz3UL7uxqGCVC3aGSpKQJcx/rjFi5+Wiv+gXGJkvDMYJyy00cvs9UDKSrTrLkLrKUl8DfdRg==
X-Received: by 2002:a05:6638:4128:b0:323:62b4:30c3 with SMTP id ay40-20020a056638412800b0032362b430c3mr8640514jab.318.1650390173239;
        Tue, 19 Apr 2022 10:42:53 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id x9-20020a6b6a09000000b006549545c9d5sm4360759iog.42.2022.04.19.10.42.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 10:42:52 -0700 (PDT)
Subject: Re: [PATCH 5.15 000/189] 5.15.35-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220419073048.315594917@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <54615348-2663-f7f7-6996-16c33855a7f4@linuxfoundation.org>
Date:   Tue, 19 Apr 2022 11:42:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220419073048.315594917@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/19/22 1:32 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.35 release.
> There are 189 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 21 Apr 2022 07:30:20 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.35-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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

