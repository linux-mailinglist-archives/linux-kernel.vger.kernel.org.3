Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE8552D36F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 15:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238330AbiESNCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 09:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238248AbiESNCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 09:02:32 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9034268304
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 06:02:30 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-2ec42eae76bso55612857b3.10
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 06:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nwW9GjvGuVvrMqwwcAAt0o0nCFOh2lYP7DZh9tX+RXU=;
        b=rCi77qAOrWXZXrPU46oeu3S+AZt3CX+fRkLyxcIaYFuC6+SZo9Vvc4rIpVp4OWLp/6
         j3g9Hxe7j8siZcxII/xR6vERekrcgwjihv/pAtnF7+WT8jbr/JN6cSlvEdd+KFNN3EP3
         2Zo9EPlnS3gnx6azniDW8Bj/vGHX+35zqMqeAoiV9CTamCmAhM1V0jfo1vVnvVSyl1AS
         3S1NmOv3nhOruowGLwOMK6OyY2XjoypeVz3jCyl2lXgmqiQvXeW82wsCevn74fb2LtXk
         7CeGK6M6CFNkR6aWGc2q+dxl1oHS3Xi1CNkimPWYi02kb2EX+2LKZuOIpOATJsyzbgcT
         Gd+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nwW9GjvGuVvrMqwwcAAt0o0nCFOh2lYP7DZh9tX+RXU=;
        b=N9xEoOGOBgg3/7N7mdl2CAhzgGN8RYPs3Q6MiwHJ+vaXVkITGXUNJbYo5FmGSZ/sr1
         U5DKtnYM04xJH6d1SmX0d9owkoJpvzLEMUY78wskXRhnQtbpIfEazKpfYx0cmZvs7UDX
         BeVnnEzW5nyGk3tMLOHVk3hswvXB/FDc7L5CfF5nS1adeiOcC1gPKMo2G+62hzSiqTs6
         7en4QSJmWZ5TvBYpr0+41mAfLlGR05B/rJaqVKT2dxkyv+8Km1TVfEPD1dBECJ2GMB9d
         fQFus174i6xbn4IQQaewJeinsT33gGBWTIIbET+Y034T+5tOeIVw01D6nKirLT/QqoAa
         DTlg==
X-Gm-Message-State: AOAM5327O+G8MxEJGai5S5nrd2rVq9ihB3/i2ZGIH0qiHIpaUIGYthMK
        2lW2pk1JIos+SRZbhXVYWBrrqkn3STWmMHS8SWEE5Q==
X-Google-Smtp-Source: ABdhPJw9DuDGpqNA9u4Nb3G/ZAoOmBgaLrxNmf9kQecQAG772or2yHzjiqgX4Aov686Gl6icaSEOn1WILYgGKeBvZbY=
X-Received: by 2002:a0d:e5c6:0:b0:2f8:c866:7af9 with SMTP id
 o189-20020a0de5c6000000b002f8c8667af9mr4648231ywe.268.1652965349808; Thu, 19
 May 2022 06:02:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220508135932.132378-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220508135932.132378-1-krzysztof.kozlowski@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 19 May 2022 15:02:18 +0200
Message-ID: <CACRpkdau5zM2g8jMDeT2gewaFzq19hyoh+dj061QwbBtk4Kotg@mail.gmail.com>
Subject: Re: [PATCH 0/4] dt-bindings/pinctrl/arm: qcom: second round of minor
 cleanups of QCOM PMIC pinctrl
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

> Krzysztof Kozlowski (4):
>   dt-bindings: pinctrl: qcom,pmic-gpio: add 'gpio-reserved-ranges'

This patch applied to the pinctrl tree on top of the other 4 patches
concerning bindings from the previous patch set.

Yours,
Linus Walleij
