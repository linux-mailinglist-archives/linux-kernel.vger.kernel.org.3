Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF0658BADC
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 14:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234100AbiHGMlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 08:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233952AbiHGMlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 08:41:09 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666D964C2;
        Sun,  7 Aug 2022 05:41:05 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id A29D01C0001; Sun,  7 Aug 2022 14:41:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1659876062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wFPzsWZvNJjf3xigQNfBO1OUrJFu0sYZpOtVGcvmNyI=;
        b=gqLNXkePnHe/K7gYCo/14jojVP3/pQNZl9OW5+UUnmZeNyk7MGTIi8K4kmu2C6fpz+Ny3z
        GHeQVFeppILDhqVtB8D7pscHzOUwszgoOmYxR5toaXCMYNhKHHawJa74BbVKFzdTL5wL0H
        a/HzLCiWm1tsAfUMGgFLj7JHws/0Tjo=
Date:   Sun, 7 Aug 2022 14:41:02 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Luke Jones <luke@ljones.dev>
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] asus-wmi: Add support for TUF laptop keyboard states
Message-ID: <20220807124102.GA32221@duo.ucw.cz>
References: <20220805081909.10962-1-luke@ljones.dev>
 <20220805081909.10962-4-luke@ljones.dev>
 <20220805120859.GB20036@duo.ucw.cz>
 <ZTI8GR.GMVLPPJWYEO53@ljones.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
In-Reply-To: <ZTI8GR.GMVLPPJWYEO53@ljones.dev>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I'm sorry but can you direct me to a source file or other that shows use =
of
> "pattern trigger". I don't know what this means or what to look for. From
> your response it seems I should certainly be using it.

Trigger is at drivers/leds/trigger/ledtrig-pattern.c , you'd want to
do something similar to drivers/leds/rgb/leds-qcom-lpg.c .

> I've finished with all the feedback I've received so far, and this is the
> last piece.

Actually... you may want to submit version without patterns at
first. It will be easier to review.

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYu+y3gAKCRAw5/Bqldv6
8pvsAJ4yN0Qm5NRqNExZoBRtdHXPWcMD4gCgwOm4s4MRF5KY2Mms/Bp6hCZs9FY=
=fpCX
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--
