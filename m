Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34214C0125
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 19:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234950AbiBVSWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 13:22:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbiBVSWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 13:22:32 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A06B12C1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 10:22:06 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id j17so8349848wrc.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 10:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Lm5xUR/DeoScu2Jz9y/NvEglJoydN1Dlz6DnerF6En8=;
        b=Yr9Z9CouG7VqoWDydXm+zhbtMlkL21HITJFGmTwDaPEgKUvKCLoha8r0A1rln5zOZn
         ionS4p/SU9TGBy6kIe+2Z50ucKF6FzTr0yriehY8GgIE3CMyvxqVp6QtNcweT3HJTVP7
         9zn63dQLX02VQud1Wxlp8NfflxCb7a3g05/geTnxASCZJ7BR5p2Y+ros3Lo5gX5u8P5O
         BAywmOnDn/N9jVi22FFJCYlYBfsUyIqDRk217CUBVCaYHtqOcIaMMO5Aodf4PsAxMYcb
         rHWt53MiULJrFWH0w5peIGcrPlycKHFIPaHhBvtywNEfUpNZvp5aAMmPi4elfJuL1Eug
         PptQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Lm5xUR/DeoScu2Jz9y/NvEglJoydN1Dlz6DnerF6En8=;
        b=u4CiyVi4MhMWJtYS0EQzPfWxboH+92LINx8oVRWUOSqufuHTKB0vLZ670z2HhtC/O5
         g4CdX0gq+3N7aMXMmTBmEIi5KClHFoeoSltCEJoI27M8fALXhyE77FUfrlAXaQGTzmce
         IfaOdLd4TmX4/xfcsNzlOx6QOfVlmDPpGclPZRHOooMtmr2xVusw/NXw2kaA7pcQ8y3p
         66Zcb7Zt+uCRniMCuSn9plDh1qkirdRkKCikVVG9bxSh+t6T42wejUhdZwQjZZKE8+wG
         NRCMSzE9q6WGHWpfcNy8A9UNqxbyiXYxpqjNnMPMM/LFP0bi4Mn8gsfyFSBYAzgkH26N
         fXAQ==
X-Gm-Message-State: AOAM533yZ0AfmAVO3kDON0TnFk3OccEdrtEJLlPudZChn9AoCnm4fp+V
        sMkFODteRu4sOElI8ejykqw2hQ==
X-Google-Smtp-Source: ABdhPJyvMCX00Qpb+LFRV2vRfzwlImSa39Q4EaeongsPm28O8Tsy9ZtLaMMPxWuPyHnkrkNmWz2mtA==
X-Received: by 2002:a5d:6d0d:0:b0:1e8:7b6a:38e7 with SMTP id e13-20020a5d6d0d000000b001e87b6a38e7mr20802901wrq.625.1645554125317;
        Tue, 22 Feb 2022 10:22:05 -0800 (PST)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id f10-20020a05600c154a00b0037bbbc15ca7sm4790779wmg.36.2022.02.22.10.22.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 10:22:04 -0800 (PST)
Message-ID: <246dce08-b8c7-4c96-9dd9-0c3246d007ed@linaro.org>
Date:   Tue, 22 Feb 2022 18:22:02 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 09/16] ASoC: codecs: wcd934x: fix return value of
 wcd934x_rx_hph_mode_put
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com
References: <20220222115933.9114-1-srinivas.kandagatla@linaro.org>
 <20220222115933.9114-10-srinivas.kandagatla@linaro.org>
 <YhUjW6B8LmoEWLRx@sirena.org.uk>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <YhUjW6B8LmoEWLRx@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/02/2022 17:54, Mark Brown wrote:
> On Tue, Feb 22, 2022 at 11:59:26AM +0000, Srinivas Kandagatla wrote:
>> wcd934x_rx_hph_mode_put currently returns zero eventhough it changes the value.
>> Fix this, so that change notifications are sent correctly.
> 
>> -	return 0;
>> +	return 1;
> 
> This now has the opposite issue where it will unconditionally flag a
> change even if none occurred, that's less bad but still an issue.  It
> should check to see if the value written is different to that already
> set and report that.
Thanks for spotting this, Yes, that is another issue, Will fix those in 
next spin.

--srini
