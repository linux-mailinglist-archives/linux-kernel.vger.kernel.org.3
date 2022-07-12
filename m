Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 261335713E5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 10:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbiGLIDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 04:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbiGLIDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 04:03:45 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079026579;
        Tue, 12 Jul 2022 01:03:44 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id n18so10912072lfq.1;
        Tue, 12 Jul 2022 01:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A/bW8s0zoH5UpbLSo1+jfXj3G0A2yQEqrO879sTZg5Q=;
        b=VxhyLif+q+1G5dGPSu8k90vU6hL373LvHxZVzMk2MsBLRbSavwWVZuWG4a7zM8cQyY
         BMMgqdsHgFtEmT177VKDRc/pI12Gty4TW6NC70OWWz8TefcTzMbk/okzFrp8kY4+EiP6
         EjB100143GnuOMTbCmW7YjtnPof97VLNkIz1GsOc5nw/85fSnZTJDtl+RpRTrsd+dG31
         XfgxLsHc1ubY3Z8e1zzV2DOQzihtp+ayYK15qMCNTM/Ald/3WoVLN3ljCiaXNNhCd/4m
         5yGdhq5+Ck5mb9puVd2BGr5QutymWQVbpD/CLv/Ve8fAXdHvonmIwHoolZB1N4oioj0h
         3ayQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A/bW8s0zoH5UpbLSo1+jfXj3G0A2yQEqrO879sTZg5Q=;
        b=7Vjq8M+HLbtN5alxc2pw6Nexr542QSj3FrYRgRCnBPNXhzEm2TzfERxDBV5rq5LH8U
         xuvY0pt6YPPJrC9nDWgXGEN7j4/dQjyug8qMTVP1GbvCUBdtr0DJjKViCDZG6rt2NLMn
         JaBR0Pt9N++O1sD96hond4N2Nc696qVe/0XprsRAhL2yRIDXjEYhy7u0ofc55Cjj1qc6
         liLeG9fPMoITeklsz7NfpUydFbj9NLE19/XuI230Ngekij3cmSHOSJckWpMyXmXNWnNq
         pFp9LfLHQKVCbBdODki14T5d2e/ztVgBdbgbw45uT5PV/FUWyoVHD8SJ4b5kmYZZC8f5
         1RjQ==
X-Gm-Message-State: AJIora9596abcU0SCGQUmnyYMez/LZjCmxRLX/Le9MhnXrz1FNTDJKWv
        JH0BRhiSzGtcRStvohizhndI++eb6LlDdk+lS8U=
X-Google-Smtp-Source: AGRyM1uetHv/UaG2R06jgnf9Ql2EOiVLPNLAlyTB3qAJPBJR9BfzPSFpwGS8ztIHge2xsMxx4c18CNJkdJ+rPX76K6M=
X-Received: by 2002:a05:6512:1188:b0:481:2eb7:f2 with SMTP id
 g8-20020a056512118800b004812eb700f2mr13946842lfr.401.1657613022433; Tue, 12
 Jul 2022 01:03:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220711134312.234268-1-tmaimon77@gmail.com> <20220711134312.234268-2-tmaimon77@gmail.com>
 <1657562119.172361.4172123.nullmailer@robh.at.kernel.org>
In-Reply-To: <1657562119.172361.4172123.nullmailer@robh.at.kernel.org>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Tue, 12 Jul 2022 11:03:30 +0300
Message-ID: <CAP6Zq1jAzHysKaVMt960hsL2rN05_kfC265CS8Xcz1r8KOQDPg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: iio: adc: npcm: Add npcm845
 compatible string
To:     Rob Herring <robh@kernel.org>
Cc:     zhengbin13@huawei.com,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Nancy Yuen <yuenn@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Tali Perry <tali.perry1@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Avi Fishman <avifishman70@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Benjamin Fair <benjaminfair@google.com>,
        Jonathan Cameron <jic23@kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Patrick Venture <venture@google.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thanks for your comment, it will be addressed next version.

On Mon, 11 Jul 2022 at 20:55, Rob Herring <robh@kernel.org> wrote:
>
> On Mon, 11 Jul 2022 16:43:10 +0300, Tomer Maimon wrote:
> > Add a compatible string for Nuvoton BMC NPCM845 ADC.
> >
> > Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> > ---
> >  .../devicetree/bindings/iio/adc/nuvoton,npcm750-adc.yaml     | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
>
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/nuvoton,npcm750-adc.example.dtb: adc@f000c000: compatible: 'oneOf' conditional failed, one must be fixed:
>         ['nuvoton,npcm750-adc'] is too short
>         From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/nuvoton,npcm750-adc.yaml
>
> doc reference errors (make refcheckdocs):
>
> See https://patchwork.ozlabs.org/patch/
>
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>
> pip3 install dtschema --upgrade
>
> Please check and re-submit.
>

Best regards,

Tomer
