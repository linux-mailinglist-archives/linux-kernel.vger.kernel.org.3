Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062B54C81F6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 05:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbiCAEK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 23:10:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbiCAEKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 23:10:54 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF865881C
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 20:10:14 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 132so13386870pga.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 20:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hpq5GjZQptAKkSMdcyQQi01o9oZPsYgMqwCWekmi7Sw=;
        b=mYhpr1HhK5yiockpEnRo39R84MNVHzkyfh4CMNhCboaf9hf5Ppb92sKJPhWXue2cUs
         8ip8D+dWTx/OQ2Bie4OmdqgD6uib7SBwoTIaw6b4zJVUbNKiOZ/AW2pTuFHMf/YXYmxB
         cUHtaOwrr/qu2w9+8F5Ea36SQXpx5hpusCTwi8msGuCvgmS3f4a0lPa6D788YUvY52o4
         3UGGmyoNbyBspSInI7Eiy81mCMIUUyvakq51xmZdYL13bNTsDrZRqf44avBMAvm2hXjT
         oiXA1IMjF+J1wSZqtKBM6n+UZ3tmactKaq3GDUCr2Rd8fm97UpqBTPeylr9QTmDtKFNm
         dD7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hpq5GjZQptAKkSMdcyQQi01o9oZPsYgMqwCWekmi7Sw=;
        b=dEXXkM/+NvaPiiSl0fM7K7SOsBhAw+eV+vhXXL+7yv/DPfZr40JS7tNxPip3UDaa8k
         7zi+o+Y0F5GDU65T+hqAm1/jrrVie4vWnLlg6JzOHvhytPAReX6YZ/ts5gzNiUSBmZSr
         iUFT9IQwNMXX6hwcdRMBJJZmYew2QZ2VZlSPpHsnYzrZRX30nSUAPLRSDFntm955wGQL
         Jf3P7H3WcOO6I9n/9YYvOrfIpF+mFPlkmBEs4IGwoD3P56cigRarZZD5f2vxSqw3i6c8
         WLBFBAgCfsNG8uQZ8f0HyPVfATYPSFz/08NynBQJaqATH7wlFrNZHx+thbffPMvjtUqO
         PCyg==
X-Gm-Message-State: AOAM533qR5JmogBe7LiJDOsQ/g9R8x6K2zGwkbuBFRwvIlkHvQVgt8Pi
        FmpWetXulWwLJgAv1OCexOuLnA==
X-Google-Smtp-Source: ABdhPJxr5ZEqJaOMmcWja5H0Gd1DkSWwOqBmNmOEwJfnm+P7g8ImFFG77VVs0E0czWTsglqGhk6PSA==
X-Received: by 2002:a05:6a00:887:b0:4f2:6d3f:5b53 with SMTP id q7-20020a056a00088700b004f26d3f5b53mr25552345pfj.21.1646107813698;
        Mon, 28 Feb 2022 20:10:13 -0800 (PST)
Received: from dragon (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id j13-20020a056a00130d00b004f1025a4361sm15254811pfu.202.2022.02.28.20.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 20:10:13 -0800 (PST)
Date:   Tue, 1 Mar 2022 12:10:07 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, bhupesh.linux@gmail.com,
        agross@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, vkoul@kernel.org,
        linux-phy@lists.infradead.org, robh+dt@kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 5/8] arm64: dts: qcom: sm8450: Fix qmp ufs phy node
 (use phy@ instead of lanes@)
Message-ID: <20220301041007.GH269879@dragon>
References: <20220228123019.382037-1-bhupesh.sharma@linaro.org>
 <20220228123019.382037-6-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228123019.382037-6-bhupesh.sharma@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 06:00:16PM +0530, Bhupesh Sharma wrote:
> Fix the 'make dtbs_check' warning:
> 
> arch/arm64/boot/dts/qcom/sm8450-qrd.dt.yaml: phy@1d87000:
>  'lanes@1d87400' does not match any of the regexes: '^phy@[0-9a-f]+$', 'pinctrl-[0-9]+'
> 
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>

Reviewed-by: Shawn Guo <shawn.guo@linaro.org>
