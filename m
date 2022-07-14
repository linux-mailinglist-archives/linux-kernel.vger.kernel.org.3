Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D1257564E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 22:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240080AbiGNUY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 16:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232299AbiGNUY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 16:24:27 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8BD1D0CD
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 13:24:27 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id o3-20020a17090a744300b001ef8f7f3dddso4152101pjk.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 13:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=pcRnU+Ror4gYiRZTAUzcABV8hGHFjcJDb40sHS5AYVk=;
        b=hvlDHdDOxK52P0/LBKCWfDreDHWqjZ0+X00Ved/rTViRBSVXTq2lYSvFTdJu/JsxcH
         Ilil5aAXg8Df3wnUF5jyZBi6aoLWCimQsGtR7CmVIOKpKWSOuVPNVKZfbs6am4YGaExF
         7kscXgmArrrB4keRwxUmuehwGsgP7fc2CTf4uTLkX10oMCdPBBldJlEP22szXpAuxJJD
         n7iw57jMeGLQLdoAFKejDR+I8P3rVeUeiIqy4pHiwDXDAIhXeDcUwj0xl05k5IcSnr1f
         WdV6IF0hjMPu2/tYtTRpJLj77S851CLISPSfKgjBG5iQELG6SFjYF4g1FUJiWlMvbkGO
         eIzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=pcRnU+Ror4gYiRZTAUzcABV8hGHFjcJDb40sHS5AYVk=;
        b=hAQJLclTsKiiHEv9qj87SR9aUs1cgVGFhTW1+jui4IYED678ZGQV/Bz+8+xUTmWeXM
         +c0YXZVh/OB6K8xiqxyddgoupDF8UI6oZhNNO1wx8IX6DxSWoZxcVIEc6cm5zfdC41xp
         PnCYzZLA/i8OLGLlkSumjdfwpSMkJPQqz87iCPwpTZLV60I2Y+AqB9fGf/QCT1dUtmYO
         +4XYhaG0dQ1mK7cfxLdNTtZdIKKBf95AE9orr1yrjPXPJVIga5snyKNC89fb4ozCO3/k
         XjHtZTIgKdOUVOiek1Xp98+g/4PRyY1efz0pJ5/dcz9ADadH2TcXn44KzUFLJG4FHO/8
         +/eQ==
X-Gm-Message-State: AJIora9KFJEfQKucwFvUzJB5Gjur7XlZs/29BDQ/WYbtvH5rIgPomW69
        WIUYQH1L6zpNKaYh6nIWNW9Ierar7vGbgA==
X-Google-Smtp-Source: AGRyM1tx/BKIt8gG9FjSZ+ck6gTBSu+yZzhvOUhowONfqODvxLg5/2Tfh0PFxmmu7wnVClZYpTsl0Q==
X-Received: by 2002:a17:90a:fe4:b0:1ef:8564:4f4 with SMTP id 91-20020a17090a0fe400b001ef856404f4mr18027029pjz.118.1657830266447;
        Thu, 14 Jul 2022 13:24:26 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q8-20020a17090311c800b0016bd16f8acbsm1889201plh.114.2022.07.14.13.24.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 13:24:25 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <17edd8b1-27d3-a768-87a3-c815e5df5d14@roeck-us.net>
Date:   Thu, 14 Jul 2022 13:24:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To:     Melissa Wen <mwen@igalia.com>, Alex Deucher <alexdeucher@gmail.com>
Cc:     Leo Li <sunpeng.li@amd.com>, Michael Ellerman <mpe@ellerman.id.au>,
        Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Daniel Axtens <dja@axtens.net>
References: <20220618232737.2036722-1-linux@roeck-us.net>
 <584fc348-7a60-26a2-af61-9edc4f4830e4@amd.com>
 <CADnq5_NkVWqcxwLMBeskqpcSEYCEjUAK0hqvA_PAo7ACHKL2cA@mail.gmail.com>
 <6a026c9a-c4ee-deba-e028-4c0f478c1911@roeck-us.net>
 <CADnq5_OrxMMkazXEPHeZXp_bV890=r21DRx2QsqLXUFj4t8aYg@mail.gmail.com>
 <20220713230917.GE32544@roeck-us.net>
 <CADnq5_PAg8xg2J3WUfjxK_-WFaLOK7cQd6bqWDnfVqE6fpXq2Q@mail.gmail.com>
 <20220714184919.rmsexizgfdkfboiq@mail.igalia.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] drm/amd/display: Add missing hard-float compile flags for
 PPC64 builds
