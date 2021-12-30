Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 362D8481B90
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 12:01:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238785AbhL3LBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 06:01:50 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:35060 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235057AbhL3LBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 06:01:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9258C61640
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 11:01:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E9F5C36AE9;
        Thu, 30 Dec 2021 11:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640862109;
        bh=Pc44Jvnm7l081xlRv9tqUnk7gHeOFu+r2QHfzwATaG4=;
        h=Date:From:To:Cc:Subject:From;
        b=aMU0pxrUToaodpio747BP3EG5M3u+3eGWc0O3rC0zNWnyu9qm0eGV5p+BxgJXHiZW
         7J5VOLpTxfwLXpEEtaFuOAbgAhvlHxIwmYFNxZLy8hOtD5V57ZN2wKYtOZactwoJ/L
         YZiyt/k4wzf8cMLeHu241l+eZbLT6iCG4SBMm2XRQnWNjVlqJb4L/oOALuTYQKGCKz
         /OvbT9mM9+wb3Lrr8XBx7OFBy1LUOxa8p1rDrn6yr4hIcJ0hIGyDmY5F4U/lxvS1RF
         hhFdIiubABG4Om+TIY7u486EApkbhISrZu51rCX4+JhwnlN1MVYtO4YN18LovXmpBl
         a4TO5pctqYlvA==
Date:   Thu, 30 Dec 2021 16:31:44 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: soundwire updates for v5.17-rc1
Message-ID: <Yc2RmBlAhj5DWjRZ@matsya>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="byx6gozXPnL5V6iZ"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--byx6gozXPnL5V6iZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Greg,

Here is the last soundwire pull for this year :). Please pull to receive
a single patch for Qualcomm driver

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/so=
undwire-5.17-rc1

for you to fetch changes up to bb349fd2d58062c69508414a9080d822b8d096b5:

  soundwire: qcom: remove redundant version number read (2021-11-23 16:47:3=
7 +0530)

----------------------------------------------------------------
soundwire updates for 5.17-rc1

 - Remove redundant version number read in qcom driver

----------------------------------------------------------------
Srinivas Kandagatla (1):
      soundwire: qcom: remove redundant version number read

 drivers/soundwire/qcom.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

Thanks
--=20
~Vinod

--byx6gozXPnL5V6iZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmHNkZgACgkQfBQHDyUj
g0c+qQ//fG04LfV2/zKctz9h61mw2I+AitlRPop6V1os3gEZz1Jc308EWI5WK/vD
gTRt+l2uIJuX9b7KJ3vrgUPp3luJZrHVVK57UMCV71RwsZLYQhmZZiXWo488ljSz
OJXG8m4GbaMLMGNewnSgbJkThSiSXD+vzk1LYL0p7qo618qV4W//HhmhvhGT4ETl
kKYay0AVUw84g7h9cnQZuBS7KVAXf4hGgl4+/OhKAXB+9UtO8piBpoZZ/xGwkHA2
8TKD4opJwxBpQcF2zKP1hwO2yVOBUPFpn6m24LZ2Zgu5qcM9NLRKFC99yuiR4W6K
J46NZv/ZPnmwKLYh+adqkeXXT5VZN3B/xbc3nPHn4k6yGo3z8kxTqApdTICaItqs
4q56fVj5OTj0E3jopIEzyzTrasylM2aFCGufFYvOCxMVgtkYasXR4f/ZqC92lZR7
OMbiBOrSpCn2mFJdsLZ2NpEU4PpbN1wQISjWR6ELqzs1dwXw2XISOg6pD12Oz7VK
7phWxK2k693DxDkIjDyur+yfcsM+du4o6U5Rg0B7ftxg34SRk2j+Bas/c+9XemE0
rGZQrb8x1HP1P41b8bHA4gmNx1XACfavq42f5XyGx3LkBhPmGuLnXw+H5TXvcqL0
YEsxpWwcXijbuK9o9BJyLOa6Y5pSvPLijpwrPcfPwS6gz4Tpu6w=
=9Egt
-----END PGP SIGNATURE-----

--byx6gozXPnL5V6iZ--
