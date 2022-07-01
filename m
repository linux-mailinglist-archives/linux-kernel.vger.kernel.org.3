Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E0356389F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 19:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbiGARgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 13:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiGARgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 13:36:04 -0400
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EEDA35AA9;
        Fri,  1 Jul 2022 10:36:03 -0700 (PDT)
Received: by mail-il1-f173.google.com with SMTP id h20so1811801ilj.13;
        Fri, 01 Jul 2022 10:36:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3aaVN1H465bVr/3jzkPQOEndVm9VzmqF/2qwwLkPR20=;
        b=ddQZIvS/K/3y3kA5q7y04pC6yfnIpAdOLrtZ9okYJsfJf5aF3CcRBXllFSiov8sNzk
         VvGWk4Em2MO7tUsWyMT3VfL7CVp3DQaFodUTViJRcIJgpmUNUaMtU6cPQCORvKhnq6hf
         +ZO1Jmo14TrjFHs3hZinu4oj+QiYd9b58v475R/QblfXG4plbzz/z/wzj1toLtrpniDW
         KHgpS1025IYm9AWVxnV32P8q3ECy5/QXqNuvTLG7T7PdfXJLkpGoySmL+9qnrUHeSc45
         KZriXqlgJHO1cwEVpLejCgB8dTxsR/PMmlICgA20Mb8kShXR13QpYZ2jVUh3dC/Q0dKf
         c4jw==
X-Gm-Message-State: AJIora8s8SsMzU6FW+1EuiVnORHLPdpftWxxBh67jFI14lYCKC5NA98a
        Y1fDIIpM0FgQgU7U+A9qvw==
X-Google-Smtp-Source: AGRyM1vpWh34NxMf1IH8M6KfFFtGFgZi0d3Hka0cqBzV30xFWrqaBKXx9Yo7RZNmRK/4m1bOmACARw==
X-Received: by 2002:a92:c54a:0:b0:2d9:5495:5caa with SMTP id a10-20020a92c54a000000b002d954955caamr9504386ilj.270.1656696962830;
        Fri, 01 Jul 2022 10:36:02 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id a16-20020a027350000000b0033192b7fd35sm10064163jae.128.2022.07.01.10.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 10:36:02 -0700 (PDT)
Received: (nullmailer pid 1190459 invoked by uid 1000);
        Fri, 01 Jul 2022 17:36:01 -0000
Date:   Fri, 1 Jul 2022 11:36:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: power: reset: qcom,pshold: convert to
 dtschema
Message-ID: <20220701173601.GA1190424-robh@kernel.org>
References: <20220629123804.94906-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629123804.94906-1-krzysztof.kozlowski@linaro.org>
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

On Wed, 29 Jun 2022 14:38:04 +0200, Krzysztof Kozlowski wrote:
> Convert the Qualcomm Power Supply Hold Reset bindings to DT schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/power/reset/msm-poweroff.txt     | 17 ---------
>  .../bindings/power/reset/qcom,pshold.yaml     | 35 +++++++++++++++++++
>  2 files changed, 35 insertions(+), 17 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/power/reset/msm-poweroff.txt
>  create mode 100644 Documentation/devicetree/bindings/power/reset/qcom,pshold.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
