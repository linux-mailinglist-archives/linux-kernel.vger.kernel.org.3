Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD824B51E0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 14:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354395AbiBNNkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 08:40:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbiBNNkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 08:40:08 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B9F4A3CB
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 05:40:00 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id l67-20020a1c2546000000b00353951c3f62so10868665wml.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 05:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=rMeJGTPLV4p5Tp7DaVbfqVcY08kZOJPbVdTXvGtRNBc=;
        b=aTQvC94T+4hLmbUP5ne+1nnxGO5slFq/CcjZI53DJsx12d9mFc9B+m6jrQG89VZBWr
         Q00Io8p1gyLzlk6LFKMN1bfDB0FwT7QcsNPOoww7eU3PbhlsGGNVIyVn5FaSIJtu3/fQ
         OwgIqecL3sadqGvoyNpHaoP6FbyT8gyZY8tBbCWBO6dJWIBYhBE+3amKT+CpXoUi/7Ve
         icUFYEQjnid26p21bDAYZN/Yv7S5tdAGTpAsqOw1N7aPSSRTdjFBNgwg1MAy2g1cFDDs
         YoSrtrJZQV6y/cSVTPa6mjHEHP/2s1XlcJOkPQp9lpLbX/WPlxd93pLvoLkLmatCJxW+
         PpZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=rMeJGTPLV4p5Tp7DaVbfqVcY08kZOJPbVdTXvGtRNBc=;
        b=yEYFWfeUEifAJfkjL+kZYiLfEW+vBDv5axMz/ta7mhS5ltfXkgK8lHDNAkZLYM3f+Q
         Nzu4z3DpcmHjrEUxgrTXV0SS1qHtXGM9H3e21ueJ6+uYq8v4+IJia62Hmujj5AVcv4Ym
         kGkHBMzJlAfNjiEpfRo8twPM342WUPtKvWQQK9P3EcQJibDSaBRlDRjX8GJjcnIRZc9z
         M3+MAx/8BLAI2nOImQ23mVuatxYu3cqaauEw6a7a6GR1Frq7aAYrWnoosnylQHjrHfNK
         IXaZySjxZX/nKVcoBlXiyAvmXTMBuSLkjhsYjQ2J7fbk4ZouVlx7jzbY1kidZr4hUX3I
         4U/w==
X-Gm-Message-State: AOAM531Sf/q5vX3MjFp+JQFP9FAqCapkXzDP+KS29/r8BraaKYh2HCBp
        n5aMloMHofKeIjR0hLE4Jc6h7w==
X-Google-Smtp-Source: ABdhPJyDZTKnKIpflWM8nlDBTCK9MeSmS3Ct60VsMMPiP3Dsw91w5J79nOlLruKTTROA4E2LwFGqog==
X-Received: by 2002:a05:600c:3c89:: with SMTP id bg9mr11215826wmb.194.1644845999574;
        Mon, 14 Feb 2022 05:39:59 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id y6sm3577479wrd.30.2022.02.14.05.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 05:39:59 -0800 (PST)
Date:   Mon, 14 Feb 2022 13:39:57 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Johnson Wang <johnson.wang@mediatek.com>
Cc:     robh+dt@kernel.org, broonie@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH 3/4] dt-bindings: mfd: Add compatible for the MediaTek
 MT6366 PMIC
Message-ID: <YgpbrWEwCtCQlez+@google.com>
References: <20220106065407.16036-1-johnson.wang@mediatek.com>
 <20220106065407.16036-4-johnson.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220106065407.16036-4-johnson.wang@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Jan 2022, Johnson Wang wrote:

> This adds compatible for the MediaTek MT6366 PMIC.
> 
> Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
> ---
>  Documentation/devicetree/bindings/mfd/mt6397.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
