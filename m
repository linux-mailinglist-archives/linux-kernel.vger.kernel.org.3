Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1444D5076EF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353595AbiDSSAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 14:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356107AbiDSSAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 14:00:12 -0400
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AADFA12AAE;
        Tue, 19 Apr 2022 10:57:25 -0700 (PDT)
Received: by mail-ot1-f45.google.com with SMTP id t6-20020a056830224600b00605491a5cd7so5215492otd.13;
        Tue, 19 Apr 2022 10:57:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GPaAOiRU2sZJkdz+TPQsTeJ4PT3ekwE1x4w/NUDI8Fs=;
        b=WB3HX+mvX9gV51fe6zVfBTtdGUq0eJZehZCYEvf044A2ZFZsrM4amBw3k0wQ7D3sJc
         WxVHbIoEsIN0e1gmcfud2G3Du2mP43QpJp77BzWl3ZoM9SjZPgkNSEpAXf7VXKnRQnRZ
         /91Vcb9TQa2CW12maaTZP4zAJRlxzPBu9pefuscW8+EwblYaomf+Qlmb4sHZnoRcgXSP
         QXyIcr73JrYJUZ32xRH/zmUGm13FD4cmFdjefhVywhPXLQ3tQmnfT8eWrld6UzuAU24s
         +pOjEy0++dz7r3twVLk7rEfdc1XE1CzwlHtY0k/lKQEg5MWoGMdCaAYUo1IFSWBEe5+a
         EKwA==
X-Gm-Message-State: AOAM532ftVcdiIxcQVtDfZnbLrKXH8vcOyqjQj4UEuUiXgCejD2mMCTg
        5WPjE7VAeXE4PN5kaYIKeA==
X-Google-Smtp-Source: ABdhPJxEWVC3kzkDRMXbExF1R9up59MpJ/NNaXh5s23dZOks4H/YEE144xrpxhxJ39CUfiie5FzjIA==
X-Received: by 2002:a9d:7e87:0:b0:605:559a:9cdd with SMTP id m7-20020a9d7e87000000b00605559a9cddmr1432908otp.61.1650391044965;
        Tue, 19 Apr 2022 10:57:24 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id ay5-20020a056820150500b00320f8a179d0sm5875192oob.30.2022.04.19.10.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 10:57:24 -0700 (PDT)
Received: (nullmailer pid 3055313 invoked by uid 1000);
        Tue, 19 Apr 2022 17:57:23 -0000
Date:   Tue, 19 Apr 2022 12:57:23 -0500
From:   Rob Herring <robh@kernel.org>
To:     Satya Priya <quic_c_skakit@quicinc.com>
Cc:     Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        swboyd@chromium.org, quic_subbaram@quicinc.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        quic_collinsd@quicinc.com, Lee Jones <lee.jones@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org, quic_jprakash@quicinc.com
Subject: Re: [PATCH V10 2/9] dt-bindings: regulator: pm8008: Add pm8008
 regulator bindings
Message-ID: <Yl74A1cljv86CqaX@robh.at.kernel.org>
References: <1649939418-19861-1-git-send-email-quic_c_skakit@quicinc.com>
 <1649939418-19861-3-git-send-email-quic_c_skakit@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1649939418-19861-3-git-send-email-quic_c_skakit@quicinc.com>
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

On Thu, 14 Apr 2022 18:00:11 +0530, Satya Priya wrote:
> Add bindings for pm8008 regulators.
> 
> Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
> ---
> Changes in V8:
>  - This is split from pm8008.yaml binding.
> 
> Changes in V9:
>   - Remove description for reg and drop unused phandle from example.
> 
> Changes in V10:
>  - Regulators are added as a part of pm8008@8 device. Change bindings doc
>    accordingly.
> 
>  .../bindings/regulator/qcom,pm8008-regulators.yaml | 40 ++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/qcom,pm8008-regulators.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
