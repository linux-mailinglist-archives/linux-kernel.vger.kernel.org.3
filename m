Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF30592C46
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbiHOJzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 05:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbiHOJzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 05:55:38 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952E6E0A6;
        Mon, 15 Aug 2022 02:55:37 -0700 (PDT)
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4M5qQj0nclz67yKZ;
        Mon, 15 Aug 2022 17:55:25 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 15 Aug 2022 11:55:35 +0200
Received: from [10.48.150.107] (10.48.150.107) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 15 Aug 2022 10:55:35 +0100
Message-ID: <e431a4ce-b9c3-a9d8-57c1-c9d055c2ca0f@huawei.com>
Date:   Mon, 15 Aug 2022 10:55:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
To:     Linux ACPI <linux-acpi@vger.kernel.org>,
        <sakari.ailus@linux.intel.com>, <sbinding@opensource.cirrus.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
From:   John Garry <john.garry@huawei.com>
Subject: [BUG] Issue with commit 923044133367 ("ACPI: property: Unify integer
 value reading functions")
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.150.107]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


My driver of interest fails to probe for v6.0-rc1 for ACPI FW:
[    5.373722] hisi_sas_v2_hw HISI0162:01: could not get property sas-addr

from a device_property_read_u8_array() call

The following fixes it:
https://lore.kernel.org/linux-acpi/YvatSoqXEtI7oqUO@paasikivi.fi.intel.com/T/#t

Tested-by: John Garry <john.garry@huawei.com>

I'm just sending a separate mail to highlight this issue as I spent an 
appreciable time bisecting and want others to avoid that. And I could 
not find the fix mail for some reason, even though I subscribe to the 
acpi list.

John
