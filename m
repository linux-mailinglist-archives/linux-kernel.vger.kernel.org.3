Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0718598703
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 17:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344196AbiHRPKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 11:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344204AbiHRPKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 11:10:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A8EBD759;
        Thu, 18 Aug 2022 08:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=CbGJK9ZiR1VZ+b3H1/bjKz89ere1vSVIkGBu0M3WHFo=; b=wruw1N6NJkF3bB+T5MEPjct/rN
        m8LDaRWUWlwkM53A1OvK5nWg9gFfb3DnhRPMtMUkQeZu4el5tythqKYR6GzskMPvuDZqvDJEsZWiH
        Dg9isqS9vy3J0/zntHKPv4Pv8+NGQurImbZOD9N1ThuywPoBSHsuBZKiBW7vyx3wWiuUVSvBIXRhl
        ppLNVpDtmqx0WYUBG0rIATrkI5B8fJHBctF1lupg2qjmg5TFCNJaVotsHua5Rd2nRqzK3NBi/MVGl
        4L5RY3AIJBPeNJClwUKEJcKuGmwteVjjvy/qduSB02gKeTnfSup2cA9XmplXdi8DRbz3l5kiREQaa
        b9sMIdRA==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oOhAU-006SuS-M7; Thu, 18 Aug 2022 15:10:46 +0000
Message-ID: <c1869a4b-ead1-2ae5-c9ec-61834b578216@infradead.org>
Date:   Thu, 18 Aug 2022 08:10:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: build failure of next-20220817 for amdgpu
Content-Language: en-US
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-next <linux-next@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <Yv1lepjhg/6QKyQl@debian>
 <CADnq5_Od9W1iuzYpsmODOB=Xem97ogeH_t0JrjWC-S8h0XM9fA@mail.gmail.com>
 <5638aaf1-b808-bdc6-d84a-820f24facea6@infradead.org>
 <CADVatmNA6-qCJEHNn-gRO6Nx88SsTrPsJn_F5J0NiFhyvijNxA@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CADVatmNA6-qCJEHNn-gRO6Nx88SsTrPsJn_F5J0NiFhyvijNxA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/18/22 03:43, Sudip Mukherjee wrote:
> On Thu, Aug 18, 2022 at 3:09 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>>
>>
>> On 8/17/22 19:01, Alex Deucher wrote:
>>> On Wed, Aug 17, 2022 at 6:03 PM Sudip Mukherjee (Codethink)
>>> <sudipm.mukherjee@gmail.com> wrote:
>>>>
>>>> Hi All,
>>>>
>>>> Not sure if it has been reported, build of next-20220817 fails with the
>>>> error:
>>>>
>>>> ERROR: modpost: "cpu_smallcore_map" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
>>>>
>>>> Trying to do a git bisect to find out the offending commit.
>>>>
>>>
>>> Thanks.  I don't see that symbol in the driver at all.  Not sure where
>>> it is coming from.
>>>
>>
>> It's powerpc only.
>>
>> Sudip, is it non-CONFIG_SMP by any chance?
> 
> Ohhh.. really sorry for the incomplete report. I should not try to
> mail while travelling.
> 
> The error is seen with powerpc allmodconfig and it has CONFIG_SMP=y.

OK, I see that also, but it doesn't make any sense (to me).

I did 'objdump' on the code file (amdgpu.o) and it's listed as
undefined but there are no code references to it.

-- 
~Randy
