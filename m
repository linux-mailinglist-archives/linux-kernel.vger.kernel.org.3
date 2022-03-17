Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC8E64DCE8E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 20:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237903AbiCQTP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 15:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237737AbiCQTPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 15:15:23 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7AA670CE4;
        Thu, 17 Mar 2022 12:14:04 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220317191359euoutp0293bf57a3aa7dd1e39880163862eda720~dQPAudX9Y1430514305euoutp025;
        Thu, 17 Mar 2022 19:13:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220317191359euoutp0293bf57a3aa7dd1e39880163862eda720~dQPAudX9Y1430514305euoutp025
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1647544439;
        bh=f/dAY9gsmFr1CExmGbBwuXXGrNmXHcikJOcKyw5TX1o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qm0fhfR6Bjkj+0y5d6Z2ggrIi27pK4avPLxYHlTTDhDFjitMD+jDci/t6CQrLAqdz
         cmM+AKAtWEnZHH1M+lwzyX3PIKF+/Ys+Zw0e1y7toQyRFHqLV6Fr2YB90l5+ALAVpW
         EmM1Z5UIx9TxJ5lpeEi02PooViMBaLuUqDAVQssk=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220317191358eucas1p20530ce3e1ab693db885b731bbe80a6f3~dQPAfjd1v2487224872eucas1p2n;
        Thu, 17 Mar 2022 19:13:58 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id ED.2B.10260.67883326; Thu, 17
        Mar 2022 19:13:58 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220317191357eucas1p1abc9a313ef2f320bda365388e72e0327~dQO-dQbRn0714107141eucas1p1O;
        Thu, 17 Mar 2022 19:13:57 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220317191357eusmtrp19cb164d83986a272f6fa05d3fbe8e5d6~dQO-cYdX71445314453eusmtrp1r;
        Thu, 17 Mar 2022 19:13:57 +0000 (GMT)
X-AuditID: cbfec7f5-bddff70000002814-70-62338876d0e0
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 78.F3.09404.57883326; Thu, 17
        Mar 2022 19:13:57 +0000 (GMT)
