Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 181CB4799DF
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 10:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbhLRJJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 04:09:12 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:49874 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232481AbhLRJJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 04:09:09 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BI4ABhw030131
        for <linux-kernel@vger.kernel.org>; Sat, 18 Dec 2021 01:09:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=6VZtdvHe5CgI6i6y6jnKplCDXzViaxhPiSYhcayS8lI=;
 b=CxsZhU2RwNVX60BnXnhIfz4wsBXwPz2EcE/WkwQbi12FiQy5CCpV/wSh+wsyJp85b3GP
 1AuOcDv38E0sars+haiY09PkWIFYZajGDVzTew6s4sqW+t2ro+0ogYgP6O+STjKjI+IK
 Re+VYQn0Q0mWDHFwenJTGMH5QulQ/jcjRRQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3d18cah5gq-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 18 Dec 2021 01:09:08 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 18 Dec 2021 01:09:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mTnkAkO6mjeDFvuJuUQRjgrUavif17AMCYVoM2CfOocGnWPCkwlL0VaxPSms02gya5EbMNB7OeCy/6kpuLyB+8NPpdgAj4vmdBHtFufOFt0SP7tJMPr1LTv3ZT1mVYOsKj0zRBBUaCErs/kwZT27Ye2qnGoym6SKHZ5eINNBd4OtNgiWmMzgLAjRJlEQt24cp5NbAManNN3vhAJJ34HFFqlA16uH4z64pO6vZDa1UFmGbS+bzBw4AMxtwoKQ4w9oE7ycJDFqWmW4lhKX1Vkv3Ny+MyTNlYgaDJTS0A8clk8njQhfOf+16tRhE0pUfU13Y6N5OLgndXxW7X4jNAmpAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6VZtdvHe5CgI6i6y6jnKplCDXzViaxhPiSYhcayS8lI=;
 b=TOkEKAjwSFqu1HFsrHd3XsZOhQcVB385cSLkSPqT2V8FP/RupkbLD7PunL0TVfl5S/YN9vs2JVrC5lB3yVV1xosKcD6Mw9AQihF6VHYrZfN076GGMja+7JPqdyLvkFxGok+efkAsoJdYZKS6X1ffNJT7eef2CUxj+d05CESHsock6d/aqdVfdpHA+8CcyqI2blO+NAB66OzijNReVg2MLztr8hsCk9/SRT3sPBwwOLMCwnu2WlWsNfAS+bAtq2z57yJJEza4DuRsi/hoQAkN6zFCPe5IYwwQOWOHQsSUTXuTLrzHZSc/0BDmSVpVc7dpmads1k6/58THJUNBKU/muA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SA1PR15MB5095.namprd15.prod.outlook.com (2603:10b6:806:1de::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Sat, 18 Dec
 2021 09:09:06 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::f826:e515:ee1a:a33]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::f826:e515:ee1a:a33%6]) with mapi id 15.20.4801.017; Sat, 18 Dec 2021
 09:09:05 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Ian Rogers" <irogers@google.com>
Subject: Re: [PATCH v3] perf/core: Set event shadow time for inactive events
 too
Thread-Topic: [PATCH v3] perf/core: Set event shadow time for inactive events
 too
Thread-Index: AQHX6ipF/JnJvZ9n50qVJHJ8Sj4PjqwqCucAgACqDoCAANmCgIALZWAAgAEVpIA=
Date:   Sat, 18 Dec 2021 09:09:05 +0000
Message-ID: <7A415BC0-E6F2-4ED2-8996-8F5871ED8001@fb.com>
References: <20211205224843.1503081-1-namhyung@kernel.org>
 <YbHn6JaaOo3b5GLO@hirez.programming.kicks-ass.net>
 <CAM9d7ciJTJB1rumzmxGeJrAdeE9R4eXhtJRUQGj9y6DBN-ovig@mail.gmail.com>
 <20211210103341.GS16608@worktop.programming.kicks-ass.net>
 <Yby8Su+fVA1lqVjT@hirez.programming.kicks-ass.net>
