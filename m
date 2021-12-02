Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B26D4668FB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 18:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376280AbhLBRWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 12:22:01 -0500
Received: from srv6.fidu.org ([159.69.62.71]:55602 "EHLO srv6.fidu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1376257AbhLBRWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 12:22:00 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id 5A770C80089;
        Thu,  2 Dec 2021 18:18:36 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id zgTVVGGim0y8; Thu,  2 Dec 2021 18:18:36 +0100 (CET)
Received: from [192.168.178.21] (host-212-18-30-247.customer.m-online.net [212.18.30.247])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPSA id F22C1C8006F;
        Thu,  2 Dec 2021 18:18:35 +0100 (CET)
Subject: Re: [PATCH] ALSA: hda/realtek: Fix quirk for TongFang PHxTxX1
To:     Takashi Iwai <tiwai@suse.de>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        tiwai@suse.com
References: <20211202152843.818617-1-wse@tuxedocomputers.com>
 <s5ho85zt3xm.wl-tiwai@suse.de>
 <aceae41d-eeaa-9f13-2e37-9fce08e693c6@tuxedocomputers.com>
 <s5hbl1zt1wy.wl-tiwai@suse.de>
From:   Werner Sembach <wse@tuxedocomputers.com>
Message-ID: <285f691b-2c0c-d032-cb96-45e9e939eabb@tuxedocomputers.com>
Date:   Thu, 2 Dec 2021 18:18:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <s5hbl1zt1wy.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: de-DE
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Am 02.12.21 um 17:19 schrieb Takashi Iwai:
> On Thu, 02 Dec 2021 17:02:51 +0100,
> Werner Sembach wrote:
>> Am 02.12.21 um 16:35 schrieb Takashi Iwai:
>>> On Thu, 02 Dec 2021 16:28:43 +0100,
>>> Werner Sembach wrote:
>>>> This fixes the SND_PCI_QUIRK(...) of the TongFang PHxTxX1 barebone. This
>>>> fixes the issue of sound not working after s3 suspend.
>>>>
>>>> When waking up from s3 suspend the Coef 0x10 is set to 0x0220 instead of
>>>> 0x0020. Setting the value manually makes the sound work again. This patch
>>>> does this automatically.
>>>>
>>>> While being on it, I also fixed the comment formatting of the quirk.
>>>>
>>>> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
>>>> Cc: <stable@vger.kernel.org>
>>> Please try to put Fixes tag as this is a fix for the existing change.
>> Sorry, wasn't aware of this. I guess it's [PATCH Fixes] as the beginning of the subject line?
> No, the Fixes tag is another line you add around your Signed-off-by
> line for indicating that that the patch is for fixing the given
> commit.  In your case, it'll be like
>
> Fixes: dd6dd6e3c791 ("ALSA: hda/realtek: Add quirk for TongFang PHxTxX1")
>
>
> HTH,
>
> Takashi

Thanks, that was indeed very helpful.

Sorry for still making noob mistakes.

