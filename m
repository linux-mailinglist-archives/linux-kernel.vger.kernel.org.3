Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 488775994D9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 07:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243608AbiHSFra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 01:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiHSFr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 01:47:26 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945C8E1929
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 22:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=PS8HuEySiw8gDcO77OK5pbaRG4LX
        z9ZolnkC6oBXv7s=; b=GNEqAbW2Xq6voRM5gvr0/BmhtyPSvASJMSO6ihWd/rWE
        aMvKi79gSgb+zdtvI4xLHu0p+d9I156I3VEM/s9nRAo7GWcisr4/PzI6j8Ot+u3s
        9tiBFN51rBYPa1OIQggy8/3jqR0hEMNyfp6P77Xw0LWOCyRv+i6ki+OTi996gaw=
Received: (qmail 4113007 invoked from network); 19 Aug 2022 07:47:23 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 19 Aug 2022 07:47:23 +0200
X-UD-Smtp-Session: l3s3148p1@p3HLoZHmuO0ucrTL
Date:   Fri, 19 Aug 2022 07:47:22 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Duncan Sands <duncan.sands@free.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Richard Leitner <richard.leitner@skidata.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net
Subject: Re: [PATCH] usb: move from strlcpy with unused retval to strscpy
Message-ID: <Yv8j6ikXWfcjA6SW@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Duncan Sands <duncan.sands@free.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Richard Leitner <richard.leitner@skidata.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net
References: <20220818210116.7517-1-wsa+renesas@sang-engineering.com>
 <edda5842-fa82-dfb0-b4b2-14a83673ea6c@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rf03PIGfQ5zrzZGP"
Content-Disposition: inline
In-Reply-To: <edda5842-fa82-dfb0-b4b2-14a83673ea6c@linuxfoundation.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rf03PIGfQ5zrzZGP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Shuah,

> Please elaborate and summarize why this change makses sense in the
> commit log? It will be easier for reviewers - saves time checking
> the link.

Okay. Will do this to all follow-ups / resends of this series.

> Acked-by: Shuah Khan <skhan@linuxfoundation.org>

Thanks,

   Wolfram

--rf03PIGfQ5zrzZGP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmL/I+oACgkQFA3kzBSg
KbaWVRAAiXuicjZTlCMgo5+Uzcpwiw2HF1j08x1pciUQP+s76e0Rq/EUdBC7qFm1
tTUa/ZtJsGP6+LFku3dvs5UHx83b/F/5yHio3V3PZJEVc10ri/Pw1GadCV2ATYDk
9ipgQ6hzBmmmEu6ruGgU/LgN3am9ZHHdjlDULDtKk9Pr4wwo1r92Hym3x/b1/X14
AbEoLl/tWW27olmqTpFHnPZ53NRdwXN2weyhNLqo754klKgJE7M8F0lRAegKUvmE
WnJb/pZJF3CkdvRNFXBNgEjAu7iN5BDAsge/ul24Ao0ocu5xVVJ5OzO4BNepB33c
9FCB9K/6T62C2NTCbugfFvmeFfgfhjwWLUdwTGYAplZdHidKlDVXfve191Ph4l+B
7AAMtVbzRpD1myUb2/hznYp5qLYNjdleyQzO17Sd+EdLLYLm63kPc29uFd8p3G87
YKFdmHUTfPPL4NvHPQPSacR2uXprIXxjRDEWf5v/RCxjzoFppZCEhm1O3rBnCD/V
/HEjMrVggaNP4fkPrvpXyE7D3nWpcsA9EhvInjWfiLTQONBYnz3B1TYUpjpSE4Ad
IaFU4XuZdT7HuWOhGfy8DnusMz0ZZYLFkinwrdP7PawN/F3l3Ay2jN4NaAjtvpVT
73GesVOy+B2VmeLznHQqMBf87tSyR4P57QeBhD2MrAMpaRxVFJ0=
=QFtp
-----END PGP SIGNATURE-----

--rf03PIGfQ5zrzZGP--
