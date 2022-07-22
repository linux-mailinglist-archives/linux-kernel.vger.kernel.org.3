Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B22957DB9F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 09:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234687AbiGVH55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 03:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234437AbiGVH5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 03:57:53 -0400
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D051B9A6BB
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 00:57:50 -0700 (PDT)
X-QQ-mid: bizesmtp71t1658476663tnxs2lfk
Received: from eureka.localdomain ( [123.124.208.226])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 22 Jul 2022 15:57:34 +0800 (CST)
X-QQ-SSF: 01400000002000B0D000000A0000020
X-QQ-FEAT: o819FCS+0JQ19gP/dGkIlUiEL8WsGfcEbawBWGAd3xZxrcd2DRuXceMjq0e1k
        3t0wN3ErSovzYQzKVA3wm+ok5gn7fqxAU9ThUxMVwWQSHxAqXT33rkGSkMC78fbow8/U/lt
        sxYK1TSRlD5aNdDnCZcBABJ95WFeldvirXAZi7sXwcN4YFBUvf7HI0sV0HJPRCV8Knqs/Z5
        rHqA0STouJMsz60KA0BRMdHMr7fnHdgYU/17TR6mPJxRiTT6ihcD7cFuHoVVr4BGhe2t4Nk
        OVkQuXln4lNISWz5N4Nr+jdbVueKOikFo4ckbiRLIQ0vfwGuckN+1jDN8Nhp57F6OveW7Wn
        Bll+FS/dr9NnS00syB1MMiNf3aDi3jgPjUubJHJ90OyyuYocbFgqwxHtoj/gbaNVAr8tTxk
        Hp/i9DmlOks=
X-QQ-GoodBg: 1
From:   Wang You <wangyoua@uniontech.com>
To:     bvanassche@acm.org
Cc:     axboe@kernel.dk, fio@vger.kernel.org, hch@lst.de,
        jaegeuk@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, ming.lei@redhat.com,
        wangxiaohua@uniontech.com, wangyoua@uniontech.com
Subject: Re: [PATCH 0/2] Improve mq-deadline performance in HDD
Date:   Fri, 22 Jul 2022 15:57:33 +0800
Message-Id: <20220722075733.363043-1-wangyoua@uniontech.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <eda05d1b-bef5-b4c0-8ac3-ad8aa13242d2@acm.org>
References: <eda05d1b-bef5-b4c0-8ac3-ad8aa13242d2@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign3
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The code in these patches has not been formatted according to the kernel 
> coding style guidelines. Please try to run git clang-format HEAD^ on 
> both patches and review the changes made by clang-format.

> Thanks,

> Bart.

I apologize for the code formatting issues, I used git-clang-format 
to reformat both patches automatically, and appreciate your comments.
PATCH v2 will be sent later.

Thanks,

Wang.


