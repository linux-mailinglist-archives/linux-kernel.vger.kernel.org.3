Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 918EA4B3E1D
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 23:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbiBMWev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 17:34:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238806AbiBMWen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 17:34:43 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D424C54BEA;
        Sun, 13 Feb 2022 14:34:35 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Jxhx54h6wz4xPv;
        Mon, 14 Feb 2022 09:34:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1644791674;
        bh=Fzp0Snyfy1af5RISLbgpyuTezJCiVACgsz03n49CR78=;
        h=Date:From:To:Cc:Subject:From;
        b=WXeGoFeTDBFH2p5I0yapHetgbyPmYCf/ItKC1f8NUCd0GqvPh43wDxgsVca/0F14m
         jnCSMJgYAGn3bHQJrMk6ql4R+cJ9XCY2Mu/ZJAKosInWXWB7E4WibfZBAl4u1Y5vSV
         8h1AOjwtjNLuvolg/tCDYVmLkjl0W5D3uROA1c1Ta32qaxackIL24nk0aQg4kSUham
         FblyGpUnZJ0ka+thmCLC3dzyRwykWjZ3Bvg0OxrFQuNY+6NqWzmpWcb9IWcNVXBekN
         bWfl9KlwySxFdlL1PJRqShSLWVBlwpLZTBOKWHhKcHmqe+/0v0fK8ohiNX6SUhTDU6
         T8cVfU/7ZWhVQ==
Date:   Mon, 14 Feb 2022 09:34:32 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andy Gross <agross@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>
Subject: linux-next: manual merge of the qcom tree with the imx-mxs tree
Message-ID: <20220214093432.31152d57@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Shyzc86i.7CwIowhtJ1D0+N";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Shyzc86i.7CwIowhtJ1D0+N
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the qcom tree got a conflict in:

  arch/arm64/configs/defconfig

between commits:

  6e3807935e18 ("arm64: defconfig: re-order default configuration")
  dde8cd786e37 ("arm64: defconfig: rebuild default configuration")

from the imx-mxs tree and commits:

  cd7ce3e18afa ("arm64: defconfig: Enable SM8250 video clock controller")
  17ef0b4b441f ("arm64: defconfig: enable mcp251xfd driver")

from the qcom tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/arm64/configs/defconfig
index 2bb7765e5d82,bbe40f0fd620..000000000000
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@@ -383,9 -383,11 +385,12 @@@ CONFIG_ATH10K=3D
  CONFIG_ATH10K_PCI=3Dm
  CONFIG_ATH10K_SNOC=3Dm
  CONFIG_WCN36XX=3Dm
+ CONFIG_ATH11K=3Dm
+ CONFIG_ATH11K_AHB=3Dm
+ CONFIG_ATH11K_PCI=3Dm
  CONFIG_BRCMFMAC=3Dm
  CONFIG_MWIFIEX=3Dm
 +CONFIG_MWIFIEX_SDIO=3Dm
  CONFIG_MWIFIEX_PCIE=3Dm
  CONFIG_WL18XX=3Dm
  CONFIG_WLCORE_SDIO=3Dm
@@@ -602,9 -607,9 +608,10 @@@ CONFIG_IMX_SC_WDT=3D
  CONFIG_QCOM_WDT=3Dm
  CONFIG_MESON_GXBB_WATCHDOG=3Dm
  CONFIG_MESON_WATCHDOG=3Dm
 +CONFIG_ARM_SMC_WATCHDOG=3Dy
  CONFIG_RENESAS_WDT=3Dy
  CONFIG_UNIPHIER_WATCHDOG=3Dy
+ CONFIG_PM8916_WATCHDOG=3Dm
  CONFIG_BCM2835_WDT=3Dy
  CONFIG_MFD_ALTERA_SYSMGR=3Dy
  CONFIG_MFD_BD9571MWV=3Dy
@@@ -1009,6 -1021,10 +1016,7 @@@ CONFIG_SDM_DISPCC_845=3D
  CONFIG_SM_GCC_8350=3Dy
  CONFIG_SM_GPUCC_8150=3Dy
  CONFIG_SM_GPUCC_8250=3Dy
 -CONFIG_SM_DISPCC_8250=3Dy
+ CONFIG_SM_VIDEOCC_8250=3Dy
  CONFIG_QCOM_HFPLL=3Dy
  CONFIG_CLK_GFM_LPASS_SM8250=3Dm
  CONFIG_CLK_RCAR_USB2_CLOCK_SEL=3Dy
@@@ -1042,11 -1058,10 +1050,12 @@@ CONFIG_RASPBERRYPI_POWER=3D
  CONFIG_FSL_DPAA=3Dy
  CONFIG_FSL_MC_DPIO=3Dy
  CONFIG_FSL_RCPM=3Dy
 +CONFIG_MTK_DEVAPC=3Dm
  CONFIG_MTK_PMIC_WRAP=3Dy
+ CONFIG_MAILBOX=3Dy
  CONFIG_QCOM_AOSS_QMP=3Dy
  CONFIG_QCOM_COMMAND_DB=3Dy
 +CONFIG_QCOM_CPR=3Dy
  CONFIG_QCOM_GENI_SE=3Dy
  CONFIG_QCOM_RMTFS_MEM=3Dm
  CONFIG_QCOM_RPMH=3Dy

--Sig_/Shyzc86i.7CwIowhtJ1D0+N
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIJh3gACgkQAVBC80lX
0Gz8wAf/evIEps2mKlyoMmqIidj+kR3rgR8pW5JfTB6jxxWrq6EVlcOCeooIaymX
yz8TID/uJFyFVwCUTsEyBD4kd0rgNdzw0RkKN6Yhk4utUUiXIeAbHrnVHLSr4gtj
zmteHtRZz8fFAe2RreR3mc3QnSGPv4tFvcm0To3+hXl3XgVEQkYkDo1X30byu8sA
HUzdQBaQZS/DRoWJq741mtNY83vE2BH+9qLYdW3FGT1i2K5f3zIpDul2gZMj7IiT
XI3WbvHISQDuODr2oxo1eE4sMESfj0utauGLn6UZSGKVf3Z5osIT/7FP+6eg3otw
A8nLSz2j7EZ2MaHHHvzN4N27yE+wnw==
=+U69
-----END PGP SIGNATURE-----

--Sig_/Shyzc86i.7CwIowhtJ1D0+N--
