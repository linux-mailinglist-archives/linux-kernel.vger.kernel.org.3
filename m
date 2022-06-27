Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43BBD55C1A7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241130AbiF0UP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 16:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240520AbiF0UPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 16:15:23 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DC91D306
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 13:15:22 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-101d96fe0a5so14390560fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 13:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3blwfZZTMRBH390nLectWFhgIDm492Spnq2Xbbt6JLs=;
        b=WwMLVEADRqo0P379S218zDtekCtrer/BHLyL1Q2GaVLMcC5xK9GWWt7DxKFdvVZVnZ
         FejS5WV95S3MzGXd57qtDbBRWVd/tn+PYMXOlPxV48dS0NOa4SjR1EffahaZGmf1Jhcr
         eziLCY/lyiwqwkZYBgZkxclzxmmrH9tRF7uyCDs4xsFD+1LMMGG7LFpoEI+RvldIqm3e
         09xfsDIVVV6s/cWINSeGZi9zUrbBZF08G2i2qTyvOOmst+4WJg9Sq6ePf8noRA5QB1AE
         2xVqZ7v6vPUmbVC73zoANim7if9CR/SVuolDXeVO+Kxd5SP7VZLyM0TRkIuVPhdt/ZhO
         H3vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3blwfZZTMRBH390nLectWFhgIDm492Spnq2Xbbt6JLs=;
        b=YOVYxix0wjr4krVbNucf2ieTQF/xT1Thqn3cnqdLLG3iLH2tAQW0Xyj9I9DGhYGzaI
         iSQKglSX1HnKM2zdo9RzWhBIR7n8knF63yQQFtlIaUw4/DgDuuj3ca0AchZukpK1/fpW
         hXpET+zys+iES3ItnnRcEukZQ4sq/UScYk1wrd1nS/UpAclKLt2857dNm0O7/Zd0bVfx
         4Xs/GQ9yxULsc9Zy2GDleSqQLlDLcCbJDEiywI4bDWrlNrJsTrziLNCU5wyC1E89FuWy
         CNoIQxv11KlbR7gYTeXct+v6YPdPSwbxifu9DV/b2JJd5oMWSY4gQqituuFtlV2psDtA
         AcAQ==
X-Gm-Message-State: AJIora8+aDC9TKciRdGLV9nzqaQP4t/zs3wygcaMPUxonxkzdeY+zlBh
        rkkpXX+ciu3ljQZocUcwqTmzxA==
X-Google-Smtp-Source: AGRyM1s6/0wpqNUDQhjiqZ+M7gqbWaoTWXguFmAH0NmwWfEtd/aNBLP+yimen/s314Wj9uF8MuPn7g==
X-Received: by 2002:a05:6870:430c:b0:101:f886:3760 with SMTP id w12-20020a056870430c00b00101f8863760mr8002029oah.88.1656360921523;
        Mon, 27 Jun 2022 13:15:21 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id a18-20020a9d3e12000000b006168dbb001fsm6731199otd.7.2022.06.27.13.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 13:15:20 -0700 (PDT)
Date:   Mon, 27 Jun 2022 15:15:18 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Li kunyu <kunyu@nfschina.com>
Cc:     agross@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: the return value statement of the
 gcc_sm6350_probe function has an extra semicolon
Message-ID: <YroP1pW3dzoV9F4D@builder.lan>
References: <20220627020500.135125-1-kunyu@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627020500.135125-1-kunyu@nfschina.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 26 Jun 21:05 CDT 2022, Li kunyu wrote:

> I think this semicolon could be deleted.
> 

Thank you for the patch Li.

Please look at the git log for suggestions about the prefix for your
commit subject (clk: qcom: gcc-sm6350: in this case).

I've updated the commit message and picked up the patch.

Regards,
Bjorn

> Signed-off-by: Li kunyu <kunyu@nfschina.com>
> ---
>  drivers/clk/qcom/gcc-sm6350.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/qcom/gcc-sm6350.c b/drivers/clk/qcom/gcc-sm6350.c
> index a4f7fba70393..69412400efa4 100644
> --- a/drivers/clk/qcom/gcc-sm6350.c
> +++ b/drivers/clk/qcom/gcc-sm6350.c
> @@ -2558,7 +2558,7 @@ static int gcc_sm6350_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	return qcom_cc_really_probe(pdev, &gcc_sm6350_desc, regmap);;
> +	return qcom_cc_really_probe(pdev, &gcc_sm6350_desc, regmap);
>  }
>  
>  static struct platform_driver gcc_sm6350_driver = {
> -- 
> 2.18.2
> 
