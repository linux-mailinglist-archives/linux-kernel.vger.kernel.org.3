Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682694EB431
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 21:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238809AbiC2Tkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 15:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238235AbiC2Tkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 15:40:37 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC099A6E3A;
        Tue, 29 Mar 2022 12:38:51 -0700 (PDT)
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22TI1tTi013824;
        Tue, 29 Mar 2022 19:38:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=Un6nV9E8+TxsW73FPh1O5NW2CBv0wws+bjFE8AIKjt4=;
 b=NOIdeonl7l9EBoAEaP8YyTGmqmHrqIjxnT3KeLqHhowBfCsXYkalUl5DxtieyERb8MLg
 szAGgxXszi2hJSmvRd5w39kImDqs7qGg0K/Imbm0s6R0dO/gW/VKG8InJjEWapNo/7wu
 A7GAr2XYtLnheREZRsrhFbOSKC7RDyXgEcNbtTRTj7rooLGBfoQb91Q7dC+K+Ak9LFjb
 UP2ycuf7i5s7v4cTGQpoOWbRxCmGc+Kx4MbaWjdP3cgNtBYAuyzPBq+OFvnQhSm63D/m
 PaBsGsfEqkrfoZ1MX+NW/rxrKl/WD34eQ1VrCWJ/GxTHfKUSlliEj5zZ5BOCSmncHz6W tg== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3f3nmv1gkf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Mar 2022 19:38:30 +0000
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 943A61315E;
        Tue, 29 Mar 2022 19:38:29 +0000 (UTC)
Received: from p1wg14924.americas.hpqcorp.net (10.119.18.113) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 29 Mar 2022 07:38:29 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Tue, 29 Mar 2022 07:38:29 -1200
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 29 Mar 2022 19:38:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z/nzCW/I3eRaoIbZrFGgksJWuDGGthQmU3TIt93HI1LtQh+MXQABVdA3L29YEP1/Y/NEVOoVQhvrkEjWUQ4lglSDWdmPe5fae33qUCCQ8v7Sr7LGAau3hZWJ4XSGXgahOpo3RH0KC9HrGYo8vtRLvJn5+/bqsZIqADLIVHw9/7fU0F1Bn1doiaulFGQMg97lQx9YlJKnWhqSVM9l7KIDiJtxTNzAB5W2l0Zr2QN90sIGDqUYKRwY4+aewG/egRR0yxkaATWFelulz17ILZuw2VQ4Xep8AyswfrY4wuLMFjGSGIU2beVg6U10CYzA7cMMrG9KU2UMa6+9W9La1kKfCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Un6nV9E8+TxsW73FPh1O5NW2CBv0wws+bjFE8AIKjt4=;
 b=lrqTz8ifmcYj1cFvWqP7xN2i0jxqLw8a0uQJXUXrx3Yo116IikJRoPGJLC5oz3UYCKWJMBnXPnwrvG9EpFEli99fmb6sY6+pqhq7Ke8refwzbVjPqQABdznAYVCk1ZcFPtJJDjxAERg6J2U/1U6yKBmLEBA6ggmLre/vm6r2DY2mvmnX1m9q0kHsCcCGu1rKVIi3pVMeMSmhbgNsrEuFN2mvL2efdphuHOTECKlzasFLpUUqOSFAhhUJh3wLtdp1+p4rbRhigBicnkrS/vj2KGLtFfrOlMIBIpYeWGB9mluITSlEj4M821SN4junQupiJO/qn1I6fGuWI4a/dDe+ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:172::21)
 by MW4PR84MB1587.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1a6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.23; Tue, 29 Mar
 2022 19:38:27 +0000
Received: from PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::bd27:815e:7c03:d1e4]) by PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::bd27:815e:7c03:d1e4%7]) with mapi id 15.20.5102.022; Tue, 29 Mar 2022
 19:38:27 +0000
