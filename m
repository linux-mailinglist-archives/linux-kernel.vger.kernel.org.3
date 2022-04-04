Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F964F0F21
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 08:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377381AbiDDGDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 02:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235279AbiDDGDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 02:03:11 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0AB332EEF
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 23:01:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8E8DC210DB;
        Mon,  4 Apr 2022 06:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649052074; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QMUWDi2KJPo4dFK9Qvg757uowk2riW8b+q7dHl6m3IM=;
        b=q2r1WTI4xk6lMHpLroN8mls7Ex7jBdv9NbQbePnrSUhuN7HKzzLvU6JD0Sea/dJPjXixsU
        D0tnBYQ03JyF/gaorFG/wSpNYCeE07MhIU/NThKMPF3f9NzS9dwsxjSyUx4k8N0O6SHpoh
        cRhZs8AbWalUSTthcYV/Ss2LBBOhWQw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649052074;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QMUWDi2KJPo4dFK9Qvg757uowk2riW8b+q7dHl6m3IM=;
        b=eeIRe9Y/pXs66Bts5snXAVH8fru+ud+RYAhx5+aF7ogTxCtwpAtN3B2VuY0HLTZxhQYrS6
        UPZxa/bln+VzjrCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6AB8213216;
        Mon,  4 Apr 2022 06:01:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iwqwGKqJSmIVTQAAMHmgww
        (envelope-from <jslaby@suse.cz>); Mon, 04 Apr 2022 06:01:14 +0000
Message-ID: <694a8729-7313-e63e-7415-5a749be3a828@suse.cz>
Date:   Mon, 4 Apr 2022 08:01:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: Linux 5.18-rc1
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Oded Gabbay <ogabbay@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <CAHk-=wg6FWL1xjVyHx7DdjD2dHZETA5_=FqqW17Z19X-WTfWSg@mail.gmail.com>
 <20220404022239.GA1186352@roeck-us.net>
 <CAHk-=wimc7V9mi=P+6p2nnctPYtSM55OSPVERUeJor7fkD_EVg@mail.gmail.com>
From:   Jiri Slaby <jslaby@suse.cz>
In-Reply-To: <CAHk-=wimc7V9mi=P+6p2nnctPYtSM55OSPVERUeJor7fkD_EVg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04. 04. 22, 5:29, Linus Torvalds wrote:
>> Error log:
>> drivers/tty/serial/mpc52xx_uart.c:967:23: error: initialization of 'unsigned int (*)(struct uart_port *)' from incompatible pointer type 'int (*)(struct uart_port *)' [-Werror=incompatible-pointer-types]
>>    967 |         .raw_rx_rdy = mpc5125_psc_raw_rx_rdy,
>>
>> and many similar errors.
>>
>> Caused by commit 18662a1d8f35 ("tty: serial: mpc52xx_uart: make rx/tx
>> hooks return unsigned"). Reported at
>> https://lore.kernel.org/lkml/20220403153607.GA3644508@roeck-us.net/
> 
> Jiri - apparently you didn't convert the cases under CONFIG_PPC_MPC512x.
> 
> Please, people, let's get these silly problems fixed asap, and not
> have people unaware of them and fixes pending until much later in the
> rc series? It was painful  last release, let's not repeat that
> mistake.

Sure, I wasn't aware of the issue until yesterday -- when Guenter 
dropped me an e-mail. It passed through all the testing machinery which 
is unfortunate. (I have a script to cross-compile most of the peculiar 
tty drivers [1]. That indeed contains "mpc52xx_uart.o powerpc_mpc5200".) 
The fix was posted as 20220404055122.31194-1-jslaby@suse.cz .

[1] https://pastebin.com/UDTsBAaY

thanks,
-- 
js
suse labs
