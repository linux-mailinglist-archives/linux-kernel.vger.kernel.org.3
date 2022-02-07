Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10EB94AC10D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 15:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391328AbiBGOTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 09:19:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379787AbiBGOE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 09:04:28 -0500
X-Greylist: delayed 122 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 06:04:27 PST
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB3CC043181
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 06:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1644242666; x=1675778666;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Z/+CVlL3mqTgFj3zyrToq+orOMgW+WqL+lq+BPmfdZM=;
  b=1knsMkmlVC4EgAoeEbUm3LVQeZLXSs8m/dd3phVhNQoLH5sqjfc4742F
   UTzsaz6b4EphMZN7+FbLCzDZyP6YwCdGls3reOCUQUBRBhpg/dYwlQ4Iy
   oMycs6Ay+4YhEHH584iShYqZI6zuvpiHwwoUjwAlopceok8Q0GnLfuGdR
   V6weieJM6JL7FloXc6S8Y9I/jGeQ62a/C6DQW2B0i40cPOLPvmp6jlYQZ
   XCwCZYTq1gOqpbQbn4UYNcaj2Ran0HXUbAI+RFuOs/X8Qd9iuZoRXvMq7
   9QNZSQ6rQx3P0gib7SYs2f1G9Wtve2N5uLikFsR3qQ2txGdPpwtRywqpf
   g==;
IronPort-SDR: IfTfJkMZmAS9CVVCaV7NUimSRktUjKglwpKNbdFyaR4I8dhj7/nDXp3iOD2pvWWq9NLNoT+MKb
 HVZ696IgFjAZE8wJThhl0LicKy7HYPZo4DNQcqMK7kQCAiLj1BrgeSuxwXRzQdWivf6QRRr6SR
 DPeP8ahSkbkShmMJ8/h7mLJVBf6N1TPkJXkNwZ1cArylmwFzlTb/zoxBQ4RWufqEphPb1rQIX5
 GZzMyYblvcZc3PprSZTke0pWtaK7JRdzRbP3j3msHHbGtKXrzDjrI1NYXh1099QKjbyuduF+En
 tOUaooe+15cScTinZHjkI9oF
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; 
   d="scan'208";a="161339149"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Feb 2022 07:01:22 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 7 Feb 2022 07:01:22 -0700
Received: from CHE-LT-I21427LX.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 7 Feb 2022 07:01:17 -0700
Message-ID: <9ac4268e0f3978203d7c3cee5b68cc3f57d2000c.camel@microchip.com>
Subject: Re: [PATCH v7 net-next 00/10] net: dsa: microchip: DSA driver
 support for LAN937x switch
From:   Prasanna Vengateshan <prasanna.vengateshan@microchip.com>
To:     Jakub Kicinski <kuba@kernel.org>
CC:     <andrew@lunn.ch>, <netdev@vger.kernel.org>, <olteanv@gmail.com>,
        <robh+dt@kernel.org>, <UNGLinuxDriver@microchip.com>,
        <Woojung.Huh@microchip.com>, <hkallweit1@gmail.com>,
        <linux@armlinux.org.uk>, <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <vivien.didelot@gmail.com>,
        <f.fainelli@gmail.com>, <devicetree@vger.kernel.org>
Date:   Mon, 7 Feb 2022 19:31:15 +0530
In-Reply-To: <20220204192906.15a0e6e0@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20220204174500.72814-1-prasanna.vengateshan@microchip.com>
         <20220204192906.15a0e6e0@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-02-04 at 19:29 -0800, Jakub Kicinski wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the
> content is safe
> 
> On Fri, 4 Feb 2022 23:14:50 +0530 Prasanna Vengateshan wrote:
> > LAN937x is a Multi-Port 100BASE-T1 Ethernet Physical Layer switch
> > compliant with the IEEE 802.3bw-2015 specification. The device
> > provides 100 Mbit/s transmit and receive capability over a single
> > Unshielded Twisted Pair (UTP) cable. LAN937x is successive revision
> > of KSZ series switch. This series of patches provide the DSA driver
> > support for Microchip LAN937X switch and it configures through
> > SPI interface.
> 
> Please CC the driver's maintainer, woojung.huh@microchip.com on the next
> version.
Woojung.Huh@microchip.com is already part of the CC list. May be
'netdev/cc_maintainers' does the case sensitive checking. I will correct it in
the next rev. Thanks.

Prasanna

