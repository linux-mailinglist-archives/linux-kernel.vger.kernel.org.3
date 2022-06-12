Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA0E65479E4
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 13:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236355AbiFLLTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 07:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiFLLTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 07:19:41 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4C85FF3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 04:19:38 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25C7ZGSv017885;
        Sun, 12 Jun 2022 11:18:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2021-07-09;
 bh=gt5R5nAg7lsS4CuAZ0wWnY0WgxcOJjHBE7ZCc9xG8Z8=;
 b=CPy8t/Y/nH5wOp7O5BqDIk/9pbrgZrqgGNfNyfyrsiGkAJBGLH2+6ypWGzszUJaSgscd
 YL+Mabb8pa30H0nLt4n3hyXn9tC36LVLeqGJBBgPh6dbNQzQVQFnuWEgHAgarRj/skYg
 ZMMhSFVwbWKr2g1v+hlKlHoX6MF+0N0cQGavOblHqNTZ1DLfIlJp2sdTWfaiHS+xUpWr
 q2ktUceCE+j0rllYr+njiGWtHnSW2grLK37UogUJTOd53KUblit7cUxTtI+0SmPnBcRf
 /o86eatVopr/U+CDDMO37IYYwi2YBFoaCvwpnD7xEyV7dMS4VNW9y1rPpP6pEnHmieBh 4g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmjns1cep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 12 Jun 2022 11:18:51 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25CBGm0f020673;
        Sun, 12 Jun 2022 11:18:50 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gmhg1hg45-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 12 Jun 2022 11:18:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K5VoUSQbdR9Swxg+177ecxszpoNdqpplguhintsrjE/RpOuBdRHHDzhivrcd91fMlgp4L7y9n5LtxJDU7acL7PHB9eUnHfkj3iIoosVAm/SiU5UqMdf1+F0/TiITHEyokuq2EulfZ3FbV1Nu9Dunu3pAuqWIOdBe81X1LCiT6QbNTD7QSfP+68XvEUuqoBZ9g9QwiR5WySRVCOMW5VZxKIfxe6sMVk1COhpqXSs2EbJnWGqSFy2lwPzUpScZtjIZFRhAYYQSe4163vxItS7FwciM+YgGaY3VTTZfZ3ir1NLCgKzQUVgw5L6WsFugJvuaHWjgNXNeuPsFkRBzIsDKkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gt5R5nAg7lsS4CuAZ0wWnY0WgxcOJjHBE7ZCc9xG8Z8=;
 b=eZMnp6VJBzjFA2hWl1pRK05puPGa5f8tqjCMMiF+nlVORwK5TIr1ZlrT/DYn5b55Zy9TxQgnOx9cfvV7wFiX/eYub9i38wBuGhjXlC4U9wKxDWLcLA1N3jTIXRpzsQKP+AMYkDI2TDYk/cJw3wkZk3LPR0KR3FGNDWhETn8Z8xdPWEVKt9JTxq1hIITlHfb0LQTjgHoUziipQpItxZyyol7gZeJUHbPHKUbl6iibVzTgxCtSM5LhvCe5zP7EYy3Je05xZFyTgFpl1LKRIEGEx0+LUcUTt3CFYSlemtEC7QZA3QGfh10S5veRUX5Vl+3Db7paBOadAf83mTMMpNzK0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gt5R5nAg7lsS4CuAZ0wWnY0WgxcOJjHBE7ZCc9xG8Z8=;
 b=jAVwYr+v2qOC8pl5dSPS4LhCCcDyC9g1i/rNtmDl20FCvITaJzAcJ05HMzcCQ4W91iQCzhSOT1jA5/ANu/SOp0RjGLEDHfPMQlaKAlM3cmnHeJYrBPsYWSQT4giqFS6DRfa/w5XAB4DKAUyLXUF18rXFt9+0zQ0k8PcRLRnzFwM=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SJ0PR10MB5801.namprd10.prod.outlook.com (2603:10b6:a03:423::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.19; Sun, 12 Jun
 2022 11:18:48 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::f501:65f7:2895:5c35]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::f501:65f7:2895:5c35%4]) with mapi id 15.20.5332.019; Sun, 12 Jun 2022
 11:18:47 +0000
References: <20220606202109.1306034-1-ankur.a.arora@oracle.com>
 <20220606203725.1313715-5-ankur.a.arora@oracle.com>
 <CAFUsyf+kDgApUu-q=FOh1WD=yzJqvTSYpHywyNteFubnKFa98A@mail.gmail.com>
 <CAFUsyfJ_vD2sy=V1NU4VZtNWCoTbOK-HNi+R0Cm4_KULS4LkCw@mail.gmail.com>
