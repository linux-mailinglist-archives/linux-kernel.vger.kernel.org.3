Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0281F51AC35
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 20:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359484AbiEDSHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 14:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357552AbiEDSGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 14:06:06 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67FFA4FC77
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 10:21:20 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id s18-20020a056830149200b006063fef3e17so1306581otq.12
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 10:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WCQd0BEkr2350zVHaq5lFX9i48jak99a6vqhtPevMLA=;
        b=fEKIAgKrPc3/Mqs8Fm9yoZwBQC9zu/F7t2r6+oEyIkgkGwg0jOe5SfeIj3DMsa1Up7
         AoG/M4xa9coTvnuHJYFlvQ5IAK0RtIqEa23aODajOCTQpz33cjKnwL1n/xLPwXbfd2Tc
         FH7r/sG/zdt1tSZz6uEZFGDQQnewvhfkeTNXe89i7/Sng2ym25yxlMiLVi7hgWB7g88i
         6SrQZpvy8JBBd5a3hAVgTOSMmSY4EhPSXgLuXcBaNCFWHRe3qefcLhTCSwGFZxpBT3i6
         M//ch3+ztRLkltCQQS6j2gkEWWRBj4UrdPi7nSEEmvSingrvRtl1GJ0cVF2XmljbkbTA
         OGRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WCQd0BEkr2350zVHaq5lFX9i48jak99a6vqhtPevMLA=;
        b=63VKkmORIhc3HWrEQqnKwy6XNHvDBHZf9Pzuf7cu0rpZfdYHEk4Umq9PBAMJZhQPtr
         2AqiOiQu+eZjEATKnbJrOpLtfBPqhK1yj5iErnaKNqPTe87Q92HL8YNhxF5pmmfoBjd6
         vazVfdDFrck998AOoKVPhziKaryJ/Ez7qj2NouJsJIdxCjm5bwjeRYvs09kl0X2PzaBT
         M7LF8KEWo0DtHgN8SH16q42OUrSLAkSVrblkhVS8fkBEBTH6yxuU5QGbgy8C73PsUnOM
         nTyKXAdDrPZFe+TXtyJ3T3dNoGVuAYYUH346JFv9VUjh+6u+/cvadUxrrONHwxZLwa7c
         3kTg==
X-Gm-Message-State: AOAM530zubk6IPl2J3kry3hzhj1kz6coGpvpIVOQ2lLh2RUjnO9GCsKW
        C6h8uxufADQlqisISYztlGLYgQ==
X-Google-Smtp-Source: ABdhPJzYJ0FPCVUpXpj95XbIPDCcfuiWkIiq8GSf0HrRowwPJd5pm70bchb1f7meCo0CrJS5bAyQ0w==
X-Received: by 2002:a9d:6956:0:b0:605:fcae:3240 with SMTP id p22-20020a9d6956000000b00605fcae3240mr7564614oto.280.1651684879703;
        Wed, 04 May 2022 10:21:19 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id a7-20020a056870b14700b000ead8b89484sm5785452oal.5.2022.05.04.10.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 10:21:19 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Adam Skladowski <a39.skl@gmail.com>, phone-devel@vger.kernel.org
Cc:     Stephen Boyd <sboyd@kernel.org>, Andy Gross <agross@kernel.org>,
        linux-clk@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org
Subject: Re: (subset) [PATCH] clk: qcom: smd: Update MSM8976 RPM clocks.
Date:   Wed,  4 May 2022 12:21:05 -0500
Message-Id: <165168485226.3730817.8622970582930057500.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220426090226.27293-1-a39.skl@gmail.com>
References: <20220426090226.27293-1-a39.skl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Apr 2022 11:02:17 +0200, Adam Skladowski wrote:
> MSM8976 does not have rpm clock named mmssnoc,
> instead it's called sysmmnoc, drop define and reuse.
> While we are at it add XO clock to list.
> 
> 

Applied, thanks!

[1/1] clk: qcom: smd: Update MSM8976 RPM clocks.
      commit: 665ca429bc4131f9165f119ad3ed81c786bf3262

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
