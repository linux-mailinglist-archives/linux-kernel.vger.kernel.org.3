Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48AE253426F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 19:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343545AbiEYRuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 13:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343550AbiEYRut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 13:50:49 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59C22018E
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 10:50:47 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id AEEE1320096D;
        Wed, 25 May 2022 13:50:44 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 25 May 2022 13:50:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1653501044; x=
        1653587444; bh=f9VnyOtZqXUWrMce84m2QLDpjEOWiin85RMdEmMsHp8=; b=a
        7bv2qZ6iWdEj2TDkEISuYBy5DdbvXzQTyTw6KTz/0WSHUF7jMXg1RMhVXcqkEc2K
        USk5mGL1IVMgv0fa7Mgf36IbVX9YBrEF96gSw1DCZA5T9Ryifszb4jD+f92ZBXV1
        6aufdEbYFZHf8uqbok9924B98mtRtwOtVrjyPF4nEqYncwpizJfGnERiP2oTSd9k
        B0hBcEg1BfJXsM8uPW5ESx8HY9Wv9MOeZwgD12OLUQzihwLLBdpZm3fcHJRH+0JD
        msxpOxJcj7eFwAifayC/ETxpFN5+4eOrRPLBgBE2yXWz0aDqgJo3ns0B9mlJBYPO
        w87c+R3niKCxNqjjOfDLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1653501044; x=1653587444; bh=f9VnyOtZqXUWrMce84m2QLDpjEOW
        iin85RMdEmMsHp8=; b=sEggMZwAaFSpgNwQr7oCW9cOkluGqzEYG5geF8GSCJgx
        qn1Friddm1VSoPbv2CEaoisuNMDrKGg26QgQXlbPQPivm6pJQ9hQsJaI562dNNC2
        ss+fnYkuxe3o/S7yipm0WBys7dUJir2JWXP9v49CGtzx5CJ1ZFf/bMaoyxycQrbB
        24QmEZxLsw1cc3BllswG5E3vAPlhhXnpud/vYwA76QLjcZNI3BDgMBc8Crjbu1lk
        33Dd8WBvZe8mjNkRCD0qNYsREA3uxVfLG6zlCljH1X+ew1iW99qIMF3+UsLa24T1
        k70X7qQiiuNZSCT8aKQGuwU97Vo1+oLs5HZPVejxhg==
X-ME-Sender: <xms:c2yOYi4ehuuUvJV-THHgsCxd7nAT_udDHXuRPLbi6AkH4o_bTqBKrA>
    <xme:c2yOYr5JlsVcYRA4Xg0pp_dodmddFl8pM6yiL96Z9aoyEepd44lm7Lwf8jBT4Pyrs
    T-d2X2JiQ5uLt0>
X-ME-Received: <xmr:c2yOYhdyxt34KDKUvnmEBEBWQF9G4TL9h3XmGH_IjvX7lY0IF7_pXhNiSmcc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrjeehgdduudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepffgvmhhi
    ucforghrihgvucfqsggvnhhouhhruceouggvmhhisehinhhvihhsihgslhgvthhhihhngh
    hslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepudeuvdekffffieduhedtkeevkedu
    fedvkeeiheffvdegueetteehgfefieetudfgnecuffhomhgrihhnpehgihhthhhusgdrtg
    homhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegu
    vghmihesihhnvhhishhisghlvghthhhinhhgshhlrggsrdgtohhm
X-ME-Proxy: <xmx:c2yOYvKpFhw5WACO0LL4djXvdFStKxtgqXjJ9k5yyogkI8x-mu5JoA>
    <xmx:c2yOYmKMsRUafaJDTKnIMP1FyYTJuVMfCBFI4E2ADa3hhgDY_yEazg>
    <xmx:c2yOYgxu96d1MwlWYUd5HHTWVxyJkTad-pblnsqPj4snsZzNXC2yLA>
    <xmx:dGyOYrH1uITAObaDXLnIqE_1LWelTEiAusXb5OLssyC7yoQ3R-fCXg>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 May 2022 13:50:43 -0400 (EDT)
Date:   Wed, 25 May 2022 13:50:37 -0400
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Jennifer Herbert <jennifer.herbert@citrix.com>,
        David Vrabel <david.vrabel@citrix.com>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xen/gntdev: Avoid blocking in unmap_grant_pages()
