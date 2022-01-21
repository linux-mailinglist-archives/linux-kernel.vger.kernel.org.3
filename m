Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7ED49598D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 06:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378553AbiAUFqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 00:46:30 -0500
Received: from mail-dm6nam10on2108.outbound.protection.outlook.com ([40.107.93.108]:45024
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233439AbiAUFq3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 00:46:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R2w5dipsX+GSIx2NVbNEE2pmjuXH4Xlph1rSMpKRTuebzGGoGwG6cQ1iuWiKCkfeKK+eo+uccfiC84DznjklqXXwPLcDKZwQor9QA9C7udTSF8/fm0Uv7s+2eu3IN2UFYW997VSRtaE9IPhJ79avyqSigM4lDcFl34nTuA3YXpCKyVsZu63njIR5Wt5YN3n3hn4rS1+aHrccg95613CuuchsBUJWLLBjKkioJl/nA0A8Rw4m8otyqcYkaYDwKxzRmwQM4mSP6H5eSJIBjYBMZny8Jsu4C8AYJdinxLdn7d5CVEHG24xp3uf4tvQy/HedTrZsJgkk3rxjxqyDFjJL4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bw0xODGKQwi71hxguZ8s7nBraJw34fMm73cnb+LWdq4=;
 b=mKjMHpLwovMCwR/1k4OwRZh7HVv7DJfCM63KsaPxixmpHZ/UaDhqtXu96nuVd3zPMThuQwtZqsYBObLWbGj4/Ds4ELIDl7wSTjIPXh2NwQO3MlhGbl7d1KQNWlamceRflI552JPJVjdV315z27zBfyUZd5jNPE4nTfUYvf1Le2pevPfTX8x41C1u4AwcYrJxuCryWen34mECIdotTJd969cRNCnTAvRLUPS9/Ou5nOsTdS/YHW88gXZ1EdSvrSEurJohQw7t2179XgjpWVdvMsb8xsYusDmQLC/i1GcEdX5usVZWkXj/3gE/SAwQs3SmeN4fn/X4q4mJ8pGQC0mONQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=towerbridgetechnology.onmicrosoft.com;
 s=selector2-towerbridgetechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bw0xODGKQwi71hxguZ8s7nBraJw34fMm73cnb+LWdq4=;
 b=P36LybohIGQZrEjf41uiDIfDwZTrFDWLW747JQACoC6k9i7L+MAIKpf0TvF4w23pguw0sjTV56/lhWwTn6GDUlSZeVQS7i1fZruT3F60MjkVP94iwyeXN/Lm1T0YMcmtbY2eR4jGvSQZ2cqiTDmxTRxxVuc/r6GSGvUR+tFrcDc=
Received: from PH0PR16MB4248.namprd16.prod.outlook.com (2603:10b6:510:4c::16)
 by BL0PR16MB2258.namprd16.prod.outlook.com (2603:10b6:207:4c::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Fri, 21 Jan
 2022 05:46:27 +0000
Received: from PH0PR16MB4248.namprd16.prod.outlook.com
 ([fe80::e88f:f199:eed:4645]) by PH0PR16MB4248.namprd16.prod.outlook.com
 ([fe80::e88f:f199:eed:4645%7]) with mapi id 15.20.4909.010; Fri, 21 Jan 2022
 05:46:26 +0000
From:   "Chevron Li (WH)" <chevron.li@bayhubtech.com>
To:     "agross@kernel.org" <agross@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Shirley Her(SC)" <shirley.her@bayhubtech.com>,
        "Fred Ai(WH)" <fred.ai@bayhubtech.com>,
        "XiaoGuang Yu (WH)" <xiaoguang.yu@bayhubtech.com>,
        "Shaper Liu (WH)" <shaper.liu@bayhubtech.com>,
        "Bruce Yang (SH)" <bruce.yang@bayhubtech.com>
Subject: =?gb2312?B?s7e72DogW1BBVENIIDIvM10gbW1jOnNkaGNpLWJheWh1Yjpwcm92aWRlIGEg?=
 =?gb2312?Q?solution_to_improve_sd_host_card_compatibility?=
Thread-Topic: [PATCH 2/3] mmc:sdhci-bayhub:provide a solution to improve sd
 host card compatibility
Thread-Index: AQHYDoo7O32thMubdkKcJGCNcx9qrw==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 1
X-FaxNumberOfPages: 0
Date:   Fri, 21 Jan 2022 05:46:26 +0000
Message-ID: <PH0PR16MB4248E3FA9BAC163EF2F209E5EA5B9@PH0PR16MB4248.namprd16.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bayhubtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8167f3a7-28f7-4e09-24df-08d9dca15da3
x-ms-traffictypediagnostic: BL0PR16MB2258:EE_
x-microsoft-antispam-prvs: <BL0PR16MB225898AED208AF91386BDBD7EA5B9@BL0PR16MB2258.namprd16.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1332;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bJSYG+BirQ3vErlj78IaRYYA9gnxwSIJmaemr4yDqiK1hxk2yNCJTNOOmarYzXyVeaMQzi3OwamD4gNVtTMwU5BO3vc9P4PAf5wgkDPTFWM3MxApnEuj00gSuYeVKL2d31OUuQ9FrvhO6Q74+MZ8mC/tKfIEfzSu5qECr3nMcpj9jtwHoWdgwsJlVkH6Q4ik8Dm2dc5VGBQivEBWKG0BhkncOYNS6gIG1gNGjF5Zw4zJt3OVjLAix0tNCiRWdWNm+8ZVWV9ElwgVetJyf/Q4e/j5YBwgfmI0DYJtS5ysoFPIytzc85H6ZkYwdqrLS4pJcLk0GoB6DtRy072gk9gH0J4dRgjx1L71llS+X6GaE2OBp4K3OZO8Mo55tpC55rv10s6SgOyR9rhg3tRnUp7eQWA6pLfczNZh2ZcTVfUieZxNFan7jV2/jBBFmHeJ6sJTIJ+jotHoPjDOXlS8FBp+uXVq0agLbcY2Ksz9qhk0qFUllry9vOYLrRPH+LCqdw624UwqT1Bf/WTZu7MWeKDDP5CuLJ4D+8YDfk/9sgkijDYomq+17G8RYVNTJN6uBx/QeSpIN6j3tAHLxIEc+uijYyuKyJYXlap1RZXx6/W+GiAKMm3UPk1UBG4/PNHuiAUTyhz1v2rdlWhH4IUhuilZoFLTqm1hAHySBQqApAa1GYGbcu5T1UF1t/E3IXJ/HplnOXiPWz0miwPg0ys8/jRqLA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR16MB4248.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(39830400003)(136003)(396003)(346002)(366004)(376002)(508600001)(86362001)(33656002)(107886003)(7696005)(66446008)(64756008)(66946007)(66476007)(66556008)(52536014)(5660300002)(316002)(55016003)(9686003)(38070700005)(186003)(38100700002)(26005)(2906002)(71200400001)(4326008)(224303003)(54906003)(110136005)(8936002)(76116006)(122000001)(6506007)(558084003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?VlNJSElyaEIwY0hCbnh4eDB4Q1VaTXcvY1k2aVJiaGZJVVptKzA2TFpMekta?=
 =?gb2312?B?dlE3TUVkUnAyQ0VOdi9vc0RhVm92a0IxM3BjY1UxSWo2MXhoSllua1dlL2VI?=
 =?gb2312?B?VU1VVXNKeFpUclNLOEovNnp2SlZ6VWpuM0p3Tk5WRFBuR3hBQksyMTJkZ2NJ?=
 =?gb2312?B?N2poN3hRQWVHSDJycXM3V1JTMXI0eE9WdmdIMGVzWjlnZlRRSzhSSHg1Zlo0?=
 =?gb2312?B?Qng1bzV3bW1KbElBeUpjd3VsdnBzT1U4d1ZOZmFXSUorMGVHdHNjTi9BazlM?=
 =?gb2312?B?b1k1OVNhdkhPVFVyQ2J6azlSNVZzUXhiSmtweEpsOTJqdWVOTGpreTgrTzRn?=
 =?gb2312?B?bm5wT1p3L3RBbVZkZHpPaEdUTnZqS2ZvSVpPck85V3kyY0pHVzMxS3NrM1ZK?=
 =?gb2312?B?WU9UK2FCT0FUL2xwNHdLSDJzWlBQeDVJWGRhMXhnU2lYM09aQXhNdHdVUTkw?=
 =?gb2312?B?SXRITytPTWVueFVBdk9QMkRsVWJBZThtdXdKajVkMThKQldReFU5MmpneUtr?=
 =?gb2312?B?TjA2a0x1SGtScnVyNGxEWkg4UlJpTnZhUG1xb1VidzA0a1dPNHpaM0MrRWNH?=
 =?gb2312?B?N2IyRGp5RXpDMGhpSHVxSDhmWTJZUjFVNW5RSDh4dDFUcWszc1dmM2ZpQzJB?=
 =?gb2312?B?TDFTRFNPY1U2Q0UyNkJTWFErTjJKNlFWWG1CMXZBMTljU2ZMMHN3Vm1Ec0Zt?=
 =?gb2312?B?VHF6OE5QaDJ5SlFvZStsWUlqK0pDTDNsOHE5NmMwMWdMUjVQTk9NUjF6WEE5?=
 =?gb2312?B?N3dySllzdlA3UkxKZStraFcvQllaY0R2TVFEaHlGNnYvSW8raHRFamI5THhF?=
 =?gb2312?B?V1pqZ1RMZ1VpOEQycnlNZVlYTnFhYXNldkwwNzJabnMzbVl6YVlZOUtMVXlH?=
 =?gb2312?B?YVZZMDBQVi9GYUdwZFdTTHVTeFlBSDVMWDRTVGN1UzZIdWY3OEwxeXZkOU9n?=
 =?gb2312?B?a3p2M0ZUYW1Tc3lTbzFCY2lGSFo4OTYwNUU1TzZ6eGFlTm5pcjd3UUE0M1lE?=
 =?gb2312?B?YWFWMExEQ1hVN2NiRmcwOTJEM1cySmNMbWRwTGMyK1dkMnY4SFZ3R3lGNnNZ?=
 =?gb2312?B?amwxVFhuOHYwc201dWJpNjRwU0hDRXlyTVhSYmlreE84TlM4Tjg5SzI1blZk?=
 =?gb2312?B?MWJCcFgwbkZvdkU5TVJQVklYenVlUkQ2NDJrZGpGTEE4bldIc2ZuWldWMURY?=
 =?gb2312?B?T0JuRjZpelhWeTQvMjRodWV0T3F3eVFwYXc1alFkQUJFbmlIdC9LOVRHeHBN?=
 =?gb2312?B?UkdWWXNES3A1YzFBcVBMd05Dd0pmWk8xVGwxYjJCTkRPQ0FkSmR6YXVGLzBT?=
 =?gb2312?B?R1NSb291NDNGQ1VMWEZJVmFSZXN2N1ZaZmVldkM1SnhwRDRYeWlPZ0FkMjE3?=
 =?gb2312?B?REVYZFpFSXZQQnFnZXBBaGk0NXlyT1FjTDlXQm83bFpCcGZmaXEvTjl4aHI0?=
 =?gb2312?B?cXVXZFlBaDZSbHhlWWNXakpORGNoT09OMnBoK2NROUtJT0JEdGx2T1N2SUxU?=
 =?gb2312?B?NmFNVFBWOVlGampHb0h6dE1oUU11ZEgyM21JaEt6amVZV0VSSWIrWmh6Tmo1?=
 =?gb2312?B?bUV5NFZESHlKWmV3WUtYeGZSVnZmQmR3TDA3eDVaTU4ydEdlYTZ6K2wzVkpi?=
 =?gb2312?B?Z3cvbjRFTHNidVhkTnRRbUdJbGd5SVpYejRNbDBzRldpU1BDK1dmVWkzQ3M3?=
 =?gb2312?B?OGcvUFdxK3RWTWs5U0dYeTFGV2hndTFVWUFNdFNwZjhSUDNIclo5SXlCbUFE?=
 =?gb2312?B?K2x6cmtZM0cyeUhXZjNPNHZQdVlMZ01UdnFVM2RPTUgzMHlxMHhISHorUW82?=
 =?gb2312?B?bHhjTGllV2hJd1M2dGJadVJLdk9CSDFkUHdKNFU5WmRXQmJoSHZpU2hnN3di?=
 =?gb2312?B?b244R2tLM3hEZm1jWWcxa2M5ak02anc4SUZNOFFZaExIS0tDVzZLcld1VHFw?=
 =?gb2312?B?U1R2aTN2dWZIQmxwOEh4Q2hIV09xZ1l1VGZLMVk2YUk3NlZJU3RWMXRnMElE?=
 =?gb2312?B?cGlNWkd1OGZYMUhHdktYcWdjOVNrZTZiM2NoV2FRakRXOE0rK0VFdW1JK2hl?=
 =?gb2312?B?MEdPaU9lajJ3YUxidzczR054dWdLcHRrUitBNm9qcFpqeEliUEdFcDBFTjcw?=
 =?gb2312?B?ZmNRUUpCbEhLZEQ4ZmJzNnF6WEI5S2cwVVhWbC9VaHk1NGtHQ1VicEc5aS85?=
 =?gb2312?B?NDNnaFlyRDFKSkE4NFN2YTNLUE1yOWVLUURJMldWUVFraHg5bXpRYVRzVnZK?=
 =?gb2312?B?eDVnRzFHL2Nyby9mV3FDdmt5T0x3PT0=?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bayhubtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR16MB4248.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8167f3a7-28f7-4e09-24df-08d9dca15da3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2022 05:46:26.6423
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0a7aae2b-8f2e-44df-ba2f-42de7f93c642
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JCv2YhmhjnLXRdLEFaEQFfEyjMJfXy4J8AQWc42jAuQKl5y2Xma18fI4Ar6mgTmpPhEt2tVRWhgNwSZTn8pbeIxI/3391NmMKnkoB7sX+O4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR16MB2258
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q2hldnJvbiBMaSAoV0gpIL2rs7e72NPKvP6hsFtQQVRDSCAyLzNdIG1tYzpzZGhjaS1iYXlodWI6
cHJvdmlkZSBhIHNvbHV0aW9uIHRvIGltcHJvdmUgc2QgaG9zdCBjYXJkIGNvbXBhdGliaWxpdHmh
saGj
