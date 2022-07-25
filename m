Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E07895805E7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 22:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbiGYUrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 16:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiGYUrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 16:47:09 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB556420
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 13:47:08 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id g20-20020a9d6a14000000b0061c84e679f5so9565339otn.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 13:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Cg/l5r1DnfHeQDhJMEUy4F+4PmlxIavAirIL0/cpxLY=;
        b=hQb7YnD6H74svuohwJ5MGhCu6hJIzuKgaz1De63644kZ3X7lWS7VjWdR5dC4VjT4nc
         74C49l30iD3MnjL3i6fgY6dKK9DC6cW5jUKNzdehgfOxLpcJWuBwZ0JN15ymAyBpl0f3
         wIWbdBwq4vghDxbSls5/cOkQLAVCd4IqybBy3wOkW8Cw8PEcNgHvWXaVzds71Fn0cz7r
         Kh7pgoX8pDsXQHQL93NlbPjVp2FHhNfcBwIpPxXsHIGmjVhN7vbVjZxXZKwb4NSRIZMI
         v/+Nk8NfkaHYcE4QPQYgk7U6djHRtVtXHRsrmTDBi8UzaJNWKMHbqGEtsR57/U0d5+pU
         jnPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Cg/l5r1DnfHeQDhJMEUy4F+4PmlxIavAirIL0/cpxLY=;
        b=KYmdeRosGuDmNMfQMijuebE8hJLw92/fREpB1BNS37dX4s0ZAGqBUP1Gd8RQKTUel0
         gq5QDlzwrXyE6bGMCS6LkKqeBI1ljwLh0Q3FCZhR9+x9hEzC6F7q6h0JkT9a/evmySq4
         EBBuLgUrEuYsJQY35Pa5A5KTRlYnG4T8BYsp6HeoJGjWsdcu6Clw78ho/4kzZX+d7OL9
         SoGxJq5HoiU9BI5XxY4Kh0ZrqAMT5SyFetsiF/dPwGTupTKFSbTxxbpdfZLQMAEXoZ86
         XCZNS+crlD1uGHWO4PPn+ki1ee+aYOyhgxVQhOxzzYnsqjCpbJ7dYbGPdRjbAFTfyuGp
         2qsQ==
X-Gm-Message-State: AJIora/CyxGkZu+oRyY5rUlwe6lJgf2Kdd+vUrhTqT1D8HW6yXZUtNEw
        R71+cr4asZfX6KwNxiRxj3M=
X-Google-Smtp-Source: AGRyM1v+7jRm6tpyJZxahGhRMsz454sYm8Q2qSd6NB5xA0Uv/skaQtKPfgvnbBzJvoF6ucOVc6dpfA==
X-Received: by 2002:a9d:2083:0:b0:61c:dbc8:3d8b with SMTP id x3-20020a9d2083000000b0061cdbc83d8bmr5369503ota.192.1658782027639;
        Mon, 25 Jul 2022 13:47:07 -0700 (PDT)
Received: from ?IPV6:2804:14c:bbe3:4370:95da:f07f:e927:6958? ([2804:14c:bbe3:4370:95da:f07f:e927:6958])
        by smtp.gmail.com with ESMTPSA id j5-20020aca6545000000b0033ad9f035a5sm1967963oiw.34.2022.07.25.13.47.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jul 2022 13:47:07 -0700 (PDT)
Message-ID: <4f359e30-90f8-c8bf-4e07-6856fcfd3506@gmail.com>
Date:   Mon, 25 Jul 2022 17:47:01 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH 1/2] drm/amd/display: change variables type
Content-Language: en-US
To:     =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>
Cc:     siqueirajordao@riseup.net, harry.wentland@amd.com,
        Xinhui.Pan@amd.com, christian.koenig@amd.com,
        alexander.deucher@amd.com, Rodrigo.Siqueira@amd.com,
        tales.aparecida@gmail.com, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, mwen@igalia.com,
        mairacanal@riseup.net, dri-devel@lists.freedesktop.org,
        isabbasso@riseup.net, andrealmeid@riseup.net, sunpeng.li@amd.com,
        airlied@linux.ie, daniel@ffwll.ch
References: <20220725181559.250030-1-magalilemes00@gmail.com>
 <a7589316-2a55-85f2-b665-5fe4bebf7a69@igalia.com>
From:   Magali Lemes <magalilemes00@gmail.com>
In-Reply-To: <a7589316-2a55-85f2-b665-5fe4bebf7a69@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/25/22 16:42, André Almeida wrote:
> Hi Magali,
>
> Às 15:15 de 25/07/22, Magali Lemes escreveu:
>> As "dcn3_15_soc" and "dcn3_16_soc" are of type "struct
>> _vcs_dpi_soc_bounding_box_st", change their types accordingly.
>>
> I can see that indeed this type change sense for those variables, but
> isn't a bit strange that the type was wrong in the first place? I wonder
> if this variable is even used, given that it would very likely throw a
> compiler error when using the wrong type and trying to access struct
> members that aren't defined.


A compilation error would be thrown if either 
"dc/dcn315/dcn315_resource.h" or "dc/dcn316/dcn316_resource.h" were 
included in the files where "dcn3_15_soc" and "dcn3_16_soc" are 
initialized. Since they are not included, the wrong variable type error 
is not shown.
To solve the sparse warning in the second patch of this series, those 
variables need to be declared first, but they are already declared, 
we're only missing the headers. If I only add the headers, then those 
variables will be seen, and I get the expected incompatible variables 
types error. So, fixing the types here is a preliminary work for the 
next patch.


Magali


>
>> Signed-off-by: Magali Lemes <magalilemes00@gmail.com>
>> ---
>>   drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.h | 2 +-
>>   drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.h | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.h b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.h
>> index 39929fa67a51..45276317c057 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.h
>> +++ b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.h
>> @@ -32,7 +32,7 @@
>>   	container_of(pool, struct dcn315_resource_pool, base)
>>   
>>   extern struct _vcs_dpi_ip_params_st dcn3_15_ip;
>> -extern struct _vcs_dpi_ip_params_st dcn3_15_soc;
>> +extern struct _vcs_dpi_soc_bounding_box_st dcn3_15_soc;
>>   
>>   struct dcn315_resource_pool {
>>   	struct resource_pool base;
>> diff --git a/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.h b/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.h
>> index 0dc5a6c13ae7..d2234aac5449 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.h
>> +++ b/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.h
>> @@ -32,7 +32,7 @@
>>   	container_of(pool, struct dcn316_resource_pool, base)
>>   
>>   extern struct _vcs_dpi_ip_params_st dcn3_16_ip;
>> -extern struct _vcs_dpi_ip_params_st dcn3_16_soc;
>> +extern struct _vcs_dpi_soc_bounding_box_st dcn3_16_soc;
>>   
>>   struct dcn316_resource_pool {
>>   	struct resource_pool base;
