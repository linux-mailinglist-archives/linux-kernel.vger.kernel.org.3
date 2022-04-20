Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9835E508EFB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 20:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381361AbiDTSCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 14:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344246AbiDTSCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 14:02:22 -0400
X-Greylist: delayed 380 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 20 Apr 2022 10:59:28 PDT
Received: from muminek.juszkiewicz.com.pl (muminek.juszkiewicz.com.pl [213.251.184.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB544756B;
        Wed, 20 Apr 2022 10:59:28 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muminek.juszkiewicz.com.pl (Postfix) with ESMTP id 3BA0E260253;
        Wed, 20 Apr 2022 19:53:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=juszkiewicz.com.pl;
        s=mail; t=1650477186;
        bh=378xZQcGCJsWGgLcL6Zj3T/L5wKuxRZjXh77lEd5C6M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gsN+z/lmkYH60f9l+afHZ/LVBFIZqoRQAAxviVf+H9ZfaBT/LXPE8TwIScjPbPosu
         XZQOfbwjLP6LP+OAVFH9dA2vk+fdlNMJLA42avfinlhKEjfldAoyPbLASIGv4S1yuT
         CM5rojZ/TYOa/KNSMM8UrtRZVapWb83+NzMRf+Fl3eSyUj8/HA3OWRTDFzx2z3b7FZ
         UB6r3aUFxAnSgQa2fCKyTpVJOmy8e6a4PyMZRaiXp/w/0BBM4vLd94gag0xQKBHsKH
         LnEdHn6j1vR26AROhErAvMolMjhHttplSQgLH1vQf+JZVaks875MTMWHp8yRzk+sGV
         Up6o11cPTvdCw==
X-Virus-Scanned: Debian amavisd-new at juszkiewicz.com.pl
Received: from muminek.juszkiewicz.com.pl ([127.0.0.1])
        by localhost (muminek.juszkiewicz.com.pl [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id rQR2UrWCHivI; Wed, 20 Apr 2022 19:53:03 +0200 (CEST)
Received: from [IPV6:2a01:11bf:4201:1400::6ca2] (2a01-11bf-4201-1400-0000-0000-0000-6ca2.la.ipv6.supernova.orange.pl [IPv6:2a01:11bf:4201:1400::6ca2])
        by muminek.juszkiewicz.com.pl (Postfix) with ESMTPSA id 4DCEB260060;
        Wed, 20 Apr 2022 19:53:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=juszkiewicz.com.pl;
        s=mail; t=1650477183;
        bh=378xZQcGCJsWGgLcL6Zj3T/L5wKuxRZjXh77lEd5C6M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=teTmWJ8qvTben8ximYcjIVe/Yk1el33/c4DNhdKU1T9G8pCta6CqV5KnyON5tWpMy
         fsz2Zrw7GbQqN9ZULj+vD91fYs01U8T5G1l9bQDR1pog7I0Du5q9VOSRqTzZxwYs9T
         LEjoAPKYnttOI4AuqEz41xZZ9SONRN3Ph8V43gwsoJL2tOz3OT5H8n/ierZGenXmeG
         gkyURrFvnLIGgFgSa34We8PNL9vs6BBdJVPmG1fE7dsy0rwZ4iYwYWmMeRhvT16g1p
         u2MlR3dIj8liH7QaOOuRA7XIc7VsaqN4/o6KXNUV3QxM/l9nUKOG95bWU8KI8KKc8w
         dc4QlHbMEJL0A==
Message-ID: <1ee78aa5-919a-9d37-7d59-a2c87f856eaf@juszkiewicz.com.pl>
Date:   Wed, 20 Apr 2022 19:52:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: Explicitly defining the userspace API
Content-Language: en-US
To:     Spencer Baugh <sbaugh@catern.com>, linux-api@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        arnd@arndb.de
References: <874k2nhgtg.fsf@catern.com>
From:   Marcin Juszkiewicz <marcin@juszkiewicz.com.pl>
In-Reply-To: <874k2nhgtg.fsf@catern.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W dniu 20.04.2022 o 18:15, Spencer Baugh pisze:

> Another related project is system call tables like
> https://marcin.juszkiewicz.com.pl/download/tables/syscalls.html  which
> don't contain any more information than already in SYSCALL_DEFINE.

This project was made to give a way of getting number<>name information 
for system call. And for 'is it implemented'.

Nothing more, just simple info. And so far helped many developers and 
their projects.

One day I got request from loongarch port maintainers to add their table 
because systemd relies on it ;D

I also made Python module for using it. So far no known users :D

https://marcin.juszkiewicz.com.pl/2021/09/14/python-package-for-system-calls-information/
