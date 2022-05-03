Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B86A85187F5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 17:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237949AbiECPLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 11:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237958AbiECPLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 11:11:36 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0E23B037;
        Tue,  3 May 2022 08:07:57 -0700 (PDT)
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243F2IQ8026481;
        Tue, 3 May 2022 15:07:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=QrPECoqTqHTM791MCW1I4vLp3+wuF+KvKe9cs0XPKcE=;
 b=VOZb9RvrNabsWgaq9tK5htKWA1zUmKlYpNkzfcpzukPrxJDd4i8LgTs2XpoUSmWVx3yM
 Hcybtn1UwQ1iAKe1daH58lHa1TwoHuGwp1cnzKbWdRKo00EOwNUbzJZkNXftNpTRYMhX
 F1kjiSMCesbWBZpZpRBJ9v7qwxQfzg9fRw/Z1fPu+2JIkwCquqjUTccC/W8hXDS6Gghr
 21kJpDDDmRGlr8wIDWzZ/OUXT6+QdM4fM8PfCBJzT+zhOYRsuUbmUOWIGNNmiE18kAR2
 hzaZD4sDngc9lFBlCm/QzSqRgbsg58UkJh/324jGB2ZlF7LyxG9+RV3eBr3tYS7rc8X3 2g== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3ftkr41bc0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 May 2022 15:07:48 +0000
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 12C9C800360;
        Tue,  3 May 2022 15:07:46 +0000 (UTC)
Received: from p1wg14926.americas.hpqcorp.net (10.119.18.115) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 3 May 2022 03:07:46 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Tue, 3 May 2022 03:07:46 -1200
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 3 May 2022 03:07:46 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xnp5tHOopdXVEN43AsgmFdgLF2GuSgtR1qq9NVOkpGTD4GOR7NXk7Ah/DTP/YjzJV1MeXELSoS4SC3/Tzmn2ZH4nvC/05RMaq0We3XifaVC52jMrlBhO+ydRunz8949hzGLcIlKPec5UNcNNX2VzUlSe95WB9M2pqeOwBWaUiTtD56i0nERH2oAqZrW96KzV/EaUHJ0xfMNHc4SC0xq/Ggwk1JM9v4znbr+WmhZwrlLw1OSmbjTGHFzc0M4c5geeRv4tzpJwAfEfwKLkaZ9F5eXfw/QPQHhTs/X2Ed/9KYVmfcvKQMAtCntfXHBuf1Q6ATOq7ugPZsKBG5azXy0jZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QrPECoqTqHTM791MCW1I4vLp3+wuF+KvKe9cs0XPKcE=;
 b=PlMdgamn8NIuQ2VvsqiM0ftFL4h7ceKxzdoLDG7pC6Ipo8PWx2K/rcEYBP+qyhvKuwAK0csyt7w5JUEv0ACKJyjzxBi54GNaLasbagVkmI1cOstn2MJI09YHArNZZZuY5+fyELPEb+TWWZXhUP3A/8BTIdhO2VstKADB2ZJ1j5FzVtsHez1DvUTuKPiNKAQYYJyHyZt+B7A/IPjG4ZWwAnw1EG1QzVKL82TTnhZjFlSPNYgNLheTawUXgmP8LrclfdDJjtFELsZVZE4BOBGOVFWpRgD8iZlNUhHd0uYPwwpKIQXAlgLBebR7Rjm8at+NmKQl73NyM4oxFANs0cTwcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:172::21)
 by DM4PR84MB1520.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.28; Tue, 3 May
 2022 15:07:45 +0000
Received: from PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6055:1602:5a0a:1562]) by PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6055:1602:5a0a:1562%8]) with mapi id 15.20.5206.024; Tue, 3 May 2022
 15:07:45 +0000
From:   "Hawkins, Nick" <nick.hawkins@hpe.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     "Verdun, Jean-Marie" <verdun@hpe.com>,
        Joel Stanley <joel@jms.id.au>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Olof Johansson <olof@lixom.net>, SoC Team <soc@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        DTML <devicetree@vger.kernel.org>
