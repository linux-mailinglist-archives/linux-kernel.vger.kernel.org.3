Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F394E581ABD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 22:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239753AbiGZUJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 16:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiGZUJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 16:09:48 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1343233E27
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 13:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=36wpHebUWA+lWUHxAuJLmGhedd5D2vCF+qo7fkkHIZw=; b=po3/K8o0LE+O1LP0BOKdX76MuI
        aVX7XVON+Drywbs8JbetPnMkOqmdEKM75kXi0jABF2dai8m2FJVWd9gn2+fFEZsmIZ6A0NULB+cID
        J1mDkNbfosUKiTtILcYPfLnMuC+qSlQZYYMa9WpKHgqm9puaJjb9mN66yMqXpmniS0H8azkifqJq9
        5dqm4IuBd8qHBEu1ymhcBam8yFAVrh2s2OGLZ6SEjg7zsmC9k7r5tdz5rX1lqyTjW+jcUaVIWbTIy
        rYxusGLPt8vvnoq6pGu5PJLmY5y0c0eRr41vHCHvuFbwDLhGTNyN1S184X34vtA9aTdXitzHA8jiR
        l5SGj/Kw==;
Received: from 201-13-50-220.dsl.telesp.net.br ([201.13.50.220] helo=[192.168.15.109])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1oGQs3-007gIM-UV; Tue, 26 Jul 2022 22:09:35 +0200
Message-ID: <63594d3f-bf14-cf96-ecdb-5e12b4cd4472@igalia.com>
Date:   Tue, 26 Jul 2022 17:09:15 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] drm/amd/display: change variables type
Content-Language: en-US
To:     Magali Lemes <magalilemes00@gmail.com>
Cc:     siqueirajordao@riseup.net, sunpeng.li@amd.com,
        tales.aparecida@gmail.com, airlied@linux.ie, Xinhui.Pan@amd.com,
        Rodrigo.Siqueira@amd.com, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, mwen@igalia.com,
        mairacanal@riseup.net, dri-devel@lists.freedesktop.org,
        daniel@ffwll.ch, alexander.deucher@amd.com, isabbasso@riseup.net,
        andrealmeid@riseup.net, harry.wentland@amd.com,
        christian.koenig@amd.com
References: <20220725181559.250030-1-magalilemes00@gmail.com>
 <a7589316-2a55-85f2-b665-5fe4bebf7a69@igalia.com>
 <4f359e30-90f8-c8bf-4e07-6856fcfd3506@gmail.com>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <4f359e30-90f8-c8bf-4e07-6856fcfd3506@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Às 17:47 de 25/07/22, Magali Lemes escreveu:
> 
> On 7/25/22 16:42, André Almeida wrote:
>> Hi Magali,
>>
>> Às 15:15 de 25/07/22, Magali Lemes escreveu:
>>> As "dcn3_15_soc" and "dcn3_16_soc" are of type "struct
>>> _vcs_dpi_soc_bounding_box_st", change their types accordingly.
>>>
>> I can see that indeed this type change sense for those variables, but
>> isn't a bit strange that the type was wrong in the first place? I wonder
>> if this variable is even used, given that it would very likely throw a
>> compiler error when using the wrong type and trying to access struct
>> members that aren't defined.
> 
> 
> A compilation error would be thrown if either
> "dc/dcn315/dcn315_resource.h" or "dc/dcn316/dcn316_resource.h" were
> included in the files where "dcn3_15_soc" and "dcn3_16_soc" are
> initialized. Since they are not included, the wrong variable type error
> is not shown.
> To solve the sparse warning in the second patch of this series, those
> variables need to be declared first, but they are already declared,
> we're only missing the headers. If I only add the headers, then those
> variables will be seen, and I get the expected incompatible variables
> types error. So, fixing the types here is a preliminary work for the
> next patch.
> 

And what happens if you just drop this declaration? It still not clear
to me why this belongs to this header, giving that AFAIK this var is
only used at drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c

Note that this kind of information you explained to me would be very
useful if you had included it in a cover letter to add more context for
your patches :)

> 
> Magali
> 
> 
>>
>>> Signed-off-by: Magali Lemes <magalilemes00@gmail.com>
>>> ---
>>>   drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.h | 2 +-
>>>   drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.h | 2 +-
>>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.h
>>> b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.h
>>> index 39929fa67a51..45276317c057 100644
>>> --- a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.h
>>> +++ b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.h
>>> @@ -32,7 +32,7 @@
>>>       container_of(pool, struct dcn315_resource_pool, base)
>>>     extern struct _vcs_dpi_ip_params_st dcn3_15_ip;
>>> -extern struct _vcs_dpi_ip_params_st dcn3_15_soc;
>>> +extern struct _vcs_dpi_soc_bounding_box_st dcn3_15_soc;
>>>     struct dcn315_resource_pool {
>>>       struct resource_pool base;
>>> diff --git a/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.h
>>> b/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.h
>>> index 0dc5a6c13ae7..d2234aac5449 100644
>>> --- a/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.h
>>> +++ b/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.h
>>> @@ -32,7 +32,7 @@
>>>       container_of(pool, struct dcn316_resource_pool, base)
>>>     extern struct _vcs_dpi_ip_params_st dcn3_16_ip;
>>> -extern struct _vcs_dpi_ip_params_st dcn3_16_soc;
>>> +extern struct _vcs_dpi_soc_bounding_box_st dcn3_16_soc;
>>>     struct dcn316_resource_pool {
>>>       struct resource_pool base;
