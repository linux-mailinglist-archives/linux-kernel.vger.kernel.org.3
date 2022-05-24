Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE445532F31
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 18:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239746AbiEXQqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 12:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239744AbiEXQqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 12:46:02 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A710E315
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 09:46:00 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 0A3DC3200063;
        Tue, 24 May 2022 12:45:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 24 May 2022 12:45:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1653410756; x=1653497156; bh=Z8fSYjEyoO
        yGRxhE+YCeBF0cIAtqOwl1QptR41zfw5M=; b=j2AVTIUb880/fsAsaQu2+eNfa9
        z8SBnLwhrZfuMvSLObCZKQAwy/cRatE2JacltIMeeRrSepSiC9+t0T4T0Fp7czWX
        5/gYxi9o+Od3AlUnFVJhwR5XrtpJVfDk8MjNqECgkmtBH0R7TWpvhfLhkpEzYltk
        wCRkSLgy8nLWSxhsSl4B3GccBywZn5U5qJv/pe5SFIr/x7dt67ZUFNV4/J2ZnnA5
        Ykh+vX66SVvCzz8h0jkrDrkDlhlihaKp+tslZx2rVX3nVzFm82QQ8+g8EnlMZEDK
        7BsBKl6by6qOca/xf0ArXYfZtfm8iwyLg++rTnI6sVTXLEfCzSlQg6pwP65g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:message-id:mime-version
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1653410756; x=
        1653497156; bh=Z8fSYjEyoOyGRxhE+YCeBF0cIAtqOwl1QptR41zfw5M=; b=V
        LXNwXJvPqjGmGshDviCRtm8ALWpp1riaUMePmb+2tXQvriq8Ia0ab9QaGOL1xq6+
        CTm7/1m9Mnj9gx4cvGmarm/Ane8X7vJ87006LfX240CxMUOqm/IG3UVYBYg5rRpv
        6LRaHb7W8e6fqhDV2itPZqm7twJNdfMesh63rDaIFB/WRHQyZ7QfMgP51UcWvWLD
        xotywFdOV2HLpu58Ek9iCJXGQMRfcWhgrBnFnYA7ZB/ec4ugnkDGbu4htvbp533o
        R5xcpcrNS78pfc7c3dGJ0m+iKxgT22CHiZeaXvydKz3SD4lzgvRe4lWEedyzvtkL
        GLNkwQMKnw0TjJdycv++Q==
X-ME-Sender: <xms:xAuNYhk7idDNgQQbKxVteUwlWV_aUfVZiicvWFJvTti1NvZ3WlJPGQ>
    <xme:xAuNYs27iIbshY3gWAG6xjPSd28nJcELG27AEszDuITuMbzo6ZuviNAP4v57Mu5q3
    5RvqALt_H2aKj0>
X-ME-Received: <xmr:xAuNYnp8Tv9YcB11SsY188gHLLPrHRcN9riFDpfO2-uVQt-xSYTVuB9wAK-6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrjeefgddutdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkgggtugesghdtreertddtvdenucfhrhhomhepffgvmhhiucfo
    rghrihgvucfqsggvnhhouhhruceouggvmhhisehinhhvihhsihgslhgvthhhihhnghhslh
    grsgdrtghomheqnecuggftrfgrthhtvghrnhepteekvefggeeivdffleehudejveevfeeg
    vdeghfeigfdvgffgudeuueefveeuveefnecuffhomhgrihhnpehgihhthhhusgdrtghomh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeguvghm
    ihesihhnvhhishhisghlvghthhhinhhgshhlrggsrdgtohhm
X-ME-Proxy: <xmx:xAuNYhkInAl2MAVRvvlApRwFUxiaw5GDvT2aUa4wM5T8DZzcoD-x-w>
    <xmx:xAuNYv2sBahVRtqStIuEMJEWYWQfq90zaIHkxpdOrgMdqHt0r-2_Mw>
    <xmx:xAuNYguS-AO9qq3fMJD__QTpMHBGGWY2Nv9O_Q636yiJDsiSE4ncmw>
    <xmx:xAuNYqRi22VZqM3w04n0TCFOE3tnk2kNTMjIl1XVfDt-r24709g_SA>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 May 2022 12:45:55 -0400 (EDT)
Date:   Tue, 24 May 2022 12:45:51 -0400
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Jennifer Herbert <jennifer.herbert@citrix.com>,
        David Vrabel <david.vrabel@citrix.com>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Subject: [PATCH] xen/gntdev: Avoid blocking in unmap_grant_pages()
Message-ID: <Yo0LwmVUDSBZb44K@itl-email>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="iCJBjnzIorPsAmSw"
Content-Disposition: inline
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iCJBjnzIorPsAmSw
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 May 2022 12:45:51 -0400
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Jennifer Herbert <jennifer.herbert@citrix.com>,
	David Vrabel <david.vrabel@citrix.com>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Subject: [PATCH] xen/gntdev: Avoid blocking in unmap_grant_pages()

