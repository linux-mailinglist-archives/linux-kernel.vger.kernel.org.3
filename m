Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1958850CB29
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 16:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236174AbiDWO2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 10:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234650AbiDWO2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 10:28:07 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002A9CF2;
        Sat, 23 Apr 2022 07:25:09 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id w16so4210857pfj.2;
        Sat, 23 Apr 2022 07:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wExGzd87BB78mTcPWNXRc3upUnls1jVFzf3VT4o1pWQ=;
        b=DreeFaztiyci0jKmcPjMXcxG3qhXNp/vWZAcsmcetKo2SSjWdw0B3uyRpaqKAy3Pjn
         wAJiz/WrExoSznpsEmKHk927b5AAZbBkKtAqgw8nokf7zZM99Jd45BxI9J1rOZcfFs1w
         DNPVSsVmVzBFT30oDE5fTX1SUOQaomj1c1eo5gbeBYNtS+R0PxCz4LN6iwB7FSy9NEdW
         FBN/RfqLEMV2XMn5JUGr65tF22MUpysCXyno4fhZeAt8kp3N6RzOGbRo8k7mbZRyXgQu
         Hs/fN2yH7IHptzDvBSkW/9jtmQMja42kg2lk7WFWu+iFLxHggg17CxtRrpUorYxuc/c+
         GQow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wExGzd87BB78mTcPWNXRc3upUnls1jVFzf3VT4o1pWQ=;
        b=7w9x5GQ+gyhIr2DrkTadGYb8paZc+5XAu8qy8lNe+dLQB8QzXYRMeFtdvD/7pojq3X
         9Is1rt5n1peDTx2Sk/1lQkNNN+1wSQRFE2avVrysHXgrm/+9IpS4DKObmDi33IFinLDg
         XZJFD9nGXYVhVhYKAtbp6I1DnOJFzIoSrd/7zpp43jbGNsOk4xHS0zlXw/Kx2qUyrSuC
         PbPpBdF5rKvCD/CXQYyZJwSlWKOS2CX1iVZklw4xsxsXTnM8z+deXobPz6K2+RUPgfoi
         0FX+iXBjUUth1XHiPlXJvR8sipzQusz0wdkTJ1Ky5RNT8gb2eRGd+0lm8s1lJJl+lVb+
         WP6A==
X-Gm-Message-State: AOAM533BQo7bnu9mUZAtDmEyJRYLlA7KftZMY8nE5bVI00BLwEgqyWTz
        QQVwWBOt+fdUMolpJ6/PIQ4jp7AduGx96ZI7q2Y=
X-Google-Smtp-Source: ABdhPJxpMqDyVBZ6qE1fMJ1NA0CsCQX8FFfnha9fGiQvUt4AHS0Klu8X3BKOE5Ug+mPC3Hpr9DlG0VAzw+9fu9Hhf3o=
X-Received: by 2002:aa7:8215:0:b0:4f7:125a:c88c with SMTP id
 k21-20020aa78215000000b004f7125ac88cmr10336976pfi.70.1650723909304; Sat, 23
 Apr 2022 07:25:09 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20220422120240epcms2p24bdcb416becf76b417f7c39006aa40f2@epcms2p1>
 <1891546521.01650629881201.JavaMail.epsvc@epcpadp4> <DM6PR04MB6575EB87D425CE431CC4A8F8FCF79@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB6575EB87D425CE431CC4A8F8FCF79@DM6PR04MB6575.namprd04.prod.outlook.com>
From:   jin young choi <ychoijy@gmail.com>
Date:   Sat, 23 Apr 2022 23:24:58 +0900
Message-ID: <CAM36TBtsU0k1e+8-_Ew4ve3SJ0yExUFwPAYnmQy_-AXUHGoeZw@mail.gmail.com>
Subject: Re: [PATCH] scsi: ufs: wb: Add Manual Flush sysfs and cleanup toggle functions
To:     Avri Altman <Avri.Altman@wdc.com>
Cc:     "j-young.choi@samsung.com" <j-young.choi@samsung.com>,
        ALIM AKHTAR <alim.akhtar@samsung.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        Daejun Park <daejun7.park@samsung.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "cang@codeaurora.org" <cang@codeaurora.org>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> > There is the following quirk to bypass "WB Manual Flush" in Write
