Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E92E4ED548
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 10:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbiCaIQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 04:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232594AbiCaIQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 04:16:25 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C0C5C84F;
        Thu, 31 Mar 2022 01:14:36 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22V4e0bb030419;
        Thu, 31 Mar 2022 08:14:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=oX1YHHz64X01rWaYta9PxOZA+Y+SF6YtCioIoccBc88=;
 b=fYOeXyNSnMVKirKQoKM07WPB4ThZ/5GPksyMhF4yeOEFMSxYZqOQQhPwbvWcnKPtB8EP
 4UE+afi5lMHHQ5DJcROl4TWbZ/UlPr5uGUprul5zFVmYEekttyO6rLlekuYSCqlijgi6
 rkoqdKyDcwBwIBIy2dK+pdxF0EaIpvaeBXHaHOThHPMXQDsO7dqWv5RuKLcHWkNU+apa
 92IjMUlzeuh8AuF8cX0R9pT2jElekB63p2NyMhyq+uSUKbaLf93amA3Q3dM72/ryDQYq
 gamUTFZcY2febbxzbUjcD8jN9ZCljZ9YwCwGUZzhl4wB0zLf68mOykmx3w7BHrschznX 5w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1se0kmhq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 08:14:25 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 22V8BJrv026171;
        Thu, 31 Mar 2022 08:14:25 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f1s94g9rr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 08:14:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TflrrQO+sl4hlwUCCl5UsUnUpyreUDtIwFihLkTjM4uz9keJ3hHRRsXhuaVW6s50dp13xQvvcpWiDkNSwKyxkIVPfHXBPnWB2oVhwqaUkvPMTuQnln7coxPnjvmMTAZ8npISLXxW4SPQAOHqC0bwgUmlbdmxi9qj5rcQgQqd1TvAdW15PWY2WBniLa0ZtQm8quO9DO1dJ1+/1DjoT39eQtx4Qn3Tiskf5XBM4cwovIVAgiIIb7xm+yaWQT/HylJ7qOPKRKU+rVV9mC7+yJkkOeuqiri6Yt8TTO/H64t/djShGimzih9RZw4EV2ACoZMI+FNiVAKWeS+VOS4llAjujw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oX1YHHz64X01rWaYta9PxOZA+Y+SF6YtCioIoccBc88=;
 b=G+XPdjT0N9oCLsSbJSJ7W04f5GJ6EZZDelWX3Ro9PYNQ67NeWZPIusMSBmRAR9gryruoyf2b+XuKQyk2VuPkLB/NlsnKJYNHfgMCI0gI12Pm6MXoVdIMJtQnJtF+PtYJCWpPhtXyPhQ/4nicia3mlf/IBqb3hyDoAmizJvWgv0/vacFf6HuuCWKGl3ipe5c/MUeW3YSfFl0oBU7vYscLJtI0ektzOKPWDtBPzoOZqf8zsRlWF5kFZ39JtNK0+fqdCUnr3RBPnh7O62ZJPMTPVinlRJScwu1Dsp+CRLZ2Dq4knhLBzFiIadJstfE8YYeM2Vi0T4BfOV735uIy+16kdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oX1YHHz64X01rWaYta9PxOZA+Y+SF6YtCioIoccBc88=;
 b=pdxM2Pg8k1PXxwNU8QW1zycqIT+gMB37hiZQuSHL+01nNZe0qz4b5agU+11/4ZhTblWlexg2dqywSwueExwnvsx+SE3In0izgT6RT2HNY8xs9HSAoMfzsfZJj4vPL7xoAKYF2HOpZEEnwDs9qnvl63neYW74AQLBER49Px3taQw=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN8PR10MB3508.namprd10.prod.outlook.com
 (2603:10b6:408:ae::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.20; Thu, 31 Mar
 2022 08:14:22 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c%7]) with mapi id 15.20.5081.025; Thu, 31 Mar 2022
 08:14:22 +0000
Date:   Thu, 31 Mar 2022 11:14:10 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     David Gow <davidgow@google.com>
Cc:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Daniel Latypov <dlatypov@google.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-sparse@vger.kernel.org, cocci@inria.fr,
        smatch@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>, julia.lawall@inria.fr
Subject: Re: [PATCH v2 2/2] Documentation: dev-tools: Enhance static analysis
 section with discussion
Message-ID: <20220331081409.GY12805@kadam>
References: <cover.1648593132.git.marcelo.schmitt1@gmail.com>
 <11f4750c6d4c175994dfd36d1ff385f68f61bd02.1648593132.git.marcelo.schmitt1@gmail.com>
 <CABVgOSkb5CpnXDF_m7iy=A7RmN+KmY0T38TeZ4hKbmkdQgt6Yw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABVgOSkb5CpnXDF_m7iy=A7RmN+KmY0T38TeZ4hKbmkdQgt6Yw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR1P264CA0099.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:50::22) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa49396f-e3b7-4d41-9416-08da12ee7632
