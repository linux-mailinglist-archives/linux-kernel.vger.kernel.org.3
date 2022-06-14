Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF01654A768
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 05:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353514AbiFNDJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 23:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355555AbiFNDIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 23:08:53 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84470DF9C
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 20:08:52 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id h7so5676126ila.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 20:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2jknCHAp9Ud5WrwOQEYCgW2boDB+iTyyFImPZhLSv0g=;
        b=dTl0OHOge36d2lKzx+2AGgGcqd3ImKydMKCkKT1StPTY6hYQBwBdltYX0Rov1d5pyb
         OZGGf62XdyrrN3VMcZ1kkSz8qR3UFdPhKOJbiadIW3xVaKmTdWbbZmBLMvnZMBJxBWNN
         3DWyaSvBAMXoGM7glE0vkL5KEXqZWh7V13Fsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2jknCHAp9Ud5WrwOQEYCgW2boDB+iTyyFImPZhLSv0g=;
        b=f1q6+OLix4BTAn3S/6liCGRy0dn5li5mK8Y/HUwhUsJW9ekuFB1vlgmdUQolyQy81J
         bNvRp529cMPMqOv+LW7v7GjvpkC6rq/I2VOWfC1uW8nErh75dEhdGSxzUQ/3V1SO5N6I
         8xTKoSJ0zh6AnRR1zVHiCfW3gO+zEogAkGtonHe4fsLhPDrRa7TXVp1SQvokg2KSe9g7
         YlfphUX0OEP7ZoTvnjqCl6Hfsj1kPtml3jGgOL0HvcHmV42B+kwG+Uh39jf52c0Xj7Wt
         uvsvWVjB3HmQuvmUm6NEU9yX3csr1KhMR8WtG7IjQTGMiz0YQ/QXC/WlCWge/YRLGxDa
         g5eA==
X-Gm-Message-State: AJIora8j6bklvCQf7caYAu3tojY/yEtu/rYUNbkOSnjanM+Hy7ZpwdgR
        6ULGXGNqEPeylpF+IsIw2G0unA==
X-Google-Smtp-Source: AGRyM1s3q0kMzBxrcwgFAM4AlUTCFDC1UHdRLZCq+ECa1PoNDQuxL8VomHs9RkLXMlT6CRA2gYUzhQ==
X-Received: by 2002:a05:6e02:1205:b0:2d7:6fde:74d1 with SMTP id a5-20020a056e02120500b002d76fde74d1mr1690566ilq.306.1655176131803;
        Mon, 13 Jun 2022 20:08:51 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id a10-20020a92d10a000000b002d6d8398e88sm4765026ilb.70.2022.06.13.20.08.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jun 2022 20:08:51 -0700 (PDT)
Subject: Re: [PATCH 4.19 000/287] 4.19.247-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220613094923.832156175@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <3ae6f75e-4e69-25d8-f0bd-c9ac9bd95da8@linuxfoundation.org>
Date:   Mon, 13 Jun 2022 21:08:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220613094923.832156175@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/13/22 4:07 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.247 release.
> There are 287 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 15 Jun 2022 09:47:08 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.247-rc1.gz
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
