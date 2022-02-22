Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062964BF409
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 09:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiBVItM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 22 Feb 2022 03:49:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiBVItK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 03:49:10 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0AE3A2F36;
        Tue, 22 Feb 2022 00:48:42 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 21M8mVGO1021748, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 21M8mVGO1021748
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 22 Feb 2022 16:48:31 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 22 Feb 2022 16:48:31 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 22 Feb 2022 16:48:31 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::a0f1:14d7:38a1:7026]) by
 RTEXMBS01.realtek.com.tw ([fe80::a0f1:14d7:38a1:7026%5]) with mapi id
 15.01.2308.021; Tue, 22 Feb 2022 16:48:31 +0800
From:   Ricky WU <ricky_wu@realtek.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "kai.heng.feng@canonical.com" <kai.heng.feng@canonical.com>,
        "tommyhebb@gmail.com" <tommyhebb@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mmc: rtsx: add 74 Clocks in power on flow
Thread-Topic: [PATCH] mmc: rtsx: add 74 Clocks in power on flow
Thread-Index: AQHYJ7nTpeKajlBmYU+vTOb/+dRQe6yeqeWAgACTEEA=
Date:   Tue, 22 Feb 2022 08:48:30 +0000
Message-ID: <90844cba1cb64571a8597a6e0afee01d@realtek.com>
References: <fb7cda69c5c244dfa579229ee2f0da83@realtek.com>
 <YhST32rsfl7MDv34@kroah.com>
In-Reply-To: <YhST32rsfl7MDv34@kroah.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.81.103]
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?us-ascii?Q?Clean,_bases:_2022/2/22_=3F=3F_06:23:00?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
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
> Sent: Tuesday, February 22, 2022 3:42 PM
> To: Ricky WU <ricky_wu@realtek.com>
> Cc: ulf.hansson@linaro.org; kai.heng.feng@canonical.com;
> tommyhebb@gmail.com; linux-mmc@vger.kernel.org;
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] mmc: rtsx: add 74 Clocks in power on flow
> 
> On Tue, Feb 22, 2022 at 07:27:52AM +0000, Ricky WU wrote:
> > After 1ms stabilizing the voltage time add "Host provides at least 74
> > Clocks before issuing first command" that is spec definition
> 
> You do have 72 columns to use here, no need to wrap this so tightly.
>

Ok...
so I need to have next patch to fix this format?

> >
> > Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
> > ---
> >  drivers/mmc/host/rtsx_pci_sdmmc.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c
> > b/drivers/mmc/host/rtsx_pci_sdmmc.c
> > index 2a3f14afe9f8..e016d720e453 100644
> > --- a/drivers/mmc/host/rtsx_pci_sdmmc.c
> > +++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
> > @@ -940,10 +940,17 @@ static int sd_power_on(struct realtek_pci_sdmmc
> *host)
> >  	if (err < 0)
> >  		return err;
> >
> > +	mdelay(1);
> 
> What is this delay for?
>

Spec definition, need to wait 1ms for voltage stable
and below mdelay(5) is our device send 74 Clocks time
 
> thanks,
> 
> greg k-h
> ------Please consider the environment before printing this e-mail.
