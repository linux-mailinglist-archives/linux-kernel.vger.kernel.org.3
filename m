Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 748DA52751F
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 05:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234390AbiEODRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 23:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234122AbiEODRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 23:17:10 -0400
X-Greylist: delayed 131206 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 14 May 2022 20:17:06 PDT
Received: from email.cn (m218-171.88.com [110.43.218.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1ADCB7DF;
        Sat, 14 May 2022 20:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cn;
        s=dkim; h=Date:From:To; bh=k0QdsXqpWjoMvrQl+daHqHXFi5/WRuqKXlL+/
        hJ9oN8=; b=PK2Uxt6IbGOyIYhHOJ3uJG9Bj6QbHJwqkkhdBey7zlu1eux7yNDCg
        PZ7E8bslru9pjXagDHI6JH0cdKvVwhPqfbk/TFUytlngy9Gff/j4o4pnglS6IT9w
        5R5w6IObbV3KeuHlcMSSzmIwfBSK4c2DqXTgVU1jOPdp6vPr6gEa4w=
Received: from bobwxc.top (unknown [120.242.68.220])
        by v_coremail2-frontend-1 (Coremail) with SMTP id LCKnCgBHrLydcIBiRrmBAA--.61540S2;
        Sun, 15 May 2022 11:16:46 +0800 (CST)
Date:   Sun, 15 May 2022 11:16:45 +0800
From:   "Wu X.C." <bobwxc@email.cn>
To:     gaochao <gaochao49@huawei.com>
Cc:     alexs@kernel.org, corbet@lwn.net, siyanteng01@gmail.com,
        src.res@email.cn, wanjiabing@vivo.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 -next] docs/zh_CN: Add
 dev-tools/gdb-kernel-debugging.rst Chinese translation
Message-ID: <YoBwnRZYhPPstiQD@bobwxc.top>
References: <20220513061035.605-1-gaochao49@huawei.com>
 <20220514100046.1683-1-gaochao49@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ue57ZUD7o2z13jL/"
Content-Disposition: inline
In-Reply-To: <20220514100046.1683-1-gaochao49@huawei.com>
X-CM-TRANSID: LCKnCgBHrLydcIBiRrmBAA--.61540S2
X-Coremail-Antispam: 1UD129KBjvJXoW3ArW5ZryUCr45WFy5uFWxJFb_yoWfGFW5pF
        sIgFyfGF4xJry5Xry8GF1rCF93ZrZ7uay5Kr98J34rJ34UCrWIv3W7KF90gFZ7X340vFy7
        XFZrJr42kryjyaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyFb7Iv0xC_Zr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
        cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
        v20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4
        CY6c8Ij28IcVAaY2xG8wASzI0EjI02j7AqF2xKxwAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
        Yx0E74AGY7Cv6cx26F4UJr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCY02
        Avz4vE14v_Gr4l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VWxJr1UJwCFx2Iq
        xVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r
        106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AK
        xVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7
        xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_
        GrUvcSsGvfC2KfnxnUUI43ZEXa7IUjD73DUUUUU==
X-Originating-IP: [120.242.68.220]
X-CM-SenderInfo: pere453f6hztlloou0/
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ue57ZUD7o2z13jL/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 14, 2022 at 06:00:46PM +0800, gaochao wrote:
> Translate dev-tools/gdb-kernel-debugging.rst into Chinese.
>=20
> Signed-off-by: gaochao <gaochao49@huawei.com>
> Reviewed-by: Yanteng Si <siyanteng@loongson.cn>

Reviewed-by: Wu XiangCheng <bobwxc@email.cn>

Thanks!
Wu

> ---
> v2:
> - change : to ::
> - change =E4=BD=BF=E8=83=BD to =E5=BC=80=E5=90=AF
> ---
>  .../zh_CN/dev-tools/gdb-kernel-debugging.rst  | 167 ++++++++++++++++++
>  .../translations/zh_CN/dev-tools/index.rst    |   2 +-
>  2 files changed, 168 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/translations/zh_CN/dev-tools/gdb-kernel=
-debugging.rst
>=20
> diff --git a/Documentation/translations/zh_CN/dev-tools/gdb-kernel-debugg=
ing.rst b/Documentation/translations/zh_CN/dev-tools/gdb-kernel-debugging.r=
st
> new file mode 100644
> index 000000000000..17b5ce85a90c
> --- /dev/null
> +++ b/Documentation/translations/zh_CN/dev-tools/gdb-kernel-debugging.rst
> @@ -0,0 +1,167 @@
> +.. highlight:: none
> +
> +.. include:: ../disclaimer-zh_CN.rst
> +
> +:Original: Documentation/dev-tools/gdb-kernel-debugging.rst
> +:Translator: =E9=AB=98=E8=B6=85 gao chao <gaochao49@huawei.com>
> +
> +=E9=80=9A=E8=BF=87gdb=E8=B0=83=E8=AF=95=E5=86=85=E6=A0=B8=E5=92=8C=E6=A8=
=A1=E5=9D=97
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Kgdb=E5=86=85=E6=A0=B8=E8=B0=83=E8=AF=95=E5=99=A8=E3=80=81QEMU=E7=AD=89=
=E8=99=9A=E6=8B=9F=E6=9C=BA=E7=AE=A1=E7=90=86=E7=A8=8B=E5=BA=8F=E6=88=96=E5=
=9F=BA=E4=BA=8EJTAG=E7=9A=84=E7=A1=AC=E4=BB=B6=E6=8E=A5=E5=8F=A3=EF=BC=8C=
=E6=94=AF=E6=8C=81=E5=9C=A8=E8=BF=90=E8=A1=8C=E6=97=B6=E4=BD=BF=E7=94=A8gdb
> +=E8=B0=83=E8=AF=95Linux=E5=86=85=E6=A0=B8=E5=8F=8A=E5=85=B6=E6=A8=A1=E5=
=9D=97=E3=80=82Gdb=E6=8F=90=E4=BE=9B=E4=BA=86=E4=B8=80=E4=B8=AA=E5=BC=BA=E5=
=A4=A7=E7=9A=84python=E8=84=9A=E6=9C=AC=E6=8E=A5=E5=8F=A3=EF=BC=8C=E5=86=85=
=E6=A0=B8=E4=B9=9F=E6=8F=90=E4=BE=9B=E4=BA=86=E4=B8=80=E5=A5=97
> +=E8=BE=85=E5=8A=A9=E8=84=9A=E6=9C=AC=E4=BB=A5=E7=AE=80=E5=8C=96=E5=85=B8=
=E5=9E=8B=E7=9A=84=E5=86=85=E6=A0=B8=E8=B0=83=E8=AF=95=E6=AD=A5=E9=AA=A4=E3=
=80=82=E6=9C=AC=E6=96=87=E6=A1=A3=E4=B8=BA=E5=A6=82=E4=BD=95=E5=90=AF=E7=94=
=A8=E5=92=8C=E4=BD=BF=E7=94=A8=E8=BF=99=E4=BA=9B=E8=84=9A=E6=9C=AC=E6=8F=90=
=E4=BE=9B=E4=BA=86=E4=B8=80=E4=B8=AA=E7=AE=80=E8=A6=81=E7=9A=84=E6=95=99=E7=
=A8=8B=E3=80=82
> +=E6=AD=A4=E6=95=99=E7=A8=8B=E5=9F=BA=E4=BA=8EQEMU/KVM=E8=99=9A=E6=8B=9F=
=E6=9C=BA=EF=BC=8C=E4=BD=86=E6=96=87=E4=B8=AD=E7=A4=BA=E4=BE=8B=E4=B9=9F=E9=
=80=82=E7=94=A8=E4=BA=8E=E5=85=B6=E4=BB=96gdb stub=E3=80=82
> +
> +
> +=E7=8E=AF=E5=A2=83=E9=85=8D=E7=BD=AE=E8=A6=81=E6=B1=82
> +------------
> +
> +- gdb 7.2+ (=E6=8E=A8=E8=8D=90=E7=89=88=E6=9C=AC: 7.4+) =E4=B8=94=E5=BC=
=80=E5=90=AFpython=E6=94=AF=E6=8C=81 (=E9=80=9A=E5=B8=B8=E5=8F=91=E8=A1=8C=
=E7=89=88=E4=B8=8A=E9=83=BD=E5=B7=B2=E6=94=AF=E6=8C=81)
> +
> +=E8=AE=BE=E7=BD=AE
> +----
> +
> +- =E5=88=9B=E5=BB=BA=E4=B8=80=E4=B8=AAQEMU/KVM=E7=9A=84linux=E8=99=9A=E6=
=8B=9F=E6=9C=BA=EF=BC=88=E8=AF=A6=E6=83=85=E8=AF=B7=E5=8F=82=E8=80=83 www.l=
inux-kvm.org =E5=92=8C www.qemu.org =EF=BC=89=E3=80=82
> +  =E5=AF=B9=E4=BA=8E=E4=BA=A4=E5=8F=89=E5=BC=80=E5=8F=91=EF=BC=8Chttps:/=
/landley.net/aboriginal/bin =E6=8F=90=E4=BE=9B=E4=BA=86=E4=B8=80=E4=BA=9B=
=E9=95=9C=E5=83=8F=E5=92=8C=E5=B7=A5=E5=85=B7=E9=93=BE=EF=BC=8C
> +  =E5=8F=AF=E4=BB=A5=E5=B8=AE=E5=8A=A9=E6=90=AD=E5=BB=BA=E4=BA=A4=E5=8F=
=89=E5=BC=80=E5=8F=91=E7=8E=AF=E5=A2=83=E3=80=82
> +
> +- =E7=BC=96=E8=AF=91=E5=86=85=E6=A0=B8=E6=97=B6=E5=BC=80=E5=90=AFCONFIG_=
GDB_SCRIPTS=EF=BC=8C=E5=85=B3=E9=97=ADCONFIG_DEBUG_INFO_REDUCED=E3=80=82
> +  =E5=A6=82=E6=9E=9C=E6=9E=B6=E6=9E=84=E6=94=AF=E6=8C=81CONFIG_FRAME_POI=
NTER=EF=BC=8C=E8=AF=B7=E4=BF=9D=E6=8C=81=E5=BC=80=E5=90=AF=E3=80=82
> +
> +- =E5=9C=A8guest=E7=8E=AF=E5=A2=83=E4=B8=8A=E5=AE=89=E8=A3=85=E8=AF=A5=
=E5=86=85=E6=A0=B8=E3=80=82=E5=A6=82=E6=9C=89=E5=BF=85=E8=A6=81=EF=BC=8C=E9=
=80=9A=E8=BF=87=E5=9C=A8=E5=86=85=E6=A0=B8command line=E4=B8=AD=E6=B7=BB=E5=
=8A=A0=E2=80=9Cnokaslr=E2=80=9D=E6=9D=A5=E5=85=B3=E9=97=ADKASLR=E3=80=82
> +  =E6=AD=A4=E5=A4=96=EF=BC=8CQEMU=E5=85=81=E8=AE=B8=E9=80=9A=E8=BF=87-ke=
rnel=E3=80=81-append=E3=80=81-initrd=E8=BF=99=E4=BA=9B=E5=91=BD=E4=BB=A4=E8=
=A1=8C=E9=80=89=E9=A1=B9=E7=9B=B4=E6=8E=A5=E5=90=AF=E5=8A=A8=E5=86=85=E6=A0=
=B8=E3=80=82
> +  =E4=BD=86=E8=BF=99=E9=80=9A=E5=B8=B8=E4=BB=85=E5=9C=A8=E4=B8=8D=E4=BE=
=9D=E8=B5=96=E5=86=85=E6=A0=B8=E6=A8=A1=E5=9D=97=E6=97=B6=E6=89=8D=E6=9C=89=
=E6=95=88=E3=80=82=E6=9C=89=E5=85=B3=E6=AD=A4=E6=A8=A1=E5=BC=8F=E7=9A=84=E6=
=9B=B4=E5=A4=9A=E8=AF=A6=E7=BB=86=E4=BF=A1=E6=81=AF=EF=BC=8C=E8=AF=B7=E5=8F=
=82=E9=98=85QEMU=E6=96=87=E6=A1=A3=E3=80=82
> +  =E5=9C=A8=E8=BF=99=E7=A7=8D=E6=83=85=E5=86=B5=E4=B8=8B=EF=BC=8C=E5=A6=
=82=E6=9E=9C=E6=9E=B6=E6=9E=84=E6=94=AF=E6=8C=81KASLR=EF=BC=8C=E5=BA=94=E8=
=AF=A5=E5=9C=A8=E7=A6=81=E7=94=A8CONFIG_RANDOMIZE_BASE=E7=9A=84=E6=83=85=E5=
=86=B5=E4=B8=8B=E6=9E=84=E5=BB=BA=E5=86=85=E6=A0=B8=E3=80=82
> +
> +- =E5=90=AF=E7=94=A8QEMU/KVM=E7=9A=84gdb stub=EF=BC=8C=E5=8F=AF=E4=BB=A5=
=E9=80=9A=E8=BF=87=E5=A6=82=E4=B8=8B=E6=96=B9=E5=BC=8F=E5=AE=9E=E7=8E=B0
> +
> +    - =E5=9C=A8VM=E5=90=AF=E5=8A=A8=E6=97=B6=EF=BC=8C=E9=80=9A=E8=BF=87=
=E5=9C=A8QEMU=E5=91=BD=E4=BB=A4=E8=A1=8C=E4=B8=AD=E6=B7=BB=E5=8A=A0=E2=80=
=9C-s=E2=80=9D=E5=8F=82=E6=95=B0
> +
> +  =E6=88=96
> +
> +    - =E5=9C=A8=E8=BF=90=E8=A1=8C=E6=97=B6=E9=80=9A=E8=BF=87=E4=BB=8EQEM=
U=E7=9B=91=E8=A7=86=E6=8E=A7=E5=88=B6=E5=8F=B0=E5=8F=91=E9=80=81=E2=80=9Cgd=
bserver=E2=80=9D
> +
> +- =E5=88=87=E6=8D=A2=E5=88=B0/path/to/linux-build(=E5=86=85=E6=A0=B8=E6=
=BA=90=E7=A0=81=E7=BC=96=E8=AF=91)=E7=9B=AE=E5=BD=95
> +
> +- =E5=90=AF=E5=8A=A8gdb=EF=BC=9Agdb vmlinux
> +
> +  =E6=B3=A8=E6=84=8F=EF=BC=9A=E6=9F=90=E4=BA=9B=E5=8F=91=E8=A1=8C=E7=89=
=88=E5=8F=AF=E8=83=BD=E4=BC=9A=E5=B0=86gdb=E8=84=9A=E6=9C=AC=E7=9A=84=E8=87=
=AA=E5=8A=A8=E5=8A=A0=E8=BD=BD=E9=99=90=E5=88=B6=E5=9C=A8=E5=B7=B2=E7=9F=A5=
=E7=9A=84=E5=AE=89=E5=85=A8=E7=9B=AE=E5=BD=95=E4=B8=AD=E3=80=82
> +  =E5=A6=82=E6=9E=9Cgdb=E6=8A=A5=E5=91=8A=E6=8B=92=E7=BB=9D=E5=8A=A0=E8=
=BD=BDvmlinux-gdb.py=EF=BC=88=E7=9B=B8=E5=85=B3=E5=91=BD=E4=BB=A4=E6=89=BE=
=E4=B8=8D=E5=88=B0=EF=BC=89=EF=BC=8C=E8=AF=B7=E5=B0=86::
> +
> +    add-auto-load-safe-path /path/to/linux-build
> +
> +  =E6=B7=BB=E5=8A=A0=E5=88=B0~/.gdbinit=E3=80=82=E6=9B=B4=E5=A4=9A=E8=AF=
=A6=E7=BB=86=E4=BF=A1=E6=81=AF=EF=BC=8C=E8=AF=B7=E5=8F=82=E9=98=85gdb=E5=B8=
=AE=E5=8A=A9=E4=BF=A1=E6=81=AF=E3=80=82
> +
> +- =E8=BF=9E=E6=8E=A5=E5=88=B0=E5=B7=B2=E5=90=AF=E5=8A=A8=E7=9A=84guest=
=E7=8E=AF=E5=A2=83::
> +
> +    (gdb) target remote :1234
> +
> +
> +=E4=BD=BF=E7=94=A8Linux=E6=8F=90=E4=BE=9B=E7=9A=84gdb=E8=84=9A=E6=9C=AC=
=E7=9A=84=E7=A4=BA=E4=BE=8B
> +----------------------------
> +
> +- =E5=8A=A0=E8=BD=BD=E6=A8=A1=E5=9D=97=EF=BC=88=E4=BB=A5=E5=8F=8A=E4=B8=
=BB=E5=86=85=E6=A0=B8=EF=BC=89=E7=AC=A6=E5=8F=B7::
> +
> +    (gdb) lx-symbols
> +    loading vmlinux
> +    scanning for modules in /home/user/linux/build
> +    loading @0xffffffffa0020000: /home/user/linux/build/net/netfilter/xt=
_tcpudp.ko
> +    loading @0xffffffffa0016000: /home/user/linux/build/net/netfilter/xt=
_pkttype.ko
> +    loading @0xffffffffa0002000: /home/user/linux/build/net/netfilter/xt=
_limit.ko
> +    loading @0xffffffffa00ca000: /home/user/linux/build/net/packet/af_pa=
cket.ko
> +    loading @0xffffffffa003c000: /home/user/linux/build/fs/fuse/fuse.ko
> +    ...
> +    loading @0xffffffffa0000000: /home/user/linux/build/drivers/ata/ata_=
generic.ko
> +
> +- =E5=AF=B9=E4=B8=80=E4=BA=9B=E5=B0=9A=E6=9C=AA=E5=8A=A0=E8=BD=BD=E7=9A=
=84=E6=A8=A1=E5=9D=97=E4=B8=AD=E7=9A=84=E5=87=BD=E6=95=B0=E5=87=BD=E6=95=B0=
=E8=AE=BE=E7=BD=AE=E6=96=AD=E7=82=B9=EF=BC=8C=E4=BE=8B=E5=A6=82::
> +
> +    (gdb) b btrfs_init_sysfs
> +    Function "btrfs_init_sysfs" not defined.
> +    Make breakpoint pending on future shared library load? (y or [n]) y
> +    Breakpoint 1 (btrfs_init_sysfs) pending.
> +
> +- =E7=BB=A7=E7=BB=AD=E6=89=A7=E8=A1=8C::
> +
> +    (gdb) c
> +
> +- =E5=8A=A0=E8=BD=BD=E6=A8=A1=E5=9D=97=E5=B9=B6=E4=B8=94=E8=83=BD=E8=A7=
=82=E5=AF=9F=E5=88=B0=E6=AD=A3=E5=9C=A8=E5=8A=A0=E8=BD=BD=E7=9A=84=E7=AC=A6=
=E5=8F=B7=E4=BB=A5=E5=8F=8A=E6=96=AD=E7=82=B9=E5=91=BD=E4=B8=AD::
> +
> +    loading @0xffffffffa0034000: /home/user/linux/build/lib/libcrc32c.ko
> +    loading @0xffffffffa0050000: /home/user/linux/build/lib/lzo/lzo_comp=
ress.ko
> +    loading @0xffffffffa006e000: /home/user/linux/build/lib/zlib_deflate=
/zlib_deflate.ko
> +    loading @0xffffffffa01b1000: /home/user/linux/build/fs/btrfs/btrfs.ko
> +
> +    Breakpoint 1, btrfs_init_sysfs () at /home/user/linux/fs/btrfs/sysfs=
=2Ec:36
> +    36              btrfs_kset =3D kset_create_and_add("btrfs", NULL, fs=
_kobj);
> +
> +- =E6=9F=A5=E7=9C=8B=E5=86=85=E6=A0=B8=E7=9A=84=E6=97=A5=E5=BF=97=E7=BC=
=93=E5=86=B2=E5=8C=BA::
> +
> +    (gdb) lx-dmesg
> +    [     0.000000] Initializing cgroup subsys cpuset
> +    [     0.000000] Initializing cgroup subsys cpu
> +    [     0.000000] Linux version 3.8.0-rc4-dbg+ (...
> +    [     0.000000] Command line: root=3D/dev/sda2 resume=3D/dev/sda1 vg=
a=3D0x314
> +    [     0.000000] e820: BIOS-provided physical RAM map:
> +    [     0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbf=
f] usable
> +    [     0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009fff=
f] reserved
> +    ....
> +
> +- =E6=9F=A5=E7=9C=8B=E5=BD=93=E5=89=8Dtask struct=E7=BB=93=E6=9E=84=E4=
=BD=93=E7=9A=84=E5=AD=97=E6=AE=B5=EF=BC=88=E4=BB=85x86=E5=92=8Carm64=E6=94=
=AF=E6=8C=81=EF=BC=89::
> +
> +    (gdb) p $lx_current().pid
> +    $1 =3D 4998
> +    (gdb) p $lx_current().comm
> +    $2 =3D "modprobe\000\000\000\000\000\000\000"
> +
> +- =E5=AF=B9=E5=BD=93=E5=89=8D=E6=88=96=E6=8C=87=E5=AE=9A=E7=9A=84CPU=E4=
=BD=BF=E7=94=A8per-cpu=E5=87=BD=E6=95=B0::
> +
> +    (gdb) p $lx_per_cpu("runqueues").nr_running
> +    $3 =3D 1
> +    (gdb) p $lx_per_cpu("runqueues", 2).nr_running
> +    $4 =3D 0
> +
> +- =E4=BD=BF=E7=94=A8container_of=E6=9F=A5=E7=9C=8B=E6=9B=B4=E5=A4=9Ahrti=
mers=E4=BF=A1=E6=81=AF::
> +
> +    (gdb) set $next =3D $lx_per_cpu("hrtimer_bases").clock_base[0].activ=
e.next
> +    (gdb) p *$container_of($next, "struct hrtimer", "node")
> +    $5 =3D {
> +      node =3D {
> +        node =3D {
> +          __rb_parent_color =3D 18446612133355256072,
> +          rb_right =3D 0x0 <irq_stack_union>,
> +          rb_left =3D 0x0 <irq_stack_union>
> +        },
> +        expires =3D {
> +          tv64 =3D 1835268000000
> +        }
> +      },
> +      _softexpires =3D {
> +        tv64 =3D 1835268000000
> +      },
> +      function =3D 0xffffffff81078232 <tick_sched_timer>,
> +      base =3D 0xffff88003fd0d6f0,
> +      state =3D 1,
> +      start_pid =3D 0,
> +      start_site =3D 0xffffffff81055c1f <hrtimer_start_range_ns+20>,
> +      start_comm =3D "swapper/2\000\000\000\000\000\000"
> +    }
> +
> +
> +=E5=91=BD=E4=BB=A4=E5=92=8C=E8=BE=85=E5=8A=A9=E8=B0=83=E8=AF=95=E5=8A=9F=
=E8=83=BD=E5=88=97=E8=A1=A8
> +----------------------
> +
> +=E5=91=BD=E4=BB=A4=E5=92=8C=E8=BE=85=E5=8A=A9=E8=B0=83=E8=AF=95=E5=8A=9F=
=E8=83=BD=E5=8F=AF=E8=83=BD=E4=BC=9A=E9=9A=8F=E7=9D=80=E6=97=B6=E9=97=B4=E7=
=9A=84=E6=8E=A8=E7=A7=BB=E8=80=8C=E6=94=B9=E8=BF=9B=EF=BC=8C=E6=AD=A4=E6=96=
=87=E6=98=BE=E7=A4=BA=E7=9A=84=E6=98=AF=E5=88=9D=E5=A7=8B=E7=89=88=E6=9C=AC=
=E7=9A=84=E9=83=A8=E5=88=86=E7=A4=BA=E4=BE=8B::
> +
> + (gdb) apropos lx
> + function lx_current -- Return current task
> + function lx_module -- Find module by name and return the module variable
> + function lx_per_cpu -- Return per-cpu variable
> + function lx_task_by_pid -- Find Linux task by PID and return the task_s=
truct variable
> + function lx_thread_info -- Calculate Linux thread_info from task variab=
le
> + lx-dmesg -- Print Linux kernel log buffer
> + lx-lsmod -- List currently loaded modules
> + lx-symbols -- (Re-)load symbols of Linux kernel and currently loaded mo=
dules
> +
> +=E5=8F=AF=E4=BB=A5=E9=80=9A=E8=BF=87=E2=80=9Chelp <command-name>=E2=80=
=9D=E6=88=96=E2=80=9Chelp function <function-name>=E2=80=9D=E5=91=BD=E4=BB=
=A4
> +=E8=8E=B7=E5=8F=96=E6=8C=87=E5=AE=9A=E5=91=BD=E4=BB=A4=E6=88=96=E6=8C=87=
=E5=AE=9A=E8=B0=83=E8=AF=95=E5=8A=9F=E8=83=BD=E7=9A=84=E6=9B=B4=E5=A4=9A=E8=
=AF=A6=E7=BB=86=E4=BF=A1=E6=81=AF=E3=80=82
> diff --git a/Documentation/translations/zh_CN/dev-tools/index.rst b/Docum=
entation/translations/zh_CN/dev-tools/index.rst
> index 77a8c44cdf49..02577c379007 100644
> --- a/Documentation/translations/zh_CN/dev-tools/index.rst
> +++ b/Documentation/translations/zh_CN/dev-tools/index.rst
> @@ -25,6 +25,7 @@ Documentation/translations/zh_CN/dev-tools/testing-over=
view.rst
>     sparse
>     gcov
>     kasan
> +   gdb-kernel-debugging
> =20
>  Todolist:
> =20
> @@ -34,7 +35,6 @@ Todolist:
>   - kmemleak
>   - kcsan
>   - kfence
> - - gdb-kernel-debugging
>   - kgdb
>   - kselftest
>   - kunit/index
> --=20
> 2.17.1

--ue57ZUD7o2z13jL/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEERbo3U5kJpaCtFl1PtlsoEiKCsIUFAmKAcI8ACgkQtlsoEiKC
sIUk7Av/ZVljAkdAC9BF0JfvES9MgU+l4kLJFyEkVolYRFEh0Sm5S4EqHCj9zfq/
8t/guRo2M42wT0sZB2iBbuYBzX5V7TKStATyUjdZf0fwOxBsxBjQ3YDnfIAnhOor
u+uX3vKIvsXxIarPEf7XLeWq2544JG/a1QQl2ZTrH9UTCXjBCqrRNyF7VbXlwqIm
4JAo8TjjZWJ2JzBxGOpyPceoTzTJT0U3I0E2tYjScci2iykHCd15iLmfZ2y5nGnH
pGntiE434REXodygr+XGncDK9MeYQxdIKgEUpu7MXte94cbU0PBZ3A04axmXSOpI
RGUxpaW95MaG00Euc9S7jCUyBZUhQUdxEKe8VuPLbb/cwNyWF/+jFE/lCrPAdV2F
7tYZY0gg4DiJ7xzzyGR55nXmEJXU8FlcK8VIFC25H0/EtFQ8ykLSd9UK0bS0RPos
hB7lkGOOTaDt34qt0gGvMygmjS242K6axBgNzZkQHHOaKsFcnY1we4WDyDywC3Jy
N0qXnjma
=lVVL
-----END PGP SIGNATURE-----

--ue57ZUD7o2z13jL/--

