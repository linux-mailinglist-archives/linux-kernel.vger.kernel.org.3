Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B521F47BBC6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 09:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235563AbhLUIZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 03:25:40 -0500
Received: from esa18.fujitsucc.c3s2.iphmx.com ([216.71.158.38]:40516 "EHLO
        esa18.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234882AbhLUIZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 03:25:38 -0500
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Dec 2021 03:25:38 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1640075139; x=1671611139;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=leLuW5M0w/kxejprJQIO678ts1KHdQeKyaT3AAB0+70=;
  b=qzMriaFKaKZcEdTNkCwI55ZyZYhc124QAYHO5aKRzXBlxRN0VGHrUiuz
   l2+HQjYPyuIZPXQofob2cLXHvA/z6gm/v7/pV5oG09tgw8RwAXGTHgR4m
   VFh4y1HqFwg5ELIBKm1KAusXk5MY4zXzg6gfWE4qVicZeswtT0pl2LxSd
   GTdBh9rcKtjA90p91U6yg0eNpKpcEICHlx/CMgjyJBe+z4eeaP5Cj1uf3
   +E+8b2qK1z7nt8K+zneA43/O6/TjoBwLBIxbReLq/OJ3xcW7WVZpXEj9G
   XQc0IiI9r2Cv0EfL0xPbP8et4h8aQV9gmgJ+B75zJIDprjBDiSX1uuX9y
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10204"; a="47237113"
X-IronPort-AV: E=Sophos;i="5.88,222,1635174000"; 
   d="scan'208";a="47237113"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 17:18:25 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g94IoXCAllgai6xCcAbwCgxSOR9+WHLjD0FCx9Ck3GDnu8TYsJu89+cxUdpZC4evCrWgJJreCSYxx/uV4WrW6HnuQeZCS0RShFI+uujwbT1MruoV4l8LAjmZutrahlyKt4uuJ3Fw7pcgRNQ4wiXmWhF5AECf00SOQItTJDXisMdkKyjM5NFyxma0+qdDPsEyru6Sw9Lk0ixwhnFUNaVeoVhgzE8Byq7oHDq6t+pzIaltFzK09XCd8GhxaEkjv4wQyC4vsgqOsqR8nIUdie40rPU3bznmMT43oQvkEI4wZe9WMRAk6WcxY8DENP8mBllhFHsc1a6uDZAIJVyNWqP1NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T3SrEdiPGG5AeD20O1QZjkIwHzOy3CNY1JN7WZzttx8=;
 b=kYX+cvuSOJXhm4yQxQhqRPHVIJNmMNW8UF01DKUA3OCxRxQR/27hsjhcr/OtRggVCkD8bApmIM2zSj5fuwuWpuNIdYi/Q4fxKw7aYOr/SoCtVnLmXOxI64OxVUGenTJ52eNvtSjnjGKLi/qdyVLjTCJWA2movjDH9Arxq20a+tVVd6imdKi5rQjJbkvZcYgrlT29BIpLdD2vjhtkuAWQT2zbq5LiV+WiDTS5Jyik0fY6DnGth5/A1Ebu5Q66guXLVvFqbrkW45v/exd+6BDBm1fTgaAUFb/c7zaRPENdrpzgXgZHug54cynE3z06YjicNcj4tF1LugML9UnK9zWA+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T3SrEdiPGG5AeD20O1QZjkIwHzOy3CNY1JN7WZzttx8=;
 b=b95W555/5ArqLPZ3WQ3Kw5BAuz3SBbEyeymni0arj7VXqiFRt6XOrrAjxRbMdE2kyvr7Uxj20w0IEzOcJndUJyQP0qZIZSmK+unnM54VZuRd6c1eb8WITXoc43kMUewPywmvluOloq6nMC9K+ikH3slIdi4GOhChLzM6EqBT+Yc=
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com (2603:1096:604:7e::12)
 by OSAPR01MB5060.jpnprd01.prod.outlook.com (2603:1096:604:6e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Tue, 21 Dec
 2021 08:18:22 +0000
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::2c38:ad18:39de:3042]) by OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::2c38:ad18:39de:3042%5]) with mapi id 15.20.4801.020; Tue, 21 Dec 2021
 08:18:22 +0000
