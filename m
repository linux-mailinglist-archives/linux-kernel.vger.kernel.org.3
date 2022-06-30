Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 907795626EE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 01:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbiF3XJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 19:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbiF3XJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 19:09:07 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8275459255
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 16:08:52 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id p9so354794ilj.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 16:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YiiXu0cJQMjKT9LWIZtpdMHTzQKvQmFUOcOzqfaSgnc=;
        b=O5IlcubKk1akgyzHocPgRmTw5e1MigaldWyYjxl8krtlQCHvJD3s4E/q81eBXKaVsR
         OayB3KoufAz/h5HYCMmH7KatlSSeVWZnJ2FF8mMRXVH0BlKiQTVwszwQVUO66jWfh2Pz
         Uj222pe0+VRAo1LY2TmCU996jUwe5f8pJZ40A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YiiXu0cJQMjKT9LWIZtpdMHTzQKvQmFUOcOzqfaSgnc=;
        b=WQVBG8GV/LRuf8s+OsYeCp2GWXM+sI4YF0sRMH0DqM14Nb899854cPdzl387HxRkEO
         xzeplkCEsU0/yo6sfRDxdICDZKaoBql8MvRurXxrSk3+mNO7j8L3n0L85Qu1PYmNpsLs
         AgfeciGGMc7cFbNMvIFvNX0RcKVh2ycFdwtJNnfmFFEDmIrfCLGYBQz77xpEcsLdV8Rp
         vI26hi/H4ZkHybX6wZ+NVxPY9wSrg5XtZ8c1WJqLjvkTLNmGQfJftmovBNg6m3ECP7FA
         we/kovjaeGLZtOshzuX3hV7nWVKYzUsioh3sBJqYZFd7bRRYP+wNYIzh5X90WRsOK3Yu
         4GGw==
X-Gm-Message-State: AJIora8YM646Hm6XkCLtzVgyo5FRkNAV5ce3dl8w5GH7JED1cUWf7DNs
        L8FHEkSua5UHf8zdoVZpiDQm0g==
X-Google-Smtp-Source: AGRyM1t3pKNB8xI7EOxG2dZ+/6KxR82KNXzrViwF/zYm/45XKBAwaOhk9AOcuOX82X8fkRKRBM4hEg==
X-Received: by 2002:a05:6e02:1708:b0:2da:9eef:5bc8 with SMTP id u8-20020a056e02170800b002da9eef5bc8mr6705255ill.153.1656630531637;
        Thu, 30 Jun 2022 16:08:51 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id h8-20020a92d848000000b002da9f82c703sm4454762ilq.5.2022.06.30.16.08.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 16:08:51 -0700 (PDT)
Subject: Re: [PATCH 4.19 00/49] 4.19.250-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220630133233.910803744@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <6c82f710-04b2-c6b5-fd35-708633f3b49f@linuxfoundation.org>
Date:   Thu, 30 Jun 2022 17:08:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220630133233.910803744@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/30/22 7:46 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.250 release.
> There are 49 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 02 Jul 2022 13:32:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.250-rc1.gz
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
