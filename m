Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0CB149472C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 07:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358690AbiATGOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 01:14:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358660AbiATGOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 01:14:10 -0500
Received: from mx.msync.work (mx.msync.work [IPv6:2a01:4f9:2b:2dc2::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41472C061574;
        Wed, 19 Jan 2022 22:14:10 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0337D26BA66;
        Thu, 20 Jan 2022 06:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1642659248; h=from:subject:date:message-id:to:cc:mime-version:content-type:
         content-transfer-encoding:content-language:in-reply-to:references:
         disposition-notification-to; bh=tm7rYi4Jr6cHNL/9fgglre+xCFRgRHfyITbl4lUkOZ8=;
        b=dOzt7GesFXcXn4UkC65nLsiaztuJ0BbZoc2nQVtuhMladpAVVmlEgcbwHJ7HLIT6W7c7w5
        ZK+bDniqa+2S4aMiDurD4YXoDGjDo+GotyRDXht3fLpgkdIvg0kMkLYURefAqK+AnoQ95Z
        Xi7asoMBclShQ+KaHk/GSqe6IeiWT3q8bff2hvBsX/motSKBELHIX2SSGHizdi3/dbEXMw
        5sGK5Uybp61yj3H579p4Ejzb5he5ztj9ylh0dFpusUrM8fQLFRqW9sdR9epX8HRLSlCFfa
        368bNhrkLbh3Y0CyFHKSOKtwgq7QaDds9I4/vdXu82fMXTYqOAKG6wOGbXaXrA==
Subject: Re: [PATCH v4 1/2] Bluetooth: btrtl: Add support for RTL8822C hci_ver
 0x08
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220119061723.2862683-1-adeep@lexina.in>
 <20220119061723.2862683-2-adeep@lexina.in>
 <56F74F4D-1916-4F4A-9669-595D3C0A69C7@holtmann.org>
From:   Vyacheslav <adeep@lexina.in>
Message-ID: <720743a1-29c8-edb5-2779-34a4b7511f0b@lexina.in>
Date:   Thu, 20 Jan 2022 09:14:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <56F74F4D-1916-4F4A-9669-595D3C0A69C7@holtmann.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

19.01.2022 22:31, Marcel Holtmann пишет:
> Hi Vyacheslav,
> 
>> Add a variation of RTL8822CS with hci_ver = 0x08. This is fully similar to RTL8822CS with hci_ver = 0x0a
>> observed on the Tanix TX6 Android set-top box and JetHome JetHub H1.
>>
>> Changes from v3:
>> - add has_msft_ext option
> 
> these belong after the --- line. Please see patch submission guidelines.
Thanks, this is my miss.

> 
>>
>> Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>
>> Signed-off-by: Rudi Heitbaum <rudi@heitbaum.com>
>> ---
>> drivers/bluetooth/btrtl.c | 8 ++++++++
>> 1 file changed, 8 insertions(+)
> 
> Regards
> 
> Marcel
> 

