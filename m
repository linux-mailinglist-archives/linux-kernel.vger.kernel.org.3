Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89DDE4C23B8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 06:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbiBXFuj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 24 Feb 2022 00:50:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiBXFug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 00:50:36 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CFF92649A1;
        Wed, 23 Feb 2022 21:50:04 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 21O5nrkB7007617, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 21O5nrkB7007617
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 24 Feb 2022 13:49:53 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 24 Feb 2022 13:49:53 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 24 Feb 2022 13:49:52 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::a0f1:14d7:38a1:7026]) by
 RTEXMBS01.realtek.com.tw ([fe80::a0f1:14d7:38a1:7026%5]) with mapi id
 15.01.2308.021; Thu, 24 Feb 2022 13:49:52 +0800
From:   Ricky WU <ricky_wu@realtek.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "kai.heng.feng@canonical.com" <kai.heng.feng@canonical.com>,
        "tommyhebb@gmail.com" <tommyhebb@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mmc: rtsx: add 74 Clocks in power on flow
Thread-Topic: [PATCH] mmc: rtsx: add 74 Clocks in power on flow
Thread-Index: AQHYJ7nTpeKajlBmYU+vTOb/+dRQe6yeqeWAgACTEED//4JngIAAveNw//+bMoCAAxkI0A==
Date:   Thu, 24 Feb 2022 05:49:52 +0000
Message-ID: <787c804009c74f478675e7257b4858c7@realtek.com>
References: <fb7cda69c5c244dfa579229ee2f0da83@realtek.com>
 <YhST32rsfl7MDv34@kroah.com> <90844cba1cb64571a8597a6e0afee01d@realtek.com>
 <YhSl4WuE2Dpil/Zj@kroah.com> <d28b6fb6649d472a809329876c3ac4bd@realtek.com>
 <YhTwm9yDEhjEXt6H@kroah.com>
In-Reply-To: <YhTwm9yDEhjEXt6H@kroah.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.81.103]
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?us-ascii?Q?Clean,_bases:_2022/2/24_=3F=3F_04:26:00?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: gregkh@linuxfoundation.org <gregkh@linuxfoundation.org>
> Sent: Tuesday, February 22, 2022 10:18 PM
> To: Ricky WU <ricky_wu@realtek.com>
> Cc: ulf.hansson@linaro.org; kai.heng.feng@canonical.com;
> tommyhebb@gmail.com; linux-mmc@vger.kernel.org;
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] mmc: rtsx: add 74 Clocks in power on flow
> 
> On Tue, Feb 22, 2022 at 12:31:10PM +0000, Ricky WU wrote:
> > > -----Original Message-----
> > > From: gregkh@linuxfoundation.org <gregkh@linuxfoundation.org>
> > > Sent: Tuesday, February 22, 2022 4:59 PM
> > > To: Ricky WU <ricky_wu@realtek.com>
> > > Cc: ulf.hansson@linaro.org; kai.heng.feng@canonical.com;
> > > tommyhebb@gmail.com; linux-mmc@vger.kernel.org;
> > > linux-kernel@vger.kernel.org
> > > Subject: Re: [PATCH] mmc: rtsx: add 74 Clocks in power on flow
> > >
> > > On Tue, Feb 22, 2022 at 08:48:30AM +0000, Ricky WU wrote:
> > > > > -----Original Message-----
> > > > > From: gregkh@linuxfoundation.org <gregkh@linuxfoundation.org>
> > > > > Sent: Tuesday, February 22, 2022 3:42 PM
> > > > > To: Ricky WU <ricky_wu@realtek.com>
> > > > > Cc: ulf.hansson@linaro.org; kai.heng.feng@canonical.com;
> > > > > tommyhebb@gmail.com; linux-mmc@vger.kernel.org;
> > > > > linux-kernel@vger.kernel.org
> > > > > Subject: Re: [PATCH] mmc: rtsx: add 74 Clocks in power on flow
> > > > >
> > > > > On Tue, Feb 22, 2022 at 07:27:52AM +0000, Ricky WU wrote:
> > > > > > After 1ms stabilizing the voltage time add "Host provides at
> > > > > > least
> > > > > > 74 Clocks before issuing first command" that is spec
> > > > > > definition
> > > > >
> > > > > You do have 72 columns to use here, no need to wrap this so tightly.
> > > > >
> > > >
> > > > Ok...
> > > > so I need to have next patch to fix this format?
> > >
> > > Please do, because:
> > >
> > > >
> > > > > >
> > > > > > Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
> > > > > > ---
> > > > > >  drivers/mmc/host/rtsx_pci_sdmmc.c | 7 +++++++
> > > > > >  1 file changed, 7 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c
> > > > > > b/drivers/mmc/host/rtsx_pci_sdmmc.c
> > > > > > index 2a3f14afe9f8..e016d720e453 100644
> > > > > > --- a/drivers/mmc/host/rtsx_pci_sdmmc.c
> > > > > > +++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
> > > > > > @@ -940,10 +940,17 @@ static int sd_power_on(struct
> > > > > > realtek_pci_sdmmc
> > > > > *host)
> > > > > >  	if (err < 0)
> > > > > >  		return err;
> > > > > >
> > > > > > +	mdelay(1);
> > > > >
> > > > > What is this delay for?
> > > > >
> > > >
> > > > Spec definition, need to wait 1ms for voltage stable and below
> > > > mdelay(5) is our device send 74 Clocks time
> > >
> > > Clock cycles and mdelay() are not going to always stay the same, right?
> > >
> > > I really have no idea what "74 clocks time" means, is this some
> > > specific timing value for this hardware?  What is the units?  This
> > > needs to be documented better in both the changelog and in the code.
> > >
> > > thanks,
> > >
> >
> > Please ref: https://www.sdcard.org/downloads/pls/ Version8
> 
> I can not download those specifications according to the license that they ask
> me to abide by.
> 
> > And see the 6.4.1.2 Power Up Time of Host Figure 6-5: Power Up Diagram
> > of Host
> > mdelay(1) corresponds to Stable supply voltage
> > mdelay(5) corresponds to Host provides at least 74 Clocks before
> > issuing first command our device need 5ms to issue 74 Clocks
> 
> What is a "clock"?  The kernel works with time units, how does "5" equal to
> 74?
> 

spec original is
"Host provides at least 74 Clocks before issuing first command"
Let me clarify it, 
74 Clocks means 74 clock signals, our Card Reader need to issue more than 74 Clock signals to Card before first command
So mdelay(5) , our device will keep issue signal to card in this 5ms make sure over 74 

> thanks,
> 
> greg k-h
> ------Please consider the environment before printing this e-mail.
