Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25B8646F97F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 04:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236241AbhLJDNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 22:13:55 -0500
Received: from m2mda239.as.sphere.ne.jp ([210.136.9.239]:57623 "EHLO
        m2mda239.as.sphere.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234022AbhLJDNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 22:13:54 -0500
Received: from m2kbo001.p.as.sphere.ne.jp (m2lb000.f.as.sphere.ne.jp [172.16.116.10])
        by m2mx401.p.as.sphere.ne.jp  with ESMTP id 1BA3AH8c002587;
        Fri, 10 Dec 2021 12:10:17 +0900
Received: from localhost.localdomain (localhost [127.0.0.1])
        by m2kbo001.p.as.sphere.ne.jp (8.14.4/8.14.4) with ESMTP id 1BA3AH6Z024662;
        Fri, 10 Dec 2021 12:10:17 +0900
Received: by nttd-mse.com (Postfix, from userid 0)
        id 7F2C3811E0; Fri, 10 Dec 2021 12:10:16 +0900 (JST)
Received: from m2lb000.f.as.sphere.ne.jp [172.16.116.10] 
         by m2gwa131.p.as.sphere.ne.jp with ESMTP id NAA14630;
         Fri, 10 Dec 2021 12:10:16 +0900
Received: from m2msa402-121.as.sphere.ne.jp ([172.16.116.10])
        by m2vok402.p.as.sphere.ne.jp with ESMTP
        id vWIamcX7Zd5ItvWIamMqFu; Fri, 10 Dec 2021 12:10:16 +0900
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01lp2113.outbound.protection.outlook.com [104.47.23.113])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by m2msa402-121.as.sphere.ne.jp (Postfix) with ESMTPS id 4CA9D2940041;
        Fri, 10 Dec 2021 12:10:16 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I/lyq18rRpUYjFkc1DyoMKf0HFDdEnrSY9a72CPiTaU1XfgDr0bmwKytn+wpm/A8T4SAGALZ43JVdYkB3+8Kctguflt16JtY2NEV/a5lK5azVYw9S+bCMAYVHt0sdYHdwib75DHxsHUHlHj9egR307P/i14ji5hD1oawInGjFsAqX0OWFPUJI0MRGdcy9+rxGMcskAfdGnrEZluMm7irHp0+AoywvnmrbyIm1SCqNV4HWaIVDN90NNmHW41vA/llk+tQ5g45EW7apBZ5TVuVVMpOAQUpLoAPzV08E2D1nClY3DDfs68POACy+JB1TyMqbkxd92QYzQwjqxsyudsoJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q7d4b/M8AeRCg74sCXVJBY0ukzzJymsX4/mC9jv7cBA=;
 b=XjMS9/hCCMAn9ERP+BzOPvy9lh2srhSr4M22a8BpIQb/lulBd/XydjPpMmXXcD1pxbhHG3gpmIX0csrXXruPlM3uqFh2QBmgzEHq0/iYAtLlCJPLeWQsD7+DKzYwsZ/DJsi3l0XdD4Jpyqjb3Wmr8ITQCpCh1et3IoEEGIqHFknRqBBXk5pCpv2IullMxGZaqEt5n+u3dLlCFmF+mPiiYMgxoytQ4RGeumkQpmbpqjYO1ULVwbOGLZn9/LGUatTvIILg4EJaIjJUDi5+kCCWBgqMgCasrJo7VTfvuDOlG0uTNtDrtQIqx1g+iiFZ6cfSuPAqMiYdhGelSur1clFj6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nttd-mse.com; dmarc=pass action=none header.from=nttd-mse.com;
 dkim=pass header.d=nttd-mse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nttd-mse.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7d4b/M8AeRCg74sCXVJBY0ukzzJymsX4/mC9jv7cBA=;
 b=WBe9uluDx30HLggj1y5B87/+eMf+8c9RUpxkG8AMc5ZqHh1d6ZC4e7cPzbOFgHnqbJ/NoA0dGuw+qeHE+NdwIZxt2r+OBD37FEY2n3G7cND3qS2FijJqB8/JTm5CmBzb+FwFaCnXl7+pI+Q9IJYq9SjMqfAOFtnQ2bQSonqSmvfrEtDNBeOqIikN4vgLtuSlgsOxOsMSXw36bpEy5ekdw53nToCALY6FtxOEM+kwaKBg9NpdrksoxjG9pBAT98Lk36OWpe5eDO7VWqzBSGQGd8XJfZQyeM88fZLf+/v988mrDTGotzhhonAxObDgZVi3bSI6lMvzEh0LGuvEhCkdtg==
