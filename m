Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2AF597BA0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 04:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242834AbiHRCnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 22:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239685AbiHRCnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 22:43:41 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2BE1A1D7A;
        Wed, 17 Aug 2022 19:43:40 -0700 (PDT)
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27I0k51I002309;
        Thu, 18 Aug 2022 02:43:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=IfvDhANzamznoWUXmjK805ce07shoT8Pd1Gai7ntMfE=;
 b=d/Dnr3Bru/veitvWAY3wC0I1Lio194HhdPb6ZAeR4Mg4jxj07OwlpndSsZEOY9SACqhg
 W4H82JLa3dCg3lfCT30kmIiLahDMV90pVMfC1PDseOFNUO7Ua2mkwuClGV77oYu8/VvH
 970yAbIg4jdc/YIrPPv5uHyLR+VbVRZmmiDAs/18qAk2IzFT8bLGHqpcfhkzXa85Jk5v
 Tx2IK1O8dSANsFRN+1SFH8/cS/rj+WVfFoSiEYnD2ZcaAhrAwfW+7Z9lllh/h630xxvF
 la6lzuEkYilpUarm+tG5QlEe2YJkRnmQa3PBAn+cFwBaxhru7f+GzxkfGc6QoJ9/RKnG EQ== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3j1b5qgpyc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 02:43:31 +0000
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 94040D2E2;
        Thu, 18 Aug 2022 02:43:30 +0000 (UTC)
Received: from p1wg14925.americas.hpqcorp.net (10.119.18.114) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 17 Aug 2022 14:43:30 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Wed, 17 Aug 2022 14:43:30 -1200
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 17 Aug 2022 14:43:30 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YBohCVynqmzFadTZGKOjThP6GQqFd4vxfYZ6mpYgllEQyRUYdv4GHXOHLAtpk9jPDpMgPTUlry0FLIMZKbX3xXLoBbDN6B6n8fisqBt9S9CfPWz3nA2qd4OelUcikQ5DObX0BYjG3t1+Ljx5ZWWwu+yZ/RPqU03eJUA6Y3uI3qWJ2/ykhmdvF3CDFDxKBtjqdewHiyaNj6TK6QHEaT9yFoJIv5nAdb/Z9EFzEMMtKQmZHTl5+gVNNtrEu2QywTS95w3qE4XdKVzFb2SSsJGBmAq3iHNlw3g1tCf/9U4lz4nCUTPO7ARYL8yRV3qUKdIbcQ468EXxXwBtLKoEEZqlLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IfvDhANzamznoWUXmjK805ce07shoT8Pd1Gai7ntMfE=;
 b=KtL2anAlpIt+vRZgIzr6G5JUmoeYN+IXBfUuxGlbYbcG2mBZGjYesZywy3/wq8bNvyI9z8OjRbzYcnH6TUCkxpwUSMhJT27auumg7MeB8gpnqAWXsuzIdh3OB0r0a2Bh32tyTFGMJlLEFlAQy7X3zgjjYrurLWCaHyg5jOZrpjpiJzg7LbzJxxHwaY9FXzBuKh4JlCg6O95Q2baPnbCQ10XDi/+eZAslcs+gLQznNLFmtVO2fvJm2HEn+aQBrTtwZZ6zy1VnMgJ12XwT+sPD/mKfGrN+VIpDuCP6fgBmkVl7+3E370iGakmLNMIXh9MOMmfcifWyuTEo23rAp+y+XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c4::18)
 by PH0PR84MB1407.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:172::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.27; Thu, 18 Aug
 2022 02:43:28 +0000
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::1cc2:4b7b:f4c5:fbb4]) by MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::1cc2:4b7b:f4c5:fbb4%5]) with mapi id 15.20.5525.011; Thu, 18 Aug 2022
 02:43:28 +0000
From:   "Elliott, Robert (Servers)" <elliott@hpe.com>
To:     "Elliott, Robert (Servers)" <elliott@hpe.com>,
        Nayna <nayna@linux.vnet.ibm.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "ebiggers@kernel.org" <ebiggers@kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 00/10] crypto: Kconfig - simplify menus and help text
