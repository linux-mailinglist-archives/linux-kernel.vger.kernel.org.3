Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5DE51021D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352488AbiDZPrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352476AbiDZPrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:47:31 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4020A814A1;
        Tue, 26 Apr 2022 08:44:24 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id m14-20020a17090a34ce00b001d5fe250e23so2883523pjf.3;
        Tue, 26 Apr 2022 08:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=YCQ0EI43F2hooz0CpudSoz0g9UCJgP24YhOIE5SHRkM=;
        b=jVULYkxOui/vCWGuPPEhiOmCg9pW9g84igZJoySXdB9igaZdmAkP3X33S5W/feowBk
         axq5dNhkvhUVENMjrz9eltQ0h/RSbr2Ftn5JEyn4Xot8C17x6nuJ4xjZaFKFSjNojgw5
         H5agjGU8SOD8eBBHbnzmNEB+Z3dkHbDdBJEiUECehNshcn7wiOK6BD7uzJL/dzXt5CoK
         5zmItYV3M26zPzi6ZhcEmC4GX1mgzcsyVSkD02ZNSCpovFLsWtxb2SYfxzL+vu8eJJ39
         B1/ia2ngX4wwrh7Zy5ZpeUL5LLV9WWaVD//5LOcWrKMmmkLpzql0Ce6rMTrOFhiedIdd
         K4RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YCQ0EI43F2hooz0CpudSoz0g9UCJgP24YhOIE5SHRkM=;
        b=ZNGFJmsETvcl8jPjrnJtzb9r5rj0n906QmFW0x/sAbfJ9KxBGWUObCH9fZNmt0pXiV
         WWLOXwqwp8zRRz14ESFsYbAVbuy/zMF1ku9nRduYRX4SV1GNZn7Bt9E6D68hvhE1+f94
         k6TSYJ4Dq23yBYGjpYMMFIf5IdW7oE6n/sldI3HezDHShf3nK3TBVWHp+1iWSIdEGNrj
         6xpyq3b6gmT1C69VfDUUi0lwDxV5Wywd7ktwoe953o8m8y3g16b/E6aUsXuSaF3hP9gD
         7DSqXRFZXqdxGZaWyRUbDBb60oDkwvyG6v/DmYGtaCvQZCdMBY7+XDtv1LZWfQLYEVfI
         oGqg==
X-Gm-Message-State: AOAM530aUiABKvSI8fEWFjyT2rNq982tHjPVSvVMXQKZUaAyLncnrr7a
        YVR7CHtz1Y27HKr3U0WMVxE=
X-Google-Smtp-Source: ABdhPJw/7hG08X1DVzF30Zy8eb9AYuT+pvCZKvy9ulWfDngDnNDHeIwoOELHF+2RqWKhS6LsaE7Shw==
X-Received: by 2002:a17:902:bb8d:b0:156:51a1:3f5a with SMTP id m13-20020a170902bb8d00b0015651a13f5amr23911199pls.65.1650987863656;
        Tue, 26 Apr 2022 08:44:23 -0700 (PDT)
Received: from [172.30.1.9] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id l14-20020a17090aec0e00b001d8ace370cbsm3420673pjy.54.2022.04.26.08.44.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 08:44:23 -0700 (PDT)
Message-ID: <2b13d915-263f-4d3f-ea35-4cb0e937bb33@gmail.com>
Date:   Wed, 27 Apr 2022 00:44:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v5 1/5] extcon: sm5502: Clarify SM5703's i2c device ID
Content-Language: en-US
To:     Markuss Broks <markuss.broks@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        devicetree@vger.kernel.org
References: <20220423085319.483524-1-markuss.broks@gmail.com>
 <20220423085319.483524-2-markuss.broks@gmail.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <20220423085319.483524-2-markuss.broks@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22. 4. 23. 17:53, Markuss Broks wrote:
> While SM5502 and SM5504 are purely micro USB switching
> circuits, SM5703 is a multi-function device which has multiple
> modules in it. Change the i2c_device_id of it to avoid conflict
> with MFD driver.
> 
> Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
> ---
>   drivers/extcon/extcon-sm5502.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/extcon/extcon-sm5502.c b/drivers/extcon/extcon-sm5502.c
> index 17a40c3782ee..f706f5288257 100644
> --- a/drivers/extcon/extcon-sm5502.c
> +++ b/drivers/extcon/extcon-sm5502.c
> @@ -831,7 +831,7 @@ static SIMPLE_DEV_PM_OPS(sm5502_muic_pm_ops,
>   static const struct i2c_device_id sm5502_i2c_id[] = {
>   	{ "sm5502", (kernel_ulong_t)&sm5502_data },
>   	{ "sm5504", (kernel_ulong_t)&sm5504_data },
> -	{ "sm5703", (kernel_ulong_t)&sm5502_data },
> +	{ "sm5703-muic", (kernel_ulong_t)&sm5502_data },
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(i2c, sm5502_i2c_id);

Applied it because this patch depends on already merged patch
on extcon-next branch.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
