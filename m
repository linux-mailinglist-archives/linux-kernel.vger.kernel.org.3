Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A63244E2627
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 13:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347229AbiCUMPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 08:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240603AbiCUMPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 08:15:24 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1399E5BD30
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 05:13:59 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id bi12so29455706ejb.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 05:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=mime-version:content-transfer-encoding:date:message-id:cc:subject
         :from:to:references:in-reply-to;
        bh=GV9VS8/cK/1/iW9YwiyL0XBgA3aSl8hWOkl7GPVanBI=;
        b=oeeLLGNl+r00f+caIK1YerzgsZi2O6Q8Uy2jH+Lwvodzm/uQ35vn5qgQMf/Cv/Y9uY
         9WsRgsBT0RWbJQQ/RvzwPzMmmET8xQjjSO3su7t4qJYzHQt3PUIsvEqfPxEFpYEXSX2Z
         Iu2iStywN8Kbl8QHmo7hDsFxdjGFlHSZlchAqGIafE07vsa3MiVeTSQzBjHlY4nUGcRy
         Q5+MqIJBySRDEwgiqztxIqc7BVb61MRmlwhIAjbJgGM4mvp8sXZA2CpKvYXOhca9o52k
         hFU+z0JA9op8VQOwt6z5ARTuRooAdTr6lvq50hK7JNUWFDAoHxKsiatP/eIkg/FKNYWt
         IwWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:cc:subject:from:to:references:in-reply-to;
        bh=GV9VS8/cK/1/iW9YwiyL0XBgA3aSl8hWOkl7GPVanBI=;
        b=7Fr5M6Uacb4x5K9zTb6Dd8SOlMxzSJ5YQj9wyY8GyeIA6WCGMpLp1ec0PqjTI9hsC+
         ceGD6xUAfhKbGL8bAnmlcNd8TEVo3lMOiAT5BgDFo8GywdpShqnIqdS0dzCtM3trhVl1
         n7+mnm3be8OSo/dajThvERxBQiqcUWE3n47mMexjv7AJoYv2amP35Lcu6HhcUH/SvU44
         hs6lJpIlRBQc3JCC/zBVntxOIyBSJ4oPvlxBS2LZY1PysNyg9kHhpiTDY9eeR2EigHWw
         dpmtaV/Qb8kbRHPnrtpLHJbqbadtidEx/YNs3IBvdbtpmXIxPBIL61ql9fakguA2N9ZZ
         FFfg==
X-Gm-Message-State: AOAM532k/jgNwKdx8CbHVbXhYWSzvQPzrU8TitXYNvZ/SH9Ycz71Hqhm
        moEygYV/cB/uh/cTbgpAidYLGA==
X-Google-Smtp-Source: ABdhPJzk0Uo89eWPVkk1mZyIW81aW02eGMZ3uIYZYeJU3QCXjfMCisnD4hgsFfd/spI4KZhqel5v5w==
X-Received: by 2002:a17:906:3cb1:b0:6ce:2a97:5ade with SMTP id b17-20020a1709063cb100b006ce2a975ademr20035718ejh.728.1647864837621;
        Mon, 21 Mar 2022 05:13:57 -0700 (PDT)
Received: from localhost (a246182.upc-a.chello.nl. [62.163.246.182])
        by smtp.gmail.com with ESMTPSA id a4-20020a170906274400b006da9456e802sm6941623ejd.102.2022.03.21.05.13.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 05:13:57 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 21 Mar 2022 13:13:56 +0100
Message-Id: <CIPJBZ36YCV6.2J3QWEURX2EEQ@otso>
Subject: Re: [RFT] ufs: qcom: drop custom Android boot parameters
From:   "Luca Weiss" <luca.weiss@fairphone.com>
To:     "Luca Weiss" <luca.weiss@fairphone.com>,
        "Krzysztof Kozlowski" <krzk@kernel.org>,
        "Andy Gross" <agross@kernel.org>,
        "Bjorn Andersson" <bjorn.andersson@linaro.org>,
        "Alim Akhtar" <alim.akhtar@samsung.com>,
        "Avri Altman" <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220320110616.18355-1-krzk@kernel.org>
 <CIPJ0CT6EQI9.2C0T9KAHDODH2@otso>
