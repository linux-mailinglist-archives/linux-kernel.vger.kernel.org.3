Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E994F4E2B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242601AbiDFAL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 20:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573397AbiDETGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 15:06:47 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D74DFD76
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 12:04:49 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id e4so98681oif.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 12:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=GcT/Qp5BSis/zPJ+f5Dmt0URaQO6bvL9wtwFht8dT2I=;
        b=N1IWSIlIkbDLe6ZqcffdHg7hOStPnaPFx1/YR11naDSdTrmY80n8Nd/Pmn+/xk0MEi
         SQIRG6WxR8kpzmCqifIOWobkr+bpD+l/DFRLnOzHw1QdGQzpv02jC1NLiQtBXYUQpUoC
         ycAE/2sNgOwQCH6VhB5PuJwbvit8U0nMNQqAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=GcT/Qp5BSis/zPJ+f5Dmt0URaQO6bvL9wtwFht8dT2I=;
        b=P/3PCd3Tk03e3TrugwQsHfjn9FzpxR2PNjW3UFaOvwpf46MrxN36BVqr8+jn0qhgBL
         dEzql2dIj98Pqx/qWSBf2+Ev1ezNdnvAHHJmiWt1fGYE9M2KDhNEdfpax2ZX8Cg/AAK1
         uPjO7syEzthLpehlsmihK5Jl9kQCXXK/3WajxHpvYROYl/lPst2+ugGJ2JVvSMGxOgdj
         hWeVq8oYSlWRvGIjJRw2oFGkUYMXQytQ/tkJ3aMk2HaMBV/QoqhhqNGvyOQ4uGTnyTpt
         lwSG55WF8BkvGekgoRuP3G6h+QjLTP0lqHMLLn3H51tFrZ8Nzwuo4nmelN7WXCd1YLaN
         1p/g==
X-Gm-Message-State: AOAM532h8L7gYHfJ2OhDnlPucfyJSSVEzecrGdfDtT0vWATkKPlCSSPs
        eVicSheeD3rkkt3Kl1lsEpi0LjIS+5Kpj6mEy9j1pQ==
X-Google-Smtp-Source: ABdhPJzopvZ8fX9C7aKOnjzWjlUsWkpdzVov43aMeOQD81tRqepWzevuGpqtMjraEe+cC8Zw8S1beZ+R+MUDupc/Q+g=
X-Received: by 2002:aca:bd41:0:b0:2ec:ff42:814f with SMTP id
 n62-20020acabd41000000b002ecff42814fmr2074558oif.63.1649185488696; Tue, 05
 Apr 2022 12:04:48 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 5 Apr 2022 14:04:48 -0500
MIME-Version: 1.0
In-Reply-To: <1649166633-25872-2-git-send-email-quic_c_skakit@quicinc.com>
References: <1649166633-25872-1-git-send-email-quic_c_skakit@quicinc.com> <1649166633-25872-2-git-send-email-quic_c_skakit@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 5 Apr 2022 14:04:48 -0500
Message-ID: <CAE-0n50h5XOgEN-Jf1p5bF4GQVUUz76hLACG0rbXxTVn73R24w@mail.gmail.com>
Subject: Re: [PATCH V9 1/6] dt-bindings: mfd: pm8008: Add reset-gpios
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Satya Priya <quic_c_skakit@quicinc.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_collinsd@quicinc.com, quic_subbaram@quicinc.com,
        quic_jprakash@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Satya Priya (2022-04-05 06:50:28)
> Add reset-gpios property for pm8008.
>
> Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
