Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5FA8540385
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 18:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343893AbiFGQP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 12:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244467AbiFGQPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 12:15:22 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2043.outbound.protection.outlook.com [40.107.22.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E3C10052F;
        Tue,  7 Jun 2022 09:15:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CmOApgutBInDElnFA/bH6fPEg1MtdgWWmx0S7TMhA1W90axdkrVgxXmdYsy0cAgW9DhkqbnsC/S6qyDuqQPSjb4WLyyveIhcDjX5tgf5rTs4YO3dP0e3sgT42esW+ik374ERo1eRGheagrmBNLNaECYU/cXeOsPvQ6Oj2Jh3OTyjSJt52PoRsTl3E0NUrFQTU3WxPl+fmR8PPA7jnq74Fv8ZOdhKDQLNLKcSjcwiIXfbX0iPoMaPb8QBO9DLJOSL2UMyHWqDZMWSpm+nG90mu6DcZZdso1gofIpBPF/3NOeB+WWZEKJFjy/87cl9o+ySoyGGIE1L70aNRIMZTH5RFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RK4NmpO8yz6vHE8sU9iZQmoHn763QDLJuMaVn+2WPJ0=;
 b=njPThwymyCSeFXzsbpmo1tm5dGI9Dk2gvbRHn38am2E+AR3VS3fBLoVid/l32KCjCzi3IyooR+lgz9rBfs1etB3NxhN1S29QB+hzH/MWPwmpTdSKdd/2m26bVWpId5uEEzwuwyFmDcQT9XvKAmpMhLDcQtqBxjdVzAM72iZ2eezn8nHrCZ4h+b6LENGWDgCxBzqqtKoAExOJisRSIixjNxXHwg/pV5v4aRSJVIyQTVut+tAc6sz7vfBN9vVU7fZm9AgDMaTejGZn20URzgNiE24Q5JfWyUejGtKPtowmo8qgRNRrAq1goL+C5rDzR8krPWhUNsFKZjhbI+d12PNjEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RK4NmpO8yz6vHE8sU9iZQmoHn763QDLJuMaVn+2WPJ0=;
 b=ATlPyh/fBK2k2nmcTsfwrXa7bsJvWKmdagXBeBCZzqvlqzYCb2K/g4Z5CWCOVTaY5rJHiYhTd8ihKdGCth0LxL7aJhQtd+fV8h57aFzcZApLkN1ps+nILHJfKVoyJpT0pvYxmQDyWUozvHC51lliTiEcm0xCfwmxMXxWRkE4p11m2zO+8LhuXwKzfd02ZKXi8oXBnATats6RQmJvLTSMCfLSu/YYH6jeQKUqmsAf2Wh7xtwExtTdh+agU1D8479+pVjuOAwuyEQ9/qFPOfBePmWpyV+mMcb4BJCy8Siz3ab019e+C7GNmWcuRUkPdHopvDVvzNFWdJ/KB00xmyNITw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by AM6PR10MB2325.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:44::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.17; Tue, 7 Jun
 2022 16:15:18 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a949:4d67:8108:3599]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a949:4d67:8108:3599%6]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 16:15:18 +0000
Date:   Tue, 7 Jun 2022 18:15:15 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mark Gross <markgross@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-watchdog@vger.kernel.org, Enrico Weigelt <lkml@metux.net>,
        Gerd Haeussler <gerd.haeussler.ext@siemens.com>
Subject: Re: [PATCH v3 0/4] simatic-ipc additions to p2sb apl lake gpio
Message-ID: <20220607181515.3f1e240c@md1za8fc.ad001.siemens.net>
In-Reply-To: <Yp9sLePHn9RqcXcU@smile.fi.intel.com>
References: <20220513083652.974-1-henning.schild@siemens.com>
        <You1KI78zbXmApm+@smile.fi.intel.com>
        <Yp9sLePHn9RqcXcU@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM5PR0601CA0026.eurprd06.prod.outlook.com
 (2603:10a6:203:68::12) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c3267f1-42f7-4ffd-b7c0-08da48a0e9a5
