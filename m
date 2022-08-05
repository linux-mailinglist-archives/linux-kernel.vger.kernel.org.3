Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D99558B107
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 23:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237041AbiHEVOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 17:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241146AbiHEVO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 17:14:27 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB055E316
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 14:14:26 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 275KnXe8024449;
        Fri, 5 Aug 2022 21:14:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=1AmLz86q9FBPnkOu6KL2T0h+MDeW5ks1xfSa60ltcHE=;
 b=ripTrjNksqa/uqeKTujneLYLhNupQqAzcG7CD6FKCiQmmM8uQl4/exneFdXgEFojOsJ8
 DhOGtFnQiSC4cpROKgksWhl7WCBvSUWSy8UGTFVW2rdJ3Bpi3jlHyJ3FNcU1+jSs0RvR
 0QeoB8cOlMrPE0mCLGZFfe8KPkB/+IOut55R63cBopu8v3Z77UD9LJNddLrQZyBjXFO2
 i6ZAr1akyOH0Uw2VDd8kpr5XzMVV1rdp1m3Cy37DffhOV2N+1+orSMss15Td/lKIHBp1
 9pNZGxsj4a7d8nqMWoP03mxthTADhu7ZwfLyvYAn7u71V54+sJEiXiOmFOgZ7Ed0VnTx yQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmvha0f0n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Aug 2022 21:14:21 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 275KvtJc006871;
        Fri, 5 Aug 2022 21:14:21 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2047.outbound.protection.outlook.com [104.47.51.47])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hmu35gap5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Aug 2022 21:14:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JqLN8HIHYpwBVqO1PnpoWcLegeRXG7YeyMFCRl+lqCfc3StHSW/uC9HQwZYny9z4hlv6EveadtkabQQeAIemxBONCMfLwk79z66mr6d7Xiiz2TmKrxtBn3+BPkSJPNOtHyRQiwx9tzrORF0bqCJydEtzSF3lEk53ouYxifp0fqYQXdGnLcPHx/2PzwiSEiewDCqLX4VQPuu9wQKyDruWaCLjbjPXW396GmnaYL3T0vDR6RhDFofcNAd04bA5c5qtL0oNWbT3AFuY26yO2kAWCvjNeOakQibwCST4dWEL7ZQ5FxhVQoGyDW8DrdgFC1/9hh9nUNWWV2KwmfKcAVSQ6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1AmLz86q9FBPnkOu6KL2T0h+MDeW5ks1xfSa60ltcHE=;
 b=ZH77DbcCc0EXpZwO95gGMhS1Be0HOPilssg14tg+pjwG433mvn94+7NWjpZuyt56EiBU28qgc9lslh+MyWeUIBFKv6HG5TRGQWADFXd7VlSZoE2/eg53GrJBnlEkCqmjQysr65+9WgIB1llXcc8BxxtD8JjGjG0aDJrN0vU49yDNcscx8984pU9ekWgioMcaf2cUhU1khB83Js8ChmNbN6vXa9003q7z3z5tRH1cC3U11vCzT0YeZjgHAByLKHnauwPvZQacFaZXgKAnneyqPsimU8ZNPJBRTwsecvENC5q8Lwfloa/UNmFMT9mi3PTI9CS4B7S1ZOeQ1PUF/+My4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1AmLz86q9FBPnkOu6KL2T0h+MDeW5ks1xfSa60ltcHE=;
 b=YT9IKAmtkXqZe2sh6AJUkGzIF8ydXz+d6s8iEBJV317ToMKh/M2q+NrjtoO+oPEMJaN8gPBdM5izSIHAo0/9qQQzaOGrJRR1lElxYb1TFYUyG0IPCA0Ymx+i90inv4eJ2H3yTAsEzLqsJqZFoIsCd4tUFdFsfaEZUDgZ+WwJOTk=
Received: from SN4PR10MB5559.namprd10.prod.outlook.com (2603:10b6:806:202::16)
 by PH7PR10MB6227.namprd10.prod.outlook.com (2603:10b6:510:1f0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.23; Fri, 5 Aug
 2022 21:14:18 +0000
Received: from SN4PR10MB5559.namprd10.prod.outlook.com
 ([fe80::1c9e:630c:a63f:fdf]) by SN4PR10MB5559.namprd10.prod.outlook.com
 ([fe80::1c9e:630c:a63f:fdf%3]) with mapi id 15.20.5504.016; Fri, 5 Aug 2022
 21:14:18 +0000
From:   William Kucharski <william.kucharski@oracle.com>
To:     "alexlzhu@fb.com" <alexlzhu@fb.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH v3] mm: add thp_utilization metrics to
 /proc/thp_utilization
