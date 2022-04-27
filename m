Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E158D51220C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 21:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232600AbiD0THF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 15:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbiD0TGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 15:06:43 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60767A0BF2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 11:53:41 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23RIUrb7032133;
        Wed, 27 Apr 2022 18:53:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=i+ATrl1Hdd/jhLPvDwKn27egXh2anFHt+JrU+ACbIMQ=;
 b=Lpb+7W6R38xkCi7ruXEDHwkYTew6GenKeXU/oAuDnpFLM0zqbdzqiqfwxc641KiMQetT
 lwOj+kUd+WlZUXUlLJ2nmU3yKmkt90u5HNAcz2hjqulSBJ0RJH4hXhkFC3S5rkSNplOu
 mUiN5Ol14SnpIsE17LZwfKY1F/ChNrx2EZfXCtC5UOnPvhHj0rq3rRaRpQVeinCGfpFS
 dni8iQlHdErgMakBe/hbcfqBC3kzXI/yibIfu/mmeAL6mB2a+f9BnHnoWcvO4G1m2MeO
 KiwLSJAUXe5OVn8jILryNnwKHzKQ8Y8lwKq2W1N1lhJl6khT/dbQ3gZGDtzVwtkpEDdR dg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb101krk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Apr 2022 18:53:34 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23RIp8Jt004097;
        Wed, 27 Apr 2022 18:53:33 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2045.outbound.protection.outlook.com [104.47.74.45])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w5c4d0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Apr 2022 18:53:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J4OjfrWPuB6Q6ZbYcQ9knPrqGllx0+5dDIXP4CnoDB8TFj1TSRL9ukWHe7UA8hi9ubHyuqbbB0L54Uwi0kHgHZue92M4ScCzShclMRfQ4lRZXtFxWy7PgQBs1NTtPtAv1H81Z1fQIe0aAJ6oC1xP5zbcWzTJhLfUH5rFoqqdfOgen6MgJbTRo7YSNL6iUYI5Hn7Lg7ZFeyqGYha0iaphjqGlgx1WlurqdrsA3zdRTOTPo6QgmW6TKPMvPA5XZwquuRzFb/v2QEc8MTsINPKJYghfTK36yhwyluFMLssP14HRycqnyYnjtqdW2cxuAUq2LTyoOZ8lmY+87ggh5hndYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i+ATrl1Hdd/jhLPvDwKn27egXh2anFHt+JrU+ACbIMQ=;
 b=F6ohKUycXPE5DV7gqMIzz4CNacBh86x1IdrUNDRRxzHlFtCvJIVp1amYL0Dvs3zQGvHv8gvHcLLHdSyjeUAA5s6PWDZBGntkC4FivlcMiaw23JG4DaPx2u5g32nmT86OkfhGWVQ+IwfhNorUzzhb6MLIFxUepcMtoAoSD7kvu4zBlICGsOSppsjJvgFrV/zrq72FY0TiUavI+qvEUssRkaXtwHinGts7FQ1EUShru1k46nK+sPbfTuM0N8X/QkvoEIM0Cj31iuvPLEyNTKVj68zVCnsmIvoX3S9onKSjyCMsPypU9gWVY4ti9youQHCpCm0wtXJjbwYt3lMKAN7iuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i+ATrl1Hdd/jhLPvDwKn27egXh2anFHt+JrU+ACbIMQ=;
 b=GQQ3pH1ejo6iUMywDutvSTlShZxsyy2ePCWQV88Hq7JnkqgEZZGcwvod4+1OSxnpWKdDtJivK7C1RtBJc+rLL3G/uJlBOJu8NR8TtnX5sNzXntYQ3Shm60y21AN2m9Dev8yURNywx+2oOmGQORM+v1fBJkm7Cn0E7TvkFNbrkjQ=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN6PR10MB1476.namprd10.prod.outlook.com
 (2603:10b6:404:42::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Wed, 27 Apr
 2022 18:53:31 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5164.025; Wed, 27 Apr 2022
 18:53:31 +0000
Date:   Wed, 27 Apr 2022 21:53:13 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     "kbuild@lists.01.org" <kbuild@lists.01.org>,
        "lkp@intel.com" <lkp@intel.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: net/dsa/tag_sja1105.c:432 sja1105_rcv() error: uninitialized
 symbol 'vid'.
Message-ID: <20220427185313.GL2090@kadam>
References: <202204270649.Eun9P40C-lkp@intel.com>
 <20220427135128.la6ifcrs2nmnx4ro@skbuf>
 <20220427142839.GK2090@kadam>
 <20220427151754.aosfkepramrgclj5@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427151754.aosfkepramrgclj5@skbuf>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0019.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::31)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d254e34f-c329-42b8-0ec8-08da287f3953
