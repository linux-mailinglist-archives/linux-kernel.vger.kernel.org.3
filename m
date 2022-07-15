Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA55575ECC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 11:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbiGOJt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 05:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiGOJtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 05:49:23 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD82D26543
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 02:49:19 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26F8tAxs032705;
        Fri, 15 Jul 2022 09:49:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=5PFaTYsSe5W+l9z79Wv2wRZRBQ5p8GBB92rJ03avcjQ=;
 b=PCq5R/YOHaCTFmbrlrIX+AJarvotZo0n8l38Yg7ATjcaFaWBYcQNTRL4h+H0EIMfmdnc
 F2GGs5krrsOA/aZOPUbTQ8IHY7islHhJx03EY1OsXL0KZSABMrZ+trMhw2k98xdh0jyi
 1/mBAX8XQk5JMrV8YrwPgjbXocw/kaVWIWb9AbcZQg0mHdQoxHN1CRpbFmJeiMyUjbpJ
 kBL0q/+aNPzJcdeC/5QtxHmWjxKleso9vquNeugth82YsKjm2JpH2V3uLT8fx6pFzgKB
 drgoDZY9Aka52S3r0gvP6SRmjOIXE0MyWbGbWNe+f/dbQRnqK4LqhiMi1YNp7nXUsb0S hQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71r1ey5e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jul 2022 09:49:14 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26F9iu74015530;
        Fri, 15 Jul 2022 09:49:13 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h7046s8nt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jul 2022 09:49:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GvCX/fJbeqeTZ4NLL8F8z7dtKgXB+zN0YdyFMhFhGwdJZpT7YiPn19T7Cp1NZtVKspyrDHDDAwOFgeWfzaEQqzs8yv5SCaP6/eG2mawprmGmKXTMx6sXZLV/f5zRaIC33r47Zd65YSMxV+gEr7w5Qyle9qsaDN9tXjBdKefFDsIpI1kNwl6f//NVpZEO3gE6V9t76KExkpnLLSqPma0SynwFwXSUJqpsXtG4MPlu9AHaR0hBxCLrshMs6yw7K4KEBVf/q6laKfmjprkbm1fNMfr0SZBZ4C6HhSoQRCpUcF/HGP31b9BeKN+/b61zNb/3qoS/rfLZ2xq+bsPZKXuCPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5PFaTYsSe5W+l9z79Wv2wRZRBQ5p8GBB92rJ03avcjQ=;
 b=XXKYwfd5e5/nLmrRbmxO9YL7iwxT4wRe5NE4HgWB0QuU4SVXrRp7n4zdsygikel3jnSou7WYdt1TyuFzrTFFs4yWXdufSnol/XgFl4RdsUYQze9TPQThML+nOIk2VtMPwS8LxOYoM+2ylu3ZQAy9EdQ2BOM3JWAxEpHanFcvVlsjkEJFpceFnEag3es3oI/S0zKbWY7Zv62k2obzXE6L6zu3eU+mKoa+zXpL8VgGmbywNkcygSr57yH9c7FepKfWX/RUkIiDv63VVAI6f/eZlER5GZfsTnJDAEL9VwK0y/GcazzLHg/dtGXE8CaLENmQO+On7fmao5W/AX9LFrCBig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5PFaTYsSe5W+l9z79Wv2wRZRBQ5p8GBB92rJ03avcjQ=;
 b=Jpt79wV9kM5Ab1Vil2WAtxv+Wj/up9aVIKnEJ2P0n4OGjw/RICJsz8tqMLkj0jemow1wtMgj1gK1qIorB4VGjfDVPh9c/XwhzIpNojyyawiZ1qiuFrsFGATWdQ6kkjtZgfIRUTdt1822cDFaZaroXArlaCg4DmAw9AkRarrukOg=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM6PR10MB4282.namprd10.prod.outlook.com
 (2603:10b6:5:222::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Fri, 15 Jul
 2022 09:49:12 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5438.014; Fri, 15 Jul 2022
 09:49:12 +0000
Date:   Fri, 15 Jul 2022 12:49:02 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] staging: r8188eu: remove unused parameter from
 update_TSF()
