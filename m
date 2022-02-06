Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08F094AB2B4
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 23:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347371AbiBFWlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 17:41:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234987AbiBFWk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 17:40:59 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE86C06173B;
        Sun,  6 Feb 2022 14:40:56 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JsPPb4PGBz4xRB;
        Mon,  7 Feb 2022 09:40:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1644187252;
        bh=zubdiqKxYImCYdOf5bL7szLMgW/1EqyuIc08SwREpW0=;
        h=Date:From:To:Cc:Subject:From;
        b=TGUCtypTOZOSJPbknxokvO82j70IYKpPAe+8U3Fa4tpNqTT+E8vH6BkiXOEavDolE
         kP7I8VOdD3fCWNEDFgBqA0UPligFs3WX+BIEbxGhjKjl3qUebSQyyngwkaXHYkSoi1
         YX7ZqiKOTZEHDbbSyP7c4MdAi5elKbuJG4J2ZG6iMyXMXGZFkLkCnhqAgR6r0HroFd
         uKjXC/kTnl8vEUCDwBFMmoOLD+HIJzPRl21bMRHG5NWHwyw+iIE2GdJsYsJLurnYI6
         wQaC/Au5aUMS5L1YyklYOcPoHSWAZReHF3YptcBK/7IsFwDKgHgTgVmrqMqS2STztB
         anvM02FfGOQtQ==
Date:   Mon, 7 Feb 2022 09:40:50 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Len Brown <len.brown@intel.com>
Subject: linux-next: build warning after merge of the pm tree
Message-ID: <20220207094050.25d7a756@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/k1zVbNacgFToE7kqLLpK_5M";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/k1zVbNacgFToE7kqLLpK_5M
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the pm tree, today's linux-next build (arm
multi_v7_defconfig) produced this warning:

In file included from drivers/thermal/thermal_core.h:15,
                 from drivers/thermal/thermal_sysfs.c:22:
drivers/thermal/thermal_netlink.h:113:71: warning: 'struct cpu_capability' =
declared inside parameter list will not be visible outside of this definiti=
on or declaration
  113 | static inline int thermal_genl_cpu_capability_event(int count, stru=
ct cpu_capability *caps)
      |                                                                    =
   ^~~~~~~~~~~~~~
In file included from drivers/thermal/thermal_core.h:15,
                 from drivers/thermal/thermal_helpers.c:24:
drivers/thermal/thermal_netlink.h:113:71: warning: 'struct cpu_capability' =
declared inside parameter list will not be visible outside of this definiti=
on or declaration
  113 | static inline int thermal_genl_cpu_capability_event(int count, stru=
ct cpu_capability *caps)
      |                                                                    =
   ^~~~~~~~~~~~~~
In file included from drivers/thermal/thermal_core.h:15,
                 from drivers/thermal/gov_step_wise.c:16:
drivers/thermal/thermal_netlink.h:113:71: warning: 'struct cpu_capability' =
declared inside parameter list will not be visible outside of this definiti=
on or declaration
  113 | static inline int thermal_genl_cpu_capability_event(int count, stru=
ct cpu_capability *caps)
      |                                                                    =
   ^~~~~~~~~~~~~~
In file included from drivers/thermal/thermal_core.h:15,
                 from drivers/thermal/thermal_of.c:20:
drivers/thermal/thermal_netlink.h:113:71: warning: 'struct cpu_capability' =
declared inside parameter list will not be visible outside of this definiti=
on or declaration
  113 | static inline int thermal_genl_cpu_capability_event(int count, stru=
ct cpu_capability *caps)
      |                                                                    =
   ^~~~~~~~~~~~~~
In file included from drivers/thermal/thermal_core.h:15,
                 from drivers/thermal/thermal_core.c:27:
drivers/thermal/thermal_netlink.h:113:71: warning: 'struct cpu_capability' =
declared inside parameter list will not be visible outside of this definiti=
on or declaration
  113 | static inline int thermal_genl_cpu_capability_event(int count, stru=
ct cpu_capability *caps)
      |                                                                    =
   ^~~~~~~~~~~~~~
In file included from drivers/thermal/thermal_core.h:15,
                 from drivers/thermal/armada_thermal.c:22:
drivers/thermal/thermal_netlink.h:113:71: warning: 'struct cpu_capability' =
declared inside parameter list will not be visible outside of this definiti=
on or declaration
  113 | static inline int thermal_genl_cpu_capability_event(int count, stru=
ct cpu_capability *caps)
      |                                                                    =
   ^~~~~~~~~~~~~~
