Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81CC58B0D6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 22:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240760AbiHEU23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 16:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235790AbiHEU21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 16:28:27 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E15A220F6
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 13:28:26 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 275KOGlF002269;
        Fri, 5 Aug 2022 20:28:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=6YfH2HzkeabwoBBixw2K906oneqWcuoO5NXiWm1mNFM=;
 b=Ypfgt5/gG5z0wLM+MhnrHfbWmPcNqSDW76rfywWjaNY3OGhDTvmcRgfN4njqUvLwwYBJ
 mHyvC0Kinz7GWhpUSz6BHQj+BH+t2PmyIwGg3/Qj3dd5y8CuhAPOoozTBuHezx3HM7NG
 qPGn9/BkKYOc68bT3CaVejYBYxSZ6Cc71m2kT6a6Q1jWNUZJhA270LkjLICvm6H4iD7x
 FkpLd0QUXAhuEeC9WIwMtpaivmCPuW2sIuXiWyjyK7ydZtO9/47pwDGsVP5RIx1gxXXl
 L0zEdcGI9VNKAs0iUlcVeRjTrmPWztjowssNENpGFpPaefER5+GzXa+60qxOPGogpn2a rA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmu2cgbqw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Aug 2022 20:28:23 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 275HIkfO010697;
        Fri, 5 Aug 2022 20:28:22 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2042.outbound.protection.outlook.com [104.47.73.42])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hmu35pqa4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Aug 2022 20:28:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WGcwJ4bLrYSzUoSo2zviE4n945ko1zuMN1ziBAKDWrehXwApfXV3UUWwkekdTGoOi2BzBPvDEXaz4OupoP8QeFJBfS7pwBY7jpqwxOdP2hgBBC8Kz5G/vdNGbi2wV4GMeL5r3k9hSOGGPahqN0wyGKKjWSSUQ/WQYY5uNbKAfOpCrzpXPSR4mLJI2OPv16NPeYDCNTUyeDI9RS4fFrhKwQaV8hXdhYsg4ZYgk4/zF+Z4d5A96CwDhvUr9QFEgM12lOYJw/tVrQpxxwiUIRu6WOHeZjjJ47f4u2zJtPU4zl1/dvp66HPWLYXSnEUPkOEgZcM0y38ByaUjnDAFIl1pDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6YfH2HzkeabwoBBixw2K906oneqWcuoO5NXiWm1mNFM=;
 b=m3yslWnROvK8alyTqOF3wXYyYRHdcdzOqdf2/7I1Uk3SD63MygL3kkxyCRB8E6T1YrmVggyTVuwCOYSatliwEOedyGi+H/qYkvnGyRqCV+pMuiZRRlBQ8VrmUzWppY+ctsraXD98DzsovxVLTgbnt4IqJAtrrNdY2nJ7fimKD0v3D8tU2YV8+x54/W0HtamqnDnoHDlbtSDFxu083YyqJNcpD3zZdzZbAXSsCk7rxWsl2TfarEEp8x38zcltMTM5G6CZrhv+nui8U6Uu/Qn2Vi5V2HY1L46Cz+RDRwfAgGkTXD4eNW3DihBURHCLfNnBdHEjQDXDu9MENMv89l87qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6YfH2HzkeabwoBBixw2K906oneqWcuoO5NXiWm1mNFM=;
 b=y/TQ5ZUbKlFi1AKSIQUcOlDQlJYb9MN6bdQsq+TkQTuz6S+SUii1aR2TIOls4XfnU3lYjwDXBSZp6hknoQoNCnzG7EK6di2vq22OoG7b5S83lUqJkOnwMDPzIgYed+pz4Qk3wZRoEXWPg+ShD2OqGtQ6yIqr1imSaBYqnkjkstE=
