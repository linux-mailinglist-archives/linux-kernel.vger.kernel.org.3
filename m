Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9385894F6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 01:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238575AbiHCXme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 19:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236105AbiHCXmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 19:42:31 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137855C9E9;
        Wed,  3 Aug 2022 16:42:30 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 273MwD9G004962;
        Wed, 3 Aug 2022 23:42:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=oKqwUu95eUCxcCVlMpC9gyCxtRZWRnz5w1tUBka1APU=;
 b=wjlgFR+oX6kFLsQWMr+FYcBS5vLZ9aUnx6W6vlCTFqEy1qYU1wt9FzgWu0QI/XQe/cGf
 IFkUC9MW4sQ4y1G0ru0n9Wcmp+yJzza5DKJum8+l/o7QsUTiIQhYHXjwD/I7AdNmksmA
 2xhwLSvtwOudSXnm4jFpk/jHTluWtXTpPvYTChrXZgB2G+X97f9w8CmMrWqNU5lTux+t
 NfCdOBs8LvrBnRNabJk6wgO2/+2rwjLskOSzX9nuyFkAS9KGrgQqdAqhamIMSdrvwj5z
 ly7OQxkh0RFmJ7LH9nt+CD28xrTDN9XiYKZX2y3+V+jqfRwORy9gdcyJldz5p5sjE3YW Kg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmu813d3q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Aug 2022 23:42:24 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 273Kc4Mu008364;
        Wed, 3 Aug 2022 23:42:23 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2042.outbound.protection.outlook.com [104.47.56.42])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hmu33gp7e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Aug 2022 23:42:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WagMLrXh5WNsJnyt8R41XKVpXsKmjYBWeDVwnm/5jEyIVGLEAj0jgSmgt7Iv8h36E4MIu8croSQSRsszWme/5mbB99OVt8R40os1b5ckf7rhLDS23pk4B+dBMVLq7YxDcTibXVzCoeCJ/hdPZ3RiWUCjBwH7q2W11SNtuP3vjG2rQe7ARogj2M7wW3pf+3f849TNqjZcJMw5Paz42dO/vI+5jtNy5f+w2FF7lh+flY3vUTdstIU6l5kERjH4WHbobpWqQIx60Tzrq5YHf3Rd1nrzl9UtwNZvcAfRZw1NRqWyqNKR81ExxSgbDYbpISA/aBjeQHSuiARmUG1TOkstQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oKqwUu95eUCxcCVlMpC9gyCxtRZWRnz5w1tUBka1APU=;
 b=kK5MZ5j7mL7SztuT1fTooE32q1GApUDv+22elVp6uKbgD5pJ4Z2TWCxxAKqznRSTyakQJHPjh3rY0CeDADWedxjKhE3XXQLe4FSa9nzZKwwlzPJ9CkUHg+M8q2WaemOpJVbOAGX7Ak/cGcDyrrwGUqCTtwZiQ347GICOeku/l7V01uSgKRWb1ZEPovXDMnoDGdCGKQjDbhLPp3Cpf4R5oJWtZIvKr6r7C+g+qE/iEodgfhhRyHnTT/tgii7OLe3WBFUwPTZnGFjkTHxgvs2R/Wm6zchRgKUCUddTILCrc+A3SPkX68eKm9ycylOlPWBkiqSrz1sYoLF2yIaDeii9VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKqwUu95eUCxcCVlMpC9gyCxtRZWRnz5w1tUBka1APU=;
 b=e8DAWGZMv8vxn1qedqnUIEUzxDWscLSZ7Mli7667jjtycskYnmRaekHJx7Jg4aE0JNbHc4s9Vbvk6R0whgjunMxCW7yj7chQW2phsLQ2n1qCNuScc/cwlPCpnow9c6YcL5KQGU0RsHSe+juLyz5l6+lFehxZmrKqSIYvAIbBc48=