In file included from drivers/thermal/thermal_core.h:15,
                 from drivers/thermal/hisi_thermal.c:28:
drivers/thermal/thermal_netlink.h:113:71: warning: 'struct cpu_capability' =
declared inside parameter list will not be visible outside of this definiti=
on or declaration
  113 | static inline int thermal_genl_cpu_capability_event(int count, stru=
ct cpu_capability *caps)
      |                                                                    =
   ^~~~~~~~~~~~~~
In file included from drivers/thermal/samsung/../thermal_core.h:15,
                 from drivers/thermal/samsung/exynos_tmu.c:26:
drivers/thermal/samsung/../thermal_netlink.h:113:71: warning: 'struct cpu_c=
apability' declared inside parameter list will not be visible outside of th=
is definition or declaration
  113 | static inline int thermal_genl_cpu_capability_event(int count, stru=
ct cpu_capability *caps)
      |                                                                    =
   ^~~~~~~~~~~~~~
In file included from drivers/thermal/thermal_core.h:15,
                 from drivers/thermal/amlogic_thermal.c:31:
drivers/thermal/thermal_netlink.h:113:71: warning: 'struct cpu_capability' =
declared inside parameter list will not be visible outside of this definiti=
on or declaration
  113 | static inline int thermal_genl_cpu_capability_event(int count, stru=
ct cpu_capability *caps)
      |                                                                    =
   ^~~~~~~~~~~~~~
In file included from drivers/thermal/tegra/../thermal_core.h:15,
                 from drivers/thermal/tegra/tegra30-tsensor.c:31:
drivers/thermal/tegra/../thermal_netlink.h:113:71: warning: 'struct cpu_cap=
ability' declared inside parameter list will not be visible outside of this=
 definition or declaration
  113 | static inline int thermal_genl_cpu_capability_event(int count, stru=
ct cpu_capability *caps)
      |                                                                    =
   ^~~~~~~~~~~~~~
In file included from drivers/thermal/st/../thermal_core.h:15,
                 from drivers/thermal/st/stm_thermal.c:22:
drivers/thermal/st/../thermal_netlink.h:113:71: warning: 'struct cpu_capabi=
lity' declared inside parameter list will not be visible outside of this de=
finition or declaration
  113 | static inline int thermal_genl_cpu_capability_event(int count, stru=
ct cpu_capability *caps)
      |                                                                    =
   ^~~~~~~~~~~~~~
In file included from drivers/thermal/thermal_core.h:15,
                 from drivers/thermal/uniphier_thermal.c:20:
drivers/thermal/thermal_netlink.h:113:71: warning: 'struct cpu_capability' =
declared inside parameter list will not be visible outside of this definiti=
on or declaration
  113 | static inline int thermal_genl_cpu_capability_event(int count, stru=
ct cpu_capability *caps)
      |                                                                    =
   ^~~~~~~~~~~~~~
In file included from drivers/thermal/tegra/../thermal_core.h:15,
                 from drivers/thermal/tegra/soctherm.c:36:
drivers/thermal/tegra/../thermal_netlink.h:113:71: warning: 'struct cpu_cap=
ability' declared inside parameter list will not be visible outside of this=
 definition or declaration
  113 | static inline int thermal_genl_cpu_capability_event(int count, stru=
ct cpu_capability *caps)
      |                                                                    =
   ^~~~~~~~~~~~~~

Introduced by commit

  e4b1eb24ce5a ("thermal: netlink: Add a new event to notify CPU capabiliti=
es change")

--=20
Cheers,
Stephen Rothwell

--Sig_/k1zVbNacgFToE7kqLLpK_5M
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIATnIACgkQAVBC80lX
0GxT6QgAnaxifff3UW9xUVxG1K2dedjwidAYRFY3nRQJbqKZa1Xlm1hton/0OB9b
cUrbl+2BgaXsVZWBAOeCzenB3r3s+bliiqLD6MbKTooCJu/1ErXbo/BCN3dDOPGF
YwsKyCQ7Tg924UkXnQL7ErZUaIoU54O5j9cC6b/PcQ7K75HL1Vquk5mJU5zwHE1O
GsiazmUPmu/ltzTV7Qr23+rBjojNdM/wyvzcqCFVPWTmUnYyaSMOoFfXHWR2SP9K
2Fxr/qH9WeMByowet9/t0Hpa2XPiN42E2khWQOzD/NYG1ATYEMybtPTimL9yPYbe
9GChqvlR1S4bJQhPYw5+Zak5VIzVSg==
=8ZN2
-----END PGP SIGNATURE-----

--Sig_/k1zVbNacgFToE7kqLLpK_5M--