X-MS-TrafficTypeDiagnostic: AM6PR10MB2325:EE_
X-Microsoft-Antispam-PRVS: <AM6PR10MB23254C1BCAF628B2247DAE3885A59@AM6PR10MB2325.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iZXqY9C6AawMnPodi4qlSVNAsyxgmXoGM6DIGbvIICl+IrJ1uZpgR/q/0UeAb6uPMu4gtvyB2z9sI6Tr8kd9+vFiJLDse/OYI+xAfY1jtwP1tT+SbmZuuL2fCXR1zdzTTDNKJVAMLxccBkJWOsRAqvPmCUIOFyL1/gYEfnefmka/kASyI83II+JZ23vIRU10LQ5A/UUrXlPhFeWM5fr8LqdEchwd2Q5ffnHgXZTFP5YAWs6QmT82wMJrzRjRjT0SCeDuC5YNExQxnUY2J3Y/gIXFtc4MYcFmA1fKYq9qTLgtUdSdMNc3vk2buO2OvobUYVtMVBk49yZ/AAwX5c3XH4EezmBTtM0omT087/EC2M9Ss2LTEzbXWUHCPbtBS4ELR1p3MQMce1QvRAFzSvZBkvxnH89JmZe1NY+B6gZ3uRfFNa10r9HSpdyifh9asz6vKGgDagLF9faRckUE5lB4YjQgbxVddXYJWOVwSJL0nkWOGgYEKRtQdxS5wh/hQFxe/jot3DaTK9bZkAvBk9j4J9MTgxv8GDTw91sxgG/fzjHQzN2+aTIFjMqBFppTpDxjWiwoU2Dzk/0Yd/OXMO9rRSH+eocaI/1LbdpD7eC8yiIA8cH2j4eP3QYNSHeJZX2eMX0dPcE7QlKwRLAe+7wPe6Mvcaqy8RMhUq6xCk9tZZs8UCq/8v3wz9jbjwYYI1WAPgjh/GVxuu0SsRnztMuTa2C3oBe8ygwJ6pp2bJSxRvI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(44832011)(6506007)(6512007)(6666004)(2906002)(26005)(9686003)(6486002)(86362001)(316002)(54906003)(966005)(38100700002)(6916009)(508600001)(82960400001)(66946007)(66556008)(66476007)(186003)(8936002)(8676002)(107886003)(1076003)(5660300002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GAJMkJ4CqRM+YBCe3MsgG6puDP5DCQcx0ArSxws+4ssKFrqqLIYQGRljZY3S?=
 =?us-ascii?Q?4ya2RjZNCGaKNITFNofjh4Vr+b1ubGiw7CMZxQ6TMln1c/a7bI6DBlhv7l55?=
 =?us-ascii?Q?mK6zJHCEGFDlGK3XAZUnjLPYw9klAneLP/C6H/Ure0o4BKVkTtvG4tczw5Wz?=
 =?us-ascii?Q?RyQSL0jDKtQFYKuhJoJn2KkSLsGtY4Jzvv1V/o+1rijFALNyoJm+m6SVjzLb?=
 =?us-ascii?Q?sEVBEr1HcbPT1ysoeDgNU4TW0bfZ/w5ojuTB7xjpbNckv1IavIUQcBWxACLx?=
 =?us-ascii?Q?GNrdai7qB6GwN2s83PeGlLj6oEpbQY6YhGLGM/+Az9rSFEQbpMXO6dZ9poET?=
 =?us-ascii?Q?92ioo+Ewv50CocY2n/9EYQi138XUmps/Mf54cZaFgKzNV2unz2dIZDw4T6fj?=
 =?us-ascii?Q?4MMz4lnXMXGvFW8hCKN7a/zL/xVpon5/cNlx2zvRwuZSKs5YjE1Hj0WjVB9V?=
 =?us-ascii?Q?JkFL0F+vOddLlJC5TNHZOZyadIVelg3HGej7HctcV/LGgvbrMrinFOiUYP4u?=
 =?us-ascii?Q?bwaI44XizEp/MERFdyXFO1ftrP5DoJtlyzUdXHSzCMcfc2clLLcqI8mrHeGC?=
 =?us-ascii?Q?C5RmUn1Wrtd7q1z61xbU87ysqbLS4g3Qe7bW8iPg21vvqCtff0CcndSh8dUw?=
 =?us-ascii?Q?/U4DX2L7h/DfKVBZjE2q1q1gWoqZzUOnMDQ9hrxWbljnTQTnZLze5iFVPUtj?=
 =?us-ascii?Q?s1GZz2KJXCz5jxRMOgTisZsR/mjgZZKI3RGUVy4r/0sJfbjPnCWUrMEeQ+sb?=
 =?us-ascii?Q?rrt10+kjyvAculZOkj2jCtEUaU7WXGNJKujeSsXOyIbi44GDxtoxrgxxF9HD?=
 =?us-ascii?Q?o7QyTDwXzqyS7QILAAD0AImnq0awom+K1xy+PowOaEMP1LCk3UHUD1ASeOMm?=
 =?us-ascii?Q?DhFyvqwSclXJokU+NPrw2phYVPu+AslR3SN+fBTcTUczCqPIeCc1p1Ph9/RC?=
 =?us-ascii?Q?9EPX4HDGvFSlzavEV7HcmgTQETlmUc35atCenSWyh5OJp+Tj36zi2loKsWi6?=
 =?us-ascii?Q?dSPIjb+OF8cz6wI2HYeCjnNJoQyrzc0lOasddR1xotrAwsEDv+Df6/RKJfRM?=
 =?us-ascii?Q?T7+fRY0c0uuzjuvwf5h6gBOsucpH5PhFp5pHLVGXNmooC1rqs6Gshp6UFHC3?=
 =?us-ascii?Q?POyFrwXiy7Vk1lEwi3ae2nOcQytC3L6hWI1z8ratLAMfu/XSWdoxXplLnlOW?=
 =?us-ascii?Q?c5IpHn2cL4lUm7ehXuYu7QgomNr/qQK3Ux81b0psmhIZ5KuBRazf8TdcnX28?=
 =?us-ascii?Q?lua/Uex8QRLt5kCIA7rQnBVm0CEsfiU//OT2JCJae8fS6DRYVtqkbzxJYT2L?=
 =?us-ascii?Q?pPiN7o6+mgVsbF1dD8RRUElhpmpllZ2XKWkVSPfrRww7e9xuEtXPRUgEWqGa?=
 =?us-ascii?Q?jkv+IA9CheuA6Ir//SGn7IBsMRNZUHE2A66Zhn1GWi59aKfkmNwwPUk31JTD?=
 =?us-ascii?Q?OeP12IXBuwoI3hwIkf9EzZrFVP1EpfyPapTDsWze8rpmeBWAMQr5uTan349b?=
 =?us-ascii?Q?0MrjvkPV3oyXAhnNFx9jj+dsWfW5tg3RAx7lP5Xak87Pp5OkHEG/BX3OyTQp?=
 =?us-ascii?Q?nAvZimxkNkJkvP+2APt9IIrdGandZUBuQ8Go3JIsUhCiLZK7rGgEnvsCA1OB?=
 =?us-ascii?Q?1qfpTMB1IZBWyZApbQ/XmFaroiG5Bz2Kd4rvvkI2dvjlRs+hFHUUQGW0qgas?=
 =?us-ascii?Q?0NODR90n4WSXsJClQjuKMpkbtBIIWHG0Xprf44vF0S8Q0PqkW81uN3bCYY32?=
 =?us-ascii?Q?RGuAfEmSjCAz2dZ9ruiSYvNIDIEcpgY=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c3267f1-42f7-4ffd-b7c0-08da48a0e9a5
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 16:15:18.0738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r1PqwnESrXZ2seLUYrN1rz6+ZmFnW++28tFMFBAKgRq3fsDk7V3iwfVtMMouIhNfqVfs68UbQJrYZ7xLON+PZYDfK/72Bg1pb1V5c6/5BJg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB2325
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Tue, 7 Jun 2022 18:18:05 +0300
schrieb Andy Shevchenko <andriy.shevchenko@linux.intel.com>:

> On Mon, May 23, 2022 at 07:24:08PM +0300, Andy Shevchenko wrote:
> > On Fri, May 13, 2022 at 10:36:48AM +0200, Henning Schild wrote:  
> > > changed since v2:
> > >  - put GPIO led module under same config switch
> > >  - some style changes from review
> > >  - init gpios with gpiod_get_index and drop gpiod_set_value
> > >  - drop bogus "if" from watchdog Kconfig
> > > 
> > > changed since v1:
> > >  - rebased
> > >  - split p1 into p1-3
> > > 
> > > This switches the simatic-ipc modules to using the upcoming p2sb 
> > > interface introduced by Andy with 
> > > "platform/x86: introduce p2sb_bar() helper".
> > > The series relies on these p2sb changes already applied and Andy
> > > will likely take them into his series at some point.
> > > 
> > > It also switches to one apollo lake device to using gpio leds.  
> > 
> > Hmm... This series misses LEDS maintainer. Okay, I will include
> > them when sending v6 after v5.19-rc1.  
> 
> I have sent v6 [1], please make sure everything is okay.

I received that and had a quick look over my bits. That all looked like
i sent it so i have no reason to doubt it would be working as expected.

In the coming two weeks i will not be able to get my hands on hardware,
so can not test but am pretty sure it is not needed another time.

regards,
Henning
 
> [1]:
> https://lore.kernel.org/platform-driver-x86/20220606164138.66535-1-andriy.shevchenko@linux.intel.com/