Received: from SJ0PR10MB4718.namprd10.prod.outlook.com (2603:10b6:a03:2dd::14)
 by DM4PR10MB6280.namprd10.prod.outlook.com (2603:10b6:8:bb::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5482.13; Wed, 3 Aug 2022 23:42:21 +0000
Received: from SJ0PR10MB4718.namprd10.prod.outlook.com
 ([fe80::c9cf:e83e:5a8d:49b6]) by SJ0PR10MB4718.namprd10.prod.outlook.com
 ([fe80::c9cf:e83e:5a8d:49b6%7]) with mapi id 15.20.5504.014; Wed, 3 Aug 2022
 23:42:21 +0000
From:   Sherry Yang <sherry.yang@oracle.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
CC:     Dave Chinner <david@fromorbit.com>,
        "dchinner@redhat.com" <dchinner@redhat.com>,
        Allison Henderson <allison.henderson@oracle.com>,
        "chandanrlinux@gmail.com" <chandanrlinux@gmail.com>,
        "bfoster@redhat.com" <bfoster@redhat.com>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] xfs: initialize error in xfs_defer_finish_one
Thread-Topic: [PATCH v1] xfs: initialize error in xfs_defer_finish_one
Thread-Index: AQHYpdlawwqDdT4esEyIG1VTh8VSnK2ahJAAgAITjICAAUGJAA==
Date:   Wed, 3 Aug 2022 23:42:21 +0000
Message-ID: <DB9D3780-165D-4E49-823D-4D5253E64905@oracle.com>
References: <20220801190311.65703-1-sherry.yang@oracle.com>
 <20220801204902.GA3600936@dread.disaster.area> <Yun6I/drpxG4L4RO@magnolia>
