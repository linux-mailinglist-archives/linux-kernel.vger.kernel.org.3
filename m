Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8959530F8A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236118AbiEWNLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 09:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236011AbiEWNLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 09:11:48 -0400
X-Greylist: delayed 78 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 23 May 2022 06:11:39 PDT
Received: from relay1.mymailcheap.com (relay1.mymailcheap.com [149.56.97.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329A32B25A;
        Mon, 23 May 2022 06:11:39 -0700 (PDT)
Received: from filter1.mymailcheap.com (filter1.mymailcheap.com [149.56.130.247])
        by relay1.mymailcheap.com (Postfix) with ESMTPS id B600B40003;
        Mon, 23 May 2022 13:11:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by filter1.mymailcheap.com (Postfix) with ESMTP id ACF512A384;
        Mon, 23 May 2022 13:11:38 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at filter1.mymailcheap.com
Received: from filter1.mymailcheap.com ([127.0.0.1])
        by localhost (filter1.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 61LqDDjP-nmA; Mon, 23 May 2022 13:11:37 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter1.mymailcheap.com (Postfix) with ESMTPS;
        Mon, 23 May 2022 13:11:37 +0000 (UTC)
Received: from edelgard.icenowy.me (unknown [59.41.161.142])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id 3F1A64042B;
        Mon, 23 May 2022 13:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1653311497; bh=ZutgL7LOgqqHUCKuYJdshLLeyN4NpumMkRbXwFtmIWc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=yjUX9FRtcElJQqRI5wkYcvgURnlwV4EdggER7NXIYqk8SKGq0ot/i89qWil3fL0R7
         7Z8tWHd6ZjO5WC0ikmZaVBuEEQTGEo4H54EvJtil4v8Cw/zGo8DBYbuXsMP9xBxa6x
         IJPGTXykbmMb3D96TPfo3I1KfW805+3cjUSxDeiM=
Message-ID: <a50307f826e8e5f4218bd2bfde23add8a26af0dc.camel@aosc.io>
Subject: Re: [PATCH v4 0/2] ARM: sun8i-r40: Enable usb otg support
From:   Icenowy Zheng <icenowy@aosc.io>
To:     qianfanguijin@163.com, linux-sunxi@lists.linux.dev
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Evgeny Boger <boger@wirenboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 23 May 2022 21:11:29 +0800
In-Reply-To: <20220518101706.26869-1-qianfanguijin@163.com>
References: <20220518101706.26869-1-qianfanguijin@163.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2022-05-18星期三的 18:17 +0800，qianfanguijin@163.com写道：
> From: qianfan Zhao <qianfanguijin@163.com>
> 
> History:
> =======
> 
> v4(2022-05-18):
> - Enable both musb and OHCI/EHCI support
> 
> Tests:
> ======
> 
> All test cases were tested on bananapi-m2-ultra.
> 
> 1. USB DEVICE(ping test)
> 
> Enable usb gadget rndis network, ping m2u on ubuntu host:

Interestingly musb previous totally fail when I initially work on R40.
Maybe some phy-sun4i-usb patches fixed it by accident?

> 
> ➜  ~ ping 192.168.200.2
> PING 192.168.200.2 (192.168.200.2) 56(84) bytes of data.
> 64 bytes from 192.168.200.2: icmp_seq=1 ttl=64 time=0.544 ms
> 64 bytes from 192.168.200.2: icmp_seq=2 ttl=64 time=0.269 ms
> 64 bytes from 192.168.200.2: icmp_seq=3 ttl=64 time=0.300 ms
> 64 bytes from 192.168.200.2: icmp_seq=4 ttl=64 time=0.295 ms
> 64 bytes from 192.168.200.2: icmp_seq=5 ttl=64 time=0.283 ms
> 64 bytes from 192.168.200.2: icmp_seq=6 ttl=64 time=0.226 ms
> 64 bytes from 192.168.200.2: icmp_seq=7 ttl=64 time=0.246 ms
> 64 bytes from 192.168.200.2: icmp_seq=8 ttl=64 time=0.204 ms
> 64 bytes from 192.168.200.2: icmp_seq=9 ttl=64 time=0.302 ms
> 64 bytes from 192.168.200.2: icmp_seq=10 ttl=64 time=0.249 ms
> 64 bytes from 192.168.200.2: icmp_seq=11 ttl=64 time=0.459 ms
> 64 bytes from 192.168.200.2: icmp_seq=12 ttl=64 time=0.232 ms
> 64 bytes from 192.168.200.2: icmp_seq=13 ttl=64 time=0.275 ms
> 64 bytes from 192.168.200.2: icmp_seq=14 ttl=64 time=0.243 ms
> 
> 2. USB HOST(OHCI)
> 
> Connect an usb serial port on OTG port, nex t is the kernel log:
> 
> [   27.824137] usb 2-1: new full-speed USB device number 2 using
> ohci-platform
> [   28.865504] cdc_acm 2-1:1.0: ttyACM0: USB ACM device
> [   29.565509] cdc_acm 2-1:1.2: ttyACM1: USB ACM device
> 
> 3. USB HOST(EHCI)
> 
> Connect an usb storage on OTG port, next is the kernel log:
> 
> [   17.754147] usb 1-1: new high-speed USB device number 2 using
> ehci-platform
> [   17.955995] usb-storage 1-1:1.0: USB Mass Storage device detected
> [   18.024497] scsi host1: usb-storage 1-1:1.0
> [   19.035091] scsi 1:0:0:0: Direct-Access     General  USB Flash
> Disk   1.0  PQ: 0 ANSI: 2
> [   19.049717] sd 1:0:0:0: [sda] 7831552 512-byte logical blocks:
> (4.01 GB/3.73 GiB)
> [   19.060873] sd 1:0:0:0: [sda] Write Protect is off
> [   19.071018] sd 1:0:0:0: [sda] No Caching mode page found
> [   19.076437] sd 1:0:0:0: [sda] Assuming drive cache: write through
> [   19.093566]  sda: sda1
> [   19.103492] sd 1:0:0:0: [sda] Attached SCSI removable disk
> 
> issues:
> =======
> 
> The system power often turned off when I plugged an usb device into
> the OTG port.
> It's not clear why.
> 
> qianfan Zhao (2):
>   ARM: dts: sun8i-r40: Add USB0_OTG/HOST support
>   ARM: dts: bananapi-m2-ultra: Enable USB0_OTG and HOST support
> 
>  .../boot/dts/sun8i-r40-bananapi-m2-ultra.dts  | 39
> +++++++++++++++++++
>  arch/arm/boot/dts/sun8i-r40.dtsi              | 34 ++++++++++++++++
>  2 files changed, 73 insertions(+)
> 