Message-ID: <20220715094902.GZ2338@kadam>
References: <20220715062908.8547-1-straube.linux@gmail.com>
 <20220715062908.8547-4-straube.linux@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220715062908.8547-4-straube.linux@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0161.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:1::24) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 616265c7-559b-42ed-d5e3-08da66474542
X-MS-TrafficTypeDiagnostic: DM6PR10MB4282:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yowmCIPNfwuW+UzEI4dv+8tPrk417xPo5ydw/ueMugbEKf7vlN7IKGaLUbEDhw+RU074oSgpVkUYB82xG61JCHddnSV1FMl/yEOSEIet0Ktb87Boc7szpdnkOP5wsu4ihwrvCnABvGw08Xff5UZ5O7tZhRfaFq0vb18L7UDhasfwLAmbT91hiNrLl9qSVQVj/b3/3xwpBhlE9DLK3kSPj6vNx/2bgT2xOEQhIiZtrVwvyzR8H/GMDUTFX5DTooCZti/e2hUT4oceeZq6cMg6Z4uIZf1u3xtN4lEn2OAa53V96ue4ADTncS1FvLcSLdvNnLGZc/zUqfoMoWs73RjflXLLp9vSJnob3B8ZnA0wamOK3QjDWGuvWewn/GOWLQDQ1d4oCSTwlCBEUxnM5Zq5NUUKV6OM8jjtjQ7c1kLRU2pFPp4cD+u56IiU0f/Qzu8fbD7O214Bsz+b0srlKZvlMdHlFgl1XQ1OyUgBQR4SBswslakgTXoFFTjfAzPoo3g+Em2bfxipx+hfeECtvCeK1PBWhONRROi3uwaLOgbMZEQDAO55gqTeBldU3JoQxURHUB1vuxUTOLM7akNi6tbT/IxfMs2cToHLsWf+jvJ62udak/l2BdonqZpJBkNgE3IjJc3wM6mEYTXkN46RwJvVy8pCPcPCeuZ8xjnuy/ay++yk4YfU9PcYNYhKUOxntSJrOYuLsctH6rgm+0ldR5pXb2EipjRc4/1GgCXDACA32LnPuJrA1SleYNv6T+ETKEFilOcz5/4sfMFE1hs0OfCEa2FG3n1CkdvWH8ugzy90+X+2l5mNZrpgUQ5cYNPf1hXO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(39860400002)(346002)(366004)(136003)(376002)(396003)(4326008)(66556008)(186003)(38350700002)(66946007)(33656002)(83380400001)(66476007)(44832011)(33716001)(5660300002)(8676002)(86362001)(15650500001)(6486002)(478600001)(8936002)(2906002)(52116002)(41300700001)(6512007)(9686003)(558084003)(6506007)(6916009)(1076003)(316002)(38100700002)(6666004)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DTCgNMY6IjzTgQR8RhTUSMSYag5bn4gGffmsgQPTTmf1PHh60ecNxzCEL76Q?=
 =?us-ascii?Q?E0PqsGiCmeBcoLamHTStw5pUxC2UuwNN8Szs21M+MdtEX3mOvK0CNBfzDUQM?=
 =?us-ascii?Q?D9SAWLotzNIlYRcXFCLlyAfOd22pI+qKB8atPlVIZUh61PToBfp5A10nmUJT?=
 =?us-ascii?Q?QMrZGMJbCVRVCtb5vMntCJgxyC2wxi3BzqFJ4t3FbRat/4ky7GP34z3vVDeK?=
 =?us-ascii?Q?v5rhVxh/DdQvr2g/hFLke1wLGeK9LKhBDGM6ujoY6giq5R34UDUZNR5ctQFt?=
 =?us-ascii?Q?zberBNjmPihdrz/4NKpEsDft6znydwuLqNx0hgz7LX6fy4/n7Rlv8D1gEud0?=
 =?us-ascii?Q?4H3RiG6CtnApGBI7vOGUXWp+HUALHUE/MaWPIshGnJkj2uMTHiUsLILKY43S?=
 =?us-ascii?Q?xPhcgSC0/l/aV/7oV/F+h8JsX78KQ34hRBe7N+85A/aZlzcIGxM6xgjRcwGl?=
 =?us-ascii?Q?ziXqXhsHFAawdopBF6IZvo+N+yohX3pt4HUyGSfIlnTuSaP4hDBza6HhSGBQ?=
 =?us-ascii?Q?xrZhO+/yGxzIJqyRphvgbCW3sD01R+vvi9chsN+Wsf5BYwc7vs/wnkTz5X4S?=
 =?us-ascii?Q?iE335i0dtAq4zTVayxIkPYdtDyD8+Qv4wgJGpltSah3iSuxTrcbKsW8+k2YL?=
 =?us-ascii?Q?AHtmLDEpO/1+InAVdac+sk8SkufEAOGAHVal76EKUEKzQiaRIQH91MhfFJWB?=
 =?us-ascii?Q?Pjozp7bosjA0Gd030jL83wqDBxj9eS9bLawxLPHApXle1FNA59qhj7m6nRiD?=
 =?us-ascii?Q?tGdgjzxIrllnQcPkfm+A0IW5jmwqkEfqXSgIEVttYNHPX35+3kOFfOX3ndWD?=
 =?us-ascii?Q?ry8R8RHzIp+aYzD5QSxCntTda4/DBqUB+yjS8kXfM+aaJo35P7AeXhLrRjSO?=
 =?us-ascii?Q?Vp6A07yHHuKRVUiOo+EJN0D1Xy2zHfNRQYdaTjjmUijus/SP7ML6P9RyIB6n?=
 =?us-ascii?Q?uOONQZnM1DgNLGNbQhXTYZ03jOV1Bjrd0ye11nc0w2c8ZGPFuuqCtCAGDuQA?=
 =?us-ascii?Q?utAJGm1ZeaPMKDhWFc7cDhcQnEtGJAjWrVawmWlmkwLJyUbkMfBEIEBRwjUG?=
 =?us-ascii?Q?/YpRSYGBQgLxdkFcwB/uMpwtj+VELQcIeaOpaXwiyeyYin59dZzxmHq92nD9?=
 =?us-ascii?Q?KRmMlyNWV+iRyKuICcVaEL6iRyfNMMYjavIdJCzkvoZTVopYfVMAQgszjd+7?=
 =?us-ascii?Q?pKAo0heiuc2aJTIC4Pi5Ch21zwW+hyeCGC4lVTK8xeFfyS10JK/kM0Oe7pUL?=
 =?us-ascii?Q?8zSez5Z3xXuqhJI7y7msws18P9YPkTbLU/9zl34RZvyQeZqXxCThMypFxQad?=
 =?us-ascii?Q?oR6VMglxx/QWCYVEttjui0uY2267BWQwAmWLi5+ZvenSnCuCw4GDrqnWnfaQ?=
 =?us-ascii?Q?c5Af9Nim4uTXDFwO6hWvBMXWk9GSF4isyeV0qfF70wfC4htVOcZfCgoFCtWH?=
 =?us-ascii?Q?gf0P+vFzJfpfD5LdeKorHw+mwfIt7qZ1Ad1KX8ve3YBi3wL2N0EwAZsRoCET?=
 =?us-ascii?Q?U5XlmWT7VKXgFLKjNi3a6OVqn+9YK4Yh0+iEZCTRaUHD7kfo0Zok4yWPlI60?=
 =?us-ascii?Q?inS2s1fmbmZ6hFjfRbuirAV6GjyMcxZNyQfAHe+lvNw1JlswoaBE/MM6sgXp?=
 =?us-ascii?Q?Kw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 616265c7-559b-42ed-d5e3-08da66474542
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 09:49:12.0971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3rcwfV/rO8HxzOEMoJBcDSgLl2Nbzt+CiTCt1Hc42gi/xXMF1RiZcXJCnwzKiQfftPMCbIC/dLWXJbKRsTKBeK4lO57GYbacBP9y08lvSpU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4282
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-15_03:2022-07-14,2022-07-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=984 mlxscore=0
 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207150042
X-Proofpoint-ORIG-GUID: wYHpPHzMcsMr2nBCVTeq9wQsBsWJTvSY
X-Proofpoint-GUID: wYHpPHzMcsMr2nBCVTeq9wQsBsWJTvSY
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 08:29:06AM +0200, Michael Straube wrote:
> The parameter 'len' of update_TSF() is unused. Remove it.
> 

I really do think this driver should do a lot of more checking on len.

It's not totally clear to me if this len can even be trusted though...

regards,
dan carpenter

