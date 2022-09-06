Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BAE75AE8B6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 14:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240130AbiIFMse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 08:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239922AbiIFMsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 08:48:31 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD24A57568
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 05:48:28 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id r4so14979455edi.8
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 05:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=sKN+MCCCY1y8F4okwhE51v1IBBv5B5BbAT3q9rc+SkQ=;
        b=pyCYVZ710UBEF04F8p5lnRQ28IKLTdGpoGJrHiZyAleJjH6xfHdT+49W9177nIItH8
         STRQMS7kABB5jsckybxJeiyg0IFBnGbudqcq/U9xSHaXw60+UkWchDR/DlUd27+lXMuy
         XofK/XQUIf4UxWB96iM+Z2a5Avd9dRo7KHYYBuWrMYzhf0GESim40a55BAYTy3IMhr2k
         9pgK9M/VTp8KBxebM7XktbOAno88Heq73kqpBFM3bq6cn7n1DbqQu8jiJ+3XVbeXyS+F
         nDV2TdKb5c7xVdQ9p9vjit3M0reKaJbTgt88G7lkuOXCCI5p5rFKq9eOm6C6Kdby65PV
         Z4RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=sKN+MCCCY1y8F4okwhE51v1IBBv5B5BbAT3q9rc+SkQ=;
        b=f/a+cAZeZGjhsdZRlH4NGGrZGiwiIcOUDMNDXxukYDRSpwyezX/Jee+f58flK6lN9r
         rsqgyto8F+LBEcB62zhqw58oG8IfLATEZfYli+khRmLjXrsm7p0KXulQ2tlw1xRKE3wC
         XMhHrrlSpAFMVLdRHkFmm7SEGC2AKEXsEdfVCWRrQm4sIbth66smB6YfIkXdKBu18PsG
         Yh1C7FH272u5HCrfStrLILbXhSnSzFa7uafWdJYdnvBptaYalCY1J+Y3uOqehYM1J5cV
         HZCbscJOkcT74CYyURx7i7/fZfTf53RxeCiYfFiO3L+iOM954zm/TpmUlZ54UimUiRYa
         h9EQ==
X-Gm-Message-State: ACgBeo19BP6EfIzZCjhMbtHJ2sH2LUEiDhSckNxRHB+w7o9TV5uL/VwJ
        rczQHb4tpP/VDlwYd7NrHl7m06ShVuM=
X-Google-Smtp-Source: AA6agR4ClGHjCw6fkSXvNPQMdz8/3T1qsN9eoPMUwjCiz8tmBBzk/hsY5jxTgMhC/5BIF5QQYjte1A==
X-Received: by 2002:aa7:c90e:0:b0:44e:b410:b1d5 with SMTP id b14-20020aa7c90e000000b0044eb410b1d5mr5028627edt.359.1662468507431;
        Tue, 06 Sep 2022 05:48:27 -0700 (PDT)
Received: from [192.168.0.151] (ip5f5abb8f.dynamic.kabel-deutschland.de. [95.90.187.143])
        by smtp.gmail.com with ESMTPSA id v6-20020a170906b00600b007306a4bc9b4sm6580001ejy.38.2022.09.06.05.48.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Sep 2022 05:48:26 -0700 (PDT)
Message-ID: <3ddb38b0-4526-05ba-0b8c-4acd21824e35@gmail.com>
Date:   Tue, 6 Sep 2022 14:48:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] staging: r8188eu: remove channel parameters from
 rtw_sitesurvey_cmd
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220905195612.81945-1-martin@kaiser.cx>
Content-Language: en-US
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <20220905195612.81945-1-martin@kaiser.cx>
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

On 9/5/22 21:56, Martin Kaiser wrote:
> The rtw_sitesurvey_cmd function may receive an array of channels in the
> ch and ch_num parameters. All of the callers set ch = NULL and ch_num = 0.
> 
> Remove the two parameters from rtw_sitesurvey_cmd and the code to process
> them.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---

Looks good and works on my system.

Tested-by: Michael Straube <straube.linux@gmail.com>
