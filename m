Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6C5C46F83A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 02:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235085AbhLJBIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 20:08:39 -0500
Received: from m2mda239.as.sphere.ne.jp ([210.136.9.239]:51243 "EHLO
        m2mda239.as.sphere.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbhLJBIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 20:08:38 -0500
X-Greylist: delayed 656 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Dec 2021 20:08:37 EST
Received: from m2kbo002.p.as.sphere.ne.jp (m2lb000.f.as.sphere.ne.jp [172.16.116.10])
        by m2mx401.p.as.sphere.ne.jp  with ESMTP id 1BA0s5bb029310;
        Fri, 10 Dec 2021 09:54:05 +0900
Received: from localhost.localdomain (localhost [127.0.0.1])
        by m2kbo002.p.as.sphere.ne.jp (8.14.4/8.14.4) with ESMTP id 1BA0s5hU031401;
        Fri, 10 Dec 2021 09:54:05 +0900
Received: by nttd-mse.com (Postfix, from userid 0)
        id 04808811D9; Fri, 10 Dec 2021 09:54:05 +0900 (JST)
Received: from m2lb000.f.as.sphere.ne.jp [172.16.116.10] 
         by m2gwa131.p.as.sphere.ne.jp with ESMTP id KAK29364;
         Fri, 10 Dec 2021 09:54:04 +0900
Received: from m2msa401-121.as.sphere.ne.jp ([172.16.116.10])
        by m2vok401.p.as.sphere.ne.jp with ESMTP
        id vUAmmy5LZdkYfvUAmmiVnv; Fri, 10 Dec 2021 09:54:04 +0900
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01lp2171.outbound.protection.outlook.com [104.47.23.171])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by m2msa401-121.as.sphere.ne.jp (Postfix) with ESMTPS id A54C0AC0052;
        Fri, 10 Dec 2021 09:54:04 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eyMz1L4ixwaXO5KcvqPJyAfgE5IEkFmYDCEzkpqvjwrzYxbPiGW9PjX66bpVFY4LOPpchEGADp8AWD0UCufFlZpaiQgY2XmcHBXWvEENTMVpYJ6t5j67cDxrBG5DStYWarzZ8kwuccEFTjoaivMUb4l3dvqF34COm2Rz8DGOb/tLo5Khc5zr5ims+RA02lmEB8oBdmPqWHj6b8vMkxxB+slgOdszI2Bt8Mx6EICK/O5Vq/30vHzziqeCkWyUzpeXGMDlx2irbw8fiIVXUlaLJok2qsVvAdMQQt06xURQRKHLsNRtyqiJRaAc7NUPBYB2RSDKPMjrHsOrxZe8ow0slw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WQmKSFi3/W6n8n5k+Sqe/J4+i01dRvv4/+WBwcajRfA=;
 b=kv8Z+aK5OJjWL2GnzYyJliZJJ3fktDR721sVxjy7mWuZDu0lpxaZTRDZw9gDM6OqvQelN0/IPj+hvp/f4xfmap2Xjz3b5oLJxx1BWRykwJ8/ZpXhxlRezJFYaTRyTFAxCUuv3O7DEcYw++jbOVHUURM9C/E9HSY6bnhd00k3tHmlqKNuZEw57Lx/vanrKJqbPb0uHXDrhu6kwLvXxqRGDTadW+dmcHSgxra61yr2yDZ3LQG3AONWXK/3uHFBWSbDvwsGVffvXjqqLDpfw6o1X9sbJZjFjJ0lv4NDroHiXeSEnktQsnfdRnlyJnAMtY/7/5xpVQnQoIDq8PGucbD0HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nttd-mse.com; dmarc=pass action=none header.from=nttd-mse.com;
 dkim=pass header.d=nttd-mse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nttd-mse.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WQmKSFi3/W6n8n5k+Sqe/J4+i01dRvv4/+WBwcajRfA=;
 b=LU7mX98MtVJQWuEoQVrODzdHz87AlylvO9gGnh3nOmMcZWItGVxmLd4WWwgzSZaNpxaf92tZxig+2Gnkbp4q3C1z0ZoPzjHDv6NiwzeaJz3GtxchGX5vYXD3Nld1YNAME6PmEHO4QK10iClgJPQAeMnxbbfez1EcFZyX0om1oPwEdY4NFxXTFdEgHfsGP+mciL9P1ZiS4zQ3FMOeFH+OfBW0AdB6jMPLsJHqF17THjNexeoCPvEh8kLB4Ov1TeYNo1LYS9bSoxCb6ejzTJ4QwJjrtBvLPu83GnhiWmORQ8tlSgRQVkWS3lwBZe8smvExyhjF0XuMmrFZ+j6K8/YW1g==