Received: from TYWP286MB2267.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:13e::12)
 by TYCP286MB2051.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:151::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Fri, 10 Dec
 2021 03:10:15 +0000
Received: from TYWP286MB2267.JPNP286.PROD.OUTLOOK.COM
 ([fe80::1034:9079:95bb:fffb]) by TYWP286MB2267.JPNP286.PROD.OUTLOOK.COM
 ([fe80::1034:9079:95bb:fffb%9]) with mapi id 15.20.4755.022; Fri, 10 Dec 2021
 03:10:15 +0000
From:   =?iso-2022-jp?B?GyRCPi5AbiEhPSQwbBsoQg==?= 
        <ogawa.syuuichi@nttd-mse.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     =?iso-2022-jp?B?GyRCOzNLXCEhQyM7SxsoQg==?= 
        <yamamoto.tatsushi@nttd-mse.com>,
        "Natsume, Wataru (ADITJ/SWG)" <wnatsume@jp.adit-jv.com>,
        =?iso-2022-jp?B?GyRCPi5AbiEhPSQwbBsoQg==?= 
        <ogawa.syuuichi@nttd-mse.com>
Subject: RE: invalid counter value in request_queue
Thread-Topic: invalid counter value in request_queue
Thread-Index: Adfssg136nOi2cDETFCz0vQyCAj2ZwAq7JVgAAD91uAABCR5QA==
Date:   Fri, 10 Dec 2021 03:10:15 +0000
Message-ID: <TYWP286MB2267FA87405E341A7D53B817B9719@TYWP286MB2267.JPNP286.PROD.OUTLOOK.COM>
References: <TYWP286MB226752FFC0E0E33777AB319FB9709@TYWP286MB2267.JPNP286.PROD.OUTLOOK.COM>
 <TYWP286MB226753FF279AA2953028BDA9B9719@TYWP286MB2267.JPNP286.PROD.OUTLOOK.COM>
 <TYWP286MB226710E14843B461637C4DC6B9719@TYWP286MB2267.JPNP286.PROD.OUTLOOK.COM>
