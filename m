Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F6D4CC2C1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 17:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235033AbiCCQ3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 11:29:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235029AbiCCQ3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 11:29:37 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87978F7472
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 08:28:39 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id u1so8639658wrg.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 08:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=e9uAigxs46BqjYn/NnAb73WG4q/CVGltu1N4Y/zwCMs=;
        b=Vcev2SFIz15CNPNz6TgieU6hpUaPUyb2MiXTR9yTHY32sCp/JeqnNvir2PknyHnDzI
         jJwtHbgTSNp/z0wchPmANaZIrlJdoKv7kQz1OJbLNbX1F0ARrRKmj6RsJBckurzoETnv
         A8CYJP4srXFo+uv8g+fTSD8j6J0/8NSkTADCX2Ds0k6d+yQqZr96K40JIK4uIYUuUUsH
         BOAvBEaqJyAQvG3LObSDzHoHEUYtNzGIERv9dbDQLHMN3jskOFXkehgBlp89UmXhWQk7
         zgzZhKL0CetqGCoRuobLTnyqYqIe2UA59mgDFLo6Vgv+i/qv6fZ7D4iarndZpeFBLXQp
         YSZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=e9uAigxs46BqjYn/NnAb73WG4q/CVGltu1N4Y/zwCMs=;
        b=ofsXWSgkaPuy/Njt3b4ANrcCOwJ6eEJNUQQbKviSB53t0lhNTs0tVeNgxXsZ6JwgWA
         2fVS+eGlVqOIzGVc81vW+/JhcBQjJhzPw3cLxeZNX46EGaXRE2okVftf1rySIUqQpNzq
         /nlxP2Mkohyi9nRTTMx+PWzcsUF6m2K9EemBJQfFLFMuuRTUXQO/5CfCvWKFoZscLswE
         aypOFgTN9ygi8d+c9sAY9fHJ4BVgShNnBxs7UzUu6JPhRQZloEeNUmdGRM1qAw6sTgkl
         NrqvPfY1EwBrtunJlV7v5Ykrhx9g4gUnlfXqADXo828q6wCAqORriEA37KJGc6QslkDw
         m7OQ==
X-Gm-Message-State: AOAM5308aDM/QbmR1Z/eHTDLXsWTBuRAlOORfl9Bx7nwRNq1LweBFesX
        7YHhg2QHuQOV+VURovlNfmyV/hgF5WEBgw==
X-Google-Smtp-Source: ABdhPJw+68OTesX5GBgIs6OHFuXgq005qYLbStO1qwh6vFVRL4WvvzUZwrz7pgV1BM2p92GZLjvDSg==
X-Received: by 2002:adf:f5c3:0:b0:1f0:4b6e:b7e7 with SMTP id k3-20020adff5c3000000b001f04b6eb7e7mr3513863wrp.287.1646324918134;
        Thu, 03 Mar 2022 08:28:38 -0800 (PST)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id r1-20020a5d4941000000b001ed89dcacbbsm2419346wrs.23.2022.03.03.08.28.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 08:28:37 -0800 (PST)
Message-ID: <cef16c0a-c0a8-3ed2-c35b-09fda2068073@linaro.org>
Date:   Thu, 3 Mar 2022 16:28:36 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] soundwire: qcom: fix build failures if CONFIG_PM=n
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        quic_srivasam@quicinc.com,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <20220303110321.23666-1-srinivas.kandagatla@linaro.org>
 <YiDlBevX3/BrXmwb@matsya>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <YiDlBevX3/BrXmwb@matsya>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/03/2022 15:55, Vinod Koul wrote:
> On 03-03-22, 11:03, Srinivas Kandagatla wrote:
>> Fix below build failure
>> drivers/soundwire/qcom.c:1460:12: error: 'swrm_runtime_resume' defined
>> but not used [-Werror=unused-function]
>> by marking the resume swrm_runtime_resume() with  __maybe_unused attribute.
> 
> A patch title should reflect the change and not the cause. So i have
> taken liberty to fix it as:
> 
> soundwire: qcom: use __maybe_unused for swrm_runtime_resume()
>   
> swrm_runtime_resume() would not be defined when CONFIG_PM=n
>   
> This causes below build failure
> drivers/soundwire/qcom.c:1460:12: error: 'swrm_runtime_resume' defined
> but not used [-Werror=unused-function]
>   
> Mark the resume swrm_runtime_resume() with  __maybe_unused attribute.
> 
> With this i have applied

Thanks Vinod,

--srini
> 
