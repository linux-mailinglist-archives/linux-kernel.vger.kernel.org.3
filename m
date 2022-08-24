Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1503359FD09
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 16:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238857AbiHXOQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 10:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237112AbiHXOQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 10:16:39 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B62C98C90;
        Wed, 24 Aug 2022 07:16:38 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id u6so17181769eda.12;
        Wed, 24 Aug 2022 07:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc;
        bh=sgXwzTE7PsRoGXGsEWvvJy3bjeYUp3GXgCssBMLKSbM=;
        b=ntIIg7M12WoPDHIFdzktTZmM4lbDKFYiMUz47h2tOigaM2cniK+LBw5QJ2aE+D+7ko
         Vh7+eqTlHxZIg2c1sl0MvBmMA3/8sIYEPwZptf+uaYe6NsgaCkZSK3P47sZskg0vCZXj
         RHGloHJMg9crKfWRLFYrxex1Ghu72pmw38dRZx0SjdpXbmDk0WInyRdxoHOxFxmOQBsJ
         TVCixA5ScCyN5OR+Hpg1vHuI5lGonXS+Uys15Ywbzo+RJUoNHSY2H2YB8LJyD/MiuWzk
         iJs+DIhcHTQEM8XEshTNFYb5xmMHUxrfbCREIhdZgiuFnimaTK7tKTuKry1DWAvX2bwb
         E9ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc;
        bh=sgXwzTE7PsRoGXGsEWvvJy3bjeYUp3GXgCssBMLKSbM=;
        b=F5qc+a7FEubIcDIPlxFZ4Io1ciCUmcDGJXbHWyo8KkgVbMT38Zu1/9u0nQs3AYWJ/u
         3KD1S390AE4LNev/Z2zyoV8lhmkaeAm+G/fLFwJQN8Ip5Y8o7dr3+6E5W0FR3YBLuRck
         8/yTUJtNvP/C7e9CQroacrSlYIE+PyPzZTl7R/Q/czGNOXEPXJ/uLtJfvc0ZlP/3hcui
         YMMZ1vN1NfaBMRE0V0Q/brWAB0KCjZQwrRD88CJUUaVApQCeuePUKJlFhXFeGmIQ3Ed9
         2MezhYd/XqQFLZtSk0Mg459/dn61M8yAfd+QEr180nqLogzziKgHXMiqkRQM90TPBheB
         t0Dg==
X-Gm-Message-State: ACgBeo2Ms013+BMqtmp14BGQVHnZ3VrWuCNkduX8BYxhgRiG9iItv/R9
        2OrpzitlSCQWJ4cMV/LZrm8=
X-Google-Smtp-Source: AA6agR6P9U7JabkSVHHrN7PBF9puqHX/MzaQ3ImlMfPCJ66pUmJwVBsRFp/I9N0MJMAerF3JRMx/2A==
X-Received: by 2002:a05:6402:2b98:b0:43e:107:183d with SMTP id fj24-20020a0564022b9800b0043e0107183dmr7793838edb.366.1661350597157;
        Wed, 24 Aug 2022 07:16:37 -0700 (PDT)
Received: from [10.176.234.249] ([137.201.254.41])
        by smtp.googlemail.com with ESMTPSA id b2-20020a17090630c200b0072b92daef1csm902876ejb.146.2022.08.24.07.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 07:16:36 -0700 (PDT)
Message-ID: <347dae29c07fe13e6974b0e59e127c399f63ef69.camel@gmail.com>
Subject: Re: [PATCH] scsi: ufs: ufsfbo: Introduce File Based Optimization
 feature
