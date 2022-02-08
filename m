Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA584AD194
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 07:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347512AbiBHGci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 01:32:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347503AbiBHGcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 01:32:31 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E756C0401F5
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 22:32:29 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id s13so49139224ejy.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 22:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qLC0AY2BcrvcKy6uLinNb7baq3XTSChUKFMo5Ii/YKY=;
        b=EmgsoAyMp/8PyEvw8ZjXJy6iPElrXu3e8YnfFuXmN3kU/RL3lFb2FxCKhk3yXQKVtd
         Oei5c3aGJXk5RgbYt82rKVMKaKkGtt9nr+ytXpfc9sQf3G42XRqrnoyKNtCbwSC+LmnD
         tAV294cXoT8OF8FOaLmLbY9dvmWBOp6tXtb37XHhmAtK6HlJkLZUfvD3fQwy9sAbJxpA
         kEIN8WTxOrOVgnoU0Zp2IVA/hchoW6luZDNXrIyQ+6ryJXctAxsj1om8pSZTRUcixeA2
         VjzESiW1G3Qxz4ObkAFGA/yjcdlw/L/is2De4je1IQyLqnDxoPJs9C1Gwp0LwMaUKyFa
         UCwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qLC0AY2BcrvcKy6uLinNb7baq3XTSChUKFMo5Ii/YKY=;
        b=Epk2y1IFfYXRE82AfYIGAh3DrTnXCO9KiUfkwujM6IThBDFIABc9JcN/KipE/rbW3K
         EhlpAeSO8R+URKWpKR36npJg7U0xYhw5zE/+FhvIdwSZQc170C4Mn5VwfmxFYaW1xSj6
         xXKnB4Z9JGyxv6jp4p/zf9jZodjjJfibEg82JNeoScJXq6fhawhHoczndvLezSS4o3jp
         WUgSkb19pwForY220jXYr3mYKbtlMrDiwRXwXVkLrEEne5e+ryVj1IwZMlrb7WGmcIzN
         0hRtxu31pgtgb/VlGl+uNa6xAL/IXnXmRReQX1tFNYMgFsJQ8UgdhIIOByFPs1240MoI
         bbRg==
X-Gm-Message-State: AOAM532DIxOwqWDO1fmE6zxutoHZWfF2hHABtzsgR86KiXFUQ/TMglUS
        75YuzX6SENjnsFimwMJDzb7UJ2LrSL6jQp+1W2FgYw==
X-Google-Smtp-Source: ABdhPJwmjoHJ/OTaZvMEWv9Ybscc9QB33g5j0N/fhn/7vQAQWO5/E4tkaJG0Tk8jmDFhvpGMP13KQh9Z3oceoIlMWBs=
X-Received: by 2002:a17:907:3e9c:: with SMTP id hs28mr2397582ejc.735.1644301948202;
 Mon, 07 Feb 2022 22:32:28 -0800 (PST)
MIME-Version: 1.0
References: <20220208025500.29511-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20220208025500.29511-1-yang.lee@linux.alibaba.com>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Tue, 8 Feb 2022 07:32:17 +0100
Message-ID: <CAMGffEnURrDMSJ44+LesZSxmgXewV4vRXBeD1c2-aBGDaaZEUA@mail.gmail.com>
Subject: Re: [PATCH -next v3] scsi: pm8001: clean up some inconsistent indentin
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     damien.lemoal@opensource.wdc.com, jejb@linux.ibm.com,
        jinpu.wang@ionos.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 8, 2022 at 3:55 AM Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> Eliminate the follow smatch warning:
