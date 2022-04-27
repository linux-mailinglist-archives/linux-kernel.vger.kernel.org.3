Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC07510F93
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 05:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357538AbiD0DiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 23:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357512AbiD0DiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 23:38:18 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325E62AD8;
        Tue, 26 Apr 2022 20:35:09 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id v12-20020a9d7d0c000000b006054b51c3d4so282835otn.8;
        Tue, 26 Apr 2022 20:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=P8TnfAKaWXwsEVz2IHHsmMbXLBYv3keX8jHJkboUhfo=;
        b=qZNiSAaIYWoTPpTYxcwpNXefkEf7mNKLxvCwi1xVh2iChN4ze5MCJtEHxRLgTNJb5F
         mm752QHptJJ6JK6+Jn3x3G3OOZqX4a2SXWXYGuUMQCdNlaJMpS41uBLUwpyI0c2d/0qg
         DNULQ4TzSTEuhVWAddkQegR46qfmDsiIn/y82/C2p2Oya8jUuOLRaAeSY409BlprWHsK
         rtWsWiqT3INPvItI2M4+Fl65W2TVO9uW3lztKgS2hMQp64dbd0VVDB/VXP78iEliHcyX
         8ZnjcT3G3+jbmmXtU0ss4wCV4GI9oQnStxLd2vlGuJoHluGsCSareOeM+ImifjMvzy8z
         KwZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=P8TnfAKaWXwsEVz2IHHsmMbXLBYv3keX8jHJkboUhfo=;
        b=ilbCrxFHe/BYzJNXlxPtIMEzjtA6j3SutHoFBnHBERWU438TRXrFiLHDgK/Sv3/Dt8
         +vpfBNp7s3gbORrdgIl3bxjd7GxHHeC0B8cPmoI+pMXDDYSPjCSq7jsfJPTh9WgygJuz
         Wmt6LwS2zPA3+t+Znd1zmFaMwRcizIDVeWqyqGnwcb/8OdbJyc9lSiIlkcE34dR9u+vj
         XBstQpflpu8+OJdxKxYLPqFTvPCHf1fQzXynT+R3Z3kWzDNWij398q00QIyhGQMimf4x
         qqp2MrbjxIgBZGsQRersW6QAXoaSHb0KwPHHjSWVtvnGo61OEbkxJDuW+zvxQjNBkuSZ
         ZpTA==
X-Gm-Message-State: AOAM533SN2PQEhw+4ijChRYfApKvZbVVK7mEdL8qyptn/dttUisLMURF
        C7c4xVg2R8CnaWnq747k9gQ=
X-Google-Smtp-Source: ABdhPJwTIlhigZpiyaVwQ7PYyFEqA5Qa0yAl0iyqicWL9mPHM0WeUeRYURlYcEptTJq5y+wJ5ZkcDQ==
X-Received: by 2002:a05:6830:2007:b0:605:8c49:a3f3 with SMTP id e7-20020a056830200700b006058c49a3f3mr8625422otp.366.1651030508495;
        Tue, 26 Apr 2022 20:35:08 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q203-20020acad9d4000000b002f8ee3f69e2sm5598621oig.52.2022.04.26.20.35.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 20:35:07 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <2563e20b-7800-086e-73d4-e4cbc7a53c5b@roeck-us.net>
Date:   Tue, 26 Apr 2022 20:35:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 0/3] hwmon: (dell-smm) Improve init code
Content-Language: en-US
To:     Armin Wolf <W_Armin@gmx.de>, pali@kernel.org
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220426213154.724708-1-W_Armin@gmx.de>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220426213154.724708-1-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/22 14:31, Armin Wolf wrote:
> This patch series improves the init code of the dell_smm_hwmon
> driver. The first patch speeds up device initialisation by avoiding
> unnecessary SMM calls during init, which might be slow on some
> machines. The second patch is a small cleanup patch, while the
> third patch allows for easier diagnosis of audio problems caused
> by really slow SMM calls.
> 
> Tested on a Dell Inspiron 3505.

Series applied to hwmon-next.

Thanks,
Guenter

> 
> Changes in v2:
> - replace pr_warn() with pr_warn_once()
> 
> Armin Wolf (3):
>    hwmon: (dell-smm) Avoid unnecessary SMM calls during init
>    hwmon: (dell-smm) Cleanup init code
>    hwmon: (dell-smm) Warn if SMM call took a very long time to execute
> 
>   drivers/hwmon/dell-smm-hwmon.c | 50 +++++++++++++++-------------------
>   1 file changed, 22 insertions(+), 28 deletions(-)
> 
> --
> 2.30.2
> 

