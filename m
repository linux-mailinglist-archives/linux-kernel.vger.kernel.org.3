Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9818C589253
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 20:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238137AbiHCSdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 14:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235127AbiHCSdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 14:33:36 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABEDB5A2D9
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 11:33:34 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id k26so17252829ejx.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 11:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XZCzsgK5M5q8NHzi6xmbpn9gZoRddz3iFPlOf7axKvY=;
        b=YsMk8HXIgSnPt5mzM6iWp0him4MjXKkA/oabwfudv/iVdDck0f5XFcrhAHm94TLKaa
         FVmrXILtDZhQR2QGQa3natCmZCcPto2ksYOM/B2ofRhAbbhUmjRM583QE3TdcU/MWrVh
         MkP+MuKuFgupQuaZp7A/GlNgGuyXOf3Ob+AfNI92aqnCYZ85AvcdPc4iwkdshnhSH7GX
         K227BeQFZPX0fZMjCvgarbyKz0Lp/kL60YHyNP6xu/kDY/7tZgHwhq0+P5pi23ukZ52/
         gBZRLOw/mSh3TTv4TAgEzvbHCR1wlz00w+aqA9xg61GuUWyTtQsHBfCxnjoN0SeX+TIn
         JUMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XZCzsgK5M5q8NHzi6xmbpn9gZoRddz3iFPlOf7axKvY=;
        b=wo6cRBOz5hgFbY8ZDHMXiDcHuRku/OjIAGzBo5BP4OyOLhxN/9Q3PPxEUz5obhy9qL
         ZhNrNIcvqgWUZF5ohKdpZ8Jhi/hvbUqe+h/ZKz4JQ2TE01OsQnnDu9MExgpzkXYyT62R
         iH3UjPLbjU7fp+Ot4moaFMsP1JehH2MnuZPbwJsp6XeKobhB2dclLgZW1bHTg6+uTZ2H
         mtgdEWL+KCjL+TU4V2IrIKRE5HDEz6fG3OHiZKacqBjBCN5a7pD09zmUpZjIMNBjQ4YW
         JZVE2ycJb9EVzlE/8fZD5Txob/jv23AfdFApuV1bjZR3Ay15ZJuHGvw8oku5bo3L5G+v
         VPlw==
X-Gm-Message-State: ACgBeo1ik2RjbhNrt9CpJYda90CoD3Z0Mnh2UkxrxOWk8373A41QWPw2
        dYZUCF61F93BjUHcpQLYkb6/5BDg2r/T2WRrKdGCTw==
X-Google-Smtp-Source: AA6agR4OstbR2Blalqyf5WPQMnigPvrCXTR7+IxtC9eyJeScjSiiGyZ90qL+i68vNdVIhdN0pk0iNNMFEQPaH/XqO5c=
X-Received: by 2002:a17:907:6890:b0:730:ba11:3bda with SMTP id
 qy16-20020a170907689000b00730ba113bdamr1975386ejc.208.1659551613320; Wed, 03
 Aug 2022 11:33:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220726115202.99108-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220726115202.99108-1-krzysztof.kozlowski@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 3 Aug 2022 20:33:22 +0200
Message-ID: <CACRpkdaba9QoMi0J2icp91hBYC6x7VAi=Dh9fjOVHuLnNUmzwA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: qcom,pmic-gpio: add PM8226 constraints
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 1:52 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> Document the constraints (number of GPIOs) for PM8226 variant.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Patch applied.

Yours,
Linus Walleij
