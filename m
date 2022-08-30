Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 018A65A6EA0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 22:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbiH3Uns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 16:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiH3Uno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 16:43:44 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7AF27FE0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 13:43:42 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id bq23so17168470lfb.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 13:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=zpTPbh+6FTpWjU33//CbUrbH55r5RpLUSqoVVWTiTkg=;
        b=pQd2svsP6AiR6HSTgGGNL7C2Z41Cr+giRe+jvUNzgWqXWB5gyTRpD6hQ7QjxyBDLmk
         kEZm17wyCgjgSJ0qaTchdgwTlPDbgUUbirEHP7JMYPqEIHKII68IzTj73W/6GOsVlasC
         1kOU/omAvQMJtW0F/QBVyDRwyf1fsyVXl+Wc0wuuAzFb/XnvdmTsHkZIaAVDJVMTTNtt
         4FrxcOZbOtlYVKL96zhHt1Uow8Z175SmbPyGDcbVW6ZOM1yGpDi23R9WaRO/iSwmgT+b
         2zw4zmuFI1782Vt03Hy5crt3m1VTjSG6rUZ4FhJzjjLVKiMILaIR3Q/wrEq6+moXIHDh
         XWhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=zpTPbh+6FTpWjU33//CbUrbH55r5RpLUSqoVVWTiTkg=;
        b=EdZ5aDtc6lXVnj9V9JjSoEWS8OAxYZxdlA2pm/I76/NQgA30HGO3OPz7sSqW2qlicb
         eo5maHCJiO3nf9I8Br39yHMak2V1c+1jJdiMRuRBtdXvcAEgKOxC5Fuknwvqyw3YNyKl
         Cx5w279zQILEA2DEdd54KMK2BhjVu4eLw6fFQC0rA5C/Ewd00DsAKQLjAPDgE1Akym+Z
         Fpx68lnC42mcNLxpaG/LBUWvwJo+jxO8YJEmTeXd8GgxAoNZwdXpLXl8K9in8h2MUA98
         FKrMqkZgUOcnNQHvA2OrbL0DML/eGWpRbBaUIyadLkJ6qlx5kzvJniyd5h6M8f21bS6f
         +Atw==
X-Gm-Message-State: ACgBeo3kCaAX/5vPqLwH6kgcvZo1yYr/701s9+yPL+gXZZPEtHUGzplB
        FBHx5w4Y6IJ9zC42OkPLSKoTqQ==
X-Google-Smtp-Source: AA6agR5TQdXplaX1+ZJ7P+5UuosDsU+hXEk3qfcGOu4a7qmInmeR6MkJlKrM6t5jZHhl01ECVVOaig==
X-Received: by 2002:ac2:5fb2:0:b0:492:ea4f:b73c with SMTP id s18-20020ac25fb2000000b00492ea4fb73cmr9008383lfe.296.1661892221227;
        Tue, 30 Aug 2022 13:43:41 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id f13-20020ac251ad000000b0048d1101d0d6sm1720449lfk.121.2022.08.30.13.43.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 13:43:40 -0700 (PDT)
Message-ID: <c2559d11-3169-454f-8376-e4500c4e7de9@linaro.org>
Date:   Tue, 30 Aug 2022 23:43:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: build failure of next-20220830 due to 5f8cdece42ff ("drm/msm/dsi:
 switch to DRM_PANEL_BRIDGE")
Content-Language: en-GB
To:     Nathan Chancellor <nathan@kernel.org>,
        "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        clang-built-linux <llvm@lists.linux.dev>
References: <Yw3V8yJgAnPD8o6P@debian> <Yw4FQm6V7d3MuMKG@dev-arch.thelio-3990X>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <Yw4FQm6V7d3MuMKG@dev-arch.thelio-3990X>
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

Hi,

On 30/08/2022 15:40, Nathan Chancellor wrote:
> Hi Sudip,
> 
> On Tue, Aug 30, 2022 at 10:18:43AM +0100, Sudip Mukherjee (Codethink) wrote:
>> Hi All,
>>
>> The builds of arm64 allmodconfig with clang have failed to build
>> next-20220830 with the error:
>>
>> drivers/gpu/drm/msm/dsi/dsi_host.c:1903:14: error: variable 'device_node' is uninitialized when used here [-Werror,-Wuninitialized]
>>          of_node_put(device_node);
>>                      ^~~~~~~~~~~
>> drivers/gpu/drm/msm/dsi/dsi_host.c:1870:44: note: initialize the variable 'device_node' to silence this warning
>>          struct device_node *endpoint, *device_node;
>>                                                    ^
>>                                                     = NULL
>>
>> git bisect pointed to 5f8cdece42ff ("drm/msm/dsi: switch to DRM_PANEL_BRIDGE")
>>
>> I will be happy to test any patch or provide any extra log if needed.
> 
> Thanks for the report. I noticed this yesterday and sent a patch:
> 
> https://lore.kernel.org/20220829165450.217628-1-nathan@kernel.org/
> https://github.com/ClangBuiltLinux/linux/issues/1700

Updated and pushed the branch to unbreak the linux-next. Thank you!

> 
> Cheers,
> Nathan

-- 
With best wishes
Dmitry

