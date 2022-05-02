Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E80B516B10
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 09:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358387AbiEBHKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 03:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233181AbiEBHKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 03:10:38 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF2B1F603
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 00:07:08 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id t11-20020a17090ad50b00b001d95bf21996so15399386pju.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 00:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kYH0ay76Tay4ZAMs5UYFoGZVb+b5goR3w/zMZTj8gCk=;
        b=aK6LO2mx6Tc/Te3W9vE0J3iZzladGLc0QGogAbCC2IAOSyLYNWlf2WwS5fQw5SxSsK
         TcIzEsWgdkwJARJ8nVExSz5/x7Nyjb+7AUOlVvI0Gwomek8Suq+vnVZXmWo75X/rDxkB
         v6RqL7jqhBGY27gN4qf9cs/LgpFO4/HJWa25n3ZNH9CUleb7vaj94IL7R51Nkp26Av42
         HPxxoxqHw5iQFOppJjVdXKLSvphY+/V44M9b0HoK80rxWlMMuthsFselFlSXnJ075hQu
         JN58/lIrszE/8mO2bI9v86tR2pdy6O5CtRotLtiCbHScj5cQzWCZwYv0fARBiQsagq/m
         oABA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kYH0ay76Tay4ZAMs5UYFoGZVb+b5goR3w/zMZTj8gCk=;
        b=m1p1VLPt9LYk35kveFR5vtQzGmAENKzhwlhXKZQoo6lXcYCYqkYQ57QTcrY28NhzIM
         wg41T+l742iGf8hEyDqfRMdfSQpKJ15zrFowbSLeU5YQR2R8nffX5BSIPLkPZQ5hlaGi
         Ui/e4jMrM/YrWGPP3AesyRAUUFyDw3iEApmSERISum9pu47upjL+SiIZvYGmVPtako2J
         YIAefzmsZOD1d8PlpC9oYogFeOOxpDfF5z0QOwqjPLbFA+a5pYoKbwMY9YKhNvdDIseA
         3sSsU8wuLpY3UGynvBCccEOJ+uIAUvsfXOJvH20eRcx16Zr7N3fcpPGqCmuO6JUJs0WO
         E8Zg==
X-Gm-Message-State: AOAM533qfE793mXgihHFbTW4KXm7XCIhAAqbuNAy9+hzTecH35DzH3fa
        o3Fv0e3riI/OWTsje1m8akqN
X-Google-Smtp-Source: ABdhPJzefYvFjXGL0mb8PwKxN4Qzl/AU5lz9eYSUYAJTIyI6d05Cqz9V6PrQhbRG87XeTV7K5Im4tA==
X-Received: by 2002:a17:90a:55:b0:1dc:1ded:5a5e with SMTP id 21-20020a17090a005500b001dc1ded5a5emr11531615pjb.213.1651475228302;
        Mon, 02 May 2022 00:07:08 -0700 (PDT)
Received: from thinkpad ([27.111.75.99])
        by smtp.gmail.com with ESMTPSA id l4-20020a632504000000b003c14af5061fsm11005813pgl.55.2022.05.02.00.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 00:07:07 -0700 (PDT)
Date:   Mon, 2 May 2022 12:37:02 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Kaushal Kumar <quic_kaushalk@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] ARM: dts: qcom: sdx65-mtp: Enable QPIC BAM support
Message-ID: <20220502070702.GD5053@thinkpad>
References: <1651332610-6334-1-git-send-email-quic_kaushalk@quicinc.com>
 <1651332610-6334-4-git-send-email-quic_kaushalk@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1651332610-6334-4-git-send-email-quic_kaushalk@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 30, 2022 at 08:30:09AM -0700, Kaushal Kumar wrote:
> Enable QPIC BAM devicetree node for Qualcomm SDX65-MTP board.
> 
> Signed-off-by: Kaushal Kumar <quic_kaushalk@quicinc.com>
> ---
>  arch/arm/boot/dts/qcom-sdx65-mtp.dts | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-sdx65-mtp.dts b/arch/arm/boot/dts/qcom-sdx65-mtp.dts
> index 6920524..5c5fcb0 100644
> --- a/arch/arm/boot/dts/qcom-sdx65-mtp.dts
> +++ b/arch/arm/boot/dts/qcom-sdx65-mtp.dts
> @@ -68,6 +68,10 @@
>  	status = "ok";
>  };
>  
> +&qpic_bam {

Nodes need to be sorted in alphabetical order.

Thanks,
Mani

> +	status = "ok";
> +};
> +
>  &apps_rsc {
>  	pmx65-rpmh-regulators {
>  		compatible = "qcom,pmx65-rpmh-regulators";
> -- 
> 2.7.4
> 
