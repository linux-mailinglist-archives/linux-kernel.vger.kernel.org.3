Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D0F528654
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 16:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244277AbiEPOCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 10:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237279AbiEPOCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 10:02:33 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBD03915C
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 07:02:31 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 0412C5C0187;
        Mon, 16 May 2022 10:02:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 16 May 2022 10:02:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1652709747; x=
        1652796147; bh=5+yjKYHPE1yoR5qIVYd0h7SQNO3dMIP7wshVKU2tLos=; b=k
        saUMyBATJHiD5hcBAlk1cIyhS1lpNsncGh0Ap4ZUTf/TWtLo6hce5e/Jb2UGcVPK
        nL6NcXTFYOzPQZ5/mnYsjoB/jgPhJDJ624lQQA2wE7c5xPoMdMSqAr8HI0/3+CkW
        eZr8gTDbC9l7Q/yiTwIIlFA8EtlwUY/FtcsgzZpZrQ+Lvbk+qXVtr/R1jQj34tpa
        73t3PsRbsODttyToRASv9OjnPMFINxj5L443EkpRW/2I1UYw1u47sT2IiTp075os
        6sRX0y6E/WPgQLABilj2gjj3SILxTVQv8bpt2FHNFCidB6Kldt9aS1JsYIBsGgb1
        Uwh0zqORhAMD6ZPNF695A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1652709747; x=
        1652796147; bh=5+yjKYHPE1yoR5qIVYd0h7SQNO3dMIP7wshVKU2tLos=; b=d
        i4A6NuCbon46rmfCdiNtEeyRKml5bH1dEYMsdrOArpkzpHB+MJR47Ls7B9vh4ikQ
        L0aZHA5SGNFR6RzZzTK/yPaqSXqe61DsdkXph2VK/JZqRJoMrFFGVUTe+6KpXr3n
        U5NJ9Y+CVNpTeiFvSz8Y127Q/Mn29hbE1sG+CNoB/13dr7grorrV0DgkkEBF4e1X
        koCzziX43Kr+9IwKHsgAW/iLx6qQiR6ohgzRNNhDTDXj0kDlDwIRvxeabG9U82jI
        1KK3mSRMogtw6D5MsVbD8cJgLY8bJH98nJ1VZ7YdHXetoAzvUCFjbTs8DiHuCU8e
        ibgZKTkheqrujPBH6PEDw==
X-ME-Sender: <xms:c1mCYvN49R8q91siQAlAHSsDYwW9JX6GZJK7uZoLaRKffOvOFebWHQ>
    <xme:c1mCYp_tKKjjaOLdt9zGxyRmVWfgWrXruRb4tYJdpuTXy0edv_fj3RYFSiLXCs0Rk
    M8kLkS5aKhSg9E>
X-ME-Received: <xmr:c1mCYuRe3kZa1gLTTNUF7kXoIR0FgzK0qPyXdMiHZ7Ba33AHz6qT_sPuTZEt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrheehgdejtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpeffvghmihcu
    ofgrrhhivgcuqfgsvghnohhurhcuoeguvghmihesihhnvhhishhisghlvghthhhinhhgsh
    hlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpeeutdehhfdtvdfffeejjedvhedvjeei
    heffheekkeehgeelueelveeludetheetteenucffohhmrghinhepghhithhhuhgsrdgtoh
    hmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepuggv
    mhhisehinhhvihhsihgslhgvthhhihhnghhslhgrsgdrtghomh
X-ME-Proxy: <xmx:c1mCYjurAm2dIPcJz8c-ZxluVFij2F_lxdkugh6HT3XxF5-0eFDUbQ>
    <xmx:c1mCYneuoRBaZp8LHp0Id6aAjgpjNZ-v-sODI87jBmo56m3R5PFyVA>
    <xmx:c1mCYv3OMOCsMbAlmIlcDY3-qItit44kex-WBnNpMPu847NOf50yqg>
    <xmx:c1mCYl3PEyg0TK6EZxQeWxycISQ5zefM9PK3N-nYBIkxIx_RTfCwyw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 May 2022 10:02:26 -0400 (EDT)
Date:   Mon, 16 May 2022 10:00:07 -0400
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Juergen Gross <jgross@suse.com>,
        Xen developer discussion <xen-devel@lists.xenproject.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Boris Ostrovski <boris.ostrovsky@oracle.com>,
        Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>, linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Memory Management <linux-mm@kvack.org>
Subject: Re: Hang in 5.17.4+ that appears to be due to Xen
Message-ID: <YoJZcUsiE3y6oul5@itl-email>
References: <Yn/Tgj1Ehs/BdpHp@itl-email>
 <55436ae1-8255-1898-00df-51261080cd41@suse.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YnCoB7CFMTtqXZKs"
Content-Disposition: inline
In-Reply-To: <55436ae1-8255-1898-00df-51261080cd41@suse.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YnCoB7CFMTtqXZKs
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 May 2022 10:00:07 -0400
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Juergen Gross <jgross@suse.com>,
	Xen developer discussion <xen-devel@lists.xenproject.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Boris Ostrovski <boris.ostrovsky@oracle.com>,
	Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>,
	linux-kernel@vger.kernel.org,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
	Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
	DRI Development <dri-devel@lists.freedesktop.org>,
	Linux Memory Management <linux-mm@kvack.org>
