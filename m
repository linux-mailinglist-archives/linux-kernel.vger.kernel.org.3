Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 798BB599DBE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 16:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349417AbiHSOob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 10:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348671AbiHSOo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 10:44:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0577A7968B
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 07:44:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ABD89B827DF
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 14:44:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EC93C433D6;
        Fri, 19 Aug 2022 14:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660920264;
        bh=SR5PrwSUNeFzrA5RDIw69x1o+dFz9ygEbvlaWHCGNQ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RNMDzlofT9Do1qtO0Evz7KNkRv+ZdvLW3fBZlD7deBiDkiEkJdnhibCTwuWfPH2Jv
         Wi1ES+bT+zVEnj5vqLu6zJerZapPimoZLYndb+1B0NTLbB1s/Use0mLOFoEwmTr4wz
         dl9BR1lEQoD+20FJAuHs+VmrOZZCdmO/a/TA2nJ+b5mQa3wj1c2rMfTj9uoOJFJcmq
         9K2iymNLshFFva/qqFQujb9ABgvR8S149BDlLifatYo9vaHdemFr2wPui7M3CMqQJ2
         i0eufKGMyk1WJVYWno6ghQ/JE8Kfj3DKcpDuLi1MgIEny0OaPF73j254/qBTuKHf4O
         kMeMGq3AFZj+g==
Date:   Fri, 19 Aug 2022 15:44:19 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Rokosov <DDRokosov@sberdevices.ru>
Cc:     Marc Zyngier <maz@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "linux@rasmusvillemoes.dk>" <linux@rasmusvillemoes.dk>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] regmap: introduce value tracing for regmap bulk
 operations
Message-ID: <Yv+hwyrQtBjc69Yd@sirena.org.uk>
References: <20220816181451.5628-1-ddrokosov@sberdevices.ru>
 <20220818121515.6azkxyqetnunwsc6@CAB-WSD-L081021.sigma.sbrf.ru>
 <87mtc1wtjz.wl-maz@kernel.org>
 <Yv5eMcmNOmyLmd++@sirena.org.uk>
 <20220818174441.arh7otvrkzg5uk3s@CAB-WSD-L081021.sigma.sbrf.ru>
 <Yv99E0mrPI0qG66I@sirena.org.uk>
 <20220819133200.xvpjzatkub4yxnsh@CAB-WSD-L081021.sigma.sbrf.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VGKnxctTzrqGZVQ/"
Content-Disposition: inline
In-Reply-To: <20220819133200.xvpjzatkub4yxnsh@CAB-WSD-L081021.sigma.sbrf.ru>
X-Cookie: Price does not include taxes.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VGKnxctTzrqGZVQ/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 19, 2022 at 01:31:35PM +0000, Dmitry Rokosov wrote:
> On Fri, Aug 19, 2022 at 01:07:47PM +0100, Mark Brown wrote:

> > I didn't realise that was even a question, but then there seems to be
> > some discussion I've not seen given the CCing going on.  The biggest
> > issue is do we even want the overhead but I'll need to find time to look
> > at this properly.

> No any additional discussion before. I've added your address to all emails
> which I sent.

I assume you copied in Thomas, Rasmus and Marc for some reason?

> Why do you think it this patch will bring overhead to regmap? AFAK, when
> tracepoint is disabled, tracepoint fast assign operation shouldn't be
> executed. In other words, memcpy will not be applied.

To repeat I have not yet looked at your patch properly, one concern is
how we handle the marshalling which regmap does.

--VGKnxctTzrqGZVQ/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmL/ocIACgkQJNaLcl1U
h9ASKQf/cUZ2kReo5KKxCBpmKiXgMUqaHSmcdqLJjMdL7VGq0GmjAfYsEYnYFKK6
DDAAPQ0ZFap5BNMXGQYVg8EwkTC7yj1nKXalzfGVcxiAf7RZCBOgfFDvbjNl/osb
vYcEKFugG9fTd1v9Pjk6MHBG4FK1zOkQSswXdpQKRivdWtmoujm1CKNGoXgfzQb7
fAMAPZcjNOS4HaPA9Iq0LnoF2TtAL/lUpfcL79yyqaW7qCgBB5ZLJJ7EgF/i0mvm
YLI1FEcKMQRytDZDPv5y+Oyeqn9z1RqZKsKYC3k8w1lCAQBIQeT5mpI5B23YSu8z
SJCQ/aIAmbnla8Ie+oN9Pt5H9d9iVA==
=Sc9H
-----END PGP SIGNATURE-----

--VGKnxctTzrqGZVQ/--
