Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 727F35927E0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 04:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbiHOCu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 22:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232915AbiHOCuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 22:50:23 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB62B60;
        Sun, 14 Aug 2022 19:50:22 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4M5f0D3yr7z4x1V;
        Mon, 15 Aug 2022 12:50:20 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1660531820;
        bh=vOhiXzqBfOmR7g4Mf/Cu4wIfgONUWNBZryBJGgBbSTQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Xke5Y+Y6RI+UBEBI4MYEZfmJwjqS6nu+8FbF0t6sFX8OVvd3xFGzOPJkrVR39J9nb
         gn5TZg/jV/9SfRIySgODLHYQXhLZp/WWGAEbMzmIS+nux4NobykkYTtUtD6MB9a21y
         hAeCInPdn0CyRfrfiC/Npyo7WzXHdiF4Xd0nsial+tlDpBcop5Kyq93gA2OlfQBHPX
         qbcQqAZ43g6rneu+0vXS9LBZR7SolykwuC0mTuSrLnNb0WkwNnB7ETxYpw9G7o0YbV
         lISR2VqsIhQeENsopSZSUjb2ELT+NXG3CfrYFynmxEPWXnn2jbVakrb5+ZOsPCwlzl
         gU8n6mBRO1mBg==
Date:   Mon, 15 Aug 2022 12:50:19 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: stats (Was: Linux 6.0-rc1)
Message-ID: <20220815125019.4a307a44@canb.auug.org.au>
In-Reply-To: <CAHk-=wgRFjPHV-Y_eKP9wQMLFDgG+dEUHiv5wC17OQHsG5z7BA@mail.gmail.com>
References: <CAHk-=wgRFjPHV-Y_eKP9wQMLFDgG+dEUHiv5wC17OQHsG5z7BA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/NcWLchgtKMbD_x4vPVLwaah";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/NcWLchgtKMbD_x4vPVLwaah
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

As usual, the executive friendly graph is at
http://neuling.org/linux-next-size.html :-)

(No merge commits counted, next-20220802 was the first linux-next after
the merge window opened.)

Commits in v6.0-rc1 (relative to v5.19):           13543
Commits in next-20220802:                          13109
Commits with the same SHA1:                        12468
Commits with the same patch_id:                      309 (1)
Commits with the same subject line:                   12 (1)

(1) not counting those in the lines above.

So commits in -rc1 that were in next-20220802:     12789 94%

Some breakdown of the list of extra commits (relative to next-20220802)
in -rc1:

Top ten first word of commit summary:

     95 perf
     33 dt-bindings
     30 tools
     25 net
     24 kvm
     23 virtio_ring
     19 riscv
     19 cxl
     19 ceph
     18 bpf

Top ten authors:

     43 xuanzhuo@linux.alibaba.com
     25 irogers@google.com
     17 krzysztof.kozlowski@linaro.org
     15 conor.dooley@microchip.com
     14 leo.yan@linaro.org
     13 xiubli@redhat.com
     13 dan.j.williams@intel.com
     11 zhengjun.xing@linux.intel.com
     11 namhyung@kernel.org
     10 snitzer@kernel.org

Top ten commiters:

    107 acme@redhat.com
     78 mst@redhat.com
     58 kuba@kernel.org
     43 palmer@rivosinc.com
     26 pbonzini@redhat.com
     24 idryomov@gmail.com
     20 dan.j.williams@intel.com
     18 ast@kernel.org
     17 tiwai@suse.de
     17 len.brown@intel.com

There are also 320 commits in next-20220802 that didn't make it into
v6.0-rc1.

Top ten first word of commit summary:

     29 tools
     27 thermal
     22 arm
     20 mm
     20 fs
     15 arm64
     14 soc
     13 dt-bindings
     10 rust
      9 btrfs

Top ten authors:

     29 paulmck@kernel.org
     19 ojeda@kernel.org
     18 zokeefe@google.com
     11 marex@denx.de
     10 daniel.lezcano@linexp.org
      8 windhl@126.com
      8 wedsonaf@google.com
      7 iangelak@fb.com
      7 daniel.lezcano@linaro.org
      7 broonie@kernel.org

Top ten commiters:

     43 daniel.lezcano@linaro.org
     32 ojeda@kernel.org
     32 akpm@linux-foundation.org
     29 paulmck@kernel.org
     18 almaz.alexandrovich@paragon-software.com
     13 geert+renesas@glider.be
     12 alexandre.torgue@foss.st.com
     11 broonie@kernel.org
      9 srinivas.kandagatla@linaro.org
      8 treding@nvidia.com

--=20
Cheers,
Stephen Rothwell

--Sig_/NcWLchgtKMbD_x4vPVLwaah
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmL5tGsACgkQAVBC80lX
0GzjBgf9FRWLsdV1UJC8mmH1HsQ0bVjozA+2L1wB/f8qDJa1hEJFlLE3Lf6dDXGF
rkvjKnqNs01d0YW6PsRLM1WHUAhV4hsUYIjuwzpcNdS4Qx+XRXYGDzIgUpxILe5N
b3YYJCzgIumWi6NchmGKyxaaPcyxF9NUcroIcu9gmU3LAgyTa01FO/ORhBGuf4hm
MVHkQD+Kk7TsIR1mclYgluL36tsOiD+O+ic0kKNgjdsVTWNGkw9cigw8gH6Y8PDM
V4QDVcLMV0PvPEjffX3EDkNtnFnjJj5jumfGJIeZhyXM7MCCNJHAW/YKoDwbzXIe
FHfIB7GY7nTtIb5PYbMeWI2Wm4iNZQ==
=/Jyo
-----END PGP SIGNATURE-----

--Sig_/NcWLchgtKMbD_x4vPVLwaah--
