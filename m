Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0794CE0D1
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 00:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbiCDXQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 18:16:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiCDXP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 18:15:59 -0500
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259CA27C52E;
        Fri,  4 Mar 2022 15:15:11 -0800 (PST)
Received: by mail-ot1-f51.google.com with SMTP id s1-20020a056830148100b005acfdcb1f4bso8596210otq.4;
        Fri, 04 Mar 2022 15:15:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k1tN1lUwUdDqhSBsOgAv09r/yxQkpYdTa5ENhCv+O54=;
        b=1UiBeaVfPe1B4pJe8Q8BRqY6QBT/egA2lo61eLWpazU7Z/Y9nqbOk99Sm+cAD2aqd0
         qEWiS+xuIhv9MbqcrXyq61sLU7Q33RfK604z5Sg8Hbh9m6db71voFkA2EToMltjgjBFw
         QadaLigqdPehuyKixL8S1WazOes0GjJqLVcfE9V3iqjBbi1+6XfEueg0JUDThRgEqVNo
         PqLePfInav2JBWm/fKfS7Fo+rkXj7LocKYZXJLxJJLEBpMQgcnLlzXvgME9gq3HHLW/u
         VgUTNYxPvGtcLmKvVjGxwILc/+lP5j4CydxMlnpU4nzJEGPwskCWTZqM5/KvvFKJ79zD
         XWAg==
X-Gm-Message-State: AOAM531SEGF7F8U8xcR+6/k144WuzDTvR9QbX0N0UkDiJh8oimm4FScA
        CEQWBJFtrBKpzze8Od3vXQ==
X-Google-Smtp-Source: ABdhPJzOcsLb3Pyg0ZZw2Oq+IlmrAhzGcVA0ROCqXJNxk8/MH4uwHRmxHy6wc0Va0PX7+059qWiAqw==
X-Received: by 2002:a9d:68d2:0:b0:5b0:328c:9d57 with SMTP id i18-20020a9d68d2000000b005b0328c9d57mr459499oto.160.1646435710459;
        Fri, 04 Mar 2022 15:15:10 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id v5-20020a544d05000000b002d7652b3c52sm3057564oix.25.2022.03.04.15.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 15:15:09 -0800 (PST)
Received: (nullmailer pid 643342 invoked by uid 1000);
        Fri, 04 Mar 2022 23:15:08 -0000
Date:   Fri, 4 Mar 2022 17:15:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Andy Gross <agross@kernel.org>, marijn.suijten@somainline.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, martin.botka@somainline.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        jamipkettunen@somainline.org, linux-kernel@vger.kernel.org,
        angelogioacchino.delregno@somainline.org
Subject: Re: [PATCH 1/3] dt-bindings: clock: qcom: rpmcc: Add RPM Modem
 SubSystem (MSS) clocks
Message-ID: <YiKdfA1eVI70bljT@robh.at.kernel.org>
References: <20220226214126.21209-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220226214126.21209-1-konrad.dybcio@somainline.org>
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

On Sat, 26 Feb 2022 22:41:24 +0100, Konrad Dybcio wrote:
> Add the missing clock definitions.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
>  include/dt-bindings/clock/qcom,rpmcc.h | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
