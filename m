Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A695076E6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356110AbiDSSA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 14:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352234AbiDSSA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 14:00:26 -0400
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A7911A02;
        Tue, 19 Apr 2022 10:57:43 -0700 (PDT)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-e5ca5c580fso8010320fac.3;
        Tue, 19 Apr 2022 10:57:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NfUXxRHK+LHQXnrnwFjeCWXpamoPwBgn6NmFsR4/ZvI=;
        b=2yRRWsh0YBOe56qXd3Pj4bklLaoUsTIIXWr3Cthb06QUITelSOvs4AgR8oqO7bZh0P
         YxeDDxhvgUXOKn9n+IZhoFMWaobGjzhWoLLLdHzWcn3AN+w2BFrsFsfAi+IYmhhFA5wl
         UKdnnncmUhwkjht/zXEAtF2IJJeP+3PDyVLvZvID6ofmCM3IhX9LPZ6ipkIt9WLcEBwd
         exJf9bD/dcjaNvTbMrzhxswGRGADazxVkf168s7n/iIhqTLixGglV9xRRl0Kkltb17i/
         b2M/hDxtwB7SrRQr8sRQTN+n5fhdEiLAv1DY81PDFhkPO4nAuI6ekk/mJ3KwQO/dzk5V
         H53Q==
X-Gm-Message-State: AOAM532zLrfHfziZtd3mWCLxHbVMtKXBbSv+VMgICMDTUaVfMZAIM9l8
        YUDDayyeniKVW+RjtywgjXzrIfHorw==
X-Google-Smtp-Source: ABdhPJygNRTnJdU4Xqcp1n+1TT3+wj2KW47+auy5sHfFy/Hc/DTV5MF50y1ElCyY0wNbKkiPOxBFVg==
X-Received: by 2002:a05:6870:ec90:b0:e5:aaf5:ca7 with SMTP id eo16-20020a056870ec9000b000e5aaf50ca7mr6607837oab.249.1650391062346;
        Tue, 19 Apr 2022 10:57:42 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o19-20020a4a9593000000b0032176119e65sm5662202ooi.34.2022.04.19.10.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 10:57:41 -0700 (PDT)
Received: (nullmailer pid 3055840 invoked by uid 1000);
        Tue, 19 Apr 2022 17:57:41 -0000
Date:   Tue, 19 Apr 2022 12:57:41 -0500
From:   Rob Herring <robh@kernel.org>
To:     Satya Priya <quic_c_skakit@quicinc.com>
Cc:     Rob Herring <robh+dt@kernel.org>, quic_collinsd@quicinc.com,
        quic_subbaram@quicinc.com, linux-arm-msm@vger.kernel.org,
        quic_jprakash@quicinc.com, Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        swboyd@chromium.org
Subject: Re: [PATCH V10 3/9] dt-bindings: mfd: pm8008: Add regulators
Message-ID: <Yl74FSBHt2ECMUsJ@robh.at.kernel.org>
References: <1649939418-19861-1-git-send-email-quic_c_skakit@quicinc.com>
 <1649939418-19861-4-git-send-email-quic_c_skakit@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1649939418-19861-4-git-send-email-quic_c_skakit@quicinc.com>
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

On Thu, 14 Apr 2022 18:00:12 +0530, Satya Priya wrote:
> Add regulators for pm8008 with example.
> 
> Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
> ---
> Changes in V10:
>  - Add regulators under main mfd node as in DT.
> 
>  Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
