Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18484575A13
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 05:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233025AbiGODtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 23:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiGODtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 23:49:52 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C47A774AB
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 20:49:51 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id b2so2160451plx.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 20:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:from
         :subject:cc:content-transfer-encoding;
        bh=ORA9GdicIywBi4YCfz3SMVjvqA0iE2u3mJ9xZsRJZtk=;
        b=TkHg0cEW2vLOa9d4C/qpZVII5HOq8hRig5mZRZwrq5bf+xDcm0r7XIz0vUfiQDnn2n
         xd7+g0TCfzvPFqXAQvahOSMDxvo+Ij82+pzrGYTY6Qvwh3qqlURrbM1zryr6Pl8EmL3S
         MWG0vaCAm4LVT7Xf5wBJDra/InEU6CU8wPR5lovpmmeXo5CKWvJCNFLx2mWMsh/fXKYq
         WiAEsaTenIa1vYgLrjevRtUIhVDq2rJPKyZrUAduQTDn9BR8KRVkysFgl+L8tAFBHzzd
         IGiQEAG/BWsBTMPRCEBItyxI1n5gvzifphYp9okud+Td4PlhwnMWwt68Zjj+VWiMrzCj
         3lUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:from:subject:cc:content-transfer-encoding;
        bh=ORA9GdicIywBi4YCfz3SMVjvqA0iE2u3mJ9xZsRJZtk=;
        b=w9okYdxn+blzFIYoML3YfaJwWjpc6ZADM4I1YrQXu9bCxt7aiI8X1B1EGkZ58sdGPm
         Khe1so1mHhRB/Wyt6HGaobwwVPh0t8IZrfcteV0iH8Pn4/+wDiZRGg4cdAImDCd7IZ2P
         51Iz9K/zv/G6LDM4QCo4So8wUJVDiIk8MqCJsHSB+woT1InQw36OtZCyTGsa5N+njBnc
         l4YnxjbSFK2Sc9pyjN+8LdfQMIIHrofcxRAU+61zoH395ZPxfySqCQ7yjeBIcMIog6f7
         lMMJADR4iqCs/uQ4Okki01a3shD/IHxmRNx/rXSSrR1pkUfu+ZEuOAZODBVY464DNTIZ
         8NlQ==
X-Gm-Message-State: AJIora/pfSqpQtC32PJpZopACbclPIvAcW4G8y2ekhUXd4XLLRNzPNmJ
        +GI75mXChg7dUva6QpRGUX1hAAg26xk=
X-Google-Smtp-Source: AGRyM1vXOnV4OchEJZGXDWPsID+khE2cDwFRMnFv2DhefFDMnEvC6X1Y1oK6hFnxeq/jkQpwrW+qDg==
X-Received: by 2002:a17:90a:f8d1:b0:1ef:8795:c7e with SMTP id l17-20020a17090af8d100b001ef87950c7emr13433844pjd.74.1657856990389;
        Thu, 14 Jul 2022 20:49:50 -0700 (PDT)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id x9-20020a170902b40900b0016a1e2d148csm2264910plr.32.2022.07.14.20.49.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 20:49:50 -0700 (PDT)
Message-ID: <e97bc607-a913-dbbd-1965-b60d55d956b8@gmail.com>
Date:   Thu, 14 Jul 2022 20:49:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        WeiXiong Liao <gmpy.liaowx@gmail.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Subject: Invalid pstore_blk use?
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees, WeiXiong,

I am trying to make use of pstore_blk which is BTW exactly what I had 
been looking for to store panic/console logs onto an eMMC partition.

Using the 5.10 kernel plus:

7e2e92e9861b Revert "mark pstore-blk as broken"
01c28bc8f389 pstore/blk: Use the normal block device I/O path
2a7507999638 pstore/blk: remove {un,}register_pstore_blk
fef0b337cd25 pstore/zone: cap the maximum device size

or the android13-5.15 (at Merge 5.15.40 into android13-5.15) kernel with 
no changes and using:

mount -t pstore pstore /sys/fs/pstore
modprobe pstore_blk blkdev=/dev/mmcblk1p9 best_effort=yes

upon triggering a crash with:

echo c > /proc/sysrq-trigger

and rebooting and remounting the pstore filesystem and loading 
pstore_blk, I only have:

# ls /sys/fs/pstore/
console-pstore_blk-0

which contains the entire console log up to, but excluding the crash. 
The kernel does show that pstore_blk was used for all 3 types of kmsg, 
pmsg and console:

[   28.649514] pstore_zone: capping size to 128MiB
[   28.712894] pstore_zone: registered pstore_blk as backend for 
kmsg(Oops) pmsg console
[   28.721145] pstore: Using crash dump compression: deflate
[   28.906253] printk: console [pstore_blk-1] enabled
[   28.911229] pstore: Registered pstore_blk as persistent store backend
[   28.917735] pstore_blk: attached pstore_blk:/dev/mmcblk1p9 
(134217728) (no dedicated panic_write!)

there is no automatic reboot upon panic, so I just tend to reboot after 
2-3 seconds manually. The kernel is configured with the default 
CONFIG_PSTORE_* options.

Is the observed behavior a limitation of the best_effort mode? If so, do 
we have any plans to implementing a non-best effort mode for eMMC devices?

Thanks!
-- 
Florian
