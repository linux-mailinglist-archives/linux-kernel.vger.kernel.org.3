Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5B3580DD4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 09:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238395AbiGZHd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 03:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238512AbiGZHdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 03:33:37 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755652B262
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 00:29:41 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id m8so16664362edd.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 00:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ERYnZjAmqURrPxvuGkteRUMsQNSwpIjr2yYOxhN4v2Q=;
        b=O7TzWpi0xj6bpvrldwDThB5d/gjYTTMTVTUGLybnaeErIiSnX0YbL+nLFA3jwlYw0E
         5AIA1897C+CZBfFXRL7et9zqCOFs5ucS+OwtB0RLvx2lC7cXunDzdsY5WkECsmbINc4r
         jKxBTjBR8iNPnoUX+ms5ucm1QP0JDcZy3RJHx2/+hVdK/1f9JW0oOapO1JOJyowAU0C3
         C1Tec08uGVo4ESKQHqt/qJFV2FiAvLAN70sMRe4J3tr433DFJIPVKal0iZ/pspuOOJ2H
         Xk7JWRiqk4Tr4gNm3/nDSk+fXnWs3wYHUErkekewEmko8zPFoeH7Hb/BOWzC+ImylG7m
         8FIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ERYnZjAmqURrPxvuGkteRUMsQNSwpIjr2yYOxhN4v2Q=;
        b=BK29HBovv/Zhcg7p/k+XvKaZWF/63uKDIJae1ZieFpsYD75FpkdYLFKydUJOG6UAoQ
         M51p4tTZbDCKT263LK1o6nMUdW46dBqpMqhk26SP7WsdYUN5GQuESXdMDrwlwKJ527aI
         w8ihxYQCcBdUoftHT9doAF55QyNydSELcn8JrbV0uSiMMj4eURUMg/NE+wqH8qc+ajVU
         rTmn6L2kM8yEOVToJF4jxIY4zTP78Umu0UFmt/MlW0ThCXmqBFTVen0uyQu0Z3cIlkBG
         4fTZ0pXkZZh8K9Utt568kB4maN4/UQCYIBC3EH4oIR/2Na+aiadp+nTX0RF2hDanBTFS
         2kUg==
X-Gm-Message-State: AJIora80coqz7WQG41OliyC5K8INOtFHF+AEAtAamkiX1GZdtSo+X3LX
        sfqo867NvflD5WKvtVMS2Oor5SJaJtJyZMYy8p3s4Q==
X-Google-Smtp-Source: AGRyM1vCl0qPyGCMLN1Hg2RlXB0kcD/KLy9QPtNqCBeoiRY0/Db5v7W/iINfCxVqz8rPtKUCoyRf96cvuacwUoXdwZo=
X-Received: by 2002:aa7:cada:0:b0:43c:4f59:391a with SMTP id
 l26-20020aa7cada000000b0043c4f59391amr2129348edt.172.1658820579738; Tue, 26
 Jul 2022 00:29:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220716192900.454653-1-konrad.dybcio@somainline.org>
In-Reply-To: <20220716192900.454653-1-konrad.dybcio@somainline.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 26 Jul 2022 09:29:28 +0200
Message-ID: <CACRpkdYv4KGDtbQvW6J=RWuvOWg5wGB-L69_cOkjorzZjqSzAA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: pinctrl: Add DT schema for SM6375 TLMM
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 16, 2022 at 9:29 PM Konrad Dybcio
<konrad.dybcio@somainline.org> wrote:

> Document the TLMM driver for SM6375.
>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>

Patch applied!

Yours,
Linus Walleij
