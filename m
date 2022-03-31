Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14A24EE311
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 23:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241632AbiCaVLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 17:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239183AbiCaVLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 17:11:42 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BF9167FAC;
        Thu, 31 Mar 2022 14:09:53 -0700 (PDT)
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22VK1nEf008009;
        Thu, 31 Mar 2022 21:09:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=W+dSfILCx+wpYCag5iefoozb3t2BtXJrwcRoM5BRaD0=;
 b=IXFN5hgoKgipBBQN9+iFwk1dS6COncokp0S6QsRBx3FkFAef1WlXY2SAXutW+Gr8X3Sb
 lxqa00kymeHR4j6UW9wcykICm3KcyEujoJ+KE0JV8jo2NtVtX432ym1s0zqIAi0nvuCH
 gqB/yPMVTjMBZSp1yyrCmcx02aCZo4y4z4PKVy679QMHX6sTXPrU5faj2xSR/nlopUNC
 TR8uhkFOBA/rlrDYgdl1LGeMN0XGfLgodbWzqYuAcdPocYBYLYM4pLZqUZ7S1NSH+zO0
 xvLe5MDSo2Ozzxv4+h6iYtlq8wi5sakVAC7AT4tawjYPqk/zY4m9gcXoWS+l6RPQjA/s Gw== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3f5gjshrm0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Mar 2022 21:09:41 +0000
Received: from p1wg14924.americas.hpqcorp.net (unknown [10.119.18.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id E6A34800398;
        Thu, 31 Mar 2022 21:09:40 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 31 Mar 2022 09:09:40 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Thu, 31 Mar 2022 09:09:40 -1200
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 31 Mar 2022 09:09:40 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZJJw4guWGGHzm8Ybaddqtnx8m9A4y53FfjPSwNgu643sdlE5rsdUIEFNO9ua44utKud3efuX5toFcwx4Y17LQYxX4Yv9URAfTBAtCJhCk7wgx5R93qqUqB9WXGLpSvvqZbz4eI7hUBt9HKOshwUAXOXgXYZDn2tqqMIJ0ik3ysGQdBGtVByIPPLJnhOYIZRcYUVrXLqm2AgcBVAgkfFc9i9Beej2BhWE3g17mW46myF61nYjtkwecxmGcYYuDnP/HIJodDrzBk+h979e412mlrVeVPGwm9R/JxX3W7zxk9pWSNEXHpe86NSv7rmuT3JY1vtKDFi2bXWBRH+eKE5LjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W+dSfILCx+wpYCag5iefoozb3t2BtXJrwcRoM5BRaD0=;
 b=EaUDwONEnQ23nzV+gjP3MCO7COCDcDZtx88XhWaW4SSDjUp9f6mFKb7y1eH1NV958O3e6STiSOWIQd+ViUjK2VArZ+6aaqNv/EXaD64Bhj7NJJ6f1XUoRh2ZM1G238d9Y3qazg0bD0H8EdoYMKUkyex304HKpGNu9VIYZcpN01PJoQdcEZuiBIvWDeCmRlV+VfEXgN354OIZoYzLWPyWmSHMn/nAF5nGZwp5SQyO1cVOCuDAZV1UzQ/UG+DCqBdsruhCgCW7bFjpeKXYLhZJrMtuzV4FhXLirhGZ4+tEuDLg/UiSLYsmIpf1TqnmEcZfDdtSI02izysDkud0QUbw3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:172::21)
 by DM4PR84MB1974.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4d::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5123.21; Thu, 31 Mar 2022 21:09:38 +0000
Received: from PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::bd27:815e:7c03:d1e4]) by PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::bd27:815e:7c03:d1e4%7]) with mapi id 15.20.5102.022; Thu, 31 Mar 2022
 21:09:38 +0000
