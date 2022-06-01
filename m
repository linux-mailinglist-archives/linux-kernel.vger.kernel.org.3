Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D04A53AA25
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 17:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355550AbiFAPd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 11:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348694AbiFAPdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 11:33:24 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9D341A3085;
        Wed,  1 Jun 2022 08:33:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6AC171FB;
        Wed,  1 Jun 2022 08:33:23 -0700 (PDT)
Received: from [10.57.36.60] (unknown [10.57.36.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 007BA3F66F;
        Wed,  1 Jun 2022 08:33:21 -0700 (PDT)
Message-ID: <be8395e3-98d7-7a8f-7153-c491b22d4463@arm.com>
Date:   Wed, 1 Jun 2022 16:33:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 3/3] thermal/sysfs: Remove cooling device sysfs statistics
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, quic_manafm@quicinc.com,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
References: <20220601151441.9128-1-daniel.lezcano@linaro.org>
 <20220601151441.9128-3-daniel.lezcano@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20220601151441.9128-3-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,


On 6/1/22 16:14, Daniel Lezcano wrote:
> The statistics are for debugging purpose and belong to debugfs rather
> than sysfs. As the previous changes introduced the same statistics in
> debugfs, those in sysfs are no longer needed and can be removed.

I just want to let you know that in current Android kernels we cannot
even compile the kernel with CONFIG_DEBUG_FS. I have this pain with
Energy Model there... Some vendors might see useful info via this
sysfs interface in bring-up of the SoC.

I don't know if there are user-space tools tracking this
information via sysfs. We probably should check that.

I agree that these statistics look more like debug info, rather than
something useful for control.

Furthermore, we have trace events for the cooling state changes, which
should be good enough for bring-up and experiments.

I don't have strong preferences here. I tend to agree to remove this
interface if there are no user-space tools using it.

Regards,
Lukasz
