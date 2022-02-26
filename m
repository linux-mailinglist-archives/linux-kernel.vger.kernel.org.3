Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B6A4C5765
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 19:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbiBZSQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 13:16:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbiBZSQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 13:16:47 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68D227EC2B;
        Sat, 26 Feb 2022 10:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645899366;
        bh=b6FURsJsW+kr6eAUTeFvjpLUUXagxQmlheQYAf45hrk=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=UmtMMia2tIroAhkdS1ib1bWj7SO9m1lrOWP+Hggn+h6fGnOhOs3e8yKIVt/tHQUKd
         sG0F4BfbU+KrWHkFbdGjrCjY0XUtZjjmMWQg36CwDkmfczhhgyGeWGu5yhULJzMwkP
         KTNAnqRPF/HE9WFGyd73pYc6m0vbX0muysAu3w5A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from genesis.localnet ([217.232.144.251]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M3lc9-1nNkUn2hE3-000wzb; Sat, 26
 Feb 2022 19:16:06 +0100
From:   Alois Wohlschlager <alwoju@gmx.de>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ovl: warn if trusted xattr creation fails
Date:   Sat, 26 Feb 2022 19:15:50 +0100
Message-ID: <2619141.9QKAVWPfZp@genesis>
In-Reply-To: <YhNzc/++SHzdMXyt@miu.piliscsaba.redhat.com>
References: <2783448.iqOl4yHqVZ@genesis> <YhNzc/++SHzdMXyt@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V03:K1:yea8lAhWsg2b284JbNbp1bAsDqhMJzbu+HTFIiw8iFSDFatyfPb
 mjBwN2E9rCnBU3bitsJLKVzL1zR8X3W+BGU39/iXsQAdRfj7mllmPE/wgVvtNqqkzi9RYmn
 suE6Z3BM/Cc+yGme+530l/JErtuLVhhfnaosILiC1SPJPC6u38vaO6d8i4pvNKJEowiEeqf
 RKTNTg0YipN2tkp+k9WPA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rd50DzNluzk=:CxzKDPOsywbN/lwqTASyvx
 3o+lMuZ6IM0RWiIFYS7B5OjKgSB0vZxYBhzlVCgq21dkJ57ORnIaNH5LoGMz8C2iAHxTecEdX
 TRY7WbgLTHxYS/FGC187EyaRn+caveLPvgzpGXKn7P8XuOFbUBpf72F/W9RlHA/f+SnWhO2ev
 O0a1FtC3luAPBAIh06Pr1+t+TCsyxb9rOlww5ubJF7Mkwy/cIiBZjlA6j/Rj5xEPjKR0BhMnZ
 l/qT4qF9z0fRyS5augxwa0EKPJVhYmiDC1Pyd9L2d6BgFekyokZAte7NaD7tLLpf2wJ+htdIu
 cUfDo3pwUrCjBp98oQC1vqa6c3eaNcALY0nwm84GB4aLfVX7piCoYQnHxeQ4Jk2dvfsbMIwv1
 gWygtEsAD2ifRAmH2gMGkG2tDWWSBZxLKzyY8d7TxLd/oFx0NahqnC8kPd/47ze0rJSV4WLy/
 YPFKYxWAzx9eYbYMNnF/P47jamQ3V0mt7MtrYmT4vdonhvAf+MQX0jOKoKYG2bePvVq7iRzKK
 liTyAG5jtV7rLaxbC5ipTj54ZuStvtHmyvUgoUsiM8kLY8Ql7bjErqy8C3rXkPE+r8WJB38Rj
 cF77bdY3ZWofzE7zXxPqg95EHaRRkTkXxIEMd2Bn5uBSArqbDQ8wTNdxUkSl/dGwJ3QfJHnFA
 TsxhFnA14+0dKP/ET2rvgLllYBdO/BmrHbYLaWCd95NoML45eKMo4BS1MoZZYDrph9ixR++fz
 HKCp1m1OwCfNg8am87F5i1KPPN+jEWeUkkhIWFwrXrkXaBq5dle75pI0deYGi9PUXGxm/n0e3
 6ZrJ1vemgmolspH9+1hQ+KzLjnd5MVTZv0F1xURlKzaZemriTiiK4M5i85cCYEiwSukoFjIJP
 lBYPzbtS28qPtQyvahjCK7k5RO4oM4J9l7U+AtJKLmOh5fZlqay6/YcuPI2l3FuzNtRE/CT+n
 wPaYs+Aagyw4tJm+Jcoyeidtm3KC4k6THfYFus8pEygFNjQWKde0tzdT6igsfdLOf5kCCiBG9
 GhdUrg4joYZTqkPNPqBW7oso2BpDMhdWyWdAoW910r3HfZ+85Fm55rv7MTCVgeJqU2y7e6G3I
 eQZy878BMm2534=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 21. Februar 2022, 12:11:47 CET schrieb Miklos Szeredi:
>
> Thanks for the patch.
>
> How about the following (untested) variant?
>
> Thanks,
> Miklos
>
>
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index 7bb0a47cb615..955aeefc3b29 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -1413,11 +1413,12 @@ static int ovl_make_workdir(struct super_block *=
sb,
> struct ovl_fs *ofs, */
>  	err =3D ovl_do_setxattr(ofs, ofs->workdir, OVL_XATTR_OPAQUE, "0", 1);
>  	if (err) {
> +		pr_warn("failed to set xattr on upper\n");
>  		ofs->noxattr =3D true;
>  		if (ofs->config.index || ofs->config.metacopy) {
>  			ofs->config.index =3D false;
>  			ofs->config.metacopy =3D false;
> -			pr_warn("upper fs does not support xattr, falling back to
> index=3Doff,metacopy=3Doff.\n"); +			pr_warn("...falling back to
> index=3Doff,metacopy=3Doff.\n");
>  		}
>  		/*
>  		 * xattr support is required for persistent st_ino.
> @@ -1425,8 +1426,10 @@ static int ovl_make_workdir(struct super_block *s=
b,
> struct ovl_fs *ofs, */
>  		if (ofs->config.xino =3D=3D OVL_XINO_AUTO) {
>  			ofs->config.xino =3D OVL_XINO_OFF;
> -			pr_warn("upper fs does not support xattr, falling back to xino=3Doff=
.\n");
> +			pr_warn("...falling back to xino=3Doff.\n");
>  		}
> +		if (err =3D=3D -EPERM && !ofs->config.userxattr)
> +			pr_info("try mounting with 'userxattr' option\n");
>  		err =3D 0;
>  	} else {
>  		ovl_do_removexattr(ofs, ofs->workdir, OVL_XATTR_OPAQUE);

Seems sensible to me, since it doesn't duplicate information in case index=
, metacopy or xino are attempted to be used.

Alois