Received: from localhost (unknown [106.120.51.46]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220317191357eusmtip27a1bd07e5280f6b2d3698a788606719f~dQO-LpM9D1842318423eusmtip23;
        Thu, 17 Mar 2022 19:13:57 +0000 (GMT)
From:   Lukasz Stelmach <l.stelmach@samsung.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Niklas =?utf-8?Q?S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Cai Huoqing <caihuoqing@baidu.com>,
        Dillon Min <dillon.minfei@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ming Qian <ming.qian@nxp.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: Re: [PATCH v2 52/67] media: platform: rename s5p-g2d/ to
 samsung/s5p-g2d/
Date:   Thu, 17 Mar 2022 20:13:37 +0100
In-Reply-To: <a26328cf8c9aaa8b5052102f205f1cfce6d69d2c.1647274407.git.mchehab@kernel.org>
        (Mauro Carvalho Chehab's message of "Mon, 14 Mar 2022 17:34:47 +0100")
Message-ID: <dleftja6domly6.fsf%l.stelmach@samsung.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg="pgp-sha256";
        protocol="application/pgp-signature"
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf0wTZxjH8/aud2217KwQ3jGzYIcBh7YuzO2MsmEk2bkMwxySbdmmFS6A
        0pa1Am4B6RAJYAXXLsMWQXRFGEJlBbHrYArJ1pQ6KqCUKDWk/igrCOnwB3XFjeMw8b/v8zyf
        7/PjzctDRJVYFC9HcYhWKWS5YkyAdv8ZHNxYUJGwf5PhTizZdmcBIy8E7gLycp8XJa/O21Fy
        yOBBSY+vDJC+M2ZAVn5vwknL3VEuOWI7jZHajktc8rwlxCFttVac9Dg2kNXTZoT8p+sJJ4mg
        HjUdRaifJ+tw6lejB6fqKgxc6r8xL0JZWisxqsHxMdVpKqHG55sA9cuMlUP5Rp5i1JzldWrg
        8RyeKvxcsC2Tzs0poFXS9/YJsrtqApy8Kcnhn2xlHA1wxlUBPg8Sb8Nqtx9UAQFPRLQAOHqt
        AWODRwCG5twchhIRcwC6SgtfOE54bqEs1Azgsbrm5cAH4M1SF7cK8HgYIYHt7Z8yhvBF6esc
        WmIQ4kcubHMOY0xhNZEGm939Sxol1kHdldtcBuIT5wDU688iTEFIvAuNrr4lKILYAkMPAjib
        XwUdhnsooxFCDg2u6aUjIDHDhwP37YDdNRmaLlpxVq+GfnvXsl4DnXotymwKiRKo173DerUA
        dp+eR1lmKxwffIaxejt8dnUSZ/kwOPZwFTs3DOq6axE2LYQV5SKWjoHmmp7lLlHwhL9leRsK
        3qhjujCP1QbgiOUBOAmijS+dY3zpHONiW4RYDy/apGw6Hp4/O4WwOhGazbNoI+C2gkg6Xy3P
        otUJCrpQopbJ1fmKLEmGUm4Biz/U+dz+2Apa/AFJP+DwQD+IWTR7Oy5cB1GoQqmgxeHCa5PS
        /SJhpuybb2mVcq8qP5dW94PXeKg4UpiR0yETEVmyQ/RBms6jVS+qHB4/SsNJijVEEAJ94ynx
        Z449M/W1XsH6I8PSI8GHTe1BU7piVttXH7T9XbR7a151T+moXrfSlfYk3ns86di9Nzb8Jr0O
        qlPDd5bctxZtFlSlJKQs9JUepYdjNF8+D49Y0Wv8rlAZN67sLbZdkiNlXzWsXXnK7C7+PX3B
        MpB4JtZ9riwu7+mBkt4Jrpmf3JWxaezm4Z6Dl3ek/PWJ4nivd3t8jd8fjei2vHLj6/cd00FZ
        Kz6xTRqZvgvF0yo6xSs0/2r+CIueLfpQe2V30uD82vKPCuoPTIBQsn1cN7Wj3JgoofdmBmoS
        dTudEamh4s17siNNxa+2Ec2iLz5w5f8wRK8Jq29EZWJUnS17601EpZb9D8280yccBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgleLIzCtJLcpLzFFi42I5/e/4Pd3SDuMkg29HZS3W3PvLZrH642NG
        i+0HH7FYHPhxnMXi4sy7LBZ3n7cwWjyfv47RonPiEnaLTY+vsVpc3jWHzaJnw1ZWi2Wb/jBZ
        7Jq+g93i7kkdi74365gtPm35xuQg4PFlaTOzx8oXs9k9ds66y+4xu2Mmq8f/G4+YPTat6mTz
        mHcy0GPzknqPOz+WMnpsfLeDyeP55e9sHp83yXmc+vqZPYA3Ss+mKL+0JFUhI7+4xFYp2tDC
        SM/Q0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS9jS/9HpoLXehWLd7UwNTCe1uhi5OSQ
        EDCR6L17i6WLkYtDSGApo8SPg5sYuxg5gBJSEivnpkPUCEv8udbFBmILCTxllLhyJQWkhE1A
        T2Lt2giQsAiQ+XzzRbAxzAJzWCVWnXgNVi8sECKx/PohqN4IiU/HJ4PZLAKqEpP232YFaeAU
        WMQoMXnyQmaQBK+AucSs8wfBikQFLCX+PPvIDhEXlDg58wkLiM0skC3xdfVz5gmMArOQpGYh
        Sc0Cuo9ZQFNi/S59iLC2xLKFr5khbFuJdevesyxgZF3FKJJaWpybnltspFecmFtcmpeul5yf
        u4kRGP3bjv3csoNx5auPeocYmTgYDzGqAHU+2rD6AqMUS15+XqqSCO+ZF/pJQrwpiZVVqUX5
        8UWlOanFhxhNgX6byCwlmpwPTEt5JfGGZgamhiZmlgamlmbGSuK8ngUdiUIC6YklqdmpqQWp
        RTB9TBycUg1M+kUuIZ6rTEM/X9g08Wxj3p0SV5X1Ngt3lCe7ORw4udTnSW7AW5HzHF2VOYz+
        Xf7WHid74vWYiwT2Cd/Z83pe7J1yVUve8l3z9y7YbTZ3059MlbQ5N16dyXiYeMcuNqPu+dtk
        oQT3Ne+S/pQ+y1+0yL+k6s5m9lSXZWePtkfOtNhfrvr1hnjNAsGdK9fxpstZNoTPLtlS4tUt
        EKMhev98wSy/7wp3bIyFLet8l9wsrmg2s5uXElSiEH3XPpjl4iaVRfnyn3ZMOG1b0rZeMSot
        1Lh78tY6j86KM80uYo8Dvx5y3G57ryouoKA/4vusOL8nOy82xJvvy9zzsXuFGVd5ybkfndcF
        2vV3NDgfMFZiKc5INNRiLipOBAABRmvpkwMAAA==
X-CMS-MailID: 20220317191357eucas1p1abc9a313ef2f320bda365388e72e0327
X-Msg-Generator: CA
X-RootMTR: 20220317191357eucas1p1abc9a313ef2f320bda365388e72e0327
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220317191357eucas1p1abc9a313ef2f320bda365388e72e0327
References: <a26328cf8c9aaa8b5052102f205f1cfce6d69d2c.1647274407.git.mchehab@kernel.org>
        <CGME20220317191357eucas1p1abc9a313ef2f320bda365388e72e0327@eucas1p1.samsung.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

It was <2022-03-14 pon 17:34>, when Mauro Carvalho Chehab wrote:
> As the end goal is to have platform drivers split by vendor,
> rename s5p-g2d/ to samsung/s5p-g2d/.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> ---
>
> To avoid mailbombing on a large number of people, only mailing lists were=
 C/C on the cover.
> See [PATCH v2 00/67] at: https://lore.kernel.org/all/cover.1647274406.git=
.mchehab@kernel.org/
>
>  MAINTAINERS                                             | 2 +-
>  drivers/media/platform/Kconfig                          | 2 +-
>  drivers/media/platform/Makefile                         | 2 +-
>  drivers/media/platform/{ =3D> samsung}/s5p-g2d/Kconfig    | 0
>  drivers/media/platform/{ =3D> samsung}/s5p-g2d/Makefile   | 0
>  drivers/media/platform/{ =3D> samsung}/s5p-g2d/g2d-hw.c   | 0
>  drivers/media/platform/{ =3D> samsung}/s5p-g2d/g2d-regs.h | 0
>  drivers/media/platform/{ =3D> samsung}/s5p-g2d/g2d.c      | 0
>  drivers/media/platform/{ =3D> samsung}/s5p-g2d/g2d.h      | 0
>  9 files changed, 3 insertions(+), 3 deletions(-)
>  rename drivers/media/platform/{ =3D> samsung}/s5p-g2d/Kconfig (100%)
>  rename drivers/media/platform/{ =3D> samsung}/s5p-g2d/Makefile (100%)
>  rename drivers/media/platform/{ =3D> samsung}/s5p-g2d/g2d-hw.c (100%)
>  rename drivers/media/platform/{ =3D> samsung}/s5p-g2d/g2d-regs.h (100%)
>  rename drivers/media/platform/{ =3D> samsung}/s5p-g2d/g2d.c (100%)
>  rename drivers/media/platform/{ =3D> samsung}/s5p-g2d/g2d.h (100%)
>

Acked-by: =C5=81ukasz Stelmach <l.stelmach@samsung.com>

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 80f2a0eea3f7..4b03db9ee31e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2616,7 +2616,7 @@ M:	=C5=81ukasz Stelmach <l.stelmach@samsung.com>
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  L:	linux-media@vger.kernel.org
>  S:	Maintained
> -F:	drivers/media/platform/s5p-g2d/
> +F:	drivers/media/platform/samsung/s5p-g2d/
>=20=20
>  ARM/SAMSUNG S5P SERIES HDMI CEC SUBSYSTEM SUPPORT
>  M:	Marek Szyprowski <m.szyprowski@samsung.com>
> diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kcon=
fig
> index aed4394ddd05..8dd178e1a359 100644
> --- a/drivers/media/platform/Kconfig
> +++ b/drivers/media/platform/Kconfig
> @@ -88,12 +88,12 @@ source "drivers/media/platform/omap3isp/Kconfig"
>  source "drivers/media/platform/qcom/Kconfig"
>  source "drivers/media/platform/renesas/Kconfig"
>  source "drivers/media/platform/rockchip/Kconfig"
> -source "drivers/media/platform/s5p-g2d/Kconfig"
>  source "drivers/media/platform/s5p-jpeg/Kconfig"
>  source "drivers/media/platform/s5p-mfc/Kconfig"
>  source "drivers/media/platform/samsung/exynos-gsc/Kconfig"
>  source "drivers/media/platform/samsung/exynos4-is/Kconfig"
>  source "drivers/media/platform/samsung/s3c-camif/Kconfig"
> +source "drivers/media/platform/samsung/s5p-g2d/Kconfig"
>  source "drivers/media/platform/sti/Kconfig"
>  source "drivers/media/platform/stm32/Kconfig"
>  source "drivers/media/platform/ti-vpe/Kconfig"
> diff --git a/drivers/media/platform/Makefile b/drivers/media/platform/Mak=
efile
> index cb5e6d1df248..aa822365d8d0 100644
> --- a/drivers/media/platform/Makefile
> +++ b/drivers/media/platform/Makefile
> @@ -30,12 +30,12 @@ obj-y +=3D qcom/venus/
>  obj-y +=3D renesas/
>  obj-y +=3D rockchip/rga/
>  obj-y +=3D rockchip/rkisp1/
> -obj-y +=3D s5p-g2d/
>  obj-y +=3D s5p-jpeg/
>  obj-y +=3D s5p-mfc/
>  obj-y +=3D samsung/exynos-gsc/
>  obj-y +=3D samsung/exynos4-is/
>  obj-y +=3D samsung/s3c-camif/
> +obj-y +=3D samsung/s5p-g2d/
>  obj-y +=3D sti/bdisp/
>  obj-y +=3D sti/c8sectpfe/
>  obj-y +=3D sti/delta/
> diff --git a/drivers/media/platform/s5p-g2d/Kconfig b/drivers/media/platf=
orm/samsung/s5p-g2d/Kconfig
> similarity index 100%
> rename from drivers/media/platform/s5p-g2d/Kconfig
> rename to drivers/media/platform/samsung/s5p-g2d/Kconfig
> diff --git a/drivers/media/platform/s5p-g2d/Makefile b/drivers/media/plat=
form/samsung/s5p-g2d/Makefile
> similarity index 100%
> rename from drivers/media/platform/s5p-g2d/Makefile
> rename to drivers/media/platform/samsung/s5p-g2d/Makefile
> diff --git a/drivers/media/platform/s5p-g2d/g2d-hw.c b/drivers/media/plat=
form/samsung/s5p-g2d/g2d-hw.c
> similarity index 100%
> rename from drivers/media/platform/s5p-g2d/g2d-hw.c
> rename to drivers/media/platform/samsung/s5p-g2d/g2d-hw.c
> diff --git a/drivers/media/platform/s5p-g2d/g2d-regs.h b/drivers/media/pl=
atform/samsung/s5p-g2d/g2d-regs.h
> similarity index 100%
> rename from drivers/media/platform/s5p-g2d/g2d-regs.h
> rename to drivers/media/platform/samsung/s5p-g2d/g2d-regs.h
> diff --git a/drivers/media/platform/s5p-g2d/g2d.c b/drivers/media/platfor=
m/samsung/s5p-g2d/g2d.c
> similarity index 100%
> rename from drivers/media/platform/s5p-g2d/g2d.c
> rename to drivers/media/platform/samsung/s5p-g2d/g2d.c
> diff --git a/drivers/media/platform/s5p-g2d/g2d.h b/drivers/media/platfor=
m/samsung/s5p-g2d/g2d.h
> similarity index 100%
> rename from drivers/media/platform/s5p-g2d/g2d.h
> rename to drivers/media/platform/samsung/s5p-g2d/g2d.h

=2D-=20
=C5=81ukasz Stelmach
Samsung R&D Institute Poland
Samsung Electronics

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXpuyqjq9kGEVr9UQsK4enJilgBAFAmIziGEACgkQsK4enJil
gBCBKAf+J72VboW3+su5GPEtJvDlwaQCuEySL4II+2co99kZPMrZ0baebScFS9HQ
pmPwAYbGgXwhVv6gmlmiG7jyVX29EGRmqBAR646ea48Id+9ZQOX3FxDdJBhx1hwT
vM0EL5UL1NVcw2xqM7BnNgohfqbpylaZnhzEfLdPF/k1n3Vywruy8XmIhNFxHl5u
lJ1grAwqHNp/fdZBOn+CQDWltpzoax/XHZBBR2s0xX9/YYE9AGUnD0SJG+EtzfKe
FMamVA9aqVDCdvJds+zX9WZwqdh6CHBECjbLNN3yEw5dqS98ezok1yUM+FBn8N98
yRNPkNyADhzXrxppgj9xPYtWiwQx2w==
=JMbw
-----END PGP SIGNATURE-----
--=-=-=--
