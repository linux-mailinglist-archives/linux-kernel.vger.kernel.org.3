Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA33567AE9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 01:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbiGEXu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 19:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbiGEXu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 19:50:57 -0400
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FD9DEFC
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 16:50:55 -0700 (PDT)
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
        by mx0a-002c1b01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 265JHdd4015749;
        Tue, 5 Jul 2022 16:49:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=4COd9xAzCL1j14LuRuAya5kBcwtBCRGWR2+WGOe94qc=;
 b=nHtyV9wCvyCUAhvPgJQlwAEM7SWSpTajbIAf9q50IOAIUicaYQXfP5ijyRjsRpZ5QMx+
 6kxp8rZckP220Aju2YmO0HynN0FFVJyo1LoKxRIwuIKdlpGRc1Jzeqx4gBdYT72mTkx5
 uWCLMfh/JZgZGYujJNnJNKZHFAs5WCZKbKnp8qtlmCbgJ8If1BRvfeUSO0LCPJOX+mCm
 5vx+kZ/4ArxUd8Jk/7PxX8u2E/sJJUiH1mSEN0GOwyxt/GCCUq2LDEjdwW/C16A3UA2o
 AWNttwvUTcwKulUSGQcqW8zwoR4O9DAd+zxg3zIXEb/0K14nI/x1zq6f5XDV3oisFQVd zw== 
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2046.outbound.protection.outlook.com [104.47.74.46])
        by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3h4ub1rebj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Jul 2022 16:49:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dHwAVEukyY7wVeRa2LHbSY/6BiIcg1k51Nf8+NCyYnVCYZQanUcmw3Aq2u4mRw/I/Ffmtya+orqeNhseKDZaynMfvdJ6TqGhKmT1m+qRneq71WjV0zx6BckIrjswb3h1m3Rhpq4eUiuBD8DxNXzcVB5ur03Wt2ypzBsoLF3qLAbNd4t5e6AByvhL/EhE7hZAcj9xqRz6ch99wjKvH+lXBcPe8VK/4UYinPfmHUHjK4pS7Eghw8g/SXrxLEQ/XUTH7lWDdbzEpmF72c58/G7NV3zJlXHQdzDAjk4/1AN6oJq7GwL8xdDzjm6igj/1AENfpBzK7p1sUW5u25f5/2yzYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4COd9xAzCL1j14LuRuAya5kBcwtBCRGWR2+WGOe94qc=;
 b=C0d5BT7ogXwpqkBD1SWt0PJOmg+heZn79qqVPMOGn6QBPDrxAHpV33Rx3s8cXSSTkW/im7QdpLxeV5ZAZ+g59+nzL/H4DxO/YqpcRD2VIo0hZ57xRDr5tOQegaCQLWd+nF6MhoBl1Rxx5DmUnCuUmfzUCkIwwVTt8ytw7U9Jq3H5Hrs7zqDYGGeWIjahfbisFpt38jW9F11h68WeO43wthnoqzkgWZPq16F4In8/qHo5HF9PupaAejlXB2f1RgmPOH7QXiVtGmHv9smVdKX9RW03O+8wRvR2UOP82QsfPucUjmHSho7eH5p8aw30eQezDHY8YFw8L2LCYLMGasseRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from BYAPR02MB4488.namprd02.prod.outlook.com (2603:10b6:a03:57::28)
 by DM5PR02MB2316.namprd02.prod.outlook.com (2603:10b6:3:53::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.17; Tue, 5 Jul
 2022 23:49:50 +0000
Received: from BYAPR02MB4488.namprd02.prod.outlook.com
 ([fe80::c17a:381f:c32f:5a54]) by BYAPR02MB4488.namprd02.prod.outlook.com
 ([fe80::c17a:381f:c32f:5a54%4]) with mapi id 15.20.5395.022; Tue, 5 Jul 2022
 23:49:50 +0000
From:   David Chen <david.chen@nutanix.com>
To:     Zhang Qiao <zhangqiao22@huawei.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
CC:     "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "vschneid@redhat.com" <vschneid@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] sched/fair: fix case with reduced capacity CPU
Thread-Topic: [PATCH] sched/fair: fix case with reduced capacity CPU
Thread-Index: AQHYjc+hB9aG+LIT+06t/z3r1vlNSa1vdU6AgAECTiA=
Date:   Tue, 5 Jul 2022 23:49:50 +0000
Message-ID: <BYAPR02MB44888C0FE86220485A38363694819@BYAPR02MB4488.namprd02.prod.outlook.com>
References: <20220702045254.22922-1-vincent.guittot@linaro.org>
 <e830e6eb-6606-74f1-c356-cb61c6f46e99@huawei.com>
In-Reply-To: <e830e6eb-6606-74f1-c356-cb61c6f46e99@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 28315d13-4be3-479c-217f-08da5ee10cf4
x-ms-traffictypediagnostic: DM5PR02MB2316:EE_
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Gn7sq7cgPLUik+jF63951B5Z+TMPT49DyKPqY7PDlaLHfyCD9eM8OgwiMxgpOjJo650/2c3d5Y0NLlIRdDUnoejqfQ7p+EVjsQtJdIlPV/TY1uu1SqZcfiwcN3iNqh7b4RHRabCMgZ3SyIhpif/+G6Q3Bum/CBRfmODfcyRJHlirypGgU9I0WXrPHMjpVLDi61XSHsaxsaag2wM71l5yvoUgkdiK2pkZ3jTiQNvnGYHK/ZQvZJ7Pcn6ZA+8Kot1dMl89MQLmR9fZIsEKr9YHyx18208qD+/figKPT3w6Q6g9dq0S26/EbB+deQCguJzPwZsWLiNZgzZmfQVJDtF0NZPvCqYLO+eumEFDQN36WD+R8xk7jJXEi7oCFMFp1T6H93dbPVYanPZRpBD3FntbfPzkPZqhnPg4fwQOePGTRIIqRVsaVHyM7+Yt/9OqRUQi9fF1zsGrglao4aB8hq3R1V1pCKsanKBh5cxR7G2yJI/jsBuFfwkCLi5YyBwXyS21lkzlL9OKSITxUrTcAuuUCGnzeIx/Auj6/evvjWfN4bHF2aCYR3AlqkcgjcDvbI6L961unVCHPATRdkZsSZbuQLSQgjY+wGyY5Zka35Hv88hFD6eRpp5e/+RuWBBnwHlAgGQNJAclKA+mkoH/Bzq292DIJfrbZ09WlpX5TSZu+33Q7brW2iTcfj1266iC4vngBfoNckJJNcO9tiw0cBQH9isFh5EJtx7E5glBxY8g2BO8G0YRWgijiEjwF8iTXywzD3PmgIvKS8lWz23tGJLUl6wnLndCzakSRT5X8uYhv5RCrO+pljU7GT4PPvGadqzs
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB4488.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(366004)(396003)(136003)(39860400002)(346002)(8936002)(52536014)(38100700002)(86362001)(478600001)(44832011)(33656002)(76116006)(122000001)(66946007)(4326008)(8676002)(9686003)(64756008)(66446008)(66476007)(66556008)(5660300002)(71200400001)(7416002)(26005)(55016003)(186003)(53546011)(316002)(7696005)(54906003)(2906002)(41300700001)(6506007)(83380400001)(38070700005)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dHl1TWlWR2RMTTVtSGpxWDBLTnVnNXUwK1VkaWxOamdYVjlZVTBDMXhjNmt1?=
 =?utf-8?B?RVVTeGRObi8wa1o4M2wrU2RTVzFTS1FqQ1RXWWIrUkxCTnZWSjRFWEZ4dWg3?=
 =?utf-8?B?cDZmR3dNVGlMMUo4elFjWVg3L3doK0hJYjdVNjJVWUppb1YxTS9JQVNEcHdE?=
 =?utf-8?B?amtOMjFCa3ZvbUJWRjJJVzFWaUtCTlRjNmZZMGN0UnczblNKUExNMk9ROS90?=
 =?utf-8?B?WVVOd1BkSG1pL2tjQUEweTF5UkkrNGVGVyswN0FnZWg3VEg5QUVoZGtJMDN1?=
 =?utf-8?B?QmhJeXNTVzFwYnhGT250ekx3cHdxTndMS0dzUHR3WXlFMHJ2MGo4UFNqTXJV?=
 =?utf-8?B?T1lRNnB2ZWdaT2VhK0JrNmtUNG5mQkEvQzNFa2RDTjc4bEwzN015MHY3TUpX?=
 =?utf-8?B?U2VUaTZ4RzhuNC9oMmhPMDdqUDFIQWhDUzhwbXhnZ25HMXhhN2JxZHUrTjZX?=
 =?utf-8?B?NkZXOERIUzZkc0g5M1hmZlFRNExsdFgzL281eENhRkxubkRGVEVac2pRMDdn?=
 =?utf-8?B?VExzYW1oRXE2Tk1YVEljV09CUlZqS3JqcjhVVzRTMHptTkZuVklWV3lzZ1FL?=
 =?utf-8?B?b0lpSUM3ZjVlMUxHWXhnaGlWa0tDS04yQ1NCODdNTHVjTitmRm1QcWltTy9J?=
 =?utf-8?B?djBWV1hDbkptcllUazNkdWd4cWlUZlhVVXhCdVBLK1BOUmtFczBBZmtEZjVs?=
 =?utf-8?B?UU1kSEpab3dFTkJYOHRKMS9Gdk9PZHY1QW1HWFIwTEdlZEU3Um5YaXozUWd3?=
 =?utf-8?B?cEh3aXY2YnFOZGN6UWVqbmxKUVpHbGNhNEZDekJZUnQ5OFIrTHFieno3MkZP?=
 =?utf-8?B?dUpWMDg0ZXkwbngyV0ZsVFlzM0xvam94K3cvRjJqdjA2TFdPRjhjNFVOVVly?=
 =?utf-8?B?REZ5QWhVRjNiRU1DTUx1L1NnY3gyNXF4Yk1vRjlaYmN6VlBNbTlQM1RQUkV5?=
 =?utf-8?B?VytXRWxrZEdCRE1CMUhaNEtZbXMySUhNNUowTVpEdzBSSENWTzBjWGpSTW5J?=
 =?utf-8?B?QjNpUFdncEMrRmlaSlhSL0t0TEgvUGxvbC9ZcmFuTS9XVCtlUCtGTFFvemxV?=
 =?utf-8?B?UmZ3b1JEbE54N3lsU0YxQ0lIR3YvZEZhaHJFVUJOamNMWmhUYkRhQlRvTVVo?=
 =?utf-8?B?Z2JBdUxxeHZjQ3Y5ck5xbmhoWFJTTkQyWWdCMlBWbjV0cFJOaDhTZVJHUlQz?=
 =?utf-8?B?QmdHSFovY1BKYWtOektVdk5pZEVQZmVqTnA1eTh4ekIxQ0VNN240MUxHN2Fz?=
 =?utf-8?B?d25CcDVUeXdlNldLWkF5T2U1L2R6aTc3WUgwNkw1Z0xzNllVR0U1elFlTzZw?=
 =?utf-8?B?M2NMa3JabnpJVHJSS2JEbm40NjVwN1pkNDNvN1daMXYvcnlrTmFOUHFidURh?=
 =?utf-8?B?ZjNpSGZnTHpwVmZxWWt2OWNFU0tzT2FRVDdEbEVmYVRXRkU0cUdPYXRnTXZt?=
 =?utf-8?B?M05ralZTbU50WlFpdytmNVMzWnRqU0FENzZ6VnhMK3hLWDB3dVVlMGRLeTNR?=
 =?utf-8?B?aDl0L3RLQVdIeXA4aXN2d0hXdUJvUmY3eXlOdFliY2ZqMHg0a1k1NFhYMTY2?=
 =?utf-8?B?TzR5TExWeDMxbUpRMVRTeVM3RWh1UzFjWWI1anBVNFMwbUl4QURET1ErQWs5?=
 =?utf-8?B?QllQdytEL1lYOFNxbHAyMERJUnB0ZmZUWG9OaDdKUmI4UVlhZklEVzZLUXJE?=
 =?utf-8?B?T3BqYzJHYzlvTFU5aXlXYmVoVWlXdlBQNmMwOGs1TldaN005ekZuQSt4cEVQ?=
 =?utf-8?B?YlNaS2x0S1JZcDFQZi81YUw4aTdwQ3E2NDBEVVlkdTlZenUvZVdpTUxjRDlN?=
 =?utf-8?B?ZEw2WlhxbWdiTjdrTVRKQnk0MFFpNDZlV1kvdjN6T0duY1ZDMnYyeUt5ZnBB?=
 =?utf-8?B?N25EdVc0RXE4eDlkbzcvbGg3UjBXY0lBWHRaRWtCSE9YdTVpNGFaK21QZS9S?=
 =?utf-8?B?ODM3cmhIaEpENnFVdEtzRFZZVTNlSjQ1WjNzUTEzU2dEVnJWdzhRcEUydGZV?=
 =?utf-8?B?OXlnTzl6UzZGaXprWDUxU2Yvdk1GY3BRNWRhWENaQW10SjVINE4zQ1hvVCtG?=
 =?utf-8?B?dExtR2NVTkJzUFJISUhuU05RUWtNMTNuYXhseldJYk1Eb0h5WDU2LzRCU1Fs?=
 =?utf-8?Q?7WcBTD1hhN8hcd9cbF42ZXQ37?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4488.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28315d13-4be3-479c-217f-08da5ee10cf4
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2022 23:49:50.3700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9IIrXEOMtvR6CiqVd2eAvFJf+REeURUCiFQE79FDbVZm8yQjJNwkLErLcYyqjZkVPyAZIiGp418K4n2LXO6R5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2316
X-Proofpoint-ORIG-GUID: 92-cxEE6RigJJYyLxPNuRpQwCuL_nwbh
X-Proofpoint-GUID: 92-cxEE6RigJJYyLxPNuRpQwCuL_nwbh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-05_20,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogWmhhbmcgUWlhbyA8emhh
bmdxaWFvMjJAaHVhd2VpLmNvbT4NCj4gU2VudDogVHVlc2RheSwgSnVseSA1LCAyMDIyIDE6MjMg
QU0NCj4gVG86IFZpbmNlbnQgR3VpdHRvdCA8dmluY2VudC5ndWl0dG90QGxpbmFyby5vcmc+DQo+
IENjOiBtaW5nb0ByZWRoYXQuY29tOyBwZXRlcnpAaW5mcmFkZWFkLm9yZzsganVyaS5sZWxsaUBy
ZWRoYXQuY29tOyBkaWV0bWFyLmVnZ2VtYW5uQGFybS5jb207IHJvc3RlZHRAZ29vZG1pcy5vcmc7
DQo+IGJzZWdhbGxAZ29vZ2xlLmNvbTsgbWdvcm1hbkBzdXNlLmRlOyBicmlzdG90QHJlZGhhdC5j
b207IHZzY2huZWlkQHJlZGhhdC5jb207IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IERh
dmlkIENoZW4NCj4gPGRhdmlkLmNoZW5AbnV0YW5peC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0hdIHNjaGVkL2ZhaXI6IGZpeCBjYXNlIHdpdGggcmVkdWNlZCBjYXBhY2l0eSBDUFUNCj4gDQo+
IA0KPiANCj4g5ZyoIDIwMjIvNy8yIDEyOjUyLCBWaW5jZW50IEd1aXR0b3Qg5YaZ6YGTOg0KPiA+
IFRoZSBjYXBhY2l0eSBvZiB0aGUgQ1BVIGF2YWlsYWJsZSBmb3IgQ0ZTIHRhc2tzIGNhbiBiZSBy
ZWR1Y2VkIGJlY2F1c2Ugb2YNCj4gPiBvdGhlciBhY3Rpdml0aWVzIHJ1bm5pbmcgb24gdGhlIGxh
dHRlci4gSW4gc3VjaCBjYXNlLCBpdCdzIHdvcnRoIHRyeWluZyB0bw0KPiA+IG1vdmUgQ0ZTIHRh
c2tzIG9uIGEgQ1BVIHdpdGggbW9yZSBhdmFpbGFibGUgY2FwYWNpdHkuDQo+ID4NCj4gPiBUaGUg
cmV3b3JrIG9mIHRoZSBsb2FkIGJhbGFuY2UgaGFzIGZpbHRlcmQgdGhlIGNhc2Ugd2hlbiB0aGUg
Q1BVIGlzDQo+ID4gY2xhc3NpZmllZCB0byBiZSBmdWxseSBidXN5IGJ1dCBpdHMgY2FwYWNpdHkg
aXMgcmVkdWNlZC4NCj4gPg0KPiA+IENoZWNrIGlmIENQVSdzIGNhcGFjaXR5IGlzIHJlZHVjZWQg
d2hpbGUgZ2F0aGVyaW5nIGxvYWQgYmFsYW5jZSBzdGF0aXN0aWNzDQo+ID4gYW5kIGNsYXNzaWZ5
IGl0IGdyb3VwX21pc2ZpdF90YXNrIGluc3RlYWQgb2YgZ3JvdXBfZnVsbHlfYnVzeSBzbyB3ZSBj
YW4NCj4gPiB0cnkgdG8gbW92ZSB0aGUgbG9hZCBvbiBhbm90aGVyIENQVS4NCj4gPg0KPiA+IFJl
cG9ydGVkLWJ5OiBEYXZpZCBDaGVuIDxkYXZpZC5jaGVuQG51dGFuaXguY29tPg0KPiA+IFJlcG9y
dGVkLWJ5OiBaaGFuZyBRaWFvIDx6aGFuZ3FpYW8yMkBodWF3ZWkuY29tPg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IFZpbmNlbnQgR3VpdHRvdCA8dmluY2VudC5ndWl0dG90QGxpbmFyby5vcmc+DQo+ID4g
LS0tDQo+ID4NCj4gPiBEYXZpZCwgWmhhbmcsDQo+ID4NCj4gPiBJIGhhdmVuJ3QgcHV0IHlvdXIg
dGVzdGVkLWJ5IGJlY2F1c2UgSSBoYXZlIHJld29ya2VkIGFuZCBjbGVhbmVkIHRoZSBwYXRjaCB0
bw0KPiA+IGNvdmVyIG1vcmUgY2FzZXMuDQo+ID4NCj4gPiBDb3VsZCB5b3UgcnVuIHNvbWUgdGVz
dHMgd2l0aCB0aGlzIHZlcnNpb24gPw0KPiANCj4gSSB0ZXN0ZWQgd2l0aCB0aGlzIHZlcnNpb24s
IGl0IGlzIG9rLg0KPiANCj4gVGVzdGVkLWJ5OiBaaGFuZyBRaWFvIDx6aGFuZ3FpYW8yMkBodWF3
ZWkuY29tPg0KPiANCj4gVGhhbmtzDQoNClRoaXMgdmVyc2lvbiB3b3JrcyBmaW5lIHdpdGggbWUu
DQpUZXN0ZWQtYnk6IERhdmlkIENoZW4gPGRhdmlkLmNoZW5AbnV0YW5peC5jb20+DQoNClRoYW5r
cw0KDQo+IA0KPiA+DQo+ID4gVGhhbmtzDQo+ID4NCj4gPiAga2VybmVsL3NjaGVkL2ZhaXIuYyB8
IDUwICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLQ0KPiA+ICAx
IGZpbGUgY2hhbmdlZCwgNDAgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pDQo+ID4NCj4g
PiBkaWZmIC0tZ2l0IGEva2VybmVsL3NjaGVkL2ZhaXIuYyBiL2tlcm5lbC9zY2hlZC9mYWlyLmMN
Cj4gPiBpbmRleCBhNzhkMmUzYjlkNDkuLjEyNmI4MmVmNDI3OSAxMDA2NDQNCj4gPiAtLS0gYS9r
ZXJuZWwvc2NoZWQvZmFpci5jDQo+ID4gKysrIGIva2VybmVsL3NjaGVkL2ZhaXIuYw0KPiA+IEBA
IC04Nzk4LDYgKzg3OTgsMTkgQEAgc2NoZWRfYXN5bShzdHJ1Y3QgbGJfZW52ICplbnYsIHN0cnVj
dCBzZF9sYl9zdGF0cyAqc2RzLCAgc3RydWN0IHNnX2xiX3N0YXRzICpzZ3MNCj4gPiAgCXJldHVy
biBzY2hlZF9hc3ltX3ByZWZlcihlbnYtPmRzdF9jcHUsIGdyb3VwLT5hc3ltX3ByZWZlcl9jcHUp
Ow0KPiA+ICB9DQo+ID4NCj4gPiArc3RhdGljIGlubGluZSBib29sDQo+ID4gK3NjaGVkX3JlZHVj
ZWRfY2FwYWNpdHkoc3RydWN0IHJxICpycSwgc3RydWN0IHNjaGVkX2RvbWFpbiAqc2QpDQo+ID4g
K3sNCj4gPiArCS8qDQo+ID4gKwkgKiBXaGVuIHRoZXJlIGlzIG1vcmUgdGhhbiAxIHRhc2ssIHRo
ZSBncm91cF9vdmVybG9hZGVkIGNhc2UgYWxyZWFkeQ0KPiA+ICsJICogdGFrZXMgY2FyZSBvZiBj
cHUgd2l0aCByZWR1Y2VkIGNhcGFjaXR5DQo+ID4gKwkgKi8NCj4gPiArCWlmIChycS0+Y2ZzLmhf
bnJfcnVubmluZyAhPSAxKQ0KPiA+ICsJCXJldHVybiBmYWxzZTsNCj4gPiArDQo+ID4gKwlyZXR1
cm4gY2hlY2tfY3B1X2NhcGFjaXR5KHJxLCBzZCk7DQo+ID4gK30NCj4gPiArDQo+ID4gIC8qKg0K
PiA+ICAgKiB1cGRhdGVfc2dfbGJfc3RhdHMgLSBVcGRhdGUgc2NoZWRfZ3JvdXAncyBzdGF0aXN0
aWNzIGZvciBsb2FkIGJhbGFuY2luZy4NCj4gPiAgICogQGVudjogVGhlIGxvYWQgYmFsYW5jaW5n
IGVudmlyb25tZW50Lg0KPiA+IEBAIC04ODIwLDggKzg4MzMsOSBAQCBzdGF0aWMgaW5saW5lIHZv
aWQgdXBkYXRlX3NnX2xiX3N0YXRzKHN0cnVjdCBsYl9lbnYgKmVudiwNCj4gPg0KPiA+ICAJZm9y
X2VhY2hfY3B1X2FuZChpLCBzY2hlZF9ncm91cF9zcGFuKGdyb3VwKSwgZW52LT5jcHVzKSB7DQo+
ID4gIAkJc3RydWN0IHJxICpycSA9IGNwdV9ycShpKTsNCj4gPiArCQl1bnNpZ25lZCBsb25nIGxv
YWQgPSBjcHVfbG9hZChycSk7DQo+ID4NCj4gPiAtCQlzZ3MtPmdyb3VwX2xvYWQgKz0gY3B1X2xv
YWQocnEpOw0KPiA+ICsJCXNncy0+Z3JvdXBfbG9hZCArPSBsb2FkOw0KPiA+ICAJCXNncy0+Z3Jv
dXBfdXRpbCArPSBjcHVfdXRpbF9jZnMoaSk7DQo+ID4gIAkJc2dzLT5ncm91cF9ydW5uYWJsZSAr
PSBjcHVfcnVubmFibGUocnEpOw0KPiA+ICAJCXNncy0+c3VtX2hfbnJfcnVubmluZyArPSBycS0+
Y2ZzLmhfbnJfcnVubmluZzsNCj4gPiBAQCAtODg1MSwxMSArODg2NSwxNyBAQCBzdGF0aWMgaW5s
aW5lIHZvaWQgdXBkYXRlX3NnX2xiX3N0YXRzKHN0cnVjdCBsYl9lbnYgKmVudiwNCj4gPiAgCQlp
ZiAobG9jYWxfZ3JvdXApDQo+ID4gIAkJCWNvbnRpbnVlOw0KPiA+DQo+ID4gLQkJLyogQ2hlY2sg
Zm9yIGEgbWlzZml0IHRhc2sgb24gdGhlIGNwdSAqLw0KPiA+IC0JCWlmIChlbnYtPnNkLT5mbGFn
cyAmIFNEX0FTWU1fQ1BVQ0FQQUNJVFkgJiYNCj4gPiAtCQkgICAgc2dzLT5ncm91cF9taXNmaXRf
dGFza19sb2FkIDwgcnEtPm1pc2ZpdF90YXNrX2xvYWQpIHsNCj4gPiAtCQkJc2dzLT5ncm91cF9t
aXNmaXRfdGFza19sb2FkID0gcnEtPm1pc2ZpdF90YXNrX2xvYWQ7DQo+ID4gLQkJCSpzZ19zdGF0
dXMgfD0gU0dfT1ZFUkxPQUQ7DQo+ID4gKwkJaWYgKGVudi0+c2QtPmZsYWdzICYgU0RfQVNZTV9D
UFVDQVBBQ0lUWSkgew0KPiA+ICsJCQkvKiBDaGVjayBmb3IgYSBtaXNmaXQgdGFzayBvbiB0aGUg
Y3B1ICovDQo+ID4gKwkJCWlmIChzZ3MtPmdyb3VwX21pc2ZpdF90YXNrX2xvYWQgPCBycS0+bWlz
Zml0X3Rhc2tfbG9hZCkgew0KPiA+ICsJCQkJc2dzLT5ncm91cF9taXNmaXRfdGFza19sb2FkID0g
cnEtPm1pc2ZpdF90YXNrX2xvYWQ7DQo+ID4gKwkJCQkqc2dfc3RhdHVzIHw9IFNHX09WRVJMT0FE
Ow0KPiA+ICsJCQl9DQo+ID4gKwkJfSBlbHNlIGlmICgoZW52LT5pZGxlICE9IENQVV9OT1RfSURM
RSkgJiYNCj4gPiArCQkJICAgc2NoZWRfcmVkdWNlZF9jYXBhY2l0eShycSwgZW52LT5zZCkgJiYN
Cj4gPiArCQkJICAgKHNncy0+Z3JvdXBfbWlzZml0X3Rhc2tfbG9hZCA8IGxvYWQpKSB7DQo+ID4g
KwkJCS8qIENoZWNrIGZvciBhIHRhc2sgcnVubmluZyBvbiBhIENQVSB3aXRoIHJlZHVjZWQgY2Fw
YWNpdHkgKi8NCj4gPiArCQkJc2dzLT5ncm91cF9taXNmaXRfdGFza19sb2FkID0gbG9hZDsNCj4g
PiAgCQl9DQo+ID4gIAl9DQo+ID4NCj4gPiBAQCAtODkwOCw3ICs4OTI4LDggQEAgc3RhdGljIGJv
b2wgdXBkYXRlX3NkX3BpY2tfYnVzaWVzdChzdHJ1Y3QgbGJfZW52ICplbnYsDQo+ID4gIAkgKiBD
UFVzIGluIHRoZSBncm91cCBzaG91bGQgZWl0aGVyIGJlIHBvc3NpYmxlIHRvIHJlc29sdmUNCj4g
PiAgCSAqIGludGVybmFsbHkgb3IgYmUgY292ZXJlZCBieSBhdmdfbG9hZCBpbWJhbGFuY2UgKGV2
ZW50dWFsbHkpLg0KPiA+ICAJICovDQo+ID4gLQlpZiAoc2dzLT5ncm91cF90eXBlID09IGdyb3Vw
X21pc2ZpdF90YXNrICYmDQo+ID4gKwlpZiAoKGVudi0+c2QtPmZsYWdzICYgU0RfQVNZTV9DUFVD
QVBBQ0lUWSkgJiYNCj4gPiArCSAgICAoc2dzLT5ncm91cF90eXBlID09IGdyb3VwX21pc2ZpdF90
YXNrKSAmJg0KPiA+ICAJICAgICghY2FwYWNpdHlfZ3JlYXRlcihjYXBhY2l0eV9vZihlbnYtPmRz
dF9jcHUpLCBzZy0+c2djLT5tYXhfY2FwYWNpdHkpIHx8DQo+ID4gIAkgICAgIHNkcy0+bG9jYWxf
c3RhdC5ncm91cF90eXBlICE9IGdyb3VwX2hhc19zcGFyZSkpDQo+ID4gIAkJcmV0dXJuIGZhbHNl
Ow0KPiA+IEBAIC05NTE3LDkgKzk1MzgsMTggQEAgc3RhdGljIGlubGluZSB2b2lkIGNhbGN1bGF0
ZV9pbWJhbGFuY2Uoc3RydWN0IGxiX2VudiAqZW52LCBzdHJ1Y3Qgc2RfbGJfc3RhdHMgKnMNCj4g
PiAgCWJ1c2llc3QgPSAmc2RzLT5idXNpZXN0X3N0YXQ7DQo+ID4NCj4gPiAgCWlmIChidXNpZXN0
LT5ncm91cF90eXBlID09IGdyb3VwX21pc2ZpdF90YXNrKSB7DQo+ID4gLQkJLyogU2V0IGltYmFs
YW5jZSB0byBhbGxvdyBtaXNmaXQgdGFza3MgdG8gYmUgYmFsYW5jZWQuICovDQo+ID4gLQkJZW52
LT5taWdyYXRpb25fdHlwZSA9IG1pZ3JhdGVfbWlzZml0Ow0KPiA+IC0JCWVudi0+aW1iYWxhbmNl
ID0gMTsNCj4gPiArCQlpZiAoZW52LT5zZC0+ZmxhZ3MgJiBTRF9BU1lNX0NQVUNBUEFDSVRZKSB7
DQo+ID4gKwkJCS8qIFNldCBpbWJhbGFuY2UgdG8gYWxsb3cgbWlzZml0IHRhc2tzIHRvIGJlIGJh
bGFuY2VkLiAqLw0KPiA+ICsJCQllbnYtPm1pZ3JhdGlvbl90eXBlID0gbWlncmF0ZV9taXNmaXQ7
DQo+ID4gKwkJCWVudi0+aW1iYWxhbmNlID0gMTsNCj4gPiArCQl9IGVsc2Ugew0KPiA+ICsJCQkv
Kg0KPiA+ICsJCQkgKiBTZXQgbG9hZCBpbWJhbGFuY2UgdG8gYWxsb3cgbW92aW5nIHRhc2sgZnJv
bSBjcHUNCj4gPiArCQkJICogd2l0aCByZWR1Y2VkIGNhcGFjaXR5DQo+ID4gKwkJCSAqLw0KPiA+
ICsJCQllbnYtPm1pZ3JhdGlvbl90eXBlID0gbWlncmF0ZV9sb2FkOw0KPiA+ICsJCQllbnYtPmlt
YmFsYW5jZSA9IGJ1c2llc3QtPmdyb3VwX21pc2ZpdF90YXNrX2xvYWQ7DQo+ID4gKwkJfQ0KPiA+
ICAJCXJldHVybjsNCj4gPiAgCX0NCj4gPg0KPiA+DQo=
