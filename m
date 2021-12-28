Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E04F048088B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 11:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236294AbhL1Kqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 05:46:46 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:49855 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236282AbhL1Kqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 05:46:45 -0500
Received: from [192.168.0.2] (ip5f5aecda.dynamic.kabel-deutschland.de [95.90.236.218])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id A71EA61EA1928;
        Tue, 28 Dec 2021 11:46:43 +0100 (CET)
Message-ID: <c26d4792-0efa-d661-faec-cb00c68132e0@molgen.mpg.de>
Date:   Tue, 28 Dec 2021 11:46:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] fix 5.15 init regression for Intel Bluetooth
Content-Language: en-US
To:     =?UTF-8?Q?Ortwin_Gl=c3=bcck?= <ortwin.glueck@logobject.ch>
Cc:     linux-bluetooth@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org
References: <856c5dc7-9fb4-8438-3451-7b369832056a@odi.ch>
 <b0f6f66b-28aa-9d43-0aab-e6887ee0fda8@logobject.ch>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <b0f6f66b-28aa-9d43-0aab-e6887ee0fda8@logobject.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Ortwin,


Am 27.12.21 um 11:26 schrieb Ortwin Glück:

> On all 5.15 kernels the Intel Bluetooth no longer works. All was fine in 
> 5.14.
> Apparently the quirk is needed for this device.
> 
> vanilla 5.15.5:
>     Bluetooth: hci0: Reading Intel version command failed (-110)
>     Bluetooth: hci0: command tx timeout
> 
> with patch:
>     Bluetooth: hci0: Legacy ROM 2.5 revision 1.0 build 3 week 17 2014
>     Bluetooth: hci0: Intel device is already patched. patch num: 32
> 
> Please apply to stable too.

This has been already reported in *[PATCH] Bluetooth: Apply initial 
command workaround for more Intel chips* [1].

As I replied there, on what device do you experience this, and how can 
it be reproduced?

I have a Dell Latitude E7250 with the Bluetooth device 0x0a2a, and 
everything works fine under Debian sid/unstable with Linux 5.15 up to 
5.16-rc6.

     Bus 002 Device 003: ID 8087:0a2a Intel Corp. Bluetooth wireless 
interface


Kind regards,

Paul


[1]: 
https://lore.kernel.org/linux-bluetooth/20211202162256.31837-1-tiwai@suse.de/
