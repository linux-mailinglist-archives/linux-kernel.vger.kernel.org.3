Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A82B5008A6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 10:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241103AbiDNIrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 04:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbiDNIrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 04:47:06 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90FEC15FF6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:44:41 -0700 (PDT)
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KfCdK5bPyz67yLV;
        Thu, 14 Apr 2022 16:42:29 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 14 Apr 2022 10:44:38 +0200
Received: from [10.47.27.157] (10.47.27.157) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 14 Apr
 2022 09:44:37 +0100
Message-ID: <a3511b66-080e-506e-6617-d7b4f59ebcfd@huawei.com>
Date:   Thu, 14 Apr 2022 09:44:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH V2 2/2] drivers/perf: hisi: add driver for HNS3 PMU
To:     "huangguangbin (A)" <huangguangbin2@huawei.com>, <will@kernel.org>,
        <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <liuqi115@huawei.com>, <zhangshaokun@hisilicon.com>,
        <f.fangjian@huawei.com>, <lipeng321@huawei.com>,
        <shenjian15@huawei.com>, <moyufeng@huawei.com>
References: <20220228123955.30284-1-huangguangbin2@huawei.com>
 <20220228123955.30284-3-huangguangbin2@huawei.com>
 <6089561f-039b-43b5-7a6b-43b00ce370f2@huawei.com>
 <5b77fceb-830f-2592-351e-4185fc8843f0@huawei.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <5b77fceb-830f-2592-351e-4185fc8843f0@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.27.157]
X-ClientProxiedBy: lhreml744-chm.china.huawei.com (10.201.108.194) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/03/2022 12:08, huangguangbin (A) wrote:
> 
> 
> On 2022/3/3 0:10, John Garry wrote:

In future can you please respond promptly to reviews? Then the review 
topics will be fresh in the reviewers memory and the reviewer will also 
be focused on the task of reviewing.

Thanks,
John


