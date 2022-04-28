Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A35235139F4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 18:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237626AbiD1Qj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 12:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiD1Qj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 12:39:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28EC6888FA;
        Thu, 28 Apr 2022 09:36:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E64AEB82EAE;
        Thu, 28 Apr 2022 16:36:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0ADFC385AF;
        Thu, 28 Apr 2022 16:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651163798;
        bh=5NZb3/YON7lOYIzTiyY5Y3HKC8KYwRKNiHRhLIgoZOg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WCvKqtEZJ8o8BiX3t+wq3lBaxr+UlZFG6vPZJ7219Fbi/VpAqrznu8B0Ee1+fM4MW
         HaF1GBEu0W8ofA2nM3EnQaTn/yaTyVTiJVzEhBPEAaAH6UJGOM0usgBjmkoFi++sDu
         Bu/hAbA1+1cT89fgNw9vQ1H5RDeo1GBSFyyyjgfST5agCD/PV/JnaZq8DyeJGckAyM
         U6J2jieZWbDrLUcmf3eUQ/2IoEpdkANF8xOf36VPl48mRKUrgwwGOZUupvbdzwz//B
         PoblzIRVMJGhWkGVWfG8U385eJW0R0fRCUJCJIZo8WxvnwPHxKstY69UbawU6uVl2w
         R06oYd9NzQJFA==
Received: by mail-pf1-f177.google.com with SMTP id y38so4708573pfa.6;
        Thu, 28 Apr 2022 09:36:38 -0700 (PDT)
X-Gm-Message-State: AOAM531ZfzweumK8gOaUh+3Adc65kWxrhxC8Ty8C4PsvESfj9m4arHxV
        6dXQHlMWKnyhlDBCGrjErL4UOrfMczCESEKorw==
X-Google-Smtp-Source: ABdhPJzcKZ0OAuC5ZcVAsgH/gXKAjIFW8NlQFPQY8Cah1gJd91WgIR8mzvN5Xix8YtdJqkfSA2NcM48JolV6qLi8EWk=
X-Received: by 2002:a63:88c8:0:b0:3ab:1871:13b4 with SMTP id
 l191-20020a6388c8000000b003ab187113b4mr21611277pgd.85.1651163798185; Thu, 28
 Apr 2022 09:36:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220423085319.483524-1-markuss.broks@gmail.com> <20220423085319.483524-3-markuss.broks@gmail.com>
In-Reply-To: <20220423085319.483524-3-markuss.broks@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 28 Apr 2022 11:36:26 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+hBtuet-WShvvLA7vfdFdpGRSmv45bcqQhoediq7a7xQ@mail.gmail.com>
Message-ID: <CAL_Jsq+hBtuet-WShvvLA7vfdFdpGRSmv45bcqQhoediq7a7xQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] dt-bindings: regulator: Add bindings for Silicon
 Mitus SM5703 regulators
To:     Markuss Broks <markuss.broks@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        phone-devel@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
        <devicetree@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy
        Shevchenko <andy.shevchenko@gmail.com>," 
        <~postmarketos/upstreaming@lists.sr.ht>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 23, 2022 at 3:54 AM Markuss Broks <markuss.broks@gmail.com> wrote:
>
> This patch adds device-tree bindings for regulators on Silicon Mitus
> SM5703 MFD.
>
> Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
> ---
>  .../siliconmitus,sm5703-regulator.yaml        | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml
>
> diff --git a/Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml b/Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml
> new file mode 100644
> index 000000000000..75ff16b58000
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/siliconmitus,sm5703-regulator.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Silicon Mitus SM5703 multi function device regulators
> +
> +maintainers:
> +  - Markuss Broks <markuss.broks@gmail.com>
> +
> +description: |
> +  SM5703 regulators node should be a sub node of the SM5703 MFD node. See SM5703 MFD
> +  bindings at Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml
> +  Regulator nodes should be named as USBLDO_<number>, BUCK, VBUS, LDO_<number>.
> +  The definition for each of these nodes is defined using the standard
> +  binding for regulators at Documentation/devicetree/bindings/regulator/regulator.txt.
> +
> +properties:
> +  buck:
> +    type: object
> +    $ref: regulators.yaml#

The correct file is regulator.yaml.

That's indicated by this warning:

schemas/regulator/regulators.yaml: ignoring, error parsing file

It will fail worse than that once the example in the MFD file is added.

Lee, Mark, I've said it before, but MFD plus child schemas need to be
applied together. Maybe no one cares if dt_binding_check is broken on
the MFD tree. The primary issue for me is transient failures during
the merge window.

Rob
