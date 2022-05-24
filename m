Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A905329B2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 13:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236945AbiEXLrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 07:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236567AbiEXLrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 07:47:11 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB7128700
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 04:47:07 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24O8j8gq017525;
        Tue, 24 May 2022 11:46:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 subject : from : in-reply-to : date : cc : content-transfer-encoding :
 message-id : references : to : mime-version; s=corp-2021-07-09;
 bh=uXSdb6f7uCAMXRH5Tb3TOyjNQCmZ4CVuVpF62hdVnDE=;
 b=E2x6izipc1galastzBCxijfLh2YHJbp3RdBzaWuztBz2TfO2N0g8NA9xZzG32GTtMCId
 rXADKhonYcDtaZTg1C2R16RXJ5U9AX0663jp68dDjD6CTZsjwcpPwuLMfnaeb9xM8qQY
 drOKDn8qJHz25fqoJdgAcj/mp1F7XbMqvCMcA9Kb75JcAN22tBZVcAPDio1X6IL/KRAm
 750a34T2hziYUaeW2l9fRXyPl7CauEQ4lm3LqvHxBv1vHGc+X7AwKzLsIPN7IeuJg5at
 ru87RiLFO0A0hHTXz+xchy9VdxQpMh9CHNHPzHRxx6j6a+HCeoG18zvtEF4iAMSZrxyt uA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g6qps65dw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 May 2022 11:46:26 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24OBkIZh025689;
        Tue, 24 May 2022 11:46:26 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g6ph87s3t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 May 2022 11:46:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JufPLRiHHtGckENQ5t4bNXrB1rxgzrJLH6d0Gy2HhHluLYS2uiGkVI7YH3Tj7TxbOoNQvWViH3DPTVIh305t2H+zTHdbkwbCxE+nq0fe97xdjpp8p1dzy/0gC54YRKtJ7z2Q+9GUKjMb83N7PDlIWg8zDG6HoCgnrF2FIYRzo/QY4a/SlkazIsogXEXErVVn4gLwJQ9VmWbj9m1QAsZ846kSXau2XRnzX+nvFbVzO8LeaFaZTbfQHV8d8OJymiNLAIOwukmHSMiGTJn9De/z9Gm4iUPN8kefgYnknX2NWeETRy6tKvIZkIeMIf8Z+mhnURN6tT4C8ny4dM4KZtJCFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uXSdb6f7uCAMXRH5Tb3TOyjNQCmZ4CVuVpF62hdVnDE=;
 b=GYJs8rP4EcV25KJmXEYbUcRGuyvnrstOni7mO2IsCmCDlG7jYdobaSdYzdrPilYEonkUPSF98hI7MQsO/3BTavINq0XL8awenjg4flobXoQ2lHbdDcBxCszGMB8SA7gsDP4r0zFJqgldXbhFl/hRNS5DoGBsOQe8FSxW+YjXahZW5U1O0AbTbV4DTQavrxdxnMBlOJqcLPm2IoqqvGqNv5N8365VzD5779342an+Hzb/VbygkFBv6hrgf6na6rlBbk94tfQ4gYMcGWVgLDkMkAMFBFxiAtF1IN+W7dv6gYiQSr0Kl59zkDE5ZM2Qj2Q0RjCzWDD/+uBxISWiq22s4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uXSdb6f7uCAMXRH5Tb3TOyjNQCmZ4CVuVpF62hdVnDE=;
 b=yzGGseWve3k3ZGeKKvm9FEagsl2lTjW2sjfJ8Ha6hZ7LDz1xVbOnAjcp2cT9rP4T6hA4oDuqWvhrTJdGWwoFr6dVAUZg8K9/rLaPomFN5jwfTDz9H+fUimVQ7amTo6yW7bqU0Z6tQTXrovUGguJcFYxlPMWm0rkM7Xsell5dFEM=
