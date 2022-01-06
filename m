Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 873C2486132
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 08:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236238AbiAFH5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 02:57:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235701AbiAFH53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 02:57:29 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5294EC061245
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 23:57:29 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id n19-20020a7bc5d3000000b003466ef16375so3239722wmk.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 23:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fQP2YfUpb4fHqOMssL3eeo2Ym6aNx9vMkOEeNtp9unE=;
        b=aYNR0bGpAowqlxd/DOt/e+Ls1z7NRf778/koD7Cfa4+aVe7SVH+l8cErlXs82QKLEw
         Z5qGDZsPuh3rS6h9gfhiFpaAoOT4rU3I3l2iVJicEu1BzGdr90SSsLQMyOsASziVgdgJ
         YObi8gEoE/VRIabA8frRa8WyJo3Ucx/Mk6bbSP6eOSBwDLlgIvJuiVh63rNzbUkZDAP+
         4LxsmWvV0H7qYyfWTpzUIDFrfSwTp1wY6RxRI9jOwufUZ8uu3M2zh9iuNYJrN8yxv498
         seyFX4qcU3HNv0Nn5+u2G2wEro1HFcF5M9s20AFKmkpikZM2Win0JKxgMQUltsO1uEOL
         1rZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fQP2YfUpb4fHqOMssL3eeo2Ym6aNx9vMkOEeNtp9unE=;
        b=2yQc+e+rNINEwxZxP+mnLwBa0vEiFzSEYWrKvJSYTjZjJNjT0teIkuVo5U1roeLe7g
         lVpyp1lEaKtPmIcxKCftPoMbZd2NuXWSFcC1gL1viJgszJTH+D07F6xuKrCE6FsmtpDi
         OqhLYpw3uXljVpSi+lOnUXP1KfNxn0DOw4yrDfVYHJOjmNiv/2L/LFZ8VUjabmuCYEzA
         49zuaLhib21MfLyChO8OPY7LyCWQwKup9HHhYsv8wTkxEoS1he50oYRLmaBaeWZ6ecgj
         KQza61eeqO3mr3rWsHG1iQG8GgSFhFSlwMs1MqZHtTPgP5moVuoD1abb5guu38kyXU4A
         Ccjg==
X-Gm-Message-State: AOAM530Xchadnhc4PF4jn2r0cm4aL8n6wR6IlFpdMIhXra2LNwuaGZPR
        92ayZ4MQoy9ze1axT3f+7xD6lM0FfjA=
X-Google-Smtp-Source: ABdhPJxQPpd9VYMQ00wMYZnHD+Ixv+8leGTwWWRu6T1/iyWI3JOX8CMjxO/l4Sh29QcFkIxKIELWbA==
X-Received: by 2002:a05:600c:4e4a:: with SMTP id e10mr5838746wmq.15.1641455847995;
        Wed, 05 Jan 2022 23:57:27 -0800 (PST)
Received: from ?IPV6:2a02:8108:96c0:3b88::b8a2? ([2a02:8108:96c0:3b88::b8a2])
        by smtp.gmail.com with ESMTPSA id a2sm1556343wri.17.2022.01.05.23.57.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jan 2022 23:57:27 -0800 (PST)
Message-ID: <1bc4945c-9087-41dc-1e30-0844e661ed5d@gmail.com>
Date:   Thu, 6 Jan 2022 08:57:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 0/7] staging: r8188eu: clean up tx power arrays
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220105083426.177128-1-martin@kaiser.cx>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <20220105083426.177128-1-martin@kaiser.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/5/22 09:34, Martin Kaiser wrote:
> This set removes unused tx power arrays and changes some other arrays from
> multidimensional to one-dimensional.
> 
> Martin Kaiser (7):
>    staging: r8188eu: rfPath is always 0
>    staging: r8188eu: make Index24G_CCK_Base a 1-D array
>    staging: r8188eu: make Index24G_BW40_Base a 1-D array
>    staging: r8188eu: CCK_24G_Diff is set but not used
>    staging: r8188eu: BW40_24G_Diff is set but not used
>    staging: r8188eu: make OFDM_24G_Diff a 1-D array
>    staging: r8188eu: make BW20_24G_Diff a 1-D array
> 
>   .../staging/r8188eu/hal/rtl8188e_hal_init.c   | 25 ++++++++-----------
>   drivers/staging/r8188eu/hal/rtl8188e_phycfg.c | 12 ++++-----
>   .../staging/r8188eu/include/rtl8188e_hal.h    | 10 +++-----
>   3 files changed, 20 insertions(+), 27 deletions(-)
> 

For all patches:

Acked-by: Michael Straube <straube.linux@gmail.com>
