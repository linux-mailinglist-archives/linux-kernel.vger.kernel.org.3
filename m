Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8575479E7
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 13:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233452AbiFLLU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 07:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236375AbiFLLU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 07:20:26 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6054FC56
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 04:20:25 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25C7QT4h023173;
        Sun, 12 Jun 2022 11:19:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2021-07-09;
 bh=8KoIYVRHYFcebR3Q+oQ4qsSOm2o8rC9DwtjtDsbg6TE=;
 b=UXxXzTgRiylCn8n41xe+tdn6Wh6HxI7IUeRXiKhdgHhlXOWPxQ7Nt8+H9SFoANgVvqW6
 D985aDkKdsDT8lGIbyWbTr0T/oqdOQ4xfF/5Y7vstFNhFYt0+Az2NakXHrbCbXs23GNi
 bDR8maYQe9pcZ2DFdNx4fPLilgPoaGvBdXPWSqHFCagqAXoO7tfpwa25/OJLYMhg/IUU
 sOQtZJqcJ/2sIryBn5eT7dpUrzlnbY9GJ/OkA+FbEZzhgwTMFvbh26xZISV52fAxvGRA
 MEFPBETQkvbBnn4QVNXU9XhUG08HhT0o6zbByofBDsYSOOyWutYhIlm2dMVWS7McrEYn fQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmjx99che-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 12 Jun 2022 11:19:43 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25CBG4vk038095;
        Sun, 12 Jun 2022 11:19:41 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gmhg8e237-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 12 Jun 2022 11:19:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I0ceQU0S0nS1vVQYuRJObfaojh4lniNt7nBfF/8p1Xi7CvsC0/teii12A7jtYruAdJ1EcbcDbbsMBo+iCcB6+HWxLPZKUVuYJBHskif/5FMUisdZ+IU+4/Simoj/4II8Tmo3XdO0DaD4YkgkaYlmAw/YKH/mKIlAFGt/vVdmGGDbLfnlM39fnXQaZFFz/+U/mTD0zRGbEpeJru2xTuo6KFhNIl2NwILdZLILQflAhM5BC7/8RRRYYdxeDDozBGn/0WcOQ072L/GL1l9YWTUf8acYGKcV9vr0p29vT4o2PfDjaxrYCXItI/Gt1tPQZrv0FN521RgNdMO+z+v5uikHfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8KoIYVRHYFcebR3Q+oQ4qsSOm2o8rC9DwtjtDsbg6TE=;
 b=JpzQQrc1ejRBi0Ap+GqEVFizjECaYU6sW6Zzm+CxestRtdIed0JilsyfzJ8WZUaKXpnce93NITPvRkzf3hcdUXxdnpgVRL/fDkgKdzSSC9euUFDAWWTsap3r7ly8QfRTXpOJTHIlR62dCkLJwNc+oMwOjBjjc/5gHKGizaZ3o4Ke3ZZ0BAXuvgvJl1stGfYcc5QTlCgNO0+9v1QkW/IFi/L5rJcZJ87fAEkeWAJhA2V8QQQ6dLy1TthAcq9l4dXGaPZzQR3cFtME3V7b0ljgR9uhdshxOX5l3ZRSa9SWDD5UElCLoUe7CF7GsTWtErTrIfzs0Tcf2RG2rc381mzlGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8KoIYVRHYFcebR3Q+oQ4qsSOm2o8rC9DwtjtDsbg6TE=;
 b=C3oS/nd+7/tmMZmAqK0B/+56JI5gUBPNyyoqWH4SYU2xOQpKDch6lBelKP7OnATIls0Oa5c407pmizlplNthxYwib21wEN46KwxKIWl18V7gYB6MmbOVPqmGHp9YevHDnk20PVBxzNGPFndHEMyfHuiiDoflhNuFUwOIRrIYwPo=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SA2PR10MB4556.namprd10.prod.outlook.com (2603:10b6:806:119::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.14; Sun, 12 Jun
 2022 11:19:39 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::f501:65f7:2895:5c35]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::f501:65f7:2895:5c35%4]) with mapi id 15.20.5332.019; Sun, 12 Jun 2022
 11:19:39 +0000
References: <20220606202109.1306034-1-ankur.a.arora@oracle.com>
 <20220606203725.1313715-9-ankur.a.arora@oracle.com>
 <20220608000125.na6z3niyv4ty7xn7@mail>
User-agent: mu4e 1.4.10; emacs 27.2
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, mingo@kernel.org, luto@kernel.org,
        tglx@linutronix.de, bp@alien8.de, peterz@infradead.org,
        ak@linux.intel.com, arnd@arndb.de, jgg@nvidia.com,
        jon.grimm@amd.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, joao.m.martins@oracle.com
