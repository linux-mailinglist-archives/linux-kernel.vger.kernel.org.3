Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 962235155D3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 22:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380926AbiD2Ukp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 16:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380876AbiD2UkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 16:40:23 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47ADB83B2C
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 13:36:59 -0700 (PDT)
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23THMpxx021231;
        Fri, 29 Apr 2022 20:36:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=mz7iuP+ogjHfO3x1zdKn8O5tOFD6HeXXeaGB8jFxdyM=;
 b=LhU8gz5gmxdFOCNZUchXBeeozDu69HnnY3prJKi6Qh9cURCfI7IgE7TizhDbhLLaTx0K
 or9totjdyfWn6XzQLZRxtVJMymI67LwfYlWFcdrThD5jtqNXzrzFZRIYIHNDkfVIMuLv
 emr1XpZJTdFeV4Rq0yD0CMEHRNgbI0nhYOZxg9U+CD3PQIKonZZ5OLCzmHZr0bNp2jay
 6yeqX3fB1x9MZS+L3oG0+kawLrfh8asFBzXWc/LCKqYlprlC0KhaRLaTCHuwx1qP4aMa
 WFewHcN70wgEnsT3e/MVYKd0J99Jh00khWQV0ZCn3qhQaYMwzsKpPQ7kNHWzdQb6tHVY Sw== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3frmby1esg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 20:36:30 +0000
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 533AF1308F;
        Fri, 29 Apr 2022 20:36:27 +0000 (UTC)
Received: from p1wg14924.americas.hpqcorp.net (10.119.18.113) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 29 Apr 2022 08:35:57 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Fri, 29 Apr 2022 08:35:57 -1200
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 29 Apr 2022 08:34:30 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F4m3uyDG9F5mrTdzWuxMvfl/3pjWC2LNKVT90G4pQ0wYiaqDL/d8DsrptG9GuSvHaj4tVlOwVNzvXx++rjfUvS/VYdqKHbxZ+pt7AFZt5d72RONHmXORsvhy1u0pZUNkVgWm1YGDqPJdvd8nuEFoZ7u58L5GSoQpOkikoLLBW41DdIC2RTVco8f0vhQ63NoWdwkp6HUJWKD4hp0Tg9d9o1f4MgBbIhc1OwZKCw6YgvOguIv55tvrM3ODBPJwL/4rUtZrQxxUMI6HwkBF5RehSQv41ndJOtkdEeNx/XR3zCaBVGZKhIVZxRAHsMTExtmKjpm00+vGxR6AETBea4Htkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mz7iuP+ogjHfO3x1zdKn8O5tOFD6HeXXeaGB8jFxdyM=;
 b=gYiXg32mdO3zbjV2tDvJYKwNfoWLAuaJeGsy00sj8U0GhDzEywbMEn9LPVfHnSbtGlML3KnW3Qf6al8NxnLfnKt8k/M/Ul8Ev4Aa4/pHveDKlOHLKvpd5KzoqOLpB0FrJwuK4ivsbbVK7fECTpGoSbWoxiLhKG2UGWnrui2gP93Q1PQlEjvsrysXm9y68uZhHuyZSLYZX9ewO/dj//H+hp8IxTq/UEv39LKX0Mb+WXi4Xuc8v0Pzfn6dg9h68xQBYfHSj9nGoeGWHy499MEkeAoIwbhsQ6a2hHKLLSaOlpxSkVFIFt1LXgE7t3o8ABHzGPseFpz52PdhjmmIbt0CXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:172::21)
 by MW5PR84MB1915.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14; Fri, 29 Apr
 2022 20:34:29 +0000
Received: from PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6055:1602:5a0a:1562]) by PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6055:1602:5a0a:1562%8]) with mapi id 15.20.5206.014; Fri, 29 Apr 2022
 20:34:29 +0000
From:   "Hawkins, Nick" <nick.hawkins@hpe.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Verdun, Jean-Marie" <verdun@hpe.com>,
        "joel@jms.id.au" <joel@jms.id.au>, "arnd@arndb.de" <arnd@arndb.de>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>
