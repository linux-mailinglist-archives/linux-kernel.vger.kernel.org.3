Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4974C5AE6C2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 13:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbiIFLmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 07:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbiIFLmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 07:42:43 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 29B123A4B5
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 04:42:43 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E59AE139F;
        Tue,  6 Sep 2022 04:42:48 -0700 (PDT)
Received: from [10.57.15.197] (unknown [10.57.15.197])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ACCB33F534;
        Tue,  6 Sep 2022 04:42:37 -0700 (PDT)
Message-ID: <5f4d77c3-ec58-659e-0b03-a799b3782a31@arm.com>
Date:   Tue, 6 Sep 2022 12:42:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH] drm/amdgpu: cleanup coding style in amdgpu_drv.c
Content-Language: en-GB
To:     Jingyu Wang <jingyuwang_vip@163.com>, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, evan.quan@amd.com, mario.limonciello@amd.com,
        Felix.Kuehling@amd.com, andrey.grodzovsky@amd.com,
        olomon.chiu@amd.com
Cc:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <4362da59f466d8c41c9a3ea91348266280b6a594>
 <20220904191513.15159-1-jingyuwang_vip@163.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220904191513.15159-1-jingyuwang_vip@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-04 20:15, Jingyu Wang wrote:
[...]
> @@ -565,8 +566,8 @@ module_param_named(timeout_period, amdgpu_watchdog_timer.period, uint, 0644);
>    */
>   #ifdef CONFIG_DRM_AMDGPU_SI
>   
> -#if defined(CONFIG_DRM_RADEON) || defined(CONFIG_DRM_RADEON_MODULE)
> -int amdgpu_si_support = 0;
> +#if IS_ENABLED(CONFIG_DRM_RADEON) || defined(CONFIG_DRM_RADEON_MODULE)

Hint: read the checkpatch warning again more closely, and consider what 
IS_ENABLED() does and therefore why this is still not quite right.

Robin.

> +int amdgpu_si_support;
>   MODULE_PARM_DESC(si_support, "SI support (1 = enabled, 0 = disabled (default))");
>   #else
>   int amdgpu_si_support = 1;
