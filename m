Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E54204ED16F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 03:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352407AbiCaByj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 21:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352397AbiCaByi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 21:54:38 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B9A4A3EA;
        Wed, 30 Mar 2022 18:52:52 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id mp11-20020a17090b190b00b001c79aa8fac4so2262654pjb.0;
        Wed, 30 Mar 2022 18:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=pPHGJquzjhuKkM6zgo0wDsWdmYjHFD768pRVRqklzb4=;
        b=pM06AMuQwIIc2X2kNwul0O1R32GzLRNtQwIZoosX9K4hj4Yf60iXlc2KW9/1mp6g7W
         z6kKVdIWJE/H0JTFy3inMERqgXlf00vkoBG/ZCCoQcKWbgot/977/Mune0S3aJgNimCp
         e324lAGc6UDp21nWoSuxMl1n5Q8P9uAnoTNv63VuqQEaH5rvyvYKdBGMP+sPDJslMH8f
         4eBuKEQHDSm884aPSpnigyvGpBKI7rYvx+qRL3/ZvT+sV0pLwx9kkuUIBL/FOAJBf6Aw
         pITHsNnglv4MurZandepyS8zY+dPNPyuOcHW5bg50ZwO+WaUInZ5aS7yj/7Mf434RTys
         1SvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pPHGJquzjhuKkM6zgo0wDsWdmYjHFD768pRVRqklzb4=;
        b=ECxQo2tSodlqNk3HyzUPl9GBdRAgWoF8ZHMI6UevahzePAfD0iBzeRfSgFzra0kChG
         bcAqyQT52fl6oy3TADXHw+V91q1KXyxdNvBNe9sjewfn0jTHEbvZrtR7EYN7noqpXYtk
         71x7s1udbJ6I6gcBiWlDWMVYGDsNU6PYeKqiZf2G9LItwBUvcIdgujjBFxdUsWBasDKC
         BjwLFSO1YnkfbflUSnm/jM6LRas1lnXP9b/VlQg5MszMSqLa3wOzeswKoKIgEq7IB846
         P4h/+g0WY7hMU5N5+Sa3FbmjiN/11l+9+VtO+uGRjxOR6tpNbKnRS4bF2W4pI7ve+2Ic
         fc3A==
X-Gm-Message-State: AOAM533ENf/v5wTmubbgna1ZeFCYGENfeTmtg4sVyRmeSWsKbjMGpwz9
        cqEPvNOUz3gn5w0oZALn2xQ=
X-Google-Smtp-Source: ABdhPJxxW5Hb84w4jrdqfMxepJFg8OftyyVmzO+uNiSCvfynYZX4BD6JjT1D8B0LVsPrItjUih+2Kg==
X-Received: by 2002:a17:90a:af86:b0:1c7:db8e:8589 with SMTP id w6-20020a17090aaf8600b001c7db8e8589mr3182961pjq.94.1648691571842;
        Wed, 30 Mar 2022 18:52:51 -0700 (PDT)
Received: from [10.11.37.162] ([103.84.139.54])
        by smtp.gmail.com with ESMTPSA id c5-20020a056a00248500b004f6b5ddcc65sm25383780pfv.199.2022.03.30.18.52.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 18:52:51 -0700 (PDT)
Message-ID: <5ba0e090-c1c0-b237-73ac-3eb4b007f5f4@gmail.com>
Date:   Thu, 31 Mar 2022 09:52:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] media: mc: delete redundant code in
 __media_device_unregister_entity
Content-Language: en-US
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220324102752.47077-1-hbh25y@gmail.com>
 <Yjx2Xm7JmS+E8d7M@pendragon.ideasonboard.com>
 <YkQ5ic2b/gaF8cF+@paasikivi.fi.intel.com>
From:   Hangyu Hua <hbh25y@gmail.com>
In-Reply-To: <YkQ5ic2b/gaF8cF+@paasikivi.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/30 19:05, Sakari Ailus wrote:
> On Thu, Mar 24, 2022 at 03:47:10PM +0200, Laurent Pinchart wrote:
>> Hi Hangyu,
>>
>> Thank you for the patch.
>>
>> On Thu, Mar 24, 2022 at 06:27:52PM +0800, Hangyu Hua wrote:
>>> media_gobj_destroy has already set graph_obj.mdev to NULL. There is no need to
>>> set it again.
>>>
>>> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
>>
>> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>>
>>> ---
>>>   drivers/media/mc/mc-device.c | 1 -
>>>   1 file changed, 1 deletion(-)
>>>
>>> diff --git a/drivers/media/mc/mc-device.c b/drivers/media/mc/mc-device.c
>>> index cf5e459b1d96..7727c619043e 100644
>>> --- a/drivers/media/mc/mc-device.c
>>> +++ b/drivers/media/mc/mc-device.c
>>> @@ -605,7 +605,6 @@ static void __media_device_unregister_entity(struct media_entity *entity)
>>>   
>>>   	/* invoke entity_notify callbacks to handle entity removal?? */
>>>   
>>> -	entity->graph_obj.mdev = NULL;
> 
> Removed the extra newline above, too. Applied.
> 
> Please run scripts/checkpatch.pl on the patches, too.

Thanks. I will make a v2 with this change.
> 
>>>   }
>>>   
>>>   /**
>>
>> -- 
>> Regards,
>>
>> Laurent Pinchart
> 