CC:     Russell King <linux@armlinux.org.uk>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 02/11] arch: arm: configs: multi_v7_defconfig
Thread-Topic: [PATCH v5 02/11] arch: arm: configs: multi_v7_defconfig
Thread-Index: AQHYVbTMo8ysJZGDuE6x+gUm+2hL4Kz9WOCAgAoLYtA=
Date:   Fri, 29 Apr 2022 20:34:29 +0000
Message-ID: <PH0PR84MB1718FC5AC7FFF0D5509337A888FC9@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220421192132.109954-1-nick.hawkins@hpe.com>
 <20220421192132.109954-3-nick.hawkins@hpe.com>
 <b5a549c0-c3f8-3c39-c4ca-a960fb748814@linaro.org>
In-Reply-To: <b5a549c0-c3f8-3c39-c4ca-a960fb748814@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5f1aee72-c223-4b58-0f02-08da2a1fa8fe
x-ms-traffictypediagnostic: MW5PR84MB1915:EE_
x-microsoft-antispam-prvs: <MW5PR84MB1915DF4ADEA9C63BC9695ED088FC9@MW5PR84MB1915.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zfKMvp/MOyIlNE3fVVk37DmDAcOO38TKSBemOMIW3EGLTBc7PkOAcuaMIgX8PtJbv9UzYxWmtxuaXHiDWJCKcIx153u9WwRpg56non9MN3B+rDGljdeGFQXfi4/I+9WSwsKctV2eZKgmT9Tghyb9QxGvMlZZr9ggM/u74f/VZEglKp05TuqSFY9X79otoosA4EuuEgJOU+Nb3xTI48Mfpz3229DFiPX4n4HARyQSXdvCmt6UEinY4elNBwfcW9k+TsVzFii6iyPLHbMr/XKR8/dnDvTDUM+Qt8eLg/gofg4KPfVQJJhMgQWlwP2SIiq6QPJ7svy9rDU2Sx3CBFClA0cb2ZQQMbHnqQnYF0Sjm2sxjly1I9HXozDTv1pu96U7z/1oVTadExB/Jcccgil3SuQ51sfyPdcosQPILDnzasI1aGSxuyBlW/6cOsx88eNBJfRaJxbxR9pUIhber8XheEpAtMKgRuGlMU2ckOvl9k6bu5clKuRYCIiaCmmJJCarNUfU1FXfZ3dJqu8hqF+d2DPlEs//sUqlNy6x9Dk44J0IRgtVL5UTLZA4O8GvfYipJXKytcrkPwi1t/3kgS/3uexayp82Z1VMT5Y+XKD9LzbzrTDu2TAH0ZsxAhHi7oUo3eXRBQlmSr5E9C/opIexaN5V+kOF8jmbEpB2B/1pchiLuA5Jt4LDi6Tr5NAiQ2TiwWiQXKQwKc5uqXdqx7YwOw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(76116006)(66446008)(66946007)(66556008)(66476007)(64756008)(33656002)(8676002)(4326008)(110136005)(186003)(316002)(54906003)(9686003)(26005)(86362001)(2906002)(6506007)(55016003)(53546011)(71200400001)(5660300002)(82960400001)(7696005)(4744005)(38070700005)(508600001)(52536014)(38100700002)(8936002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OVZMUXE4ZzhiejdBUmNmUnByWmh4NS8xcG95anR4cXFMQkx2bzhncExzUVhZ?=
 =?utf-8?B?ZFA0aTVqUVE3SXB5MEpMOG9vNW9kTE9IbnF0OHpvd2tpMVp2SEZ5aHZFaGdx?=
 =?utf-8?B?bXkxam9iemh5NXNyeUIrTVl5Q25EVmpYSkJVM1dwbEtLT0RtTTNDMHd5dUVm?=
 =?utf-8?B?eklkZ3BISGljQmVkY09HQkh6cW1rZFBOY0o5VXkyZ0xLMEdkQ1JqcXZjbFd4?=
 =?utf-8?B?RHU3bytWSlRPZ2poL0hMK0p2R1ZTZWFBdlZkOVd3N2VjQUVFaEJGem1MdVAv?=
 =?utf-8?B?Z3BVaTB1WkxHMXJoTllzRjk2MUQ5aExoZDZnbit6NFdpYVYvZzNDNTJsMzhT?=
 =?utf-8?B?bm5qWDdZdGR3bzhzZGhkQUxDUnpQYW80OUF3azRGZEdYeCs5V3F1Q0dsM1VR?=
 =?utf-8?B?cHQ2VHNvT1YxQm15VlloOUtYS09jc0FOTUR5RWZnU0ZVcHBLTUNYUGhRS0Ur?=
 =?utf-8?B?S1BKd3MwMDNIRm5lUUJpczdpVEE1MTAvL0tLakE1Z1JBdDU0OGF3cFZETCti?=
 =?utf-8?B?djM3eTJ5cG9Zd1dZcVVCTlc0RzZwSk1yOCtlRU51Uml4RXdNU1ZKY1g4MEU2?=
 =?utf-8?B?MklLb3BZRFRYT1RFdzYzaTRxZEMxdG1Fek9FYzZuV0wwdjNqVkZUYVYrT3RD?=
 =?utf-8?B?L2VNaUcyQ0QyQXJnR3prWm1hQTdncHNqbEhPcXRvSitsWUlFU25WYy9MYUs0?=
 =?utf-8?B?b25tY21DVTkvOU15QnVUNUR2T25OZWRFS1NuT2ZxME50MnhEK3BzNkhqdmdU?=
 =?utf-8?B?NndaN3phay9LU2J0U25YeVJBYWNIOTJiWE9pazlyR2ZBNVU0ZDY4bGkzSHhz?=
 =?utf-8?B?NW9tblFEc2VEMy94VGZqUWxGQWpVUk1HY0lTekl5bS80cjIvb2l4aHYxK2dv?=
 =?utf-8?B?eHQxbmJsMnQzd01TMnpjckhiRFJFaTNDS2ZNK0RnSVNIbkVtUlZkaXhSNXZL?=
 =?utf-8?B?bGIzR0piVDl1RjErZk8raW5yb1lXMi9nK0VPWWtIMTNra2Jady9TOEZONExX?=
 =?utf-8?B?UmtiMFFnWG1LbWpzK2tvZzlMMVlHZHFNTkIveElOeHpRcVpBN0phTEhMbXN5?=
 =?utf-8?B?Q0ZheTVPRm15Y0ZTYklLVVlhWkJ5QjZOOWNSTUxPMkFIcE5nZndwbHl5Nktp?=
 =?utf-8?B?eDZzdmZTTm9wbVhuc2k5ajIzSVFrNmhXTk9oYmtVTm1UOFE3bnVTREsrY2ZI?=
 =?utf-8?B?WlRNTFppYURvOG4zL0R2Rm1IZmRjcXlQVm9Wc3YyazV0UStlOWlnNm1XeTF3?=
 =?utf-8?B?dGNLNjhaTVJKSWM4VGdJa09TVDM5eUh1UEJ0YzJTbTB3d2hNN0w0MDZvZm5Y?=
 =?utf-8?B?aW1ZOEZLWW1uVGduazc1WGlwNFJVY0V2NnBrdzcrRFV4TzJTdjIvblg3aDU2?=
 =?utf-8?B?MXFBb0RvM0VmcEJBWXdKNDVUbXlkdzF5YTJPcnI0NUxxVW1YSDM0dEc3cGNa?=
 =?utf-8?B?YlEwL1JNclpGSGNYVldRTHNIaFIrZVJLdVFUNktxdDBPRmZrdzFjQVZqc0o3?=
 =?utf-8?B?bDU2ODNvQUVXaXFWdHdCd2NWeTFKRDN4NFRRNUNkRWxnMkhaK28xekFwZXhQ?=
 =?utf-8?B?eHc1eWwraGRGejRrWS9hYzVVdHJtd3dNQlY3L0xlb3M3aVBzdHUvY2VFeExP?=
 =?utf-8?B?RlBtQUl0R1JsN0tIeE41TVhwTmY5VG5XeHIrS25nTEU5MGUzUDZTRG1wNVdx?=
 =?utf-8?B?Vm5NdFkvL1JZczVvY3NOWXlzU1ptK1pIL3QwQkV4cURBRVNCYzBjWDZLdTJX?=
 =?utf-8?B?bmhWLy9ITjBrZXFjYXROOCswdmkwb0E3ZE9JMDU5bWlFSmwvaFhXRUxXUFFj?=
 =?utf-8?B?RjBlYTRwemd5d2VJSkVyVTduM2NJWm1xRytEVkJ6QkVUQlREMEo4V3BlR3Z3?=
 =?utf-8?B?S2NPOGVuOCs2WjBtQ3YyMjZvZ1ZOeUhBOTFPaXh0cUFzNC8yT1lWU3dGQjND?=
 =?utf-8?B?MzlQek10RXNNYkNKK3J4amdRdG5yWmtrRU1iRlVXSHBjMEIvOU54elBXNzQx?=
 =?utf-8?B?Y1FFeFIxanBONEU5L3h4Q2JNOGhsK1laZUpPS3BiKzg0cFVPUFAyYWZWazRJ?=
 =?utf-8?B?N1QxVkF0cGptV1dUcTNEQysvU0xXd1FLVGxBMENGdG85THEwVmgwOVBxNVNp?=
 =?utf-8?B?NUVGUHMzdDVBMnB0TnAyOE0xdW1zamt0eWxBbFdud2JmWFpPbTJCR09kM29T?=
 =?utf-8?B?S1NaOUsxVVZUUXlaTys5ZHRZVUVZN1NlNTBQdTF3K1YrY3FWdnRPR0JhZU03?=
 =?utf-8?B?OGhyRDIrQ0R4OERxbTV6cHBrSWFleHZFRU9vdFV3Rmt1Nm1RZ0h5enpSYk1o?=
 =?utf-8?Q?mRhKAC7txy0fHCgvOQ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f1aee72-c223-4b58-0f02-08da2a1fa8fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2022 20:34:29.3608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7P6KsqVQM7WcnfBHwXBlgOZtBW7U781yasgeCKKR738VfYm7Sf4o2j+9rXV0KJ4XB8c2K9I69mYkRSNOsBT9pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR84MB1915
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: 0Xnsob1z-wbZ54KGJDYypMzfkr05qgrZ
X-Proofpoint-ORIG-GUID: 0Xnsob1z-wbZ54KGJDYypMzfkr05qgrZ
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-29_09,2022-04-28_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 mlxlogscore=736 mlxscore=0 suspectscore=0 phishscore=0 adultscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204290111
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjEvMDQvMjAyMiAyMToyMSwgbmljay5oYXdraW5zQGhwZS5jb20gd3JvdGU6DQo+ID4gQEAg
LTEyMjgsMyArMTIzMCw0IEBAIENPTkZJR19DTUFfU0laRV9NQllURVM9NjQgIENPTkZJR19QUklO
VEtfVElNRT15ICANCj4gPiBDT05GSUdfTUFHSUNfU1lTUlE9eSAgQ09ORklHX0RFQlVHX0ZTPXkN
Cj4gPiArQ09ORklHX0dYUF9XQVRDSERPRz15DQoNCj4gVGhpcyBkb2VzIG5vdCBsb29rIGxpa2Ug
aW4gY29ycmVjdCBwbGFjZS4gWW91IG5lZWQgdG8gYWRkIGVudHJpZXMgaG93IHRoZSBzYXZlZGVm
Y29uZmlnIHdvdWxkIGRvIGl0Lg0KDQpIZWxsbyBLcnp5c3p0b2YsDQoNCkkgaGF2ZSBtb3ZlZCBD
T05GSUdfR1hQX1dBVENIRE9HIGJldHdlZW4gQ09ORklHX1BNODkxNl9XQVRDSERPRz1tIGFuZCBD
T05GSUdfQkNNNDdYWF9XRFQ9eS4gSG93IGRvIEkgcnVuIHNhdmVkZWZjb25maWcgdG8gbWFrZSBz
dXJlIGl0IGlzIGluIHRoZSByaWdodCBwbGFjZSBmb3IgdGhpcyBmaWxlPw0KDQpUaGFua3MsDQoN
Ci1OaWNrIEhhd2tpbnMgDQoNCg==
