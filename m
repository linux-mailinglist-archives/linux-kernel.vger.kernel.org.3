Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847754F8E58
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 08:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235025AbiDHGAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 02:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiDHGAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 02:00:08 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E3A2CA853
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 22:58:05 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2383rhWu024455;
        Fri, 8 Apr 2022 05:57:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=bd83RyWqzmpUjKqE215dUmV3QACTqnTtd2iGmEZQC+U=;
 b=sPFezhWl8kbSl5KsueGYzJ1qDtbIVOU9tnRxPVtdYFW02qaowkNevZ6443y8jxGDueIL
 OlyXM6zGHGfVNZTU5Ch5Gazl2bT7fWADnC9PP3TL64Kz0qijtMtR6v3n9Rfncfd/TFjz
 FF2wJCl2K44URJk2GMX4REjuOPzEpVR2qWVZ9rUXnmMbWhSrrlSJ+mL1wezs86eAQeNR
 /SHQUlXfgshtee9ZCfL7F1+P9U+bARnk7XVW+lZX6B5Vmudl/ngbgzUXE5p1P0fggbfz
 +L2md/BPE5icTSiCXG6IU0QfoxYW431DHRkCOiUiNZD9SHvh9CgXPKC7Og72HA0FAC00 aw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6f1te6q1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Apr 2022 05:57:50 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2385dS2Q027301;
        Fri, 8 Apr 2022 05:57:49 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f9804vgab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Apr 2022 05:57:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YUaszS4lqQAxfW8Fxmj9cjcS8U5zRMxhG2qkcLxyihgO7sy2CMuFmI8cbgWLI6gtWV0DQ8GT9Unxf0hrwM4jGBnjTssKkxyHs/cNnifeg1bFY7mVEL/na6Fm0r4ckayOhfeefm5cZkkDYOt86FVrBa5SoHR7X9ohmVEr0g6csLxnYP5oOL1pD1nT53dP79lsn2XzwHZzFqm94lP4CfHCR/QsSbpZurwsavy/JftnNFhK6WfARl9fuzUMSmGJEU8ncdXFDG5sxwAThJr4P1OvuvaxDcThEkqvopv/6IOL4j9LcfnKMzn3VmLMSalXnisB22Dm46NBXinqk1ZU9v0Q7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bd83RyWqzmpUjKqE215dUmV3QACTqnTtd2iGmEZQC+U=;
 b=huzdEH8v05AiDgNR3QEYFgsH4YzpHzspV8zLTg3iny3/V0PJ9SslgiImjhmCEtdoZCMYxE4ZzN9yp4aBOPHuTS5CwPLzVjXXhJrot79Vs10ARoRCLTPnv/BQkpuwgeix35BzZD2SQEQ8kDcOUwwo09yTt8dhrN/tARNmJrNCjoTlvdc5lH9LtPE0aL7b0FyEcThBNMK5oOGWuK0oWIC1/scwVVW2qoPCKIuFh0ldyUyXldoA049b8+j+dM6CrY3Se5xpg8+B0NkyUwv1EtT76g6c29ccfzTacVst4YuEsAK85zHpD2T3CoQrSjW3pHUKEjTWkv7DSfqWVQpYgX2ZZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bd83RyWqzmpUjKqE215dUmV3QACTqnTtd2iGmEZQC+U=;
 b=VFwMvpOyaS6w8aq/IaWPlKAkliAmqTA9yxKhGiYGYfQUEJ65QYmWlrJhXxnlMzS2fAMKWLwc+HafvRcbH5zN3TXV+q6nuLMK1ckA2X4YuX6fgZ89UBCK4TVwp90/HzJx8pU+ERPXzbAmfvc7LoiEAgNmNdOjS+mNm5eDK5riP6g=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM6PR10MB2811.namprd10.prod.outlook.com
 (2603:10b6:5:61::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Fri, 8 Apr
 2022 05:57:46 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5144.022; Fri, 8 Apr 2022
 05:57:46 +0000
Date:   Fri, 8 Apr 2022 08:57:32 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Rebecca Mckeever <remckee0@gmail.com>, outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] staging: rtl8192u: replace ternary statement with
 if and assignment
Message-ID: <20220408055732.GO3293@kadam>
References: <cover.1649378587.git.remckee0@gmail.com>
 <36059ec66a2f3d58a8e339aa4f262772eabd3ef0.1649378587.git.remckee0@gmail.com>
 <alpine.DEB.2.22.394.2204080614400.2199@hadrien>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2204080614400.2199@hadrien>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR1P264CA0091.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:3f::28) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea82a549-3766-438b-1fc0-08da1924b439
