Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 448CB4733C5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 19:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241772AbhLMSR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 13:17:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241784AbhLMSRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 13:17:20 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145B8C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 10:17:20 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id w33-20020a17090a6ba400b001a722a06212so13032027pjj.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 10:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=F8sC5FdkIHoBVbPCAfYKXOlFiBXA/DjGmKoVu/p8um4=;
        b=WKpsS7BCccTwE1d79oM3wlk6RJsntAUKBcIbMfpM8GPX6WFNkU2Rbsxq8X7D6cu0uT
         maGbQAx/VsOk/OVSwMXbpgnd1c+A/IP/o6hmDqE0veUBZHOMP0sG2zzRFl5T6fjPeFKT
         qZ2/1Jns+iZ+Fhe7JhfgAkGNr0EmNN+9SuPO2p2HxaZlb0PPt7GqJhtB84bOEM7I3FeN
         +d4NidTgHTl/TG9Vc+WBHJ/lUBpzfamxrFZJmNRv57NYlU8071Z9TBiKYCNhTqNNR4lA
         dZWilvcgK5+vqBUNVQengXwp2+HZ6jvK8ZHgMge6bmhSkhKAlVHuZwcbh0cwTp7uQ8ZM
         2/yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=F8sC5FdkIHoBVbPCAfYKXOlFiBXA/DjGmKoVu/p8um4=;
        b=mSUZ7tMyrNVGBmGk2F9x4aWBgoqmfQUY+nloxl9T9DU1YwK8/burBYBDWcOKLoGfLL
         dSePuilGum9P1UdmkQklILvTXvOafgy8w7nd2p5yo7RjhkBaz3np5yJgK1LxAL2d5tIj
         BD2UqXHpG+lMPFQw+SJ+TeRN403Q4CHbV8XS1u0rE6bYO6nbGSF5yXMdovDXeICiWz3m
         bcWwauj4kpEynl/P4jhiVjHOALjnMFARP3Ga5nfT4ZqqFmClgDttgC0D3gLFTY8F//8J
         IWA8guoZGEQo6H97U8HqGCaOXsvRb4Ch6ypWalRxfOKoSxskMUYy6LWXAlyl9sll7fDW
         OkTw==
X-Gm-Message-State: AOAM5322vqcMQ6VeL5+0dK0Hh5HZ1iz5rLQiCbRMDb/N+3S1sSh0Us+M
        3bdTk2dKdUa9IARlWi2ZhLx7ug==
X-Google-Smtp-Source: ABdhPJzGTZQvwgc4TUkEaYPWSzTALTXz9xvxlCOEFBKYWk78pzdOq2gg4NHj2nXmnop+zjQSs/bheQ==
X-Received: by 2002:a17:903:283:b0:142:1243:d879 with SMTP id j3-20020a170903028300b001421243d879mr98970610plr.61.1639419439435;
        Mon, 13 Dec 2021 10:17:19 -0800 (PST)
Received: from [192.168.254.17] ([50.39.160.154])
        by smtp.gmail.com with ESMTPSA id md6sm7613577pjb.22.2021.12.13.10.17.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Dec 2021 10:17:19 -0800 (PST)
Message-ID: <52a7fa5d-6fa0-a0df-2e88-bd4bf443a671@linaro.org>
Date:   Mon, 13 Dec 2021 10:17:18 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 5.10 000/132] 5.10.85-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     shuah@kernel.org, f.fainelli@gmail.com, patches@kernelci.org,
        lkft-triage@lists.linaro.org, jonathanh@nvidia.com,
        stable@vger.kernel.org, pavel@denx.de, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, linux@roeck-us.net,
        krzysztof.kozlowski@canonical.com
References: <20211213092939.074326017@linuxfoundation.org>
From:   Tadeusz Struk <tadeusz.struk@linaro.org>
In-Reply-To: <20211213092939.074326017@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/21 01:29, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.85 release.
> There are 132 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 15 Dec 2021 09:29:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.85-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.

Hi,
In this release cycle there were two similar nfc fixes:

fd79a0cbf0b2 nfc: fix segfault in nfc_genl_dump_devices_done
4cd8371a234d nfc: fix potential NULL pointer deref in nfc_genl_dump_ses_done

The list here only includes the second one. The first is still missing.
The same applies to 5.15

-- 
Thanks,
Tadeusz
