Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 281D05189BA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 18:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239486AbiECQ1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 12:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237543AbiECQ0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 12:26:39 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18E2396A4;
        Tue,  3 May 2022 09:23:06 -0700 (PDT)
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243FOxsF017959;
        Tue, 3 May 2022 16:22:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=EjgHOgiPVfyE7OTUmvIxzJ4c060wAeED0qyHUTp5wJI=;
 b=b10qeR5o2x0v7X+1ms09jRPvJIGf//xFfuz98NDfqxycazQWqkrociWtqrv9rArYQeiS
 fFojEu8zjfx1UP9t5ljFr0ywfFK1xchIctBjghkDMeq+9AO3lS8R8mypmmX/yktvka3c
 fiRI+xxlmyN7a+8XFVvf4a9VrBm/bXRwj6GW6Kf+SVpgUAWX+QZqCdevOWlDK5isu2fD
 4xBZqPpHvMTsAMjzSRZJArg5iVmwDicC09bTJnN6Q+oF7GyJKQBwjNjRCpIs7T95OqHT
 azLNFsDbG+YQPWMEw3/cIuWcwR+sW4gf50LFE3HEiDJ4yyiRVZaVJqP5PD/2qvXK17Tx qA== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3fu70k8gqc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 May 2022 16:22:42 +0000
Received: from p1wg14924.americas.hpqcorp.net (unknown [10.119.18.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id EF289800357;
        Tue,  3 May 2022 16:22:40 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 3 May 2022 04:22:37 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Tue, 3 May 2022 04:22:37 -1200
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 3 May 2022 04:22:37 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nbgv1tbLq72ZDQGExDhJ9F6Ch87XFLdO+dLDLH7Zd1HEnK77MQQaZKIELJrTB1LZywHfZAgEuMibDJYoy3nWpdsH8Oq2M9fRGBDAKZRLvfqC+tg3tFTtxiRWtWJn7YC+fJ10WKCA2TpQIOgsm4NhlU8rvcjUdrxU29nvUVNdywED7dQPjlUnFp4gTDPO4aEiPNQYGNiuDWGQ8kn6Re6/sidfCl6tIa+eqKqhX3tjOIFwZ8WK8fIN34P6P2IqhXD8iVCnm3/Bc4Bb5S06sQ0RtJaWlT8p3g0MZCgCoxJt9TM3oqhpUHnJz56X0G5/0ao7rfKq1vZSroQ0mV1a2bo/UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EjgHOgiPVfyE7OTUmvIxzJ4c060wAeED0qyHUTp5wJI=;
 b=EqG+i3leWqc5ShPnWrcIwWNJxFn8PlPzbZ615iM1x4e56sLaOjq+TaGlMlsgI0ufJnKTwTO/dv2/pBzROrnLMscdC6/sqQ9qIWEViQlr0pk2eQkp/3qA7+063C1z1v7qKRZflD/+u/uregrbORMMyMRaCXLDVkZzWJuz69WwQbISr0K/X9lLJBeca92msJ5SiFJiOUMzoThV0ptsJlASb5SfHgqaLY6krhwISjjYsNRvE1eUPds8Y6ILNq5C5v8kDCffRN2njV0tFVDo8+S0pafVTYBmaBEgS6tsm/EUg+cv10TVqa8JdgVF9CZg5qru/AcFwsDTG7+LO5hUa9hJ8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:172::21)
 by MW5PR84MB1793.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Tue, 3 May
 2022 16:22:35 +0000
Received: from PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6055:1602:5a0a:1562]) by PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6055:1602:5a0a:1562%8]) with mapi id 15.20.5206.024; Tue, 3 May 2022
 16:22:35 +0000
From:   "Hawkins, Nick" <nick.hawkins@hpe.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        "Verdun, Jean-Marie" <verdun@hpe.com>,
        "joel@jms.id.au" <joel@jms.id.au>, "arnd@arndb.de" <arnd@arndb.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Subject: RE: [PATCH v6 3/8] watchdog: hpe-wdt: Introduce HPE GXP Watchdog
