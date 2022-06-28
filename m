Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC7E55F01B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 23:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbiF1VDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 17:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbiF1VDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 17:03:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29CC1E3F3;
        Tue, 28 Jun 2022 14:03:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2ED8DB82048;
        Tue, 28 Jun 2022 21:03:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7821C341CE;
        Tue, 28 Jun 2022 21:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656450195;
        bh=Rfms4m5in8Xe7xJ0eZWNIANXBFcp1r32y3aZVMG6zvY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=q48Ozx5MNTspB2EO4Ksg7oh+3Jd/ZNjTqXiJW3cXDuDaRDJRpx3YpDBeIyfGCz/rj
         KC9F/RSBXji4m23/zlpCOBDQmOyze3yTEgk4mGIAYfguQTjsUgrdPvCb8rHkD8rliZ
         4Npq4D0oXIZg8uqen/UB7BxLV15uU255NLj05kTgdFePSkYAk1FlHA2q+zwLTSgBWX
         c0NlAITfE1rUX0DrHckaLMRU0Ryb9w0KPdG7YxCNEVHShnirG+y9xl0m0tSCKswQjj
         hHkRqeyRuP34bHLhXw/xxHylnNrW5pdjvAMswHuanEOxuZ6DGxWXPZ+ZvfuLOBeyAI
         UfxIY13F8txzg==
Received: by mail-vs1-f41.google.com with SMTP id z66so13234770vsb.3;
        Tue, 28 Jun 2022 14:03:15 -0700 (PDT)
X-Gm-Message-State: AJIora+qyCud1P2rNO2DcxLm6R43zI2UGXLoK6tx2eNpOBSlZZGiGBg2
        2i6QFVRzMl0nbMiMtLKn+Dddt5Sf9Akzuho/dA==
X-Google-Smtp-Source: AGRyM1vnXfTwPPSIr2lfZXc+/YJfSls/8Ym24xFccq4g1KNlq/Vya1NEwiQGz7V0T8ohATTEHpJSsJWVwgTCPSeFuqQ=
X-Received: by 2002:a67:c187:0:b0:354:3ab2:ba65 with SMTP id
 h7-20020a67c187000000b003543ab2ba65mr3100211vsj.53.1656450194819; Tue, 28 Jun
 2022 14:03:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220610213308.2288094-1-robh@kernel.org> <20220628201438.GC694214-robh@kernel.org>
In-Reply-To: <20220628201438.GC694214-robh@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 28 Jun 2022 15:03:03 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJbZOAMPJDt3ha=rLw0tFuLJ57ZyaCeBJZfEqCHVbtSnw@mail.gmail.com>
Message-ID: <CAL_JsqJbZOAMPJDt3ha=rLw0tFuLJ57ZyaCeBJZfEqCHVbtSnw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: arm/juno: Drop erroneous 'mbox-name' property
To:     Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 2:14 PM Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Jun 10, 2022 at 03:33:07PM -0600, Rob Herring wrote:
> > The 'mbox-name' property in the Juno mailbox node is undocumented and
> > unused. It's the consumer side of the mailbox binding that have
> > 'mbox-names' properties.
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  arch/arm64/boot/dts/arm/juno-scmi.dtsi | 1 -
> >  1 file changed, 1 deletion(-)
>
> Ping!

Sorry, I see this was applied. I need to figure out why 'lei' misses
emails sometimes.

Rob
