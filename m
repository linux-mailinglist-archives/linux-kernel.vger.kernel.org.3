Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A475A47BCD4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 10:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236357AbhLUJYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 04:24:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236335AbhLUJX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 04:23:58 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B92AC061574;
        Tue, 21 Dec 2021 01:23:58 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id t18so25496850wrg.11;
        Tue, 21 Dec 2021 01:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=JiSwgynY0ouiHxxDkFiTGE0SJCUuFbNuV7MjwRTSqx8=;
        b=G9KdN3kIbKGbFnEUHUKsZsEBRWvDzMfCDjA1eNlyu+dg/UadRUlcSWYcIa7ur/JyzV
         nOCtW2KFmLKkoGmxM+qjR78FiMWgg01Re6PZGhIIkUWoKDQm4evbjb3l2MWydLPs8m2O
         Ypk6qHoNwi0oM0cPPanOD6ywONHDLE3KBp7SyAwNj4gVv33kFw2qSEunUEY6r311rUup
         ubmixjP3v1HV2mreWahW/pitNCbfjMM9q4kUagsoLTtGn0QoHpPbkdlOEzyMmjJKF52j
         FW23As3WT9bA/xqkxVNxHogPoavg1YilCUQbaXI4gWAIVhW2TxYvC0p1Ry96FTnBBz15
         hs7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=JiSwgynY0ouiHxxDkFiTGE0SJCUuFbNuV7MjwRTSqx8=;
        b=AmM8kkmYEqKVokFHcDwUEbl5fWsBgNHB9llCTH4RqnX3bun5hhfewjTMPySZZcscMz
         wCtk255Z7SwcTvnA0qep6zHHQb4RgIhhAhqqUDGu5Nxb9jWgkiswdQRNsxajE8XjK8mJ
         DoYrWvK1aoidvisK8t+p48nhBBYnnjifSY0SoT5sYHptKFeDVrUSXQ1H9E6Bm3tmbGwg
         Yk9WjgjqxhKwYhC/vsT43Zll3S4TdB16EIhY9AR6Jq8Gr4zM1h+ZC/0SsmFAkg4lqt+M
         JxB069GscV1PA1La1Xo3qrN92f8g7/szqWEB0xQEipA0kvnuX/qEKfclhbfAtWTVW559
         aCbw==
X-Gm-Message-State: AOAM531P4yuN98fkkLoXdfjzz675anNDWzXrp6LhyuLY3zeILUT7q0UT
        iLM8QWFUv/+zImAABXRBViE=
X-Google-Smtp-Source: ABdhPJyH8hD2Cy5Eeat0R99gvXMgY2SSGQgDObew5sNwwTli/MvTT7g29JPJ5Buw5qbmBCljoc0j5g==
X-Received: by 2002:adf:9d82:: with SMTP id p2mr1877317wre.414.1640078636757;
        Tue, 21 Dec 2021 01:23:56 -0800 (PST)
Received: from [192.168.0.14] (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net. [86.13.91.161])
        by smtp.gmail.com with ESMTPSA id p22sm3585656wms.2.2021.12.21.01.23.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Dec 2021 01:23:56 -0800 (PST)
Subject: Re: [PATCH v1 1/1] software node: Update MAINTAINERS data base
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
References: <20211221071409.14361-1-andriy.shevchenko@linux.intel.com>
 <35944dfd-a20a-f67b-5d34-a0e0a4cb7066@gmail.com>
 <YcGbidqy+rgiY1vf@smile.fi.intel.com>
From:   Daniel Scally <djrscally@gmail.com>
Message-ID: <605c8f7b-599c-1644-686d-8b94d8f05e87@gmail.com>
Date:   Tue, 21 Dec 2021 09:23:55 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YcGbidqy+rgiY1vf@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 21/12/2021 09:16, Andy Shevchenko wrote:
> On Tue, Dec 21, 2021 at 09:15:30AM +0000, Daniel Scally wrote:
>> Morning
>>
>> On 21/12/2021 07:14, Andy Shevchenko wrote:
>>> There are two updates to the MAINTAINERS regarding to software node API:
>>> - add Dan Scally to be designated reviewer
>>> - add rather tightly related device property files to the list
>>> - adjust section name accordingly
>>>
>>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>> ---
>>>
>>> Based on the latest Dan's involvement and amount of patches seen recently
>>> I went ahead and added his name to the list. Dan, please tell me if it's
>>> not appropriate.
>> This is fine by me - I don't know if you need a tag from me for this but
>> feel free to add whichever's appropriate
> Yep, please give a formal tag (usually Acked-by in this kind of cases).
>
Acked-by: Daniel Scally <djrscally@gmail.com>
