Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1163259173B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 00:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236681AbiHLWXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 18:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbiHLWXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 18:23:06 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6312311456;
        Fri, 12 Aug 2022 15:23:05 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id a12so950441qkk.7;
        Fri, 12 Aug 2022 15:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=sW9hnKe3PhL/Umb988XscvuO/sNSE1um1bW+MnXhWus=;
        b=J5FtUxwOJSF75TAcrJRoMnQtXL5c7loYkQCFP1u3P6IwwcrI06PVP5haZ1yXX+UgkR
         CzgrkA2RPKKBX2DX/idC49STf/d/0x29dESCYsr7Gzh3fHWnnWr9+ddnhXWeBaTQl7u2
         EGgzH+w5WNTUpdqIZaWQTEH/IxsQAIbJWrY0oGt+76QXSveZJUiytlu6CiaocAFcYYHx
         urvUjygl+fYsUxlO2yP4NoteQCcV+LsTI5ei7iovq0+6lWv12S1SjNZcCxYNBwW1A9KB
         OZszwh077kL4sJBM8tsuH4DnX+BhHQUaWoO7gyMvNgLnVwdSzeJhu+7NLVio4L1kYFat
         Ob5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=sW9hnKe3PhL/Umb988XscvuO/sNSE1um1bW+MnXhWus=;
        b=sAInmIk2jFUhsC+EE1zW9fc/twbgLMlkF8wLueqwoJ87ziTTU/4jXe8PffZUlfELhV
         LjkFnshEu+HL9hL0bk84zi6RTL5KecIHo88NZgd2o/lsi0PnKJjimsepyfpKPNxhfXiU
         hf1tRbp3iDw6DRWUO8iHO7DT9SPP9dND5jfkuEs9NFarWUnJZj0Dw6yGx6AaHPCKiish
         tw86ng10IeM/UW8LrcOWBPxv3iw9CO39FUceM3mIltNEuH3yhBme32j0Rk+J0pUJnTcd
         5w0BjtCYxEHC+uuvUWXbHk4IL6T6jRcX6k9iNCUZdAcHffhP69EB5WVv9ruZnmpqMK7w
         40zQ==
X-Gm-Message-State: ACgBeo00Mt2I0CCj2eG+Ob32ecy3W/lMem4KMMu41AbOG5t1o0r1edvM
        umGzk2nge/73ACoT/4OiUPA=
X-Google-Smtp-Source: AA6agR73OgaSYcBb88BYiZ0fBxAC6nCOw2FRiSsESxntACfgwGjaVSC8g+jLMOBhRgJTwLjzwhbuug==
X-Received: by 2002:a05:620a:461e:b0:6b5:f9b9:5f70 with SMTP id br30-20020a05620a461e00b006b5f9b95f70mr4542519qkb.631.1660342984353;
        Fri, 12 Aug 2022 15:23:04 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id bn12-20020a05622a1dcc00b0031eb5648b86sm2524908qtb.41.2022.08.12.15.22.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 15:23:03 -0700 (PDT)
Message-ID: <90d37d6e-52df-149e-5691-ae7a91521482@gmail.com>
Date:   Fri, 12 Aug 2022 15:22:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 3/3] memory: Add Broadcom STB memory controller driver
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
References: <20220801220931.181531-1-f.fainelli@gmail.com>
 <20220801220931.181531-4-f.fainelli@gmail.com>
 <26ad247d-a4b3-4051-b8d9-505c09b76f6b@linaro.org>
 <375eac04-dbfd-080a-3003-cae3eda1f42b@gmail.com>
 <fa283e3c-5b96-b0a4-95c5-a7230d16d8ca@linaro.org>
 <ec06e9c6-f475-fe19-9046-d57a6168e72b@gmail.com>
 <c51c360e-a73f-9333-ffa1-3461de29f41f@linaro.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <c51c360e-a73f-9333-ffa1-3461de29f41f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/12/22 11:41, Krzysztof Kozlowski wrote:
