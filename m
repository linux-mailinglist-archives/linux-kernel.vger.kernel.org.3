Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34E159978F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 10:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346568AbiHSIkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 04:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347656AbiHSIkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 04:40:39 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E04B54C92;
        Fri, 19 Aug 2022 01:40:36 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4M8FZS6hrnz4wgr;
        Fri, 19 Aug 2022 18:40:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1660898434;
        bh=uisOxKW0IqlxNEUQLnJRe3FfZBB2ylgQjA49VP1OvrM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=m64tQGfYHHeiflTNxDIBVWx1fuCzvVEv5JrqculF+hMsKLbABD68To21ECRQhLeaj
         jsWcgQY1DWabF/qbwpo0508Fi7vuoHxt47mXieDHF6TtdTNcRB4OK6YMOB/1lwzaC1
         sVT3xPm+KUkQxVqoyFV8t1x+RRoKKi4ye1IBzTfOHC4H76oig9Ic6VnYV+dqfGfyEV
         mEzj8WXUxA4/Yj1qOlXMdVV1zFhPNwLSptJCu0N54pLNDVWAW4HMOAQ7I81zto2nGT
         dlsJPaz13oZ2plx2OznKrRrpR3L7D8enU1x3Vpn4LXZkQCFEEamn6APhqIOOMYp293
         hqXQRYnwMuTJw==
Date:   Fri, 19 Aug 2022 18:40:27 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the char-misc.current tree with the
 mm-hotfixes tree
