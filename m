Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B99556057A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 18:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233281AbiF2QKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 12:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233462AbiF2QKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 12:10:39 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E72286CB
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 09:10:38 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id l2-20020a05600c4f0200b0039c55c50482so11764904wmq.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 09:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=SEMFcIPDfBALSSCWbUM/48N5X3O5aKQwjbMRjI8nqUw=;
        b=jCn0Y3/LYiFWVk9GT55lSaUeOkkZJ69Uj+iVfbUpmQfd2qKZbv/IzWnpw4IteXg5xS
         Xa7b/2J2MrkmWcSNoTnnqgLUESW9p+LxpxViM6pxy5uZadAoNnUKKLMI3Ehe0ns0Cbrs
         Lsd1SsA8ENGTrMJz9mIIDzCoeGMGMIgIHJAyUqXvvpMosctwQ1pSES78VNU6RTvBSj8w
         1rt+Wun9iEtm2DpdaPyE8GCllbvWdp1aTxcfXCNaIXLF+M7qwq/A8Tld5fi8Kw8sfJNL
         ztj2o9t4JTGEpjgkbMgI/jkEeZ30CHUiXZxZXInVD1KAfSkqylLiljl5qtw29MjQqnhK
         0kXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SEMFcIPDfBALSSCWbUM/48N5X3O5aKQwjbMRjI8nqUw=;
        b=Se5Dd/XT6eIV22aCc9ErUWqUKoY//mfv3eMEsmh6yuwOTiNTZNSAh+P4DegeBCfCbd
         Ft9C2ZmUsLdQ6O+wWZmc88K0LOp1GPRLx0MqmMw2bB11Jw7tHORbi8ySh3DOMkvvs3dM
         MlfQd2Qz6719H77XU9HzgLEI7ZA3CNa5oX+xtHhB439HVoJ0qEXebNgLDforxHyLcJDl
         czWT0p+1LCnLlqAJ3Lo1jfPZCJuqBwQlCO4O7g6eX2nqX6M0TVOjH8wtzBl1FY8/K1pU
         JWlIsa9ww3K9sXnMt1PPHkIa69WNKjVW44hKXyWiEq5k5s2kEb26+qzQ99PxohG+QHLX
         2A8A==
X-Gm-Message-State: AJIora8sTcsjp3rYhcXNOjcEg5VMNLAiisbALaTZBVOkvL3iWCQMrq4L
        Ui2pVS37tFMFJnpNFrKFKjSwWxb4E5ZpBNLJ
X-Google-Smtp-Source: AGRyM1uXRsCmp5t0GXuVL8ntgGXkfKBR3b37W+44IEemEUaddIEU1bPSbYeX9UP2sc9o98WdRbT8HQ==
X-Received: by 2002:a05:600c:1c27:b0:3a0:5098:c8b6 with SMTP id j39-20020a05600c1c2700b003a05098c8b6mr4680548wms.69.1656519037113;
        Wed, 29 Jun 2022 09:10:37 -0700 (PDT)
Received: from [192.168.86.238] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id r20-20020a05600c35d400b003a02f957245sm3725912wmq.26.2022.06.29.09.10.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 09:10:36 -0700 (PDT)
Message-ID: <9c71f751-2f5e-4d1f-5f94-942cf7ad6a8a@linaro.org>
Date:   Wed, 29 Jun 2022 17:10:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] ASoC: codecs: wsa883x: add control, dapm widgets and
 map
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, linux-kernel@vger.kernel.org
References: <20220629145831.77868-1-srinivas.kandagatla@linaro.org>
 <YrxpgF2B5W7fyYVy@sirena.org.uk>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <YrxpgF2B5W7fyYVy@sirena.org.uk>
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



On 29/06/2022 16:02, Mark Brown wrote:
> On Wed, Jun 29, 2022 at 03:58:31PM +0100, Srinivas Kandagatla wrote:
> 
>> +static const char * const wsa_dev_mode_text[] = {
>> +	"speaker", "receiver", "ultrasound"
> 
> Idiomatically these would be capitalised ("Speaker" and so on).  Sorry,
> didn't notice on v1.  Otherwise this looks good.
Make sense, Will send v3.

--srini
