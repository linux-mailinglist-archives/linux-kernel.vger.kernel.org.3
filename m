Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6843D4D1140
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 08:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244611AbiCHHrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 02:47:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiCHHq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 02:46:58 -0500
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [71.19.156.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199803E0D3
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 23:46:01 -0800 (PST)
Received: from hatter.bewilderbeest.net (174-21-187-98.tukw.qwest.net [174.21.187.98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id BA823D7;
        Mon,  7 Mar 2022 23:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1646725560;
        bh=HXpXa9hrjYoPMQUYirJanMV84faarG7+Ko1HRfUY6j4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kTjwDSVGY2weTNLpafdlH+jLwLqhKbWrUql8kHzXgqB3xfvm5vZnR+3PmlIKgm56m
         iGySOKgao2fUuCtRRA1JA5a8CFT7JqOKmfwAPbOqzCwiHF5UorobuUdolqO86p6Ck1
         cy5RIrfcitrlzkUqEjO0sy4mpR8kFej7koDgPNxw=
Date:   Mon, 7 Mar 2022 23:45:57 -0800
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH v2 2/2] misc: Add power-efuse driver
Message-ID: <YicJtee4LrShiUC9@hatter.bewilderbeest.net>
References: <20220308011811.10353-1-zev@bewilderbeest.net>
 <20220308011811.10353-3-zev@bewilderbeest.net>
 <YicAWbGN74F6SSNs@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YicAWbGN74F6SSNs@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2022 at 11:06:01PM PST, Greg Kroah-Hartman wrote:
>On Mon, Mar 07, 2022 at 05:18:10PM -0800, Zev Weiss wrote:
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -7058,6 +7058,11 @@ S:	Orphan
>>  W:	http://aeschi.ch.eu.org/efs/
>>  F:	fs/efs/
>>
>> +POWER EFUSE DRIVER
>> +M:	Zev Weiss <zev@bewilderbeest.net>
>> +S:	Maintained
>> +F:	drivers/misc/power-efuse.c
>> +
>>  EHEA (IBM pSeries eHEA 10Gb ethernet adapter) DRIVER
>>  M:	Douglas Miller <dougmill@linux.ibm.com>
>>  L:	netdev@vger.kernel.org
>
>Entries need to be in sorted order :(
>

Ack, forgot to move it when I renamed an earlier incarnation from 
"efuse" to "power-efuse"...will fix.


Zev

