Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6572053869A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 19:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241233AbiE3RKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 13:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236466AbiE3RKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 13:10:09 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427AB52E77;
        Mon, 30 May 2022 10:10:08 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id v29so11324304qtc.12;
        Mon, 30 May 2022 10:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oxsU6BZPmhtsJk029fJfCgFa/Yx2pedHRJxAPup2ZGQ=;
        b=a30J9ZLHq6PnD5dvjYW+JCZoywHdde68D0HZmkyj6gn3MAQ9fPZEfjH0OZP8FfXfD8
         KioNnFiNqfK0Gxlr3ZYx8/lOcnYTVEc9vkQPXOGKLjWu0nF1pHTk9nbuTtRycyH/pTyh
         2Pq2MMILU0AknlES52s+lTcxRULffvbqRnfE4nXWeVjq0rR25vklbftGfmL9GaKGLTre
         viqEVh5IknyASwbm6c33FHh5cgcxxFG5Qggh0lJQa9+kOVZSCpeqEOoe2n1j/TeLgClP
         hUB2XHY1w3sw3JhOtgmbxclT84H9/Lqp8zXF7NksQxt3uRUN2QHPfFIoiZ3wZepH88BC
         orOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oxsU6BZPmhtsJk029fJfCgFa/Yx2pedHRJxAPup2ZGQ=;
        b=M39P57q27OHvjHjBuNR0K7amE1X2B3hm2VB7piTfzZqm8k9DeyJwxLTJPUnWePFDki
         pryhE1mV/Oiw9AUIepq3R5QhKWi03MA5nE024wGckudpMAAG4xkfTKwqsrazOvtOcMns
         JU/2ZFD5wr4/VcK6O0bZU7j1ocUWI/6eYNSzmd8pfLtMnRI5XsIkDbGT/NqJVojGu6vK
         BU6xMTvGe7dd98aBPIj7YXWsWIcUvw8LGoS9KmfJdM6s2oYgPvvzzb34BJTRtsQdUtvU
         vsZltB1a1/BgV5wy6M16XW/MPNszvquKzlwKF0SUqMZcNYe5h0Ou5q/xaNIhmK4/d7Gt
         Udgw==
X-Gm-Message-State: AOAM533rFl5zt+TAl7HfUazU53YAwp6Po/bwBn5amXKTUZo5/8V+W1cr
        CvXF/i+S7pJZFTRhVD+8IHgXAXt/8pfHdWmExUk=
X-Google-Smtp-Source: ABdhPJypCNQIFlpWBttNDE/gYRkzMxJZx8QGhKo3Xhy4l4xBXUyrYHjYlgEvGcQO0xUVQKj90Oj0OSHjrBmwmLXhstA=
X-Received: by 2002:a05:622a:138a:b0:2f3:e12d:a023 with SMTP id
 o10-20020a05622a138a00b002f3e12da023mr44545627qtk.82.1653930607237; Mon, 30
 May 2022 10:10:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220519133015.484639-1-robimarko@gmail.com> <20220524022243.GA2625732-robh@kernel.org>
In-Reply-To: <20220524022243.GA2625732-robh@kernel.org>
From:   Robert Marko <robimarko@gmail.com>
Date:   Mon, 30 May 2022 19:09:56 +0200
Message-ID: <CAOX2RU4JED8144JuVWtQyF9opqseUviDU7Z-an6eKVy_A=A_-A@mail.gmail.com>
Subject: Re: [PATCH v5 1/7] dt-bindings: regulator: qcom,spmi-regulator:
 Convert to dtschema
To:     Rob Herring <robh@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        lgirdwood@gmail.com, broonie@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

On Tue, 24 May 2022 at 04:22, Rob Herring <robh@kernel.org> wrote:
>
> On Thu, May 19, 2022 at 03:30:09PM +0200, Robert Marko wrote:
> > Convert the bindings of Qualcomm SPMI regulators to DT schema.
> >
> > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
> > Changes in v4:
> > * Remove blank interrupts and interrupt-names as generic properties
> > to only allow them per compatible
> >
> > Changes in v3:
> > * Remove quotes around refs
> > * Use much stricter regex for regulator node matching
> > * Add supply matching per compatible
> > * Add blank interrupts and interrupt-names as generic properties
> >
> > Changes in v2:
> > * Remove the forgotten text bindings
> > * Move allOf after patternProperties
> > * Use my private email as the maintainer email
> >
> > I am aware that syscon alone is not really acceptable, its converted
> > directly from the old text bindings.
> >
> > Any advice on how to solve this is appreciated.
>
> Add a compatible for the block in question, but that means you have to
> have a schema for it. Or you can just drop the node. This binding isn't
> really about that node.

Sorry for the late reply,
I think I will just remove the example node to not complicate the
series further.

Regards,
Robert
>
> Rob
