Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6E5254B3C8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 16:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245208AbiFNOs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 10:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244922AbiFNOsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 10:48:04 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A247865E1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 07:48:01 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25EEgmr9014678;
        Tue, 14 Jun 2022 14:47:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=Rnx+b4r0kbTYGxg2mcLgpY0SvPPq0tD2XCTkWZ1SeQE=;
 b=wO0V4RfmmS8J1xNMymL+SL6Gb5jaWrNxy1tJnMeR2/dKqO2/m3Z6g9Kmt78ef19BrO2/
 GNTOK/fRE6GO3R+TVvLLZLJ8QnTkJgicpc93Xkxy7FSAw6JzBQDHYRZp7ybXJQj8foRx
 8FIuohUSRAIqr5QF02UcDrowd+5YQadauNuGq2m+3IorhNmRmh9EZCY1nXJ/S3cv58kA
 tDIppQ0gPk7pgD10lPSSdo/U1kv3dMxfT8+T6KwnZ5hmGPYpYyvk878DVVrG3pSI3NAa
 igDLkXCGgOddtYll4KDI1BZT/wnkPjU+eWbbhLM9AcB7wTy+q5u1qLXmDw5VuKA/+DYf Hg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmhu2p4yd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jun 2022 14:47:55 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25EEjYDM040315;
        Tue, 14 Jun 2022 14:47:55 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gpqw9ymc1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jun 2022 14:47:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XT6Rn47gqI5QeCWFQGPPtTJbi4uaqT4mdGZnklAYixsIO7OC40d5jtGVolrJgmb/8TygCfNsOAKLgDOpk0aapaohlQW8sVIducUn0hIv5OLuLP0EZglr6YMnK0EtYRmOlbrLtHNQbdPasDIxT87pV/3TP56qp1gArrmJZF4NFB8Tf7QM+Grgwl2PFVDaEsw6K/xoBS2DTqQeBQNysSBCFPJVOINW01E8H3hGLEAAw0qunzeozCYC6vM/q6EElhBrdoNS9PcaJONmr8XNynJOqv+msVEJma5ivNsud2up3juTQaySsFxYZmZuMftiO/s+QgMqBMVY8utyCq4QQpa7zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rnx+b4r0kbTYGxg2mcLgpY0SvPPq0tD2XCTkWZ1SeQE=;
 b=ija8jGDthftRja/4cjsU60KMfH4lTU7xsoRKIDe9BsoYQq6MAdF4R4USuoCWDjn/D7q0bYP9BrxdMH/kKsDRFyGJ7WjegIdK+I9wyjK1+Sl11NO8N24J1N27DnjDfCJtMt5PxaibGTTdfZDVyAjSxuTkmdog1Krh9iqSrn7OAqBIHnxJH5h086wytzYtPw+p8fSHw1HRIz0mYScoDuduEhV8M25L3nNAGTe6w09kDNtrOaB/5mc3uiftXFrrJTlxGaGFOna0cphRh9KoeGvOfncKhLfvkfvP0DdYyGFRFkQmW/1390N+VsMI2TsYqYJxWe5DrXHXcJ/jhrqWr0sstw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rnx+b4r0kbTYGxg2mcLgpY0SvPPq0tD2XCTkWZ1SeQE=;
 b=PePn/iZFnFeOO0VV34YtK7G6czhbKJoqUY5SmKalNd/+LDMyMXNhn8/qBiwe26jF36owlVH086NcvKwzOY3YUCEF7kNjosqCOgTVhbkvQxuxENA5BVmRM4HlAPlMp91/s+oEjgyQfO2qZBxO/pQe83LGKsviT3iz4z35HGstqI8=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MW4PR10MB5701.namprd10.prod.outlook.com
 (2603:10b6:303:18b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.16; Tue, 14 Jun
 2022 14:47:53 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5332.020; Tue, 14 Jun 2022
 14:47:53 +0000
Date:   Tue, 14 Jun 2022 17:47:34 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     daniel watson <ozzloy@challenge-bot.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] staging: r8188eu: remove leading '_' on
 _rtw_IOL_append_WRF_cmd
Message-ID: <20220614144734.GK2146@kadam>
References: <cover.1655171591.git.ozzloy@challenge-bot.com>
 <3797496ad258ba3d0184b82194c6db729eff28d9.1655171591.git.ozzloy@challenge-bot.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3797496ad258ba3d0184b82194c6db729eff28d9.1655171591.git.ozzloy@challenge-bot.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0016.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:1::28) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc5cfaf8-4e71-4af0-82c2-08da4e14dc8c
