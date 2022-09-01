Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 835215A92A6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 11:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234461AbiIAJD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 05:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234412AbiIAJCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 05:02:45 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1DB136090
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 02:01:46 -0700 (PDT)
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MJFLX3Xltz6HJG9;
        Thu,  1 Sep 2022 16:57:56 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Sep 2022 11:01:43 +0200
Received: from [10.48.151.166] (10.48.151.166) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 1 Sep 2022 10:01:42 +0100
Message-ID: <bfcdda60-6871-4f4b-d346-23d24ccef65d@huawei.com>
Date:   Thu, 1 Sep 2022 10:01:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
From:   John Garry <john.garry@huawei.com>
Subject: Re: [PATCH v2 1/4] bus: hisi_lpc: Don't dereference fwnode handle
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "xuwei (O)" <xuwei5@huawei.com>
References: <20220708210859.6774-1-andriy.shevchenko@linux.intel.com>
 <f1d58027-099c-0486-0433-f97ec64ecfb7@huawei.com>
 <CAHp75Vf1JmkJ06np18+iTb+U7RZtbFQTRg-COyc+-V6URSsfZA@mail.gmail.com>
 <b83244b2-8881-bd74-a7e1-33006b42a636@huawei.com>
 <YwTV1g4RCgiCNl68@smile.fi.intel.com>
In-Reply-To: <YwTV1g4RCgiCNl68@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.151.166]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/08/2022 14:27, Andy Shevchenko wrote:
>> I'll pick these up to be sent upstream by xu wei through the arm-soc tree.
> Thanks!
> 
> ...
> 
>> b. Add a patch to convert this driver to use
>> platform_device_register_full(). This obviously conflicts with a.
> This one can be done beforehand, because it doesn't change flow, correct?

The general flow is the same. It may be previewed here:
https://github.com/hisilicon/kernel-dev/commits/private-topic-lpc-6.0-platform-full

Thanks,
John
