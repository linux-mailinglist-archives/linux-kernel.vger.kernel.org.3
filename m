Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C56D5765FB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 19:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiGOR0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 13:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiGOR0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 13:26:45 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2148643CC
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 10:26:44 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26FG50OT024289;
        Fri, 15 Jul 2022 17:26:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=5F12O8mpVgedDVdPBH27FxyMGpsyMrZi5xXMGhriF68=;
 b=UThSegACdyeN6g8gkYqtU4ApoQ4WEcP2h26W8yN0m6zW+Vkbx6WdGYmWSo0Emogg0nbD
 zQyESmYOKnCvJOaU6bKtihvvljz2f2B3R2iLbfXSUnFYHiSyul4S/u+oJNzOrPNxhbvP
 8Bqo6+7DNaexQycGDJRHdxjORFNCSvKA7KK64axRFuaYiJ+g17x/JIi0Kdi8RC3qdZ82
 xs7qU+YfeKxB5E5MPmI+UDBPftKI5JkoLGVghjifxhOtkd+rd/Em6znLjdEtKqoqBSxm
 ZVH1Ch2TQE6joI73FLP67XG5DUQPeCph3kkKfMrp6MfzjC4G8vNoAT5Q1n+p4DzqgPPg pQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h727ss4jt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jul 2022 17:26:31 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26FHBT2M032039;
        Fri, 15 Jul 2022 17:26:30 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h7047sdc3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jul 2022 17:26:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ni/Ts4icyM6kRmLp1ht5KYYFM2P8Yis6HBj1m64+YWozetSM8f1OUBW1CWTGYxfGgxmiCVWS2+MCpTSZhgHpaIpkxKH7RZH0wQUCkeXNZ14ekAiowS/2Spxi8NS1lknP1UIImBdnoRaKXG5XNOXiNvh/eQ6EcTpC57kip6orhjzh362PdBJ06JlkXPYqX14cTx/1RjAt7WTfeEc57XiENPbREtBRTjzAuZHD8BjOXRmKRPjk1eRIi1aTJz4hqdVXNZGDcDucnLfuDQQu6kcug42AOeyCGGsvtFFIt8koU7qPY8iNSDFOA/+vSt0F3tH+CTCER1TBqbR537nepLbfUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5F12O8mpVgedDVdPBH27FxyMGpsyMrZi5xXMGhriF68=;
 b=IsmKW/vjGYMwwDu1crtx6x0Aeg0GyaPLYHaj3arPxaQ563PeLHXxi0KTmVBKc8QaQvDXFgXTkx5YcSWeEr5sRZJiQsMS2mmci/ZLqziLcuLOcJk/8+cyAsv/beuGn9pHaWa7i3zKmoCX9wH97kq8uKzfIDX+JmnmXv90/FHvVq3cKZZ6aDBL9h2kSLU1VTbZd2WAGIORSx9IXaqTMaWo/neczHTrYelEK2wkF/h3vBZcs3m6/bTGwwP24TPmS40Iw7z9ko9tX7v/QQgOC5EwlTR+RUjAF6Uz2i0VU8SaYxBBiwQqqNsYRqMkADsom9jd0pcriRbXuAqmAvi0ktSkow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5F12O8mpVgedDVdPBH27FxyMGpsyMrZi5xXMGhriF68=;
 b=u5/ZyOKnqhMzDLrV8G4dai3IWw3k3BYcwxNX9frfFS783KXsm8Yb3Tu/KK1f/qqhPY1H8BgyM6Xc7ckcgK0RxPmn1W0BqDV1IrDRcPmgN8oF/zuc4SbrN80VePPjouQEAXdYHV4HBLjh9wqTppgf9RHkNGeUxAZQj5/o/AAblBE=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by BL0PR10MB2769.namprd10.prod.outlook.com (2603:10b6:208:7f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17; Fri, 15 Jul
 2022 17:26:28 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::2ce3:447b:f3ee:bf1e]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::2ce3:447b:f3ee:bf1e%5]) with mapi id 15.20.5438.014; Fri, 15 Jul 2022
 17:26:28 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] acpi/nfit: badrange report spill over to clean range
Thread-Topic: [PATCH] acpi/nfit: badrange report spill over to clean range
Thread-Index: AQHYlX3HVbDs2AmFoUigIZUcRQZQvK17eX+AgAGCqQCAAAjvAIABgQiAgAAgsgCAAQ46gA==
Date:   Fri, 15 Jul 2022 17:26:27 +0000
Message-ID: <82641e64-1003-d11a-df9c-73f3b61d6b8a@oracle.com>
References: <20220711232658.536064-1-jane.chu@oracle.com>
 <62ce16518e7d3_6070c29447@dwillia2-xfh.jf.intel.com.notmuch>
 <09df842d-d8e4-0594-56b0-b4bb9ea37b67@oracle.com>
 <62cf622a32e1_16b52e294ea@dwillia2-xfh.jf.intel.com.notmuch>
 <8b13446a-65ac-0cbd-6c17-0f9e1cfbb048@oracle.com>
 <62d0c0947c3e6_1643dc2944a@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <62d0c0947c3e6_1643dc2944a@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 82f8357a-b7a3-490a-7fca-08da66872694
