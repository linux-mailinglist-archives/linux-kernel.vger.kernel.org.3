Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABE0488308
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 11:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233813AbiAHKPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 05:15:18 -0500
Received: from smtp.bonedaddy.net ([45.33.94.42]:40620 "EHLO
        smtp.bonedaddy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbiAHKPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 05:15:17 -0500
X-Greylist: delayed 561 seconds by postgrey-1.27 at vger.kernel.org; Sat, 08 Jan 2022 05:15:17 EST
Received: from localhost (n175-38-222-73.per2.wa.optusnet.com.au [175.38.222.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pabs3@bonedaddy.net)
        by smtp.bonedaddy.net (Postfix) with ESMTPSA id 0EA3618007A;
        Sat,  8 Jan 2022 05:06:35 -0500 (EST)
Authentication-Results: smtp.bonedaddy.net; dmarc=fail (p=none dis=none) header.from=bonedaddy.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bonedaddy.net;
        s=mail; t=1641636398;
        bh=sU8wHdA/eA0+RGEHn8+xBGwBO0Ds63zMwONdksN3I9E=;
        h=Subject:From:To:Cc:In-Reply-To:References:Date;
        b=HuRQ7TPxtF08ZgMu9hUVU3JpGavRY2/kA4d/obXcAWeL1p8EIwcb4rPkuKBveiskA
         xfQxXQPKcQstVjwU+siZ1L4EAyKdF/6xWb4cHuL7GLcVe9jCoUgBhJG9RclcBjRnG+
         0tQu4vbvWMN4nabxmvPciwJ7aV7eXxLzmSqsr6jMLTk3DXmRSGgs0et558ChbdbG85
         Mdo0hj8MBxLDINnaFLJojVFIOlmnY3XRxDvudZWebnj5v1AyP6CLK5GKVkIIVwToBM
         odD2MYlNntF84V3qloSgVZHVxc2elTp2gEA/cYYWsmo94SeGBUS8HBh4cfNTZ00B6Y
         rFOBv6lNdh1IQ==
Message-ID: <b6079be95091af6dfa3dcf02673bde8db841941e.camel@bonedaddy.net>
Subject: Re: [PATCH] tools/lib/lockdep: drop liblockdep
From:   Paul Wise <pabs3@bonedaddy.net>
To:     Sasha Levin <sashal@kernel.org>, mingo@kernel.org
Cc:     peterz@infradead.org, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <b82c6441832477653dfc4c2556b81b29bc1c75fa.camel@bonedaddy.net>
References: <20211112151602.1378857-1-sashal@kernel.org>
         <b82c6441832477653dfc4c2556b81b29bc1c75fa.camel@bonedaddy.net>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-jPS1CGmwKxPQaYGvflRO"
Date:   Sat, 08 Jan 2022 18:05:39 +0800
MIME-Version: 1.0
User-Agent: Evolution 3.42.2-1 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-jPS1CGmwKxPQaYGvflRO
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2021-11-18 at 08:32 +0800, Paul Wise wrote:


> I read that liblockdep and the lockdep tool are moving out of the Linux
> kernel tree, but couldn't find where they will be moving to. An LWN
> commenter suggested I contact you to ask about this. Thoughts?

I got this response from Sasha elsewhere and permission to fwd here:

   I haven't really gotten to extracting it out of the kernel tree.
   There's a bunch of annoying work needed there to extract whatever
   headers and code we need out of the kernel tree and make it work,
   and I just haven't had the time to do it yet. I'm hopeful I could
   do it in the next few weeks - have been a bit busy.

--=20
bye,
pabs

https://bonedaddy.net/pabs3/

--=-jPS1CGmwKxPQaYGvflRO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEYQsotVz8/kXqG1Y7MRa6Xp/6aaMFAmHZYfAACgkQMRa6Xp/6
aaMPRQ//RR/ZiLXR04AhblrVl5Q8oLfUK8G5G8F13dADVSZoq5rWjArtX5P8deVx
rQ2leVTXOToGqLwc9FqrX5TV4gH7cmB4w0OcOGLs0hMJjF7eEfYqxDs1Zp6UK4IK
7q/jlHD0iSicD7ipFZcY4knyGKhbOrt5PCY8NumF9ht2NmixtQ/9TymwocYuJ2Un
dIoBOiErNL4OU1j4nPiLkqs/6NYZIvFkAdDltJwbXpYsqr/DK4zA/04hizB9YcPQ
VPQBfGNdEFyo8ePtsimVn8bSf2HuSzlAg8JBtM25clOG1Y6mqZSkLn70DoIX4JEE
jMcXYvSBu6VSIbLypIqBRzFxb9byUYppA32m/msBRR1l3CNlGLVHbDOgvD1xFqDZ
TYBbRAdrKVPp/nL0RW8T49z0zP/v3/XRzZyTXK4LdLvf3bM27TRltDEoG/Y+1zxI
ri1B9E1GsRKWmPuyKHMFBOhb9BPa5tkV0AHLYjXqivsIpdtC1RCeZgerhbjUU4es
Cg8xOwFe8BSc54+03CtnuhQz583ZWjBO7aM18FoogeWkN27aIY7nTTtrWYjWfuZ8
V+tEihoEQpN5chT3P9xX6NUEv+tA+8r3DjVFN321cSLl++rWpdRzEqGq3ByXAAEs
n2IxxyR9P3EmwIunsvCu/tqW/G47jfbjOEVAED6tkMArhQr+9P0=
=CGrv
-----END PGP SIGNATURE-----

--=-jPS1CGmwKxPQaYGvflRO--