In-Reply-To: <Yun6I/drpxG4L4RO@magnolia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a03e545-fecd-4a65-eb0a-08da75a9cf87
x-ms-traffictypediagnostic: DM4PR10MB6280:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gqNsqcA7hOrgeb09nVQ0l0+5v71FzVfHwURl4VQD7a4zGGDHf+Y/R2ssNCZ3BaGK5KV45gRafgGNTWWgKD4b/fxSGjJvXvYmdLeUHVCnt9iLD7W7vfseNMcXxAoK/UFxTj6PkN11AHDQYRZqJGQImpuiGvfTYH/DR2ff788gN6yiR1DFB1LBRPS1lmeCzKE19wJw46fTjL5pdc7KdS/dIELnzggldZGWRKgj5HlJY1qeqtX3uvXbH4LgsPPhHg0tk+2YVK/OnjmsGMd4NUspM8WTKNE2nBpDCnPtftcXZQFdNK3xZN1kh6f2cNwg4+sUPYDlLwYIA7De4kuvjhuKC7sOVDovE1h8TiZFHVwQyMo+4TJoG+PVvf8dByeiVNytZCB+EIgVXzQW7cQnHGA212SPMtaEIOaPbkJXCribBYk0aejadgNN5ZqMYjfnKK31WCAQB1AUOYBO/YTfM6Jrj19gcwY6vKSjpcVcnhLxByBlXV3TyuWCqpXOYlPmY2o4mwttn2QVOy72eVN5Pcn9JYQwLHSxQ2GDX8L8JnyMWE5n0ix+wZpeNEm/UHNQLlj8fxTrxUgBPB3ZR/gng38w1ZFYw2ZlRPisc7gJAGf2tyIBJbc9GXwzFgFA0fCrqu+X296h9UK4MFhqssAJduc9doEBT4P382ZKG+GDwBGbPge7bm+CZ8g5EX3OJ7q2GwTBhIe5rGS48/sjCCQFdtNkv9xrv8Y8wNeRy2GWmxv3am9L4LPLybrYpwCPDIS6OdRlBhZ2Yde/uaQtsU3U5VT7dPx6xn/5BDAs0pq5tYZFAigB5+9hKIvqby1wucbkAuilwUI/MVWelos/xqMJb2tNyw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4718.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(376002)(39860400002)(396003)(346002)(83380400001)(66946007)(6916009)(76116006)(91956017)(33656002)(8676002)(5660300002)(66556008)(122000001)(2906002)(4326008)(38100700002)(6506007)(6486002)(186003)(54906003)(6512007)(66476007)(316002)(53546011)(66446008)(64756008)(36756003)(38070700005)(71200400001)(44832011)(2616005)(86362001)(41300700001)(8936002)(478600001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OUx2K2VpOHdhNGJpckM4eVlPOEtWbGVRUVF3aWNONmxWUFlLang0L08vTzFU?=
 =?utf-8?B?U2lPR3NqcythYjFsdjBBTU9Rd1pScXZraEZ3eURvaElDZGlYNVBUcHZITkVY?=
 =?utf-8?B?bXhWeEZhTnhuYm5WQnk0Y1hWL2cwLzE1Wk5xdnhyRXpJMWJwQVoxZnV4bGwx?=
 =?utf-8?B?R3F6bWw0ZUJiOE9adU4wa1habXlrS2RQdU52NStQY1ZKK0dFbEdUTE01cVBT?=
 =?utf-8?B?RHlrbDhDamthMko1aXZIUXd0NFpqSmcwTHJOR1VkbUNNUEFvS3hxd3hDYjBP?=
 =?utf-8?B?blZCd1VQQURURkF4bjRhTFUyRjR0Rkk3bFgxdGxtaG9INEZKTmJ5YUhsU2hP?=
 =?utf-8?B?UDRIYkpocnA1UTc1Z28zenEwSzBmUy9zU0ZkR1hJY09oOXpOUitBWE5Sdk5n?=
 =?utf-8?B?MU94OEhIMFlvYVpUZEhWeUMwa2xGNzAyNWg4c1JwQ3dtMzNqam9EQ3VlNlZq?=
 =?utf-8?B?R1pNN1d4T3djZG00YmVtWmFUdmFCV2FXc0w5aC94QUZvSGEweFNEdVhSWVF0?=
 =?utf-8?B?TWpJcTlEMVVjaG54Snlqek1WNEpWdmN6T2ZlRC8yeGhxWjZDRXF2YURXMUFK?=
 =?utf-8?B?U215dWIvRE9oSFdnbW1YRTJZVXZFSlRDRTR4S1IxeU9RWkhaUktFNC9UQmlx?=
 =?utf-8?B?K01SbWlvU1pEQXpFRFRoeWFkd1JkWUJVVVFMZldYNE5KSGhrWVdJUXpCMGs2?=
 =?utf-8?B?Y2VMVXJYc0hrM0xGSHVOZ1I2QTAwYlFtZit6SFoyYytnbWN3UEx2cW5KTlg4?=
 =?utf-8?B?OU1LcmxtTlRZdkoxRmZ1K29DdnJNNlZZa29EN2cvbCtPNStlNFNrSVpSS1Fn?=
 =?utf-8?B?c01od1p3dzRKbVkzcE1YdU5vWHVxV0lnejNBWUlNSHdmTERJL1dOQVJPOWhm?=
 =?utf-8?B?em1FbzRtTzJseFlSSTZFb1F2SnVwc3Y0Y0UreTBtNTgyR29wRUZCM3oxMk40?=
 =?utf-8?B?UllWcVJrMkJwTjd3TDNJQVVoS01QUjVBeUZnQWxtb2pRenNGRmliaVBhbmpp?=
 =?utf-8?B?VTR6WXBCMUQ0TTBFL09RTnFkdVdYVjJ3Mmx1OUVySnJhTTJMdHdTdm1oMVN6?=
 =?utf-8?B?ZmZXenBNOW80OUlPSzRZeVN5V2VHWlJuUjFYeE0walN6dHJpU2lJRGtleGpF?=
 =?utf-8?B?dkMrOU9KbDBqK0lsVWg4L285ajNvSWtFbzdzL3BXZGZKektkaWF4NStyeGhr?=
 =?utf-8?B?MnFhMW5pQlZRZFE0ZXVxcWNpSnQ0Mk9WQnBuYmxBZHVzeFlOWmc4bVkwVEI4?=
 =?utf-8?B?L0FJK3c1L1lYM2hnOWhtY29wTjNyS2YxNDR2OGRyV2lJakNJb3lFdzBwQlEx?=
 =?utf-8?B?b2lHRDNjTHJ5NTVWODdlZjQyVWd2N2FlTW14ekhGQ2NDNmtBaEs4SEtUaURN?=
 =?utf-8?B?QTYzNitVZzFKM0RHQU8xUUxtcGEya3J4ZjFnMUo1cDcwTmVZR3NvV2pwdjFs?=
 =?utf-8?B?NUh2UFcvUXJzYklveTY2cElTdENkQnlvanpsa1cva0hmaVB6L3F1Lzhsb0l0?=
 =?utf-8?B?SEM0bzR2VjFWaWpETzVUbUNwMC8zQ3BoQk1IcTZ4U0RtWE91WERnV3JDdG1k?=
 =?utf-8?B?bWlGN05wMGs5dHBzK1RVR2ZwQVVXK281Z2JnUy8vTDJuUm5SOVpxQ3B1TXRF?=
 =?utf-8?B?cnNHbmdTdlZiVS9CNFEzK283RkFSNWVFVTJzZ3dDdFRCQjdiQXR3cWFuNFNt?=
 =?utf-8?B?VGpjZDFkNktsU2s5SDNtSkt4ZjNSbCtrcXVSQjdtMmdiVnRyRWc0NmNnMkJs?=
 =?utf-8?B?Vi96aitJN1k4RzhDT2tYNHoxdTM3d2pTdWJ6ZTJFdHR0dmdmVkVUNzVEWDQ0?=
 =?utf-8?B?a2s4b1FQZ3crQWxTaUtmK3VBeWNPeiswQnFFcElZSmpYUkVGUFd4dTlZU09I?=
 =?utf-8?B?MWlxSzNpVFBxWHhhYXozMWtKSVJCaXhYNEdra2tWTjdYb2krMDRWanVDQzJ4?=
 =?utf-8?B?S1FKMVVWRFJLMDZGR0R6anBZMEZVY0lsWm9pNlpYQlhudnZDVVM4aHU5VGtN?=
 =?utf-8?B?TlNtOEYrMnBUUVdqRGlxaTFBUFh2eVRkQTUrc1Q3RnQzc09iWkZXUS9BeFlF?=
 =?utf-8?B?OWRPcVZla3AxazFxMGRDRi9CQzJNSzhpc1ZUQVFBNTRPZythUGRicmZBdGhS?=
 =?utf-8?B?ZU1BVno4RVh5SSsyYms3N2tIKzhKV3lrNEdHbEZHTWxEWGFpY0MxcWZXTFgy?=
 =?utf-8?Q?4/Jcucjsfp55lPm87tw4IB4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <03375F42B9860F40AC186D6E37E1AFEC@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4718.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a03e545-fecd-4a65-eb0a-08da75a9cf87
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2022 23:42:21.7904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pFdbrSo1Wqper1O508uRiUnpadAgHT7HogxPpxECewKvYAnfbf5jIIDyU6L5eCOAzuqFuhLKxBFDLOFzslO2Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6280
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-03_06,2022-08-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2208030100
X-Proofpoint-ORIG-GUID: oc5dMOAUnSvqCm6LThgOfvRojTyDQ_8q
X-Proofpoint-GUID: oc5dMOAUnSvqCm6LThgOfvRojTyDQ_8q
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IE9uIEF1ZyAyLCAyMDIyLCBhdCA5OjMxIFBNLCBEYXJyaWNrIEouIFdvbmcgPGRqd29uZ0Br
ZXJuZWwub3JnPiB3cm90ZToNCj4gDQo+IE9uIFR1ZSwgQXVnIDAyLCAyMDIyIGF0IDA2OjQ5OjAy
QU0gKzEwMDAsIERhdmUgQ2hpbm5lciB3cm90ZToNCj4+IE9uIE1vbiwgQXVnIDAxLCAyMDIyIGF0
IDEyOjAzOjExUE0gLTA3MDAsIFNoZXJyeSBZYW5nIHdyb3RlOg0KPj4+IFBhdGggdGhyb3VnaCBu
b24tdm9pZCBmdW5jdGlvbiAneGZzX2RlZmVyX2ZpbmlzaF9vbmUnIG1heSByZXR1cm4gZXJyb3IN
Cj4+PiB1bmluaXRpYWxpemVkIGlmIG5vIGl0ZXJhdGlvbiBvZiAnbGlzdF9mb3JfZWFjaF9zYWZl
JyBvY2N1cnMuIEZpeCB0aGlzDQo+Pj4gYnkgaW5pdGlhbGl6aW5nIGVycm9yLg0KPj4gDQo+PiBJ
IGRpZG4ndCB0aGluayB0aGlzIHNpdHVhdGlvbiB3YXMgcG9zc2libGUgLSBob3cgZG8gd2UgZ2V0
IGRlZmVycmVkDQo+PiB3b3JrIHF1ZXVlZCB3aXRoIG5vIHdvcmsgaXRlbXMgb24gaXQ/DQo+PiAN
Cj4+IElmIHdlIGNhbiByZXR1cm4gYW4gdW5pbml0aWFsaXNlZCBlcnJvciBmcm9tIHhmc19kZWZl
cl9maW5pc2hfb25lKCkNCj4+IGJlY2F1c2Ugb2YgYW4gZW1wdHkgcXVldWVkIHdvcmssIHRoZW4g
c29tZXRoaW5nIGVsc2UgaGFzIGdvbmUgd3JvbmcNCj4+IGVhcmxpZXIgaW4gdGhlIHdvcmsgZGVm
ZXJyYWwgcHJvY2Vzcy4gSWYgdGhpcyBjYW4gYWN0dWFsbHkgaGFwcGVuLA0KPj4gdGhlbiB3ZSBu
ZWVkIHRvIGZpeCB3aGF0ZXZlciBpcyBjcmVhdGluZyB0aGUgZW1wdHkgd29yayByYXRoZXIgdGhh
bg0KPj4gcGFwZXIgb3ZlciBpdCBieSBpbml0aWFsaXNpbmcgdGhlIGVycm9yIGJlaW5nIHJldHVy
bmVkIGZvciBlbXB0eQ0KPj4gd29ya3MuLi4NCj4gDQo+IC9tZSBiZXRzIHRoaXMgaXMgYSByZXNw
b25zZSB0byBhIHN0YXRpYyBjaGVja2VyIHRoYXQgZG9lc24ndCBrbm93IHRoYXQNCj4gbGlzdF9l
bXB0eSgmZGZwLT5kZnBfd29yaykgPT0gZmFsc2UgaW4gYWxsIGNpcmN1bXN0YW5jZXMuICBJdCdz
IG5vdA0KPiBwb3NzaWJsZSBmb3IgdHAtPnRfZGZvcHMgdG8gY29udGFpbiBhbiB4ZnNfZGVmZXJf
cGVuZGluZyB3aXRoIG5vIHdvcmsNCj4gaXRlbXMuDQoNCkhpIERhcnJpY2ssIA0KDQpZb3XigJly
ZSBjb3JyZWN0LiBUaGlzIGlzIGEgZmFsc2UgcG9zaXRpdmUgYnVnIGRldGVjdGVkIGJ5IG91ciBz
dGF0aWMgY29kZSANCmFuYWx5c2lzIHRvb2wuIFNvcnJ5IGZvciB0aGUgbm9pc2UuDQoNClNoZXJy
eQ0KPiANCj4gLS1EDQo+IA0KPj4gQ2hlZXJzLA0KPj4gDQo+PiBEYXZlLg0KPj4gLS0gDQo+PiBE
YXZlIENoaW5uZXINCj4+IGRhdmlkQGZyb21vcmJpdC5jb20NCg0K
