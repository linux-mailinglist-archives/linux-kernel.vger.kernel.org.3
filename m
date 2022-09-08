Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7B6B5B166D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 10:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbiIHIJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 04:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbiIHIJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 04:09:47 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124B620BD7
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 01:09:45 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id z8so23150012edb.6
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 01:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=S1qXKiCajjh/Uipc8YgMZjzlpJicWnNYZECRNVm1W44=;
        b=YUOI2kYGVp8TedktBBfFdNobEmHj7S9Q1LO8y/r2tvlZZ+5ZC4wlQhkhl1SEtvc4cP
         F8XJfH9efVRhKhKBlrIduz313st7Jm3Ay4LLP9V5gtcdxIruOaGROH2A2qaODRX7H/ua
         0Su8QeZwPmjFNoNx9t/sC8yFpobFSwGGGbMtMNlEXPce22uejctJNRxxDegKT6OegWUg
         xLelMTTz2OPFcT79j0o7xF8ZimSkWQRyIB+3N6jF39pwaJ3byW8+tFfI3QBTAkbd6TSv
         XNLXIUdaszwnMZZCzxaOOQ9kVY7yf5ayJPm+udIirSx11k5DxI+p4ARltB8EWRgoSXXT
         gGNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=S1qXKiCajjh/Uipc8YgMZjzlpJicWnNYZECRNVm1W44=;
        b=V60bRAXVKLlvGKwiUy5EagWzoH+4dB+8Mk0duHSpvRTXFF1WiQje31/541YcoIy+NT
         0NY40eUC1cs/E4DBmQgrSpUTiExYYIOVnvmm8WKBqSp3KvAPucSfZNJ2p5Ysc6WLMhcK
         pK8jrzwyCi8f4UYBEwtgq8DIFS0c6/9iJY+CDdKQzuh9TFo69Ki1xfrUuR2/cWVrTCdM
         QcHVRdJRMO2sIZS6VHyeisozkUPdJptfulROiwGxj6TNcTKEKRLgnIcyJuD7L2EvXFGS
         AWoBBy0JNVYJ4xUm/mNp+r2VclQRCnatfia7LQHpmXhDXoz2atrUPqpdFd2E54ZkH1de
         V3Xw==
X-Gm-Message-State: ACgBeo1SYHUtihA4NxHDNQbWe7fDXpIDqa3vRiLvQhkwywBZeLYDSE/Q
        1w2vWfgtrzgFh/JlHMNQ/0eelstr07G6yVb+DS592w==
X-Google-Smtp-Source: AA6agR4Ul4v+ifKJUG+DffGG6giEHITRYdE5Bt6AKV97jrthkmExLFsd8TA3X6Foj57Noofm4ulq1/3/4JopmDpgxeQ=
X-Received: by 2002:a05:6402:2691:b0:43d:ba10:854b with SMTP id
 w17-20020a056402269100b0043dba10854bmr5936048edd.158.1662624583635; Thu, 08
 Sep 2022 01:09:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220903174150.3566935-1-iskren.chernev@gmail.com> <20220903174150.3566935-5-iskren.chernev@gmail.com>
In-Reply-To: <20220903174150.3566935-5-iskren.chernev@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 8 Sep 2022 10:09:32 +0200
Message-ID: <CACRpkdYwc=py6s0CqGZgusH4yQA+ZqQGYgeWqcv+NDpnSwt3Vw@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] dt-bindings: pinctrl: qcom: sm6115: Add reserved ranges
To:     Iskren Chernev <iskren.chernev@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 3, 2022 at 7:42 PM Iskren Chernev <iskren.chernev@gmail.com> wrote:

> Ideally this and similar common properties will be inherited so you
> won't need to paste them in every pinctrl binding.
>
> Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>

This patch 4/9 applied to the pinctrl tree.

Yours,
Linus Walleij