In-Reply-To: <TYWP286MB226710E14843B461637C4DC6B9719@TYWP286MB2267.JPNP286.PROD.OUTLOOK.COM>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nttd-mse.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1200d0c7-0451-49e1-e7dc-08d9bb8a9656
x-ms-traffictypediagnostic: TYCP286MB2051:EE_
x-microsoft-antispam-prvs: <TYCP286MB20518CEE76AA9AD2F5C6BF63B9719@TYCP286MB2051.JPNP286.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yjccNveVWW4QhUUHKT/qgrMhdWeCKZagduH6cUDf8bN5/ABYkUjyp/spIQx1fAGmtY8i30LW2vLQI7ylFJR7NHYOeq2p01lvXs+pD7khtwwbvjowkpuEMVTGAvM1fabfVibal02THMdaUkeAhbmVgDqODxnVeoJ2wxSxr+aSNI2egcJbDbsvsoa2ouLHQC5PZpdyWhMV23gDAUpsGbIAjIdoOI3nKllP/hWxz+fBjh9FxNj42tO2ADxnX1crG8+gQ8ClWveW2cC/tsGFOXiXFRIeIfD0o21nBU7PxsAk+eTkN29P/JJbavmPayDZ3Z6dN3n9Go75fuVBcRST2Lmeu6yAPYreZbTQLI3CZ5BKTOQgAJXhqdC9Eo4c1Ao0giOUT0jtVESmO+xI3luHiapykyU8XqugFD4wfDgKn9y4pwZoDdVV5doE0h7RrAd3wc/hD83gVae+bJnJCfAGNh8W15i6Hgy22+hBSqW4nlvjRlFJAcRBwyIO/qGGk5WD57fDl5v97qDu8MuaRo6OOJL2W3d8GbBzYDVHH3tQufQIF1MMacMDOmjY9YMyxcoi2XjhCEPiExB7+efn7fTUhAVtzhALOBXsq/HgQf1Ba33Vw5lHeRaMbcWw9tss9209ro/LQcHTX0EmJ2dEJ0ITxvgcQlADB0TLCaiy7E++JIQ85viX/s6oBMIrUC/37Pzl/aAl7tFG7vm7fyFgZUnWD+R6Bg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2267.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(2940100002)(4326008)(107886003)(76116006)(66446008)(86362001)(66946007)(64756008)(66476007)(66556008)(52536014)(8676002)(6916009)(82960400001)(54906003)(316002)(55016003)(83380400001)(33656002)(2906002)(122000001)(85182001)(186003)(5660300002)(38100700002)(9686003)(38070700005)(8936002)(53546011)(71200400001)(26005)(508600001)(6506007)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?VnlRcmZqYUVreWhPNlVXSmg4WFRMRjlkbTh1TStBQ28wRXVydTNQMGZ4?=
 =?iso-2022-jp?B?QWIya1htdWl5K2FZaW1wdFplOGozMWVoZnB2MGpmMytiN2VtM2ZmRHRr?=
 =?iso-2022-jp?B?cVVKOTh4UVM1cHE3YnZwd2lJZGhVek9XQ1ZVd3YzYU9TWGxJR2hZYmFM?=
 =?iso-2022-jp?B?N3BSdndhRGtuUXpmZjV3cTVxeC9CSVF1WU9qcXN0dHhSWDYwOVZ0aDcv?=
 =?iso-2022-jp?B?aWgxMDFiNVg2Rk9MSTArd2ttamZGTWJuVlpwU0ZzNFEzajhoT3E2c3FI?=
 =?iso-2022-jp?B?M2pkTmhpeDNhSGRhbkw5dGo5V283UUZWdmJFMDIyMVVGZSt3ODI0cnRQ?=
 =?iso-2022-jp?B?NzgwWjdGeUgzZm16L3BjekJ1Q3dHVENDYXI4SzZCc080ejd2WlB4S3g0?=
 =?iso-2022-jp?B?SDdJNUxwWXA2UGlKU0p4ZGdyRWFKSGpPU2dTY0ZDbWZ0N2tpSlBXZWFX?=
 =?iso-2022-jp?B?dlRwYzIwaGxXN3ZZWDBrMExoeW5KSCtIV1BFUDRZNU1NRWdzSlYxckxW?=
 =?iso-2022-jp?B?ZGJIVmN4bmpiM0xIWEdIZitFVHR4NUZWUFcwL0tjKytLUGVKZXZ5d1RQ?=
 =?iso-2022-jp?B?WkJwamRIS2c4L0VCak1pZ1puSWUwUTJRd2gxam5GcXgzcndKS1crbWVq?=
 =?iso-2022-jp?B?NXVlRE1GZTFIOGowT2dMaWZXTDFZVU55dkhZVEJsWG5uaitoZ094emFr?=
 =?iso-2022-jp?B?YmxTU1ZTRWpGY1FNRFpoTTRZQVFvcTVKUHpQcTd4NlJYUVdCRXI4em0w?=
 =?iso-2022-jp?B?YlFKVkpReSswUTE0MGFnUjJzcks0b3VYMDNPOHJkVm1rRndjeFZ5WnhS?=
 =?iso-2022-jp?B?c0c1NEZsQ3ZxUGZnTmkzb3g0YU1RUUE3cFRFZlcvQlFZQ1pyZ2NLSzZk?=
 =?iso-2022-jp?B?MCs3VXRjRzY5VlZwM01BdnREeHBWTkdQakdGZnJ3bVZzN3VPSlR3MVFr?=
 =?iso-2022-jp?B?N3FRZ2ErdXZrd0l4L0V3TlV2UlF2czBaSGxxTGFSUkNDT1lndXU4YldV?=
 =?iso-2022-jp?B?MHBDeVpZVVFyektkL3RNV1FGUFpueW1OYUNBVGtheWsxaGJwVE0zb2dM?=
 =?iso-2022-jp?B?djNoUlNqR3VZRUh1bGpmOHhSQzg2ZFRReHRDMTJKdi9kOHUyQjJkeXpu?=
 =?iso-2022-jp?B?Wkk4TkpHd1l3L2ZDdktHcmVCMElMTHJzemJ1WVowZDdFaWhSREh6b2Jt?=
 =?iso-2022-jp?B?WnhWZGRYazN5OEw3OHlmN0l1bkMxdUlNSlUvVTFja1Y0Z3drVUhpWW90?=
 =?iso-2022-jp?B?WEZ0VnVyUXNMaU4ycWd5Ylc5a3EySlJkYjg5SHUzWldFVG45T043cjYz?=
 =?iso-2022-jp?B?UlErcndGUHR6UnFFdzE2dEhsQ0twYzE4OTFaNldXMUZNM2o5MTJjTU8v?=
 =?iso-2022-jp?B?dEQrcUtZei9KMGdLS3d1bVBrcnZwa2lBSHJUUHVXcXdySDZhRkZIUVhz?=
 =?iso-2022-jp?B?NWFZUTRPdlBrUS9mYi9rTVg1clFtS3pncWlSZU40QWYySUhNRFdTR0g2?=
 =?iso-2022-jp?B?aXdEU0NtZlVrV0s5VnoyK2IxVEJnOFR0UEE4aFNEUUMrZjlKSW9INDRH?=
 =?iso-2022-jp?B?RHFVamlYbUVWMEdKSGo2UG52N0xqQlNvZ09FUVA1QXIrc01lcVJpbzQ3?=
 =?iso-2022-jp?B?bG5wK2RNV3Ryd2xtMFBPSE1JQ0w4TDFwY2c0dzFTbjdNa0VzV283MnNY?=
 =?iso-2022-jp?B?RUdvUkdzdEVQazZqUVR1ZmxibVBHM3BOdklvYmFGMEtKTk55OHVCeGZU?=
 =?iso-2022-jp?B?ZUFxYWoxREV4OU5EWWlaMXgyRkdoU2N2SXovcURnVXJrVlFaUDVtSVg0?=
 =?iso-2022-jp?B?OFVmZ3NMWWtzamljREtkT0FyQlNtT0pFRFZBZmpxNnBJb3k0UHdOSU1h?=
 =?iso-2022-jp?B?bm1OYkJYL210Y3c4akpiYUp0MTUvZ0krcStPbXFHQVh4RnZVakswYitx?=
 =?iso-2022-jp?B?cWFDbTZZaFV3UHFTdUJyRzZjdWdkL0ZwelV5ZThvSlJFSXhUcyszeEYr?=
 =?iso-2022-jp?B?c3B5T1ljejZSV0l2OUNzQ3VIblM0WnRUTGgrTkNCdUxMeHZmb21kVWNI?=
 =?iso-2022-jp?B?YzRkMmFaMEwxRHBpU1ltc2FMOUlDb0lVNWcrcEtUb0c5VnNBU2xkTjQ3?=
 =?iso-2022-jp?B?TjJBTkV2amcybmw2Q3p4aGlkOXNRYU5zdHRJeWhkajJWQlBEeEpZOHN0?=
 =?iso-2022-jp?B?eUNwTUVZVmZhdDZja2pwK1M5MnloWjE5ZzA5T2RQUHdxcks1QWVRdFgr?=
 =?iso-2022-jp?B?MzVoK21TcHNSanVnRE9HZGc3ajBjRmNPTHREWUxGY3ROa1BwaTdKa01L?=
 =?iso-2022-jp?B?bDBwclkwT2FQbTZrM29xemtpTGhiN2hxRi9tWGt5VTV4NWpuS0J3bDEy?=
 =?iso-2022-jp?B?Z25IQk0wQWljaldJRkowVTR2V3lYS2d3cGtBcW5scDJzckNJV08xQUtB?=
 =?iso-2022-jp?B?dlc4WGl3PT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
