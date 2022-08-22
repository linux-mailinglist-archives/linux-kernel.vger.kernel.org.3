Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8612659BE3C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 13:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233815AbiHVLJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 07:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234330AbiHVLJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 07:09:12 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4D133E26
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 04:08:01 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id e21so8523436edc.7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 04:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=UBOByeB2MXYBWF0Ngo8u4UdkkfztEsDE7yNqsiJ1+80=;
        b=BzsFOpc1/Mc0X9z223lsXWZS/tY4y0+joi4BEv5glMXwdMgLaEhyVlaoSyz0K3ya5T
         Ik7dnernQfgtBGmb+OvhwETWQh2h1AZJR54hTZepWY1rjP3ebDuqzWjStEC3jbFZAaw8
         K3gES4WqS6qJyzcuG97gJlbc1py4dUVk1Dm2de26RCPo8+VMeeWYLdPHDpYmZUAx9/uT
         V6Th/pdzLwmss/lYVTMINZDV4WCGgQdDMtOtbeznxVHJbvPD3E7QhLY5CRFw9vGUoXgt
         BPaaxk1C3EAsbeHb+beUDVIHdJo8ahLgoYZ8fLqanNhVk7TuErun4JI3xtOxsLTl5M6V
         esLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=UBOByeB2MXYBWF0Ngo8u4UdkkfztEsDE7yNqsiJ1+80=;
        b=XqlQQqS/MTvcFt4c+1nUPREuf9fPFhsYsBn6T1cDuAyzpW1sEVMU6cyg4gtfrbSIJQ
         S3Gvq6I12H7o0fvolge/D5Ai2WKMHVAeMVdVmT4sXSp7eUb9O62R4i3MTE57ct19U57J
         VFceJlPmw6aqhSBYXCGAe6PwndDbcWeqWqLhlrWrFBcs9mILr+WQDZjN0OZrLYdwc1s6
         FzL0AIPykEPr8KxuBV5Yw+sOR5/uq5JikkUaXX121xZpO29Uf8/nmHntbqjh5ODqJd6K
         oohzESLS+9QRVsdthIBVirObsWe7yQoAMCcdL03HcJD8Dpiogj8egySGpCLRE6n2DZnR
         p6IQ==
X-Gm-Message-State: ACgBeo1Beg6eYFAlr9usVO9M0U4tUOFWFsXKdlvnyCJWDXOjmFjVmCZb
        D2D7D4YSzLRsyxPrTFRzH5dbaEwuGikpEkIHbX/3vQ==
X-Google-Smtp-Source: AA6agR6I8GpDbmShK/nTtNn95EOVxEW+y17uLeMbs/P/mq4HbiEMfUtFHz3h1LT8uPmBbs95HSDU97bm3dLNTUXQr5A=
X-Received: by 2002:a05:6402:641:b0:446:d:bd64 with SMTP id
 u1-20020a056402064100b00446000dbd64mr16181153edx.32.1661166479741; Mon, 22
 Aug 2022 04:07:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220809214556.2489822-1-robh@kernel.org>
In-Reply-To: <20220809214556.2489822-1-robh@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 22 Aug 2022 13:07:48 +0200
Message-ID: <CACRpkdbSycBG6ZiXfEHLquiyAMu=et81LAaGZbj38bhAccCSkw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: qcom,ipq6018: Fix example
 'gpio-ranges' size
To:     Rob Herring <robh@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sricharan R <sricharan@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 9, 2022 at 11:46 PM Rob Herring <robh@kernel.org> wrote:

> 'gpio-ranges' entries have a fixed size of 1 phandle plus arg 3 cells.
> The qcom,ipq6018-pinctrl example is a cell short:
>
> Documentation/devicetree/bindings/pinctrl/qcom,ipq6018-pinctrl.example.dtb: pinctrl@1000000: gpio-ranges:0: [1, 0, 80] is too short
>         From schema: /usr/local/lib/python3.10/dist-packages/dtschema/schemas/gpio/gpio.yaml
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Please ack and I can send to Linus before rc1.

Sorry for delay, was on vacation :/
Acked-by: Linus Walleij <linus.walleij@linaro.org>

I think as binding maintainer you can just submit this kind of smaller stuff
without any subsystem consent, if you have it acked by Krzysztof, even more so.

Yours,
Linus Walleij
