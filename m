Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40507535736
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 02:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbiE0AuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 20:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbiE0AuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 20:50:10 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE09E5287;
        Thu, 26 May 2022 17:50:09 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L8R6P0hHZz4xDK;
        Fri, 27 May 2022 10:50:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1653612605;
        bh=6OKsQwubDd4Th9ZVB0QUsCkySIFZVgivSJg7yv4p6NY=;
        h=Date:From:To:Cc:Subject:From;
        b=pWoYbU2BvN7SDgrvmSDJGFXaETSO7SfBnPAifT58T0SxO4Ec52hCzbtz1YowkxpQm
         CjAZi1daYDfQNRqmLSGwLCskum99AKpyVHOfL30xH5HBerO8MbGllM/8h4TPHHVZD+
         9koZBmdB8NqsRUUa0lS0f9eYcUUtRvDVHx/Kl349n9MALV3g03jj5PGBFZWJiJ+g5I
         gBrAuqrSwtwq/HLtTyUNm3fLZzf52dEAz8oHzVhb7H2xr4kzfxHFU5QPP6lT7PhatJ
         7JFQHrthSBy7RB7GdizOiR15URXVcvA0rjnaSL4hRxgvkcWIR0ao5FFOaxgu7/yXyK
         T7bdQjEobrtnw==
Date:   Fri, 27 May 2022 10:50:03 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Leo Li <leoyang.li@nxp.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: please clean up the soc-fsl tree
Message-ID: <20220527105003.1392a238@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/39rztP6qs1ZOa0t9Re4a3bS";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/39rztP6qs1ZOa0t9Re4a3bS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The soc-fsl tree has not been updated since early January, and all its
changess appear to be upstream (though as different commits), so please
clean it up as it has started causing conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/39rztP6qs1ZOa0t9Re4a3bS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKQIDsACgkQAVBC80lX
0GyrjAf/ayvjtTqwwQeg2RcqamVSzaUO9c6DuX4OYcuQvBPMGN20knsEbirU3iry
ylp/qDNfYtA15H0iKsSW2LRDWGTrcdkI3IlZQNn1pScNih7rfYKoUvOa11vfqtqw
us+FBOHd4y6j5JiS3yJT0MmCYBhixaswav/viK7brMjUV5soQmN1M2aIkaGvvZPF
tn3IoBXOQxU7cOn/pu5o7lQSbkx3LxP8SB0t6MVyotBfe+A/fe9K03new6HzlWoE
0VoROvlhXV7X0e/IS8Gn83NN4buvobd8gq/qNWdCY2lK8y0BcSRdQfJ54JzzAtrt
H8WcLhwxvI+BPQhIzzdwjORKDIpCow==
=KIcl
-----END PGP SIGNATURE-----

--Sig_/39rztP6qs1ZOa0t9Re4a3bS--
