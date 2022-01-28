Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C03949F049
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 02:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241845AbiA1BCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 20:02:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236921AbiA1BCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 20:02:00 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC5FC061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 17:02:00 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id g2so3828388pgo.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 17:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=obrdhdVm4PvSG5R1xKZYS6lkGF0TscPIm4ZrMbK0aJU=;
        b=allFE17VplTrJV124AQE3Pg9zU/+Bqe/O3N+qawqLHSG8KfQuybH0py5VmfMDw487E
         MksiMF1onfDKwXVoTR01dA7X62iMn2KmrXaTLcIdREIkPs84JatT3ntzo64mNvV7EJH6
         r8xqEhHjMe/9gi925z6h37rJ2s5KwLlriwe2qAYbnCLhgJqjURrJjGAg5qDJwoPvOwA4
         G/adfSni2DnGxwinFNq1Y80AO0P5v3j69jgEVz4ht+ASgrrETHm7TyfHhb2lY1mjigTa
         mZUzkpvBq3jN5YyQTX48BbF2p/BuI5o1Q0AT806xTkzqwFB2w+6ZNNf4JIwrNdQ4LUiw
         u0Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=obrdhdVm4PvSG5R1xKZYS6lkGF0TscPIm4ZrMbK0aJU=;
        b=w9w8yS2yiZux2pXcSssc5W3hdE55n9RbsFkbiGeBouI/PoiO6SwLcahkLyhh4MStqr
         EM6b51Rwy/nn4iSyVVdIw/DXPdrFXSWDSHA0UJpcUhJN/HCPcOANmiaUOgrb8Sp7QgQO
         ilCAbJQDfIbjOHgCFEaWR8Gupyd1L5c0tsiNi6C+469Vi96s6UHXftITZYTS4SV7S3Re
         fHXzCf5S9/Frd3ySl9ufUGCL4UwrfWUNYHdNjbFNwru4P9H2pwfp1KyIDNF8SJHuaqD2
         4huLSKvzk7KYlNhc0JJ5e1AwLsurivzGfLakHUoLbEsanbVCecl/aSMvu4F57Hi4FpCJ
         FRhg==
X-Gm-Message-State: AOAM533fF0afjRIUruznZuU3/jS4eOObLZOenQOLm4dKZksswwW8sP5O
        FBDMoNl0EaFuaBV+AwjKB60=
X-Google-Smtp-Source: ABdhPJwAtWwY+ilUEo0jp20ZfzNnWAPlRY5aj2xDpBg+/M9t6X35iUnOTePr1Gsk89Q9AGqFSVKgTg==
X-Received: by 2002:a05:6a00:2447:: with SMTP id d7mr5527416pfj.64.1643331719809;
        Thu, 27 Jan 2022 17:01:59 -0800 (PST)
Received: from ?IPV6:2600:8802:b00:4a48:31be:19f8:e4b4:84c8? ([2600:8802:b00:4a48:31be:19f8:e4b4:84c8])
        by smtp.gmail.com with ESMTPSA id b20sm7097453pfv.134.2022.01.27.17.01.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 17:01:59 -0800 (PST)
Message-ID: <e801d672-bedf-b08b-d27b-2b0cdd476a6d@gmail.com>
Date:   Thu, 27 Jan 2022 17:01:57 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 0/3] phy: phy-brcm-usb: Fixes for phy-brcm-usb driver
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Al Cooper <alcooperx@gmail.com>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-phy@lists.infradead.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20211201180653.35097-1-alcooperx@gmail.com>
 <7cbb745e-8b95-1eed-0903-44070a112ec0@gmail.com> <Ye0/8MSBRVNuBr3L@matsya>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <Ye0/8MSBRVNuBr3L@matsya>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/23/2022 3:45 AM, Vinod Koul wrote:
> On 19-01-22, 15:26, Florian Fainelli wrote:
>> Hi Vinod,
>>
>> On 12/1/21 10:06 AM, Al Cooper wrote:
>>> A few fixes for the phy-brcm-usb driver.
>>>
>>> Al Cooper (3):
>>>    phy: usb: Leave some clocks running during suspend
>>>    usb: Add "wake on" functionality for newer Synopsis XHCI controllers
>>>    phy: broadcom: Kconfig: Fix PHY_BRCM_USB config option
>>
>> Are you able to pick up those patches? Thank you
> 
> Applied phy patches to phy-fixes, thanks

Thanks! I can see patches 1 and 3 there but patch 2 is not in phy-fixes 
or your next branch. Can you pick it up if it is satisfactory? Thanks!
-- 
Florian
