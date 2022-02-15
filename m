Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B534B7626
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238404AbiBOU11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 15:27:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiBOU1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 15:27:25 -0500
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B92D5F6D
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 12:27:14 -0800 (PST)
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <riel@shelob.surriel.com>)
        id 1nK4Pa-00060c-4r; Tue, 15 Feb 2022 15:26:58 -0500
Message-ID: <3db11c51eeb323c5b81ba29772128109160dc14f.camel@surriel.com>
Subject: Re: [PATCH 1/1] mm: fix use-after-free bug when mm->mmap is reused
 after being freed
From:   Rik van Riel <riel@surriel.com>
To:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc:     mhocko@kernel.org, mhocko@suse.com, shy828301@gmail.com,
        rientjes@google.com, willy@infradead.org, hannes@cmpxchg.org,
        guro@fb.com, minchan@kernel.org, kirill@shutemov.name,
        aarcange@redhat.com, brauner@kernel.org, christian@brauner.io,
        hch@infradead.org, oleg@redhat.com, david@redhat.com,
        jannh@google.com, shakeelb@google.com, luto@kernel.org,
        christian.brauner@ubuntu.com, fweimer@redhat.com, jengelh@inai.de,
        timmurray@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        syzbot+2ccf63a4bd07cf39cab0@syzkaller.appspotmail.com
Date:   Tue, 15 Feb 2022 15:26:57 -0500
In-Reply-To: <20220215201922.1908156-1-surenb@google.com>
References: <20220215201922.1908156-1-surenb@google.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-FmyWs8UEexXTYm9YBNHJ"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Sender: riel@shelob.surriel.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-FmyWs8UEexXTYm9YBNHJ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2022-02-15 at 12:19 -0800, Suren Baghdasaryan wrote:
> After exit_mmap frees all vmas in the mm, mm->mmap needs to be reset,
> otherwise it points to a vma that was freed and when reused leads to
> a use-after-free bug.
>=20
> Reported-by: syzbot+2ccf63a4bd07cf39cab0@syzkaller.appspotmail.com
> Suggested-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>=20
Reviewed-by: Rik van Riel <riel@surriel.com>

--=20
All Rights Reversed.

--=-FmyWs8UEexXTYm9YBNHJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAmIMDJEACgkQznnekoTE
3oMmGwf7BPkOeYgY95xS38+UUl4fHxNFjY4/Pvo6cqwwcm0KCg34H6EWjkJ/DjBx
KmvEc50MmagdnaYNsqwNCkKaEXnTtGMjajn6U95Wr5te6OaPjlv1dn3i+zv1RKIr
UUyv2eznCQm7P3M4RZC795B55zVMwKtJ/fN04V9FHOnYQ9S5aJA1R7TBP4v58A8d
dQxqFAZEEvU4HJCINyR/HGFkRBbhSnHstAKAY6GA6se2cDvCrbhxKeHIaPWgewWs
g1YhRgM2c1ANGmNwAk/nYTfSedODfoSvojnlHvBUsjBJbqPK9KxfvAKX+XjgxBNe
pILGfzCvk/u7dIvpr9ZT761EymjxJQ==
=AgXC
-----END PGP SIGNATURE-----

--=-FmyWs8UEexXTYm9YBNHJ--