X-MS-TrafficTypeDiagnostic: BN6PR10MB1476:EE_
X-Microsoft-Antispam-PRVS: <BN6PR10MB14769FD105523CBEF62BD45B8EFA9@BN6PR10MB1476.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cFrcM19Np2hevjlwh1lSKBr0rLdzBaLc4ym0h2IIiXghmlWSj7/LCtydOZG2mNUiBdpW+vqcYfxQc8g0Yobgm6PoZc70dE5XWgvqgktRKc+oLk9ZkzKtTT6Z1zkK29JQ3Xi2nyRucS7UY9DGxfvHTRlgKxfQLiyREh0vkcJB2DSogVpi7F6UEgJXXhgR81Qq/e9Ah+YSo83XQG1mlzhVn2zhNW9dH9MCaExK/8b32oNbR/x1pQh1kXQpfpSynGRBpVQOnv5uJb2UMunTcLSVWzi6qU2C+jVT9QoZJOdqO/bLvTiANTSQsxVnxM2WlDTme9tlIuLUJFEy4xiOAXDXPwjs9xjOLRaz9lZH7b7rbLx2iXWQ+4+shdYzshLHUX8v2+RxtlDMSwzLvnFLgVLMAM42zSW9VSCxyRAfPZPDZjqqV2ghbxJTKQbC7/O0XUPZNPx3AYAuIvhUJKo5EzSGLTZAnCPj+LJtvBndUqoes7+KZcFJUejdttZYXWlCB+ua1PgyQd2Fs0BD9kTbHyYQdbwtDAu9qriWKze7W8WcTrrK8bWBqshWh4WVBmUhB/+MpYnZC+T0jTqYK+9pf/x7gdo8DEUPu/2wKnZHojYftRFEyYCSgXDVXHyN/Akk9N6kmMkTvBr2FFcoUlwsCu+LiFHn25EA+BJyUMR2ur4rSwvGi1lbD0VuB4p8luU6MYjdwTZR/kiOZW0WSUxczK+hXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(44832011)(33716001)(33656002)(5660300002)(186003)(66476007)(316002)(66556008)(4744005)(2906002)(66946007)(4326008)(6916009)(8676002)(8936002)(54906003)(52116002)(86362001)(6486002)(508600001)(38350700002)(38100700002)(6666004)(6512007)(1076003)(26005)(9686003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GH32Xf7oVRVDFumE5d+kA8HLqFw6IhYrr8mle7VW3SlR7oP1APBw/vVJPevg?=
 =?us-ascii?Q?4KXD+R+RBLuum67pAO+k4797ilpoT5rcLWtIPl4fVV0ZpvVae+vrYpO/q3uc?=
 =?us-ascii?Q?JOMeptHQna03ry/iYTkRzAeJr4Q+G8Rcn2hH29gVMVeIOjw4FwEHmQuvCDfJ?=
 =?us-ascii?Q?OY6ZvqyLus+jAxbuOCgk4rH2W6NSshc06CNGkYMpQLp6hDeCdGUCG27qFWz6?=
 =?us-ascii?Q?Xtwth40hpCIBNJn/QQI5NG1H1JKjFTNTwcLyzsAOLBJDQ+Yd+xKBmyCsUJgG?=
 =?us-ascii?Q?m18e8O0BK86RsThrdyRX+FcFt7teQg9BJ0p1/BegBfbSrAhPiHF8qwwaLjpr?=
 =?us-ascii?Q?aqkSXUAUYLe0Pqe0f9io0cFCjl+WU7fw3yc9lYgRxXaYfYWmSYp97Aa/N7nW?=
 =?us-ascii?Q?9zLNP5Emy77Kx6AWOLeLj2OzMWZPA40eopCTK/1vN8X4kOB/nAubHasv7Rvw?=
 =?us-ascii?Q?X7/Ath/JmM4uIK7MFoery1uQfdRLIsxUfU7Bhw8su9P+vpYthnAgemAyG4pN?=
 =?us-ascii?Q?iXgxmlOdWVEPo2bR7ggceM/6EnIVqsS1NTb7XrQ/BH8dWf/gpVymbdfPfXe1?=
 =?us-ascii?Q?KORFuYIo5ou0XItGAYZ1HxE/p6JNJ5patltI4IWwxJxn2yzSwdPsP5s+joIS?=
 =?us-ascii?Q?cvpgfRrhQJ8oHcWBnzyamkvouI0CFabvmQ+1GHLsFPllm8UYuwW+pKrj5OYc?=
 =?us-ascii?Q?yRU60fzaNkdJ6PH83Jixgl4p4TUHtVofADYEblXclgmQSV9xhtWwvWch1Zzw?=
 =?us-ascii?Q?VhTiwF/Cx4GBMU55t3uRZQGV7nzCjgWLm71KtUjKHZ9dHP9qSbEOi+JYscQh?=
 =?us-ascii?Q?dWjkN2jdghwcU8B8u+POMjMMBtNkL+giXeT4ePGoKOEshXVr80FpCV+rsm3j?=
 =?us-ascii?Q?XSS41LT+FxgUgbOnyak6n8vHihi3QMezxLf3j25LofvJdEyp8jIx1clo3T0d?=
 =?us-ascii?Q?yyQ4UZp2rSFV/26x7Ldseuym+uv3b/p+gxJQyAHdPmlczaHO5WOs3EsvH9cg?=
 =?us-ascii?Q?bHjjEel8ixsU/8icNjZCOOd1y9mXNRPXgYfJwXCjyAbbcTSbnS7IU9MDnHgQ?=
 =?us-ascii?Q?u4Rkuuxa7yuo2mQDcTCwTfuTANjJotzzH+WebNRgyFivnuTrGUdTG6YWL9Ym?=
 =?us-ascii?Q?wHAIsTfb6PPmluPfVXjgmGS8I6k951lhQWU6pggeJip2wSB+GYP46TTirrxf?=
 =?us-ascii?Q?dUJl3Q/toz8Bsf335m+pizI2wxRs5LsN6Di7zpDDK4XsZEFNkGQPYvNJom/S?=
 =?us-ascii?Q?jA1e6AJtv5/j5g/FWydSWgk7dEeV7FNkILQh1BCq+n3rf4C/jtsAuZmss1tQ?=
 =?us-ascii?Q?M5GEVxLbc5SkeN5odnlzdRKEYWxOSrnEOs0YL0mBLSYJK1NpIc5hKTAeeELQ?=
 =?us-ascii?Q?4RGv67DYzTfHhe2yRZmC3vnDO4Cah4A6Nj0jx8nEUvNTU7TyPf4bGtreO8xZ?=
 =?us-ascii?Q?kC5Fw3BKY77Uv9im0VfGzcpKhQoALQWzqiHmk3+3CBOS1xJ9Am28HWEj3nur?=
 =?us-ascii?Q?YM4hDIPipjmj5fDcllKrFbeUqoKGQOlcFzBWRc7b2zMsdHZoQN5Wv2PVWQXB?=
 =?us-ascii?Q?0x8h3hkioyFdCoYmklsIpAgMFNFt91pR2CZxzLB2s8PpCB987GpDe6V8pECS?=
 =?us-ascii?Q?YbIwPveBLtu+zMQdT82LPTPaNuPW0QHz8X0kSABKKVpQCrvqirauJoYACgnk?=
 =?us-ascii?Q?WNrtGMVVvimT917MnbKfpkD586N/f2IPU40ZcQpa+uYuxrmhHPT/yepB6I9S?=
 =?us-ascii?Q?1UlvvjB+pSOUM0VwY1QKYI8XkM8hlkQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d254e34f-c329-42b8-0ec8-08da287f3953
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 18:53:31.6236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: haJNSSX4hS2NJd7++DibJcZgTFx62CLKKGQhyfazLZNHwHNMxK/VW8C6KyeJkiD5QTQ9+v4r6pU7Nkvcml9Rd/nnLk1/E5fVL2mIXlOBgHE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1476
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-27_04:2022-04-27,2022-04-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=977
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204270118
X-Proofpoint-ORIG-GUID: NoKisPxExGFBMiSWbQ9VvVSWzVzeYZst
X-Proofpoint-GUID: NoKisPxExGFBMiSWbQ9VvVSWzVzeYZst
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 03:17:55PM +0000, Vladimir Oltean wrote:
> On Wed, Apr 27, 2022 at 05:28:39PM +0300, Dan Carpenter wrote:
> > I should probably have wondered why I hadn't emailed you before...  For
> > some reason I got confused and thought it was an arch/ thing...
> > 
> > My desktop build does cross function analysis so it doesn't print this
> > false positive.
> > 
> > regards,
> > dan carpenter
> 
> So I don't need to do anything? Cool.

Yeah.  It's fine.

regards,
dan carpenter

