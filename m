Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C504EB570
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 23:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235132AbiC2Vre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 17:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234905AbiC2Vr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 17:47:27 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333835A0A4;
        Tue, 29 Mar 2022 14:45:44 -0700 (PDT)
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22TL9kaE025236;
        Tue, 29 Mar 2022 21:45:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=31NwAxptEiJ4XRPIU5pNSWCUN3jO4xBojIGpnEXEcLg=;
 b=JgnNnWCI/JHRrUBNIF8QoEVhRvIJnFieJjCV9bLrDTkLsrMw+7sozGnUz3xPuZPijS95
 o+kZMLGamOaWW9O67GDneWxCxsxUTdeI2EjIx9Ws7FsUMqPCLDo7TpODCKELdOfgZYPM
 GyA6V0TTDcu+FqNq3xFhuheNhYympHggPPLVuEOMRs2yEnW0MqroXlnkiu20Mi1dRMlr
 yaEt+m3/3Z4w7+9iUuW4N06tst57R4qVIPouv7OjytBkiTW74RKfS76jpQO8sjgMnAEi
 IIzYey6APbfEo+4y9n79H7jd1Eh1ZnGdZP8vh1KG09R2w2NI851iZTgdWzYONbaRfHF2 6A== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3f3nmv2944-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Mar 2022 21:45:31 +0000
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 2EA40131B6;
        Tue, 29 Mar 2022 21:45:30 +0000 (UTC)
Received: from p1wg14923.americas.hpqcorp.net (10.119.18.111) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 29 Mar 2022 09:45:20 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Tue, 29 Mar 2022 09:45:20 -1200
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 29 Mar 2022 09:45:20 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gr88ahPPC4gK4Xlj5L9cJ01D+64aKAHyVJKXi+AcSb1lzdL3DR5Xols4llMHavimttBH4t90SSybm9Wu/Z2q463S+swav2UaX60kPagsZBEOiDGFKSiVNmmy100mTTK6LBlv7TJcGNsr642PIQol8aiFWjL/u4aF6liqRT1fij33bvDV3fEOFzZWnim+dYUPLUJd6YePx74HsJZDJNjU+YIVDltmflMayD0yqTQkuX+bQVEEVLB/LkiCPG+wrgwceibm/xj642tk3Kzh3aSXm8WBD3iY8/weJtdclcN3tA9BXVcgDKzZXbeZJrPf4K7LGzQsoOz3PCwIM9EehQFkcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=31NwAxptEiJ4XRPIU5pNSWCUN3jO4xBojIGpnEXEcLg=;
 b=etyoJHJF1KN2eDq0v0CAhyxoakPW+8ayEu/l7k/QEAHHtDF4BAESKI4IW4lueT9njV/RF7Bh+nI6IoUSqKVHfyoSesfsa9Q/yAclsjXRv6vIG+fbJ0gxRH7K8aD7Fz3hwKyd0punl+O8gKKDxXIlmeBMtZWa3+qlmBf8+MONynm+RGHhakRVhsHLpkyU8SU4zTrohd6aO9OUgKynuy80+efEgZ9ctOQ1AGcx3IUaweW8gygHun/VnTP0r4kZTnA2W81h3V2aXC5T6SsqmATNhSPuu5qzCbcaYLgoKSrcm7M5LAS3m8NVK+lrgQSgJDvuqXv2GtaCPjX6bPqCpnyNng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:172::21)
 by MW5PR84MB1819.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.23; Tue, 29 Mar
 2022 21:45:19 +0000
Received: from PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::bd27:815e:7c03:d1e4]) by PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::bd27:815e:7c03:d1e4%7]) with mapi id 15.20.5102.022; Tue, 29 Mar 2022
 21:45:19 +0000
From:   "Hawkins, Nick" <nick.hawkins@hpe.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "Verdun, Jean-Marie" <verdun@hpe.com>,
        Olof Johansson <olof@lixom.net>,
        "soc@kernel.org" <soc@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 09/10] arch: arm: boot: dts: Introduce HPE GXP Device
 tree
Thread-Topic: [PATCH v3 09/10] arch: arm: boot: dts: Introduce HPE GXP Device
 tree
Thread-Index: AQHYNLgx692NqDgvU0iOWKp+QCe0Uqy5/HOAgAgo3qCAAAx5AIAAD3gwgAEJmYCAE5R/wIAAGtkAgAAFszA=
Date:   Tue, 29 Mar 2022 21:45:19 +0000
Message-ID: <PH0PR84MB17181C316E55073EBC28C386881E9@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220310195229.109477-1-nick.hawkins@hpe.com>
 <20220310195229.109477-9-nick.hawkins@hpe.com>
 <eb66cc83-2da9-8e19-db69-633e34fef946@canonical.com>
 <PH0PR84MB1718C31DB71AA2A67FEC5F6E88119@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
 <b1cc2566-cd78-7cb4-f8a5-d6fc8065fe6e@canonical.com>
 <PH0PR84MB1718292B1C11F4FE83326A5388119@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
 <fb4def96-4b20-604f-d15d-fef87eb2232d@canonical.com>
 <PH0PR84MB1718A2CFBFC90C9C0CAA5515881E9@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
 <CAK8P3a0fCE_NM=z68d1m9BTfuKixh1pKLw3gn+Sr7SxKb6UJAg@mail.gmail.com>
