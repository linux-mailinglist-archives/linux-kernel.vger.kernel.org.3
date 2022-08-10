Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2413658EFF7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 18:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbiHJQCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 12:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233360AbiHJQBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 12:01:52 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912DC78BE9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 09:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=KKr3/p7RXk6Xd7JZFfPWIxAClLn2mUrBIY5Ne5PRLek=; b=L8dRFbdhNwtpr3+2ATPgf6lwH+
        u9BwHPLH/dmnm8mITuJ++Gpx8rqBHuB9s9Gi+HTKufdfpzmmCjAnkCws4n+2p01pYZHGMzOzVtpEL
        RFczXZ3mXbUA80XgWJ4LAkAhyvVxdufnWXVy3dSLghfCbLXINAN3HvyS/qcjKLBOZIK0yCfM2olL6
        v2DR/p8zT4xS5CKOke0TXJzlywb3+hQJTO9d7NXIdgmug2XNX6S4dCvOnqpHUEeoT4JItkfR/QLMo
        YUSqKGm2A/H8s8tyQF4P8NOjoYzX/aXhuKmTpa1Qxg+q3qhbnR1Nqfj8ZOZuHwt1nV0RigknlSFxW
        m+9OeSxw==;
Received: from [191.17.41.12] (helo=[192.168.15.109])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1oLo9N-004UMr-Ht; Wed, 10 Aug 2022 18:01:41 +0200
Message-ID: <0e3b981b-f324-d52c-dc67-4ea9100769ef@igalia.com>
Date:   Wed, 10 Aug 2022 13:01:22 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 0/4] drm/amd: Add more GFXOFF stats for vangogh
Content-Language: en-US
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Pan Xinhui <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Tao Zhou <tao.zhou1@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jack Xiao <Jack.Xiao@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Tom St Denis <tom.stdenis@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        kernel-dev@igalia.com
References: <20220726182152.123649-1-andrealmeid@igalia.com>
 <CADnq5_MJAbhQ8VZcPVY5nhg3VnefKPnSscMnRPsm2wB04G6wBg@mail.gmail.com>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <CADnq5_MJAbhQ8VZcPVY5nhg3VnefKPnSscMnRPsm2wB04G6wBg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Às 12:57 de 10/08/22, Alex Deucher escreveu:
> On Tue, Jul 26, 2022 at 2:23 PM André Almeida <andrealmeid@igalia.com> wrote:
>>
>> This series adds new logging features for GFXOFF available for vangogh
>> and documentation for it.
>>
>> I've created a small userspace program to interact with this new debugfs
>> interface and it can be found at:
>>
>> https://gitlab.freedesktop.org/andrealmeid/gfxoff_tool
>>
>> Changelog:
>>  v2:
>>  - Make entrycount uint64_t
>>  - Add a note in docs about data types and overflow
> 
> A minor comment on patch 2, the rest looks good to me.
> 

ok, let me send a v3

> Thanks,
> 
> Alex
> 
> 
>>
>> André Almeida (4):
>>   drm/amd: Add detailed GFXOFF stats to debugfs
>>   drm/amd/pm: Implement GFXOFF's entry count and residency for vangogh
>>   Documentation/gpu: Document GFXOFF's count and residency
>>   drm/amdgpu: Document gfx_off members of struct amdgpu_gfx
>>
>>  Documentation/gpu/amdgpu/thermal.rst          |  18 +-
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   | 168 ++++++++++++++++++
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   2 +
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       |  39 ++++
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |  14 +-
>>  drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  45 +++++
>>  drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |   3 +
>>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  35 +++-
>>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  22 +++
>>  .../pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h    |   5 +-
>>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |   5 +-
>>  .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |  92 ++++++++++
>>  drivers/gpu/drm/amd/pm/swsmu/smu_internal.h   |   3 +
>>  13 files changed, 443 insertions(+), 8 deletions(-)
>>
>> --
>> 2.37.1
>>