From:   "Hawkins, Nick" <nick.hawkins@hpe.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "Verdun, Jean-Marie" <verdun@hpe.com>
CC:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
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
Thread-Index: AQHYNLgx692NqDgvU0iOWKp+QCe0Uqy5/HOAgAgo3qCAAAx5AIAAD3gwgAEJmYCAE5R/wA==
Date:   Tue, 29 Mar 2022 19:38:27 +0000
Message-ID: <PH0PR84MB1718A2CFBFC90C9C0CAA5515881E9@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220310195229.109477-1-nick.hawkins@hpe.com>
 <20220310195229.109477-9-nick.hawkins@hpe.com>
 <eb66cc83-2da9-8e19-db69-633e34fef946@canonical.com>
 <PH0PR84MB1718C31DB71AA2A67FEC5F6E88119@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
 <b1cc2566-cd78-7cb4-f8a5-d6fc8065fe6e@canonical.com>
 <PH0PR84MB1718292B1C11F4FE83326A5388119@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
 <fb4def96-4b20-604f-d15d-fef87eb2232d@canonical.com>
In-Reply-To: <fb4def96-4b20-604f-d15d-fef87eb2232d@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2fbbf11e-44ea-44d2-0f72-08da11bbb280
x-ms-traffictypediagnostic: MW4PR84MB1587:EE_
x-microsoft-antispam-prvs: <MW4PR84MB1587A82EFD40FB545450612D881E9@MW4PR84MB1587.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mjbdXwsOdoeYPBoJF7HqxUkX1qDEN07QTxFXbs56w3de9rAR+y+utKwJLZqadXn4rR2yHs87BEmPjItTFxlH2CDh7VEVXIsgWjajn7xXrzc9yY7qTGzyahgXNHcGAeYvPl6rArOO/LfSrt39qm8iT3d9+BYKOmWCmHapYsnPTHwawA0ErXoyzxSn4oWTeOBIkA4LZs49rXT6u4P1TU4d1/Uf4dYobwwqyjhFIC5U8Y3dQNt7K8cbCH9ZN5ODAKN9prH64Ngpv0S1dhewNj7kuOMEcjNJPVumK78Uis8Art3QYzx2wWZvLfO1RIt1rL6ry6+kif0UBXxHlz6npDT/qtZn8bnOw7UBHkZkOZ71L9oHHtxKbE/z0qt8c6hjkrfFRFrPLdem/Bvsq81dAXIqxEoNbxyH3Wp8AA58XZWCNaBnLnf8kw7ACm6cwmKOlx7wIvq3Xtpw+7Tl2E1rEjsjEiuIqzakfL86uGBPlRkhyLGRGEQnam7L1489B0cxlvXIUwI19f3nrbyGIFVJRF0dqWCjLYkUzhtZqqrAFg6F5O0UzYzUobxQ2R+gyS9owuLxVlOyGHYV62iZsKPU7JllhCNZDI+r3kVMoI4p/xAq8uPfO+gJTrwgAZHlmHwWGBCHXZMEKELNspa93HJF+4XcmbsWgxTMb3LKG/2vmBG7IZIXRu/ziFbrkeNduVTu3WAib1fw5Iit+vAGHXD2ONV39A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(55016003)(82960400001)(508600001)(38070700005)(6506007)(38100700002)(33656002)(7696005)(122000001)(86362001)(53546011)(52536014)(26005)(66946007)(316002)(186003)(55236004)(9686003)(83380400001)(5660300002)(71200400001)(2906002)(8936002)(4326008)(66446008)(64756008)(6636002)(76116006)(110136005)(54906003)(66476007)(66556008)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aTQwYmpQVEZsWERqMEU0Ni9oOWZUMVAwU1QvZG9YQ25nWEczTDFVdElvd21J?=
 =?utf-8?B?bGFBVUxNalBIK3JTb1RsRENETzJpMTgvaHQ4QXVrdFI0L1hFcmVvczFsSXdM?=
 =?utf-8?B?UTA4N0tQTW1RY1l1K3MwQTJKRlo4akNBSXRpOHRCeHRhcUhHcGcrSStwNXpN?=
 =?utf-8?B?NzJwMFNZNFJUS3BiYmRFSFE1eWhocWNCZFRkQVd0T1VLWmRaaDJ1SmFSbkth?=
 =?utf-8?B?bW85c3pzTnJPdVZ2Q0xyMjZxM0tFQldsdHVSdG13OGRyWlZScWZaVUdjODN0?=
 =?utf-8?B?VHVjeStTMTBVb3pvS1l1bDFGeDNibFdMeEtTYjlBZWNMazVMNkhBc0kzR1Ra?=
 =?utf-8?B?Q1RVZjNzcFJ6dDNSQytTbi9DZ0pKV3NPaEx6ZDQ4MlBrTkV2cTRLRjltZVN0?=
 =?utf-8?B?QkNwU0F5TjdZYWlsN1ZUZjdXYVZzQm83NUswV2pVN0tWUkxIRWpkVmJQcmx3?=
 =?utf-8?B?SG40U3IrYno4MTdRUlZwWmpWODM2ZzBUVDJxV3ZCdDcvazBETlJnMXkwRFhC?=
 =?utf-8?B?OWNrVGhqallxb3Mwc3JjYlVLSzZuY0hMZ0tOOHlmZWJHYWp0WndYQmhZQTM3?=
 =?utf-8?B?RVpKblN2YkxiOUpLVEh1enA2SGhOdUM0N0hlWTlwSTBzZXN1dVhNenhhcVVk?=
 =?utf-8?B?ZlZ5dWV0TFAxcGJYa2w2cndSWG8yRFNCNWVXT0piRk9VMDc3aEMwbWFhOUZw?=
 =?utf-8?B?NWlSb3hpU242RlJManNpM2dNT3ZlcmlSN2hUSG5rb3hLSnFhYzBTSFU3Yi9U?=
 =?utf-8?B?RzBnRmFRRlo2RC9ZMHlSd3B6Ymx5eFY2ZU96Z0NIY2pxcmVsVkdjK3JiMkFV?=
 =?utf-8?B?SE1nZ1pJRTZxUVd4RUpOVEtnam9DeUpLeFRkdDdNbXN6d3diSXp4SVFSSHQ1?=
 =?utf-8?B?WE1QcjkySEMwYU45a2lPbFkxOVcxVEl4b3pOWk80dlZ4TG1GMThZMHkwWERU?=
 =?utf-8?B?eFQvS042elhTQUt0Y3dVMWY1OWtuV3Q0QkhUWmtrVGR0THUreUYxYk9Zczdy?=
 =?utf-8?B?TERtaUVlbHNFRVBKWUNDalFWaGI1WW8zWTRjcFA2TGtFVUlNekVnWnRCNm5m?=
 =?utf-8?B?eThqNzRPNVR5Z2RDUElwQi9oeWVGaWhwRUkrcUErZXh2dzNwR1J2bGRrVDJi?=
 =?utf-8?B?ckIwbkpsSU1rVVUxSisxNE4yOVZDODNtT1B1L3hNVjlITVBia0w2VW5JaGNH?=
 =?utf-8?B?d0ljTGhKZTdoaFQ2SnVzbEdtZ1J1cXJCbFJmNTB3Q3c0SHhBVEhmaDZ0eSta?=
 =?utf-8?B?V1hSRFI3dW5ZU0p6cHN4MnAzcHhnUmdBUjlpNi9RMlIvRWMzYkx5Sy9qUC9G?=
 =?utf-8?B?a2RnVHBWKzNVYi9TcElTYUpVK3NDM0taMUNMOWhpMm5GclprNDlIZklqVjkx?=
 =?utf-8?B?UTk4NGRsa0dveTJnT08zdXhneUFEOUMrUUMxdkxIZUVUVi94RjFzdzFqQ1Zr?=
 =?utf-8?B?b3BrclNHNWVuNFJ1SS9hUm10MTJ5WWhVUFNmK3VTRHNXSlhkYTg3cnpDM1pa?=
 =?utf-8?B?N0lFNUFORThVWW1RQTV6Z0o3WkovRldaUlZDQXVFa1dkdDhkWjRIVEdodGo3?=
 =?utf-8?B?ajNINk9SVStlK1Q3dE1DTER0NnpiZ0o0SHFkTCsyWlVTM1daWEVjVUloclpt?=
 =?utf-8?B?U3ljMXBlL1BlZDRMdDdlS3I3bUJBNDVBSTl2ODVzVTN0ajJ3UUlpWTRuTU4x?=
 =?utf-8?B?VHBVQmJiVzBHR2RyeWJaNy9iSHFQOTd4WHB1Q2gzdUtJeWw3d1ZUUXdaVHVz?=
 =?utf-8?B?OFF6NnlwUGNSc3ZOTTNrNS9JaTNXZnRRb0s4YStnTzBYQytKb0duUGRtdjE2?=
 =?utf-8?B?aHkzT200MjVWb2hnbDVqQUJKSjZ1Yks0Nm1nVFI1RlBvTVh5TUY0UUprMXMx?=
 =?utf-8?B?MzRqZXlOTDNkR2htRjdUSThERzh5cDZhajlHdFVuSzE2QjU1ZjJ6UlZKak8w?=
 =?utf-8?B?SzJLOUpBZmpydExncVo5Q0RWTWJaTDB4eWNWZ0hNWTdPZWFML2lxYUxTYm5Y?=
 =?utf-8?B?anZCVVNtaitKeFdkTVNjbjFMZGMraHNqZy9rQXpzV3V3c2w3NjlnenA0TFkx?=
 =?utf-8?B?MVBwZzFiR0RTb0JyYVNhcGlWdzlEbTlNVTJBdXJTUUJhdmJzL3JETCtjcENn?=
 =?utf-8?B?UzV5WE1TUFRiRmRPQmZsTmkvR1h0Nkg4YkFDbjF6K2JJNTRYRXFXMlZFdWR2?=
 =?utf-8?B?K3hWdmFpZXpNOWZPS3ROTmM4Y0s0dThGNTVOeEJWSFNiVW5TYUplUzRBcVRt?=
 =?utf-8?B?SXl2alhkOVpEV3pSNW1PbDRhNVIyemp1YVljWnhCbHRZdURKNDlyaTI1MFFr?=
 =?utf-8?B?K2xZQnhocnlSVGxlRVBTYTNhVXgrUHdRQ2hUQ20xclAzQUxGM0Yvdz09?=