content-transfer-encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nttd-mse.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2267.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1200d0c7-0451-49e1-e7dc-08d9bb8a9656
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2021 03:10:15.0888
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6f1f471a-dbdb-48eb-a905-2d249e046ae5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I3DPoGbw5TOMu2fD183/+F3QgmdORIuQQgUdU9UtbiPT4bA5xNDoPcK+VfbB3OFqx9vTyouGfroLkJdNyBmTzFXWh/qOwb3QTpr9ocYCnj8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2051
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OK, I understood the logic roughly:=0D=0A=
=0D=0A=
-- negative value is OK. all values in each percpu_count_ptr are sum up a=
t percpu_ref_switch_to_atomic_rcu() and store into atomic_t count.=0D=0A=
-- atomic type is prefer to percpu type for some device to avoid RCU sync=
hronization. then keep atomic.=0D=0A=
  But percpu access is less SMP synchronization than atomic. Now my syste=
m took percpu type=0D=0A=
=0D=0A=
Finally, no problem. Thanks=0D=0A=
=0D=0A=
Best regards, shuichi ogawa=0D=0A=
=0D=0A=
-----Original Message-----=0D=0A=
From: =1B$B>.@n!!=3D$0l=1B(B <ogawa.syuuichi@nttd-mse.com> =0D=0A=
Sent: Friday, December 10, 2021 10:07 AM=0D=0A=
To: linux-kernel@vger.kernel.org=0D=0A=
Cc: =1B$B;3K\!!C#;K=1B(B <yamamoto.tatsushi@nttd-mse.com>; Natsume, Watar=
u (ADITJ/SWG) <wnatsume@jp.adit-jv.com>; =1B$B>.@n!!=3D$0l=1B(B <ogawa.sy=
uuichi@nttd-mse.com>=0D=0A=
Subject: RE: invalid counter value in request_queue=0D=0A=
=0D=0A=
I forgot to take care gdb-script about ATOMIC mode in percpu_count_ptr.  =
 I fixed the script then I got:=0D=0A=
=0D=0A=
super_block 0xffff9bb3f8bbcc30 "vdb"=0D=0A=
 q=3D(struct request_queue *) 0xffff9bb3fb53d1c0,q->q_usage_counter.percp=
u_count_ptr=3D(unsigned long *) 0x3a80c000b2b9=0D=0A=
 0:0xffffd634bfc0b2b8,0x0,0=0D=0A=
 1:0xffffd634bfc8b2b8,0x0,0=0D=0A=
 2:0xffffd634bfd0b2b8,0x0,0=0D=0A=
=0D=0A=
Result is as same as previous my e-mail.=0D=0A=
=0D=0A=
-----Original Message-----=0D=0A=
From: =1B$B>.@n!!=3D$0l=1B(B =0D=0A=
Sent: Friday, December 10, 2021 9:54 AM=0D=0A=
To: linux-kernel@vger.kernel.org=0D=0A=
Cc: =1B$B;3K\!!C#;K=1B(B <yamamoto.tatsushi@nttd-mse.com>; Natsume, Watar=
u (ADITJ/SWG) <wnatsume@jp.adit-jv.com>=0D=0A=
Subject: RE: invalid counter value in request_queue=0D=0A=
=0D=0A=
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
You can find percpu_count_ptr has a bit __PERCPU_REF_ATOMIC=3D0x1 per cpu=
 counter looks not used=0D=0A=
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
From: =1B$B>.@n!!=3D$0l=1B(B <ogawa.syuuichi@nttd-mse.com>=0D=0A=
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
