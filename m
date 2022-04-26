Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24AF4510797
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 20:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352937AbiDZSzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 14:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238860AbiDZSze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 14:55:34 -0400
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE6C15570B;
        Tue, 26 Apr 2022 11:52:26 -0700 (PDT)
Received: by mail-ot1-f51.google.com with SMTP id 88-20020a9d0ee1000000b005d0ae4e126fso13674059otj.5;
        Tue, 26 Apr 2022 11:52:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9N1e5OZslji5MP/XoK2WWFaGv293/fdkodPjyRIaC70=;
        b=PscwfUKhkBUPk+1jj5p9wKmj4Ixb+iERwCGNGotJyGhNXq1XMdGZJ5oSbkd37NfAYA
         7Joj1J1iR5QhdMVhiM2g/aww9Tj6BiDlcQ3LnRus8/URbucjctTdPz3dww6iXziSSdVP
         QUznavDRROwtYbLeKkYMqcyKfVLysT9AnAxqblTXTIhyURRdZRG+hUTRGz8VkEFaTTaH
         DWKZAbM5p3O8Gl8zpgmzNlA95FyIf/SzynxDmKPI1AAPzCqQE5C/tH2G87BcndOHB3HZ
         rd61ZEgB9apynE9rU0OhRKPMdrRoCR+Mv8SRTRhE+qqlXtkr4DvGjrZrHGi8zHbRhJrO
         D4nA==
X-Gm-Message-State: AOAM533pH8kIztARfJMCdaYLo/drARmQmnAiy40O0aEW0oj8LMgPMtaG
        6wIiZoaGtjmaKtVA18ITLg==
X-Google-Smtp-Source: ABdhPJwdnX0Kr0creoWkGFLn2FOd17FF/HQNHWRUfZfGtUbtbeT7+L6U7uHsfQzvpoVlI1TgeinZNw==
X-Received: by 2002:a05:6830:911:b0:605:c9ad:3873 with SMTP id v17-20020a056830091100b00605c9ad3873mr1869805ott.363.1650999145814;
        Tue, 26 Apr 2022 11:52:25 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y6-20020a4a86c6000000b0033a64ed2074sm5887405ooh.19.2022.04.26.11.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 11:52:25 -0700 (PDT)
Received: (nullmailer pid 2348389 invoked by uid 1000);
        Tue, 26 Apr 2022 18:52:24 -0000
Date:   Tue, 26 Apr 2022 13:52:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     linux-clk@vger.kernel.org, Loic Poulain <loic.poulain@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ilia Lin <ilia.lin@kernel.org>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Nishanth Menon <nm@ti.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/9] dt-bindings: opp: opp-v2-kryo-cpu: Remove SMEM
Message-ID: <Ymg/aMLxcPg1IvDh@robh.at.kernel.org>
References: <T-ZqipM8xIaRroty0k9MEPCfD31BvtDXY6IaSm8uCD_ffIgJKYAcY-EZ49w0S-uX0w9sn1mUfBALTv0SqOb7OM1Uh6pskewGKxkOFYRJwfM=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <T-ZqipM8xIaRroty0k9MEPCfD31BvtDXY6IaSm8uCD_ffIgJKYAcY-EZ49w0S-uX0w9sn1mUfBALTv0SqOb7OM1Uh6pskewGKxkOFYRJwfM=@protonmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 09 Apr 2022 04:17:35 +0000, Yassine Oudjana wrote:
> qcom-cpufreq-nvmem no longer uses SMEM. Remove all references
> to SMEM and change the description and maximum value of
> opp-supported-hw to reflect the new set of possible values.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>  .../bindings/opp/opp-v2-kryo-cpu.yaml         | 56 +++++++++----------
>  1 file changed, 26 insertions(+), 30 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
