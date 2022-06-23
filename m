Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641A3558A9F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 23:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbiFWVVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 17:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiFWVVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 17:21:49 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A9A62BD4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 14:21:45 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25NKO48X021387;
        Thu, 23 Jun 2022 21:21:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 subject : from : in-reply-to : date : cc : content-transfer-encoding :
 message-id : references : to : mime-version; s=corp-2021-07-09;
 bh=O3pnt6qbSEP//AB578lpa5igH4gBKNg9xNS9SyJcaB0=;
 b=i8oHQksPSGgbx+ITd2PpPSVJepA3UySnUpM+yFjLs40muxDwx+N+Crf4tVs9sHuKFz8U
 l3h8nEzyUeoz++vP9ipRVmhL+qqjHb1JRTXkdY1YFtyFgiTfi0pLnkgvtw8chAtGoLvM
 BmqJbFmPD92SqvBdR5eAAYI8FhyAtb9UeshXBn3JOtfAI60189jgPwWzuANGuTTmvtop
 Zqt/kf3DaY6ANQOHmhdbWFRKEH0jQ7Sgh8Tv5mU67wNqRxa9eQh1nPQTEkzB5eOfWL1N
 7vySPm/ITCNNWh/EHIQ1uwMcLTK83JySPaKJlkHICKUM0Sf2ACpEwABl/t+lH7nGWFEt 7g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs6at4bfp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jun 2022 21:21:22 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25NLAcM6020463;
        Thu, 23 Jun 2022 21:21:21 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gtd9wpfxj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jun 2022 21:21:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hwlYor55WMvvS9D2uZZgoEtqKhPGYW6qyyxTDq4wTsAgfXyS6zXcDy3QSff+kfa7LOZfIAifrURZp82xyuFlVybntoFZ6N6gxr+A6FJtRdXUPNGhU0cytT3qvyUuUzNEraGM6TSU0RJzhV9SdzK34G7RhNFhouEDAEOKqcgZV1YwPVlLwDqDR9PIGlipFmOGm7OFrtvtDY8nbOwjOwebcdCxM6eMzRHQ/ZFM5tPV3708kNPV3iX97ezq10bZPV1oiflixnVC8Hc8OhqFCmy4O4h+FZI+ZEnk+EC1rLvRe75pgxaJdjBRFDhi2qsjrQlaY8LhaWE+9V1vrM9q2OV2eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O3pnt6qbSEP//AB578lpa5igH4gBKNg9xNS9SyJcaB0=;
 b=Jg8gQxQk2PQFomgfDzyZqRlohAWTwCRIBLyLsFFTrdVJYqItjn2V1yK8gsNloZG+Dq6KSjYcgf2qkrWmypQMCYHmw0ygT4dQ2EYY1rsFHYT9jfu0V98wJXrXmNUDbifT3ZmCeXctWxHM6ePr+2aF8WJ3tksxdWoETTkSIGLt03u9ld+sL+6uy44JwfGyAxHsIPdyJH19HSu5fqNJtrI8AuXAtsRDSIgp9BKaZcWTScPDLgTyGe5VrITl43ira7QdhDoHQfNzcGdd0MqFqKK1c4YfgnqKKXDaoox6eh5lBSIwA5o0V08Yrxnwvr3dFLxP3qDZCF3ObHl0VJXdVpJ59w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O3pnt6qbSEP//AB578lpa5igH4gBKNg9xNS9SyJcaB0=;
 b=jtOmgqump060Lx9YII8jp74aKKr1ykG7EksUBz2kL3htsOYGHJg6EToXd7CJB6FB3lWdpsTxZttXlf/Hd4NQCv9IW9FRVumKt1O0TJ+9jSFleUPOyJtqAez+Th2akcWar/C/gwdbi8lEXCwVfODBw+OG6hwtBsCsN3/kMbmkeic=
Received: from CO1PR10MB4787.namprd10.prod.outlook.com (2603:10b6:303:9c::16)
 by MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Thu, 23 Jun
 2022 21:21:19 +0000
Received: from CO1PR10MB4787.namprd10.prod.outlook.com
 ([fe80::4970:b0a5:43f3:4be6]) by CO1PR10MB4787.namprd10.prod.outlook.com
 ([fe80::4970:b0a5:43f3:4be6%5]) with mapi id 15.20.5373.015; Thu, 23 Jun 2022
 21:21:18 +0000