Message-ID: <Yo5scR3gW5XvEnif@itl-email>
References: <Yo0LwmVUDSBZb44K@itl-email>
 <36489ed0-d2ec-92bc-6a15-b423118f8af2@suse.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tH1jpdVHmorgFwLg"
Content-Disposition: inline
In-Reply-To: <36489ed0-d2ec-92bc-6a15-b423118f8af2@suse.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tH1jpdVHmorgFwLg
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 May 2022 13:50:37 -0400
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Jennifer Herbert <jennifer.herbert@citrix.com>,
	David Vrabel <david.vrabel@citrix.com>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xen/gntdev: Avoid blocking in unmap_grant_pages()

On Wed, May 25, 2022 at 11:17:39AM +0200, Juergen Gross wrote:
> On 24.05.22 18:45, Demi Marie Obenour wrote:
> > unmap_grant_pages() currently waits for the pages to no longer be used.
> > In https://github.com/QubesOS/qubes-issues/issues/7481, this lead to a
> > deadlock against i915: i915 was waiting for gntdev's MMU notifier to
> > finish, while gntdev was waiting for i915 to free its pages.  I also
> > believe this is responsible for various deadlocks I have experienced in
> > the past.
> >=20
> > Avoid these problems by making unmap_grant_pages async.  This requires
> > making it return void, as any errors will not be available when the
> > function returns.  Fortunately, the only use of the return value is a
> > WARN_ON().  Replace this with WARN_ON()s where errors are detected.
>=20
> Not all callers of unmap_grant_pages() are issuing a WARN_ON(). Are you
> sure that this change can't result in a flood of WARN()s?

It probably can, but for a different reason.  Since the actual unmap is
now asynchronous, the handle is set to INVALID_GRANT_HANDLE too late to
prevent double unmaps.  I will fix this by using a separate bool array
in v2.  Another option is to (ab)use the paddding bits in the hypercall
struct, but that seems too fragile.

> Please note that you are modifying the semantics in case of an unmap
> operation returning an error. Previously there were no further unmaps
> done in this case, while now you are basically continue unmapping even
> after hitting an error. This seems to be fine, but is worth mentioning
> in the commit message.

Will fix in v2, thanks.

