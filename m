Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 195FE49C874
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 12:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240580AbiAZLSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 06:18:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:40629 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233442AbiAZLSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 06:18:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643195917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=srD1l04gPQ84q1XF/RWjCuwwGgitsqKSn4fv06ciBhg=;
        b=KRZkCB6lUGM3lT4GWR5ZL/vHnBoJ5E95MYTA49kBaglKL+IkSwDyMyKizunrVddbgVEPcy
        3lhjoCg+LbUW+khQfRg02IbCEnlG8vLA54n4KWgt8WFrzxEy1ruMFnObOT7DTrM4kUXIFR
        xUjQCIArYCTW3F/A8k6jquzH2jI1uSI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-21-wpn-_CXVOy6cEEuIoJOa1A-1; Wed, 26 Jan 2022 06:18:33 -0500
X-MC-Unique: wpn-_CXVOy6cEEuIoJOa1A-1
Received: by mail-wr1-f71.google.com with SMTP id c10-20020adfa30a000000b001d79c73b64bso4169801wrb.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 03:18:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=srD1l04gPQ84q1XF/RWjCuwwGgitsqKSn4fv06ciBhg=;
        b=ohOd1xgfmt9ovILfihNIgcls2ApUFJccuMjlYijPzrBJvbdpAS38Jlm4wxE35+1Hy6
         aJ3zFty84QcHLpnqZbncQbMz6nKnr3+aIBaUTDr3g4W0qRlndxGZ3MAZAFZCIFLydbx2
         bTcs7nvpo9dglTCDKbuXf9S4bnOgnioEoJmsGHBHxic+kq4QpMqO0dGmBYYS6CdQ9GXY
         XEfdt1gMLuVSKqqcb7R+1EhUmyM05ES0KCAr33TMiSjNbnTWPab+6/YZPMXNq5Z5UdEY
         ZyvHFAvWBG7hvYpn8iIF+shSBj4XolzAOb1Ml2cDoylCCEsWppPbQGKmfEgOoB1PbsMN
         UE6g==
X-Gm-Message-State: AOAM532MlKtExX/utU5fciLZciWdCRbzaUB1J4OSmAcTo79ghEnziTGd
        0XHsK94gSOL1AgsnArBy/oM02sTlvSyUOViy8scgZDqhnR7vuewzwlw/VVFoL40ybPCpzmckxqt
        T5mXdPdav4EgNctQiiONH/o/W
X-Received: by 2002:a05:6000:156d:: with SMTP id 13mr1586783wrz.66.1643195912596;
        Wed, 26 Jan 2022 03:18:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyvCzW4Jn73KJItw350M3F/f6JTN+7T8OA7kDxsaF2hqvwBivMpTbBXPxCTm3unY1Mql6OAYg==
X-Received: by 2002:a05:6000:156d:: with SMTP id 13mr1586760wrz.66.1643195912374;
        Wed, 26 Jan 2022 03:18:32 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id i17sm19005103wru.107.2022.01.26.03.18.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 03:18:32 -0800 (PST)
Message-ID: <b13c0634-e766-74db-ab1f-672f5d0c04d6@redhat.com>
Date:   Wed, 26 Jan 2022 12:18:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v1 0/4] fbtft: Unorphan the driver for maintenance
Content-Language: en-US
To:     Helge Deller <deller@gmx.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Andy Shevchenko <andy@kernel.org>, linux-fbdev@vger.kernel.org,
        Michael Hennerich <michael.hennerich@analog.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Phillip Potter <phil@philpotter.co.uk>,
        Carlis <zhangxuezhi1@yulong.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Heiner Kallweit <hkallweit1@gmail.com>
References: <20220125202118.63362-1-andriy.shevchenko@linux.intel.com>
 <991e988b-7225-881b-a59a-33c3eae044be@suse.de>
 <CAHp75Vc2cjHkJwNSiJ-HSWBG=DYy68uvD7QQzNdRp3mQxoY1nw@mail.gmail.com>
 <3877516e-3db3-f732-b44f-7fe12b175226@gmx.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <3877516e-3db3-f732-b44f-7fe12b175226@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/26/22 11:59, Helge Deller wrote:
> On 1/26/22 11:02, Andy Shevchenko wrote:

[snip]

>> P.S. For the record, I will personally NAK any attempts to remove that
>> driver from the kernel. And this is another point why it's better not
>> to be under the staging.
> 
> I agree. Same as for me to NAK the disabling of fbcon's acceleration
> features or even attempting to remove fbdev altogether (unless all
> relevant drivers are ported to DRM).
> 

But that will never happen if we keep moving the goal post.

At some point new fbdev drivers should not be added anymore, otherwise
the number of existing drivers that need conversion will keep growing.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

