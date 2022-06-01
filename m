Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC2653A92B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 16:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354934AbiFAO1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 10:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355608AbiFAO0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 10:26:43 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B4411C
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 07:20:52 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id z13so2149275ljn.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 07:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/qDPxqxtAnqx70yomMz4iKcG/suKMrIdMG5mPCftR2g=;
        b=gVFN2d29Ob2IsoQslrcbptF3svKScdiHyFPmNr10CFxhknhNn7gqwsCr9mypdHMeuG
         I7gk65CFQNFA2oKopvqa13ri4A88g45f4vVdOURoytvhrtLUr9CcFjTCUiQugHnnOXiX
         1jOT8/raJcsgiLpvcIgBcyfQdYnhYIoFsUlynR1Cm5PJGCFH8ubju+VXnv+qmsEJ41uz
         nRA+RsZVOyGUxogebV8INdIHtxPZrKXyGasyf9ReRz6j850wBTV6UhXNjlxn7RYN70N/
         ahpY3ajNR6s6gcsLlhKnHBHSwtFNLicEaHdRprD/mwMZ8dQV35aorV1pkxL10dFefyNR
         NCfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/qDPxqxtAnqx70yomMz4iKcG/suKMrIdMG5mPCftR2g=;
        b=nwqCKgB7UbZ49GqAgT19jxPHNbDbIM8geDlcrdBa56r+3lAvmIneEjcp6AHP8dlq2e
         VrgZZXQHEwhS6AkSarw2sTH29+3xqYmsLvIdxW0irUfE3GlWABiTM09rT9CZrXe0y3Kr
         VWcUhi5TfyngaI+kkcZh3+pf3jAQCMcHI5PGeen1tVbiK1k2VHxb6KT66eLIbyrO42LH
         MXne9sJiwbwwEOGgFxnJjqIF9Enxj1Quox3VhH+Nn31ISwkfaREpFBaOskVrGZQTRPVv
         ctISHCe2RvnT6Mc5UJIUAXfD1qoyY3DWbxhzRzSDDXPxr8nU6npAc2dZYXIfqqqurswJ
         yLXA==
X-Gm-Message-State: AOAM531Rgv2uMgpyAwJZR66zzBaIjn9D1Y6OtwwlEvcBQOEjSImCDBMj
        g3pyii5p64V9NX/sd4zWgA54TdNtzTUSFz6xtbLj4SwT7Tw=
X-Google-Smtp-Source: ABdhPJyHLe+8u5VYlCGJLP8Qc+G0asgDycWaaA6EZ0mEacenGngsM1+d36udkKA5adI89ZmSgyxTW2xZap3Rb49TyUQ=
X-Received: by 2002:a2e:9e54:0:b0:250:d6c8:c2a6 with SMTP id
 g20-20020a2e9e54000000b00250d6c8c2a6mr40310597ljk.16.1654093250356; Wed, 01
 Jun 2022 07:20:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220526014204.2873107-1-robh@kernel.org> <CAPDyKFoh5FyRDxr22XnkOd76MG4YjkvqL039=+qHGZKwfdFquw@mail.gmail.com>
 <20220601140429.GA3909718-robh@kernel.org>
In-Reply-To: <20220601140429.GA3909718-robh@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 1 Jun 2022 16:20:14 +0200
Message-ID: <CAPDyKFoDfBCFrdvDunCm4a2v_A=UzVMJvHyNN6XAdjjQ=gzkvg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: Fix unevaluatedProperties warnings in examples
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Hu Ziji <huziji@marvell.com>, Al Cooper <alcooperx@gmail.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Wed, 1 Jun 2022 at 16:04, Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Jun 01, 2022 at 02:46:21PM +0200, Ulf Hansson wrote:
> > On Thu, 26 May 2022 at 03:42, Rob Herring <robh@kernel.org> wrote:
> > >
> > > The 'unevaluatedProperties' schema checks is not fully working and doesn't
> > > catch some cases where there's a $ref to another schema. A fix is pending,
> > > but results in new warnings in examples. Fix the warnings by removing
> > > spurious properties or adding a missing property to the schema.
> > >
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> >
> > Queued for v5.20 on the devel branch, thanks!
>
> Can you take for 5.19 instead so I can enable this in dtschema sooner
> rather than later?

Sure! I have moved the patch to the fixes branch now.

Kind regards
Uffe