Subject: RE: [PATCH v6 7/8] ARM: dts: Introduce HPE GXP Device tree
Thread-Topic: [PATCH v6 7/8] ARM: dts: Introduce HPE GXP Device tree
Thread-Index: AQHYXmTKMgAnIeG/Tk629X6tcmENZa0M+RuAgAA84pA=
Date:   Tue, 3 May 2022 15:07:44 +0000
Message-ID: <PH0PR84MB17180215774D59A3EC277B1388C09@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220502204050.88316-1-nick.hawkins@hpe.com>
 <20220502204050.88316-7-nick.hawkins@hpe.com>
 <CAK8P3a2rzmVrpnf2r73iXB=T06OMOsgwyq1i8z7swuOW-q88eQ@mail.gmail.com>
In-Reply-To: <CAK8P3a2rzmVrpnf2r73iXB=T06OMOsgwyq1i8z7swuOW-q88eQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7a550429-5886-48e7-a35c-08da2d16ad87
x-ms-traffictypediagnostic: DM4PR84MB1520:EE_
x-microsoft-antispam-prvs: <DM4PR84MB1520E8A8D778EEBD5739173688C09@DM4PR84MB1520.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Yi89aXew2kD8jHwKXb3CiMxLW4T5h+LET+Vba14Nj88RJbg3kB183sJ9xDzaaWN0LePgjDUCZCYZng5uA98muAM7VOtO3MAUsdpFaJBCVthLQJTMVHb1E1w3IhbARGce8SNUVIBiJMylQcL9STgWndyTJvVcNC/WOryuudlzNGgfgJ59yRyGcRGOlvTSLXqgjPsuQWshJAjOxAJtzN2Q8idosCO6uSMCPzLAnZovZsUhs/rOEyAuoUYw3UkoMu7F55M6tv77HvhoBuSpUypmCmAARedGGT3fK0uG1A4/eoMn4847uSw2zgsaKDTQUJvzAInc3MsR6irU6y5eh8vjdUBh6DcZtjNrHkcJIFRHmpu47wYUyp0xjbQLLXM5YVZEjQBNAtiGiqZIGig2+EiuxKNzFpL1oc4z4aESxPg0U4/cakTle6Lr9cHMxI/WCEwFDAQq/kzK5VoQwkaZB8u915L2RVdJcFeJhThD+NktbxPHF7Oz6lOON0JgHelAmVg5XLq2qL/5UqrcZm6RjZ4mROkX83/fOHuWRwMeJRT4gRhOCJ9frQ51qri6eIoN9TIlp2e0ju1n2aMpM+CkD2hY5TBTfmo7gnn5ABu0qVgQ93YQg/vyBQ7ptKQM55s9QFTFAFxg0eWKDf2nWzLk9ANjhLLa/8D7fCVK9gAu/AYdaLwaawL1hu5JIl0ncgPKOndV+sDXUZlxFcTnpqpdb9fPbg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(54906003)(316002)(52536014)(53546011)(4326008)(9686003)(5660300002)(186003)(6916009)(55236004)(86362001)(122000001)(76116006)(66946007)(8676002)(64756008)(66476007)(66446008)(66556008)(55016003)(508600001)(82960400001)(2906002)(38070700005)(8936002)(38100700002)(7696005)(26005)(6506007)(33656002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dWNqSEx6a1JHV0xia3YwNUV6ZWlrY0tlTzJveXM3aFlMMDI4VG9LV0hiYVcy?=
 =?utf-8?B?Z2xlYTVzRktNdHNTVCt6WmZ0MUxQY2d3Qjc1U2ZwVmE4ek0rVzFXODJrSGNq?=
 =?utf-8?B?OGUyamhYQXNpSXNpaWorb2hVRmpHYndWajFjS0xweVN5Y2FnWHc3eENtckov?=
 =?utf-8?B?YlcxU3BMaExNeXcyZURjZXhsemxxbGtKRWp4WXVXY0QyUWN6cFFaTks2dDBH?=
 =?utf-8?B?VEs3MTRuY0NlZytKSEVzdUpRREZBWHB6S1BiSFJCTDlWTXF2d2pBQk4zNElX?=
 =?utf-8?B?bzFQeGc1dUxTQVJuSk9ZMy85ZFh3SWF2TFM5L0JSbk1ZbG1RZmhaV3JiZWJJ?=
 =?utf-8?B?ejh1SG9iZVpEYWh0dXlJbUJURTBNK1hvNnFrMVZGek1kNElqZ1p6K0FlK0xP?=
 =?utf-8?B?V3BJem9KQVZCNW84aGtpUWQyU0xJR3UwcmEyQitpQ1Z2bHNwc0U0MGU5blps?=
 =?utf-8?B?Zll5RjUxODAwendCc2VyN1dJMGdscXN0WWNnNW5hTmk0cjFXUEU0N0lkQW9T?=
 =?utf-8?B?bTdrK29vUjdGdnYwdU1lcTVCbDZZTndzNVNSMXpFTkllREVKVjVOOGRldi90?=
 =?utf-8?B?V2JHZWhzZ29WQWhvdlBEUWpCM2tMQ3R5V2txR1dKcDFVeVVueUNTcTVlSzNN?=
 =?utf-8?B?MVJZblVhSWtTNzc4RjFOS0dTdTVDZEtvRzhUMnhQYWpqUWtOcTBkWFlCV1Fx?=
 =?utf-8?B?OGh5U3hBcmY2Y2IwUzhPcjlsakxBUENYdm9lVUU5c29ENnNvMGFjSkJkajRj?=
 =?utf-8?B?emJrZmdSSEVmL1cxVTd4UTZkSTZXc3gwNVh0dkF0anNQZFFXK1QzQXBnSGZ4?=
 =?utf-8?B?OC9EQXpuclNBVVlEU2NWcEZvcFJwZlJSYnZhV0pFdXd2K05nQkJzTE5XNENu?=
 =?utf-8?B?cHlXM1dnMnNiKzF4cEE4dzQ0SjRpaDRYT0MrRTFYVWY2RjVMZTZVMHJRUjRG?=
 =?utf-8?B?UDFlNzlEcjdZZlVOUkVLdUtzOGlXNVM5eTJpVHZrMEN0U1R2cDJaZUpMOHQz?=
 =?utf-8?B?UEgzWktEb3MwS2pNbENzTlJtd0VML1MrUU5lL3E1dmRHdUN3SUV0M2lXa2lO?=
 =?utf-8?B?QVE0SkE0akJXcEgwN2hYMGNpL1V6T0RIbkhMRnlCL2N1eTZTOGEyeUkzQTgw?=
 =?utf-8?B?M3Y3WmZ2bTAzWEZTdkxGMiswcEs4RTNYa0tpYUk3L1VnWFVvZkhzTSs5dHox?=
 =?utf-8?B?bDlpTWZuY2hyRjRMbUJQcHd3NVl6L04xcnpNNk9VTXBlMWJJczVBUTd3cnpQ?=
 =?utf-8?B?R0Jjd2lKR3NnenVWcjJZWXgzdnRrSkNhZ3VkV2JJNUptdTRBT0VqeDVuL21E?=
 =?utf-8?B?MFZrSnpJbVIzV2MzYUphSW1tZGk5TDhyWUcyVUNFRUdlZU9FekxOUE5vcXQ1?=
 =?utf-8?B?bHpSYmNGOE9HVzZVU05JNkVHTURIeGcvem1INkljTlQ2WXpENVBTcGErUWFu?=
 =?utf-8?B?TS8xb1VIK0Zqby9USklBNGcycVNERFU1MzFBTnRkVkZLMVNha0JZV3R4WUpL?=
 =?utf-8?B?cXFjZlRlR3Q3VmJEV3M5bFlBWVFveHQxMGFSUG13dGlrWGJETUw0ellubGFL?=
 =?utf-8?B?c0UxOVFtQ0U0cHlVemVvSmVzRU9jYm5mU1BiV0orbktpSnhPSlN1SmtmN1dp?=
 =?utf-8?B?SGFGZlNhVlVlVGtDVjVCbjBIelFjRW5uWE5uYm9udVdoM1NYeTlVUlVaR0Z0?=
 =?utf-8?B?QVltMStHYjRPa09HQnJtN1RZV0NZdlFkeTJTQXhRYnVRY2YxSzBvTUJhc3Jw?=
 =?utf-8?B?cFdsNUVPMFppanVhbHFnNDd1MUhYVUJVT3FxbTIyL2lUZDBlTGxJeHorQ1F4?=
 =?utf-8?B?QU5SL3dkZUFCdDB4ckVNeGJ2YVVUbFluYmFPOFpaS2lscklPK0NwdlZLZDJN?=
 =?utf-8?B?cnk4ajJId2NrSGlyakw1MDR4ak5RcVNPei9xZXY5SFp1QVVWcUhSNVlEa3k2?=
 =?utf-8?B?ZVdyWXhGbXgvOEgvSEltRDR5UWJqSEl1NVcwTXpSTE9zSnFIK2FGaVFFN3JY?=
 =?utf-8?B?b3JueHU3bENlWS8vSmFjeVdaTkRoN2E1VnVWN2JKeGhJL1hqeXJNOWRBUmxU?=
 =?utf-8?B?eUtsMnZGdG5Vck1GZ2FVVGc0SnlNZDhKaG8xMElqbWxGWWZ5TWVQdGt3LzVZ?=
 =?utf-8?B?ZWlCQ0FObXAyRTZlYUFRRWZXbVd1ZFFqcUVub3ZBZmZ2SWl4UWhKS1cxNUtM?=
 =?utf-8?B?cWxrdDlBOHpPNUpoY0NSMHZkUXJlQ2tUcExQN21pZW8xQ3ROdFFIVXZXaHhk?=
 =?utf-8?B?RU1KZWJPa2tad3R6bXJ1Tk1FeHVZTGs3dkM1RVBXclA3NVhFd3NoYkFsbjhm?=
 =?utf-8?B?SnJxcjZwdnVTMlgxN1E2Q1FhNGN1UWJLYm5xV1UzOTVPZDJPUFFsUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a550429-5886-48e7-a35c-08da2d16ad87
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2022 15:07:44.9599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kCOGOeHWOTQaOxcavUxy3Sm4Rt2zJKd/Vua+tkyvmOtoG/VXL+wgjJ6TXycUh1nvuVCB/d7uH4M6oEmEaLn0bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR84MB1520
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: v4Sz-qty4d56Wz-zRh2JPhWCrw6sRgM9
X-Proofpoint-ORIG-GUID: v4Sz-qty4d56Wz-zRh2JPhWCrw6sRgM9
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-03_06,2022-05-02_03,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 mlxscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205030106
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiBNb24sIE1heSAyLCAyMDIyIGF0IDEwOjQwIFBNIDxuaWNrLmhhd2tpbnNAaHBlLmNvbT4g
d3JvdGU6DQoNCg0KPiA+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2hwZS1ibWMtZGwzNjBnZW4x
MC5kdHMNCg0KPiBJbiB0aGUgYm9hcmQgc3BlY2lmaWMgZmlsZSwgeW91IG5vcm1hbGx5IGhhdmUg
ImFsaWFzZXMiLCAiY2hvc2VuIiBhbmQgIm1lbW9yeSINCj4gbm9kZXMgdGhhdCBkZWZpbmUgZS5n
LiB3aGljaCB1YXJ0IGlzIHVzZWQgZm9yIHRoZSBjb25zb2xlLg0KDQpUaGlzIGlzIHdoYXQgSSBo
YXZlIGNvbWUgdXAgd2l0aC4NCg0KLyB7DQogICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDE+Ow0K
ICAgICAgICAjc2l6ZS1jZWxscyA9IDwxPjsNCiAgICAgICAgY29tcGF0aWJsZSA9ICJocGUsZ3hw
LWRsMzYwZ2VuMTAiLCAiaHBlLGd4cCI7DQogICAgICAgIG1vZGVsID0gIkhld2xldHQgUGFja2Fy
ZCBFbnRlcnByaXNlIFByb0xpYW50IGRsMzYwIEdlbjEwIjsNCg0KICAgICAgICBhbGlhc2VzIHsN
CiAgICAgICAgICAgICAgICBzZXJpYWwyID0gJnVhcnRjOw0KICAgICAgICB9Ow0KDQogICAgICAg
IGNob3NlbiB7DQogICAgICAgICAgICAgICAgYm9vdGFyZ3MgPSAiY29uc29sZT10dHlTMiwxMTUy
MDAiOw0KICAgICAgICB9Ow0KDQogICAgICAgIG1lbW9yeUA0MDAwMDAwMCB7DQogICAgICAgICAg
ICAgICAgZGV2aWNlX3R5cGUgPSAibWVtb3J5IjsNCiAgICAgICAgICAgICAgICByZWcgPSA8MHg0
MDAwMDAwMCAweDIwMDAwMDAwPjsNCiAgICAgICAgfTsNCn07DQoNCj4gPiArL2R0cy12MS87DQo+
ID4gKy8gew0KPiA+ICsgICAgICAgbW9kZWwgPSAiSGV3bGV0dCBQYWNrYXJkIEVudGVycHJpc2Ug
R1hQIEJNQyI7DQo+ID4gKyAgICAgICBjb21wYXRpYmxlID0gImhwZSxneHAiLCAiaHBlLGd4cC1k
bDM2MGdlbjEwIjsNCg0KPiBJIHRoaW5rICJocGUsZ3hwLWRsMzYwZ2VuMTAiIGlzIG1pc3BsYWNl
ZCBoZXJlLCBpZiB0aGF0IGlzIHRoZSBpZGVudGlmaWVyIG9mIGEgcGFydGljdWxhciBtYWNoaW5l
IHJhdGhlciB0aGFuIHRoZSBTb0MuDQoNClllcyB0aGF0IGRvZXMgbm90IGxvb2sgY29ycmVjdCB0
aGVyZSBpdCB3aWxsIG5vdyBiZSBjb21wYXRpYmxlID0gImhwZSxneHAiOw0KDQo+ID4gKyAgICAg
ICBtZW1vcnlANDAwMDAwMDAgew0KPiA+ICsgICAgICAgICAgICAgICBkZXZpY2VfdHlwZSA9ICJt
ZW1vcnkiOw0KPiA+ICsgICAgICAgICAgICAgICByZWcgPSA8MHg0MDAwMDAwMCAweDIwMDAwMDAw
PjsNCj4gPiArICAgICAgIH07DQoNCj4gSWYgdGhlIG1lbW9yeSBpcyBvdXRzaWRlIG9mIHRoZSBT
b0MsIGl0IHNob3VsZCBub3QgYmUgaGVyZS4NCg0KSXQgaXMgcGFydCBvZiB0aGUgU29DLiBTaG91
bGQgSSBwdXQgaXQgaW4gdGhlIGF4aSBidXMgaW5zdGVhZD8gSWYgc28gd291bGQgSSBuZWVkIHRv
IGNyZWF0ZSBhbiBheGkgZm9yIHRoZSAuZHRzIGFzIHdlbGw/DQoNClRoYW5rcyBmb3IgdGhlIHJl
dmlldywNCg0KLU5pY2sgSGF3a2lucw0K