X-MS-TrafficTypeDiagnostic: BN8PR10MB3508:EE_
X-Microsoft-Antispam-PRVS: <BN8PR10MB3508FDEE7612F9ED9DF5F4778EE19@BN8PR10MB3508.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vZAhi1ZLinwFEoI48C33dpXnFXPITxP2Uz/jYKTQSov08wM6tkUFqsG0isTBafC0q1Dq+LtVqeoDXlDrcH4mKaktdnymHbBboyLuUPKgnfdHip7M9AewtxNucdq20ge7EKrnXh1SI2YNJ0b4gj3l7w8oSGQYB/siN29bGGmyg9kqU3KEqCg0TSmgsQ7tMcGxuKW5kX0bzm7U4V4uwdMdNjiysSvo7Chj52HR+Na7GguSlfwtsjo+9VVryuRCmpPGWsu3e72PWxUVHdMxWy9ULh0EBg5CJTq2ax3EqBzUQsQxjV41GvdCWk2CoI+xYEsu12HrBdaCIbhXEeW2JNykViyVQONVJp+nDwpxNxVZCp/oIVw1IqAfkV6CVehdjsUp4glu1KFUIjVq18ONIgtzTrcHYLJsYi6yzB8fs+5d0z6QiRq4NSE1VMUYF+WUOtsj+TbW1jRs5heTaaiRW85u1TW+xBRVkW91Ou4GSn8vX9uqQll/IKgpod16bxP7g7DTIKG1/1/tpzP0zJvc3KJugWg/R28Hjci6DtSzKgZheqCxYK3hYl28Th4aV25NNbWgYm9jORQV8J+91Q24dXLhsFM7yYWtNsOWpi9bfwU4LfLsGayb7fFDBvBNbSM+YrbhTPyotz0sIf4Rzwl1E6kJBhzTz7m1MfJ9Uxe4/jL/ed1Qymscj2zGaxIjSOlL1/dasTk+pCrW9YSLubYDLb3DWw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6506007)(2906002)(186003)(26005)(52116002)(6512007)(9686003)(1076003)(33716001)(83380400001)(8936002)(6486002)(6916009)(66476007)(38350700002)(38100700002)(7416002)(5660300002)(86362001)(66556008)(66946007)(4326008)(44832011)(8676002)(54906003)(6666004)(316002)(508600001)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2wqaQw5/ep0g1M3lTV6HpEqNIbTqVnFtxi20+338QMilbWymwfai/joWnXT6?=
 =?us-ascii?Q?zIeZYNYfY2yzupqbrbtDZaalXM4ObXhF7RSSop37gLOFBCOYEURlqaC9T9AS?=
 =?us-ascii?Q?3DR9YzkXJCeOsNAMO73hFKtHZIDwo5FXJQFgMdDm/iBvGEvMcY5s4k29MZTR?=
 =?us-ascii?Q?RMEIe5xO7rlxO3xRo8HMLpI+qN5WvRMdFdRfLx+nBv0uR6qMrBd7nAlNG6zN?=
 =?us-ascii?Q?lME1v95IUPvH4MB13aXpccuGgaALFfbFR1EYfZB8YjciePbPTwSP2pcXQwfR?=
 =?us-ascii?Q?xBQjhXvYabL/gb5fpTFReDtKEQ9B+hW9L5QRct17tABqYZhlLupj1PJuvcAw?=
 =?us-ascii?Q?oS3RRA1/RsaPq5TyvGI89XW76BbgXha2aH48pSP1w/zt4UqKFqUoysFElFKl?=
 =?us-ascii?Q?7Bsa+hFdbHmTOGD8Ex6p/vx6CZuFU1wMthFOyD9ILnjxDwbWIWyV5GDaMp6z?=
 =?us-ascii?Q?/mIL5CyG94CipPqGbF/D7Tqn5kYl1P+D/39mLbdr0elfZkaaHnv8uXWXx72W?=
 =?us-ascii?Q?l+CLSKse96zZrC1XQVTTYv9dAvi1dqtyRnVxEN5fPrWT0VYDQC9O9ojieq9z?=
 =?us-ascii?Q?5eZ11VEOO8L72OXvk6/OpvSh2rxKYvOSfRSpymSXQYEs/24tElLWT8B6lSDp?=
 =?us-ascii?Q?gBdwQZL4dMcWvoIaPTkVegIw/cYoIUuKj6l7BR2tbL9nC/OTTena981mv88Y?=
 =?us-ascii?Q?ZPc5S1JUXySho9CEgQUPx5QiBeshIhzmwUU/BOAJpfjZY4EPWubWu1DTZKCN?=
 =?us-ascii?Q?3KvO45c7DF83mOjgSQoLcrI5oHhEqTBm5t6kSoBzMzE3jQ+LOfLq+14ArHqh?=
 =?us-ascii?Q?9LJ3OcB+IOarp9ifrtDqS2an83EYtaSD5WUlPIepNDiJlT3EgHbixzSyYFKG?=
 =?us-ascii?Q?BBxSQGi5JSyJHbrAsTr9VBzu5yuxp+fkK6TiTQGC8JMxS+mduV2AqfRN1yaS?=
 =?us-ascii?Q?Gx3J8k66RBobv+79U250klXZX56hmOxb05HxsjIRcJwvifOZQIV1D8coY8LW?=
 =?us-ascii?Q?4vqQk/V/aVRs3LwuMP+5Zso4qc/uBswqUUVfskOytzFgu6AqQKJm5KDAa7wM?=
 =?us-ascii?Q?4kTfVXqmpUTYrkjpuwPsbEsYQOY8Ic2qu/hLUvCVD2eVHzOvWL7RoIUacMNj?=
 =?us-ascii?Q?/D/JcZhjQE1qFkn1NdWC9DLSWZuM1zNftE+zKBiZYjHxsT6a7mZ5Jvr8SBcT?=
 =?us-ascii?Q?n5z3eSTSsYALB0FsQMEiMgGJMzYreRAADiKsBcgMUVugTqEcD4l3QtzQzBN7?=
 =?us-ascii?Q?J2X6FJ8MZ6xwPnTDchxLg85edFmbzCrxvEH/tVI4UXx28WkloM5ALAuYrPCI?=
 =?us-ascii?Q?NJI4M9qP+vp7fMz0/tZayXEjYdrG+S4ZcSWyX8YcjD/jU9aznrIO3Yc0udpN?=
 =?us-ascii?Q?zJ4TMvWm950kgeLTW+exQ+uzMMfQHYcHpzRHxN1JQxKwqVBgbgdxzwDLlBRb?=
 =?us-ascii?Q?wAEcp/ZhrS/ltg2JpkEZKrh7gqc+0piOCG5JltlqtJGOo1fxrrNxK1TcWKhH?=
 =?us-ascii?Q?yRmnBLDsvBSzpkTJYaVTDFfX0rYchj8d0gXiYUcBAoNUSrOTYuXKAcdCBDJZ?=
 =?us-ascii?Q?WU4o55LlGhenJKUn7U1DRjQX7JaTldXwdcM5NckZhBxOxafEEzEUPtzeoRGK?=
 =?us-ascii?Q?ahNlVsCmYSVd5MrvpG9ivukBQ2js8uU0nXlcpqbLUGnKS2kGWw/CWus4eEvm?=
 =?us-ascii?Q?J7xLsKSA/eNSHMOep67a8KOgidMD5xyR0BkQ34JhwjzQXEAabIbxVxbhQBpP?=
 =?us-ascii?Q?IGeUMzQlZYWutEhx0Isrpn/6SyOU/OI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa49396f-e3b7-4d41-9416-08da12ee7632
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 08:14:22.4326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LbxbJbjzcG81nOYdorxr2rFcLqiya/PWssueqPKYkW/mvHdnRYfzqIyqRMyqujSuTlXahvyg+6zr6NadDEVGFNQ2fihXCD7lQLxE5UIguQ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3508
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-03-31_03:2022-03-29,2022-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203310045
X-Proofpoint-ORIG-GUID: qHsypwRQde9I_185KKpu-b7QVC0_Zfn0
X-Proofpoint-GUID: qHsypwRQde9I_185KKpu-b7QVC0_Zfn0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 10:48:13AM +0800, David Gow wrote:
> > +
> > +Smatch does flow analysis and, if allowed to build the function database, it
> > +also does cross function analysis. Smatch tries to answer questions like where
> > +is this buffer allocated? How big is it? Can this index be controlled by the
> > +user? Is this variable larger than that variable?
> > +
> > +It's generally easier to write checks in Smatch than it is to write checks in
> > +Sparse. Nevertheless, there are some overlaps between Sparse and Smatch checks
> > +because there is no reason for re-implementing Sparse's check in Smatch.
> 
> This last sentence isn't totally clear to me. Should this "because" be "so"?
> 

I stopped reading your email when you wrote "Cheers, David" but I should
have scrolled down.

There is not very much overlap between Sparse and Smatch.  Both have a
warning for if (!x & y).  That is a tiny thing.  The big overlap is when
it comes to the locking checks.  The Smatch check for locking is
honestly way better and more capable.

I always run both Sparse and Smatch on my patches.  I should run
Coccinelle as well, but I'm more familiar with Sparse and Smatch.

regards,
dan carpenter

