Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21FDC54CC8F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 17:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349353AbiFOPT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 11:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349227AbiFOPTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 11:19:23 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B6C24956;
        Wed, 15 Jun 2022 08:19:22 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id e4so13681698ljl.1;
        Wed, 15 Jun 2022 08:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jtDLXWranri9SO0ungbK/rfZfrPvocRl+VfvQBvGjo8=;
        b=f0HQ1vv+o5fTCQrso/rD+FdM1EuNryosCq4xi7a9dblyGF8itOuVz/ArZ2rBPrReQi
         QRhKSEYCSaKboZzrI+WtJayBbQSMgjtMBUY07ud/MZv9f20xWM9YBOMDGNpmJPGnVfZn
         209azDbGMveKEJsAAVbxLirdJBZkLvA7r0SeKTECZwNIhOsNeB9wXNJcIS5PQTRxObbC
         lboCdrIwtKAz+hwRVHeKGX60bbi2aqKw7L+H1b0OJ2V4yTLxgUAtjCexprm0GQtmMybV
         2IAahrCiVwtuRg95F/zWS8qMTAuCJspW/+smwGj3Z9mDHdDRJ5C1lrqdwI2JQFYkTKV3
         ciWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jtDLXWranri9SO0ungbK/rfZfrPvocRl+VfvQBvGjo8=;
        b=xyG4fWuy7Q9rh4nOn+cnzm9lleplXk1aZ9ZF11cGLsSxbAoxOkEjQQq28/PedDRu5y
         OxlVGA7KiMXztUj3Cpm/7obIOOgP8rOIy4WfLAbmQvtHFm6C9Bkn+uIVHEZAcXKxZcrb
         Bl85SriGczwwzt2oa769rpj5BBy9Hv0TJpNsKxuVXpYqdilWGdEHXSNUPcS1whhXQ+az
         PA5b8D4v/6+yo8HhXbHB1FAA42Y/S0gGnNosD3iC5SUNAPDDULh4yu3wSzouQOlWxSwH
         hNBw+BjV+d+Vs5qV/UY9qt1B8b3y2uFlzbIAz+0VULm88G076fmYns5mj9gIF0KvKHAf
         KpEw==
X-Gm-Message-State: AJIora+mw5oCyHepgNLO1RvIsMljk4cAOvbWrKlQyAMfMKfp8pq7PXOq
        RHX3pQSHClUg0dxtS/0/xM6/DZHXMjHSD4nUso4=
X-Google-Smtp-Source: AGRyM1s3Wkd6PJq3so/0xApmm+/Ezzsnk7JGMgg9Ouusxj+OYaPM8DZ979+vYb4QeZlGOTCPIUZcr+weDB4mqcGTDxQ=
X-Received: by 2002:a05:651c:54f:b0:255:9ea4:ae79 with SMTP id
 q15-20020a05651c054f00b002559ea4ae79mr146008ljp.122.1655306360512; Wed, 15
 Jun 2022 08:19:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220609150851.23084-1-max.oss.09@gmail.com> <20220609150851.23084-2-max.oss.09@gmail.com>
 <1654829855.220248.560616.nullmailer@robh.at.kernel.org>
In-Reply-To: <1654829855.220248.560616.nullmailer@robh.at.kernel.org>
From:   Max Krummenacher <max.oss.09@gmail.com>
Date:   Wed, 15 Jun 2022 17:19:09 +0200
Message-ID: <CAEHkU3W0wRDWvEVwgjoeAQaTSr-V=0J2L-FtwJA78EHkaED4YA@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] dt-bindings: power: Add bindings for a power
 domain controlled by a regulator
To:     Rob Herring <robh@kernel.org>
Cc:     Kevin Hilman <khilman@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-pm@vger.kernel.org,
        Max Krummenacher <max.krummenacher@toradex.com>
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

Hi

On Fri, Jun 10, 2022 at 4:57 AM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, 09 Jun 2022 17:08:47 +0200, Max Krummenacher wrote:
> > From: Max Krummenacher <max.krummenacher@toradex.com>
> >
> > Adds binding for a power domain provider which uses a regulator to control
> > the power domain.
> >
> > Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
> > ---
> >
> >  .../power/regulator-power-domain.yaml         | 58 +++++++++++++++++++
> >  1 file changed, 58 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/power/regulator-power-domain.yaml
> >
>
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/power/regulator-power-domain.example.dtb: power-sleep-moci: $nodename:0: 'power-sleep-moci' does not match '^(power-controller|power-domain)([@-].*)?$'
>         From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/power/regulator-power-domain.yaml

Will change to 'power-domain-sleep-moci' in V2.

Regards
Max

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
