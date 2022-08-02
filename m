Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2DA587DF2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 16:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233883AbiHBOMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 10:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234097AbiHBOMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 10:12:19 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C47A51B7A1;
        Tue,  2 Aug 2022 07:12:17 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id bq11so17028982lfb.5;
        Tue, 02 Aug 2022 07:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=RDs6awO6VCv+ESUehDACchXulBPRYE1xCdDOQIT00OU=;
        b=ilqTGIgIgHGQ+3zthdqUAJskTvQ+6/u5bNroSJgRtYecDJ7LkMhgjtk87W1TnWNoxU
         aIhsMpzaPh1wJbXeCKGIVo8sP+UjMeK3yAJ28NUGLdXjZFASVErUewWisLsoW/6SCr1P
         tVlFRU/1nU03UybLsg6d14h+2NUvDog7DrWyAl4sht6+eeso9WLpflVxV15vVRl8PGkI
         J2qEPBpolzJ7CFIt2Yldvo/9AMvS6idj2LGcvlGIyTiPonXBLcdYJfa8N/Hz3GrqTylB
         9LBFv2iEzvAPm2oYyCGWeWYLKLFXCK6p6jHT7X7f+7OtBHH0XMrOXNyGJNL6ETYp5rx0
         ZoIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=RDs6awO6VCv+ESUehDACchXulBPRYE1xCdDOQIT00OU=;
        b=ie0ZGqUb6m9ipgKSNNWjJbzw69ZfhRfKrx0Qa/T8FAaRMpaJlNH+jVk+bqNVzfk6sw
         mRgJnzwESHO5y4dIcNpWJT8EGqixfjpGLkMAfxnQ5W2kvD1OgbwAMuW7V5cycrw11r4q
         oFcYEWFWUsr/MrRmdR/YIyHJ9aAUQT1aAx96NbRp0KbxBxbwBhbBitT6tI8sKXhV5xG3
         V/mJDSCEKUtBMQS+O7PxcOt/GDThkFsSbWCz16CpCduCxEIxlQF0GdT1lTw5SAM+gQ4P
         5V7+VYhleMbgaa8nGctu9lQ+D4P1pP59sEavy7O6hbaPro4YN9s25k6pg2m823JTh+hz
         QMiw==
X-Gm-Message-State: AJIora8K+TnBMopnjR/SdOS807k7/4u/W1Hixlt3cKuth+KmkwCsGGAS
        iHcx4egYQ3/80NNW/86eLk3SBVAApC5UNCgG/g==
X-Google-Smtp-Source: AGRyM1uPPqPT0ZregMnVxFvJs3ge9dtMLnuP+VmBdV4ZlWgha0GV8WBL9m5bvAh/H15HyQucBIDvYnv79sMb4arx4bw=
X-Received: by 2002:a05:6512:1694:b0:48a:9d45:763f with SMTP id
 bu20-20020a056512169400b0048a9d45763fmr7228575lfb.662.1659449535538; Tue, 02
 Aug 2022 07:12:15 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20220802080146epcms2p24b86bfce3d3c09c79b91d861cb3b2cce@epcms2p1>
 <20220802080146epcms2p24b86bfce3d3c09c79b91d861cb3b2cce@epcms2p2> <20220802080927epcms2p1d0d89c32a9bd07c07f233801bb954807@epcms2p1>
