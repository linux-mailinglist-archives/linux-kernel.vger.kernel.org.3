Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBE0F46E1BB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 06:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbhLIFFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 00:05:37 -0500
Received: from m2mda233.as.sphere.ne.jp ([210.136.9.233]:57356 "EHLO
        m2mda233.as.sphere.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhLIFFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 00:05:36 -0500
X-Greylist: delayed 742 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Dec 2021 00:05:36 EST
Received: from m2kbo001.p.as.sphere.ne.jp (m2lb000.f.as.sphere.ne.jp [172.16.116.10])
        by m2mx402.p.as.sphere.ne.jp  with ESMTP id 1B94ndKp020119;
        Thu, 9 Dec 2021 13:49:39 +0900
Received: from localhost.localdomain (localhost [127.0.0.1])
        by m2kbo001.p.as.sphere.ne.jp (8.14.4/8.14.4) with ESMTP id 1B94nc05030621;
        Thu, 9 Dec 2021 13:49:38 +0900
Received: by nttd-mse.com (Postfix, from userid 0)
        id 52F6D60BC4; Thu,  9 Dec 2021 13:49:38 +0900 (JST)
Received: from m2lb000.f.as.sphere.ne.jp [172.16.116.10] 
         by m2gwa132.p.as.sphere.ne.jp with ESMTP id PAE15913;
         Thu, 9 Dec 2021 13:49:38 +0900
Received: from m2msa401-121.as.sphere.ne.jp ([172.16.116.10])
        by m2vok402.p.as.sphere.ne.jp with ESMTP
        id vBNCmZTuZd5ItvBNCmMOPs; Thu, 09 Dec 2021 13:49:38 +0900
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01lp2107.outbound.protection.outlook.com [104.47.23.107])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by m2msa401-121.as.sphere.ne.jp (Postfix) with ESMTPS id 01AB3AC0051;
        Thu,  9 Dec 2021 13:49:38 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XlwCghzvaIVd3RO8oOzXBnfARaoP3/TT7dMMzkQZCgTML3rwqBZR31Z+ke6nhQk+3ZN9UTPBt6B1pA+YCAaATRqMkB68VL4F1EyJHPCPEXKTKeCe/yisDtCmZv1MO7gXRUBlkQ1nKB+KQwP/GDrcthMBbqMqaxI5ai1mqTIwvVuP2blSvFlQkzoRIWzhgdeTBERd5lfRpNNjxBT0T/yCB2aDXJAHWeIWwDAOl7kfZhOKDrRSV7isdy3Ta5FOr1pDT8M9iGfiFk3vpmrP4VSQa/z+NtU0bllxMVSdd9pwr+05S3kPWWsBA2wd8l+Pl+Mx0PcM50CC8YXTupJUXRO/ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c8CbTXcYWfCCjUMBpIhCUG8C1FZtLaZN+TiZi3XDxxs=;
 b=I6dq3dPC8PuLOUqOSUG8Qw4SWWe7uUOhxm/0ZZmyPUocGZClt8UWE5R7gTQG/LCMFMAgWngoD3ZzGcmMyPCifc4pxBDKm55hYmi67ggIUSesIpBVc21fZc7G5Pju4CcpRdjX9XUYrhN7cKZOBklympztxWPqmU1UKz9im41OxRnmnt0ntSJDWq2dYsqtpGPaZokZ/ald/dIsuypL5CK5hIBUeEXCH+Q/n4oXB3vfeZ5rCKOgzFUp7KjtcSjCk+/s70NPm9s216qD6TAnmR70uqZBhl/AJrshSGtaniSoHJ8cSnAfVoJJhd4SfiPLriwZlXzNZc/qnzBBHUVvTGLA+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nttd-mse.com; dmarc=pass action=none header.from=nttd-mse.com;
 dkim=pass header.d=nttd-mse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nttd-mse.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c8CbTXcYWfCCjUMBpIhCUG8C1FZtLaZN+TiZi3XDxxs=;
 b=U9Phkf3G++6jgkpIEhMq6g1BDTU2RcQQz3XyPQ5QOL3NCfRhRZKOwO10bo7sR5eMdC7bqO/+bsSlQjaQv2ywdSrHdCXbsAnJlEh2C54m5x7tBsBgs26cRUAxc00IM5ip7lEicREYnZIZHccDppG1SUInooLLaPL7KJjHkJZpkL9yTATA6iHb9i+WlVPgJM5wYdtqqcRgr3pwqoC2MjPoqUHluRpXOpk6G7ra/bXjzsMU0tT7UXEQ+NstiLZbOYrcAj6KXzlQo6v3NLPMDMOTL2w93A+SGhK2xDR2MnHAWYgIMYI/5lXhyvZ8SGIZm8HFGvWdE9ZBhkr4csXFL9FSUA==