User-agent: mu4e 1.4.10; emacs 27.2
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     Noah Goldstein <goldstein.w.n@gmail.com>
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        open list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        X86 ML <x86@kernel.org>, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, mike.kravetz@oracle.com,
        mingo@kernel.org, Andy Lutomirski <luto@kernel.org>,
        tglx@linutronix.de, Borislav Petkov <bp@alien8.de>,
        peterz@infradead.org, ak@linux.intel.com, arnd@arndb.de,
        jgg@nvidia.com, jon.grimm@amd.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, joao.m.martins@oracle.com
Subject: Re: [PATCH v3 09/21] x86/asm: add clear_pages_movnt()
In-reply-to: <CAFUsyfJ_vD2sy=V1NU4VZtNWCoTbOK-HNi+R0Cm4_KULS4LkCw@mail.gmail.com>
Date:   Sun, 12 Jun 2022 16:48:38 +0530
Message-ID: <87tu8qnn8x.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: PN2PR01CA0194.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::19) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ab86896-8ce3-4e81-81fe-08da4c6551c8
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5801:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB58014FD286AE9C2AF50CA4A3CEA89@SJ0PR10MB5801.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TVPerpgRFPrXQfNZ3i0kVHZsQV6jfrw+In0BXa3CdpxRTy046e/+eTfsEIL0rZfZW/xlKOy11tx1E3BB8wW+l7hTy3d4vXBJaAb9kBC2E7490uBv+1srGHDbGFttHGAbw2lCQUiXy7pyBKzUAdMg9520M1GYkFkdSZUXDLphhw1Znw2aoHgMGyYj1DTr5ILxOTrBb53eg8Usqu/PXMJ8W9HKHdheLn+umgCWfp9XRx9vD46dPhA8LmDpTwNgwALHLC8XsCo/pyMM1A7N9OW8kOnTG4E0buV8IRqQkRzVIqsI0b4al6BvYCSq7BdNAc++7sYpU2S/m+Xez06sIlL6fTbL1ttazCugyIVnAFEUqO+yWve7EbObYAvxhaFvEz/F4MGhzIHymUjeOUQtnnl0VDqZjLElUSa2+ggkSoR9zFtJeuaX/D+rCBL80g3Pt4JvBCMalNvkmOYDj6hgWC68m25r86koc39ZFQvpJfjSmMh7YUWvO3sm5U/Yn+bV4VgLnKmhsZBokqthaTDpoIylQTsxPF7OkopG6S3Wq8pd1LBIA8+/zfFMZ0OHB966rzeeZgpB4mAvZ6HvRe/mg8am0fv+S8cwMpGM9EklPqR54q199wQqwikkJpd25UbzSQQZjTRHQYkcBXEDWmzTBNRFNEGv+2WUmfzRRG8wOodJsJd4eOGEOhz258n/v5cPo+raal6zjWMcu8l+M5mTsvJV8kaITyFqe1oFZBAJUIMbEnM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(186003)(2616005)(107886003)(66946007)(2906002)(6916009)(54906003)(86362001)(8936002)(6666004)(316002)(38100700002)(36756003)(6512007)(83380400001)(52116002)(7416002)(6506007)(5660300002)(66556008)(66476007)(8676002)(4326008)(966005)(53546011)(6486002)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JlpDmNHQCIT5n7XfHEoY8j3j/T8QIlhROrevoqHW8kMDYcjsdOtDTfTVdPQt?=
 =?us-ascii?Q?5125C3Gh+IoNtgsDrN5yympG1X2jBc3kw7x4s2e4bfu86Rc4X4OBWeYab0TU?=
 =?us-ascii?Q?lPlpu3nxobi2ZIOS6COBmKNdmUN4F2YWOsymKJzz29kzcDfuFtJMCu1G0/Vj?=
 =?us-ascii?Q?TTCXJlGBhgDzULhxQm02afLcOBO/xOzUDB8RuDT2pQ1owKsw5LTx+PgSDOHf?=
 =?us-ascii?Q?U6KkamRQHcb14WHXOfDEfjnseMvnA4t2VQ91jdmqiPRT3JuDMqrdiwMqVlDb?=
 =?us-ascii?Q?MaJ26k/BLp+D/eKHzKCtx5LkGi8I44Q3mGwORy+wvb060fCdNw+XnUfk1GoQ?=
 =?us-ascii?Q?vfCAbFXoFi49mgbn6CwvTQhPqt1EBQK2SmS4nWzCEMuez/ZH06yorZFvF17J?=
 =?us-ascii?Q?Ircc1PofDHoXfzIl7tOvDX9K18dVQyDsJF1jpC0M6I2loSb7B991IBszUNNU?=
 =?us-ascii?Q?brhyjW/pnVpYnrc42HdheOpTUxa59CtgAoxvBu/sTtPs+BmpR6LauhaOrom1?=
 =?us-ascii?Q?rB73LuzYpPR8T5icdJ8da7uEyPjqyXVgcMwPqg55DtamXKc/sIODhbHgrQi8?=
 =?us-ascii?Q?zB70uFjeJFLUjPOOXUWRAT0T8DDrRlUvKQuUDCnxSjf4X2Ppd3vWoDLJUEm6?=
 =?us-ascii?Q?3Tgyib1C9xTqcIwD9MNx4zkLS6pmMPsWh4vPApWiaedq0dMKM6U8hJT4wqIU?=
 =?us-ascii?Q?E/s1zj5+972EU6fQDl20833pOU1hMy07z8ZI+AOGvsq2uiCQ888r5N3rS5rJ?=
 =?us-ascii?Q?MVxnAASEen7rvOgiAEUjI9+O5wp2Ecqq31x8391qQCB27ATmv4sWkD6KS/C4?=
 =?us-ascii?Q?ucErJ5NqC3MkPwnR40sgHftt87D7BZB0xELhPXNU0Uk0HvJQo3NSofSUbO9c?=
 =?us-ascii?Q?ZTDC7KZt+vo5o6teLrKINf8lCK8k2uURs6ttlN6ZBixA2GqjvnSxjYf0A66O?=
 =?us-ascii?Q?7eB6N4vQx/2qH6S+Pt9JquMsoJ9x7M3EY3nIE0j0jvjrxX1CJTxMG7Anl1N1?=
 =?us-ascii?Q?8AvEJtqGx7YYSl1VmDnnfN9/OzsDGRR88JkPo9rbgASXK77mNiEzOjprVLDU?=
 =?us-ascii?Q?3+oO/kNEphpv5w4DX1RfCIkq53hboHNe+hpgAeJD6ax5C0kycvI8xX3Q9r9I?=
 =?us-ascii?Q?nuKL5Zf0ukZI0ABD5g/+M5PnWw0XkrRwCW4SkjyA+U+8BnTbl+eFtYDF0+u6?=
 =?us-ascii?Q?wU5N6pc7z1AvzgW3lxd/AhBNUiapO0TevrWxOGnU/27KYM0cDMqyBul/p56E?=
 =?us-ascii?Q?WoMxzdsWnopr6v4sk6SrfvgQzWziTkKFOI/a4ACWc7Ee5NebC0m9s9ZWdFf2?=
 =?us-ascii?Q?BUAOgaC6R2qDo1/O0lA/JsMNbXzpRg3kQegYLRmJu8Burj6m5VkJ+4YJywwa?=
 =?us-ascii?Q?GBLgx0uAiURiVCx0IftvqvAA+sgfkYXA+SQgHOVr9BE+fzhyw8Md57Pf2o6E?=
 =?us-ascii?Q?zW0w/5AZUwZXiL2kClD0N+LOps4nJVYMh/AvsT08LTX1FP0VCUpGMvt/noAK?=
 =?us-ascii?Q?nA4je7zTO4KbJ0GSZxYugb4AUhxnwwV64tKfL9Fvvf+fziR2Ak8MR9H8SrFc?=
 =?us-ascii?Q?mrK4hgwCd7uvbL6bu7/OYFkMgnpegem5BeqckqYfjekcgIkQxcufMY8yjMB7?=
 =?us-ascii?Q?S9Emci/tXRXK1Ne6/kPXptWKjLWNu2KnsRuYNhcDKbYNzWZGudX3S6ru1nSM?=
 =?us-ascii?Q?dcW+9gO90jwsiqsxXVxF2IzjRDFR28p1s7vIg8DUmqUeOl040ChV4HCsQzCG?=
 =?us-ascii?Q?hBY+a/GQbuqcdI6fKRTgrtK6OwBZ7Ih5bE0hycX5m9DmFSZONEVRklc5ZUe7?=
