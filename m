Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F07B54D28B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 22:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241916AbiFOU2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 16:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345400AbiFOU1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 16:27:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D6012D17;
        Wed, 15 Jun 2022 13:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=ZyYyezCf/BUfWvp3SS0tJHgG622dktRJVLjhG8Bed+o=; b=t6FThO6AzVoLedjjG9EdaVxiL8
        5ktznfR8LrGVb+WtjLEaRaSPViEyhNC143ZMJFCtlJU/zT8amLEUnucDXb5ENS3H59PTNZquZ+Fa0
        Is9l/e4AR6SHp6qzDScX0ZF6rhkdzRYxnXopaTJJqarY/3hxC1JpEYI6HfNyUs0JZDGVaLrfDCgjL
        Xrik5yF6YlY/KX1BghnObD0aBBV5lrK67UbASiGXgXRRIYKnDPFFhCogrUGjxL1rAXm4BfLjVqgDF
        y5W+Dy2xB9h3n7h9dGbkBZMLsRtaePaC9ZFF3Oix9dr+tNqYL4zOzRYGsXKeZYIozG36zzYg4Jz0e
        JleW347g==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o1Zc6-001Ldf-Hc; Wed, 15 Jun 2022 20:27:42 +0000
Message-ID: <3581d1bc-9442-c3e6-7fbd-c7a7a691a839@infradead.org>
Date:   Wed, 15 Jun 2022 13:27:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: linux-next: Tree for Jun 15
 (drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c)
Content-Language: en-US
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20220615160116.528c324b@canb.auug.org.au>
 <d1a48a84-6d07-e8f7-5fd8-d24a7a1cf187@infradead.org>
 <CADnq5_N6gfaPfZJAX4+poWFFruxNdFKZqzXZXosj1A55e-O1mA@mail.gmail.com>
 <fb53cab1-f693-5309-e06a-0fe0fc932c2c@infradead.org>
 <CADnq5_Nz9cw3L6_Ab=7WQZ4_y8OTSiwZmoQup+9OjaaZPCqUqQ@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CADnq5_Nz9cw3L6_Ab=7WQZ4_y8OTSiwZmoQup+9OjaaZPCqUqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 6/15/22 13:13, Alex Deucher wrote:
> On Wed, Jun 15, 2022 at 3:44 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>>
>>
>> On 6/15/22 12:28, Alex Deucher wrote:
>>> On Wed, Jun 15, 2022 at 3:01 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>>>>
>>>>
>>>>
>>>> On 6/14/22 23:01, Stephen Rothwell wrote:
>>>>> Hi all,
>>>>>
>>>>> Changes since 20220614:
>>>>>
>>>>
>>>> on i386:
>>>> # CONFIG_DEBUG_FS is not set
>>>>
>>>>
>>>> ../drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c: In function ‘amdgpu_dm_crtc_late_register’:
>>>> ../drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:6599:2: error: implicit declaration of function ‘crtc_debugfs_init’; did you mean ‘amdgpu_debugfs_init’? [-Werror=implicit-function-declaration]
>>>>   crtc_debugfs_init(crtc);
>>>>   ^~~~~~~~~~~~~~~~~
>>>>   amdgpu_debugfs_init
>>>>
>>>>
>>>> Full randconfig file is attached.
>>>
>>> I tried building with your config and I can't repro this.  As Harry
>>> noted, that function and the whole secure display feature depend on
>>> debugfs.  It should never be built without CONFIG_DEBUG_FS.  See
>>> drivers/gpu/drm/amd/display/Kconfig:
>>
>> Did you try building with today's linux-next tree?
>> (whatever is in it)
>>
>> I have seen this build error multiple times so it shouldn't
>> be so difficult to repro it.
>>
>>
>>>> config DRM_AMD_SECURE_DISPLAY
>>>>         bool "Enable secure display support"
>>>>         default n
>>>>         depends on DEBUG_FS
>>>>         depends on DRM_AMD_DC_DCN
>>>>         help
>>>>             Choose this option if you want to
>>>>             support secure display
>>>>
>>>>             This option enables the calculation
>>>>             of crc of specific region via debugfs.
>>>>             Cooperate with specific DMCU FW.
>>>
>>> amdgpu_dm_crtc_late_register is guarded by
>>> CONIG_DRM_AMD_SECURE_DISPLAY.  It's not clear to me how we could hit
>>> this.
>

I was just about to ask what the paragraph above means.
It was confusing to say the least.
 
> I was able to repro it.  In linux-next the
> CONFIG_DRM_AMD_SECURE_DISPLAY ifdefs in
> drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c seem to be missing.
> I guess they were lost when the amdgpu branch was merged into
> linux-next.  The attached patch restores the
> CONFIG_DRM_AMD_SECURE_DISPLAY protections.

OK, that builds for me.

Thanks.

-- 
~Randy