x-ms-traffictypediagnostic: BL0PR10MB2769:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 25BL7McO2uBrOhiDIIwc6PFNJiB1laibeYf5BzXg2Yrpt76s9lhPsrv/5QovxrkdRH7GFprNNspQMG1hhN/y56XPRa/HJVOGXMiXQl87LfdJFcERoGx+lZlkaYbqDPFox7+S5OgVeHkUFLvdCd3VyRpr6/bzuNwyTNHwZ6f5+dsPcJgC4HiXlwWJFSkb6rSmOUmrF1cG1/QWlAnDBem2GYKrywrA7r/w9jzU7yvVjT1999LpKPFPF7JmpB4YQgoQglj6eGOZeVUlkOwJdvs0pQaXQuKkuYdFmncrkD2rvMe+ZDmbPQnLa0OKGMJL5pNNZE6PUWKJxA3FU/Tw+CoTTdYU87YeYeQkskrpx80TCuI02yeZEJs0+cUwZdtQ1GuYD2ooSajgsb5Yl+mbVKRLX8AcGuWTTIZqFe3yHgAZE2eWk56rs/aB0VrvGVTynGFQMz+Xp2resg7t44Yz7zx/81CZNegGJg4Ovlpucys8LlbHz/yQuPcnc8w/pxRfiVgnpCl4hmHdCHaRbf9oT+GASe9bxiUwLRm8Ij9o4YE4xFwK+MQL0zyb4y39EXI6lkl+Y50/aTIwafIUMcP9bTjTMuZ8dGKvQjjmIdq/VYrE0q6yIiRYAJb3aYUClRMcmhs4UJySg+xdZ2xVkgNprXNmbkkaVcWoufKrpLlITK+Yi2PY0rBVA9RaO0UsPSp7im9u6AxTeI3YQ5qYwVE6WiaPHmQ7jLO3oWZTE/soI/jbDJMh+cnZ9Jfx4Pxarzh652A3FFp/T8HnLGGF5lPXjPJHOJdU5jBTVdnlhrdP2IIIETNScdklgY/EOFP5AZJ2rB2G8x7drhU1j8tWqUjDmYcMXP+ToU8CevV4MgOqSkNFoub9vME+5EQQxNyAFk6zDz+i
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(396003)(376002)(346002)(39860400002)(110136005)(316002)(41300700001)(26005)(6506007)(478600001)(53546011)(2906002)(6486002)(71200400001)(8676002)(64756008)(66946007)(76116006)(66556008)(66476007)(66446008)(44832011)(8936002)(5660300002)(122000001)(38070700005)(86362001)(31696002)(38100700002)(36756003)(186003)(2616005)(31686004)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?clNkSjVETVlVYitvd1ZucXdMY0U3SWpzZmFSSURoTmhMSzhqb250eXQzb3RR?=
 =?utf-8?B?MXQ2ZFJZNmpPcVBXVEtWQTBMajlTaE9CK25rOXFoclE5T3NxaHZRMGxtQUNM?=
 =?utf-8?B?TmczZHVUT3hFTzRqeHhkZFJXNjBBZjUzR0ozR3I2Vkxra2F4MHFCY3ZPV2Q5?=
 =?utf-8?B?R21GZHlyVVZiVllmWkZTbzd4a3hFUk1nTlgwWGFnS0tiSnhNV0FOMGgycVh1?=
 =?utf-8?B?ZmcrWDRCaFZTNFpWWWxDMCtIZ3AySEdCNThYSXBEbFdlMi83eEl0K1ROMGVt?=
 =?utf-8?B?UmJCOHZNa1JYQmllRkFrVzlGMXBOOXVUQS9WTERLTGZER0JJMzJoc3ZoVlIv?=
 =?utf-8?B?cncrNjg4N2xPSWprZU9QVnJ1UmNNMTVGcjBMSERzcXFjUU9RSmh2TEh4YkJa?=
 =?utf-8?B?VzA2RFluc0lLYWRoeGVCd3J6ak94MkFkL0tTME9xTXhtaHZUdTNLcTNITFZU?=
 =?utf-8?B?YXJWdzRsMUx5VmF1Yk5oQWtQRFpIOGNhb0pnVlpRcFZEYUkyQzlxWFY4eFo4?=
 =?utf-8?B?NmpWZXRtMWptMlNUQWpTdFpoRzI2NWsvSEpwOXBBdzlkVDZWWWRoZy9RMDZM?=
 =?utf-8?B?N1NuQU9UdWVuU256REZnM3Rrb00vVDhIUktXYzVzMGE4NWl5NmlrOURMVmJZ?=
 =?utf-8?B?YTJQTEFjUXlpTWNvcnFad0IwUkw2Tlp0VlZORURaUzBPQVJXaEVYNkExZDBh?=
 =?utf-8?B?R3RjSlJjZDM5QUhoanhvaE1LeW9FYWtXWkRNdkxwK2d1WGRiQmt2QW1wV0Mz?=
 =?utf-8?B?Mk9HR0VkUkVLYU5iSXdEd080NUc4YmRhY1lmTnQvWEdSZE1UVmoxY0Q5NXBw?=
 =?utf-8?B?WHJ0SFlIR1gwTU1rb3ZRS1lPYXBXRDhxc3pxYjlmMC9EeDJQOFpDNnF5bEp6?=
 =?utf-8?B?eEFJdzg4dnJhNHlqeW1vbFFOS1ZyQ0NIVlRDUDZ3QzlLZml0UzdaNGtiNkRZ?=
 =?utf-8?B?cEppTkJjSm9hQUNZRjlWYTE3cHNZTHFEdkRUT0xqLy9obmdnTGlCMURFT1d1?=
 =?utf-8?B?MXhhM0xzTnhrSUZFbVdNVzIxV3hpVDU4NUYzOTNqNURKQlRISjlHeVlraVVK?=
 =?utf-8?B?WFZWMFYxLzM5UXdJSXloaWtUbXU3VC84TVMreUFTeDBaSEVtNjRwL1RjQTdU?=
 =?utf-8?B?dGovbE9yMVJBMUdkVmpWY2xEU2pBV0FLdVNraUJWQUpGbFBwcVVnK0tESTQr?=
 =?utf-8?B?d1FkS1BPU1NWSFdhbWQ4dEZPL1kycldtWjFPVHVFWFBpUmtYZUhLK3pwbVBl?=
 =?utf-8?B?MVRqM0QxeWJKeGwwcXY4R0RWUFBpR2VtaU5PODhVQTN0ZTlhMnNjbWkrdlhs?=
 =?utf-8?B?YzM3RGNyRi9pcDdIZlo5QkJZYThvZThYV1ZIaGRCNTRUVHgvWDFYQlZoeGNi?=
 =?utf-8?B?L3c1eEFwVThuR3BNb3krRkRQWDhLSU0wNUdFa3NFS3RZT1dURUhQb08yQkd2?=
 =?utf-8?B?VUQvT2owdzc2c2gvZVAvN0poNHRMTSt5R1hHU2U2aUpyM1YwdmhCTUV6RUFP?=
 =?utf-8?B?MiszeTI4L1VaVHVjd1MxZmVXUHNEemRHZm81UUdrK1doeWJwMDJ3UDF2dFlS?=
 =?utf-8?B?dEJSMW1uZGhqS2tNaW1lUEJKS3JKckVkYmMrSTVhbTl0S0dsc0s5L3VZNVQr?=
 =?utf-8?B?dG9jN1lnNW5mRDhSdWVVV3Bka1k4QkttY2VZeDRIbWZiVmZIQUFWYk1VS3Rw?=
 =?utf-8?B?d3lSSkY5dU9jeWRzMHV5VnVMUGdnZDIyMzVOYmtOK1FJakxmblQ1Z0lJYVJV?=
 =?utf-8?B?T2lzak1SMS9ZbEVGdzR4Q2oxZFpGRGxpZDIyZjNaVm1HZytGZ3ppNTc5bTAv?=
 =?utf-8?B?cjRFN0RLb0xaRTlTMTJWTnZuZzNOY0tRWHdpQW4zMmE4QkE0MUxJKzdaS3pX?=
 =?utf-8?B?MEtWejJ5TFdUcTZvWTd3Z3hNaGgxRTBKcHBQZHYyTWpsbjFzbkJiNXovVTZ4?=
 =?utf-8?B?bjhJQ3E3eG02cDdKNm5VTDJpenFTd3JySjNtVFcxUXd0UTgxSGk3eFhsUitU?=
 =?utf-8?B?ZHJNT0RnS1NCMzRPQUxTQzAxSzYxOTJSK0hhVHE1aC9WMy9rMW43c1ZnQ0pG?=
 =?utf-8?B?M3hRN1ZHb1BPK1FOZi91QzZpRm1idVM4enh3T29lUjAybUI5QlVrWnpXWUJ4?=
 =?utf-8?Q?yPnA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9183180BCC62514FAE7188468A9A828E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82f8357a-b7a3-490a-7fca-08da66872694
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2022 17:26:28.0074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VN659o4Ary4KY5M03JxWS3QX+q+1uLMna1kw/f4HvWVSwjpf8B8vUf/j3HcsJBg92pOIPH7WWa89XcJALwFN2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2769
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-15_09:2022-07-14,2022-07-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 mlxscore=0
 suspectscore=0 adultscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207150077
