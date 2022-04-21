Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7895096D9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 07:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384452AbiDUF3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 01:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352029AbiDUF3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 01:29:41 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4963F10FDF;
        Wed, 20 Apr 2022 22:26:51 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KkQyG2FQTz4xPw;
        Thu, 21 Apr 2022 15:26:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1650518807;
        bh=obUMvUDcW5ADdNj9AQAgj041C4bh8/ER2ca6uS1LOaw=;
        h=Date:From:To:Cc:Subject:From;
        b=fVV853wMs2Xy+Y0RO4HJwYeWV4o5Ib6PpbVk0ft+7q2KQfI+tfFGAg7ZCcmY109dR
         rOrlYOi14vcMN07D4qCPsmf+jtQ19G5YhxHqUpkI1AsXlobvabXqmNJk3kTdagKi+k
         E0fOpCv0cOYOI0JE9n1ak4zVIpwI5mKVlTs7DZpqrgqLertMCOezmrOf6Z+4DYSgGS
         AEcH5kSeJkly8htquqILrkMXN7hOiua1bIJFcbI5YDbUdPcruuA9AUHG52PKj2vWMn
         pqNJ5aPqZecI00mulZZdzJn9NC1XMpc7Ef5FfUCF9+ZaBXcMQyLAa068QHwYsMRTT8
         ZDzYxiY+iRhww==
Date:   Thu, 21 Apr 2022 15:26:45 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tony Luck <tony.luck@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the driver-core.current
 tree
Message-ID: <20220421152645.3a849198@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/zYTrU5V0_FKwA75GJmtqLXr";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/zYTrU5V0_FKwA75GJmtqLXr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the driver-core.current tree, today's linux-next build
(x86_64 allnoconfig) produced this warning:

drivers/base/topology.c: In function 'topology_is_visible':
drivers/base/topology.c:158:24: warning: unused variable 'dev' [-Wunused-va=
riable]
  158 |         struct device *dev =3D kobj_to_dev(kobj);
      |                        ^~~

Introduced by commit

  aa63a74d4535 ("topology/sysfs: Hide PPIN on systems that do not support i=
t.")

--=20
Cheers,
Stephen Rothwell

--Sig_/zYTrU5V0_FKwA75GJmtqLXr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJg6xUACgkQAVBC80lX
0GwuGQf/exY/1tahtiFpqBCOzh7iATnS4lD/tMzvKIKyTlyFN94l4ekyU2iunlv/
keqy8k6sd0dkODKaQUFkWcscSIgHbppGCmEAYGK9zwyJdZh8XB6L1fowXNB2e/LT
jQbCqpMVX+Pk0rjOteQEtZsh0Krvdy9c9GR6r8h7AOMXCYVi1oL/OIoslHlZmZg3
Wt5ajoJPlh3zUZfsnRx6oFa0rJyMVbHekPHQXYx9rROUIwLDW5K9dIRHGBPqm844
fOM7sCs0bsCUadHU1v9A7T/ZD5nAOC/C3/hjqDmcjfyLCSKpKTRx/m+NV/UO+svB
ymqXREEwIAqeNJp65vHKmvQcCWXiYQ==
=h7KC
-----END PGP SIGNATURE-----

--Sig_/zYTrU5V0_FKwA75GJmtqLXr--
