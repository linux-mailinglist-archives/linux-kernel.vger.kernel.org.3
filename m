Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B34E51F1F1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 00:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233365AbiEHWa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 18:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbiEHWaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 18:30:22 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D6462E7;
        Sun,  8 May 2022 15:26:29 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KxJmw61bnz4xXk;
        Mon,  9 May 2022 08:26:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1652048785;
        bh=nRowzYtIsfB8xM8z2R02BWcz+5FWml3cD8TGiBF1ptA=;
        h=Date:From:To:Cc:Subject:From;
        b=g620KZAs0t/OlkebsL2AUKy2lWp/zIheZoDJSPZu0UUIvOXvv3wwny7vg8/IUydVE
         FIB4vsP0rcNCty8HuNgNB1Tf+51gJRAHuc6J2GgxVyTHFGt0EjmQRn3w6r2AYmHTW0
         k8TH+JxPOMtmVSUTWXb89edJ9kh75ZGk8WuSEhmR/OGRdWEfA6K1vxfYEdcVf51Qeg
         hlDKeM5+eY3qEHQiLC9onsNOBp71C65ZqzWgQvGc5cwNsPr2QJIdDAYQgF+JPuHLEp
         8bhE+ENAmQK4dUAdHXZk9tgbb/n0+Xm6OKOXmGir8yZcxeljxY67J3zKgZeQLAxkMM
         Hq7AhahukCUzA==
Date:   Mon, 9 May 2022 08:26:23 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the v4l-dvb-next tree
Message-ID: <20220509082623.37c008f9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/g=3JoUxs1/ym4i0tYH/l9Uz";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/g=3JoUxs1/ym4i0tYH/l9Uz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  18a9b21f7a9d ("media: uvcvideo: Fix memory leak if uvc_ctrl_add_mapping f=
ails")

Fixes tag

  Fixes: 07adedb5c606 ("media: uvcvideo: Use control names from framework")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: 70fa906d6fce ("media: uvcvideo: Use control names from framework")

--=20
Cheers,
Stephen Rothwell

--Sig_/g=3JoUxs1/ym4i0tYH/l9Uz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJ4Q48ACgkQAVBC80lX
0GxQ5Qf/WtnQkmp4NpGM7KOWN6POwUVCzCR26zEpfe09yA/L0wN3EuU4Y7fHWhs8
4Y8HeDpTKCqBTTFP8swhNKQeqxay10SlkKEiFk+aZ+TTBDaBwr5BSu9IvHjv3ddh
FmT4NxuQdSiaeX4gobPX+czr0YNVwOPt3Lu4P4SZYxOSQO7NGqlYgWwZ3wtMtU6t
pcfeojoNiAuK5wP/lNfUcO+1M90toY8nKm28qaFL17fThuwXS1xYKxkVbICcDqJF
3udeqBp8YAHpm55a7bqRiUcNS7Sq9BNabKPO/DZR58/hFWmXAD2DGu9BsnLzuB/G
qLEiFpWMV24tFSsqv0NHSDWK9s0BDA==
=P7Io
-----END PGP SIGNATURE-----

--Sig_/g=3JoUxs1/ym4i0tYH/l9Uz--
