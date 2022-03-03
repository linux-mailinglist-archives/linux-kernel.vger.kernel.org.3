Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9B534CB872
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 09:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbiCCIKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 03:10:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbiCCIKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 03:10:08 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F5417128D
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 00:09:19 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id u1so6450584wrg.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 00:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=Z6JyIRyQjmSUtkW88pmcBmgAMAjTfjaBSIAjcjL9OVw=;
        b=E0Npjfox6oARCXqef/ki4z3U3S3pEMaz9/n9UG3aUZ68amCdmjwb18hcpdSqSONxsL
         8DiOVPd4/4R4r4i6UPOAvZZMdhBda8JQ9ldoYTMThxhhCSuwbrG2BLYfTUhT607oVgT1
         RA0m/RxXVYdURAuD7CQKjpD5o2O/Aljz6s3W0sIkxg3U63aq+Ch3c8JKO9WQnG5+IkgZ
         sqmWVGmYEN4zC+TXwlfCpNPXytgMtXZaKVmx+xgjiQv8yRIZ15bfVbwyZli2CRtFd1rs
         8QylsKiDChLpoWpkpmc66/O+ywCUSiEemr+i8IiQTiN+husZB2kbV78tV43Emgbih7NT
         AXXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=Z6JyIRyQjmSUtkW88pmcBmgAMAjTfjaBSIAjcjL9OVw=;
        b=k0tj8Bi8boMzyA5ZNft1kKzLEw0NSbZ4CAG/kRVg/WWHeJXgaMBWmz2b7n0MoKgWqE
         YqzglWGbvB3fBwlWGwREeDAgvl9gAT8j60DsVjXFJ6h62QZBjQEqj57Y/muxs7JATzpn
         WlYC8B79vWvztytx6C+epsDs8PITuxGAJD/nNRyaXddjDArcSGy3HhJclqyhytkBM0Ab
         57NxqzWqM80tBJuEqTQ6l8sWhn21kl9OfSn1KBHDmO1u4bLTdOwu75dU3nDOCN8eqngw
         rHHJ4hc45RK+rFFqfr9UfxDC+2lOhXirkw1L9j5d9Hsc4/JpbtmguTzRnsjhK0xu8MwQ
         lxcA==
X-Gm-Message-State: AOAM531blkYx8e/8fK/oC74asdgtceiPxzaHAvj7rXlZ9gf55RHXrP6D
        YWm75kziZ4t5RyycaJ5hdcK7xA==
X-Google-Smtp-Source: ABdhPJxPM3kI13wFwt3A6IcMRrK7MK6qxv6UEHqOpofmJc3dylmW24GXvKuHRZ7VaPAAsLhhSBWpDA==
X-Received: by 2002:a5d:4ec6:0:b0:1f0:5929:7f53 with SMTP id s6-20020a5d4ec6000000b001f059297f53mr950008wrv.400.1646294957944;
        Thu, 03 Mar 2022 00:09:17 -0800 (PST)
Received: from ?IPV6:2001:861:44c0:66c0:37d4:6d61:9015:27a5? ([2001:861:44c0:66c0:37d4:6d61:9015:27a5])
        by smtp.gmail.com with ESMTPSA id c4-20020adfef44000000b001ef93c7bbb8sm1277168wrp.30.2022.03.03.00.09.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 00:09:17 -0800 (PST)
Message-ID: <3c1dc535-37f5-89e0-4a75-a4b7d1cd1721@baylibre.com>
Date:   Thu, 3 Mar 2022 09:09:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V3] tty: serial: meson: Fix the compile link error
 reported by kernel test robot
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Yu Tu <yu.tu@amlogic.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20220228135530.6918-1-yu.tu@amlogic.com>
 <29b34655-f820-39c9-4363-878481cd3f63@baylibre.com>
 <Yh087tJhakKHs88e@kroah.com>
 <8747c5c6-a129-3a26-8ebb-9e21a18236ec@baylibre.com>
 <Yh6KzOU4xsSB0lRf@kroah.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <Yh6KzOU4xsSB0lRf@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 01/03/2022 22:06, Greg Kroah-Hartman wrote:
> On Tue, Mar 01, 2022 at 08:23:26AM +0100, Neil Armstrong wrote:
>> Hi Greg,
>>
>> Le 28/02/2022 à 22:21, Greg Kroah-Hartman a écrit :
>>> On Mon, Feb 28, 2022 at 03:13:48PM +0100, Neil Armstrong wrote:
>>>> Hi,
>>>>
>>>> On 28/02/2022 14:55, Yu Tu wrote:
>>>>> Describes the calculation of the UART baud rate clock using a clock
>>>>> frame. Forgot to add in Kconfig kernel test Robot compilation error
>>>>> due to COMMON_CLK dependency.
>>>>>
>>>>> Fixes: ("tty: serial:meson: Describes the calculation of the UART baud rate clock using a clock frame“)
>>>>
>>>> As I already replied on V2 of this patch, you're invited to apply these fixes directly
>>>> on the next version of your "Use CCF to describe the UART baud rate clock" patchset
>>>> and not as a separate patch.
>>>
>>> No, this is broken in linux-next now as the path listed here is in my
>>> tree right now.
>>
>> Oh, I wasn't aware you took this patchset.
>>
>>>
>>> I need a fix for it, or I can revert the original.
>>
>> Please revert the whole patchset, it's not ready yet, neither fully reviewed ands buggy
>> on old SoCs.
> 
> Yes, will go do so now, thanks for letting me know and sorry about all
> of this.

Thanks, we'll make sure it won't happen again and will work toawrds a working solution

Neil

> 
> greg k-h

