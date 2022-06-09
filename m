Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56B55455CE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 22:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345094AbiFIUke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 16:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbiFIUkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 16:40:32 -0400
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A996B156461;
        Thu,  9 Jun 2022 13:40:31 -0700 (PDT)
Received: by mail-il1-f177.google.com with SMTP id s1so19630560ilj.0;
        Thu, 09 Jun 2022 13:40:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JPFIQj3seYABrD7RnegA3z27kpvWq95njxbWEfL3Hw0=;
        b=yGi4Rx3ymwfZu0/GXgnuKy1MaXFN2dp3V5yeb+VYsXFchef1fa3nUCYbETYUKmaqlm
         jOEr4JX1QXO9pr+NphKv8w76d2XRbcn72iZWUsk0j5wdfD9QxGog/N73cpor0TVAaCNF
         TF180rtf6z6mPrEG9T1AhrohLs5HSYixncnkXXoS9oFpDuFl56GcVFVWcbL3naiYjiUa
         H8NAn8QmZnESQXoSHlWUipRaWsFHzYTCyX7e73nQQ5X8/1LmSdLAtyJLjUKsMJ5ktCIg
         y1DVwh2cBJXTOWHfCAfavArUhQLTvzFmZSe67+cYJ12efpzYcrPqzU9ZVlrTI/9Fe53k
         LahQ==
X-Gm-Message-State: AOAM533aZa7HWUmwYh61vu5ZkQKqsTcGt45sJtNMZfR7pzGfa6bSyP8N
        mZzkuqWMEvoJ3Ik8cBRJFg==
X-Google-Smtp-Source: ABdhPJxhSHpw8c73EBmQgcNkousM034q6LSovvCE/09nebqSp36lzkzNkJB+3Yx8hvdNA8+ZmwVqDA==
X-Received: by 2002:a05:6e02:20e9:b0:2d1:d151:3c53 with SMTP id q9-20020a056e0220e900b002d1d1513c53mr23177829ilv.220.1654807230916;
        Thu, 09 Jun 2022 13:40:30 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id y11-20020a02904b000000b0033206b52e4csm968762jaf.42.2022.06.09.13.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 13:40:30 -0700 (PDT)
Received: (nullmailer pid 63923 invoked by uid 1000);
        Thu, 09 Jun 2022 20:40:28 -0000
Date:   Thu, 9 Jun 2022 14:40:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Brian Masney <masneyb@onstation.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 02/14] dt-bindings: sram: qcom,imem: add IMEM memory
 region
Message-ID: <20220609204028.GA63739-robh@kernel.org>
References: <20220607171848.535128-1-krzysztof.kozlowski@linaro.org>
 <20220607171848.535128-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607171848.535128-2-krzysztof.kozlowski@linaro.org>
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

On Tue, 07 Jun 2022 19:18:36 +0200, Krzysztof Kozlowski wrote:
> Add bindings for IMEM memory region (like SRAM) used on several
> Qualcomm SoCs.  In the downstream (vendor) tree, it comes with several
> children used for debugging purposes.  The upstreamed parts are much
> smaller - just image loader and syscon reboot.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/sram/qcom,imem.yaml   | 75 +++++++++++++++++++
>  1 file changed, 75 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sram/qcom,imem.yaml
> 

Applied, thanks!