From:   "nakamura.shun@fujitsu.com" <nakamura.shun@fujitsu.com>
To:     Namhyung Kim <namhyung@kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Rob Herring <robh@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH v5 3/3] libperf tests: Add test_stat_multiplexing test
Thread-Topic: [PATCH v5 3/3] libperf tests: Add test_stat_multiplexing test
Thread-Index: AQHX60P0SRYTbqZ3XUqLA2y/FGhh0Kwq2moAgBHT2H4=
Date:   Tue, 21 Dec 2021 08:18:22 +0000
Message-ID: <OSBPR01MB46004A56EC0CB66FAD6EC4FCF77C9@OSBPR01MB4600.jpnprd01.prod.outlook.com>
References: <20211207082245.604654-1-nakamura.shun@fujitsu.com>
 <20211207082245.604654-4-nakamura.shun@fujitsu.com>
 <CAM9d7ci3Uycj21X4XXu-MxV--k=gtYkS-H+vGWheKC-YG+d3Wg@mail.gmail.com>
In-Reply-To: <CAM9d7ci3Uycj21X4XXu-MxV--k=gtYkS-H+vGWheKC-YG+d3Wg@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=True;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2021-12-21T08:18:22.221Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
suggested_attachment_session_id: cc9cf796-e099-07d0-cb9d-642225b29653
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 101379f0-4599-4e4d-f22b-08d9c45a744e
x-ms-traffictypediagnostic: OSAPR01MB5060:EE_
x-microsoft-antispam-prvs: <OSAPR01MB5060EED2C38DB0F8A6DB1C0AF77C9@OSAPR01MB5060.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qBJ1NagcM7ty3f84b8eBwrWC+oBCBNFLRA9LDDZOKtLMqe6QnzlqCtzsNlzSDkvHZwqpznB4pHCYVOLLWN6mEtyY5SwB2YxwvzhvXnurbFIWFQIQjBvsAIIACgK2OHW8MafAH1Y9lpRd/OaQddqQuxR9Nz+jVyt31Q5pgRVDWY14ZElYJwDz57zDCXYGTFTqU+itkNs6bDpkZeNhbKEwzHU6OGiEo8THs53oqAggJ1uEf60m17irLsbfhtElWeYP/uwvrru/zozdi5e376iLs/H5dpe7Tl1ZGzg0LiWdaF/SVPNoimMUYMNN72dcYZXCeikT43D0FT2ocX6pDA6owiKvybiDyl5m0yVAUJYN3QteZSdHj7y8bTpANYtMmg/hwPER5dMUWNpQeoe3h3byZ10puhxZ87EwbE8ttOn/ImZirwwuqNMkEkF/SQdXM7Yw0Rq1l95gTGsD5FSdiNkDLwUQcjnDjRqYk7/dV5w2ni3G+QJ7I6q/I8YB4TM7B4se7hSFTtU6r3fyNQ+U3BDYmZL6XeDhLW++3Nn7z9GjHPyK98/MId8YZ2zNr8WOCnARKT1WR5LoilDI1iIU43sj7nru/eM9zdVX1rQCHnXBZkYM28rscJ3vz1ZHOTFJdc3jsTzoOBtB6AUCnTKzn7sY+1LvAYhZRD21sSOR8xWqPITxv3tCUILRwobvbzJA4GJ4CxVYqBGxohTMBpV4OzH2oA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB4600.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(26005)(86362001)(6916009)(55016003)(186003)(8676002)(71200400001)(8936002)(38070700005)(54906003)(316002)(7696005)(9686003)(33656002)(66556008)(76116006)(52536014)(38100700002)(83380400001)(66476007)(66446008)(82960400001)(2906002)(64756008)(91956017)(66946007)(85182001)(7416002)(5660300002)(122000001)(6506007)(508600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?VjRPdWdjaWZKa0g3bVYzNUJSK1JMNXFrYlZHWDR3NHh0Q1VYckM3M0I2?=
 =?iso-2022-jp?B?dWtSc0hJU2xWcm5yUmFlVCt1UkZlZDlLMzR4QnZyQWRFTzU1U2MxaURs?=
 =?iso-2022-jp?B?YzA3bGpSNlhNWTRNZjZBT080L1pONzkvMVVvTkowWUtuUVViMlcrWTd3?=
 =?iso-2022-jp?B?ZDR4MVZpbHlpa0YzeTlLZEJpMU5sOTlaNlhaYXp3L0RZcFBJWDN5Q3Fa?=
 =?iso-2022-jp?B?NktiWlFCZzVFV2Q4Q1ZZbXB5cUwwbVZXakVxSS92OVFGb2UxZkJBN3l4?=
 =?iso-2022-jp?B?RFVJSXZlZ1ZDWEh4NlhMWkRaYVZOb1phVURHUkpZazBjVDVoUjZOSkow?=
 =?iso-2022-jp?B?RlNDVGpNL3doaXZyN3JaK2tSSWpjQjAybGlCa3UyVEllK25NcnJrSTZv?=
 =?iso-2022-jp?B?cGtKZExmajFpOEkvWUxyUFVocmNTUjhMblNCTTV2Wm9KSVVRSnpBalZ0?=
 =?iso-2022-jp?B?VUJXQXFia2N5VjhoL3h1UVNEWUxnV2dzc0E4NW9mVkY2OElWU01UUnlz?=
 =?iso-2022-jp?B?dHNCSGU0bkVPaUZBbVBRcktpQ2dLeVlwbm5qdWhJdDhkR29vMWZjRURS?=
 =?iso-2022-jp?B?eE53Mi9DcVVXd2JRQ09CRllmc1dzRFFqWURxSzd6Uk1sYWVCNW1IcVNV?=
 =?iso-2022-jp?B?RWZiMDNzc2lTdFBacHRzN21pTzdwRXVvWjdSeTc5R2JYREN3ZHF3Y3hN?=
 =?iso-2022-jp?B?VFZEZVB2UlRJVjNvRk1VK21oZmpmTXFwUWNJdTV4SU9Da25ubkZYUlNM?=
 =?iso-2022-jp?B?Q0o3d2ZsZ25EYjl5U3lWZmhraSswMW8zblNldWdPTkFscWN4R2lzdU5N?=
 =?iso-2022-jp?B?UUlWakVhWTMrcnBpT0pSR09PUEJwOEhVYjRGK01MTFFzNHJ4Ni96WFVO?=
 =?iso-2022-jp?B?dTFtRVY4bVlFd3FCY3BEdHYreVNhdjVSWkdGU3RGcnI4S3VLQ3VFalpD?=
 =?iso-2022-jp?B?ck9YVnpSb29EU1JuZ0xNVGdMR1BUcEJnYnlScVRVSThCeXRkSVQxTFJI?=
 =?iso-2022-jp?B?TWxMaUxNOGxNZ1hvSlllSlFMd2psaGIrN2lxaDdXZEhzTXRKV1dEZnNk?=
 =?iso-2022-jp?B?aXl6NENkaUlGTmVWOUdLdWhST0NrQU5TckRSRUJNdDlNdEZFS0t0V2N1?=
 =?iso-2022-jp?B?M1N5YkZ0K3ZBS1g0MmtiSituaHZnV2trL2lKSlNUR0FiN3J6OEhnbllQ?=
 =?iso-2022-jp?B?QjJxSFpzWVl4Q2FseVFtQWNRWjJhOWM2QmlPTVAza2NLcTdBZVUySmZk?=
 =?iso-2022-jp?B?U3dQMlBTYzFiZEM1Mlo0S2pSSjNVdk9WN2IzdnBYTGFhTk1JWFpkTHdn?=
 =?iso-2022-jp?B?T0R6dTJTNlRNby8wVEM3cllVNVVmb3NuK1Y4d3Nwb25MeVJ3elF2TVNB?=
 =?iso-2022-jp?B?dUIzZ3VqMGd2c1FWMysxa2RvUnJ1Y1B4NVp5ZXd5SWU2djhnOGhqTmE5?=
 =?iso-2022-jp?B?S0ZBK3BTcVNrS3pTbjBhVlRtc1NQMEQyUURxNXFYYm8xYWdMQ0pWWHRo?=
 =?iso-2022-jp?B?eW5jZWdGVFlKNHZmRCtSZVozaE93UFRJNGQ4ZjNDNVBqd2ZWWEF2NS9G?=
 =?iso-2022-jp?B?dXg5bDFJK0tldUQzc1hGNmY1NEZiWEc5SU10cXZmZUxVVEx6RXhhY21F?=
 =?iso-2022-jp?B?dndTTTVrcVdBMmxUeGw0SEZWT1lBenFLeGt0Zmx2NXhUSUxFNEtaeU1D?=
 =?iso-2022-jp?B?TS9qbTNmbzU3Z1FBZHdLUUVYbS9TK1lOWnI5RnUzR0MxTC9PdUY0dS9a?=
 =?iso-2022-jp?B?SVVzdXFVSjFYM2NxdjYxKzRPQkRCd0Q2SkFOaDBiM3RndTExdFdCaktt?=
 =?iso-2022-jp?B?YkxJMGZBcFRSVDY4MU5DaHltUjR0emhTcDg2UjRHZ3Z2RjRCbjFmaGRj?=
 =?iso-2022-jp?B?S3A3WGIzOGpKdEFMWEh3elJheStqd0dJQWRBbzMzN1I5RldRS3BCRmlX?=
 =?iso-2022-jp?B?aWlmZVRMOTJMdGRoR0NDY1R1V3I5NlBZTmxkdTVVbHl6Yi9pU3o0TU50?=
 =?iso-2022-jp?B?QjRhM3dRWnVDMzdTcHUxRENmdnViN1hKZEhTMWtpbDB4WVZoVTRCVkxE?=
 =?iso-2022-jp?B?K2picnB2cXVaa1dndnFpS2FqdW9MbUNtOTNSbWQrQzE4ZGJDcU40R3Ji?=
 =?iso-2022-jp?B?SVlodzZzR1NRU3VRenRyM2YyRWtWK2xZelZ3Q2JUTlEwaEhaNDFHZmwv?=
 =?iso-2022-jp?B?M053UzYzWTRmYXFOZmgvYVpwWk9WZnBXODVkTHM2R253RHhFUDlqbmZV?=
 =?iso-2022-jp?B?SWxHTDB6ZTUrRFpnY2lIc2ZVZ0pWblY3elpwQmlmY1gxOWJYcnVnb3Fr?=
 =?iso-2022-jp?B?enY4Y3BmYnEzaW5wUk1QeE0vWXQxNUJlN1o1VE95NlRLVmQ3bzI5ckdK?=
 =?iso-2022-jp?B?THFwZ2ZQRks3RVJVZTdJZHhhNjV0QW1NdUpwd0dhOWJjOHFmK1RSb2sz?=
 =?iso-2022-jp?B?Z211YVRnPT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4600.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 101379f0-4599-4e4d-f22b-08d9c45a744e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2021 08:18:22.6687
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pO+c2EEKsQZT+apDP2qvYn6vQ7Bdz5/yz0Fo4kt46PL0ssHpTQ5iv7mlDAetAvZkOZYIpf1pQ2kYPvReZ9aFvkTZChK1OzEGiOFYYFqV+iM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB5060
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Namhyung=0A=
=0A=
Sorry for the late reply.=0A=
=0A=
> > +static double display_error(long long average,=0A=
> > +                           long long high,=0A=
> > +                           long long low,=0A=
> > +                           long long expected)=0A=
> > +{=0A=
> > +       double error;=0A=
> > +=0A=
> > +       error =3D (((double)average - expected) / expected) * 100.0;=0A=
> > +=0A=
> > +       __T_VERBOSE("   Expected: %lld\n", expected);=0A=
> > +       __T_VERBOSE("   High: %lld   Low:  %lld   Average:  %lld\n",=0A=
> > +                   high, low, average);=0A=
> > +=0A=
> > +       __T_VERBOSE("   Average Error =3D %.2f%%\n", error);=0A=
> > +=0A=
> > +       return error;=0A=
> > +}=0A=
> > +=0A=
> > +static int test_stat_multiplexing(void)=0A=
> > +{=0A=
> > +       struct perf_counts_values expected_counts =3D { .val =3D 0 };=
=0A=
> > +       struct perf_counts_values counts[EVENT_NUM] =3D {{ .val =3D 0 }=
,};=0A=
> > +       struct perf_thread_map *threads;=0A=
> > +       struct perf_evlist *evlist;=0A=
> > +       struct perf_evsel *evsel;=0A=
> > +       struct perf_event_attr attr =3D {=0A=
> > +               .type        =3D PERF_TYPE_HARDWARE,=0A=
> > +               .config      =3D PERF_COUNT_HW_INSTRUCTIONS,=0A=
> > +               .read_format =3D PERF_FORMAT_TOTAL_TIME_ENABLED |=0A=
> > +                              PERF_FORMAT_TOTAL_TIME_RUNNING,=0A=
> > +               .disabled    =3D 1,=0A=
> =0A=
> It'd be nice if you use a less restrictive event attribute=0A=
> so that we can test it on VM or with non-root.=0A=
> =0A=
> How about using SOFTWARE / CPU_CLOCKS with=0A=
> exclude_kernel =3D 1 ?=0A=
=0A=
I'm currently working on adding a new API for libperf.=0A=
So, I will respond to the above comments around the end of January.=0A=
=0A=
=0A=
Best Regards=0A=
Shunsuke=
