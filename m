Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5D657155A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 11:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbiGLJJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 05:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbiGLJI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 05:08:56 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25AD8193FE;
        Tue, 12 Jul 2022 02:08:42 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id a39so9121446ljq.11;
        Tue, 12 Jul 2022 02:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1RbNAk2loNo7HnTvuU1BMwc2UO5NqN/DOoq+VrgJR2M=;
        b=EMG22hH8EyDx9MahdYbBc1FhWhhsX6CRNDakWkenx0oAa5GLIwJogcgOF8ENLRQwwx
         Se3fEsR9DIoaK4WEu4l8vNnj+/sjr3R5m1qdqnSt20dCi8+Xf1H4y2uk06YGJZOIEJY7
         i4+YBicPhjLJf6N+16P5SwCMP3sfFFVuiUC/+7vTNas7M1lykTfdC7zY4rib22YsIIQ4
         XcoW09m4HYK9+9sJbFLXHc3cCAp/9+zIBtQAaI49DdiXAVzgCnQcLNoTQk4mHarYnNkq
         9VasOsv0nXDhMvEC7GP/J4aYp5JzWTnOnYoxwFDIRvpdMPRWE+b7sRgX0kzzmJFI4beE
         1cdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1RbNAk2loNo7HnTvuU1BMwc2UO5NqN/DOoq+VrgJR2M=;
        b=CBOFIma+FnvplVmMC/n0ADQuuzog80p2S4bv4E/mrxpUOigU3vFP4bXZg2FFe2H1Rx
         UCe+VkpKKOrZJTN9BDrDl1fRRzQoobavbDgtNNlAOhyPeMBhFtjinVlkiyzGcouWXp90
         bj9r7LfVlmBwcp+1l064iNO9lV8yYXDeJ3nQticbijW2aTP2atcG/CC7nrUqOQ2fCVxb
         a7DluSevnGtm91fMNEXM8efu6E10TSqsaDirtDZod3kN0Ihgs840yWSTDhBOBZyh4RsG
         CCqOy3ZNlBZmUQjTIZq+u8tEdGe5LjAsCniHEwkP7h8UMEsVcSChG19WruxyvwOI3g49
         wWJA==
X-Gm-Message-State: AJIora/C+42WOU9doY2+MrAFgoZI/rqL2sjBrpYGWk7d4e5CimPf2OHU
        seXphHrAwaTqx40Qs3DChVXHVC3L8DjMqnCjO3o=
X-Google-Smtp-Source: AGRyM1tMn/6KcyAf3KU/4C9+Nq+Qk7UgIhyc1wPTZ+6jwN+B0OVOO9meDPyQ93iSexAkmvKQOlI11K1GyPF2R+ttqj0=
X-Received: by 2002:a2e:9cc9:0:b0:25d:755f:c310 with SMTP id
 g9-20020a2e9cc9000000b0025d755fc310mr2927837ljj.296.1657616920449; Tue, 12
 Jul 2022 02:08:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220712030509.23904-1-mimi05633@gmail.com> <20220712030509.23904-2-mimi05633@gmail.com>
 <2f593af5-442e-67cc-9b7c-303d4c24e389@linaro.org>
In-Reply-To: <2f593af5-442e-67cc-9b7c-303d4c24e389@linaro.org>
From:   Minying Lin <mimi05633@gmail.com>
Date:   Tue, 12 Jul 2022 17:08:28 +0800
Message-ID: <CAL3ZnpxCnWt=fgNvAZ5Efep8bxbAbEb9BM3kWa00brGgoCuKLQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] dt-bindings: rtc: nuvoton: add NCT3018Y Real Time Clock
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>, a.zummo@towertech.it,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, ctcchien@nuvoton.com,
        Medad Young <medadyoung@gmail.com>, KWLIU@nuvoton.com,
        YSCHU@nuvoton.com, KFTING <KFTING@nuvoton.com>, JJLIU0@nuvoton.com,
        CS20 MYLin1 <mylin1@nuvoton.com>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        linux-rtc@vger.kernel.org, devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Krzysztof,

Thank you for your reminder.
I'm new to upstream. I will add the review tag in the next patch.

Thanks.
Best regards,
Mia

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> =E6=96=BC 2022=E5=B9=
=B47=E6=9C=8812=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=883:43=E5=AF=AB=
=E9=81=93=EF=BC=9A
>
> On 12/07/2022 05:05, Mia Lin wrote:
> > Document devicetree bindings for the Nuvoton NCT3018Y Real Time Clock.
> >
> > Signed-off-by: Mia Lin <mimi05633@gmail.com>
>
> Where is the review tag?
>
> Best regards,
> Krzysztof
