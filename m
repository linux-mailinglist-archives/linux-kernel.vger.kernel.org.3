Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4D554ED74
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 00:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379026AbiFPWmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 18:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbiFPWmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 18:42:18 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B7562125;
        Thu, 16 Jun 2022 15:42:16 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LPHHB1DCJz4xXh;
        Fri, 17 Jun 2022 08:42:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1655419334;
        bh=rNBaq11Gw+mremeoXxVHFK+tR4/FP1VgkGo5GqRkBtk=;
        h=Date:From:To:Cc:Subject:From;
        b=PoF67ziB4Gc515RY+uBYjG2oCQvKf/nQ8GhQ5OULxiZBt2W/aR2y5xSzufJxoE9RJ
         67+8jlh4V2KADqR5G+Xvkatt7Dt515VSVUal4aSpJt7PdgZn4HivmxBCi5Z//yazKl
         FxGnOuQOyjQPsqTqW8pmgBHFcEWJ1CJRBP+ACdi4kzjYSXK3DdleKIjwj3tnfC/kd9
         UMzuV0wMaiv1Q8gbudf/YxA0KVbgmUw/vKgCieMlzx2D2Mnsb2i6kyjwZtRxX09XLT
         XHszj/LGhn8IqbB0sj8R/0SQK8nz0mfmUAUDwHA+CorVJnOdUS9cHry65gO1307dqF
         JdyIgMNL59wgg==
Date:   Fri, 17 Jun 2022 08:42:12 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the drm-msm-lumag tree
Message-ID: <20220617084212.1bd73556@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/+XmnEXyziQdn8rKRZupmG4y";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/+XmnEXyziQdn8rKRZupmG4y
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  2c00a5337c86 ("drm/msm/dpu: move intf and wb assignment to dpu_encoder_se=
tup_display()")

Fixes tag

  Fixes: e02a559a720f ("make changes to dpu_encoder to support virtual enco=
der")

has these problem(s):

  - Subject does not match target commit subject
    Just use
	git log -1 --format=3D'Fixes: %h ("%s")'

--=20
Cheers,
Stephen Rothwell

--Sig_/+XmnEXyziQdn8rKRZupmG4y
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKrscQACgkQAVBC80lX
0GxGVAf/cl4LBGDEpfJFMcF/NpwiMi2PRFMzLwhZLbCDa7OjGFhw+0HxPfqq/uWQ
yKvhbeTCd0MQ+O/38ohSl5VjfsiyLPF6s/Q9zVbYkQjdoV/RGrXjuxBrJn3Fch+B
q+CRpOtLqrjeXPLEH524wfkbedI4Gs7P+MgDDhjGkRGC68Auk2KyH7BzM/cRrnYk
X5Dwml7fRzSTZexEcXrk809rToMCBVrbqv/vAWXE5YjTBW8Pi/LLuIM6JZZ7aGun
NMiC/Hb2w1NPksVFhlYf2P5ghNeBIfrYBIJc98+p3dt01CJ0jSG9/cFBMQH5hHkZ
X9FxO349hAWdLKu+vyj6cN8EufvcaQ==
=APXl
-----END PGP SIGNATURE-----

--Sig_/+XmnEXyziQdn8rKRZupmG4y--