From:   "Hawkins, Nick" <nick.hawkins@hpe.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     "Verdun, Jean-Marie" <verdun@hpe.com>,
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
Thread-Index: AQHYNLgx692NqDgvU0iOWKp+QCe0Uqy5/HOAgAgo3qCAAAx5AIAAD3gwgAEJmYCAE5R/wIAAGtkAgAAFszCAAZ7G8IAAu8qAgAC9QRA=
Date:   Thu, 31 Mar 2022 21:09:38 +0000
Message-ID: <PH0PR84MB17186189F5025374AA39584D88E19@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220310195229.109477-1-nick.hawkins@hpe.com>
 <20220310195229.109477-9-nick.hawkins@hpe.com>
 <eb66cc83-2da9-8e19-db69-633e34fef946@canonical.com>
 <PH0PR84MB1718C31DB71AA2A67FEC5F6E88119@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
 <b1cc2566-cd78-7cb4-f8a5-d6fc8065fe6e@canonical.com>
 <PH0PR84MB1718292B1C11F4FE83326A5388119@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
 <fb4def96-4b20-604f-d15d-fef87eb2232d@canonical.com>
 <PH0PR84MB1718A2CFBFC90C9C0CAA5515881E9@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
 <CAK8P3a0fCE_NM=z68d1m9BTfuKixh1pKLw3gn+Sr7SxKb6UJAg@mail.gmail.com>
 <PH0PR84MB17181C316E55073EBC28C386881E9@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
 <PH0PR84MB17185ADBA824F9CC9EB3E022881F9@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
 <CAK8P3a1080yz9jggOrwz2iQ1sAB2Xe2Emh22uCuqRok60BQSiA@mail.gmail.com>
