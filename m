Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 117FB521C4B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 16:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245263AbiEJOdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 10:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344241AbiEJOHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 10:07:46 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99FBE21088A
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 06:42:03 -0700 (PDT)
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24ABZvjx008253;
        Tue, 10 May 2022 13:41:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=6S2mNVDpLT9CWLKs0itE6WQYHmyikHGTIO8h+frTDwM=;
 b=BvWCRQY/kFnYBOk/NH+The/3NlKkvxntEbcIrFlV7xqjthUtCYupKQnTWsr3dfDGl5HZ
 5wXrryBXMCRMrqUv3jgnST2MlksvzeODUpssHVfSfse+OCcyWBgbRJ9emm6+zhTzMWvY
 YGvcvtiwCh5p/REJ1CuChR0MoJFHugw2uKi2wR6lOjV8OLhk6f/8i5quLh/LogwRGGLY
 VoDFFgGinv6onQpBk9LoAGHDF3tP2N5A+XlIgD1dZ/zFetbWVKeMcvlrf75Fn9fXhoMC
 8TpM3OCaiygKgJQRBmBRd9E+BEot/VgaA9cWTaPB/4IyKjJSAISibYpFS24IJaNQD5I9 4Q== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3fypw098dn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 May 2022 13:41:24 +0000
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 2E9C6130A9;
        Tue, 10 May 2022 13:41:20 +0000 (UTC)
Received: from p1wg14925.americas.hpqcorp.net (10.119.18.114) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 10 May 2022 01:41:12 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Tue, 10 May 2022 01:41:12 -1200
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 10 May 2022 01:41:11 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AdD7pfEV4Sxv63q5pshCJrOkDQzySNjtTcN+apFgZz7KToWh9oswk26vCELatekOLAxRDSIiTg0eHVeNf0ah6Pp9n7N74qugqzLqrRAyN/7GC/6Bh/P2iU+q7wtYWeJ9ZbCusl+SloVqqfU4HDXxZMXm3fQsz14KvuoMDBTZ5xJORrf+EGRavcD2M/gcUJvG6TU9QCua9m7KnRDBDW6M6CMIzs5bFmmVAp6aDErmyHjQqJk3BfzfNoPAiY+b5Qu1a9phyaViajZqH5I1BZx0l+YayGjUzvrqGFSWrXIcavk12T0JCjyHT6E3+MiLsbGM7KPE5QbMQwmnNjFBQw/2iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6S2mNVDpLT9CWLKs0itE6WQYHmyikHGTIO8h+frTDwM=;
 b=BaRLlp9yplhQF4zhkutzD5ueAd1ZFa/3t8vHbcyvywG0SApuZsLVzJlE+Z/nzUnKbVM94eW3mwP8n9sfKQMif5Zv7TPG5asAan4MjFCfsW2upiuSnStyyIZeUkAQyflFLPtHV0LoLaq0WFWVO9nyAAPY2S/TRE94X4dKK0yhhgc6//BGw10arvagAhr9KQHsL6L9exmKg1XEQc/RKEQV3GBdvDyVWJjFnN3BcZbKMdvjgdVHvzjSJFddH0OmWnTp4j5z7Ah4bbc1mz8ISdpnkgUpRSHSTPyYe546dYRNXTR8uFfnMXv1viiDCv6Z4E0XA8LfSj94KHsCXSxug59d5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:172::21)
 by DM4PR84MB1832.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Tue, 10 May
 2022 13:41:10 +0000
Received: from PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6055:1602:5a0a:1562]) by PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6055:1602:5a0a:1562%6]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 13:41:10 +0000
From:   "Hawkins, Nick" <nick.hawkins@hpe.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        "Verdun, Jean-Marie" <verdun@hpe.com>
CC:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joel Stanley <joel@jms.id.au>
Subject: RE: [PATCH v1] ARM: A9: Add ARM ERRATA 764319 workaround
Thread-Topic: [PATCH v1] ARM: A9: Add ARM ERRATA 764319 workaround
Thread-Index: AQHYYX9/lEqShxGKek6V2FmsHnxQM60XuXoAgABMyYCAABLbAIAACoqg
Date:   Tue, 10 May 2022 13:41:10 +0000
Message-ID: <PH0PR84MB171846CCF58FC36A39C39EF388C99@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220506192957.24889-1-nick.hawkins@hpe.com>
 <CAK8P3a045Di_zRomezeah0ZoSGPw0Z6YoYkZtoxx1qOXAtKbbw@mail.gmail.com>
 <7C103AEB-3111-4AE6-9645-CF590388A879@hpe.com>
 <CAK8P3a0OS+4XTG9VmfPwbuQoT+_G5-fSatbJ0g8Y7Y+O6-3YLQ@mail.gmail.com>
In-Reply-To: <CAK8P3a0OS+4XTG9VmfPwbuQoT+_G5-fSatbJ0g8Y7Y+O6-3YLQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 953d5603-7958-491f-2271-08da328abe13
x-ms-traffictypediagnostic: DM4PR84MB1832:EE_
x-microsoft-antispam-prvs: <DM4PR84MB1832A9BC85EB4951FC71EA4888C99@DM4PR84MB1832.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +QNjV9gbAkhiWMnlJj7kmAqAnX5ffDtH8mz5ia13oBGi37JMfd8fkPJx3/sIuk6pmPp6oWe+E0Dn6Nc1txmDdWj9MkwD48J2MmZ4ZQ4yhkqrxfwelakbIBr2ksUA81hiLdP/C/LYooeVh01chCUVaNfsG88A2X2W/Fmfa1aSP6mBd0zGmFH6dMHqtmv8N01GcR0y+ONZRhC1P3WEUxgxUntCNkLhnidoPCKjzh1+3T02WVROAD0rw8dshddoAnGr0Z9TMM9BzrKjFxMY4yVe/swjyXt5EwltlMsmvIUmwNmsdVDJDRdv5mbyaRRuSwNvi8Zi2DV1YHrHXom++ty/FPsW3GGoa7ZqbOx42hKpo+fyOCvo+UhvOiUoJt72PdFBUJTHHt8Plzz/gjH/NKdB1Og143rCSmXFWU2xpUhFwPcsJVha+H9uzWHHo27SvOdM2e31dDuvJrBnBM/KawNjsQp9H2l01fm58ojubK36cVatB5NkfsmAd5UQzJKwsRMsOBe/Dk81IFqKWdR/Q3VlvWLOgLlSaNF94S2cErpw/an8421aQVZG7UeDBnuWPpXn6HEpByMgG3zROF6qVMnd7OTa6unr6Hioa6m13/8rghGJQUmB2frFz9kQ2xRPt9Af0OYB8ojo+f6IRMgLPAeoGKo/2DIkPAXpnUxdFpuYGPhd/eAUF/lowXHLUkyJ7knOnVlDolsi2+byms/p2VArGA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(82960400001)(38100700002)(9686003)(38070700005)(122000001)(26005)(6636002)(66446008)(55016003)(8676002)(4326008)(64756008)(186003)(76116006)(66556008)(110136005)(66946007)(66476007)(54906003)(316002)(53546011)(508600001)(5660300002)(2906002)(6506007)(86362001)(55236004)(33656002)(8936002)(71200400001)(7696005)(52536014)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S3JhT3BvcVd2RDljN0tVTUhhQUFZWUxta2VyQ2U0RUNWWWFKWnV5V0lITEhk?=
 =?utf-8?B?ME92SDRDWEE1UE1wM3pXOHg1N3ZmOVlMUXBUTXR4T3IrVGtJQUdRYlc2TjA5?=
 =?utf-8?B?dEVDVDdHc2ROUFZUaEhiVHhQeDByM0paekpTR0wySlc0dHphY1RYZjFuV2lD?=
 =?utf-8?B?TEFyNUZSRjRtYXlrZTlqdTMvZ0lYaXNpTjFVb0JrUUgwRzE5cTQxSDFHSVpq?=
 =?utf-8?B?ZmN4TmFEcDJseHJqUWR4RVhVQXVTOExHUU95VXN1OEhXcDc2MVpHemVGS3Vo?=
 =?utf-8?B?emZJOGJ0Qm93b1A3ZmQ4TkxtVGxsNDh4N2tpK2lvc01sVElvZkRxWWNZdHRS?=
 =?utf-8?B?NUsyMWNVNTRHOVBmc1hNaVpZZ3VhcEsrRGRHd3pnejFQQ1NTSEFsYTZ5TlRy?=
 =?utf-8?B?cWxoeHZVdzdyZm1UaFZkMTZycFNVcytPRGxLM3VRWmV3bnpnUFR5ZFRBMGpu?=
 =?utf-8?B?TC9KbGtKMnpQTG9ocm9BSDAyWXh1Znd6R3IyTkVFR2Q2d3V5eXNYNVNKUUZm?=
 =?utf-8?B?U3Vkb0dFV0szTzBlV1VQMWpJUGxsMGs5cHlQS0ZubWdYMzNUMXRlVXhHUHE4?=
 =?utf-8?B?UmUwRTc4bHBEeGVEWWxOTmZ1UVdBdWhRdy96RnFYcFd3aHNnWG4zUzh5QnZ2?=
 =?utf-8?B?OVJ5MFAxbUxTNzh6cDAyZXRNRG0zbE8zeUlsTWZYQ1NIRGVSenpQc1NUOUxy?=
 =?utf-8?B?RFBSYnB4NEkvZ3ZQK3htb2Rzb3NXanpGQUlEc3RicmJjWmN0K3NLd3JNN2lj?=
 =?utf-8?B?V0pkSk8yS2JPYmVWbFVCczZ0ZUVrZEFwd09ZQktHOHhFY25aNHViazJ1U05D?=
 =?utf-8?B?dXhyd0tIeXdZdlJ6WFBaaTNpdmlWK05Hb2FKNkIxc2V0VVBOK3ljK01aaWo1?=
 =?utf-8?B?QndYRHZ5K3BUZGtndjhkUisxdWFJdDJnQW95SFFvYmIrcDdVaC83dmpoN3NG?=
 =?utf-8?B?V1dZaTZNL2xLczYrUWU5QWYwT1hTc2VndmQybXRMOVB0UFhsL2ZVSXBvK0tp?=
 =?utf-8?B?SGV2NkdkcHVaYkxtdW5td3liOEU4eVBVR3NvUllzVlQ5RlRxSzhzbnZvb0lk?=
 =?utf-8?B?ZXp6NUYvSjJMNURRMnJFaHZaeXAySDVCdWhvRUxnN2dFa1hzWDR4M0V0a0VR?=
 =?utf-8?B?MndKekFNNW5MOUhySmxrZm5CeENmZHkrM2s4SFJobUpVaWhZbjZtWnpPWkUz?=
 =?utf-8?B?M2lwc1RqSDlOVnpFczlMeG9PS0Z4MEZpQjd3eDhSWXNtditaVnhmWjJscVFO?=
 =?utf-8?B?RWs5TFpacGxuYlp5UHBqR3ArUUxFcTlYTDRnTGh5cXE4am9CUnFjVUc1TC9o?=
 =?utf-8?B?YkNJNHFPS3ovRzA5dGU2Yk5aVzd3TjlObHMxTmUwY2tMUnB1Z1RiWm5CV0ZI?=
 =?utf-8?B?c1I2N1NkdFVYWDE5aUQ0SlBTWWlxYzl5ZkpMdGIyTnhzOVd6WnNGbExBcGta?=
 =?utf-8?B?b1MxUU5jQ05kbGNPM3lZYmFGdnRNSUhENlpNNy81TlJ6d3BaSDdQZ1pqMHQx?=
 =?utf-8?B?Tm5BUGRTamkxVnVMRW02djlGak81WlNYNlpLU0MwbFR2d0Q0UXhvUGtXeW1U?=
 =?utf-8?B?N2p0WmpxNGltL0ZBMXh4U1ZYTmZDazk5S3pBblV0N0RyS2hxUnVzMDJCbnNa?=
 =?utf-8?B?SzFuNXZZTUljdUJKQ3EvMkVHNm1nem1jZmZjSVZWcDd6YWZRVFdTZm5iLzBF?=
 =?utf-8?B?S1lmQUsvVWFiRDlHeFN6L05VZ0lWcXVkMVBpL0VKcDdrQnFMMzV4RHBKbUlo?=
 =?utf-8?B?NXBLRGJPcHdjK2tZejZ1S21Nc2V2bkFBbW53ZEhHV3pVZmpyd3FFc0pLZ29u?=
 =?utf-8?B?aHhCV3NjVG53cHczdGhuYXV1REdRbVdOK0NmM3dTNU9EOE01UHhiQW5RVzV3?=
 =?utf-8?B?MXhHTG9TUk1JaHhqcVRjcWJCaHVBN0FKMGVZSHRNSW1XMHBRNFpQNFlJYjBO?=
 =?utf-8?B?UU9UZkVJWjM1d3gvZUxBZTNPWXJnTkRzTC9oOTBQUzJHZ2VqS1hNeUhkUkJW?=
 =?utf-8?B?M2JPOStOeXoxLzVuaEh3K3A4U2NUTlJ2NldGb1pXV1d2UldpdjBsUkZiZ1pG?=
 =?utf-8?B?OGpnZnZIQ05KV3I1Wm56R0dFZHk5WTJJeDl4QjU0UTVoQjFTY2ZNaEZrY0xJ?=
 =?utf-8?B?bE1Fck5ZL3pEdUtaUnozTWE1cWpmdlZVa0QyOXZVcktiTDJUdVBkK1MxZnV4?=
 =?utf-8?B?eCs3UWZvV1JBeUJ2c3h1VnJIQzVwWHdtRTBHWU90cEZZSlVDRWFXRnNoMFoy?=
 =?utf-8?B?RHBWVENNYWRqQjF3YkJkWnloNmIzQjFDZzA0QjRSN2gvblVRd2k3bE5JcW44?=
 =?utf-8?B?L1FMRWV4dDBZRTBlWWtoeklObDQ1Nll2R0grZGU3ZE0vZklkTTdJdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 953d5603-7958-491f-2271-08da328abe13
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2022 13:41:10.1991
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rapsKm+hjcpM+JXmBjh8kfj/uUyG0HocU7d0tIgjW4kaDNPNP0cegQokDKeLzLgHdHSyIN8ac6LRBjqTWxcbJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR84MB1832
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: v96mgehI8PMvY9cR5z8A3lfWUdKuwr2h
X-Proofpoint-GUID: v96mgehI8PMvY9cR5z8A3lfWUdKuwr2h
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-10_03,2022-05-10_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 adultscore=0 mlxlogscore=934 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205100063
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiBUdWUsIE1heSAxMCwgMjAyMiBhdCAxOjUzIFBNIFZlcmR1biwgSmVhbi1NYXJpZSA8dmVy
ZHVuQGhwZS5jb20+IHdyb3RlOg0KPiA+DQo+ID4gSGkgQXJuZCwNCj4gPg0KPiA+ID4gICAgSGkg
TmljaywNCj4gPg0KPiA+ID4gICAgVGhpcyBzZWVtcyBhIGJpdCBtb3JlIGNvbXBsZXggdGhhbiBu
ZWNlc3NhcnkuIENhbid0IHlvdSBqdXN0IHVzZSBhIGN1c3RvbQ0KPiA+ICAgIGlubGluZSBhc20g
d2l0aCBhbiBleF90YWJsZSBlbnRyeSB0byBjYXRjaCB0aGUgZmF1bHQ/IEhhdmUgYSBsb29rIGF0
DQo+ID4gICAgX19nZXRfdXNlcl9hc20oKSBmb3IgYW4gZXhhbXBsZS4NCj4gPg0KPiA+ICAgICAg
ICAgICBBcm5kDQo+ID4NCj4gPiBXZSBnb3QgaW5zcGlyZWQgZnJvbSBkZWJ1Z19yZWdfaG9vayB3
aXRoaW4gdGhlIHNhbWUgc291cmNlIGZpbGUgKCANCj4gPi4vYXJjaC9hcm0va2VybmVsL2h3X2Jy
ZWFrcG9pbnQuYyApLiBXZSBjaG9zZSB0aGF0IHBhdGggdG8ga2VlcCANCj4gPmNvaGVyZW5jeSAg
d2l0aGluIHRoZSBzb3VyY2UgY29kZS4gV2UgY2FuIGltcGxlbWVudCB0aGUgc2FtZSBmaXggYnkg
DQo+ID51c2luZyBhbiBleF90YWJsZSAgZW50cnksIGJ1dCB0aGlzIHdpbGwgY3JlYXRlIHR3byBk
aWZmZXJlbnQgd2F5cyBhdCANCj4gPmNhdGNoaW5nIHVua25vd24gaW5zdHJ1Y3Rpb24gIHdpdGhp
biB0aGUgc2FtZSBzb3VyY2UgZmlsZS4gV2lsbCB0aGF0IGJlIG9rID8NCg0KPiBJIGdvdCBhIGxp
dHRsZSBsb3N0IHRyeWluZyB0byBmaW5kIHdoZXJlIHRoZSBicmVha3BvaW50IGluc3RydWN0aW9u
IGNvbWVzIGZyb20gdGhhdCBnZXRzIHRyYXBwZWQgaGVyZSwgYnV0IEkgd291bGQgZ3Vlc3MgdGhh
dCB0aGV5IGhhZCB0byBkbyB0aGlzIHVzaW5nIGFuIHVuZGVmX2hvb2sgYmVjYXVzZSB0aGUgZXhf
dGFibGUgYXBwcm9hY2ggZG9lcyBub3Qgd29yayB0aGVyZSBmb3Igc29tZSByZWFzb24uDQoNCj4g
SSB3b3VsZCBzdGlsbCBwaWNrIHRoZSBleF90YWJsZSBtZXRob2QgaGVyZSBpZiB0aGF0IHdvcmtz
Lg0KDQpJIHdpbGwgcHVyc3VlIHRoZSBtZXRob2QgeW91IGhhdmUgcmVjb21tZW5kZWQgQXJuZC4N
Cg0KVGhhbmsgeW91IGZvciB0aGUgZmVlZGJhY2sgYXMgYWx3YXlzLg0KDQotTmljayBIYXdraW5z
DQo=
