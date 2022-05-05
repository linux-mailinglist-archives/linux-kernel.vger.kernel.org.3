Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2DC151BD88
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 12:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356208AbiEEK4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 06:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233254AbiEEK4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 06:56:22 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A1846176
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 03:52:42 -0700 (PDT)
Received: from kwepemi100009.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Kv9WG2Lg9zhYvj;
        Thu,  5 May 2022 18:52:10 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 kwepemi100009.china.huawei.com (7.221.188.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 5 May 2022 18:52:40 +0800
Received: from [10.67.101.67] (10.67.101.67) by kwepemm600003.china.huawei.com
 (7.193.23.202) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 5 May
 2022 18:52:40 +0800
Subject: Re: [PATCH v5 0/2] Add support for UltraSoc System Memory Buffer
To:     <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>
CC:     <coresight@lists.linaro.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>,
        <Jonathan_Lucas@mentor.com>
References: <20220416083953.52610-1-liuqi115@huawei.com>
From:   "liuqi (BA)" <liuqi115@huawei.com>
Message-ID: <91304a8c-9baa-c183-c51d-0211e1fff66f@huawei.com>
Date:   Thu, 5 May 2022 18:52:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220416083953.52610-1-liuqi115@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.101.67]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gentle ping. Any comment or suggestion is appreciated.

Thanks,
Qi

On 2022/4/16 16:39, Qi Liu wrote:
> Add support for UltraSoc System Memory Buffer.
> 
> Change since v4:
> - Add a simple document of SMB driver according to Suzuki's comment.
> - Address the comments from Suzuki.
> - https://lore.kernel.org/linux-arm-kernel/20220128061755.31909-1-liuqi115@huawei.com/
> 
> Change since v3:
> - Modify the file header according to community specifications.
> - Address the comments from Mathieu.
> - Link:https://lore.kernel.org/linux-arm-kernel/20211118110016.40398-1-liuqi115@huawei.com/
> Change since v2:
> - Move ultrasoc driver to drivers/hwtracing/coresight.
> - Link:https://lists.linaro.org/pipermail/coresight/2021-November/007310.html
> 
> Change since v1:
> - Drop the document of UltraSoc according to Mathieu's comment.
> - Add comments to explain some private hardware settings.
> - Address the comments from Mathieu.
> - Link: https://lists.linaro.org/pipermail/coresight/2021-August/006842.html
> 
> Change since RFC:
> - Move driver to drivers/hwtracing/coresight/ultrasoc.
> - Remove ultrasoc-axi-com.c, as AXI-COM doesn't need to be configured in
>    basic tracing function.
> - Remove ultrasoc.c as SMB does not need to register with the ultrasoc core.
> - Address the comments from Mathieu and Suzuki.
> - Link: https://lists.linaro.org/pipermail/coresight/2021-June/006535.html
> 
> Qi Liu (2):
>    drivers/coresight: Add UltraSoc System Memory Buffer driver
>    Documentation: Add document for UltraSoc SMB drivers
> 
>   .../trace/coresight/ultrasoc-smb.rst          |  79 +++
>   drivers/hwtracing/coresight/Kconfig           |  10 +
>   drivers/hwtracing/coresight/Makefile          |   1 +
>   drivers/hwtracing/coresight/ultrasoc-smb.c    | 643 ++++++++++++++++++
>   drivers/hwtracing/coresight/ultrasoc-smb.h    | 106 +++
>   5 files changed, 839 insertions(+)
>   create mode 100644 Documentation/trace/coresight/ultrasoc-smb.rst
>   create mode 100644 drivers/hwtracing/coresight/ultrasoc-smb.c
>   create mode 100644 drivers/hwtracing/coresight/ultrasoc-smb.h
> 