In-Reply-To: <CAK8P3a1080yz9jggOrwz2iQ1sAB2Xe2Emh22uCuqRok60BQSiA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 55c07c69-2e4e-4735-1365-08da135ac44c
x-ms-traffictypediagnostic: DM4PR84MB1974:EE_
x-microsoft-antispam-prvs: <DM4PR84MB19744A78CABC4C1A69EB4D8288E19@DM4PR84MB1974.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jyiaz5BSPmnG/9K5oeTSuYBXAw6T94ajMPOkk/EazaACuNUu6as4LiR3g99vjTgcr+1kFpu34RmmlHmPKimdr/K7EBGQCzkjeAqu6Y5IxakttncBZc9TxrfN2sHN0i3YhJSEgSzS1ySWF72i5LM5opcPfNf0qPdi8vsHx6hPiNQmF5vHDsMoca16P+V0fbk/P1Tlzo3j4jwOTD3WkcRS0MiOM5IWEAdAn0shHhFW3hO9GmwkAY1yGwpZCLQqArtSQwXWVdRzWmRucZKcdyMUr98AsxgymJDgOr1m3z68w36qcx3te3GsL6tZlaxVaIWfxwP2vh3GliYJm6pezkUNBAO1VDF5Jz53bev1YRscU0TmJgqWoscyo7k/OKfDZmXkjZ82TthQx/7bd7KCMUceXCELdqGjf9zLVaHV10bVEaz5kL3CTaIJJpI/wBVXZBItrlf1R5Mpewpd682dovifxHqqlQErdQ+DJBsQ26RW07ImJP6j47Nhy4h8Hur9mNIvvr1WPgm6+qqJlZcn+nya+F2YACoZpYWCDfMKx6WmvgdVkLjkoB1FExooFg2syGhRTPhT+7lEj5e9qxLvP4yTspZBEu0LcbuKFDU9TkjmNXqZhDvSpEwtSzwZwad3Gr0STIQnu4ZwK8ujHGD8xvDyMgIvo3HbdoW/B9sAXYAzxaolS4gFqiQpUcVKcWLfc5ZVRExX03tYzC2PxRC8BEJzXw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(4326008)(76116006)(52536014)(66446008)(64756008)(26005)(55016003)(5660300002)(186003)(508600001)(33656002)(66946007)(66556008)(8676002)(82960400001)(316002)(54906003)(2906002)(6916009)(53546011)(122000001)(86362001)(6506007)(83380400001)(71200400001)(38100700002)(7696005)(9686003)(38070700005)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OHNUL24wVjkrVElFMVo0aWpub3NrTDJ5S1lORFllR1FYMzVzVWpqSEQvR2xk?=
 =?utf-8?B?clhnQkpSSWJnZXpUVkdGNWpxY3ZDeTNoUWJEQmlqMHM4MFR0QVl6S0JVaEQv?=
 =?utf-8?B?bG5UVEJRRXd6b1dhNk1PalBUNUU5ekc4aFhtUVBCUE0wditVSVk1cnJvcllK?=
 =?utf-8?B?MTdpRVRlaFdpZnBGenJ3NGlac1dmUkNFWjJiSm40d3ZVNTM3bm8vOEZBd3lN?=
 =?utf-8?B?OVhKVGFWc1BUaERPZXAxdFpuTHBFblZwMkFhbHhWVHhvUnc4VC9zWFJRa3N2?=
 =?utf-8?B?ajhMZThpTmJiMzJZc0F3dndsSmIyMzBtQk43ZGtvYjcvdDdGV3pQdjIraTc1?=
 =?utf-8?B?cEdoTU5LYkFSdW5JdHhVT2NkUGdQaTZZdkZ4YzJGTEtyR0MrYXVjc0dHQU45?=
 =?utf-8?B?Zm8waUR4NFhaa3grdEJaZHY3Zm1xY0orUXZwQkR0eGFqMjZiR1dFNlJlVURD?=
 =?utf-8?B?Y1JhZ2VTWlhZM0Z2a1dPL3ZXclgzbE5QMjR4cUE0T1o1cG5wWkpsVjdTRllV?=
 =?utf-8?B?USs5dDRtdS9zY05KNDc1S1B3RjJNN3JZUFBPbThnSWtZUnM4K2xkL0RMT2Ri?=
 =?utf-8?B?Unl0ZHllNHBzWUIxeWNKMHFLTTdrME9MOEtsUVBCOHIvNGxNMzVOS25Dd3hr?=
 =?utf-8?B?R0ZIRXFUWktxOEc1V2QwQXF4TUZETnIrdDcwdm96TXpiS1phLy9OalRDcm5H?=
 =?utf-8?B?OXRET1BwL1dPVGZyN1k5YmhvSkFFc2hUcmR6QWp4Uk5NMUh3QkJZZE9vVzND?=
 =?utf-8?B?cVBmR1BsdlhFTnZYZ1AxbXUzOWxWLzF1NE9DOGtDY2IzdXAvWWNxQ1FqNEda?=
 =?utf-8?B?aFhoaFFBQWJIMUxYNjFxREZVZjBBT3pzT0ljN0RQemJPNjZMUHhoY1AzdFEx?=
 =?utf-8?B?eFFuUG1CSmVFRGdwdUgydTM0eWwyZVZKeHZ0U0N1NUdXTmFXTmMzVzdNUEZJ?=
 =?utf-8?B?RDhId05WcWZIekVrQVR0djBPaWlPaEZuWFZFK1NYSG04SDBkUkVmOXgrSy92?=
 =?utf-8?B?Y2hESGNKTHJ0QjVDczJWOXdsZG1nYXgva2VxYVZ1angxMC9UL00xdDZibVEx?=
 =?utf-8?B?SjdjN0dBNXM4RjNsemVwbTFEZHZPZEk5aHpTekpUVnJvYXpiVnV2VGp5MjFy?=
 =?utf-8?B?d2tZeTN6ZFRRdDVkNTNrUExuZkcwUUtLWEdISW5mbU5MZWlUa2lmRWhlM2du?=
 =?utf-8?B?ZVpJbzRhV1RPWVAvWWtlK3hxZS8rYUc1QWxNRGJOYXN0cHg5Yyt4MG4xZ0FF?=
 =?utf-8?B?cTQwT1dzZEJpeWVxeGpxUDgrb2VnOEttNWduVGRIVWtGdlczNDQ2Vm9ySXJs?=
 =?utf-8?B?dm5RRkZqSXdWZ1pEYnRzNzRWRGs4ZTJEUzBNb2pHL3M1Q05vWnJxZ2VScWlN?=
 =?utf-8?B?RWl0Zml3NloxZDVyajAyWjFGQ0I5dWZEcFpwSW42eVBSNWFJZFZYR0IvN0Ns?=
 =?utf-8?B?R3V3YXdNNnZjN1liNitZMFZyYW1rbjJOc3pHSnlhd21iMzRnV0ZrN1B3dlNy?=
 =?utf-8?B?V2syMk5IZFNtekptYWNhUDFHWTUyaWc1cDFIWnVmN2hiM2JEdGl3UE1rZzhF?=
 =?utf-8?B?a3oxVHpmU25kbjE2S0IxTHhWcXA1Qkg4OURWYzNRb3YyUkVpQ1BlMUYzbHJl?=
 =?utf-8?B?TWlkVGN2UEdGbTYvYjBmT0IwUUt6U1U0ZS9WMm42ZGV4SnNERFQ0cGhnSmRL?=
 =?utf-8?B?eUVNY2tTRHR4UnlKQ2owOUl5WCtJUzNyd0ZDLzZNeVNOYkxNdTRBeE9adzVW?=
 =?utf-8?B?VzRabFJKalQxbExQWGxZNy9XREFpUjFYQ2pMQlpXd3JZb1FQOE8rZUJTaFJw?=
 =?utf-8?B?T2kxM2MwUStzUzZISGhsbnErQmZWUEdwU1ZEd3Y4RlZ3Z29HKzc0TlpNMEFR?=
 =?utf-8?B?bE9YbkhVWVlsWlNaMWlIK2hzNVpGTkk4SUtocy95akVFcTZ0MXB1bDhxRkFH?=
 =?utf-8?B?REVuV2t5dzc4UXFIWktkdkYrS1VKYU9Xa08rSXdLbkVxRmFkSmZVUXpCL2lM?=
 =?utf-8?B?dEY3MnpJOGdteVo1TTRTa09qamFNUnFpc2syamxxUzQ0aDloQ0NRVFIzbFlh?=
 =?utf-8?B?YjF0Y0NmRmppZlpCMld2Mzk5RVhMbXJvV09SUVgvLzl6U1Nnbno5d1dEd3g1?=
 =?utf-8?B?dEpZb0lyeVN1aHRPbUU4MHhsaXQ5KzllZVlTK3ZjbEUvam5Sbi8yM0JjeUdP?=
 =?utf-8?B?MmEvRS9CR0F6WVVMRTBPTCtDZlVmSU51bjNRWlhCK1JqZVUwSTdwaU9QZWth?=
 =?utf-8?B?Sld1d3F3K2hvc1FjU0xrc0JQNXM1SkJxWkxldkc5QTNtVHFiTUJqS2oxL1U1?=
 =?utf-8?B?dDdhUzZmdUxJVGs3eVl6OUd1eTlYOE5lQWkwTG8rRFpHTUVvbXc2dz09?=