Thread-Topic: [PATCH v6 3/8] watchdog: hpe-wdt: Introduce HPE GXP Watchdog
Thread-Index: AQHYXmTBU9QpRPETyU+LLmyqVzG+B60Ma8CAgADeuyA=
Date:   Tue, 3 May 2022 16:22:35 +0000
Message-ID: <PH0PR84MB1718D28F1846F54DB5766E6D88C09@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220502204050.88316-1-nick.hawkins@hpe.com>
 <20220502204050.88316-3-nick.hawkins@hpe.com>
 <c0262cf4-dfeb-c9a9-bcb2-24af006e6d4d@roeck-us.net>
In-Reply-To: <c0262cf4-dfeb-c9a9-bcb2-24af006e6d4d@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 80b08e55-a2fa-4755-973e-08da2d212205
x-ms-traffictypediagnostic: MW5PR84MB1793:EE_
x-microsoft-antispam-prvs: <MW5PR84MB1793F6547BA07DCB960FCF6588C09@MW5PR84MB1793.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IdG0uxjpWlqRz3G70Oh9mxKtkW037cNdCIqRdm4AcaYhe/tLtARFCdtVvpW9GHAMI+ZLSiRYAERHhNlpe6MSr3rSJzxqBtRZFEsEhuJwnj9CoY6hlopGqMX+pCh7fPwYfSjsqQrF+m1iu/rYv5blTqwGWTuKrsc3kBFA0M2KaiZ6s3gV4173j5kRJQ7aoP7tLOVYl0MYgykFvonkx4B7f8Be+cn0IO9PVld4vtCD7zt7pxFM3rNWwCG4TrH2c5big7o1CS/arAM3CJiXdURYTiS80rZD2KF06+JysuPOdGCegCC4XPfNEtCk3h67NMGxOSd5S/wfuJJbQaRa5EgSePOqsSUUmWBcjam03ma9DXlx8xQrL+BNZWJBwnRbahuJhKov3kXI7dQ3fz6eaNAmIR9Rpu5G0GNwv7Tw92+X3heeZAKuHA8FHDhyy147MD+8RKkIKEq7d4tRsNyjFZEVdjf5KZCKS4CGt7cmW4WB4Q/g7jGs+zG0htXU+Jw+PtQFYYvBNUAFs6PemkzB6KvQzeRVfwZ5t0ZonprsG/ISuIf3dYDvrWg0tNDrZnanXxvrFpubreUmYeER55UdF44YCkq4Dl77r+3Ei/kuqRZSvHGkrE25KlZoIgCMiHlM8TzYbUFod7xksQMn6tE2uN5WFxwsDyMrqBCfTOCIXOicHkW5xZr6AagmY2uRVhvW6u3ZM9MfZSvdVgexub6nfp1FSQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(2906002)(55236004)(6506007)(53546011)(55016003)(26005)(9686003)(508600001)(122000001)(8936002)(52536014)(38070700005)(38100700002)(71200400001)(7696005)(82960400001)(5660300002)(8676002)(76116006)(4326008)(64756008)(66946007)(66556008)(66476007)(66446008)(33656002)(186003)(316002)(110136005)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TnpQeHd5dWxwdVNrNE81YkNwbVhldUUxSWdCT3lYcHNDQkVBcVJBY2RSaTh6?=
 =?utf-8?B?ejlkTVhzcGR6YjBuekpwOE82WFpZNCtnSGJneHF4cm9aSUg5U1dQRURFSkUw?=
 =?utf-8?B?N3c3Y2hCZlBUbjNJUTcyNGszc0QwbWZZK09lMGRnS0s0bVhPbVZvWDdld2d2?=
 =?utf-8?B?azBySDg1ZitMNmY4bGxLN1N4d0NQM05oa1BqMW9oczIyemxON3dHRWYyUmxz?=
 =?utf-8?B?R2NJTTVMQkltd1B6N0ZhSVBnNk9ySzZBYXdITDNQYmszS1NGMW5ieUwxSWlM?=
 =?utf-8?B?RXZFQzgyUEM5YlJkQnVEcGRPNWlJRWdYVVc5U3Jia1NqWXp0alNoMS9qZEh3?=
 =?utf-8?B?MjFYSXZxNWM4OVZhclFENmxQaEg2ajBLRlJ1Rk5FYTZDQ1pXNys2czVvRG5l?=
 =?utf-8?B?ZmhINzlIVmI2YWdsVGcrVXZZZUc2VnNvSFNlVWJ1NWk4aEFCN3lJb3V4bzAv?=
 =?utf-8?B?ajBiNE5kbDljQjNiOGxrbTdiZVFNRDlPclYya2Yxb0h1SUs2TzhPK0daL2hS?=
 =?utf-8?B?aGhVZEZaTnVqSEJlbjVqQkNBcEI0V3g4T2ZLTDd6Q0hQZUhkdm1VeS9GMnk3?=
 =?utf-8?B?N3dUSUY4Ulk1TDZTUGwxWE1nZFZGem11cjdJKzlXODg5SXovRFZWaDFybktt?=
 =?utf-8?B?T0ZBTnB6VzhITzYxY0NwMlp3eU9TZnFLNThtYitLdmJZVDdNM01UTVkzUUdO?=
 =?utf-8?B?cGpra0ZTOUg4YlZSbTRvRDZtQmxzOU04aTdzSkRac2UzWDQzZXFJVlJUdVZ5?=
 =?utf-8?B?RTE5UkhCaytoNUZkeGhxenFnQlEzdlE5N3FDd1Y3WDV4NW91L3hZV1kvcU5I?=
 =?utf-8?B?eGUwT1VVRkpLdjhRQk5iV3RRdjF0M2xkZGN0TDFwK21KZ1h3cXdDRDNnMUdC?=
 =?utf-8?B?TXJWTjhNR3dGdG02dUNyOWdwcVU3VTI3QnVTcWR1S0ZNMnJiTXdRNTlJekJr?=
 =?utf-8?B?azR2TGh4WFhnQkpOS2RlMjc2d2lEWmtzbStYNjJpMy9zQWhJcS9TV042NWdE?=
 =?utf-8?B?bTBjN3VadHQreTZ5UWNrWndyOEJwQnorMnF4Q2RhV2drZEdrMStsQ2d2QXlG?=
 =?utf-8?B?OGF1RHZscmtrdHhJT0FTK25ZTHVvL0lrV3I1VDB4dlp2cnJjZlpJMGF0bWtG?=
 =?utf-8?B?a00vdU04eVU3cjdzOC9NUTBaUnQ3MkgvQUthK2VlamhHdEpXNkxFL3ZleXlY?=
 =?utf-8?B?SU9DcGNvSEhlYlhzTVR1WXVTUGQwdHN6NjFzTmhNUmhKTFU3aVpaTUhhNlZR?=
 =?utf-8?B?YkdYcFZJSVoxK0RKcURRUzAvalpVOTJlSVd3TDE5MEJGYWUybGx2TFJFUGlU?=
 =?utf-8?B?c1lLZ3d2TTg1T3lZekdHV3psWTFwSFFDVmM2VnBQcHVhSU45aEE0N1oxczVQ?=
 =?utf-8?B?Z3hXQVRzTzZEV1BKY0F3NFhUT0h6TTNjd28wd1k1S2Erb2ZUekpSY2RLV0M3?=
 =?utf-8?B?VUZCeVhMR1lEV3Q0K1RlaUNRZExHVnJ6cnd5cG94ME50UFBCQXJMM1h3Y29x?=
 =?utf-8?B?SjBCdEtKK3hTNkQrRmszSmVpR01DbUZPODhiRnIrWFVLVjBBSFQrNE5yb3E2?=
 =?utf-8?B?UzFrMmx2WGNBSlRUVWZPREd3VVJuUFpoY2xhZEdJbGpSNmltSjFiQkZiYmNE?=
 =?utf-8?B?QXNldFJOTUV2NWtLaHBaTjJxb2lPRDFyb2k1QkQ4L1puT1dXR0ZsSW1DbkdO?=
 =?utf-8?B?SlRvRVliOVJ2b0E3djNsbWFlUTZHNlZMc2JtWFhjbi9rams2Q2NxK010TFlH?=
 =?utf-8?B?c3RubmFjVmQ5MzdPeitqZGRpNjV6MnpNRUF1QTIrYWtLUk02UnRNRjdnRGNM?=
 =?utf-8?B?Q2JSdi9MWlF1dDkxaFlRSUQ3UXRJL0llWVVOY2dLdGdtZzJCL0ZoTmVaRWpp?=
 =?utf-8?B?SHNjUHVBcDd2MlRRb05aZWx3VjVrd2Rva0l3MVF6WkpxS1dXZzAvWGV0Sm1R?=
 =?utf-8?B?L1p6ZkppaWxvWUx5a2Z0aUxZMklxOHNodXdlUE1ySlVENnhDT1RRVEVqckFO?=
 =?utf-8?B?b3hOMklWanVsMDhmNmlSVlBnR2g5bHRid09LdktuRFJVZkl0cjk4WFNrWHdn?=
 =?utf-8?B?WXpud1lmQk55WVEvUjd6NktWK3ZKZ0R4dVFmaWM4TFZNdFM2VENBQnB0OGlE?=
 =?utf-8?B?SGcvc1kxZHlxTklSSnZsZ05CMkJFM2tlemJ4K0tVTWw2ZmI1cGFVSTNkZzhD?=
 =?utf-8?B?Tm1CRGd5Q1pibFUzS0U2YkdHVGFaQ21KczI0WnVvYTZVK1krM1Nwd1hWMVRX?=
 =?utf-8?B?NWhzc3JORjhXYzJnZUdkc2FveWorZXU3Q1JsVGhLNERQbEc3dWt6RjVNZnBF?=
 =?utf-8?B?UUFDOHljN1pBME1NeTZUSWZ6UEJxQUVHc0J2aVRrN3MyQ2pXYTUxZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 80b08e55-a2fa-4755-973e-08da2d212205
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2022 16:22:35.3996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DBCDrnu4e9ysh9qZV/IGR9jxFGYdGIyvB0QNiZwyyckA1ogfyrWgILsvNpM3o7Q/Xw2kURffRyASZntDRdfxZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR84MB1793
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: 5Xz73IaouY4oWN-cjZ_mCSWuhIznRd8r
X-Proofpoint-GUID: 5Xz73IaouY4oWN-cjZ_mCSWuhIznRd8r
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-03_07,2022-05-02_03,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 priorityscore=1501 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0
 clxscore=1015 lowpriorityscore=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205030109
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNS8yLzIyIDEzOjQwLCBuaWNrLmhhd2tpbnNAaHBlLmNvbSB3cm90ZToNCj4gPiArI2luY2x1
ZGUgPGxpbnV4L29mX2FkZHJlc3MuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L29mX3BsYXRmb3Jt
Lmg+DQoNCj4gV2hlcmUgYXJlIHRob3NlIG9mXyBpbmNsdWRlcyB1c2VkID8NCg0KVGhleSB3ZXJl
IG5vdCB1c2VkIGFueW1vcmUgd2l0aCBsYXRlc3QgY2hhbmdlcy4gVGhhbmsgeW91IGZvciBwb2lu
dGluZyB0aGlzIG91dC4gSSB3aWxsIHJlbWVtYmVyIHRvIGNoZWNrIGluIHRoZSBmdXR1cmUgZm9y
IGVhY2ggbmV3IGNvbW1pdCB0byBkb3VibGUgY2hlY2sgdGhpcy4NCg0KPiA+ICsjZGVmaW5lIFdE
VF9NQVhfVElNRU9VVF9NUwk2NTUwMDANCg0KPiBTaG91bGRuJ3QgdGhhdCBiZSA2NTUzNTAgPw0K
DQpZZXMgaXQgc2hvdWxkIGJlLiBJIHdpbGwgY29ycmVjdCB0aGlzLg0KDQo+ID4gK3N0YXRpYyBp
bnQgZ3hwX3dkdF9zZXRfdGltZW91dChzdHJ1Y3Qgd2F0Y2hkb2dfZGV2aWNlICp3ZGQsDQo+ID4g
KwkJCSAgICAgICB1bnNpZ25lZCBpbnQgdGltZW91dCkNCj4gPiArew0KPiA+ICsJc3RydWN0IGd4
cF93ZHQgKmRydmRhdGEgPSB3YXRjaGRvZ19nZXRfZHJ2ZGF0YSh3ZGQpOw0KPiA+ICsJdTMyIGFj
dHVhbDsNCj4gPiArDQo+ID4gKwl3ZGQtPnRpbWVvdXQgPSB0aW1lb3V0Ow0KPiA+ICsJYWN0dWFs
ID0gbWluKHRpbWVvdXQsIHdkZC0+bWF4X2h3X2hlYXJ0YmVhdF9tcyAvIDEwMDApOw0KPiA+ICsJ
d3JpdGV3KFNFQ1NfVE9fV0RPR19USUNLUyhhY3R1YWwpLCBkcnZkYXRhLT5iYXNlICsgR1hQX1dE
VF9DTlRfT0ZTKTsNCg0KPiBGaXJzdCwgdGhlIGFjY3VyYWN5IG9mIGFjdHVhbCBpcyByZWR1Y2Vk
IHRvIDEgc2Vjb25kLCB0aGVuIFNFQ1NfVE9fV0RPR19USUNLUygpIG11bHRpcGxpZXMgdGhlIHJl
c3VsdCB3aXRoIDEwMCwgbWVhbmluZyB0aGUgYWN0dWFsIGFjY3VyYWN5IGlzIDEwbXMuIFdoeSBu
b3QganVzdCB1c2UgMTAgbXMgPw0KDQo+CWFjdHVhbCA9IG1pbih0aW1lb3V0ICogMTAwLCB3ZGQt
Pm1heF9od19oZWFydGJlYXRfbXMgLyAxMCk7DQo+CXdyaXRldyhhY3R1YWwsIGRydmRhdGEtPmJh
c2UgKyBHWFBfV0RUX0NOVF9PRlMpOw0KDQpJIGhhdmUgcmVwbGFjZWQgdGhlIG1lbnRpb24gY29k
ZSB3aXRoIHdoYXQgeW91IHJlY29tbWVuZGVkIGFib3ZlLg0KDQo+ID4gKw0KPiA+ICtzdGF0aWMg
aW50IGd4cF9yZXN0YXJ0KHN0cnVjdCB3YXRjaGRvZ19kZXZpY2UgKndkZCwgdW5zaWduZWQgbG9u
ZyBhY3Rpb24sDQo+ID4gKwkJICAgICAgIHZvaWQgKmRhdGEpDQo+ID4gK3sNCj4gPiArCXN0cnVj
dCBneHBfd2R0ICpkcnZkYXRhID0gd2F0Y2hkb2dfZ2V0X2RydmRhdGEod2RkKTsNCj4gPiArDQo+
ID4gKwl3cml0ZXcoMTAsIGRydmRhdGEtPmJhc2UgKyBHWFBfV0RUX0NOVF9PRlMpOw0KDQo+IERv
ZXNuJ3QgdGhhdCB0cmFuc2xhdGUgdG8gMTAwIG1zIHRpbWVvdXQgPyBXaHkgc3VjaCBhIGxhcmdl
IHJlYm9vdCBkZWxheSBpbnN0ZWFkIG9mIHdyaXRpbmcgMSA/DQoNClRoaXMgaGFzIGJlZW4gY2hh
bmdlZCB0byAxLg0KDQo+ID4gKwlneHBfd2R0X2VuYWJsZV9yZWxvYWQoZHJ2ZGF0YSk7DQo+ID4g
KwltZGVsYXkoMTAwKTsNCj4gPiArCXJldHVybiAwOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0
aWMgaW50IGd4cF93ZHRfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikgew0KPiA+
ICsJc3RydWN0IGRldmljZSAqZGV2ID0gJnBkZXYtPmRldjsNCj4gPiArCXN0cnVjdCBneHBfd2R0
ICpkcnZkYXRhOw0KPiA+ICsJaW50IGVycjsNCj4gPiArCXU4IHZhbDsNCj4gPiArDQo+ID4gKwlk
cnZkYXRhID0gZGV2bV9remFsbG9jKGRldiwgc2l6ZW9mKHN0cnVjdCBneHBfd2R0KSwgR0ZQX0tF
Uk5FTCk7DQo+ID4gKwlpZiAoIWRydmRhdGEpDQo+ID4gKwkJcmV0dXJuIC1FTk9NRU07DQo+ID4g
Kw0KPiA+ICsJZHJ2ZGF0YS0+YmFzZSA9ICh2b2lkIF9faW9tZW0gKilkZXYtPnBsYXRmb3JtX2Rh
dGE7DQoNCj4gSSdkIHBlcnNvbmFseSBwcmVmZXIgaWYgdGhlIGFkZHJlc3Mgd2FzIHBhc3NlZCBh
cyByZXNvdXJjZS4NCg0KSnVzdCB0byBjbGFyaWZ5IGZvciBteSB1bmRlcnN0YW5kaW5nIGFyZSB5
b3UgYXNraW5nIHRoYXQgaW4gdGhlIGRldmljZSBzdHJ1Y3R1cmUgSSB1c2UgdGhlICJ2b2lkICpw
bGF0Zm9ybV9kYXRhIiB0byBwYXNzICJzdHJ1Y3QgKnJlc291cmNlIj8gSWYgSSBhbSBpbmNvcnJl
Y3QgaGVyZSBjYW4geW91IGVsYWJvcmF0ZSBvbiB3aGF0IHlvdSB3b3VsZCBsaWtlIHRvIGJlIGRv
bmU/IEJhc2VkIG9uIGZlZWRiYWNrIGluIHJldmlldyBmb3IgdGhlIGRldmljZSB0cmVlOyB0aGUg
d2F0Y2hkb2cgaXMgYmVpbmcgY3JlYXRlZCBhcyBhIGNoaWxkIHRvIHRoZSB0aW1lci4gVGhlcmVm
b3JlIHRoZSBjb25jbHVzaW9uIHJlYWNoZWQgd2FzIHRoZXJlIHNob3VsZCBub3QgYmUgYSBneHAt
d2R0IGxpc3RlZCBpbiB0aGUgZGV2aWNlIHRyZWUgZmlsZXMuIEkgdG9vayB0aGlzIGltcGxlbWVu
dGF0aW9uIGJhc2VkIG9uIHdoYXQgSSBmb3VuZCBpbiBpeHA0eHhfd2R0LmMuDQoNClRoYW5rIHlv
dSBmb3IgeW91ciB0aW1lIGFuZCBmZWVkYmFjayBHdWVudGVyLA0KDQotTmljayBIYXdraW5zDQo=
