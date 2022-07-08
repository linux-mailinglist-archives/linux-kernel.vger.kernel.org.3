Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5037856C0FB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 20:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239100AbiGHQaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 12:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239341AbiGHQ3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 12:29:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083AF208;
        Fri,  8 Jul 2022 09:29:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AEDEDB828A6;
        Fri,  8 Jul 2022 16:29:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFBF9C341C6;
        Fri,  8 Jul 2022 16:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657297764;
        bh=bnYt7XSKQbcRefHIMdh+InQ9CqN2VQX7nimG9Okphro=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WomL5vW9a8IMxo80M+xawgDmjrK4aQEofHM5wARWcZI3nmY8mvW+pUSgA3j4jvMHx
         3uDUpjNmfWdXC7CoDq9d3/M1Do/B+1JNrk+f5IQyv031tmQBWDJeuvfssvcLwthm/y
         Ym9oHPbagYNWXUvK7MRD2FSKo/DdGTxPBSHNOEi6uoqqbTT2QwhaJ5cryZiC7nrqd/
         Dqt/kFUzUAGEg4QrbVNJq/+/pbJeEiOMlf3TFPbhJ7KIPM6LvZpI9sEUCfChmsMBvR
         UYt0F33WWEfHs8UYvp6diua1X/c7m26CKRgEPSJiJeDpfSdKOjeOlKuSg3YGmCSoL+
         oF1qDHA092R6g==
Date:   Fri, 8 Jul 2022 18:29:19 +0200
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] [RFT] dt-bindings: leds: Add
 cznic,turris1x-leds.yaml binding
Message-ID: <20220708182919.2a1e4a52@thinkpad>
In-Reply-To: <20220708160528.ysy4lzxfpwobfiwr@pali>
References: <20220705000448.14337-1-pali@kernel.org>
        <20220705155929.25565-1-pali@kernel.org>
        <20220706131507.353f0bed@thinkpad>
        <20220706111912.hz2mx4dc35lgq6l5@pali>
        <20220706172732.6228d180@thinkpad>
        <25b43586-eeb3-4b7b-7362-2d599aa89cf0@linaro.org>
        <20220708160528.ysy4lzxfpwobfiwr@pali>
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Jul 2022 18:05:28 +0200
Pali Roh=C3=A1r <pali@kernel.org> wrote:

> On Wednesday 06 July 2022 17:36:43 Krzysztof Kozlowski wrote:
> > On 06/07/2022 17:27, Marek Beh=C3=BAn wrote: =20
> > > On Wed, 6 Jul 2022 13:19:12 +0200
> > > Pali Roh=C3=A1r <pali@kernel.org> wrote:
> > >  =20
> > >> On Wednesday 06 July 2022 13:15:07 Marek Beh=C3=BAn wrote: =20
> > >>> On Tue,  5 Jul 2022 17:59:28 +0200
> > >>> Pali Roh=C3=A1r <pali@kernel.org> wrote:
> > >>>    =20
> > >>>> +examples:
> > >>>> +  - |
> > >>>> +    #include <dt-bindings/leds/common.h>
> > >>>> +
> > >>>> +    cpld@3,0 {   =20
> > >>>
> > >>> The generic node name should be just "bus". That it is a CPLD
> > >>> implementation should come from compatible string.   =20
> > >>
> > >> Sorry, I do not understand why "bus". Why other memory chips are nam=
ed
> > >> e.g. "nand" or "nor" and not "bus" too? =20
> > >=20
> > > As far as I understand this is because that is the preferred name for
> > > busses and this is a bus, since there is also the simple-bus compatib=
le.
> > >  =20
> > >> By this logic should not be _every_ node called just "bus"? Hm... an=
d=20
> > >> are names needed at all then? =20
> > >=20
> > > :-)
> > >=20
> > > The schema
> > >   https://github.com/devicetree-org/dt-schema/blob/main/dtschema/sche=
mas/simple-bus.yaml
> > > allows for different names (soc|axi|ahb|*-bus) to avoid warnings on
> > > existing old dts files.
> > >=20
> > > The preferred way is to not have the implementation in nodename,
> > > similar to how we use 'switch' instead of 'mv88e6xxx', or
> > > 'ethernet-phy' instead of 'mv88e151x', or 'led-controller', ... =20
> >=20
> > Thanks Marek for detailed explanation.
> > The cases above rather trigger my comments and this one here, after
> > Pali's explanation, do not fit them. pld is a generic class of a device,
> > so it is okay here. cpld probably as well (although one could argue that
> > it is a subset of pld, so the generic name is pld, but then one would
> > say fpga also should be called pld). For me it does not have to be bus,
> > just don't want mv88e6xxx or any other vendor/model names. Therefore
> > cpld is fine. =20
>=20
> Exactly. cpld, fpga, nor, nand, soc... all of them are not real buses.
>=20
> simple-bus here is just name invented by device tree and without which
> existing kernel drivers refuse to work.

OK, then cpld seems correct. I thought it was considered a bus in a way,
since "simple-bus" is used in compatible.

Marek
