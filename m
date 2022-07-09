Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8AD56C990
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 15:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiGINiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 09:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiGINiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 09:38:02 -0400
Received: from email.cn (m218-171.88.com [110.43.218.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03142EE2A;
        Sat,  9 Jul 2022 06:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cn;
        s=dkim; h=Date:From:To; bh=JixWAUQ2D+AlS+IvtPX8+giR8H//4PxI4x0YD
        i2+XmM=; b=DOAFYGKv4tNuqnzp3O9S+0P/SAuziOJ1TYF5fE3jbjmRAFjEJmQlM
        Bib/WVWeocmG3wbz/rd7/NSYJeWfIy+/Na3vp01py4IUIUeXsUdA0oAt1bpT2ek/
        HpZ/GuJCrergwIEzZwN8rBl3YExK4gpmWAvXYWxVx+IKooQ10+AO9k=
Received: from bobwxc.mipc (unknown [120.242.121.162])
        by v_coremail2-frontend-1 (Coremail) with SMTP id LCKnCgBnGGWmhMliJTUiAA--.22889S2;
        Sat, 09 Jul 2022 21:37:44 +0800 (CST)
Date:   Sat, 9 Jul 2022 21:37:42 +0800
From:   Wu XiangCheng <bobwxc@email.cn>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Alex Shi <alexs@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 02/21] docs: update vmalloced-kernel-stacks.rst
 reference
Message-ID: <YsmEpheSCLX8aFXQ@bobwxc.mipc>
References: <cover.1657360984.git.mchehab@kernel.org>
 <71f4ccf95aa2de93be469b1e64606f9fc16dcaa2.1657360984.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BT8liDK9z8k+k0em"
Content-Disposition: inline
In-Reply-To: <71f4ccf95aa2de93be469b1e64606f9fc16dcaa2.1657360984.git.mchehab@kernel.org>
X-CM-TRANSID: LCKnCgBnGGWmhMliJTUiAA--.22889S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw48Gr1UuF1rury7CrW8Xrb_yoW8XF45pF
        1DKr1xJ3Zxtw1UGw48Xw42kFy7Aa1kuF43GwnxtwnYvrnIyr4Ikws09393XasFy340kFWj
        qFnYg34Ygw42y3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgSb7Iv0xC_Cr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
        cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
        v20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j6r4UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4
        CY6c8Ij28IcVAaY2xG8wASzI0EjI02j7AqF2xKxwAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
        Yx0E74AGY7Cv6cx26F4UJr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCF04
        k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26F4UJr1UMxC20s026xCaFVCjc4AY6r1j
        6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
        AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE
        2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
        C2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kfnx
        nUUI43ZEXa7xRRJPEDUUUUU==
X-Originating-IP: [120.242.121.162]
X-CM-SenderInfo: pere453f6hztlloou0/
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BT8liDK9z8k+k0em
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 09, 2022 at 11:07:15AM +0100, Mauro Carvalho Chehab wrote:
> Changeset ee65728e103b ("docs: rename Documentation/vm to Documentation/m=
m")
> renamed: Documentation/vm/vmalloced-kernel-stacks.rst
> to: Documentation/mm/vmalloced-kernel-stacks.rst.
>=20
> Update its cross-reference accordingly.
>=20
> Fixes: ee65728e103b ("docs: rename Documentation/vm to Documentation/mm")
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>

Acked-by: Wu XiangCheng <bobwxc@email.cn>

Thanks,
	Wu

> ---
>=20
> To avoid mailbombing on a large number of people, only mailing lists were=
 C/C on the cover.
> See [PATCH v3 00/21] at: https://lore.kernel.org/all/cover.1657360984.git=
=2Emchehab@kernel.org/
>=20
>  Documentation/translations/zh_CN/mm/vmalloced-kernel-stacks.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/translations/zh_CN/mm/vmalloced-kernel-stacks.=
rst b/Documentation/translations/zh_CN/mm/vmalloced-kernel-stacks.rst
> index ad23f274f6d7..d02a23f7f07e 100644
> --- a/Documentation/translations/zh_CN/mm/vmalloced-kernel-stacks.rst
> +++ b/Documentation/translations/zh_CN/mm/vmalloced-kernel-stacks.rst
> @@ -1,7 +1,7 @@
>  .. SPDX-License-Identifier: GPL-2.0
>  .. include:: ../disclaimer-zh_CN.rst
> =20
> -:Original: Documentation/vm/vmalloced-kernel-stacks.rst
> +:Original: Documentation/mm/vmalloced-kernel-stacks.rst
> =20
>  :=E7=BF=BB=E8=AF=91:
> =20
> --=20
> 2.36.1

--BT8liDK9z8k+k0em
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEERbo3U5kJpaCtFl1PtlsoEiKCsIUFAmLJhJcACgkQtlsoEiKC
sIUfSgwAxPJetlt51pOmXcpVIR5EF8Cuk/alGtWPtyKj+Tvneb3y1IMG+LN8fxBh
NYxq7wBfK2zR15Ohg/SKRdWcVaufTIole7aX6rUqGb7Nlg2rxX5wi5YGmyNRjcO4
HiWp0HJFCu2MVjZ39EpYp01cTDvx88NC7bNermKsGPbgKe4E24oXkvWPiOApEOg7
MWxtvxBynn5wky8nJvShOhBlM/6Hsi2yAhBT1CNcL58Wm0Ct+5wo4Wpu7H500Uln
3J5ZvQd3J/lf/3tx41AONd2HwZ9IJDZUWqk7KDin0lsR93visVuUv+i6aBGyIW5J
fPvLZzPG3PWq0NZ6ieYPWia5SkxtcHT2q7+pHjPdRQmYVDorqy6ZRWJMRcthWJap
ONmUbLt8MPcWueXgvI0/xDcK0PNSaPh0TqHqmW+mJw4wk6KLbh6IJ1wkxQy+ad2x
ccriNVpcnS63CaNC6C7vNAfyt1kOrfUEvs559G9R60SZBvDF8cGzyt1o5HLsxlnp
N77NNeAC
=ZKC1
-----END PGP SIGNATURE-----

--BT8liDK9z8k+k0em--

