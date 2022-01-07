Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28D04487B1E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 18:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348508AbiAGRMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 12:12:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239660AbiAGRMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 12:12:38 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76AAC061574;
        Fri,  7 Jan 2022 09:12:37 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id w80so9018666oie.9;
        Fri, 07 Jan 2022 09:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=meWJzKr/lTzDUp9/XTgznWUNAOJF/DX7ONGAL+XEdDE=;
        b=CebyNuSFAISoL8GLFOIls5ab12rksmV+sCFCD2dYzRH9UPGxInpCbjflUw1Puh7lNq
         JBvUWRNLJtK+iJcset2E2nK83KhszuXRmJ0bb0pv/6ul1yte/sr+oaMqjmeINlLIVbfJ
         a6yz7kZn61u6NIuNHLxe/H/CJhMnB86/+xa61p133dStn2B+5jsdtxb33+a+w9iqsxe/
         PzIsmytcRlDCDaEQvDs3SDzyQic7/h6hPHJ1KgXDzhQ12p5X44VpFsIuGOOI5pMHAWZp
         zsJyE99ROU/KuXzH/h3S8MG+T10WKPfFUpYoW9q/Cv9pWACK3U0HPLA/tvoXClkMdRjT
         lN+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=meWJzKr/lTzDUp9/XTgznWUNAOJF/DX7ONGAL+XEdDE=;
        b=yQPhNDwMxsPRk2zqKT1eQ4xHyXybCeDZWXDwqsoL0NDJyRCXZFETqDwA3/yjjWxW7k
         Uw3QDKU3XeRLW8NjYNh3PWapP5Z8QGE7CzGTvRqhkeoRSsnWf1KxsUTAbBFQB3GFHBga
         TU/wdLkn7LC0bxj/BmqbdMgxF00lLajB/oou8qg2BUhXLWHF6n7OsGBLj/CJNHV4uUZO
         Zf6Gjf95ICXtV9TnlOUEZsbowlMRmAGKizwr7w6e/XISQyhOVRfenyrLN4sHyRb9NwbY
         S1FTqERq2G0RaxI/aP/DHSVLULOM0/DKOoAeemuICP9H/2XO94xgJw0bPdDPBSFvkYxn
         rpLQ==
X-Gm-Message-State: AOAM531mKlqCe3kA8mR70J6QGvsnw4oX2WwgnrHitgZnjgJ3dAZ9RQJX
        oS/PFfaqLbku7STTduI2wuv+bjaA6+U=
X-Google-Smtp-Source: ABdhPJw7YvIfoiY0y4PDfRlT5fALUBVcjFRb/Fp6PiEruD1lC365sWjUSQW/TcqkK4BEd0fXsDK5UQ==
X-Received: by 2002:a05:6808:d4d:: with SMTP id w13mr10379078oik.85.1641575555698;
        Fri, 07 Jan 2022 09:12:35 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t17sm968120otc.17.2022.01.07.09.12.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jan 2022 09:12:34 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Robert Richter <rrichter@amd.com>,
        Terry Bowman <Terry.Bowman@amd.com>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        wim@linux-watchdog.org, ssg.sos.patches@amd.com,
        sudheesh.mavila@amd.com,
        "Lendacky, Thomas" <thomas.lendacky@amd.com>
References: <20211103161521.43447-1-terry.bowman@amd.com>
 <20211103161521.43447-4-terry.bowman@amd.com>
 <20220106181809.GA240027@roeck-us.net>
 <9afabe55-6429-2284-cafd-d59ce481f067@amd.com>
 <YdgeU2p+i5hN1XCU@rric.localdomain>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 3/4] Watchdog: sp5100_tco: Add EFCH SMBus controller
 initialization using MMIO