Received: from CO1PR10MB4787.namprd10.prod.outlook.com (2603:10b6:303:9c::16)
 by SN6PR10MB3070.namprd10.prod.outlook.com (2603:10b6:805:d3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.23; Tue, 24 May
 2022 11:46:23 +0000
Received: from CO1PR10MB4787.namprd10.prod.outlook.com
 ([fe80::3d8a:f5f5:c8b8:bc4a]) by CO1PR10MB4787.namprd10.prod.outlook.com
 ([fe80::3d8a:f5f5:c8b8:bc4a%9]) with mapi id 15.20.5273.023; Tue, 24 May 2022
 11:46:23 +0000
Content-Type: text/plain;
        charset=us-ascii
Subject: Re: plumbers session on profiling?
From:   Ruud van der Pas <ruud.vanderpas@oracle.com>
In-Reply-To: <87mtf7z0rt.fsf@gnu.org>
Date:   Tue, 24 May 2022 13:46:13 +0200
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Bill Wendling <morbo@google.com>,
        Vladimir Mezentsev <vladimir.mezentsev@oracle.com>,
        clang-built-linux <llvm@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>, Yonghong Song <yhs@fb.com>,
        Wenlei He <wenlei@fb.com>, Hongtao Yu <hoy@fb.com>,
        Ingo Molnar <mingo@kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <6F9E9D93-3913-4022-9384-D809C8EF7715@oracle.com>
References: <CAKwvOdkyY9rsH3eViMK-_4iz_W_usumz5nD+3AhbNCVQ3FRCjA@mail.gmail.com>
 <CAKwvOdnsZekEM77axBf67MDqQVP0n6PTKH=njSyPSWTNiWAOiA@mail.gmail.com>
 <87mtf7z0rt.fsf@gnu.org>
To:     "Jose E. Marchesi" <jemarch@gnu.org>
X-Mailer: Apple Mail (2.3696.80.82.1.1)
X-ClientProxiedBy: SY2PR01CA0022.ausprd01.prod.outlook.com
 (2603:10c6:1:14::34) To CO1PR10MB4787.namprd10.prod.outlook.com
 (2603:10b6:303:9c::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d2abdd5-1e85-42ef-388d-08da3d7b06cb
X-MS-TrafficTypeDiagnostic: SN6PR10MB3070:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB30701408054AA2A467747AF5F3D79@SN6PR10MB3070.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dpvsTk3fZIfrChh/0BdBqJ0kFLW5qWMO8ODqQgjLS3EukCSNmZPngGMWIReUtO1vrwdruo4+N1K3XgtT8R0mEdWUUOYxPHey1JMOyy1N0Uz4TC7oa0yri6LxvDSBkwS922nH5E8+qqiz2SdWyVKCslOPIg1Rl5ti9HXWa3vBLSefoBO0eImslrhlWm/m5p9NkYRmd4jM7O3MRsEpPmj29ajE0GUeRqGLEMB1ukpPMllnVMHej/j8Rm+sER1TsGfMeVdydFw6CzqgJKzTyYrCUyMEDjgkFsgufcqX2SVgw8N1+yVaOoDCYxZP9qj+N8yC+VmXcoUQIboMmcHecmZX6al1ntn5zl5VdwxQRWys0X/ht30AmNxp+6Ln5Mxq7t1u7w5NrwisqtXPSsaPPPM4nE6Ih4dUIQLIZTK5Hf+ycR93cYlmu+3MaStXfnqIGLp0HUkXtfukQgOrm1MQ3iQTdPdrhqk0/fq2Bp5wBQmDC6/RdC3sUIlu9PQIIZGOzRFigOnS48QHjSHagQ/1ZVOdcFB1r3G1USSRVC9jN6x5k2LvErc3IhZ9kh05Fr6Y7cWr0V40AAHgG/B6PeWZP+y6AFBbe4Rg6TMXxFV3GzfYH69Cc4q8e9YQudZK9aHZeKLp/4g3Tj05IBfOGtD+3Jv3wsqLscLj+l5DbCBM9fj405TZLuWQZu8gW4XQauvDnGDs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4787.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(38100700002)(54906003)(6916009)(4744005)(2616005)(6512007)(86362001)(66946007)(66556008)(4326008)(36756003)(8676002)(66476007)(3480700007)(52116002)(6666004)(53546011)(6486002)(33656002)(6506007)(2906002)(8936002)(508600001)(186003)(5660300002)(7416002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eXQ7dPXhG5fC+UKgd8gnUna8TpIIYgiIHR5u+2yG74rl+EhQGAjlYkcM3umh?=
 =?us-ascii?Q?lpptEwGmbJwWZTK103r7Fx//WKxNAPXnB9dI1yZAXqyvufszIHHKz2oyw+Te?=
 =?us-ascii?Q?t/aY+m5U5ixgrHfkowuT+fe2BYJ7G9Gl8vtCVrzlUpgW4s+40x4NWtMMXYEN?=
 =?us-ascii?Q?FzKBNzPBReZhgKE8VzUd5C3oaRz3XOU0FhNd0YcuQVT9G/GOKQzbBdTPiIVc?=
 =?us-ascii?Q?i2hrwTCEWpZO5zvRqsUGnlNUCxyYJWW4JjknykbaI+AJ4KTMCeK47lI23GkY?=
 =?us-ascii?Q?+8NwQIaq6PPkopJeQVuZAbvFlo5tZts2oH0n3j9otYIJi8PF3kBjFW+W0kuh?=
 =?us-ascii?Q?E40jNZVc7rhSrwEvqDZrMiVfC8cQTS9YI2X/rWt2VCnIPbfAxXiFyYGItCfP?=
 =?us-ascii?Q?RAmJZOfC6ribzWgNvoHcXWikiXJu5X0qW4hE+VEhDsP/Wze4NwlDFaaMwGV6?=
 =?us-ascii?Q?0XAmKRmJprnzOpKC2osXmLnSr2ru9itiXiypk9Si4kg1tkIsenLCjVXq/Tl9?=
 =?us-ascii?Q?LaACccQFufJF35ol7HmYTpiTUc94Ab1vq+G8m9AYqtknrmy0KjXy2Kkue46H?=
 =?us-ascii?Q?TEX3/q45rSNax2p2tXpviDjfWJccRein9dg9WDQ/OD/XybmjYM4HmJcNXyvO?=
 =?us-ascii?Q?PBTcRJp3JxBicQ15gB8YCFjh2tGVLLx62Nw0blWlG7O1IQneOxfyidbsqbm+?=
 =?us-ascii?Q?2QdWG4lzIW7MPoqjoPqC+vhlwJ1YH8Kn9pJs9C/1uXp2lHg7FiF+OEvXoaqv?=
 =?us-ascii?Q?diUgEp1kk6wfXyEjz5UNLmabWsBcVFjZu7I85O8zA8vfmH5h9bxTztH4rpkH?=
 =?us-ascii?Q?r4hCZZFF1LvyGKis6bBtV2WtIvLwglvClKqyVpSK+2QrhuYVcPrX9QfHnGLn?=
 =?us-ascii?Q?mSfMoghW0vA4UoxdimPTzgqbIKex67y6G3cFBgvYOXkiftQQ6SNMxzvEG/MA?=
 =?us-ascii?Q?+sUDJZsFxsye2h/yYA232Ihamc3Fm02tF/5vLwJ7NHnfHFJN6nWkuRxaSaNN?=
 =?us-ascii?Q?abswjGty7yQBJSSa4DGxU6BEif4lcln8E9HbiiUohexu8GJTaIvWuJ13TPsa?=
 =?us-ascii?Q?xipELeyDYaHlTwqHK9PaJiZ8yJGeJgKVPejjIC22QTKwoTxoXoWl9ct1HNif?=
 =?us-ascii?Q?ajZGUNZ1qLtWIetC8LLRyOXK3vO9OrygzcksWKRHHEr0R+zS9gIfbaqSorr2?=
 =?us-ascii?Q?pbkx3M+X2AADPLt9jwlTghcNSr7a6/3SQ/Aa5IyyflbdK8FqETpZ0SVqwSrC?=
 =?us-ascii?Q?7ATIKNSWkdTTfOFnT4ZSLCVeJjIoRS7dmydyHcL42xNsANkL0DAyibsas+xi?=
 =?us-ascii?Q?3b+iH+RBR8WHvWuN6ZR/uFLk0wvBK0JrpFcBCV37qWvucnnajFCKASU1SqOK?=
 =?us-ascii?Q?M090FlHA7C81QCneMKBualHdYPqMzFVN+wwfVDK6XM10Fa+Kq1UgfUKC9hkz?=
 =?us-ascii?Q?J1UK2lWrQ1M9eH7Csrvk6+/XU8MUXSK6/bwkBcPw8yli4TKJm0GDh4o3rEbC?=
 =?us-ascii?Q?3Xe+lDEl1UxlGh7BtVq2kcZHnDm4XXOUzIiWZP5a8H5oXOkpWzGE0m2AKP02?=
 =?us-ascii?Q?sKNl4I6IioaI/b5Ph+R/pjiluHwwvR1UZAQTTspXeFdeLJ4p9CiLl327r5VJ?=
 =?us-ascii?Q?oYlzOCO/9tKAxE1sajH9t7jCOmNjyPcVyAreJFs7hhulnTDMbKRCCTnr2jCh?=
 =?us-ascii?Q?gtiVlLfBO3Uc0uvfCrR8xWXj7szkQpdKdkKZxRqEjl1P3qye4+YIJiNbBDlt?=
 =?us-ascii?Q?1nWv0cj4SabZ39XOH263n8hBPv5JneBmEVL3altl7mn4Pt7AtqcypdGWj75V?=
X-MS-Exchange-AntiSpam-MessageData-1: DaEuuy2nw4bjMs/pjwU0lDZfnHJFmeRLhho=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d2abdd5-1e85-42ef-388d-08da3d7b06cb
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4787.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:46:23.2162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FDxj8X5Z5UWSG3Fsn2YJEaxQBX1nYx9f4kzH8HLJvBiMLLqdXXZefwDpMmHkApvRC1tOFWZIWu50W/aYHXdBn49SXURCR23k422PfudTsnY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3070
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-24_04:2022-05-23,2022-05-24 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=585 adultscore=0
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205240061
X-Proofpoint-ORIG-GUID: br9K5afrhsFWPL1cyIOD54QFrYMvfmgH
X-Proofpoint-GUID: br9K5afrhsFWPL1cyIOD54QFrYMvfmgH
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jose,

Thanks. I indeed plan to attend LPC 2022 and am very interested 
to participate in such a discussion.

Kind regards, Ruud

> On 24 May 2022, at 12:24, Jose E. Marchesi <jemarch@gnu.org> wrote:
> 
> 
> I am adding Ruud van der Pas in CC.  He works in gprofng and would be
> willing to participate in a discussion on kernel profiling.
> 
>> (Re-sending with Vladamir's email addr fixed; sorry for the noise)
>> 
>> On Fri, Apr 15, 2022 at 10:54 AM Nick Desaulniers
>> <ndesaulniers@google.com> wrote:
>>> 
>>> Hi Sami, Bill, Jose, and Vladamir,
>>> Jose and I are currently in the planning process to put together a
>>> Kernel+Toolchain microconference track at Linux Plumbers Conference
>>> this year (Sept 12-14) in Dublin, Ireland.
>>> 
>>> Would you all be interested in leading a session discussing various
>>> profiling related topics such as:
>>> * gprofng
>>> * PGO
>>> * AutoFDO
>>> 
>>> Would others find such a discussion useful?
>>> --
>>> Thanks,
>>> ~Nick Desaulniers