X-MS-TrafficTypeDiagnostic: MW4PR10MB5701:EE_
X-Microsoft-Antispam-PRVS: <MW4PR10MB5701F5423AD0556A56C84A368EAA9@MW4PR10MB5701.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O1y0oPWrdHgfGfpHwO7jO5r5MT8po9b2uoMnWU4iUT6QLS0lPE9z1eeEwZ5ORpiamoAF/LI4gkv3/kNBaRBjWa7ho6xRC0ANCb2ZXvDPkuQYemvXI7fhXLzx0f8QI/ylN1iR7bb/YyMc9ax4tUZt+uSpOiDulGs6vpPvOgnW7bUgJZ7QPbLOgPAPd01aGYTNV8VeK7dFCvSAqdce/7cmJqRrEfFdAZc8oByrt8BdWAli6CNWN2dnVz9oTTyBIYvZWPq8OGYQwGlNWHxsvISjTtXyMgUaRICtopfqZEe3ZBYktaTZeAOJB4UCvB12+/4tCEwkQ3SpibTprvnCgNym0TYGuvi2k7T4KQewy+hWzpy5ym3Mfq+Cqt7dv6eK2GrFB8AYt+kwdmpVz0o2Q3PhrqvsyUWZml1MNqGkPn/qK1H/C2WPkkdassyaNXoCxAYSl4Cq/2P5APsDEEx1HSqJ22ocw/CFrSmQ+2SFtg/cJMxVaPzGz2O6OcVNJ1hRHKwAhkht+cJoKFR+SkQp8I/TcoWLfoDJkz9+ZGs/uhysVjgXeduELQuc1N8I8u4cVkjd7dQTmsYZhBsXsTUyYTpiq7CFiW+LMVHCtvJ6UIsb5HUXAxNqx3UIY+1O7AGefWgJSvbDfPBmsxnuy2QbXKmMod5bvy7bHo2w9b33jU+w3ZXgtTjgJNn6xqF86TxOkFL/gjZx+w68lpLvzrz8+hcx0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(2906002)(38350700002)(38100700002)(4326008)(66476007)(5660300002)(83380400001)(6666004)(508600001)(66946007)(66556008)(44832011)(33716001)(6916009)(9686003)(54906003)(316002)(8676002)(86362001)(6512007)(6486002)(6506007)(33656002)(52116002)(26005)(1076003)(186003)(4744005)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WewLCIlMvBKTJwuF1EAISxqgo/ZKr0uIPsZdyI/VtWDAWCzZbAgpNU3X7bj8?=
 =?us-ascii?Q?/Rv6w/SYusd4Huu5iozxbyjHkKY1tTuwq16pbf5d5QYVMqkC3bSNJzJldqJk?=
 =?us-ascii?Q?sdNQ8iZQvLg4iydnK9ARiukY7ZRFXClyuHO+nt2oa/k9tQOMSu91GUdCaFwb?=
 =?us-ascii?Q?TJG24hXus6QiwTqUvX1OxA7d+pCtYxlsOV5jwg2Czol0FjRnvLhj5w5+/IlZ?=
 =?us-ascii?Q?SNTWc2c74oPVZfgAv7hk7U70PwVwd9r2IxRBRzN3oIa0t9piSgA8dlzkENvR?=
 =?us-ascii?Q?eAPJn5rzSd4fUEEOfSDMdlXkjBYZIGFClFyRsNOP+plssAsgY0fDsCNeYXpb?=
 =?us-ascii?Q?EJlAK4DwzAEkPfmlmtNH0VgnvSkMBn7b9W2a3ynA1mSp+Crqt7/QRdrFPP96?=
 =?us-ascii?Q?uaGP18HnBLaxpeywUPolgYeOojHImn8MA+EYgaMtncYhprWSQGFBYSwrP6nz?=
 =?us-ascii?Q?l9oEhj88QJlDqZKU9Hf8FvZspKGJPf0A6fWSDs7BjoNyHO3qLiAh9umrfgyo?=
 =?us-ascii?Q?nDNOh8rVuCoVEldXk/ctjjFBF7Pbae1UyCY0dE1ysXmk1gbnH8OWUKeLfWx+?=
 =?us-ascii?Q?sIykwq+b9DEVe+OK7oDctpnTBjdLoFxoUTX8WEQ7hqK5zXe/iJzZoVcfONWS?=
 =?us-ascii?Q?kHZQwslziHscwwDU7EA8l3QLS62fKyk3iWul/rbOO9IKjV3JsmHvUeXOkm1M?=
 =?us-ascii?Q?CPz2ep9SHxJMIpGy4rrQMBjEQSwE4Pdl1LqJvODoRICH8xko9DvAByKQmNcP?=
 =?us-ascii?Q?RecsTmihIHg5NLXcNAk6hGf5AqLsw32YskWb3DUSNx00qfvsLmGVSl4TPRbY?=
 =?us-ascii?Q?LcgmFIjL5QzME2vKJbsXBEb8F5uOZwrNgbHo3Zd+d5XYvIBt8D7TQ+3sqKvs?=
 =?us-ascii?Q?AJZ3MiSAp05KLIYSr+bypNuhJXP9TMHFSL5Uo5J9pjVG0PE/Bkj0/VIoY1AT?=
 =?us-ascii?Q?pur1O6lO65MT5pVgN+6l51anC9pe0/udc12um14o/uwjyKZTO1iIvllr3X3B?=
 =?us-ascii?Q?zy1QWqdtBn68Rx87mGigcZi5C1px+AWqCf5BTNdAJ/R4fCLH5+aedi4T0oOD?=
 =?us-ascii?Q?M1hZJFnUXyxUETgoFT+T00w7VVww/UIgdocBESAiRNC7+rhYdxnjWQKb6GTv?=
 =?us-ascii?Q?y5G9E1Z/i9HiqSqHoYkwnzCtXi1meLlaBg/OIgSTG1KR23xudtRLSjBvTQGV?=
 =?us-ascii?Q?JLkQ5lm/gDmQFovPj0dxHuVSkACVR6Ud6bMcuVR746hrSOCYHne6gKfnNt8i?=
 =?us-ascii?Q?qCQJit4w9a/LPwypXjuvNI660RoDTioPjwNEQCp0F/jphNVAo1YE+009a6m1?=
 =?us-ascii?Q?W0GTyaMiHRSEtwUKTfdQ+8zLZ7/d5MZYWmbrOX7j/jzHtbTkAbttfHtY+UR3?=
 =?us-ascii?Q?rdI21ftptfcfgWZXekX1ASxxPUDkifVrIK6TpPrpzSwkhWFu2mSdjUudmxyb?=
 =?us-ascii?Q?I+FaAJGLKRK4hxG2WV5CI72HNE0EaUmsgpOcoybql53gypvJvx21VE7x19mp?=
 =?us-ascii?Q?I7pltqJRVwJuTc1SqxTnrI/U+YKYMrwEvklXOuSuvkNUQ8PDMZT7IlP099q4?=
 =?us-ascii?Q?bbhEKFsuBiCE8skhZJYgVOcWzRhxz+GhTu7iiNv/pWw3I55DbB6iBrMEHoBd?=
 =?us-ascii?Q?BQk30P/QIeg0NfuLqT8xxgi+pMpir1KiG9e8Dpm04BSH0EPxvgcLOVr5Wg15?=
 =?us-ascii?Q?b1z9P9v57+AHdgxTkuUNq0aapJmCuNwKkQufX3E/HuWhd8vVofzQI7owNIBH?=
 =?us-ascii?Q?jGGafBFW02Ueq8VDn+62YrkeF+44w6w=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc5cfaf8-4e71-4af0-82c2-08da4e14dc8c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2022 14:47:53.4886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pYzWVP/y6emUPC2CIlbd39IBZUtOGudBx5YOK2hbYU7BvjlJOmY4Balsqn/xjBwMXn5PTQfU0Xz5o453ZQa72lQ0PIsPLF0D9fXvE9OxY0k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5701
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-14_05:2022-06-13,2022-06-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 mlxlogscore=885 phishscore=0 mlxscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206140058
X-Proofpoint-GUID: dReckrQN0102QvYXvownOtmjpFI6fFTA
X-Proofpoint-ORIG-GUID: dReckrQN0102QvYXvownOtmjpFI6fFTA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 07:07:33PM -0700, daniel watson wrote:
> From: Daniel Watson <ozzloy@challenge-bot.com>
> 
> name the function rtw_IOL_append_WRF_cmd and call it directly,
  ^^^^^^^^
Where is the first part of the sentence?

> instead of using wrapper macro
> 
> delete wrapper macro, which is not needed
> 
> NOTE: code compiles, not tested on hardware
> 
> Signed-off-by: Daniel Watson <ozzloy@challenge-bot.com>
> 
> staging: r8188eu: remove leading '_' on  _rtw_IOL_append_WRF_cmd
> 
> call rtw_IOL_append_WRF_cmd directly instead of using wrapper macro

This is a better commit message but use a capital C "Call".

> delete wrapper macro, which is not needed
> 
> NOTE: code compiles, not tested on hardware
> 
> Signed-off-by: Daniel Watson <ozzloy@challenge-bot.com>

You have the commit message twice.

regards,
dan carpenter

