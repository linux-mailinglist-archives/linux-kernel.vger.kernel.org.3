Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABE954E53A8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 14:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244378AbiCWN5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 09:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234058AbiCWN5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 09:57:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACAF57484E;
        Wed, 23 Mar 2022 06:55:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5572BB81F53;
        Wed, 23 Mar 2022 13:55:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1923AC340F6;
        Wed, 23 Mar 2022 13:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648043744;
        bh=P8NTZuF0QXODpURRwvFC6LW0z8AssRvgJlAdwMonpCg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oy29/wl2bpoI1wsHjVLiihwZqX1tUiGJhKfhp1QXkiNGvJw91j+dYsNT7hRqe0WU3
         gQ8emufN69eeenFbET/C7/nGr0irezv0LbcKoPZqcysYpr1jZ8CO8z44blAmwIQ2a+
         UxOYVlWfZDXl4gAbYDHMZaSX33OIN0KmBxGYUmQTu2/a4Sd+35vDDgbL+CEV+lcVbt
         VJgDiV9dxjUzjV4E1bWBSSGoVF6JZhK1e/OB5bUJk36TCzRlqsSI/uHEOzhiD1naOh
         Ej4kfgJdgKjg8Hdl4hNT09SERYuCgROQGeMqHECIRxoq7hO9IWZLOuzFwcfqPN3uyI
         MsPnJY/MnFeIA==
Received: by mail-ed1-f53.google.com with SMTP id b24so1908134edu.10;
        Wed, 23 Mar 2022 06:55:43 -0700 (PDT)
X-Gm-Message-State: AOAM531XIrD+tRbEmtxDzHQhVWmk3YEQ6kUZhuelXmhdhRxKY+O3LNTs
        nocK6qcbB66TnQbHyFwSbbpk25aXlF3fSBKhdg==
X-Google-Smtp-Source: ABdhPJyl3S/nnGcuk0QekFB6PwTDpTG4muoEfDkHxTUjbPfg2atZC9hLqjSf0xf6Kd1lpsl0pXjp+7cobGg9ogJfxVM=
X-Received: by 2002:aa7:da99:0:b0:419:17be:ceb4 with SMTP id
 q25-20020aa7da99000000b0041917beceb4mr145746eds.303.1648043742316; Wed, 23
 Mar 2022 06:55:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220224164831.21475-1-ansuelsmth@gmail.com> <20220224164831.21475-2-ansuelsmth@gmail.com>
In-Reply-To: <20220224164831.21475-2-ansuelsmth@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 23 Mar 2022 08:55:30 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLduGK=CyAcgahswFfeA43vh+QPgRgcL4+=piOwWwvJRQ@mail.gmail.com>
Message-ID: <CAL_JsqLduGK=CyAcgahswFfeA43vh+QPgRgcL4+=piOwWwvJRQ@mail.gmail.com>
Subject: Re: [PATCH v5 01/15] dt-bindings: clock: split qcom,gcc.yaml to
 common and specific schema
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 10:48 AM Ansuel Smith <ansuelsmth@gmail.com> wrote:
>
> Split qcom,gcc.yaml to common and specific schema to use it as a
> template for schema that needs to use the gcc bindings and require
> to add additional bindings.
>
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  .../bindings/clock/qcom,gcc-other.yaml        | 76 +++++++++++++++++++

This now throws errors in linux-next:

Traceback (most recent call last):
  File "/usr/local/lib/python3.8/dist-packages/jsonschema/validators.py",
line 816, in resolve_from_url
    document = self.resolve_remote(url)
  File "/usr/local/lib/python3.8/dist-packages/jsonschema/validators.py",
line 923, in resolve_remote
    result = json.loads(url.read().decode("utf-8"))
  File "/usr/lib/python3.8/json/__init__.py", line 357, in loads
    return _default_decoder.decode(s)
  File "/usr/lib/python3.8/json/decoder.py", line 337, in decode
    obj, end = self.raw_decode(s, idx=_w(s, 0).end())
  File "/usr/lib/python3.8/json/decoder.py", line 355, in raw_decode
    raise JSONDecodeError("Expecting value", s, err.value) from None
json.decoder.JSONDecodeError: Expecting value: line 1 column 1 (char 0)
During handling of the above exception, another exception occurred:
Traceback (most recent call last):
  File "/usr/local/bin/dt-doc-validate", line 70, in <module>
    ret = check_doc(f)
  File "/usr/local/bin/dt-doc-validate", line 36, in check_doc
    for error in
sorted(dtschema.DTValidator.iter_schema_errors(testtree), key=lambda
e: e.linecol):
  File "/usr/local/lib/python3.8/dist-packages/dtschema/lib.py", line
1016, in iter_schema_errors
    meta_schema = cls.resolver.resolve_from_url(schema['$schema'])
  File "/usr/local/lib/python3.8/dist-packages/jsonschema/validators.py",
line 818, in resolve_from_url
    raise exceptions.RefResolutionError(exc)
jsonschema.exceptions.RefResolutionError: Expecting value: line 1
column 1 (char 0)
./Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml:
mapping values are not allowed in this context
  in "<unicode string>", line 17, column 11

>  .../devicetree/bindings/clock/qcom,gcc.yaml   | 59 +-------------
>  2 files changed, 80 insertions(+), 55 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml
>
> diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml
> new file mode 100644
> index 000000000000..4e5903bcd70d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml
> @@ -0,0 +1,76 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/qcom,gcc-other.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Global Clock & Reset Controller Binding
> +
> +maintainers:
> +  - Stephen Boyd <sboyd@kernel.org>
> +  - Taniya Das <tdas@codeaurora.org>
> +
> +description:
> +  Qualcomm global clock control module which supports the clocks, resets and
> +  power domains.
> +
> +  See also:

I think the problem is here. You need a '|' after 'description' to
preserve formatting and ignore what looks like a mapping.

> +  - dt-bindings/clock/qcom,gcc-apq8084.h
> +  - dt-bindings/reset/qcom,gcc-apq8084.h
> +  - dt-bindings/clock/qcom,gcc-ipq4019.h
> +  - dt-bindings/clock/qcom,gcc-ipq6018.h
> +  - dt-bindings/reset/qcom,gcc-ipq6018.h
> +  - dt-bindings/clock/qcom,gcc-ipq806x.h (qcom,gcc-ipq8064)
> +  - dt-bindings/reset/qcom,gcc-ipq806x.h (qcom,gcc-ipq8064)
> +  - dt-bindings/clock/qcom,gcc-msm8939.h
> +  - dt-bindings/clock/qcom,gcc-msm8953.h
> +  - dt-bindings/reset/qcom,gcc-msm8939.h
> +  - dt-bindings/clock/qcom,gcc-msm8660.h
> +  - dt-bindings/reset/qcom,gcc-msm8660.h
> +  - dt-bindings/clock/qcom,gcc-msm8974.h (qcom,gcc-msm8226 and qcom,gcc-msm8974)
> +  - dt-bindings/reset/qcom,gcc-msm8974.h (qcom,gcc-msm8226 and qcom,gcc-msm8974)
> +  - dt-bindings/clock/qcom,gcc-mdm9607.h
> +  - dt-bindings/clock/qcom,gcc-mdm9615.h
> +  - dt-bindings/reset/qcom,gcc-mdm9615.h
> +  - dt-bindings/clock/qcom,gcc-sdm660.h  (qcom,gcc-sdm630 and qcom,gcc-sdm660)