X-MS-Exchange-AntiSpam-MessageData-1: fMtERQrcDZDj3EBLUzvIHkq+pQGbjchCv2w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ab86896-8ce3-4e81-81fe-08da4c6551c8
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2022 11:18:47.8692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zXMrRtiBP+NYrOZFYV2sXYI9SGyDoQPbk2udW8DBhWs9gIHs/WnFD+J/tW7jWybKEqven3nydAlBXGjnnx+v1Xuz96UC6JycJ0skcCLiew8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5801
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-12_04:2022-06-09,2022-06-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206120054
X-Proofpoint-GUID: LJ3txGRqM8-oo6L09tU3Jr3uX1P2xALf
X-Proofpoint-ORIG-GUID: LJ3txGRqM8-oo6L09tU3Jr3uX1P2xALf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Noah Goldstein <goldstein.w.n@gmail.com> writes:

> On Fri, Jun 10, 2022 at 3:11 PM Noah Goldstein <goldstein.w.n@gmail.com> wrote:
>>
>> On Mon, Jun 6, 2022 at 11:39 PM Ankur Arora <ankur.a.arora@oracle.com> wrote:
>> >
>> > Add clear_pages_movnt(), which uses MOVNTI as the underlying primitive.
>> > With this, page-clearing can skip the memory hierarchy, thus providing
>> > a non cache-polluting implementation of clear_pages().
>> >
>> > MOVNTI, from the Intel SDM, Volume 2B, 4-101:
>> >  "The non-temporal hint is implemented by using a write combining (WC)
>> >   memory type protocol when writing the data to memory. Using this
>> >   protocol, the processor does not write the data into the cache
>> >   hierarchy, nor does it fetch the corresponding cache line from memory
>> >   into the cache hierarchy."
>> >
>> > The AMD Arch Manual has something similar to say as well.
>> >
>> > One use-case is to zero large extents without bringing in never-to-be-
>> > accessed cachelines. Also, often clear_pages_movnt() based clearing is
>> > faster once extent sizes are O(LLC-size).
>> >
>> > As the excerpt notes, MOVNTI is weakly ordered with respect to other
>> > instructions operating on the memory hierarchy. This needs to be
>> > handled by the caller by executing an SFENCE when done.
>> >
>> > The implementation is straight-forward: unroll the inner loop to keep
>> > the code similar to memset_movnti(), so that we can gauge
>> > clear_pages_movnt() performance via perf bench mem memset.
>> >
>> >  # Intel Icelakex
>> >  # Performance comparison of 'perf bench mem memset -l 1' for x86-64-stosb
>> >  # (X86_FEATURE_ERMS) and x86-64-movnt:
>> >
>> >  System:      Oracle X9-2 (2 nodes * 32 cores * 2 threads)
>> >  Processor:   Intel Xeon(R) Platinum 8358 CPU @ 2.60GHz (Icelakex, 6:106:6)
>> >  Memory:      512 GB evenly split between nodes
>> >  LLC-size:    48MB for each node (32-cores * 2-threads)
>> >  no_turbo: 1, Microcode: 0xd0001e0, scaling-governor: performance
>> >
>> >               x86-64-stosb (5 runs)     x86-64-movnt (5 runs)    Delta(%)
>> >               ----------------------    ---------------------    --------
>> >      size            BW   (   stdev)          BW    (   stdev)
>> >
>> >       2MB      14.37 GB/s ( +- 1.55)     12.59 GB/s ( +- 1.20)   -12.38%
>> >      16MB      16.93 GB/s ( +- 2.61)     15.91 GB/s ( +- 2.74)    -6.02%
>> >     128MB      12.12 GB/s ( +- 1.06)     22.33 GB/s ( +- 1.84)   +84.24%
>> >    1024MB      12.12 GB/s ( +- 0.02)     23.92 GB/s ( +- 0.14)   +97.35%
>> >    4096MB      12.08 GB/s ( +- 0.02)     23.98 GB/s ( +- 0.18)   +98.50%
>>
>> For these sizes it may be worth it to save/rstor an xmm register to do
>> the memset:
>>
>> Just on my Tigerlake laptop:
>> model name : 11th Gen Intel(R) Core(TM) i7-1165G7 @ 2.80GHz
>>
>>                   movntdq xmm (5 runs)          movnti GPR (5 runs)
>>     Delta(%)
>>                   -----------------------       -----------------------
>>            size      BW GB/s ( +-  stdev)          BW GB/s ( +-
>> stdev)         %
>>            2 MB   35.71 GB/s ( +-   1.02)       34.62 GB/s ( +-
>> 0.77)    -3.15%
>>           16 MB   36.43 GB/s ( +-   0.35)        31.3 GB/s ( +-
>> 0.1)   -16.39%
>>          128 MB    35.6 GB/s ( +-   0.83)       30.82 GB/s ( +-
>> 0.08)    -15.5%
>>         1024 MB   36.85 GB/s ( +-   0.26)       30.71 GB/s ( +-
>> 0.2)    -20.0%