In-Reply-To: <CAK8P3a0fCE_NM=z68d1m9BTfuKixh1pKLw3gn+Sr7SxKb6UJAg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 94377da5-53c3-4520-5334-08da11cd6b83
x-ms-traffictypediagnostic: MW5PR84MB1819:EE_
x-microsoft-antispam-prvs: <MW5PR84MB181936C8E262C4BFC4ABDC89881E9@MW5PR84MB1819.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9/b6ot0Na4FO78rYuCSNwlaPg7TI5gdu5lXEUVQMNBfCmyIG9bF71MM+XXrAdTYJ2dEnlrfa5VO4oBrkhN7kb0Lb8uY10/h/+QTftKiTE3sL1vvqvdqELMz0ddwcQtcZ+BBIEBSD0cK2xsesDhsBCkAWTSjPGRb0Y+epy+4e2Yg+4id/pAcgxk922tDvdd4Otx2RrPgtpQyGo84dD/tZxAF42wcaMDoRFlMzrt/H6MeCRm7UqEN1JTIQehQllyInmD+u9EzBTXMZuM1XPHCay5Lesp2ENbCgSatDCR7xQY2Bolfo6FWelJDTC/KiPUmaBNdaJ4qMFg5w79BgcZFk270H3+6FQdIolv8wQVXOTSapvLSR+/qGkZAoJMXkPQEOyxaB1U7xWgnxIsxsbNNAoAPxqDKPMJb3aXDrmSTkdP3bh3RkLPCYYpGsGF1gzQic1p2+muNKSVZDB9RIFbaeveyv4rTQxQv+9srXGbfZ3PDkddjwboXBDWWzATauJVO4eqZ8n7UWXQJgNZLriwno2vZeC/G6XS11gE6ricgIEFrYNmtP0WXyUmkp41JhZSg1t0Lgbp2OwLtFnbujEYHMKV2yEugrhjT1bVmAuL91GyknWXM1WS0+/rcukl0kI5AISneq6LzX/G2iH8s4FcnnWRn6W/x6o1ILBEpESWEjspu+NoXmA+M4vOuf3suOwtx+YNqwxbK8Tm375bWdyKNKyA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(55016003)(7696005)(82960400001)(86362001)(38100700002)(122000001)(6506007)(33656002)(38070700005)(508600001)(5660300002)(26005)(54906003)(66476007)(71200400001)(186003)(55236004)(9686003)(83380400001)(52536014)(2906002)(53546011)(4326008)(66446008)(316002)(64756008)(6916009)(8676002)(66946007)(76116006)(66556008)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RGl1bEQxTzIzK1ArclorcWNodWtXOGY1eXJHSHhXdGNVUnphU3kxQTkxajkz?=
 =?utf-8?B?VURsNFJkZEx5ZWNWdCszTVllTkdiK1cvbGNYRERjQ0ZHamUwd3FjS0ZxQmtL?=
 =?utf-8?B?ckphYWNFbTZMMTJVVnFyTGIzd1R6eDhyWG5KcFJvSEFJOFZVczVPWThia1lo?=
 =?utf-8?B?M1ZNeXhiVHpFM1FMUnRCSGRpSjIzNkNJZnoxOXNBNWl6RFh1VTJaWXFFZmEx?=
 =?utf-8?B?TmVjYnlrOHNqdFIwTTV3ZTA1ZFVzSVk2bUxkbDVRd21rYmtNdkVFSGtBUm84?=
 =?utf-8?B?TkIzMVNnMW5HQ1oraWhNNnkyS3JQS0FrREMzWXFUUUFkNExwQkNOcmkrT2gv?=
 =?utf-8?B?WFF0bnBZTHQ1OTgvWVhDaXJ6dDA1YjBOM0tWdnU2YkZ0NnZXUEpVeUtreDJm?=
 =?utf-8?B?azlDNGQ2L0VEWXJLTU02a2xpZEJpa1g3aFIzdlJZV1pBd2RzVTVnZm13S3Er?=
 =?utf-8?B?cHBhN2M0V3g0M3BXdUdtNkJCY0N1Q3FXNit6bERWUjVOdVltUlFPVUxhbkdz?=
 =?utf-8?B?SzZXNk5JK3loWTM4OVRzYWdIRnROSExIeEtqVk82dHhaRThLVzgvd0g1TnMr?=
 =?utf-8?B?d09MRlhtWDMrRFZaTHc4TGtmRmVHU3pSS09pd0R1M3BIOC9XRlJGTzlEUWs1?=
 =?utf-8?B?QjVBNDh4VlhSb2k3aFdSQVRxdEROdEFQQ0dqdzBReHZ0WEQyZVVRTG1FdW1x?=
 =?utf-8?B?QU1hcXV3MWRIOXg1b0RMT2R5cUxyc29Ba1dIUDJ2cFZBQU8yWkFnWkJScG10?=
 =?utf-8?B?R2tHK2R1U2NMTTQ4eFd1cEdKZHFlTkdQaHdzU3A4MVMxbjlvanFUSjJOczg0?=
 =?utf-8?B?cEdObzJvSHJTYW9wQXF4ekEyN3hsMmk0N25LZ2xUYTQ3bU5TV3pZcG41cVNr?=
 =?utf-8?B?U1JnVXNoMVR4WXF3NDQyOTRTWlFEWlBpZlk3c09qTk1oN0Q1ZmpWTVF1aWtt?=
 =?utf-8?B?NGV5VnFzeTMyTE1tcjJyZWZPazlxZW4xdWdLMndTNkY5VFNFdTdrZ2N2TDFN?=
 =?utf-8?B?NS9vMEI5bFlSRmllNzRHKy8vUXhGRVk5MGkvY1ZObkg4U1pOQzROQjFZWlNP?=
 =?utf-8?B?a3NaTDZtdCs0aTRFT3JGa3ZmWERmWUhrcmRPSThhOVJhNUtPM0tUWU9BRTNI?=
 =?utf-8?B?ZllsNFBQblo3UGpmRExPQnRVZG9YaC9ERGpieDc0ZXRDWkhrWG52ai9MMFlt?=
 =?utf-8?B?ZDhEa040RDBZUGVvZ3FxOTVmZ1NjcU5JVm1oU3FxL2tKNS9uVnFSdjBkeXYv?=
 =?utf-8?B?M1ZHeUkycU1lMWVVQTdEMjhCeWFQQWpTTUYzS2NJeVpYak1WaFJkTmR4K3E2?=
 =?utf-8?B?aVI5WkVkSXpWNCtqWHBpTG1KdTR4VWpRalVTaUlBVEc3Q0s3cnF5ODBvNDY2?=
 =?utf-8?B?bFova2ExczVaMHIrREg0cEgvbXBLZzJ6Vlcrd3BNd1JDZG8zR0xPNmtHL1gr?=
 =?utf-8?B?ejhOcHlkdUN1VXFvekpnMDlLenlVMmZnS0JsSjNxQkpGRXVuRFlMNC9PNGFR?=
 =?utf-8?B?VFZwV1QwcExwMElJYnJza1pGL21OL3c3Tm1qR21FdXgrOVYxSFFPdEQ3em5Y?=
 =?utf-8?B?QzJTbE1nZlFYaElJczNZR2xXV09QVlRtU0VWN01YY2xFVFZJdWtJT3dWTUdC?=
 =?utf-8?B?NElMMFpYVEw0eVJKSFMrUUcrQk44UnFiZG4rNnJZVmtHTDY0bmhsV3JKNmd5?=
 =?utf-8?B?K2FHYkVFZmVpUVc3VnNBdjVPbjcvZFlpK2pBZHY2Z1Y3cEN5SGUzNG1pZjc3?=
 =?utf-8?B?TUxHVWZNNU1SK1lNbm14UEZrdG1HV3d3TkdlTXdQdXZaem5JZlM1VFdvWUpP?=
 =?utf-8?B?ZE14MjA0UzRhSHNBVmJjalFFTEY2eG9JSWZkMVdOY3ZIRnNydDFHOXozOExG?=
 =?utf-8?B?NmJDNzhnM25vR2RUWTFwVmVyVW5PSXF1azRwSEtITE1vZEhtbkcvQTFiNmI5?=
 =?utf-8?B?TmQrcjJ0ZU1yWGdFeXhXMC8rZUdvTE9GOGJ4emsxYW5aeUJIcnc4ckZxRG9l?=
 =?utf-8?B?c2FtQU5ELzJuNENxa29QaUtudEtVT1hUWW12RUdUR3RncDQ4VUhCRUxmNVI4?=
 =?utf-8?B?b3hJTjZhUnNDVFozUnlEYUdWdzZhS2wya3ZYMFNJSnhGVkpDR1kwUzhaZHo2?=
 =?utf-8?B?ZmplZVpjejVKRUlNQzk4UE1FelRha1hPYU95Q2FsdnoxcmZTalhJZVE1YSsv?=
 =?utf-8?B?ZkZaeUdLUUtYc3F6N3hqVndpbjFMYlZueG0wcVVLZHF4MGNadGNwZWJ3WVRE?=
 =?utf-8?B?WTJKWDhtaFR0UlVnN0Ntdm1DLzF0b1RnWVBZTm9xQjNFTWFQbFU4RWdCZEVC?=
 =?utf-8?B?MkhaRDU2VzlvRytweHB3MEYyd3RiVFdVelR6UDFoYkUwU0hJM0FEdz09?=
