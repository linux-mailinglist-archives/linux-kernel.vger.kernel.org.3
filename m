Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A865A3C04
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 07:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbiH1FcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 01:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiH1FcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 01:32:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A1B44569;
        Sat, 27 Aug 2022 22:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=apY3Uy4g7u5jWYvr/Eu34sq+vcsKX0NmxpVfE1iBAy0=; b=ndfPy9KPoY+bett04r1fx880KY
        DoqEL3ZDMOmsUbYvGrmnSXFQkve+QTZkpDIR7dk6usD0k3JPUbvBCoCy+CoQSXPIB9iWq5JrwV0hT
        KivGpJKizmxQprKWlOvlpJ7mfPkIW0p5QsgAkCOs4ebFZqeh/4XOAD2fxEYuwyIC13m9xTskwRteC
        nfh8gmy/Me97pcrAFK73KKqJC+qV4oVc8vyttc4h2e7kP7hBA2vJkmjXcbrAsAP0C7QaJZTI1+XR7
        iKzKIR1+wFxqSqkdhPTxtfWqGYsJ0Tm9na2jGeyEhJscRN+TtPvjOAyhVITdo/xI2HrmZw98fnZnQ
        vml+IBhA==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oSAts-00Djqn-Qd; Sun, 28 Aug 2022 05:32:00 +0000
Message-ID: <637e5934-7dd2-c77e-748d-f8445acff29e@infradead.org>
Date:   Sat, 27 Aug 2022 22:31:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] Documentation: fb: udlfb: clean up text and formatting
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Bernie Thompson <bernie@plugable.com>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Helge Deller <deller@gmx.de>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
References: <20220827193925.19612-1-rdunlap@infradead.org>
 <6cb3b3fc-30d4-0396-fc95-8182ca72fb1e@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <6cb3b3fc-30d4-0396-fc95-8182ca72fb1e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/27/22 18:51, Bagas Sanjaya wrote:
> On 8/28/22 02:39, Randy Dunlap wrote:
>> -From the command line, pass options to modprobe
>> -modprobe udlfb fb_defio=0 console=1 shadow=1
>> +From the command line, pass options to modprobe::
>>  
>> -Or modify options on the fly at /sys/module/udlfb/parameters directory via
>> -sudo nano fb_defio
>> -change the parameter in place, and save the file.
>> +  modprobe udlfb fb_defio=0 console=1 shadow=1
>> +
>> +Or modify options on the fly at /sys/module/udlfb/parameters directory via::
>> +
>> +  sudo nano fb_defio
>> +  change the parameter in place, and save the file.
>>  
> 
> Better say "Or change the options on the fly by editing
> /sys/module/udlfb/parameters/fb_defio."
> 
>>  Unplug/replug USB device to apply with new settings
>>  
>> -Or for permanent option, create file like /etc/modprobe.d/udlfb.conf with text
>> -options udlfb fb_defio=0 console=1 shadow=1
>> +Or for permanent options, create a file like /etc/modprobe.d/udlfb.conf
>> +with text::
>> +
>> +  options udlfb fb_defio=0 console=1 shadow=1
> 
> Maybe we can say "Or to apply options permanently, create modprobe configuration
> like /etc/modprobe.d/udlfb.conf with::"

Thanks, I'll send a v2.

-- 
~Randy