X-MS-TrafficTypeDiagnostic: DM6PR10MB2811:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB2811F6DD1AE89169CD2402F28EE99@DM6PR10MB2811.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uImOFV3DJpz0TLmcxgYLX02Ybkqixa2GMtnZ9afNFAbAEymCLIuLf3WteWSil/gQDSBufxvES1ckBHknQzGHQEZES9mjcSCfMkThbe0/1RLIx16Uic1dNEeutmx1ONgmVB21i07fNyBuuTW4cELx5oEfmqtjqejWFgYH26ULs3M5e8cjQp9KCGFAlpMfbg2+zUlYDod+aRu7sghkXL3+7VJY/Mogr77KOW1bWmuErcEdnLsVjvbwe6dLxbbHfCxd1a2wD4p6//046KZPa1L/qntcOl4OuSb8Dp6u1Fnmfc6QwtRG+N/MP+8UT+PQZXpH8rjNudAaHml5Z2VLdl0oEVs1thlqMRV0eKHpTriejex9V8LD54nNFipS6OXlbQRTlk62wO09U6GkW6s/4zYus/eJV7niBb0fuwDSlg6QBNOoqgREF6ojIUa9OuZ7eD7fN1o0SchlOGNVZHRN7y6YuR4DoVafhpcUgbuYv0difaVxZAdfK869j28HZnUh8Lg4qLbIF2eTv0Dqak+cC7vmIiAHa+308dIyoQ8qPiSsInAWJpEIWDbqtjANk2zK7zzyGrHNAf4Uki3scdzhnVY/81CGlPuPa/x04HJNk2muO/nk3q4tGH8s/qUGvt3+MmWLURnxB7gRme8DjJ+41zJPakB76aeh/PMHrxlTpFnisKyLgRuThZ+rUC60gc0r2z/lexYVgbR4VYcWUi4cIzfp1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(52116002)(44832011)(4326008)(86362001)(186003)(5660300002)(6666004)(66946007)(66556008)(38350700002)(66476007)(38100700002)(33656002)(2906002)(8936002)(8676002)(83380400001)(6512007)(9686003)(26005)(54906003)(6916009)(508600001)(6486002)(6506007)(316002)(1076003)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dxkwZfI7lTA78ySomZxL8FKMMIX1l5kDGw2JVSbgaBP0B521vRdeQ4GJORh3?=
 =?us-ascii?Q?CRWc8BZCS5GRgLwvdJRksUL8Qx7CA+8L1qTa6UXwPox/z/VOE84Dz0wsYEAQ?=
 =?us-ascii?Q?8O9Ljn8aICPtgpqHg57rbVjhctyumsrCkEeICryUsA82Sr+EX/YY3UhkCLLu?=
 =?us-ascii?Q?qNqgoPOU/uPpH3Ld0wAE+8ZGaCC2NV4I1s2eIDRedJ1OJsXmwU3Rpixjld+h?=
 =?us-ascii?Q?Mge+mB6YfV1Xmg0uu9n/xo+GGLdStQODDgrrjATMtaxKr2U+PkiHflnLBsvH?=
 =?us-ascii?Q?PMdSLtRutU/6KsZLRuQxRRXVAXMLKCW0fRIs6mhIwGrDTK6ViNg3Qr+g6svW?=
 =?us-ascii?Q?b1aaaG1TeMjf00xfoCEETAz+j4UVZ44dMb9FU58R4UvsYJNwyigat5QG+Rls?=
 =?us-ascii?Q?gLlKeLqETrkZWVNz7GWThUO8ofLDR/hqFSvP8HD2hIUtsCpYMo2nBGoEPU6d?=
 =?us-ascii?Q?1wgxNl7ZGWiodBMcs+nE2/yhbdlb++LQnQ2kaQ5cDyesQzsvlKrSux/n3/Aq?=
 =?us-ascii?Q?6RUdD+Z0I+yJvfq5ypi+0lbLzz+WiNF2MNK73stiL9uLEO13VhsW2C26RMB/?=
 =?us-ascii?Q?HX3aEe1IT65yB1sxBLyya+Q4t11ARxQ9GBp0Cqgj9aDmERpbCeU0ayXgAFjy?=
 =?us-ascii?Q?t5qnyzdoUZ3LjgrPXOl3ecGiYRQ31ff10e0dEPIlDh3zBXtPec8h/rm2qRL5?=
 =?us-ascii?Q?hS0Wn5gN+R+2jB3Q8SXkzqjWpt4hhh2QaKe13pxrGki/lKqrPHL1pA+Ykn9g?=
 =?us-ascii?Q?NEnl4rZCSnEXCBeaL+qhuEKV7yPtIEGtH0gaFLLmO77ApQp8/GANZyzfmhKS?=
 =?us-ascii?Q?HYEMJkFZ525SsbC0GasakO7Xy5P2IVZysnPpfk7WaB+ra2m4UYpTLYvt1cpy?=
 =?us-ascii?Q?fH47bpr73b+uJLPQZUc9zRwDbW3j1TMX03zppYyzG/NFXTbm7TeP8aF7Z0hv?=
 =?us-ascii?Q?mpBt4J1WAdsDgRKFG1aYEx4Sc05KDnoKgRSwNXD+kaj71oVdgLDrcpcMz8Ez?=
 =?us-ascii?Q?XDfaQwMWWr9hmJpUM96V0jSlEbK+erZo6YozI31w6ugjZdr+EI6laa4RzsUV?=
 =?us-ascii?Q?ca1CMIowuVZVClZ9EEOdcXsml2B+NIemxRGVpbYIhkuuth7pGRrqfjsKx6yO?=
 =?us-ascii?Q?0CwUIHEIaH7XnGoHDmdUrsVjWj5ttA3jYsiqrr2lFiv6azryby4f7RM6RSgS?=
 =?us-ascii?Q?4SUz+GUA3nVX0iH+KwqG5+y5ZoCDLwIG9Z1eTQfHluW28jjZeQQgGp+hBFhe?=
 =?us-ascii?Q?YqqtzuUrTMfDTuIol/tz6wfQsN6CtUZ38lDZLij7dVLnJLJzBzL5itXZDUe0?=
 =?us-ascii?Q?jRp3uxUkqBpaijKcwvHA/or8ZHI1gW6VZvm7fWRXW5AK+XSrraremUOeNsam?=
 =?us-ascii?Q?LeStUBRaUWyg6dnn0EQGkm3NCmVVcL7LPtP9Ao97FKJm52ImEV1IPDjkwtvO?=
 =?us-ascii?Q?JuSSBJpKMZg6x2sLLJx0tdvBpM9J+UYIhFAx0BDxL1yK/t8OPzvfsN2Vp4gl?=
 =?us-ascii?Q?wKMDzk6sta4AB5io1zgpuQQE8DXWtbi+b9NRr3ytsRMH1vn2c2cBl2yEqM5T?=
 =?us-ascii?Q?h41Ns202RRkIEEWKg284QuPEwsavGDZ67q4y/vDvHChmOWnxGiHuZnqYzj6M?=
 =?us-ascii?Q?5utq5tfBmISxxfVzkBKoUw9uzO3AlXwE+b370utaETymnYBqvmQ4GCWvS+PN?=
 =?us-ascii?Q?cOKfxBT8P8CIJJHrsjblqEV3SHB5zoubfaXQu4PrBgurwK7WMPx63HDx6g7f?=
 =?us-ascii?Q?+L3r5LZh/f2HLTpJAFDQPuey4YCNLqc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea82a549-3766-438b-1fc0-08da1924b439
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 05:57:46.2787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I2Uk09gX0y98Qj4SURtZBFuA/SCJg/cKvSgwF0gk+FlARNbY3Om/9ZXMoLcsKKVsxdy5EM3o1PAIVLmgPhV1z/nuLNK0EnRV+fZQY2mdiFg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2811
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-07_01:2022-04-07,2022-04-07 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 suspectscore=0 spamscore=0 mlxlogscore=937 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204070064
X-Proofpoint-ORIG-GUID: ar2rF50WhZ_7RLUCSQTx5j7Kywx1-X_7
X-Proofpoint-GUID: ar2rF50WhZ_7RLUCSQTx5j7Kywx1-X_7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2022 at 06:15:14AM +0200, Julia Lawall wrote:
> On Thu, 7 Apr 2022, Rebecca Mckeever wrote:
> 
> > Replace ternary statement with an if statement followed by an assignment
> > to increase readability and make error handling more obvious.
> > Found with minmax coccinelle script.
> >
> > Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
> > ---
> >  drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c
> > index 78cc8f357bbc..9885917b9199 100644
> > --- a/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c
> > +++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c
> > @@ -470,7 +470,9 @@ int ieee80211_wx_get_encode(struct ieee80211_device *ieee,
> >  		return 0;
> >  	}
> >  	len = crypt->ops->get_key(keybuf, SCM_KEY_LEN, NULL, crypt->priv);
> > -	erq->length = (len >= 0 ? len : 0);
> > +	if (len < 0)
> > +		len = 0;
> > +	erq->length = len;
> 
> Maybe you could use max here?

Initially Rebecca did use max() but I NAKed it.  It's really not less
readable.  Better to handle the error explicitly.  Keep the error path
indented two tabs.  Separate from the success path.

regards,
dan carpenter

