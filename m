Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9FBF51F97E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 12:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbiEIKRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 06:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231551AbiEIKRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 06:17:35 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DE027F118
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 03:13:41 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id u3so18718796wrg.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 03:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=GaL3qU7bb4pmLuktb+ToXSRDw1RPg3fK4StNqr8O7Jc=;
        b=Cnd8XL4p3KywJ1VFeWVLi3Mp7nqaMYuxgmKTvhDr8/YY2nNTwyb4eSN0K1EhWy4pC5
         KQ+88i5mg9/TCDwNowz2joE8vX49Tzkj2WYFEsdRNA8o0+tAa91+Cbnjj56eHwAJ8Aha
         bVETIz81lLjrwglyanJ3Vfkn7J+w19hCTuM9XjtjEtkMVdXGmv/4EGedf0/SJTCXSb3M
         J/ugrt5ePNJyDcS+/37WmKoCG2lsEiJPgG88JELuwIH08ge5y+MJlOX1/B3rxigpfl8F
         s/joObtLGx1wL2echropz4MCCqg3HRH8e+WqTiPeqy16Qdtkc8peg1J6vdkZdp7RrwuF
         oLqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GaL3qU7bb4pmLuktb+ToXSRDw1RPg3fK4StNqr8O7Jc=;
        b=PjisyGkZekWmT3wKQ4/ca62cyTiXD0JJ0JLyihAljF9OS0Mob3XcDTRq6GRxgkMwHZ
         i5EWOBMq+QcEJQurcUygMdOWw3rGz4oX58MZp4jczbXatR3yeczDFn3n18KkySonMHlN
         7xNYpoAAQBYExinOlHi4iHTG4TsSka7EBzzyuttJdG2zLDVU4TixEz4DlAddXeogjgKu
         eFAT0D8RLmL185+8tKdservIV9V9pBoNn7cxPncVq2TFRyMT7aAxSat6k06gfMNiTiBV
         I8zoNAuMaG39gt5FaJx8uvSnkyDCYlYEULYNS75UnIYSzu6V6h+2NeJAOcMdf6yM4Ot4
         M2AA==
X-Gm-Message-State: AOAM532x8dhzcyQ1pX1fLaQxVTjGnCQ9O/96WlOdlpIvEJd+IAs/dw54
        UlKCjLx7Vkqp/t2TiDkaCLOETA==
X-Google-Smtp-Source: ABdhPJxaRsRd1b6LMcq7fpAaqxNBS7p91qx1h/SxBc2ekN6EZDk3+R7aKcmlFH68RZT4BqwzylppNA==
X-Received: by 2002:a05:6000:186d:b0:20c:6b74:f31a with SMTP id d13-20020a056000186d00b0020c6b74f31amr13129777wri.286.1652091111077;
        Mon, 09 May 2022 03:11:51 -0700 (PDT)
Received: from [192.168.1.41] (176-182-171-101.abo.bbox.fr. [176.182.171.101])
        by smtp.googlemail.com with ESMTPSA id bu17-20020a056000079100b0020c5253d8e9sm9799243wrb.53.2022.05.09.03.11.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 03:11:50 -0700 (PDT)
Message-ID: <d7b562cc-4360-de76-f92b-8b435d11afa3@linaro.org>
Date:   Mon, 9 May 2022 12:11:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] tools/thermal: Remove unneeded semicolon
Content-Language: en-US
To:     Haowen Bai <baihaowen@meizu.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1651801831-24944-1-git-send-email-baihaowen@meizu.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <1651801831-24944-1-git-send-email-baihaowen@meizu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05/2022 03:50, Haowen Bai wrote:
> Fixes coccicheck warning:
> 
> tools/thermal/thermometer/thermometer.c:147:3-4: Unneeded semicolon
> 
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