Content-Type: text/plain; charset="utf-8"
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fbbf11e-44ea-44d2-0f72-08da11bbb280
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2022 19:38:27.5921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y+462BqN3SK3sZbKinZchAxMfFUfOTEQ3Onn0UZHI4WHgkJf3i9Z3kkfNBAv5R3+nsHIMVKz6/MduPjoVgzcuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR84MB1587
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: t7gLiwBmkwX-HwbwBfsPxBm0HR0sehSW
X-Proofpoint-GUID: t7gLiwBmkwX-HwbwBfsPxBm0HR0sehSW
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-29_08,2022-03-29_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 malwarescore=0 clxscore=1011 impostorscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 priorityscore=1501 mlxlogscore=999
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203290108
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEtyenlzenRvZiBLb3psb3dza2kgW21h
aWx0bzprcnp5c3p0b2Yua296bG93c2tpQGNhbm9uaWNhbC5jb21dIA0KU2VudDogVGh1cnNkYXks
IE1hcmNoIDE3LCAyMDIyIDM6MzcgQU0NClRvOiBIYXdraW5zLCBOaWNrIDxuaWNrLmhhd2tpbnNA
aHBlLmNvbT47IFZlcmR1biwgSmVhbi1NYXJpZSA8dmVyZHVuQGhwZS5jb20+DQpDYzogQXJuZCBC
ZXJnbWFubiA8YXJuZEBhcm5kYi5kZT47IE9sb2YgSm9oYW5zc29uIDxvbG9mQGxpeG9tLm5ldD47
IHNvY0BrZXJuZWwub3JnOyBSb2IgSGVycmluZyA8cm9iaCtkdEBrZXJuZWwub3JnPjsgbGludXgt
YXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9y
ZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KU3ViamVjdDogUmU6IFtQQVRDSCB2MyAw
OS8xMF0gYXJjaDogYXJtOiBib290OiBkdHM6IEludHJvZHVjZSBIUEUgR1hQIERldmljZSB0cmVl
DQoNCk9uIDE2LzAzLzIwMjIgMjE6MTAsIEhhd2tpbnMsIE5pY2sgd3JvdGU6DQoNCiguLi4pDQoN
Cj4+Pj4+PiBJIHRoaW5rIG9uZSBvZiBwcmV2aW91cyBjb21tZW50cyB3YXMgdGhhdCB5b3UgY2Fu
bm90IGhhdmUgImdlbmVyaWMtZWhjaSINCj4+Pj4+PiBvbmx5LCByaWdodD8NCj4+Pg0KPj4+PiBZ
ZXMgdGhlcmUgd2FzLCBJIHJlbW92ZWQgdGhlIHVzYjA6IGVoY2lAY2VmZTAwMDAuIEkgc2VlIG5v
dyB0aGF0IHRoaXMgaXMgaW4gcmVmZXJlbmNlIHRvIHRoZSBjb21wYXRpYmxlLiBUaGlzIGlzIG91
ciBlaGNpIGNvbnRyb2xsZXIuIFdoYXQgd291bGQgYmUgYSBtb3JlIGFwcHJvcHJpYXRlIGNvbXBh
dGlibGU/IERvIHdlIG5lZWQgaHBlLGd4cC1laGNpIHBlcmhhcHM/DQo+PiANCj4+PiBZZXMsLCBz
ZWUgb3RoZXIgY2FzZXMgaW4gZ2VuZXJpYy1laGNpLnlhbWwgYmluZGluZ3MuIFlvdXIgY3VycmVu
dCBjaG9pY2Ugd291bGQgYmUgcG9pbnRlZCBvdXQgYnkgZHRic19jaGVjaywgdGhhdCBpdCdzIGlu
dmFsaWQgYWNjb3JkaW5nIHRvIGN1cnJlbnQgYmluZGluZ3MuDQo+PiANCj4+IEZvciBzb21lIHJl
YXNvbiB3aGVuIEkgY29tcGlsZSBJIGFtIG5vdCBzZWVpbmcgYSB3YXJuaW5nIGZvciB0aGF0IGZp
bGUuIEkgaGF2ZSBiZWVuIHVzaW5nICJtYWtlIGR0YnNfY2hlY2siIGFuZCAibWFrZSBkdGJzIFc9
MSIuIFBlcmhhcHMgSSBhbSBtaXNzaW5nIGFuIGltcG9ydGFudCBmbGFnPw0KDQo+IE15IGJhZCwg
SSBtaXNyZWFkIHRoZSBnZW5lcmljLWVoY2kgYmluZGluZywgc28geW91ciBjb21wYXRpYmxlIGlz
IGFjdHVhbGx5IGNvcnJlY3QgZnJvbSBiaW5kaW5ncyBwb2ludCBvZiB2aWV3LiBTdGlsbCBjb21t
b24gcHJhY3RpY2UgaXMgdG8gYWRkIG93biBjb21wYXRpYmxlIHdoaWNoIGFsbG93cyBsYXRlciBj
dXN0b21pemF0aW9uLg0KDQo+PiBJbiB0aGUgY2FzZSBvZiBjcmVhdGluZyBhIGhwZSxneHAtZWhj
aSBiaW5kaW5nIHdvdWxkIEkgbmVlZCB0byBhZGQgdGhhdCB0byB0aGUgZ2VuZXJpYy1laGNpLnlh
bWw/DQoNCj4gWWVzLCBhZGQgeW91ciBjb21wYXRpYmxlIHRvIHRoYXQgYmlnIGVudW0gd2l0aCBs
aXN0IG9mIG1hbnkgaW1wbGVtZW50YXRpb25zLg0KDQpEb25lLg0KDQo+ICguLi4pDQoNCj4+Pj4+
Pj4+ICsNCj4+Pj4+Pj4+ICsJCW1lbWNsazogbWVtY2xrIHsNCj4+Pj4+Pj4+ICsJCQljb21wYXRp
YmxlID0gImZpeGVkLWNsb2NrIjsNCj4+Pj4+Pj4+ICsJCQkjY2xvY2stY2VsbHMgPSA8MD4+Pj47
DQo+Pj4+Pj4+PiArCQkJY2xvY2stb3V0cHV0LW5hbWVzID0gIm1lbWNsayI7DQo+Pj4+Pj4+PiAr
CQkJY2xvY2stZnJlcXVlbmN5ID0gPDgwMDAwMDAwMD4+Pj47DQo+Pj4+Pj4+PiArCQl9Ow0KPj4+
DQo+Pj4+Pj4gV2hhdCBhcmUgdGhlc2UgY2xvY2tzPyBJZiBleHRlcm5hbCB0byB0aGUgU29DLCB0
aGVuIHdoZXJlIGFyZSB0aGV5PyBPbiB0aGUgYm9hcmQ/DQo+Pj4NCj4+Pj4gVGhpcyB3YXMgdGhl
IGludGVybmFsIGlvcGNsayBhbmQgbWVtY2xrIHRoZXkgd2VyZSBib3RoIGludGVybmFsIHRvIHRo
ZSBjaGlwLg0KPj4+PiBGb3Igbm93IEkgYW0gcmVtb3Zpbmcgb3NjIGFuZCBtZW1jbGsgYW5kIHdp
bGwganVzdCBoYXZlIGFuIGlvcGNsayB0aGF0IEd4cC10aW1lciB3aWxsIHJlZmVyIHRvLg0KPj4g
DQo+Pj4gWW91IHNob3VsZCByYXRoZXIgaGF2ZSBhIGNsb2NrIGNvbnRyb2xsZXIgZHJpdmVyIHdo
aWNoIGRlZmluZXMgdGhpcyAoYW5kIG1hbnkgb3RoZXJzKS4gVGhleSBjYW4gc3RheSBhcyBhIHRl
bXBvcmFyeSB3b3JrLWFyb3VuZCwgaWYgeW91IHJlYWxseSBuZWVkIHRoZW0gZm9yIHNvbWUgb3Ro
ZXIgbm9kZXMuDQo+PiANCj4+IEkgYW0gdHJ5aW5nIHRvIHBpY3R1cmUgd2hhdCB5b3UgYXJlIHNh
eWluZyBidXQgSSBhbSB1bnN1cmUsIEkga25vdyB0aGF0IG9uIGEgc2VwYXJhdGUgcmV2aWV3IHlv
dSBtZW50aW9uZWQgdGhhdCB0aGUgZ3hwLXRpbWVyIG5lZWRlZCB0byBoYXZlIGNsb2NrcywgYW5k
IGNsb2NrLW5hbWVzIGluc2lkZSB0aGUgbm9kZS4gV291bGQgaXQgYmUgaW1wcm9wZXIgZm9yIHRo
ZSBneHAtdGltZXIgdG8gcmVmZXJlbmNlIGlvcGNsaz8NCg0KPiBJdCBhbGwgZGVwZW5kcyBvbiB0
aGUgYXJjaGl0ZWN0dXJlIG9mIHlvdXIgU29DLiBJIGNvdWxkIGltYWdpbmUgc3VjaCBvbmU6DQo+
IDEuIEZldyBleHRlcm5hbCAoZnJvbSBTb0MgcG9pbnQgb2Ygdmlldykgb3NjaWxsYXRvcnMsIHVz
dWFsbHkgcHJvdmlkZWQgb24gdGhlIGJvYXJkLiBJdCBjb3VsZCBiZSAyNCBNSHosIGNvdWxkIGJl
IDMyNzY3IEh6IGZvciBCbHVldG9vdGggZXRjLg0KDQo+IDIuIE9uZSBvciBzZXZlcmFsIGNsb2Nr
IGNvbnRyb2xsZXJzIGluc2lkZSB0aGUgU29DIHdoaWNoIHRha2UgYXMgaW5wdXQgdGhlc2UgZXh0
ZXJuYWwgY2xvY2tzLiBUaGUgY2xvY2sgY29udHJvbGxlciBwcm92aWRlcyBjbG9ja3MgZm9yIHNl
dmVyYWwgb3RoZXIgY29tcG9uZW50cy9ibG9ja3MuIEFsbG93cyBhbHNvIGdhdGluZyBjbG9ja3Ms
IHJlcGFyZW50aW5nIGFuZCBjaGFuZ2luZyBkaXZpZGVycyAocmF0ZSkuDQoNCj4gMy4gT3RoZXIg
YmxvY2tzIHdpdGhpbiB5b3VyIFNvQywgZS5nLiBneHAtdGltZXIsIHVzZSB0aGVzZSBjbG9ja3Mu
DQoNCj4gVGhlIHRydWUgcXVlc3Rpb24gaXMgd2hlcmUgaXMgdGhhdCBtZW1jbGsgb3IgaW9wY2xr
IGdlbmVyYXRlZD8gSXMgaXQgY29udHJvbGxhYmxlIChnYXRlL211eC9yYXRlKT8gRXZlbiBzb21l
IGZpeGVkLWZyZXF1ZW5jeSBjbG9ja3MsIGNvbWluZyBvdXQgb2YgdGhhdCBjbG9jayBjb250cm9s
bGVyIChwb2ludCAyLiksIGFyZSBkZWZpbmVkIGluIHRoZSBjbG9jayBjb250cm9sbGVyIGJlY2F1
c2UgdGhhdCdzIHRoZSBsb2dpY2FsIHBsYWNlIGZvciA+dGhlbS4NCg0KRnJvbSB0aGUgcGVyc3Bl
Y3RpdmUgb2Ygb3VyIFNvQyB0aGVyZSBpcyBhIFBQVUNMSyB0aGF0IGdlbmVyYXRlcyB0aGUgY2xr
IHNpZ25hbHMgZm9yIG91ciB3YXRjaGRvZyBhbmQgdGltZXIuIFRoaXMgaGFwcGVucyBpbnNpZGUg
dGhlIFNvQy4gSSBhbSB0cnlpbmcgdG8gcmVwcmVzZW50IHRoaXMgYmVsb3cuDQoNCmF4aSB7DQoJ
CWNvbXBhdGlibGUgPSAic2ltcGxlLWJ1cyI7DQoJCSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KCQkj
c2l6ZS1jZWxscyA9IDwxPjsNCgkJcmFuZ2VzOw0KCQlkbWEtcmFuZ2VzOw0KDQoJCWFoYkBjMDAw
MDAwMCB7DQoJCQljb21wYXRpYmxlID0gInNpbXBsZS1idXMiOw0KCQkJI2FkZHJlc3MtY2VsbHMg
PSA8MT47DQoJCQkjc2l6ZS1jZWxscyA9IDwxPjsNCgkJCXJhbmdlcyA9IDwweDAgMHhjMDAwMDAw
MCAweDMwMDAwMDAwPjsNCg0KCQkJLi4uDQoNCgkJCXRpbWVyMDogdGltZXJAODAgew0KCQkJCWNv
bXBhdGlibGUgPSAiaHBlLGd4cC10aW1lciI7DQoJCQkJcmVnID0gPDB4ODAgMHgxPiwgPDB4OTQg
MHgwMT4sIDwweDg4IDB4MDg+Ow0KCQkJCWludGVycnVwdHMgPSA8MD47DQoJCQkJaW50ZXJydXB0
LXBhcmVudCA9IDwmdmljMD47DQoJCQkJY2xvY2tzID0gPCZwcHVjbGs+Ow0KCQkJCWNsb2NrLW5h
bWVzID0gInBwdWNsayI7DQoJCQkJY2xvY2stZnJlcXVlbmN5ID0gPDQwMDAwMDAwMD47DQoJCQl9
Ow0KDQoJCQl3YXRjaGRvZzA6IHdhdGNoZG9nQDkwIHsNCgkJCQljb21wYXRpYmxlID0gImhwZSxn
eHAtd2R0IjsNCgkJCQlyZWcgPSA8MHg5MCAweDAyPiwgPDB4OTYgMHgwMT47DQoJCQl9Ow0KDQoJ
CQkuLi4NCgl9Ow0KDQoJY2xvY2tzIHsNCgkJcHB1Y2xrOiBwcHVjbGsgew0KCQkJY29tcGF0aWJs
ZSA9ICJmaXhlZC1jbG9jayI7DQoJCQkjY2xvY2stY2VsbHMgPSA8MD47DQoJCQljbG9jay1vdXRw
dXQtbmFtZXMgPSAicHB1Y2xrIjsNCgkJCWNsb2NrLWZyZXF1ZW5jeSA9IDw0MDAwMDAwMDA+Ow0K
CQl9Ow0KCX07DQoNCkkgYW0gaW4gdGhlIHByb2Nlc3Mgb2YgcmV3cml0aW5nIHRoZSB0aW1lciBk
cml2ZXIgZm9yIExpbnV4IGJ1dCBoYXZlIGhpdCBhIGRpbGVtbWEgYW5kIEkgYW0gbG9va2luZyBm
b3Igc29tZSBkaXJlY3Rpb24uIFRoZSByZWdpc3RlcnMgdGhhdCByZXByZXNlbnQgdGhlIHdhdGNo
ZG9nIHRpbWVyLCBhbmQgdGltZXIgYWxsIGxheSBpbiB0aGUgc2FtZSByZWdpc3RlciByZWdpb24g
YW5kIHRoZXkgYXJlIHNwcmVhZCBvdXQgdG8gdGhlIHBvaW50IHdoZXJlIHRoZXJlIGFyZSBvdGhl
ciBjb250cm9scyAgaW4gdGhlIHNhbWUgYXJlYS4NCg0KRm9yIGluc3RhbmNlIHdpdGggb3VyIHdh
dGNoZG9nIGNvbnRyb2xzIHdlIGhhdmU6DQoNCkA5MCB0aGUgY291bnRkb3duIHZhbHVlDQpAOTYg
dGhlIGNvbmZpZ3VyYXRpb24NCg0KQW5kIGZvciBvdXIgdGltZXIgd2UgaGF2ZToNCkA4MCB0aGUg
Y291bnRkb3duIHZhbHVlDQpAOTQgdGhlIGNvbmZpZ3VyYXRpb24NCkA4OCB0aGlzIGlzIGFjdHVh
bGx5IG91ciB0aW1lc3RhbXAgcmVnaXN0ZXIgYnV0IGlzIGJlaW5nIGluY2x1ZGVkIGluIHdpdGgg
dGhlIHRpbWVyIGRyaXZlciBjdXJyZW50bHkgdG8gY2FsbCBjbG9ja3NvdXJjZV9tbWlvX2luaXQu
DQoNCldoYXQgd291bGQgYmUgeW91ciByZWNvbW1lbmRhdGlvbiBmb3IgdGhpcz8gSSB3YXMgY29u
c2lkZXJpbmcgY3JlYXRpbmcgYSBneHAtY2xvY2sgdGhhdCBzcGVjaWZpY2FsbHkgcG9pbnRzIGF0
IHRoZSB0aW1lc3RhbXAgcmVnaXN0ZXIgYnV0IEkgc3RpbGwgaGF2ZSB0aGUgaXNzdWUgd2l0aCBn
eHAtdGltZXIgYW5kIGd4cC13ZHQgYmVpbmcgc3ByZWFkIGFjcm9zcyB0aGUgc2FtZSBhcmVhIG9m
IHJlZ2lzdGVycy4gDQoNCiBUaGFua3MsDQoNCi1OaWNrIEhhd2tpbnMNCg0K
