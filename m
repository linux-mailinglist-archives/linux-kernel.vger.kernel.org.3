Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0685A4F1736
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347374AbiDDOkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377993AbiDDOjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:39:03 -0400
Received: from srv6.fidu.org (srv6.fidu.org [159.69.62.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555B83F88A;
        Mon,  4 Apr 2022 07:36:27 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id 643E1C800A2;
        Mon,  4 Apr 2022 16:36:25 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id FgWi6ci6Q9W0; Mon,  4 Apr 2022 16:36:25 +0200 (CEST)
Received: from [192.168.178.30] (host-212-18-30-247.customer.m-online.net [212.18.30.247])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPSA id E02D5C8009C;
        Mon,  4 Apr 2022 16:36:24 +0200 (CEST)
Message-ID: <1754062e-0d2a-9400-fe41-5434933fb9ca@tuxedocomputers.com>
Date:   Mon, 4 Apr 2022 16:36:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v5] input/i8042: Rework quirk tables
Content-Language: de-DE
To:     Hans de Goede <hdegoede@redhat.com>, dmitry.torokhov@gmail.com,
        tiwai@suse.de, mpdesouza@suse.com, arnd@arndb.de, samuel@cavoj.net,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220329143622.31394-1-wse@tuxedocomputers.com>
 <8a430ab7-024f-51a9-d785-07e03f163261@redhat.com>
From:   Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <8a430ab7-024f-51a9-d785-07e03f163261@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Am 02.04.22 um 12:47 schrieb Hans de Goede:
> Hi,
>
> On 3/29/22 16:36, Werner Sembach wrote:
>> Revision 5 with some fixes based on feedback by Hans de Goede.
>>
>> The 1st patch is minor housekeeping.
>>
>> The 2nd patch merges the tables together. Minor fixes in 5th revision and
>> no more duplication of ASUS devices
>>
>> The 3rd patch add optional debug output to see which quirks get applied. In
>> 5th revision this no longer breaks compilation on non x86 platforms.
>>
>> The 4th patch adds a list of Clevo devices that need multiple quirks.
>> With the reworked table they don't need to be inserted multiple times now,
>> which was required in v1 and v2 of this patch.
>>
>> I also included the extra quirk for the Clevo NS7xMU, which was a separate
>> patch before.
>>
>> The added Clevo devices are now only identified by their board name as this
>> is the only somewhat reliable string that might not be changed by resellers.
> Thanks, the entire series looks good to me:
>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>
> for the series.
>
> Regards,
>
> Hans
>
>
>
> p.s.
>
> In the future if you get a Reviewed-by to a previous version of a patch
> and the patch does not change (or does not change much, e.g. only
> small code-style / comment typo tweaks) you can keep that Reviewed-by
> for next versions of the patch, just copy it over to your commit
> msg and put it directly above your own S-o-b line.
>
>
OK, thanks
