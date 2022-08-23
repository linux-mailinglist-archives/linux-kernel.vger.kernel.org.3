Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF1B959EE78
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 23:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiHWVxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 17:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiHWVxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 17:53:20 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EAEA62D3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 14:53:19 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id x19so11920845pfq.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 14:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flatmax-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=FnXtIAn0IyAxdQUTX7XZR7kL9caPa6K/jTtIbR9ZQeI=;
        b=obG8zpTD+VGj/DhquSB91/B1nOh31Mf4zX+mS3y0p5WZzXTnSJmE6BQmTBA4htk1bt
         XRB+svL4DsVm3OkT5aF7hEmIk/4ALS2HX0O2/ztMnxBw49FnjkWu9FdCfnqi7jQqRU+d
         93bGDbVwtR9FlSajQpZw/u8rSYDVTNqP80KtM3yeeIfToDmxuUv9olyyqcQDpDJeWSGi
         Se31wC8WzlmZeIawaNAM86zcgRAoNetc+63r/+hXDvOEqTgzpIkonR8X/m6Zh4Os6+eX
         wJIR+cK/L+K6oi+d5tFd8eKuKOA39x2u5gtPHF2/ignKoLU990mH7UniqFXIep+6DPUG
         I9fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=FnXtIAn0IyAxdQUTX7XZR7kL9caPa6K/jTtIbR9ZQeI=;
        b=q/fE0dCJnqu/o79PNYJ6ptHiYiyJZhs6iooZ1E8ojtv8p3mdIXH6MYQqmRSJfr4qsR
         LrT4tIrD2tMe14EoN0Lf8oqdezkErepg91H2nW1cspJkYrcDqw1VUDnvbv2PzXg/e9Sx
         eJQDJ/u66mSszTuY7L7zRWhJPdu0Eo8PgJ5PDSiugN6OA6HKGNkzJ68kY8pN64M/Twp3
         pNft+mN05RPRzl6mhzs+XCj0VBYj/Z0kLY2eNko2Ng3VsrX9ptpvfl8e6znyTFDYwtHj
         C2kpbPeWeFy4r1ojstsdihaODFYKmp+gWmd4PJQ8IodCcPb/8mcgVhN8Ck471jeffwrj
         QLfQ==
X-Gm-Message-State: ACgBeo2mjqSCNg0rWKaqSN3mRj5tfApmW02ax+oMA0o5DGdNBu6w1zAf
        ZdawhoXB4XfW41PTc/ZQyEu9ChrA3Drd3wGl
X-Google-Smtp-Source: AA6agR5ZlhUCW0kK8H4ShGD2wDJdvUWRcHbYtHdfzqHhFuCrXOYakw0jq4ZSaTBUiLOaY8O66jszSA==
X-Received: by 2002:aa7:9e4b:0:b0:536:68f0:dc93 with SMTP id z11-20020aa79e4b000000b0053668f0dc93mr15058614pfq.8.1661291599070;
        Tue, 23 Aug 2022 14:53:19 -0700 (PDT)
Received: from ?IPV6:2406:3400:213:70c0:5c76:4280:5b6b:9ce0? ([2406:3400:213:70c0:5c76:4280:5b6b:9ce0])
        by smtp.gmail.com with ESMTPSA id f76-20020a62384f000000b0052f20d70845sm11232126pfa.150.2022.08.23.14.53.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 14:53:18 -0700 (PDT)
Message-ID: <95641765-17a4-79aa-1ce3-9cd760ed41f4@flatmax.com>
Date:   Wed, 24 Aug 2022 07:53:13 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] ASoC: codes: src4xxx: Avoid clang
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
References: <20220823151939.2493697-1-nathan@kernel.org>
From:   Matt Flax <flatmax@flatmax.com>
In-Reply-To: <20220823151939.2493697-1-nathan@kernel.org>
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

This looks good.

Reviewed-by: Matt Flax <flatmax@flatmax.com>

On 24/8/22 01:19, Nathan Chancellor wrote:
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
>    sound/soc/codecs/src4xxx.c:280:3: error: variable 'jd' is used uninitialized whenever switch default is taken [-Werror,-Wsometimes-uninitialized]
>                    default:
>                    ^~~~~~~
>    sound/soc/codecs/src4xxx.c:293:59: note: uninitialized use occurs here
>                    ret = regmap_write(src4xxx->regmap, SRC4XXX_RCV_PLL_10, jd);
>                                                                            ^~
>    sound/soc/codecs/src4xxx.c:223:17: note: initialize the variable 'jd' to silence this warning
>            int val, pj, jd, d;
>                          ^
>                            = 0
>    sound/soc/codecs/src4xxx.c:280:3: error: variable 'pj' is used uninitialized whenever switch default is taken [-Werror,-Wsometimes-uninitialized]
>                    default:
>                    ^~~~~~~
>    sound/soc/codecs/src4xxx.c:288:59: note: uninitialized use occurs here
>                    ret = regmap_write(src4xxx->regmap, SRC4XXX_RCV_PLL_0F, pj);
>                                                                            ^~
>    sound/soc/codecs/src4xxx.c:223:13: note: initialize the variable 'pj' to silence this warning
>            int val, pj, jd, d;
>                      ^
>                        = 0
>    3 errors generated.
>
> The datasheet does not have any default values for these regmap values
> so pick some arbitrary values and print to the user that this is the
> case to silence the warnings.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1691
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
> Suggested-by: Matt Flax <flatmax@flatmax.com>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>
> v1 -> v2: https://lore.kernel.org/20220822183101.1115095-1-nathan@kernel.org/
>
> * Don't return early, just initialize the values to some arbitrary
>    numbers and try to hobble along, as other parts of the chip may be
>    functional.
>
> * Add message and comment to describe this situation.
>
>   sound/soc/codecs/src4xxx.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
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
> base-commit: 94f072748337424c9cf92cd018532a34db3a5516
