Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4E3B54D335
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 23:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349161AbiFOVAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 17:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346052AbiFOVAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 17:00:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91FB5523D;
        Wed, 15 Jun 2022 14:00:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6194361356;
        Wed, 15 Jun 2022 21:00:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F301BC3411E;
        Wed, 15 Jun 2022 21:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655326814;
        bh=H/KvdVW+OVA5m+P7Zw9G+q3TtBvXLtLwBl8hRTBS/bA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QxbPbc8tlWgFeYsXMM2ZnM0naobnJYZtq2duTMSpUT095EP3ijtx5nuKABHZdHqcI
         riEpWjEsb1HpqDB3zhiD8V01PxXhGT7S4o0M2xb+CH4emrPXxw6MDnM4zazkrybu5/
         A3ZHL/SpqayY9OCkZQ6EC9+gKzel9dVIVleBqXpAbPfnTn3JRWJsjcDlPutNoZsePz
         BM1soqK1938U73gjJOE5+Pi3Bx2srKZlll0ot6/NupAUIYbxnU6EQ8wHJwHU5ouyKa
         nQiuiUBRatc9C7gieka7hSvwHqfHU/0d8ckfQOZMvNc99jIu7/WqHyQtvWs5YAh2yK
         +R731VOOVpxVA==
Date:   Wed, 15 Jun 2022 22:09:30 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 1/1] iio: adc: intel_mrfld_adc: explicitly add proper
 header files
Message-ID: <20220615220930.710ed42d@jic23-huawei>
In-Reply-To: <PH0PR03MB6786A019FB9A1BA810DDE2BC99AD9@PH0PR03MB6786.namprd03.prod.outlook.com>
References: <20220615120803.41350-1-andriy.shevchenko@linux.intel.com>
        <PH0PR03MB6786A019FB9A1BA810DDE2BC99AD9@PH0PR03MB6786.namprd03.prod.outlook.com>
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

On Wed, 15 Jun 2022 12:15:48 +0000
"Sa, Nuno" <Nuno.Sa@analog.com> wrote:

> Hi Andy,
>=20
> > -----Original Message-----
> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Sent: Wednesday, June 15, 2022 2:08 PM
> > To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>;
> > Alexandru Ardelean <aardelean@deviqon.com>; linux-
> > iio@vger.kernel.org; linux-kernel@vger.kernel.org
> > Cc: Jonathan Cameron <jic23@kernel.org>; Lars-Peter Clausen
> > <lars@metafoo.de>
> > Subject: [PATCH v1 1/1] iio: adc: intel_mrfld_adc: explicitly add proper
> > header files
> >=20
> > [External]
> >=20
> > Do not trust the fact that iio.h includes of.h which in turn includes
> > all the headers we are relying on.
> >=20
> > The ultimate goal is to actually drop of.h from iio.h.
> >=20
> > Signed-off-by: Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com>
> > ---
> >=20
> > Jonathan, this should be squeezed before we remove of.h in iio.h
> > I think Nuno somehow missed this =20
>=20
> Yes, I did (compile) tested this on arm and arm64 as I said in the cover.
> I guess this one won't be enabled on those archs :).
>=20
> I was planning to send this on v2 (I did noticed the kernel test bot
> emails) but yeah, this should actually be included with the other
> patches before removing of.h from iio. Thanks!
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

Applied.  Oddly didn't show up in my normal x86 build test.

As suggested, slotted in before the of.h removal patch.

Thanks,

Jonathan

>=20

