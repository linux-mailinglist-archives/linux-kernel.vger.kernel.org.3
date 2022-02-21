Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 442FB4BDD62
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354324AbiBUP1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 10:27:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344601AbiBUP1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 10:27:46 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4EDB13CCE
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 07:27:22 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id d27so27737841wrc.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 07:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=nv0eH0e7g8WkSmFjX1RSL2aoVO4qfLGoWioqkn/s04Q=;
        b=SzS1kQVd6eOQ9thb7s9wnyOfj+bo8Cb2YS9H0qwQdPX3eig4P5HbhTJXadTFfDrSnc
         rIw83tT/y9NpvKfF8HkB6sK4JmCyfx6o7kATb07icgBJgg5YnzJXcwD+R2LSG9BSTWfw
         Zup8VT41n/kkT1p7TjAEb+/S1tmSbCThdsixos3JQzV1o+gGpTOTU3SVQ2HEkvp7aPGa
         VkOtxTLPiPu0eZwVigSaHuBWUkOyXTIByg8gzvyROYxOBSlWeQvSSMYXJQwIGTuzcd3M
         M35d6FXlR7GyaX+0JM2VsQ5PQ5f9wvWoba5QIwADbVBlknqbjKYeL+v/xn81WxQDorWc
         6dAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nv0eH0e7g8WkSmFjX1RSL2aoVO4qfLGoWioqkn/s04Q=;
        b=jH1he1oXOMUh4Bpj/5a/ex3qQ0Q6huVXwq5BmnhWYKI3xjgvAx0pOZL1vryHBai9nO
         D8Os5ewdMpXN3GXBlvOK+1GXWuRdYlqRdGrDk+4kuP+6WXtugoKbKve3/BTc+bxyI3Jk
         n2zXKCke6wMVZkNBaW3FSaF0jNHbZmBXRZlx2E4MQ6C2RtGk83FTmtxUkSKVfr/Mm6rf
         GE+qTd1OT3hT/xHfIQn5hS/IyWPV99KcxRfsg2QjAWaxGBiwE9FksYH2JMSvHnEo9Z1r
         D3xZ6cYL4CQ5uQSdrjgy2JRSTvIIyBb5rfOmhGXK67Y8wfEC5Bo97H6OsRbapx/Dbd94
         9dfA==
X-Gm-Message-State: AOAM532xmXpUuEI+5TiTLtgtRJqYv/83S47ky77egccjK3u4JE1fePg8
        NOuMmsP0PtPpJ1G6B87exB5IGg==
X-Google-Smtp-Source: ABdhPJwmIdJCjnM9fEqF+TMGGejDU8cw2ZcMVWpRXEWassnpvKyeS//y4XQ3Oo4skLwgTVH/2L/vTg==
X-Received: by 2002:a05:6000:1b04:b0:1e7:3a09:6468 with SMTP id f4-20020a0560001b0400b001e73a096468mr15812862wrz.383.1645457241137;
        Mon, 21 Feb 2022 07:27:21 -0800 (PST)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id m8sm8545039wms.4.2022.02.21.07.27.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 07:27:20 -0800 (PST)
Message-ID: <d1d55fd2-68a8-9271-00c5-b395b085b50c@linaro.org>
Date:   Mon, 21 Feb 2022 15:27:19 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 01/10] ASoC: codecs: va-macro: add runtime pm support
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com
References: <20220221131037.8809-1-srinivas.kandagatla@linaro.org>
 <20220221131037.8809-2-srinivas.kandagatla@linaro.org>
 <YhOuvdsKu6zOg2p/@sirena.org.uk>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <YhOuvdsKu6zOg2p/@sirena.org.uk>
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

Thanks Mark,

On 21/02/2022 15:24, Mark Brown wrote:
> On Mon, Feb 21, 2022 at 01:10:28PM +0000, Srinivas Kandagatla wrote:
> 
>> +static int __maybe_unused va_macro_runtime_resume(struct device *dev)
>> +{
>> +	struct va_macro *va = dev_get_drvdata(dev);
>> +
>> +	clk_prepare_enable(va->clks[2].clk);
> 
> This magic number stuff is going to be excessively fragile, and the fact

I agree, will try to clean this up properly in next spin.

> that this is sometimes managed via the bulk APIs and sometimes not isn't
> going to help either.  Either all the clocks should be managed here or
> this should be pulled out of the array.
> 
> Also consider error checking.
will do,

--srin
