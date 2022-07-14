Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12585749DC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 11:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234187AbiGNJ7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 05:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234085AbiGNJ6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 05:58:34 -0400
Received: from sinsgout.his.huawei.com (sinsgout.his.huawei.com [119.8.179.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499394D4F4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 02:58:05 -0700 (PDT)
Received: from sinmsgout01.his.huawei.com (unknown [172.28.115.139])
        by sinsgout.his.huawei.com (SkyGuard) with ESMTP id 4Lk90T0KYcz5RsrG
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 17:58:01 +0800 (CST)
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.156.148])
        by sinmsgout01.his.huawei.com (SkyGuard) with ESMTP id 4Lk8tm4yYwz9v7Gq;
        Thu, 14 Jul 2022 17:53:04 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 14 Jul 2022 11:57:51 +0200
Received: from [10.126.173.191] (10.126.173.191) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 14 Jul 2022 10:57:50 +0100
Message-ID: <3492d341-a681-f344-f5cd-5b1ea3725f31@huawei.com>
Date:   Thu, 14 Jul 2022 10:57:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: faddr2line issue
From:   John Garry <john.garry@huawei.com>
To:     <jpoimboe@kernel.org>, <keescook@chromium.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <09df26a9-27af-1276-34c6-820bf7e27da8@huawei.com>
In-Reply-To: <09df26a9-27af-1276-34c6-820bf7e27da8@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.173.191]
X-ClientProxiedBy: lhreml725-chm.china.huawei.com (10.201.108.76) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/07/2022 15:47, John Garry wrote:

+

JFYI, This issue is caused by CONFIG_DEBUG_INFO now being default off in 
my .config from commit f9b3cd245784 ("Kconfig.debug: make DEBUG_INFO 
selectable from a choice").

By enabling that config faddr2line now looks ok again.

BTW, Could we add a check for any kernel dependency in this tool?

Thanks,
John

> Hi Josh,
> 
> I am finding that for a few mainline kernel releases that faddr2line 
> does seem to be working:
> 
> ./scripts/faddr2line vmlinux  sas_discover_domain+0x4dc/0x560
> sas_discover_domain+0x4dc/0x560:
> fs mm ??:0
> 
> This is on my arm64 system. I have not tried another arch. Are there any 
> known issues?
> 
> Maybe I'm using it incorrectly... I can go back and see when this 
> stopped working for me.
> 
> Cheers,
> John

