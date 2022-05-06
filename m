Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1413551CEF8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 04:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388319AbiEFCYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 22:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388336AbiEFCYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 22:24:04 -0400
X-Greylist: delayed 1977 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 05 May 2022 19:20:21 PDT
Received: from titan58.planetwebservers.net (titan58.planetwebservers.net [51.79.1.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602586449
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 19:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lockie.ca;
        s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=UlDoBbDDRWNOD0Y9A3voW+KijnwB9F1zKLSJPaxFGIM=; b=CeZUmDT2WnZbShhcxSviDoC4fm
        tDpaRKhnoBFJHaVeuzlV+bNt2GRfvZ9RsrgCkDRg9lYxWditQzapTSWGTdy3kuoz++cQWFj1esSq8
        iNF8JfHjhppU5BOzzJYgz+3EjGd/jmHSO1i3XneAi2wiT2C9kawTUUhOHNOyKFOgbxAXfSM16WhMS
        T5MKQetxmLzrXAYCr1KTUg5L8T9awaxz38KqJZY4B51mJMDqm7QGAk8Z0BNvxtPz+K7oOm166mYp7
        MRp2sAHST7V4/Yt6H00Bm/oHeYrpDFC29YWD0jJ22eiYVU9ZMyux+i3OoNclbd2+rJCw19mfmXjif
        761EyKew==;
Received: from [216.168.124.37] (port=40056 helo=[192.168.68.65])
        by titan.planetwebservers.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <bjlockie@lockie.ca>)
        id 1nmn3x-0005k5-Tf; Fri, 06 May 2022 11:47:21 +1000
Message-ID: <bf281951-aff0-2d02-895d-8b2527975133@lockie.ca>
Date:   Thu, 5 May 2022 21:47:20 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: Suspend/resume error with AWUS036ACM
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, gonsolo@gmail.com
References: <CANL0fFQRBZiVcEM0OOxkLqiAKf=rFssGetrwN6vWj5SsxX__mA@mail.gmail.com>
From:   James <bjlockie@lockie.ca>
In-Reply-To: <CANL0fFQRBZiVcEM0OOxkLqiAKf=rFssGetrwN6vWj5SsxX__mA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - titan.planetwebservers.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lockie.ca
X-Get-Message-Sender-Via: titan.planetwebservers.net: authenticated_id: bjlockie@lockie.ca
X-Authenticated-Sender: titan.planetwebservers.net: bjlockie@lockie.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-From-Rewrite: unmodified, already matched
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

What is UBSAN?

Mmm, I got something similar but I upgraded and now I get:
[   53.857635] 
================================================================================
[   53.866267] UBSAN: array-index-out-of-bounds in 
/build/linux-raspi-9eKTPI/linux-raspi-5.15.0/net/mac80211/airtime.c:460:47
[   53.877535] index 15 is out of range for type 'u16 [12]'
[   53.882952] CPU: 3 PID: 104 Comm: kworker/u8:1 Tainted: G C        
5.15.0-1006-raspi #6-Ubuntu
[   53.882961] Hardware name: Raspberry Pi 4 Model B Rev 1.1 (DT)
[   53.882965] Workqueue: mt76 mt76u_tx_status_data [mt76_usb]
[   53.882990] Call trace:
[   53.882992]  dump_backtrace+0x0/0x1f0
[   53.883001]  show_stack+0x24/0x30
[   53.883006]  dump_stack_lvl+0x8c/0xb8
[   53.883011]  dump_stack+0x18/0x34
[   53.883015]  ubsan_epilogue+0x10/0x54
[   53.883019]  __ubsan_handle_out_of_bounds+0x80/0x90
[   53.883026]  ieee80211_get_rate_duration.constprop.0+0x218/0x290 
[mac80211]
[   53.883162]  ieee80211_calc_rx_airtime+0xfc/0x160 [mac80211]
[   53.883251]  ieee80211_calc_tx_airtime+0xd0/0x110 [mac80211]
[   53.883338]  mt76x02_send_tx_status+0x17c/0x390 [mt76x02_lib]
[   53.883360]  mt76x02_tx_status_data+0x5c/0x90 [mt76x02_lib]
[   53.883377]  mt76u_tx_status_data+0x88/0x110 [mt76_usb]
[   53.883386]  process_one_work+0x204/0x4c0
[   53.883396]  worker_thread+0x144/0x470
[   53.883401]  kthread+0x12c/0x140
[   53.883407]  ret_from_fork+0x10/0x20
[   53.883428] 
================================================================================

ubuntu server 5.15.0-1006-raspi


I was getting:
[   25.597319] 
================================================================================
[   25.597344] UBSAN: invalid-load in 
/build/linux-raspi-9r6HWT/linux-raspi-5.15.0/net/mac80211/status.c:1164:21
[   25.597367] load of value 255 is not a valid value for type '_Bool'
[   25.597382] CPU: 0 PID: 105 Comm: kworker/u8:2 Tainted: G C        
5.15.0-1005-raspi #5-Ubuntu
[   25.597397] Hardware name: Raspberry Pi 4 Model B Rev 1.1 (DT)
[   25.597406] Workqueue: phy0 mt76x02_mac_work [mt76x02_lib]
[   25.597472] Call trace:
[   25.597477]  dump_backtrace+0x0/0x1f0
[   25.597496]  show_stack+0x24/0x30
[   25.597507]  dump_stack_lvl+0x8c/0xb8
[   25.597520]  dump_stack+0x18/0x34
[   25.597530]  ubsan_epilogue+0x10/0x54
[   25.597539]  __ubsan_handle_load_invalid_value+0x80/0x90
[   25.597553]  ieee80211_tx_status_ext+0x54c/0x550 [mac80211]
[   25.597800]  mt76_tx_status_unlock+0x100/0x160 [mt76]
[   25.597854]  mt76_tx_status_check+0x74/0xa4 [mt76]
[   25.597900]  mt76x02_mac_work+0x174/0x2ac [mt76x02_lib]
[   25.597943]  process_one_work+0x204/0x4c0
[   25.597958]  worker_thread+0x144/0x470
[   25.597970]  kthread+0x12c/0x140
[   25.597981]  ret_from_fork+0x10/0x20
[   25.597996] 
================================================================================

Everything seems to work.

On 2022-05-05 02:29, Gonsolo wrote:
> Hi all.
>
> After a resume I get the following error:
>
>   +0,000007] UBSAN: invalid-load in
> /build/linux-lowlatency-fSdu7c/linux-lowlatency-5.15.0/net/mac80211/status.c:1164:21
> [  +0,000004] load of value 255 is not a valid value for type '_Bool'
> [  +0,000004] CPU: 22 PID: 387 Comm: kworker/u256:5 Tainted: P
>    OE     5.15.0-27-lowlatency #28-Ubuntu
> [  +0,000004] Hardware name: To Be Filled By O.E.M. To Be Filled By
> O.E.M./X399 Phantom Gaming 6, BIOS P1.31 01/14/2021
> [  +0,000003] Workqueue: phy0 mt76x02_mac_work [mt76x02_lib]
> [  +0,000014] Call Trace:
> [  +0,000003]  <TASK>
> [  +0,000003]  show_stack+0x52/0x58
> [  +0,000006]  dump_stack_lvl+0x4a/0x5f
> [  +0,000007]  dump_stack+0x10/0x12
> [  +0,000003]  ubsan_epilogue+0x9/0x45
> [  +0,000002]  __ubsan_handle_load_invalid_value.cold+0x44/0x49
> [  +0,000004]  ieee80211_tx_status_ext.cold+0x4e/0x5f [mac80211]
> [  +0,000068]  mt76_tx_status_unlock+0x111/0x160 [mt76]
> [  +0,000010]  mt76_tx_status_check+0x68/0x90 [mt76]
> [  +0,000009]  mt76x02_mac_work+0x14b/0x240 [mt76x02_lib]
> [  +0,000008]  process_one_work+0x222/0x3f0
> [  +0,000006]  worker_thread+0x50/0x3f0
> [  +0,000004]  ? process_one_work+0x3f0/0x3f0
> [  +0,000004]  kthread+0x13b/0x160
> [  +0,000003]  ? set_kthread_struct+0x50/0x50
> [  +0,000004]  ret_from_fork+0x22/0x30
> [  +0,000006]  </TASK>
> [  +0,000001] ================================================================================
>
> This is a stock Ubuntu Jammy lowlatency kernel (with Nvidia drivers).
>
> I would be happy to provide all the needed information to resolve this.
>
> I also want to note that the device is running quite unstable (lots of
> deauthenticating, network lost, etc...).
>
> Regards,
> g

