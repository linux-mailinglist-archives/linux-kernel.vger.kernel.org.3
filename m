Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD15B4AD2A1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 09:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348710AbiBHIAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 03:00:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348723AbiBHIAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 03:00:45 -0500
Received: from out199-12.us.a.mail.aliyun.com (out199-12.us.a.mail.aliyun.com [47.90.199.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA86C0401F6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 00:00:44 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R931e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0V3vYOvJ_1644307232;
Received: from 30.178.81.201(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0V3vYOvJ_1644307232)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 08 Feb 2022 16:00:40 +0800
Message-ID: <d528b122-bace-5318-f6a5-ec7af6eb14d7@linux.alibaba.com>
Date:   Tue, 8 Feb 2022 16:00:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
From:   kanie <kanie@linux.alibaba.com>
Subject: Re: [PATCH] uio: Replace mutex info_lock with percpu_ref to improve
 performance
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     xiaoguang.wang@linux.alibaba.com, xlpang@linux.alibaba.com,
        linux-kernel@vger.kernel.org
References: <1644304760-11862-1-git-send-email-kanie@linux.alibaba.com>
 <YgIa+W6kAsWMUdj3@kroah.com>
In-Reply-To: <YgIa+W6kAsWMUdj3@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/2/8 15:25, Greg KH 写道:
> On Tue, Feb 08, 2022 at 03:19:20PM +0800, Guixin Liu wrote:
>> This patch includes a modification to repace mutex info_lock with
>> percpu_ref, in order to improve uio performance.
> How does it improve performance?  What benchmark are you using and what
> are the results?
>
> These changes are quite complex, you need to better describe these in
> order to be able to have them accepted.
>
> thanks,
>
> greg k-h

okay, I will supplement the performance-test result later.

Guixin Liu

