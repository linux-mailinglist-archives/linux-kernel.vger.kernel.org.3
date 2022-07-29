Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97CED585111
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 15:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236672AbiG2NrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 09:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233738AbiG2NrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 09:47:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97270357FB
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 06:46:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 329A561F51
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 13:46:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90DAAC4347C
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 13:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659102418;
        bh=jlWA67ik7HWpGlimNkeX80+EmNYham+2fsifsCQt0/s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oMzRDd38lTUgCcBBD4wITi6kePxOZpfiMSJFdS4SpN4RJiR9EuFDmNMpYhXTSO5Zy
         5Wr7hYxjH8OdUZ5qqcHYnZCEM94AY34w+ug6Q0CnNOFtJ0VwYcsw66AvvJD/25oXvr
         1uP6zuzkd5amDkKEvgU2Wd+kOCpL11nIw2tVbw0LhTJYEkLAai405AHpUVtulWlbeU
         1Eu5k+IbbDc0pXwQgAYP4t9pMCcqpHFZvtRUXO1a5p5oeZWMgk9extGJuVqWdhQViX
         Y/JT3FYRv4T6Lp0Gm0x9rs+cvM5ffsyqUZap3kjn0Y+M5N+us1bVn4trw1F+Z/4CDf
         K2aON3IkC8eEg==
Received: by mail-ua1-f47.google.com with SMTP id 5so1846726uay.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 06:46:58 -0700 (PDT)
X-Gm-Message-State: ACgBeo2kvUtfXxE0EBra2gsYDc4Xotn/g+AwqJD5batZlm3SouwtPylL
        57fvs/gOtGxILYq3aiubl1XzDB7DLCR9NsK+NA==
X-Google-Smtp-Source: AA6agR5PmvGCM0mkzmecJwfwZOt2jeEZdF7UUaBABYn/PqpsiaR/083HWz0V12UPm3GkXn9KEqs9ZTFGKBkAOESYjhE=
X-Received: by 2002:ab0:2b06:0:b0:384:c4af:107c with SMTP id
 e6-20020ab02b06000000b00384c4af107cmr1304596uar.77.1659102417535; Fri, 29 Jul
 2022 06:46:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220504180822.29782-1-pali@kernel.org> <165909977761.253830.2305727219055135050.b4-ty@ellerman.id.au>
In-Reply-To: <165909977761.253830.2305727219055135050.b4-ty@ellerman.id.au>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 29 Jul 2022 07:46:46 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJZ6s4qU+Yt4CCj3q-Fk_MKEddx5aLKu15NLnTbgMyRGA@mail.gmail.com>
Message-ID: <CAL_JsqJZ6s4qU+Yt4CCj3q-Fk_MKEddx5aLKu15NLnTbgMyRGA@mail.gmail.com>
Subject: Re: [PATCH] powerpc/85xx: P2020: Add law_trgt_if property to PCIe DT nodes
To:     Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 7:17 AM Michael Ellerman
<patch-notifications@ellerman.id.au> wrote:
>
> On Wed, 4 May 2022 20:08:22 +0200, Pali Roh=C3=A1r wrote:
> > DT law_trgt_if property defines Local Access Window Target Interface.
> >
> > Local Access Window Target Interface is used for identifying individual
> > peripheral and mapping its memory to CPU. Interface id is defined by
> > hardware itself.
> >
> > U-Boot uses law_trgt_if DT property in PCIe nodes for configuring memor=
y
> > mapping of individual PCIe controllers.
> >
> > [...]
>
> Applied to powerpc/next.
>
> [1/1] powerpc/85xx: P2020: Add law_trgt_if property to PCIe DT nodes
>       https://git.kernel.org/powerpc/c/1f00b5ab992c122c51bc37662b3b4df596=
3462f3

Why? Minimally, it needs a vendor prefix and s/_/-/ as I commented.

Rob