> > Booster.
> >
> >   - UFSHCD_QUIRK_SKIP_MANUAL_WB_FLUSH_CTRL
> UFSHCD_ --> UFSHCI_
>
I'll fix it. :)


> >
> > If this quirk is not set, there is no knob that can controll "WB Manual Flush".
> >
> >         There are three flags that control Write Booster Feature.
> >                 1. WB ON/OFF
> >                 2. WB Hibern Flush ON/OFF
> >                 3. WB Flush ON/OFF
> >
> >         The sysfs that controls the WB was implemented. (1)
> >
> >         In the case of "Hibern Flush", it is always good to turn on.
> >         Control may not be required. (2)
> >
> >         Finally, "Manual flush" may be determined that it can affect
> >         performance or power consumption.
> >         So the sysfs that controls this may be necessary. (3)
> >
> > In addition, toggle functions for controlling the above flags are cleaned.
> >
> > Signed-off-by: Jinyoung Choi <j-young.choi@samsung.com>
> > ---
> >  drivers/scsi/ufs/ufs-sysfs.c | 46 ++++++++++++++++++-
> >  drivers/scsi/ufs/ufs.h       |  2 +-
> >  drivers/scsi/ufs/ufshcd.c    | 86 +++++++++++++++++-------------------
> >  drivers/scsi/ufs/ufshcd.h    |  7 +++
> >  4 files changed, 94 insertions(+), 47 deletions(-)
> >
> > diff --git a/drivers/scsi/ufs/ufs-sysfs.c b/drivers/scsi/ufs/ufs-sysfs.c
> > index 5c405ff7b6ea..6bbb56152708 100644
> > --- a/drivers/scsi/ufs/ufs-sysfs.c
> > +++ b/drivers/scsi/ufs/ufs-sysfs.c
> > @@ -229,7 +229,7 @@ static ssize_t wb_on_store(struct device *dev, struct
> > device_attribute *attr,
> >                  * If the platform supports UFSHCD_CAP_CLK_SCALING, turn WB
> >                  * on/off will be done while clock scaling up/down.
> >                  */
> > -               dev_warn(dev, "To control WB through wb_on is not allowed!\n");
> > +               dev_warn(dev, "To control Write Booster is not allowed!\n");
> >                 return -EOPNOTSUPP;
> >         }
> >
> > @@ -253,6 +253,48 @@ static ssize_t wb_on_store(struct device *dev,
> > struct device_attribute *attr,
> >         return res < 0 ? res : count;
> >  }
> >
> > +static ssize_t wb_flush_on_show(struct device *dev,
> > +                               struct device_attribute *attr,
> > +                               char *buf)
> > +{
> > +       struct ufs_hba *hba = dev_get_drvdata(dev);
> > +
> > +       return sysfs_emit(buf, "%d\n", hba->dev_info.wb_flush_enabled);
> > +}
> > +
> > +static ssize_t wb_flush_on_store(struct device *dev,
> > +                                struct device_attribute *attr,
> > +                                const char *buf, size_t count)
> > +{
> > +       struct ufs_hba *hba = dev_get_drvdata(dev);
> > +       unsigned int wb_flush_enable;
> > +       ssize_t res;
> > +
> > +       if (!ufshcd_is_wb_flush_allowed(hba)) {
> > +               dev_warn(dev, "To control WB Flush is not allowed!\n");
> > +               return -EOPNOTSUPP;
> > +       }
> > +
> > +       if (kstrtouint(buf, 0, &wb_flush_enable))
> > +               return -EINVAL;
> > +
> > +       if (wb_flush_enable != 0 && wb_flush_enable != 1)
> > +               return -EINVAL;
> > +
> > +       down(&hba->host_sem);
> > +       if (!ufshcd_is_user_access_allowed(hba)) {
> > +               res = -EBUSY;
> > +               goto out;
> > +       }
> > +
> > +       ufshcd_rpm_get_sync(hba);
> > +       res = ufshcd_wb_toggle_flush(hba, wb_flush_enable);
> > +       ufshcd_rpm_put_sync(hba);
> > +out:
> > +       up(&hba->host_sem);
> > +       return res < 0 ? res : count;
> > +}
> > +
> >  static DEVICE_ATTR_RW(rpm_lvl);
> >  static DEVICE_ATTR_RO(rpm_target_dev_state);
> >  static DEVICE_ATTR_RO(rpm_target_link_state);
> > @@ -261,6 +303,7 @@ static DEVICE_ATTR_RO(spm_target_dev_state);
> >  static DEVICE_ATTR_RO(spm_target_link_state);
> >  static DEVICE_ATTR_RW(auto_hibern8);
> >  static DEVICE_ATTR_RW(wb_on);
> > +static DEVICE_ATTR_RW(wb_flush_on);
> Maybe wb_flush_enable ?
>
'wb_on' sysfs already existed. So I named it in the same format (_on)
I'll change both. (_on -> _enable)


