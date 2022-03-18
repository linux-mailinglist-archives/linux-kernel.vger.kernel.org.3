Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0794DD56B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 08:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233247AbiCRHqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 03:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233224AbiCRHqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 03:46:49 -0400
X-Greylist: delayed 1121 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 18 Mar 2022 00:45:23 PDT
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1810A1F51B3;
        Fri, 18 Mar 2022 00:45:22 -0700 (PDT)
Received: from [127.0.0.1] (helo=localhost)
        by relay.expurgate.net with smtp (Exim 4.92)
        (envelope-from <prvs=50901776b7=fe@dev.tdt.de>)
        id 1nV70J-000Tmn-MA; Fri, 18 Mar 2022 08:26:31 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
        by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <fe@dev.tdt.de>)
        id 1nV70I-000T4V-Ul; Fri, 18 Mar 2022 08:26:30 +0100
Received: from securemail.tdt.de (localhost [127.0.0.1])
        by securemail.tdt.de (Postfix) with ESMTP id 3F9E8240049;
        Fri, 18 Mar 2022 08:26:30 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
        by securemail.tdt.de (Postfix) with ESMTP id B16B4240040;
        Fri, 18 Mar 2022 08:26:29 +0100 (CET)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
        by mail.dev.tdt.de (Postfix) with ESMTP id 3B1FB25F67;
        Fri, 18 Mar 2022 08:26:29 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 18 Mar 2022 08:26:29 +0100
From:   Florian Eckert <fe@dev.tdt.de>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Eckert.Florian@googlemail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] leds: ktd20xx: Extension of the KTD20xx family of
 LED drivers from Kinetic
In-Reply-To: <20220212120857.GJ20866@duo.ucw.cz>
References: <20220121140150.1729-1-fe@dev.tdt.de>
 <20220121140150.1729-2-fe@dev.tdt.de>
 <CAHp75Vd4pwFXoF=xS5cskM2GDNb6c6RXTYo3j3FLP+nuQVoRyg@mail.gmail.com>
 <20220212120857.GJ20866@duo.ucw.cz>
Message-ID: <7c973f04b4ecf1cd88d69e388edbb7e7@dev.tdt.de>
X-Sender: fe@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-purgate-ID: 151534::1647588391-000005D6-B4761D2A/0/0
X-purgate: clean
X-purgate-type: clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Pavel,

Haven't seen the new ktd20xx for the next [1] kernel release yet.
Do I still have to do something?

Best regards,

Florian Eckert

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-leds.git/log/?h=for-next
