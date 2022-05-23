Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0488530900
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 07:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233232AbiEWFug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 01:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232298AbiEWFuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 01:50:19 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA66D2CCB8
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 22:50:17 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220523055015epoutp047cf6261b466c406a2732aa55c9fa2b63~xpfZMrxw91227812278epoutp04T
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 05:50:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220523055015epoutp047cf6261b466c406a2732aa55c9fa2b63~xpfZMrxw91227812278epoutp04T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1653285015;
        bh=pA/oh00VW5BYtnIAPos+Rl3OXf5h4kl7QqAwkIfF1oA=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=Cz/8O4u3/2i6uVnkr3R8kLYex8x9tLropJtwjA255Ledja1ZowHY0Ptolnh4DGPpE
         ALTsB61ZzKolK86NYRiot9Os267HXFR5Dd9/UOFxv9w3WTcS9d3OyaIWiQXI79Rqcm
         KUlEszj8v6AmL1ZejcJ1chMhHZMXXMqE+p4hsFD0=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20220523055015epcas2p31401698dcf419c43915aa32487c96d57~xpfYwDQG72228522285epcas2p3-;
        Mon, 23 May 2022 05:50:15 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.100]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4L65yW5dQwz4x9QZ; Mon, 23 May
        2022 05:50:11 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        82.22.09764.1902B826; Mon, 23 May 2022 14:50:09 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20220523055008epcas2p4b3c935a52b6b362f1bd84a8a57949b3e~xpfTH7w_H0414604146epcas2p4w;
        Mon, 23 May 2022 05:50:08 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220523055008epsmtrp2b1ee6aa9b949dcc80073bcaa5c24124e~xpfTG7zMY2587425874epsmtrp2b;
        Mon, 23 May 2022 05:50:08 +0000 (GMT)