X-Proofpoint-ORIG-GUID: KBnkIIQHEl88RX7-aNJkf_71C6MeGrsv
X-Proofpoint-GUID: KBnkIIQHEl88RX7-aNJkf_71C6MeGrsv
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNy8xNC8yMDIyIDY6MTkgUE0sIERhbiBXaWxsaWFtcyB3cm90ZToNCj4gSmFuZSBDaHUgd3Jv
dGU6DQo+PiBJIG1lYW50IHRvIHNheSB0aGVyZSB3b3VsZCBiZSA4IGNhbGxzIHRvIHRoZSBuZml0
X2hhbmRsZV9tY2UoKSBjYWxsYmFjaywNCj4+IG9uZSBjYWxsIGZvciBlYWNoIHBvaXNvbiB3aXRo
IGFjY3VyYXRlIGFkZHJlc3MuDQo+Pg0KPj4gQWxzbywgc2hvcnQgQVJTIHdvdWxkIGZpbmQgMiBw
b2lzb25zLg0KPj4NCj4+IEkgYXR0YWNoZWQgdGhlIGNvbnNvbGUgb3V0cHV0LCBteSBhbm5vdGF0
aW9uIGlzIHByZWZpeGVkIHdpdGggIjw9PSIuDQo+IA0KPiBbMjkwNzguNjM0ODE3XSB7NH1bSGFy
ZHdhcmUgRXJyb3JdOiAgIHBoeXNpY2FsX2FkZHJlc3M6IDB4MDAwMDAwNDBhMDYwMjYwMAkJPD09
IDJuZCBwb2lzb24gQCAweDYwMA0KPiBbMjkwNzguNjQyMjAwXSB7NH1bSGFyZHdhcmUgRXJyb3Jd
OiAgIHBoeXNpY2FsX2FkZHJlc3NfbWFzazogMHhmZmZmZmZmZmZmZmZmZjAwDQo+IA0KPiBXaHkg
aXMgbmZpdF9oYW5kbGVfbWNlKCkgc2VlaW5nIGEgNEsgYWRkcmVzcyBtYXNrIHdoZW4gdGhlIENQ
RVIgcmVjb3JkDQo+IGlzIHNlZWluZyBhIDI1Ni1ieXRlIGFkZHJlc3MgbWFzaz8NCg0KR29vZCBx
dWVzdGlvbiEgIE9uZSB3b3VsZCB0aGluayBib3RoIEdIRVMgcmVwb3J0aW5nIGFuZCANCm5maXRf
aGFuZGxlX21jZSgpIGFyZSBjb25zdW1pbmcgdGhlIHNhbWUgbWNlIHJlY29yZC4uLg0KV2hvIG1p
Z2h0IGtub3c/DQoNCj4gDQo+IFNpZ2gsIGlzIHRoaXMgImZpcm13YXJlLWZpcnN0IiBjYXVzaW5n
IHRoZSBrZXJuZWwgdG8gZ2V0IGJhZCBpbmZvcm1hdGlvbg0KPiB2aWEgdGhlIG5hdGl2ZSBtZWNo
YW5pc21zID4NCj4gSSB3b3VsZCBleHBlY3QgdGhhdCBpZiB0aGlzIHRlc3Qgd2FzIHRydWx5IHdv
cnJpZWQgYWJvdXQgbWluaW1pemluZyBCSU9TDQo+IGxhdGVuY3kgaXQgd291bGQgZGlzYWJsZSBm
aXJtd2FyZS1maXJzdCBlcnJvciByZXBvcnRpbmcuIEkgd29uZGVyIGlmDQo+IHRoYXQgZml4ZXMg
dGhlIG9ic2VydmVkIHByb2JsZW0/DQoNCkNvdWxkIHlvdSBlbGFib3JhdGUgb24gZmlybXdhcmUt
Zmlyc3QgZXJyb3IgcGxlYXNlPyAgV2hhdCBhcmUgdGhlIA0KcG9zc2libGUgY29uc2VxdWVuY2Vz
IGRpc2FibGluZyBpdD8gYW5kIGhvdyB0byBkaXNhYmxlIGl0Pw0KDQp0aGFua3MhDQotamFuZQ0K
DQoNCg==
