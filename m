Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 967D947E0C4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 10:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347375AbhLWJSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 04:18:32 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:59469 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239245AbhLWJSa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 04:18:30 -0500
Received: from [192.168.0.2] (ip5f5aea70.dynamic.kabel-deutschland.de [95.90.234.112])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id F355A61EA1BDD;
        Thu, 23 Dec 2021 10:18:27 +0100 (CET)
Message-ID: <373eb764-f5bb-d6ff-0500-db2ccd62a6b2@molgen.mpg.de>
Date:   Thu, 23 Dec 2021 10:18:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v3 1/3] Bluetooth: mt7921s: Support wake on bluetooth
Content-Language: en-US
To:     Sean Wang <sean.wang@mediatek.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Mark-YW.Chen@mediatek.com, Soul.Huang@mediatek.com,
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
References: <ceafc644ca9ce926a9fb07f7b3f4e2f701e69c8d.1640165092.git.sean.wang@kernel.org>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <ceafc644ca9ce926a9fb07f7b3f4e2f701e69c8d.1640165092.git.sean.wang@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Sean,


Am 23.12.21 um 03:56 schrieb sean.wang@mediatek.com:

[…]

>   static int btmtksdio_probe(struct sdio_func *func,
>   			   const struct sdio_device_id *id)
>   {
> @@ -998,6 +1024,7 @@ static int btmtksdio_probe(struct sdio_func *func,
>   	hdev->shutdown = btmtksdio_shutdown;
>   	hdev->send     = btmtksdio_send_frame;
>   	hdev->set_bdaddr = btmtk_set_bdaddr;
> +	hdev->wakeup = btmtk_sdio_wakeup;

The equal sign still is not aligned with the one on `hdev->send`.

[…]


Kind regards,

Paul
