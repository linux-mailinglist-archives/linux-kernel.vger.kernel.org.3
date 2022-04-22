Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15F7650BFE5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 20:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiDVSoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 14:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiDVSn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 14:43:58 -0400
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845A528E3D;
        Fri, 22 Apr 2022 11:39:56 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id e30so7907012eda.0;
        Fri, 22 Apr 2022 11:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bPNNWfLorKQdlTFIcjMKIT2TFnHa6NCO/tOM3FpNRzI=;
        b=pP6MZqf6ePvtfF8C835aDJIPBvIV4lDmCDZhjumIvJCQVxJtJREqUoC0VxvW6c78CI
         W1Db4zEr+1RPlTjOQCGM2twHKDnpTZHL4FYuvzjhHG0ZblJmKqye31fbrgxc3NKypZ1I
         Ug3HvhkTfBISMUd/Jrb4wumZvYE1Z6LFM5tuRsWGOKsfJRunnWB1fLbjGce/CsMUYyo3
         JMdpCSzshEeL2Q+5usL2vPWhlKRzLHKvxcK1dGqVPO0b7or2wMsySbttMus3R4kVqv1l
         BRRLX+sMN8v3A4fxeTVpW8gtLjWSnxUPPqgkpZtNjsvsa7VSqCun6TQhFpUATMUeg8Q8
         mlig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bPNNWfLorKQdlTFIcjMKIT2TFnHa6NCO/tOM3FpNRzI=;
        b=cPrpl+IQ1PS1qREDOo0BcziXavDqAPCtiBNTW+h/xpfoS/4doseyAtinKFa11Liztx
         lrlIsvAF/ykT2PEh+tv4q0Dj1m0sAijNW+Fd0yrNYTETw62LE73f1KvHpdIwB8JaG5pX
         EvmdNWs2UmuWXNWbxSvhis29ts6mur5lzUFvD1jeyt2LtNlxgG84Zd5n3wFGJlE0lH8j
         bCwOxoD6fImHacX9HA9ofhErqTiwEbgcPpSG941oh45/Tlge4kc2p/d2K09am0a82r2h
         X6Hvy4vyiJupG1oTsUE25wyXoDa9jm55GoB4w0Z9kaUH/GgfsN8EUFtVQBsfUYVxBOzz
         i98A==
X-Gm-Message-State: AOAM531L+Q3ZS3k+IgP4ZZRd4+AmX7RXvVDGxBiJvF/ts2M1pwcvGG/N
        f1blcohI5synUsRJoUW/N4FivV/291agsupulIo=
X-Google-Smtp-Source: ABdhPJwE2DVZWKHijzJDzimQ+LsCESxc4MQeRHdyFiQT+g0Dn0dBzdTwYzWmusdEEtXivLVlXKGE0ciNAZff560gHD8=
X-Received: by 2002:a50:bae3:0:b0:425:b2b5:6248 with SMTP id
 x90-20020a50bae3000000b00425b2b56248mr6239060ede.281.1650652404409; Fri, 22
 Apr 2022 11:33:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220419160058.9998-1-markuss.broks@gmail.com> <20220419160058.9998-2-markuss.broks@gmail.com>
In-Reply-To: <20220419160058.9998-2-markuss.broks@gmail.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Date:   Fri, 22 Apr 2022 21:33:13 +0300
Message-ID: <CANhJrGMe0Vxt_KxzMX_9oGyaFeMi5hmNCYje99a8DB-tHZKuYg@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] dt-bindings: regulator: Add bindings for Silicon
 Mitus SM5703 regulators
To:     Markuss Broks <markuss.broks@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 8:36 PM Markuss Broks <markuss.broks@gmail.com> wrote:
>
> This patch adds device-tree bindings for regulators on Silicon Mitus
> SM5703 MFD.
>
> Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
> ---
>  .../siliconmitus,sm5703-regulator.yaml        | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml
>
> diff --git a/Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml b/Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml
> new file mode 100644
> index 000000000000..a8ffd3ecf3a5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml
> @@ -0,0 +1,52 @@
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

Maybe It'd be better to nowadays refer to the regulators.yaml

Best Regards
-- Matti Vaittinen