> >
> >  static struct attribute *ufs_sysfs_ufshcd_attrs[] = {
> >         &dev_attr_rpm_lvl.attr,
> > @@ -271,6 +314,7 @@ static struct attribute *ufs_sysfs_ufshcd_attrs[] = {
> >         &dev_attr_spm_target_link_state.attr,
> >         &dev_attr_auto_hibern8.attr,
> >         &dev_attr_wb_on.attr,
> > +       &dev_attr_wb_flush_on.attr,
> >         NULL
> >  };
> >
> > diff --git a/drivers/scsi/ufs/ufs.h b/drivers/scsi/ufs/ufs.h
> > index 4a00c24a3209..6c85f512f82f 100644
> > --- a/drivers/scsi/ufs/ufs.h
> > +++ b/drivers/scsi/ufs/ufs.h
> > @@ -611,7 +611,7 @@ struct ufs_dev_info {
> >
> >         /* UFS WB related flags */
> >         bool    wb_enabled;
> > -       bool    wb_buf_flush_enabled;
> > +       bool    wb_flush_enabled;
> >         u8      wb_dedicated_lu;
> >         u8      wb_buffer_type;
> >
> > diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> > index 3f9caafa91bf..7bd510582471 100644
> > --- a/drivers/scsi/ufs/ufshcd.c
> > +++ b/drivers/scsi/ufs/ufshcd.c
> > @@ -249,7 +249,6 @@ static inline int ufshcd_config_vreg_hpm(struct
> > ufs_hba *hba,
> >                                          struct ufs_vreg *vreg);
> >  static int ufshcd_try_to_abort_task(struct ufs_hba *hba, int tag);
> >  static void ufshcd_wb_toggle_flush_during_h8(struct ufs_hba *hba, bool
> > set);
> > -static inline void ufshcd_wb_toggle_flush(struct ufs_hba *hba, bool enable);
> >  static void ufshcd_hba_vreg_set_lpm(struct ufs_hba *hba);
> >  static void ufshcd_hba_vreg_set_hpm(struct ufs_hba *hba);
> >
> > @@ -269,7 +268,7 @@ static inline void ufshcd_disable_irq(struct ufs_hba
> > *hba)
> >         }
> >  }
> >
> > -static inline void ufshcd_wb_config(struct ufs_hba *hba)
> > +static void ufshcd_wb_set_default_flags(struct ufs_hba *hba)
> >  {
> >         if (!ufshcd_is_wb_allowed(hba))
> >                 return;
> > @@ -277,7 +276,7 @@ static inline void ufshcd_wb_config(struct ufs_hba
> > *hba)
> >         ufshcd_wb_toggle(hba, true);
> >
> >         ufshcd_wb_toggle_flush_during_h8(hba, true);
> > -       if (!(hba->quirks & UFSHCI_QUIRK_SKIP_MANUAL_WB_FLUSH_CTRL))
> > +       if (ufshcd_is_wb_flush_allowed(hba))
> >                 ufshcd_wb_toggle_flush(hba, true);
> >  }
> >
> > @@ -608,7 +607,7 @@ static void ufshcd_device_reset(struct ufs_hba *hba)
> >                 ufshcd_set_ufs_dev_active(hba);
> >                 if (ufshcd_is_wb_allowed(hba)) {
> >                         hba->dev_info.wb_enabled = false;
> > -                       hba->dev_info.wb_buf_flush_enabled = false;
> > +                       hba->dev_info.wb_flush_enabled = false;
> >                 }
> >         }
> >         if (err != -EOPNOTSUPP)
> > @@ -5689,74 +5688,70 @@ static void
> > ufshcd_temp_exception_event_handler(struct ufs_hba *hba, u16 status)
> >          */
> >  }
> >
> > -static int __ufshcd_wb_toggle(struct ufs_hba *hba, bool set, enum flag_idn
> > idn)
> > +static int __ufshcd_wb_toggle(struct ufs_hba *hba, const char *knob,
> > +                             bool set, enum flag_idn idn)
> >  {
> > +       int ret;
> >         u8 index;
> >         enum query_opcode opcode = set ? UPIU_QUERY_OPCODE_SET_FLAG :
> > -                                  UPIU_QUERY_OPCODE_CLEAR_FLAG;
> > +               UPIU_QUERY_OPCODE_CLEAR_FLAG;
> > +
> > +       if (!ufshcd_is_wb_allowed(hba))
> > +               return -EPERM;
> >
> >         index = ufshcd_wb_get_query_index(hba);
> > -       return ufshcd_query_flag_retry(hba, opcode, idn, index, NULL);
> > +
> > +       ret = ufshcd_query_flag_retry(hba, opcode, idn, index, NULL);
> > +       if (ret) {
> > +               dev_err(hba->dev, "%s: %s %s failed %d\n",
> > +                       __func__, knob, set ? "enable" : "disable", ret);
> > +               return ret;
> > +       }
> > +
> > +       dev_dbg(hba->dev, "%s: %s %s\n",
> > +                __func__, knob, set ? "enabled" : "disabled");
> > +
> > +       return ret;
> >  }
> Is this debug info (knob extra argument) worth the complication?
>
> Thanks,
> Avri
>
Only the location of the existing code has been moved.

