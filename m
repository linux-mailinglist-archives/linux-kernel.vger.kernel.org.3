Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE60598772
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 17:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344346AbiHRP17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 11:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242310AbiHRP1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 11:27:55 -0400
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA82C04F1;
        Thu, 18 Aug 2022 08:27:53 -0700 (PDT)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-11cb3c811d9so490390fac.1;
        Thu, 18 Aug 2022 08:27:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=jzS/xxmqPClvxlGlF65JWerijpK7L30Co5ggvmlz4L4=;
        b=KNxQd1VVwbwrgQcE56JVxitCFndqhn3DHlVPvUj9s0c6NnXNaesBKQPT0PDWTjfVT3
         xMcT0unc0myLnUqznjkzOqwaQJF4D8gKO4ohKgrZeqlGxEyslcwZqR/nJDIXHUvDakEI
         QET3B8hM+ZPveRZrZR09/YuKzfbret4TqCr054n4ne4/dEnGXk44wq9FLqieXI92C/RY
         lykxaho6ltqTYCC7JgdAnB1UOCyZN2KqKmI+GNTMUlC3uCQ0iRmjV7EyayjY4jR8z/DK
         R6ZZkbhGyVgyS18OhnhAuBZikvTKYJRyLBAm0X2V/UJ7yUZRviumoKPi826rsUlvIZbD
         6Jaw==
X-Gm-Message-State: ACgBeo2jOgF/blFp3J81FygfDGWnC2DH7jvfBvPmCzvMEdGTBtKDzhRu
        tiXmYYcHO46CNPZ/un/m0UIGdQJhsg==
X-Google-Smtp-Source: AA6agR79Xb5ppP36+flNqhbBpw6WE0dpQ+DboWk9JqdKE4sl0qtWg0nngMvhcYxqeytWgL0Uwk4EQQ==
X-Received: by 2002:a05:6870:a99e:b0:11c:5025:d1d0 with SMTP id ep30-20020a056870a99e00b0011c5025d1d0mr3941523oab.222.1660836472292;
        Thu, 18 Aug 2022 08:27:52 -0700 (PDT)
Received: from robh.at.kernel.org ([2607:fb90:5fe0:b4f5:6e22:4704:df60:73a3])
        by smtp.gmail.com with ESMTPSA id p18-20020a4ad452000000b0041ba304546csm367108oos.1.2022.08.18.08.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 08:27:52 -0700 (PDT)
Received: (nullmailer pid 1900162 invoked by uid 1000);
        Thu, 18 Aug 2022 15:27:47 -0000
Date:   Thu, 18 Aug 2022 09:27:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        linus.walleij@linaro.org, konrad.dybcio@somainline.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: pinctrl: qcom: Add sm8450 lpass lpi
 pinctrl bindings
Message-ID: <20220818152747.GN1829017-robh@kernel.org>
References: <20220817113833.9625-1-srinivas.kandagatla@linaro.org>
 <20220817113833.9625-2-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817113833.9625-2-srinivas.kandagatla@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 12:38:32PM +0100, Srinivas Kandagatla wrote:
> Add device tree binding Documentation details for Qualcomm SM8450
> LPASS(Low Power Audio Sub System) LPI(Low Power Island) pinctrl driver.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../qcom,sm8450-lpass-lpi-pinctrl.yaml        | 135 ++++++++++++++++++
>  1 file changed, 135 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sm8450-lpass-lpi-pinctrl.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
