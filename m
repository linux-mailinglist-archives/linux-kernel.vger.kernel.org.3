Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEBED5A8619
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbiHaSzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbiHaSzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:55:06 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1D612619
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 11:55:04 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id gb36so9361415ejc.10
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 11:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=CMpQEYdybSyhAWte/2QTAoDCUR/mXObytaX6p/VZc6E=;
        b=lqPIYuzGgbqH/UbmKzHFXJjvvK357w2rVqakmMKTURzL7n5cBXsQ9J9XEqB4Pm/ygE
         sSz1lDUxPhCp6+GwU6rtSS5rtFfclUH7YHRdbr6d2CQMBAj4rZhT9tbd5KGmTiI9N0ES
         nhQ3BpOoWtnOgkaaWhpWa61C/LmGN/RvYGahuji3EdAjrstTMqM6G9mDQ31ANpeFryOD
         sJBtqfRlBBFVUiuQOOFfzGLDh6ekLYnSQmeLvFVj6D5O9WGHO9WjC5aWw8qfvuFO43A2
         8W05sjG361fKNBH6M9koFfQXhv5saZlzdgUf3yGeVbIxuPkJLfsYVP1Cax/Uc9joLveW
         16nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=CMpQEYdybSyhAWte/2QTAoDCUR/mXObytaX6p/VZc6E=;
        b=4mUBggIWKe/a0Ol6lsiSDV9PHUNkdy28tE85HlAV+SqYGi4jV3rSY0I9xJCbvGwlQj
         uY9NVD9bHBys662KytP7HUbckikmX+ZF8NrrjDxpiFD1prOLbU0/lpdQMon9FzHfNNF2
         YrvqBp2aITN5N03Df+pkMBexmlUFIr2K+KRq8aGx790t9UagU6kHLbwh4QPSoUDodmbw
         L+ppghRQTFqo3s/vKEoPSf6sMJafoT54tjgMvfpk/rwKyhfCuT2hAnoeVPnpN+DJ7umu
         Hm0R/TzEYnNwjIA9+MRGS6qmu4CCBRefhS7NIk1+hI7JVDo7VQEszs21q88jena2w3I4
         OmTQ==
X-Gm-Message-State: ACgBeo3OIhYUiW/5Qv34IvnHmmu2sRsh5pKUGK1BQ2iSEE6respzRA92
        a3xft+z2t7VbojBuNtrsGss=
X-Google-Smtp-Source: AA6agR4eIHFs1O8X2CZ7Z71VdsNr8hWv15ibxCEcftc5dYd455VKKDLNPZQibIa5z7qja9vGOJ5jXg==
X-Received: by 2002:a17:907:2721:b0:741:56e5:6802 with SMTP id d1-20020a170907272100b0074156e56802mr13527094ejl.675.1661972102850;
        Wed, 31 Aug 2022 11:55:02 -0700 (PDT)
Received: from [192.168.1.100] (p57ba2cf5.dip0.t-ipconnect.de. [87.186.44.245])
        by smtp.gmail.com with ESMTPSA id bq10-20020a170906d0ca00b00734b2169222sm7420328ejb.186.2022.08.31.11.55.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Aug 2022 11:55:02 -0700 (PDT)
Message-ID: <6e5dc597-19aa-aed2-c94a-29d13acc0f87@gmail.com>
Date:   Wed, 31 Aug 2022 20:55:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/2] staging: r8188eu: migrate os_dep/mlme_linux.c
Content-Language: en-US
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220831053639.8559-1-straube.linux@gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20220831053639.8559-1-straube.linux@gmail.com>
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

On 8/31/22 07:36, Michael Straube wrote:
> This series moves the functions from os_dep/mlme_linux.c to
> core/rtw_mlme.c and removes os_dep/mlme_linux.c.
> 
> Tested on x86_64 with Inter-Tech DMG-02.
> 
> Michael Straube (2):
>    staging: r8188eu: make two functions static
>    staging: r8188eu: remove os_dep/mlme_linux.c
> 
>   drivers/staging/r8188eu/Makefile             |  1 -
>   drivers/staging/r8188eu/core/rtw_mlme.c      | 31 ++++++++++++++++
>   drivers/staging/r8188eu/include/mlme_osdep.h |  2 -
>   drivers/staging/r8188eu/include/rtw_mlme.h   |  2 -
>   drivers/staging/r8188eu/os_dep/mlme_linux.c  | 39 --------------------
>   5 files changed, 31 insertions(+), 44 deletions(-)
>   delete mode 100644 drivers/staging/r8188eu/os_dep/mlme_linux.c
> 


Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150
