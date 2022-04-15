Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29BD4502C29
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 16:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354707AbiDOOxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 10:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354704AbiDOOxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 10:53:32 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87EF9B2463
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 07:51:04 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23FCYDfV029074;
        Fri, 15 Apr 2022 14:50:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=aXEg0WRk+hLB1DNgV8lqX6PgqCnIisyZ50gFmublsIk=;
 b=sin7j+WulEodIwNiM+a9Jc7MoHqV2APeLboElXiBDLrOAhteFhr1p/0/mm9Kga2Fcl8S
 ypPOp7511ZkeDxEwCYDSUFTbF8LD6UFO13FTvsZSyxI5Uu3GIiG7X5Ij8rhN8sAsEbvz
 ZufCsjqP2jPoY2nrBRHTaJOIdm+/vcYlHPC8/Pr5c4seyZE2XfauuwoJ6LjxfGs3z8c4
 f780oiIr3FpjQS4DmhcQ+skbPt894vK7BOKdhZ8QyyvrLR+wkeQF/jXKO7+pSyAaKvBn
 x280nHRASaCA7ykCpZPC74q8FlVdlC8wbCRJp/u+l8OkoOpkjKy+MSbKCTa34fVMxuqh 3Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb1rsfdsm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Apr 2022 14:50:11 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23FEkV2Y002558;
        Fri, 15 Apr 2022 14:50:11 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2049.outbound.protection.outlook.com [104.47.73.49])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fck15y1f8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Apr 2022 14:50:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KtMK1lUzArPhD5nK3G9eKUiyD15IPjruLwwd6PNXgy/Fb3HURl2UlJKvnG7UzpmDSESi7Q4+9yN8NWBY6JUpxPqsHyD+JQAwLzxX/OCX2Cd1R2acUXXVUTACe94h6V9UlxKr9sWb6JAnFwBWW3UZEA2/a1jMbSbKW+8Ep1SneKQNd2ezx5ami6k9ZKRhjgEja4HkrTY9rEVXaaYksFEX+jbyz4DigQ9PFxc8sXnM9nUhvPf9q4O2jeg0L+JNgaDKrqITy+LptmlamtHPBoYnYNJgApWKLDbE+v37hPPngOzPU5WrneTKFrGf2Ut3VEAylSuoT8kMHRLk+N+42N2gCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aXEg0WRk+hLB1DNgV8lqX6PgqCnIisyZ50gFmublsIk=;
 b=Y9VcLSntlwFNne4Kh0KX55k3L7M9NhqbVCiJIU4UP+zwfsPvfNigGMR1LEBd4mGilUrwGeecMPMti6fTk1qixZ0ANfiQV63jGGMBkjQmnEbF4BFkQ4rhb/dCdF8ZMee5hYy2kAJzKGTNFfVDYWgLfjBINu9CNVqeOqwrRptCY3LWQwltSRaoAdKjbZ9j57s9CqyHbqOJWlXhdFT0FNo+T9zlm1ix/hBvOZy8cjr84lMdkT8+QlnWHhDoSHAUdsjvHll74lbWQyhfompbuLMZWer9hyLgczfZN2WuzzJZLAbEUFfZK8HXwAIrN4lvb3hhAh/yTWhEUIMiElYDLOLakQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXEg0WRk+hLB1DNgV8lqX6PgqCnIisyZ50gFmublsIk=;
 b=FmQhkYvUonw1qyYx8/ZJscHx7yAvl6zz0ltv7xLjr23fBqxgCd9UEI/Yi1VDpxf36LNm4/VVSgtvfoh1+ayaorbV0pr7lBdQwECn8XGhyqST3M3rPOZw8F22QSYEpHcKuicvyN1DzTH5OBk+/VnIMz6USEBzIHf/i/Yi4ftvVt4=
