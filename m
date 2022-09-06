Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBEA35AE43F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 11:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239359AbiIFJ3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 05:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239292AbiIFJ30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 05:29:26 -0400
X-Greylist: delayed 439 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 06 Sep 2022 02:29:22 PDT
Received: from mx1.emlix.com (mx1.emlix.com [136.243.223.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CBD21E;
        Tue,  6 Sep 2022 02:29:22 -0700 (PDT)
Received: from mailer.emlix.com (unknown [81.20.119.6])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id 1B01E5FB05;
        Tue,  6 Sep 2022 11:22:02 +0200 (CEST)
From:   Rolf Eike Beer <eb@emlix.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Steven Price <steven.price@arm.com>
Subject: Re: linux-next: manual merge of the mm tree with Linus' tree
Date:   Tue, 06 Sep 2022 11:21:56 +0200
Message-ID: <1697463.OzeqPvCt3f@mobilepool36.emlix.com>
In-Reply-To: <20220906190141.028ea19a@canb.auug.org.au>
References: <20220906190141.028ea19a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart17688512.O1j82dVNQg"; micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart17688512.O1j82dVNQg
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Rolf Eike Beer <eb@emlix.com>
Subject: Re: linux-next: manual merge of the mm tree with Linus' tree
Date: Tue, 06 Sep 2022 11:21:56 +0200
Message-ID: <1697463.OzeqPvCt3f@mobilepool36.emlix.com>
In-Reply-To: <20220906190141.028ea19a@canb.auug.org.au>
References: <20220906190141.028ea19a@canb.auug.org.au>
MIME-Version: 1.0

Am Dienstag, 6. September 2022, 11:01:41 CEST schrieb Stephen Rothwell:
> Hi all,
> 
> Today's linux-next merge of the mm tree got a conflict in:
> 
>   mm/pagewalk.c
> 
> between commit:
> 
>   8782fb61cc84 ("mm: pagewalk: Fix race between unmap and page walker")
> 
> from Linus' tree and commits:
> 
>   fa02fb928200 ("mm: pagewalk: make error checks more obvious")
>   66c217081bd0 ("mm: pagewalk: allow walk_page_range_novma() without mm")
> 
> from the mm tree.
> 
> I fixed it up (I think - see below) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

Andrew,

please drop all my patches except the following 2 from your queue for now:

-mm: pagewalk: fix documentation of PTE hole handling
-mm: pagewalk: add api documentation for walk_page_range_novma()

Some of these patches are clearly outdated now with 
8782fb61cc848364e1e1599d76d3c9dd58a1cc06 being included. I'll review them in 
detail eventually and resubmit what is still relevant.

Regards,

Eike
--nextPart17688512.O1j82dVNQg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iLMEAAEIAB0WIQQ/Uctzh31xzAxFCLur5FH7Xu2t/AUCYxcRNAAKCRCr5FH7Xu2t
/IRdA/wOKgkuuUhb8NObay0gGGsA6yE3ewYcmMO3g0KJ2GYonYuqtMvUQetW5KiK
hxsfkPAn6MdEf2Bxo97798KH9xXi0hL16d04Sxbh2LQAERJvU96Lgnm/AD5X35QD
ZtE4S6MlVXTTiaZqDRD7M8ABNmJvqf72js+G1f7UNy/bBH5V2w==
=5lQP
-----END PGP SIGNATURE-----

--nextPart17688512.O1j82dVNQg--



