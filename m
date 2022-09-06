Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E335AE931
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 15:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240384AbiIFNOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 09:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233870AbiIFNOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 09:14:06 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 621B36DFB0
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 06:13:56 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id kk26so23127035ejc.11
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 06:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=jrvWfBsi80xl3fi7CChz3RymCRuWomD19UUNJ4pyqyk=;
        b=mtxOpioeHaKN9D7OtPjto93HBgDJFU0Z1Ntc5myMNA9MU97o8fIdhjsKnHV+shngBS
         uoOFpxViSbOVaCX32M9DJPTdlnaROyMCBIURemMcF97CN8G1ZVLIk/0/qIWiNkr3hop/
         liTXx4FVObzC6jkjKDVnldgjJs4ocuzOTrK/D3DIUapSRSvlSQmBRTrbJzVcrI3+H7m7
         2NvaHjmjaICEVmAnbnGQljPV/iXJHjKpDX/9K3txchcqf276a5xFP6pZqE0eb1js2aOb
         4U8MTgiF6/LNfsSkZbZbA4XITdYyO8lVw1+j6gbQ3Glc4Xjc4IUVf4iwRdoCPSgjNZD4
         6xHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=jrvWfBsi80xl3fi7CChz3RymCRuWomD19UUNJ4pyqyk=;
        b=nYi0hnRXYu5s2wpc9/RrUqIkX+4ORTGLKzpndtYbKU5xxwkYFAIc8W22pBsmOan6Ku
         L1PibsWym2Y/fpkynlCilpinuAe8efKgpLcylSN9oonKt27AlBtGKMPl6XCSZRsMMGjh
         Hwk0DE7m0gkSQ0vbfs6uCYiJzVrRNG53QAjMqpgB0nQY6qC6fCHXeJ72JxIlYgBrXn3H
         fMPkOmyaSwC9GAtXzhQbEd1PMXj5jr2v6gSsFVCMSYEOQvSso5oUP3+7iQYj7Rc0F9j7
         Xr6ssRxfX9ZLo3kfayKpeaDbQRxxJ2F7d2s1axbZ3sQhDIf7ACtVMt8aMbrSjpwRremQ
         Lyaw==
X-Gm-Message-State: ACgBeo23IthqSiE5PN6kQT24zBQta7j36elimN5DmGGVuMmm9WsyqoYB
        0LltU4vo6VD+oVXaRIu2NtyHQ2DicvQ=
X-Google-Smtp-Source: AA6agR6HvJGRAyGYGt9UbbAqsJv7U3Qc1sCBQSTnox5v96fXfiNJOKI/kB4HBNwfOx9WPHdaCziQBQ==
X-Received: by 2002:a17:907:7d8c:b0:731:65f6:1f28 with SMTP id oz12-20020a1709077d8c00b0073165f61f28mr37400431ejc.91.1662470034930;
        Tue, 06 Sep 2022 06:13:54 -0700 (PDT)
Received: from [192.168.0.151] (ip5f5abb8f.dynamic.kabel-deutschland.de. [95.90.187.143])
        by smtp.gmail.com with ESMTPSA id j2-20020a17090623e200b0073dbc35a0desm6665081ejg.100.2022.09.06.06.13.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Sep 2022 06:13:54 -0700 (PDT)
Message-ID: <010c2294-ded0-fff0-5b19-e3e89c66d84d@gmail.com>
Date:   Tue, 6 Sep 2022 15:13:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 0/7] staging: r8188eu: continue rtw_led_control cleanup
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220905200146.82259-1-martin@kaiser.cx>
Content-Language: en-US
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <20220905200146.82259-1-martin@kaiser.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/22 22:01, Martin Kaiser wrote:
> Here's some more small patches to make rtw_led_control simpler.
> 
> Martin Kaiser (7):
>    staging: r8188eu: simplify the LED_CTL_POWER_OFF case
>    staging: r8188eu: don't restart WPS blinking unnecessarily
>    staging: r8188eu: always cancel blink_work before WPS blinking
>    staging: r8188eu: always update status before WPS blinking
>    staging: r8188eu: always cancel blink_work when WPS failed
>    staging: r8188eu: reset blink state when WPS fails
>    staging: r8188eu: do not "scan blink" if we have a link
> 
>   drivers/staging/r8188eu/core/rtw_led.c | 80 +++++++++-----------------
>   1 file changed, 28 insertions(+), 52 deletions(-)
> 

For all patches:

Tested-by: Michael Straube <straube.linux@gmail.com>
