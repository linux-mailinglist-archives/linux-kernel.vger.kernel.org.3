Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DEC4524CD3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 14:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353709AbiELM2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 08:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232866AbiELM2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 08:28:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD6D248E3C
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 05:28:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 86F6E61F51
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 12:28:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51AD8C34119;
        Thu, 12 May 2022 12:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652358527;
        bh=n9/65A/EjXtZGwmrrn/Yq2UEgowCAYR4MzdFrhY2Ye4=;
        h=Date:From:To:Cc:Subject:From;
        b=lJwYPXKlndZOO1/fwTyjnaITVZpGY5S1oGUa9tHMC0oyUbSBwVvCmbAtkkSc1JeQU
         1Yk5y2bIEf8IkzL1qgyX51Xjd2S6KDNnATftpJhUjjLey5G0TsWNe6YJlof8kbfW9M
         OuTcsg/IhR6O8sQeaFzhg2w+nSPb4Sru1sdubAXTxrMA8LSzHlizS1+8SEFKY+VLuM
         QOC0qqOD0wJXHrXJ1EjVBx8sS9bPJMwof3NXm0aAvbG5SN5ZSbingbaoR/zraKAn+P
         7YTrY+uX3J1PTo28IfKNbPT+28EiNUDZcIbv0srKUU+E1/xqO5a7k9or0kcNSuavAx
         n738S+FZSn4Fw==
Date:   Thu, 12 May 2022 17:58:43 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: soundwire updates for v5.19
Message-ID: <Ynz9e/Ppp+xbk4Ph@matsya>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ONYpAYSFgdbLxYI9"
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ONYpAYSFgdbLxYI9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Greg,

Please pull to receive soundwire subsystem updates for v5.19-rc1.=20

Minor updates to Intel and Qcom driver and some core changes in
power-management. Patches are already in linux-next.

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/so=
undwire-5.19-rc1

for you to fetch changes up to 74da272400b46f2e898f115d1b1cd60828766919:

  soundwire: qcom: adjust autoenumeration timeout (2022-05-09 12:03:14 +053=
0)

----------------------------------------------------------------
soundwire updates for 5.19-rc1

 - Support for v1.6.0 Qualcomm controllers
 - Bunch of pm updates by Intel for peripheral attachment and system pm
   etc

----------------------------------------------------------------
Dan Carpenter (1):
      soundwire: qcom: fix an error message in swrm_wait_for_frame_gen_enab=
led()

Pierre-Louis Bossart (9):
      soundwire: cadence: recheck device0 attachment after status change
      soundwire: intel: prevent pm_runtime resume prior to system suspend
      soundwire: intel: disable WAKEEN in pm_runtime resume
      soundwire: bus: pm_runtime_request_resume on peripheral attachment
      soundwire: qcom: return error when pm_runtime_get_sync fails
      soundwire: bus: use pm_runtime_resume_and_get()
      soundwire: cadence: use pm_runtime_resume_and_get()
      soundwire: intel: use pm_runtime_resume_and_get()
      soundwire: qcom: use pm_runtime_resume_and_get()

Srinivas Kandagatla (1):
      soundwire: qcom: adjust autoenumeration timeout

Srinivasa Rao Mandadapu (2):
      soundwire: qcom: Add compatible name for v1.6.0
      dt-bindings: soundwire: qcom: Add bindings for audio clock reset cont=
rol property

Wang Wensheng (1):
      soundwire: stream: Fix error return code in do_bank_switch()

 .../devicetree/bindings/soundwire/qcom,sdw.txt     | 14 ++++++++
 drivers/soundwire/bus.c                            | 27 ++++++++------
 drivers/soundwire/cadence_master.c                 | 42 ++++++++++++++++++=
++--
 drivers/soundwire/intel.c                          | 11 ++++--
 drivers/soundwire/qcom.c                           | 22 ++++++------
 drivers/soundwire/stream.c                         |  1 +
 6 files changed, 90 insertions(+), 27 deletions(-)


--=20
~Vinod

--ONYpAYSFgdbLxYI9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmJ8/XsACgkQfBQHDyUj
g0fTJg//ZuEISBqJnFjCo1yX5vG28Sp2uP/dn98nRI1YNzpSHMgva331ILpQYdOj
uz3GgXlfsymC4uPJlpbW6ltNNQrdMovgxE4V05DKrK9doTXLyGUszqzBpdof14DX
NCz1mKOd5LWh93cgJkhiRQ3cR5zXkPlIIkPB+ULMKebbBY6dYSuMoilxLBsEkrJu
DfcWVUrfgwwRHFEy0MGDUSzCwApy+O0iSjPZJhOTVs2/OglLYPTBEgOKxZH4H/Zj
OrOknGcE9pEaLl8z4cLC6w1xDsf1wOON0Us3E/hKcmdDNdKNMan35ZB5EYkKJ45a
1QcgYaSRwOU5XrekudYHAtiGyhzC53q91riUqYGGkl6sn25sBsB3+t8mBm8PXlk2
ONajQljC2qu2OZAvq3I2CprOh2Hoj3jt/wzt2fg+13twKgwbbGWEUZsWu3mYDtJy
dqcqK7yxwA6GX8wEsMcQ+ufNIfig1AnIbT6Y4lV0klRzFc+8nGFDYeiCYcxnJkOo
V8xzarsYuMuY6O4Cftn1iDHstUlsZ+kxBZCjN+PAkq5VBA8zyhimqTLCagEnCdkB
pLf0YxRv23i3vIfjsCnMavGHx1PumZ/08E2bH3qchKqRYb7nbKGIpAL2KqckApbn
P/PDEcOOj+1eW+FRQ+xqAHGJWdCTRG3j/C1jAUXGk00YrHaYQVs=
=gWHh
-----END PGP SIGNATURE-----

--ONYpAYSFgdbLxYI9--