Subject: Re: Hang in 5.17.4+ that appears to be due to Xen

On Mon, May 16, 2022 at 08:48:17AM +0200, Juergen Gross wrote:
> On 14.05.22 17:55, Demi Marie Obenour wrote:
> > In https://github.com/QubesOS/qubes-issues/issues/7481, a user reported
> > that Xorg locked up when resizing a VM window.  While I do not have the
> > same hardware the user does and thus cannot reproduce the bug, the stack
> > trace seems to indicate a deadlock between xen_gntdev and i915.  It
> > appears that gnttab_unmap_refs_sync() is waiting for i915 to free the
> > pages, while i915 is waiting for the MMU notifier that called
> > gnttab_unmap_refs_sync() to return.  Result: deadlock.
> >=20
> > The problem appears to be that a mapped grant in PV mode will stay in
> > the =E2=80=9Cinvalidating=E2=80=9D state until it is freed.  While MMU =
notifiers are
> > allowed to sleep, it appears that they cannot wait for the page to be
> > freed, as is happening here.  That said, I am not very familiar with
> > this code, so my diagnosis might be incorrect.
>=20
> All I can say for now is that your patch seems to be introducing a use af=
ter
> free issue, as the parameters of the delayed work might get freed now bef=
ore
> the delayed work is being executed.

I figured it was wrong, not least because I don=E2=80=99t think it compiles
(invalid use of void value).  That said, the current behavior is quite
suspicious to me.  For one, it appears that munmap() on a grant in a PV
domain will not return until nobody else is using the page.  This is not
what I would expect, and I can easily imagine it causing deadlocks in
userspace.  Instead, I would expect for gntdev to automatically release
the grant when the reference count hits zero.  This would also allow for
the same grant to be mapped in multiple processes, and might even unlock
DMA-BUF support.

> I don't know why this is happening only with rather recent kernels, as the
> last gntdev changes in this area have been made in kernel 4.13.
>=20
> I'd suggest to look at i915, as quite some work has happened in the code
> visible in your stack backtraces rather recently. Maybe it would be possi=
ble
> to free the pages in i915 before calling the MMU notifier?

While I agree that the actual problem is almost certainly in i915, the
gntdev code does appear rather fragile.  Since so few people use i915 +
Xen, problems with the combination generally don=E2=80=99t show up until so=
me
Qubes user makes a bug report, which isn=E2=80=99t great.  It would be bett=
er if
Xen didn=E2=80=99t introduce requirements on other kernel code that did not=
 hold
when not running on Xen.

In this case, if it is actually an invariant that one must not call MMU
notifiers for pages that are still in use, it would be better if this
was caught by a WARN_ON() or BUG_ON() in the core memory management
code.  That would have found the bug instantly and deterministically on
all platforms, whereas the current failure is nondeterministic and only
happens under Xen.

I also wonder if this is a bug in the core MMU notifier infrastructure.
My reading of the mmu_interval_notifier_remove() documentation is that
it should only wait for the specific notifier being removed to finish,
not for all notifiers to finish.  Adding the memory management
maintainers.
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--YnCoB7CFMTtqXZKs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmKCWXEACgkQsoi1X/+c
IsEjNBAAz3hf+qemY+7SSkjIjwueaAyZFhnYLKo7R0cNfYPKD12S5Rt0z0iQbVNN
PSXBm7/9WS5C9a3x4poKuE5k+HUbpBiu/xrUHSvWQgoCpJCT7ZIruIKQYYj7Ok9C
BRf3ZjB47o9ZYkRjanMjNeCYJpx8JpAU4Kq1DtLtZW9vtibKdk/Yhn4bl54rqBtQ
8UGtYK85sfxTnBegkR3/T2bXAuymx3tbi6+VF1NjzH1SYSNp0kUX7FJGfQrNaXXO
jzNW7rCsA9AEeitHavIsRgBMSMGbeq+QLdGhx5I8TKS9fplT99b6ZvnEg3qMDDKe
Y6l7SM765IqeByc+oi1cmZ25djJiRUKM7OVgDLvkC73F3auBKEzA+H56JOvMJDHu
rrKdUt4Mbo5eOBxRJn1l9C/C/2Gxuu2UW8KOAXVoLk+yjWjzqUYrpO8lm/T1o/m7
0lwBFi5KV2iEPuGcfS9cMNPmjNtkFSgKpSSmAatwH0D7nQCPPoN6Xf1WzQN/mAyz
XP8VvvKkzB+QLyu+/niOIWHWNED2EwOiR1rhJ8ElESpDTz03qBGrSpIoffmwVngB
nojEVAMrgCyzwmfB90myQAZ2MUvdfgOUj5Cy6qAZYctv2RXAwBvZOmZdgWMLYJvl
IoWWk34NY57aVwFxvWnDQls/YRqzO8DZUimCHIt1CxqK64u35yk=
=bUCk
-----END PGP SIGNATURE-----

--YnCoB7CFMTtqXZKs--
