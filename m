Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01E50574943
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 11:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237124AbiGNJm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 05:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237585AbiGNJmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 05:42:25 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149C8474EF
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 02:42:23 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id t25so1875911lfg.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 02:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=dsFU8ewxIpnrWF6cefKe+G467zfznXVN3ZUYn7Rk1fc=;
        b=yOkBr9ThiWHGXYUzxt87xaFSVdzdULXRjGwplloEdGkUTY2uItcDRBYVs3EWgF8eK3
         Y2IT7VZVnC0kxmTqETkzxaUIYWWurz9teUzYQZ8rhqowirRiKMVxuOwJ9+oiWF8LVDww
         w1yTVygSCqhyH8Yw5aJC83ZyzrIh5PjwSQ2Ob1wwmqhC9eznfG4jLdiWsU0bsuiARfRO
         8sb9WrJQfbBYNO2fGEnILHYuZaeiL4MBygKwO9hW5N/QFuv7o6IIs6/Qbxk4r7Yk3J7w
         Ba0WbjQAofuKU/4EHC+K+tBtA74iCKOTKaa7R16porgItIW2nVWKM+fIQSYZ4+WKEwo7
         L2mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dsFU8ewxIpnrWF6cefKe+G467zfznXVN3ZUYn7Rk1fc=;
        b=QRXWYUXLGd/kqLOg/vteeQJOuEbhJmXSfknluf6O9EY4iGpxXO7zw5fQUZz3rOyaXl
         fBkX2SUSkQW1i570Z9wnQH6jy7EW4KZ3LQ69ExJtyuLG4K/sqPkUs4Kl1Ps4qQOXONvx
         puRTkwnKAwAifQcAsRXNLpCvmdNS3aJMeLuRorQ0G0h/aMb4jFrRPmGNAAqPwPq7cJvN
         x+dYlMg77CkePu/OAk8BCoIJRP6rY4MgMngic5JjBW2oIhPvZTzV7kkZmZPTUXUbrL61
         z+JA0ixKfriBSZyGikre28mNUCArb7ZzyDeFs4eX1KZT/h7vwo5iEdFPxGbO8Zok++ZA
         J+cg==
X-Gm-Message-State: AJIora+06ttuW89gWd3ck/ERMznlZoRjJN+nM6lhjQ738qyP3qOClvaN
        59VDF7GJFlhXaof/xNXwZ7Cl4A==
X-Google-Smtp-Source: AGRyM1vUziNMsgQrJ2z3cXXHCB3q9qQIgt4FekNlQSi6bNvvs16bzAG9doF8Mk1/G7zH3tEsBolt5A==
X-Received: by 2002:ac2:5509:0:b0:489:e7f9:75b9 with SMTP id j9-20020ac25509000000b00489e7f975b9mr4487221lfk.507.1657791741374;
        Thu, 14 Jul 2022 02:42:21 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id y10-20020a056512044a00b0047fbf4c8bdfsm265861lfk.143.2022.07.14.02.42.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 02:42:20 -0700 (PDT)
Message-ID: <beb747ed-6e71-78a4-d5b8-b51b8d2ca927@linaro.org>
Date:   Thu, 14 Jul 2022 12:42:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/6] clk: qcom: msm8996-cpu: Statically define PLL
 dividers
Content-Language: en-GB
To:     Yassine Oudjana <yassine.oudjana@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220621160621.24415-1-y.oudjana@protonmail.com>
 <20220621160621.24415-3-y.oudjana@protonmail.com>
 <CAA8EJpq4YYdeXVtYORaDROiFLRL6p-_jmjx3mj4JtrYDhik3hQ@mail.gmail.com>
 <A250FR.22DB6BQXIGPX1@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <A250FR.22DB6BQXIGPX1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/07/2022 11:32, Yassine Oudjana wrote:
