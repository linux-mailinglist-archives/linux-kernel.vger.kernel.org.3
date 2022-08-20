Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 611CA59AFC3
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 20:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235785AbiHTSq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 14:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235635AbiHTSq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 14:46:28 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616834C63B
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 11:44:39 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-3375488624aso169174437b3.3
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 11:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=fBIVWoeQRh7o83oUgJ5fSHOAY110UQuIGTEwQvPGNto=;
        b=a8jqEQjy4xRMZ9UmJBkgBbHFPAcji97ogC+1cTzhAlHTDsuHSTf4lq5ILPl1cxl5jL
         b5Dg4Wpz6wnchFzjGmhVK1uxCYDFRCIPGjBINyuqp+q3+teDXeWke5DS+1iDWeAhfTUh
         s2Oj78XKhW9VezKPSHkpoSrUHllPCC2ZNGV9NWDstMBaerjpEBkYHyiCCHsxPQ2CS5Sq
         Ea5epHR+EKrVYpA1bOTv2kNA9LH6m75+mEe+fdl8XziAT5XI2wXOsi+aEGfG29sS73zJ
         ad287fc5but4vvKqN+xoTRCj9xFu0pUQbKW+joie12i0FdImwUBgKPdgDyAQee058j1J
         0Hqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=fBIVWoeQRh7o83oUgJ5fSHOAY110UQuIGTEwQvPGNto=;
        b=sqhPqAdszQw2PMEqE0Sk5xuBtUqCYTh5uAf9iFy54bxjajBFB9rCWGLuJNs9CaVfor
         Ajv35grfrIH/D0EvqcxWSjDhBDZqXUpPyvVDJPLg2oqm8FMuyHYcqNgzxvYz7CHhCokV
         Djl9RpzgsjiZH6w/NXIlXKp7bR6ZS5i+jJrLDyQ1Ob9oSfUTemEYAqEnXStG2GCoae6Q
         aQsKPHv8QpOS89p4ifaBJWhqi6JdUJwxsA4qKazICTuCgaE2Eixd5WFN/Gcx3hDpFSVm
         m+qLHPJuycGM9GIz62mVGoAI/NhpIisZx979Ue49Ft5V8J4jK+AqBZtiWO63tU4f6cTC
         rjZw==
X-Gm-Message-State: ACgBeo1MR4xKWS1H2HcxVX6/g7iG/yKgzODZMSZdNSBPMyNsC9Mij7ij
        4671Qy4PsrO6TtVl4tJgae9nXNAh6iZPUA8hyI4=
X-Google-Smtp-Source: AA6agR7Lq80CWXvbr6SMx/WuvIxvr3IkVhtZ0ZJbmRwA4I6pAZMhKgGUEu6Zq8J1dIccrPoqNjvZ2uKPFRlcREa+eXU=
X-Received: by 2002:a0d:c981:0:b0:330:dc03:7387 with SMTP id
 l123-20020a0dc981000000b00330dc037387mr13256448ywd.380.1661021070040; Sat, 20
 Aug 2022 11:44:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1661018051.git.namcaov@gmail.com> <46d73e331bae2192a328f6691763f39ea6c18b08.1661018051.git.namcaov@gmail.com>
In-Reply-To: <46d73e331bae2192a328f6691763f39ea6c18b08.1661018051.git.namcaov@gmail.com>
From:   Nam Cao <namcaov@gmail.com>
Date:   Sat, 20 Aug 2022 20:44:19 +0200
Message-ID: <CA+sZ8B9Pa5h8K9LS17fB2Oy8oRadnVSeup6dqfWoVfV1DKkckw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] staging: rtl8723bs: remove unused function ODM_InbandNoise_Monitor
To:     hdegoede@redhat.com
Cc:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, lkp@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please ignore these emails. They are detached from the thread for some reason.

