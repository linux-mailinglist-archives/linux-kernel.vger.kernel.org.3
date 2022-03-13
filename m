Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5504D74C8
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 12:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234666AbiCMLB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 07:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234654AbiCMLBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 07:01:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD3ED4464;
        Sun, 13 Mar 2022 04:00:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C328CB80CA9;
        Sun, 13 Mar 2022 11:00:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9060C340EC;
        Sun, 13 Mar 2022 11:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647169213;
        bh=K6raQ3hcVYXvtlWvYXOLgzshf6ywpYtouqfgtS4XSgI=;
        h=Date:From:Cc:Subject:In-Reply-To:References:From;
        b=f6FajvJWGzBUEAJpip4FTCW+ziT2N4Fes+bwxhm6P4X7wHhwUaOMcP7i6caQXwqAV
         SWFJaTRBzr7UeVqgZ+iQvK2L3/es8ZmF5h5H5xaq7iNbSQ7hOWUmfOoqgkr4yH0Kyi
         NtI8zelQGEh4QkIsNyt+pRe1NmA2S5GeVN6NyJtGOiToEcx9OvPpDe6BbFPYjsJ0TW
         Q2BxYhRUItV5G1A7lThY+qbpnEFFMkYGlshPOVw01Xmd9feBk2BRWRn4e0xWiwwXF3
         /6jc7G1QK35edetsIKmeke+nHWz8o2iqh3gG38fXqgG+tLtV3iKAFRUZpClo/8XJVp
         Lk/RW6spFk5+g==
Date:   Sun, 13 Mar 2022 12:00:02 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eddie James <eajames@linux.ibm.com>,
        Fabio Estevam <festevam@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Mikhail Ulyanov <mikhail.ulyanov@cogentembedded.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sylwester Nawrocki <sylvester.nawrocki@gmail.com>,
        Yong Deng <yong.deng@magewell.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
        openbmc@lists.ozlabs.org
Subject: Re: [PATCH 00/24] Organize media platform drivers per manufacturer
Message-ID: <20220313120002.0d782ce7@coco.lan>
In-Reply-To: <cover.1647167750.git.mchehab@kernel.org>
References: <cover.1647167750.git.mchehab@kernel.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, 13 Mar 2022 11:51:41 +0100
Mauro Carvalho Chehab <mchehab@kernel.org> escreveu:

> This series comes after the one I sent earlier today sorting media/platform Makefile and Kconfig.
> 
> It basically groups all drivers per vendor, ensuring that each vendor has a Makefile/Kconfig
> pair.
> 
> The end goal is to keep the platform Makefile/Kconfig clean and easier to maintain, less
> prune to errors. After applying both series, the size of such files were drastically reduced:
> 
> 	 drivers/media/platform/Kconfig  |  731 ++------------------------------
> 	 drivers/media/platform/Makefile |  115 +----
> 	 2 files changed, 78 insertions(+), 768 deletions(-)
> 
> Mauro Carvalho Chehab (24):
>   media: platform: rename coda/ to chips-media/
>   media: platform: rename marvell-ccic/ to marvell/
>   media: platform: rename meson/ge2d/ to amlogic/meson-ge2d/
>   media: platform: rename mtk-jpeg/ to mediatek/mtk-jpeg/
>   media: platform: rename mtk-mdp/ to mediatek/mtk-mdp/
>   media: platform: rename mtk-vcodec/ to mediatek/mtk-vcodec/
>   media: platform: rename mtk-vpu/ to mediatek/mtk-vpu/
>   media: platform: rename sunxi/ to allwinner/
>   media: platform: rename tegra/vde/ to nvidia/tegra-vde/
>   media: platform: rename amphion/ to nxp/amphion/
>   media: platform: rename exynos4-is/ to samsung/exynos4-is/
>   media: platform: rename exynos-gsc/ to samsung/exynos-gsc/
>   media: platform: rename s3c-camif/ to samsung/s3c-camif/
>   media: platform: rename s5p-g2d/ to samsung/s5p-g2d/
>   media: platform: rename s5p-jpeg/ to samsung/s5p-jpeg/
>   media: platform: rename s5p-mfc/ to samsung/s5p-mfc/
>   media: platform: rename stm32/ to sti/stm32/
>   media: platform: rename am437x/ to ti/am437x/
>   media: platform: rename davinci/ to ti/davinci/
>   media: platform: rename omap3isp/ to ti/omap3isp/
>   media: platform: rename omap/ to ti/omap/
>   media: platform: rename ti-vpe/ to ti/vpe/
>   media: platform: Create vendor/{Makefile,Kconfig} files

Worth mention that, while the above changes are really trivial, it is
no fun to do them individually. It is also subject to errors.

So, after manually doing a couple of them, I decided to revert
to the original state and do it via the script below, checking
the patches and editing the last one.

Thanks,
Mauro

---

#!/bin/bash -e

export LC_ALL=C # Needed by sort

TMP=$(mktemp /tmp/rename.XXXXXXXXX)

trap 'catch $LINENO' ERR SIGINT
catch()
{
	echo "Error on line $1"
	rm $TMP || true
	exit 1
}

