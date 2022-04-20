Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 874875080BD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 07:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359444AbiDTF4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 01:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359441AbiDTFzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 01:55:53 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3738DEDF
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 22:53:08 -0700 (PDT)
Received: from epcas3p3.samsung.com (unknown [182.195.41.21])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220420055302epoutp02de2d31045eb5dabbde141b2a90a56809~nhPZ9M9J21974119741epoutp02K
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 05:53:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220420055302epoutp02de2d31045eb5dabbde141b2a90a56809~nhPZ9M9J21974119741epoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1650433982;
        bh=gsbIJ9MYIvel4byuN1yOMJ7JFiezGXpDZDDAumV77cw=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=rVyqw+JA/W0UOkrmiPWjxvh3+7PFUPbTs+cSBpl/XbrixsBbGEru03f+527iwyqjT
         21BRMIfus4BJyY5Oj+BAc90McF/g+2wWcS/yK/VkU/emGWcPQYY1BFeENEcdxzwGP2
         G0+f7bQYQgXcJx4tRAnco7f80ev2Ie2tj1pGW9U4=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas3p2.samsung.com (KnoxPortal) with ESMTP id
        20220420055302epcas3p2613e0dc2fa7ad29ccb327f892a5c7dc4~nhPZcn3fr0321103211epcas3p2q;
        Wed, 20 Apr 2022 05:53:02 +0000 (GMT)
Received: from epcpadp4 (unknown [182.195.40.18]) by epsnrtp1.localdomain
        (Postfix) with ESMTP id 4Kjqb20RMLz4x9QV; Wed, 20 Apr 2022 05:53:02 +0000
        (GMT)
Mime-Version: 1.0
Subject: RE: [PATCH v2 2/5] scsi: ufshpb: Remove 0 assignment for enum value
Reply-To: keosung.park@samsung.com
Sender: Keoseong Park <keosung.park@samsung.com>
From:   Keoseong Park <keosung.park@samsung.com>
To:     Bean Huo <huobean@gmail.com>,
        ALIM AKHTAR <alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "tomas.winkler@intel.com" <tomas.winkler@intel.com>,
        "cang@codeaurora.org" <cang@codeaurora.org>,
        Daejun Park <daejun7.park@samsung.com>,
        "powen.kao@mediatek.com" <powen.kao@mediatek.com>,
        "peter.wang@mediatek.com" <peter.wang@mediatek.com>,
        cpgsproxy3 <cpgsproxy3@samsung.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20220419183044.789065-3-huobean@gmail.com>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <1796371666.21650433982047.JavaMail.epsvc@epcpadp4>
Date:   Wed, 20 Apr 2022 11:49:48 +0900
X-CMS-MailID: 20220420024948epcms2p83ddfc0ced8ab1074865151baaa6ab8b3
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20220419183923epcas2p426a61f579c8a096a8dce2f452640cf47
References: <20220419183044.789065-3-huobean@gmail.com>
        <20220419183044.789065-1-huobean@gmail.com>
        <CGME20220419183923epcas2p426a61f579c8a096a8dce2f452640cf47@epcms2p8>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Bean Huo <beanhuo@micron.com>
> 
>If the first enumerator has no initializer, the value of the corresponding
>constant is zero.
> 
>Signed-off-by: Bean Huo <beanhuo@micron.com>
>---
> drivers/scsi/ufs/ufshpb.h | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
> 
>diff --git a/drivers/scsi/ufs/ufshpb.h b/drivers/scsi/ufs/ufshpb.h
>index 2825ec69a6a6..b7e2817d4e76 100644
>--- a/drivers/scsi/ufs/ufshpb.h
>+++ b/drivers/scsi/ufs/ufshpb.h
>@@ -59,8 +59,8 @@ enum UFSHPB_MODE {
> };
> 
> enum UFSHPB_STATE {
>-        HPB_INIT = 0,
>-        HPB_PRESENT = 1,
>+        HPB_INIT,
>+        HPB_PRESENT,
>         HPB_SUSPEND,
>         HPB_FAILED,
>         HPB_RESET,
>-- 
>2.34.1
> 

Reviewed-by: Keoseong Park <keosung.park@samsung.com>

Best Regards,
Keoseong Park