On Sat, Aug 20, 2022 at 8:00 PM Nam Cao <namcaov@gmail.com> wrote:
>
> because this function is not used. Also remove function
> odm_InbandNoise_Monitor_NSeries because it is a static function
> which is only called from ODM_InbandNoise_Monitor.
>
> Signed-off-by: Nam Cao <namcaov@gmail.com>
> ---
>  .../staging/rtl8723bs/hal/odm_NoiseMonitor.c  | 111 ------------------
>  .../staging/rtl8723bs/hal/odm_NoiseMonitor.h  |   7 --
>  2 files changed, 118 deletions(-)
>
> diff --git a/drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.c b/drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.c
> index 392cc8a398f5..b85b323cf5bd 100644
> --- a/drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.c
> +++ b/drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.c
> @@ -17,114 +17,3 @@
>  #define Valid_Min                              -35
>  #define Valid_Max                      10
>  #define ValidCnt                               5
> -
> -static s16 odm_InbandNoise_Monitor_NSeries(
> -       struct dm_odm_t *pDM_Odm,
> -       u8 bPauseDIG,
> -       u8 IGIValue,
> -       u32 max_time
> -)
> -{
> -       u32 tmp4b;
> -       u8 max_rf_path = 0, rf_path;
> -       u8 reg_c50, reg_c58, valid_done = 0;
> -       struct noise_level noise_data;
> -       u32 start  = 0;
> -
> -       pDM_Odm->noise_level.noise_all = 0;
> -
> -       max_rf_path = 1;
> -
> -       memset(&noise_data, 0, sizeof(struct noise_level));
> -
> -       /*  */
> -       /*  Step 1. Disable DIG && Set initial gain. */
> -       /*  */
> -
> -       if (bPauseDIG)
> -               odm_PauseDIG(pDM_Odm, ODM_PAUSE_DIG, IGIValue);
> -       /*  */
> -       /*  Step 2. Disable all power save for read registers */
> -       /*  */
> -       /* dcmd_DebugControlPowerSave(padapter, PSDisable); */
> -
> -       /*  */
> -       /*  Step 3. Get noise power level */
> -       /*  */
> -       start = jiffies;
> -       while (1) {
> -
> -               /* Stop updating idle time pwer report (for driver read) */
> -               PHY_SetBBReg(pDM_Odm->Adapter, rFPGA0_TxGainStage, BIT25, 1);
> -
> -               /* Read Noise Floor Report */
> -               tmp4b = PHY_QueryBBReg(pDM_Odm->Adapter, 0x8f8, bMaskDWord);
> -
> -               /* PHY_SetBBReg(pDM_Odm->Adapter, rOFDM0_XAAGCCore1, bMaskByte0, TestInitialGain); */
> -               /* if (max_rf_path == 2) */
> -               /* PHY_SetBBReg(pDM_Odm->Adapter, rOFDM0_XBAGCCore1, bMaskByte0, TestInitialGain); */
> -
> -               /* update idle time pwer report per 5us */
> -               PHY_SetBBReg(pDM_Odm->Adapter, rFPGA0_TxGainStage, BIT25, 0);
> -
> -               noise_data.value[RF_PATH_A] = (u8)(tmp4b&0xff);
> -               noise_data.value[RF_PATH_B]  = (u8)((tmp4b&0xff00)>>8);
> -
> -               for (rf_path = RF_PATH_A; rf_path < max_rf_path; rf_path++) {
> -                       noise_data.sval[rf_path] = (s8)noise_data.value[rf_path];
> -                       noise_data.sval[rf_path] /= 2;
> -               }
> -               /* mdelay(10); */
> -               /* msleep(10); */
> -
> -               for (rf_path = RF_PATH_A; rf_path < max_rf_path; rf_path++) {
> -                       if ((noise_data.valid_cnt[rf_path] < ValidCnt) && (noise_data.sval[rf_path] < Valid_Max && noise_data.sval[rf_path] >= Valid_Min)) {
> -                               noise_data.valid_cnt[rf_path]++;
> -                               noise_data.sum[rf_path] += noise_data.sval[rf_path];
> -                               if (noise_data.valid_cnt[rf_path] == ValidCnt) {
> -                                       valid_done++;
> -                               }
> -
> -                       }
> -
> -               }
> -
> -               /* printk("####### valid_done:%d #############\n", valid_done); */
> -               if ((valid_done == max_rf_path) || (jiffies_to_msecs(jiffies - start) > max_time)) {
> -                       for (rf_path = RF_PATH_A; rf_path < max_rf_path; rf_path++) {
> -                               /* printk("%s PATH_%d - sum = %d, valid_cnt = %d\n", __func__, rf_path, noise_data.sum[rf_path], noise_data.valid_cnt[rf_path]); */
> -                               if (noise_data.valid_cnt[rf_path])
> -                                       noise_data.sum[rf_path] /= noise_data.valid_cnt[rf_path];
> -                               else
> -                                       noise_data.sum[rf_path]  = 0;
> -                       }
> -                       break;
> -               }
> -       }
> -       reg_c50 = (s32)PHY_QueryBBReg(pDM_Odm->Adapter, rOFDM0_XAAGCCore1, bMaskByte0);
> -       reg_c50 &= ~BIT7;
> -       pDM_Odm->noise_level.noise[RF_PATH_A] = -110 + reg_c50 + noise_data.sum[RF_PATH_A];
> -       pDM_Odm->noise_level.noise_all += pDM_Odm->noise_level.noise[RF_PATH_A];
> -
> -       if (max_rf_path == 2) {
> -               reg_c58 = (s32)PHY_QueryBBReg(pDM_Odm->Adapter, rOFDM0_XBAGCCore1, bMaskByte0);
> -               reg_c58 &= ~BIT7;
> -               pDM_Odm->noise_level.noise[RF_PATH_B] = -110 + reg_c58 + noise_data.sum[RF_PATH_B];
> -               pDM_Odm->noise_level.noise_all += pDM_Odm->noise_level.noise[RF_PATH_B];
> -       }
> -       pDM_Odm->noise_level.noise_all /= max_rf_path;
> -
> -       /*  */
> -       /*  Step 4. Recover the Dig */
> -       /*  */
> -       if (bPauseDIG)
> -               odm_PauseDIG(pDM_Odm, ODM_RESUME_DIG, IGIValue);
> -
> -       return pDM_Odm->noise_level.noise_all;
> -
> -}
> -
> -s16 ODM_InbandNoise_Monitor(void *pDM_VOID, u8 bPauseDIG, u8 IGIValue, u32 max_time)
> -{
> -       return odm_InbandNoise_Monitor_NSeries(pDM_VOID, bPauseDIG, IGIValue, max_time);
> -}
> diff --git a/drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.h b/drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.h
> index ab114543f39c..01c5c524d4e0 100644
> --- a/drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.h
> +++ b/drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.h
> @@ -29,11 +29,4 @@ struct odm_noise_monitor {
>         s16 noise_all;
>  };
>
> -s16 ODM_InbandNoise_Monitor(
> -       void *pDM_VOID,
> -       u8 bPauseDIG,
> -       u8 IGIValue,
> -       u32 max_time
> -);
> -
>  #endif
> --
> 2.25.1
>