Content-Type: text/plain;
        charset=us-ascii
Subject: Re: plumbers session on profiling?
From:   Ruud van der Pas <ruud.vanderpas@oracle.com>
In-Reply-To: <CAKwvOdm=_YqBpuBzouqoWHYNe6MMUE10vqF0PUkU=hcOj+UqrQ@mail.gmail.com>
Date:   Thu, 23 Jun 2022 23:21:07 +0200
Cc:     "Jose E. Marchesi" <jemarch@gnu.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Bill Wendling <morbo@google.com>,
        Vladimir Mezentsev <vladimir.mezentsev@oracle.com>,
        clang-built-linux <llvm@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>, Yonghong Song <yhs@fb.com>,
        Wenlei He <wenlei@fb.com>, Hongtao Yu <hoy@fb.com>,
        Ingo Molnar <mingo@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B0A01DE7-1B50-479A-92DF-DAFAB3F06E0F@oracle.com>
References: <CAKwvOdkyY9rsH3eViMK-_4iz_W_usumz5nD+3AhbNCVQ3FRCjA@mail.gmail.com>
 <CAKwvOdnsZekEM77axBf67MDqQVP0n6PTKH=njSyPSWTNiWAOiA@mail.gmail.com>
 <87mtf7z0rt.fsf@gnu.org> <6F9E9D93-3913-4022-9384-D809C8EF7715@oracle.com>
 <CAKwvOdm=_YqBpuBzouqoWHYNe6MMUE10vqF0PUkU=hcOj+UqrQ@mail.gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
