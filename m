Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7AA4CD9E7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 18:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240944AbiCDRQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 12:16:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240282AbiCDRQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 12:16:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7438B1B7602
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 09:15:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1395361E25
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 17:15:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64BBAC340E9;
        Fri,  4 Mar 2022 17:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646414156;
        bh=WSbNEoqyvBDWcdty7gCjQEOBDhcK3NfnwgdYdzUd9mU=;
        h=Date:From:To:Cc:Subject:From;
        b=Kdc54skqY8KKk8BHkF3XPf2M8YBfhZEChq+7fQvNLwbYmQkyw9JQBVC03qQ5l5Y+Q
         3dawXFXxxGhTZ8OOREEEb42+7WBiM5CuIOg6L2d0mLJa6nWH2wbOe+9EnHxx44ox3L
         XkGxa3wc+COEc5ePfi9dHpMi6ymFtiucpHnbUfn9VB4Vc965AprG7w262yZbSwR/1K
         uAkC3f2H6MhvoVWK30Gz/8kmxgmBPukl3LFdi+0k7Tm6YjC1BW/i1C46bEZpx8/BEK
         fC8l0j4bzIA7oSKVcnR0ZStnFp3Tw18Zlo4uJVhGpA4WsWe1HxS2yzGTmKUG41nAzJ
         K0jNvHqCtWxcQ==
Date:   Fri, 4 Mar 2022 22:45:51 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] soundwire updates for v5.18-rc1
Message-ID: <YiJJR1hYtlJfBCe4@matsya>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1xsTExvZlP2WC3+B"
Content-Disposition: inline
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1xsTExvZlP2WC3+B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Greg,

Please pull to receive updates for soundwire subsystem for v5.18.

Mostly bunch of core stream refactoring by Intel folks and qcom driver
updates.

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/so=
undwire-5.18-rc1

for you to fetch changes up to 266fa94673d325f489f74d0a9a12024a7f1ee49c:

  soundwire: qcom: use __maybe_unused for swrm_runtime_resume() (2022-03-03=
 21:21:54 +0530)

----------------------------------------------------------------
soundwire updates for 5.17-rc1

 - stream handling refactoring and renaming to make it consistent
   in the core
 - runtime pm suport for qcom driver
 - in band wake up interrupt support for qcom driver

----------------------------------------------------------------
Libin Yang (1):
      soundwire: intel: fix wrong register name in intel_shim_wake

Pierre-Louis Bossart (20):
      soundwire: bus: add dev_warn() messages to track UNATTACHED devices
      soundwire: stream: remove unused parameter in sdw_stream_add_slave
      soundwire: stream: add slave runtime to list earlier
      soundwire: stream: simplify check on port range
      soundwire: stream: add alloc/config/free helpers for ports
      soundwire: stream: split port allocation and configuration loops
      soundwire: stream: split alloc and config in two functions
      soundwire: stream: add 'slave' prefix for port range checks
      soundwire: stream: group sdw_port and sdw_master/slave_port functions
      soundwire: stream: simplify sdw_alloc_master_rt()
      soundwire: stream: split sdw_alloc_master_rt() in alloc and config
      soundwire: stream: move sdw_alloc_slave_rt() before 'master' helpers
      soundwire: stream: split sdw_alloc_slave_rt() in alloc and config
      soundwire: stream: group sdw_stream_ functions
      soundwire: stream: rename and move master/slave_rt_free routines
      soundwire: stream: move list addition to sdw_slave_alloc_rt()
      soundwire: stream: separate alloc and config within sdw_stream_add_xx=
x()
      soundwire: stream: introduce sdw_slave_rt_find() helper
      soundwire: stream: sdw_stream_add_ functions can be called multiple t=
imes
      soundwire: stream: make enable/disable/deprepare idempotent

Rafael J. Wysocki (1):
      soundwire: Replace acpi_bus_get_device()

Srinivas Kandagatla (4):
      soundwire: qcom: add runtime pm support
      dt-bindings: soundwire: qcom: document optional wake irq
      soundwire: qcom: add in-band wake up interrupt support
      soundwire: qcom: use __maybe_unused for swrm_runtime_resume()

Srinivasa Rao Mandadapu (1):
      soundwire: qcom: constify static struct qcom_swrm_data global variabl=
es

 .../devicetree/bindings/soundwire/qcom,sdw.txt     |  14 +-
 drivers/soundwire/bus.c                            |   8 +-
 drivers/soundwire/intel.c                          |   4 +-
 drivers/soundwire/intel_init.c                     |   7 +-
 drivers/soundwire/qcom.c                           | 208 ++++-
 drivers/soundwire/stream.c                         | 952 ++++++++++++-----=
----
 6 files changed, 774 insertions(+), 419 deletions(-)

Thanks
--=20
~Vinod

--1xsTExvZlP2WC3+B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmIiSUcACgkQfBQHDyUj
g0cDERAAy9x57GKCEwoe7MHBUX3rflHPe3kCeGVy7bAeK2NeuOQxut/hKX1HA89y
bONz2BF+x8NlmhGLQ/MkWvWPAALfnShqAMtkCoVxc9i2ptBQ8fmHqcjJrHDNRXXm
dElNSwzPCMnHO535iLuo97ndoBmbBh775O43cus6T0oSdW6PpLD5m1TKos2n+sUP
SXk4Rz1VZhqy3oJp47j4jUXvKuLe0ubmKTZGPh71eMqAC39Ax2ql6DhUHbAOgGRN
DBVgGU0y3l8/5K/AhNczvNZvw7gMNWCSEt5THSVVEaBlnYMgSGhJUqv0kUgOmnXk
/ZS8VucbzILFAUXJYFERDWGy9S0OVY6YzNjn+7hYbALuSpTlyA1qauHJ0r6B49IH
PwMIN7pq0YDUJfpTDDbGl4XGRHRxMkCFELUP/WvsXfpMsKrvpkiB6BVhQAHFPHSv
Ar67HiZGyT0tt5LdFCLaG2Nc6o18/zvp4iEtQOrWW5pm/lm/nqkwgwLkJIkbC+ID
h/IN9jjkKuQ7HA9yGlGBR6xpeKOpcSfZyebfgmd2bzqyNeXya951R0Zbd8lbOXEP
0tFJUIfuANlesLS0tzYOx1p+tZbyr8Qf8iXih6q1OmpZXx/OrDZNIPEnuOPBJN3r
z0tl8UH/c0XcoZ7/yJ5pTboYnS/k4FY9CBxaLzbxML9OHYlx+mM=
=399t
-----END PGP SIGNATURE-----

--1xsTExvZlP2WC3+B--
