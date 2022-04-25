Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 403B350E339
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 16:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242377AbiDYOfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 10:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234017AbiDYOfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 10:35:45 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B1503631D;
        Mon, 25 Apr 2022 07:32:41 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id k2so712222wrd.5;
        Mon, 25 Apr 2022 07:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:references:in-reply-to:content-transfer-encoding;
        bh=Q1Q4M+Hf51detY+GO1HpX2r9kXTkVcmJcJZz9o+0qHE=;
        b=gAXgTnBQR4jH5J4ieiWpfbyZO8aC+JkQJM7cniJQuvd6BbaY6pxi7JYdiDwAoc/9m3
         yZ0P8wBOkH1sa1KW94cDaJLOS6bUitDjFygEVp5Ao7TyOsA2+uVusr9LwdZGQH9Qi5iR
         LO6xtkUGFvoMunhzqHzh4coEUgA2g8D2KM9TdENDVSzR29m6ymjtepv+9M48bHqFAc0p
         X6evzdBgI5lAbnMKnBibAlBj5BdUYoU6EGvDmSXo8bDIEX7FR0Q14i2r1W1OjZ0d6CCR
         E0OakJAfXrMovjhDH6+3R5zqkUfjTuJ3oC+JEZUTAXmV0XjrS+UcFHSRYhm+5QCwlLe4
         /5YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:references:in-reply-to
         :content-transfer-encoding;
        bh=Q1Q4M+Hf51detY+GO1HpX2r9kXTkVcmJcJZz9o+0qHE=;
        b=vHc9ZGnGdmrh4gRCjGjg0D6WWFWA9oUImfWYiefCZY+2LxGtkehGawjEUTBVM5+bYk
         aw4OLEq1go8nuNvCBWmWLGmw+R7jV+k3F/8HRDya18GaL4FopfBBqr/T7JJ5f7+UBL6i
         EeoEdYmFZg4LoACrfT2sRo/XBGTf14Y9FaVaJVTeoZ8/ilpkmcOWGhPczP6Bak65oMBq
         Ji1d5//GblJXaUEBJ0tTIPX5R2IrztiFrIBeZvRYClX9/rLV7BvcLf/kggY55+kjwYTj
         H/nlxGFsrcRnu9Po9zqbTPZxHq203NebAjcoydmXmjWupka+qz299txoAinERrMM+kHi
         7yXw==
X-Gm-Message-State: AOAM531xY7SOW4E0wldTJmQKCjzUT2jNr2GpQD97gQ11ylv2+453cUiI
        kfYJtylyL4rI7T+pBQcVWNIC7CtPsbU=
X-Google-Smtp-Source: ABdhPJxAsLAen1VbIvEwhQ7glsbGoSqgAnqkC5JQdgng/fsjHF4mt5iSeWI6AKwOrMXfdQpweyreaA==
X-Received: by 2002:a05:6000:799:b0:207:a326:8e with SMTP id bu25-20020a056000079900b00207a326008emr14707243wrb.516.1650897159869;
        Mon, 25 Apr 2022 07:32:39 -0700 (PDT)
Received: from [192.168.1.10] (4e691f2a.skybroadband.com. [78.105.31.42])
        by smtp.googlemail.com with ESMTPSA id o8-20020a5d6488000000b002051f1028f6sm10259798wri.111.2022.04.25.07.32.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 07:32:37 -0700 (PDT)
