Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72D4549A858
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381366AbiAYDDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 22:03:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S3415598AbiAYBsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 20:48:05 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2361C06E015
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 17:46:32 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id u5so15540568ilq.9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 17:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OLFh68WssbeQyB1KrT0TRpUmamwDBiQmELJA8PMvRb8=;
        b=Kz8eMKjla9hxns2SFusdrhsEQaemENVSfQXAhV2XGbhNUGoZSIIGXScVsdzelc4LjM
         Nb+4nN9llQO2eqIVWV2oqC4Cs5zMd8SpdFBcY+FoPiMh1ppIvhwu6/XETOeiBybv3MRh
         b1PQ6tDHewtJvtVb6ebYv82xcyklYm445/sqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OLFh68WssbeQyB1KrT0TRpUmamwDBiQmELJA8PMvRb8=;
        b=otCzYbonto0mlRoQHQhxQqjMJG5gOvXn3Fub324qAvZ/sApwAXnOgVCY1if7uqVpGp
         jrw3vwOC/betqKG7aFGdaeo4LLEe7NQQwHDEwPiAJp5Dxo2NozcHhIDAvPcDbEbUurjF
         SzQFjg20hmcIBvvrbmUYkms0NJ+z99EFCaKDi94PA+Cel3E1OE1yUp5ua1ey+vW7yPLX
         C+b7y3oeS6OmSfIQAcS2M1TkZvFwNW7vM8sfuWaU/JUIh7T5aZqMe8C7C2R+CUq2vsl6
         9Nicx6yqDcWs0p5CGyyXhAlsbz1/sopP1zukhtRFInSxlt0IDuKy4c3uuiiQGh8wCGHh
         obQg==
X-Gm-Message-State: AOAM531fXsLSbvog909Gkrc/1hb1/V8JpG7nnf0YHirp8fuYsWdJQAyF
        S3lzMLP7xMH0vmvYqR9IVylf4g==
X-Google-Smtp-Source: ABdhPJzfzNVUXd2pR1v+yfQ36klDiWPOQZ69j5O6DVxr1DyUrEf/Dj0WF1Nc3KzJXCeDylaHeMPHNg==
X-Received: by 2002:a05:6e02:1bcc:: with SMTP id x12mr10476913ilv.96.1643075191643;
        Mon, 24 Jan 2022 17:46:31 -0800 (PST)
Received: from ?IPv6:2601:282:8200:4c:b48b:eb27:e282:37fe? ([2601:282:8200:4c:b48b:eb27:e282:37fe])
        by smtp.gmail.com with ESMTPSA id v19sm8057996ilj.49.2022.01.24.17.46.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jan 2022 17:46:31 -0800 (PST)
Subject: Re: [PATCH 5.16 0000/1039] 5.16.3-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20220124184125.121143506@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <8e94c4da-86ef-4693-c1ae-31a3447f4efb@linuxfoundation.org>
Date:   Mon, 24 Jan 2022 18:46:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220124184125.121143506@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/22 11:29 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.16.3 release.
> There are 1039 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 26 Jan 2022 18:39:11 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.16.3-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.16.y
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
