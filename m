Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4C5570DB3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 00:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiGKW5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 18:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiGKW5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 18:57:09 -0400
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93D8252A4;
        Mon, 11 Jul 2022 15:57:08 -0700 (PDT)
Received: by mail-io1-f46.google.com with SMTP id n68so6343086iod.3;
        Mon, 11 Jul 2022 15:57:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nkB1LobiQA6NccntvHF5Qv0wX7FCiVqXUkIF4H0VLgA=;
        b=6WpHXJfHvRvNFBp5FTCa+WTfeAucfOHTl28bbx6FI0nQlaqGTGJ0g5aHUeNAyP/FJw
         CwzmLo40XdnTlXxIDwpkkZmAC23eRxt586uB09P9GDAEmUWncxgdEgR3wat/pCU0Dncq
         J5QBr5natNdVkVG59eM2pMneAMOY0gJwoXJsOqIl/1wAEG25J2TjqOw/HRYNohoPnb0c
         Hw7/7S2Olsywo7iTqMEnBJ9tN9CalJzEHuPq06ZiW4x2hNXJMFkeKy9SyZ65fy3wduD8
         rfNc5FY18F14qv2U3uq1PPLuGVT4jIgFKkVucaQCpu+vwW4TFcjvKq9zcD9zbgjg2Gf8
         xY/A==
X-Gm-Message-State: AJIora+1XXemFmyzAY+K8t5vP8Um6HIqs6ecDpgiN/8y6rVttv9Rx3R6
        UEVvxWyFK5pjevqPhMeaDNq+xF093A==
X-Google-Smtp-Source: AGRyM1vX/8+PDDhf0f+QHpvSfhNzgqMs8567A/5TH4WA3ncvtyaETEfARInjSczaw0kMVaD9wvB4IQ==
X-Received: by 2002:a05:6602:2586:b0:675:9050:4651 with SMTP id p6-20020a056602258600b0067590504651mr11049758ioo.192.1657580227931;
        Mon, 11 Jul 2022 15:57:07 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id q4-20020a02b044000000b00339c1f7130csm3452121jah.84.2022.07.11.15.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 15:57:07 -0700 (PDT)
Received: (nullmailer pid 424684 invoked by uid 1000);
        Mon, 11 Jul 2022 22:57:05 -0000
Date:   Mon, 11 Jul 2022 16:57:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>,
        ~okias/devicetree@lists.sr.ht, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] dt-bindings: firmware: convert Qualcomm SCM binding
 to the yaml
Message-ID: <20220711225705.GA422079-robh@kernel.org>
References: <20220708090431.30437-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708090431.30437-1-david@ixit.cz>
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

On Fri, Jul 08, 2022 at 11:04:31AM +0200, David Heidelberg wrote:
> Convert Qualcomm SCM firmware binding to the yaml format.
> 
> This commit also:
>  - adds qcom,scm-mdm9607 into list which has only core clock
>  - adds qcom,scm-sm6125, qcom,scm-ipq6018
>  - #reset-cells, because the property is already used
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> --

Should be '---' in order to be removed automatically when applying.

> v5:
>  - add qcom,scm-sdx65 from new commit to txt binding
>  - add freshly merged qcom,scm-sc8280xp
>  - add interconnects
>  - add accidentally removed # from #include directive
>  - move mdm9607 to 3 clocks (thx @Guru)
>  - fix compatible string in example
> v4:
>  - added clocks minItems and maxItems
>  - removed quotes from $id and $schema
>  - adjusted description of TCSR HW block
> v3:
>  - add preceding patches for ARM and arm64 adding missing compatible strings
>  - extended with missing compatible strings
>  - added two additional maintainers, see https://lkml.org/lkml/2022/6/23/1969
> v2:
>  - changed maintainer to Bjorn
>  - document #reset-cells
> 
>  .../devicetree/bindings/firmware/qcom,scm.txt |  61 --------
>  .../bindings/firmware/qcom,scm.yaml           | 147 ++++++++++++++++++
>  2 files changed, 147 insertions(+), 61 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/firmware/qcom,scm.txt
>  create mode 100644 Documentation/devicetree/bindings/firmware/qcom,scm.yaml

Doesn't apply for me, so I'm assuming this will go via QCom tree.

Reviewed-by: Rob Herring <robh@kernel.org>
