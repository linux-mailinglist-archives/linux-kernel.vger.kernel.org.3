Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 366AB5677E6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 21:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiGETgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 15:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbiGETgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 15:36:41 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37BE8193C1
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 12:36:40 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id m16so1103354edb.11
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 12:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=M/BtDHk5812Fsbsd6YvmUhNGguiw7DdnJo+yT+T1deo=;
        b=bSzifshel3jbS0Mp9ZVzsudk2NvNDJvVYOG7JndQ3Cpiz5OIEKGw1PgVgkUJGNhVh9
         3+fspIZqSMNFCBbP9R9J3+OyADyUcxZxjx1nd+/DLMonjkYYsmxG4+spT4Z26JkWtZ1S
         V4dsWBIbftjMJ1LsBn72iSOVVfQFhKwvXlHKIUpRTXUeTydNu4/Fs4H9IF/Zo7Bspfaq
         2vArJ57RCSB//LVElMTJCg0tmRGE1UNmw986lSVBVijc6XbwclEGF8ZR0uxJ7p105kvu
         E2jIA2b6KP5qqpQyKw/ZYivg9Xec0QCm8a50LFWaUIxMlpKM7G1kKHY0bq1QG2EQ2577
         Bd8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=M/BtDHk5812Fsbsd6YvmUhNGguiw7DdnJo+yT+T1deo=;
        b=5n+n7K3TN63osvXtXNZDI/LyPh4ugEbdQzSiZBHk6FMMIc+MDzKM61Df9fGf039Xk+
         BBZCH4zxNIkP+xifMSBrzYRPnaRwhlLFk/YBtv3kFM4OEWufDz1wdwdgu4vXeYDa+U3N
         UHNTwRydc7pd4GMyrzVdyPkIcKj05gIi0QdxTN3s4R127haNOgsbhb7Voe2TLiX13zJJ
         JLLKRWNJspjCo4g/O6fFRliU9FYvx7yjHCtAJf6fdpL5+PyXeTfq4N+bxOHERE8AQ2dX
         QGEk8uxfmykkdST3RQm9oxNl59jN13PLw7egrEFLlg9fG2/KGpevv8z+iX4KvdF07E0p
         2k2Q==
X-Gm-Message-State: AJIora//8D8COsfYBqX2KyFEv2Pig7D8DqNl6EARchvbOLw3mfRGbfoh
        biqsB8Qle3tpRGaMoCXJmTk=
X-Google-Smtp-Source: AGRyM1sqnHZ0S+f06LG1LJTTd2Oa56TCdcEk7NPGxY7hw40tPKhr4tob1Y2PwvvIrYus606VFD+RtA==
X-Received: by 2002:aa7:c683:0:b0:43a:13fe:9c69 with SMTP id n3-20020aa7c683000000b0043a13fe9c69mr22883942edq.353.1657049798848;
        Tue, 05 Jul 2022 12:36:38 -0700 (PDT)
Received: from [192.168.1.100] (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id w2-20020a50fa82000000b0043a64eee322sm4825875edr.28.2022.07.05.12.36.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jul 2022 12:36:38 -0700 (PDT)
Message-ID: <7612d07c-9e10-f8dc-3db8-cae179dd8b89@gmail.com>
Date:   Tue, 5 Jul 2022 21:36:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 0/6] staging: r8188eu: clean up ap2sta_data_frame
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220704201654.195574-1-martin@kaiser.cx>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20220704201654.195574-1-martin@kaiser.cx>
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

On 7/4/22 22:16, Martin Kaiser wrote:
> Start cleaning up ap2sta_data_frame. Remove duplicate assignments, use an
> ieee80211 helper in one place.
> 
> Martin Kaiser (6):
>    staging: r8188eu: set bssid only once
>    staging: r8188eu: don't set pattrib->dst again
>    staging: r8188eu: don't set pattrib->ra again
>    staging: r8188eu: don't set pattrib->ta again
>    staging: r8188eu: remove a misleading comment
>    staging: r8188eu: use ieee80211 helper to check for nullfunc frame
> 
>   drivers/staging/r8188eu/core/rtw_recv.c | 13 +++----------
>   1 file changed, 3 insertions(+), 10 deletions(-)
> 

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150
