Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 253D453CE01
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 19:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344380AbiFCRXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 13:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344375AbiFCRXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 13:23:12 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337F8527FE
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 10:23:11 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id DD22621B35;
        Fri,  3 Jun 2022 17:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654276989; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UPMomr3jzTc6gcXGmXLj0Br1avJ9TWeGe+quz6nhksE=;
        b=FBr3uWFAKiPnWWIx3Sz21Y7eogyRuw9PoWzwr8WfvYbPxJow5GJMnecyM/pc0R44W6V6Gz
        QxKjWjmn6ABSboCJXUfW4iQlX9jFhrr6gOk55o7jWFcuEZ5Yy5xvKoy+W+FFq3AL2YFtlF
        tHla8nIB5bLCxav9bxojI+Tb5PNOgvM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654276989;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UPMomr3jzTc6gcXGmXLj0Br1avJ9TWeGe+quz6nhksE=;
        b=+K8MayvxFlWvSJh6B29VGb2H61gLR5nPEhIBFCa7Jcd/FtkpELUMxeP0PDiCo6WMKU2ZTR
        NeVpGzIhAktMvHBg==
Received: from lion.mk-sys.cz (unknown [10.100.200.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C2BB42C141;
        Fri,  3 Jun 2022 17:23:09 +0000 (UTC)
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
        id 9D17D60426; Fri,  3 Jun 2022 19:23:09 +0200 (CEST)
Date:   Fri, 3 Jun 2022 19:23:09 +0200
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     "Yang, Philip" <Philip.Yang@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: (REGRESSION bisected) Re: amdgpu errors (VM fault / GPU fault
 detected) with 5.19 merge window snapshots
Message-ID: <20220603172309.kq47e4kyopz2qqi3@lion.mk-sys.cz>
References: <20220527090039.pdrazo5e6mwgo3d3@lion.mk-sys.cz>
 <20220527124459.mfo4tjdsjohamsvy@lion.mk-sys.cz>
 <CADnq5_Pr-FKfhuXT9DR2rYD=dMfD=+Dfev+CO-xeaPGnhwSQaA@mail.gmail.com>
 <20220602142254.2ck7dw7u3xlzdnt2@lion.mk-sys.cz>
 <CADnq5_MiQKX4JA-3xbxGYXKHpJqD0Px1NYSiL6yPeTwseoNVGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mcayuoy6vmkfigea"
Content-Disposition: inline
In-Reply-To: <CADnq5_MiQKX4JA-3xbxGYXKHpJqD0Px1NYSiL6yPeTwseoNVGg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mcayuoy6vmkfigea
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 03, 2022 at 11:49:31AM -0400, Alex Deucher wrote:
> On Thu, Jun 2, 2022 at 10:22 AM Michal Kubecek <mkubecek@suse.cz> wrote:
> >
> > On Thu, Jun 02, 2022 at 09:58:22AM -0400, Alex Deucher wrote:
> > > On Fri, May 27, 2022 at 8:58 AM Michal Kubecek <mkubecek@suse.cz> wro=
te:
> > > > On Fri, May 27, 2022 at 11:00:39AM +0200, Michal Kubecek wrote:
> > > > > Hello,
> > > > >
> > > > > while testing 5.19 merge window snapshots (commits babf0bb978e3 a=
nd
> > > > > 7e284070abe5), I keep getting errors like below. I have not seen =
them
> > > > > with 5.18 final or older.
> > > > >
> > > > > -----------------------------------------------------------------=
-------
> > > > > [  247.150333] gmc_v8_0_process_interrupt: 46 callbacks suppressed
> > > > > [  247.150336] amdgpu 0000:0c:00.0: amdgpu: GPU fault detected: 1=
47 0x00020802 for process firefox pid 6101 thread firefox:cs0 pid 6116
> > > > > [  247.150339] amdgpu 0000:0c:00.0: amdgpu:   VM_CONTEXT1_PROTECT=
ION_FAULT_ADDR   0x00107800
> > > > > [  247.150340] amdgpu 0000:0c:00.0: amdgpu:   VM_CONTEXT1_PROTECT=
ION_FAULT_STATUS 0x0D008002
> > > > > [  247.150341] amdgpu 0000:0c:00.0: amdgpu: VM fault (0x02, vmid =
6, pasid 32780) at page 1079296, write from 'TC2' (0x54433200) (8)
> > > > [...]
> > > > > [  249.925909] amdgpu 0000:0c:00.0: amdgpu: IH ring buffer overfl=
ow (0x000844C0, 0x00004A00, 0x000044D0)
> > > > > [  250.434986] [drm] Fence fallback timer expired on ring sdma0
> > > > > [  466.621568] gmc_v8_0_process_interrupt: 122 callbacks suppress=
ed
> > > > [...]
> > > > > -----------------------------------------------------------------=
-------
> > > > >
> > > > > There does not seem to be any apparent immediate problem with gra=
phics
> > > > > but when running commit babf0bb978e3, there seemed to be a notice=
able
> > > > > lag in some operations, e.g. when moving a window or repainting l=
arge
> > > > > part of the terminal window in konsole (no idea if it's related).
> > > > >
> > > > > My GPU is Radeon Pro WX 2100 (1002:6995). What other information =
should
> > > > > I collect to help debugging the issue?
> > > >
> > > > Bisected to commit 5255e146c99a ("drm/amdgpu: rework TLB flushing").
> > > > There seem to be later commits depending on it so I did not test
> > > > a revert on top of current mainline.
> > > >
> > > > I should also mention that most commits tested as "bad" during the
> > > > bisect did behave much worse than current mainline (errors starting=
 as
> > > > early as with sddm, visibly damaged screen content, sometimes even
> > > > crashes). But all of them issued messages similar to those above in=
to
> > > > kernel log.
> > >
> > > Can you verify that the kernel you tested has this patch:
> > > https://cgit.freedesktop.org/drm/drm/commit/?id=3D5be323562c6a699d384=
30bc068a3fd192be8ed0d
> >
> > Yes, both of them:
> >
> > mike@lion:~/work/git/kernel-upstream> git merge-base --is-ancestor 5be3=
23562c6a babf0bb978e3 && echo yes
> > yes
> >
> > (7e284070abe5 is a later mainline snapshot so it also contains
> > 5be323562c6a)
> >
> > But it's likely that commit 5be323562c6a fixed most of the problem and
> > only some corner case was left as most bisect steps had many more error
> > messages and some even crashed before I was able to even log into KDE.
> > Compared to that, the mainline snapshots show much fewer errors, no
> > distorted picture and no crash; on the other hand, applications like
> > firefox or stellarium seem to trigger the errors quite consistently.
>=20
> This patch should help:
> https://patchwork.freedesktop.org/patch/488258/

It seems to help, I'm running a kernel built with this patch on top of
mainline commit 50fd82b3a9a9 (current head) and I haven't seen any
errors yet. I'll give it some more time and report back.

Michal

--mcayuoy6vmkfigea
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmKaQ3cACgkQ538sG/LR
dpXmCggAgQk48eQZJOBICUS7Vy2W1l+t7ZkV3KeG6iHfiKv3N6XaxdgeXZPDCHmU
ER4fq6lc6jqj+kvFqumeyPt3lDjuo60t8GqM/Ba80ZTKLTAj2boaw8j9M0O9gi4m
mLrzXmYIFpRLBiw0OJt7bNfevxU7eKwLO6SPORKm/L8HTUD+InurJdmVxkiBEHTo
xkYsFjEoOLPmGyIWOls+hGkzz9/LdwlBWWsgU2vpPs0Fr8xtyu7AaTP0uR5nxi2n
LZQzGG/FBR3pk4cEkcA0/2mJtJdJl/zDS8aL15z4x9Fv3geug6kAEFwkklW2MVe5
hB1FjEBmS1dBQvGPlSjgNA4ktoW0wQ==
=LYI5
-----END PGP SIGNATURE-----

--mcayuoy6vmkfigea--