> 
> On Tue, Jun 21 2022 at 20:02:28 +0300, Dmitry Baryshkov 
> <dmitry.baryshkov@linaro.org> wrote:
>> On Tue, 21 Jun 2022 at 19:07, Yassine Oudjana 
>> <yassine.oudjana@gmail.com> wrote:
>>>
>>>  From: Yassine Oudjana <y.oudjana@protonmail.com>
>>>
>>>  This will allow for adding them to clk_parent_data arrays
>>>  in an upcoming patch.
>>>
>>>  Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
>>>  ---
>>>   drivers/clk/qcom/clk-cpu-8996.c | 66 +++++++++++++++++++++------------
>>>   1 file changed, 42 insertions(+), 24 deletions(-)
>>>
>>>  diff --git a/drivers/clk/qcom/clk-cpu-8996.c 
>>> b/drivers/clk/qcom/clk-cpu-8996.c
>>>  index 5dc68dc3621f..217f9392c23d 100644
>>>  --- a/drivers/clk/qcom/clk-cpu-8996.c
>>>  +++ b/drivers/clk/qcom/clk-cpu-8996.c
>>>  @@ -135,6 +135,34 @@ static struct clk_alpha_pll pwrcl_pll = {
>>>          },
>>>   };
>>>
>>>  +static struct clk_fixed_factor pwrcl_pll_postdiv = {
>>>  +       .mult = 1,
>>>  +       .div = 2,
>>>  +       .hw.init = &(struct clk_init_data){
>>>  +               .name = "pwrcl_pll_postdiv",
>>>  +               .parent_data = &(const struct clk_parent_data){
>>>  +                       .hw = &pwrcl_pll.clkr.hw
>>>  +               },
>>>  +               .num_parents = 1,
>>>  +               .ops = &clk_fixed_factor_ops,
>>>  +               .flags = CLK_SET_RATE_PARENT,
>>>  +       },
>>>  +};
>>>  +
>>>  +static struct clk_fixed_factor perfcl_pll_postdiv = {
>>>  +       .mult = 1,
>>>  +       .div = 2,
>>>  +       .hw.init = &(struct clk_init_data){
>>>  +               .name = "perfcl_pll_postdiv",
>>>  +               .parent_data = &(const struct clk_parent_data){
>>>  +                       .hw = &perfcl_pll.clkr.hw
>>>  +               },
>>>  +               .num_parents = 1,
>>>  +               .ops = &clk_fixed_factor_ops,
>>>  +               .flags = CLK_SET_RATE_PARENT,
>>>  +       },
>>>  +};
>>>  +
>>>   static const struct pll_vco alt_pll_vco_modes[] = {
>>>          VCO(3,  250000000,  500000000),
>>>          VCO(2,  500000000,  750000000),
>>>  @@ -261,7 +289,7 @@ static struct clk_cpu_8996_mux pwrcl_smux = {
>>>                  .name = "pwrcl_smux",
>>>                  .parent_names = (const char *[]){
>>>                          "xo",
>>>  -                       "pwrcl_pll_main",
>>>  +                       "pwrcl_pll_postdiv",
>>>                  },
>>>                  .num_parents = 2,
>>>                  .ops = &clk_cpu_8996_mux_ops,
>>>  @@ -277,7 +305,7 @@ static struct clk_cpu_8996_mux perfcl_smux = {
>>>                  .name = "perfcl_smux",
>>>                  .parent_names = (const char *[]){
>>>                          "xo",
>>>  -                       "perfcl_pll_main",
>>>  +                       "perfcl_pll_postdiv",
>>>                  },
>>>                  .num_parents = 2,
>>>                  .ops = &clk_cpu_8996_mux_ops,
>>>  @@ -354,32 +382,25 @@ static int 
>>> qcom_cpu_clk_msm8996_register_clks(struct device *dev,
>>>   {
>>>          int i, ret;
>>>
>>>  -       perfcl_smux.pll = clk_hw_register_fixed_factor(dev, 
>>> "perfcl_pll_main",
>>>  -                                                      "perfcl_pll",
>>>  - CLK_SET_RATE_PARENT,
>>>  -                                                      1, 2);
>>>  -       if (IS_ERR(perfcl_smux.pll)) {
>>>  -               dev_err(dev, "Failed to initialize perfcl_pll_main\n");
>>>  -               return PTR_ERR(perfcl_smux.pll);
>>>  +       ret = devm_clk_hw_register(dev, &pwrcl_pll_postdiv.hw);
>>
>> No need to. I'd suggest picking up the
>> devm_clk_hw_register_fixed_factor patch from my patchset and using
>> this API.
> 
> I did it this way to be able to define it statically in the
> `parent_data` arrays of the secondary muxes in patch 6/6. How
> would I do it this way? Do I define global `static struct clk_hw *`s
> for the postdivs and use them in the `parent_data` arrays, or
> perhaps un-constify the arrays and insert the returned
> `struct clk_hw *`s into them here? Also can you send a link to
> your patch? or is it already applied?

I have been playing with your patchset. In the end I have dropped the 
idea of using devm_clk_hw_register_fixed_factor() and just used 
devm_clk_hw_register too. So:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> 
>>
>>>  +       if (ret) {
>>>  +               dev_err(dev, "Failed to register pwrcl_pll_postdiv: 
>>> %d", ret);
>>>  +               return ret;
>>>          }
>>>
>>>  -       pwrcl_smux.pll = clk_hw_register_fixed_factor(dev, 
>>> "pwrcl_pll_main",
>>>  -                                                     "pwrcl_pll",
>>>  - CLK_SET_RATE_PARENT,
>>>  -                                                     1, 2);
>>>  -       if (IS_ERR(pwrcl_smux.pll)) {
>>>  -               dev_err(dev, "Failed to initialize pwrcl_pll_main\n");
>>>  -               clk_hw_unregister(perfcl_smux.pll);
>>>  -               return PTR_ERR(pwrcl_smux.pll);
>>>  +       ret = devm_clk_hw_register(dev, &perfcl_pll_postdiv.hw);
>>>  +       if (ret) {
>>>  +               dev_err(dev, "Failed to register perfcl_pll_postdiv: 
>>> %d", ret);
>>>  +               return ret;
>>>          }
>>>
>>>  +       pwrcl_smux.pll = &pwrcl_pll_postdiv.hw;
>>>  +       perfcl_smux.pll = &perfcl_pll_postdiv.hw;
>>>  +
>>>          for (i = 0; i < ARRAY_SIZE(cpu_msm8996_clks); i++) {
>>>                  ret = devm_clk_register_regmap(dev, 
>>> cpu_msm8996_clks[i]);
>>>  -               if (ret) {
>>>  -                       clk_hw_unregister(perfcl_smux.pll);
>>>  -                       clk_hw_unregister(pwrcl_smux.pll);
>>>  +               if (ret)
>>>                          return ret;
>>>  -               }
>>>          }
>>>
>>>          clk_alpha_pll_configure(&perfcl_pll, regmap, &hfpll_config);
>>>  @@ -409,9 +430,6 @@ static int 
>>> qcom_cpu_clk_msm8996_unregister_clks(void)
>>>          if (ret)
>>>                  return ret;
>>>
>>>  -       clk_hw_unregister(perfcl_smux.pll);
>>>  -       clk_hw_unregister(pwrcl_smux.pll);
>>>  -
>>>          return 0;
>>>   }
>>>
>>>  --
>>>  2.36.1
>>>
>>
>>
>> -- 
>> With best wishes
>> Dmitry
> 
> 


-- 
With best wishes
Dmitry
