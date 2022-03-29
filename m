Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3054EB510
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 23:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbiC2VM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 17:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbiC2VM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 17:12:57 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D627522F;
        Tue, 29 Mar 2022 14:11:10 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KSj0R6zgHz4xMW;
        Wed, 30 Mar 2022 08:11:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1648588264;
        bh=1Nc2RkEcQOeDjzDUY7/xY8ML0T2ks4OpiKgL3VVN9N8=;
        h=Date:From:To:Cc:Subject:From;
        b=neFkzFWsRTLN3REES2VTb0ywd5Y5QxCsvH+q8PXEND/FxO76DYKll7uM/qrgtCDLI
         said9PwQk5vU5APMhPSoDdvxZ++jBBeSE+Y5MTQaFesI97xyLcpSyzLdiO5o3Mv+cw
         xa640BUQsJmHq9mpmeud2F8t0WtiDpULkBiKniyJglZDYAruF7ei+m59qlpYksJD6d
         rbvOXyvVieiZcFFbbfc+oPBficqps5/sgygLCejPRafKkBQfdTv2bBYrcnFObwZWru
         pe+9fIRNgcvlk4v5VgGINZ4d5l6wiO9yFNf7je9scstqXBa+trYIsbnVYdAicEXbpU
         iFxVm0FFSACnA==
Date:   Wed, 30 Mar 2022 08:11:02 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Chris Leech <cleech@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the block tree
Message-ID: <20220330081102.1adb284c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ZWh8+u/w_It_LRO7a6.25Jh";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ZWh8+u/w_It_LRO7a6.25Jh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  d6d6742772d7 ("nvme: fix RCU hole that allowed for endless looping in mul=
tipath round robin")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/ZWh8+u/w_It_LRO7a6.25Jh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJDdeYACgkQAVBC80lX
0GxEaggAmxPHYaZ6YcSnazVJFLylk/hvLIjtkfRYiZVJlhne4fSWFTMdxNhB3dw4
YjMc9yEVovrjtPWvatI95M2v1iOhVl9/gY6dRE9fp7e7elg1NYb3nCSL/IdnDyKi
jBUny4fzOckZxnJYfd2mOqgUue5x6XziCQpJgkfis/rs0Sps5U7v6ZXHBGtCYNlD
lmmGqjnu3y9o/WJyNZE26QA1GA3fwiBLSZg7HKpCsXYTDuwGUOAROpDKwxNs5zRr
/+5iEXaZIk8ythBQtPXZPN2TLbWqagosnlNhel3bb+GZ/yFVFkdDT0jqmZn8Xxu+
vK0DFZGtDJX6mv5NmBgPMQKZXCv2UQ==
=Vj9u
-----END PGP SIGNATURE-----

--Sig_/ZWh8+u/w_It_LRO7a6.25Jh--
