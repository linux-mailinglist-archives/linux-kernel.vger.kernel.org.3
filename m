Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D7457F677
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 20:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbiGXScW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 14:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiGXScU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 14:32:20 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5964CDF72
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 11:32:19 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id mf4so16873723ejc.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 11:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=kHwnjAd0klMJ7kiJVlb73ix9dRQwry5Ws8qHCsAzQEA=;
        b=AJCcai+xAj8I+OdNokcMBzxTPjfTL5NUi0E2fpfQpDrzLwBp1Rm9baBuWZ67TboZjI
         sO+lq3VLI0Nnxg/5lt9EliJnSxdANZO+mu1UQFSnjgUz2Ck4T9pXZ6WBOTO994/ASQi9
         eldHV1Su1xg1GkM8pRr0za3TMiWaC6Ikg3f49urXnxqs+D0Pm+hmaO7OeLX+QftEwwVl
         ynYcmPNnKuCDfEArApN9fbhpzrzhp4YZ//2Xl7pGKQ0bkt64JV5Ez7fML9y4U5uCwQAl
         sxkOiFSuWFr5HY7NHMzcBsLoErxYePAUlxA2/Q216IkXFZBOHFcmmjQfqXbrtqvq7mw1
         LASQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kHwnjAd0klMJ7kiJVlb73ix9dRQwry5Ws8qHCsAzQEA=;
        b=XPfYYM6569rFZfscNionsv3jMYz4bnNL1CFoB7ifCt/SPMW01NSWJk5aEt1Xg6lrRz
         epfzFtr3O0pEA5BLdSFsXRwMZ2mH+I53N71kBqUCfOmu235PhcgRPnZ1sTD5x8gaoUEm
         GgssF7mjZpSrTLC3vCFR4dZHzRTuYxriEsRaraREASKvZ/JKlE+15wAT4fel64/k2BkJ
         eJCnpnXzMmLVOylJqnhciNmxmS0fw6xpFhVNJIWAqFDsko9ELBv2voOFqshVa1EgAEaq
         xfcejN/CkaBDPdnEQbdC/l9pKOBI2w0lORit7Dn2RNePxo+5fsAUuB5wxHmk407/4ORj
         F9BA==
X-Gm-Message-State: AJIora9r51Giv8tHN5KmH6pRyBMr08+y7fwgfdCAZeObi1FkFYDyZVBe
        iU5J1dVD5QsKFOGVychIDSQ=
X-Google-Smtp-Source: AGRyM1szw1eNn1oiMpE8989ROVwM/cDN8FXihbTs0Dxtdn6xg8Md1+CVEVCNfrCe2L1d2glx/up2Bw==
X-Received: by 2002:a17:906:cc11:b0:72b:458e:5d45 with SMTP id ml17-20020a170906cc1100b0072b458e5d45mr7210187ejb.589.1658687537956;
        Sun, 24 Jul 2022 11:32:17 -0700 (PDT)
Received: from [192.168.1.100] (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id lb5-20020a170907784500b0072f2e409575sm4400145ejc.98.2022.07.24.11.32.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Jul 2022 11:32:17 -0700 (PDT)
Message-ID: <5972ceac-5f68-85af-bbe0-e640a6a64149@gmail.com>
Date:   Sun, 24 Jul 2022 20:32:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/5] staging: r8188eu: use struct ieee80211_mgmt in
 OnAssocRsp
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220724153917.138848-1-martin@kaiser.cx>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20220724153917.138848-1-martin@kaiser.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/24/22 17:39, Martin Kaiser wrote:
> Use a struct ieee80211_mgmt in OnAssocRsp to read elements of the
> association response message.
> 
> Martin Kaiser (5):
>    staging: r8188eu: get da from ieee80211_mgmt
>    staging: r8188eu: read status_code from struct ieee80211_mgmt
>    staging: r8188eu: read capability info from struct ieee80211_mgmt
>    staging: r8188eu: read aid from struct ieee80211_mgmt
>    staging: r8188eu: use offsetof for ie start offset
> 
>   drivers/staging/r8188eu/core/rtw_mlme_ext.c | 16 ++++++----------
>   1 file changed, 6 insertions(+), 10 deletions(-)
> 

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150
