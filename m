Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0897B55EE10
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 21:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbiF1Trh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 15:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbiF1TrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 15:47:22 -0400
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600AE657B;
        Tue, 28 Jun 2022 12:43:05 -0700 (PDT)
Received: by mail-il1-f179.google.com with SMTP id p14so8869021ile.1;
        Tue, 28 Jun 2022 12:43:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VHVKVN3IX7q5QzhaWKonzv3cqLL801D7VMqTJfjBH8g=;
        b=dSb8EdVti2Q9VGSfer6ePqppL5+KxT7nXnmKm9mqtMDcA/6Bilk4oaGEd4v9vCXuGt
         p/Qh8pxsXwvBja63uEq6BoXb0qkIJ5AHmq43plpvqrMKpzoCw4pLs2Jbx1huZHsnOVib
         F4Z7G079XELDyrFRuZFsuUJyqMk4fQimmQi8Y32WSrBo31JqqlRrtOEY6FL9xDFGj6Ka
         R4VlxOAtAZvoaxFmy1PEovsxMGSyrjavWDyADxYBWv3/t7g3TQ5M0UYxx81Z/KNzYxlJ
         fE435Q5AthghO535BLhhfjxslpxvmoSx7OTrwaOn9WHPcUabUfeOCkoGmqSieL2Z8VCY
         xLsQ==
X-Gm-Message-State: AJIora+4B/c3biW4wC2Bqo/cb6puq5moPtO/GvG+CLfpWRU649E6/unr
        VJS3T3Zv5faHqP8iMU+lvg==
X-Google-Smtp-Source: AGRyM1thY7k8pboASgqZUmOKDkN+wYthPaxZ2hPfQa6CL7bFuO78NVmRq9Fl1FcLGhXHSV4B4sPAVQ==
X-Received: by 2002:a05:6e02:1c4b:b0:2d9:5706:7a50 with SMTP id d11-20020a056e021c4b00b002d957067a50mr11254928ilg.257.1656445384222;
        Tue, 28 Jun 2022 12:43:04 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id w1-20020a5ed601000000b00675305c58bdsm4024486iom.18.2022.06.28.12.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 12:43:03 -0700 (PDT)
Received: (nullmailer pid 860430 invoked by uid 1000);
        Tue, 28 Jun 2022 19:43:01 -0000
Date:   Tue, 28 Jun 2022 13:43:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-clk@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        devicetree@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: clock: add pcm reset for ipq806x lcc
Message-ID: <20220628194301.GA860372-robh@kernel.org>
References: <20220621163326.16858-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621163326.16858-1-ansuelsmth@gmail.com>
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

On Tue, 21 Jun 2022 18:33:24 +0200, Christian Marangi wrote:
> Add pcm reset define for ipq806x lcc.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
> v2:
> - Fix Sob tag
> 
>  include/dt-bindings/clock/qcom,lcc-ipq806x.h | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
