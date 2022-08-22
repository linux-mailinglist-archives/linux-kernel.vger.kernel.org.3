Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081C759CB8B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 00:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238479AbiHVWfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 18:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238460AbiHVWfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 18:35:36 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75CE748C90
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 15:35:34 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id jm11so11186429plb.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 15:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flatmax-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=jEuLhzJLSTk5CufgkvPiCkW+mlDKBcKSUTF8OkYisvc=;
        b=SYIxBE2rosAR/GAp4nMjnyKF81I+qBEKUZpzJsIxsQl9fpWAmPl88aJNxE7DM3qAkb
         t49LfzyqsMsORWG6DSp7IzGyY7azYsmh2kySlQC8hS1zwi71Yber9qS8oujA1jG0Gqik
         mhtYCdbM/T348ZrTyknqpMu00DxO4LZ5yXDLCiJ45G1EVOSmflSUlofu0oqOYL4x95KZ
         rccl+jGR/5/7fb8yxOONYXM2PeBHZy/brtBPj23wuc8hCwKqf2SFpBI3/AxnX5SH9X0c
         C9Nlo6Q5Y+o5EM6VwbYLImvJhaRXmx1em4qW3k+039Mb3jTr6qRiIQ80/N6FSaL5eCr3
         HxtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=jEuLhzJLSTk5CufgkvPiCkW+mlDKBcKSUTF8OkYisvc=;
        b=x+GYn4HQyR+77gd2weN0Bx2KMSjZe2k7JcIKpMpYOQQhU239YmgSTTZjyjjum3XgCd
         D8vNL8A4eBYUUcNqBTNRRg0XaslLiYqlnN4n5tz8bq0cQzjHbYvrkjdYO4IuQHC1GrhF
         aVFEHVpu2TfbTs0XWpToJK97u4yPU5UF9jMgY9aHtiRgQUnAcNf4B3+xkxuUgZaFckCH
         db4wruzN04ua1Yeny18dHN9CmruFZSUZGV9Yvc1gavO+390iUCBitHUVErkLW0udOcIS
         /BNpj6x/NqRmBWWiPSbCdrRngooPlrpx7OzMfrfmMGlzoBLoI1gkrMVdmIirhXEEqgU/
         uokA==
X-Gm-Message-State: ACgBeo1w6TRpqVl/mGzMCPh3G6xSGbICgX2vfqdCxJueTB6Z+SWBi9rI
        dGLuPk+/uYrchruTth0TniFIrg==
X-Google-Smtp-Source: AA6agR6YtxMR78C4m5EhtbfUJBy+PKaZepoTxqsQ+ro2j2FBPWOeEUsFy2BpbS4rJUKi1UTFOA1Wmw==
X-Received: by 2002:a17:90b:1e4e:b0:1fa:bab4:d24f with SMTP id pi14-20020a17090b1e4e00b001fabab4d24fmr428445pjb.185.1661207733771;
        Mon, 22 Aug 2022 15:35:33 -0700 (PDT)
Received: from ?IPV6:2406:3400:213:70c0:73b4:2cc5:1ada:53cd? ([2406:3400:213:70c0:73b4:2cc5:1ada:53cd])
        by smtp.gmail.com with ESMTPSA id q4-20020a170902eb8400b0016c9e5f291bsm8812572plg.111.2022.08.22.15.35.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 15:35:32 -0700 (PDT)
Message-ID: <99a54f9c-519e-1ccb-8ceb-391a0aeb359d@flatmax.com>
Date:   Tue, 23 Aug 2022 08:35:26 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] ASoC: codes: src4xxx: Avoid clang
 -Wsometimes-uninitialized in src4xxx_hw_params()
Content-Language: en-AU
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        patches@lists.linux.dev, kernel test robot <lkp@intel.com>,
        "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
References: <20220822183101.1115095-1-nathan@kernel.org>
 <72de09df-5dee-8bd0-5c91-359e4bc36ca8@flatmax.com>
 <YwQEDyk17Q06mIVR@dev-arch.thelio-3990X>
From:   Matt Flax <flatmax@flatmax.com>
In-Reply-To: <YwQEDyk17Q06mIVR@dev-arch.thelio-3990X>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

That solution looks good.

Matt

