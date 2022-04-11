Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9624FB50D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 09:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245526AbiDKHjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 03:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236539AbiDKHja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 03:39:30 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28ABE3969E
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 00:37:16 -0700 (PDT)
Received: from [192.168.0.2] (ip5f5ae91f.dynamic.kabel-deutschland.de [95.90.233.31])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 7D59561EA1923;
        Mon, 11 Apr 2022 09:37:13 +0200 (CEST)
Message-ID: <76171e7d-43f0-fb7b-6e58-8a09c8f43e88@molgen.mpg.de>
Date:   Mon, 11 Apr 2022 09:37:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCHv2] drm/amdgpu: disable ASPM on Intel AlderLake based
 systems
Content-Language: en-US
To:     Richard Gong <richard.gong@amd.com>
Cc:     airlied@linux.ie, dri-devel@lists.freedesktop.org,
        xinhui.pan@amd.com, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, mario.limonciello@amd.com,
        daniel@ffwll.ch, alexander.deucher@amd.com,
        christian.koenig@amd.com
References: <20220408190502.4103670-1-richard.gong@amd.com>
 <44354d78-b340-fbc4-fd6c-060d7ad3404e@molgen.mpg.de>
 <cacb177f-20e2-b50a-806f-777837fba693@amd.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <cacb177f-20e2-b50a-806f-777837fba693@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Richard,


Thank you for your response, but please reply to your own reply next time.

Am 11.04.22 um 02:37 schrieb Gong, Richard:
> 
> On 4/8/2022 7:19 PM, Paul Menzel wrote:

>> Thank you for your patch.
>>
>> Am 08.04.22 um 21:05 schrieb Richard Gong:
>>> Active State Power Management (ASPM) feature is enabled since kernel 
>>> 5.14.
>>> There are some AMD GFX cards (such as WX3200 and RX640) that cannot be
>>> used with Intel AlderLake based systems to enable ASPM. Using these GFX
>>
>> Alder Lake
> Actually there are 2 formats (one with space, another is w/o space) in 
> the upstream sources, so I will keep that unchanged and use the format 
> w/o space.

Do you mean the Linux kernel sources? Anyway, please use the correct 
spelling [1].


Kind regards,

Paul


[1]: 
https://ark.intel.com/content/www/us/en/ark/products/codename/147470/products-formerly-alder-lake.html
[2]: https://en.wikipedia.org/wiki/Alder_Lake
