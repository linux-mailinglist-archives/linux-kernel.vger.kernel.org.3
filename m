Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8C8560385
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 16:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbiF2OoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 10:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232039AbiF2OoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 10:44:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451F01C933;
        Wed, 29 Jun 2022 07:44:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D870D61F1F;
        Wed, 29 Jun 2022 14:44:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42B5DC341CD;
        Wed, 29 Jun 2022 14:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656513845;
        bh=nOwZTusFcv/EYtDIjBSt3qVjRLnbfqmzjz/wxrw87gM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TCNfSU7xjjstRbo0Q57fM/83aVIGLEYh+Q9N3hjAPaEtHn8ewt9g8OX6jBMrq2sb7
         fBh5mAT9sT7A1QqH2S7fAP/4pf61BgvasAm89O2QiQZRbrjQ/+SnHFFENlfH2DgTxK
         BNobPrvWPd6N4y/sxCi2nuPfoRRGBwzqBA92Z4G3StqIQeEnBMNT1lXWgUC+PfCP6k
         CFd/08r9NoFcPidNFCkPypsBqas5RnyLYpYL7JK5pDJjHZcLBMjFOvV7qpRuXqfKCJ
         WxnRW1Gd+fbgGkdRaCICMiKIcBnQb3YnOKPFos+3IMTEMazaThsDnJrTYdfDbPRpTP
         pXjwCcP6i+IQg==
Received: by mail-vs1-f50.google.com with SMTP id o190so15410811vsc.5;
        Wed, 29 Jun 2022 07:44:05 -0700 (PDT)
X-Gm-Message-State: AJIora9styVjgAQ27a65CTtRYHdRyNp32uP2pNphf3nLjAIyAMbpXM7H
        qGxgSnVcCkH53zsEldVXsSNej+9EkwQOt5fqbA==
X-Google-Smtp-Source: AGRyM1v+y9DrAuOxQEZVR1hAanT0MwRi2QARCd9KFYqN6aXvz6C8qa122ImM5AlzqKYTYGlyVhZXbxHailnnstV8yYQ=
X-Received: by 2002:a67:e407:0:b0:354:3d39:e0e7 with SMTP id
 d7-20020a67e407000000b003543d39e0e7mr4552526vsf.0.1656513844236; Wed, 29 Jun
 2022 07:44:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220610213308.2288094-1-robh@kernel.org> <20220628201438.GC694214-robh@kernel.org>
 <CAL_JsqJbZOAMPJDt3ha=rLw0tFuLJ57ZyaCeBJZfEqCHVbtSnw@mail.gmail.com> <20220629090956.muoonqm3okw5reiu@bogus>
In-Reply-To: <20220629090956.muoonqm3okw5reiu@bogus>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 29 Jun 2022 08:43:53 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+1bpiuFiffXbq0KS8Uo8afT-_rX-jUVPqgoJd+gVLFwg@mail.gmail.com>
Message-ID: <CAL_Jsq+1bpiuFiffXbq0KS8Uo8afT-_rX-jUVPqgoJd+gVLFwg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: arm/juno: Drop erroneous 'mbox-name' property
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
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

On Wed, Jun 29, 2022 at 3:11 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Tue, Jun 28, 2022 at 03:03:03PM -0600, Rob Herring wrote:
> > On Tue, Jun 28, 2022 at 2:14 PM Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Fri, Jun 10, 2022 at 03:33:07PM -0600, Rob Herring wrote:
> > > > The 'mbox-name' property in the Juno mailbox node is undocumented and
> > > > unused. It's the consumer side of the mailbox binding that have
> > > > 'mbox-names' properties.
> > > >
> > > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > > ---
> > > >  arch/arm64/boot/dts/arm/juno-scmi.dtsi | 1 -
> > > >  1 file changed, 1 deletion(-)
> > >
> > > Ping!
> >
> > Sorry, I see this was applied. I need to figure out why 'lei' misses
> > emails sometimes.
>
> Yes I did apply this and another patch IIRC.
>
> Sorry for naive question what is 'lei' ?

Part of public-inbox which is what lore is:

https://people.kernel.org/monsieuricon/lore-lei-part-1-getting-started

Rob
