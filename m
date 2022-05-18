Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF2952B2CE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 09:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbiERHFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 03:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbiERHFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 03:05:34 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B977CA308F
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 00:05:32 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nrDkF-0000CF-AS; Wed, 18 May 2022 09:05:19 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 1EB3B80F3A;
        Wed, 18 May 2022 07:05:18 +0000 (UTC)
Date:   Wed, 18 May 2022 09:05:17 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-can@vger.kernel.org
Subject: Re: drivers/net/can/spi/mcp251xfd/mcp251xfd.h:481:34: warning: field
 hw_tx_obj within 'struct mcp251xfd_tx_obj_load_buf::(unnamed at
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h:479:2)' is less aligned than
 'struct mcp251xfd_hw_tx_obj_raw' and is usually due to ...
Message-ID: <20220518070517.q53bjzo6lbnq3f2i@pengutronix.de>
References: <202205181414.n8QRDe8k-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cujgf6c2mizwls7v"
Content-Disposition: inline
In-Reply-To: <202205181414.n8QRDe8k-lkp@intel.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cujgf6c2mizwls7v
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 18.05.2022 14:45:33, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master
> head:   210e04ff768142b96452030c4c2627512b30ad95
> commit: eb79a267c9b3e608e7762a1b221428f37ace3aa3 can: mcp251xfd: rename a=
ll remaining occurrence to mcp251xfd
> date:   1 year, 8 months ago
> config: arm-randconfig-c002-20220518 (https://download.01.org/0day-ci/arc=
hive/20220518/202205181414.n8QRDe8k-lkp@intel.com/config)
> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 853f=
a8ee225edf2d0de94b0dcbd31bea916e825e)
> reproduce (this is a W=3D1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbi=
n/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm cross compiling tool for clang build
>         # apt-get install binutils-arm-linux-gnueabi
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git/commit/?id=3Deb79a267c9b3e608e7762a1b221428f37ace3aa3
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/=
git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout eb79a267c9b3e608e7762a1b221428f37ace3aa3
>         # save the config file
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross=20
>=20
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>=20
> All warnings (new ones prefixed by >>):
>=20
> >> drivers/net/can/spi/mcp251xfd/mcp251xfd.h:481:34: warning: field hw_tx=
_obj within 'struct mcp251xfd_tx_obj_load_buf::(unnamed at drivers/net/can/=
spi/mcp251xfd/mcp251xfd.h:479:2)' is less aligned than 'struct mcp251xfd_hw=
_tx_obj_raw' and is usually due to 'struct mcp251xfd_tx_obj_load_buf::(unna=
med at drivers/net/can/spi/mcp251xfd/mcp251xfd.h:479:2)' being packed, whic=
h can lead to unaligned accesses [-Wunaligned-access]
>                    struct mcp251xfd_hw_tx_obj_raw hw_tx_obj;
>                                                   ^
>    drivers/net/can/spi/mcp251xfd/mcp251xfd.h:485:34: warning: field hw_tx=
_obj within 'struct mcp251xfd_tx_obj_load_buf::(unnamed at drivers/net/can/=
spi/mcp251xfd/mcp251xfd.h:483:2)' is less aligned than 'struct mcp251xfd_hw=
_tx_obj_raw' and is usually due to 'struct mcp251xfd_tx_obj_load_buf::(unna=
med at drivers/net/can/spi/mcp251xfd/mcp251xfd.h:483:2)' being packed, whic=
h can lead to unaligned accesses [-Wunaligned-access]
>                    struct mcp251xfd_hw_tx_obj_raw hw_tx_obj;
>                                                   ^
>    drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c:511:1: warning: unused =
function 'mcp251xfd_chip_set_mode_nowait' [-Wunused-function]
>    mcp251xfd_chip_set_mode_nowait(const struct mcp251xfd_priv *priv,
>    ^
>    3 warnings generated.
> --
> >> drivers/net/can/spi/mcp251xfd/mcp251xfd.h:481:34: warning: field hw_tx=
_obj within 'struct mcp251xfd_tx_obj_load_buf::(unnamed at drivers/net/can/=
spi/mcp251xfd/mcp251xfd.h:479:2)' is less aligned than 'struct mcp251xfd_hw=
_tx_obj_raw' and is usually due to 'struct mcp251xfd_tx_obj_load_buf::(unna=
med at drivers/net/can/spi/mcp251xfd/mcp251xfd.h:479:2)' being packed, whic=
h can lead to unaligned accesses [-Wunaligned-access]
>                    struct mcp251xfd_hw_tx_obj_raw hw_tx_obj;
>                                                   ^
>    drivers/net/can/spi/mcp251xfd/mcp251xfd.h:485:34: warning: field hw_tx=
_obj within 'struct mcp251xfd_tx_obj_load_buf::(unnamed at drivers/net/can/=
spi/mcp251xfd/mcp251xfd.h:483:2)' is less aligned than 'struct mcp251xfd_hw=
_tx_obj_raw' and is usually due to 'struct mcp251xfd_tx_obj_load_buf::(unna=
med at drivers/net/can/spi/mcp251xfd/mcp251xfd.h:483:2)' being packed, whic=
h can lead to unaligned accesses [-Wunaligned-access]
>                    struct mcp251xfd_hw_tx_obj_raw hw_tx_obj;
>                                                   ^
>    2 warnings generated.
>=20
>=20
> vim +481 drivers/net/can/spi/mcp251xfd/mcp251xfd.h
>=20
>    477=09
>    478	union mcp251xfd_tx_obj_load_buf {
>    479		struct __packed {
>    480			struct mcp251xfd_buf_cmd cmd;
>  > 481			struct mcp251xfd_hw_tx_obj_raw hw_tx_obj;
>    482		} nocrc;
>    483		struct __packed {
>    484			struct mcp251xfd_buf_cmd_crc cmd;
>    485			struct mcp251xfd_hw_tx_obj_raw hw_tx_obj;
>    486			__be16 crc;
>    487		} crc;
>    488	} ____cacheline_aligned;
>    489

The structure layout is intentional as it describes the hardware
messages on the SPI bus. The functions accessing these structs use
appropriate put_unaligned_*() functions.

How to properly annotate these structs to silence the warnings?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--cujgf6c2mizwls7v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmKEmqsACgkQrX5LkNig
010wJAf/chPXIiNCGy6KFLiLZz5cZUSKN6WyTQN1q4bmbJppDkFfg+dEjoMedGWL
KPH0TdZ9AtWFRFDZzmGrPgBVcnoXD0Hi7Hb1ISIJFZjf7XBDXvePoFY0+6JikS6w
AwbMsLZMHBByU9kMOz5NobPyBDaWKcc78dLZARD+vrHhwzQ5C8mITuHHGeQU995N
Q83dbx/7dqK6DIfM4draFFYetB4UWmaUS3aBDs0SB7+hX4+8ts9KHdlCm0k/7FXU
607UgLU7Lukwxprd3lGf54HEDAt2fazhseZri8rIaXKOznpjLSOvt0PNUvsQrAEh
5HqZC4V3MqeqIurSCde5uCv2B9sgww==
=THh8
-----END PGP SIGNATURE-----

--cujgf6c2mizwls7v--
