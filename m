Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35FE85249EF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 12:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352336AbiELKDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 06:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352646AbiELKBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 06:01:44 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA542631;
        Thu, 12 May 2022 03:01:43 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id i24so4337716pfa.7;
        Thu, 12 May 2022 03:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:content-transfer-encoding:date:message-id:cc:subject
         :from:to:references:in-reply-to;
        bh=EpBY+DzaKr9D9IVnNO2+lmGSlE52SY1thjpa7lm9o98=;
        b=H/vDwD9CLydNeeCx0wINFwNCrrUAP3HjvBKceekUmrNS2Cm1/dqVyoSPjQfWVLDoYY
         hNwhC4cPb4rAtzFwuXR9KbED2q9bIevRtRi8A19F/zYGPSv3LpHFTI89j0/GVsI6vbF6
         z1Y6KvKppkgn0KxmM7uP5k6RH6XbpoK6oqnLi1r0EOGwuSLagI/LXmTklB96zhbGrRdR
         jZq++K/R4Nc732LumYw2B9iaYS6s6+8Tyb0U3xypaHWBY1ZyVfSNkTTFaVb4L/kLKkvG
         nm1V01D/xeNmrkc7tRGXoFryvx/vhdCjcmi01xDQFF8dbqEbY/IpM4YQHJGhZzcwJcxr
         RzdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:cc:subject:from:to:references:in-reply-to;
        bh=EpBY+DzaKr9D9IVnNO2+lmGSlE52SY1thjpa7lm9o98=;
        b=AFGt3/JvSWzgM0Jhznq0qW4FUROWDWXB2kB1K1yRClHIkeG0u9eb8qcEysv52MtMAZ
         mVmEsbzoQ1GX/mqb4yPrWS9IDoe99s/0rNWbh9PjGxnX4raVzGbJvp+tLtz2d+mREdCf
         Fverjp3qDBVvdRwM8i4Lo3xknjBoAdU/8hCR1xL2Yq/Fv3v4xwUHMZyHaIk+4DQVDmu1
         J9lmK5JxpElJeRDYmGZUQH16zsRCLEeHVXaKwp0m/zD+a8GOaS2TZZRMlLz0LzMwAnd4
         UtBj0tFgDRSmKM+8Fz+/zpc7I34IGeMkXST1QxngpNB3o4gRyeNJatmLC3Gi1d+xR7jg
         MVbQ==
X-Gm-Message-State: AOAM531dVvfqsMgJyWJQhlJGmb1RTCTmKSB6roPiJ0TmVkc1CzR9Uj7K
        vK5V27KMi4JyeT6itgH+/LM=
X-Google-Smtp-Source: ABdhPJwDkS1ORRJ1l54DeEOUcmdKRbft9icrpYGIK8G2oR5hAts4EVC68n5cxAfMu55mW6Prgo7TZg==
X-Received: by 2002:a63:2a04:0:b0:3c4:a041:d71 with SMTP id q4-20020a632a04000000b003c4a0410d71mr24377491pgq.492.1652349702720;
        Thu, 12 May 2022 03:01:42 -0700 (PDT)
Received: from localhost ([49.204.239.218])
        by smtp.gmail.com with ESMTPSA id j8-20020a170902758800b0015ea95948ebsm3454916pll.134.2022.05.12.03.01.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 03:01:42 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 12 May 2022 15:31:36 +0530
Message-Id: <CJXP2Z9J7QS1.24A3N1EFCTACN@skynet-linux>
Cc:     <linux-arm-msm@vger.kernel.org>,
        <~postmarketos/upstreaming@lists.sr.ht>,
        <bjorn.andersson@linaro.org>, <devicetree@vger.kernel.org>,
        <phone-devel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Andy Gross" <agross@kernel.org>,
        "Mathieu Poirier" <mathieu.poirier@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 4/9] dt-bindings: remoteproc: qcom: wcnss: Convert to
 YAML
From:   "Sireesh Kodali" <sireeshkodali1@gmail.com>
To:     "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        <linux-remoteproc@vger.kernel.org>
X-Mailer: aerc 0.9.0
References: <20220511161602.117772-1-sireeshkodali1@gmail.com>
 <20220511161602.117772-5-sireeshkodali1@gmail.com>
 <00234f36-9bae-31d5-5b83-ea238e7e3c11@linaro.org>
 <CJXL0SG2GHN1.1IO2JOR5ARNV8@skynet-linux>
 <30c18480-bf0d-82b9-5b11-daa3b70c40df@linaro.org>
In-Reply-To: <30c18480-bf0d-82b9-5b11-daa3b70c40df@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu May 12, 2022 at 2:06 PM IST, Krzysztof Kozlowski wrote:
> On 12/05/2022 08:50, Sireesh Kodali wrote:
> >>> +    description: The names of the state bits used for SMP2P output
> >>> +    items:
> >>> +      - const: stop
> >>> +
> >>> +  memory-region:
> >>> +    maxItems: 1
> >>> +    description: Reference to the reserved-memory for the WCNSS core
> >>> +
> >>> +  smd-edge:
> >>> +    type: object
> >>> +    description:
> >>> +      Qualcomm Shared Memory subnode which represents communication =
edge,
> >>> +      channels and devices related to the ADSP.
> >>
> >> You should reference /schemas/soc/qcom/qcom,smd.yaml
>
> It seems it is not a SMD driver so above reference is not correct. This
> should be probably described in its own schema, I just need to
> understand what's this...
>
The smd-edge node describes the smd channels used to communicate with
the remote processor. For wcnss that would be the remote proc id, and
the channels for bt and wifi (both separate). There's a similar node for
adsp and q6v5.
>
> Best regards,
> Krzysztof