Thread-Topic: [PATCH v3] mm: add thp_utilization metrics to
 /proc/thp_utilization
Thread-Index: AQHYqRBThWx3+ROj9kK56+lh+SclzA==
Date:   Fri, 5 Aug 2022 21:14:18 +0000
Message-ID: <6210179C-4DF8-4C32-9735-3EB1495CDB3D@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3729.0.22.1.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f9f1634f-e8ba-44b1-5909-08da772775af
x-ms-traffictypediagnostic: PH7PR10MB6227:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R7m7XPf2lKGa1QYEhQqwlig6Uj5wy8+RAOnM7HPsKVL5IxGWMpVCnc7fUoaPatN1ScRXXdZqZWmOLPBvUXIOZxqvZ9PC2oLufYuArskWo8TrUCtjSGczIn0JFeHxXPeNod1LS7q/3ZI3OVUQCX8LXV3Oe43npDtM09Znncfjv5L6jtV8UDPRUWeX0oCjXmI8q65Yp4hU4ZU8fxcufqlQ/fUy0TS++2RAgJ/jlJEpnBFetMsEr5eKWUlpIGJU007UFjYyBjECIDHF/0nzQWJJvpn3ggX4R7M76aDDWfAHc3rznUhhpO3PCD0HNGHBjHFpgS9BX4jMswd1IzUXKbXQPoO+ShPFlu+WgGS1WmbHCthQKEjGfUiBY/ub2jKAWegeGzp4zOgN5M0CHr01ceN1xOUkdFv8sWN1YujFXh1IbYH6MbjTwuz3ufuGbDw0k2cnRnZtoyWgD5cYJbHXHPaeeUUWvdiRjyZ7Iu6kv66uJLGcmqO1DLYcXIxeBqHCLVqIgpyofCGHe79t0YQwrqpaZRw71ttIr6lo6sYg9sscV9UMrmj2JoTjZU91DmgS8YOR4+57Q0st48xFfjmFddUJdj8wbDtroxavHHHTrEFf3p1D3dcreCCd7eS3ph3+cJmU8DNnhXHqIVjDYh++jM4hSC9Ef0r0i5+2o3lFR7LpG5jhZmJ7So9BuAAnHwAyX5gjI72YgFBJuEf2ggmFHATpv1BW9wz6SOYQvZyyqjLjfiWh8ivlsqiplD8O3NCG3v96YRHeqR9B9PkdvAn1/9j8P4fjAmgceJUxBI7vZefx54Hv4IaQ9FQahw0yHMxRyQ6iJH4HYcnZEK1aLdOyd5XicA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR10MB5559.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(346002)(376002)(366004)(396003)(4326008)(66446008)(6512007)(66476007)(91956017)(44832011)(64756008)(86362001)(66556008)(8676002)(186003)(76116006)(5660300002)(38070700005)(6486002)(6506007)(478600001)(53546011)(36756003)(66946007)(8936002)(2616005)(4744005)(83380400001)(6916009)(316002)(54906003)(122000001)(41300700001)(38100700002)(33656002)(2906002)(71200400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NWwrL1huWGxrZTFiMVQzc2JJUXJiZGlxZ1dEMWlBcDduR1oySUZhNzVUb0pS?=
 =?utf-8?B?T1ZJbDA4Sm5EZGZ3VVVSd2FsbXYrYXlxTUtTZE52NnVCNDR4VzRDelVwOXZk?=
 =?utf-8?B?aEhsNExoQ0RxNDF3c2cvQnhWM28zRlZRUWZmY1JFdkFHdVVZVGhZQ0RHT0VF?=
 =?utf-8?B?Q21razFXZktNbHhTUmZMQis0RWszSmxUdFFCbTBsOWtaVWtaTCtUK1IyTHF2?=
 =?utf-8?B?bk9ndHpldmZyTWpndDFtS1BjbXdUdEt6TTB3WHMrNGZYV0dwSGU5TCtIRUxJ?=
 =?utf-8?B?QmppZmlNTEdNSEtqaFpXTHo5WXB6Z2ZkQzBiSDZDWkpMVVVyYnp0SE5zeUI2?=
 =?utf-8?B?MVNRUEVZNTdLV28vSEl3R1lWYStVKzl1UVowc3Fmd2c1SGNyaGRpcjlzQVhl?=
 =?utf-8?B?eUpPQ3JjaEpTVmJVejNpYXpKSnlxcmtKbFZ5MHJZK1pqaUd2TlVFUnM3ZEdr?=
 =?utf-8?B?WkhsWVBGNGEyVm5GOFlZOTZZZDRVUHMySjBOemNCdWh0WFRWMnl6a2lOc2tF?=
 =?utf-8?B?RnI1QzdGeVVGQk1FVzNWRHYvR3prQXIvMjVYWDVQV2xaOVB2VDltd0NMdzFN?=
 =?utf-8?B?eE1lRFhJbXYydnRVZFBPR3puL3ZzT3g4dWJyUkJZVXhzMnYzS3pTNEVib0kv?=
 =?utf-8?B?QmU4Z1pLY1g4Q1Ixd0JQV0FGeHlPME0xM2tSVjh6T0pHRE03NFNUalBUeVJy?=
 =?utf-8?B?WDBtRTRleW5kN0tNREJIVFRjYVB2cmtMVGlvU1h2VWZGMEUxaDByMG5BNDYy?=
 =?utf-8?B?N3hGeUFwWUlZTDdpazFwMm4rOStSbVhxZkhRNjBSeGRBQmc0MjJVRlZGN242?=
 =?utf-8?B?SDNZdU52U1k5d2wvTXE0ZUVQQVFsZXlTUmlYUkNlYU10QXc0WVJtaTdtbys1?=
 =?utf-8?B?QTlhRVYzZWFDVEZVZmJPRWJlZGFFU1liV2txUlZMMGNXaEswYXcyUE4xWm5h?=
 =?utf-8?B?L1pYWlZwUEdjK0Z3SGljWnh0RklnNWg2Sk1MUzcycUlEbG1vUHdLQjdta042?=
 =?utf-8?B?amRMelJlQ0dDRm5ERUIvZHo1SHI2UlowSUJLWGQySzZJV0RZaWpyRXlKMkVa?=
 =?utf-8?B?ZDZvL3VIK0tJb29oTlVBd3d1QVBaUUtRZzd6MzUxekpxSzhsWWpPUG41aDFN?=
 =?utf-8?B?azJZOVFxRnBvUjZ3Nzh2MmtFSXVwU0JBWnBuejJwS3J0UndBcEpJbWJqOHdl?=
 =?utf-8?B?ZUtsUG80UFhHb1pDWmhGdm9qaFQ4MHIxZkt4VFJsRGc3dk90REU5c2ZFeGZB?=
 =?utf-8?B?SFNZVGpQUEthOCtXUVFPNlh3dEt4eGp5MkNQWFQ3M1JvRnI1Y0J2NUlXM3V0?=
 =?utf-8?B?QVBtdjd2cm55SENEd0hyV0t3T3dtcmQ3dWVpZjkwbUNTclVlUjNRL0hOeFpo?=
 =?utf-8?B?Q25ZcXR1UjExZDBTaFRrWWw4REFsL1hRNjVqU1pmUXEvR2h1NDRvQjVUdldX?=
 =?utf-8?B?TnptK1NMcWRrN3hudW9JRi90eTVveWRuNlBzMnNUWHAySmQ1aTBIeURQV05Y?=
 =?utf-8?B?K3dsbWdYMGV2WW9JeDVzTWRQOG9HdnhUZHd2WUpHbFBQS3RjcC9HeVdPeEZp?=
 =?utf-8?B?RVFOcjBuY2hhNnM5cTFFOTVhUjgvdVdnbzFDWkpWeE1LZE5pUElmaHo2bkR4?=
 =?utf-8?B?V2o0aHpFRjNZd2hzZXN4SVBvZ3NPZUZPeGFBVXpTU0VMZmZOS0ZOSmd4eGt1?=
 =?utf-8?B?T1RmaWk4TndUY0cyc1paUmsyQWVobzZwaXNxQUtZak90eXZjQldKVStBMUV3?=
 =?utf-8?B?RW82a0tzZVIzVmdvbHB5U0x2UUhoR0ZqbFNRaXpoL3VOVmhsbmxFZEM2bVpK?=
 =?utf-8?B?QzhNWmxYQ2loTWRMeTFoemdtNXlMS25SMW1lUEY3ZFY4S0NuWTdXK3RLRjVn?=
 =?utf-8?B?KzhXWlpaVy9scExqck5mSXJIbVZIYWNMQjZGa205Z1hnenFDemNQT0V3VHEx?=
 =?utf-8?B?VlozQXlzUUNtaHRvTVhrSFZiRmNScDR4M1RmQWcyN01OcWFtS2c3SC9mdWow?=
 =?utf-8?B?UVI1SFVpR2gyYVc1bU4rbUE4Q1VRMkZnUWxsclRPY1NjS042bTIzamdyYWtB?=
 =?utf-8?B?TCtGUGRLVlgvTlg1clNBL3ByQzdQOGdiSHk0RkZUT0diSUFscUVpdU8vcVNy?=
 =?utf-8?B?aXR5bXZNbXNWMVlDd3JFS0RHSm5RVTdNV0ZjNWZyY2FiNVVCcENMNDR6bzRt?=
 =?utf-8?B?OUlCaHB0Mk5JQUYwZVFHdENqcERWd2NaZXdpRllNb2p3aHR5TGhMdE5oZXN1?=
 =?utf-8?Q?pRIbp5Go2x2tH+dVFC/jCbfTYXQZJBbKuhcr3+XBQ4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <05D2BC9118BF754AA8653A942988FF18@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR10MB5559.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9f1634f-e8ba-44b1-5909-08da772775af
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2022 21:14:18.7732
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0VBESi6pX/C5vL/Yl2Qqvo3HPa2XdQBXF6d4dT9OINLJsxZkjT1w+m4QH8VwoNts62Vtw7L9odecx44vqz8z8PzwZf/Yot8ulKAVfHtTQ0M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6227
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-05_11,2022-08-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=660 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2208050094
X-Proofpoint-ORIG-GUID: 34W-LqQAaxjVrrNVYmGAvAbqDZbiz7x-
X-Proofpoint-GUID: 34W-LqQAaxjVrrNVYmGAvAbqDZbiz7x-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KE15IGFwb2xvZ2llcyBpZiB5b3UndmUgc2VlbiB0aGlzIHR3aWNlLCBJJ20gaGF2aW5nIG1haWxl
ciBpc3N1ZXMgdG9kYXkuKQ0KDQo+IE9uIEF1ZyA1LCAyMDIyLCBhdCAxMjo0MCwgYWxleGx6aHVA
ZmIuY29tIHdyb3RlOg0KPiANCj4g77u/RnJvbTogQWxleGFuZGVyIFpodSA8YWxleGx6aHVAZmIu
Y29tPg0KPiANCj4gVGhpcyBjaGFuZ2UgaW50cm9kdWNlcyBhIHRvb2wgdGhhdCBzY2FucyB0aHJv
dWdoIGFsbCBvZiBwaHlzaWNhbA0KPiBtZW1vcnkgZm9yIGFub255bW91cyBUSFBzIGFuZCBncm91
cHMgdGhlbSBpbnRvIGJ1Y2tldHMgYmFzZWQNCj4gb24gdXRpbGl6YXRpb24uDQoNCk91dCBvZiBj
dXJpb3NpdHksIGRvIHlvdSBoYXZlIGFueSBzdGF0aXN0aWNzIG9uIGhvdyBtdWNoIG9mIGEgcGVy
Zm9ybWFuY2UgaW1wYWN0IHNjYW5uaW5nIG1heSBoYXZlPw0KDQpXZSd2ZSByZWFjaGVkIHRoZSBw
b2ludCB3aGVyZSB3ZSd2ZSBmaW5hbGx5IGJlZW4gYWJsZSB0byBzaG93IHByZXZpb3VzIGFkbW9u
aXRpb25zIHRvIG5vdCBlbmFibGUgVEhQIGR1ZSB0byBhIG5lZ2F0aXZlIHBlcmZvcm1hbmNlIGlt
cGFjdCBubyBsb25nZXIgaG9sZCB0cnVlLCBhbmQgSSdkIGhhdGUgdG8gc2VlIHN5c3RlbXMgb24g
d2hpY2ggZW5hYmxpbmcgVEhQIG5vdyB3b3VsZCBjYXVzZSBhIHBlcmZvcm1hbmNlIGhpdCBkdWUg
dG8gdGhpcyBzY2FubmVyLg==
