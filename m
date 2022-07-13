Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68B15574022
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 01:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbiGMXmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 19:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiGMXmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 19:42:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51C152DC3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 16:42:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3ECD461B2D
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 23:42:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58367C34114;
        Wed, 13 Jul 2022 23:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657755729;
        bh=QSNkC2o08v7WCpV9y/AExdfGE38oqqwuACYWyvh/61g=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=L+/5ZEpbAhTUISCUDUiP4CHaLS4QgdK84S+JufA3mOGG1Hzxpl2LANWv5aiAIKMoT
         7Zjv/9KPOavF55neu6sD7vTOYXif2XfAKqieeQKMUsGc3gb9bYTvkRCKFsOU/Qb67b
         lJ1sMkWQG2Xwp/JTsRZgedPrKHfBDJlvYG6J6myJdKjIzwo4gtmpbOvgZkNl8vfqIE
         06+bclfxBdLqdTZKrpZeU6t4OgGt0Nhs6GCzUi6XU5bomV4pjGjg0pomJols+dsb4H
         1StFP1GjcHiH7wBBjsI/WBPYX/y3/QbG+1JLMgS8QCL8XXRaLNOYYMiHGHbKChYlZe
         iYSfLTQvuBnRQ==
Message-ID: <7b7c5908ccb62f365fff8f55d32baae4c4a6ea89.camel@kernel.org>
Subject: Re: [linux-stable-rc:linux-5.10.y 6996/7120]
 arch/x86/kernel/ftrace_64.o: warning: objtool: ftrace_epilogue()+0x10:
 unreachable instruction
From:   Ben Hutchings <bwh@kernel.org>
To:     kernel test robot <lkp@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Thu, 14 Jul 2022 01:41:58 +0200
In-Reply-To: <202207130344.dwXyDmTk-lkp@intel.com>
References: <202207130344.dwXyDmTk-lkp@intel.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-xihVhGLTPlOoCLKSnsKF"
User-Agent: Evolution 3.44.2-1 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-xihVhGLTPlOoCLKSnsKF
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2022-07-13 at 03:57 +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git linux-5.10.y
> head:   ba398a0e54049bb6a1c102245ae84103f103ff2c
> commit: 8ca9dceaa17983afec1cc8e1a6e76d6bd142447a [6996/7120] objtool: Ass=
ume only ELF functions do sibling calls
> config: x86_64-rhel-8.3-syz (https://download.01.org/0day-ci/archive/2022=
0713/202207130344.dwXyDmTk-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
> reproduce (this is a W=3D1 build):
>         # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git/commit/?id=3D8ca9dceaa17983afec1cc8e1a6e76d6bd142447a
>         git remote add linux-stable-rc https://git.kernel.org/pub/scm/lin=
ux/kernel/git/stable/linux-stable-rc.git
>         git fetch --no-tags linux-stable-rc linux-5.10.y
>         git checkout 8ca9dceaa17983afec1cc8e1a6e76d6bd142447a
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         make W=3D1 O=3Dbuild_dir ARCH=3Dx86_64 SHELL=3D/bin/bash arch/x86=
/
>=20
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
>=20
> All warnings (new ones prefixed by >>):
>=20
> > > arch/x86/kernel/ftrace_64.o: warning: objtool: ftrace_epilogue()+0x10=
: unreachable instruction
>=20
>=20
> objdump-func vmlinux.o ftrace_epilogue:
> 0000 000000000008ca70 <ftrace_epilogue>:
> 0000    8ca70:	e9 00 00 00 00       	jmp    8ca75 <ftrace_epilogue+0x5>	8=
ca71: R_X86_64_PLT32	ftrace_stub-0x4
> 0005    8ca75:	66 66 2e 0f 1f 84 00 00 00 00 00 	data16 cs nopw 0x0(%rax,=
%rax,1)
>=20

I don't know what's going on here.  There's a jump to a ret (now
potentialy a rethunk), and nothing obviously unreachable.=20
ftrace_epilogue got simplified by commit 0c0593b45c9b "x86/ftrace: Make
function graph use ftrace directly" which maybe avoids the warning in
the mainline.

Ben.


--=-xihVhGLTPlOoCLKSnsKF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmLPWEYACgkQ57/I7JWG
EQkElg/8CxrOb8wBVeise13xIdOTOxY04WXDqek2gnNgdhnwYyMHczm6zU/slFCv
oiHylVbwSUuL8/sxZfNqZXoG13plGpX6ib/RYyEqAPI8LXi8/kHU2eU/DX7Jj0o3
XdEoXLUeh+t5m3lJmWUkJlzhuHfBUbgs/zB1o5IOPPxgERN4H/WUu+GODhOePQXc
keemdUrhUpOIGyKmYb3K2SNWuHlI1Vj+6XscDAFq98ZFQCLEn7XdWRrBLO3Y4N2z
7zE0bOZig0imhy0B/I9Jytmm5BUJSi55h4oy/01Z5Jq9/zmlO2/5gBkk+Z8GKFVi
bPpEVXBcrr7ososTT5ekXWgihexQuJGzLnnzr9Acp8j5dj3QE97EOWg+pdMHdN8v
yo+R+ktSqx/L0lheJcjhE3LA2WvW/If5KHh2/5/6luISd2b933+SNsaAPoh+gGRM
PSCzJypSFR57G++6LEkFKClG/QEuPk03F2ra6K3avRBXuKN7xoOQN2eddSzG5+Ra
K4OIbYwNnInhhw0DINbsEW0QZt0uc3dxWr+FIWADan19dhy4mf3AI1WR+wf0qlTw
JqH4BGOUskLrhRT3cExs7Js00bj9ExY1dc08KH9vrQwdA3fGPpZw3biLVLtaUFbg
BM1Wl7vERIoYoMxNNBUz9dsZNlu3KIOsy2enk8zd1HHtJ2bbghg=
=73XA
-----END PGP SIGNATURE-----

--=-xihVhGLTPlOoCLKSnsKF--