Message-ID: <20220819184027.7b3fda3e@canb.auug.org.au>
In-Reply-To: <Yv8vZQB25NE0r/uN@kroah.com>
References: <20220819082714.5313827d@canb.auug.org.au>
        <Yv8vZQB25NE0r/uN@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/R80RBNWmf__C1lGbMR.J92d";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/R80RBNWmf__C1lGbMR.J92d
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Fri, 19 Aug 2022 08:36:21 +0200 Greg KH <greg@kroah.com> wrote:
>
> On Fri, Aug 19, 2022 at 08:28:18AM +1000, Stephen Rothwell wrote:
> >=20
> > Today's linux-next merge of the char-misc.current tree got a conflict i=
n:
> >=20
> >   drivers/android/binder_alloc.c
> >=20
> > between commit:
> >=20
> >   b3bb668f3dc6 ("binder_alloc: add missing mmap_lock calls when using t=
he VMA")
> >=20
> > from the mm-hotfixes tree and commit:
> >=20
> >   d6f35446d076 ("binder_alloc: Add missing mmap_lock calls when using t=
he VMA")
> >=20
> > from the char-misc.current tree.
> >=20
> > I fixed it up (I used the latter as it was committed later even though
> > the author times were the same) and can carry the fix as necessary. This
> > is now fixed as far as linux-next is concerned, but any non trivial
> > conflicts should be mentioned to your upstream maintainer when your tree
> > is submitted for merging.  You may also want to consider cooperating
> > with the maintainer of the conflicting tree to minimise any particularly
> > complex conflicts. =20
>=20
> These should be identical, if not, something went wrong :(

Something went wrong :-)

$ git range-diff b3bb668f3dc6^..b3bb668f3dc6 d6f35446d076^..d6f35446d076
1:  b3bb668f3dc6 ! 1:  d6f35446d076 binder_alloc: add missing mmap_lock cal=
ls when using the VMA
    @@ Metadata
     Author: Liam Howlett <liam.howlett@oracle.com>
    =20
      ## Commit message ##
    -    binder_alloc: add missing mmap_lock calls when using the VMA
    +    binder_alloc: Add missing mmap_lock calls when using the VMA
    =20
    -    Take the mmap_read_lock() when using the VMA in binder_alloc_print=
_pages()
    -    and when checking for a VMA in binder_alloc_new_buf_locked().
    +    Take the mmap_read_lock() when using the VMA in
    +    binder_alloc_print_pages() and when checking for a VMA in
    +    binder_alloc_new_buf_locked().
    =20
         It is worth noting binder_alloc_new_buf_locked() drops the VMA rea=
d lock
    -    after it verifies a VMA exists, but may be taken again deeper in t=
he call
    -    stack, if necessary.
    +    after it verifies a VMA exists, but may be taken again deeper in t=
he
    +    call stack, if necessary.
    =20
    -    Link: https://lkml.kernel.org/r/20220810160209.1630707-1-Liam.Howl=
ett@oracle.com
    -    Fixes: a43cfc87caaf ("android: binder: stop saving a pointer to th=
e VMA")
    -    Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
    +    Fixes: a43cfc87caaf (android: binder: stop saving a pointer to the=
 VMA)
    +    Cc: stable <stable@kernel.org>
         Reported-by: Ondrej Mosnacek <omosnace@redhat.com>
    -    Reported-by: <syzbot+a7b60a176ec13cafb793@syzkaller.appspotmail.co=
m>
    -    Acked-by: Carlos Llamas <cmllamas@google.com>
    +    Reported-by: syzbot+a7b60a176ec13cafb793@syzkaller.appspotmail.com
         Tested-by: Ondrej Mosnacek <omosnace@redhat.com>
    -    Cc: Minchan Kim <minchan@kernel.org>
    -    Cc: Christian Brauner (Microsoft) <brauner@kernel.org>
    -    Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    -    Cc: Hridya Valsaraju <hridya@google.com>
    -    Cc: Joel Fernandes <joel@joelfernandes.org>
    -    Cc: Martijn Coenen <maco@android.com>
    -    Cc: Suren Baghdasaryan <surenb@google.com>
    -    Cc: Todd Kjos <tkjos@android.com>
    -    Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
    -    Cc: "Arve Hj=C3=B8nnev=C3=A5g" <arve@android.com>
    -    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    +    Acked-by: Carlos Llamas <cmllamas@google.com>
    +    Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
    +    Link: https://lore.kernel.org/r/20220810160209.1630707-1-Liam.Howl=
ett@oracle.com
    +    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    =20
      ## drivers/android/binder_alloc.c ##
     @@ drivers/android/binder_alloc.c: static struct binder_buffer *binder=
_alloc_new_buf_locked(
    @@ drivers/android/binder_alloc.c: void binder_alloc_print_pages(struct=
 seq_file *m
     -		}
     +
     +	mmap_read_lock(alloc->vma_vm_mm);
    -+	if (binder_alloc_get_vma(alloc) =3D=3D NULL)
    ++	if (binder_alloc_get_vma(alloc) =3D=3D NULL) {
    ++		mmap_read_unlock(alloc->vma_vm_mm);
     +		goto uninitialized;
    + 	}
     +
    ++	mmap_read_unlock(alloc->vma_vm_mm);
     +	for (i =3D 0; i < alloc->buffer_size / PAGE_SIZE; i++) {
     +		page =3D &alloc->pages[i];
     +		if (!page->page_ptr)
    @@ drivers/android/binder_alloc.c: void binder_alloc_print_pages(struct=
 seq_file *m
     +			active++;
     +		else
     +			lru++;
    - 	}
    ++	}
     +
     +uninitialized:
    -+	mmap_read_unlock(alloc->vma_vm_mm);
      	mutex_unlock(&alloc->mutex);
      	seq_printf(m, "  pages: %d:%d:%d\n", active, lru, free);
      	seq_printf(m, "  pages high watermark: %zu\n", alloc->pages_high);

--=20
Cheers,
Stephen Rothwell

--Sig_/R80RBNWmf__C1lGbMR.J92d
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmL/THsACgkQAVBC80lX
0GzlYQf/ZYiupdmRuwv/uusPjCKYlvCSC+B4njyeYZhbU/23go92fAYcLO79l7y9
bWUYYg8b3GMXAgykZDF8LOf5+itjGacVwrdMR7ImY9WDIhFoBJtYAtkxSb8fdv/P
wPRxMHWEcVy5JvF+Unzfy/09uYiEATqwOkhExTNYgcYHfAfu3DWqIZBbJZ1n5cGd
Cpi5tKeto5nkr1c0tRGXcyPuvz6fGnFtMLcwB9iMqTrcFyJuX+VYpuTePp5N2s/+
X8lqvFMLRWhsHjCc0h6CL7Xo4r5P+22OLnVg9tI/a85wr3Dzs8DmffkoXWt1mVBR
uFHuNc+0JMQeOFIoubQFNnegD7158A==
=XhGU
-----END PGP SIGNATURE-----

--Sig_/R80RBNWmf__C1lGbMR.J92d--
