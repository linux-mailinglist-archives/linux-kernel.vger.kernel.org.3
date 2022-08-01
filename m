Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE36586260
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 03:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236511AbiHABwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 21:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiHABwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 21:52:44 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31033101EC;
        Sun, 31 Jul 2022 18:52:43 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id v16-20020a17090abb9000b001f25244c65dso13637293pjr.2;
        Sun, 31 Jul 2022 18:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=cts89Urg1Uc0LBv0m8WUOVTMu8H/nP9lQWVspGvxl/M=;
        b=Yoyl7sblFAAr4nHx9Dw11RXEAxdHiU4x6bJUImWzvGs8+ogPEAD8n1G3W4OLAvcriP
         XTjhuYo6QuntcB3so/5xBNA2YDR+GYuYl+MZ0EdsQ6oJ9YdTl7y2uDLaLvcOgbdfUou9
         IOdgeaItYpET9I6Feq6O2WIx51DSLd7xTJFLL9+JzLCWhwQGXTYIZESs+dmFF8CjJlk9
         NeT1k58fdutlDBeJEzgOHs8rAg67bFvrfwaHaEaqe7HLu/2q+J+IU5f8UrHjXFS+YNDD
         xFaYIKJeH8S0d4LD2LMFOdMj4JIVaPCdSsYES8eAZLX1eDD9AKBzaM3M0LpLtKWJ36PM
         VR6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cts89Urg1Uc0LBv0m8WUOVTMu8H/nP9lQWVspGvxl/M=;
        b=xpa/oTCqJLOTi11UoSP3HD4ysuWco9ydaPoCvynLkhLvj6p/To98EUZ9HD518XtuvQ
         n9S9FzZdGd3QOqNgDgFw9hIB4wuk7XAE7Irz0TrR3V1MNukIPMjVFhu899P61nlBQaDK
         pV0l+Ea4VGi/+qx28AiFioP4dJkhc6PXwzZ4YljtpXk2taNjznY+qLBB8rFvL+a33CMz
         bPMdql38fOQv7rELtgKoYnAIVHnJW1UTRQ72JtB875j+bft2p4KBgqosV3x2B0thn/ul
         lOlMD7l+Qh72wqs2uJs7VEArCj46LHdIhX0Ac0HMzeMUpcXiquOOJHLR/2k5HBKFy3SY
         4vGA==
X-Gm-Message-State: ACgBeo0ZHS+4wIFsN6Ha5DukIhIU6LTBkyQKR5s3zwOGzGu5rq9zbNYd
        vSaWitxdbRx+TYx5HI0QglA=
X-Google-Smtp-Source: AA6agR6QZqDQ9TIbddaHajr6M7D7HTfebbIH2FC8Gj5rE5OFz3YWnlmS6T6dPK+JFQNL9it6Wi8rZA==
X-Received: by 2002:a17:903:11d1:b0:16c:defc:a098 with SMTP id q17-20020a17090311d100b0016cdefca098mr14349003plh.50.1659318762325;
        Sun, 31 Jul 2022 18:52:42 -0700 (PDT)
Received: from [10.10.4.41] (125-228-123-29.hinet-ip.hinet.net. [125.228.123.29])
        by smtp.gmail.com with ESMTPSA id v10-20020a63f20a000000b0041b672e93c2sm6292529pgh.17.2022.07.31.18.52.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jul 2022 18:52:41 -0700 (PDT)
Message-ID: <4ea235d1-46c1-87de-760f-dc4775007ae0@gmail.com>
Date:   Mon, 1 Aug 2022 09:50:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 2/2] iio: humidity: hdc100x: add manufacturer and
 device ID check
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Patrick Williams <patrick@stwcx.xyz>,
        Potin Lai <potin.lai@quantatw.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220728125435.3336618-1-potin.lai.pt@gmail.com>
 <20220728125435.3336618-3-potin.lai.pt@gmail.com>
 <20220731130959.50826fc4@jic23-huawei>
From:   Potin Lai <potin.lai.pt@gmail.com>
In-Reply-To: <20220731130959.50826fc4@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/31/22 20:09, Jonathan Cameron wrote:
> On Thu, 28 Jul 2022 12:54:35 +0000
> Potin Lai <potin.lai.pt@gmail.com> wrote:
>
>> Add manufacturer and device ID checking during probe, and skip the
>> checking if chip model not supported.
>>
>> Supported:
>> - HDC1000
>> - HDC1010
>> - HDC1050
>> - HDC1080
>>
>> Not supported:
>> - HDC1008
>>
>> Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
> I need some more information on the 'why' of this patch.  There are a number
> of drivers that do a similar ID check but in recent times, that approach has
> been considered wrong because it breaks potential use of multiple compatible
> entries in device tree.   If a new device comes along and is backwards
> compatible with an existing one (maybe has new features, but using them is
> optional) then we want to have an entry that looks like
>
> compatible = "ti,hdc1099", "ti,hdc1080"
>
> If the new ID is not supported by the kernel that is being used, we still
> want the driver to 'work' using the fallback compatible.
>
> As such, we no generally do the following.
>
> 1) If we have a match to a device we know about but it's not the one the
>    firmware tells us to expect, print a warning but operate as if the firmware
>    had been correct - particularly if we know the parts aren't compatible
>    with each other. (this bit is optional as we should be able to assume firmware
>    doesn't do stupid things :)
> 2) If we don't match at all, print a warning about an unknown device but carry
>    on with assumption that the firmware is correct and this new device ID is
>    backwards compatible with the provided fallback compatible.
>
> So if this is just a bit of defensive programming (rather than necessary for some
> reason not yet explained) then change from returning an error on probe() to 
> printing an warning message but continuing anyway. (which is part (2) of the
> above)
Hi Jonathan,
In our hardware board, we have "ti,hdc1080" as main source, and "silabs,si7020"
for 2nd source. This two chip are locate at same bus and same slave address,
and we want to use multiple compatibles to support both chips with single device
node in device tree.
 
Ex:
compatible = "ti,hdc1099", "silabs,si7020";
 
In order to support this, I need to add ID checking mechanism into the current
hdc100x driver, so the si7020 chip will fail to probe with hdc100x driver
(because the ID checking is not failed), then success probe with si7020.
 
Base on you explanation, it looks multiple compatibles is not suitable in this
case? Would you mind advise us what would be the better approach for our case?

Thanks,
Potin