In-Reply-To: <CIPJ0CT6EQI9.2C0T9KAHDODH2@otso>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all again,

On Mon Mar 21, 2022 at 12:58 PM CET, Luca Weiss wrote:
> Hi Krzysztof,
>
> On Sun Mar 20, 2022 at 12:06 PM CET, Krzysztof Kozlowski wrote:
> > The QCOM UFS driver requires an androidboot.bootdevice command line
> > argument matching the UFS device name.  If the name is different, it
> > refuses to probe.  Thise androidboot.bootdevice is provided by
> > stock/vendor (from an Android-based device) bootloader.
> >
> > This does not make sense from Linux point of view.  Driver should be
> > able to boot regardless of bootloader.  Driver should not depend on som=
e
> > Android custom environment data.
> >
> > Cc: Luca Weiss <luca.weiss@fairphone.com>
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>
> As expected this makes UFS probe even if the node is named ufs@1d84000
> on my device.
>
> While I don't know why the code existed in the first place, it was added
> back in 2015 with the introduction of the driver, so probably it's just
> some remains from downstream that weren't cleaned up back then.

I went digging a bit and found the original commit from downstream:
https://source.codeaurora.org/quic/la/kernel/msm-3.18/commit/?id=3D15e2c78d=
6a7ec73be941e058671942fd9f72b128

<quote>
Boot device can be either UFS or eMMC which means if eMMC is the boot
device, probing UFS device is not desirable as it's not going to be
used after probing. Kernel command line parameter "android.bootdevice"
tells the kernel about the boot device so look at this boot device
parameter to know whether to probe UFS device or not.
</quote>

Should be safe to remove.

Regards
Luca


>
> With this commit also 6b9afd8f96c6 ("arm64: dts: qcom: sm8250: change
> ufs node name to ufshc") could be reverted (but it would probably make
> more sense to rename all ufshc@ to ufs@ in a new commit).
>
> Tested-by: Luca Weiss <luca.weiss@fairphone.com>
>
> Regards
> Luca
>
> >
> > ---
> >
> > Not tested, please kindly provide tests.
> >
> > See also:
> > https://lore.kernel.org/linux-devicetree/f61abc2b-3ce8-7b1f-3d28-8a4a03=
ec58eb@kernel.org/T/#u
> > ---
> >  drivers/scsi/ufs/ufs-qcom.c | 15 ---------------
> >  1 file changed, 15 deletions(-)
> >
> > diff --git a/drivers/scsi/ufs/ufs-qcom.c b/drivers/scsi/ufs/ufs-qcom.c
> > index 0d2e950d0865..586c0e567ff9 100644
> > --- a/drivers/scsi/ufs/ufs-qcom.c
> > +++ b/drivers/scsi/ufs/ufs-qcom.c
> > @@ -957,18 +957,6 @@ static const struct reset_control_ops ufs_qcom_res=
et_ops =3D {
> >  	.deassert =3D ufs_qcom_reset_deassert,
> >  };
> > =20
> > -#define	ANDROID_BOOT_DEV_MAX	30
> > -static char android_boot_dev[ANDROID_BOOT_DEV_MAX];
> > -
> > -#ifndef MODULE
> > -static int __init get_android_boot_dev(char *str)
> > -{
> > -	strlcpy(android_boot_dev, str, ANDROID_BOOT_DEV_MAX);
> > -	return 1;
> > -}
> > -__setup("androidboot.bootdevice=3D", get_android_boot_dev);
> > -#endif
> > -
> >  /**
> >   * ufs_qcom_init - bind phy with controller
> >   * @hba: host controller instance
> > @@ -988,9 +976,6 @@ static int ufs_qcom_init(struct ufs_hba *hba)
> >  	struct resource *res;
> >  	struct ufs_clk_info *clki;
> > =20
> > -	if (strlen(android_boot_dev) && strcmp(android_boot_dev, dev_name(dev=
)))
> > -		return -ENODEV;
> > -
> >  	host =3D devm_kzalloc(dev, sizeof(*host), GFP_KERNEL);
> >  	if (!host) {
> >  		err =3D -ENOMEM;
> > --=20
> > 2.32.0

