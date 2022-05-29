Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34EA5372FC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 01:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbiE2Xpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 19:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbiE2Xpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 19:45:42 -0400
Received: from sonic306-24.consmr.mail.gq1.yahoo.com (sonic306-24.consmr.mail.gq1.yahoo.com [98.137.68.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631E44EDFF
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 16:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=att.net; s=s1024; t=1653867941; bh=LyHIiwzQ85zJjJXdYrmYS7vDqGGe1tqy8kIf32+/1s8=; h=Date:Subject:To:References:From:In-Reply-To:From:Subject:Reply-To; b=iuh+hhz2klysa68tPeJyFp+gYoAzOW1O0QK8ee/2jZXsEBOVF4Wp05HPS41EtOr7tkYZTkr4G/eHwhisqxg+elyhNta9wN8WfmBpX7lm1SnGuMGcQe8+PF+IA1+VkIoBvGoLkUY0Z5HTzinjE945tYIjojS1QmeIvJpTcEfCERg=
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1653867941; bh=4MNxbewl9odPoTBDM4t5azZNzUaPS77SeZU2yphvBvW=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=ZYgskEjeNvzzOw34r3sZHvv+Ie9FXVMTQXcQTTd0vh/8EwHPHXPnMYljlbuYQBN9Y3Xbxxk6tWtYny0FBx7WFhyNgtkvlhtmdBTHYVGbHw3lyDmrNRGvD930ViPsEkP7y8HxOMm1513cPkG9E2trIddmWFdFcWEZ2ICbSRLooWiyYAg+5F5+1AySKxntHYU42xHe9UHRJGbhRfeqbcQ0v4vSGQWbm7zHdDVI8FopMP5tdi3yNlU0iwkQ3CxUrRJ1ggKkCXRPV/qJnROeNBA+KZjJ/J4upmtw5XWC0ABLk2RV0MjxC1ITg0z7eFHmdXxwuY6Zvahnpd8InF4c8Z7O9Q==
X-YMail-OSG: zTItYR0VM1mpuFkrWRwmFe9IMoPpUIyYUqLiLIAe9a9vu.BgOqrlSBVJA1iIBRI
 HVpfp7j5D6qGqWDKYSK_saYNryoonRUOLMxA.GNlatvY.YqYFx8NhbAZHM8_hv.kdnPJcdgJAq5z
 SniHFOi8PtnsynZuFT.92gIhbrKQGptKcD3qIzZBxRpMEZE1l5HDJqlTZdL8zr7Rano3S_hplOoB
 WSaxJ_RdWQZFDSXx1m1nbpmsqoF2AwnA.1rKyMLy9PB5vKTvQNN.hjxw25xxbrGRCpbOFMoqe62y
 _ojfTIVYgZlDuttCRAXg1LkLsPnh33sFJwG002.zazXcf1nVmC75d9_ioiL_lE4R3vTDg77SYMg3
 BKXQJcv.hNCNc3.W9rbvYqcLchrDdkWrw8Rwmcx5D9Hc7cCvXjLNLm64lYYuw_vSuEdN9OThJYpU
 VDPUBFloUaoVxMVAXUJPvICsKGO9LMAfkwISgg2Ujw2zdgLXN2AS7qWfmlY7GoyFD1Olxqeck3xC
 Vpspy6DdwP5.Rd3hZYeJtm9ZrPwk5z59E_r3snFdKg5vor0wuHFgWqXSGH2WEK1k60Nw2HAPRQwf
 QGyaCzOQYsSU8uIPyOFreY6AxdREtmvJyZR057zr7RMQ20inVUx2onVAF5D3chsLJcUjRIqihUpM
 LS6gVJC.cLmfWqFwirmotgT30M6f9ADmHkILz0nLaG8vPvTb9.ukTx4VMzxDVdP8pvlPkqMvN7.7
 laqWpjnr1z1RNdqrpWjcL.J6dJs5EK34Mqwiq4bj594UgNkxtHWBqwbXWlXJwBbz5sadg48dARQo
 eV2IhI3uElJO0WkI38aeo9ICjYO9o5PPjinlQDWPmU2V1QHk1U8JJbZhqX4N7uGNobW4vxeTPoIC
 c0vxGeQ4dR_aoWmCLJjCEfft8BVs5FW5x7jFBXDsSpKg6Ae10oaE7ihIa_Rn2U5haDnEg.VsJeCC
 jZIbNkg_QoMcfoKsJCxqTAfAlFXSv7ZxESKWbgJoN2p07l4OJc.E7vileaH.CUdYfxtxBjTxCzjI
 AjQ3ruuUy91FVH3IAK2cBySVq849aMmtIBGbcTX0rQyHZCKHDmkoRI2_wBTKb1Pn5FtKyXtJGLdk
 S_2ep._2cSMb0_Kv5LA_PKlMRQv3aCASwbS0d2JTZq1MkCjFU8lSBqZacIk6YxOPONzlG1pUOGGv
 5.ASawzgSVFyQctWTDz0cM.7xAgzow4e0S6L7m3cpc.rXKB3hVYAyR2XEhhIbuLurmgTTtwrTxtC
 TNzd6.xkGJ9AXddE_cspUpdyInGIJ9CaaZ6SI24lve5h4v5FRLXUFqSSJSlMzPeuvOmwZoWsYgsW
 fKcHXMnpLkNMNcZKOmOLeyleC1bFeMutypTTh3MWEYBc6MxUw1aJ6XZxiYkaR8weDhzuO7j_5LYj
 2ABbfhxxyusc_bmA.qqcDResyR7vI6M5mbj1GXYil9r0ggTfp22gmljUTwn.hnKu5XwoRZnMHl4g
 KRiGW.X.RDjjGsCpT132Yqn0kHNfxfJVlBuJ0j71_T8RNpHnLAW9or4zaTkUD6pcxgbhYs9Ovh5l
 K_Up_lpELAZAdxSeBxDxlFoXiTPqUoBxiUz9m26Ivf9g_MB38nqaidJpqg4XT_0h1TyFRihSl19T
 Ns7Pbw6lsPx4ovxCXuW3irTp7HSjnnfIEEsUpWZnQS5WD_Ibz1PTVwzfzqUo3hDWfJdE8bLobv9O
 YV7rgNiG0sqhuk5xO_PTvpmg5jGB5Ll4lMmtmf0wsVeWHAIItZWlV4VZ1J9ePLvbH2hpc30deUem
 kcHAHis8HjIa0m2C0K.hI9fidoIMMbf_RSj7j5uYwKfgIc70.lqXdrgPfngBLftqR2mAwH3rqfRG
 QzpDJ5e0_7fqlIispscTwBRWQ2CzglTldbzd1lvzNruDCg2W8BCogblpez.mY6VaHA5Q3Ovv7y4g
 QO2CtNb4N8hLD_mjtdXhaPdRKhhiRvfNMFywDgWIeox9TKUa.7v9hc6uU51oN3GAA830Ka.rK5kw
 sBfj.nRm6YB8dqAfskLMty.uwdgFk2kuMmDROHEbalrEOyrr54HKG_d5KxYCjFeK4l.SOMhQ.40V
 .zZrQD4UPlsad19CElK7VdiPRMyszyd_Nwu2s5oP9N4YSjjVPirIHBboykXwogWX5Vr7XubXLuEh
 C3HrZ9g470OULulEQX7djSoExjf3JMhEdRFvCqGAexLcnq.KTHgO.4ATWdvJvkZIk4pU0BcHk0vS
 UUY_fSdv.9AQ1EmQfWynr9gZZCkmUAJ4v28oNJqaycvyR8MySao9ENFPqIfrG9opw.kVcir1Wp_7
 pZujmIb6hnJ2.lMg4OCWT9_qbUA--
X-Sonic-MF: <lesrhorer@att.net>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.gq1.yahoo.com with HTTP; Sun, 29 May 2022 23:45:41 +0000
Received: by hermes--canary-production-ne1-799d7bd497-8kdwl (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID f6c8cf899abfc94e7dc54acc5f12cd5d;
          Sun, 29 May 2022 23:45:35 +0000 (UTC)
Message-ID: <3b8f2ed6-11fd-b5a7-5442-7cac90348514@att.net>
Date:   Sun, 29 May 2022 18:45:24 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Module failure on new install of Debian Bullseye
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>
References: <dd7e69ce-41a4-cc5e-5a15-0ae9fc52aad0.ref@att.net>
 <dd7e69ce-41a4-cc5e-5a15-0ae9fc52aad0@att.net>
 <7999b7b4-3b58-a9c4-4756-445e54404f0f@csgroup.eu>
 <ba2fb3ff-22dd-d68e-fa99-02de39240f20@infradead.org>
From:   Leslie Rhorer <lesrhorer@att.net>
In-Reply-To: <ba2fb3ff-22dd-d68e-fa99-02de39240f20@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20225 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


     If this is the wrong list, please let me know the correct one so I 
can subscribe and post there.

     Two of my servers are having bizarre problems after upgrading to 
Debian Bullseye.  After attempting numerous fixes, I decided to wipe the 
systems and do a fresh install.  I did a fresh install of he first from 
a netinst thumb drive, but the .iso does not contain the bnx2c drivers 
needed for the ASUS PEB-10G/57811-1S 10GbE SFP+ Network Adapters used by 
both systems.  I tried adding what I thought to be the correct non-free 
drivers, but I still got errors about the bnx2x drivers and the 
interface shows no carrier.  Since no carrier is detected on the 
interface, no LAN or internet access is possible.  The system is 
effectively dead, although it boots up and of course I have local 
console access.

     After several different approaches, I changed from the netinst 
image to a full non-free image.  It still would not properly load the 
bnx2x drivers.  I tried downloading all six bnx2x e1, e1h, and e2 
release 7.13.15.0 and 7.13.21.0 firmware files and adding them to the 
initram image.  It no longer complains about missing files, but it 
doesn't activate the NIC, either.  These servers are both essentially 
dead in the water until I can get this fixed.

     The only thing I spot from dmesg that seems possibly related is:

[    1.420748] r8169 0000:0b:00.0: can't disable ASPM; OS doesn't have 
ASPM control
[    1.433467] r8169 0000:0b:00.0 eth0: RTL8168f/8111f, 
50:46:5d:65:15:9c, XID 480, IRQ 39
[    1.433469] r8169 0000:0b:00.0 eth0: jumbo features [frames: 9194 
bytes, tx checksumming: ko]
...
[    1.458361] r8169 0000:0b:00.0 enp11s0: renamed from eth0
[    1.465675] bnx2x: disagrees about version of symbol module_layout
...
[   12.976323] r8169 0000:0b:00.0: firmware: failed to load 
rtl_nic/rtl8168f-1.fw (-2)
[   12.976478] firmware_class: See https://wiki.debian.org/Firmware for 
information about missing firmware
[   12.976632] r8169 0000:0b:00.0: Direct firmware load for 
rtl_nic/rtl8168f-1.fw failed with error -2
[   12.976636] r8169 0000:0b:00.0: Unable to load firmware 
rtl_nic/rtl8168f-1.fw (-2)
[   12.977326] RTL8211E Gigabit Ethernet r8169-0-b00:00: attached PHY 
driver [RTL8211E Gigabit Ethernet] (mii_bus:phy_addr=r8169-0-b00:00, 
irq=IGNORE)
[   13.046445] r8169 0000:0b:00.0 enp11s0: Link is Down

     I would not expect the RTL8168 or RTL8169 firmware to be necessary, 
but is it?  Either way, why isn't it on the image?  I would ask the same 
thing about the bnx2x drivers, but they seem to have a bit of a history 
of being fragmented.  All that aside, how can I get this fixed in a hurry?

     This is an AMD system with an 8 core FX-8350 CPU.  The install 
image is Debian GNU/Linux 11.3.0 "Bullseye" - Unofficial amd64 DVD 
Binary-1 with firmware 20220326-11:23.  I pulled the extra firmware from

git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/bnx2x/
