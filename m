Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0D45290CB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 22:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346421AbiEPULZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 16:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347808AbiEPT6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 15:58:10 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9F2488A8
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 12:49:53 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id q130so19405585ljb.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 12:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=oEm9ampsAj6VYW+tU85zYMzzZx02BGFqtMSM4mOG0tA=;
        b=U7buNOqjUYJdNpQY9YuQfPTXQU2kJGI1JMCwJZzffMIpfmu3+CAsXURRP0Wq/dLHqL
         WxwHP1Y5UswHg8kl376kfFpvpJmM0vqWNIgVooqhmpJG3MLFaIYiLABLpUSHY4ynbB6b
         jDUogzUaKfR288AQWZtLAqP0p87zqNpPeWszfciItxfQ69oyuVrO7zz+oybO7smE+BKG
         0xKf/qAwJDAs5YFYYjsM/DEeYn6uwBcz7bMNZPGWd3dQqcIFngSplVgHVoEdzyOyeL4C
         OB/60doqNZWpioNGkrwf+rBeckB5hzqMp2x4AOyrviPhUFQyH6fdNtPw5jiitY3KOWDA
         Kh3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oEm9ampsAj6VYW+tU85zYMzzZx02BGFqtMSM4mOG0tA=;
        b=BJacVYAvD1OKGQGCPDW3EbzR6SHfzoBvxYSY8pDBC2i2hd5iCXD7pjRTEjoeWTzQrW
         tFPIp2NP1dTI6Y0sa5/KFwQSpoPQjGA0d6vfpGFR0lRCNj1vK/iMEYe4dKJ9Iiv2jVRD
         wHDb/Hf+hKWzEqgogv6GjTOXrhi7yKSFuHpzzJSInWSHxDqgLWKuweXXxwq1+H+apzaW
         tS8l6/0twjZcNel903ah8tWSlVEbWQ3zNh8tMnrFuQkQ+zPkO8KybtyFWe6Z5V/CQqfM
         gQb3G1tRDypcrIlaor3UdEePKQ5Eo2qnu20HpYBr18Ji7wh7V/+jqnAI0V7AX2yXFvL6
         zBrg==
X-Gm-Message-State: AOAM533qFfQaPdSfObAa+3bymNCr9W3/f2KTc7eYcpuBihKJX++VI8LS
        fP5g96DEppAht78tF1R8Y2Sa1cK7g/cUdg==
X-Google-Smtp-Source: ABdhPJzj4kqsOgk+3Pmh9rw0qnfBHTmwH2zkabyF2JtWUfp4tC2MsFuwkJI+p0hvrqs5l+xyK9fwYw==
X-Received: by 2002:a2e:b5d1:0:b0:24f:331d:f9b6 with SMTP id g17-20020a2eb5d1000000b0024f331df9b6mr12066365ljn.302.1652730591843;
        Mon, 16 May 2022 12:49:51 -0700 (PDT)
Received: from [192.168.1.11] ([217.117.245.216])
        by smtp.gmail.com with ESMTPSA id r13-20020a2eb60d000000b0024f3d1daea8sm1659956ljn.48.2022.05.16.12.49.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 12:49:51 -0700 (PDT)
Message-ID: <8142ad15-1fdc-10f8-86f2-fb275cb6cd39@gmail.com>
Date:   Mon, 16 May 2022 22:49:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 0/3] staging: r8188eu: fix checkpatch.pl warnings
Content-Language: en-US
To:     Vihas Makwana <makvihas@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20220516170306.6008-1-makvihas@gmail.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <20220516170306.6008-1-makvihas@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vihas,

On 5/16/22 20:03, Vihas Makwana wrote:
> This patchset fixes following checkpatch warning:
>      WARNING: Comparisons should place the constant on the right side of the test
> 
> Compiled tested only.
> 
> Vihas Makwana (3):
>    staging: r8188eu: fix checkpatch warnings in rtw_p2p
>    staging: r8188eu: fix checkpatch warnings in rtw_pwrctrl
>    staging: r8188eu: fix checkpatch warnings in rtw_wlan_util
> 
>   drivers/staging/r8188eu/core/rtw_p2p.c       |  8 ++++----
>   drivers/staging/r8188eu/core/rtw_pwrctrl.c   | 12 ++++++------
>   drivers/staging/r8188eu/core/rtw_wlan_util.c |  2 +-
>   3 files changed, 11 insertions(+), 11 deletions(-)
> 
checkpatch warns about the subjects. See an example for 1/3, but it's 
related to all 3.

> WARNING: A patch subject line should describe the change not the tool that found it
> #4: 
> Subject: [PATCH 1/3] staging: r8188eu: fix checkpatch.pl warnings in rtw_p2p
> 
> total: 0 errors, 1 warnings, 0 checks, 32 lines checked




With regards,
Pavel Skripkin