Content-Type: text/plain; charset="utf-8"
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 55c07c69-2e4e-4735-1365-08da135ac44c
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2022 21:09:38.5932
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VTs85VHNk9/udABCh4pkPoUmoS25afLv5KgYLkxWKJGafpp0Rx6s6Akyid9Exmq9S3INYE7W1WYQr/m5OA/A2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR84MB1974
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: 9jdS4B2N4m7ZCMFGGLmNk2mL2J2YowIn
X-Proofpoint-ORIG-GUID: 9jdS4B2N4m7ZCMFGGLmNk2mL2J2YowIn
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-31_06,2022-03-31_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 phishscore=0 clxscore=1015 bulkscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 suspectscore=0 spamscore=0 priorityscore=1501 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203310111
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
dG86YXJuZEBhcm5kYi5kZV0gDQpTZW50OiBUaHVyc2RheSwgTWFyY2ggMzEsIDIwMjIgNDozMCBB
TQ0KVG86IEhhd2tpbnMsIE5pY2sgPG5pY2suaGF3a2luc0BocGUuY29tPg0KQ2M6IEFybmQgQmVy
Z21hbm4gPGFybmRAYXJuZGIuZGU+OyBWZXJkdW4sIEplYW4tTWFyaWUgPHZlcmR1bkBocGUuY29t
PjsgT2xvZiBKb2hhbnNzb24gPG9sb2ZAbGl4b20ubmV0Pjsgc29jQGtlcm5lbC5vcmc7IFJvYiBI
ZXJyaW5nIDxyb2JoK2R0QGtlcm5lbC5vcmc+OyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJh
ZGVhZC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnDQpTdWJqZWN0OiBSZTogW1BBVENIIHYzIDA5LzEwXSBhcmNoOiBhcm06IGJvb3Q6
IGR0czogSW50cm9kdWNlIEhQRSBHWFAgRGV2aWNlIHRyZWUNCg0KT24gVGh1LCBNYXIgMzEsIDIw
MjIgYXQgMTI6MjcgQU0gSGF3a2lucywgTmljayA8bmljay5oYXdraW5zQGhwZS5jb20+IHdyb3Rl
Og0KPiBPbiBUdWUsIE1hciAyOSwgMjAyMiBhdCA5OjM4IFBNIEhhd2tpbnMsIE5pY2sgPG5pY2su
aGF3a2luc0BocGUuY29tPj4gd3JvdGU6DQo+DQo+ID4+IEkgYW0gaW4gdGhlIHByb2Nlc3Mgb2Yg
cmV3cml0aW5nIHRoZSB0aW1lciBkcml2ZXIgZm9yIExpbnV4IGJ1dCBoYXZlIGhpdCBhIGRpbGVt
bWEgYW5kIEkgYW0gbG9va2luZyBmb3Igc29tZSBkaXJlY3Rpb24uIFRoZSByZWdpc3RlcnMgdGhh
dCByZXByZXNlbnQgdGhlIHdhdGNoZG9nIHRpbWVyLCBhbmQgdGltZXIgYWxsIGxheSBpbiB0aGUg
c2FtZSByZWdpc3RlciByZWdpb24gYW5kIHRoZXkgYXJlIHNwcmVhZCBvdXQgdG8gdGhlIHBvaW50
IHdoZXJlIHRoZXJlIGFyZSBvdGhlciBjb250cm9scyAgaW4gdGhlIHNhbWUgYXJlYS4NCj4gPg0K
PiA+PiBGb3IgaW5zdGFuY2Ugd2l0aCBvdXIgd2F0Y2hkb2cgY29udHJvbHMgd2UgaGF2ZToNCj4g
Pg0KPiA+PiBAOTAgdGhlIGNvdW50ZG93biB2YWx1ZQ0KPiA+PiBAOTYgdGhlIGNvbmZpZ3VyYXRp
b24NCj4gPg0KPiA+PiBBbmQgZm9yIG91ciB0aW1lciB3ZSBoYXZlOg0KPiA+PiBAODAgdGhlIGNv
dW50ZG93biB2YWx1ZQ0KPiA+PiBAOTQgdGhlIGNvbmZpZ3VyYXRpb24NCj4gPj4gQDg4IHRoaXMg
aXMgYWN0dWFsbHkgb3VyIHRpbWVzdGFtcCByZWdpc3RlciBidXQgaXMgYmVpbmcgaW5jbHVkZWQg
aW4gd2l0aCB0aGUgdGltZXIgZHJpdmVyIGN1cnJlbnRseSB0byBjYWxsIGNsb2Nrc291cmNlX21t
aW9faW5pdC4NCj4gPg0KPiA+PiBXaGF0IHdvdWxkIGJlIHlvdXIgcmVjb21tZW5kYXRpb24gZm9y
IHRoaXM/IEkgd2FzIGNvbnNpZGVyaW5nIGNyZWF0aW5nIGEgZ3hwLWNsb2NrIHRoYXQgc3BlY2lm
aWNhbGx5IHBvaW50cyBhdCB0aGUgdGltZXN0YW1wIHJlZ2lzdGVyIGJ1dCBJIHN0aWxsIGhhdmUg
dGhlIGlzc3VlIHdpdGggZ3hwLXRpbWVyIGFuZCBneHAtd2R0IGJlaW5nIHNwcmVhZCBhY3Jvc3Mg
dGhlIHNhbWUgYXJlYSBvZiByZWdpc3RlcnMuDQo+Pg0KPiA+IEkgdGhpbmsgdGhpcyBpcyBtb3N0
IGNvbW1vbmx5IGRvbmUgdXNpbmcgYSAnc3lzY29uJyBub2RlLCBoYXZlIGEgDQo+ID4gbG9vayBh
dCB0aGUgZmlsZXMgbGlzdGVkIGJ5DQo+Pg0KPj4gSSBmb3VuZCBhbiBleGFtcGxlIGFuZCBjb3Bp
ZWQgaXQgYWx0aG91Z2ggSSBoYXZlIGEgY291cGxlIHF1ZXN0aW9ucyB3aGVuIGl0IGNvbWVzIHRv
IGFjdHVhbGx5IGNvZGluZyBpdC4gQ2FuIHRoYXQgYmUgaGVyZSBvciBzaG91bGQgSSBwb3N0IHRo
ZXNlIHF1ZXN0aW9ucyBpbiB0aGUgcGF0Y2ggdGhhdCBhY3R1YWxseSBjb25jZXJuIHRoZSBmaWxl
Pw0KPj4NCj4+IHN0OiB0aW1lckA4MCB7DQo+PiAgICAgICAgIGNvbXBhdGlibGUgPSAiaHBlLGd4
cC10aW1lciIsInN5c2NvbiIsInNpbXBsZS1tZmQiOw0KPj4gICAgICAgICByZWcgPSA8MHg4MCAw
eDE2PjsNCj4+ICAgICAgICAgaW50ZXJydXB0cyA9IDwwPjsNCj4+ICAgICAgICAgaW50ZXJydXB0
LXBhcmVudCA9IDwmdmljMD47DQo+PiAgICAgICAgIGNsb2NrcyA9IDwmcHB1Y2xrPjsNCj4+ICAg
ICAgICAgY2xvY2stbmFtZXMgPSAicHB1Y2xrIjsNCj4+ICAgICAgICAgY2xvY2stZnJlcXVlbmN5
ID0gPDQwMDAwMDAwMD47DQo+Pg0KPj4gICAgICAgICB3YXRjaGRvZyB7DQo+PiAgICAgICAgICAg
ICAgICAgY29tcGF0aWJsZSA9ICJocGUsZ3hwLXdkdCI7DQo+PiAgICAgICAgIH07DQo+PiAgfTsN
Cg0KPiBJJ2QgaGF2ZSB0byBzdHVkeSB0aGUgb3RoZXIgZXhhbXBsZXMgbXlzZWxmIHRvIHNlZSB3
aGF0IGlzIG1vc3QgY29tbW9uLg0KDQo+IE15IGZlZWxpbmcgd291bGQgYmUgdGhhdCBpdCdzIGJl
dHRlciB0byBlaXRoZXIgaGF2ZSBhICJocGUsZ3hwLXRpbWVyIiBwYXJlbnQgZGV2aWNlIHdpdGgg
YSB3YXRjaGRvZyBjaGlsZCBidXQgbm8gc3lzY29uLCBvciB0byBoYXZlIGEgc3lzY29uL3NpbXBs
ZS1tZmQgcGFyZW50IHdpdGggYm90aCB0aGUgdGltZXIgYW5kIHRoZSB3YXRjaGRvZyBhcyBjaGls
ZHJlbi4NCg0KQXJuZCwgdGhhbmtzIGZvciB0aGUgZmVlZGJhY2suIEkgYW0gdHJ5aW5nIHRvIHVz
ZSB0aGUgYXBwcm9hY2ggeW91IHJlY29tbWVuZCB3aGVyZSB5b3UgaGF2ZSBhIHN5c2Nvbi9zaW1w
bGUtbWZkIHBhcmVudCB3aXRoIHdhdGNoZG9nIGFuZCB0aW1lciBhcyBjaGlsZHJlbi4NCg0Kc3Q6
IGNoaXAtY29udHJvbGxlckA4MCB7DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNv
bXBhdGlibGUgPSAiaHBlLGd4cC1jdHJsLXN0Iiwic3lzY29uIiwic2ltcGxlLW1mZCI7DQogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJlZyA9IDwweDgwIDB4MTY+Ow0KDQogICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHRpbWVyMDogdGltZXIgew0KICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAiaHBlLGd4cC10aW1lciI7DQog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW50ZXJydXB0cyA9IDwwPjsN
CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbnRlcnJ1cHQtcGFyZW50
ID0gPCZ2aWMwPjsNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjbG9j
a3MgPSA8JnBwdWNsaz47DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
Y2xvY2stbmFtZXMgPSAicHB1Y2xrIjsNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
fTsNCg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB3YXRjaGRvZyB7DQogICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJocGUsZ3hwLXdk
dCI7DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIH07DQp9Ow0KDQpUaGlzIGNvbXBp
bGVzIHdpdGhvdXQgYW55IGVycm9ycyBidXQgSSBkbyBoYXZlIHNvbWUgcXVlc3Rpb25zIGFib3V0
IGFjY2Vzc2luZyB0aGUgcmVnbWFwIGluIGJvdGggZHJpdmVycywgc3BlY2lmaWNhbGx5IHRoZSB0
aW1lciBjb2RlLiBIb3cgZG8geW91IHVzZSBhIHJlZ21hcCB3aXRoIGNsb2Nrc291cmNlX21taW9f
aW5pdD8gSSB0cmllZCBzZWFyY2hpbmcgdGhyb3VnaCB0aGUgY29kZWJhc2UgYW5kIGNvdWxkIG5v
dCBmaW5kIHRoZSBhbnN3ZXIuIEkgYXNzdW1lIEkgYW0gbWlzc2luZyBzb21lIHZpdGFsIHN0ZXAu
DQoNClRoYW5rcywNCg0KLU5pY2sNCg0KDQoNCg0K
