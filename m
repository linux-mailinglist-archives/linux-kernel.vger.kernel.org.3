Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7727B5AB8E9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 21:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbiIBTgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 15:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbiIBTfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 15:35:55 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822BAD87E0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 12:35:52 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id bp20so3036569wrb.9
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 12:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=T/yia6VscjVg9lKFE0AZwhYiMtREgLkGPOBsdI4ZOMw=;
        b=eGWa7bKHYl2Nz+WSVKuek/89mZFFJO04byxlX4ef3ZKdyHmKWjt8V5HSKcA0SO7+BB
         8sezSC+tip0hoL50+gA90+17rq34nljG+JylbfYIKC+nCrl1fT6LgBNdgmplZ2D9lNBC
         IwHbGwqnNi1xacWEei/qzP0xdhqkWKCCn4bIjVN7jo0NdhIl9k14RIjZ0nrDGt+et9L0
         y6sca1h7IsgXoN8sxmQC7+yBhJshVjbRPyOUVHVxPtqr59bhFTeVfz7djyNGg+GFbBZK
         l3aN7WN82xLn4ziGTpSlSE1WY94+QS3ju9Rl+kqUDrV4xYe+Sb9ez1o4Urx941zb/tTQ
         yvjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=T/yia6VscjVg9lKFE0AZwhYiMtREgLkGPOBsdI4ZOMw=;
        b=glCRLDOXzx/vaB2HmB23SkxfVrocmMQd1Mdiih5468AKEcQCeqAAChBcLvEYjvvS+X
         +QwTCNPAsdyWoL1/6gtwrpw9rIYcGGnx0zhDdjn/e5ajoPny45J6cTvZwdrfNmPxPuvz
         72GCNaVQwImc9RQg9gmXmE+601olUQ8K/aCF7MVxLXlhhaMFDC54soKJWAjqsi8tnlcp
         VKcjjCAPN5IiOXNwDd3H8Kkg1QzgPvf/e/5CmbT2qZRwublYqJsSC/s59prZcdLlCeMl
         5yHA6v/wO4LsoVoFYYH3LLtQjz02TflJj31074nyEbZb3txB1LnDkrEewOcaxAVSdhT1
         zYhQ==
X-Gm-Message-State: ACgBeo2PJ3lk3zYyYboWD2z6ud9KBN2b/TncFVQIIgkENASJINeCcndd
        SnQN8jMBRySa1S/9EY/4EnWJXg==
X-Google-Smtp-Source: AA6agR6fwsbL5snUTUdHCaiK0SNJivEidWO0mT7PNvT5SeOJiRU3048OfxhzYCccpXyv/2u1SpCrFQ==
X-Received: by 2002:adf:f592:0:b0:225:2f5e:6a99 with SMTP id f18-20020adff592000000b002252f5e6a99mr19302290wro.593.1662147350584;
        Fri, 02 Sep 2022 12:35:50 -0700 (PDT)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id bg15-20020a05600c3c8f00b003a4f08495b7sm10552034wmb.34.2022.09.02.12.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 12:35:49 -0700 (PDT)
Date:   Fri, 2 Sep 2022 22:35:46 +0300
From:   Abel Vesa <abel.vesa@linaro.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V3 0/8] clk: imx93: new gate API and composite update
Message-ID: <YxJbEmO7oI3wNll2@linaro.org>
References: <20220830033137.4149542-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830033137.4149542-1-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-08-30 11:31:29, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> 
> V3:
>  Add R-b
>  Drop of_match_ptr in patch 2, so I drop Abel's R-b in this patch.
> 
> V2:
>  Add A-b from Rob
>  Add a new patch 2 reported by intel test robot
>  Use Abel's new address for sending mail
> 
> The current clk driver use gate API as i.MX8M*, the gate2 API use 0x3 as
> val/mask, however i.MX93 LPCG DIRECT use BIT0 as on/off gate. So clk
> disable unused actually not gate off the LPCG clocks.
> And i.MX93 has AUTHEN feature, so add a new API to support i.MX93 clk gate.
> 
> i.MX93 CCM ROOT has slice busy check bit when updating register value, add
> check. CCM ROOT also has AUTHEN whitelist, so add DID check.
> 
> Besides the gate/composite update, add MU[X] and SAI IPG clk in this
> patchset
> 
> This patchset has got reviewed in NXP internal, so I keep R-b tag here.
> For those that have some change compared with downstream, R-b tag dropped.

Applied all, except patch no. 2. Will wait for Stephen to pick that one
up since it is a fix and so it might need to go through his clk/fixes.
If not, I'll apply it to my tree along with the others.

> 
> Peng Fan (8):
>   dt-bindings: clock: imx93-clock: add more MU/SAI clocks
>   clk: imx93: drop of_match_ptr
>   clk: imx: clk-composite-93: check slice busy
>   clk: imx: clk-composite-93: check white_list
>   clk: imx: add i.MX93 clk gate
>   clk: imx93: switch to use new clk gate API
>   clk: imx93: add MU1/2 clock
>   clk: imx93: add SAI IPG clk
> 
>  drivers/clk/imx/Makefile                |   2 +-
>  drivers/clk/imx/clk-composite-93.c      | 171 +++++++++++++++++++-
>  drivers/clk/imx/clk-gate-93.c           | 199 ++++++++++++++++++++++++
>  drivers/clk/imx/clk-imx93.c             |  32 ++--
>  drivers/clk/imx/clk.h                   |   9 +-
>  include/dt-bindings/clock/imx93-clock.h |   9 +-
>  6 files changed, 402 insertions(+), 20 deletions(-)
>  create mode 100644 drivers/clk/imx/clk-gate-93.c
> 
> -- 
> 2.37.1
> 