I will edit this part again.
This is because the msg for query execution already exists in the
following function.
   - ufshcd_query_flag_retry()

Thanks,
Jinyoung

> >
> >  int ufshcd_wb_toggle(struct ufs_hba *hba, bool enable)
> >  {
> >         int ret;
> >
> > -       if (!ufshcd_is_wb_allowed(hba))
> > +       if (hba->dev_info.wb_enabled == enable)
> >                 return 0;
> >
> > -       if (!(enable ^ hba->dev_info.wb_enabled))
> > -               return 0;
> > -
> > -       ret = __ufshcd_wb_toggle(hba, enable, QUERY_FLAG_IDN_WB_EN);
> > -       if (ret) {
> > -               dev_err(hba->dev, "%s Write Booster %s failed %d\n",
> > -                       __func__, enable ? "enable" : "disable", ret);
> > +       ret = __ufshcd_wb_toggle(hba, "Write Booster", enable,
> > +                                QUERY_FLAG_IDN_WB_EN);
> > +       if (ret)
> >                 return ret;
> > -       }
> >
> >         hba->dev_info.wb_enabled = enable;
> > -       dev_info(hba->dev, "%s Write Booster %s\n",
> > -                       __func__, enable ? "enabled" : "disabled");
> >
> >         return ret;
> >  }
> >
> > -static void ufshcd_wb_toggle_flush_during_h8(struct ufs_hba *hba, bool
> > set)
> > +static void ufshcd_wb_toggle_flush_during_h8(struct ufs_hba *hba, bool
> > enable)
> >  {
> > -       int ret;
> > -
> > -       ret = __ufshcd_wb_toggle(hba, set,
> > -                       QUERY_FLAG_IDN_WB_BUFF_FLUSH_DURING_HIBERN8);
> > -       if (ret) {
> > -               dev_err(hba->dev, "%s: WB-Buf Flush during H8 %s failed: %d\n",
> > -                       __func__, set ? "enable" : "disable", ret);
> > -               return;
> > -       }
> > -       dev_dbg(hba->dev, "%s WB-Buf Flush during H8 %s\n",
> > -                       __func__, set ? "enabled" : "disabled");
> > +       __ufshcd_wb_toggle(hba, "WB-Buf Flush during H8", enable,
> > +                          QUERY_FLAG_IDN_WB_BUFF_FLUSH_DURING_HIBERN8);
> >  }
> >
> > -static inline void ufshcd_wb_toggle_flush(struct ufs_hba *hba, bool enable)
> > +int ufshcd_wb_toggle_flush(struct ufs_hba *hba, bool enable)
> >  {
> >         int ret;
> >
> > -       if (!ufshcd_is_wb_allowed(hba) ||
> > -           hba->dev_info.wb_buf_flush_enabled == enable)
> > -               return;
> > +       if (hba->dev_info.wb_flush_enabled == enable)
> > +               return 0;
> >
> > -       ret = __ufshcd_wb_toggle(hba, enable,
> > QUERY_FLAG_IDN_WB_BUFF_FLUSH_EN);
> > -       if (ret) {
> > -               dev_err(hba->dev, "%s WB-Buf Flush %s failed %d\n", __func__,
> > -                       enable ? "enable" : "disable", ret);
> > -               return;
> > -       }
> > +       ret = __ufshcd_wb_toggle(hba, "WB-Buf Flush", enable,
> > +                                QUERY_FLAG_IDN_WB_BUFF_FLUSH_EN);
> > +       if (ret)
> > +               return ret;
> >
> > -       hba->dev_info.wb_buf_flush_enabled = enable;
> > +       hba->dev_info.wb_flush_enabled = enable;
> >
> > -       dev_dbg(hba->dev, "%s WB-Buf Flush %s\n",
> > -                       __func__, enable ? "enabled" : "disabled");
> > +       return ret;
> >  }
> >
> >  static bool ufshcd_wb_presrv_usrspc_keep_vcc_on(struct ufs_hba *hba,
> > @@ -5790,7 +5785,7 @@ static bool
> > ufshcd_wb_presrv_usrspc_keep_vcc_on(struct ufs_hba *hba,
> >
> >  static void ufshcd_wb_force_disable(struct ufs_hba *hba)
> >  {
> > -       if (!(hba->quirks & UFSHCI_QUIRK_SKIP_MANUAL_WB_FLUSH_CTRL))
> > +       if (ufshcd_is_wb_flush_allowed(hba))
> >                 ufshcd_wb_toggle_flush(hba, false);
> >
> >         ufshcd_wb_toggle_flush_during_h8(hba, false);
> > @@ -8178,7 +8173,8 @@ static int ufshcd_probe_hba(struct ufs_hba *hba,
> > bool init_dev_params)
> >          */
> >         ufshcd_set_active_icc_lvl(hba);
> >
> > -       ufshcd_wb_config(hba);
> > +       ufshcd_wb_set_default_flags(hba);
> > +
> >         if (hba->ee_usr_mask)
> >                 ufshcd_write_ee_control(hba);
> >         /* Enable Auto-Hibernate if configured */
> > diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
> > index 94f545be183a..abd2be248dc5 100644
> > --- a/drivers/scsi/ufs/ufshcd.h
> > +++ b/drivers/scsi/ufs/ufshcd.h
> > @@ -991,6 +991,12 @@ static inline bool ufshcd_is_wb_allowed(struct
> > ufs_hba *hba)
> >         return hba->caps & UFSHCD_CAP_WB_EN;
> >  }
> >
> > +static inline bool ufshcd_is_wb_flush_allowed(struct ufs_hba *hba)
> > +{
> > +       return ufshcd_is_wb_allowed(hba) &&
> > +               !(hba->quirks & UFSHCI_QUIRK_SKIP_MANUAL_WB_FLUSH_CTRL);
> > +}
> > +
> >  static inline bool ufshcd_is_user_access_allowed(struct ufs_hba *hba)
> >  {
> >         return !hba->shutting_down;
> > @@ -1209,6 +1215,7 @@ int ufshcd_exec_raw_upiu_cmd(struct ufs_hba
> > *hba,
> >                              enum query_opcode desc_op);
> >
> >  int ufshcd_wb_toggle(struct ufs_hba *hba, bool enable);
> > +int ufshcd_wb_toggle_flush(struct ufs_hba *hba, bool enable);
> >  int ufshcd_suspend_prepare(struct device *dev);
> >  int __ufshcd_suspend_prepare(struct device *dev, bool rpm_ok_for_spm);
> >  void ufshcd_resume_complete(struct device *dev);
> > --
> > 2.25.1
