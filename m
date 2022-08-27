Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC045A351A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 08:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbiH0GzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 02:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbiH0GzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 02:55:04 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4475A1409A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 23:55:02 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27R1hcNJ006584;
        Sat, 27 Aug 2022 06:54:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=XyQtZKvmdD5io60wFZ+9XsFMRWs2HUzaxmiqFMJDtjU=;
 b=eXNbeJ+wdWMtnLu/PO7a110Y0/64bXDfl5bh7V7sN6VG7nWIC8o951uMG+8RPGu4Exqu
 FKV8wnXcd/qFQZ5WJs0A0yKb4fdHB9UlM0OgsFBdzBp/iBddtteX+5sJAeWU5328zl+I
 vBiO2FP3vkp5AAlxY48Q32XHHEWSAeZbXdqmCWdH9jfhcwhIDdj9eHPGWdgJ9R8B9Ynm
 YlmKU7n6CuCe4DpAxLWbKM5VnxGFrlL9647Jw8yZYzo3jETxPUmm00r1FgM+IEnG+4/8
 jPI3dGowg4PGozPv0tVrjPyljFuakKYoh9Jp3WDAyFXTUuzKqmogEctRe5zKWjZw5BNw IA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j79v0g6kd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 27 Aug 2022 06:54:52 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27R1X51d033533;
        Sat, 27 Aug 2022 06:54:51 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j79pyvrw3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 27 Aug 2022 06:54:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MGGF9eslJllF3iAmkjIYnQIm9kceNXlX414rM6vjNkfg7M/YBz0Lbhd/M1lEL6rpIh1nd79kb+/sgHfGjmc+i5oM5ilkbnD1ykRg68+WpAqcAz5VlxF9RPguo9ykOjeiJmvLyJ8fw03XZZFx0wm8bCI6ZPgb+eouNFw3cZtASOxaMBEu4YOWQkAhkDKw513FKzizXnA8KKjAdV6+5mZtu5bm4KOvb1PlIIiQrLwOrA13D+u1tXM/7R8AZN2F1IM6p1BfkHaacMJdTvnICb5/ryu9c4ghbRlYB/vrhA2KEwk8MeC+7DvldC1ar+X9/soad7uLaOjFiibLiHQ9TrMIZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XyQtZKvmdD5io60wFZ+9XsFMRWs2HUzaxmiqFMJDtjU=;
 b=iJfLc0twaL7KrsZpma8YEfRnlvqw6yOHNR7qIrJPCSuVK1fV55qSmDTUrbnbrR9oXP+WjUbIB2i2fOK7ZlXVXohdlf7DIgzyK075DW2tGdmKJ9xUGpU1amHMwO7GGKGazED/50TeddAnAUfkAUPaQw1wlhETyRahFlekZ+tVj6rBdFJ0ughsPFfAhnRge50Hi8HW1hJ2Ny0SP2mEYIuomg0WhC137EzQRadRMH6gtkR28dURZH0O+gmHGvTCl/sQWThdDOZVBB1nW31lGi1F3yh7oXScLCyr/xblCPLsh6s7w4VDw49XJDGXxWYpAqfzxJpGfOe5sd2ztkwGH8JPbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XyQtZKvmdD5io60wFZ+9XsFMRWs2HUzaxmiqFMJDtjU=;
 b=YDDctWvG7dwEoDgv30+4mtcwH1iYCLHD3voO/G5TYAepmj/liBGJ1RD3vko4ys5IO9VTK8T9cd0r4nxqfTDyihAxkEi1H/hTwW1Ute2ZzvQQeOSknenTLDDJFvYv2KZpYLzes8vpuLEl6+iAy5mf5Kq9eiYVbq5uDj8ZxD1PAgc=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by PH7PR10MB6378.namprd10.prod.outlook.com
 (2603:10b6:510:1a8::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Sat, 27 Aug
 2022 06:54:49 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5566.016; Sat, 27 Aug 2022
 06:54:49 +0000
Date:   Sat, 27 Aug 2022 09:54:35 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Maxime Coquelin <maxime.coquelin@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, elic@nvidia.com,
        guanjun@linux.alibaba.com, parav@nvidia.com,
        gautam.dawar@xilinx.com, xieyongji@bytedance.com,
        jasowang@redhat.com, mst@redhat.com
Subject: Re: [PATCH] vduse: prevent uninitialized memory accesses
Message-ID: <20220827065435.GL2030@kadam>
References: <20220826161605.559317-1-maxime.coquelin@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220826161605.559317-1-maxime.coquelin@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR1P264CA0196.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:57::14) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4031a17-d0bb-48ea-95c7-08da87f908ce
X-MS-TrafficTypeDiagnostic: PH7PR10MB6378:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A7/Zki//GvDFKYjv9sfBJStlDWRolGD4+TkV8rMhp/HQAodaOoq1dMXQff+HfQmKwfk6jPoDvEKGFWLm1Q2USJI967QF/n1Gp1tWNDwi+BorMbNvk/Bt8mRUevMJaEtFMsTreE4AbMv7NrsiO5SNaWiJhwXtZ1Kt7qJKcxfagFM2V4dnaEltrmFA2Lbo6DOcNIYHFfT5Eud17+6A5SxQoW2QLFJJxJq8hGEf8qJUgS0YUyPNsmahQ5Q3mKcsxz4wBhMOUU+VIRfuyILQ8pMxZt2utb+6FL8aV40KFNs8xEu0JBjvybXQnMYtgi4rzWGhx2mCcbAWvjunY0FeV3hSz3f+gpihYDOjN+3IL/CgIrkKt1bn20P3aykISxm1wZO8v9s+vrX97tGRuG6e279Trd35d7AiLYv0OiKnlCM36o62J+Hrx250g28zWmaJFaIkQ7K2Broj+4f8TByv+Rk1CdgaKo+WrscMKat1MEqUuClZCODsiPmxVSUgqAgr0u3FYevWEk9y8iq3cnVUn+32E6WXunFRCQhLwsea/TnTMFwCnWc+RKZj67D7mhkyhCieY5JwK8Q63UQxYQY1Q35DMmPErECF9X7XrXm11cM51ktaqMJPkQNzgsFkjiVNF/de5CnxdknyqRg9eO71IniTUV9ehHGHjv3txlONXr5iuf7520lA1cOoiMaimtqax8yfp0guQ1l4NQmlY7qEJjV0BOH2ayT+Pc0Yb9P+WqXlrJ8KqVXZ3F+eUEghkZQMLb30148H10XoRpeaqXWnhul9+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(136003)(366004)(376002)(39860400002)(396003)(1076003)(186003)(38350700002)(38100700002)(5660300002)(8936002)(44832011)(4744005)(7416002)(66946007)(66556008)(66476007)(8676002)(33716001)(2906002)(478600001)(6486002)(52116002)(9686003)(6666004)(6512007)(6506007)(41300700001)(26005)(6916009)(316002)(33656002)(4326008)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B186t9MdiQxDwFEBpVAAPaSU0Ffu/N6AdtoELOcsVY7Xla4S1+kxOnQJTd6o?=
 =?us-ascii?Q?7yUgAGrKRyEyO3G7baT+I+BN9yPOraS4Zw0sBAeV/9UtrOTm8u+aufjuxcP7?=
 =?us-ascii?Q?xsn7H+PRGIovu6IQY+VBAs7DfuxtHgVI8rlvdf9D0AbPB5yIha9Nso1UYFRs?=
 =?us-ascii?Q?enlAGx5TD2Uw9KW71tsTfYa66utXxy1glFup7wfsqArKabB1lpAPryaxKl5F?=
 =?us-ascii?Q?nbVMbp9cn2u6NDUTkEl2r5wEe7fAG2i/hKyjg7GiaXlR65VrOoBxsbqLMxIA?=
 =?us-ascii?Q?jdjYusfaMqDXiPUQWK/3yK01csx+aGiYz10JG0g+2AaRrX/ppKYqNDcPSH7K?=
 =?us-ascii?Q?KWWR/sXwyMat7iDbaFiLnWaurVnWP7p/njyvI4MOa2k2aSW57bcEUexr+hIw?=
 =?us-ascii?Q?srFArrRzBKFwpN6fl84BzGR1fm5EwSkCRwcQomH93J5LUYLGCmif3a223hqv?=
 =?us-ascii?Q?PIMe8XTPZODnU8k5qcUuZz0REkDu+1upv0Gg7ykuOtpvbtfZFD16qSYDHllD?=
 =?us-ascii?Q?3XGa6fSLtQCThGVJGGZ2cf7BnWEJ4n0Zc+AxwIxzxV1Fz5oqgASEQEXxE8Vb?=
 =?us-ascii?Q?iXTwspb47MsT4TNUEnWmeBR+q2fx0wTbOxJekt+efVyfbIUEXK5JgoC0+wzM?=
 =?us-ascii?Q?jfAD7oKV7iL93pV17FqkoKyRoeY2Rs1SwWkR4mU2jd3YeDj41M+Htzv4oVcU?=
 =?us-ascii?Q?EOs/MlM2AEM2p8xzD39nyrmaeSXlrGkrlHGKlwkLtNwGD9b2bN2K5dbQFEtz?=
 =?us-ascii?Q?4cq16bymIsa+nsLCxn4aMw/ymfHU/F+XvoznXS75iNtpcia+OE8zdzU9gOe9?=
 =?us-ascii?Q?GNwYbm+5B2s70rnkhYfbzsl2jFZpiMwFpWwklk1zDjvstM9TJW8b21QxmUlY?=
 =?us-ascii?Q?/GQsv9noquzuLJ88lSRKA0gLWOQ0fXuGty9ye8hiBMj7+7d6V3uAHFOqr9RY?=
 =?us-ascii?Q?mM6eVOXMyaSXzp/h2IT48v/fc02/bU3SaHuT+MX39j+mDZ0GzUdPBObsJf1G?=
 =?us-ascii?Q?4+bgkG+nFNw22DFyx6NPPdj9r+MrdD/kXMeiFOYezX2Ap5RFyfAxJ1CJ+lcD?=
 =?us-ascii?Q?XhMLqHkN3VBp7JiKSKTcK+NrsszPERdVmgchWII6cU3o1HIpctZuZGbQKOJb?=
 =?us-ascii?Q?Rf3YIgGnle9+Q8PaZZKFXtC7xv/nHt0huSX/+iAeLq4QQNF8PPs300jpVgqk?=
 =?us-ascii?Q?wofdCPjfCks4Qqzpogf9PBbe7n641Sm5JjSRLQaRytxalosi7qt/GEp5OzFR?=
 =?us-ascii?Q?fxcvu8zOTeyEhFYISOYEiIB73arGmi20BCSfsxuyZOnSuOMcu1zGG25GXOMm?=
 =?us-ascii?Q?Fx0LGN3/rijUQOe/j3WB3VfMrDMvrLoGuqvhUviCWd3Cpoy18bUiLnKYR1AD?=
 =?us-ascii?Q?6aP8SvnQnREbVUspjb4v+vMMPxGt4A8otFiAqSd06QV1rzxlj/ERMfDUKoy6?=
 =?us-ascii?Q?XcMbuzeo6uC0ZvKA+TEPOZxSwHdwxpVUyrvbLTsdehoJcHHkDxNqhi5Xoo35?=
 =?us-ascii?Q?xGUEyZ2bxHrSOdmb0ncIksYOPYtG4MH0kN6ApbvDwj22MObAc+LpTZxVtFj7?=
 =?us-ascii?Q?e8+OoESciOE584h6KjFG0qwPkQFqiS8YeQH98mPFVe/oV8zewoc0Jbln4b2/?=
 =?us-ascii?Q?wA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4031a17-d0bb-48ea-95c7-08da87f908ce
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2022 06:54:49.1959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Riuj6We1OsTiYk1peAXRpt7buZs1qJc2ZzmbZoRQQX7Fd1hWktzNQLQoCATCTQ757p+kNOSq/UmS4Ki96j3roojxzZ358A4EIaW0HLfxIcs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6378
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-27_02,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 mlxlogscore=772 phishscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208270027
X-Proofpoint-GUID: KZ6es6DbpAlpCXOyRaZ9DrxPAx7dSq6I
X-Proofpoint-ORIG-GUID: KZ6es6DbpAlpCXOyRaZ9DrxPAx7dSq6I
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2022 at 06:16:05PM +0200, Maxime Coquelin wrote:
> If the VDUSE application provides a smaller config space
> than the driver expects, the driver may use uninitialized
> memory from the stack.
> 
> This patch prevents it by initializing the buffer passed by
> the driver to store the config value.
> 
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>

This sounds like it needs a Fixes tag?

regards,
dan carpenter