Received: from TYWP286MB2267.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:13e::12)
 by TYYP286MB1762.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:fc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Fri, 10 Dec
 2021 00:54:03 +0000
Received: from TYWP286MB2267.JPNP286.PROD.OUTLOOK.COM
 ([fe80::1034:9079:95bb:fffb]) by TYWP286MB2267.JPNP286.PROD.OUTLOOK.COM
 ([fe80::1034:9079:95bb:fffb%9]) with mapi id 15.20.4755.022; Fri, 10 Dec 2021
 00:54:03 +0000
From:   =?iso-2022-jp?B?GyRCPi5AbiEhPSQwbBsoQg==?= 
        <ogawa.syuuichi@nttd-mse.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     =?iso-2022-jp?B?GyRCOzNLXCEhQyM7SxsoQg==?= 
        <yamamoto.tatsushi@nttd-mse.com>,
        "Natsume, Wataru (ADITJ/SWG)" <wnatsume@jp.adit-jv.com>
Subject: RE: invalid counter value in request_queue
Thread-Topic: invalid counter value in request_queue
Thread-Index: Adfssg136nOi2cDETFCz0vQyCAj2ZwAq7JVg
Date:   Fri, 10 Dec 2021 00:54:03 +0000
Message-ID: <TYWP286MB226753FF279AA2953028BDA9B9719@TYWP286MB2267.JPNP286.PROD.OUTLOOK.COM>
References: <TYWP286MB226752FFC0E0E33777AB319FB9709@TYWP286MB2267.JPNP286.PROD.OUTLOOK.COM>
In-Reply-To: <TYWP286MB226752FFC0E0E33777AB319FB9709@TYWP286MB2267.JPNP286.PROD.OUTLOOK.COM>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nttd-mse.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d761d796-6633-4635-2980-08d9bb778fd3
x-ms-traffictypediagnostic: TYYP286MB1762:EE_
x-microsoft-antispam-prvs: <TYYP286MB17626F98CA5DBDA987F074E5B9719@TYYP286MB1762.JPNP286.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jyVM9+TPd4oIMo25CDHQ5V+Nh+KgEa8HmM4mGsK8Wp7Cws2pB2qUE6/rDG7PCLqz/KjpyIfndQi/PglxZcGh2Dgmy/TktzmTYwmzfm3cD25LxKcrqmtGkNHtVwP2ZqExvDC/XJaeL+r0/xUe0Ka/Q3FQm2/3WASiwqrVvkefhBYNHXpILvVDi0cesKru/3HIz+mWBdJcRk2omW2Mji0orGpYdFjjNHu0VwylZvsgrLlZVxfWDuFHnCcGpy3csXelT3Ap3zn8ybgSz4NB3tctiMnUkOzjpkKkTG53hOnsOgPFU83MwQ003Ok/tK8o/wW8gqxJ/HQ5wCjVilY7tCfAF6pukBeG+p2k18jTIzxsiXTKf+t3EDBSHZ+iHG8hD7netQysIE4Wpnn+m8UHWcnqOMKsRVri+hohUPKe0CuLwX8mQHFHirRBmCc5NQ99gHhldKYDgDAlwnlCgQe8qY6HaqiqUZLhiAVw+96g0bEbMxx9jJpxIZB5kIjf8UdeRMRi666cSOnGzKff8DfoQ6TeAsxP7RsC2gXKli9RJsilloaGo9ISnwoBTbjm3hQ+Cj7N9+VXbf5NQrNAXYIOsoOlFld8qigQt56Mwu441PkMeL0IOfXQPkEaSih7bG3eI9h1JWBIyxDgEH54T0x4PMsd1LnjTMj1CoGYcWf+yTI3/8wbA78ueviiisqYOxtJqn/WDhXF1oVZgtkqmZCweHAMfQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2267.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(86362001)(508600001)(38070700005)(33656002)(6506007)(2906002)(122000001)(9686003)(55016003)(4326008)(83380400001)(186003)(38100700002)(53546011)(76116006)(26005)(66556008)(5660300002)(54906003)(64756008)(66476007)(66446008)(7696005)(71200400001)(52536014)(85182001)(6916009)(8936002)(66946007)(8676002)(82960400001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?RFk4S1ZNOXlPOXQwZVJSZnp3RVo1aWlhUlJJYUpzalpubnJvOGhWREdX?=
 =?iso-2022-jp?B?ODJXbTIwVEd0YnJJaTJEM01mUmJxR3YzMXV4YVpSMis0NFFKMEpUNzBL?=
 =?iso-2022-jp?B?VDA4ZlBjZWo0azJBRDc5YnRuaTdaSnVSanVYaGt3OGh0N1lSc1Y4UUd5?=
 =?iso-2022-jp?B?blB1R0IrbGp3RkcxaTEzMWFlaXV1WmNIZmNYbjA0c1JPalJHUzRyRFdL?=
 =?iso-2022-jp?B?ZjE0S2dGUG51MWNWV1dYQ2krL29jRXRtUVI0M2FZM25SVGRDMUFVclhV?=
 =?iso-2022-jp?B?MElyVjF0cTlKbjhmN0lkdHk5K2tkQ0IyRE96TlArZ2w4Rjhrb0JJMkdF?=
 =?iso-2022-jp?B?QmFQaWQ0WE9RMjl4VlhUcWhiUEJEL2JSTVZ2elVQNEVuV1cwNnFJSCtm?=
 =?iso-2022-jp?B?cW9FUVlJeENRNWxXTlgrY3hoWFZrUDQ4MjJyT0d3TmdHeGRJVzNqNm40?=
 =?iso-2022-jp?B?bTJsVjJUdzV1UndTVkJlNFBKWXd4OVpZWHY5NHFVSkhJcVlEUlBaak1O?=
 =?iso-2022-jp?B?a2crZWdGN1daNHo4UTZ0ZisrekUyQWRWUWFHK0VpMjVNT09GRklRMnQx?=
 =?iso-2022-jp?B?UXdSWEVBNm5Yb0VMVEVWMWNQMlNZYmU4ZDE5cXhHNHd3SHViYTdtaWxO?=
 =?iso-2022-jp?B?K0RxMHhFZENPOVB2NHR4Y0dkN0lPYUVrWjFtaG8zenhTcDM1eXhjd0Fh?=
 =?iso-2022-jp?B?dHY4MHhLRU9GbmFvSEltNC9sSXMzWEYvTVpXSWJFN3pwZEQrS2sxSm0x?=
 =?iso-2022-jp?B?YUk2NWlUQmNEamEyVzBieHFKVVY5RGkwY2N6NUVJNDExNmRMblhwRlMy?=
 =?iso-2022-jp?B?djc5eTV6bmx6b3N4bk43QWwyQThRTVBpQkw5eTY5ZE1oREo2TElKUHcw?=
 =?iso-2022-jp?B?WUx3UURRV2JsL1JTYkJUNUVaamh5QmR4SUx6YXRBdWl5bnJWd3N2WXV3?=
 =?iso-2022-jp?B?d2gyT29JQnRjNVMvbk52T09lL2VZcXBpcTVRVGcyM2UrZnBHNDlVNndW?=
 =?iso-2022-jp?B?emdrVGtueWtnWHVQNEFNUHNVL3JtTDNaaXlMRFpTQ0xqb1IzdWJwQWdX?=
 =?iso-2022-jp?B?ZTFCZmUxUTFrV0haTFNtcjdyVzJSaWpwaUI3bXh3dEs3NEl3Nkw3Qnk1?=
 =?iso-2022-jp?B?Ly9INkdRcE10R1FwWDhZWm9sdEZIT29DdkxZYjNvd29kMW5zb1l0ZUEr?=
 =?iso-2022-jp?B?YkphTmVZRE5yQ1QvT2syc2ZvK2p5UStxMm0zQ2VKNTlsc2UzOTkrNkJ3?=
 =?iso-2022-jp?B?bEpvREFSbUhkclZXNVVmRTcxeE9udmNEcjF6R0RucERTWDc1UHViTmhw?=
 =?iso-2022-jp?B?Rm9nVldPSXNEWFFLRFRQbjFqL0JBWnByeG1sUG9hWFA4eEFicVRoSWl4?=
 =?iso-2022-jp?B?OEN2TmdCci9YNEJYdVI4OVhHdWhxeitKd1hrWjk3Q2dpSVFLRko0aDhz?=
 =?iso-2022-jp?B?SFB3enRsS0Z4djZJS2Y0RS80M2tER1dCR3E3QURUUHA2RE1MTkZJQysw?=
 =?iso-2022-jp?B?NnlWcHNNbU9yckFrWjNXQ1o2ZjdManBtMEx3NXh6cFdHbktqYTZyZlRZ?=
 =?iso-2022-jp?B?ZVl1NC9mUGo2NjZlK2NmUE5IYS9LSjdqb2ZEc2IyUXQ2Q29yMEJpMDJU?=
 =?iso-2022-jp?B?b2hFd2UwdXdjQjYwV3M4NGQ4ZUtlZ2kxVTU1bGxyQ2xqeUFUT3FFSTJJ?=
 =?iso-2022-jp?B?aUIyMXljTVlsTWhack5Mazg0UEJZTlMxNzdvOUZQL1FrZHBTYlUxZGd6?=
 =?iso-2022-jp?B?OURhaWxEM3M2Ujk1U0NBZFZwQjY1N1p5eDNyOTI2a2I5clhTSXRUZ2lX?=
 =?iso-2022-jp?B?SDNBUUxvYkJaUjBnMlpJM0ZOMWdtb21UTTU3Q1RqSXNNNnEvMXl6V2Vv?=
 =?iso-2022-jp?B?L2tueFlvek0rVm11ZUZaNlFsQkJZeklibFhLVW1NSWdOZkFodWtna2Jk?=
 =?iso-2022-jp?B?UUFtRjhLV08reC9jZWdmZmY4QXVuSlE2UWRwS3EvaW8zckt3WmVIdG1m?=
 =?iso-2022-jp?B?Tmh5bzhHK2F2OGJ4Tkx4Z0lqVFVZWEZBMVV0RUszaElxNGp2bkx4dnJ5?=
 =?iso-2022-jp?B?Y0l5TjJZa2lSZXA2Vkp4YUI3N2hNZjNKQytCaFlMOHZ4UllZNVgwSTNR?=
 =?iso-2022-jp?B?amZUMkI0WkpnSC9Ya2hiKzUvR2l3NmdmdW9hMldyYVcxa25raFUyZU8w?=
 =?iso-2022-jp?B?UFFNdk1YTGFxSWdsUjNPb0pJMU4wVDBmdDhSVTYzMTRZQ3dDblVXMm1I?=
 =?iso-2022-jp?B?UHlITnY1QUt2VGN1VDAwakpReHFxQVBwZ1lwaU4vTmh6N1MwWGpKYlVG?=
 =?iso-2022-jp?B?ZDVuQW5kRWdERENyZE5UYW1YKzZ4VjFxYmhGQ1JBZmEycmhoZ0ZKR0x4?=
 =?iso-2022-jp?B?d2xpN3RnZWxGc0xuZ3BLYnJLS2ZYSXcxdnFFbVZyZE5MN0VDNkpVRmhy?=
 =?iso-2022-jp?B?OTNEemlRPT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
content-transfer-encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nttd-mse.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2267.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d761d796-6633-4635-2980-08d9bb778fd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2021 00:54:03.6993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6f1f471a-dbdb-48eb-a905-2d249e046ae5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: htP/ItQmijVJ8TyRh+AQhHyBVt+KA8HqANWImDfadxv4j+CgcLj0RFInSehTC6v4RvwsSCoBgZmY/i5i6yS4IM61Taz6GbfB2KA11Ze2ITI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB1762
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all=0D=0A=
=0D=0A=
I understood the reason why per-cpu couner became negative.=0D=0A=
As I mention previous mail, q_usage_counter should be atomic counter.=0D=0A=
percpu_refcount has not only percpu counter but also ATOMIC counter mode.=
=0D=0A=
=0D=0A=
As fact, blk_alloc_queue_node() initialize request_queue->q_usage_counter=
 as ATOMIC_MODE like this:=0D=0A=
=0D=0A=
        /*=0D=0A=
         * Init percpu_ref in atomic mode so that it's faster to shutdown=
.=0D=0A=
         * See blk_register_queue() for details.=0D=0A=
         */=0D=0A=
        if (percpu_ref_init(&q->q_usage_counter,=0D=0A=
                                blk_queue_usage_counter_release,=0D=0A=
                                PERCPU_REF_INIT_ATOMIC, GFP_KERNEL))=0D=0A=
=0D=0A=
However, q_usage_counter becomes percpu mode at blk_register_queue() .=0D=
=0A=
=0D=0A=
blk_register_queue()=0D=0A=
=0D=0A=
        /*=0D=0A=
         * SCSI probing may synchronously create and destroy a lot of=0D=0A=
         * request_queues for non-existent devices.  Shutting down a full=
y=0D=0A=
         * functional queue takes measureable wallclock time as RCU grace=
=0D=0A=
         * periods are involved.  To avoid excessive latency in these=0D=0A=
         * cases, a request_queue starts out in a degraded mode which is=0D=
=0A=
         * faster to shut down and is made fully functional here as=0D=0A=
         * request_queues for non-existent devices never get registered.=0D=
=0A=
         */=0D=0A=
        if (!blk_queue_init_done(q)) {=0D=0A=
                queue_flag_set_unlocked(QUEUE_FLAG_INIT_DONE, q);=0D=0A=
                percpu_ref_switch_to_percpu(&q->q_usage_counter);=0D=0A=
                blk_queue_bypass_end(q);=0D=0A=
        }=0D=0A=
=0D=0A=
=0D=0A=
When I remove percpu_ref_switch_to_percpu(&q->q_usage_counter) in blk_reg=
ister_queue() ;=0D=0A=
=0D=0A=
- At least percpu counter is no longer used.=0D=0A=
=0D=0A=
super_block 0xffff9bb3f8bbcc30 "vdb"=0D=0A=
 q=3D(struct request_queue *) 0xffff9bb3fb53d1c0,q->q_usage_counter.percp=
u_count_ptr=3D(unsigned long *) 0x3a80c000b2b9=0D=0A=
 0:0xffffd634bfc0b2b9,0x0,0=0D=0A=
 1:0xffffd634bfc8b2b9,0x0,0=0D=0A=
 2:0xffffd634bfd0b2b9,0x0,0=0D=0A=
=0D=0A=
You can find percpu_count_ptr has a bit __PERCPU_REF_ATOMIC=3D0x1=0D=0A=
per cpu counter looks not used=0D=0A=
=0D=0A=
- I check again q_usage_counter.=0D=0A=
=0D=0A=
crash> p $q->q_usage_counter=0D=0A=
$1 =3D {=0D=0A=
  count =3D {=0D=0A=
    counter =3D 5=0D=0A=
  },=0D=0A=
  percpu_count_ptr =3D 64324651496121,=0D=0A=
  release =3D 0xffffffff9d44445d,=0D=0A=
  confirm_switch =3D 0x0,=0D=0A=
  force_atomic =3D true,=0D=0A=
  rcu =3D {=0D=0A=
    next =3D 0x0,=0D=0A=
    func =3D 0x0=0D=0A=
  }=0D=0A=
}=0D=0A=
=0D=0A=
atomic_t count is 5.=0D=0A=
5 is OK or NG ? I will check it.=0D=0A=
Other block device which ext4 mount on has counter=3D1=0D=0A=
=0D=0A=
Now question is =0D=0A=
   Why blk_register_queue() turn q_usage_counter to percpu mode ?=0D=0A=
=0D=0A=
I think this code has some reason to turn to percpu mode, though blk-core=
.c treat that counter as atomic counter.=0D=0A=
Does it have some problem ?=0D=0A=
=0D=0A=
Best Regards, shuichi ogawa =0D=0A=
=0D=0A=
-----Original Message-----=0D=0A=
From: =1B$B>.@n!!=3D$0l=1B(B <ogawa.syuuichi@nttd-mse.com> =0D=0A=
Sent: Thursday, December 9, 2021 1:50 PM=0D=0A=
To: linux-kernel@vger.kernel.org=0D=0A=
Cc: =1B$B>.@n!!=3D$0l=1B(B <ogawa.syuuichi@nttd-mse.com>; =1B$B;3K\!!C#;K=
=1B(B <yamamoto.tatsushi@nttd-mse.com>; Natsume, Wataru (ADITJ/SWG) <wnat=
sume@jp.adit-jv.com>=0D=0A=
Subject: invalid counter value in request_queue=0D=0A=
=0D=0A=
Hi, all=0D=0A=
I have first time to post mail, so if you have some matter, please let me=
 know.=0D=0A=
I'm studying Linux kernel, referencing kdump, to clarify system performan=
ce problem.=0D=0A=
Now I found strange value in request_queue->q_usage_counter.percpu_count_=
ptr=0D=0A=
=0D=0A=
Kernel version: 4.9.52, I checked 5.10.80 briefly, and looked similar.=0D=
=0A=
=0D=0A=
super_block 0xffff9a563820e430 "vdb"=0D=0A=
 q=3D(struct request_queue *) 0xffff9a563b948920,q->q_usage_counter.percp=
u_count_ptr=3D(unsigned long *) 0x39dbc000b2b8=0D=0A=
 0:0xffffd431ffc0b2b8,0xffffffffffffdaf1,-9487=0D=0A=
 1:0xffffd431ffc8b2b8,0x0,0=0D=0A=
 2:0xffffd431ffd0b2b8,0x2510,9488=0D=0A=
=0D=0A=
This is output of gdb script in crash commadn. Format is <cpu>:<address>,=
<value in HEX>, <value in signed long DEC>=0D=0A=
=0D=0A=
Values of percpu_counter_ptr, big value or negative value on cpu0, and po=
sitive value on cpu2.=0D=0A=
If sum up all cpus, total=3D1, it means 1 request remain in /dev/vdb at t=
hat kdump.=0D=0A=
=0D=0A=
Easy to estimate, count up cpu and count down cpu are different.=0D=0A=
I think the q_usage_counter doesn't work as reference counter to guard in=
valid disposing request queue, however I don't found to use this counter.=
=0D=0A=
=0D=0A=
System looks no problem. However I wonder that causes any troubles like i=
nvalid disposing resource.=0D=0A=
I ask you that this is really no problem at all.=0D=0A=
=0D=0A=
---=0D=0A=
=0D=0A=
As we know, this counter is reference counter of request queue access, Fo=
r example generic_make_request=0D=0A=
   blk_queue_enter(q, false) -> percpu_ref_tryget_live(&q->q_usage_counte=
r) : count up=0D=0A=
   blk_queue_exit(q) -> percpu_ref_put(&q->q_usage_counter) : count down=0D=
=0A=
=0D=0A=
If count up on cpu2, and count down on cpu0, this counter becomes invalid=
.=0D=0A=
I found 2 cases:=0D=0A=
=0D=0A=
case-1: normal case of counting actual requested I/O=0D=0A=
=0D=0A=
blk_mq_map_request() request bio to block device, then count up in blk_qu=
eue_enter_live(q)=0D=0A=
blk_mq_end_request() called at terminating I/O at IRQ context, then count=
 down in=0D=0A=
  blk_mq_free_request() -> blk_queue_exit(q)=0D=0A=
=0D=0A=
IRQ context is normally run on cpu0 in my system. so If AP requests FILE-=
I/O on cpu2, this problem is reproduced.=0D=0A=
=0D=0A=
case-2: preemption=0D=0A=
=0D=0A=
generic_make_request is not preempt disabled, then cpu may changes betwee=
n blk_queue_enter and blk_queue_exit.=0D=0A=
=0D=0A=
Now I think q_usage_counter should consist of simple atomic_t or kref_t i=
nstead of percpu_ref.=0D=0A=
System looks no problem as of now, I've not yet make any patches to corre=
ct it.=0D=0A=
If I have a chance to make the patch, I will post again.=0D=0A=
=0D=0A=
Best Regards, shuichi ogawa, NTT-Data MSE corporation=0D=0A=