unmap_grant_pages() currently waits for the pages to no longer be used.
In https://github.com/QubesOS/qubes-issues/issues/7481, this lead to a
deadlock against i915: i915 was waiting for gntdev's MMU notifier to
finish, while gntdev was waiting for i915 to free its pages.  I also
believe this is responsible for various deadlocks I have experienced in
the past.

Avoid these problems by making unmap_grant_pages async.  This requires
making it return void, as any errors will not be available when the
function returns.  Fortunately, the only use of the return value is a
WARN_ON().  Replace this with WARN_ON()s where errors are detected.

Fixes: 745282256c75 ("xen/gntdev: safely unmap grants in case they are stil=
l in use")
Cc: stable@vger.kernel.org
Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
---
 drivers/xen/gntdev-common.h |  4 ++
 drivers/xen/gntdev.c        | 82 ++++++++++++++++++-------------------
 2 files changed, 45 insertions(+), 41 deletions(-)

diff --git a/drivers/xen/gntdev-common.h b/drivers/xen/gntdev-common.h
index 20d7d059dadb..a6e2805ea2ce 100644
--- a/drivers/xen/gntdev-common.h
+++ b/drivers/xen/gntdev-common.h
@@ -16,6 +16,7 @@
 #include <linux/mmu_notifier.h>
 #include <linux/types.h>
 #include <xen/interface/event_channel.h>
+#include <xen/grant_table.h>
=20
 struct gntdev_dmabuf_priv;
=20
@@ -73,6 +74,9 @@ struct gntdev_grant_map {
 	/* Needed to avoid allocation in gnttab_dma_free_pages(). */
 	xen_pfn_t *frames;
 #endif
+
+	/* Needed to avoid allocation in __unmap_grant_pages */
+	struct gntab_unmap_queue_data unmap_data;
 };
=20
 struct gntdev_grant_map *gntdev_alloc_map(struct gntdev_priv *priv, int co=
unt,
diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
index 59ffea800079..670d800e4a89 100644
--- a/drivers/xen/gntdev.c
+++ b/drivers/xen/gntdev.c
@@ -62,8 +62,8 @@ MODULE_PARM_DESC(limit,
=20
 static int use_ptemod;
=20
-static int unmap_grant_pages(struct gntdev_grant_map *map,
-			     int offset, int pages);
+static void unmap_grant_pages(struct gntdev_grant_map *map,
+			      int offset, int pages);
=20
 static struct miscdevice gntdev_miscdev;
=20
@@ -349,61 +349,65 @@ int gntdev_map_grant_pages(struct gntdev_grant_map *m=
ap)
 	return err;
 }
=20
-static int __unmap_grant_pages(struct gntdev_grant_map *map, int offset,
-			       int pages)
+static void __unmap_grant_pages_done(int result,
+		struct gntab_unmap_queue_data *data)
 {
-	int i, err =3D 0;
-	struct gntab_unmap_queue_data unmap_data;
-
-	if (map->notify.flags & UNMAP_NOTIFY_CLEAR_BYTE) {
-		int pgno =3D (map->notify.addr >> PAGE_SHIFT);
-		if (pgno >=3D offset && pgno < offset + pages) {
-			/* No need for kmap, pages are in lowmem */
-			uint8_t *tmp =3D pfn_to_kaddr(page_to_pfn(map->pages[pgno]));
-			tmp[map->notify.addr & (PAGE_SIZE-1)] =3D 0;
-			map->notify.flags &=3D ~UNMAP_NOTIFY_CLEAR_BYTE;
-		}
-	}
-
-	unmap_data.unmap_ops =3D map->unmap_ops + offset;
-	unmap_data.kunmap_ops =3D use_ptemod ? map->kunmap_ops + offset : NULL;
-	unmap_data.pages =3D map->pages + offset;
-	unmap_data.count =3D pages;
-
-	err =3D gnttab_unmap_refs_sync(&unmap_data);
-	if (err)
-		return err;
+	int i;
+	struct gntdev_grant_map *map =3D data->data;
+	int offset =3D data->unmap_ops - map->unmap_ops;
=20
-	for (i =3D 0; i < pages; i++) {
-		if (map->unmap_ops[offset+i].status)
-			err =3D -EINVAL;
+	for (i =3D 0; i < data->count; i++) {
+		WARN_ON(map->unmap_ops[offset+i].status);
 		pr_debug("unmap handle=3D%d st=3D%d\n",
 			map->unmap_ops[offset+i].handle,
 			map->unmap_ops[offset+i].status);
 		map->unmap_ops[offset+i].handle =3D INVALID_GRANT_HANDLE;
 		if (use_ptemod) {
-			if (map->kunmap_ops[offset+i].status)
-				err =3D -EINVAL;
+			WARN_ON(map->kunmap_ops[offset+i].status);
 			pr_debug("kunmap handle=3D%u st=3D%d\n",
 				 map->kunmap_ops[offset+i].handle,
 				 map->kunmap_ops[offset+i].status);
 			map->kunmap_ops[offset+i].handle =3D INVALID_GRANT_HANDLE;
 		}
 	}
-	return err;
 }
=20
-static int unmap_grant_pages(struct gntdev_grant_map *map, int offset,
-			     int pages)
+static void __unmap_grant_pages(struct gntdev_grant_map *map, int offset,
+			       int pages)
+{
+	if (map->notify.flags & UNMAP_NOTIFY_CLEAR_BYTE) {
+		int pgno =3D (map->notify.addr >> PAGE_SHIFT);
+
+		if (pgno >=3D offset && pgno < offset + pages) {
+			/* No need for kmap, pages are in lowmem */
+			uint8_t *tmp =3D pfn_to_kaddr(page_to_pfn(map->pages[pgno]));
+
+			tmp[map->notify.addr & (PAGE_SIZE-1)] =3D 0;
+			map->notify.flags &=3D ~UNMAP_NOTIFY_CLEAR_BYTE;
+		}
+	}
+
+	map->unmap_data.unmap_ops =3D map->unmap_ops + offset;
+	map->unmap_data.kunmap_ops =3D use_ptemod ? map->kunmap_ops + offset : NU=
LL;
+	map->unmap_data.pages =3D map->pages + offset;
+	map->unmap_data.count =3D pages;
+	map->unmap_data.done =3D __unmap_grant_pages_done;
+	map->unmap_data.data =3D map;
+
+	gnttab_unmap_refs_async(&map->unmap_data);
+}
+
+static void unmap_grant_pages(struct gntdev_grant_map *map, int offset,
+			      int pages)
 {
-	int range, err =3D 0;
+	int range;
=20
 	pr_debug("unmap %d+%d [%d+%d]\n", map->index, map->count, offset, pages);
=20
 	/* It is possible the requested range will have a "hole" where we
 	 * already unmapped some of the grants. Only unmap valid ranges.
 	 */
-	while (pages && !err) {
+	while (pages) {
 		while (pages &&
 		       map->unmap_ops[offset].handle =3D=3D INVALID_GRANT_HANDLE) {
 			offset++;
@@ -416,12 +420,10 @@ static int unmap_grant_pages(struct gntdev_grant_map =
*map, int offset,
 				break;
 			range++;
 		}
-		err =3D __unmap_grant_pages(map, offset, range);
+		__unmap_grant_pages(map, offset, range);
 		offset +=3D range;
 		pages -=3D range;
 	}
-
-	return err;
 }
=20
 /* ------------------------------------------------------------------ */
@@ -473,7 +475,6 @@ static bool gntdev_invalidate(struct mmu_interval_notif=
ier *mn,
 	struct gntdev_grant_map *map =3D
 		container_of(mn, struct gntdev_grant_map, notifier);
 	unsigned long mstart, mend;
-	int err;
=20
 	if (!mmu_notifier_range_blockable(range))
 		return false;
@@ -494,10 +495,9 @@ static bool gntdev_invalidate(struct mmu_interval_noti=
fier *mn,
 			map->index, map->count,
 			map->vma->vm_start, map->vma->vm_end,
 			range->start, range->end, mstart, mend);
-	err =3D unmap_grant_pages(map,
+	unmap_grant_pages(map,
 				(mstart - map->vma->vm_start) >> PAGE_SHIFT,
 				(mend - mstart) >> PAGE_SHIFT);
-	WARN_ON(err);
=20
 	return true;
 }
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--iCJBjnzIorPsAmSw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmKNC8MACgkQsoi1X/+c
IsHAJRAAjtDopK0KF9LmKELwrNytKtSheNA1qaQAT4GYCdiQfBh/BUKH+SLULH39
picN4dJb62xrkRQNAuwc3uzObotjRFAOHsvUMKMfrj761fjmm9LfFmIRyVOo2Kny
9VLUB2kPgmphv9NtSHms7XwzINYjipyon0wUIvAmP2CbHyzcTniibIafHPY+jlL4
qB5JI6yjg/B3XXbW5LeVCW7yN9hF1FJpPt1ndhNSytXm/RkUivoRKQ16B3FqNRJx
w1N6PrLfjiSIOIQaS+0JQHak7jWQ89Dit1GPVzOzkvk1DpfiaNK7gttMcADyyDPD
TMoeKq/ozU/IGOyK1PAij/k+6iZBwo4hQdpcYCr8hmj4yJxCVzKsQV+yL/HmehtK
edzbfH7JwF8Z1ap3xugTEr89biFnPy+/VsCha10L/tm/3xh0RtQt+7FId6jBVdi6
G9dKOd7gu4f4BbwFDYEGJuVDYdNTqV9LV7/tkQeit7j2/y4MS9fClQKrFSvN8QoV
iMpGc3RvwZfz9EZE8ABPFKA1fhIRCPk6ebzagLynOQ4Pn65LjjTOZqaFXXUxFEIp
FkrwFARyo7pv14q5CJfDCwyz+hlGHqEHYyc3HxSm2HU21lbNxn9VBzjNZFNcFuvs
Ep4ZBSkl2obWuIG5TcXToIHxuqAo9ufsl6DZPlYFj5GA2ob5cmM=
=FXH8
-----END PGP SIGNATURE-----

--iCJBjnzIorPsAmSw--
