Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DEC75716D6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 12:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232978AbiGLKLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 06:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232931AbiGLKKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 06:10:32 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A2AACF65
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 03:10:01 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 19so9299579ljz.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 03:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0ZDFQ2Um/nbZ3y2xNR8xPwRUF9abK32syd+qjiX1zSk=;
        b=BSY4pUelNP4h5Wr+dYRA14v6b719CrwYFbUUC+l33kYLjDo3Hdf56rKyLWfWRrP2cV
         WZVZASV4qdF1Ur2mFtYAgAd4D6xb5cekT9yEvcZQH9qt5VQGndqNago7Il08cphBt5t9
         DA4WN8380FtDEOHE8rbnqjhIhjHSRtWNMJys36YCLLLIiYZOG3MFsSpOrKbqKMj6HXWa
         7LiIQ7V4eDxM1WkeL4mUGvBNRcl59FBtL9csg4luoUTki6UiNCIWXi72AH2r+tQlgVF1
         GBygsZ+6vfKOYx6Frtq0xeQ+ZUQqalMxpIElz/NSWTN6fNN4t+m0UWYIK9/WuICNReNu
         EK3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0ZDFQ2Um/nbZ3y2xNR8xPwRUF9abK32syd+qjiX1zSk=;
        b=KQzWjdW6UsZGR8+nC0o4/Y1aZ05/FLsY/KHM1VDs952Z9MxRg/1R2wn4eSY7WDcnsY
         Z4GA44ud8ehARi7sOrILcnKeouS0KV+RO8zHsgAVL1WpuYf9b9VJUCz3hLB4PbldlyOD
         rav15bumMcFiXFaJ1iqe+v8uY72LjvYpvHh1UcUF8Dahku39QAL+7aBGQ3DuXPHwqSlv
         Y4ZlIV3GT8sck3HmY8aHKvoysnsFO7FaGfvkYzC0Kpp7c/0RINz/bGYXn7ZwqIPjs5e7
         d+cQ8dx5Clr2paRTMYpS6zc9EacGNxJp9KN0L5KXFxxz/mLQ98mkqk9w2dRLesR1wRz+
         2xUQ==
X-Gm-Message-State: AJIora9NLrQP+lEei9rYSaWMb/tP/xvVoRooh3E5IQQsbI0sd0gr8jf1
        4kew1jjR2llqgMS6vUkFa6UHvw==
X-Google-Smtp-Source: AGRyM1t7I/+8lbJvJ0cWSuayauSODbhAXQyCBBXSKtzRJjwHCj1HjP3OHPvkO85FAWFhkAlkIi8Afg==
X-Received: by 2002:a05:651c:1078:b0:25b:ef62:8387 with SMTP id y24-20020a05651c107800b0025bef628387mr12125381ljm.185.1657620600014;
        Tue, 12 Jul 2022 03:10:00 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id a4-20020a056512390400b00489c8110197sm2099589lfu.242.2022.07.12.03.09.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 03:09:58 -0700 (PDT)
Message-ID: <bcbd1b29-7c6d-1d1d-2c72-b8818e99c65c@linaro.org>
Date:   Tue, 12 Jul 2022 12:09:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 6/7] pwm: dwc: remove the CONFIG_OF in timer clock
Content-Language: en-US
To:     Ben Dooks <ben.dooks@sifive.com>, linux-pwm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>,
        Sudip Mukherjee <sudip.mukherjee@sifive.com>,
        William Salmon <william.salmon@sifive.com>,
        Adnan Chowdhury <adnan.chowdhury@sifive.com>
References: <20220712100113.569042-1-ben.dooks@sifive.com>
 <20220712100113.569042-7-ben.dooks@sifive.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220712100113.569042-7-ben.dooks@sifive.com>
Content-Type: text/plain; charset=UTF-8
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

On 12/07/2022 12:01, Ben Dooks wrote:
> We should probably change from the #ifdef added earlier in
> 49a0f4692a8752c7b03cb26d54282bee5c8c71bb ("wm: dwc: add timer clock")
> and just have it always in the dwc data so if we have a system with
> both PCI and OF probing it should work
> 
> -- consider merging with original patch

Missing SoB. Please run checkpatch.

Best regards,
Krzysztof
