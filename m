Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE807550E30
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 02:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237582AbiFTA5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 20:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbiFTA5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 20:57:32 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F3A6568
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 17:57:27 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25JLsCG0005303;
        Mon, 20 Jun 2022 00:57:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=NbBI8bnBQasjDP38FNYnti2ceJ+HkVS6Rz4S4u8AIKs=;
 b=pvo1kPG5KyGtmVWSjOMB+rg6+/RgQMsbGa+x0+fSsW31ipvplv/x0P1N8Uqv2t52V1Tk
 B1D32FhJsQ0McWrCy2nlho5L/6fQutXE4XIbtvZ4g5UkIRL9+FsxEofoizB3rvX15n39
 JWG+W6Lz+k6vc6gWomNjPxOiWPa39TD11lrN9EAqI7Az2ReQV/zYQO0lKzMJJTu2LBXc
 krQVE5K/KZUkLEtoa8ionLND3CPHAf9PdsaAguqWzMzBzIqf+q3stOOHjJr3iienqHYo
 FUvIqtODt9Io51oj0RRDEVkISDIRQHViPI9MYrKPJB5/ubC/j+EHIUjwPPZTrWEYbWgW kw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs5g1t0m8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jun 2022 00:57:26 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25K0oUI2036179;
        Mon, 20 Jun 2022 00:57:25 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2174.outbound.protection.outlook.com [104.47.73.174])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gs551e38y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jun 2022 00:57:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jtTr9Bc1yDrz9di0LGxM0m0nUua4XrdXz4fM9AsqjlcWH3R2C0yWGqIBsWknfWK6p3CGFfd6+6HPD0HYSmdefB/IZ4HOM7dYIKm86Oq3oNc+Z0gxjxVkT+dTGZlGeibI7SfsGZ9XNk/t2+dcoHQWYgKq5uLK6EoTEsa2Zgwe1NSgjB4M1mF1iITvoD+3Q0VdoYezkyUrm4NXvT+920rdJ7lQoVmu0LOg48LVc19Nsrrvu9heYNIXr2ac5TfWd1IiASMFKyR10TUC832CnrBDNWULSekZtowEnhSfZxyFiKLJ5HS4qItgN4OpaukUPp+7qRqdYCPhogS1Z0sJ19CB/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NbBI8bnBQasjDP38FNYnti2ceJ+HkVS6Rz4S4u8AIKs=;
 b=A9iatAcQU/xthWfRrjmbyIyuRIG6XUxHV6x38Q35lqEEh7CaYuxb4MhfTTmOnIDz7Irgrw1ijl76CL6xhvmT1iveGHpoHFwYjoFDwUTaQEfk1OSS49t3xB/4V7s9Af5d14BFarl0CWH8zLG+ZEjvbfdy6EuZvNvKZnTinQspRvuhvxNyTXYZMN3xMOkfsW7cmFrcakBShfB+RkXaoPsgM4Sc3qPL51G3y6VE5yqAdHp1+D4zQ4I1MkvwuHrmQaAr+cag2DvJ3W2c8ZG1BZenu94XSqLdFcb4oUmzI1yXoOtyQ6DKXYpYwXeuZSifeSWCdEtq9XmF/YxdMG+94wMd7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NbBI8bnBQasjDP38FNYnti2ceJ+HkVS6Rz4S4u8AIKs=;
 b=jTQoZqqyNaYNEXLpXmev5Yxe7vafPZUXiszAzUfjuXpLXO2NqtJxm4FQG6xt5wV4LjZZmIxnCG2f2RNdbeVu7XaZrAuzM6InGqK1O7mll7CzCwLk9bC4Q3XCw2N/TqWhhBJD176tIEqpXl7PZX7Jj1AfbPT3b2LfrCXLmS8BWu0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB5865.namprd10.prod.outlook.com (2603:10b6:806:22b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Mon, 20 Jun
 2022 00:57:23 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::a022:c9:1cd6:8ef0]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::a022:c9:1cd6:8ef0%4]) with mapi id 15.20.5353.021; Mon, 20 Jun 2022
 00:57:23 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: possible trace_printk() bug in v5.19-rc1
Thread-Topic: possible trace_printk() bug in v5.19-rc1
Thread-Index: AQHYgZTiaV2APa8LiECz6bYrBgXq161SKdYAgAAAwoCAAdkwgIAAXpIAgAMb4QA=
Date:   Mon, 20 Jun 2022 00:57:23 +0000
Message-ID: <355D2478-33D3-4046-8422-E512F42C51BC@oracle.com>
References: <F6C267B0-83EA-4151-A4EC-44482AC52C59@oracle.com>
 <20220616113400.15335d91@gandalf.local.home>
 <E309A098-DA06-490D-A75C-E6295C2987B9@oracle.com>
 <20220617155019.373adda7@gandalf.local.home>
 <3BAD2CD9-3A34-4140-A28C-0FE798B83C41@oracle.com>
