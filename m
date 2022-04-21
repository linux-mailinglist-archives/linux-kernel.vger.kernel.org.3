Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C5750A685
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 19:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390504AbiDURD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 13:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236463AbiDURD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 13:03:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31CB49904
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 10:01:06 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23LGHv2V019298;
        Thu, 21 Apr 2022 17:00:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=62qJ9A1FaxFdnXOV0A0gRlGlfwlsRqmMNRTK50FsAS4=;
 b=AYTJJm9olAyyNkPM79gixRtGNy2KopcfWiXJgmV2Bi+mMzOhkNY+ZMr4UbuK9GdBh6RH
 VUnet0z7b6MHCKt5IgANUrLYa1OKAvZVYwaf+S+hsle6WJswfTjznR11l8C2I0asNyvz
 UdG2lB8ouNi7F1GOW6+iesOR9pf9TWr7leS39l69OLnRQ6n4wcSm6ZMoxME0rfjoGtLK
 7WyOYAkgBddexo6HEvaHu0IT1iFtVuI6dqTKdCDnK1xICjciz45B2ljLaqTHrdLXcFcK
 E+h2nqQmYXb84+MMQQSuDyATpBQbI6Jk5xiwlasC0ecOc0rRJ5KoFj38Md7YlTzAv/yH tQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffm7cvbh4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Apr 2022 17:00:49 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23LH0k7C033873;
        Thu, 21 Apr 2022 17:00:48 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2045.outbound.protection.outlook.com [104.47.57.45])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fk3au860q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Apr 2022 17:00:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h97u1eqM31vU55P8LCkQ1ik8T9/mQZvSgLBJw6OqvfFxnWEIgsSb7kC4la+BE8rflHeb3VQkwSPYQw4s5f8d5eKWOKwDrYYpT9uAW/pBH77bOkB5+d5OdDMt1XaQNBR6T2w/+FmuOQmlPKZZ+YkT+jupXS0dV9bpAEp+m354zSljzFQMraY+azdAHiyG/g5eSsIuFSoSiWVLBE3TpkT3BbpT4qJAbTYWwNqj5R04I9oJ1NiD5KTuyFTZPPmHdIJUlWc8U7jE3FKqtIR5qRB/w8sW6bu2fKG0KY5crK6a3CgC3RFLG3xxL4/Wa5m5COHWmo95nQYJyWNIY7mQJLbTJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=62qJ9A1FaxFdnXOV0A0gRlGlfwlsRqmMNRTK50FsAS4=;
 b=OycRmMMOsYnCxGCLxOHUFMbqjMlbCKzifCPJDWV7qZqVTMGwQK+MK8h8hGrmiEqGfVSxJFLFXrrE45HrrBIS4u1AOXM0ObZ6f2O8+fF/CDnHRkB5WDeFQFWj/UN3r/dhugOQwxBSmA1EdBPeDicTzPTqRcwk38uxY2ZI2k5jRCxxKHH3e+tjnVgP30oA2lFOXDey7g+SijhzSer2krtUfaENGSJWWu+18HkqZZvtb1P4G7HBPq0MASpXymceqbqCvz+gc67GrL3XYDSexISa4LOeTefke9RKvX0lunZs9Q8K7NrgpjjCycZG35mgDDQbAq/5aTdebwwqVK4ucnKYjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=62qJ9A1FaxFdnXOV0A0gRlGlfwlsRqmMNRTK50FsAS4=;
 b=XNmQ3lsEOkXUeu/LBfu61vGLmxy062dCTnmLhxFRQZ8SfuzDhXIVan7XMl3DCsSTSnOcMDZbVN31pQCnMhljldxC9jMuYHAhp+X82FyXj3H5UKjLSFBnVc6QJvH+Ax7Zct2WLzG0iNt45zV8zrPFpKDy2ZdElgijVGejjmljpGk=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BLAPR10MB4914.namprd10.prod.outlook.com
 (2603:10b6:208:30d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 21 Apr
 2022 17:00:41 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5164.025; Thu, 21 Apr 2022
 17:00:40 +0000
Date:   Thu, 21 Apr 2022 20:00:10 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Solomon Tan <wjsota@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk
Subject: Re: [PATCH] staging: r8188eu: use in-kernel ieee channel
Message-ID: <20220421170010.GD2462@kadam>
References: <20220421015811.2745-1-wjsota@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421015811.2745-1-wjsota@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0037.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::7)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11992671-7232-4ed1-d64f-08da23b8771f
X-MS-TrafficTypeDiagnostic: BLAPR10MB4914:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB49144F847D37EE1A486C28C68EF49@BLAPR10MB4914.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z0Vsbo1a2DawYRdJFPv5A2VcUXpHxwiHzmHMQ5ss3edTSpGvbh1PPMQ3KH+HrL00UvpgoBOIjqnuAY+y7rmdM76AYk7r3oE2ae/V8acWhSqED30jnD9gwU/Go3X/DX7HR2uZSgzw7vUWQHVvc+9EwOqtGLF1KtE3twMmuqGWcpdu0bpMJ+36C7WEainereIoTU6JBPh2z9ikvIMBFAq9eSajQrdermH8Pa33ToeuC4jxilHdi/GDm2Fnmws7AKO+7SPmfN2qY9/W6kY/84EmustJ4xIWMowktGbcfW2ViObnaFwNi26s8BKBW70+1YO2T9KCeOYSP4xGPX4fw3xL8S2BYksKsL2TzhLcDy4iJim1EP3x3YrTAkLWmww35XsFLx0sgZDs4tZF68eB0W1zcOYPkp5xNRG1bTXAk3kzZRG+UW1I2bmJQGegaYXLIdkvHdjxGzhUEdXAidcJxjy2yd1uCNlU43Z8ScdNCy9lZch9QO3xReinXWt+TSFa/ylh7R8QZUFkXymBKBnJFqiLi2WAbB65cs7G1wCiGnBSS83eNAaqNlt3ScAnpY1Hxvg5XjYvh3UBcN+IFKcDJDfMgCNzQ/TNrFCZwTHSTeqn4qwudo0UP8mCFPVdPwuJLhmSZXJkJwoWyl7715HUjywWr9h4FKujhIoVFYOYjvfo5ZAVAp/igTIHow+NfHZmVeMbf8shIXUbSipCZT4uL5yRhw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6486002)(83380400001)(186003)(2906002)(33716001)(508600001)(5660300002)(52116002)(4744005)(9686003)(26005)(6666004)(6506007)(6512007)(1076003)(38350700002)(33656002)(8676002)(6916009)(66476007)(66556008)(66946007)(316002)(44832011)(8936002)(86362001)(38100700002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ttuh+xY44NTIZ0v8HoXenoiZoYyVn+Rqe5duMUSi9P0q091tXNvKZFbWkONN?=
 =?us-ascii?Q?O8qd5RjsX7zF9CTK5U+srsuqucbIwp+/jkMJMbOy/K9a/NgBCZpuuSpYkmKJ?=
 =?us-ascii?Q?gzM/PbQXC+WamBi9PC21i3o1tfVIK/7CKOPuUihsZiiMcPIghD4jg5eno/+I?=
 =?us-ascii?Q?KRJLQsaATcuToW+8x5xfdeS8Pah8YYOjaxlPyJkOoM1q/ExIYQnHkuLxMjJ1?=
 =?us-ascii?Q?VcioQlsggXHgBSkATbhocW3MUaiLe2ySsWjfBXvgM+R/TkhCrTiSUw75paVE?=
 =?us-ascii?Q?5VqkF9wsoc06Dc6mgv0s3148StaDQNmmmVBvO647dkBKpTtzOj7iJzcO8HCs?=
 =?us-ascii?Q?GaQ/NF1hoeiadTN7wD4LlFDi4ZVuGMjUrvOPkm9YzdBbECiMDsV9bFDs1Zh+?=
 =?us-ascii?Q?LyklvIgxYFybpg9PeRI3C5TJWfn29mGQbY93WqjC6nNbEDHaifDYBHbsEOgS?=
 =?us-ascii?Q?2Fair6lLZEPn5QJ+ZHeef4QA1y8sGXBcrwui63lYq3Y44XzskI60Kb5ch+CV?=
 =?us-ascii?Q?rfN+pZZgtjGkvrqegP5LjgPar5hZzwaZiYX741/Va0mJHzmoi+Li6IFaiBSD?=
 =?us-ascii?Q?Gvah+CLtTV2g4fvFt5vOSaarImqdVgq1qHA6Rz1fyICJ5N3wi5uIiw6a6iZg?=
 =?us-ascii?Q?/VNJuD4UV4gp0UejPfmOmtbslJ+kRs/TDih/aPf5Qg0OEAJR+CmGVoiqa/fz?=
 =?us-ascii?Q?8TRwd+bNgf2J7Rlfb0U1HDFULA4AWThNavrTd4AE9/EpCx/QB9qFjZ3LAe8G?=
 =?us-ascii?Q?ROh+tiUsJD1ZBCz1iEt6A7cIS/GRqOhjZcbaxe1fLa9fPLrjNuYfu6hTnG+E?=
 =?us-ascii?Q?w7uEVmozXRmd6ZGXKPrteAZpxig9Y9zLoAfdMqG0d8s8tHCyYtK9SkWuqC01?=
 =?us-ascii?Q?JrFeDcI90kPf3RIKBNEIOkVhrOF0l5hwX42Todw2Q8ZyVouKxCWFaKOU5z3a?=
 =?us-ascii?Q?JpQH6WpzCDGUkNv0lbh9ngt98p45UqdAwJA7w5GNLvBKsyP7gmr4IP0hrjDh?=
 =?us-ascii?Q?aeJ5Rq34r/EeYS+pu9hhMmbgGQi4eK1kSZf9TWuCCPUFvLMHz3cRZNKZiMFs?=
 =?us-ascii?Q?+JkKLE0TfOpT1F0DsiJhc9ueZwhtYG4/CTggWPupdlNWxYCrKdrN78AB1WXI?=
 =?us-ascii?Q?S125q6rrIPkSoBXgp2v1IGIggTdjoxAeB8ve1VmmtM9JU4hjVsS4pEXt9fjn?=
 =?us-ascii?Q?k9siiR+JYfvbZe6mOyWMf/ImuZ7vDxe9ewHH0+/mArvEFgPdBRz0XqY+suUZ?=
 =?us-ascii?Q?XgBqX4Cv9riXqYAPHD/wqOCnRTQ3f+QHoGGHD8iWokZ30Ls5It5CWGezYgN4?=
 =?us-ascii?Q?8s6bDAQdPcI90KVYQ3tjaDmqDE9vDQBkn0USgz9AWjddudqxXo75VLBLgBCu?=
 =?us-ascii?Q?xMYy8GnUV1tdC5VP3Bsa3YuLzzZPawQlhEyeYSoGJVhw+oomibp2s7A7wAeZ?=
 =?us-ascii?Q?u8qR4+Jwen6kaGs8vVERWAdL0jduaymulm3yGnm+Wii0eSmv5hPXalzlsGxL?=
 =?us-ascii?Q?D2tPLyOrlXV+xLSLoYazdncx0e4rp7qsFz2TOuH5iuX7lJsijF+XYKehAN9z?=
 =?us-ascii?Q?C2AJ6xWlXySMIuRaLT26ovSj6LTYlAqtFdVJozVf0eVCUWgRYQY9KjqBlfKV?=
 =?us-ascii?Q?ZSHsh+LNNBQnO1ogtVE5G8zA4SfL3h4ebjBONm3CupvqA6FU/y3WQaCBRFrJ?=
 =?us-ascii?Q?kYHDxIWq4cq2ywfPsXSN0OEV/pVGiRbK32WQrwv999PrZzXEaFb9m8QjTWJX?=
 =?us-ascii?Q?68X8zl9USsFot7OuFhgqweNaeiIVB4s=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11992671-7232-4ed1-d64f-08da23b8771f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 17:00:40.8532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vGAiE++oSxv0GsJJJlLeQ5X5Inw//OYKufojMAtI+7Ft9Z1iODZ99g38TicpzAao8N1vx26sKrWCyjUIQVNdepyAEnrgB3pb713bkoy3tiw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4914
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-21_03:2022-04-21,2022-04-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204210090
X-Proofpoint-GUID: Q5E8DJ3uiJpELCH6dmZKXODz9Yi4l_My
X-Proofpoint-ORIG-GUID: Q5E8DJ3uiJpELCH6dmZKXODz9Yi4l_My
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 09:58:12AM +0800, Solomon Tan wrote:
> The rtw_ieee80211_channel structure just duplicates the in-kernel
> ieee80211_channel structure

When you say that they are duplicates, I expected them to be the same
but they're not at all.  ieee80211_channel has a bunch more struct
members.

I don't really have a problem with the change necessarily but the commit
message should not have mislead me.

regards,
dan carpenter

