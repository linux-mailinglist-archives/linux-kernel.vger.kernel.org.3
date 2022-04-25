Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 430D950DC9A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 11:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238348AbiDYJab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 05:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235892AbiDYJ35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 05:29:57 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19AE26E;
        Mon, 25 Apr 2022 02:26:48 -0700 (PDT)
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Kn02S6M1zz67NMW;
        Mon, 25 Apr 2022 17:24:16 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Mon, 25 Apr 2022 11:26:46 +0200
Received: from [10.47.92.213] (10.47.92.213) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.24; Mon, 25 Apr
 2022 10:26:45 +0100
Message-ID: <2fe555d8-9bb8-59ca-d0c7-d2ad6249f50a@huawei.com>
Date:   Mon, 25 Apr 2022 10:26:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: 5.17.0 boot issue on Miata
To:     Bob Tracy <rct@frus.com>, <debian-alpha@lists.debian.org>
CC:     Michael Cree <mcree@orcon.net.nz>, <linux-alpha@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <Yj0u150JJpsb9nj4@gherkin.frus.com> <20220326222157.GA13650@tower>
 <YkuejknyPDJoQEDC@gherkin.frus.com> <20220405050125.GA25969@tower>
 <YkxKRElYUhMgOOCN@gherkin.frus.com>
 <10d61d8f-edfc-fc39-0936-233692464dbd@gmx.de>
 <Yk4XsdHvjrLqN1LR@gherkin.frus.com> <YlAyZdZ6afL58Ege@gherkin.frus.com>
 <Yl5AXvU+cBH5ex4K@gherkin.frus.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <Yl5AXvU+cBH5ex4K@gherkin.frus.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.92.213]
X-ClientProxiedBy: lhreml702-chm.china.huawei.com (10.201.108.51) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/04/2022 05:53, Bob Tracy wrote:
> (Adding linux-scsi and linux-kernel, now that bisection is complete.)
> 
> On Wed, Apr 06, 2022 at 05:44:01PM -0500, Bob Tracy wrote:
>> v5.17-rc2 ok.  v5.17-rc3 I get the disk sector errors and hang that I
>> reported in the first message in this thread.
> This is on an Alpha Miata platform (PWS 433au) with QLogic ISP1020 controller.
> 
> Here's the implicated commit:
> 
> edb854a3680bacc9ef9b91ec0c5ff6105886f6f3 is the first bad commit
> commit edb854a3680bacc9ef9b91ec0c5ff6105886f6f3
> Author: Ming Lei<ming.lei@redhat.com>
> Date:   Thu Jan 27 23:37:33 2022 +0800
> 
>      scsi: core: Reallocate device's budget map on queue depth change
>      

Please try v5.18-rc2 as it should have a fix in commit eaba83b5b850

Thanks,
John
