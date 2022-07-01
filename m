Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70068563898
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 19:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiGARcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 13:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiGARcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 13:32:42 -0400
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9164427B26;
        Fri,  1 Jul 2022 10:32:41 -0700 (PDT)
Received: by mail-io1-f44.google.com with SMTP id p128so2946948iof.1;
        Fri, 01 Jul 2022 10:32:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kdihIzz/bUBc79Tl403XsRH5T+EuaLhkcyZfLILKxN8=;
        b=0EYypL/zJa40wA2jfVV5CEgWp+IM4m430msR8ascesOg71Yq50TDy/lb8/69orhHz+
         wDBR2B/BVX9ZKlmaV5Mb9E+mla15odUsCf8H1efLUS8Pxe0YU0nD9ad+WemRvlY3R+V+
         VaxOxJwTKyHZMzk+79wul3zI+ucqeh5cerT76m8XgSMMfT7hEqEhVHAyqUP1jXprVmkn
         4AiRlQS7I2ZLnq7gsUwm+TK0HacGjN17d7lOLmKFrt5p7ni2whJnhU29Yc2gatrLGtMw
         NHcofuvCUOCwUo7zsPF7uxDb5GYGgxBh9D8Hx6dJIupHa4Vcis0Znz5vCMr1yGdc7ET+
         ATWg==
X-Gm-Message-State: AJIora+XLbdAjpwy6BX+2yj3sKHfg09xrHF06arW4fXL8qifakNVPxln
        6Wh2umCzKT/xTxQ0Tc81WQ==
X-Google-Smtp-Source: AGRyM1uZ8OwgEzsYCO7/yMQZmvzU4+eDubJKYCRdP+KsYw/UCew6Al3YMalNieo9Vemle++GbRPKbA==
X-Received: by 2002:a5d:9b85:0:b0:675:31ec:97dd with SMTP id r5-20020a5d9b85000000b0067531ec97ddmr8084076iom.111.1656696760783;
        Fri, 01 Jul 2022 10:32:40 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id i19-20020a023b53000000b00339cdf821dasm10007287jaf.51.2022.07.01.10.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 10:32:40 -0700 (PDT)
Received: (nullmailer pid 1184843 invoked by uid 1000);
        Fri, 01 Jul 2022 17:32:38 -0000
Date:   Fri, 1 Jul 2022 11:32:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v4 3/5] dt-bindings: arm: msm: Rework kpss-gcc driver
 Documentation to yaml
Message-ID: <20220701173238.GA1175908-robh@kernel.org>
References: <20220629121441.6552-1-ansuelsmth@gmail.com>
 <20220629121441.6552-4-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629121441.6552-4-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 02:14:39PM +0200, Christian Marangi wrote:
> Rework kpss-gcc driver Documentation to yaml Documentation.

It's not 'driver Documentation'. It's a DT binding for h/w.

Lot's of things are YAML. I prefer 'DT schema'

The subjects are bit long and get cut off as well. For the subject, 
something like:

dt-bindings: arm: msm: Convert kpss-gcc to DT schema

And similar for the other patch.

> The current kpss-gcc Documentation have major problems and can't be
> converted directly. Introduce various changes to the original
> Documentation.
> 
> Add #clock-cells additional binding as this clock outputs a static clk
> named acpu_l2_aux with supported compatible.
> Only some compatible require and outputs a clock, for the others, set
> only the reg as a required binding to correctly export the kpss-gcc
> registers. As the reg is shared also add the required syscon compatible.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../bindings/arm/msm/qcom,kpss-gcc.txt        | 44 ---------
>  .../bindings/arm/msm/qcom,kpss-gcc.yaml       | 90 +++++++++++++++++++
>  2 files changed, 90 insertions(+), 44 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.yaml
