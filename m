Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5A1047B324
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 19:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240560AbhLTSrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 13:47:19 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:42921 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240549AbhLTSrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 13:47:18 -0500
Received: from [192.168.0.2] (ip5f5aed30.dynamic.kabel-deutschland.de [95.90.237.48])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 8CC1661EA1927;
        Mon, 20 Dec 2021 19:47:15 +0100 (CET)
Message-ID: <214e5c3f-4198-d647-eb05-adaaeba63aa8@molgen.mpg.de>
Date:   Mon, 20 Dec 2021 19:47:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 2/3] Bluetooth: btmtksdio: Enable SCO over I2S function
Content-Language: en-US
To:     Sean Wang <sean.wang@mediatek.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        Mark-YW.Chen@mediatek.com, Soul.Huang@mediatek.com,
        YN.Chen@mediatek.com, Leon.Yen@mediatek.com,
        Eric-SY.Chang@mediatek.com, Deren.Wu@mediatek.com,
        km.lin@mediatek.com, robin.chiu@mediatek.com,
        Eddie.Chen@mediatek.com, ch.yeh@mediatek.com,
        posh.sun@mediatek.com, ted.huang@mediatek.com,
        Eric.Liang@mediatek.com, Stella.Chang@mediatek.com,
        Tom.Chou@mediatek.com, steve.lee@mediatek.com, jsiuda@google.com,
        frankgor@google.com, jemele@google.com, abhishekpandit@google.com,
        michaelfsun@google.com, mcchou@chromium.org, shawnku@google.com,
        linux-bluetooth@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <638a2506-c410-d98c-b704-6f16f72e0bc6@molgen.mpg.de--annotate>
 <1640022750-16263-1-git-send-email-sean.wang@mediatek.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <1640022750-16263-1-git-send-email-sean.wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Sean,


Am 20.12.21 um 18:52 schrieb sean.wang@mediatek.com:
> From: Sean Wang <sean.wang@mediatek.com>

>> Am 18.12.21 um 02:08 schrieb sean.wang@mediatek.com:
>>> From: Mark Chen <mark-yw.chen@mediatek.com>
>>> 
>>> For MediaTek chipset, the driver has to issue the specific
>>> command to enable Bluetooth SCO support over the I2S/PCM
>>> interface.
>> 
>> Please document the datasheet name, revision and section, where
>> this is described.
> 
> the datasheet is not released in public so Mark and I cannot provide
> the detail here, but we will make the patch easy to review and
> understand.

Too bad. The name and revision of the datasheet would still be good to 
have documented.

>> Please add how SCO support can be tested. Are all Mediatek chipsets
>> supported?
> 
> the SCO profile was tested by setting up a VOIP application,
> connected to HFP device, checked telephony function can work
> normally.
> 
> currently, SCO is only supported by mt7921, we will change the
> subject to "Bluetooth: mt7921s: Enable SCO over I2S function" to
> avoid any misunderstanding.

Thank you.

I also saw a linux-firmare patch updating the firmware. If a specific
firmware version is required, please mention it too.

[…]


Kind regards,

Paul
