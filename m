Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 490AE5168AC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 00:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355746AbiEAWjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 18:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355778AbiEAWix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 18:38:53 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC0F19C32;
        Sun,  1 May 2022 15:35:23 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Ks1JR0T09z4ySV;
        Mon,  2 May 2022 08:35:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1651444519;
        bh=I6PWU7Bb5XXt1zwPzGfD6cV4tmw/FGmxLXRTOvcdR7I=;
        h=Date:From:To:Cc:Subject:From;
        b=FHCrYXwEPx1tBfk65OrM2PE7o0PQ6W7s4J+jqcP89s4GuknXL9TE0BiMA3ZH5ybXS
         mrV3fByVn1a1p4cIn7e/cv1eIeB10TBqVpC6xivYwEH+7btzPP/hHMIYPS4LSfXqkC
         Ow9qZUOu/vzYEdJp+6kfKRPp4Z2aziHKLhC/yubSKOWF3/10zLJ2JgOVH6SvId/4vl
         n7K2Hu8cwzaM77qazUeHqc/V2K+7cSuIptluAOg21zCTId7dGGv28FUIisitBzMkuQ
         79AB+6aGBZUISfugHZD60l0R+ciKbnsCJORmOd08Sh9W4JZRjx+4tuAqP+SaUjmapd
         jmrLuvzBKcHuQ==
Date:   Mon, 2 May 2022 08:35:04 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Rob Clark <robdclark@gmail.com>, Sean Paul <seanpaul@chromium.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the drm-msm tree
Message-ID: <20220502083504.4a31cfdc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/OMen9LlIAkjJuHkgXbkShij";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/OMen9LlIAkjJuHkgXbkShij
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  4845d89f94a3 ("drm/msm: select DRM_DP_AUX_BUS for the AUX bus support")

Fixes tag

  Fixes: 82c59ed16695 ("drm/msm/dp: Add eDP support via aux_bus")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: 0d682843bfee ("drm/msm/dp: Add eDP support via aux_bus")

--=20
Cheers,
Stephen Rothwell

--Sig_/OMen9LlIAkjJuHkgXbkShij
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJvCxgACgkQAVBC80lX
0GwZywf/W6GHRqwng5RzdkaX3lDQH6gLil9biJ6rceu2i3S3Sxnjd4MNe+cmS32O
5yIaMYZ9P+2tALbbB/RePd5+x/LDJQxOe59SDQqS6HPIvlmqcC05wmR5XJcwb++G
jSs4kXyJCruWd53of89x/LE6eY+kN7LJCVmYi/b/EEYKosdWXRwz2rmAYmC3L9Ty
suE/j3mUh9b1bZnknQWvsPlMvl73NM9UqgQUFtX9/XfHy60/kDNxQU2RlVWmY0M2
fOROvfznkgc7va0L2vlrDEka+j/rbOl9Qg/CU1Pjt5jghUexVaUrxO2AZsO4R/VB
JHQSAc5U5LOu6eIHl1pK+Pss+ZmnEg==
=BBak
-----END PGP SIGNATURE-----

--Sig_/OMen9LlIAkjJuHkgXbkShij--