Content-Type: text/plain; charset="utf-8"
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 94377da5-53c3-4520-5334-08da11cd6b83
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2022 21:45:19.4662
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A4CD1jYWgjkLb/s0DDQtzO7ZbzsLJBcI4rMlNKxn6tK1gRmX8semg9p11fi3MLoy5C/GX3N0xN2jqQ+d0vAeQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR84MB1819
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: ZSu9W_mOebCT8LLoU9fChBO5IM55g6Cp
X-Proofpoint-GUID: ZSu9W_mOebCT8LLoU9fChBO5IM55g6Cp
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-29_09,2022-03-29_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 priorityscore=1501 mlxlogscore=999
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203290117
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBBcm5kIEJlcmdtYW5uIFttYWls
dG86YXJuZEBhcm5kYi5kZV0gDQpTZW50OiBUdWVzZGF5LCBNYXJjaCAyOSwgMjAyMiA0OjEzIFBN
DQpUbzogSGF3a2lucywgTmljayA8bmljay5oYXdraW5zQGhwZS5jb20+DQpDYzogS3J6eXN6dG9m
IEtvemxvd3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBjYW5vbmljYWwuY29tPjsgVmVyZHVuLCBK
ZWFuLU1hcmllIDx2ZXJkdW5AaHBlLmNvbT47IEFybmQgQmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+
OyBPbG9mIEpvaGFuc3NvbiA8b2xvZkBsaXhvbS5uZXQ+OyBzb2NAa2VybmVsLm9yZzsgUm9iIEhl
cnJpbmcgPHJvYmgrZHRAa2VybmVsLm9yZz47IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmcNClN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMDkvMTBdIGFyY2g6IGFybTogYm9vdDog
ZHRzOiBJbnRyb2R1Y2UgSFBFIEdYUCBEZXZpY2UgdHJlZQ0KDQpPbiBUdWUsIE1hciAyOSwgMjAy
MiBhdCA5OjM4IFBNIEhhd2tpbnMsIE5pY2sgPG5pY2suaGF3a2luc0BocGUuY29tPj4gd3JvdGU6
DQoNCj4+IEkgYW0gaW4gdGhlIHByb2Nlc3Mgb2YgcmV3cml0aW5nIHRoZSB0aW1lciBkcml2ZXIg
Zm9yIExpbnV4IGJ1dCBoYXZlIGhpdCBhIGRpbGVtbWEgYW5kIEkgYW0gbG9va2luZyBmb3Igc29t
ZSBkaXJlY3Rpb24uIFRoZSByZWdpc3RlcnMgdGhhdCByZXByZXNlbnQgdGhlIHdhdGNoZG9nIHRp
bWVyLCBhbmQgdGltZXIgYWxsIGxheSBpbiB0aGUgc2FtZSByZWdpc3RlciByZWdpb24gYW5kIHRo
ZXkgYXJlIHNwcmVhZCBvdXQgdG8gdGhlIHBvaW50IHdoZXJlIHRoZXJlIGFyZSBvdGhlciBjb250
cm9scyAgaW4gdGhlIHNhbWUgYXJlYS4NCj4NCj4+IEZvciBpbnN0YW5jZSB3aXRoIG91ciB3YXRj
aGRvZyBjb250cm9scyB3ZSBoYXZlOg0KPg0KPj4gQDkwIHRoZSBjb3VudGRvd24gdmFsdWUNCj4+
IEA5NiB0aGUgY29uZmlndXJhdGlvbg0KPg0KPj4gQW5kIGZvciBvdXIgdGltZXIgd2UgaGF2ZToN
Cj4+IEA4MCB0aGUgY291bnRkb3duIHZhbHVlDQo+PiBAOTQgdGhlIGNvbmZpZ3VyYXRpb24NCj4+
IEA4OCB0aGlzIGlzIGFjdHVhbGx5IG91ciB0aW1lc3RhbXAgcmVnaXN0ZXIgYnV0IGlzIGJlaW5n
IGluY2x1ZGVkIGluIHdpdGggdGhlIHRpbWVyIGRyaXZlciBjdXJyZW50bHkgdG8gY2FsbCBjbG9j
a3NvdXJjZV9tbWlvX2luaXQuDQo+DQo+PiBXaGF0IHdvdWxkIGJlIHlvdXIgcmVjb21tZW5kYXRp
b24gZm9yIHRoaXM/IEkgd2FzIGNvbnNpZGVyaW5nIGNyZWF0aW5nIGEgZ3hwLWNsb2NrIHRoYXQg
c3BlY2lmaWNhbGx5IHBvaW50cyBhdCB0aGUgdGltZXN0YW1wIHJlZ2lzdGVyIGJ1dCBJIHN0aWxs
IGhhdmUgdGhlIGlzc3VlIHdpdGggZ3hwLXRpbWVyIGFuZCBneHAtd2R0IGJlaW5nIHNwcmVhZCBh
Y3Jvc3MgdGhlIHNhbWUgYXJlYSBvZiByZWdpc3RlcnMuDQoNCj4gSSB0aGluayB0aGlzIGlzIG1v
c3QgY29tbW9ubHkgZG9uZSB1c2luZyBhICdzeXNjb24nIG5vZGUsIGhhdmUgYSBsb29rIGF0IHRo
ZSBmaWxlcyBsaXN0ZWQgYnkNCg0KDQo+ICQgZ2l0IGdyZXAgc3lzY29uIGRyaXZlcnMvd2F0Y2hk
b2cvIGRyaXZlcnMvY2xvY2tzb3VyY2UvDQoNCklzIHRoaXMgYSBnb29kIGV4YW1wbGUgb2Ygd2hh
dCB5b3Ugd2VyZSB0aGlua2luZyBvZj8gSSBmb3VuZCB0aGlzIGluIGFyY2gvYXJtNjQvYm9vdC9k
dHMvc29jaW9uZXh0L3VuaXBoaWVyLWxkMTEuZHRzaQ0KDQpzeXNjdHJsQDYxODQwMDAwIHsNCiAg
ICAgICAgICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAic29jaW9uZXh0LHVuaXBoaWVyLWxk
MTEtc3lzY3RybCIsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgInNpbXBs
ZS1tZmQiLCAic3lzY29uIjsNCiAgICAgICAgICAgICAgICAgICAgICAgIHJlZyA9IDwweDYxODQw
MDAwIDB4MTAwMDA+Ow0KDQogICAgICAgICAgICAgICAgICAgICAgICBzeXNfY2xrOiBjbG9jayB7
DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAic29jaW9uZXh0
LHVuaXBoaWVyLWxkMTEtY2xvY2siOw0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAj
Y2xvY2stY2VsbHMgPSA8MT47DQogICAgICAgICAgICAgICAgICAgICAgICB9Ow0KDQogICAgICAg
ICAgICAgICAgICAgICAgICBzeXNfcnN0OiByZXNldCB7DQogICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGNvbXBhdGlibGUgPSAic29jaW9uZXh0LHVuaXBoaWVyLWxkMTEtcmVzZXQiOw0K
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAjcmVzZXQtY2VsbHMgPSA8MT47DQogICAg
ICAgICAgICAgICAgICAgICAgICB9Ow0KDQogICAgICAgICAgICAgICAgICAgICAgICB3YXRjaGRv
ZyB7DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAic29jaW9u
ZXh0LHVuaXBoaWVyLXdkdCI7DQogICAgICAgICAgICAgICAgICAgICAgICB9Ow0KIH07DQoNCklm
IHRoYXQgaXMgdGhlIGNhc2UuLg0KDQp0aW1lY3RybEA4MCB7DQoJY29tcGF0aWJsZSA9ICJocGUs
Z3hwLXRpbWVjdHJsIiwic3lzY29uIjsNCglyZWcgPSA8MHg4MCAweDE2PjsNCg0KCXdhdGNoZG9n
MDogd2F0Y2hkb2cgew0KCQljb21wYXRpYmxlID0gImhwZSxneHAtd2R0IjsNCgl9DQoNCgl0aW1l
cjA6IHRpbWVyIHsNCgkJY29tcGF0aWJsZSA9ICJocGUsZ3hwLXRpbWVyIjsNCgl9DQp9DQoJDQoN
Cj4gWW91IG1heSBhbHNvIHdhbnQgdG8gbG9vayBhdCB0aG9zZSBkcml2ZXJzIHRvIGZpbmQgaWYg
YW55IG9mIHRoZW0gY2FuIGJlIGRpcmVjdGx5IHJldXNlZCwgdGhpcyBpcyBwZXJoYXBzIGEgbGlj
ZW5zZWQgSVAgYmxvY2sgdGhhdCBvdGhlcnMgYXJlIHVzaW5nIGFzIHdlbGwuDQoNCkkgd2lsbCBs
b29rIGFuZCBzZWUgaWYgYW55IG9mIHRoZW0gaGF2ZSB0aGUgc2FtZSByZWdpc3RlciBzZXRzIGFu
ZCBmdW5jdGlvbmFsaXR5Lg0KDQpUaGFua3MsDQoNCi1OaWNrIEhhd2tpbnMNCg==
