Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 059AA49B3B1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 13:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381840AbiAYMPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 07:15:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444674AbiAYMLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 07:11:01 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3ACC0613DE
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 04:09:13 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id j23so57177181edp.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 04:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4wac7eCHjjoR27WE2JN+TT1tiH9/RFWfh6DHtSMCbJY=;
        b=J7o0o2udCFzNmRR9YWC0vB4fyZreNAYvCBo9+zv+4nhaBY5BCjzDDvpHeeYovjmxTX
         G4PQoRM6+Fpr66xhNXnwHREbR3OWYxr0kx236kE4aYuScTYvnvw2q4j9IYqRL3w1Lchj
         3QsRukt2RjMs9rVmBKv88ymKCXy/9Hwt3DA4a+3oOSIrKoGHIbD2K7+pGGJZ09skGLsy
         YJJLvvSKGSqxYnkkKlk/nya3Ohh9gwDGk+aoDSvA4yv40KNd2g7iZzSrC1/meRGxF3gR
         TSMknyPokHu8qWHjKJ2EBGgQlrSjbgpTFLalVi9tg3W2ugI/sIca2VLmEYRedUULS162
         ECCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4wac7eCHjjoR27WE2JN+TT1tiH9/RFWfh6DHtSMCbJY=;
        b=XspHnuSktNELsMAt8gPZi32jGhgJCSg1J+NCrdbw4sAtr0tcTB2IyF9gYYflH7dDW0
         TY+w0MgwHc0UJwBYqZPmvWbrzb770a1xig1RLQsVZgU1rvLJJLu+Ibix6pvjsjmIC00+
         1oDG7/PIz3ymwD1sXaw1wV8YHU7DeboVz5AVUI7qHrpgKflv/50nZZLORlSG7hhfpa1f
         zgUSACtqQw+A9sevF6VlSIZZjcYz7BZFjtDnqfz/mKU7LolN8ZA3BPJMizntq52htX1r
         4neIDlioT7zma2yjIK2WdOT5DOBEXR2sHLbrzh6XWaAFrfi0dpcubNv5Lq0eMHdXC94m
         eH6Q==
X-Gm-Message-State: AOAM531oftXXmJ+eWdaAmeDLtjqyeGI7PUWIjTOLULO6dm90269ZVzt2
        bttaeI7XNISHfJe0kD65534nk7GK1zWT4knXzHrcug==
X-Google-Smtp-Source: ABdhPJwFUNiPQ6ZMa5gM27wXDKRyeO/swCb4JPc+zt+CzKu5kWIFe759qCovWCs/xFBi1bad/SiqdukSSjUzYElMdAM=
X-Received: by 2002:a05:6402:195:: with SMTP id r21mr19944269edv.174.1643112551677;
 Tue, 25 Jan 2022 04:09:11 -0800 (PST)
MIME-Version: 1.0
References: <1643110372-85470-1-git-send-email-john.garry@huawei.com> <1643110372-85470-3-git-send-email-john.garry@huawei.com>
In-Reply-To: <1643110372-85470-3-git-send-email-john.garry@huawei.com>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Tue, 25 Jan 2022 13:09:00 +0100
Message-ID: <CAMGffEmDKBVT=VP4UEa9qUoTaTqTnuBKyEKCqngXOYLu9uG=9A@mail.gmail.com>
Subject: Re: [PATCH 02/16] scsi: libsas: Delete lldd_clear_aca callback
To:     John Garry <john.garry@huawei.com>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        artur.paszkiewicz@intel.com, jinpu.wang@ionos.com,
        chenxiang66@hisilicon.com, Ajish.Koshy@microchip.com,
        yanaijie@huawei.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        linuxarm@huawei.com, liuqi115@huawei.com, Viswas.G@microchip.com,
        damien.lemoal@opensource.wdc.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 12:38 PM John Garry <john.garry@huawei.com> wrote:
>
> This callback is never called, so remove support.
>
> Signed-off-by: John Garry <john.garry@huawei.com>
Indeed.
Reviewed-by: Jack Wang <jinpu.wang@ionos.com>
Thx!
> ---
>  Documentation/scsi/libsas.rst         |  2 --
>  drivers/scsi/aic94xx/aic94xx.h        |  1 -
>  drivers/scsi/aic94xx/aic94xx_init.c   |  1 -
>  drivers/scsi/aic94xx/aic94xx_tmf.c    |  9 ---------
>  drivers/scsi/hisi_sas/hisi_sas_main.c | 12 ------------
>  drivers/scsi/isci/init.c              |  1 -
>  drivers/scsi/isci/task.c              | 18 ------------------
>  drivers/scsi/isci/task.h              |  4 ----
>  drivers/scsi/mvsas/mv_init.c          |  1 -
>  drivers/scsi/mvsas/mv_sas.c           | 11 -----------
>  drivers/scsi/mvsas/mv_sas.h           |  1 -
>  drivers/scsi/pm8001/pm8001_init.c     |  1 -
>  drivers/scsi/pm8001/pm8001_sas.c      |  8 --------
>  drivers/scsi/pm8001/pm8001_sas.h      |  1 -
>  include/scsi/libsas.h                 |  1 -
>  15 files changed, 72 deletions(-)
>
> diff --git a/Documentation/scsi/libsas.rst b/Documentation/scsi/libsas.rst
> index 6589dfefbc02..305a253d5c3b 100644
> --- a/Documentation/scsi/libsas.rst
> +++ b/Documentation/scsi/libsas.rst
> @@ -207,7 +207,6 @@ Management Functions (TMFs) described in SAM::
>         /* Task Management Functions. Must be called from process context. */
>         int (*lldd_abort_task)(struct sas_task *);
>         int (*lldd_abort_task_set)(struct domain_device *, u8 *lun);
> -       int (*lldd_clear_aca)(struct domain_device *, u8 *lun);
>         int (*lldd_clear_task_set)(struct domain_device *, u8 *lun);
>         int (*lldd_I_T_nexus_reset)(struct domain_device *);
>         int (*lldd_lu_reset)(struct domain_device *, u8 *lun);
> @@ -262,7 +261,6 @@ can look like this (called last thing from probe())
>
>             my_ha->sas_ha.lldd_abort_task     = my_abort_task;
>             my_ha->sas_ha.lldd_abort_task_set = my_abort_task_set;
> -           my_ha->sas_ha.lldd_clear_aca      = my_clear_aca;
>             my_ha->sas_ha.lldd_clear_task_set = my_clear_task_set;
>             my_ha->sas_ha.lldd_I_T_nexus_reset= NULL; (2)
>             my_ha->sas_ha.lldd_lu_reset       = my_lu_reset;
> diff --git a/drivers/scsi/aic94xx/aic94xx.h b/drivers/scsi/aic94xx/aic94xx.h
> index 8f24180646c2..f595bc2ee45e 100644
> --- a/drivers/scsi/aic94xx/aic94xx.h
> +++ b/drivers/scsi/aic94xx/aic94xx.h
> @@ -60,7 +60,6 @@ void asd_set_dmamode(struct domain_device *dev);
>  /* ---------- TMFs ---------- */
>  int  asd_abort_task(struct sas_task *);
>  int  asd_abort_task_set(struct domain_device *, u8 *lun);
> -int  asd_clear_aca(struct domain_device *, u8 *lun);
>  int  asd_clear_task_set(struct domain_device *, u8 *lun);
>  int  asd_lu_reset(struct domain_device *, u8 *lun);
>  int  asd_I_T_nexus_reset(struct domain_device *dev);
> diff --git a/drivers/scsi/aic94xx/aic94xx_init.c b/drivers/scsi/aic94xx/aic94xx_init.c
> index 7a78606598c4..954d0c5ae2e2 100644
> --- a/drivers/scsi/aic94xx/aic94xx_init.c
> +++ b/drivers/scsi/aic94xx/aic94xx_init.c
> @@ -960,7 +960,6 @@ static struct sas_domain_function_template aic94xx_transport_functions = {
>
>         .lldd_abort_task        = asd_abort_task,
>         .lldd_abort_task_set    = asd_abort_task_set,
> -       .lldd_clear_aca         = asd_clear_aca,
>         .lldd_clear_task_set    = asd_clear_task_set,
>         .lldd_I_T_nexus_reset   = asd_I_T_nexus_reset,
>         .lldd_lu_reset          = asd_lu_reset,
> diff --git a/drivers/scsi/aic94xx/aic94xx_tmf.c b/drivers/scsi/aic94xx/aic94xx_tmf.c
> index 0eb6e206a2b4..0ff0d6506ccf 100644
> --- a/drivers/scsi/aic94xx/aic94xx_tmf.c
> +++ b/drivers/scsi/aic94xx/aic94xx_tmf.c
> @@ -644,15 +644,6 @@ int asd_abort_task_set(struct domain_device *dev, u8 *lun)
>         return res;
>  }
>
> -int asd_clear_aca(struct domain_device *dev, u8 *lun)
> -{
> -       int res = asd_initiate_ssp_tmf(dev, lun, TMF_CLEAR_ACA, 0);
> -
> -       if (res == TMF_RESP_FUNC_COMPLETE)
> -               asd_clear_nexus_I_T_L(dev, lun);
> -       return res;
> -}
> -
>  int asd_clear_task_set(struct domain_device *dev, u8 *lun)
>  {
>         int res = asd_initiate_ssp_tmf(dev, lun, TMF_CLEAR_TASK_SET, 0);
> diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
> index a05ec7aece5a..f014e458edbb 100644
> --- a/drivers/scsi/hisi_sas/hisi_sas_main.c
> +++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
> @@ -1801,17 +1801,6 @@ static int hisi_sas_abort_task_set(struct domain_device *device, u8 *lun)
>         return rc;
>  }
>
> -static int hisi_sas_clear_aca(struct domain_device *device, u8 *lun)
> -{
> -       struct hisi_sas_tmf_task tmf_task;
> -       int rc;
> -
> -       tmf_task.tmf = TMF_CLEAR_ACA;
> -       rc = hisi_sas_debug_issue_ssp_tmf(device, lun, &tmf_task);
> -
> -       return rc;
> -}
> -
>  #define I_T_NEXUS_RESET_PHYUP_TIMEOUT  (2 * HZ)
>
>  static int hisi_sas_debug_I_T_nexus_reset(struct domain_device *device)
> @@ -2341,7 +2330,6 @@ static struct sas_domain_function_template hisi_sas_transport_ops = {
>         .lldd_control_phy       = hisi_sas_control_phy,
>         .lldd_abort_task        = hisi_sas_abort_task,
>         .lldd_abort_task_set    = hisi_sas_abort_task_set,
> -       .lldd_clear_aca         = hisi_sas_clear_aca,
>         .lldd_I_T_nexus_reset   = hisi_sas_I_T_nexus_reset,
>         .lldd_lu_reset          = hisi_sas_lu_reset,
>         .lldd_query_task        = hisi_sas_query_task,
> diff --git a/drivers/scsi/isci/init.c b/drivers/scsi/isci/init.c
> index aade707c5553..e294d5d961eb 100644
> --- a/drivers/scsi/isci/init.c
> +++ b/drivers/scsi/isci/init.c
> @@ -193,7 +193,6 @@ static struct sas_domain_function_template isci_transport_ops  = {
>         /* Task Management Functions. Must be called from process context. */
>         .lldd_abort_task        = isci_task_abort_task,
>         .lldd_abort_task_set    = isci_task_abort_task_set,
> -       .lldd_clear_aca         = isci_task_clear_aca,
>         .lldd_clear_task_set    = isci_task_clear_task_set,
>         .lldd_I_T_nexus_reset   = isci_task_I_T_nexus_reset,
>         .lldd_lu_reset          = isci_task_lu_reset,
> diff --git a/drivers/scsi/isci/task.c b/drivers/scsi/isci/task.c
> index 3fd88d72a0c0..403bfee34d84 100644
> --- a/drivers/scsi/isci/task.c
> +++ b/drivers/scsi/isci/task.c
> @@ -625,24 +625,6 @@ int isci_task_abort_task_set(
>  }
>
>
> -/**
> - * isci_task_clear_aca() - This function is one of the SAS Domain Template
> - *    functions. This is one of the Task Management functoins called by libsas.
> - * @d_device: This parameter specifies the domain device associated with this
> - *    request.
> - * @lun: This parameter specifies the lun       associated with this request.
> - *
> - * status, zero indicates success.
> - */
> -int isci_task_clear_aca(
> -       struct domain_device *d_device,
> -       u8 *lun)
> -{
> -       return TMF_RESP_FUNC_FAILED;
> -}
> -
> -
> -
>  /**
>   * isci_task_clear_task_set() - This function is one of the SAS Domain Template
>   *    functions. This is one of the Task Management functoins called by libsas.
> diff --git a/drivers/scsi/isci/task.h b/drivers/scsi/isci/task.h
> index cae168b8916f..f96633fa6939 100644
> --- a/drivers/scsi/isci/task.h
> +++ b/drivers/scsi/isci/task.h
> @@ -140,10 +140,6 @@ int isci_task_abort_task_set(
>         struct domain_device *d_device,
>         u8 *lun);
>
> -int isci_task_clear_aca(
> -       struct domain_device *d_device,
> -       u8 *lun);
> -
>  int isci_task_clear_task_set(
>         struct domain_device *d_device,
>         u8 *lun);
> diff --git a/drivers/scsi/mvsas/mv_init.c b/drivers/scsi/mvsas/mv_init.c
> index dcae2d4464f9..21429e3a3632 100644
> --- a/drivers/scsi/mvsas/mv_init.c
> +++ b/drivers/scsi/mvsas/mv_init.c
> @@ -64,7 +64,6 @@ static struct sas_domain_function_template mvs_transport_ops = {
>
>         .lldd_abort_task        = mvs_abort_task,
>         .lldd_abort_task_set    = mvs_abort_task_set,
> -       .lldd_clear_aca         = mvs_clear_aca,
>         .lldd_clear_task_set    = mvs_clear_task_set,
>         .lldd_I_T_nexus_reset   = mvs_I_T_nexus_reset,
>         .lldd_lu_reset          = mvs_lu_reset,
> diff --git a/drivers/scsi/mvsas/mv_sas.c b/drivers/scsi/mvsas/mv_sas.c
> index 1e52bc7febfa..fd273c3e069e 100644
> --- a/drivers/scsi/mvsas/mv_sas.c
> +++ b/drivers/scsi/mvsas/mv_sas.c
> @@ -1553,17 +1553,6 @@ int mvs_abort_task_set(struct domain_device *dev, u8 *lun)
>         return rc;
>  }
>
> -int mvs_clear_aca(struct domain_device *dev, u8 *lun)
> -{
> -       int rc = TMF_RESP_FUNC_FAILED;
> -       struct mvs_tmf_task tmf_task;
> -
> -       tmf_task.tmf = TMF_CLEAR_ACA;
> -       rc = mvs_debug_issue_ssp_tmf(dev, lun, &tmf_task);
> -
> -       return rc;
> -}
> -
>  int mvs_clear_task_set(struct domain_device *dev, u8 *lun)
>  {
>         int rc = TMF_RESP_FUNC_FAILED;
> diff --git a/drivers/scsi/mvsas/mv_sas.h b/drivers/scsi/mvsas/mv_sas.h
> index 8ff976c9967e..fa654c73beee 100644
> --- a/drivers/scsi/mvsas/mv_sas.h
> +++ b/drivers/scsi/mvsas/mv_sas.h
> @@ -441,7 +441,6 @@ int mvs_scan_finished(struct Scsi_Host *shost, unsigned long time);
>  int mvs_queue_command(struct sas_task *task, gfp_t gfp_flags);
>  int mvs_abort_task(struct sas_task *task);
>  int mvs_abort_task_set(struct domain_device *dev, u8 *lun);
> -int mvs_clear_aca(struct domain_device *dev, u8 *lun);
>  int mvs_clear_task_set(struct domain_device *dev, u8 * lun);
>  void mvs_port_formed(struct asd_sas_phy *sas_phy);
>  void mvs_port_deformed(struct asd_sas_phy *sas_phy);
> diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
> index d8a2121cb8d9..b8cf1bae4040 100644
> --- a/drivers/scsi/pm8001/pm8001_init.c
> +++ b/drivers/scsi/pm8001/pm8001_init.c
> @@ -123,7 +123,6 @@ static struct sas_domain_function_template pm8001_transport_ops = {
>
>         .lldd_abort_task        = pm8001_abort_task,
>         .lldd_abort_task_set    = pm8001_abort_task_set,
> -       .lldd_clear_aca         = pm8001_clear_aca,
>         .lldd_clear_task_set    = pm8001_clear_task_set,
>         .lldd_I_T_nexus_reset   = pm8001_I_T_nexus_reset,
>         .lldd_lu_reset          = pm8001_lu_reset,
> diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8001_sas.c
> index 160ee8b228c9..4368122ab475 100644
> --- a/drivers/scsi/pm8001/pm8001_sas.c
> +++ b/drivers/scsi/pm8001/pm8001_sas.c
> @@ -1357,14 +1357,6 @@ int pm8001_abort_task_set(struct domain_device *dev, u8 *lun)
>         return pm8001_issue_ssp_tmf(dev, lun, &tmf_task);
>  }
>
> -int pm8001_clear_aca(struct domain_device *dev, u8 *lun)
> -{
> -       struct pm8001_tmf_task tmf_task;
> -
> -       tmf_task.tmf = TMF_CLEAR_ACA;
> -       return pm8001_issue_ssp_tmf(dev, lun, &tmf_task);
> -}
> -
>  int pm8001_clear_task_set(struct domain_device *dev, u8 *lun)
>  {
>         struct pm8001_tmf_task tmf_task;
> diff --git a/drivers/scsi/pm8001/pm8001_sas.h b/drivers/scsi/pm8001/pm8001_sas.h
> index a17da1cebce1..3ea53a0d0cc1 100644
> --- a/drivers/scsi/pm8001/pm8001_sas.h
> +++ b/drivers/scsi/pm8001/pm8001_sas.h
> @@ -649,7 +649,6 @@ int pm8001_scan_finished(struct Scsi_Host *shost, unsigned long time);
>  int pm8001_queue_command(struct sas_task *task, gfp_t gfp_flags);
>  int pm8001_abort_task(struct sas_task *task);
>  int pm8001_abort_task_set(struct domain_device *dev, u8 *lun);
> -int pm8001_clear_aca(struct domain_device *dev, u8 *lun);
>  int pm8001_clear_task_set(struct domain_device *dev, u8 *lun);
>  int pm8001_dev_found(struct domain_device *dev);
>  void pm8001_dev_gone(struct domain_device *dev);
> diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
> index 698f2032807b..d59618898619 100644
> --- a/include/scsi/libsas.h
> +++ b/include/scsi/libsas.h
> @@ -637,7 +637,6 @@ struct sas_domain_function_template {
>         /* Task Management Functions. Must be called from process context. */
>         int (*lldd_abort_task)(struct sas_task *);
>         int (*lldd_abort_task_set)(struct domain_device *, u8 *lun);
> -       int (*lldd_clear_aca)(struct domain_device *, u8 *lun);
>         int (*lldd_clear_task_set)(struct domain_device *, u8 *lun);
>         int (*lldd_I_T_nexus_reset)(struct domain_device *);
>         int (*lldd_ata_check_ready)(struct domain_device *);
> --
> 2.26.2
>