> > Fixes: 745282256c75 ("xen/gntdev: safely unmap grants in case they are =
still in use")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
> > ---
> >   drivers/xen/gntdev-common.h |  4 ++
> >   drivers/xen/gntdev.c        | 82 ++++++++++++++++++-------------------
> >   2 files changed, 45 insertions(+), 41 deletions(-)
> >=20
> > diff --git a/drivers/xen/gntdev-common.h b/drivers/xen/gntdev-common.h
> > index 20d7d059dadb..a6e2805ea2ce 100644
> > --- a/drivers/xen/gntdev-common.h
> > +++ b/drivers/xen/gntdev-common.h
> > @@ -16,6 +16,7 @@
> >   #include <linux/mmu_notifier.h>
> >   #include <linux/types.h>
> >   #include <xen/interface/event_channel.h>
> > +#include <xen/grant_table.h>
> >   struct gntdev_dmabuf_priv;
> > @@ -73,6 +74,9 @@ struct gntdev_grant_map {
> >   	/* Needed to avoid allocation in gnttab_dma_free_pages(). */
> >   	xen_pfn_t *frames;
> >   #endif
> > +
> > +	/* Needed to avoid allocation in __unmap_grant_pages */
> > +	struct gntab_unmap_queue_data unmap_data;
> >   };
> >   struct gntdev_grant_map *gntdev_alloc_map(struct gntdev_priv *priv, i=
nt count,
> > diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
> > index 59ffea800079..670d800e4a89 100644
> > --- a/drivers/xen/gntdev.c
> > +++ b/drivers/xen/gntdev.c
> > @@ -62,8 +62,8 @@ MODULE_PARM_DESC(limit,
> >   static int use_ptemod;
> > -static int unmap_grant_pages(struct gntdev_grant_map *map,
> > -			     int offset, int pages);
> > +static void unmap_grant_pages(struct gntdev_grant_map *map,
> > +			      int offset, int pages);
> >   static struct miscdevice gntdev_miscdev;
> > @@ -349,61 +349,65 @@ int gntdev_map_grant_pages(struct gntdev_grant_ma=
p *map)
> >   	return err;
> >   }
> > -static int __unmap_grant_pages(struct gntdev_grant_map *map, int offse=
t,
> > -			       int pages)
> > +static void __unmap_grant_pages_done(int result,
> > +		struct gntab_unmap_queue_data *data)
> >   {
> > -	int i, err =3D 0;
> > -	struct gntab_unmap_queue_data unmap_data;
> > -
> > -	if (map->notify.flags & UNMAP_NOTIFY_CLEAR_BYTE) {
> > -		int pgno =3D (map->notify.addr >> PAGE_SHIFT);
> > -		if (pgno >=3D offset && pgno < offset + pages) {
> > -			/* No need for kmap, pages are in lowmem */
> > -			uint8_t *tmp =3D pfn_to_kaddr(page_to_pfn(map->pages[pgno]));
> > -			tmp[map->notify.addr & (PAGE_SIZE-1)] =3D 0;
> > -			map->notify.flags &=3D ~UNMAP_NOTIFY_CLEAR_BYTE;
> > -		}
> > -	}
> > -
> > -	unmap_data.unmap_ops =3D map->unmap_ops + offset;
> > -	unmap_data.kunmap_ops =3D use_ptemod ? map->kunmap_ops + offset : NUL=
L;
> > -	unmap_data.pages =3D map->pages + offset;
> > -	unmap_data.count =3D pages;
> > -
> > -	err =3D gnttab_unmap_refs_sync(&unmap_data);
> > -	if (err)
> > -		return err;
> > +	int i;
>=20
> Mind using unsigned int instead?

Not at all.  I used int because that is what the original code used, but
an unsigned type is definitely better.

> > +	struct gntdev_grant_map *map =3D data->data;
> > +	int offset =3D data->unmap_ops - map->unmap_ops;
> > -	for (i =3D 0; i < pages; i++) {
> > -		if (map->unmap_ops[offset+i].status)
> > -			err =3D -EINVAL;
> > +	for (i =3D 0; i < data->count; i++) {
> > +		WARN_ON(map->unmap_ops[offset+i].status); >   		pr_debug("unmap hand=
le=3D%d st=3D%d\n",
> >   			map->unmap_ops[offset+i].handle,
> >   			map->unmap_ops[offset+i].status);
> >   		map->unmap_ops[offset+i].handle =3D INVALID_GRANT_HANDLE;
> >   		if (use_ptemod) {
> > -			if (map->kunmap_ops[offset+i].status)
> > -				err =3D -EINVAL;
> > +			WARN_ON(map->kunmap_ops[offset+i].status);
> >   			pr_debug("kunmap handle=3D%u st=3D%d\n",
> >   				 map->kunmap_ops[offset+i].handle,
> >   				 map->kunmap_ops[offset+i].status);
> >   			map->kunmap_ops[offset+i].handle =3D INVALID_GRANT_HANDLE;
> >   		}
> >   	}
> > -	return err;
> >   }
> > -static int unmap_grant_pages(struct gntdev_grant_map *map, int offset,
> > -			     int pages)
> > +static void __unmap_grant_pages(struct gntdev_grant_map *map, int offs=
et,
> > +			       int pages)
> > +{
> > +	if (map->notify.flags & UNMAP_NOTIFY_CLEAR_BYTE) {
> > +		int pgno =3D (map->notify.addr >> PAGE_SHIFT);
> > +
> > +		if (pgno >=3D offset && pgno < offset + pages) {
> > +			/* No need for kmap, pages are in lowmem */
> > +			uint8_t *tmp =3D pfn_to_kaddr(page_to_pfn(map->pages[pgno]));
> > +
> > +			tmp[map->notify.addr & (PAGE_SIZE-1)] =3D 0;
> > +			map->notify.flags &=3D ~UNMAP_NOTIFY_CLEAR_BYTE;
> > +		}
> > +	}
> > +
> > +	map->unmap_data.unmap_ops =3D map->unmap_ops + offset;
> > +	map->unmap_data.kunmap_ops =3D use_ptemod ? map->kunmap_ops + offset =
: NULL;
> > +	map->unmap_data.pages =3D map->pages + offset;
> > +	map->unmap_data.count =3D pages;
> > +	map->unmap_data.done =3D __unmap_grant_pages_done;
> > +	map->unmap_data.data =3D map;
>=20
> I think you need to call refcount_inc(&map->users) here and do the related
> gntdev_put_map() call in __unmap_grant_pages_done(). Otherwise you are ri=
sking
> to have map freed before the async operation has finished.

Whoops, good catch.  Will fix in v2.

> > +
> > +	gnttab_unmap_refs_async(&map->unmap_data);
> > +}
> > +
> > +static void unmap_grant_pages(struct gntdev_grant_map *map, int offset,
> > +			      int pages)
> >   {
> > -	int range, err =3D 0;
> > +	int range;
> >   	pr_debug("unmap %d+%d [%d+%d]\n", map->index, map->count, offset, pa=
ges);
> >   	/* It is possible the requested range will have a "hole" where we
> >   	 * already unmapped some of the grants. Only unmap valid ranges.
> >   	 */
> > -	while (pages && !err) {
> > +	while (pages) {
> >   		while (pages &&
> >   		       map->unmap_ops[offset].handle =3D=3D INVALID_GRANT_HANDLE) {
> >   			offset++;
> > @@ -416,12 +420,10 @@ static int unmap_grant_pages(struct gntdev_grant_=
map *map, int offset,
> >   				break;
> >   			range++;
> >   		}
> > -		err =3D __unmap_grant_pages(map, offset, range);
> > +		__unmap_grant_pages(map, offset, range);
> >   		offset +=3D range;
> >   		pages -=3D range;
> >   	}
> > -
> > -	return err;
> >   }
> >   /* ------------------------------------------------------------------=
 */
> > @@ -473,7 +475,6 @@ static bool gntdev_invalidate(struct mmu_interval_n=
otifier *mn,
> >   	struct gntdev_grant_map *map =3D
> >   		container_of(mn, struct gntdev_grant_map, notifier);
> >   	unsigned long mstart, mend;
> > -	int err;
> >   	if (!mmu_notifier_range_blockable(range))
> >   		return false;
> > @@ -494,10 +495,9 @@ static bool gntdev_invalidate(struct mmu_interval_=
notifier *mn,
> >   			map->index, map->count,
> >   			map->vma->vm_start, map->vma->vm_end,
> >   			range->start, range->end, mstart, mend);
> > -	err =3D unmap_grant_pages(map,
> > +	unmap_grant_pages(map,
> >   				(mstart - map->vma->vm_start) >> PAGE_SHIFT,
> >   				(mend - mstart) >> PAGE_SHIFT);
> > -	WARN_ON(err);
> >   	return true;
> >   }
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--tH1jpdVHmorgFwLg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmKObHMACgkQsoi1X/+c
IsELJhAAuIAx7uIeEyQhBZBAzwtSmYh5IdUkfopnk1jPiGmuJPbj5010dCgT98/G
k7+U58vCM6YhJRvTQxBF4BU3UCMJ8/Zgtp9DgUAk86tq8eR//sg8TM367N0EzISi
mFN2mZTShVwxQa/aL5y9GazQd9x2afoWNhb5+0ygHpnbL+Ik+iFf0G4etjFKcnU4
EBnQXxBrVSMoYauyNxYdTHpVJmAr89+xvFcuhFxPX0RatzoIBk76NydBguBVSkIK
K7apSkRx12sOVN7rJmm7gVw3xA9YaEZGsLaXH414cuMgl2rZmekpYx3VsXD+XtBO
snUZcFuRWwHbjSEBJBpYhicqdPXZXTqZVd0yNpjaZ89Nt5HAECyJum4mddRA2h4H
VFcLzwkyG3JgWd8QX0aP7QxhHxWDuGATBJDQGKo5/7BxwB7HMO2jHYEioLUhlvRx
Gfjpx7Jmz29xwfYjr/KNm405LtazRWFtXSD2r/uw0E0e69UCc7LrrjAI4Sgw1u11
n0Rsf63IOL7HatEPklfEpO9nKRJAPb35JRpUMXc8I2sOleVkXekX1MhhP/t4bzxw
bH2/uVczKGWh6u+7OTAxhv+Al//Gj898j7BL4VVN9T0IqbD1vFYeVo+OooJBn0rj
tPs58kNVGs+fkh3K4x/kKRR/l+4AblzKtyTmW1TAqdDgWDJQY9U=
=7NB2
-----END PGP SIGNATURE-----

--tH1jpdVHmorgFwLg--