Received: from SN4PR10MB5559.namprd10.prod.outlook.com (2603:10b6:806:202::16)
 by SN6PR10MB2957.namprd10.prod.outlook.com (2603:10b6:805:cb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Fri, 5 Aug
 2022 20:28:20 +0000
Received: from SN4PR10MB5559.namprd10.prod.outlook.com
 ([fe80::1c9e:630c:a63f:fdf]) by SN4PR10MB5559.namprd10.prod.outlook.com
 ([fe80::1c9e:630c:a63f:fdf%3]) with mapi id 15.20.5504.016; Fri, 5 Aug 2022
 20:28:19 +0000
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
Thread-Index: AQHYqQnms2z5CDFxYkexQ8cYvFTgrw==
Date:   Fri, 5 Aug 2022 20:28:19 +0000
Message-ID: <70BEF411-33A1-4733-AE09-BE8486D2F8E8@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 826bda60-3039-4bb1-231f-08da772108f0
x-ms-traffictypediagnostic: SN6PR10MB2957:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l/hB8zENJsZy2b7G8MI4VC6jPmwOLjRU4vcM4TVH9SOCVGpRFPLNYYZQ9UOMUiNYmkz2BcX09tea5DScNCKZU/K2K6eKtE2B66YTg4F8iAyl9Ld8M9g3BcPpJdAYKTxtupTOUzYX2CoL7Ki/nas59xA8uom/PtoBv+9fJk5V5KrDLMZ3MSid1ywE9f7p5/X8Q+s6eVF69mdi+BhP69EKbBs3gn8dTqSxnDNaxS22I9MBymmoCusSyKLaEtPH3rcEbC3hJHhy41MKshzeLTWzWEAD5oOdiEyQDFbUKpNpm5VyFseVY0jKUFFpmNvIsFQ/0VMdmbdbk/namJQsWFStOZP3rl9xQUi3r19YB71N++zaUaq/2QUqK+yJeaHh5ip4EG+ymxgb7uFYoIMndfJ6bJzsGcfExcI6MTBa8FA4IqfBjl1R7KW/xQPLMmFptgS/Z/yyv5GYEvsQGy6+1pDVbYpUHo9zKWcfb/26eLj1VDcVi5UynwCzoKM2cP+PVhKwnjNSWBiAeIGdJThbLDm7WgMmZll9kOxC/SmvtZKRO5vTVmCrYCFzqJYqCNHv1VUe3c+eQjzgaMNKKPQNisnIW992I2zzP95TAivwZ+MMJkTkzx6BZDwDclLNcDITjYQjHDO6kXyMFfwDLYwC6+KGmikexAeDnUtxPWZBUeHlu6wygGdk6abPe743UR77oVDJsr6TgMU8A5pPeVSuoQsjLgoTy/BUDtC6Q4eTkLtg7d/9Wmrj+D/JfJgVfscllRqggOhff4W7QVsc4Cp7QcM2HJ6zvF6Z1Bqc4UEigAWm184VWJ8cRO69cgoi+bL7zxaXneIBAFMERv5LnOypo+6Irw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR10MB5559.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(376002)(136003)(346002)(39860400002)(6486002)(71200400001)(478600001)(41300700001)(86362001)(38070700005)(6506007)(53546011)(36756003)(6512007)(2616005)(316002)(6916009)(54906003)(186003)(83380400001)(8676002)(4326008)(5660300002)(64756008)(66476007)(66556008)(44832011)(8936002)(91956017)(76116006)(66446008)(66946007)(38100700002)(33656002)(2906002)(4744005)(122000001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?REQwWjRVVUc5Uld3M3R4eE5RajdPYVA5a3hPL2kwYStTaXgxaFI2cWFYN1M4?=
 =?utf-8?B?OFNaNkxDVlFydy9IbXJUOWpHbU1RV01KR040Y05zZnJOU1E3UnNRYlpCdGR4?=
 =?utf-8?B?bWRKOUxmbFVBZGVDbnZqQ2tkaG85ZU9WSWVubEZOWktNN1BKOFIyejBTNDZh?=
 =?utf-8?B?NjhlRDRXMXliVkZxRDBQRW1sOTNKUEc1WS9OYnZkbjB1U3pYWnptdGhxcllE?=
 =?utf-8?B?dy8yYmxpcWI4dkVJUkNLRC9BS0luTkV2R2J3ZjZUbkU4bzlLbU9vOEhJSDRw?=
 =?utf-8?B?MGIyclNJVFk1ZWJqMlhFSEpWaGFJcUpCOHdQREREWU9Jc2VqR1o1QVFnS1NI?=
 =?utf-8?B?VVBFalRTQ254Zk1RQjlDSDZiMWM5cUdyK2VMNkxOTHd5Z1FLb2dkS2l5Vll3?=
 =?utf-8?B?NndKRkpsZFRPcVZhUXZ6TVpXV2VvNkgrQnZTejdMeVBGU0xMV0NjY1pOenc5?=
 =?utf-8?B?cCtJMmNRSElHRlh2aEVNaVFsOUFEQmdsMDF1YzhIemZTRXRCY3d2ZGdrR2JC?=
 =?utf-8?B?Sm5IQUlxL2pZc2tuZEVYbUhzUjcrVDdzL0l6VnFUaUVXbmxpSkFTNjN2VHBu?=
 =?utf-8?B?bUdidUhZd3hMYmRKdGN3Y1dwTTd0WnNKWkpBRFRFVDNQMzF5aVdocVFHSzF3?=
 =?utf-8?B?S2VsWmZSc3ZOd2tqM2krT2YxemVnR3VoWkxQcFBwckZVNHRKYTNqL1JpbXJT?=
 =?utf-8?B?YUVuc080SU5SUWtBM00ybVY5QkhRc2JUbU83cFJOWjFOUTJtaFNzSHArS3Vj?=
 =?utf-8?B?Q3FvM2ZuTUtlVVU5dk8wMDZvOVhTcm5pZXpBNCsrYWJlWlZVWVlkU1c2VUh4?=
 =?utf-8?B?S3NzZGNuazBFUnM4a0dVTnowcEJ3UUE0Z2k0YXJKbkxtVm9ocFdVc0YyYnZq?=
 =?utf-8?B?UVlEY3VmcjBCZ2VIWWlrd0NjK1pzQVhHNWROSFZTamswUSs2OGRlOUY0Y3Vp?=
 =?utf-8?B?TVk0enRKTzhiOVRvQkxYMzhPdy9OYVNsZGpxTUJxQjJxNDEzVTBqTlRURzFh?=
 =?utf-8?B?aXFWUTJOS3hyN1RhT2l4Q3ZmNk5nb2hqMDJ3S2FSWTRDaDZyQzJkWW1ybmtz?=
 =?utf-8?B?OHgwdWtWd2dwRkhxbW1MSHJ5SFdqVEROZzV6NkJRRWhJWmVQcDBrTXJRRXVu?=
 =?utf-8?B?dzIrTldSRzNGRGNEVndtZ21YemViYnV3b1VkTWpsYmEwUEd4R05MR2NUbWlE?=
 =?utf-8?B?RkNhZ1RoYWREeEtqa3JjMEUydy9iUEVTQlRzeTFoUVpjWmlzWjBWdWtMMDJE?=
 =?utf-8?B?WGtUaHk2TEI2WFYrQ0s0bzc1VzNPRWZJeG1zcEs0WlZyWnVFTW5UNnNWcFFO?=
 =?utf-8?B?T1dwa093TzduU2lOWVAxeEZCMWUyYU5Zd2IyTEZxN0czUGg4L3duRW1handE?=
 =?utf-8?B?c3JEZmVhZ0NOdDB3UjE5S3pveHhMSDB6c0hibDNqU2hUT2pOWTVrZlFZSEl1?=
 =?utf-8?B?SkU3b0FheDQ3dWwxOCtZU3AwbEcvd1NrRmxVd0VxZ1pFMG9yQnJDN2dwZy9Z?=
 =?utf-8?B?ZHVtaFpqSlg5bUd3Z3d2djU2dnRMS2NaTUhFcXlGbjR0NEk4OVc0OVBIKzE1?=
 =?utf-8?B?NXJTdyt5WVFSVjNlazNCRDBES3ZFYlhua0g1VkdZdENFaUNXUng4d0dib21E?=
 =?utf-8?B?VFMrd2p3amthaDNZYWphQ0ZsS2QwQ0NmU0ZpY2hxT1ZNYk44TVRwZEhkaThO?=
 =?utf-8?B?Smx6Ymw1cWVaamZyQ01VdUg0RFlld3VSVWRIa2l0YUtleUliL3Y1WjhXeDVN?=
 =?utf-8?B?RmlrbFF3SFp6ZjIvVzFZSlpPTGxXSmpqS0dweDVweGtBUWI3RTBESitSR1VM?=
 =?utf-8?B?c1lFZ1JPdkxlZnRSa3F5cUtpY05pYUxjMUI4Tzk4Qlh5elA0ZFN0ZFU1aTF4?=
 =?utf-8?B?Z216S2FkeG54Q0tzemNTRTRORzZ1QlJsVHF5Zmxna09ja3ZQalN4cWF6aFlK?=
 =?utf-8?B?bnZ1T2RyZkNtZWxieEpTZUp3WXZQWWRmMXdkUGNrcXBXSVEvanRueUw0TlBW?=
 =?utf-8?B?SFE1SFhGUFdnYmsvRkZjY1lOMENhUWJpVkN4Um1QZUQvL0tLZEI3WG9VVjBL?=
 =?utf-8?B?K1VFVXlqYlRLUnVjS05CMmRqNktqc3htWTFrWTYwT25VKzM2enR0TDRkeENk?=
 =?utf-8?B?M29BNC9ZWHdGbmJ4ZCtqZlhKTWJMQlRQck13Yms5MmhyUSsxQ0JWRFAwRmxs?=
 =?utf-8?B?VmV4NHBlYlVWdjA4VmhaMlRWcXBSN0wyQTJpbWFyT3JscndyL3ROYTJ4RU5P?=
 =?utf-8?B?L25NYVZUcmhVTEJQMlVQQlBmemZRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9965960AFE61DA439E0001BCD978C57F@oracle.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR10MB5559.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 826bda60-3039-4bb1-231f-08da772108f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2022 20:28:19.3771
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g61hFZtnFawVDHcGyyW6zED75SZOI/YPup9ySaBhhaDjlOzeBAg6To21oO+2YxnsY+ORQolUD56g9NNRHnszYihqC12l93DCdubqLnkOFSQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2957
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-05_11,2022-08-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=557
 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208050091
X-Proofpoint-GUID: Uyi_NIKbD76-03sMBtCxZZKLzt-DKwW2
X-Proofpoint-ORIG-GUID: Uyi_NIKbD76-03sMBtCxZZKLzt-DKwW2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IE9uIEF1ZyA1LCAyMDIyLCBhdCAxMjo0MCwgYWxleGx6aHVAZmIuY29tIHdyb3RlOg0KPiAN
Cj4g77u/RnJvbTogQWxleGFuZGVyIFpodSA8YWxleGx6aHVAZmIuY29tPg0KPiANCj4gVGhpcyBj
aGFuZ2UgaW50cm9kdWNlcyBhIHRvb2wgdGhhdCBzY2FucyB0aHJvdWdoIGFsbCBvZiBwaHlzaWNh
bA0KPiBtZW1vcnkgZm9yIGFub255bW91cyBUSFBzIGFuZCBncm91cHMgdGhlbSBpbnRvIGJ1Y2tl
dHMgYmFzZWQNCj4gb24gdXRpbGl6YXRpb24uDQoNCk91dCBvZiBjdXJpb3NpdHksIGRvIHlvdSBo
YXZlIGFueSBzdGF0aXN0aWNzIG9uIGhvdyBtdWNoIG9mIGEgcGVyZm9ybWFuY2UgaW1wYWN0IHNj
YW5uaW5nIG1heSBoYXZlPw0KDQpXZSd2ZSByZWFjaGVkIHRoZSBwb2ludCB3aGVyZSB3ZSd2ZSBm
aW5hbGx5IGJlZW4gYWJsZSB0byBzaG93IHByZXZpb3VzIGFkbW9uaXRpb25zIHRvIG5vdCBlbmFi
bGUgVEhQIGR1ZSB0byBhIG5lZ2F0aXZlIHBlcmZvcm1hbmNlIGltcGFjdCBubyBsb25nZXIgaG9s
ZCB0cnVlLCBhbmQgSSdkIGhhdGUgdG8gc2VlIHN5c3RlbXMgb24gd2hpY2ggZW5hYmxpbmcgVEhQ
IG5vdyB3b3VsZCBjYXVzZSBhIHBlcmZvcm1hbmNlIGhpdCBkdWUgdG8gdGhpcyBzY2FubmVyLg==