Received: from CH2PR10MB4344.namprd10.prod.outlook.com (2603:10b6:610:af::19)
 by MN2PR10MB3502.namprd10.prod.outlook.com (2603:10b6:208:118::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Fri, 15 Apr
 2022 14:50:09 +0000
Received: from CH2PR10MB4344.namprd10.prod.outlook.com
 ([fe80::2143:b691:57c5:7643]) by CH2PR10MB4344.namprd10.prod.outlook.com
 ([fe80::2143:b691:57c5:7643%7]) with mapi id 15.20.5164.020; Fri, 15 Apr 2022
 14:50:09 +0000
From:   Qing Zhao <qing.zhao@oracle.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
CC:     Kees Cook <keescook@chromium.org>,
        Bill Wendling <morbo@google.com>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        clang-built-linux <llvm@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        "Jose E. Marchesi" <jemarch@gnu.org>
Subject: Re: toolchain mitigations plumbers session
Thread-Topic: toolchain mitigations plumbers session
Thread-Index: AQHYUEbqQRHvn8TmMUa7Bz+ctF1QuKzxD6SA
Date:   Fri, 15 Apr 2022 14:50:09 +0000
Message-ID: <3DE35A81-1FC6-4EC7-8F3A-B395B576644D@oracle.com>
References: <CAKwvOdniB-+F37ygZhRytBGVFjwnukyOpmoiJTCeusMdb=6_=g@mail.gmail.com>
In-Reply-To: <CAKwvOdniB-+F37ygZhRytBGVFjwnukyOpmoiJTCeusMdb=6_=g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 94af58f6-f0d8-42af-79b4-08da1eef3cde
x-ms-traffictypediagnostic: MN2PR10MB3502:EE_
x-microsoft-antispam-prvs: <MN2PR10MB3502859AA120B5623874984280EE9@MN2PR10MB3502.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iGolUEQdqY9Pf3pRVC3HujvHJIZmJ4ebBW+O7eu1j/7TIBA7J4BSiMVBEuZZ0zQoQxhPzy2bJCPU0geWJ6J2UG5e37nEr9iHPiYxY35Zo3iKroM4au/xWGq2qelmFWfUwOILvTWl5sCduBMts4u6sYkYKJFxnBkgbgsC8rMc8p8Gl9woooOmT71XTLvJ1Vi+qsqBIOQsbDV+NJtdoa0qiGGTJYCueQHp4HC7f8I8UGNnAwnQcUp70nbTxZdITHnciBmt/R27hv/i8FfMd18bcRrzUgFRZTG8HruvVNdCnTF53DYiTedzAEVEPEsNAVlbWMu3J6YeVAQ6DWw/LbLsisx0eovNZz80dJVh5aTqGUgg71R2K+29flm4tjFIqun3E7PibBgtBtYuzkGn0UKwnclNL2ZVe6Uy1Xa7OEyhEqCcyuV+ak6UFzI/ck9DiVq+NA93fOZ1YCJwVdcKb9s1xdU7qpg9+XXa0teBPUEj4/m6zci9yhKtGdcjUXxuPwlw1xPzMMbq8zv2aVdPxWtkebfajbeETs4yUH4I1YlwxZODYhEaKiM7Mcv7sGEeU9esTdnPxOwadaGOT/oZ7tnn9MPJYDAGyOVNbSxHFopjhrSk3/UWsXJw/uM5JyU/Zz83FnLeWfahsvVCFlQm1BBk9WiAxlLsuz9KgHtf6v0WDagX8HkMFCkhY3z4arFRTTXdqftm+2SMwZEbPAxLu78JOUkw96jfjq8QWpqWCMJkEnOMeW344czQga3RtVi/MWvf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4344.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(122000001)(66556008)(4744005)(44832011)(38100700002)(8936002)(91956017)(8676002)(6916009)(66446008)(54906003)(33656002)(4326008)(66946007)(64756008)(66476007)(36756003)(316002)(6506007)(508600001)(86362001)(53546011)(71200400001)(76116006)(6486002)(6512007)(2616005)(2906002)(186003)(3480700007)(38070700005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aGcrMnhSRjg1eFhLOEtQVG9MdWhIWlRPRjMrekJDSGgzSG9OL1k2NHBCR2lm?=
 =?utf-8?B?SUQ5VkFsSHlxTHYvakY5Z1N4NGtZZUVVSVJwNEk1UkR6RzV5Vis1Z0ZjU2dk?=
 =?utf-8?B?c1hEejhpanNmY1BkN1haa0N3Y3hUQ0tIU0FLazBnQThUczIyczhzbzVNOVl6?=
 =?utf-8?B?eEU0bkphcC9FSEdxYVhVQ2kzOUgycklBcE1SM2dBWklOZkNIY3IrSkNva1BH?=
 =?utf-8?B?SGZlYXRZczVOY0pUYm1zS3Fhb2tQdEI5ZHhRdEc1OU05QUYxTkFTOUFQeTNi?=
 =?utf-8?B?MzVnV09kTi8xZEthd25pcEtpaUVuN3JBYTM3eTNKZnpmZS9BSUlHZU8rZE50?=
 =?utf-8?B?YzVXbGNvMU1ZVkFKSnQ2RlR0cXlNR1ZkWURub3hkV2c3K1ZRbWFUUDlGZW5m?=
 =?utf-8?B?d1VvWTVIUDJyZU9LR0tsSnJhWktCYUFQRnQ1N3NkVkNzVmVCajhsbitIM1lN?=
 =?utf-8?B?cVdWTFoyUHdwTUY3aDdkYStwT1plSTZaK1BMRnpVQkJaU1lwQUI0Ujh0N1VI?=
 =?utf-8?B?SWVyQm1XcFFyd0FoL2hDbExGNzJRbjhEVzhQN293WnBQdnE1YVFwSnNEOTBY?=
 =?utf-8?B?K1JMVkc5SnJwdFNSQ3NoeCtiZ3VNbUFxZDZhV2N1RThzeUtFRGlac3BkTjky?=
 =?utf-8?B?UmJ3bUhsK3A3NXl5VmFVeWxsZFNVNEk4MzlGYTExTmJySDFYRXlpRTh4TGFP?=
 =?utf-8?B?bE9jQjBZbXdZbFJOblZTODFmTVRBVEoxMDZ1WG5vemE3ZDFBdkJ2K0VMOUQ0?=
 =?utf-8?B?ZXFURVh1RjgvdU82UGJZU0I0RUtaaXBhOFVpNUMwdE9MbGdNSW04c2JRNFUx?=
 =?utf-8?B?UDRITml2ekl6M3RWNTVLTXNnRVpIdGM1UHFPM0JPTGJGVjVJWGw4MTh0SlRi?=
 =?utf-8?B?K0pxVEZwYUJQNVR4NmhtejdRV0pVd3QrRmNwcm1Vem8wcXI2dUhJUk0wcTVU?=
 =?utf-8?B?WXBDZEt6aGs3Yys3UDQrb2ZaSEp4YzdwZnAxMWZZY0xIZTNJbVdZYkkzcFVJ?=
 =?utf-8?B?Z3k4blNVbGFOZGxuaHFObnhacGE4Z3BpOXZ4dkJpeUtkRC9HVnV6NkpobEs5?=
 =?utf-8?B?TWZYTnBCRmJLQWlSTzA2ODNvZjdadHAxZXVDUzdLb0ZXOGQxT01ScVBoNm85?=
 =?utf-8?B?elFsaGRpeW8relk1a2dqZFhVUzZOcUtzaVVVaVRzSkFLWEREOFN3bVFkbGNZ?=
 =?utf-8?B?ZTZzemVRVjNjbGRYMkNUMWZNUjl6L3FzbW5TVUZhb092Smovdm40Q2Y4MXFo?=
 =?utf-8?B?WGFiU3JaYmRpakJqTjVBYnlhUHlkaUFvb2hYZFkxZDVQYVJUUXdqTU9yeEFr?=
 =?utf-8?B?NnZEdDBoaGUwdjRkOEcxaC9ERjdqcnR0R0todTVGMXA3M3k2WmZQTVhpTVhw?=
 =?utf-8?B?UVhnR3cwNlRMSVNFdVVtaTBHWGxCM0t4cU92TzBRWTVTM0d0T2hTVzJPbjdR?=
 =?utf-8?B?U2FtUWhPZnJ4Sk50b1dyT2JuQlN0WXhyMWcvMkI1akRnSXZTeHZOTllVWmRw?=
 =?utf-8?B?MFFGOC9TZnVvZXlraXlzWVdzM0REVXh1MGVGT1NvS2gxUkFxRS9tMFlKVStp?=
 =?utf-8?B?bjhOSGVYQW0vY01oUFVuWExoVlFDTlM5L0FOK2U2Z3VoL2drMS9LZlorSHNv?=
 =?utf-8?B?VjNWMkJ3SjI3Z0F1RU5oNDgrQ3RmQ0tQdVhPdzJYckFSLzlFN1lUZmpHWFpi?=
 =?utf-8?B?YmlHMnBEY2NSdzMvTVZITVB1OWFRMnErNnVkUUp2bXpHMEJuQ1RUczQxVTRO?=
 =?utf-8?B?Vk1QN0J6d1Vja2UyMllZUFdoWGtyUWFCcnpQT1lOVlRhYnlxSUtvTmpXeHg3?=
 =?utf-8?B?Nmk1WWxnT1g3TVF2dFFZLzBBT3VSOHJWT0c5MTNRUjlFQUl0eGlaazI5b3FK?=
 =?utf-8?B?QzFwZ24zQ1Vkb2pEY2tvQmdSKzZuVDZyeEtwS0xpK1ZSTnhPV3Y2TkIrTmlr?=
 =?utf-8?B?eHZSYS9ZRE1CZmFxRGoyVncyeTJlTlNBTUVDNlJEMytmVDJvM0JvdnloMGxx?=
 =?utf-8?B?VmV0TTl4R3hrWGNESE05V0lqTWFoZGdGZ1Vjb29UeWw0TU8vTC9qa3ZwQU5v?=
 =?utf-8?B?WThlaVIwNWs3WFdxK284bXlaSVkrWDZ5bnV3YUZxblg2UlliY2hxWkZoelgy?=
 =?utf-8?B?azJack1ITWZDL3p4TkFqVUZuUU5mbnBqUWxRQ0FJay9KcVJiazYrc0doTDRL?=
 =?utf-8?B?S01PVitYa2xUU1d0TTRiT2EwMWlKRU00am01SHdVWXFnUGk5OEZRVXFIT2JU?=
 =?utf-8?B?cWhLVTdIeXdZVlFLbkJDa2IrMUU4NXdMK3FFTWZFbXZQOEhPZDhsS0RlaHRM?=
 =?utf-8?B?Nm5SWkxpYXhUTGw4ZHNPaHYxOHpScStqci9ha1JyeWJaSzVqL083a1NKRUhN?=
 =?utf-8?Q?km0AA8Y+0FJ5ImGu4fFPTkwICsSuYIvYr+ITK?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <54CD3F1E1D5914479C63C6D80220F19F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4344.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94af58f6-f0d8-42af-79b4-08da1eef3cde
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2022 14:50:09.2794
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: emUCdK+V/Y/D7vD+cW+cw+JBQEV0P4AjRtASK7De+ZbhEhYLyKzKfEt4TI4PY/qTkYgU6kgpH353lhAhLejmFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3502
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-15_01:2022-04-14,2022-04-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 malwarescore=0 mlxlogscore=702
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204150087
X-Proofpoint-ORIG-GUID: ozwytIq-QdCU154lXIdCt4IH2gnTq_Yi
X-Proofpoint-GUID: ozwytIq-QdCU154lXIdCt4IH2gnTq_Yi
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIE5pY2ssDQoNCj4gT24gQXByIDE0LCAyMDIyLCBhdCA0OjMwIFBNLCBOaWNrIERlc2F1bG5p
ZXJzIDxuZGVzYXVsbmllcnNAZ29vZ2xlLmNvbT4gd3JvdGU6DQo+IA0KPiBIaSBRaW5nLCBLZWVz
LCBhbmQgQmlsbCwNCj4gSm9zZSBhbmQgSSBhcmUgY3VycmVudGx5IGluIHRoZSBwbGFubmluZyBw
cm9jZXNzIHRvIHB1dCB0b2dldGhlciBhDQo+IEtlcm5lbCtUb29sY2hhaW4gbWljcm9jb25mZXJl
bmNlIHRyYWNrIGF0IExpbnV4IFBsdW1iZXJzIENvbmZlcmVuY2UNCj4gdGhpcyB5ZWFyIChTZXB0
IDEyLTE0KSBpbiBEdWJsaW4sIElyZWxhbmQuDQo+IA0KPiBXb3VsZCB5b3UgYWxsIGJlIGludGVy
ZXN0ZWQgaW4gbGVhZGluZyBhbm90aGVyIHNlc3Npb24gb24NCj4ga2VybmVsK3Rvb2xjaGFpbiBj
b2xsYWJvcmF0aW9uIGZvciBtaXRpZ2F0aW9ucz8gRG8geW91IHBsYW4gdG8gYXR0ZW5kDQo+IHBs
dW1iZXJzIHRoaXMgeWVhciB3aGljaCB3aWxsIGJlIGluIHBlcnNvbj8NCg0KSeKAmWQgbG92ZSB0
byBhdHRlbmQgIHBsdW1iZXJzIHRoaXMgeWVhciB0byBtZWV0IHBlb3BsZSBpbiBwZXJzb24hDQpC
dXQgbm90IHN1cmUgd2hldGhlciB0aGVyZSB3aWxsIGJlIGVub3VnaCBuZXcsIGJpZyBzdHVmZiB0
byByZXBvcnQgdGhpcyB5ZWFyIHNpbmNlIG1vc3RseSBidW5jaCBvZiBidWcgZml4ZXMgYW5kIG1p
bm9yIA0KSW1wcm92ZW1lbnRzIHRvIHRoZSBwcmV2aW91cyB3b3JrLg0KDQpRaW5nDQoNCj4gLS0g
DQo+IFRoYW5rcywNCj4gfk5pY2sgRGVzYXVsbmllcnMNCg0K
