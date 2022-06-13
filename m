Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADC5F54A0CA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 23:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234342AbiFMVFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 17:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352805AbiFMVEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 17:04:44 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D70DB2D
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 13:40:07 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25DJdPlu004110;
        Mon, 13 Jun 2022 20:39:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2021-07-09;
 bh=IHZkHx6v0qzdiP34i4TVymbJ8CxsQitipHlwxsCMgjw=;
 b=dOk1o05H/ersgen8HiwrEiSABq50U0LYtiU6haVdGK1SYck401hUyHfKonRjzNBTUGV8
 Lp5pMreRqTGg5IPyz4jiIFaysNc/etTaSeWJEjwLEicV8Az5j4IBFC5lufufERatMvOA
 vg5lN5n4+l6QpPq+yIie1rcNw53zTol3CKDNr2iDgIbfHB6474PzJGawbaYJ6GqaTPaJ
 crO7sQNxdA2cjgUR8crgwl2yKEeXuvY2dd6onbfHaACXNfYOGM5jpYpp0EbgrvbfT8Iy
 p2JNubd1m1SyDPeCtuwoOjDNuU8BQYyAXVtRoBahzUWj7JUU5/9B/VECfJ6/S+QNchVM kg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmhu2m60e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jun 2022 20:39:47 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25DK67I6030909;
        Mon, 13 Jun 2022 20:39:47 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gpbv8s4jf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jun 2022 20:39:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DuWXbFPhcgSuhMaSAQFtBcoA4DBV0KNr+NzbV/XK3NlRRsJ5vR2n47WwvxxVxRa3G8X1sjiOjZxRtwJpv4oQlQ1Lrz6noe9WF9lPa0eFubegqmSV8/4hkvSyaLN/sZeVsRfWy4+HKfitNCVp5VUbWyaO1ESE45dRAZChIQXLvD2Op08Kyc1TyrwRgKaQwstQbzkzZB9jmqn9IK8U7blPzzjLG/DwQOm0XAmEtW4dAih2YeZBZVu0AZOv08LMZmBLOoa3HiKKI6NRaWe5RA0JgD9bNC8raSZBNE5CF6Y7XMGUbubLhvaomkxwzgH86W9+5KETc6iMHiKKkzT7UYDzrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IHZkHx6v0qzdiP34i4TVymbJ8CxsQitipHlwxsCMgjw=;
 b=WRBceQWFRn6iFrKqsoRR1BqBfGi/kgoVuTtaz/pW+TEQfipGVFMnLJjRxEtriYqwVGVXapYgcZqm0hd3+LmHl8aCK0sNHjVWSLBMiEdrOUuNP6mXxk5QTBWfjm2mevlHDGJGuttOyAmFJVWszEuOs6Cm/g0vvBSi+0fnd/EBOdhgSWiXB6xqhqJCv1x/jaZ0vJI/IxMH5Yr9kFUThJr+tblclyjolDgI/ntII+3hfIzOtY+e6WKM5rzHhwwMbkFFGX6wWTpN6R3t14FdzT1fX1pUBZpjQJEy6hBxOGTZvCY6fbHqYQiN40QSdMrtL3ZnCRLd9c1amQomSp0LLUxTFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IHZkHx6v0qzdiP34i4TVymbJ8CxsQitipHlwxsCMgjw=;
 b=VD9s0q6m/NYMvs8O7UQ72e0CKt3bHYBvMAxX6zCoXtyqpNZPoL5Jev7Q1VMmgkGqzZc/3jJkq0PqZ+4JFJtTvkCtqYN2+n+DsJOejp0Bzs3TCChuYuWbeb03W6ZV0gfchiBKm8YledVG/M5NsdazB403uu+TWjISApJ/JQb54Zo=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by DM6PR10MB3964.namprd10.prod.outlook.com (2603:10b6:5:1d1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.14; Mon, 13 Jun
 2022 20:39:45 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::4d84:324a:aeaf:8f2b]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::4d84:324a:aeaf:8f2b%7]) with mapi id 15.20.5332.020; Mon, 13 Jun 2022
 20:39:44 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     akpm@linux-foundation.org
Cc:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Dave Young <dyoung@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Bixuan Cui <cuibixuan@huawei.com>,
        David Vernet <void@manifault.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH 0/2] Expose kallsyms data in vmcoreinfo note
