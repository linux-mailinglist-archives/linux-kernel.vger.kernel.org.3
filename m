Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5608554D342
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 23:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347438AbiFOVEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 17:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238600AbiFOVEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 17:04:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B241245AB;
        Wed, 15 Jun 2022 14:04:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16EA760FB7;
        Wed, 15 Jun 2022 21:04:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09C3AC3411A;
        Wed, 15 Jun 2022 21:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655327068;
        bh=hE39RVqnoCowXM9bxp3o8FqxXU/Szd80uy6eIhs9g3U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Hi/0jpYEB50JqvcJPwlV1hr/a0AxMbaRoO8oAyLvkAYVFWZwGj8GKEnqLtwNOgg34
         tceFW5ehstCD7gLBadWuuxHEDK06fmltBb91QlM7fivtrllQIKD5EOR18NvbPAYwDC
         yTzxH6Fq1txJshoyT6nPaoQD0eIT5lnXjnw2Owxa2IYE3VOY6fTuZ5OkCdtmOutP73
         RVcgJhpzwG4JkADUERjDiSKLl4Y9rTazee2LAkJzXPe6XpijvNW4j4aRodGscBKhJU
         Iu3ZUANEFM2U2zeVeymNngISg1EEdQxPlVRGxxPAx9sohffmQM8j8lvOUmPTHuFXAP
         Lme8ot5GRyPAg==
Date:   Wed, 15 Jun 2022 22:13:44 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 1/1] iio: adc: intel_mrfld_adc: explicitly add proper
 header files
Message-ID: <20220615221344.308bf5da@jic23-huawei>
In-Reply-To: <20220615220930.710ed42d@jic23-huawei>
References: <20220615120803.41350-1-andriy.shevchenko@linux.intel.com>
        <PH0PR03MB6786A019FB9A1BA810DDE2BC99AD9@PH0PR03MB6786.namprd03.prod.outlook.com>
        <20220615220930.710ed42d@jic23-huawei>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jun 2022 22:09:30 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Wed, 15 Jun 2022 12:15:48 +0000
> "Sa, Nuno" <Nuno.Sa@analog.com> wrote:
>=20
> > Hi Andy,
> >  =20
> > > -----Original Message-----
> > > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Sent: Wednesday, June 15, 2022 2:08 PM
> > > To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>;
> > > Alexandru Ardelean <aardelean@deviqon.com>; linux-
> > > iio@vger.kernel.org; linux-kernel@vger.kernel.org
> > > Cc: Jonathan Cameron <jic23@kernel.org>; Lars-Peter Clausen
> > > <lars@metafoo.de>
> > > Subject: [PATCH v1 1/1] iio: adc: intel_mrfld_adc: explicitly add pro=
per
> > > header files
> > >=20
> > > [External]
> > >=20
> > > Do not trust the fact that iio.h includes of.h which in turn includes
> > > all the headers we are relying on.
> > >=20
> > > The ultimate goal is to actually drop of.h from iio.h.
> > >=20
> > > Signed-off-by: Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com>
> > > ---
> > >=20
> > > Jonathan, this should be squeezed before we remove of.h in iio.h
> > > I think Nuno somehow missed this   =20
> >=20
> > Yes, I did (compile) tested this on arm and arm64 as I said in the cove=
r.
> > I guess this one won't be enabled on those archs :).
> >=20
> > I was planning to send this on v2 (I did noticed the kernel test bot
> > emails) but yeah, this should actually be included with the other
> > patches before removing of.h from iio. Thanks!
> >=20
> > Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com> =20
>=20
> Applied.  Oddly didn't show up in my normal x86 build test.
Figured out the chain of necessary dependencies so I'll catch anything
effecting this in my smoke test build going forwards.

Thanks,

Jonathan

>=20
> As suggested, slotted in before the of.h removal patch.
>=20
> Thanks,
>=20
> Jonathan
>=20
> >  =20
>=20

