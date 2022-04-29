Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF7E5147C1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 13:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358024AbiD2LKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 07:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358074AbiD2LKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 07:10:12 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C396344CC;
        Fri, 29 Apr 2022 04:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651230412; x=1682766412;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=rOn7ihLjZxMlGQmWbzVw3x2VHGTlH3YuYPK6W1CvuVs=;
  b=MVDm81wmnZfyjYVzgOHMI+sHYRhq4zanMpHd/u/F5pD8km3vgblgIgG9
   EJAVKds8/1U4/fECO0n/IVp9AjMQJG5sV/oa88HO/kLYoZkXvs7HlTh+1
   yGEEBrh/K/6JkCc6QeZbICu+lEJ9jevSFf+/Wh9VzhY7GK0k0flJNOSje
   Q=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 29 Apr 2022 04:06:51 -0700
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 04:06:51 -0700
Received: from blr-ubuntu-242.ap.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 29 Apr 2022 04:06:49 -0700
From:   Naina Vaskenly <quic_nvaskenl@quicinc.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        lijian <lijian@yulong.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Kumar Anshuman <quic_anshuk@quicinc.com>,
        Naina Vaskenly <quic_nvaskenl@quicinc.com>
Subject: [PATCH V0 1/1] media: v4l2-core: Enable reserved field of v4l2_event
Date:   Fri, 29 Apr 2022 16:36:07 +0530
Message-ID: <cover.1651223992.git.quic_nvaskenl@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'reserved' member of struct v4l2_event is currently not enabled.
This field can be used to transfer data, if >64 bytes of data
has to be sent. Hence, added this change to copy the reserved field in
__v4l2_event_queue_fh.

Naina Vaskenly (1):
  media: v4l2-core: Enable reserved field of v4l2_event

 drivers/media/v4l2-core/v4l2-event.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
2.7.4