On 23/8/22 08:32, Nathan Chancellor wrote:
> Hi Matt,
>
> On Tue, Aug 23, 2022 at 08:00:07AM +1000, Matt Flax wrote:
>> Hi Nathan,
>>
>> On 23/8/22 04:31, Nathan Chancellor wrote:
>>> Clang warns:
>>>
>>>     sound/soc/codecs/src4xxx.c:280:3: error: variable 'd' is used uninitialized whenever switch default is taken [-Werror,-Wsometimes-uninitialized]
>>>                     default:
>>>                     ^~~~~~~
>>>     sound/soc/codecs/src4xxx.c:298:59: note: uninitialized use occurs here
>>>                     ret = regmap_write(src4xxx->regmap, SRC4XXX_RCV_PLL_11, d);
>>>                                                                             ^
>>>     sound/soc/codecs/src4xxx.c:223:20: note: initialize the variable 'd' to silence this warning
>>>             int val, pj, jd, d;
>>>                               ^
>>>                               = 0
>>
>> If you really want to get rid of these warnings, you can use this default
>> for the variables :
>>
>> pj = 0x0;
>> jd=0xff;
>>
>> d = 0xff;
>>
>> It doesn't really make sense why we would choose to initialise these
>> variables, but if you want to silence the preprocessor, then perhaps those
>> values. Put a message that defaults are not known nor specified in the data
>> sheet and these values are chosen to be unlikely matches of real world
>> values - which ensures regmap updates later from an initial unknown chip
>> state after refresh.
> Okay, I could do something like this?
>
> diff --git a/sound/soc/codecs/src4xxx.c b/sound/soc/codecs/src4xxx.c
> index a8f143057b41..db4e280dd055 100644
> --- a/sound/soc/codecs/src4xxx.c
> +++ b/sound/soc/codecs/src4xxx.c
> @@ -280,9 +280,14 @@ static int src4xxx_hw_params(struct snd_pcm_substream *substream,
>   		default:
>   			/* don't error out here,
>   			 * other parts of the chip are still functional
> +			 * Dummy initialize variables to avoid
> +			 * -Wsometimes-uninitialized from clang.
>   			 */
>   			dev_info(component->dev,
> -				"Couldn't set the RCV PLL as this master clock rate is unknown\n");
> +				"Couldn't set the RCV PLL as this master clock rate is unknown. Chosen regmap values may not match real world values.\n");
> +			pj = 0x0;
> +			jd = 0xff;
> +			d = 0xff;
>   			break;
>   		}
>   		ret = regmap_write(src4xxx->regmap, SRC4XXX_RCV_PLL_0F, pj);
>
> These warnings need to be eliminated because Linus requires a clean
> build as much as possible [1] [2], which has been codified by
> CONFIG_WERROR, which is enabled by default with allmodconfig. As a
> result, clang allmodconfig builds are broken [3], which you might have
> already seen. If there is another way this could be written without
> potentially uninitialized variables, I am open to it.
>
> [1]: https://lore.kernel.org/CAHk-=wg-mH-_GYpkhz_psjBWG6ZcjKnPo83fg7YMj_by+-LRTQ@mail.gmail.com/
> [2]: https://lore.kernel.org/CAHk-=wi4wyvuXs0SUq-2x=XHxWmJ6jVKRD-WpE0kWgWiqVJNbg@mail.gmail.com/
> [3]: https://lore.kernel.org/YwNMUlAmu%2FqCjuva@debian/
>
>> All a bit messy really.
> Indeed :/
>
>>> According to the comment in the default case, other parts of the chip
>>> are still functional without these values so just return 0 in the
>>> default case to avoid using these variables uninitialized.
>>>
>>> Link: https://github.com/ClangBuiltLinux/linux/issues/1691
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Reported-by: "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
>>> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
>>> ---
>>>    sound/soc/codecs/src4xxx.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/sound/soc/codecs/src4xxx.c b/sound/soc/codecs/src4xxx.c
>>> index a8f143057b41..cf45caa4bf7f 100644
>>> --- a/sound/soc/codecs/src4xxx.c
>>> +++ b/sound/soc/codecs/src4xxx.c
>>> @@ -283,7 +283,7 @@ static int src4xxx_hw_params(struct snd_pcm_substream *substream,
>>>    			 */
>>>    			dev_info(component->dev,
>>>    				"Couldn't set the RCV PLL as this master clock rate is unknown\n");
>>> -			break;
>>> +			return 0;
>>
>> Don't return here, the rest of the chip is still functional and probably in
>> use. Print the dev_info and continue.
> I'll send a v2 tomorrow morning (for me at least) if there are no other
> comments.
>
> Cheers,
> Nathan
