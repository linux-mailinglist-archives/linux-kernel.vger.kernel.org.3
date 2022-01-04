Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9D0484325
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 15:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234051AbiADOOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 09:14:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233807AbiADOOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 09:14:53 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF996C061761;
        Tue,  4 Jan 2022 06:14:52 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id by39so60872992ljb.2;
        Tue, 04 Jan 2022 06:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=j+KR6yo0w4DU0VDvp5TpT7prkSMR0PFKueK7Af1t9HE=;
        b=b+m+I2UnzuJQOE/3/rp2Z70kjc2h4wsah6JeJ9AbLMEHUMT2IrKvrOu0TZA7wUZEBV
         EkevQokctBRj4sp+MFLFheu45uGdM/rGZWmvzugt2mtt5ITiWXX4Ye/9eRnpJOYDddng
         zeVvnTKUxMVA7B6htKhDkLnEQgw86fXtpxsE6qgWdRYyNz+iyt9NlSbbyIMYRNJJitVB
         frKvvEvKT31eDHOIaEx0crjwqX0k+tZCSXlMZcYVqc2YzUVxUC5Q86Wzox4ujyeaioNn
         az8C/z0Hozuw1ns2ge4vobFGiN+7Lq7ft3DRBk0lleRi4P06GLkHIKtnLAgZjnmBKcfP
         h0xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=j+KR6yo0w4DU0VDvp5TpT7prkSMR0PFKueK7Af1t9HE=;
        b=W8PsSr2of3lZzK7Voo88LWWfzZSIdedyyfzhHidwXN+PFjPA4dBi0DahrpkTGrNrQN
         hi1VkyxHEC8jel3EclnrdjriIR8EhFi3DkR/4Dwg8k1YkeuvJAb1uyp6FrDc8x0kz/ER
         6+yJHf6RaH01M6A4lID90El02l9y6SAuk3TSnBKk3f583ti1YRlXcAeTfs5V5H4e73mF
         7eJgGIyaUfJtS+iBcOpPYGC5mjco9wFPjDCfE3icDSVxMgwZ+KPiFmCBzeN8EiPe0yWV
         C0xJYLURu4ByvdhZONWSmTEAtiWGMUvF/s3u0Pyc/4eHcWNUArE8kdhktP0wkaZUDCc+
         nKSw==
X-Gm-Message-State: AOAM5314IMdcwhvi0gDPDcahrO+q2FUmlOXmJgjDIiqDyHp85nLu47Ll
        StbanlEWoAUWX17/rEd+bYY=
X-Google-Smtp-Source: ABdhPJylDt39BDuHM0Gi69h6JEKY1zQcf4T07X1J4U2kdHArDnWh5RDm/VhNV/dibeKJC7D+BtiN1g==
X-Received: by 2002:a2e:854b:: with SMTP id u11mr31833344ljj.390.1641305690964;
        Tue, 04 Jan 2022 06:14:50 -0800 (PST)
Received: from [192.168.1.11] ([94.103.235.38])
        by smtp.gmail.com with ESMTPSA id c37sm3814430lfv.0.2022.01.04.06.14.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jan 2022 06:14:50 -0800 (PST)
Message-ID: <6338e7cd-80cb-11af-e3c0-edd740bb9e49@gmail.com>
Date:   Tue, 4 Jan 2022 17:14:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: INFO: trying to register non-static key in hci_uart_tx_wakeup
Content-Language: en-US
To:     kvartet <xyru1999@gmail.com>, marcel@holtmann.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Cc:     sunhao.th@gmail.com
References: <CAFkrUsjA1qai+1ysWS_LEUYcMGo+ZRF3v743q6k9e4roF6PWZw@mail.gmail.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <CAFkrUsjA1qai+1ysWS_LEUYcMGo+ZRF3v743q6k9e4roF6PWZw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/22 11:49, kvartet wrote:
> Hello,
> 
> When using Syzkaller to fuzz the latest Linux kernel, the following
> crash was triggered.
> 
> HEAD commit: a7904a538933 Linux 5.16-rc6
> git tree: upstream
> console output: https://paste.ubuntu.com/p/Bfpr8Gxtd4/plain/
> kernel config: https://paste.ubuntu.com/p/FDDNHDxtwz/plain/
> 

Btw, can you, please, use plain pastbin or something else, that does not 
require a registration? I think, most people here do not have ubuntu one 
account and don't want to have one. I saw people using google drive for 
these kind of things


Thanks for your reports!



With regards,
Pavel Skripkin
