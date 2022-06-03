Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D539553CAC2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 15:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244710AbiFCNkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 09:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234405AbiFCNkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 09:40:33 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712DB2ED79;
        Fri,  3 Jun 2022 06:40:31 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 0E7721BF207;
        Fri,  3 Jun 2022 13:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1654263629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/PDivizaxZ+AZVI8p6z9vlgef9z49p8d3VW+VGNrFXQ=;
        b=FyImQt/znIZ3l9LMdZ0YhyUCnm8jZNezAY+ZF2LrLu5+lFQyM6ady0UJG32AVkeNcXDR1b
        eQqgT8r55nCwyn+w87wZtn52dhsFvmEQmOrr98AaC2wCDFSb5yeHuJasulwXo1ubBOgB52
        2ZdD/b/c0tSyL6Xmesr/4co48HjYzx65CUOCkP7ByAC+iTcuV6FFG5+8VZ8ONelSLgc/MZ
        /nIPfrKqOkV/Um8Mzbk7mzYbqSYkEY7k0247463pkejI/L7GnCiSO5hbWJGGgrKdDW5mCp
        N+QKuEvj8NkAMLRjc09Leu0e4zzHtr/MUaNE8AptT3KletmN9jvAB2jQMtB4fA==
Date:   Fri, 3 Jun 2022 15:40:24 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Uwe =?UTF-8?B?S2xlaW5lLUs=?= =?UTF-8?B?w7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mtd: mxc-nand: Drop undocumented
 properties from example
Message-ID: <20220603154024.27ae9ad5@xps-13>
In-Reply-To: <20220531150515.GB1742958-robh@kernel.org>
References: <20220525205947.2487165-1-robh@kernel.org>
        <20220527093839.3byc6r6ixuu5givt@pengutronix.de>
        <20220531150515.GB1742958-robh@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob, Marc,

robh@kernel.org wrote on Tue, 31 May 2022 10:05:15 -0500:

> On Fri, May 27, 2022 at 11:38:39AM +0200, Marc Kleine-Budde wrote:
> > On 25.05.2022 15:59:46, Rob Herring wrote: =20
> > > With unevaluatedProperties issues fixed, 'nand-bus-width' and
> > > 'nand-ecc-mode' are flagged as undocumented. Removing them from the e=
xample
> > > is the easiest solution to silence the warnings.
> > >=20
> > > Signed-off-by: Rob Herring <robh@kernel.org> =20
> >=20
> > At least the 'nand-bus-width' property is described in
> > "nand-controller.yaml" and the "mxc-nand.yaml" refers to it.
> >=20
> > | allOf:
> > |   - $ref: "nand-controller.yaml"
> >=20
> > Is this ref broken? =20
>=20
> Nope, read my note below. 'nand-bus-width' is documented as a nand chip=20
> (child node) property, not a nand controller property.
>=20
>=20
> > regards,
> > Marc
> >  =20
> > > ---
> > > These properties may be deprecated, but they are still widely used in
> > > bindings. They either need to be documented (and marked deprecated) or
> > > removed from current users (i.e. dts files). =20

I don't mind keeping them undocumented to encourage people to migrate
to a better description. For the record, in the past controllers and
devices where not separated in the description, hence we had NAND chip
specific properties landing in to the NAND controller description.

So I'm fine with the current approach.

Thanks,
Miqu=C3=A8l
