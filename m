Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15F9B4AA133
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 21:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238666AbiBDUdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 15:33:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238463AbiBDUdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 15:33:11 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7409C06173E
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 12:33:10 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id c188so8831979iof.6
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 12:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yC+jvfwVlwP869Sf5VAj3JxEYXRki/S+j7RsCMY3Luc=;
        b=hw8nrVpnzEkdr0OXDIad/ireNg0NAK/Xv7CtDLacAkx1cPrF3ZB2GNFNpFEmc0YfcX
         s0PFua40cSq28GFIa06w0+J9WtvYTs5y13wzFbEOO6en8gG9ySAxL8HnievQucay9A1v
         mX1aNadCpsN7W4hscbCOmr5QExwXOZYVgfr68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yC+jvfwVlwP869Sf5VAj3JxEYXRki/S+j7RsCMY3Luc=;
        b=Or7TijO9Rs9/90GXRgPwSdPG8uXKQBPoHCfltiPKPgyUcU6yBIoZJqcwJpYiQg4TiI
         V5a92Cy4aksT/aDjIpQ1cJiPYn6x3nWrlmRIxQHg7zEJD5mk4x7D5uIQnqKyzwoCs2lL
         jqR+oVcyZ2MAZXEwieE0Ph7BzBxCC9ZUBXhv1Lq+hz7Yn78At/T44g2EVMag6/tQWRUN
         w71XMMm6eMuWufV478Lnlztczg2uHReC9oSgI1gReiPWm4HXrsw3zoPv8RxYqy4QX2af
         vD3LeWgwCGb/R26YiL8/8I57U/iGL1fdUPD8FxADaOYUz4yXUSmLgt4uSK9mJA6TNp1H
         10QA==
X-Gm-Message-State: AOAM533arn+2e3GP0ixmcpoaoO3LS4JzJ746rMTwQtC30zvqzonr0EXH
        UScX3xXm/tVrByqep+EkAkFW0w==
X-Google-Smtp-Source: ABdhPJx51DRl4laNymhQtxHuk5vl3tJeD/NGPb0mxlDiukv3RiGPA0t5MAALJPu6EXeimY+N2tnlNw==
X-Received: by 2002:a5d:8419:: with SMTP id i25mr359840ion.163.1644006790204;
        Fri, 04 Feb 2022 12:33:10 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id g8sm1462727ilc.10.2022.02.04.12.33.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Feb 2022 12:33:09 -0800 (PST)
Subject: Re: [PATCH 5.4 00/10] 5.4.177-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220204091912.329106021@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <ae60077f-6682-310e-b21a-792a68250530@linuxfoundation.org>
Date:   Fri, 4 Feb 2022 13:33:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220204091912.329106021@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/22 2:20 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.177 release.
> There are 10 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 06 Feb 2022 09:19:05 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.177-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
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

