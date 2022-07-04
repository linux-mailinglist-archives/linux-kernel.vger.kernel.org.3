Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6B8565587
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 14:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234337AbiGDMf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 08:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234305AbiGDMfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 08:35:25 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91EFDF7B;
        Mon,  4 Jul 2022 05:35:23 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id p11so6661499qkg.12;
        Mon, 04 Jul 2022 05:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L26OGxCQeAShzZ7IN8Yk5BRKtL3bXrg6hbNNWf0Thhk=;
        b=H2J1VAtX82XClfLTbz2dyknW2SdL/HpBIgPgc+t6nW3Flt4B2rbbYwbkM3o+VBqYGh
         MRBgbUO5XXPZYh3i+JPo2V520/4pbmGGdkOxBwlj2Xh5VN7DK4lWnLRSn3IxdPIq42IB
         dittD39uOA2fipFI5d8Ch/HhfdTGiBXhUr5j8JZIVHsU0rKLLgsyZH6NGD0ut5SUZhHD
         oRSBVs2r0ldy1iQmKHxo6zKwIhmTcHULishK1SpjgfYvHGnciNcy+ELETDtIus0vhX7i
         v9eN+Bm+YMrTPtt0RYmXWnIoji97TGcgwN5osLIa6AjKYt0xupyA2XABMXEw6jbpNtZW
         y/Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L26OGxCQeAShzZ7IN8Yk5BRKtL3bXrg6hbNNWf0Thhk=;
        b=QttmR0d0OpchLjcE7cCAbmU3KNPkCA+3hPx7hZblv4HGAVP75PIjoYXPdFnMvjBEw7
         9YyeugIL/US6qdOqyQDPmsfcy5uJQyqR2svc/WcEO30FKXaBJxkL2l6nQJbwLrylgiQA
         ihLJ/JxQ0iEqw+7GI769w7aXdmrUftAlCqKZyjxlnwEyD4OFeU8t33sqCrdXgR/DHh0G
         5tto+TIOELcO8e5Kgy5mNBGPxrmSk5sfVa/nhRQvb+2xqB35LqX/ic2Gmr6e4m15J/W0
         DDn0oHVg/3AdtgIRF2rbpORI1l42xc17cEx2xQou/4r2j5Gdd9zu0r+q5eu8VJs2JV+e
         nXew==
X-Gm-Message-State: AJIora+oLPHX4A7L745IsgnW+j18ZdJ6OZdt9b2r9wXThJ5gRgrlg8oy
        rq9Ibtwn4cK681zFh4xWzhdkXJYm8v2G88IVRvQ7Ht1gEvE=
X-Google-Smtp-Source: AGRyM1tO2cWDq82bBvy53yJ+ZJclz3mgz5qV9XFfpKFeyWeZGrSR2O3+0HJQp60M/tHFBY+AEYnUJzaPgzOoojMTcuQ=
X-Received: by 2002:a05:620a:4547:b0:6b1:4f80:d5a8 with SMTP id
 u7-20020a05620a454700b006b14f80d5a8mr18661614qkp.87.1656938122800; Mon, 04
 Jul 2022 05:35:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220704113246.622917-1-robimarko@gmail.com> <8f6f1bad-6ad7-7092-7395-145cfe565ced@linaro.org>
In-Reply-To: <8f6f1bad-6ad7-7092-7395-145cfe565ced@linaro.org>
From:   Robert Marko <robimarko@gmail.com>
Date:   Mon, 4 Jul 2022 14:35:12 +0200
Message-ID: <CAOX2RU7pm1tc=nAVNk9QB0=SeWoTNFgOsyMPbOPbAV762KvARA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: ipq8074: move ARMv8 timer out of SoC node
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Jul 2022 at 14:30, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 04/07/2022 13:32, Robert Marko wrote:
> > The ARM timer is usually considered not part of SoC node, just like
> > other ARM designed blocks (PMU, PSCI).  This fixes dtbs_check warning:
> >
> > arch/arm64/boot/dts/qcom/ipq8072-ax9000.dtb: soc: timer: {'compatible': ['arm,armv8-timer'], 'interrupts': [[1, 2, 3848], [1, 3, 3848], [1, 4, 3848], [1, 1, 3848]]} should not be valid under {'type': 'object'}
> >       From schema: dtschema/schemas/simple-bus.yaml
> >
> > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > ---
> >  arch/arm64/boot/dts/qcom/ipq8074.dtsi | 16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
> >
>
> This is a duplicate, I guess... I responded to newer patch.

Yeah, git-send mail failed the first time so I resent but it actually
succeeded the first time as well.

Sorry for the confusion.

Regards,
Robert
>
>
> Best regards,
> Krzysztof
