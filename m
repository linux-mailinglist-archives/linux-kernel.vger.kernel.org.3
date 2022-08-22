Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7176559CB40
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 00:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238016AbiHVWAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 18:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiHVWAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 18:00:16 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829163DF02
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 15:00:15 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id w138so9033333pfc.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 15:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flatmax-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=k7QztPNY6f5UPLhFzQe/bCAaGoEOsA+9S8peUjdBlTk=;
        b=c/WEgMnCXQKbLNgvEBP8td0Sx3mSDaOuW5vJixarP5cB4HVOlwXWV7YHZNlHV6wKk1
         qap2wSHRjwj8hGabgU8iqHb7uEBpz7J82eh8P6R8Q1qRSFYIFU8aQh+1WW2j8FwiMA3A
         HQfQDT4JHh7UiHHwrVjOG6IWx19Lv7rlRPKMS3Ua4lKhD8k7mBr5pcCrF7p17wcUTG9U
         W+PsUGz0g8Sj+XTMw6EZr72lPcqggh+SUb1apuwoYAQRl6FQ+hcYt1MN/4QzCsc/B9vI
         SuTwVo2Ev6dG9sTc5hD2uIrrYKMKwf1qnd/Ihd7R5viPBb1A9MVu6SEVEoSw5IygzRXp
         IXBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=k7QztPNY6f5UPLhFzQe/bCAaGoEOsA+9S8peUjdBlTk=;
        b=0f6VYdBF+ygoVX6pTPDwemFo7/tRGRBJAFAJ4Hr3MVfc5xeVMMuhC+LTEY2aLUB3V/
         boja4ZO9hbdUuzu0+ONXsuclutFEBCk2SiCS416ZR32FL53jYsdm69iTwgihtZQQSggw
         ZdKdbLh5IswIHvO4LEhGNoqZnI6ON41wzkDCMAe4qlayH2dPlk2inC4N0sebzfnFJWS8
         4h/K/Z16v7Wwb//cdNbhI5c5/HLJNJ6Na/+W+lQoCSiqce1Zkzw9aEjrRwhZhGKpAecm
         KK53tzrXdu38soMKCjjbe0YlxbuiNkSzQji/o5ysPdQqU4pqBpOKsUCLRcl0fDVUsMc8
         oVCA==
X-Gm-Message-State: ACgBeo0rpl/3FNlL2Q4i4sHo/8bwmx0zyxH8qa0IddW1xR5VtJ0mVoSp
        YmWNeRHBZm3G4Qr40+DF9eJNiw==
X-Google-Smtp-Source: AA6agR6duxF3m0MIusH+8dSELwpye5RmZc+z35IyCWoipxGYYNLN70/tfTT/CqoBOD/cFCtjYZ5d9A==
X-Received: by 2002:a05:6a00:2486:b0:536:777b:6a64 with SMTP id c6-20020a056a00248600b00536777b6a64mr9649685pfv.65.1661205614943;
        Mon, 22 Aug 2022 15:00:14 -0700 (PDT)
Received: from ?IPV6:2406:3400:213:70c0:73b4:2cc5:1ada:53cd? ([2406:3400:213:70c0:73b4:2cc5:1ada:53cd])
        by smtp.gmail.com with ESMTPSA id o12-20020a170902bccc00b0016db7f49cc2sm8817503pls.115.2022.08.22.15.00.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 15:00:14 -0700 (PDT)
Message-ID: <72de09df-5dee-8bd0-5c91-359e4bc36ca8@flatmax.com>
Date:   Tue, 23 Aug 2022 08:00:07 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] ASoC: codes: src4xxx: Avoid clang
 -Wsometimes-uninitialized in src4xxx_hw_params()
Content-Language: en-AU
To:     Nathan Chancellor <nathan@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        patches@lists.linux.dev, kernel test robot <lkp@intel.com>,
        "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
References: <20220822183101.1115095-1-nathan@kernel.org>
From:   Matt Flax <flatmax@flatmax.com>
In-Reply-To: <20220822183101.1115095-1-nathan@kernel.org>
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

Hi Nathan,

On 23/8/22 04:31, Nathan Chancellor wrote:
> Clang warns:
>
>    sound/soc/codecs/src4xxx.c:280:3: error: variable 'd' is used uninitialized whenever switch default is taken [-Werror,-Wsometimes-uninitialized]
>                    default:
>                    ^~~~~~~
>    sound/soc/codecs/src4xxx.c:298:59: note: uninitialized use occurs here
>                    ret = regmap_write(src4xxx->regmap, SRC4XXX_RCV_PLL_11, d);
>                                                                            ^
>    sound/soc/codecs/src4xxx.c:223:20: note: initialize the variable 'd' to silence this warning
>            int val, pj, jd, d;
>                              ^
>                              = 0


If you really want to get rid of these warnings, you can use this 
default for the variables :

pj = 0x0;
jd=0xff;

d = 0xff;

It doesn't really make sense why we would choose to initialise these 
variables, but if you want to silence the preprocessor, then perhaps 
those values. Put a message that defaults are not known nor specified in 
the data sheet and these values are chosen to be unlikely matches of 
real world values - which ensures regmap updates later from an initial 
unknown chip state after refresh. All a bit messy really.


> According to the comment in the default case, other parts of the chip
> are still functional without these values so just return 0 in the
> default case to avoid using these variables uninitialized.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1691
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>   sound/soc/codecs/src4xxx.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/codecs/src4xxx.c b/sound/soc/codecs/src4xxx.c
> index a8f143057b41..cf45caa4bf7f 100644
> --- a/sound/soc/codecs/src4xxx.c
> +++ b/sound/soc/codecs/src4xxx.c
> @@ -283,7 +283,7 @@ static int src4xxx_hw_params(struct snd_pcm_substream *substream,
>   			 */
>   			dev_info(component->dev,
>   				"Couldn't set the RCV PLL as this master clock rate is unknown\n");
> -			break;
> +			return 0;


Don't return here, the rest of the chip is still functional and probably 
in use. Print the dev_info and continue.



