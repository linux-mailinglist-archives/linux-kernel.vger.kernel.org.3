Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5957E558CE7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 03:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbiFXBjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 21:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiFXBjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 21:39:41 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06CF56C17;
        Thu, 23 Jun 2022 18:39:39 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 81E815C0186;
        Thu, 23 Jun 2022 21:39:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 23 Jun 2022 21:39:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1656034777; x=1656121177; bh=565TWR/uy2A0QxlobJCGVdPrSxTk
        rfuJfZYcREIrUeo=; b=MZYy8O0KJEwXEMZ8aazL1zILdov7ZnG7azysEGnZ1lJr
        A68IPbgIjmhkShae+eeUEqKjFVR5mtejFtrivBmUnHvJUK3vERL9pOxyHiphins6
        UW9YvO+DBkjXR1kryvZwVwonpA3azs5fz+BKUIJim53PZ5IDLChEIUInWEP3XP19
        0ix3Gl+ePef4Ajr14gN8aHzS3bU/2rCQvClkSY0ZT1Zjy7uyT7sIBNitnGUQLM5q
        QslErpMB8aEQ45M7sAbLrqaBZKLvxXY6UjX4ZHp4KOjhSeL9gfH+62TiG03cjLZD
        UaCflCv7JbgyTqvgokDq9gn7j3sKVH3ddwCG816U3Q==
X-ME-Sender: <xms:2BW1Yss5qOFzkveUYaHLOnJyv2WYI8p5lLB1OoK46yoKaEPj5_qZxA>
    <xme:2BW1YpcZp9HFGfyL2jxkIuicetclo5QcVYC2TSZaXILGOYz9PIlYud3_n26eAA1Fo
    UBY-CUYwPlvlnLzEEQ>
X-ME-Received: <xmr:2BW1Ynznt-XacYUM81g7-TPI-oS7DfMT48B4LDAMfGwvVcF9MbNOiIJgEUV2dL-o3V32HkuRiFaiiUnnN2dNr8pe6XOjMfDBf4g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudefkedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefhihhnnhcu
    vfhhrghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrg
    htthgvrhhnpeelueehleehkefgueevtdevteejkefhffekfeffffdtgfejveekgeefvdeu
    heeuleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hfthhhrghinheslhhinhhugidqmheikehkrdhorhhg
X-ME-Proxy: <xmx:2BW1YvNjejz_WbriN67i723QUHpb2L833EWVjnkHc5OsMYi-DQAa1w>
    <xmx:2BW1Ys-kMNBJN1hxheCcvQPmEgLC3-VJTngErheCtKSwHetoaXQC6Q>
    <xmx:2BW1YnXCgkqmH5za3KLHjLuhzF2Mqa6FHiza7AaycOJZx5i8a346ow>
    <xmx:2RW1YuLcVyxAgeNVzou6YI6HOPe0F-Hdp6_vs2DuiTcwlczapd5BCw>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Jun 2022 21:39:34 -0400 (EDT)
Date:   Fri, 24 Jun 2022 11:39:32 +1000 (AEST)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Li Zhijian <lizhijian@fujitsu.com>
cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: Enlarge log buffer length to 256
In-Reply-To: <20220624012542.1384858-1-lizhijian@fujitsu.com>
Message-ID: <9831381e-f9c7-f7af-e6da-a757a76f34@linux-m68k.org>
References: <20220624012542.1384858-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 24 Jun 2022, Li Zhijian wrote:

> scsi_report_sense() is possble to print messages exceeding 128 bytes:
> [  475.156955] sd 9:0:0:0: Warning! Received an indication that the LUN assignments on this target have changed. The Linux SCSI layer does not automatical
> 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>  drivers/scsi/scsi_logging.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/scsi_logging.c b/drivers/scsi/scsi_logging.c
> index b02af340c2d3..edc3fe8c7e0f 100644
> --- a/drivers/scsi/scsi_logging.c
> +++ b/drivers/scsi/scsi_logging.c
> @@ -17,7 +17,7 @@
>  
>  static char *scsi_log_reserve_buffer(size_t *len)
>  {
> -	*len = 128;
> +	*len = 256;
>  	return kmalloc(*len, GFP_ATOMIC);
>  }
>  

Perhaps it's better to waste fewer words (both kinds). E.g.

diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index 49ef864df581..e7283bf23db3 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -463,13 +463,11 @@ static void scsi_report_sense(struct scsi_device *sdev,
 			evt_type = SDEV_EVT_LUN_CHANGE_REPORTED;
 			scsi_report_lun_change(sdev);
 			sdev_printk(KERN_WARNING, sdev,
-				    "Warning! Received an indication that the "
 				    "LUN assignments on this target have "
 				    "changed. The Linux SCSI layer does not "
 				    "automatically remap LUN assignments.\n");
 		} else if (sshdr->asc == 0x3f)
 			sdev_printk(KERN_WARNING, sdev,
-				    "Warning! Received an indication that the "
 				    "operating parameters on this target have "
 				    "changed. The Linux SCSI layer does not "
 				    "automatically adjust these parameters.\n");