Received: from TYWP286MB2267.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:13e::12)
 by TYCP286MB1916.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:101::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Thu, 9 Dec
 2021 04:49:37 +0000
Received: from TYWP286MB2267.JPNP286.PROD.OUTLOOK.COM
 ([fe80::1034:9079:95bb:fffb]) by TYWP286MB2267.JPNP286.PROD.OUTLOOK.COM
 ([fe80::1034:9079:95bb:fffb%9]) with mapi id 15.20.4755.022; Thu, 9 Dec 2021
 04:49:37 +0000
From:   =?iso-2022-jp?B?GyRCPi5AbiEhPSQwbBsoQg==?= 
        <ogawa.syuuichi@nttd-mse.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     =?iso-2022-jp?B?GyRCPi5AbiEhPSQwbBsoQg==?= 
        <ogawa.syuuichi@nttd-mse.com>,
        =?iso-2022-jp?B?GyRCOzNLXCEhQyM7SxsoQg==?= 
        <yamamoto.tatsushi@nttd-mse.com>,
        "Natsume, Wataru (ADITJ/SWG)" <wnatsume@jp.adit-jv.com>
Subject: invalid counter value in request_queue
Thread-Topic: invalid counter value in request_queue
Thread-Index: Adfssg136nOi2cDETFCz0vQyCAj2Zw==
Date:   Thu, 9 Dec 2021 04:49:37 +0000
Message-ID: <TYWP286MB226752FFC0E0E33777AB319FB9709@TYWP286MB2267.JPNP286.PROD.OUTLOOK.COM>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nttd-mse.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 67566b36-c2a0-440d-7e82-08d9bacf4d8e
x-ms-traffictypediagnostic: TYCP286MB1916:EE_
x-microsoft-antispam-prvs: <TYCP286MB19165D27C3FB77E939663FE6B9709@TYCP286MB1916.JPNP286.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /9XSgqsIwKl9a4XspS2gqhlp35/lEuaavcRT4eUX74VA3dvUTJqyu+IMxl3mvVeAY/k4EddpwpHeKpJ6X21fz6pRIP3o4fwSj95h0OMsgpvSUe8OTOrCnyul9c2Fp1Jza4ziz7aExcjwo0AVbZHB6WoBdqVy4ubhCdWAFxNN6F+3eln2BVGQhtSlvSOkToMf5R/BLK+XHvHO/Owt9ojrzxigDTi6ULx2vOB0zxbTnvu2fmh+BolJco4wwKPSR70E/QxYUZjeIShNogJD7uCdrJqCBbbcb43Cy2yiisIWTRrcJ8v6zeh/+pp6Xx+F4GzV9bxAX5dmxUncJ+b8+XnXMszXRg+EgElEuNOewmsowR6RLtHXajai0SBwB0CgAKRucyXynCUB62pELPIhhepMBTRVI9xZooGMiw63TLgUwwjRPqEypnkggDQHbAUgajdrEIQ65+jkdI+Q9F2pUzDZEkN3DlpBjQ3nyBwNvrRdE74Sfp5aBP50q2ZNRftGpLhUo4+0MmosFCKHar5xAxtKxh9xAoCwqZyir9yEKbFrk/p8HxEhy5f7iatnZK560HYF5UGu4c49hTxxjgF9x/UPVydu87tzO9iGL+2NuxXJSIWR6gXTSKIcGxuR78mWS6a8rj6bT4eOTgNyYTbSiQYhxg6YDOnTGh6lIVfdRsXL8fEjnrMAng+nfUlvxbCxe3i0tHo7SaklPqVmRRd3MCNHLw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2267.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(508600001)(6916009)(2906002)(38070700005)(85182001)(71200400001)(316002)(186003)(122000001)(83380400001)(7696005)(26005)(38100700002)(86362001)(6506007)(33656002)(52536014)(64756008)(8676002)(8936002)(55016003)(66476007)(9686003)(66446008)(76116006)(5660300002)(66556008)(4326008)(54906003)(82960400001)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?VUxUL0pNSkpTbVVoRkU5Q3JlaHRSZE0zRWhYL2NGMHgySXJrOWRKN1ZG?=
 =?iso-2022-jp?B?YkZQTWk5dldNczJkcVA2dXJBbFRBNDVGR0V4SDFTeWlwTTlNZVl6Q1pK?=
 =?iso-2022-jp?B?OXZ1ZXJuL0Z5NzN4Um55R2U4OEFwcEJ1eWVvd3pKbXdGcTdyUTczL25p?=
 =?iso-2022-jp?B?Z0hyWTRkUHRaYzYvS2ptZE9LZ2M0QjBOeTJkVktKbTVxV0R4WXViRnFv?=
 =?iso-2022-jp?B?K0pSSGNtWUVjRnhXSVI2Ylg5ZE13dzdWN3VGMlBJazQrZ0pIOEZQTE9Z?=
 =?iso-2022-jp?B?dzlhSWJ4NUZkZis1NW5hcXBtak4ydldQUzBLRVNRN09rV3E1NWozay9L?=
 =?iso-2022-jp?B?Skk3YlZFMkdTb0xMQmRtVnBHYXFaRWIwOGVhTXNLaGhDQWEyczdUUnNh?=
 =?iso-2022-jp?B?YWtKUG5mNkdnTUNnQWxPd2JURVBuZ2pNbTFnYlJFbjRqem5IZ0pYY1Ev?=
 =?iso-2022-jp?B?SVVNdHQ1ankrUFFDbVo4bDAwYm5kc0VaNTJ1TWxhcjJ6WE9YdTZyUzNJ?=
 =?iso-2022-jp?B?N2RlRk1HeG5xNEY0YVg1U3RoZ3NtZHM1L2NFLytwZTUzbXJIU3EzK1hF?=
 =?iso-2022-jp?B?YU1WMzlxbm1Dd2JiQ2pDczZTU3ZwcVZhY3N1czhrd2FaWGJQNldTY0p1?=
 =?iso-2022-jp?B?WWhNN0kyVVpTUURjUzVEZnBlTWl6U25RWG9HcTN0ak9UV1U2Znd5Sjlj?=
 =?iso-2022-jp?B?WjVTSlEzVnQ3M1c0NW5jRnZzUzFHbXZwM3V5TWxlSXAwc3JWMzRLRXRj?=
 =?iso-2022-jp?B?NXhSVENzUUpFajBYbWQzTlErTXh0V2NnaExTTFkvU3daUnJlOHV1N1NF?=
 =?iso-2022-jp?B?MVVtbklrNklrZTlnREZxYUNVUXk0Zlk4VkJhWFJ6RWZTdWVFVDlJNElN?=
 =?iso-2022-jp?B?cnp2YVlSdU1naDhCVUtWUVJQbUphMHBjcU9PNmpWWTFwUGZwdXliMzJJ?=
 =?iso-2022-jp?B?YkRFWkNUT1Fyc0tmUUFnbkxtU1NIQk1EU2dqMHBEclRzdnNNeDNJTUN0?=
 =?iso-2022-jp?B?Tk1RR3JlMWkrd2ZsZnBRNUZlNURtcm1mUDhlU00xWm4vSHlEYmlQbnpk?=
 =?iso-2022-jp?B?Y3BpazNqSTI5MlY2MlU5UVJrVUI2dmJXYndLdCtJd0RhclZ0VXZrVWx5?=
 =?iso-2022-jp?B?NFF2Vy83d1RETVR6SS9FSmlTVnN4SW4ySk9pYkM5ZjJwSzZqZjVYcUNr?=
 =?iso-2022-jp?B?d3FkWEVUcmpHYVMyZmVVTUx6VUdscUtLTHp4Y3JqTmhldXBJUmMxalRq?=
 =?iso-2022-jp?B?K0phdXh0VHQvVWZ6Umh0bG42R1UwU1lBajF5SThlbUU5QXUzc0dkR0NK?=
 =?iso-2022-jp?B?N05vM3dua2tmc1M3d0Q0Q3hLRk10eUZDU0Ryc2drR2szNTR1djJuYmxK?=
 =?iso-2022-jp?B?SFRJRUhVdnBJWElpWVRWUG1ZL0F2RFlLUm5ibkRYdXdUNXg4RWJBYmFn?=
 =?iso-2022-jp?B?aTB5TTZjaEV6Qnl3elVqejNGZ3B1bG81NStaTEF2dEY2TjVDMTNYbWQr?=
 =?iso-2022-jp?B?M3pUNlhOZXdWeUxvbFA5UWJBdnpOdzFhV2VIMnF2Sm5NWGU4VTcrZ2Qz?=
 =?iso-2022-jp?B?ODl6N3QvRDhTZEVwb01hcW1vQXh6VStMazlBajROQmhuU3RDM1lKRkN6?=
 =?iso-2022-jp?B?cXdiaGduQVQvdDNlUHZoMGpCVlZOZlBzTG5HbUo0VXVxek5DY1pRUmMy?=
 =?iso-2022-jp?B?S1Uxclp6WUsvSEVXU0EwZjJLeFJ6VUd5SnV0T1dsYTA5L2ZDZmVjRkpv?=
 =?iso-2022-jp?B?bjlwSGFYTVFRVlJ5dzR5REx6YzE5MjUreHhPM3lNd28rbFZxbGlPRE9m?=
 =?iso-2022-jp?B?cE9zRG5CUG9NdXA4cXdkdlpkRThiVlVlNm9RYmU5ZzJDUi9wUXFtU1pQ?=
 =?iso-2022-jp?B?OEZmSCtmLzRpOG1TTlRZb2U1eVBmZStqUTFXUzV0Si9qVWZZNlQvMitL?=
 =?iso-2022-jp?B?Qjk3WlNQS0ZEZXZNb2k1d0xuT25XaXV6MTcxZGEwMDFYVDRsZTJVU0Ni?=
 =?iso-2022-jp?B?eEhSaCs3T3BKOWRlaDYyaVFjbjhzTm5lVHJVSjhlVXlsY2ZnNksxUUFH?=
 =?iso-2022-jp?B?a09tTkVHU0d6d1kxRWdhaWpvbDFNOXc1L2U4dTgrL204WitHNkVjUHRo?=
 =?iso-2022-jp?B?WG9vZUw0UlFvSHo2ZDh2RU80L0xVa1k3T1hPanc1SnpUUm04WEMzU1pN?=
 =?iso-2022-jp?B?TUd1Vi9aaWlZT1lrRGVhWHFhY3UyV2Q5ajhnOGR1S0VhOGJPUzRveFRR?=
 =?iso-2022-jp?B?VGI1MXJUZUo2cDVPK1dLa0tqcUlWOWd2blRUNEg5Wm94b1h6NGVmU05P?=
 =?iso-2022-jp?B?SFpTTlJjb0Ntc29zZGp2T09PVDhraGYzeFFGQ093NW1YSE8xdVpPQ3Fp?=
 =?iso-2022-jp?B?WXNEdmR1VEU0VHJMYVNJNkw1cUNxKy9uVWhMTXZyOFpQTHRXRmVOUXZW?=
 =?iso-2022-jp?B?VjUwRzNBPT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
content-transfer-encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nttd-mse.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2267.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 67566b36-c2a0-440d-7e82-08d9bacf4d8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2021 04:49:37.1408
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6f1f471a-dbdb-48eb-a905-2d249e046ae5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l64uUdp6KvOFuGSxl/4zuSx11KQqVubfUcNT6piS+BFaFRbd1U+8oC+WzXPAv0orgOfMVJk1sCtBLxo5V88HjftVZroXdaAU26ItqyqDnjQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB1916
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
r example=0D=0A=
generic_make_request=0D=0A=
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
n=0D=0A=
blk_queue_enter and blk_queue_exit.=0D=0A=
=0D=0A=
Now I think q_usage_counter should consist of simple atomic_t or kref_t i=
nstead of percpu_ref.=0D=0A=
System looks no problem as of now, I've not yet make any patches to corre=
ct it.=0D=0A=
If I have a chance to make the patch, I will post again.=0D=0A=
=0D=0A=
Best Regards, shuichi ogawa, NTT-Data MSE corporation=0D=0A=
