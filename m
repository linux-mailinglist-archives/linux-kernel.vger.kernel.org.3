Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE01583DCB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 13:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237152AbiG1LlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 07:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237281AbiG1Lk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 07:40:57 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691885F43
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 04:40:15 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id k11so1827987wrx.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 04:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZTE4cnVobwmiqOUoS9ukGmjCOG+lX5jwP+r9zIdwDR4=;
        b=POCt2LdXxGBz03FDFBw0TqGivbwIbMfy3yVn0vuquDPrOK51EiKmVXwPUuGsbI5Y3o
         //9o2GyvPB+UJ9t5A7r1v4n3gMDLNDcECNpqAyNY9XuZ7I1adAmgT+eGie172lemzll2
         VZTyqRdpKrDFrvuUYj7+NHwPUffQXOkyAAwOFklWw0mESAHY5n51/znIUcDHIAsWjjyB
         CqYYW1aCrzDukJqTyi1PsZqhrW1Q22v8gceNYThdJhzKBpO3NmQf4w4mSHIlfx4A99i6
         afRf9W0e12L+dHchYBiHfskWdktZwcuSivkE1yoCLKjKhPvhz1LhqcMuBpbTLqii+uP2
         0Syw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZTE4cnVobwmiqOUoS9ukGmjCOG+lX5jwP+r9zIdwDR4=;
        b=Yj8sLUWgnMjGj0CVlIJjdkPW1xcdqTZq4WldkLMXEZBLEGHCxTYrPriIt7k4d3pIzw
         hnJ3t2sgfWh8uDXQEpJWaQvMrU4lF3YivFKi0+BdTn5/sJcCYDi49tL6S3MaNxcJF4B1
         ls9wgYcVlOFYQttfLoxTWQ7xcRGtmSSFH2q8BZUqylDipCSnovDuXym913dQ8NBGQ/89
         rHY/FGrvrkWS5J8AqVMIUZ2majJ0Tww3btYNQNrlq0yoBTvCjeKjff1VZjC9pw1hynIQ
         ehpiRFCRXyOG+zuTeEomyhEBCj9OPP1i3514gOkbXihqny4xci0ojAvU+m011eGew1ns
         2+xw==
X-Gm-Message-State: AJIora8iVjenaK9qSLWpSIvgmnSqAVDpSpVelp3AEQGdNAXo5kPAheJD
        1qA7AUklu1E+JfLeJYe5vyx/rQ==
X-Google-Smtp-Source: AGRyM1vYKooOSjgWwIWNujjfVy6VuQq0Lw3mcwRtcB1YbS1NSaJR2CGc58Mg2l7pDrGhc3/H3W2OmQ==
X-Received: by 2002:a05:6000:156e:b0:21d:c50a:7cdb with SMTP id 14-20020a056000156e00b0021dc50a7cdbmr17180485wrz.16.1659008413733;
        Thu, 28 Jul 2022 04:40:13 -0700 (PDT)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id r41-20020a05600c322900b003a2e89d1fb5sm4444116wmp.42.2022.07.28.04.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 04:40:13 -0700 (PDT)
Date:   Thu, 28 Jul 2022 14:40:11 +0300
From:   Abel Vesa <abel.vesa@linaro.org>
To:     XU pengfei <xupengfei@nfschina.com>
Cc:     Kernel@nfschina.com, agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org
Subject: Re: [PATCH v2] clk/qcom/gcc-sm6350: Remove unnecessary semicolon
Message-ID: <20220728114011.2fztt7htj6ekwiz2@linaro.org>
References: <Yt5FAJiEv0WWuDNV@linaro.org>
 <20220728090719.3056-1-xupengfei@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220728090719.3056-1-xupengfei@nfschina.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-07-28 17:07:20, XU pengfei wrote:
> Remove unnecessary semicolon after qcom_cc_really_probe call.
>
> Signed-off-by: XU pengfei <xupengfei@nfschina.com>
> ---

Thanks for this new version, but there are still some issues with it.

First of, don't use slashes in subject. Use semicolons instead.
Have a look at how other commits look like by running:

git log --oneline drivers/clk/qcom/

Also, do not send subsquent versions of a patch as a reply to old ones.


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
