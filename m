Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54D38464C83
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 12:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348899AbhLALZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 06:25:01 -0500
Received: from esa6.fujitsucc.c3s2.iphmx.com ([68.232.159.83]:64017 "EHLO
        esa6.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237895AbhLALY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 06:24:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1638357696; x=1669893696;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=32NxCpgTN7zfc8hYHPKkppSlj0jTbudHwdUy289uCFw=;
  b=AMje4fr8lmrwSOnVBaMSrnyUcOkCE26So9PYFd6dA1UO3CgvV9q/+xgZ
   SzJY+ToVBNPKe+MHG11S7S7RQhbbFBQdOJfGpKZjZ+7og9TxPB/WCvArN
   TLT2VFpkgfRaNJiN2q7yz/mbec+3jURQt/K8S+nQFMFFVP4NT/Fb7e3fp
   uBShYjG/3vla7ZWGqrHiAwFABoUHCe8H8USiiXjzX8XxnJzEFSWk/fdn0
   gPLrhn/XVwBnyjvMJOE7qvHh0djhJLW5hhUT0SALNin8CgccQBTwVR2UJ
   /5p+Y0JatjNjs2o7FEtn9tDkXwMSCcdiKWDz948N7Hl+jZ0yXaAZ0cE7y
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10184"; a="45004395"
X-IronPort-AV: E=Sophos;i="5.87,278,1631545200"; 
   d="scan'208";a="45004395"
Received: from mail-os0jpn01lp2111.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.111])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 20:21:31 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aQ3GI4LBqJ5zOQaQOkksrKcmZrjPDlQXKw1IKKS5xAS24jHi+PwI27kdpk57tFxlsePGIvpwkEMYjAlbChd3arwffa70y3jBYMaE2RSP9ZZHHDMFG6+2+UfN5fimGT5XfIgfCVFvkbDaOBblYo56/nB0F9Yp8mfEFHnxG6TPJ8jUNguw6qHS8gh3VD39Yugp24hV5m5hQHfwOde5Q8q0kyieRN/ALNUANEng7jPEKidzJQ3wH9paH5rTCw+gQSkIlMwbyehk1E/0DdcKJnBQXCHaYXIRRZJhxW5Hl9OOfd7kqr1YmVlwWFA4RdtOhP5pU+YC6KqVa5nzLk2F9tVLNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=32NxCpgTN7zfc8hYHPKkppSlj0jTbudHwdUy289uCFw=;
 b=bWKk7LgGzbtiMjeNr67eIMRI2lCUJc9iK6zNIK1amP5Bc6QwdU03lOpwmyidsOYcJKGsX/SlPKK0q5swYS+hNRjBvvtnWThnl/FrPUqR6CoZI1CwHL4INJZfa/mlPVLJgxD3qnUHZr40RWVue8hWM38T8a1RiNs9LcIPAW+qa79ssC4ASvjEK87b+040D4ICGV0lF9pYMXsbroMBnCx0oYYv8owJQVhcqSatFm7XNDZcqe7nSU4h+KtBWGG46e/gAH3fQL1Ms59RiI7oKIaloLaXf0VGdHF+ZBnhJK95hciGhdwP9c6EuWILZlbmDYbzdk/x/guGjU1eNAPE8w/+zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=32NxCpgTN7zfc8hYHPKkppSlj0jTbudHwdUy289uCFw=;
 b=MLPC76eZFLW4JMW4+pN5VMDIJXs+FeMpd4J30MYLwOS+T+nLARvxmO9u4u0UtPhGLnmcp+bnukNHZMN7f5DF5wOM81M0atp6dB2okZU5yX5Zc1eLJWO08nV23slJovp0TlIAKGaMalBFZbnryARBjaYrr0DyHV9MpR62ilFToAk=
