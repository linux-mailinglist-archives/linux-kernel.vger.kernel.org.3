Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912C058AA83
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 14:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240656AbiHEMJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 08:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiHEMJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 08:09:01 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD652316A;
        Fri,  5 Aug 2022 05:09:00 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id AE7741C0012; Fri,  5 Aug 2022 14:08:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1659701339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0uvOdezGubzEgiEQYe2abWp+ga6SLlUKY0x31hlZjL8=;
        b=DthWHpf1Ndm6CGGZZYiupKCb32lyZo18MjNvzzglyV12eZ0GhaFCSpalvU/XrRcE2hfPPo
        laQUEde6j0SezMoqQ0F1/QZ6n6ol4XyQ2ipeZ4xE+9QgJVsZlx+vdv+1gpDvEqycj07mQ5
        9lEfMSiHWjiGTqay6EOBB9KFVmJXVG8=
Date:   Fri, 5 Aug 2022 14:08:59 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     "Luke D. Jones" <luke@ljones.dev>
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] asus-wmi: Add support for TUF laptop keyboard states
Message-ID: <20220805120859.GB20036@duo.ucw.cz>
References: <20220805081909.10962-1-luke@ljones.dev>
 <20220805081909.10962-4-luke@ljones.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="RASg3xLB4tUQ4RcS"
Content-Disposition: inline
In-Reply-To: <20220805081909.10962-4-luke@ljones.dev>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RASg3xLB4tUQ4RcS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!
>=20
> Adds two paths:
> - /sys/devices/platform/asus-nb-wmi/keyboard_rgb_state
> - /sys/devices/platform/asus-nb-wmi/keyboard_rgb_state_index

Patches 2-3 -- we already have pattern trigger. This should use it...

Best regards,
									Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--RASg3xLB4tUQ4RcS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYu0IWwAKCRAw5/Bqldv6
8oH5AJ4uctk1n8S4t+NHFng/KyDHb3LeAACdEgnLQQyMtI6wQjJeqMfP2uaQAHk=
=4aQe
-----END PGP SIGNATURE-----

--RASg3xLB4tUQ4RcS--