In-Reply-To: <Yo2W3mH/5uuAJyw5@MiWiFi-R3L-srv>
References: <20220517000508.777145-1-stephen.s.brennan@oracle.com>
 <YoTIMEPAxLF9t2eo@MiWiFi-R3L-srv>
 <878rqs163s.fsf@stepbren-lnx.us.oracle.com>
 <Yo2W3mH/5uuAJyw5@MiWiFi-R3L-srv>
Date:   Mon, 13 Jun 2022 13:39:28 -0700
Message-ID: <87h74os3gf.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0095.namprd05.prod.outlook.com
 (2603:10b6:a03:334::10) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac4eef45-5c08-433a-f457-08da4d7cd95d
X-MS-TrafficTypeDiagnostic: DM6PR10MB3964:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB3964CD90F5F0C0CEC96A669DDBAB9@DM6PR10MB3964.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Mcv8vzk+K2D6qigyX7OhfdIo7Fdf6KIML+Mt8e3MjV+k4qg1B2E72dQ0UAoZ4UZzAjKAg7oyKldsz1Zgk8Hr8Tin2P/cK5f65gAKGVJiI4GEY//t86hVRlYaEuhk+hDoZV20ZiL1jFMqamBOyy1h2hkfpDIgMg2tOiB136Lli297gAEBYkVyNI22zxf3qGl7//Derc31SKkVUA/YpgH1Kv8Hu0bZKmyBiVEbHYRvDPVR7dseks9nwhCQJpXsPIQZElEH0WKcjNt+6OYlvzTsQXU94uJgHHzzhhFXInTIvLgPWwX6p1/gWVLsb3cIcW3lSFY/AV4e6HWpZJ9zaji/OiMJeFaMUfI+alY63HH9NT19Ra3IUQXiT6q4VR+IN+5eYwWVwWhJ+b6BRV5IcxF8R/FBI6rvSqfVY9tEEh6ZYpIWOLZQTrYdjpIhal+bI7YBUzAaXQgOrorF+LarxSF8a+dTA0KM3AV+rNKXswBMOUvPgXY0pcpDjUKcBMl09YsLqAxmbW2aUt29a4vkXRNDKXqx6+RH+aA8LfkOsuE+hk1OscanI+FUpMJVDXUwWFFH2iGzBG/F3bU8Y0Ksfh+lPi3FQBhZSxTi1thnc/EBfh7AyvOwCQrDAYnmFQfm0R7nHGkQ0PMTtCd7kvd7pNDyg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(7416002)(8936002)(2616005)(54906003)(66556008)(4326008)(8676002)(66476007)(508600001)(5660300002)(186003)(66946007)(6486002)(38100700002)(4744005)(6506007)(6916009)(2906002)(6666004)(86362001)(6512007)(316002)(26005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J6OfQeSHvRwrkunvFJYIUTJ9Xp4hIeuXR78RFJwq5+0lyqJ3wTDzpyvqrKVm?=
 =?us-ascii?Q?I3Wbu6CH8C/NPRxt2ldwKSPow9ku61c5DWVlp9P9pO+N/Tqad0XHnv3aOla5?=
 =?us-ascii?Q?36gi1XEKQGadAutaogHUB5caWY+Fzuc9kjj2QWqAjVixgF55yc2peQuOKt8O?=
 =?us-ascii?Q?TwKQW2ynN/arH4b96dY1Obw1zzghWZwQ2vtV5vg4R17g1TbqAi1B4mOAM610?=
 =?us-ascii?Q?ka5cvvK3B0/hvPB0/k3k3G7HXjGn5nFgfjtBKD1jkCL+/i7TbW9NpYAJPwgR?=
 =?us-ascii?Q?wqH+RY1Q7MLopaJk7m+KSVaHHfQAhxS+Hgs+FxFdADAhaxB7w/OUI2I37Qms?=
 =?us-ascii?Q?9XFst4xmdRVLh40h3iOUnYz+QuN0PCzLMV5jiPkK1HjifTsGVPNA/CCVL94a?=
 =?us-ascii?Q?uznwqn91EzO5L6C1MMbSGggMmphEIshPuA8N1l4EbrkcPaJXZwGyGAgVjNUI?=
 =?us-ascii?Q?5AqbDL+bJHaWffdreeKAGAZHEJ/BTzcer9OMO4n4NAQFj5eYhcjNGv28JAVl?=
 =?us-ascii?Q?FYv+r0fNfO+LdxvyrhafsjS9vgkLjMxDO0Pq4EBB/mIEhVtKAzQ/OPB4klMq?=
 =?us-ascii?Q?iPfjAULy6tFOX5TME3EI0n75rDkEOxjXNuii0FE7w+Q+PmkWx1Pd+JRXDKFK?=
 =?us-ascii?Q?iNzC7PJP8aS7qUSGFWMDvp2bYDRm6ULcZmk9BPF3o29ROGunDWboZYmuAims?=
 =?us-ascii?Q?yS7tspqEaoNMt1E2J1/45gKp7SNZAvV51ZPTFXgkju0b9hs8f2yvXJG4wckJ?=
 =?us-ascii?Q?Hjgfpz8f97JUwJ9kFl3DuBByILxmjYRtdWeBN1Yj3315p9K1pM77vLDRqS/A?=
 =?us-ascii?Q?hLDhVLzmXXQdtatcnYQMADaJ978/Z0WfM1VB9l8ACUZwFAxN3p0CLOsQrnNi?=
 =?us-ascii?Q?72L9OWobPBYv1UnyLLbh6AEaNIdyJX9LNnLhbl/lbvZSqDRR6qJW4vaX6TZi?=
 =?us-ascii?Q?eO1IVfvngdw0Hiag7ovlAVj2iLNSSbXpnqrUnPQ8I6hB8d6wo1xzslB3EIW4?=
 =?us-ascii?Q?hCHxJ2O3kbaJkLgko4RVurkZrnZzIrEHmde9duqS4rlMDP6aCGW5fDZkkWfu?=
 =?us-ascii?Q?kjWkVbnnlnD9guFDVkHoOoQiBq1GJq1Xr8Es915vep8kpbenc/MtpODgV0k4?=
 =?us-ascii?Q?banLly5YDEdoWJ2dRpO3DDqHPOIKcNjIwFeZXFOiRRkpP8ftEYhJ6oUH6YWI?=
 =?us-ascii?Q?WVBX98WiMvfzeKJLz2pnC1JcqnCYwoOjoVQSgd6mSiclXHfzRykv2UN1k5As?=
 =?us-ascii?Q?1Z0drRCey6+7Hjv2SJNlvnjn5p8t3RjNUm3t08n4o8vEefZazdnUDqjjg3sq?=
 =?us-ascii?Q?7yrTjo2nP41VRWnJhv8iw7SsSF7GWm58x1lH/hQ+sjSAXgdq5bpd8CVKwfX0?=
 =?us-ascii?Q?+3WY6DMgbhlQwV2H5Zum3+BcUvaEzgACKTfpWW1U9PPK3yfA+YAwPGGLPwRt?=
 =?us-ascii?Q?5+MHFDQWQoOaoNgHqlpY+iC//j7dIjSTquidUH1Aw/LEGJJGKpiN91yZc05u?=
 =?us-ascii?Q?C19UOU8jyu/QVPOHcgMCSgTIG3LMjUtRO2tkL9F/vU6D/fUU21o1lgm8MXIt?=
 =?us-ascii?Q?9z1nCK7NkYXQEKEW3OxpjohSpVqtRynF/xEbSEeWkkjhSVmOOIRNxULREhJT?=
 =?us-ascii?Q?Fs5ZZ4FDkFifdYGmQJQGPqdsk8W+inhrwg919je5dQx5NoZv/TdtXkD9et+S?=
 =?us-ascii?Q?cfvpLdKH14GZnF8WmDd5OjvYxmVlzpOdO9kKkXBeB7rXZ6un07mvX/m79+0K?=
 =?us-ascii?Q?XmMlBYsKHqaAjvR7L/4cRLn3osRoca4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac4eef45-5c08-433a-f457-08da4d7cd95d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 20:39:44.8986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mQlrbZKvG8UN3gtfPA31Tyx8kDPJ405ue1B+RmO2I/wAd2EDnk6zkpyohey7ovVImkGJ4TkP6Bx1qst/anOqJDfaXgo9bLonzNHjqA06eXU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3964
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-13_08:2022-06-13,2022-06-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=942 adultscore=0
 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206130082
X-Proofpoint-GUID: AMuXnhpaFPID7wHyQCFJBWo2zRSUsetw
X-Proofpoint-ORIG-GUID: AMuXnhpaFPID7wHyQCFJBWo2zRSUsetw
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Baoquan He <bhe@redhat.com> writes:
> On 05/23/22 at 11:00am, Stephen Brennan wrote:
>> Do you know which tree this patch will go through?
>
> I would like to ask Andrew to help check and pick this if no concern.

Just wanted to check if you would be willing to take a look at this
series and possibly queue it up. I can resend the series directly to you
if you need.

Thanks,
Stephen
