Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB0564DA408
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 21:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351728AbiCOUdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 16:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241887AbiCOUdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 16:33:15 -0400
X-Greylist: delayed 3410 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 15 Mar 2022 13:32:03 PDT
Received: from mx0b-00369f01.pphosted.com (mx0b-00369f01.pphosted.com [148.163.139.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520F232984
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 13:32:02 -0700 (PDT)
Received: from pps.filterd (m0167463.ppops.net [127.0.0.1])
        by mx0b-00369f01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22FARQW2011586;
        Tue, 15 Mar 2022 15:34:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mksinst.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to :
 content-transfer-encoding : mime-version : content-type; s=podFeb2021;
 bh=XX05cN8dwx1M5qElshErShz5Fmj53/c6maO08JTlzcw=;
 b=I7zV9BntoDNXxMrVSpFsfjbzMJnyt9Din7LNFV3P6KTccOwU4gg4DzDKWyuyUVC2vUem
 7x70Tg/JWni3/f1+nwluYQS9OMYEyEEkvCoDB2jyYxmqxBjLkITlfGK2VrvnQoaPoSt2
 vx4gpNFCToeNZZsW+JzX7qT54DwNewmoE5bioZKZqoS9VooY0gowDKD5KD46gM8XrO52
 PdQ1IrIzPdqm2BZG18EU4IZ91sRNbw9qirq+aNMzeINm6hrfjrMyEFGRhdX/3vSBGKXt
 4jLdC07iTqzK2DSqJa4Lx+NZEH2oRhpGeuiKkA683eRjMI8ql9Jze34u6xqWV5zanB6X sQ== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by mx0b-00369f01.pphosted.com with ESMTP id 3ets2htfu1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Mar 2022 15:34:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vy8Ss27ZluJy+8f8z3R5qOGfzhRt0lVGKZ6EX2W6AEyz7UTHYB1ihYVc84lJILD1YyzHE5kgOZgG22+8mkUMimX9cmIf2I8kcMrYBWSKbvddXPf4J3l5yVN23EUlm3k1tNPPQtZ7aA1k6DjiJEDIEEXA7cJyZeL8/D1syJ9Qu5KQMrYJYN9Hksvm5XMZuN1Erb9+jeD8CrV69pfj7m6Y8M67bBbr2y8DSaeKUB+vxKvPHZdyJ2FimMbUzrmZVUCpx9WRIJHqSbr9MJCQj5/BZqWe9zwGrcMnewvOHsk+g3aQ0u39Z43vgkT1M4iswu/nF6QPr/1RjgmUTp+Hz/Ab/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8mc8YwfANLVh17h3WQAyTweS6gIh2wXtzOVSbGXE9L8=;
 b=ZkG5svIEdG2rEKAS3k3KH/+vFKZAGjMymPXJcj/9JdLhGf/svznUDnADl2h6sjkLXT9Q4vZ9HLlZvqf34Dyw9ms451aAcm23hNJEhKONbNb+PVfztPDotN4M1yEjeiL2uJJ8Tyqx5yTSKpQk0jy1zYDtQ9YKqpI0cI+Aw78nhLYl7MPdwKK0qTRHkS0dSVt9pI4e6KxsAFHffYmdY7rNE8JtxqH1JVxIsRGNpgfAbbb3rg52Dqr83jjYQUWwoSjgeeQedrMSGEsDxKVsLUFHzxO7Bb5h+zcfqhymiuT7vBlHBJ99RhLrAAzJ7Zl7Q9U7XPl7Sj3KvuSPx4Y84ZPBAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mksinst.com; dmarc=pass action=none header.from=mksinst.com;
 dkim=pass header.d=mksinst.com; arc=none
Received: from MN2PR03MB5008.namprd03.prod.outlook.com (2603:10b6:208:1ac::24)
 by CO3PR03MB6808.namprd03.prod.outlook.com (2603:10b6:303:171::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Tue, 15 Mar
 2022 19:34:52 +0000
Received: from MN2PR03MB5008.namprd03.prod.outlook.com
 ([fe80::8d29:bd4b:20cf:ee41]) by MN2PR03MB5008.namprd03.prod.outlook.com
 ([fe80::8d29:bd4b:20cf:ee41%7]) with mapi id 15.20.5061.029; Tue, 15 Mar 2022
 19:34:52 +0000
From:   "Fillion, Claude" <Claude.Fillion@mksinst.com>
To:     Luca Ceresoli <luca@lucaceresoli.net>,
        Adam Ford <aford173@gmail.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC:     "aford@beaconembedded.com" <aford@beaconembedded.com>,
        "cstevens@beaconembedded.com" <cstevens@beaconembedded.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH] clk: vc5: Enable VC5_HAS_PFD_FREQ_DBL on
 5p49v6965
Thread-Topic: [EXTERNAL] Re: [PATCH] clk: vc5: Enable VC5_HAS_PFD_FREQ_DBL on
 5p49v6965
Thread-Index: AQHYOEpoqMQLOkVQCEOjGSHAmfR/NqzA0z7w
Date:   Tue, 15 Mar 2022 19:34:52 +0000
Message-ID: <MN2PR03MB5008F8DDC6DD934074EBBC0E93109@MN2PR03MB5008.namprd03.prod.outlook.com>
References: <20220313115704.301718-1-aford173@gmail.com>
 <a146f554-837a-d19a-425c-b1fd790a0497@lucaceresoli.net>
In-Reply-To: <a146f554-837a-d19a-425c-b1fd790a0497@lucaceresoli.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: be6beb76-00ba-4595-2117-08da06bae06c
x-ms-traffictypediagnostic: CO3PR03MB6808:EE_
x-microsoft-antispam-prvs: <CO3PR03MB6808DD00CC0CCFAA59592ABC93109@CO3PR03MB6808.namprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0r98q1iV79eq0miEwuMAUl57ulK03XK9+nsyGQDN1BnrnU4HvcXuoGW0ka84lflTFbkI90YwP+ncshEEOJgxWteVCNaXJwX6VyOhR75mUT2AP/TRrOV3qYRWZT9MXUBbvxSQge3JK9OMzFfg5ssFP0AT0L9PVYozILUodmxU6H5A2xvr4WPXkSZyiPEc0TiG2xdRl6UkzErf2K2ERo1c0XT3jAMRw43YQFh/RCoUqvIvDKVdOdQgFm3R9Fb5ZDGolu3clA66HGEYiZwBCKDqB9UxFBvUqxaLP3R3rlY+Yht13fh8K6TqVCabk0KZXtxxjHK3x/tNKK2fU6RQqdJpYmm1So2byuT+y6WKLIgyOgLTc0pyDM9YDaGkijLUFNwBCkFDqwD/QnXYSqd6Jc9X0IrlUx4tJXN1EF++eb3OF274J+gmzr9MbwLdoYyj60kt+l0MM0tlW/Xqew72qXSdhltgKCHEvL5oqiZMS0Jq4gDDihqcac/1sDHq6nKyEs8dFxujXRVT8GIq2derMCnj8w5KvzsRyOlAELjHTKUo0TSNrTnbUSV27KsOCY9O4CETEYrSoCp+6e+rON/uENoCb1HaHsZqSasfFWaDSIiiLZuHgVNjzbtkbMs9svOq4BgWxnoCg/CW+76SkkNR1UP6hRS1ejKM3WAFGC6HYLi75S+/25yGsO38wQjtLBaswrTqE0qFxQH6Q+HorKin+0lVIA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB5008.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(33656002)(122000001)(38100700002)(7696005)(53546011)(8936002)(5660300002)(52536014)(9686003)(6506007)(86362001)(55016003)(26005)(83380400001)(186003)(54906003)(110136005)(66446008)(66556008)(66946007)(316002)(66476007)(76116006)(64756008)(8676002)(38070700005)(4326008)(71200400001)(508600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NmpZWTZTcHN1WFdNNmVFWE9LK1B5V1RXNGI4Z0lBemNqWTcycSt4ZW5NN2Zw?=
 =?utf-8?B?TmxURmNrYU5HU1RJYzh0ejVpSXIvMVFPQ2M1QUtiejU1bG1oMGZnMklyU2l3?=
 =?utf-8?B?VFlueU8zOTFheXBGb0pxaW5TTm9QbjlGaUs0YVN1Z3VKWWFUK1ozTEZaa2h4?=
 =?utf-8?B?bDZtOEp5ME15OHdhWGRrWkFGRU1DOUJjUTA4WFNRVzEwdlpqK2l2S0ZQSWhK?=
 =?utf-8?B?OTZUNGgrRk5PempzQWx5ZzJ4eExNTVI4aVBmNldjY3FPb095T3hLbm0rdVdZ?=
 =?utf-8?B?R1E4UGh4YytTeFQwakNpSFZDb0lETHM1VWVkOE9IVjJudE9uQlVLcS9SZDFQ?=
 =?utf-8?B?QW1nWllnV0craFlyRnpuRG1tU0xSVFRNazFTdy9GU0YvRU9ZVGdmb3BudjVm?=
 =?utf-8?B?SUVhT0tseGVUaVptM0pvUkhRNm1ZVXhlbURrOGFxcmxmTjYrRDBGZ0xQalp0?=
 =?utf-8?B?ZnQ4QWVPNVE5SVF4N29KYTBIb25NMElIaDNaakVtb0E0OHpHVnJpZWx1ZTVH?=
 =?utf-8?B?R3FHM2NmRERCcU9mbDlFSU9uZXhVUzYvbHBraWhNRVlnTWptVUNaYVdYR3U5?=
 =?utf-8?B?YzZCMEM5OW9tVWIxMFZCUjV2Z1J4dGkvR0EzNXJKNnlta2dmVyt6MjM5SHYr?=
 =?utf-8?B?NmRDdnJvUHdvUklnZWZRT0lGRXZ0dWZqLzVicXU4aDVCdURDdTVOWndXZ2ZG?=
 =?utf-8?B?Q3grdDBKVi9CVzFGZG5yT1pHUFBiTW5kQ3VkMEZLN2UwamlZRlNRbDMwaUEx?=
 =?utf-8?B?NFR5M2VIYVhTQVBUOGhKRHcwUDFLc0UySEJwTnpSZjc5b2tFVFVuODNPWGd5?=
 =?utf-8?B?aXNQRlRGbUZIQzIxQ01YU1RmaW5ZT2pYWERtNUF2TWVNdVhDcnVNT3Y1eW5M?=
 =?utf-8?B?eFBraEF4K0g2bEs1ZXpOQ04zWmwyU25aUnZLU2ZHRmE2Q2hrdHc2SmR3bVFD?=
 =?utf-8?B?Rk1HWnFVYW5RT1lqWDVac3F1NngvWGptVUhnNy9hVW5yU09lWXpvNWR4OUp3?=
 =?utf-8?B?Z2dRSmFkcFppVjR0dmtvTTNrK1RnNjhSdXdQNnp3ZFM5Sm5tR1BScXdnVVVq?=
 =?utf-8?B?TVlzV0RJNW5YNEJHRDJpcXRNOThuRWpiNnhIKzU0ZGtSZzJQaEt3VkhBdmFh?=
 =?utf-8?B?V05lWWhGKytHejdZQ3JMRlBCMlB0NkpWSW5SQmZ6N01MQkxReXVkY3hkdkRD?=
 =?utf-8?B?eDYzUjlGYXNWQmVQcXhlSFJ4T29zcWZRQnNZc0d0c3Z3dmFBSExacDdVZFNy?=
 =?utf-8?B?Y3NNRzhmMnByZ2s5TjJxZzQ4VHNYTjF1RmJHSWNSZXIxRmxqbnFuSi9sQ2hw?=
 =?utf-8?B?ZG9lWTlzbnNMWmwrZkdQZW4rdmE1eFBMMHpsc3BzM0ppbzE4REZoTXhLc0Qw?=
 =?utf-8?B?MFhxMFN5eGM3K3ZIK21EZk9JaFRuWEwvWVVWcStZTXFaWlRxKzUyNWZJR0Jk?=
 =?utf-8?B?Zk5LdExKVHJvakloRzM1aERjc3RaNGFtZ2tidzdESDNzQWhmcWpuMWcvVm5w?=
 =?utf-8?B?VzZiYVpnbUxqenNLQWU0ZGlFOHMxRjFhSlhERGh5UXp0VDQxSUdEQW1VYkJK?=
 =?utf-8?B?aWpkOFZ4REdzWklKcGtSVmZuWkVNS3hCRzcrcSt0YlQ4a1FsZ0pKeVBlYS9s?=
 =?utf-8?B?R2pCanRxbjYzSFVnYno0cW16MS8xY3JERHlYT0o5R3pBTTZnWmpFUnlBVjdk?=
 =?utf-8?B?Y2hZc3J0eTQ0dUFKSytYKzdhaVNVOU1wT1RMSk5nVDB0RmZGVUdKU3ZBYkVW?=
 =?utf-8?B?NWRXdzhuSVRXWGdHMzVpQkJIZlhhcE5BNXBSdzFYMDV4YW5iRGhOc0ZVelRY?=
 =?utf-8?B?ZG4zWmFjTERoS1VQSWRxc1pLeDE0ZC8zT203TXZPMlhRWjAyZ3RnaFRESE1o?=
 =?utf-8?B?dWVIRFRIT0k4QkUzTWR1RXdoNjhGVFhERnBsMDNKcVVGbkhCQlgrdk9xWXkr?=
 =?utf-8?Q?/ECPYBGVVwA5FeiQXeBVTejHgteje05S?=
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: mksinst.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB5008.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be6beb76-00ba-4595-2117-08da06bae06c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 19:34:52.3182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34fc6b5f-c773-4cad-ae20-f226c36b7e65
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GjLEcO+OSQtTSJZVh0JGpB4Z2xqGA5pdw6XxNJgZQrWfaKHwMhGzA4XgX4jJ/MvmlGu46WXcgOCiCw37ms43wGCOoRG/YJLN5/HSr7hUres=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO3PR03MB6808
X-Proofpoint-GUID: Trc4PC-baBjKn9cYOPPK_CopzxHNjVu3
X-Proofpoint-ORIG-GUID: Trc4PC-baBjKn9cYOPPK_CopzxHNjVu3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-15_09,2022-03-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=937 impostorscore=0 adultscore=0
 clxscore=1011 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203150113
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gTHVjYSwNCg0KSSB3aWxsIGRlZmVyIHRvIEFkYW0sIGJ1dCBhIGZldyBjb21tZW50czoN
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMdWNhIENlcmVzb2xpIDxs
dWNhQGx1Y2FjZXJlc29saS5uZXQ+DQo+IFNlbnQ6IFR1ZXNkYXksIE1hcmNoIDE1LCAyMDIyIDQ6
NTUgQU0NCj4gVG86IEFkYW0gRm9yZCA8YWZvcmQxNzNAZ21haWwuY29tPjsgbGludXgtY2xrQHZn
ZXIua2VybmVsLm9yZw0KPiBDYzogYWZvcmRAYmVhY29uZW1iZWRkZWQuY29tOyBjc3RldmVuc0Bi
ZWFjb25lbWJlZGRlZC5jb207DQo+IEZpbGxpb24sIENsYXVkZSA8Q2xhdWRlLkZpbGxpb25AbWtz
aW5zdC5jb20+OyBNaWNoYWVsIFR1cnF1ZXR0ZQ0KPiA8bXR1cnF1ZXR0ZUBiYXlsaWJyZS5jb20+
OyBTdGVwaGVuIEJveWQgPHNib3lkQGtlcm5lbC5vcmc+OyBsaW51eC0NCj4ga2VybmVsQHZnZXIu
a2VybmVsLm9yZw0KPiBTdWJqZWN0OiBbRVhURVJOQUxdIFJlOiBbUEFUQ0hdIGNsazogdmM1OiBF
bmFibGUgVkM1X0hBU19QRkRfRlJFUV9EQkwNCj4gb24gNXA0OXY2OTY1DQo+IA0KPiBUaGlzIGVt
YWlsIG9yaWdpbmF0ZWQgb3V0c2lkZSBvZiBNS1MuICBVc2UgY2F1dGlvbiB3aGVuIHNoYXJpbmcg
aW5mb3JtYXRpb24NCj4gb3Igb3BlbmluZyBhdHRhY2htZW50cyBhbmQgbGlua3MuDQo+IA0KPiAt
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+IC0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gSGkgQWRhbSwgQ2xhdWRlLA0KPiANCj4g
dGhhbmtzIGZvciB5b3VyIHBhdGNoLg0KPiANCj4gT24gMTMvMDMvMjIgMTI6NTcsIEFkYW0gRm9y
ZCB3cm90ZToNCj4gPiBUaGUgNXA0OXY2OTY1IGhhcyBhIHJlZmVyZW5jZSBjbG9jayBmcmVxdWVu
Y3kgZG91Ymxlci4NCj4gPiBFbmFibGluZyBpdCBhZGRzIHZlcnNhY2xvY2tfc29tLmRibCB0byB0
aGUgY2xvY2sgdHJlZSwgYnV0IHRoZSBvdXRwdXQNCj4gPiBmcmVxdWVuY3kgcmVtYWlucyBjb3Jy
ZWN0Lg0KPiA+DQo+ID4gU3VnZ2VzdGVkLWJ5OiBDbGF1ZGUgRmlsbGlvbiA8Q2xhdWRlLkZpbGxp
b25AbWtzaW5zdC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogQWRhbSBGb3JkIDxhZm9yZDE3M0Bn
bWFpbC5jb20+DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvY2xrLXZlcnNhY2xv
Y2s1LmMNCj4gPiBiL2RyaXZlcnMvY2xrL2Nsay12ZXJzYWNsb2NrNS5jIGluZGV4IGU3YmUzZTU0
YjliZS4uNGQxOTA1NzllODc0DQo+ID4gMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9jbGsvY2xr
LXZlcnNhY2xvY2s1LmMNCj4gPiArKysgYi9kcml2ZXJzL2Nsay9jbGstdmVyc2FjbG9jazUuYw0K
PiA+IEBAIC0xMjExLDcgKzEyMTEsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHZjNV9jaGlwX2lu
Zm8NCj4gaWR0XzVwNDl2Njk2NV9pbmZvID0gew0KPiA+ICAJLm1vZGVsID0gSURUX1ZDNl81UDQ5
VjY5NjUsDQo+ID4gIAkuY2xrX2ZvZF9jbnQgPSA0LA0KPiA+ICAJLmNsa19vdXRfY250ID0gNSwN
Cj4gPiAtCS5mbGFncyA9IFZDNV9IQVNfQllQQVNTX1NZTkNfQklULA0KPiA+ICsJLmZsYWdzID0g
VkM1X0hBU19CWVBBU1NfU1lOQ19CSVQgfCBWQzVfSEFTX1BGRF9GUkVRX0RCTCwNCj4gDQo+IA0K
PiBJZiBteSB1bmRlcnN0YW5kaW5nIGlzIGNvcnJlY3QsIHRoZSBkb3VibGVyIGlzIG5vdCBtZW50
aW9uZWQgYnkgdGhlDQo+IGRhdGFzaGVldCwgYnV0IGl0IGV4aXN0cy4gTWF5YmUgaXQncyB3b3J0
aCBhIGxpbmUgb2YgY29tbWVudCB0byBoZWxwIGZ1dHVyZQ0KPiByZWFkZXJzIG5vdCB3YXN0ZSB0
aGVpciB0aW1lIGluIGZpbmRpbmcgb3V0Og0KPiAgIC8qIEZyZXF1ZW5jeSBkb3VibGVyIG5vdCBt
ZW50aW9uZWQgb24gZGF0YXNoZWV0ICovDQo+IA0KDQpJIHNlZSB0aGUgZG91YmxlciBiaXQgbWVu
dGlvbmVkIGluIFRhYmxlIDI1IG9mIGJvdGggdjYgYW5kIHY2ZSBzcGVjcy4gIEl0IGlzIG5hbWVk
IGRpZmZlcmVudGx5LCBidXQgYXBwZWFycyB0byBoYXZlIHRoZSBzYW1lIHB1cnBvc2UuIA0KDQoN
Cj4gQ2FuIHlvdSBjb25maXJtIHRoYXQ6DQo+ICAtIHRoZSBlbl9yZWZfZG91YmxlciBiaXQgdmFs
dWUgZGVmYXVsdHMgdG8gemVybyB3aGVuIHJlYWRpbmcgaXQsIGFzIHRoZQ0KPiAgICByZWdpc3Rl
ciBndWlkZSBzYXlzPw0KPiAgLSBpZiBzZXQgdG8gMSB0aGUgZnJlcXVlbmNpZXMgZG91YmxlPw0K
PiANCj4gV2l0aCB0aGF0IGNvbmZpcm1lZCwgdGhlIHBhdGNoIGxvb2tzIGdvb2QuDQo+IA0KPiBU
aGFua3MsDQo+IC0tDQo+IEx1Y2ENCg0KSSBwbGF5ZWQgYXJvdW5kIGEgYml0IHdpdGggdGhlIHBy
b2dyYW1taW5nIGJvYXJkIHRvZGF5IGFuZCBkaWQgbm90IHNlZSB3aGF0IEkgZXhwZWN0ZWQgdG8g
c2VlLg0KDQpVc2luZyBpMmNnZXQgSSBzZWUgdGhhdCB0aGUgcmVnaXN0ZXIgaW4gcXVlc3Rpb24g
KDB4MTApIGhhcyBhIGRlZmF1bHQgdmFsdWUgb2YgMHhBMCBmb3IgYm90aCA2OTAxIGFuZCA2OTY1
LiAgVGh1cyBpdCBzZWVtcyBkaXNhYmxlZCBieSBkZWZhdWx0IGZvciBib3RoIHBhcnRzLg0KDQpT
dGFydGluZyBhdCBteSBiYXNlIGZyZXF1ZW5jeSBvZiA0Ni44TUh6LCBzZXR0aW5nIHRoZSBiaXQg
dG8gMSAoaTJjc2V0KSAgY2hhbmdlcyB0aGUgb3V0cHV0ICBmcmVxdWVuY3kgdG8gNTkuMDRNSHog
Zm9yIHRoZSA2OTAxIHBhcnQsIGFuZCB0byA0Ny43TUh6IGZvciB0aGUgNjk2NSBwYXJ0LiAgU28g
c2V0dGluZyB0aGUgJ2RvdWJsZXInIGJpdCBjaGFuZ2VzIG91dHB1dCBmcmVxdWVuY3kgZm9yIGJv
dGggcGFydHMsIGJ1dCBub3QgdGhlIHNhbWUgYW1vdW50Lg0KDQpOb3Qgc3VyZSBvZiB0aGUgbWVh
bmluZywganVzdCB3YW50IHRvIHBhc3MgdGhlIGluZm9ybWF0aW9uIGFsb25nLg0KDQotQ2xhdWRl
DQoNCgo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09ClRoaXMgbWVzc2FnZSBhbmQgYW55IGF0dGFjaG1lbnRzIGFyZSBp
bnRlbmRlZCBvbmx5IGZvciB0aGUgZGVzaWduYXRlZCByZWNpcGllbnQocykgYW5kIG1heSBjb250
YWluIGNvbmZpZGVudGlhbCBvciBwcm9wcmlldGFyeSBpbmZvcm1hdGlvbiBhbmQgYmUgc3ViamVj
dCB0byB0aGUgYXR0b3JuZXktY2xpZW50IHByaXZpbGVnZSBvciBvdGhlciBjb25maWRlbnRpYWxp
dHkgcHJvdGVjdGlvbnMuICBJZiB5b3UgYXJlIG5vdCBhIGRlc2lnbmF0ZWQgcmVjaXBpZW50LCB5
b3UgbWF5IG5vdCByZXZpZXcsIHVzZSwgY29weSBvciBkaXN0cmlidXRlIHRoaXMgbWVzc2FnZSBv
ciBhbnkgYXR0YWNobWVudHMuICBJZiB5b3UgcmVjZWl2ZWQgdGhpcyBlbWFpbCBpbiBlcnJvciwg
cGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGJ5IHJlcGx5IGUtbWFpbCBhbmQgcGVybWFuZW50bHkg
ZGVsZXRlIHRoZSBvcmlnaW5hbCBhbmQgYW55IGNvcGllcyBvZiB0aGlzIG1lc3NhZ2UgYW5kIGFu
eSBhdHRhY2htZW50cyB0aGVyZXRvLiAgVGhhbmsgeW91Lgo=
