Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258AC51BCDB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 12:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350138AbiEEKNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 06:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiEEKNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 06:13:48 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C669F49921;
        Thu,  5 May 2022 03:10:08 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Kv8Zl18dLz4ySm;
        Thu,  5 May 2022 20:10:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1651745407;
        bh=pQjCYyrFKi4aTFqrqMNEu9e4Y3X4LuYFm0xdp8T/v/o=;
        h=Date:From:To:Cc:Subject:From;
        b=bOAQUZOn7Gvr20YMToIZ7WkXxw/fg1XoZ26scHrS/H7HCa3GVDMZtxMXZ2dmx4uQ2
         /qn+pQFa3QAWOabpGy3bKfRkjVqbzxqUUBvRCQB2o5Ul9Zj9zsCj7XORQHoBV5Ntxi
         dmwzdN3+pXHqpYNfVm4NFlGyCU8H/tpHnXHFMCLw3Iqd20laZZTel67GrPUpsTA9ry
         3D8dxsb1xqqdEa/91LmwlioIVW+I6tRj62ZiWiXAjxY7Wf96O5sZy3fNddSC9TzG2r
         u3t9qOydrReKNjp1qMdhFh1VgzYxDneRS1JwnExSHSIvk2TUUmZQicPaf1a2p0UqJ3
         sXS5VyKOsmr0w==
Date:   Thu, 5 May 2022 20:10:05 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christoffer Dall <cdall@cs.columbia.edu>,
        Marc Zyngier <maz@kernel.org>
Cc:     Oliver Upton <oupton@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the kvm-arm tree
Message-ID: <20220505201005.7ab164c0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Va4j0WMpB8949col8bOV5m_";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Va4j0WMpB8949col8bOV5m_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the kvm-arm tree, today's linux-next build (htmldocs)
failed like this:

Sphinx parallel build error:
docutils.utils.SystemMessage: /home/sfr/next/next/Documentation/virt/kvm/ap=
i.rst:6175: (SEVERE/4) Title level inconsistent:

For arm/arm64:
^^^^^^^^^^^^^^

Caused by commit

  bfbab4456877 ("KVM: arm64: Implement PSCI SYSTEM_SUSPEND")

I have applied the following patch for today (I don't  know if it is
correct, but it does build).

--=20
Cheers,
Stephen Rothwell

--Sig_/Va4j0WMpB8949col8bOV5m_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJzon0ACgkQAVBC80lX
0GyVnQgAjbKexSUi5f5yf/pPzNPy0kAxhFTDU5pjqd1PLMo80BJOYearPVLj/9TE
3bpnhpbm3MDshParqDs2Po8fTsyIpDdK3bgNDPmOdwIi1GYDJJa44q/GAyKqFOOX
7p+fSkX3yGI1Fr45F1vpbPHmeRSvJINysybJJSNO/HOFSbD21zVWHOLA9T/Fkil+
McCFlEi2/UKQ2YIARoyb0tjgOAVbVRYdOJ9qEjwNFrjIX3Tv65f66qE8MQOBXoXn
ecg33BxzD/4WjibK+R3ILceaPqXUP/OcCj0OH4L6RlmxShZ/AD2XGSffCRUECJdn
oz7aM3mQEnoC0dZkL3v74sgVQwlzEQ==
=sf8b
-----END PGP SIGNATURE-----

--Sig_/Va4j0WMpB8949col8bOV5m_--
