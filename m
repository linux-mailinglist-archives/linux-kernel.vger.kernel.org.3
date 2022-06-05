Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 904CC53DC6E
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 17:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345071AbiFEPHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 11:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbiFEPHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 11:07:51 -0400
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3224314080;
        Sun,  5 Jun 2022 08:07:50 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id p129so12049113oig.3;
        Sun, 05 Jun 2022 08:07:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Eud9kg/6OFIqnqYrPe3oEwQGSlqs1McYY85aMizcgo0=;
        b=YXfajtCQLNHIkypQ5n0dwnAdRdEubsDdFuNwV+v4qvlKwYt3ihZTsN2seKbnVL0Un2
         yThIPlCGQdoMIp9zDsY+uZ3p0hf3U/POJr0ynGfsI7tOoSp8neX4WBucem6NWTVntgcw
         NI+x/SK4xMTMHViN+a8jRiY9Zakyk32PpaZGh7NA8VLrhKA+8eulyWSr4rxwF/HUNsWi
         vc7wNs3Rar3J72vEdwe9eng3qQb6Pqcsq6UV51d9EIvAlG0NTfCGwZScCI2TlvfioeKJ
         H+Y2H8YcmmXsvScN0r1J6mfOF4tkC1BiGydvrGiWffKEJulF+Hl2fHq88+Pq0i8++Vfr
         agow==
X-Gm-Message-State: AOAM533mUoQJ+KwHQBg8+JfktZNAYtVbZdZ6A+TjF0luITxJ1F3rHmRm
        sOd0g1BgWh/Zve+7IlXKQQ==
X-Google-Smtp-Source: ABdhPJz00ge01uJT59XtkxX6M/a3OhPGU/9wzEOHC1jW9OSL85nx3nlhfnsOhpmql6+2MPxju5SuxA==
X-Received: by 2002:a05:6808:bd5:b0:32b:ac3a:73e1 with SMTP id o21-20020a0568080bd500b0032bac3a73e1mr26500521oik.54.1654441669478;
        Sun, 05 Jun 2022 08:07:49 -0700 (PDT)
Received: from robh.at.kernel.org ([2607:fb90:20d2:7c7e:bed3:ffa4:df1c:4ad2])
        by smtp.gmail.com with ESMTPSA id z6-20020a9d71c6000000b0060affecb2a5sm6628284otj.17.2022.06.05.08.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 08:07:49 -0700 (PDT)
Received: (nullmailer pid 3507843 invoked by uid 1000);
        Sun, 05 Jun 2022 15:07:47 -0000
Date:   Sun, 5 Jun 2022 10:07:47 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Rob Clark <robdclark@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Kumar Gala <galak@codeaurora.org>
Subject: Re: [PATCH 1/4] dt-bindings: arm: qcom: document qcom,msm-id and
 qcom,board-id
Message-ID: <20220605150747.GA3465286-robh@kernel.org>
References: <20220529202629.47588-1-krzysztof.kozlowski@linaro.org>
 <20220529202629.47588-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220529202629.47588-2-krzysztof.kozlowski@linaro.org>
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

On Sun, May 29, 2022 at 10:26:26PM +0200, Krzysztof Kozlowski wrote:
> The top level qcom,msm-id and qcom,board-id properties are utilized by
> bootloaders on Qualcomm MSM platforms to determine which device tree
> should be used and passed to the kernel.
> 
> The commit b32e592d3c28 ("devicetree: bindings: Document qcom board
> compatible format") from 2015 was a consensus during discussion about
> upstreaming qcom,msm-id and qcom,board-id fields.  There are however still
> problems with that consensus:
> 1. It was reached 7 years ago but it turned out its implementation did
>    not reach all possible products.
> 
> 2. Initially additional tool (dtbTool) was needed for parsing these
>    fields to create a QCDT image consisting of multiple DTBs, later the
>    bootloaders were improved and they use these qcom,msm-id and
>    qcom,board-id properties directly.
> 
> 3. Extracting relevant information from the board compatible requires
>    this additional tool (dtbTool), which makes the build process more
>    complicated and not easily reproducible (DTBs are modified after the
>    kernel build).
> 
> 4. Some versions of Qualcomm bootloaders expect these properties even
>    when booting with a single DTB.  The community is stuck with these
>    bootloaders thus they require properties in the DTBs.
> 
> Since several upstreamed Qualcomm SoC-based boards require these
> properties to properly boot and the properties are reportedly used by
> bootloaders, document them.

My primary issue here is accepting this will be an endorsement for 
other vendors doing something similar. I'm not against an ID 
property(ies) in the root node, but would rather see something common 
if we do anything.

Rob