In-Reply-To: <20220802080927epcms2p1d0d89c32a9bd07c07f233801bb954807@epcms2p1>
From:   Stanley Chu <chu.stanley@gmail.com>
Date:   Tue, 2 Aug 2022 22:12:03 +0800
Message-ID: <CAGaU9a_YZDxaeOCErnQwFF9mE7bARDf4sw3F3ai1DiWwNVMFcw@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] scsi: ufs: wb: Modify messages
To:     j-young.choi@samsung.com
Cc:     ALIM AKHTAR <alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Aug 2, 2022 at 4:29 PM Jinyoung CHOI <j-young.choi@samsung.com> wro=
te:
>
> Messages are modified to fit the format of others.
>
> Reviewed-by: Avri Altman <avri.altman@wdc.com>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Signed-off-by: Jinyoung Choi <j-young.choi@samsung.com>
> ---
>  drivers/ufs/core/ufs-sysfs.c |  2 +-
>  drivers/ufs/core/ufshcd.c    | 23 +++++++++++------------
>  2 files changed, 12 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/ufs/core/ufs-sysfs.c b/drivers/ufs/core/ufs-sysfs.c
> index 2c0b7f45de4b..117272cf7d61 100644
> --- a/drivers/ufs/core/ufs-sysfs.c
> +++ b/drivers/ufs/core/ufs-sysfs.c
> @@ -230,7 +230,7 @@ static ssize_t wb_on_store(struct device *dev, struct=
 device_attribute *attr,
>                  * If the platform supports UFSHCD_CAP_CLK_SCALING, turn =
WB
>                  * on/off will be done while clock scaling up/down.
>                  */
> -               dev_warn(dev, "To control WB through wb_on is not allowed=
!\n");
> +               dev_warn(dev, "It is not allowed to configure WB!\n");
>                 return -EOPNOTSUPP;
>         }
>
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index 5099d161f115..dcd7f03db2a2 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -5737,13 +5737,13 @@ int ufshcd_wb_toggle(struct ufs_hba *hba, bool en=
able)
>
>         ret =3D __ufshcd_wb_toggle(hba, enable, QUERY_FLAG_IDN_WB_EN);
>         if (ret) {
> -               dev_err(hba->dev, "%s Write Booster %s failed %d\n",
> -                       __func__, enable ? "enable" : "disable", ret);
> +               dev_err(hba->dev, "%s: Write Booster %s failed %d\n",
> +                       __func__, enable ? "enabling" : "disabling", ret)=
;
>                 return ret;
>         }
>
>         hba->dev_info.wb_enabled =3D enable;
> -       dev_info(hba->dev, "%s Write Booster %s\n",
> +       dev_info(hba->dev, "%s: Write Booster %s\n",
>                         __func__, enable ? "enabled" : "disabled");

You need to rebase this patch to follow the latest change as
https://lore.kernel.org/all/20220709000027.3929970-1-bjorn.andersson@linaro=
.org/

>
>         return ret;
> @@ -5757,11 +5757,11 @@ static void ufshcd_wb_toggle_buf_flush_during_h8(=
struct ufs_hba *hba,
>         ret =3D __ufshcd_wb_toggle(hba, enable,
>                         QUERY_FLAG_IDN_WB_BUFF_FLUSH_DURING_HIBERN8);
>         if (ret) {
> -               dev_err(hba->dev, "%s: WB-Buf Flush during H8 %s failed: =
%d\n",
> -                       __func__, enable ? "enable" : "disable", ret);
> +               dev_err(hba->dev, "%s: WB-Buf Flush during H8 %s failed %=
d\n",
> +                       __func__, enable ? "enabling" : "disabling", ret)=
;
>                 return;
>         }
> -       dev_dbg(hba->dev, "%s WB-Buf Flush during H8 %s\n",
> +       dev_info(hba->dev, "%s: WB-Buf Flush during H8 %s\n",
>                         __func__, enable ? "enabled" : "disabled");
>  }
>
> @@ -5775,14 +5775,13 @@ int ufshcd_wb_toggle_buf_flush(struct ufs_hba *hb=
a, bool enable)
>
>         ret =3D __ufshcd_wb_toggle(hba, enable, QUERY_FLAG_IDN_WB_BUFF_FL=
USH_EN);
>         if (ret) {
> -               dev_err(hba->dev, "%s WB-Buf Flush %s failed %d\n", __fun=
c__,
> -                       enable ? "enable" : "disable", ret);
> +               dev_err(hba->dev, "%s: WB-Buf Flush %s failed %d\n",
> +                       __func__, enable ? "enabling" : "disabling", ret)=
;
>                 return ret;
>         }
>
>         hba->dev_info.wb_buf_flush_enabled =3D enable;
> -
> -       dev_dbg(hba->dev, "%s WB-Buf Flush %s\n",
> +       dev_info(hba->dev, "%s: WB-Buf Flush %s\n",
>                         __func__, enable ? "enabled" : "disabled");
>
>         return ret;
> @@ -5800,7 +5799,7 @@ static bool ufshcd_wb_presrv_usrspc_keep_vcc_on(str=
uct ufs_hba *hba,
>                                               QUERY_ATTR_IDN_CURR_WB_BUFF=
_SIZE,
>                                               index, 0, &cur_buf);
>         if (ret) {
> -               dev_err(hba->dev, "%s dCurWriteBoosterBufferSize read fai=
led %d\n",
> +               dev_err(hba->dev, "%s: dCurWriteBoosterBufferSize read fa=
iled %d\n",
>                         __func__, ret);
>                 return false;
>         }
> @@ -5885,7 +5884,7 @@ static bool ufshcd_wb_need_flush(struct ufs_hba *hb=
a)
>                                       QUERY_ATTR_IDN_AVAIL_WB_BUFF_SIZE,
>                                       index, 0, &avail_buf);
>         if (ret) {
> -               dev_warn(hba->dev, "%s dAvailableWriteBoosterBufferSize r=
ead failed %d\n",
> +               dev_warn(hba->dev, "%s: dAvailableWriteBoosterBufferSize =
read failed %d\n",
>                          __func__, ret);
>                 return false;
>         }
> --
> 2.25.1



--=20
Yours truly,

=E6=9C=B1=E5=8E=9F=E9=99=9E (Stanley Chu)
