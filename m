Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9239B599648
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 09:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347068AbiHSHj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 03:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346839AbiHSHjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 03:39:52 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5032C126
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 00:39:51 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4M8DBZ4SCqzGpgt;
        Fri, 19 Aug 2022 15:38:14 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 19 Aug 2022 15:39:48 +0800
Subject: Re: [PATCH 1/2] mm: memory-failure: kill soft_offline_free_page()
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220819033402.156519-1-wangkefeng.wang@huawei.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <fc98118d-be1e-301d-768d-4ce14a7d21db@huawei.com>
Date:   Fri, 19 Aug 2022 15:39:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220819033402.156519-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

On 2022/8/19 11:34, Kefeng Wang wrote:
> Open-code the page_handle_poison() into soft_offline_page() and
> kill unneeded soft_offline_free_page().
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

LGTM. Thanks.

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks,
Miaohe Lin

