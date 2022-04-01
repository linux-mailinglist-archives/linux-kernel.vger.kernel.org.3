Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026D24EF923
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 19:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350544AbiDARqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 13:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345141AbiDARqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 13:46:18 -0400
Received: from gateway34.websitewelcome.com (gateway34.websitewelcome.com [192.185.148.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0184164BEB
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 10:44:28 -0700 (PDT)
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 855A3512A54
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 12:44:28 -0500 (CDT)
Received: from 162-215-252-75.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id aLK0nhUc4RnrraLK0no4kn; Fri, 01 Apr 2022 12:44:28 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:Subject:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=R6CCo0Ivq9tj59jKVA48y3vxWF19qfaCGqdqIiS/OJ8=; b=1KBTGtweF9m2/5SMW5VKYht5Ss
        9An8Kj2crLaaTJ124SKAEyHbM/EAE3qyCc/AiT91ccH3mMd3F8/ARzmNz4o8+EFG4WC5GLXtBsuOK
        V3JoQ8VH2jrlIONVtH2zX9tIrlhnLuv73Pn0D0o9fYJRGZ9ahLAd/bE8HvVYyjMlE4vyLqgQcUw+Z
        xgeDScjKk/6Q3H8h2gyWlNgVhct5YP5RwLZiXZkZOq7GDafPHvq66H1eFYtiQLxz7kfyeZnq7CAJ2
        pQtB480N9IAVhtUTfKsSA1curEbvuHujUQS550pfiFuFeJf9k/6xFqf/okNYKREFT/zBwaGV3/kQP
        5HXL9dXA==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:54658)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@roeck-us.net>)
        id 1naLK0-000z9O-5c; Fri, 01 Apr 2022 17:44:28 +0000
Message-ID: <927a54f9-b413-0c71-461d-28ed9d5ece96@roeck-us.net>
Date:   Fri, 1 Apr 2022 10:44:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Helge Deller <deller@gmx.de>
Cc:     James.Bottomley@HansenPartnership.com,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220401154137.GA3745625@roeck-us.net>
 <57e79014-25e6-62d3-27de-64797e43992b@gmx.de>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] parisc: Switch from GENERIC_CPU_DEVICES to
 GENERIC_ARCH_TOPOLOGY
In-Reply-To: <57e79014-25e6-62d3-27de-64797e43992b@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1naLK0-000z9O-5c
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net [108.223.40.66]:54658
X-Source-Auth: linux@roeck-us.net
X-Email-Count: 1
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/1/22 09:47, Helge Deller wrote:
> Hi Günter,
> 
> On 4/1/22 17:41, Guenter Roeck wrote:
>> On Thu, Mar 24, 2022 at 07:46:50PM +0100, Helge Deller wrote:
>>> Switch away from the own cpu topology code to common code which is used
>>> by ARM64 and RISCV. That will allow us to enable CPU hotplug later on.
>>>
>>> Signed-off-by: Helge Deller <deller@gmx.de>
>>
>> This patch results in the following traceback when
>> booting generic-32bit_defconfig - SMP in qemu.
> 
> That's strange, because I just built this generic-32bit_defconfig myself and
> it boots up nicely in qemu for me. The only thing missing is CONFIG_CGROUPS=y so that
> systemd can start.
> 

Did you disable SMP (that is what - SMP was supposed to mean) ?
Also, note that the system does boot fine, it just spits out the warning.

> I'm not sure how I can debug/reproduce your bug report...
> 

I see the problem with generic-32bit_defconfig if I disable SMP.
I normally have some other (debug) options enabled, but I confirmed
that it is sufficient to disable SMP. The actual command line should
not matter, but here is one of mine as example (for booting from
initrd). I currently use qemu v6.2.

qemu-system-hppa -kernel vmlinux \
     -no-reboot -initrd rootfs.cpio \
     -device e1000,netdev=net0 -netdev user,id=net0 \
     -append "panic=-1 slub_debug=FZPUA rdinit=/sbin/init console=ttyS0,115200" \
     -nographic -monitor null

Guenter
