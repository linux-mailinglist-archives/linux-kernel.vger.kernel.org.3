Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D1C502D53
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 17:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355651AbiDOPur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 11:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355648AbiDOPuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 11:50:44 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A137799EDD
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 08:48:15 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-ddfa38f1c1so8370423fac.11
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 08:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=q765IUBwbVRbiY7GCRp5aqTSZ9koQTZPRgD9rU6GYlQ=;
        b=QmDl2ZbCxThSfQnoARLLm8ygLudpYKwsU5b5uTG/EHUM9ZQgVC5u/3fWrWAkePQDeA
         9g+ThLsoU/HloYF3fZRBjTgs9T6YxC9rosDKJ3IxwoVeYCMu5udlhZb1p8IXJBf4eZcE
         TYvI3TrZL9vMMVE9w6tp6d5NbDg+bUf8wnbv2uUEnbCjed63GR5FTf27z18NuQdJLGPv
         1CSPuBa3bSDpIlxwRHBjOyQYinoO+OXQTEwVVRAc1pZ353AD2EUXfFL9Hq4QXazF7Syu
         DHtDmV6ypjdMORqtaQToliODRqF82ZhA9f1hn7sTsoh+W6BiSGZfbDhaewEcq/j9C2LX
         qTNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=q765IUBwbVRbiY7GCRp5aqTSZ9koQTZPRgD9rU6GYlQ=;
        b=1KlNsicc6w5l5gEh6mkwZiZXW9jeW8+vagsdHXPhpSIrWmN0H7a04ezTxGnl8Km8Aa
         t0pGGK6mAPLyo2BqdqLKflMJ49l8CSsZ2PD0eqHSpjO7n6vAjQFu3EpqDIhlAV1GjbL9
         2dbY+33ZW1oLvuJmSix6cQG+sq2qpFwRxqGKHSxnSwqSzbF+0/xUgwGxQZVLl3orxcgt
         H7c8gQAujmyxSW7U6/ROwaF8Q3eMfKCsUXWXk/8xV2A+PP4xeiPdUlFCLFQPE5zAr+8+
         63kiDid7mo9aiWGygNw9gTgMhBRvJ7iivsLdZDE4ftcR2BF/E8fhARAn8KgxFX7bR/xH
         PT6A==
X-Gm-Message-State: AOAM533MnQh8VZ4VscFjEnYsO+tD3JH8iS1LsGQj4x9mg6N/E6lfIDNI
        TcKeYkytnSUKiipdG1t/keE=
X-Google-Smtp-Source: ABdhPJz0Qb+sYq3Yq8EPsahoB2T5DD2qiGBzIOps5tE8PDXLRrqMoVfMIpEdr7bT30wXdLczPcr6Kg==
X-Received: by 2002:a05:6870:e3c1:b0:d7:2dc8:7fd0 with SMTP id y1-20020a056870e3c100b000d72dc87fd0mr1653590oad.104.1650037695002;
        Fri, 15 Apr 2022 08:48:15 -0700 (PDT)
Received: from ?IPV6:2603:8090:2005:39b3::100e? (2603-8090-2005-39b3-0000-0000-0000-100e.res6.spectrum.com. [2603:8090:2005:39b3::100e])
        by smtp.gmail.com with ESMTPSA id q13-20020a4ab3cd000000b0032830efe365sm1222249ooo.43.2022.04.15.08.48.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Apr 2022 08:48:14 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <349ff644-e615-8a1a-c4b2-233bb81352ae@lwfinger.net>
Date:   Fri, 15 Apr 2022 10:48:13 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 0/8] staging: r8188eu: fix and clean up some firmware
 code
Content-Language: en-US
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20220415121023.11564-1-straube.linux@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <20220415121023.11564-1-straube.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/15/22 07:10, Michael Straube wrote:
> This series fixes wrong size of struct rt_firmware_hdr in the first
> patch and does some cleanups in rtl8188e_firmware_download() in the
> other patches.
> 
> Tested on x86_64 with Inter-Tech DMG-02.
> 
> v3:
> - Splitted the first patch into two separate patches.
> - Added back logging the firmware version only once.
> - Included the compile time check for size of rt_firmware from
>    patch 8/8 of v2 in the patch that replaces the hardcoded size.
> 
> v2:
> - Added a patch to check size of struct rt_firmware_hdr at compile time.
> 
> Michael Straube (8):
>    staging: r8188eu: fix struct rt_firmware_hdr
>    staging: r8188eu: convert u32 fields of rt_firmware_hdr to __le32
>    staging: r8188eu: clean up comments in struct rt_firmware_hdr
>    staging: r8188eu: rename fields of struct rt_firmware_hdr
>    staging: r8188eu: use sizeof instead of hardcoded firmware header size
>    staging: r8188eu: remove variables from rtl8188e_firmware_download()
>    staging: r8188eu: use pr_info_once() to log the firmware version
>    staging: r8188eu: check firmware header existence before access
> 
>   drivers/staging/r8188eu/core/rtw_fw.c | 79 ++++++++++-----------------
>   1 file changed, 29 insertions(+), 50 deletions(-)

Most of this is fine, other than the removal of in-line comments in patch 3/8.

Larry

