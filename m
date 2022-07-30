Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEE1D585BC9
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 21:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235526AbiG3Tf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 15:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233791AbiG3Tf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 15:35:57 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2950DBC34
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 12:35:56 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id uj29so635700ejc.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 12:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=znMiuLtPPIpLgWBCzArU4bLlFvXoiSKJfPgx/vuRq3Y=;
        b=oGiQ19fmM36ySn6hnM/Kc3RBnM+VyBrBGURWcFUC3e1Xcky6/UxMxltKXyYK0QMHXC
         DpxfY7NiRu9fFBkBtPmNB7qZkY9Yk2jDIIn96P9B4dhdZdXQzAuUMze6NlDfr9G1YNxE
         ZbOFT8jStPcPqiENo1YFx9V+DwiqSoxz+tyLs4wahUCFaNhCI2hp+yCUzKccQzPc18Se
         EYNL7DF2X1D4WCjLmraOcP0Z9sAZqus1fMWlzHcsmmnwIMURpkVXSvCwqSvCrCVZc66a
         NuddmHClYUlKLWRZW2k11Not7djZIpEBmSkPjPWeN9fjDwHXtNFtnns+y7Q6Dls4cHm+
         tBUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=znMiuLtPPIpLgWBCzArU4bLlFvXoiSKJfPgx/vuRq3Y=;
        b=lW1SmLwj+5AzNrESGTElBn90Ms4HBIVl1h17b5bqbVbklXHzCBehZQIbvGZmEpS8+o
         lLILi7GbPrRYOJVsA5PpF0V1K57sAENKwG7u2v868SZO733IeKuVGIKtxQbfAsjgCAuq
         cZ9RCZ6lwL1/p1wMaA+JMTkGYkTyDPs5ULm0exqYu20I7QFbKek8b7WzRiiYBZBi7iYp
         UbPbUU3NfN84HRu8awAZSQkyqcxxd5CKHVTFz5MxTvUZWpSvOcqtKugymL5UvCph731M
         gbXrtewTlG5ZNt3sbtUAokzxONQuLi4UCPI6rQFJWaOyWXFOTyKxkEgfB4movwo+7kVA
         FbEQ==
X-Gm-Message-State: AJIora/pnlSG+H0vyhWz6atd+Ba/7ozso2WtAWrF5YvZy6AMvTsG61UY
        rLEnF9VzUrv5Ci0Nva5AKpE=
X-Google-Smtp-Source: AGRyM1uHP719Ybc+4zG0bI975OB3+ZffJMtmMa47CoQveZhyDa8+b+XFiSDi+Jk35PLiRXZriKNiRQ==
X-Received: by 2002:a17:906:ef8b:b0:72b:45a2:2232 with SMTP id ze11-20020a170906ef8b00b0072b45a22232mr6947078ejb.484.1659209754774;
        Sat, 30 Jul 2022 12:35:54 -0700 (PDT)
Received: from [192.168.1.102] (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id e6-20020aa7d7c6000000b0043a61f6c389sm4265368eds.4.2022.07.30.12.35.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Jul 2022 12:35:54 -0700 (PDT)
Message-ID: <749e2a31-cde9-ef80-f290-3a7a36c92636@gmail.com>
Date:   Sat, 30 Jul 2022 21:35:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/3] staging: r8188eu: report errors from
 ReadAdapterInfo8188EU
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220730143939.671951-1-martin@kaiser.cx>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20220730143939.671951-1-martin@kaiser.cx>
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

On 7/30/22 16:39, Martin Kaiser wrote:
> Update the ReadAdapterInfo8188EU to return an error code. Change the
> calling function to relay these errors to the driver's probe function.
> 
> Martin Kaiser (3):
>    staging: r8188eu: handle errors from ReadAdapterInfo8188EU
>    staging: r8188eu: make rtw_handle_dualmac a void function
>    staging: r8188eu: return an error code in rtw_usb_if1_init
> 
>   drivers/staging/r8188eu/core/rtw_wlan_util.c |  5 +-
>   drivers/staging/r8188eu/hal/usb_halinit.c    |  7 +--
>   drivers/staging/r8188eu/include/drv_types.h  |  2 +-
>   drivers/staging/r8188eu/include/hal_intf.h   |  2 +-
>   drivers/staging/r8188eu/os_dep/usb_intf.c    | 49 +++++++++++---------
>   5 files changed, 33 insertions(+), 32 deletions(-)
> 

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150