In-Reply-To: <20220714184919.rmsexizgfdkfboiq@mail.igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/22 11:49, Melissa Wen wrote:
> O 07/13, Alex Deucher wrote:
>> On Wed, Jul 13, 2022 at 7:09 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>>
>>> On Wed, Jul 13, 2022 at 05:20:40PM -0400, Alex Deucher wrote:
>>>>>
>>>>> The problem is not the FPU operations, but the fact that soft-float
>>>>> and hard-float compiled code is linked together. The soft-float and
>>>>> hard-float ABIs on powerpc are not compatible, so one ends up with
>>>>> an object file which is partially soft-float and partially hard-float
>>>>> compiled and thus uses different ABIs. That can only create chaos,
>>>>> so the linker complains about it.
>>>>
>>>> I get that, I just don't see why only DCN 3.1.x files have this
>>>> problem.  The DCN 2.x files should as well.
>>>>
>>>
>>> Seen in drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile:
>>>
>>> # prevent build errors regarding soft-float vs hard-float FP ABI tags
>>> # this code is currently unused on ppc64, as it applies to Renoir APUs only
>>> ifdef CONFIG_PPC64
>>> CFLAGS_$(AMDDALPATH)/dc/clk_mgr/dcn21/rn_clk_mgr.o := $(call cc-option,-mno-gnu-attribute)
>>> endif
>>>
>>> Does that explain it ?
>>
>> I would expect to see it in dcn20_resource.c and dcn30_clk_mgr.c for
>> example.  They follow the same pattern as the dcn 3.1.x files.  They
>> call functions that use FP, but maybe there is some FP code still in
>> those functions that we missed somehow.
> 
> Hi,
> 
> I'm a little late here, but I'm not able to reproduce the issue yet.
> I have this setup:
> - gcc 11.3.0
> - binutils 2.38.50
> - mainline kernel (torvalds) version: 5.19.0-rc6 (cross-compiling)
>    -> make ARCH=powerpc CROSS_COMPILE=powerpc64-linux-gnu- allmodconfig
>      => DRM_AMD_DC [=y] && HAS_IOMEM [=y] && DRM [=m] && DRM_AMDGPU [=m] && (X86 || PPC64 [=y]) && (!KCOV_INSTRUMENT_ALL [=n] || !KCOV_ENABLE_COMPARISONS [=n])
>    -> make -j16 ARCH=powerpc CROSS_COMPILE=powerpc64-linux-gnu-
> 
> Am I missing something?
> 
> So, as Alex mentioned the possibility of some non-isolated FPU code in
> 3.1, I reviewed dcn31 code and my best bet so far is that the issue
> is here:
> 
> https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c#L1721
> 
> Although dcn31_update_soc_for_wm_a() is only called inside
> dml/dcn31/dcn31_fpu:
> - dc->res_pool->funcs->update_soc_for_wm_a(dc, context);
> 
> it's declared in dcn31_resource and has FPU code. So, we should move it
> to dml/dcn31/dcn31_fpu.
> 
> However, as I can't reproduce the issue, I don't know if it addresses
> the problem reported here and also if everything will be clean after
> moving it.
> 

I don't think that would solve anything. As I have tried to point out,
the problem is that code compiled with hard-float is linked together
with code compiled with soft-float. An alternate fix might be something
like the one attached below, but I don't know if that would be correct
and/or complete.

> Guenter,
> 
> Can you provide more info about your setup: cross-compile or not, any
> flags, branch, etc?
> 

Nothing special. Same compile options as the ones you use, and it is a
cross-compile environment. I tried gcc 11.2.0 with binutils 2.36.1
and gcc 11.3.0 with binutils 2.38.

Guenter

---
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/Makefile b/drivers/gpu/drm/amd/display/dc/dcn31/Makefile
index ec041e3cda30..44ff6f196860 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/Makefile
@@ -10,6 +10,8 @@
  #
  # Makefile for dcn31.

+CFLAGS_$(AMDDALPATH)/dc/dcn31/dcn31_resource.o := $(call cc-option,-mno-gnu-attribute)
+
  DCN31 = dcn31_resource.o dcn31_hubbub.o dcn31_hwseq.o dcn31_init.o dcn31_hubp.o \
         dcn31_dccg.o dcn31_optc.o dcn31_dio_link_encoder.o dcn31_panel_cntl.o \
         dcn31_apg.o dcn31_hpo_dp_stream_encoder.o dcn31_hpo_dp_link_encoder.o \
diff --git a/drivers/gpu/drm/amd/display/dc/dcn315/Makefile b/drivers/gpu/drm/amd/display/dc/dcn315/Makefile
index 59381d24800b..55fcae2d2aae 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn315/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn315/Makefile
@@ -25,6 +25,8 @@

  DCN315 = dcn315_resource.o

+CFLAGS_$(AMDDALPATH)/dc/dcn315/$(DCN315) := $(call cc-option,-mno-gnu-attribute)
+
  AMD_DAL_DCN315 = $(addprefix $(AMDDALPATH)/dc/dcn315/,$(DCN315))

  AMD_DISPLAY_FILES += $(AMD_DAL_DCN315)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn316/Makefile b/drivers/gpu/drm/amd/display/dc/dcn316/Makefile
index 819d44a9439b..7251ef9c1afb 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn316/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn316/Makefile
@@ -25,6 +25,8 @@

  DCN316 = dcn316_resource.o

+CFLAGS_$(AMDDALPATH)/dc/dcn316/$(DCN316) := $(call cc-option,-mno-gnu-attribute)
+
  AMD_DAL_DCN316 = $(addprefix $(AMDDALPATH)/dc/dcn316/,$(DCN316))

  AMD_DISPLAY_FILES += $(AMD_DAL_DCN316)
