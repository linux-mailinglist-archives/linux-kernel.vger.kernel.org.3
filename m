Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD68A58D03D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 00:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244600AbiHHWio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 18:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244567AbiHHWik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 18:38:40 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB3EF70;
        Mon,  8 Aug 2022 15:38:38 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4M1rhT6HTDz4xD2;
        Tue,  9 Aug 2022 08:38:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1659998313;
        bh=csvvQDyGYCMCPcaM/XVHFy6jJ3pw8ANibPTMSGL0GnM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Eyc6iqp0ThtV5q9W+falrAei/hRadBbSb219POoJzG2TrOBvb97FyjGDN8htINzix
         XPDz5rzNQaOlEZ2O8TvRqPd+JXrVSbXyQU22CwmJ/43I2xcojrlim9IULTeAiAGuTT
         jkmLwsqiHyim2z9IlQYJN6W80LYyCZY41179TlLnUfmEuEjcS444X9ijleUwybn6gE
         C8hZKQM4fhht/ub7AVeEthktr+kTJvkO9V+lKhWfnMhTJA+u00VtQjZKpu2wQvv4ls
         +nuC1RMp00iSRh1YZkZ+UHjj4p7M65O0CrkN4z/Fzkvw9dLWDS7aMlfN49lWSM85QK
         H74jvUiSQxLeg==
Date:   Tue, 9 Aug 2022 08:38:16 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for Aug 8
Message-ID: <20220809083816.338deaae@canb.auug.org.au>
In-Reply-To: <20220808134735.0b3b93a4@canb.auug.org.au>
References: <20220808134735.0b3b93a4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/tWXZBdYxPua4UBKr_kypLtv";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/tWXZBdYxPua4UBKr_kypLtv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi All,

On Mon, 8 Aug 2022 13:47:35 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>

Please do not add any v6.1 destined code to your linux-next included
branches until after v6.0-rc1 has been released.

--=20
Cheers,
Stephen Rothwell

--Sig_/tWXZBdYxPua4UBKr_kypLtv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLxkFgACgkQAVBC80lX
0GxjmAf9HpYvFqfx/JoIAApl98DgMlbQnoJny9RcHDeVAlqDs3DFxVBjnBv71nHw
12GsnYuxcanQWambeLGxM/C6M5DgkkpnyJI7gg1q2FzHYOXcjKn47q/Acg/ObC2w
8yaYmprViNDzBTfobvG94wPfn7fTBTZcyoRx5Uh3p5cTiwFBAYGMf+vigxdRxZ2O
j2HGnUNQF/9YGlWrjDcexuyhVEkcKuc5/RLnLPWEEHehLVdz5gB9gHyM2ooIufk6
+tj+9meXVRoqoDepQIJKsjZLhgr++Br0VcVw2eNBSwZRh35HrAAaqyO+WjN85XRZ
G5JxEIlZYT0EJgibhqV7DPutY2OQbQ==
=1pLt
-----END PGP SIGNATURE-----

--Sig_/tWXZBdYxPua4UBKr_kypLtv--
