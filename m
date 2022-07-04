Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 275AC565DAD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 20:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233922AbiGDS6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 14:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiGDS6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 14:58:39 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A89E6140
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 11:58:38 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id ay16so18114028ejb.6
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 11:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=8OLL1jUVaQcGoXmQo2JjgriQ5VFjXz9Vc55lT99BIvI=;
        b=TgAY4HAHmFE1nSrA53O3flNQ3tgdijtGS7y26ZTXyHz+GfNTp+tqJMOh49IqHLY0Ug
         AP87D+lBKUZqG2/ekNJYcrJcmVuzTqCExtF6UT6qoZujcfIkDFccwOXgFpsAaM0e9Znb
         sKoW9ppKMIg+rB3PzHJ24nCYogtmYmRp/XadVzxwUeegbO+xMghj8G8HHvjY28w42xSA
         6ALo5TzBCoNRTDh/kmOFjK0/EmiuJa5qVbpRozpcMNjYcaeSWRqGX99IwzWIv0b2MfOr
         dVM20S0UVBWT5AvM539cb4ynw365B07srl7mTpP//lUDp5HHpmR7ZcvCItMPviPrSTPb
         2XYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8OLL1jUVaQcGoXmQo2JjgriQ5VFjXz9Vc55lT99BIvI=;
        b=J+IBugeUO4m9mjBbwCENy0fQJfcM8lZzAqPJV4+MN4fKndpByAJstq1dVNuMk9sTz9
         pqwq/DtpfPTwGZG0vC/WyoojypciFxuTeiTLXGGZAgfAkH7TL5tXvOTcqXCmyxjvmPMn
         VwgkA13J7uDe5c629hUUzlV4wQSZYf8tr/5/txRz9Rfpa2NMVKw9cC4VhLYMcHCKmSEU
         8jlN0TWKUf7eSh34YV5qBWd5v/vhh6Hvh8Gi9N8lm3otz7acCeZ+bE5RrZlAOjgbbAOc
         9JhWPmi6qGWTp7ruCv9p931UBSWmpTT88j3si/T867bbLQm7Fa5zWbT/LilSBj1k+p1Q
         KLhQ==
X-Gm-Message-State: AJIora9PiG3HXpSd2w6AlEzoeOnByaYVSeLf5rfdzqy5czvbGCLT6HAh
        GbUhN+XaHv2lTxWRDv1lqkQ=
X-Google-Smtp-Source: AGRyM1s8PYtZXuUD1BhG5j69FCmLcX4OMHH7nYgx7Qju2MLprfzyddftxsIyPLuygDD3gZuvit3EGg==
X-Received: by 2002:a17:907:778a:b0:70c:d67:578e with SMTP id ky10-20020a170907778a00b0070c0d67578emr29231722ejc.696.1656961117113;
        Mon, 04 Jul 2022 11:58:37 -0700 (PDT)
Received: from [192.168.1.100] (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id b21-20020aa7cd15000000b0043a6c538047sm1865356edw.70.2022.07.04.11.58.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 11:58:36 -0700 (PDT)
Message-ID: <a39f84f8-bde2-1a5a-f8ec-000dcabcea74@gmail.com>
Date:   Mon, 4 Jul 2022 20:58:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 0/5] staging: r8188eu: power sequences cleanup
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220704145221.159949-1-martin@kaiser.cx>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20220704145221.159949-1-martin@kaiser.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/4/22 16:52, Martin Kaiser wrote:
> Simplify and clean up the power sequences. Remove some unused register
> definitions.
> 
> Martin Kaiser (5):
>    staging: r8188eu: move pwr seq defines to HalPwrSeqCmd.c
>    staging: r8188eu: support only us in PWR_CMD_DELAY
>    staging: r8188eu: read pwr seq length, remove PWR_CMD_END
>    staging: r8188eu: remove sdio definitions
>    staging: r8188eu: mac addr len is unused
> 
>   drivers/staging/r8188eu/hal/HalPwrSeqCmd.c    |  60 +++++---
>   .../staging/r8188eu/include/HalPwrSeqCmd.h    |  47 ------
>   .../staging/r8188eu/include/rtl8188e_spec.h   | 137 ------------------
>   3 files changed, 42 insertions(+), 202 deletions(-)
> 

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150