Received: from OSBPR01MB2037.jpnprd01.prod.outlook.com (2603:1096:603:25::17)
 by OSAPR01MB1763.jpnprd01.prod.outlook.com (2603:1096:603:31::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Wed, 1 Dec
 2021 11:21:28 +0000
Received: from OSBPR01MB2037.jpnprd01.prod.outlook.com
 ([fe80::816a:2a54:60a9:7124]) by OSBPR01MB2037.jpnprd01.prod.outlook.com
 ([fe80::816a:2a54:60a9:7124%7]) with mapi id 15.20.4734.027; Wed, 1 Dec 2021
 11:21:28 +0000
From:   "tarumizu.kohei@fujitsu.com" <tarumizu.kohei@fujitsu.com>
To:     'Greg KH' <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "riel@redhat.com" <riel@redhat.com>,
        "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>,
        "will@kernel.org" <will@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "ionela.voinescu@arm.com" <ionela.voinescu@arm.com>,
        "pcc@google.com" <pcc@google.com>, "bilbao@vt.edu" <bilbao@vt.edu>,
        "matorola@gmail.com" <matorola@gmail.com>,
        "rafael@kernel.org" <rafael@kernel.org>
Subject: RE: [PATCH] docs: document the sysfs ABI for "nohz_full" and
 "isolated"
Thread-Topic: [PATCH] docs: document the sysfs ABI for "nohz_full" and
 "isolated"
Thread-Index: AQHX5oPYD8EANbzSgkWXmArNG7XUEKwdPsAAgAA+J8A=
Date:   Wed, 1 Dec 2021 11:21:28 +0000
Message-ID: <OSBPR01MB20374FD49F83642F6A7526C780689@OSBPR01MB2037.jpnprd01.prod.outlook.com>
References: <20211201071852.3568489-1-tarumizu.kohei@fujitsu.com>
 <YacljAVpgcjkayCg@kroah.com>
In-Reply-To: <YacljAVpgcjkayCg@kroah.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?iso-2022-jp?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZl?=
 =?iso-2022-jp?B?Y2UwNTBfQWN0aW9uSWQ9ODdkNWZmMjQtNGVmZi00MDQzLTg1NzQtODJi?=
 =?iso-2022-jp?B?ZjgxMjJhY2Q5O01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFi?=
 =?iso-2022-jp?B?NGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9h?=
 =?iso-2022-jp?B?NzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxl?=
 =?iso-2022-jp?B?ZD10cnVlO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQt?=
 =?iso-2022-jp?B?M2IwZjRmZWNlMDUwX01ldGhvZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3?=
 =?iso-2022-jp?B?Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9OYW1lPUZV?=
 =?iso-2022-jp?B?SklUU1UtUkVTVFJJQ1RFRBskQiJMJT8lUhsoQjtNU0lQX0xhYmVsX2E3?=
 =?iso-2022-jp?B?Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRl?=
 =?iso-2022-jp?B?PTIwMjEtMTItMDFUMTE6MTc6MDJaO01TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?iso-2022-jp?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX1NpdGVJZD1hMTlmMTIx?=
 =?iso-2022-jp?B?ZC04MWUxLTQ4NTgtYTlkOC03MzZlMjY3ZmQ0Yzc7?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bcb5221b-6c73-4aa0-b5ac-08d9b4bcb826
x-ms-traffictypediagnostic: OSAPR01MB1763:
x-microsoft-antispam-prvs: <OSAPR01MB176341B3E0FBD6FAE0AF565C80689@OSAPR01MB1763.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LJcQycYhDfNzpxhRGwBtTtciYCtw3FeF0BVJ5HfSKBMj7SRLVTY2HZ0NCn2kytIUQi+s3ta3DGg2bjRndTitTA2pjoX5bRSMl9U4SDbmmEqHK5intrLhKwAJ7W2OA90HuQCOtpU/t7yPvsRR0xvxnXOesXl9KboEprlxwfmEJ4ZhJlD2hnq7f6Fl+giKz8jZ3RkRaKsxCJF2RaAa1tDfwP/B3lW6XCbaRE3f+lI/bto35SiGrnP9aMXT2UqTiT9aCrdF8K+SgI9+jhPsttbyGJXk7y5GKfAAjgHdaHGPIyKlcK7r8jCbyOu8rtANDTdirbzOUzHivEiv96ZkSqG9BZqQb2PSfKzryCo8fJ7QGD12JLz/AbuRSXWGU3KJJiaczaxthX+FjKm2Yqans0E8qlUmmLF/6ED+eJ3T1vVcRJlZrx03fYjOn5ufFs51cwDF8ZUZGmZTH+mxNtNPKzLjfCJbkTdkLdLI2QK2RR5zDcfOQrzRgFFqpyMCJiHVF1Fzh5hji0cok9pPxbL/Ohz+w0izZdwnsaSBILJ5ydGN/yetomc7vHrbI/q1JwvltiKBAe9nMRt8kP1D+FK2SbvmwmM71jVdjVyd9uHwr/lLn+V0+mdTkefLlc8sZBBL655FIIvNk3eVCcMzhOnYiOWATiLs65eXG8PPjF3SFYsrLgNFyk7uYNRV7A/5kW8mPbShxvdTdZh0IlKif8ScXfZskw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2037.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(6916009)(8676002)(71200400001)(33656002)(8936002)(52536014)(9686003)(66946007)(82960400001)(66556008)(66476007)(66446008)(558084003)(7416002)(316002)(55016003)(4326008)(85182001)(186003)(6506007)(26005)(86362001)(38100700002)(2906002)(76116006)(5660300002)(38070700005)(64756008)(7696005)(122000001)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?NTFPTWRHc1R5aXRSMjJxem0rU0Y4czRrUjczbE0yZnZSSDlLNnJTdDFG?=
 =?iso-2022-jp?B?cWhzcThwUjVPZ3ZPOG85RHlzeVpxSEVmN3YwdEdpMjBjSGxGSmJOK1hx?=
 =?iso-2022-jp?B?SXl3ajM3QmxFZ3k1Y3BSQk1GQ0lDYmtYanpxTDhvNmtjN1hXaUtmVXFU?=
 =?iso-2022-jp?B?NHJnODJHNkc3NlFzbmtnd2IrMDZDMElQRGFXSmoyWjlEYW5HbVlHbkhu?=
 =?iso-2022-jp?B?S3A1dUlyMW1VbkFucE9leUNwdkpHZkhsVkI4N005YkF4NmxnY0krSHhw?=
 =?iso-2022-jp?B?ZVRTRVpyNCt4ZU01Y3M4a3dCUVBwV2JJMXZzN05TUjFSU2ZPQnJmTHM2?=
 =?iso-2022-jp?B?N0ZCS3lXU2E0WEVRVkl0T1B2MDRQT3Rpdi9nTzlYVFRBN052QTViU3dh?=
 =?iso-2022-jp?B?cEV1S3VaWVlWYktiMDIzSXg3Y0ZYVVozbWc5YjFwdnJBUVBOdDg2czl5?=
 =?iso-2022-jp?B?T3RlQXNyTjJOZFRUQjRYdHNLNWJJSDlOWDRYM0xVaHZVVFdST3Nranlj?=
 =?iso-2022-jp?B?S2IyTVVwL0U4ZjNGdEF2d2tHMTJTMytOK05nbTRaZnZ6Ri9tb0pUWTZF?=
 =?iso-2022-jp?B?ODJWc2syNXZaWW5ZV2FYS1RPdWJBTWFvUUc3cVdWcWtodEc3UUduaXB5?=
 =?iso-2022-jp?B?WGtDMFVmVWJybGNNcHB2L29rWTk4T3U4OGNrMFBPdVJVUHNybzBjOFB3?=
 =?iso-2022-jp?B?RWllTDlXNWJSWjFCZGo4eW9BOEVBNWZXQy96bW5WV25uNHFLZUJuY3B0?=
 =?iso-2022-jp?B?ZmJLZGk3U2JxSEd2TUVkTzR6T1E2ZG4za293THNCTGowOWxJb0p4bzlF?=
 =?iso-2022-jp?B?U0t3QmJIcjhTeUtsYkJWRmkrZlljR3QzNERNWktuaTlvYnRPU0hhc2V0?=
 =?iso-2022-jp?B?RFdpRkpkV3Bwb1A3dE1qU2Y1a2dQVzZSUGpqWEVVWml3UkxNVlZCUUNl?=
 =?iso-2022-jp?B?c1NoTTR5OWt1L2pLUWNRejI1dTRaakhFOWJHRXNTYktIeUgrYXQ4WDAx?=
 =?iso-2022-jp?B?dGUrT3NmZWt0S3JOQm9QTUZPK3hYMVlFT2trcWlJYjg0dkpMTGtUMHhH?=
 =?iso-2022-jp?B?SnpnRWhBODJwd2lzQm1VdDZrQUxZVTdWWFMwMFAyM2ZhNC9tazhvQ1JE?=
 =?iso-2022-jp?B?S25xMERmSmRod0lsSUZERnhoSnpKM2Z6KzV5RjZTMHh1TGplOUtKMzhU?=
 =?iso-2022-jp?B?UmRMVnZjcktSZGVZNTNTYldEbzZkSE9MSTFXVkN6RTRVc2twa21GK241?=
 =?iso-2022-jp?B?T2tmN0VEQ3FTL0VONmYvV1dYVGZIMW8xVGM1Sk9GV1FjNzgzdHRXeEd6?=
 =?iso-2022-jp?B?RzByTGtnaDR1OURrYUNwOVFUYjVEWTVzNkEwU2FQUUhoWEhEcWJpNTA2?=
 =?iso-2022-jp?B?T2MzQllPay9nTE1leDBxbTZTM0VHUlcyeEpMMUJhNDR3UUpndExmR082?=
 =?iso-2022-jp?B?bVI1WmlVcWRDOXJwM0lDNXg3YUhobndocU5kSk9YVStSNVU3elBzdlNH?=
 =?iso-2022-jp?B?NTExdnZWQXRTTTJFeXVYckFTNXl3YVQxVHYrTUNzSmlIb0xxR3V4eWFY?=
 =?iso-2022-jp?B?V1VTNjAyS0ZsbzBlR0JFeldRcm9kanYxNFdmcUtOb1k2aTBPcUh3SFIy?=
 =?iso-2022-jp?B?U1E3VHZDQnlteVVPNzdySlU0VFlleElEdFc3K0ZLL214ZFBCVnA5Yk9U?=
 =?iso-2022-jp?B?TDJseHo4WVk3eVlzV2Z0NFpwSElFS3g0d0QzdXMyN2tvK3ZBT3J4TElW?=
 =?iso-2022-jp?B?UHJMbmF3akJUVHpuNWpEaDhZbEswQ2V4MUVRcm5qemp2Y0hFdHB2dHN4?=
 =?iso-2022-jp?B?cTM1T3JvOGEzbC9PWlk5T2RHbUgvWkZkZHl6bHp6K29yZXl3dVZhQ3lD?=
 =?iso-2022-jp?B?d0YzKzVuWllmRGlXbTl0U1NMQVVOYTlpS1JON1RvbkhXcWhxUkNHUGUy?=
 =?iso-2022-jp?B?eWo0TmtyVjZnS1J1UWhjQXZzcnhsTHlmcVIxL2t0aHhLMkJjME1RS0h4?=
 =?iso-2022-jp?B?eERFZU9RTmQ5alBEUGl5cnJmcUdEcUdCRWJ6N0RPd1V0R1J6T2lHVTZl?=
 =?iso-2022-jp?B?V0kzMzkrR0dIMCtzbUdKNnQ4bHhGQWJORlVwV253TUZ5OUw3R21VNFky?=
 =?iso-2022-jp?B?NVYwZ1dkZmxQTzVHRW5RZjExcDZSMDcvWThmZlh5ZGlvL2xlVExkSmJ1?=
 =?iso-2022-jp?B?RlNhY3JxWjBuL2UrSlpIaXY2dWhQdlhLMk4vbXFseTc4RzFZNXFXcUJV?=
 =?iso-2022-jp?B?a2Z1RDVELzJ2bWlETzM2MFo0VHVzcEowVTVmSktBV1VhSlRHN2VuMzVU?=
 =?iso-2022-jp?B?TUJTUGRkazJEeWRnSU1oenl6Q3ZkSkZKQ2JTNXo5ZGlDRUFRcy8rZGp4?=
 =?iso-2022-jp?B?cVVWbFFtQi80aDZLcmlWT0tUKzl3VUFEZ0YwdFBadkE4QStWd3p6YUR4?=
 =?iso-2022-jp?B?YUViQUVnPT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2037.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcb5221b-6c73-4aa0-b5ac-08d9b4bcb826
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 11:21:28.5562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: osCH3Ix51hCfDGego3UNEK9MRwrqi0F6Caeu3qM9HSlPWzzGAJBK2d7XHfVFH/Ih4vlbFDqlvyj2LzWi3r2F7VGQ7wFKyhNhAKIsCG5gsiA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB1763
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your comment.

> These should be two different entries, not one please.

We would like to send the next version patch with separate entries.
