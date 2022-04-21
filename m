Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A54985094E8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 04:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383762AbiDUCE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 22:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243566AbiDUCEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 22:04:55 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9173EBF42;
        Wed, 20 Apr 2022 19:02:06 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KkLQ46Y5qz4xXl;
        Thu, 21 Apr 2022 12:02:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1650506525;
        bh=fpuJ7Ozpq47prccPMVSJGx+Z84fuvxEzTAnpoIqh2rI=;
        h=Date:From:To:Cc:Subject:From;
        b=Dd0HJTSWhblQrJWXHTNe43TbjiiDP6Ie7+By3Z81MTstPRF3n57sZRkWtErG1qtom
         RRgK2AbMKJL5EvM9puISfP1w5YBEiFdRqzpPJZGAx98OgEN8J1O5TMHW6UmAf6cpqp
         xfpQxURoEG/wPSnYhzjyxXJfzBjPC9tkxVWVcRMgJKxqui6Fa7mSaC0dOt2uBZhdes
         4Kh5+p5b6KOzqrDtc5De6EDWM/TUtnrS1L2qicZdbbWgdPlPOi5kfyMkGdZGLvqK9E
         gkVdBHRAtytd+vyhLCr1f1tzwG24E/SgidwTZjjzG9pfuP+MYz1ti+xkgGttUwWDdE
         wRPJEYyiTKrlA==
Date:   Thu, 21 Apr 2022 12:02:03 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the block tree
Message-ID: <20220421120203.2102b554@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/3T5VNW4vw7himpMUNTk7vQT";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/3T5VNW4vw7himpMUNTk7vQT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the block tree, today's linux-next build (arm
multi_v7_defconfig) produced this warning:

fs/io_uring.c: In function '__io_sqe_files_unregister':
fs/io_uring.c:8992:13: warning: unused variable 'i' [-Wunused-variable]
 8992 |         int i;
      |             ^

Introduced by commit

  16b217ed7bb3 ("io_uring: store SCM state in io_fixed_file->file_ptr")

--=20
Cheers,
Stephen Rothwell

--Sig_/3T5VNW4vw7himpMUNTk7vQT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJguxsACgkQAVBC80lX
0GwR9ggAj2TSuobLjEmjYeEU+merhU2VRa5mOI5IeRSGSJZEqqZvm6yWZsZ+HDJA
+OlAqZLjwFFxODxhnSSBezsdGEWxvVWGZj7hzrhXWrKEhHmMonAP3eVLReRIU+pu
qLIxD9HcQLaXonGzDNxxL18+45LwX8yhB8PudKFTHa0XziArKBjGcmPpEaXMazZF
lfbPAp8pRVA/m96h+ylndue0YcVNtNt6odn3LkTRMwKBt2qwnaZcZ9ehyNnAp+j8
ppkW8YFORZG6vyzH9eaO0ZUIYpWZVPANq7drB1s6RE/043cVaaRx/mm8HqH0URLE
0kWl5nXL294GjpMf1YSeZX3OpVTU8w==
=kaw1
-----END PGP SIGNATURE-----

--Sig_/3T5VNW4vw7himpMUNTk7vQT--