X-AuditID: b6c32a46-79619a8000002624-89-628b20911f9c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        FA.05.08924.0902B826; Mon, 23 May 2022 14:50:08 +0900 (KST)
Received: from KORDO040863 (unknown [10.229.8.56]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220523055008epsmtip2ae963e12a700d380b6eb784abdcad9ed~xpfS-wqnw1425914259epsmtip2M;
        Mon, 23 May 2022 05:50:08 +0000 (GMT)
From:   "Hoyoung SEO" <hy50.seo@samsung.com>
To:     "'SEO HOYOUNG'" <hy50.seo@samsung.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20220522171847.66373-1-hy50.seo@samsung.com>
Subject: RE: [RESEND PATCH v1] scsi: ufs: Change the shutting_down flag
 setting position
Date:   Mon, 23 May 2022 14:50:08 +0900
Message-ID: <221501d86e68$f5e613a0$e1b23ae0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQHYKRR1NoX3jnWOYKYl5kKfNMG5oQK7eI1prRai7gA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCKsWRmVeSWpSXmKPExsWy7bCmqe5Ehe4kgyUTRS1WL37AYnF51xw2
        i+7rO9gcmD36tqxi9Pi8SS6AKSrbJiM1MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJ
        IS8xN9VWycUnQNctMwdoh5JCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwLxArzgx
        t7g0L10vL7XEytDAwMgUqDAhO+P+8utsBa+FKmZufsLYwHiPv4uRk0NCwETizrVdjF2MXBxC
        AjsYJX53TWeDcD4xSixasYUVwvnMKHFt4wtmuJb+ScwQiV2MEud2r2aBcJ4zSsw52s8IUsUm
        oCVxfeJbsA4RgSyJB4/nMoHYnAJWEj2HL4HZwgJREmcuzGUDsVkEVCWaV25iAbF5BSwlFt2c
        CGULSpyc+QTMZhaQl9j+dg7UFQoSO86+ZoSYbyXxYPoRRogaEYnZnW1g10kInGKXuPh9ORtE
        g4vEnV3/2CFsYYlXx7dA2VISn9/thaoplvjxZjUTRHMDo8TS9mNQ24wlZj1rB9rAAbRBU2L9
        Ln0QU0JAWeLILajb+CQ6Dv9lhwjzSnS0CUE0KkmcmXsbKiwhcXB2DkTYQ2LGnrPsExgVZyF5
        chaSJ2cheWYWwtoFjCyrGMVSC4pz01OLjQqM4JGdnJ+7iRGc/LTcdjBOeftB7xAjEwfjIUYJ
        DmYlEd7tiR1JQrwpiZVVqUX58UWlOanFhxhNgcE+kVlKNDkfmH7zSuINTSwNTMzMDM2NTA3M
        lcR5vVI2JAoJpCeWpGanphakFsH0MXFwSjUw7WBdte8av8z7I5veacVN35A8/8gS7doQxpLe
        t/Z/iuVceSMLkxeZXp9r3WUuduPtJsf7V5SN+OTlsjqSDbU4Gq5EGS7KeBzB1e1qdIc56Wjl
        RsWWR6mOvfN3iPrtuDjbI8le7LOuq9+hS0tUdzbylaqUNYav3x6U52s6/4X8CY1Nea2nGH8+
        jW6pvOB8lfnB/1Nh7Nrra+ZbWmit2f7CMG2r8J5Q21ezf59d6qwuqnqRJ92sJ1Y3qVtsrcYr
        9zKZdx/1rJdoH/719b3ifmNha6YZzw62z9s8T9GL66cC/wWP11r29scXqq36cujatOKYnZsF
        PaaELLL9XCX6cvU7wW88y88rlK9bncO3jJdPiaU4I9FQi7moOBEAB+fWrwcEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKLMWRmVeSWpSXmKPExsWy7bCSvO4Ehe4kgw2XzS1WL37AYnF51xw2
        i+7rO9gcmD36tqxi9Pi8SS6AKYrLJiU1J7MstUjfLoEr4/7y62wFr4UqZm5+wtjAeI+/i5GT
        Q0LAROJO/yTmLkYuDiGBHYwSh2dNZYZISEj8X9zEBGELS9xvOcIKUfSUUaLh80OwIjYBLYnr
        E9+C2SICORJLFu2HmtTNKLHt6zQWkASngJVEz+FLYJOEBSIkWr53soLYLAKqEs0rN4HV8ApY
        Siy6ORHKFpQ4OfMJmM0soC3R+7CVEcKWl9j+dg7UdQoSO86+ZoRYbCXxYPoRqBoRidmdbcwT
        GIVmIRk1C8moWUhGzULSsoCRZRWjZGpBcW56brFhgVFearlecWJucWleul5yfu4mRnDIa2nt
        YNyz6oPeIUYmDsZDjBIczEoivNsTO5KEeFMSK6tSi/Lji0pzUosPMUpzsCiJ817oOhkvJJCe
        WJKanZpakFoEk2Xi4JRqYNIOtOlbPcs2zs3t3jdHGR5zptkrlY+2nErhWHxdIv7ItYJLTBH7
        de7PriuOuvPQbr1LR9bfp92WJ5UCZ4kpfjtlYOxyKSv9Sd7fa8utOHjNY5gldJrOVYWlf0x1
        P9gWlr4/sXCOYVzN1h9/1Uwj6xvk1/87LBM851dndHLu7ZoH/e0T7340fM6eyv7v2o+GNUz3
        pj73eHb2k0WxsFOJxMrjR1WqdG9l9pUeOZEQuy93+0GDKe5rpx4+ekTUyoNnj6fkXt2e43Oa
        NuioNz0+J/hmgREX5zQutdbaKn2X04tYXc40eX+c1sPUyJj6inOfkrzszdKY65pfTglMY7j9
        dJXgjceLeq16VvlJnFp4WomlOCPRUIu5qDgRAB/JW2boAgAA
X-CMS-MailID: 20220523055008epcas2p4b3c935a52b6b362f1bd84a8a57949b3e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220523053658epcas2p2400c4c92126baa05d5fb4b5d6ed7e274
References: <CGME20220523053658epcas2p2400c4c92126baa05d5fb4b5d6ed7e274@epcas2p2.samsung.com>
        <20220522171847.66373-1-hy50.seo@samsung.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: SEO HOYOUNG [mailto:hy50.seo@samsung.com]
> Sent: Monday, May 23, 2022 2:19 AM
> To: linux-scsi@vger.kernel.org; linux-kernel@vger.kernel.org;
> alim.akhtar@samsung.com; avri.altman@wdc.com; jejb@linux.ibm.com;
> martin.petersen@oracle.com; beanhuo@micron.com; asutoshd@codeaurora.org;
> cang@codeaurora.org; bvanassche@acm.org; bhoon95.kim@samsung.com;
> kwmad.kim@samsung.com
> Cc: SEO HOYOUNG
> Subject: [RESEND PATCH v1] scsi: ufs: Change the shutting_down flag
> setting position
> 
> When System shutdown, will called ufshcd_wl_shutdown().
> Then the shutting_down falg set to 1 at ufshcd_wl_shutdown().
> And send to SSU cmd at ufshcd_wl_shutdown()->__ufshcd_wl_suspend()->
> ufshcd_set_dev_pwr_mode() function.
> 
> If occurred fail during send SSU cmd,
> then will called ufshcd_err_handler for recovery.
> But already set shutting_down to 1, so ufs driver could not recovery.
> Then System wait for SSU cmd to be completed and eventaully it will tak
> Hang.
> So changed the position where shutting_down is set.
> 
> Signed-off-by: SEO HOYOUNG <hy50.seo@samsung.com>
> ---
>  drivers/scsi/ufs/ufshcd.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c index
> 1fb3a8b9b03e..65d47cd5afbe 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -9235,10 +9235,6 @@ static void ufshcd_wl_shutdown(struct device *dev)
> 
>  	hba = shost_priv(sdev->host);
> 
> -	down(&hba->host_sem);
> -	hba->shutting_down = true;
> -	up(&hba->host_sem);
> -
>  	/* Turn on everything while shutting down */
>  	ufshcd_rpm_get_sync(hba);
>  	scsi_device_quiesce(sdev);
> @@ -9248,6 +9244,10 @@ static void ufshcd_wl_shutdown(struct device *dev)
>  		scsi_device_quiesce(sdev);
>  	}
>  	__ufshcd_wl_suspend(hba, UFS_SHUTDOWN_PM);
> +
> +	down(&hba->host_sem);
> +	hba->shutting_down = true;
> +	up(&hba->host_sem);
>  }
> 
>  /**
> --
> 2.26.0

Hi,

It seems that same patch below this.
https://lore.kernel.org/lkml/74cade30-6dde-c5f7-e009-b34423d22c12@intel.com/

I think that will occurred error with called __ufshcd_wl_suspend().

So the hba->shutting_down need to set after call __ufshcd_wl_suspend().
Otherwise, the error_handler cannot operate when an error occurs.
Please give opinion.

Thanks.

