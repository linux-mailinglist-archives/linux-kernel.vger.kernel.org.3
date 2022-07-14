Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB0757516A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 17:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239948AbiGNPIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 11:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237665AbiGNPIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 11:08:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780AC63930
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 08:08:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 27DD3B82719
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 15:08:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5D73C34115
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 15:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657811282;
        bh=UYQ9+te4KDbPDNm5NrYTytFuP7/GJGGzIOgSc/+8ZsI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KhMRx7tqN33q2uG5HrkHTWvLzVM9ps8ZX0Ldqu51zPMfkvyjO+lE0dPXBMC6xoIIy
         MK4dV7LlFmaroBTM3eOOvx4ymLGFlsdaCrW8FD6dK4vtMHOXvoj2gt0kr2jah/FRIv
         Po6ZdVnwi3XWxJ8uwaSGNaBN6v0f5Z0DeAo8eUTDairbAq5oNS++TLOSTZOeDnFwmX
         tW2YCvrB7GceKfjczRP4wMWpfj/B8SguBXAIw3yr/KTxyfL/gxLeeqkdaPuDPnkwtH
         VPrE7BM0lwLHbLm+hlZhPpmFu2u61U1LBXboE/2ZwAPi0cA+uBv55xZ6L71MU9bOcZ
         TEBH3eAB5FZsw==
Received: by mail-vs1-f46.google.com with SMTP id x125so1699005vsb.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 08:08:02 -0700 (PDT)
X-Gm-Message-State: AJIora+ol63qAeh21ZpATJMeemmn+JQI42xyRKUzSuXjUp13SYkxCCkn
        U096HmNYg7iw/SxoT7neLn4aJqUr3WjcFCUvow==
X-Google-Smtp-Source: AGRyM1sMZdbvA4+pTgknoI8ZibnawDLOfix1bfiq0ksSqXAK8yzjMR/zqB9nsiSjNS+lfjR4Zg4dM4gmrL+nMbRX5w0=
X-Received: by 2002:a67:d194:0:b0:357:8ea:5554 with SMTP id
 w20-20020a67d194000000b0035708ea5554mr3707059vsi.0.1657811281644; Thu, 14 Jul
 2022 08:08:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220707081826.953449-1-Naresh.Solanki@9elements.com>
 <20220707081826.953449-3-Naresh.Solanki@9elements.com> <20220714141041.GB2229197-robh@kernel.org>
 <YtAkwcwXaQqZV75d@sirena.org.uk> <CAL_JsqKu_HCDoPBTcVdVV2JyD_8p3+cbrNC0u6VrK85vWZmt3Q@mail.gmail.com>
 <YtArbh4a40cACRMt@sirena.org.uk>
In-Reply-To: <YtArbh4a40cACRMt@sirena.org.uk>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 14 Jul 2022 09:07:49 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+KRyE3i3CkPKopGgFvL+h0pT3R-d3aZNgVmKyiTy3gjw@mail.gmail.com>
Message-ID: <CAL_Jsq+KRyE3i3CkPKopGgFvL+h0pT3R-d3aZNgVmKyiTy3gjw@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] dt-bindings: regulator: add bindings for output-supply
To:     Mark Brown <broonie@kernel.org>
Cc:     Naresh Solanki <naresh.solanki@9elements.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 8:43 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Jul 14, 2022 at 08:23:39AM -0600, Rob Herring wrote:
> > On Thu, Jul 14, 2022 at 8:14 AM Mark Brown <broonie@kernel.org> wrote:
>
> > > It's a description of a power supply output from their system (system as
> > > a whole, not power provisioned within the system).
>
> > Well, that's a better commit message than the original, but I still
> > don't understand.
>
> Consider for example a BMC (IIRC that's what their specific product is),
> a bench supply or some automated test equipment.  Part of the function
> for these systems is to provide power to other systems which would be
> represented as a root or wall supply in the description of the system
> that actually uses the supply if it were described using DT.

Didn't someone else have a similar use recently? Controlling some
supply external to the system. I can't seem to find it now.

In any case, it's not for you to describe, but Naresh, and in the
binding and commit messages. But first we need to overcome proper
usage of get_maintainers.pl. In response, to my first reply on v4, I
have a second v4 sent privately today (and still only the vendor
prefix). Sigh. AFAICT, for v1-v3, the only thing that made it to the
list was the cover letters. Bottom line is this series has multiple
problems and shouldn't have been applied yet.

Rob