From:   Bean Huo <huobean@gmail.com>
To:     Jiaming Li <lijiamingsofine@gmail.com>, avri.altman@wdc.com,
        alim.akhtar@samsung.com, jejb@linux.ibm.com, bvanassche@acm.org
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        lijiaming3 <lijiaming3@xiaomi.com>
Date:   Wed, 24 Aug 2022 16:16:35 +0200
In-Reply-To: <20220824084633.14428-1-lijiamingsofine@gmail.com>
References: <20220824084633.14428-1-lijiamingsofine@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-08-24 at 16:46 +0800, Jiaming Li wrote:
> From: lijiaming3 <lijiaming3@xiaomi.com>
>=20
> Implement File Based Optimization initialization and add sysfs
> interface.
>=20
> Stoage devices have a long lifespan. Device performance over its
> lifespan is not constant and may deteriorate over time
>=20
> This feature describes a method to improve the performance
> regression.
> The host needs to provide File System information to storage device
> first. Based on that information device analyzes the file system data
> and provides the host the level of performance regression. The host
> then may instruct the device to execute optimization procedure to
> improve the regression level.
>=20
> Signed-off-by: lijiaming3 <lijiaming3@xiaomi.com>
> ---
> =C2=A0arch/arm64/configs/defconfig |=C2=A0=C2=A0=C2=A0 1 +
> =C2=A0drivers/scsi/ufs/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=
=A0 9 +
> =C2=A0drivers/scsi/ufs/Makefile=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 1 +
> =C2=A0drivers/scsi/ufs/ufs.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
=C2=A0 13 +
> =C2=A0drivers/scsi/ufs/ufsfbo.c=C2=A0=C2=A0=C2=A0 | 1007
> ++++++++++++++++++++++++++++++++++
> =C2=A0drivers/scsi/ufs/ufsfbo.h=C2=A0=C2=A0=C2=A0 |=C2=A0 143 +++++
> =C2=A0drivers/scsi/ufs/ufshcd.c=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 15 +
> =C2=A0drivers/scsi/ufs/ufshcd.h=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 7 +=
-
> =C2=A08 files changed, 1195 insertions(+), 1 deletion(-)
> =C2=A0create mode 100644 drivers/scsi/ufs/ufsfbo.c
> =C2=A0create mode 100644 drivers/scsi/ufs/ufsfbo.h
>=20
> diff --git a/arch/arm64/configs/defconfig
> b/arch/arm64/configs/defconfig
> index 4972a81d40d6..1363c237b6f3 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -289,6 +289,7 @@ CONFIG_SCSI_UFSHCD_PLATFORM=3Dy
> =C2=A0CONFIG_SCSI_UFS_QCOM=3Dm
> =C2=A0CONFIG_SCSI_UFS_HISI=3Dy
> =C2=A0CONFIG_SCSI_UFS_EXYNOS=3Dy
> +CONFIG_SCSI_UFS_FBO=3Dy
> =C2=A0CONFIG_ATA=3Dy
> =C2=A0CONFIG_SATA_AHCI=3Dy
> =C2=A0CONFIG_SATA_AHCI_PLATFORM=3Dy
> diff --git a/drivers/scsi/ufs/Kconfig b/drivers/scsi/ufs/Kconfig
> index 432df76e6318..57b0e8b14543 100644
> --- a/drivers/scsi/ufs/Kconfig
> +++ b/drivers/scsi/ufs/Kconfig
> @@ -199,3 +199,12 @@ config SCSI_UFS_FAULT_INJECTION
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0help
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Enable fault injec=
tion support in the UFS driver. This
> makes it easier
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 to test the UFS er=
ror handler and abort handler.
> +
> +config SCSI_UFS_FBO
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool "Support UFS File-based O=
ptimization"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0depends on SCSI_UFSHCD
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0help
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The UFS FBO feature improves =
Sequential read performance.
> The Host can
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 send the LBA to device. The d=
evice will return a fragmented
> state. It
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 is up to the host to decide w=
hether to defrag. After
> defragment,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Sequential read performance i=
s improved
> \ No newline at end of file
> diff --git a/drivers/scsi/ufs/Makefile b/drivers/scsi/ufs/Makefile
> index c407da9b5171..956be0738263 100644
> --- a/drivers/scsi/ufs/Makefile
> +++ b/drivers/scsi/ufs/Makefile
> @@ -9,6 +9,7 @@ ufshcd-core-$(CONFIG_DEBUG_FS)=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0+=3D ufs-
> debugfs.o
> =C2=A0ufshcd-core-$(CONFIG_SCSI_UFS_BSG)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0+=
=3D ufs_bsg.o
> =C2=A0ufshcd-core-$(CONFIG_SCSI_UFS_CRYPTO)=C2=A0=C2=A0+=3D ufshcd-crypto=
.o
> =C2=A0ufshcd-core-$(CONFIG_SCSI_UFS_HPB)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0+=
=3D ufshpb.o
> +ufshcd-core-$(CONFIG_SCSI_UFS_FBO)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0+=3D ufs=
fbo.o
> =C2=A0ufshcd-core-$(CONFIG_SCSI_UFS_FAULT_INJECTION) +=3D ufs-fault-
> injection.o
> =C2=A0
> =C2=A0obj-$(CONFIG_SCSI_UFS_DWC_TC_PCI) +=3D tc-dwc-g210-pci.o ufshcd-dwc=
.o
> tc-dwc-g210.o
> diff --git a/drivers/scsi/ufs/ufs.h b/drivers/scsi/ufs/ufs.h
> index 8c6b38b1b142..b750ce3f7de9 100644
> --- a/drivers/scsi/ufs/ufs.h
> +++ b/drivers/scsi/ufs/ufs.h
> @@ -170,6 +170,7 @@ enum desc_idn {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0QUERY_DESC_IDN_GEOMETRY=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D 0x7,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0QUERY_DESC_IDN_POWER=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D 0x=
8,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0QUERY_DESC_IDN_HEALTH=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 0x9,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0QUERY_DESC_IDN_FBO=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 0xA,
Hi Jiaming,=20

Is this a UFS extended standard or vendor specific feature?



