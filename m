Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A20B558A1EF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 22:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239761AbiHDU0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 16:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233368AbiHDU0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 16:26:43 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC261704C
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 13:26:42 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id i14so1329140ejg.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 13:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=gcpgRFm5vs+rWDh+VychUN2x/2sAeZ2CGnsyB4UULJc=;
        b=U+0+6h8r128HlTmUDQKULCIe7qAmbEWPanQmIrXi5N5AgdgxB6E53mTzNW8+LiTNtK
         vqtsohxdorLfeMTsSQ1rt0Oj0/jtS/+ZbFc0kOazgBgl98+GPTXVP8JJW4OfQqDOzLWI
         fwpuRgM7WggNA6TnZLCWhFsHA6s3+5Gt3FcpviGfa5l2PUFtju4sH0eE0LCCjbKaQwS2
         bMvLN28ZcZa9/T12bAKWV+pGpPWVKgGYaanp+adVRtrJ1cXmsA7vkfnB4Ybnbczy7XYz
         5Dz+hRaUZ/D9jmy1kEYU+cAJTn5rOC3szgO+Kvg+hX1lPuxZ/nmT8tBceE2/GtG1cdBK
         8+8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=gcpgRFm5vs+rWDh+VychUN2x/2sAeZ2CGnsyB4UULJc=;
        b=cjsIcKFBuDa6HMhkDTAEmOtj8qkz5JJTS38f5bUtaifDJW2unCsGyvb7DjxtftgSUu
         RYq8t2DW6+qs3himYO+tsKnGHAfw2mRQGZS+Y1oAWCEo1HyQX6S9ohuSFk1ZQcCWHY0r
         4RZVmSzOd//alQF87HP/U8VXwOKrX60UAIMghx3NCu4kFgNbwgkroJqRMvmYwLWcGYXG
         hW/BBGkxdW1co3gjbJ/J0ezLBQDcNbuBR2wGQJHn01JneUblxUfpp7ZyoS9bhVYsjf1y
         /OPn8ExHfFtuMPD3jMOY1YHIOzUdxdPinNORvFRINcjDnnAEisTKRFGK23lJi7WQqhYJ
         hF+Q==
X-Gm-Message-State: ACgBeo3BBHp5JeF/ZYrSK8lbUVcdOo8Vj7YNtlkMTIm2wg6scx/k5YWD
        RM0ZCZNh2TEI593PqeXNyjE=
X-Google-Smtp-Source: AA6agR7c6h38sC+j142B8oImCPvDh7SJghL+4wS2cJ1aoK0xIA7Qb6Wu8Ut3ixQ1Xdmk4/bevqSRnQ==
X-Received: by 2002:a17:907:6d04:b0:72e:e204:a70b with SMTP id sa4-20020a1709076d0400b0072ee204a70bmr2657688ejc.432.1659644801394;
        Thu, 04 Aug 2022 13:26:41 -0700 (PDT)
Received: from [192.168.1.103] (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id z7-20020a50cd07000000b0043bea0a48d0sm1122480edi.22.2022.08.04.13.26.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 13:26:41 -0700 (PDT)
Message-ID: <99ee7f1d-62fa-a873-403a-445d8d8b096a@gmail.com>
Date:   Thu, 4 Aug 2022 22:26:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] staging: r8188eu: convert rtw_p2p_enable to correct error
 code semantics
Content-Language: en-US
To:     Phillip Potter <phil@philpotter.co.uk>, gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, paskripkin@gmail.com,
        straube.linux@gmail.com, martin@kaiser.cx, abdun.nihaal@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220802234408.930-1-phil@philpotter.co.uk>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20220802234408.930-1-phil@philpotter.co.uk>
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

On 8/3/22 01:44, Phillip Potter wrote:
> Convert the rtw_p2p_enable function to use correct error code semantics
> rather than _SUCCESS/_FAIL, and also make sure we allow these to be
> passed through properly in the one caller where we actually check the
> code, rtw_wext_p2p_enable.
> 
> This change moves these functions to a clearer 'return 0;' style at the
> end of the function, and in the case of errors now returns ret instead
> of jumping to the end of the function, so that these can still be passed
> through but without using a goto to jump to a single return statement at
> the end which is less clear.
> 
> This change moves the driver slowly closer to using standard error code
> semantics everywhere.
> 
> Signed-off-by: Phillip Potter<phil@philpotter.co.uk>
> ---
>   drivers/staging/r8188eu/core/rtw_p2p.c       | 19 ++++++++-----------
>   drivers/staging/r8188eu/os_dep/ioctl_linux.c | 12 +++++-------
>   2 files changed, 13 insertions(+), 18 deletions(-)


Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150