Thanks this looks interesting. Any thoughts on what causes the drop-off
for the movnti loop as the region size increases?

I can see the usual two problems with using the XMM registers:

 - the kernel_fpu_begin()/_end() overhead
 - kernel_fpu regions need preemption disabled, which limits the
   extent that can be cleared in a single operation

And given how close movntdq and movnti are for size=2MB, I'm not
sure movntdq would even come out ahead if we include the XMM
save/restore overhead?

> Also (again just from Tigerlake laptop) I found the trend favor
> `rep stosb` more (as opposed to non-cacheable writes) when
> there are multiple threads competing for BW:

I notice in your spreadsheet, that you ran the tests only until
~32MB. How does the performance on Tigerlake change as you
go up to say 512MB? Also, a little unexpected that the cacheable
SIMD variant always performs pretty much the worst.

In general, I wouldn't expect NT writes to perform better for O(LLC-size).
That's why this series avoids using NT writes for sizes smaller than
that (see patch-19.)

The argument is: the larger the region being cleared, the less the
caller cares about the contents and thus we can avoid using the cache.
The other part of course is that NT doesn't perform as well for small
sizes and so using that would regress performance for some user.


Ankur

> https://docs.google.com/spreadsheets/d/1f6N9EVqHg71cDIR-RALLR76F_ovW5gzwIWr26yLCmS0/edit?usp=sharing

