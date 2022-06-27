Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC6855D383
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236976AbiF0OTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 10:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235267AbiF0OTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 10:19:20 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32379101C2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 07:19:19 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id s1so13273102wra.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 07:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=OxTd7fdB6orfEASOGRyD2CfOAQhkret3W6VljUETf1M=;
        b=NS6T8tGOanPvusQZQFpHrG/sAvxIq/6eSzqfUCeEANZuMeuKbKRTbN/Y1X9f+r88kE
         wMNLhqG07GbwEMIL40+N/ZdQYoDhstEKrtRX7X4dWcZfAq4t20zltTrWwDcLfGUE1NWx
         LfQwWfxqij3zklxD8ItxmvIAMQt0uknsoxQemqhQGilZOjBZmJlk+spsx2uMNvg5+ArS
         J4XH3Hy8088/nd7FxJQoDH40PI1ClLYHLOce7wD/FU10P7VA/3rkWS4cd9zkJ74DeJMx
         87ajY7eH+5iJfUNym1nmiCMwbXMs3vOzdA/zRWOFDT3Xs2mHnnkyHX0oRO0eT8FB7v6K
         XBSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=OxTd7fdB6orfEASOGRyD2CfOAQhkret3W6VljUETf1M=;
        b=fpGuDckCQGSyrMwWQ9r5B7W6h2Cya54cmRjFU5EFr6HPA8c4oUB9PJhUoi64vTZX7y
         2/Al5Qf7qmmnZBoDtiNMDh9lOmd3oxMh2Et7vDhSkyL6+gII7z2PmgSqrEPU9PgiH9qT
         2L5tMzPL2E9Od5FWapGnN9PTejKLEeHJvyUUVRW0MzWU8auWegsYoIQtoqSfZO7tgxZY
         XGW0w+KHmge0Dq3zUnFbCaRpmAa2OMgs5tsqwsUfYFYvAHtKeIB5zX4YqBxI93abwtPt
         OF9ZwP17ljgwBqCQ99LWrWAo2Chz/AdeYkvXbMH8U+nvq+lJ4Vyndm77miCME4yTvFW7
         eMow==
X-Gm-Message-State: AJIora/iec3eHIL2BHEvOBTHmszbA0y/NLMWp4lTASzyk0SRDU4FB27P
        TKNQhsj53mZ+sHM0nWfC7k2TmQ3C2T+w/A==
X-Google-Smtp-Source: AGRyM1uN+zaVAdP/+/bAUqfFx2/h0MdRJVlYR9m3wnoKZzjycVN+sYCuBmidtVli+dLsQEubkezMjw==
X-Received: by 2002:a05:6000:2c6:b0:21b:ad25:9c1b with SMTP id o6-20020a05600002c600b0021bad259c1bmr12966628wry.391.1656339557775;
        Mon, 27 Jun 2022 07:19:17 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id y12-20020a5d4acc000000b0021b9416fa13sm12041034wrs.90.2022.06.27.07.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 07:19:17 -0700 (PDT)
Date:   Mon, 27 Jun 2022 15:19:15 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Zhang Jiaming <jiaming@nfschina.com>
Cc:     linux-kernel@vger.kernel.org, liqiong@nfschina.com,
        renyu@nfschina.com
Subject: Re: [PATCH] mfd: Fix spelling mistake
Message-ID: <Yrm8Y+ACttPIaGFe@google.com>
References: <20220623073333.5675-1-jiaming@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220623073333.5675-1-jiaming@nfschina.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jun 2022, Zhang Jiaming wrote:

> Change 'receieved' to 'received'.
> Change 'recieve' to 'receive'.
> 
> Signed-off-by: Zhang Jiaming <jiaming@nfschina.com>
> ---
>  include/linux/mfd/ipaq-micro.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Patch subjects to mention the sub-device they pertain to.

I've fixed this up for you this time.

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
