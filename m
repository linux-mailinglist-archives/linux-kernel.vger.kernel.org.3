Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82DA4597F75
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 09:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243906AbiHRHqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 03:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243892AbiHRHqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 03:46:07 -0400
Received: from srv6.fidu.org (srv6.fidu.org [IPv6:2a01:4f8:231:de0::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A71A6D545
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 00:46:05 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id 3E774C800A2;
        Thu, 18 Aug 2022 09:46:03 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 8-OXr-g8Y69l; Thu, 18 Aug 2022 09:46:03 +0200 (CEST)
Received: from [IPV6:2003:e3:7f47:c300:41ac:9de4:5825:30ea] (p200300e37f47c30041Ac9De4582530ea.dip0.t-ipconnect.de [IPv6:2003:e3:7f47:c300:41ac:9de4:5825:30ea])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPSA id EEDF5C8009A;
        Thu, 18 Aug 2022 09:46:02 +0200 (CEST)
Message-ID: <920e65d4-5760-3e35-8b2a-dae4f9220632@tuxedocomputers.com>
Date:   Thu, 18 Aug 2022 09:46:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] ALSA: hda/realtek: Add quirk for Clevo NS50PU, NS70PU
Content-Language: en-US
To:     Takashi Iwai <tiwai@suse.de>
Cc:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20220817135144.34103-1-wse@tuxedocomputers.com>
 <87edxe9euc.wl-tiwai@suse.de>
From:   Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <87edxe9euc.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just realized I forget to change the subject and description: the NS50PU 
was already added by someone else, this patch only adds the NS70PU.

Am 18.08.22 um 09:43 schrieb Takashi Iwai:
> On Wed, 17 Aug 2022 15:51:44 +0200,
> Werner Sembach wrote:
>> From: Christoffer Sandberg <cs@tuxedo.de>
>>
>> Fixes headset microphone detection on Clevo NS50PU and NS70PU.
>>
>> Signed-off-by: Christoffer Sandberg <cs@tuxedo.de>
>> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
>> Cc: <stable@vger.kernel.org>
> Applied, thanks.
>
>
> Takashi