>> >
>> > Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>> > ---
>> >  arch/x86/include/asm/page_64.h |  1 +
>> >  arch/x86/lib/clear_page_64.S   | 21 +++++++++++++++++++++
>> >  2 files changed, 22 insertions(+)
>> >
>> > diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_64.h
>> > index a88a3508888a..3affc4ecb8da 100644
>> > --- a/arch/x86/include/asm/page_64.h
>> > +++ b/arch/x86/include/asm/page_64.h
>> > @@ -55,6 +55,7 @@ extern unsigned long __phys_addr_symbol(unsigned long);
>> >  void clear_pages_orig(void *page, unsigned long npages);
>> >  void clear_pages_rep(void *page, unsigned long npages);
>> >  void clear_pages_erms(void *page, unsigned long npages);
>> > +void clear_pages_movnt(void *page, unsigned long npages);
>> >
>> >  #define __HAVE_ARCH_CLEAR_USER_PAGES
>> >  static inline void clear_pages(void *page, unsigned int npages)
>> > diff --git a/arch/x86/lib/clear_page_64.S b/arch/x86/lib/clear_page_64.S
>> > index 2cc3b681734a..83d14f1c9f57 100644
>> > --- a/arch/x86/lib/clear_page_64.S
>> > +++ b/arch/x86/lib/clear_page_64.S
>> > @@ -58,3 +58,24 @@ SYM_FUNC_START(clear_pages_erms)
>> >         RET
>> >  SYM_FUNC_END(clear_pages_erms)
>> >  EXPORT_SYMBOL_GPL(clear_pages_erms)
>> > +
>> > +SYM_FUNC_START(clear_pages_movnt)
>> > +       xorl    %eax,%eax
>> > +       movq    %rsi,%rcx
>> > +       shlq    $PAGE_SHIFT, %rcx
>> > +
>> > +       .p2align 4
>> > +.Lstart:
>> > +       movnti  %rax, 0x00(%rdi)
>> > +       movnti  %rax, 0x08(%rdi)
>> > +       movnti  %rax, 0x10(%rdi)
>> > +       movnti  %rax, 0x18(%rdi)
>> > +       movnti  %rax, 0x20(%rdi)
>> > +       movnti  %rax, 0x28(%rdi)
>> > +       movnti  %rax, 0x30(%rdi)
>> > +       movnti  %rax, 0x38(%rdi)
>> > +       addq    $0x40, %rdi
>> > +       subl    $0x40, %ecx
>> > +       ja      .Lstart
>> > +       RET
>> > +SYM_FUNC_END(clear_pages_movnt)
>> > --
>> > 2.31.1
>> >


--
ankur
