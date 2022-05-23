Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6BD7531BA7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239572AbiEWRHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 13:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239475AbiEWRGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 13:06:11 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5788B12623
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 10:06:07 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id er5so19909524edb.12
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 10:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=YrY6mURHinjqWwitegOe1ZXjhF0i1u/4+qbA+8XPd74=;
        b=GijRvlPm8XonYS9Fbp6rhrU21pU3I+fLZ2KjP3FKCwZduOvrl3jK42JkV/R0dbHM9j
         us2e5hXsLE2CXiyrccPgtu5cTS1KFPZ61ruva8Psu50BKW7PTWjJICNqQvIjhayJ2n0q
         nW15/AEptBLW17E9sxHVfyfLNX3g0fHZB65Eun2q2rtEqx68UvfBO87bQfkeHdcd2IaK
         rV4xEXmhoy4wbG67VNExfTqEMm0de/dhoUVmL27CPUZ1YcFZcbaXSwSlLFoLy8z7MxbZ
         aLVLaFuqtpNfPmE6KYrNB1W4RJ/zqjJ/lPuc6NJ9MT6zI8Z8Xm0MF/TIYrMWqP78cYYR
         dGtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=YrY6mURHinjqWwitegOe1ZXjhF0i1u/4+qbA+8XPd74=;
        b=CypKUCMVwsPi7xMB6g/r94wSrfh+oyOMtAKiLZLWmXYJo5A0+kXbei60VcaJybccho
         +Op/uKIzIJFeOmmPMUxZkyqpsqUyIJYK/jBINU+A17yqTuqnkoe0+DCvyUJhes6qIo3b
         FHz1tyLOYGXo8uH2XvPI43jUP16LHV1L39IBiM9JHM5FoQ8Xe3EiJXFDa1eBtL4qd3A6
         07yvGItnBelVcAv5InJ1hkVj37GHFS5mZQuRg+YCOWY5t/YIhAr1L+mU5SWw/IcDTvne
         lqk6v249xtbq9BotaLBUnWqBrDgvKj4XBbbfy07CKior5bs+4GxIV1Wt1ZJdqJ6S5K5t
         s6dQ==
X-Gm-Message-State: AOAM533Taa58wK8s38vbXyY8Z5cxO+FqJeDAL5T2e114ca3mnhpsSuCl
        /a4jlezq/NbHLBhdkVn2ySYyQ5on4bI=
X-Google-Smtp-Source: ABdhPJyH8akOgZUtv9ecBlp4mP28urBRg3c0ruLX+fy6Vpo0h+E4PiDCLRPIKgQ1lO5PefDMAv2MKg==
X-Received: by 2002:aa7:cb55:0:b0:42a:ac67:892f with SMTP id w21-20020aa7cb55000000b0042aac67892fmr24663651edt.215.1653325565760;
        Mon, 23 May 2022 10:06:05 -0700 (PDT)
Received: from [93.172.10.244] (93-172-10-244.bb.netvision.net.il. [93.172.10.244])
        by smtp.gmail.com with ESMTPSA id f8-20020a1709063f4800b006f4c82c2b12sm6406673ejj.19.2022.05.23.10.06.04
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 23 May 2022 10:06:05 -0700 (PDT)
Message-ID: <628BBEEB.9010306@gmail.com>
Date:   Mon, 23 May 2022 20:05:47 +0300
From:   Eli Billauer <eli.billauer@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.12) Gecko/20100907 Fedora/3.0.7-1.fc12 Thunderbird/3.0.7
MIME-Version: 1.0
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     Zheyu Ma <zheyuma97@gmail.com>, arnd@arndb.de,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] char: xillybus: Check endpoint type before allocing
References: <Yn9XwHxWsLIJXlHu@kroah.com> <20220514114819.2773691-1-zheyuma97@gmail.com> <Yn+va5fTsuaFTxVR@kroah.com> <CAMhUBj=RMJwn2K+rQC9rQ=QEe5QkiJ29rMd8KzEC8B7vtXo+ug@mail.gmail.com> <Yocp+WZ0On9/wObu@kroah.com> <CAMhUBj=J5-V_D_kucpiWz6ZdOSSR1N9nRXQxOKgmwRA+LxW17Q@mail.gmail.com> <YouxHY48daZt7J/O@kroah.com>
In-Reply-To: <YouxHY48daZt7J/O@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/05/22 19:06, Greg KH wrote:
> If the device does not have the EXACT USB endpoints that you are
> expecting (size, address, direction, type, etc.) at probe time reject
> the device.
>    
This is probably a good time to add some information about XillyUSB.

All XillyUSB devices have EP 1 IN and EP 1 OUT as bulk endpoints.

On top of that, they *may* have up to 14 additional bulk OUT endpoints, 
having the addresses EP 2 OUT to EP 15 OUT. The population of endpoint 
addresses is not necessarily continuous. Any set of OUT endpoint 
addresses is allowed. The driver doesn't know which of these endpoints 
are available initially.

Rather, it works like this: The driver uses the EP 1 IN and OUT 
endpoints to query the device for a data structure, which contains 
information on the device's communication channels. The driver sets up 
device files accordingly, and it also gets informed on which bulk OUT 
endpoints are present.

For what it's worth, I think it's fairly safe to assume that if a device 
returns a legal data structure (which passes a CRC test), it's a 
XillyUSB device. Either way, it's impossible to verify that all of the 
device's bulk OUT endpoints are correct before obtaining the data 
structure from the device. The fact that each device has a different set 
of communication channels, and that the driver learns about them in 
run-time is the whole trick with Xillybus and XillyUSB.

And just in case you wonder why there's only one bulk IN endpoint: All 
inbound communication, control as well as data, is multiplexed into this 
single endpoint. That's in order to allow the device better control on 
which communication channel is serviced at any time, with a few 
microseconds' granularity. The same trick is unfortunately infeasible in 
the other direction.

I don't have any particular view on how the device should be validated, 
but I thought this information would be helpful.

Thanks,
    Eli
