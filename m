Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15725526D6C
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 01:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbiEMXUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 19:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiEMXUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 19:20:13 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3231CBC6C9
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 16:18:42 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id g28so17717959ybj.10
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 16:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=peFPtL0ZhzsJZHNucBDtSwt3F1izphFO+BREPiZmQjc=;
        b=neoc4bliNIEuwITc3td2ZW08qZUSbSxEOpHqeR4p8ZRBmPCnGFYguhLglAwZ+Zg7GD
         IHiTKfAwBSBXj7zRbP+cFmi6g6NOO26eqWMaoEdHKOEqxwwVH7Sas76I3p9g5NJHnV3j
         UTZnJJHhKUxrjf/+krI5Du+FGuy3MSr/HUPLfnZYZCf4sLJsQUT6O/jh9YTkbrBQBBP6
         6ukMi/1/AukIUqqMlEqPnDoE25XZyk57RvDoJOxucC5Qln8wTzBuHoUXMac9Pc7evjuq
         ou0AQn4ZteR4wxH0ZzwnY4OpDeFAx58uf/pZ59dN0BdDBLIQayLelu0NaoS8mxsQKyZp
         /WMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=peFPtL0ZhzsJZHNucBDtSwt3F1izphFO+BREPiZmQjc=;
        b=LxmDwV1RqkJtGb0fBnuzYAdgNjnkHut9PWwCIvoS50clm1LFuxoadnzhsjFWnLMJJT
         jrDn7sq5/gDvUa3PJvGH6ko+bZKCsDTST0nBlk/8LySeb+I0sBrxQpfrjUC1PgmH4dEL
         IKNzRM/4E8lbCJRhd+kNbWRfhB5E0AgnOxtfVlOzg9Vx93MlZDMcnt6jxxdcxd0pauJs
         dQcp0DTKYVnZeM1B7/Sh9ByC76hiqsjCeAW2nWO8JazGbN0g9iPYwv3sVIDe+xEgy24+
         ozW+tBLBPAULWY0fvS4j8zU4Wkg1Mh0kHTF0VXhrqvzXNn7Cp4wjG78YHY/bnPJDsNAO
         GTqw==
X-Gm-Message-State: AOAM533EBf7YyycQ11cqcQHo8ahWBKPQ5j+s/W9DXh5HRIWpP06UUv05
        pNFskWdsFkm2nlW6l/E2pke5m4GwhzdOsi5kAPg5Kbto9t8=
X-Google-Smtp-Source: ABdhPJzq/anb8INHniF8SiNul15kIbegKtWUZLQxaVHXqzCkz8MczW1Rtjm+OV0/55vE2qrtnxfGrJFNvmZgkA2MHhQ=
X-Received: by 2002:a25:bcc3:0:b0:648:7360:8e75 with SMTP id
 l3-20020a25bcc3000000b0064873608e75mr7252850ybm.533.1652483921333; Fri, 13
 May 2022 16:18:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220508135932.132378-1-krzysztof.kozlowski@linaro.org> <20220508135932.132378-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220508135932.132378-2-krzysztof.kozlowski@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 14 May 2022 01:18:30 +0200
Message-ID: <CACRpkdZLsw7rU113x88MKxTUEPgueLHf+7Pu4FevCAQLP2jBqg@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: pinctrl: qcom,pmic-gpio: add 'gpio-reserved-ranges'
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>, David Heidelberg <david@ixit.cz>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
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

On Sun, May 8, 2022 at 3:59 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> 'gpio-reserved-ranges' property is already used and supported by common pinctrl
> bindings, so add it also here to fix warnings like:
>
>   qrb5165-rb5.dtb: gpio@c000: 'gpio-reserved-ranges' does not match any of the regexes: '-state$', 'pinctrl-[0-9]+'
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

This does not apply on top of pinctrl's devel branch, am I doing
something wrong?

Yours,
Linus Walleij