Message-ID: <be9e8d7b-0038-91e7-a6c6-e18c3d03e68f@googlemail.com>
Date:   Mon, 25 Apr 2022 15:32:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: Oops in 5.18.0-rc4 when removing module dvb_usb_dtt200u
Content-Language: en-GB
From:   Chris Clayton <chris2553@googlemail.com>
To:     LKML <linux-kernel@vger.kernel.org>, linux-media@vger.kernel.org
References: <45c2dac8-277b-c7f1-bb52-16cf4d82ba5a@googlemail.com>
In-Reply-To: <45c2dac8-277b-c7f1-bb52-16cf4d82ba5a@googlemail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/04/2022 15:03, Chris Clayton wrote:
> As $SUBJECT says, I'm seeing an oops when I remove dvb_usb_dtt200u. The backtrace is as follows:
> 
> Mon Apr 25 13:11:39 2022] usbcore: deregistering interface driver dvb_usb_dtt200u
> [Mon Apr 25 13:11:39 2022] ------------[ cut here ]------------
> [Mon Apr 25 13:11:39 2022] WARNING: CPU: 8 PID: 1774 at kernel/module.c:1094 module_put.part.0+0x45/0x50
> [Mon Apr 25 13:11:39 2022] Modules linked in: dvb_usb_dtt200u(-) rfcomm bnep xt_MASQUERADE iptable_nat nf_nat xt_LOG
> nf_log_syslog xt_limit xt_multiport xt_conntrack iptable_filter ntfs3 wmi_bmof snd_hda_codec_hdmi coretemp hwmon usbhid
> r8169 snd_hda_codec_realtek realtek snd_hda_codec_generic mdio_devres ledtrig_audio x86_pkg_temp_thermal libphy
> snd_hda_intel snd_intel_dspcfg snd_hda_codec i2c_i801 snd_hwdep i2c_smbus snd_hda_core i915 drm_buddy ttm drm_dp_helper
> drm_kms_helper mei_me syscopyarea sysfillrect sysimgblt mei fb_sys_fops intel_lpss_pci intel_lpss uvcvideo
> videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 btusb videobuf2_common wmi btintel nf_conntrack_ftp xt_helper
> nf_conntrack nf_defrag_ipv4 tun
> [Mon Apr 25 13:11:39 2022] CPU: 8 PID: 1774 Comm: modprobe Not tainted 5.18.0-rc4 #928
> [Mon Apr 25 13:11:39 2022] Hardware name: Notebook                         NP50DE_DB                       /NP50DE_DB
>                    , BIOS 1.07.04 02/17/2020
> [Mon Apr 25 13:11:39 2022] RIP: 0010:module_put.part.0+0x45/0x50
> [Mon Apr 25 13:11:39 2022] Code: f0 0f b1 93 c8 02 00 00 75 ef bf 01 00 00 00 e8 61 aa f9 ff 65 8b 05 da 3f 6d 5b 85 c0
> 74 03 5b c3 cc e8 a5 a4 eb ff 5b c3 cc <0f> 0b eb dc 0f 1f 80 00 00 00 00 48 85 ff 74 02 eb a9 c3 cc 0f 1f
> [Mon Apr 25 13:11:39 2022] RSP: 0018:ffffb99700bfbd58 EFLAGS: 00010297
> [Mon Apr 25 13:11:39 2022] RAX: 0000000000000000 RBX: ffffffffc04d5bc0 RCX: 0000000000001000
> [Mon Apr 25 13:11:39 2022] RDX: 00000000ffffffff RSI: ffffffffc04cf740 RDI: 0000000000000001
> [Mon Apr 25 13:11:39 2022] RBP: ffffffffc04cf740 R08: ffffffffc04d5bc0 R09: 0000000000000262
> [Mon Apr 25 13:11:39 2022] R10: ffffffffc04cf740 R11: ffff96eff93db2f5 R12: ffff96efc4bb8c00
> [Mon Apr 25 13:11:39 2022] R13: ffffffffc04cf740 R14: ffff96efc4bbb030 R15: 0000000000000000
> [Mon Apr 25 13:11:39 2022] FS:  00007ff523738b80(0000) GS:ffff96f700600000(0000) knlGS:0000000000000000
> [Mon Apr 25 13:11:39 2022] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [Mon Apr 25 13:11:39 2022] CR2: 00007ff523836d10 CR3: 000000013944a002 CR4: 00000000007706e0
> [Mon Apr 25 13:11:39 2022] PKRU: 55555554
> [Mon Apr 25 13:11:39 2022] Call Trace:
> [Mon Apr 25 13:11:39 2022]  <TASK>
> [Mon Apr 25 13:11:39 2022]  symbol_put_addr+0x2f/0x50
> [Mon Apr 25 13:11:39 2022]  dvb_frontend_put+0x98/0xc0
> [Mon Apr 25 13:11:39 2022]  dvb_usb_adapter_frontend_exit+0x3c/0x60
> [Mon Apr 25 13:11:39 2022]  dvb_usb_device_exit+0x80/0x140
> [Mon Apr 25 13:11:39 2022]  usb_unbind_interface+0x82/0x260
> [Mon Apr 25 13:11:39 2022]  device_release_driver_internal+0x1a2/0x200
> [Mon Apr 25 13:11:39 2022]  driver_detach+0x3f/0x80
> [Mon Apr 25 13:11:39 2022]  bus_remove_driver+0x50/0xd0
> [Mon Apr 25 13:11:39 2022]  usb_deregister+0x63/0xbd
> [Mon Apr 25 13:11:39 2022]  __do_sys_delete_module.constprop.0+0x14f/0x220
> [Mon Apr 25 13:11:39 2022]  ? fpregs_assert_state_consistent+0x1a/0x40
> [Mon Apr 25 13:11:39 2022]  ? exit_to_user_mode_prepare+0x3b/0x110
> [Mon Apr 25 13:11:39 2022]  do_syscall_64+0x38/0x90
> [Mon Apr 25 13:11:39 2022]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [Mon Apr 25 13:11:39 2022] RIP: 0033:0x7ff523866b77
> [Mon Apr 25 13:11:39 2022] Code: 73 01 c3 48 8b 0d f1 72 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00
> 00 0f 1f 44 00 00 b8 b0 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d c1 72 0c 00 f7 d8 64 89 01 48
> [Mon Apr 25 13:11:39 2022] RSP: 002b:00007ffd19bd25a8 EFLAGS: 00000202 ORIG_RAX: 00000000000000b0
> [Mon Apr 25 13:11:39 2022] RAX: ffffffffffffffda RBX: 00000000006cd900 RCX: 00007ff523866b77
> [Mon Apr 25 13:11:39 2022] RDX: 0000000000000000 RSI: 0000000000000800 RDI: 00000000006cd968
> [Mon Apr 25 13:11:39 2022] RBP: 00000000006cd900 R08: 0000000000000000 R09: 0000000000000000
> [Mon Apr 25 13:11:39 2022] R10: 00007ff52376cd10 R11: 0000000000000202 R12: 00000000006cd968
> [Mon Apr 25 13:11:39 2022] R13: 0000000000000000 R14: 0000000000000000 R15: 00000000006cd900
> [Mon Apr 25 13:11:39 2022]  </TASK>
> [Mon Apr 25 13:11:39 2022] ---[ end trace 0000000000000000 ]---
> [Mon Apr 25 13:11:39 2022] dvb-usb: WideView WT-220U PenType Receiver (Typh successfully deinitialized and disconnected.
> 
> I get the same oops in 5.17.4 and 5.15.35 too. I'll try 5.10.112 and 5.4.190 and report back.
> 

Unfortunately, I get the same oops in 5.10.112 and in 5.4.190.

> The oops semems to be in kernel/module.c, but as I can insert and remove other modules, I've copied this report to both
> LMKL and the linux-media list.
> 
> Please do let me know if you want any additional diagnostics, but you will need to cc me as I'm not subscribed..
> 
> Chris
