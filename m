Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14868514579
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 11:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356655AbiD2Jhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 05:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233639AbiD2Jhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 05:37:43 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D9DC614D
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 02:34:25 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id bi24-20020a05600c3d9800b00393ff664705so4410149wmb.4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 02:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=h0yrV2ajUc4rzaoxaQXdr/H66fDaJUn1O4DJRX2MRlk=;
        b=Z5bSwm9xVeqJTkHi/E+zDFhz0AAL5h9UOf3cJMQzYZw98qSwZBvQMrnZ1+aybXB08y
         y6LX9cALR4JoZWfBIU2pMENjClVGnEuM35Z/IvM2wY/Ky9cAa8eKF3Umv6fCedUY88zx
         fDonFxm6E5R2aJXFcv9Gat0A2f/vlknUCeo3u+KluYqCpFCZ/xw+ajKL9/n0LTevLl8R
         Zb024uyrXCAyS7EgzZYbh2d34zc51Z/sevHpwrODI4dxDmEfQoqCsYAZPnivLOwonwTB
         Fu3n3fRJYNBlz3CKvB0B9Ln6bwXc/UteSwNiwJMCgKZ3rEMbO7H879uAMS+VOeU+0RBJ
         ZWWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=h0yrV2ajUc4rzaoxaQXdr/H66fDaJUn1O4DJRX2MRlk=;
        b=3We2QrzxstDSpIichNPBir6f+sJnwkgyLqyf/mZKxuVgjlpoAup1htxfIMq0nm2WQb
         J0fPtpY1ek0KMDmvpebGp/SYi4gKdYyr0qrb97m1vAyvWK6cFnwD9W5BJBpDsIkTDWo5
         +SOVwJK3b7duL0QLUxmTyrnpzl1TcOuRFP80wJbaUtmK84Zu58pgXfGRJiUWzYcSYpqv
         9+9GGK4DlOAvGZnPWN/vPsnGDVnYzzku++K4zNHtKQrvej+DzIztvvCrdIKUoT0UbFnT
         I0Zaf4grcDhtrMoFxGrC8LOqb789zbCq2m2ohvSjLW+XrbD48XwU1HkxqWi6d7ZUNdj6
         e/SA==
X-Gm-Message-State: AOAM5311fYsUsibbrjMhgHH2iVxQfeFzUtTgUFpdyzE7DoBq5KqbFzjR
        BbAdiQIHHc/ibncUC4/cDarblw==
X-Google-Smtp-Source: ABdhPJzmcD4ri76iXLdyQmRdRY+9aWEyMv1yNpq83rWd+E7spwx5/0JbkXiBuegBm4jKapBf2qF+JQ==
X-Received: by 2002:a1c:c912:0:b0:37b:e074:dfcb with SMTP id f18-20020a1cc912000000b0037be074dfcbmr2287180wmb.161.1651224864103;
        Fri, 29 Apr 2022 02:34:24 -0700 (PDT)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id m41-20020a05600c3b2900b00393e6f6c130sm2258555wms.42.2022.04.29.02.34.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 02:34:23 -0700 (PDT)
Message-ID: <917b4cc2-4bb0-d123-006b-ffec2226b79a@linaro.org>
Date:   Fri, 29 Apr 2022 10:34:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] nvmem: change sp_otp_v0 from global to static
Content-Language: en-US
To:     Tom Rix <trix@redhat.com>, vincent.sunplus@gmail.com
Cc:     linux-kernel@vger.kernel.org
References: <20220403133906.1379832-1-trix@redhat.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20220403133906.1379832-1-trix@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/04/2022 14:39, Tom Rix wrote:
> Smatch reports this issue
> sunplus-ocotp.c:74:29: warning: symbol 'sp_otp_v0'
>    was not declared. Should it be static?
> 
> sp_otp_v0 is only used in sunplus-ocotp.c.  File
> scope variables used only in one file should
> be static. Change sp_otp_v0's storage-class-specifier
> from global to static.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---

There is already a patch for this in next.


--srini
>   drivers/nvmem/sunplus-ocotp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvmem/sunplus-ocotp.c b/drivers/nvmem/sunplus-ocotp.c
> index 2dc59c22eb55..e0b11e13f5f8 100644
> --- a/drivers/nvmem/sunplus-ocotp.c
> +++ b/drivers/nvmem/sunplus-ocotp.c
> @@ -71,7 +71,7 @@ struct sp_ocotp_data {
>   	int size;
>   };
>   
> -const struct sp_ocotp_data  sp_otp_v0 = {
> +static const struct sp_ocotp_data  sp_otp_v0 = {
>   	.size = QAC628_OTP_SIZE,
>   };
>   
