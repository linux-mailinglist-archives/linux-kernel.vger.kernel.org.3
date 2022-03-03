Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F8A4CC1E0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 16:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234580AbiCCPpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 10:45:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233859AbiCCPpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 10:45:53 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C89891959D7
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 07:45:07 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6AB0A1424;
        Thu,  3 Mar 2022 07:45:07 -0800 (PST)
Received: from [10.57.22.15] (unknown [10.57.22.15])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 48DF13F66F;
        Thu,  3 Mar 2022 07:45:06 -0800 (PST)
Message-ID: <f0480a3c-6f8a-d6a6-d55e-829c65db6b9a@arm.com>
Date:   Thu, 3 Mar 2022 15:45:04 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v4] drivers/coresight: Add Ultrasoc System Memory Buffer
 driver
To:     Qi Liu <liuqi115@huawei.com>, mathieu.poirier@linaro.org,
        mike.leach@linaro.org
Cc:     coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com
References: <20220128061755.31909-1-liuqi115@huawei.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20220128061755.31909-1-liuqi115@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qi

On 28/01/2022 06:17, Qi Liu wrote:
> This patch adds driver for Ultrasoc SMB(System Memory Buffer)
> device. SMB provides a way to buffer messages from ETM, and
> store these CPU instructions in system memory.
> 
> SMB is developed by Ultrasoc technology, which is acquired by
> Siemens, and we still use "Ultrasoc" to name driver.
> 
> Signed-off-by: Qi Liu <liuqi115@huawei.com>
> Tested-by: JunHao He <hejunhao2@hisilicon.com>


Apologies for the delay in getting to review this patch. I will take a 
look at it next. Thanks for your patience.


Kind regard
Suzuki