> On 12/08/2022 20:52, Florian Fainelli wrote:
> 
>>>> unless you also implied enclosing those functions under an #if
>>>> IS_ENABLED(CONFIG_PM) or something which is IMHO less preferable.
>>>
>>> Are you sure you added also pm_ptr()? I don't see such warnings with W=1
>>> and final object does not have the functions (for a different driver but
>>> same principle).
>>
>> Yes I am sure I added pm_ptr() see the v4 I just submitted. I don't see
>> how the compiler cannot warn about the functions being unused the day
>> they stop being referenced by the pm_ops structure which is eliminated?
> 
> I don't have the answer how it exactly works (or which gcc version
> introduced it), but I tested it and the functions were not present in
> the object file, thus of course no warnings.
> 
> The driver change I am referring to is:
> https://lore.kernel.org/all/20220808174107.38676-15-paul@crapouillou.net/
> 
> I think the only difference against your v4 is:
> DEFINE_SIMPLE_DEV_PM_OPS
> and lack of __maybe_unused on the functions.
> 
> The DEFINE_SIMPLE_DEV_PM_OPS itself adds __maybe_unused for !CONFIG_PM
> case, but I don't think it is relevant.

It definitively is relevant here. SIMPLE_DEV_PM_OPS without 
__maybe_unused results in the following pre-processed code:

static int brcmstb_memc_suspend(struct device *dev)
{
  struct brcmstb_memc *memc = dev_get_drvdata(dev);
  void *cfg = memc->ddr_ctrl + memc->srpd_offset;
  u32 val;

  if (memc->timeout_cycles == 0)
   return 0;






  val = ({ u32 __r = (( __u32)(__le32)(( __le32) __raw_readl(cfg))); 
__r; });
  val &= ~((((1UL))) << (16));
  __raw_writel(( u32) (( __le32)(__u32)(val)),cfg);

  (void)({ u32 __r = (( __u32)(__le32)(( __le32) __raw_readl(cfg))); 
__r; });

  return 0;
}

static int brcmstb_memc_resume(struct device *dev)
{
  struct brcmstb_memc *memc = dev_get_drvdata(dev);

  if (memc->timeout_cycles == 0)
   return 0;

  return brcmstb_memc_srpd_config(memc, memc->timeout_cycles);
}

static const struct dev_pm_ops __attribute__((__unused__)) 
brcmstb_memc_pm_ops = { }
                         ;

static struct platform_driver brcmstb_memc_driver = {
  .probe = brcmstb_memc_probe,
  .remove = brcmstb_memc_remove,
  .driver = {
   .name = "brcmstb_memc",
   .of_match_table = brcmstb_memc_of_match,
   .pm = ((1) ? ((&brcmstb_memc_pm_ops)) : ((void *)0)),
  },
};

Now with DEFINE_SIMPLE_PM_OPS, we get the following instead:

static const struct dev_pm_ops brcmstb_memc_pm_ops = { .suspend = ((0) ? 
((brcmstb_memc_suspend)) : ((void *)0)), .resume = ((0) ? 
((brcmstb_memc_resume)) : ((void *)0)), .freeze = ((0) ? 
((brcmstb_memc_suspend)) : ((void *)0)), .thaw = ((0) ? 
((brcmstb_memc_resume)) : ((void *)0)), .poweroff = ((0) ? 
((brcmstb_memc_suspend)) : ((void *)0)), .restore = ((0) ? 
((brcmstb_memc_resume)) : ((void *)0)), .runtime_suspend = ((void *)0), 
.runtime_resume = ((void *)0), .runtime_idle = ((void *)0), }
                         ;

static struct platform_driver brcmstb_memc_driver = {
  .probe = brcmstb_memc_probe,
  .remove = brcmstb_memc_remove,
  .driver = {
   .name = "brcmstb_memc",
   .of_match_table = brcmstb_memc_of_match,
   .pm = ((1) ? ((&brcmstb_memc_pm_ops)) : ((void *)0)),
  },
};

so we will continue to reference the functions, but eventually we will 
eliminate those at the optimization stage by figuring out that this is 
dead code, therefore it can be eliminated. Note that in both cases the 
object does not contain brcmstb_memc_{resume,suspend} which makes sense 
because the warnings are generated at the time the code is processed, 
and the dead code elimination at one of the optimization stages.

I can spin a v5 with DEFINE_SIMPLE_PM_OPS if you prefer to get rid of 
the __maybe_unused.
-- 
Florian
