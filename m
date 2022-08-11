Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66DD958F5BE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 04:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233666AbiHKCK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 22:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233587AbiHKCKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 22:10:54 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B245525286;
        Wed, 10 Aug 2022 19:10:52 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4M39JW1ZK4z4xTx;
        Thu, 11 Aug 2022 12:10:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1660183851;
        bh=3rvXtkxg/SjbFeeDDCWuFa5wU7JjNfgGbCt4+O3rysI=;
        h=Date:From:To:Cc:Subject:From;
        b=nlMLVCxD5OGPafbjzxuIu3UuLKUtKihF5E5f6mmfTuFY8fm9kNOPKW4btR3wJyNLL
         P8JLeopL8qAVnhS4eUmjQvlvmzOtg8PWVWztoK55+7RvYMUZFr+K2KSQmilOySjqLr
         4Kqks3eyrjtqJ/yZGhxF3eNeMyxDMzWO6w4Wl+enzE48zY4W8Bju0pOrYXIsyeBiUc
         SlVIeTq4MolPzIuPDlTiaH23AZoY0DJYS8nUSvnKjmbzcA3l9cgcp8tSuMsSIzWOHY
         dG+wCjjaex72JZzM2itFLOhbxvr20BWCRMwhQlN5Koyrlg02uwlds1jxjQivx3nQGH
         nojUp0xx4oA5Q==
Date:   Thu, 11 Aug 2022 12:10:49 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the amdgpu tree
Message-ID: <20220811121050.0da83776@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/MinjIO9iqeHhmJ=lsNQg_Oz";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/MinjIO9iqeHhmJ=lsNQg_Oz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the amdgpu tree, today's linux-next build (htmldocs)
produced these warnings:

drivers/gpu/drm/amd/display/dc/dc.h:465: warning: Enum value 'MPC_SPLIT_AVO=
ID' not described in enum 'pipe_split_policy'
drivers/gpu/drm/amd/display/dc/dc.h:465: warning: Enum value 'MPC_SPLIT_AVO=
ID_MULT_DISP' not described in enum 'pipe_split_policy'

Introduced by commit

  a2b3b9d57bdb ("drm/amd/display: Document pipe split policy")

--=20
Cheers,
Stephen Rothwell

--Sig_/MinjIO9iqeHhmJ=lsNQg_Oz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmL0ZSoACgkQAVBC80lX
0GybtQf+PSq7cH/HBIsYy00wH0DvZZFTbuQsLwCJrdlmH8TuXrbEnYvfz/gt5ZWT
zC2z1mU1XrBBZUIN5QcdFv5LbApAUEjuiyVPvTMhn01b+qOhssoNqHxKfRsMO1jt
upz3WukLSgUose5f2M7xxKEnkmH3qBXsn0tQUywbOZlSRRwMIkOVz+4n81yctGga
LJUPaKf4QCrsso5IB4X1hCiFkAlPCoFpdtmsZyrv+BR79mx2p1gGMywKwSBAHPKG
JWrYV+QUHJq+6XYKqvq1nvjAuwPmid0Z9vgBCriNlOLxAtlfKCM9W+6daMd+Qeqy
OASH92at0JSCjMStnT0dqPMdTrHR/g==
=EQfT
-----END PGP SIGNATURE-----

--Sig_/MinjIO9iqeHhmJ=lsNQg_Oz--
