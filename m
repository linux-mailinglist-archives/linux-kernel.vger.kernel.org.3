Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 441E0526C1E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 23:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384616AbiEMVJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 17:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384609AbiEMVJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 17:09:40 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A065F84
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 14:09:38 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-2ef5380669cso102543657b3.9
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 14:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ikL0/gwIaUWXfMtkCpW673auiv9e8rY9L7j8kbUCodE=;
        b=vnm5P9psR0k0g/RGFnw+D3DgIlgSFzdTxdgBIGsyCdmrlWc3ziSI1keco4oQEKCXby
         oswqgtNO/SfqRjShMbKhvJ1Kd6BVsK5PH0LnU//aAlk+aGxF0J3aLSRL5OrC0hyx9Qb5
         0z3jvLqFW4xz7nYE6J3u91Ku0t24ytF0jIlNEDxDI8sPRurCTQKet9UwSndD2qN4T0KO
         BFZXSct77T9J5LCsCDeYWjyBrc3TdNvg5kQj+iHGT+h550kmr86zJaYQBeuPgq8Ah+3z
         28pMm0GRY4lZf6P2UX0coGvPbP+PtkT6Grr2Vt7r0MhPky3t0Od0Z34C/gLNtoBiM83N
         EQVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ikL0/gwIaUWXfMtkCpW673auiv9e8rY9L7j8kbUCodE=;
        b=2wUi9yZBpBArV4OMxaBvJzbdJvHs6L/9kl+6oY0o4ZNWMRJk1Cz36t2TJYvj4lYr+g
         MMTb9j82uBcpAFWWZ6j4WE9kl785+1MOi6NR36hvv9whzoJjJ01zv1nZKai4KLMAhn6N
         kb+0hLgldNZIodsCUoxZHrc852U/gO+xKoB/5jijZtAo66H5AXcM4fGCohlGUit4rjZE
         WWhBdjpzUnKSTGCh5luN8ItLT/EgBreDPPAbtICi80H6ARAK10h93BEIIuvNi9bugxhU
         VwWTO/iheFz9LSk8NIS3mxfS4BNX9Sw3qC+rIiJjn9I92UhuDCjw6tHZxx7MG+n7N3ID
         071w==
X-Gm-Message-State: AOAM530XEit/STfYtJN9l5MxW7YEQGW0QzXjiFOc/FvuoVRIYAutcl56
        fdOTbRPJMGIzqFnRHzmumyYYdBMtG2jNxWUa8Yx7zQ==
X-Google-Smtp-Source: ABdhPJyZhSGsZyH7SCsSN/Tf1gdlPJvallUvmRrCHX9UTyZ+zCvIzg6tvp2h34sx39n1RCDeM63EkvOGZpI/ej/L83s=
X-Received: by 2002:a81:6d4f:0:b0:2fe:b911:fb6d with SMTP id
 i76-20020a816d4f000000b002feb911fb6dmr4488107ywc.140.1652476177376; Fri, 13
 May 2022 14:09:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220511220613.1015472-1-marijn.suijten@somainline.org>
 <20220511220613.1015472-3-marijn.suijten@somainline.org> <d2507298-00a6-a1cc-0302-f96597fb4127@linaro.org>
 <20220513091734.hivkkbpc6inyb4la@SoMainline.org> <5cce491d-c673-d2a6-3aae-79b2e5902a01@linaro.org>
In-Reply-To: <5cce491d-c673-d2a6-3aae-79b2e5902a01@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 13 May 2022 23:09:26 +0200
Message-ID: <CACRpkdbyVScvnn-99XQ526B=64fQp34PKjot1CJ2Wfm0PKmZgg@mail.gmail.com>
Subject: Re: [PATCH 2/7] dt-bindings: pinctrl: qcom-pmic-gpio: Add pm6125 compatible
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Fri, May 13, 2022 at 11:37 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> >> This will need fixups or rebasing on my sets of PMIC gpio schema cleanup:
> >
> > Ack.
> >
> >> https://lore.kernel.org/all/20220507194913.261121-1-krzysztof.kozlowski@linaro.org/
> >> https://lore.kernel.org/all/20220508135932.132378-2-krzysztof.kozlowski@linaro.org/
> >>
> >> Bjorn,
> >> let us know preferred order (who should rebase on who).
> >
> > I prefer yours to be applied first, so that I can retest this
> > patchseries with stricter / more correct dt-bindings introduced by it.
> > My series can also be resent with the notice that it has already been
> > rebased on top of your series, after collecting more reviews.  Where
> > necessary, I can review your series too if that helps getting it in
> > sooner.
>
> Sounds good. It's in Bjorn's hands now. :)

Ugh can I get that with a pull request? Maybe Krzysztof can provide?

BTW I have high confidence in you Krzysztof after all your work on the
Samsung pin controllers, can you and Bjorn
discuss maybe adding you as comaintainer for Qualcomm pin controllers,
it's not like Bjorn has too little to do.

Yours,
Linus Walleij
