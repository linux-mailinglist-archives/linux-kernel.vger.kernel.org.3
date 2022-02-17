Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A26B44BA312
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 15:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241932AbiBQOfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 09:35:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbiBQOfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 09:35:34 -0500
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050::465:101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF1A2B1671;
        Thu, 17 Feb 2022 06:35:19 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Jzy6C1S0mz9sV1;
        Thu, 17 Feb 2022 15:35:15 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1645108512;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zURhBcd1HznQnraXISg5dKkf+eFuRNWJeFqODzAj4Is=;
        b=BjrfX8bcB3YJObvV4YlFB03EY5OIzuxs17s5/nsBEfejpK7EZi++mQoqrfNmyYctMhXNce
        v+hyrgLIeurSyIXglItUOeZx+fq0Iu2sVRQTJZt8Twkyz3aKP/pyOONg0goNWZywqTYouJ
        ApizqO/WhUT2SBhXMXxfPEhDwGXbvVfJ0ZqlJxbZCz7wQmylTV6t1qGZfCxOHn6VIg5mwE
        PHXys+B1hCqczGxbeNGUSo9P5P7c1ZVjRx/KY96AbyGQV/UfvJw9HjH1U6fy1ao9IEEpRX
        s9fzbVCKh6F5MQYawSmoKBfvNVE/zOiTAWdkrAWPXXZXUknbziYEfVDY9V2poQ==
Message-ID: <863b1032-754d-d6ca-cef1-f6a271ae92ef@mailbox.org>
Date:   Thu, 17 Feb 2022 15:35:08 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 8/8] drm/fourcc: Add DRM_FORMAT_D1
Content-Language: en-CA
To:     Pekka Paalanen <ppaalanen@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>, Helge Deller <deller@gmx.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>
References: <20220215165226.2738568-1-geert@linux-m68k.org>
 <20220215165226.2738568-9-geert@linux-m68k.org>
 <20220217121033.0fc7f6ba@eldfell>
 <CAMuHMdXf3tFLb16Y=wh5C3QUYN4PdCjaYPCzMOTCye-eYS-N8w@mail.gmail.com>
 <20220217162823.050d5f17@eldfell>
From:   =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@mailbox.org>
In-Reply-To: <20220217162823.050d5f17@eldfell>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-17 15:28, Pekka Paalanen wrote:
> On Thu, 17 Feb 2022 11:42:29 +0100
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> 
>> Hi Pekka,
>>
>> On Thu, Feb 17, 2022 at 11:10 AM Pekka Paalanen <ppaalanen@gmail.com> wrote:
>>> On Tue, 15 Feb 2022 17:52:26 +0100
>>> Geert Uytterhoeven <geert@linux-m68k.org> wrote:  
>>>> Introduce a fourcc code for a single-channel frame buffer format with two
>>>> darkness levels.  This can be used for two-level dark-on-light displays.
>>>>
>>>> As the number of bits per pixel is less than eight, this relies on
>>>> proper block handling for the calculation of bits per pixel and pitch.
>>>>
>>>> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>  
>>
>>>> --- a/drivers/gpu/drm/drm_fourcc.c
>>>> +++ b/drivers/gpu/drm/drm_fourcc.c
>>>> @@ -151,6 +151,8 @@ const struct drm_format_info *__drm_format_info(u32 format)
>>>>               { .format = DRM_FORMAT_C4,              .depth = 4,  .num_planes = 1,
>>>>                 .char_per_block = { 1, }, .block_w = { 2, }, .block_h = { 1, }, .hsub = 1, .vsub = 1 },
>>>>               { .format = DRM_FORMAT_C8,              .depth = 8,  .num_planes = 1, .cpp = { 1, 0, 0 }, .hsub = 1, .vsub = 1 },
>>>> +             { .format = DRM_FORMAT_D1,              .depth = 1,  .num_planes = 1,
>>>> +               .char_per_block = { 1, }, .block_w = { 8, }, .block_h = { 1, }, .hsub = 1, .vsub = 1 },
>>>>               { .format = DRM_FORMAT_R1,              .depth = 1,  .num_planes = 1,
>>>>                 .char_per_block = { 1, }, .block_w = { 8, }, .block_h = { 1, }, .hsub = 1, .vsub = 1 },
>>>>               { .format = DRM_FORMAT_R2,              .depth = 2,  .num_planes = 1,
>>>> diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
>>>> index 8605a1acc6813e6c..c15c6efcc65e5827 100644
>>>> --- a/include/uapi/drm/drm_fourcc.h
>>>> +++ b/include/uapi/drm/drm_fourcc.h
>>>> @@ -104,6 +104,9 @@ extern "C" {
>>>>  #define DRM_FORMAT_C4                fourcc_code('C', '4', ' ', ' ') /* [3:0] C */
>>>>  #define DRM_FORMAT_C8                fourcc_code('C', '8', ' ', ' ') /* [7:0] C */
>>>>
>>>> +/* 1 bpp Darkness */
>>>> +#define DRM_FORMAT_D1                fourcc_code('D', '1', ' ', ' ') /* [0] D */
>>>> +  
>>>
>>> the same comment here as for C1 and R1 formats, need to specify pixel
>>> ordering inside a byte.  
>>
>> Right, will do.
> 
> Btw. does endianess of anything have any effect on these pixel formats?
> 
> That's probably a weird question, but I recall Pixman (the pixel
> handling library of the X server nowadays known as Xorg) having pixel
> formats where CPU endianess affects whether the first pixel in a byte
> is found at the MSB or LSB.

Pixman probably has that for hysterical raisins inherited from the X code base. Conceptually, endianness is purely about the order of bytes in words, and is orthogonal to the order in which the bits of a byte/word are numbered.


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer
