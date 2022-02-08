Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41C264AD732
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356451AbiBHLcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:32:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356735AbiBHK47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 05:56:59 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C04C03FEC0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 02:56:55 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JtKgF5wMTzccnm;
        Tue,  8 Feb 2022 18:55:53 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Feb 2022 18:56:53 +0800
Subject: Re: [PATCH 1/4] mm/memory_hotplug: remove obsolete comment of
 __add_pages
To:     Oscar Salvador <osalvador@suse.de>
CC:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20220207133643.23427-1-linmiaohe@huawei.com>
 <20220207133643.23427-2-linmiaohe@huawei.com>
 <YgJCqAToVBk2G3fq@localhost.localdomain>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <af295749-bb1b-a277-e745-3a246928331a@huawei.com>
Date:   Tue, 8 Feb 2022 18:56:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YgJCqAToVBk2G3fq@localhost.localdomain>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/2/8 18:15, Oscar Salvador wrote:
> On Mon, Feb 07, 2022 at 09:36:40PM +0800, Miaohe Lin wrote:
>> Since commit f1dd2cd13c4b ("mm, memory_hotplug: do not associate hotadded
>> memory to zones until online"), there is no need to pass in the zone.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> 
> Yeah, I am with David here, "Reasonably generic function for adding
> memory" does not really tell me much about that function.
>  

Agree with you. And Andrew have kindly made that change.
Many thanks for your review. :)
