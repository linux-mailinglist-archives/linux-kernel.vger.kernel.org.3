Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 098D0469C8F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 16:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358772AbhLFPXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 10:23:31 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:34522 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355787AbhLFPOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 10:14:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 44CFA61349
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 15:10:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 988C0C341C5;
        Mon,  6 Dec 2021 15:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638803446;
        bh=IKiCrwkAdFuuSfbngsgxUNZnen9NhInnh4oYmhBKl68=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RiFHDFRz6ASjbJtqFRqzL0raAgcVkb1UFoquDcKAsjGnHCmZ2YRSxanhe9p7Cyix3
         OcfgPdZQcnX0CxRUb2R6YUUKRwUoVM/dMNX82NccZgCzUbgy8MW0fsmg0M4ffAeJuQ
         lqYrSrlgFHqDe7lXcdcYB2PpPvgaqMFZmhg28sNWRM5Qx7A369cPgO6u3I+JkNe6AY
         vkdcpsdYzD254UG4IAXetwkI6jiufAePtySRuhS2dvZAZBHT0XywTzD7mH+IgkpUUA
         BwxNVOlEV9jnos2LZel76qnnjWVzjceGmi6nRG/wr67OmrLt6vDXI+6D+GRy1McESb
         xJOTchbiTWT6A==
Date:   Mon, 6 Dec 2021 15:10:40 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>, Jiri Slaby <jslaby@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Fuad Tabba <tabba@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>
Subject: Re: [RFC PATCH 0/6] linkage: better symbol aliasing
Message-ID: <Ya4n8IDXVqSKKFIL@sirena.org.uk>
References: <20211206124715.4101571-1-mark.rutland@arm.com>
 <CAMj1kXHUtyn9K91jkqdU69-acvGkYsPZ-yeb7dALOeztDpfDvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5TuEFK4aIq+uk2Un"
Content-Disposition: inline
In-Reply-To: <CAMj1kXHUtyn9K91jkqdU69-acvGkYsPZ-yeb7dALOeztDpfDvg@mail.gmail.com>
X-Cookie: You will soon forget this.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5TuEFK4aIq+uk2Un
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 06, 2021 at 03:06:44PM +0100, Ard Biesheuvel wrote:

> I never understood why we had these start/end markers in the first
> place for alias definitions, so good riddance.

> Acked-by: Ard Biesheuvel <ardb@kernel.org>

What Ard said:

Acked-by: Mark Brown <broonie@kernel.org>

--5TuEFK4aIq+uk2Un
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGuJ+8ACgkQJNaLcl1U
h9CB2wf9GiwHi9nQmSSBARizu2DEGe0cEqdEYmebea2KBT1g+DXvaECdoW4wO+ZC
Bg7XIfCbLg9J+K8kGXKEBI5df/p8heEMueL4c0bvVp/AWKisRgkx9XVdrOP/HGVW
s4/vPD8TOK0eJQeYoWTr2TAzkAsOPTw8EYhQyCVgEGhyyMlomlEKgHI/Wq+ZpRpY
vv/coIGS0Ov0GRI/pQey6CgiQukYvfZrDRlRmu0T8+9zhxVDiIlfm+/Rhjrl0vc2
kGp8FthxrUiBAvIEBX3Wam7ft17350twX4NHMPHs7VjhLhN8lNNTha+dQSdDOoif
990xktLlnm+76bwB+LYyAl21XaY3pQ==
=EfQx
-----END PGP SIGNATURE-----

--5TuEFK4aIq+uk2Un--
