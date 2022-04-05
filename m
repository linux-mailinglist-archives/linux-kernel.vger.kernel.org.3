Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A174F43A0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 00:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356035AbiDEU1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 16:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444471AbiDEPld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:41:33 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC73C3347;
        Tue,  5 Apr 2022 07:04:58 -0700 (PDT)
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KXq9B2TTJz67nP6;
        Tue,  5 Apr 2022 22:02:54 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 5 Apr 2022 16:04:55 +0200
Received: from [10.47.91.157] (10.47.91.157) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 5 Apr
 2022 15:04:55 +0100
Message-ID: <5f1d8b3f-0afa-2724-4ff1-f061939c68c5@huawei.com>
Date:   Tue, 5 Apr 2022 15:04:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
To:     <alexandre.truong@arm.com>
From:   John Garry <john.garry@huawei.com>
Subject: perf tool: About "perf arm64: Inject missing frames when using 'perf
 record --call-graph=fp'"
CC:     <linux-perf-users@vger.kernel.org>,
        "jolsa@kernel.org >> Jiri Olsa" <jolsa@kernel.org>,
        <german.gomez@arm.com>, <james.clark@arm.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.91.157]
X-ClientProxiedBy: lhreml747-chm.china.huawei.com (10.201.108.197) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

I notice that with commit b9f6fbb3b2c2 ("perf arm64: Inject missing 
frames when using 'perf record --call-graph=fp'") that I get messages 
spewing the console when running perf record+report, as below:

john@ubuntu:~/linux$sudo tools/perf/perf record -ag fio null12.fio
john@ubuntu:~/linux$sudo tools/perf/perf report > report
unwind: can't read reg 29
unwind: can't read reg 29
unwind: can't read reg 29
unwind: can't read reg 29
...

Do you know the possible cause? I haven't checked...

Thanks,
john
