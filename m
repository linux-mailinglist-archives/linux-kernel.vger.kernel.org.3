Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BEA14EC858
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 17:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347680AbiC3Pgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 11:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348329AbiC3Pf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 11:35:28 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 742B82A913A
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 08:33:35 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22UFL0BB007033;
        Wed, 30 Mar 2022 15:33:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=fKYf/DJvJBKA984+GRiO4i4a6vU7sUnRXAssiXfPW0c=;
 b=A6Kaa+7sIBaMdi+RpgWYtssw13WZWxfwxzvfp+ykdoYsfIBx9BpAKHMiZtShAxtnrkB9
 c8ZIXYGCZ8UTmfWOJ+E70sp+LXF+oWMieJFemiVRskd+xTkTi4fSw8gLXzehfTFlE2AS
 I1X+yFv7k/QUramfprjAsVCukp9X9h/IHql6r5XEGP+8fddVB9hZPxxAE9CQKDnLcKhs
 52dymtTtdzUO/TcW2qQ+E5Kb+P4FCSHriddtNmE4SuHSI/xPaiXfs4qyPrg72IKNKTN3
 JKQGqGRp35xILKKPebzvsbCP8kEG1yhV/XNbj9gZkMFlxSF8A4EFxNhjoTkWhdFNf7eZ Iw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1tes1tnx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Mar 2022 15:33:13 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 22UFUWKp028764;
        Wed, 30 Mar 2022 15:33:13 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f1s949nq6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Mar 2022 15:33:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i4XItIsdrHmpw9pyoa783wmfg0jHh2TzKhTUV0gx7iZDn4lBZiI+6ZFE4bVDH/RwKaYRJ1Jm6p63HaP2ASm8lyBuysMhMpuzliD853ZYRFAsEfOMI9JqtJBxTGp7StaeAU1RGybmHWTv+W7pMp22XClB0kK+Sw1SI61Vl6cUyiAhL6DQ8u/BdoDEBabFamLfo+C8bujTsovNvL36avMt5yDB1sdAFqyJAgnn7E4OYZBCriPq+nPgMmV9oWKmvdaFibF+5EfDHk00PK6c50nqaPaRbaEGbVEs4sgnDvrq8D8cZ0oOqbuF4lTuY9ZXvFm/6ya1KIsiPsy6PLVRBWbYtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fKYf/DJvJBKA984+GRiO4i4a6vU7sUnRXAssiXfPW0c=;
 b=Ge5SrCe8ts03LvHLok9ilP00cNBWJjXL2YNVtvNuMb/sR/SjpJt7Gp1bOLyYucuqn9yvlYEIr799ihc56YpkSctdZx42W7knOR3uV9cOLAbWh/7XPCl+CTmpCtXJb56/1p2DtvgIMYWh7HDACGewUkzvUVmrSDz/59f8BOHsWd6x2kZFcnSpcxRFuSc/h1DgJFYcr6pNoYbByyjjorV/rCSfij5UFvIfotb9Us4aLOGQcgFavmjEtybp80TxdpPQ90Y9A0yzzaknpxn3fEEVXJ/0nprhqAUqZGnnzKQgF6/ESSeT6BU1BBh30xTptXVvr+NZchOpiJUtx3iasRWlMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKYf/DJvJBKA984+GRiO4i4a6vU7sUnRXAssiXfPW0c=;
 b=DnlXbY3pfe5EPm0DqLoTIrDoe1Zo8o9W1s2XgBW2UfAaemfi8MXcvicjXxH61vNRgND9MUj+Nc3hUYK/Xqxbw5ckCRkAPKrBY+Rkzs70krvJAF4kcrK7/xLXPoEdxE4LIzQ4cfQRR4fd5sHxEMM9bBf4dWudyquyzWwTqSSDs8o=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BY5PR10MB4195.namprd10.prod.outlook.com
 (2603:10b6:a03:201::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.16; Wed, 30 Mar
 2022 15:33:11 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c%7]) with mapi id 15.20.5081.025; Wed, 30 Mar 2022
 15:33:11 +0000
Date:   Wed, 30 Mar 2022 18:32:47 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benjamin Philip <benjamin.philip495@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Colin Ian King <colin.king@intel.com>,
        Samuel =?iso-8859-1?Q?Sj=F6berg?= <info@samuelsjoberg.se>,
        Charlie Sands <sandsch@northvilleschools.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        ira.weiny@intel.com, outreachy@lists.linux.dev