Subject: Re: [PATCH v3 13/21] clear_page: add generic
 clear_user_pages_incoherent()
In-reply-to: <20220608000125.na6z3niyv4ty7xn7@mail>
Date:   Sun, 12 Jun 2022 16:49:30 +0530
Message-ID: <87mteinn7h.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BMXP287CA0011.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::21) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e6df70e-e067-4524-d922-08da4c65704a
X-MS-TrafficTypeDiagnostic: SA2PR10MB4556:EE_
X-Microsoft-Antispam-PRVS: <SA2PR10MB45567684B27E18E330DE103ECEA89@SA2PR10MB4556.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CHGQNTt9li7zF/aMIP/xm71+kplA+ISnJWsbqeW2FFWSrj5ioePP0NYQD7RvxHqin3WFDx1Iu05jbEB3fvEtdrJgLB2iiZU0J/K/x5YoclNME8LfYJd/R20zfRg+/hRMFESBu1joQbi+TG7ZyU7ZS09hfzwEMnuiJwzNzVZmgncU2bx9+zSq/8+FudZib9hKKSVt9JwCzI+jVYdg3zJMLNB4YwFhNE4kk1y45uKaQGM2eSLS7sBo3bBcNkZ/zf1Goe8rFNQ86+Nv2pjb3kLkxzDDZomuTGcL5kgHBOFhqWH2V4EKGFzEdvRpaJDJXXhZY3W1ly0Euq1PcjAMQmrxz4Smkk6F4vaMHdisbv32sl9vGoRgKpUTorzcanjtDJNfx6WcXtCe1DQT+AUToX0K4B1GqValuQjH3mmNuvbI4G0SYFtvxa7upMXYIfL1QWNrMehAycgZOILP527z8PUC/UKkbij5fUyyknG+OvAQQpw5EQEHW3fKnG4Y9lcBeOy/9Ofx144Jyj9iqkYBY7eO/KmQgvw3Uj9JLfzj5jbWEgDwV6BjLUDoTCtgkeZfVzEVcyv4cfW9+ZYKcAxegJBCZY2MkMiI7CHYX3P/rvc50docJKSQF6OKt2TvcHF3jnjcKSNag0RZ+8RrdLS2X/aOgpkGxkj18CV8F2TUZArwIAbyyCLUq7XV8fYmkmt30JBd84ExshMBKj637HrD6lnJvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(6486002)(4744005)(86362001)(186003)(36756003)(8676002)(66476007)(4326008)(2906002)(66556008)(5660300002)(7416002)(508600001)(8936002)(6916009)(66946007)(316002)(107886003)(2616005)(52116002)(6506007)(6666004)(6512007)(38100700002)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/hnVryKnye98wUQqJajis7lSHhgdfkIgrchQe9XT8h23viVsC6sxyeVF24Oz?=
 =?us-ascii?Q?kxckCQji4qg8ZGCffNu5XKB5evcQO75gqQpHzTwOFtBSvvI3Sbt4vvcM0qGW?=
 =?us-ascii?Q?1wCZA5fVqnxSuY3yPN+E6qG5jqXlZHH0JYPZJHQ9F9aiO3cJjduWdhbJHvuY?=
 =?us-ascii?Q?O3xlWGntYQm0qG23f0/pgbANvXBn2AuzfqigjglODySqKUMKnxShnItijzF8?=
 =?us-ascii?Q?3A+gcukaIB8JVFrZKe4tL0MXkVWKOQAJj64lVwr8sl20C1QA62Rl+EJt2BxS?=
 =?us-ascii?Q?iHJt008+BoELKQBMFzwmQds759aUkwXx0wiY2m2unFnfKP8uN2PczvO3YWhS?=
 =?us-ascii?Q?JgDcSx9JIt9Ftv57fT/9Y7j4gmn1GrrIlEEPmYu7+e+Wx9is6aRLPcOdUaCT?=
 =?us-ascii?Q?HipsNwizH2KFxAb3NPh1nv3f52AD9U+DMD0VPtFs3eEDvPWjNE3J6KpUEj/K?=
 =?us-ascii?Q?ONzXFcYGcmqLQSpUlohRXjp5MgycKix9jgKYwvMJyy2GiBTrbVHVKsRK/ayy?=
 =?us-ascii?Q?FKLIQUEjvwaHCZ0GM03TISY1DAR6mkPaokzfX329Z8HMgQEdrk37j5HvuuTi?=
 =?us-ascii?Q?M6BlzFltxlWfzpv6eBGeAKGEyY7cYQqJ8hvB0pXE6GPBB427XtnsOFA53SHp?=
 =?us-ascii?Q?ry5iYGjN7uiT1FwWInsUmBXbQoV/JIEJxCYhg4tfN2tHEFwMOu3YMtkvsm0v?=
 =?us-ascii?Q?6BAnapPqU9MZthOV4bFLBqO+3oVBwW5gVhM4pzYY20kaOQP+I9EA6D2apaqU?=
 =?us-ascii?Q?UEQADDdjKQQTk+G0SQTv0tXEkZ0t2v3d7LxNwHO9MeHctVUZK2Zgcc6nRyRO?=
 =?us-ascii?Q?/N6HoXRII2+SN9SXRHGCNhdpLzZgdhCFrOlNznGsJyDVemew6OUEx3BsWDJv?=
 =?us-ascii?Q?5S5KrNlNxF7wFBA0ODyPRszDEyk5U0c7EEmppnrAeEVV6jHqqtbs0mxgr+/D?=
 =?us-ascii?Q?sORma75ciS7RR9uNgQPhxlGIMkGYCsxfYDMw5RT5vj1LAl671LiuuJ0pft28?=
 =?us-ascii?Q?FKrAsh3627cLBv8F8A7+EjJOwoI5BhkJS+y6n90DF9++sNDrxeNnYO+mMcLo?=
 =?us-ascii?Q?tkh9PeCLHy0xqvwk1sxM3t1O/b2s9myNsEBwBGV+HzFW/LX85K1iXIMlkhA0?=
 =?us-ascii?Q?kIz7gGQc1myQbSx55IyilYq8TmJc9EHx1xYFVek+3qZII2zSUyhtPnKKVQrc?=
 =?us-ascii?Q?Mv/P/LYKrqrFFXUVczu2g153+EV7Psyxej2QLZSwIVBtolWjv28DKKJln7+G?=
 =?us-ascii?Q?ZD1E7F90DqplpzAaDjs2FaY9VBv+XqKoFmlbTBEtxvLwjLRz2+Xql5pmShf6?=
 =?us-ascii?Q?55W5/jt2xw3b+wUWKlDX2dqBw+ojD/Hz8IdfjfX87uKgDHScypGh7Lvps0K+?=
 =?us-ascii?Q?rDvm+z6D0C56/WKbxujpHA/tkbfBUpkej27Izj3rW+HDz+0m3NAof5/TdnVs?=
 =?us-ascii?Q?3PC3VO4y+mLFBYregTKwRW8uXO1yw3pdiKy5nbg9CXqQFqFx5lAHIMdIEXh1?=
 =?us-ascii?Q?DMobapgcTScjZ8f9OSNy4P7/ngAXz8uPS6t86va/Ko8OoR0FLDPP7vsT5XXK?=
 =?us-ascii?Q?pL1TyffJRvpGlNrxGjdiie3qnM2xhk0nTEACD2BlZjysmUjdQXsR7dbFHuF4?=
 =?us-ascii?Q?8/2SesDVCxvRR2lVx2WXsfPUA/qfqvH8+Fs6mQbyhq7w1bS6z0NgQ7eBLPDr?=
 =?us-ascii?Q?H/14K+UG6fwNRXHxMWGyeyhn4eNDFJ5Nc6TX6jnAiyH7FIxPWZCqVyLAVF6v?=
 =?us-ascii?Q?379M8qWqwqQZWhU4DBrig/MpM2Gl+frHNyT7vZgLvXx5u0EaO4otE48M+rIS?=