In-Reply-To: <Yby8Su+fVA1lqVjT@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3693.20.0.1.32)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dd681153-7b69-4a8e-30c8-08d9c2060ae8
x-ms-traffictypediagnostic: SA1PR15MB5095:EE_
x-microsoft-antispam-prvs: <SA1PR15MB5095CF7BA1E5C4150C79C266B3799@SA1PR15MB5095.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mLb1stJvugG5uTTXWDAT1ynDD+Z6vMk3fzOZQ2DKCNcjz6ApKIcgjiqilBfH+19mvt4eq9o/WlyZL5uFz+0p4Y+5k9YjWR4Z3xqdt5ruBYZv5aRujJYlvoPz4C+f2K6qOj3CEOWfHrsFU3MgKT/CgsVN9wq/lN7MlTRSwRnu27YkvPaJH7Wa0o+zN9jpuq4WX2xFMyWGjCV2LK9+YSEXHEqrTRqUjzS28XFyS72nwLvlFvjomPNTixfErG5w7AtS8KfrSz4OL2nW8f9UA6oOaifnvT4pNbu2JJCpeoTa2bHecQU5OeZokgja0JnyK3h199fqHn+nNe1mdeXptcs+1a4Xz8G+83gbutgO8g11ZasLDWwrf9NEf4jdLAhNgjxI4ir5VThYsEcvD+6OYj50wIAZDilNbecisJz/XkfIcH0Es0K84Zac77y7D5NbgkouISv3ZZfBH2AEL3ww2OdStZI6axRJgYdyF5xoJ2aIGDUHExkXqhUGqlsouFdaF0FSxnlEWKpkX6FbMszjjqYVapNWjSPEN0YrlKBVdxz2uOGeXW6EbPcLZjm9+FxdsDoOI3Kw71cc0npaKLdNEthLy2DrVytbFA5G1a/TlOiMnM8VmuW51wuhdL3FGCQ5C7xRc4uYvbMgIaG0BCUDZti7U53NtyG3k2r+rlTEXrljEgHM746/JtTtu+vDlqAw+/un9y2porfHNHND/tXEssf5ce/MI+AywLqG1rO+An+TWpw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(122000001)(38100700002)(7416002)(91956017)(66946007)(5660300002)(64756008)(4326008)(38070700005)(6486002)(76116006)(66476007)(2906002)(66446008)(66556008)(6512007)(6916009)(33656002)(316002)(54906003)(71200400001)(8676002)(86362001)(36756003)(2616005)(8936002)(83380400001)(508600001)(186003)(53546011)(6506007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wWIPuirfsZQVEuW8uYxiI0PxI0ocT2kOMu0I28cp8281e76XY9OeiYbCWxxh?=
 =?us-ascii?Q?mcerU352f4j3s5RS7aOxk9Bf2ktouQGOmPNL6x+KPcziP+ahwehZYjaPXkJq?=
 =?us-ascii?Q?6yQP/Z1Xc/tCwPiAzmCpvaoHS/R42Wf/31e9JZ40v2xzQCaiH7Fbdp4tXPbI?=
 =?us-ascii?Q?J8XNzuCcqgPsxBmGH9E8kYHkQ5opq3yDfQ2dHo7HTGfBQTf0yaLji6yKxOUS?=
 =?us-ascii?Q?4QQllN2uLb3WHO4eR2d9epgNyCbfc1VDnjPjTY6Wx8zwfwSCnlKFwaMbqbst?=
 =?us-ascii?Q?8k6IrhWwykJ551yVxc4NojEMMNBTzA1I4Fv0NbhHJzLxbvm27fvL5SwJJ0WY?=
 =?us-ascii?Q?8O7hEJ06JCxf8Y694TWnOBZ11UeM21Jc7awroxNz1Atv+y8NPa4NocwPin5O?=
 =?us-ascii?Q?GFScbzOkFKjgeknXc8sDpN6OpIlmxMmRu0r+IU/pViufjIC2chp9xarxx8dw?=
 =?us-ascii?Q?fsckA/QcfgFpHhZbFP1ZRxcb/cl+eF99H3kyB/7II3YCpgz00U50hr6ItYLc?=
 =?us-ascii?Q?jGdBGSrU6CCf2930zjUnvXgOJrrraLWuzXZUAQc3WHwAgOY2x7r2jZofTz1Q?=
 =?us-ascii?Q?DwrDaQYWO1heEuZxe+Ubg5xe/kvmvaLvvgcAbW+EBRjXpxgiyjK643NfFECc?=
 =?us-ascii?Q?eu0HDuL/fLdwK2Du43VSg19ys3rgV2K8xC3eSy4XOxcrtPKCmCBKRWcswZVV?=
 =?us-ascii?Q?epRGoYvjpZy5kvKbuhNnqH7yiez4LnaUnzsd0H29fwigjaE5/5EXtLRzTNb/?=
 =?us-ascii?Q?PeixdSJIStaA8aNhpCvirf2kCixv9jCcJcKaJhG7hiXr03STkw6judrQsxo0?=
 =?us-ascii?Q?L3hi7qObspK3AbbFIxBTM1cF1DrKrfdC2g84eBFRJgaTwyEw7ICFTq8Hrx9E?=
 =?us-ascii?Q?zSXqWvYDMO0Cn6hMsBDsl6u+19cC0gZdLJpI56Y3db87wjJx3sK5fMetqat7?=
 =?us-ascii?Q?/oZ/2u4pELYcpcsgxSKXxcxAaDERHg/lUi8Zl2nOkXfrJbCFq2aF++Z/RTcN?=
 =?us-ascii?Q?RghaA8SIEfcqMi5WXBf4J1Qfzu9AQKhhLF1s5vWGBVoGKRKtBS+iWzUIdnRo?=
 =?us-ascii?Q?Uu18ogt75yOlMnabRAn4g5TSAt/vyEQ7CAI6QPTgPeS6IVE2MMvHXuTc3Rgn?=
 =?us-ascii?Q?iVUOxcTU3xc3SqE+oHQDGbHSu0B0bQF2GNxShHZpJBaOz30mpAFLGq9Ommng?=
 =?us-ascii?Q?6hJ8nCReC9wyEPQx7zG1O0W2VxkWxspdXFHysU/5FMmDOZ5NvYRmFg2qKZ3K?=
 =?us-ascii?Q?Sp5j56O8cgmhI4pezUGhrTKd4vQhCbiKpYlseEERxiOC5E8Gt8H4/322w/2C?=
 =?us-ascii?Q?jtWhbyZjp0zCmky7c4F9GrYvAChh14Q3DK2Y6ZhFzTeV+MdxkckIyjbJU4xf?=
 =?us-ascii?Q?qrr6zBPXmi7I9sQF2KiwL1FLTTG7TjPHIOtUxovIIE33CiyNTo5QtCENszZI?=
 =?us-ascii?Q?bPlsAYsKChkBKGZoSkG52x00mx+Q/UWt5tcFE00nQJ+au4TDEe5se8SsHu3t?=
 =?us-ascii?Q?Ix0Y/GPdTtXq7kAakYKPqSkfz3/tN6O67A/lw1F0KUeYaWCTKyTIH0ByCUaC?=
 =?us-ascii?Q?5cBNIiIA3jfSjhSnseIxqcORfrS5nsIEW3/Q1BhZPpDJRpNVr5CYYCLY6pon?=
 =?us-ascii?Q?1vsXmOeez7twB7NjQUxeN2aZnKFrz22WR+xqhF1Ra+88ZQQQ+snc/rwkmA6j?=
 =?us-ascii?Q?Rr/4oQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <992AE1D0F0717B43AD632CC649CF4CF5@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd681153-7b69-4a8e-30c8-08d9c2060ae8
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2021 09:09:05.6962
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hyQO0lyUnPmawtxz5JkAbLJpLDIul5XooI8AoiKkJBzdvZ0pE5gL/ei1HJlbEYy5i/kzj2dExJcUmuDZCJ2ipA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5095
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: gsFLLs2qVXbpaQvIE6xOgMUGY5TH1zKR
X-Proofpoint-ORIG-GUID: gsFLLs2qVXbpaQvIE6xOgMUGY5TH1zKR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-18_03,2021-12-16_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 impostorscore=0 suspectscore=0
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112180053
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 17, 2021, at 8:35 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> 
> On Fri, Dec 10, 2021 at 11:33:41AM +0100, Peter Zijlstra wrote:
> 
>> I'm thinking this is a cgroup specific thing. Normally the shadow_time
>> thing is simply a relative displacement between event-time and the
>> global clock. That displacement never changes, except when you do
>> IOC_DISABLE/IOC_ENABLE.
>> 
>> However, for cgroup things are different, since the cgroup events aren't
>> unconditionally runnable, that is, the enabled time should only count
>> when the cgroup is active, right?
>> 
>> So perhaps perf_event_read_local() should use a cgroup clock instead of
>> perf_clock() for cgroup events.
>> 
>> Let me think about that some more...
> 
> How's this then? Song, could you also please test and or better explain
> the problem f79256532682 pretends to cure? Because the below is
> reverting that, I *really* hate having to touch the events we're not
> scheduling.

Unfortunately, this change bring the bug back. For time_enabled in rdpmc
case to work properly, we have to touch all the enabled but not running 
events, right?

Thanks,
Song

[...]