sort_makefile()
{
	# sort Makefile
	sed '/^obj-y/Q' drivers/media/platform/Makefile> $TMP
	grep "^obj-y" drivers/media/platform/Makefile |sort | uniq >> $TMP
	cat <<EOF >> $TMP

# Please place here only ancillary drivers that aren't SoC-specific
# Please keep it alphabetically sorted by Kconfig name
# (e. g. LC_ALL=C sort Makefile)
obj-\$(CONFIG_VIDEO_MEM2MEM_DEINTERLACE)	+= m2m-deinterlace.o
obj-\$(CONFIG_VIDEO_MUX)			+= video-mux.o
EOF
	mv $TMP drivers/media/platform/Makefile
}

sort_kconfig()
{
	# sort Kconfig
	sed '/^source/Q' drivers/media/platform/Kconfig> $TMP
	grep "^source" drivers/media/platform/Kconfig |sort | uniq >> $TMP
	cat <<EOF >> $TMP

endif # MEDIA_PLATFORM_DRIVERS
EOF

	mv $TMP drivers/media/platform/Kconfig
}

do_rename_vendor()
{
	old=$(echo $1 |perl -ne 's,/$,,; print $_')
	new=$(echo $2 |perl -ne 's,/$,,; print $_')

	echo "$old -> $new"

	mkdir -p dirname drivers/media/platform/$new

	git mv drivers/media/platform/$old/* drivers/media/platform/$new/

	sed s,$old/,$new/, -i $(find drivers/media/platform/ -name Kconfig) $(find drivers/media/platform/ -name Makefile)
	sed s,drivers/media/platform/$old,drivers/media/platform/$new, -i $(git grep -l drivers/media/platform/$old) || true

	# Remove obj files, to make the directory cleaner
	rm -rf drivers/media/platform/$old/ || true

	sort_makefile
	sort_kconfig

	cat <<EOF >> $TMP
media: platform: rename $old/ to $new/

As the end goal is to have platform drivers split by vendor,
rename $old/ to $new/.
EOF

	git commit -as -m "$(cat $TMP)" --no-edit
}

do_rename_vendor coda chips-media
do_rename_vendor marvell-ccic/ marvell/
do_rename_vendor meson/ge2d/ amlogic/meson-ge2d/
do_rename_vendor mtk-jpeg mediatek/mtk-jpeg
do_rename_vendor mtk-mdp mediatek/mtk-mdp
do_rename_vendor mtk-vcodec mediatek/mtk-vcodec
do_rename_vendor mtk-vpu mediatek/mtk-vpu
do_rename_vendor sunxi/ allwinner/
do_rename_vendor tegra/vde nvidia/tegra-vde
do_rename_vendor amphion nxp/amphion
do_rename_vendor exynos4-is/ samsung/exynos4-is/
do_rename_vendor exynos-gsc samsung/exynos-gsc
do_rename_vendor s3c-camif samsung/s3c-camif
do_rename_vendor s5p-g2d samsung/s5p-g2d
do_rename_vendor s5p-jpeg samsung/s5p-jpeg
do_rename_vendor s5p-mfc samsung/s5p-mfc
do_rename_vendor stm32 sti/stm32
do_rename_vendor am437x/ ti/am437x/
do_rename_vendor davinci ti/davinci
do_rename_vendor omap3isp ti/omap3isp
do_rename_vendor omap ti/omap
do_rename_vendor ti-vpe ti/vpe

# Create or update drivers/media/platform/*/Kconfig

IFS=$'\n'

# Fixup Kconfig files
for i in $(cat drivers/media/platform/Kconfig|perl -ne 'if (m,platform/([^/]+)/([^/]+)/Kconfig,) { print "$1 $2\n" }'); do
        echo "Handling $i Kconfig entries"

        a=$(echo $i|cut -d' ' -f1)
        b=$(echo $i|cut -d' ' -f2)

	kconfig="drivers/media/platform/$a/$b/Kconfig"
	parent="drivers/media/platform/$a/Kconfig"

        if [ ! -e $parent ]; then
                echo "creating $parent..."
                echo "# SPDX-License-Identifier: GPL-2.0" > $parent
		git add $parent
        fi

        echo "source \"$kconfig\"" >> drivers/media/platform/$a/Kconfig
        echo "source \"$parent\"" >> drivers/media/platform/Kconfig

        sed s,$kconfig,$parent, -i drivers/media/platform/Kconfig

        echo "sorting..."
	sort_kconfig
done

# Create or update drivers/media/platform/*/Makefile

for i in $(cat drivers/media/platform/Makefile|perl -ne 'if (m,.*=\s*([^/]+)/([^/]+)/,) { print "$1 $2\n" }'); do
        echo "Handling $i Makefile entries"

        a=$(echo $i|cut -d' ' -f1)
        b=$(echo $i|cut -d' ' -f2)

        make="$a/$b/"
        parent="$a/"

        if [ ! -e drivers/media/platform/$a/Makefile ]; then
                echo "creating $parent..."
                echo "# SPDX-License-Identifier: GPL-2.0" > drivers/media/platform/$a/Makefile
                git add drivers/media/platform/$a/Makefile
        fi
        echo "obj-y += $b/" >> drivers/media/platform/$a/Makefile
        echo "obj-y += $parent" >> drivers/media/platform/Makefile

        sed s,$make\$,$parent, -i drivers/media/platform/Makefile
done

sort_kconfig
sort_makefile

	cat <<EOF >> $TMP
media: platform: Create vendor/{Makefile,Kconfig} files

Instead of placing multiple per-vendor entries at the
platform/{Makefile,Kconfig}, create them at the per-vendor
directories.
EOF

git commit -as -m "$(cat $TMP)" --no-edit
