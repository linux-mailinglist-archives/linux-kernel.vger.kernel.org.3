Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4A8517213
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 16:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385628AbiEBPBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 11:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348651AbiEBPBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 11:01:21 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35107E0B5
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 07:57:52 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id r83so11890995pgr.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 07:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XHqLNWitZtORmjEq/cRS//R1AvQcIbzg25S0RWWto9k=;
        b=AyFgig29pfqccJeJdorEFuAEQ2F3/ciPZDDiB/bjUaNPUxsvPj1ds+wxjwJA9Zo4jw
         nlfh041c6A0wdnF6jiRHssXwjPQhgV05k/hka086lAsbghZYwvR1hSco0mgsAV6pHY2Q
         QiQmt4Bkw/9PGihig7cA8mI687d6BFxvOre+xKrStaA0yJlAqdJ3bjPnV1sf+RYKNSzA
         /4GjeJD4gqJIRTWvQfpsLASKs3sa3+WXgRQYGWZhukOzU6FHKUGVeucSAzaX/uB/imbO
         Wb4scXI/DkeSiOmsXgjeRoOiv4YGJdmwUvm3I8b19UiExQG5anjYUbp+fGaK7thasFg0
         c5/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XHqLNWitZtORmjEq/cRS//R1AvQcIbzg25S0RWWto9k=;
        b=tZCTSrwcUgYBexXdIB9PzE3GjUc49Gyk4FK19vRd0Th36l7De2yzgoN5Ug0bMzbaiV
         VR1X7ogUGqqOuDWfVbVcXhVlFq9fVBN+OaLeFFT9bkM0JwIH+5oPWHKNlG9zBkN/xJWs
         jF4we1k9XMmaq42gg39blL6VCxx7EqqkX8s40fyNMM3AkzsgyBqFZ4AhhjWV6EHsqxeP
         /dQYCtfNCaNxzAOHK5EarRR343Rmzu0o2V9ySkH6sAzoa3XJOKpL9j3L0VB8pHHJfnUu
         +7OOwIc7rOyh/KGHHdA2mANejCc+/HTvSvwrrcYWIF/uZ58HHv/F/Wb6RFDyx/NyExVQ
         hY6w==
X-Gm-Message-State: AOAM531FE+xljmLHCtCrPlE8tWvpTcwOSB/17rO7TC4NS4A+jUdlzO7M
        uJbb1932cCh7byjUNe7Csxn6
X-Google-Smtp-Source: ABdhPJyIBwUGoIN5550lxCNvnnupjXjaMPmDyqTNGFAY1zq7+AzTJUTXeHmwH9N6r2cJ5TRhX1axYg==
X-Received: by 2002:a63:4723:0:b0:3c2:69ab:df80 with SMTP id u35-20020a634723000000b003c269abdf80mr27147pga.23.1651503471617;
        Mon, 02 May 2022 07:57:51 -0700 (PDT)
Received: from thinkpad ([27.111.75.99])
        by smtp.gmail.com with ESMTPSA id h2-20020a62b402000000b0050dc762815fsm4776688pfn.57.2022.05.02.07.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 07:57:49 -0700 (PDT)
Date:   Mon, 2 May 2022 20:27:43 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Kaushal Kumar <quic_kaushalk@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] ARM: dts: qcom: sdx65-mtp: Enable QPIC BAM support
Message-ID: <20220502145743.GE98313@thinkpad>
References: <1651500878-10244-1-git-send-email-quic_kaushalk@quicinc.com>
 <1651500878-10244-4-git-send-email-quic_kaushalk@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1651500878-10244-4-git-send-email-quic_kaushalk@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2022 at 07:14:37AM -0700, Kaushal Kumar wrote:
> Enable QPIC BAM devicetree node for Qualcomm SDX65-MTP board.
> While at it, sort the blsp1_uart3 node in alphabetical order.
> 
> Signed-off-by: Kaushal Kumar <quic_kaushalk@quicinc.com>

Same comment as 4/4, with that fixed:

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  arch/arm/boot/dts/qcom-sdx65-mtp.dts | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-sdx65-mtp.dts b/arch/arm/boot/dts/qcom-sdx65-mtp.dts
> index 6920524..153ad2a 100644
> --- a/arch/arm/boot/dts/qcom-sdx65-mtp.dts
> +++ b/arch/arm/boot/dts/qcom-sdx65-mtp.dts
> @@ -64,10 +64,6 @@
>  	};
>  };
>  
> -&blsp1_uart3 {
> -	status = "ok";
> -};
> -
>  &apps_rsc {
>  	pmx65-rpmh-regulators {
>  		compatible = "qcom,pmx65-rpmh-regulators";
> @@ -245,6 +241,14 @@
>  	};
>  };
>  
> +&blsp1_uart3 {
> +	status = "ok";
> +};
> +
> +&qpic_bam {
> +	status = "ok";
> +};
> +
>  &usb {
>  	status = "okay";
>  };
> -- 
> 2.7.4
> 