X-MS-Exchange-AntiSpam-MessageData-1: rwEn1xwCJPAtxcJLUaMnFCuxzmGXiXIDHVU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e6df70e-e067-4524-d922-08da4c65704a
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2022 11:19:39.0238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hvJ47w6F1nIuizzJmcmbBk+vjK18HoZbMvdp9/BjvhvwfkMttufapLsJGsgVr9C711bjwWXE39CVUfYjTWOkG0zzpglDm154ruQEeGXlcjc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4556
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-12_04:2022-06-09,2022-06-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=929 suspectscore=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206120054
X-Proofpoint-ORIG-GUID: B9pdLfRNhLKGACBUCFWPxvzvEbFkYdZI
X-Proofpoint-GUID: B9pdLfRNhLKGACBUCFWPxvzvEbFkYdZI
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Luc Van Oostenryck <luc.vanoostenryck@gmail.com> writes:

> On Mon, Jun 06, 2022 at 08:37:17PM +0000, Ankur Arora wrote:
>> +static inline void clear_user_pages_incoherent(__incoherent void *page,
>> +					       unsigned long vaddr,
>> +					       struct page *pg,
>> +					       unsigned int npages)
>> +{
>> +	clear_user_pages((__force void *)page, vaddr, pg, npages);
>> +}
>
> Hi,
>
> Please use 'void __incoherent *' and 'void __force *', as it's done
> elsewhere for __force and address spaces.

Thanks Luc. Will fix.

--
ankur
