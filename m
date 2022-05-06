Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5FA951DAAA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 16:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442266AbiEFOmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 10:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442261AbiEFOmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 10:42:14 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C127E6A41F
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 07:38:30 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 88-20020a9d0ee1000000b005d0ae4e126fso5047523otj.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 07:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=iky+2DSYqv2Gw83+fUdec0P6CD5G2yXukPaUGpyxX6E=;
        b=SymezlUM2zDLS9ItKEh8Tw9JXBO690esOf0mPiAj5TSYPuxIqmFLN1TiHIAhNkzAT5
         0s+c6p4FLMwPCF/WZMwDnLc8TLFJeUjBkekH3kTQay1i2msU34YYwuLIzzhNERZ6Jnap
         eddyooibtoTQHvCZmfeDjLIUYfg83zCOY+bUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=iky+2DSYqv2Gw83+fUdec0P6CD5G2yXukPaUGpyxX6E=;
        b=Fr70P+W5gPZsul9TJzoc5Qs9geFrtuuQv/HeNW02H64R40c/f4Cqp1EwMnhYPdkgXM
         5riQEUVbdBaM2q0tIOVP6VDLHD+8VA22mqSdbBhe2n29bFwlCwhX/Ww+77qNrFuoXbCn
         4T17dCLG//7U8FmktKYLwDmM4cwgR3StFQUlGa/cSzcbLU4f498UZQc0T5fX9qitCJtB
         gpOhNWn/v4q79yJpqRbWLJbsIhcRGVoWHM49/bjoSmL8xkhWCrtiLg2UBnw1QAnGGjl3
         C7a7LmzLjcA+fgupNCg7FS4AG4kxFVfrazdN0jGIn6D84aXEy6kSRvEDCS/2N/TysTKf
         awJg==
X-Gm-Message-State: AOAM530UblV4W01oqCoM1EmV1Rt8F7tVRxP04//UyhPkgmQMYAckJvib
        dloNNL4T//nmwdkLB7T0N5Q8rir8nHEXYfhI+T4QGw==
X-Google-Smtp-Source: ABdhPJyGXk5/9A2xbuYzjjU+Qgz+l2qZMYFFTHj6EvEgRIee763d/CoZ4dDksxQO6mI8HSUj8GSqFqiHSa80y7p4SOU=
X-Received: by 2002:a9d:20a1:0:b0:5e8:d2b6:f63f with SMTP id
 x30-20020a9d20a1000000b005e8d2b6f63fmr1078941ota.159.1651847910486; Fri, 06
 May 2022 07:38:30 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 6 May 2022 10:38:30 -0400
MIME-Version: 1.0
In-Reply-To: <1651742739-12338-6-git-send-email-quic_c_skakit@quicinc.com>
References: <1651742739-12338-1-git-send-email-quic_c_skakit@quicinc.com> <1651742739-12338-6-git-send-email-quic_c_skakit@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 6 May 2022 10:38:30 -0400
Message-ID: <CAE-0n50Ysr_BTUCZ0Wd6mJVaDf9PXspzuzuoL79dij-iOc9nVA@mail.gmail.com>
Subject: Re: [PATCH V11 5/9] mfd: pm8008: Remove the regmap member from
 pm8008_data struct
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Satya Priya <quic_c_skakit@quicinc.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_collinsd@quicinc.com, quic_subbaram@quicinc.com,
        quic_jprakash@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Satya Priya (2022-05-05 02:25:35)
> Remove the regmap member from pm8008_data struct as it is
> not used outside of probe. Add a local variable for regmap
> and pass it to the pm8008_probe_irq_peripherals()
> API in pm8008_probe.
>
> Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