In-Reply-To: <3BAD2CD9-3A34-4140-A28C-0FE798B83C41@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 88b4461e-b181-469b-77dd-08da5257d5fc
x-ms-traffictypediagnostic: SA1PR10MB5865:EE_
x-microsoft-antispam-prvs: <SA1PR10MB58659D2BF508CE5ED253226393B09@SA1PR10MB5865.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eoHg/syd1SnB9HeZNj4i+Rss6xMxdN5UYKauY5DQuHjwuHLF3GRp/xzLUsqXwFA9oKCFxlR0HsFb8zDCXaVnP+ZxVcNrSIT5Lg3pq3o39KXLzpVBHV7hOALZmBmZy5RjL7V3QZjyYlC+Qy6IULDCfuhUyHCX3HvpjsMTLwgyrNEPpMoHtE07Ez5DXCbcQ0qwlraBGQt0V8/Q49aixsijxgpkzHvm+elLc4E11dOoe6FEw3XHs9X1y7gfJ+gwUL4aJCEFo/BcWdghZVqJVLc3yv9PFPeWYE6HC8wP9toXH57GjWvjp5BY2ZslPA7MXmQHZK5Z+aB6xZNjOwrf8FqEwrpoMOaT1mNHi9TQ3PCetow+MuLmL+dJj6xdwu4P9C5+JsjwL8Ivkc9xYoWqiBVxKshdoNzbFg2XVSunRtRQfgcb/6DIOWCNAN6EUr47uLzow/VVm2ddwECu1+GVw1dowk5H3YHFzLpLdddXK9LzUpi9rfYnAlTRdfGZtImf+U0UR8VG4L3x7tKeRDl/o09tbmePt5N4qQ9bi4nnR0GpWdN+I2/8SxWmITLgM6enycxtNZlUtmMcfxhsxvK+SpHwbPsCXr+Y5VDa9hF4gxN9jf5+b3Cx4FOjC6jUB4bVGNXBzbAQPoEcwo9bMDCF5EaDx9HPWgicJfAQEY/CMz0Y1wF4cVx2/XED4hf3fhfMgqmRjgkU9XxmVknYpnBAPdkRiPCmS6bMd1D12l48vwuB3qY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(396003)(346002)(136003)(366004)(6486002)(8676002)(86362001)(33656002)(8936002)(38070700005)(478600001)(6506007)(38100700002)(53546011)(186003)(36756003)(66946007)(2616005)(41300700001)(66446008)(66556008)(6916009)(66476007)(76116006)(64756008)(2906002)(6512007)(4744005)(122000001)(5660300002)(91956017)(71200400001)(26005)(4326008)(316002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5N7Cm7PzhwMBUgmBp8LECoUZVcidDbzKr9X1idkZtVKnpx3jZEfLFD58Av+E?=
 =?us-ascii?Q?H56VRPE8SxsYgqBkx09WPCkx03Kiwn1KckfojY7NDyDNO9bC3qEtiy+ckJX/?=
 =?us-ascii?Q?/DonJ5MfTOMQBhH76BTQIGEjDP39V4mKjh9kHPScdanTrLP06Cz64S0urFiT?=
 =?us-ascii?Q?8Rjdh/CeIMk5MYTX0In35FxWnTSzi9HOQ17Ai6GHOxQuWbRjv5a+J7OJTwLK?=
 =?us-ascii?Q?1M9iofiudD5V8sOqdXdymOb3Qz0/aWPNZLYYVB+1uuL9FTIFOJc4+HsAo0Yy?=
 =?us-ascii?Q?aOMRC+g4WST2giRyy88qzohYE7xgFBnw5GSGr5mUUI7huBxSOb6wSbQzxRIl?=
 =?us-ascii?Q?yNBHF+odyEEfQt3F77OxahnnkCRi5LNicAkDh2Zy5Cd1aNHwiM4+6jQJeEKH?=
 =?us-ascii?Q?z8TZf9YqABJUD9Oona5yHQq/eWdDTVB1+YVZLQUlnyG94p2jVSp+NUOEQiwZ?=
 =?us-ascii?Q?9rCcxT55zf0qlTH2DiF74xUXhbx6qslcyG4ovi+50hqLMxzTFnz5Oou87RUx?=
 =?us-ascii?Q?waUxuKA/kCOkbURdItcvFNhWZ0OBO5r28Lg01DTkOTu8wazSX6+7hA4/KE0I?=
 =?us-ascii?Q?CMFoZELRACW1U2cdH196ZjKNhfQvzzT5ilOc0yepCb4xKZmOUhnuNhVVHSoI?=
 =?us-ascii?Q?xPT5M/vH1n7QaZDuB1tT4hlxihypIPdQoQvqQpqpgryIPRw9bXOD4G7RM4su?=
 =?us-ascii?Q?NvSejl8Zm60cnz0T3E+Bm9HeaAzYynzTxqcQkZFQdQ9axMxjNNmzDGl7auqh?=
 =?us-ascii?Q?dYVt3ODuVmf88UGF1M/9Gz1fU5nPX41aZqtrH5izxqno5ghpyM+T5YoWydGM?=
 =?us-ascii?Q?I8tNRiZ1dWCXyi1mcujUluPBHuuBZECBTyuNJl7nCykcBzmtGH1Hjvc2uQhf?=
 =?us-ascii?Q?qjHqbjIFzqkVA4C6wuW+DzYVnjhZQDcwwwo+R7cUjRNzWzmK/NFmHi6H0gbf?=
 =?us-ascii?Q?wv51s5DWqIN+L8h4CKUIpD9iyEq+ctrayRwUgnOM2U+vuyhQEu007PuIEN6Z?=
 =?us-ascii?Q?N/VGWLjbhgIlveFnkkM207Ks1adf45ayS5wyUiKzNBOpO5Vb+sm4f/VlyizR?=
 =?us-ascii?Q?Rv4A+PUUB/d5i8C/DmdPT3tqQUJiwYyKmRLtYksZ6rOdZk7M7tUFsHUHwZMk?=
 =?us-ascii?Q?m3ZW15LrC0zDlqup9WKr9mpas5snQWg3D4SrsII8fWGDLb1KWxFMJlTJbXJ4?=
 =?us-ascii?Q?mJcEGRLSNnrz7FJ7HUylbCXr+devhq9g622ru4d+IernZ6fcr3ZP+nVA10tl?=
 =?us-ascii?Q?zGNqOg1DEIb661Qyx1PRErPnA5t8kfzg5E/Rn+6ndzjUJadyAh/q7PSF/n1K?=
 =?us-ascii?Q?gD2WA2uwpV3Y03Q6sXMfU9Y80dxEZ3NvjZZMjvgTv/mybjYG4uQ9ITc6Hbf+?=
 =?us-ascii?Q?DoGrCUGvRxYrRRuCqSE1AxIe+vmn0Zh26rWLjV5SuHhuNawr9agv2moFORep?=
 =?us-ascii?Q?6vvNmdkN/z5SoWhmkd+WZCK2ZIqDTpATpJMINaferGc4pgBsAktsNZPVjty8?=
 =?us-ascii?Q?JaGVmBiBWh5FZLaCs+SXD1aD2SMtItoblOkJoUwBOh294hEWVCtVX0YH//GK?=
 =?us-ascii?Q?pD0WxSEcnuKgL+gD7wLCNjDRgwQoak8E6Raas+rczpJYanC0JySDDNvuw051?=
 =?us-ascii?Q?jFliDmUoS4oSA3UOgZmjZwvBlVqgnPUtEccqSzFwt58RfYsHgyIVLV4Didk0?=
 =?us-ascii?Q?EfiBFCizOM47M0aVVTeBSO5FhgQ7J2RddDsFyI4TGuIjrdbgy9aOcxVg46Ej?=
 =?us-ascii?Q?6W1IPwtZqqcCwZMAlz+eLO30C0ttb4w=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1F48EA7572F44B498EDDF50DB8CCD6B2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88b4461e-b181-469b-77dd-08da5257d5fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2022 00:57:23.1755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GMBmxNKC33kX0pE3U1zM8n6RdeKa94XUHYgrl4i1BF0aE2zZ9Cv7J6Pjn8jkCU9hya0egkB9zYYp4fIUdrN3Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5865
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-19_12:2022-06-17,2022-06-19 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=950
 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206200002
X-Proofpoint-GUID: cmZzgq-3b88N0bby6cTpQBnyzzS7gHOU
X-Proofpoint-ORIG-GUID: cmZzgq-3b88N0bby6cTpQBnyzzS7gHOU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve-

> On Jun 17, 2022, at 9:28 PM, Chuck Lever III <chuck.lever@oracle.com> wro=
te:
>=20
>=20
>=20
>> On Jun 17, 2022, at 3:50 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
>>=20
>> On Thu, 16 Jun 2022 15:36:43 +0000
>> Chuck Lever III <chuck.lever@oracle.com> wrote:
>>=20
>>>> Did you remove any modules before displaying the trace?=20
>>>=20
>>> I haven't explicitly removed nfsd.ko, and lsmod says it's still there.
>>> And, trace_printk was working as expected on v5.18.
>>=20
>> Are you sure?
>=20
> Yes, I'm sure. I just checked out v5.18 and built it with the
> same CONFIG. trace_printk() on that kernel generates function
> names as expected.

I moved my development work to another system, and bisected. The
result:

91fb02f31505 ("module: Move kallsyms support into a separate file")


--
Chuck Lever