> drivers/scsi/pm8001/pm8001_ctl.c:760 pm8001_update_flash() warn:
> inconsistent indenting
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
Acked-by: Jack Wang <jinpu.wang@ionos.com>
Thanks!
> ---
>
>   Changes in v3:
> --According to Damien's suggestion
>   1) "u32 fc_len = 0;" -> "u32 fc_len;".
>   2) Add spaces around the "-" and remove the unnecessary parenthesis.
>   3) Move "fc_len = (partitionSize + HEADER_LEN) % IOCTL_BUF_SIZE;"down,
>      right above the "if" where the variable is used.
>
>  drivers/scsi/pm8001/pm8001_ctl.c | 61 ++++++++++++++++----------------
>  1 file changed, 31 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/scsi/pm8001/pm8001_ctl.c b/drivers/scsi/pm8001/pm8001_ctl.c
> index 41a63c9b719b..66307783c73c 100644
> --- a/drivers/scsi/pm8001/pm8001_ctl.c
> +++ b/drivers/scsi/pm8001/pm8001_ctl.c
> @@ -727,6 +727,8 @@ static int pm8001_update_flash(struct pm8001_hba_info *pm8001_ha)
>         u32             sizeRead = 0;
>         u32             ret = 0;
>         u32             length = 1024 * 16 + sizeof(*payload) - 1;
> +       u32             fc_len;
> +       u8              *read_buf;
>
>         if (pm8001_ha->fw_image->size < 28) {
>                 pm8001_ha->fw_status = FAIL_FILE_SIZE;
> @@ -755,36 +757,35 @@ static int pm8001_update_flash(struct pm8001_hba_info *pm8001_ha)
>                         fwControl->retcode = 0;/* OUT */
>                         fwControl->offset = loopNumber * IOCTL_BUF_SIZE;/*OUT */
>
> -               /* for the last chunk of data in case file size is not even with
> -               4k, load only the rest*/
> -               if (((loopcount-loopNumber) == 1) &&
> -                       ((partitionSize + HEADER_LEN) % IOCTL_BUF_SIZE)) {
> -                       fwControl->len =
> -                               (partitionSize + HEADER_LEN) % IOCTL_BUF_SIZE;
> -                       memcpy((u8 *)fwControl->buffer,
> -                               (u8 *)pm8001_ha->fw_image->data + sizeRead,
> -                               (partitionSize + HEADER_LEN) % IOCTL_BUF_SIZE);
> -                       sizeRead +=
> -                               (partitionSize + HEADER_LEN) % IOCTL_BUF_SIZE;
> -               } else {
> -                       memcpy((u8 *)fwControl->buffer,
> -                               (u8 *)pm8001_ha->fw_image->data + sizeRead,
> -                               IOCTL_BUF_SIZE);
> -                       sizeRead += IOCTL_BUF_SIZE;
> -               }
> -
> -               pm8001_ha->nvmd_completion = &completion;
> -               ret = PM8001_CHIP_DISP->fw_flash_update_req(pm8001_ha, payload);
> -               if (ret) {
> -                       pm8001_ha->fw_status = FAIL_OUT_MEMORY;
> -                       goto out;
> -               }
> -               wait_for_completion(&completion);
> -               if (fwControl->retcode > FLASH_UPDATE_IN_PROGRESS) {
> -                       pm8001_ha->fw_status = fwControl->retcode;
> -                       ret = -EFAULT;
> -                       goto out;
> -               }
> +                       /*
> +                        * for the last chunk of data in case file size is
> +                        * not even with 4k, load only the rest
> +                        */
> +
> +                       read_buf  = (u8 *)pm8001_ha->fw_image->data + sizeRead;
> +                       fc_len = (partitionSize + HEADER_LEN) % IOCTL_BUF_SIZE;
> +
> +                       if (loopcount - loopNumber == 1 && fc_len) {
> +                               fwControl->len = fc_len;
> +                               memcpy((u8 *)fwControl->buffer, read_buf, fc_len);
> +                               sizeRead += fc_len;
> +                       } else {
> +                               memcpy((u8 *)fwControl->buffer, read_buf, IOCTL_BUF_SIZE);
> +                               sizeRead += IOCTL_BUF_SIZE;
> +                       }
> +
> +                       pm8001_ha->nvmd_completion = &completion;
> +                       ret = PM8001_CHIP_DISP->fw_flash_update_req(pm8001_ha, payload);
> +                       if (ret) {
> +                               pm8001_ha->fw_status = FAIL_OUT_MEMORY;
> +                               goto out;
> +                       }
> +                       wait_for_completion(&completion);
> +                       if (fwControl->retcode > FLASH_UPDATE_IN_PROGRESS) {
> +                               pm8001_ha->fw_status = fwControl->retcode;
> +                               ret = -EFAULT;
> +                               goto out;
> +                       }
>                 }
>         }
>  out:
> --
> 2.20.1.7.g153144c
>
