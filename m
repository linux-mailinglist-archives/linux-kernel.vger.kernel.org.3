Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFB958DF9C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 21:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbiHITCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 15:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348684AbiHITC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 15:02:27 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E68C69
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 11:35:13 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id v14so3843854qkf.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 11:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=k1Lt5id3T06F1YwJtAYxhzPmLo8QV3Ba3OExNOeJU6M=;
        b=YyaouVoHToM0Y2Yn9tCzpLug8w/elHQ5S9CvHuxwM7JFh1A9NSPZVNqisplKyNgr1f
         1RQLmVN9dAO5+PWJHDsk2c28R0BT5xveGRBgra7PIdQ2Hi6Ayc/qC3SsBYHkgIvYKjCz
         VuXJhaPhwoQG2bk+fioohJaSvThocxZ4nfCAMkeUMATHFU7DLvGjUYDQ2T79LUjjdzZ3
         WpaxcXbsZ1mZWQCVyABlVNE1B5ECskoB8JsHmjThUg+JbEpyF7ItCOboi1dXuEqHfw5U
         XPy7EDI1c1BcNo/6diKdRyKr87Txp8mhcIMeHQuHNTMrO/r+v8/XtvyVrewHK936V0Lf
         ibrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=k1Lt5id3T06F1YwJtAYxhzPmLo8QV3Ba3OExNOeJU6M=;
        b=k6HiWCrDcoj/XSclIv/pNsAKk/ecGzCUhKcDQgsSIJdbqtv9CMP6elKKtDVV0Ltogm
         0Nmn4NxmfNYkA/YQiFfyFzzvCxEoIlTGuR/n3d7NXizD/Ocr1zI4Gsm61mA2AVYAKDUA
         2kMZCDlJFV3I0Tfzi7oFtlAPOXAHSlTgojjrhSkyjZMVRsYB66srpHsAkWfNvsoEgICB
         bYsqzehcGu+uuKEO57+nfJlDdl4eIGkHBColUpg6Svwg+lC/4zM4umx2fGiulJyIuI6v
         iHxq19KUNElV43CNNwPdDjFAQogUCiaMfVuyfQjmg6f0Kdt/0g58dtvJ+dFl4IcjCBLS
         fKew==
X-Gm-Message-State: ACgBeo1cz+/Iw86LaMO6qefdf/RigZRkkSgObh4rl3cDid5XjQqu1F59
        lgTugX98oZY1SCeg7kBLDT4=
X-Google-Smtp-Source: AA6agR7hZgiA45OYCk65SvAtODzF8TirpzXIIXSSM3gK0fhDuouaG6BemCHZzMmKvXukFg5/qnakhA==
X-Received: by 2002:a05:620a:bd4:b0:6b9:fdf:1bb5 with SMTP id s20-20020a05620a0bd400b006b90fdf1bb5mr15899033qki.447.1660070112937;
        Tue, 09 Aug 2022 11:35:12 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d19-20020a05620a241300b006a6ab259261sm13269247qkn.29.2022.08.09.11.35.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 11:35:11 -0700 (PDT)
Message-ID: <c5edaa34-6f85-c6a8-84f5-75413dc864ea@gmail.com>
Date:   Tue, 9 Aug 2022 11:35:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: Invalid pstore_blk use?
Content-Language: en-US
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     Kees Cook <keescook@chromium.org>,
        WeiXiong Liao <gmpy.liaowx@gmail.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>
References: <e97bc607-a913-dbbd-1965-b60d55d956b8@gmail.com>
In-Reply-To: <e97bc607-a913-dbbd-1965-b60d55d956b8@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees, WeiXiong,

On 7/14/22 20:49, Florian Fainelli wrote:
> Hi Kees, WeiXiong,
> 
> I am trying to make use of pstore_blk which is BTW exactly what I had 
> been looking for to store panic/console logs onto an eMMC partition.
> 
> Using the 5.10 kernel plus:
> 
> 7e2e92e9861b Revert "mark pstore-blk as broken"
> 01c28bc8f389 pstore/blk: Use the normal block device I/O path
> 2a7507999638 pstore/blk: remove {un,}register_pstore_blk
> fef0b337cd25 pstore/zone: cap the maximum device size
> 
> or the android13-5.15 (at Merge 5.15.40 into android13-5.15) kernel with 
> no changes and using:
> 
> mount -t pstore pstore /sys/fs/pstore
> modprobe pstore_blk blkdev=/dev/mmcblk1p9 best_effort=yes
> 
> upon triggering a crash with:
> 
> echo c > /proc/sysrq-trigger
> 
> and rebooting and remounting the pstore filesystem and loading 
> pstore_blk, I only have:
> 
> # ls /sys/fs/pstore/
> console-pstore_blk-0
> 
> which contains the entire console log up to, but excluding the crash. 
> The kernel does show that pstore_blk was used for all 3 types of kmsg, 
> pmsg and console:
> 
> [   28.649514] pstore_zone: capping size to 128MiB
> [   28.712894] pstore_zone: registered pstore_blk as backend for 
> kmsg(Oops) pmsg console
> [   28.721145] pstore: Using crash dump compression: deflate
> [   28.906253] printk: console [pstore_blk-1] enabled
> [   28.911229] pstore: Registered pstore_blk as persistent store backend
> [   28.917735] pstore_blk: attached pstore_blk:/dev/mmcblk1p9 
> (134217728) (no dedicated panic_write!)
> 
> there is no automatic reboot upon panic, so I just tend to reboot after 
> 2-3 seconds manually. The kernel is configured with the default 
> CONFIG_PSTORE_* options.
> 
> Is the observed behavior a limitation of the best_effort mode? If so, do 
> we have any plans to implementing a non-best effort mode for eMMC devices?

Any feedback on my email? I did try to get kernel panics to be dumped 
out to a dedicated /dev/mtdblock* partition for which there ought to be 
support for mtd->panic_write, but it still did not work any better. Is 
there something obvious that I am missing which prevents kernel panics 
from being logged?

Thank you!
-- 
Florian
