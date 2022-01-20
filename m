Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2581494C5B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 11:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiATK64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 05:58:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbiATK6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 05:58:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B47C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 02:58:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7501061535
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 10:58:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3A52C340E2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 10:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642676333;
        bh=+jkyxXMoEk5+hwtBJlffpwJ8aa4wwzoRMO9NurvgCWU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=g8YoZlVkh/8k178K0nLX3wCKHTyTeisRKNVJwPT8ky5ra7t+9c50Mymp49zx4hvA8
         KHG361Br503LtIHzpMLGQLbZMXsdBX693wh56U+kx0ISfnb6z9MQMTqNP0l1UhAd/l
         bbbMRpdJVPc0t9bvSJchRS4xLi/FEhhXqVcJNG8RunmVPOt5fy6bbjIeopq0p6gT2l
         djl1pvdmppC8+L1diVcoUFU4czH0IuGEr197CKK0n8anbhUm5I3BeZHaj9h8l6KmH6
         FC2NJ3rqvC+y3cInKFDY2Kudu9DgHl0Sj6pn+GwwsB0aTg+aC5bjg7tKG4mA7SDR9S
         NTcYYDYcTdevg==
Received: by mail-lf1-f44.google.com with SMTP id d3so20004282lfv.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 02:58:53 -0800 (PST)
X-Gm-Message-State: AOAM530duo5ttSqT7Qo8BPAm72zcpxWp5bEeEo0dO97L+tAS5xnkMrkj
        g7I7+R9fQlpEaUoYnthSa3+5d3+pICk0WL/KDFiIyg==
X-Google-Smtp-Source: ABdhPJzCBCnJZ3oIXFukCi1Pa6f/1m/OuPcJzRFUfboLxTs9Ofigs2PhdSiU3aU8RkHR44+n8gnJLTI4QW+JwXe3GT4=
X-Received: by 2002:a05:6512:986:: with SMTP id w6mr31394398lft.201.1642676331951;
 Thu, 20 Jan 2022 02:58:51 -0800 (PST)
MIME-Version: 1.0
References: <20220112194118.178026-1-luca@z3ntu.xyz> <20220112194118.178026-7-luca@z3ntu.xyz>
In-Reply-To: <20220112194118.178026-7-luca@z3ntu.xyz>
From:   Amit Kucheria <amitk@kernel.org>
Date:   Thu, 20 Jan 2022 16:28:40 +0530
X-Gmail-Original-Message-ID: <CAHLCerMEvDyrxkwpd+POUSjspkEfw=-FhPCS1=nX5WOVH4=bcw@mail.gmail.com>
Message-ID: <CAHLCerMEvDyrxkwpd+POUSjspkEfw=-FhPCS1=nX5WOVH4=bcw@mail.gmail.com>
Subject: Re: [PATCH 06/15] dt-bindings: thermal: tsens: Add msm8953 compatible
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 1:12 AM Luca Weiss <luca@z3ntu.xyz> wrote:
>
> Document the compatible string for tsens found in msm8953.
>
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> Acked-by: Konrad Dybcio <konrad.dybcio@somainline.org>

Acked-by: Amit Kucheria <amitk@kernel.org>

> ---
>  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> index d3b9e9b600a2..b6406bcc683f 100644
> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> @@ -43,6 +43,7 @@ properties:
>        - description: v2 of TSENS
>          items:
>            - enum:
> +              - qcom,msm8953-tsens
>                - qcom,msm8996-tsens
>                - qcom,msm8998-tsens
>                - qcom,sc7180-tsens
> --
> 2.34.1
>
