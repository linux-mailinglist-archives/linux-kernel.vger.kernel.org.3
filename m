Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6116F4E63F3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 14:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350397AbiCXNSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 09:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbiCXNSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 09:18:20 -0400
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C2F5D5D9;
        Thu, 24 Mar 2022 06:16:49 -0700 (PDT)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-ddfa38f1c1so4855504fac.11;
        Thu, 24 Mar 2022 06:16:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L4yFfoTfZccYE7Di0YlYjA+29UIzoRBEMm0qGrq7xq0=;
        b=pyWonZjOu8h2d1LF/imDL6nNHN71qqyZobbj2ihOkPo6OUo09bC2jk8Rr95oxvzyOO
         n0nOFeGacSWCNPg/Pd8nFqsPW3c3lN5hErE3iMf41+ReawQStFqYoE/SJ6fHuPLAIm7E
         Qlk6W2djiL6/N/7k+KTsuip3aGJYiW4PBxE6R51FvkxMyimGU0aoQ39/kUyYqbiazh3x
         5NuLRq1szjfkDgovIsMm6bdmFD82gtl3xs8/Fh02INhGDM420FJbIMGrBvb+aKTmyh73
         5tlKFcYLRmG4dCNU+ZgNk02+f3lw3e/d28yRApMcKkAwYUp3btfwlqJLlkvEPKmvcRJv
         A8tQ==
X-Gm-Message-State: AOAM53033C2yGb7TFTOyRcQbj4DmyPLtMXt5lv5xNKvpFekUBd8BWzXR
        JyI/5+8cs1bntyQ9qTbfDQ==
X-Google-Smtp-Source: ABdhPJyWCV888rnqVqehNYjSRgPdI4EiYHkWQq19im/ieDnEq2LtJ//jkVdiM9VQ0b2qos+XqrXknw==
X-Received: by 2002:a05:6871:811:b0:dd:b8ea:6bb1 with SMTP id q17-20020a056871081100b000ddb8ea6bb1mr6479846oap.43.1648127808262;
        Thu, 24 Mar 2022 06:16:48 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t10-20020a056830224a00b005cd9db03fabsm1296706otd.78.2022.03.24.06.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 06:16:47 -0700 (PDT)
Received: (nullmailer pid 1905192 invoked by uid 1000);
        Thu, 24 Mar 2022 13:16:46 -0000
Date:   Thu, 24 Mar 2022 08:16:46 -0500
From:   Rob Herring <robh@kernel.org>
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
Subject: Re: [PATCH v5 01/15] dt-bindings: clock: split qcom,gcc.yaml to
 common and specific schema
Message-ID: <YjxvPik3jaQHXIzt@robh.at.kernel.org>
References: <20220224164831.21475-1-ansuelsmth@gmail.com>
 <20220224164831.21475-2-ansuelsmth@gmail.com>
 <CAL_JsqLduGK=CyAcgahswFfeA43vh+QPgRgcL4+=piOwWwvJRQ@mail.gmail.com>
 <Yjt5QxZ4+kdwTtUH@Ansuel-xps.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yjt5QxZ4+kdwTtUH@Ansuel-xps.localdomain>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2022 at 08:47:15PM +0100, Ansuel Smith wrote:
> On Wed, Mar 23, 2022 at 08:55:30AM -0500, Rob Herring wrote:
> > On Thu, Feb 24, 2022 at 10:48 AM Ansuel Smith <ansuelsmth@gmail.com> wrote:
> > >
> > > Split qcom,gcc.yaml to common and specific schema to use it as a
> > > template for schema that needs to use the gcc bindings and require
> > > to add additional bindings.
> > >
> > > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > > ---
> > >  .../bindings/clock/qcom,gcc-other.yaml        | 76 +++++++++++++++++++
> > 
> > This now throws errors in linux-next:
> > 
> > Traceback (most recent call last):
> >   File "/usr/local/lib/python3.8/dist-packages/jsonschema/validators.py",
> > line 816, in resolve_from_url
> >     document = self.resolve_remote(url)
> >   File "/usr/local/lib/python3.8/dist-packages/jsonschema/validators.py",
> > line 923, in resolve_remote
> >     result = json.loads(url.read().decode("utf-8"))
> >   File "/usr/lib/python3.8/json/__init__.py", line 357, in loads
> >     return _default_decoder.decode(s)
> >   File "/usr/lib/python3.8/json/decoder.py", line 337, in decode
> >     obj, end = self.raw_decode(s, idx=_w(s, 0).end())
> >   File "/usr/lib/python3.8/json/decoder.py", line 355, in raw_decode
> >     raise JSONDecodeError("Expecting value", s, err.value) from None
> > json.decoder.JSONDecodeError: Expecting value: line 1 column 1 (char 0)
> > During handling of the above exception, another exception occurred:
> > Traceback (most recent call last):
> >   File "/usr/local/bin/dt-doc-validate", line 70, in <module>
> >     ret = check_doc(f)
> >   File "/usr/local/bin/dt-doc-validate", line 36, in check_doc
> >     for error in
> > sorted(dtschema.DTValidator.iter_schema_errors(testtree), key=lambda
> > e: e.linecol):
> >   File "/usr/local/lib/python3.8/dist-packages/dtschema/lib.py", line
> > 1016, in iter_schema_errors
> >     meta_schema = cls.resolver.resolve_from_url(schema['$schema'])
> >   File "/usr/local/lib/python3.8/dist-packages/jsonschema/validators.py",
> > line 818, in resolve_from_url
> >     raise exceptions.RefResolutionError(exc)
> > jsonschema.exceptions.RefResolutionError: Expecting value: line 1
> > column 1 (char 0)
> > ./Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml:
> > mapping values are not allowed in this context
> >   in "<unicode string>", line 17, column 11
> > 
> > >  .../devicetree/bindings/clock/qcom,gcc.yaml   | 59 +-------------
> > >  2 files changed, 80 insertions(+), 55 deletions(-)
> > >  create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml
> > > new file mode 100644
> > > index 000000000000..4e5903bcd70d
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml
> > > @@ -0,0 +1,76 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/clock/qcom,gcc-other.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Qualcomm Global Clock & Reset Controller Binding
> > > +
> > > +maintainers:
> > > +  - Stephen Boyd <sboyd@kernel.org>
> > > +  - Taniya Das <tdas@codeaurora.org>
> > > +
> > > +description:
> > > +  Qualcomm global clock control module which supports the clocks, resets and
> > > +  power domains.
> > > +
> > > +  See also:
> > 
> > I think the problem is here. You need a '|' after 'description' to
> > preserve formatting and ignore what looks like a mapping.
> >
> 
> Yes, I just sent a patch to fix this.
> Out of curiosity, any idea why this wasn't flagged by an old run of
> dt_binding_check? I totally remember running dt_binding_check on these
> Documentation and I had no problem. There was a bug in the old version
> and it does now correctly find these kind of errors?

Not sure exactly, but I don't think there was any change. v3 didn't 
have the issue and the bot checks didn't run on v4 or later. Probably 
because it couldn't apply them.

Rob
