Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 788B85A0B44
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 10:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234518AbiHYIXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 04:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235036AbiHYIXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 04:23:21 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A93A598B
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 01:23:19 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id k22so4011855ljg.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 01:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=QcYaN0JPky1EGXbRY64NqWC+vf4pbZdpI3za5tFR27Y=;
        b=R6+bJKdroxxLZUeNX914wnlRmrBnu6dnYD5EjdF8U/Fu7DzRIGzlImTazksz7MMUE+
         AtYJCGUm2qYs2ilZeWHBntZNyFAgv/64O/Q3WuNZ23BwxjUACbevkfowc+3UN52EvTk/
         I2UxdF2QChDaiSduTt5APgjpVYLTTZ0WvNNnd3bxttbBn1TnZkgU/Syw4DI8wLeLaxXT
         4RaxgB2NrE0LukyVvLOJzaMXXKUcLcTj4SqG8OORdb+VquhoJUuNYd3+U1ppcEe3ZJ4p
         fKvSBT72f7NpcwIJlLNxO1tuBXskIFyFncojPfy3ahZbUoEpX316AcmPWVra2cbdWfYa
         rECg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=QcYaN0JPky1EGXbRY64NqWC+vf4pbZdpI3za5tFR27Y=;
        b=XD8EXDT0kmFtoBVnS6qx9va6Zwa6sgIchL5fMf4ilmaupVQyTm7IqN5/RA6BMMqY9r
         x/AQOxB2tBBMa0uUkdA1gurffkeOOSAwjFxyZzHyDwnpPgBy6GtWyPbFtmgTm7rABfx+
         o6B2CmMlEBGPPd/rV9xUquAWEhd1+/vxdYlvWV8EFY7+RvWbSAm3V9n7tDySKkejlGk+
         SIDE8xmMg38DomGHZ452LKGibjsEJI/eomKbs66Vt7pHZUYauqntyhRN/LWJE+SCqVWn
         WWZLMXRa0JxcfzAYiibPwDFfVTGNcNlUDVbf2wjg28HEXSpd8Os2snmPGztWIeq7V4Cv
         km3A==
X-Gm-Message-State: ACgBeo1z7yphBdGmXdTH0zphmIYPW8RZxdJmn1k0orGMdJuKG7vi4dfb
        ephX7rvFDlSzCSDdsvs+3KrwHw==
X-Google-Smtp-Source: AA6agR78g9/aWyse4FQH581ZrbhVy37gSTslIw8h/JN2EkuNfJP5xOpXkmesnAnV+MzF5s5aBmGV0A==
X-Received: by 2002:a2e:bf11:0:b0:261:9343:fb2 with SMTP id c17-20020a2ebf11000000b0026193430fb2mr770866ljr.47.1661415797930;
        Thu, 25 Aug 2022 01:23:17 -0700 (PDT)
Received: from [192.168.0.71] (82.131.98.15.cable.starman.ee. [82.131.98.15])
        by smtp.gmail.com with ESMTPSA id c11-20020a056512074b00b0048a7c162bbesm356757lfs.279.2022.08.25.01.23.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 01:23:17 -0700 (PDT)
Message-ID: <1491c83f-cd75-4de3-ec26-86db4adb2ade@linaro.org>
Date:   Thu, 25 Aug 2022 11:23:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] dt-bindings: remoteproc: Add missing
 (unevaluated|additional)Properties on child nodes
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220823145649.3118479-10-robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220823145649.3118479-10-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/08/2022 17:56, Rob Herring wrote:
> In order to ensure only documented properties are present, node schemas
> must have unevaluatedProperties or additionalProperties set to false
> (typically).
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/remoteproc/qcom,sc7180-mss-pil.yaml      | 1 +
>  .../devicetree/bindings/remoteproc/qcom,sc7280-mss-pil.yaml      | 1 +
>  .../devicetree/bindings/remoteproc/qcom,sc7280-wpss-pil.yaml     | 1 +
>  3 files changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-mss-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-mss-pil.yaml
> index e76c861165dd..e4a7da8020f4 100644
> --- a/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-mss-pil.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-mss-pil.yaml
> @@ -140,6 +140,7 @@ properties:
>  
>    glink-edge:
>      $ref: qcom,glink-edge.yaml#
> +    unevaluatedProperties: false

Is it actually needed? The qcom,glink-edge.yaml has
additionalProperties:false, so I expect it to complain if anything
appears here.

Best regards,
Krzysztof