X-Mailer: Apple Mail (2.3696.100.31)
X-ClientProxiedBy: SY6PR01CA0155.ausprd01.prod.outlook.com
 (2603:10c6:10:1ba::9) To CO1PR10MB4787.namprd10.prod.outlook.com
 (2603:10b6:303:9c::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95216b79-ab5b-4996-1687-08da555e5039
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yhhGFCW8VZpdJl16CdVsoQjli0oJuTe1R7EjogpIpVa6/m+ms1sqkKUgwhP2P9X8w8xY3fBSzteCE1HZDNNe6TR8UMXJjT4z5FuVWw+/6UfnvAf9RwoqI0YSGf89SK1yUm4K6tznxTbdie+wAI5KEKAPALzEuoOVMXL/7A7X1UrGsm0ZWIfQb0O28XMGtx3x+u7b67Pav6qph2SVMn98pYnds9LxkXKO49IQHzJs+NHaghAPrILNI9Asu9ai5E9wTbKK8+j14iB4W7g4ppw9MPjuARXEx5Wn5IOhHZXX0DnLHyUkOSw18LG5FBNlzoCWr4KDAwRG4sCn0iNEcgIEFUPDlo0yFEmJW82UlSwyIHO6bpen5Y9Wa3kIaAWJqKA+P0w6woAfK4ui9C0Wb56JAShiTdpLI4+ZHD2sx2YYemWMWeMOQLpfk2Rwgno6tBJjRMuoTSKdRtUr5TEFGC01Pi9Zdtn57yyGh2RKRm56mlhA8DkQkKMT0pGZdBYvp/E4VZZFRIHqAlCZGFtb3sPUA5SqfDdXt0hRBt3swny1jblBK8OlHGckE23q9bytcKoKJC17JFm+0D3nahZS4Tf3pBtZ+5fvpn+g3kq5fNYzPxYLQ4W9sRHo4RxtHtBPUcceNhfOrald8m9/Cpd/qvI0u+pJr/CEr0bhgSe/k6teh+jqCGo4hAPhizhOkcilV84Se5DvagW2uJKxNqH+tZNB241xIY8yLrQazdynnP/rbZ+wDZ4irb6POLGqO8zD6GliwRBapYNdfoOE7lqaMsa6fIg+qWkW1oEAZ+CKvOyhElggfeCOauTz7zbWnisYVFxp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4787.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(346002)(39860400002)(376002)(366004)(396003)(53546011)(3480700007)(2616005)(6666004)(4326008)(6506007)(52116002)(6486002)(6512007)(966005)(478600001)(66946007)(316002)(6916009)(86362001)(41300700001)(66476007)(66556008)(8676002)(7416002)(54906003)(38100700002)(33656002)(186003)(8936002)(5660300002)(36756003)(2906002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?41ryQicV/ziV5xZjC/MYBSEOojTEBIcGScaClWs/S6NdIC88VGCZbODBwTsY?=
 =?us-ascii?Q?uWcs5KjMpJ+AuW/Ns28EkiwmjHW+1anUgRW7BMNdom+mzn6IvreKykCG/tr4?=
 =?us-ascii?Q?mkBCxFWW/XW7B7nHpmueWK5O52EJIZ7HqOc01AZIlMPF6cX3GYred2M8LteT?=
 =?us-ascii?Q?rUTslx5ABCwxup3SKQOHtIxydXOXxnlHNaPNxUaxqkOmiKxBPE2rCgVRSJN3?=
 =?us-ascii?Q?uXZsvVUI3cKQsCXbMs+Z2RztY7h/CjuoUDBYSl6EOMh79/g1JATNC2Zqv8qk?=
 =?us-ascii?Q?9++16jML2zqXZ7oy/FV9Kux8CyQrdsCXiBTUMLCl5pJUJL0nVJDJnJ6022YK?=
 =?us-ascii?Q?EQqCbCGlKBFDW6C/kGopKbvKjQ2k6wpYsRWS778lnCWqoWbELHjsy3OFmIBc?=
 =?us-ascii?Q?vn0M9nXKcc85QsXkf617hHlTK53xKbdf/c/GKmExWHlIcS49vL5T3BcjrGno?=
 =?us-ascii?Q?kH65i2+fNlKL+pE/S2YWfxnfAyCTqNjI53jXWgiSC3hJWKy+YmqzvC2gw03t?=
 =?us-ascii?Q?ZvDpK1t7ypVZ/j/qOpB7+CqlXpBLcG1hEtWhqSBDo05uoaPaKAOGPgBx/je1?=
 =?us-ascii?Q?Xa5DVk9844Vi+GXxyMjWxFOiDPIXaDC5nQhp+b17PIUqWFGB8/v7NFwrUh2B?=
 =?us-ascii?Q?PGmMrS4vacsA/La8hvU5NWWFSMRiyfMtTF98ie76l2CO1X6aqhpB+JI8NwD/?=
 =?us-ascii?Q?3A1PbHpuyIW8B2ZZTRzmx3BUBzFU/XDKU2zktGNQif15m8lXjRhRDJPT3Bn3?=
 =?us-ascii?Q?OYcnyacXPSg8keRZL13qCZks/p4Fla1dotL25bgVcFq7KsmMAkyY375LSy7A?=
 =?us-ascii?Q?VUIhsxO/QcVsEK2W9dBIAb5l1F7wbKWL0UGXwwBvMwGH5haVmnGYuXqYJt61?=
 =?us-ascii?Q?VJKWrkD1fgZG2Ime+0sIdSIDb+V8/a+5cSe7ETntw+y1jhqnKEpu/KJnlFV/?=
 =?us-ascii?Q?vjsr+7y4t2NYFzHgX+SwK6iXi+CUTbBfAVyt4f9mb76OAQHXi9sgyZSCUZUK?=
 =?us-ascii?Q?S9a4SY5yZHU3vSxHdJao4/x0URIQhWvMdaJ8VpebxrRnTj2ZAsyxoWtnq1Ch?=
 =?us-ascii?Q?gC4A7oM2NL8HZI7HTi/rHRHpldCoCnS9TvYbHxDK/obUoj/ZrDcIqZGAuUic?=
 =?us-ascii?Q?+X1fExjxSyTgCnUn0n1LYyMoM9BW03jKWHx3NZ+tzpS7zcyILaMen+A/xyF1?=
 =?us-ascii?Q?0x9X9nItXq59tGamBmbrM5XbDTcMp//8SshpOI+BqwvYr1npMSAA7UZxfKLL?=
 =?us-ascii?Q?UzH7HJLXngbeMRNLIeAKGiuGr6Fh0n4E2eVVUFUhJcTRTccGUM/Wxa3QEPzE?=
 =?us-ascii?Q?5FTuG3+mwNSZrhHdYgA64uu+jE1EiG+Por/BWtfwLfwR98h9YmaW76EVf20x?=
 =?us-ascii?Q?yPTHzxxf6I8YRsU/giyVwG3mJTR+5e4G5RfAEvTWrTyFnQDV53SOs0U9/fhh?=
 =?us-ascii?Q?d0uZA0dI431js2fwSDdZgNd5f00dWgxarjx+HCtxib9EFIzetNoK8J+Nd7lD?=
 =?us-ascii?Q?JsvvhsarHCNYqPIvDDN6801luBDTviZBwCfPUwHXSTqQ0YBsRb1MwQscKubI?=
 =?us-ascii?Q?J6ddAEQIdHzahzqZcKIPxHBF0wA8jNVzhW2oh88Cw2yBsxuObZUg8IXPD4wZ?=
 =?us-ascii?Q?Xi9QHm9SvpVtJKSUuU0xv0uJNzduALhsMWMkwmqLJWaIXK3LlHruskKJ//z+?=
 =?us-ascii?Q?o8A8iXxHpSZUWVRUlU4sut9HW3Q9wPxtV8pZJtTR9/9q4qwgGUFjS/GIL8GU?=
 =?us-ascii?Q?fRCxTztD8u4C43tZuJx/ieCw27FtJkpLDpbJRiiPwo+l5XNTXs0S4NOe5i3s?=
X-MS-Exchange-AntiSpam-MessageData-1: F18z1Kq9MptFaUle1NYb7wSXo+IdH8Pt6LI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95216b79-ab5b-4996-1687-08da555e5039
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4787.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2022 21:21:18.9114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cqowZ8oFUWw6s/iNlMnLlVxitY+4k2YocXAJwVA7yigMne1ElF8rQPI+zBexZ34cYIeqo9+dTYqtg/5HBG5xsAaxj6zhGRvt38bPFBNoQd0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2365
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-23_10:2022-06-23,2022-06-23 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=341 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206230082
X-Proofpoint-ORIG-GUID: -SnzsRg4gY1hrFeofkHhhK0w9E0lA4Qg
X-Proofpoint-GUID: -SnzsRg4gY1hrFeofkHhhK0w9E0lA4Qg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

Apologies for the delay. It's been a busy week with gprofng related work.

> If you're still considering attending Linux Plumbers conf, please
> submit a proposal:
> https://lpc.events/event/16/abstracts/
> Please make sure to select "Toolchains Track" as the "Track" after
> clicking on "Submit new abstract."

Thanks for asking!

Our presence largely depends on a discussion on kernel profiling and
to see what we might be able to do with gprofng regarding this.

From our side, the main person will be Vladimir. He knows the code
inside and out, but I will also try to attend such a session.

Is there any news regarding such a session on kernel profiling?

Kind regards, Ruud

>=20
>>=20
>> Kind regards, Ruud
>>=20
>>> On 24 May 2022, at 12:24, Jose E. Marchesi <jemarch@gnu.org> wrote:
>>>=20
>>>=20
>>> I am adding Ruud van der Pas in CC. He works in gprofng and would be
>>> willing to participate in a discussion on kernel profiling.
>>>=20
>>>> (Re-sending with Vladamir's email addr fixed; sorry for the noise)
>>>>=20
>>>> On Fri, Apr 15, 2022 at 10:54 AM Nick Desaulniers
>>>> <ndesaulniers@google.com> wrote:
>>>>>=20
>>>>> Hi Sami, Bill, Jose, and Vladamir,
>>>>> Jose and I are currently in the planning process to put together a
>>>>> Kernel+Toolchain microconference track at Linux Plumbers Conference
>>>>> this year (Sept 12-14) in Dublin, Ireland.
>>>>>=20
>>>>> Would you all be interested in leading a session discussing various
>>>>> profiling related topics such as:
>>>>> * gprofng
>>>>> * PGO
>>>>> * AutoFDO
>>>>>=20
>>>>> Would others find such a discussion useful?
>>>>> --
>>>>> Thanks,
>>>>> ~Nick Desaulniers
>>=20
>=20
>=20
> --=20
> Thanks,
> ~Nick Desaulniers