Subject: Re: [PATCH v4] staging: rts5208: Convert kmap() to kmap_local_page()
Message-ID: <20220330153247.GW12805@kadam>
References: <20220330143331.8306-1-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330143331.8306-1-fmdefrancesco@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0035.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::19)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84c5fed1-5eed-4af2-d14a-08da1262991e
X-MS-TrafficTypeDiagnostic: BY5PR10MB4195:EE_
X-Microsoft-Antispam-PRVS: <BY5PR10MB4195BD3139248E5C746436EA8E1F9@BY5PR10MB4195.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PjU7PV4wC0WvDpsub8/U/ZwuZt43ywqd4dN/tVZaOO+GUMhuupA2N6Y+C7PbVoKAhrmy3yqDBY0jSGKLuA1OzYA7yOj/ON6KYJ5cK/xh6nivkLq9/7kiKxxg2nxH7WPY/yNe87BZdZvAHaXwCS3zTKwyq+sW8zpSKqiWraKvo+nI1OYJlWaGigm64FktLg+jaS7VLZJ6AYkI08V+RzhlUWBF9zMQUvtlAecRVam4zdiLCj/8OfziAkJdpN/6q2zH7+aSx5vECWSd61Fa9QCMZVTmEeV5X5P2mDgtju9FUinltOqCVh6Cs+YPa0xW7dofWBajYaIpptauLjNm11u0qIPIwstAEnZEcfSGqkeOtIWHYlAZy8gkdztOxbpUe+26amSAlfDwdBAEN4Hm0xQBr/ydOEqciU5PvQNi/SvfQTopqKa3eM4v3OeMhgkmcvMDQsyB/3vatbqGNSPx0Ikrdd/bSTSjSZ4L4mV+yivV9prL4V+KzDU5h042aLTAzRwwdI3agNvwWZPMqOlUPb2+KKS87C78zWqv5GY/xzbN0ZONTexzGpwWtQddI6PVwgnnHEwNnRSYqxiVm38ilmoBPrRfy106jAeC6sh2mnsiDkTyz/+1vJOOfDGbumH1dPMqGtiqkZbCKgXudSANAcdk3DbOWGKaW1whAng+f18tFqX/OFY+HB0lwVILCe8XZANdX/gmWlFjSFMwiFA43upAsg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(4744005)(26005)(7416002)(52116002)(8936002)(44832011)(186003)(83380400001)(66476007)(508600001)(66556008)(4326008)(66946007)(6486002)(33656002)(8676002)(1076003)(6916009)(6512007)(86362001)(38350700002)(33716001)(2906002)(38100700002)(5660300002)(6666004)(316002)(54906003)(6506007)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pYu2ndpjz22e9l5QOsjzDw+IInxmMFo1lL90LqItthJDduZ5EIGaIQD6bwZj?=
 =?us-ascii?Q?gG7alWdpmNWdczkajeujsZ7c+rOkBkMZHUWsNjP92gEvhe2uY0UGgD1sdmby?=
 =?us-ascii?Q?J0FSmI2A5xqIpyKRGy0jFkxv5kh80a23jJaTM7BrRdvLLveexfwfp2bbHfY7?=
 =?us-ascii?Q?GrJ4wYux5FF+6oEzf/tltvniurLUB6yqrkL9Vpm+8dw1Vj2f9Sfw+6irXxH0?=
 =?us-ascii?Q?YIhV3uqOZUl9KQ518AZTSyBhM85exQrV08zEHzZJ8Y79BGp2rA7m++2hdIVt?=
 =?us-ascii?Q?pbbPcMaIrJErGZRz8F/A65z0c0gQFXsJDvzgjPQBe4YTlnLVQ+QkAM6DRwW5?=
 =?us-ascii?Q?d4SaYA9NT049b1nBXFboyRtrXdxTyzgGHYGWyXAHRNLSTDW9V0bUADnEvJUP?=
 =?us-ascii?Q?UKCxrmp0izrt/hN/DVlbh8z4ybsT7B9rYmYJYNNzL6xNOc35r6AQIRwK9KR0?=
 =?us-ascii?Q?m++Hecc1mBJ68hVPU3nsXzqCe/73xvkpp1xB/wDunH6ZVcR80RxWv8vcHK4f?=
 =?us-ascii?Q?iN7qpKv5Gem5Pff3rxdvqkf8QcK1UBq18Q8b3RPSL22iUtwK3Ie1+eTFaj5B?=
 =?us-ascii?Q?NtvgBUbpKLsgMDfF0Ee9YpXU224ZxSqwmH3sbYTYB8qlEuYGxZjON6jTG2+H?=
 =?us-ascii?Q?7mKu75IZrVuEtkvnUUPNZCuoHvOs2zMcTAIEUp9jWcB5YPzTYuBvN7m8xKW6?=
 =?us-ascii?Q?aVIKoYoYDP+p0DSKF2voR2PzH23wCJmaFzw2Z97//glznkpQbqtCv+FPWcDk?=
 =?us-ascii?Q?ANNW+liqIy7ZY+gBb5jrVVKeI6P1WogqwS5S4mnIHBspi4QXMZDBgpsuCaoc?=
 =?us-ascii?Q?KprvVfETJ+tgFo2A+DyaLsahlR0C8OMVLXILnLOxVuB0VbJ6cm6MfK057FI1?=
 =?us-ascii?Q?FHnqz4qKBjHIl5BMi95n+Bw2vTE7rfBFMpU+1VmM4o3R1LDEkeTstFq4eoEU?=
 =?us-ascii?Q?WHa7U9Unv2LFxcCvwJ138DfwiDbO2n4Q3DYRFjcZTnPw/LFQfeZtqew/4xdR?=
 =?us-ascii?Q?8T+GOpnYhT0YSVUjS6mjgI3fLy/rOfSSVuy03EEwsIkHydjiJZAfu65vebSR?=
 =?us-ascii?Q?uQofkWpjLgGg5n6CNKIWG33vVZdYrRFknzqzzqlNTdQIVr07DK/lu7Cgy69r?=
 =?us-ascii?Q?SSXDP7irVX2/28PRAG72dsTTNY431/4bbeUy6xTpweFwGnMAIhhmmUp/ZD+I?=
 =?us-ascii?Q?YlXvswSsRgqVeNeprEbHfmcfJwIm9JB7XC074QXA8clxO7pZtcbh/la7Ti3h?=
 =?us-ascii?Q?YDyaT3hYJ/y1fQqqtkTibkbmpohwvCRVlfMPjDxyvOLzJwzF89Wt+/knxpoL?=
 =?us-ascii?Q?uBtbOed7dAiTrMXF0jGAaAWcnZSMDyIJk3gj6HSEnPvPlDXXX5ByVt+yJ16p?=
 =?us-ascii?Q?44OamuaCCupjiC2SH/8nCtQDfd00yRGPHbrHUFk22rIHmg8MjRZDQrozcxwG?=
 =?us-ascii?Q?qHWV1OF/4XP4x2Nm/XOzOekE0vJ4zl33B/ZI1ISKsC6M9JkN/YLpkImLAHaK?=
 =?us-ascii?Q?pXoo/yd2mClEVgMxpzb/GqpNYAOizSnAqLtzwSBtdBcg/ToKXY9N3Di8YYr7?=
 =?us-ascii?Q?kLMUzgwpXUkF744pMjV2ywXlVr/Aa2t9RTgK1USwOAjOEIdugTE+TQDptHCU?=
 =?us-ascii?Q?5nX4ZpL5luqHbz8Hdg/xXGzIXP/XMXJ3uowj8Vlu2g8I1gz9cJ0j2TOEXyJ/?=
 =?us-ascii?Q?itMR1uPXfMfY8M0i3X0MV0XUlGs808XLG0PeBvCj/Xn38rfk4DdtEKMGKTZW?=
 =?us-ascii?Q?L5cKjWim1a0jUzdgHcLBTlek9HynoR4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84c5fed1-5eed-4af2-d14a-08da1262991e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2022 15:33:11.2937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qxYr0YcSeXaE7xVM3xs+EpqezkpO4NPCLClXsY0lRgFUmGxmLGpWF6LClde3xojmpdWmB8/xms1aJ/ga8d86oyHTGq9+cgP+6aT/et1pd4U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4195
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-03-30_04:2022-03-29,2022-03-30 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203300075
X-Proofpoint-GUID: frTIr9K4mD2AZNahXUgTzaIDpFXy5qbh
X-Proofpoint-ORIG-GUID: frTIr9K4mD2AZNahXUgTzaIDpFXy5qbh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 04:33:31PM +0200, Fabio M. De Francesco wrote:
> The use of kmap() is being deprecated in favor of kmap_local_page()
> where it is feasible.
> 
> With kmap_local_page(), the mapping is per thread, CPU local and not
> globally visible. Therefore rtsx_stor_access_xfer_buf() is a function
> where the use of kmap_local_page() in place of kmap() is correctly
> suited.
> 
> Convert to kmap_local_page() but, instead of open coding it, use the
> helpers memcpy_to_page() and memcpy_from_page().
> 
> Make a minor change to a comment related to scatter-gather.
> 
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---

LGTM.

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