Message-ID: <ac8e1173-3002-54f1-0264-6f0cdf26c475@roeck-us.net>
Date:   Fri, 7 Jan 2022 09:12:32 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YdgeU2p+i5hN1XCU@rric.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/7/22 3:05 AM, Robert Richter wrote:
> On 06.01.22 13:07:11, Terry Bowman wrote:
>> On 1/6/22 12:18 PM, Guenter Roeck wrote:
>>> On Wed, Nov 03, 2021 at 11:15:20AM -0500, Terry Bowman wrote:
> 
>>>> diff --git a/drivers/watchdog/sp5100_tco.c b/drivers/watchdog/sp5100_tco.c
>>>> index 80ae42ae7aaa..4777e672a8ad 100644
>>>> --- a/drivers/watchdog/sp5100_tco.c
>>>> +++ b/drivers/watchdog/sp5100_tco.c
>>>> @@ -48,12 +48,14 @@
>>>>   /* internal variables */
>>>>   
>>>>   enum tco_reg_layout {
>>>> -	sp5100, sb800, efch
>>>> +	sp5100, sb800, efch, efch_mmio
>>>>   };
>>>>   
>>>>   struct sp5100_tco {
>>>>   	struct watchdog_device wdd;
>>>>   	void __iomem *tcobase;
>>>> +	void __iomem *addr;
>>>> +	struct resource *res;
>>>
>>> I must admit that I really don't like this code. Both res and
>>> addr are only used during initialization, yet their presence suggests
>>> runtime usage. Any chance to reqork this to not require those variables ?
> 
> We did that in an earlier version, see struct efch_cfg of:
> 
>   https://patchwork.kernel.org/project/linux-watchdog/patch/20210813213216.54780-1-Terry.Bowman@amd.com/
> 
> The motivation of it was the same as you suggested to only use it
> during init.
> 
> Having it in struct sp5100_tco made things simpler esp. in the
> definition of the function interfaces where those new members are
> used.
> 

'res' is only used in the context of sp5100_request_region_mmio()
and sp5100_release_region_mmio(), and both are called from
sp5100_tco_setupdevice_mmio(). I do not see a need for carrying it around
anywhere else, including efch_read_pm_reg8() and efch_update_pm_reg8().

efch_read_pm_reg8() is only called from sp5100_tco_setupdevice_mmio(),
and it only uses struct sp5100_tco *tco to get the address. I don't see
why the address can not be passed to it directly.

efch_update_pm_reg8() also uses tco only to get the address. Again, passing
it instead of a pointer to sp5100_tco *tco would easily be possible.

efch_update_pm_reg8() is only called fromm sp5100_tco_setupdevice_mmio(),
where the change would be easy. It is also called from tco_timer_enable(),
which in turn is called from sp5100_tco_timer_init(). This, again, is called
from sp5100_tco_setupdevice_mmio(). Since the first operation in
sp5100_tco_timer_init() is to call tco_timer_enable() and that function
does nothing but calling efch_update_pm_reg8(), it would easily be possible
to pull out that code from tco_timer_enable() and move it into
sp5100_tco_setupdevice_mmio().

So, no, I neither see the need for having the information in struct
sp5100_tco nor for keeping it in its own structure. If you'd merge
sp5100_request_region_mmio() and sp5100_release_region_mmio() into
sp5100_tco_setupdevice_mmio() you would not even need any pointers
to pass the values from sp5100_request_region_mmio(). Otherwise you
could have sp5100_request_region_mmio() return a pointer to res or
an ERR_PTR, and pass the address as pointer parameter.

Guenter

> If that init vars are no longer in struct sp5100_tco then callers of
> efch_read_pm_reg8() and efch_update_pm_reg8() will need to carry a
> pointer to them. To avoid this I see those options:
> 
> 1) Implement them as global (or a single global struct) and possibly
> protect it by a mutex. There is only a single device anyway and we
> wouldn't need a protection.
> 
> 2) Have an own mmio implementation of tco_timer_enable() and/or
> sp5100_tco_timer_init().
> 
>> Yes, v3 will include refactoring to remove 'res' and 'addr'. I will also
>> correct the trailing newline you mentioned in an earlier email.
>>
>> Regards,
>> Terry
>>
>>>>   	enum tco_reg_layout tco_reg_layout;
> 
> While at it, tco_reg_layout is also only used during initialization
> and can be moved there too. This would raise option 3:
> 
> 3) Add a pointer of struct sp5100_tco to struct efch_cfg and use that
> struct instead in init funtions only. But that causes the most rework
> (which would be ok to me).
> 
> Going with 3) looks the cleanest way, I would try that. But all
> options have its advantages.
> 
> -Robert
> 
>>>>   };

