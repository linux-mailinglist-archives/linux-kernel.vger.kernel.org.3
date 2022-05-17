Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46FF052972B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 04:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbiEQCMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 22:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiEQCMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 22:12:09 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B43C46159;
        Mon, 16 May 2022 19:12:06 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24GKjIjt009400;
        Tue, 17 May 2022 02:12:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=zFbh++clTm+UzPVnjv1tfarRGBfWd/uVCwxooNRFaAE=;
 b=U9HpoDTQF0uUn5A1QyRCN3dJNORO1X+qoN5UI2D/vA1iXDcHfMd9VGCAd+G9sf43QqyE
 ZhV6LElAMeJmcnHRb4mispBTCnuTJ3mzJwXBzdzBPBldzhP3B4IL/v7vM3zWb9Gk780M
 oFycwaOVktsx170Jkzj24kHJUWdcBjoAKO3GE+yn51CWZ2gYSmKZapTPPtnA4zVYr8z/
 aBOyScRSduFh99pg9gsIaKqARh6LIupNr7iVg0r4i+W87CvpTJdktW064s1Am3Expjch
 AgplCSd0DcmKXSIz83n1wce+g3gBbhz1faX04hJvqnbKdKmZRjneVFVQvQOVt6r2ALOM Sg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g24ytmwcx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 May 2022 02:12:03 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24H2BTsM011862;
        Tue, 17 May 2022 02:12:02 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2043.outbound.protection.outlook.com [104.47.56.43])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g22v2akdc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 May 2022 02:12:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A/wgAwD3mCLBjqYDhJuC4i86D9VwvVQmNFELB3iXzueS49XfYEXCXnbpb5LPyjC5D9IGNTisjo6L/YN3VGUf+hc4xFKc4+oGxymFkFSU7pUEB+Q+nTzHmtiuywvuCvHezlgWyDdmbKy3Mx+JRRPbGYU2vrEzGqClBA5qf8VC9LvHRMcmITPYp0EtZyGpSBSKimDZVlTGuUw6SxpMOkAzEqOLEz/mW8Qx/BHpiod9tV/Ki0+v81ZyBPpVSLClj2B9idI9t60BiObeg3M1sfUCA4UO/Q44lC0SkILC+XhGpHH7T6VEY+QW+wmXKv1vFl1NZMg0YeriuIolZVh8FJGDFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zFbh++clTm+UzPVnjv1tfarRGBfWd/uVCwxooNRFaAE=;
 b=RaQuQpjAzhHPx/Uvs1OoKIPlrdA6HJdu8RNMjK2FnXqxS3SDfPS4njLb4fNTp/pL9iXyGG2rYULJfTJiYyThNsneIcsUODXF/jDp8Bjq+BeiAjq6k8nRri3VRNJTqsgg/WXC0hY0u9SOo7HslHk9OoDEf/gN3Nt8KFVVzPnPNPJ/JYKRaIj45/6GD2h5jgYt2ZDnBlH2wqbm2BDZh2Kc1f5qAPyrp2MVp9Kq7ZIEdf+teHo/Ku2GKPB4/JxBCebxb8LFRczugKig+nkWl11W88iixdmWTQqsI46oQX0rH/OFtzZOuibLi1auCBN57YCNCGiZ1ZA9sJvnviVC+muEXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFbh++clTm+UzPVnjv1tfarRGBfWd/uVCwxooNRFaAE=;
 b=u4IQrL2wnHk6OXn+T+haP/Lrun6UsdZER3mYMXKupbrYDdIXi7nSincyZj6eVdYouD54062/6KN450IusJ/bVFS50RKHpgWjSD349d8LsHjGhTSpu+8CGE7Zkmn9kYbbx04g8z3US/KsmyGtTwcVWYMOuzhZqdptHorcNMjLXtE=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by BN6PR10MB1457.namprd10.prod.outlook.com (2603:10b6:404:46::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Tue, 17 May
 2022 02:12:00 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::d1db:de4e:9b71:3192]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::d1db:de4e:9b71:3192%9]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 02:12:00 +0000
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     dan.carpenter@oracle.com,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: megaraid_sas: Remove redundant memset statement
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq135h8rjqa.fsf@ca-mkp.ca.oracle.com>
References: <20220505143214.44908-1-harshit.m.mogalapalli@oracle.com>
Date:   Mon, 16 May 2022 22:11:57 -0400
In-Reply-To: <20220505143214.44908-1-harshit.m.mogalapalli@oracle.com>
        (Harshit Mogalapalli's message of "Thu, 5 May 2022 07:32:13 -0700")
Content-Type: text/plain
X-ClientProxiedBy: MN2PR22CA0006.namprd22.prod.outlook.com
 (2603:10b6:208:238::11) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9ede635-e447-485a-f234-08da37aaa051
X-MS-TrafficTypeDiagnostic: BN6PR10MB1457:EE_
X-Microsoft-Antispam-PRVS: <BN6PR10MB14572AEB0019FC2371FCFA648ECE9@BN6PR10MB1457.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OvWAvHUvNgOlpGzjvvI1VNJdu58+a25tobE7UpoY/z3Vpvqw37jRxVSGa05cuhOswYtCyZMlfCZBvCHExfeoxk87fwkYkT48FPweJHk1wvyadX77Jh8t/KicpVJqHg/J2tO4VGq98jB01I8l2si+aP66zgCskO2B9Iwzx+G74LZGHCwAqK83ixiMGHpSkcdydV77CkKl4YF120GV50pAO5me0LU2AkrbgY2egVrGS1TEPTMsPOx5Sh+dufqG3ie7k/mzbqd00/tgqdiT46CxJdK53w4x5RqADrzxPN4jkCwgEv8Wxl77FDV4KJjayzTZn8v/dKH5VCf0k8KevRCbFMkkRurl/gJWqHZsMU75IM5/gkCwkPW5WOcnN+q3NnUkSWaGi2YMRUvMsESWGmCbjJW40254r1IwozZc0/dx6Oex9o5JLSBOPW8TdLYNRKzBBHnq/BhDBQiovazquKqKy01Bj1jVXC5UlWru25XlliDZQEDJGbov98NLQNgJM3ygza5j9R2FAscsEkFIo0lLEdui9xGp9w4zfPER4WIsE+sm/bmA3c30eip1rUUZkIq19bLI8m6q5izGsecm1Jrv8E0FRsLSIY8nkCHvk46J6jlIf87NNDhEQ9qe7p2piX7nCZ31l8zPece40tLxn97fhNXt6nL5tyZXtCwcbWu8PC3LygQGoKJLPGgMXdBc3A6liUSF81BMgvU2Z7Tb9z3Xxw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(558084003)(83380400001)(52116002)(36916002)(186003)(508600001)(5660300002)(38100700002)(6666004)(38350700002)(86362001)(6512007)(6506007)(6636002)(66556008)(4326008)(66946007)(6862004)(8676002)(66476007)(54906003)(2906002)(316002)(6486002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5Hil7nyUAl7wiT/ijshkOQ/xPFdRprDWT7LW2JaPI/fhks4h6P2QDtSwa1bZ?=
 =?us-ascii?Q?EGmamsNw4lNiFRNsqnaeisyddDRY72WPhNfnqS9Wj2FMsq4kz2zeuG8PENEg?=
 =?us-ascii?Q?guBCVKtzaerDYZL+sdlC1Ckj0/je08kLvNVpSHVZX3UNIFV6bJxDWv1MoDmn?=
 =?us-ascii?Q?hwN/48cPXTdod00UUP8yaYeTigdFMwJ8k6+UOelPFI1SquapYRk862eU2ire?=
 =?us-ascii?Q?ntrd/lT3S/qvVrOKZSzXoOsxKiPNzOiLiIZoeO6NZyqLf4prKWXi9LGyTUxe?=
 =?us-ascii?Q?4PS5BsrSdHqp/+3PMbB5o1Q4qjr7VWPo8BiF2mIR5JockAN/2mWHT4bKSQfK?=
 =?us-ascii?Q?xxkTvTHLm15yKlCBTN0FTjhnlJsHJ+baihR01ss11uKZIdlpWcOuuuUlV4fC?=
 =?us-ascii?Q?KwZGWottZBA3aJM4MI/lDh8mOxKQPcLjwlTrQufhm1h5D5aODZg1K0YR7wUE?=
 =?us-ascii?Q?/DYwEPVN9kMooy7C0gAoyGbxWYKryqBk0uWxz7FEprTKKUHUr1aR27Oxkple?=
 =?us-ascii?Q?CAjpkFfQ1a6tf/WeUc/NFATgZuKhfueH144OhFkfBvxGXljbLFqRqQjQ3iAh?=
 =?us-ascii?Q?vVt7v5c97XBtLXcvgVomt5D16/2YDv4Z/55QJRbK38BlQGDClL0bsKaZdSoW?=
 =?us-ascii?Q?NO+N2m4rTlJxZoUCfToCsmAPJAJlUiJlkpnLrNjObmekIGokZbrCBSRQBKFy?=
 =?us-ascii?Q?vjmZ72jMLgGQO3lan61ecFPN/ZF0uEsM8E470O3Lx2gKpt8b41jolSYQW/Qi?=
 =?us-ascii?Q?fv9X5kxsz6Qtju4BsdJ4C6I9YoFytjGumXRUry0vvkqljWQHrqLbMejOHFAJ?=
 =?us-ascii?Q?oddGO/gcVMuHo8xMxnd/9NFqiZTQSBCrcPjlRqYTzBWZBBkiGRCPT76jRp6l?=
 =?us-ascii?Q?BXntl+wbkiVctHHipLsS4B3AtqclOluruo7947gECL/ojESoiJW42QWiRqFv?=
 =?us-ascii?Q?neNGawdP+5WFrNa53yXjNL23hapnOdjValgpmaUeE45iL4hqMMHPjb6mjVmC?=
 =?us-ascii?Q?HySvv9Y0EjE2KBKEBJrQ84hOBrqq667qM+krMq1S6mJ+w1kGpLwjsZYD6NA9?=
 =?us-ascii?Q?Yqzs78iASUutXvvi+3PjYFj+VGBnz3hxv4xev+Nf5o5M6uwDs4kOdD024E5G?=
 =?us-ascii?Q?S/C5Jr6EAzR1zqWaLuLmGZ+1HBa5S9oBeRPYtiQKztX7JBrc9u6EV+GnOIts?=
 =?us-ascii?Q?MkNOizCfhxSL+0vHp9gzJKdd2slCd6UAH/FxAsbDrEpRziqN5Ypl/fh+Dj9t?=
 =?us-ascii?Q?5a9eq/RTqaiXdgKC5zcWwkiQeQ91A4QdsDKv5SyruJSH58VNGCV4mvphjA1i?=
 =?us-ascii?Q?q9WloNhgnjjCQLJ8absiDIkmvN89U5L2C7zoaFN2IZFwlAjGgm+NXKYU2NkN?=
 =?us-ascii?Q?XxsoO+qsAvD5/0IrpLy+5kr9WJ1HuyZ+79DFQpTKNaVSe2Y0Egz+sVFAO8vw?=
 =?us-ascii?Q?beV7QpmFGhbRC83IvXQj5CMWZTSVDZla3j2bDPA/ddZjOsNut3xlBftidMjq?=
 =?us-ascii?Q?STCPTjm0ZDfITAexrqwtYBjLhKA7nl5JoJZevGRDMsDTO9aMoIU9t3nWQ04R?=
 =?us-ascii?Q?pA4VacEpRNMqrqdRTX1gKFxTdzmUdDcueD+zbc1w+T5x3Vj6+GzL9sXihbSM?=
 =?us-ascii?Q?9B6Y1c7w/bUo2reX3UCXD7J70OdPrd5wderIgsxIhvmsV+BPcc91KGoqcHs6?=
 =?us-ascii?Q?Uz8OT8DI9gA7NQA7FB8lJODRUoSHBlGQyMOsPNklP74LppScGfluw2s9QSVK?=
 =?us-ascii?Q?XgpABYldrlC8cNs8pXWT374CWc2/7Js=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9ede635-e447-485a-f234-08da37aaa051
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 02:12:00.1446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RhUZ+ceieKOoZInPhrUeoLAIIOsyxaaUF0KkIJzVZ7yLxTB/ppuxl+zTWBCvK3lze3vKOkbDxSETTYwwFUIglbfwwy0ZCE9wKHEwOuZlTUs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1457
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-16_16:2022-05-16,2022-05-16 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 mlxlogscore=828 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205170010
X-Proofpoint-GUID: XHtHkj1TiCldML_nnhJ7GTodritSRYQP
X-Proofpoint-ORIG-GUID: XHtHkj1TiCldML_nnhJ7GTodritSRYQP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Harshit,

> As memset of 'scmd->sense_buffer' is immediately followed by a memcpy
> where 'scmd->sense_buffer' is the destination, memset is redundant.

Applied to 5.19/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
