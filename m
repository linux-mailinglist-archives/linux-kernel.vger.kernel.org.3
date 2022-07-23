Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 374F057EEA2
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 12:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239454AbiGWKPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 06:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239395AbiGWKPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 06:15:21 -0400
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259B36A9CC
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 03:05:31 -0700 (PDT)
X-QQ-mid: bizesmtp85t1658570658th2mgs73
Received: from eureka.localdomain ( [123.124.208.226])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 23 Jul 2022 18:04:07 +0800 (CST)
X-QQ-SSF: 01400000002000B0D000B00A0000020
X-QQ-FEAT: ILHsT53NKPj0HRDuEtI5CbFD7rnuEHAyGC+20aqF8DJXqYDMQ5BN+2SdvaKK5
        zCGT1gSzYgjkwhGLcKrh3muLGgmAKIE0BdZ8BLlySm7EAJ4bnrGbaZHVQoHMHLSzcANBti3
        +B7UiNHj+XVbpxfxe9rm7UvYiMgBdpEdvIk8E0TH/ZIWFH/0qd4O+HNmV1hBLREisoz5Gl+
        nT38oQvOWPKfZe/DcCrHNfSNcCHRirRTd+7YOf75SsT0vc1nQ/vXLS1JAsPvr04dNLEp51p
        4h9+uDR0AAaT1DLeNOcOzMty/hsgfyQ4eXiep6N8UQPnwexDrXHN5gUzCjFBdHIB/um3Cyw
        hC39LlHsUDwA/t4P5GI44+8yyAzAyCThZOA3t8SbsMwyGDWZ5NLpDyodWBK0A==
X-QQ-GoodBg: 2
From:   Wang You <wangyoua@uniontech.com>
To:     bvanassche@acm.org
Cc:     axboe@kernel.dk, fio@vger.kernel.org, hch@lst.de,
        jaegeuk@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, ming.lei@redhat.com,
        wangxiaohua@uniontech.com, wangyoua@uniontech.com
Subject: Re: [PATCH v2 1/2] block: Introduce nr_sched_batch sys interface
Date:   Sat, 23 Jul 2022 18:04:06 +0800
Message-Id: <20220723100406.437387-1-wangyoua@uniontech.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <da0fe451-c036-cd18-7eb2-55c51c104ab5@acm.org>
References: <da0fe451-c036-cd18-7eb2-55c51c104ab5@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign3
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Do we need this new parameter? How does the performance of reducing 
> nr_requests compare to configuring nr_sched_batch?

It seems I can't get convincing data in the current test conditions, sorry, 
please ignore it unless I can produce valid evidence.

I will reconsider the effect of this modification on a single disk, 
from recent testing it seems that the link to the raid controller has 
a lot of impact.

Thanks,

Wang.


