Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2F4570055
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 13:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbiGKLZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 07:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiGKLZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:25:02 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC0D9D524;
        Mon, 11 Jul 2022 03:56:01 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LhLQl11NXz4xD9;
        Mon, 11 Jul 2022 20:55:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1657536959;
        bh=U/KYNMY+7+7To8WFTCWm5uU7LB27krSvLn/u4CKUVjc=;
        h=Date:From:To:Cc:Subject:From;
        b=OzS6MTHB8GFG1yBEVKJIOsA6JPpoUcB+9astOxj9LlJzPaGEK72e84CAEJXa6hum+
         Fwq5mIX73wM/MdCAPbKVZMYh22sR1wp69W9zVIE0/2enQsRPttO5mDzgIZJBWXjW5v
         qnVKh4Un36J6xbZBzdAfKHyn8sWml60cvr1XiUouDBhE63CI1CqMCVerbHAljyfsdG
         ElUVl9sjIykNDe1UMmcUQ/bwxxlrTHHReHnjbnZtp7DhLTv5Do24guWeudQGFcVQOl
         uj6lFuVaFgeYJcCZaQwDQyNzIaUiCcqj/jJRKrFQfTI+5zMezv4z525CtsOYzwsrDh
         /7tLJXnCsjvLw==
Date:   Mon, 11 Jul 2022 20:55:57 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>
Cc:     Matthew Rosato <mjrosato@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the kvms390 tree
Message-ID: <20220711205557.183c3b14@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_//y.urvOQWaMAJ.2mvOZmL_w";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_//y.urvOQWaMAJ.2mvOZmL_w
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the kvms390 tree, today's linux-next build (KCONFIG_NAME)
produced this warning:

Documentation/virt/kvm/api.rst:5959: WARNING: Title underline too short.

4.137 KVM_S390_ZPCI_OP
--------------------

Introduced by commit

  a0c4d1109d6c ("KVM: s390: add KVM_S390_ZPCI_OP to manage guest zPCI devic=
es")

--=20
Cheers,
Stephen Rothwell

--Sig_//y.urvOQWaMAJ.2mvOZmL_w
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLMAb0ACgkQAVBC80lX
0Gzg7gf/WX4aS+xXbKB+6HaB1bMFEhoTYPRwF8YaFOMd9Utp6u0xwfwu6uuAA07l
8Yro1AyxvAQnK7MUzC+qDzlvWqt1l5bcaMMz34KNdM6ihcsH6vNFZpVdPIgqavXG
Pw6b5x0TtduOUccK7bgpQeNctk+ua9dyUS80fKCCMRUHBUdWZcXqpU3qNrProRte
549oKzjaMBsc1g9YCv1OszUEprBoPic7lY5kfTJs6QwjNXgVV5dgm0Tcy1SXROZp
Ywgdox0VTTPD5oMgnXeY/UOKFK4XnnFdj+9hcvmhH1cMOpYfWMCW03GiYIuj4tMA
/lJGxhEwiwWwwRgW5YFtifaij87a4A==
=Kg9q
-----END PGP SIGNATURE-----

--Sig_//y.urvOQWaMAJ.2mvOZmL_w--
