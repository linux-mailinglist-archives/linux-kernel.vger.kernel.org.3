Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0731255D836
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238765AbiF1JiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 05:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234605AbiF1JiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 05:38:14 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2CEA130A;
        Tue, 28 Jun 2022 02:38:11 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3AwEfiD6BZ9qbamxVW/9Phw5YqxClBgxIJ4g17XOL?=
 =?us-ascii?q?fVwLtgmtzhmMEnGIcWD+DM/mCazb1cttxbNzn80IEsJCAx9UxeLYW3SszFioV8?=
 =?us-ascii?q?6IpJjg4wn/YZnrUdouaJK5ex512huLocYZkHhcwmj/3auK79SMkjPnRLlbBILW?=
 =?us-ascii?q?s1h5ZFFYMpBgJ2UoLd94R2uaEsPDha++/kYqaT/73ZDdJ7wVJ3lc8sMpvnv/AU?=
 =?us-ascii?q?MPa41v0tnRmDRxCUcS3e3M9VPrzLonpR5f0rxU9IwK0ewrD5OnREmLx9BFrBM6?=
 =?us-ascii?q?nk6rgbwsBRbu60Qqm0yIQAvb9xEMZ4HFaPqUTbZLwbW9TiieJntJwwdNlu4GyS?=
 =?us-ascii?q?BsyI+vHn+F1vxxwSnsgYvMeo+ebSZS4mYnJp6HcSFPi3/VnDUceOYwe5/YyBD8?=
 =?us-ascii?q?e9rofMj9lRhKOheiexLO9V/kqh84masLsOes3v3h60TDfS+4rXZ3ZWKjMzdhC1?=
 =?us-ascii?q?Tw0i4ZFGvO2T84Ybyd/KRfNeRtCPn8JB58k2uSlnH/yd3tfsl39ja425XXDiRd?=
 =?us-ascii?q?6y7nFLtXYYJqJSN9Tk0LeoXjJl1kVqDly2Me3kGLDqyzzwLSU236TZW7bL5Xgn?=
 =?us-ascii?q?tYCvbFZ7jZ75MUqaGaG?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A99DtYKvfHESOGhJj5wy2oRmQ7skD7NV00zEX?=
 =?us-ascii?q?/kB9WHVpmszxra+TdYcgpGfJYVEqKQgdcLG7Sc+9qBznhPxICOUqXYtKGTOW31?=
 =?us-ascii?q?dAT7sSibcKoQeQeBEWn9Q1vcwLHpSWSuefMbEQt6fHCWeDf+rIjOP3lZxAm92u?=
 =?us-ascii?q?s0tFfEV7bb169QdlBkK+Gk1yfgNPAp00D/Onl7B6jgvlaXIKdd66G3VAe+DCou?=
 =?us-ascii?q?fAnJXgbQVDKAUg7GC1/E6VwY+/Ax6FxQ0fTj8K5b8j9FLOmwv/6r7mk9zT8G6m?=
 =?us-ascii?q?61Pu?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="126760304"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 28 Jun 2022 17:38:09 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 1A6BE4D68A24;
        Tue, 28 Jun 2022 17:38:07 +0800 (CST)
Received: from G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Tue, 28 Jun 2022 17:38:06 +0800
Received: from [192.168.122.212] (10.167.226.45) by
 G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Tue, 28 Jun 2022 17:38:07 +0800
To:     <fthain@linux-m68k.org>
CC:     <jejb@linux.ibm.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <lizhijian@fujitsu.com>,
        <martin.petersen@oracle.com>
References: <9831381e-f9c7-f7af-e6da-a757a76f34@linux-m68k.org>
Subject: Re: [PATCH] scsi: Enlarge log buffer length to 256
From:   "Li, Zhijian" <lizhijian@fujitsu.com>
Message-ID: <6cbb4340-abc2-d902-7ae6-0ae169a97132@fujitsu.com>
Date:   Tue, 28 Jun 2022 17:38:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <9831381e-f9c7-f7af-e6da-a757a76f34@linux-m68k.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-yoursite-MailScanner-ID: 1A6BE4D68A24.AEE54
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@fujitsu.com
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry for the late reply. (Strange! this reply didn't arrive to my mailbox)

> On Fri, 24 Jun 2022, Li Zhijian wrote:
>
> > scsi_report_sense() is possble to print messages exceeding 128 bytes: > [ 475.156955] sd 9:0:0:0: Warning! Received an indication that the 
> LUN assignments on this target have changed. The Linux SCSI layer does 
> not automatical > > Signed-off-by: Li Zhijian <lizhijian@fujitsu.com> 
> > --- > drivers/scsi/scsi_logging.c | 2 +- > 1 file changed, 1 
> insertion(+), 1 deletion(-) > > diff --git 
> a/drivers/scsi/scsi_logging.c b/drivers/scsi/scsi_logging.c > index 
> b02af340c2d3..edc3fe8c7e0f 100644 > --- a/drivers/scsi/scsi_logging.c 
> > +++ b/drivers/scsi/scsi_logging.c > @@ -17,7 +17,7 @@ > > static 
> char *scsi_log_reserve_buffer(size_t *len) > { > - *len = 128; > + 
> *len = 256; > return kmalloc(*len, GFP_ATOMIC); > } >
> Perhaps it's better to waste fewer words (both kinds). E.g.
Yes, it's an option. if no objection, i will apply your suggestion in 
24h later. hahaha :)

Thanks
Zhijian


>
> diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c 
> index 49ef864df581..e7283bf23db3 100644 --- 
> a/drivers/scsi/scsi_error.c +++ b/drivers/scsi/scsi_error.c @@ -463,13 
> +463,11 @@ static void scsi_report_sense(struct scsi_device *sdev,   			evt_type = SDEV_EVT_LUN_CHANGE_REPORTED;
>   			scsi_report_lun_change(sdev);
>   			sdev_printk(KERN_WARNING, sdev,
> - "Warning! Received an indication that the "   				    "LUN assignments on this target have "
>   				    "changed. The Linux SCSI layer does not "
>   				    "automatically remap LUN assignments.\n");
>   		} else if (sshdr->asc == 0x3f)
>   			sdev_printk(KERN_WARNING, sdev,
> - "Warning! Received an indication that the "   				    "operating parameters on this target have "
>   				    "changed. The Linux SCSI layer does not "
>   				    "automatically adjust these parameters.\n");



