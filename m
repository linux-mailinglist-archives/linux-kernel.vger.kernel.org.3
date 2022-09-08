Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2CD95B269B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 21:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbiIHTQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 15:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbiIHTQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 15:16:05 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D981C3F7D
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 12:16:04 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id fy31so40349717ejc.6
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 12:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=7y4nA/2xDJfYJjiHsXSxtBDwG/RdKjtD4H9Y9Yc85To=;
        b=ROVDvcV8KoG3A8gHUPY2sbQ3J7kUQZuBjHxyYOQSw1bAo21d6kcAwvHEGnqPL6QkvA
         0qtbyzXILuLqS7DCVEfoSf8SjMlOZIEmUbZtYYx0b7GAgTBLJaTCvItK1fLrk/u7PgNv
         365IXBsKUZ+RbeZmUmQIHZ9U+YjgpoSbF1xATMp6fRt5nV45foSX1BrErKYnXagzm/Mg
         HztGHOf6Vm0UzRftaIXbiXNDUGjJA8AKOYqp5F5SHbQj3F0IRi/6RuEwksHl3uRaQOh8
         WUjPv8D0caa2EfQBxL0CBFIZfUp0xBw0fTTU7tfALC5RAt3DLbZ9ZmI8rvHV4qK6PT54
         tE7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=7y4nA/2xDJfYJjiHsXSxtBDwG/RdKjtD4H9Y9Yc85To=;
        b=VL3b0phMceNCwkCo/ay4aJJbBxsORwrZG9qEKV+X0SYVSZvBNKC8YPgv795Cao1DC1
         bxWQ+fk++TUe2J/G8Ovuz6//xa3ENZmhXhVfFP0ysImC8MsgQiV6VNfvFyehJTVuq5Ks
         1og5ZtH6X8CS++tuHvge3XOE05d7CCztIrSm/IjA0q+bpyOA6obk70i+ZhOdRlz9/3lC
         p52upLmQz5Sw1mRgWx3BgkmSPChi5nytfMPAfMi06Lfm4L1sDQRWeB7/0Ls0CSlISd0k
         lQ8F/DarBq64Q3MgQ10FLYk5aK+TERK5YxVcya6TNzWQAva3fBFybqzAKmVV9llqoGX2
         uFBw==
X-Gm-Message-State: ACgBeo0kxqkJBUTx5F8IqxBmWgEcrcT6RIpVxHe++6gaOs7fVA5SeZz3
        gUxQSRwNb+2DI88NjEN6uHc=
X-Google-Smtp-Source: AA6agR5QbmgYt8K41NBlaandsZsChJr17wPPa+yvgNg+6Ys4YHmMEElz/E3BFOHgD8LqRcB9vpnc5w==
X-Received: by 2002:a17:907:7242:b0:741:7cd6:57d5 with SMTP id ds2-20020a170907724200b007417cd657d5mr7065929ejc.419.1662664563275;
        Thu, 08 Sep 2022 12:16:03 -0700 (PDT)
Received: from [192.168.1.100] (p57ba2cf5.dip0.t-ipconnect.de. [87.186.44.245])
        by smtp.gmail.com with ESMTPSA id b10-20020a056402138a00b0044e81203bebsm8583651edv.31.2022.09.08.12.16.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 12:16:02 -0700 (PDT)
Message-ID: <7df98003-1d55-8993-bcd5-064ac01c9afd@gmail.com>
Date:   Thu, 8 Sep 2022 21:16:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/4] staging: r8188eu: some simple cleanups
Content-Language: en-US
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220908130915.8406-1-straube.linux@gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20220908130915.8406-1-straube.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/22 15:09, Michael Straube wrote:
> This series contains some simple cleanups in different areas of the
> driver.
> 
> Tested on x86_64 with Inter-Tech DMG-02.
> 
> Michael Straube (4):
>    staging: r8188eu: remove unused parameters from
>      _BeaconFunctionEnable()
>    staging: r8188eu: remove unused parameter from UpdateBrateTbl()
>    staging: r8188eu: make two functions static
>    staging: r8188eu: remove unnecessary return labels.
> 
>   drivers/staging/r8188eu/core/rtw_mlme_ext.c   | 42 ++++++++++++++++++-
>   drivers/staging/r8188eu/core/rtw_wlan_util.c  | 40 ------------------
>   drivers/staging/r8188eu/hal/usb_halinit.c     |  5 +--
>   .../staging/r8188eu/include/rtw_mlme_ext.h    |  2 -
>   .../staging/r8188eu/os_dep/osdep_service.c    | 10 ++---
>   5 files changed, 47 insertions(+), 52 deletions(-)
> 

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150