Thread-Topic: [PATCH v2 00/10] crypto: Kconfig - simplify menus and help text
Thread-Index: AQHYspAVhdnwrvKxPUuXHJ8Go7Hopq2z0aMAgAAQpQCAABBfEA==
Date:   Thu, 18 Aug 2022 02:43:28 +0000
Message-ID: <MW5PR84MB184244A4BECD56B56E3082A2AB6D9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220815190608.47182-9-elliott@hpe.com>
 <20220817232057.73643-1-elliott@hpe.com>
 <e6e99e33-4279-690d-88b8-9e732551c17c@linux.vnet.ibm.com>
 <MW5PR84MB1842AF29C3DA6CDC5E51BEDFAB6D9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <MW5PR84MB1842AF29C3DA6CDC5E51BEDFAB6D9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b1579d70-53d2-4c7f-dc18-08da80c36e74
x-ms-traffictypediagnostic: PH0PR84MB1407:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zKdx5mucjpxUIv6H1mGr6/vw6EonqBdRkxtjKA0r4P11Cl06rPA2/gY/YqE8XT1Ppmw7guEAEZyhUoGFKoUgYbIsyLL3mu66UqSBHDGY0EKnWa87Tqpp2xQ5zzXrInfJuxUwhinnaCjrgIoS2nVn2q96CUsaltgeibDucWa7nj8gkma02WDjuSQ0kPYrzb1CotMPxZ3c5RWOHRXrRp05TkaU+b1MquDY9LT/AaCQrU/7jm8HMC98hTK7JyN/7lf1+v5CeV/oeh9L+uUsOT1gfovYhfkrksdXtSrQfgSEaOX2pWgESoAea+VxJnZydRpJPDyqvaNo6kspylB2QZq1oouIsuNSdwnFloMwZ/SPBxCbQg7seNh8ENEA8QKkWfdVb1+Z9HhXBpaojOuwoOyx/QEAjBrYXtV66jLFEu7cpfZnn4Jm99GM0qA3jYTAI1kUZ8z/mETOXye/OtYlnOZ+RRaGvp1Io679RgB/ynvmE4s1QWrrmDBZfYgmxVVDaK1GPK3ICoMfDvPu+31fhB5Ao7xeMruaXDXAsQUlX2BZI1EgP+PvtjjoxvlO/lxonuFUdvGIag+Gjckf1zkY1c6pEGd1A7kwiUlMbM/3B2ae088ogAAM6yv4wiDRzylAYdcQNxDq30Ku6s3lFwVtxMnKk8BYJhHrkrJeuE4TuXX220u1QrlW2FxMuwNblGfRX1J7pdVibx+12Hqah0OshlfaaVxO2kCcitpnCenPDeE0KlUXQF/37vj3bUVILVxnafjqkqZVCXPeO+CZZI0IgCdwcA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(136003)(39860400002)(366004)(396003)(66476007)(38100700002)(38070700005)(122000001)(64756008)(82960400001)(5660300002)(8676002)(66556008)(66446008)(66946007)(186003)(53546011)(41300700001)(2940100002)(478600001)(71200400001)(26005)(76116006)(6506007)(316002)(7696005)(9686003)(110136005)(83380400001)(4744005)(86362001)(33656002)(55016003)(8936002)(52536014)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZzFuWHFieUsreThvelU2OVJlckFRWjZ6OHpVRk5mekNZbHVLUzlhWW8yNTVz?=
 =?utf-8?B?alIwVlY4Zk5VSWVSa3BPNFgwTGxIaS9VVHBrNGtCeUozWXNjdDF4dmFMQ3hp?=
 =?utf-8?B?NEZ0NGR1bVRCSnB2RC9IeWNXY2pPK0lnS0E2dDFsWm15bnBTWVRLUXRHYWNs?=
 =?utf-8?B?SEIrV3NhTnNnc1VreWhtbGhXQVIzT1dYZU9LR0YvZDhvMEVjUFVpa2IreGY2?=
 =?utf-8?B?Z0pQbTZqL3hXN3Ywcis1YUw5Yk5NN09VNHlqNTV2UnB3c045ZHpMUExiQjJT?=
 =?utf-8?B?cjM5dkJZUGFNdnJUZUNIL3NWSWdSL1NlSWlTS2FPSUhnTk1hcW5YSllGVnBI?=
 =?utf-8?B?UldQSHJWM1ZpQXYva3ozN0dHK1ZHK1JVa0ozb3E1OEUwdDRkMHpZeGtlVVoz?=
 =?utf-8?B?WFFUNU9OMU00RFIvSTkralZIUi95UnJXanUxV2VBUnlIWXc5clNlcWdUOTM3?=
 =?utf-8?B?NFNQdzROb0tWVzRRVGhJcGNlSElNZnBWemtCQ202OEU5cU1uSGRmVE1wYWRo?=
 =?utf-8?B?NTF5OWNhbnFma0xWSkhMdzE2aENzN2JyVVhLWm1Tb1BSN05iemRjWnNpOSty?=
 =?utf-8?B?T2V4M3pWYzlOaUk2S3VNNUx5blcwQXFqTlBmNVllQmlNRDdHRG8yVVlubWRp?=
 =?utf-8?B?Q0Vsa0NLcFd3aUJpTXpaK3BPSC9GVjRjczJNcWlxN0tNQ290N0NNTWhJYVN3?=
 =?utf-8?B?d2lrbnc2TkFNOU5tQWZMUEc0SFNSbWZ0Zkc1Z0t0bzA0aUIrZXkvWnN6T2Ry?=
 =?utf-8?B?UlRZY2VWNXVMUUtLVkk0aWxYRHBRSzNnM25pOEZldmZjVU13YVNsQnFySWhk?=
 =?utf-8?B?V2RRR0UwT0pvVDg3R1p2eitIVUV1NFhtVGczUGpwWUlQRXNFMHE3OWl4dE55?=
 =?utf-8?B?T0RJVzFzaVZqUUdVbG1rTXVDS0wrUTRUNnE4NlZoZWtmdzRPM2hOMFNTbGlC?=
 =?utf-8?B?djVBaUZJYXk0U1orSFVMSTNveGJFQ01nc1ZmdVhLMkljcjQwN2xMVmJrY1ds?=
 =?utf-8?B?ZENNM3BWd2xrSDhlNHJHOEs1M2RMb2NFaUhNK3M5L1EwL0tyUDVzZU1EQXBs?=
 =?utf-8?B?NXczUDFKK0ViRi9VU0l1b3JPdTJ1N2ttUGRhdEpUc2xHUVNNYlB4OEVpaTRS?=
 =?utf-8?B?S1NYTjYwMmsrci9XR0hzV3N6Yk5uVVNmVnZNTUNLYjIyTmdMcVUveG5sdkwz?=
 =?utf-8?B?MXJYbDBGOWpsdnJaNCtIcEp2UmZzRGtTMGtBTXdxd28rb20wZGdQL0pxR1FO?=
 =?utf-8?B?YVJyUzdZZGxrM1BiWmpVOHlYVlk5VzlzelBRbnVQV3hsTTl3ODF1U3hNT3Bs?=
 =?utf-8?B?RlQzMU5LcFlNbWV4TlM0VVF4a2xic004Wmpkanlqd3hVR0h6RWtMMTdCYzlu?=
 =?utf-8?B?dWJZajBNTXVVUnJUYnRoVTNsUVR5WDNDNytVN0gzb3RoS3FjOXVrRnVHaGNy?=
 =?utf-8?B?b0dsVTRRZjQwSUpXTFAzNk5KeTNxSS9nSnJHK016OS9CSG5EUTg1QnFodmNz?=
 =?utf-8?B?K2hKNm5WOEdTd3o1SDhqRzRBcUxkWXZMYlN6T1h2TTNkVGNpMld1aDRCQW5l?=
 =?utf-8?B?V2hkZTNQcjVKbzB0eGY4ZHlQR3ErVjNOaGRaNy9sRmZaZXRFR1grTDQ0ZmJk?=
 =?utf-8?B?MXJCSkk4dEZUa3F0Um9hbm1welFJMUZ3M0luYSs1V2JkVTVncG5jZW9UN3hv?=
 =?utf-8?B?U0tNaFI0bkVQNVBxendHcjNKczVNQlcyVmJsaGRDVnJIR0FCV20zdGdhdGo1?=
 =?utf-8?B?UkdZb01JbVpsSFh3UUszQzBSNXpGQmJ2eTdjUkRsWjRKRVhMOXVwcDVEVlZa?=
 =?utf-8?B?d0x1SmNkZUdGMUo0NWhoQndrM2JIWVFSOXdaZHpVYUN6bTIxQnNDb1ZhbGFT?=
 =?utf-8?B?Kzh2SndQSDVJOWk4OVFSMUhYNVNyV3poWFB2M05aa1FJdkFzNXZMNUJsZ204?=
 =?utf-8?B?bWZIZVFvUWR0TlVDS0RrQWFTV3NBNnI3eS9SdmM2OUlmSVhRSlE1MzZqYkNI?=
 =?utf-8?B?SmpkYlArN2ZmN0NENzNzem5nTEZVaVZlVFlpekFWVDlscDFMSklNemM5enR0?=
 =?utf-8?B?R2F6SGxHQTBISUt6T2hFQUgwd29DdnRsZUZjcUlQaUpGTlBNYVFtZzFUMmhi?=
 =?utf-8?Q?0Gds=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b1579d70-53d2-4c7f-dc18-08da80c36e74
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2022 02:43:28.6164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ywd5S6pQi0+C5ryFiAxDVAL9AX4/CPVS5C/aQ6kfeDT7XO+wsYbMlFU8v/Sueq/M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR84MB1407
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: PM0RGbpMgOzZG3TVh-iqlJw-7Z8XpgYK
X-Proofpoint-ORIG-GUID: PM0RGbpMgOzZG3TVh-iqlJw-7Z8XpgYK
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-17_17,2022-08-16_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 phishscore=0 spamscore=0 priorityscore=1501 mlxlogscore=999 malwarescore=0
 mlxscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208180008
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBFbGxpb3R0LCBSb2JlcnQgKFNl
cnZlcnMpIDxlbGxpb3R0QGhwZS5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgQXVndXN0IDE3LCAy
MDIyIDk6MTMgUE0NCj4gU3ViamVjdDogUkU6IFtQQVRDSCB2MiAwMC8xMF0gY3J5cHRvOiBLY29u
ZmlnIC0gc2ltcGxpZnkgbWVudXMgYW5kIGhlbHAgdGV4dA0KPiANCj4gPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206IE5heW5hIDxuYXluYUBsaW51eC52bmV0LmlibS5jb20+
DQo+ID4gU2VudDogV2VkbmVzZGF5LCBBdWd1c3QgMTcsIDIwMjIgNzo0MiBQTQ0KPiA+DQo+ID4g
PiBOb3RlczoNCj4gPiA+IDEuIHBvd2VycGMgZG9lc24ndCBidWlsZCBmb3IgcmVhc29ucyB1bnJl
bGF0ZWQgdG8gdGhpcyBzZXJpZXMuDQo+ID4NCj4gPiBEaWQgaXQgYnVpbGQgd2l0aG91dCB0aGlz
IHBhdGNoc2V0ID8gQ2FuIHlvdSBwbGVhc2Ugc2hhcmUgbW9yZQ0KPiA+IGRldGFpbHMgb24gdGhl
IGVycm9yIG9yIHJlYXNvbnM/DQo+IA0KPiBJIGhhdmVuJ3QgdHJpZWQgd2l0aG91dCB0aGUgcGF0
Y2hzZXQsIGJ1dCB3aWxsIHRyeSB0aGF0IG91dCwgYW5kIHdpbGwNCj4gYWxzbyB0cnkgZGVmY29u
ZmlnIHJhdGhlciB0aGFuIGFsbG1vZGNvbmZpZy4NCg0KVGhlIGRlZmNvbmZpZyB0YXJnZXQgd29y
a3MgZmluZS4NCg0KDQoNCg==
