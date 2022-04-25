Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3112950E989
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 21:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244962AbiDYTgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 15:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242465AbiDYTgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 15:36:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB5F11114B;
        Mon, 25 Apr 2022 12:32:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 64A68B81A2B;
        Mon, 25 Apr 2022 19:32:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06828C385A4;
        Mon, 25 Apr 2022 19:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650915173;
        bh=+Ldmjo2nOkdw5AcH6ZzgLglBh0fhTCqRCzAYPRBrJ2k=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=dn8bgOUj9DkwKFWUn6Rk8A0RTJrf8u4iAM9vb9E4FSVQEb57hveL2yyjljPehhFHP
         pGdEZ9pEvyE23cnIrKcY5PxUmkoRdoRZvYMZBhrawVkDL8i0T32y1YinycXywWddh8
         g47bGhux2twSn7n4+lk864+gxJiOizDVPU7fu+o8VtvC3XWwGViGJTsmgp26eWqOPi
         AFgXl9hZP6Rg/nXCQx3G0A6UMVOMyqW66BceiGY3Aofm3Yj8lyYI72sKzfhrUwef8L
         49kvuox9ef5ytd1V8d6ngt0pudXu1qbGFSm5c4DoKkmRIZzWgw/M62VF9BGtmSoPEB
         oxExbf8gd61WA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220425133527.3723233-1-robh@kernel.org>
References: <20220425133527.3723233-1-robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: clock: qcom,gcc-apq8064: Fix typo in compatible string
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh@kernel.org>, Taniya Das <tdas@codeaurora.org>
Date:   Mon, 25 Apr 2022 12:32:51 -0700
User-Agent: alot/0.10
Message-Id: <20220425193253.06828C385A4@smtp.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rob Herring (2022-04-25 06:35:27)
> The compatible string should be 'qcom,gcc-apq8064', not
> 'qcom,gcc-apq8084'. Found by enabling undocumented compatible checks.
>=20
> Cc: Ansuel Smith <ansuelsmth@gmail.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yam=
l b/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml
> index 97936411b6b4..9910a3e033bb 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml
> @@ -25,7 +25,7 @@ description: |
> =20
>  properties:
>    compatible:
> -    const: qcom,gcc-apq8084
> +    const: qcom,gcc-apq8064

This file has dt-bindings/clock/qcom,gcc-apq8084.h referenced. Should
that be removed? It looks like commit a469bf89a009 ("dt-bindings: clock:
simplify qcom,gcc-apq8064 Documentation") took the more than just the
compatible for apq8084 from qcom,gcc-other.yaml and put it in here while
removing gcc-apq8064. Probably the apq8084 part needs to be a copy of
the apq8064 file with the single compatible changed.
