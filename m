Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E014FEEA6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 07:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbiDMFqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 01:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbiDMFqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 01:46:18 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732CE30F55
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 22:43:58 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23D1P95q012645;
        Wed, 13 Apr 2022 05:43:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=lrkIA6FPjNDJVPYlvd4BhJjE46UKmWVVjrSaFHQjxv0=;
 b=IBcuzxLUt3dQLTOy29DcT7eUH9WESD2d2W4QRgahqL4Qzpc92Urj8hQIv4jG+GfkcPY4
 6et5cIhxBwXwrHsBGdeauIRqF61JxsoDQHsDJnbKe1ejyD7Z2hrh+qNP8fiOVkSgux8x
 Tkm/UJMOPnLWACgDdDWWDFpRT5/PpRGkUfCU1wmbePuLqtETEzKLTGeUP8qvl+/MtYzD
 +ScNoPSp6ZM502ktcNiwfouE4qwVNJVDWfGNyys0uyNtnbr5V7w+xgXgPQg6T4dsI74F
 iTKyb5tX6aoE88uthMR2BWJyi2ljVod42I6NXJSNzgTB2pp+Ua0j+8yO05cwHHxd/1Uy 0g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb2pu0ywe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Apr 2022 05:43:21 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23D5fQVo033782;
        Wed, 13 Apr 2022 05:43:20 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fb0k3mtfk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Apr 2022 05:43:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TRCwjWFEpciZRWqQhlvW/vmywxEtdf6+hLa71m4Xyl3Q44PFzrVArw375BrE5P3aZM/hTsAQviF7yrcWy/HaNe0EnlMEsdJc5sSTMvrvsxMf6TX7BL+QdBsLxuPQXGign3KlSMrhBYKwhu7vh+iu6TyrrbOplTRy75DH1dOoY5hq6WhZoPCKfT4RaqYbFKsGu0qP1UisvP1st2FdcIGXjdbBX6d/dLO4x8gL03V7Vo7lMbID9PRd+NGF0b69chUVyKchaAJtRRUNo/g6kL6mNHNCZF1GyfMO6TwzygdA5AT+sd1xUH4oCjnVyPb/pTLLhLPgZtTYNstQ5Z9VcbpcgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lrkIA6FPjNDJVPYlvd4BhJjE46UKmWVVjrSaFHQjxv0=;
 b=d99oDb7XoCHYCcC6BAIIF2qtUeIhn3rRTIZ4bJWJtzOBtGUzdIdarfxmeEJMvK87tXQLuB2rM5SO6BG2V1/HvYs5mdsMGnLZ2spVO8N2csOKGTZIkII1Y1kM3wCv9kI5jkemDN5gJ8liCNMWqA7xQlI7v0V7JK9Cw18R0HQ8URYVwd2aotKD9RYIg8GSdp39QrXCmIOgQqCU4BrfVPKdYwrPmUS2SJavv55H0oUPsmrVKTnzT8UsQ+jPZwtr/LdMR79htaQURxH80k809DMq08UORzRRXk7fSOhVMmQ8BctdW0sua8IDMxPnL+1u/cI4F0HqoC/Yb7LUrHn1m7yvSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lrkIA6FPjNDJVPYlvd4BhJjE46UKmWVVjrSaFHQjxv0=;
 b=X7dbUnXLFqmSi2YalMMglOdhICit6z9Q3LkNMCixQ3JPrk8nY3WF2gHyxsaUgprFG2JMhbKaNaIm8GqIfYUZ+Zqn2uPsHd8nIBtAEh5D+9CKARzpDgf+BFx7h2xuYsh7WjXs4IIO6Uj5IHKqmyohjOPOC/bCv2ae2IyWALFKHW4=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BLAPR10MB5345.namprd10.prod.outlook.com
 (2603:10b6:208:331::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Wed, 13 Apr
 2022 05:43:18 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5144.022; Wed, 13 Apr 2022
 05:43:17 +0000
Date:   Wed, 13 Apr 2022 08:42:52 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Vihas Makwana <makvihas@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: Re: [PATCH v2 0/7] drop some unnecessary wrappers
Message-ID: <20220413054252.GR12805@kadam>
References: <20220411102136.14937-1-makvihas@gmail.com>
 <3484215.R56niFO833@leap>
 <20220412151529.GF3293@kadam>
 <3134226.AJdgDx1Vlc@leap>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3134226.AJdgDx1Vlc@leap>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0047.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::35)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91d01f31-20f7-47cd-8a30-08da1d108222
X-MS-TrafficTypeDiagnostic: BLAPR10MB5345:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB5345936A1C80CC65B39912E18EEC9@BLAPR10MB5345.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V5aDO0RfMDtVArk3Sta/75+bWFyJav/elVN8IewfYPuywhvgixNTIFY+aY0uE7oWIS4Ad32CrnPP3APz+mwiUno0ZrvKWsSBN1z7GfU2WzoDhY0Wma+bmp3Ge+6LBgm5BG4oaCKCgLiIvPIH5c6+vk23sW07BSt/Ktl7wYv6+/QCtyBAXPORoMiCoozd7Q1RHnWte7RXE0IfB4mC39TSmGGBOMeEAsKxuzN9QqfB7AUnZcnvJYOvgCItGDs4mCPa9WSknoEl4QGuFEn/CHHTC8LghQ83GSYqbg/9r2Hz674ymnCT2lQDa6m1L2B9Ykgm5WYcn0ncgxn9VjA+WA9rJSU/AukMhLUmv829ZbV4k/Dej7U9EEV+CLwC6eSbwa6k97SmNWhtlJKUfTlmg1bPkVXMLUr7FQgGelW6FofUv/PBmKUr+3h43WTJZRZLuoTn2VEW6O4WPRfiUxUOjV1metlYNx6LtzFI1QAONYPT//BA0w5z1pwKvl/1v19bLObHuw6b53DDJYSQSQDZiJDFqjI/vylCGk5ylPkoBn4jMxSYcQceCWZMpcgcSW5oD141eoglJQMjKEjbExIJlK3szf+z3oChjcq6myfP+dKPvVmR9FgIIrHvuJeQG+bycHWXjUSRYYRLuwNmPom+NDZKp6a+Vh0RJZyhW7ljLXcYuq8QW7cY+xdKlwmb36y4btK+D/XtTiOZiytkK4TRPPGHlg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(33656002)(508600001)(5660300002)(8936002)(44832011)(38100700002)(38350700002)(6486002)(83380400001)(186003)(26005)(2906002)(52116002)(1076003)(6666004)(86362001)(9686003)(6512007)(316002)(54906003)(6916009)(66476007)(4326008)(66556008)(8676002)(66946007)(33716001)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E0Z0rCfUR85rCH8sLO3CcyF2sby6jUljsSSrpUtz1Re4QIi/NYEM+CryAn+h?=
 =?us-ascii?Q?0gYu3nxIiUgKdArCuCt7KNugmQY0087Br3ZgrmlENLY2cwsd0DuxF6QU+ZLn?=
 =?us-ascii?Q?72rzRoByIXWDEgY23YXgBjwkhn+3viRQJn5hEeqUFaX5IasGklkOcR0UVVb1?=
 =?us-ascii?Q?wasH2rTk0nuK/PMPiNNZaT8jUnjc1P05NElDMQ+Kqyvf3q3nVhw74f4CoNZa?=
 =?us-ascii?Q?E+4v7MgP2LdpqE16OWGc5GSrWFiwnuZhrDnNwxZSqPv4SsFu8M6dV5AR6cNJ?=
 =?us-ascii?Q?Q4dg+Sp2WSbm4tNLc2zobPn3QXrXUMW+YIzKKv5l4Pga/yw1QNfF+kKoLEJE?=
 =?us-ascii?Q?O7/dBBnWnCScdzxZgJstq9ltyuor/gHvBjDGDr+zKewh9XNbhkF6ZY7H5giH?=
 =?us-ascii?Q?Z6piO/ZqDQe+i5rLP2ssnnQlzneUa10/t/VCY1FStxK5k1mf6QVTSTvJq/Pn?=
 =?us-ascii?Q?skbZqERGwMnbeEZK3NZiZkOigfmNfGPBn1vfSXGE3V+DuaIbhGNmYxUTkP6m?=
 =?us-ascii?Q?NqKmVrkH4HIN0xpgz6XR7X7NsO3M7gtpnQ6knzPjdfjElaUWxDYlmCmhmA43?=
 =?us-ascii?Q?oIXRruoiBK6eVY56KUQQnDzZmXgT9cDAnd4782vRvpS3riNPcfT8o6W8w3+Z?=
 =?us-ascii?Q?NWV/KMl6/EnuV/nED2eF52P01QVCXDwQzXYVDVcn7AtqhVWUr052nj0D9KFz?=
 =?us-ascii?Q?UC4PofgFzXtiSs/VNR6vAToZZdNS/KYL8xPTeASq4t5QJfkFxJTRo+itJG3X?=
 =?us-ascii?Q?4/g2UTZkq271+8KDxiL1/BE3ygqBSXkq41pBNClPwfMlsMam/oMk8b6JvjcZ?=
 =?us-ascii?Q?dHTz9GLdATLL8hjhQYgReI4hDFsBP8HV4Us3cpOOi7ldz8KHf/cYWytypyWd?=
 =?us-ascii?Q?84Bi62Y74alrPsnxQu6yi1RWaE1UBskL7LlXPClptD49HpKu2uZmmJXwOsLU?=
 =?us-ascii?Q?7mFZV94dxcWbibg/HZsGgeZ+80DN7unstgk8We9lG5HyZeH/SVQmsj5YUhoW?=
 =?us-ascii?Q?cT/zkgQySDNoU/jNFxW2BbeCtm/dXnAgOWFP3cgD3eUiTgJKoXi7gZken1d0?=
 =?us-ascii?Q?vcC5QuVH504w3C5Pv8mwvCW/pKNK8UWvhc9OeCMr1K30ilNeyVm6gQmejSmy?=
 =?us-ascii?Q?vgkDqmdiL3Riegaes/NX2dLHPfHF/g/a1FS94Pk4lbExsI99JRzfldCJ9VnO?=
 =?us-ascii?Q?0IqyKqVsCS1n2DR+cCaebGeRH1i8iNX7LXrm9x83wOaHz+bhyTA+nrMt2RMU?=
 =?us-ascii?Q?S7PNDURb52Lqd5UIF/GYMEUqynP1QtW6LIF2P8NHjCYIaW/vZ5CNZHVVB2Gg?=
 =?us-ascii?Q?R/HyrBISk0MwTcQDytZsKUjhP2ApFmzyfV+7v602sEwqB/o2e351mAVKkfPB?=
 =?us-ascii?Q?JzfRXrPHGv+y43lnjQijqpPOZbM+qR6nEN9JajKyz7GamnSEkuw6h5Ll2M2N?=
 =?us-ascii?Q?MgSuBre/OyC9aoFLsp3ocgK0uDpf0RzjdlBPojkeZ9HZI40lAZphCacmDaK6?=
 =?us-ascii?Q?e7gRcK9lXtkidvyPFxRaJ9aFKC5l9MdUIxVRN45+y6eA8+P+GBxei160egA7?=
 =?us-ascii?Q?5zU8gKCo5H6PMSiWwrNG7R02IPPUASSUIH3T+OneUY0UN2kyd+JSV9Wl0pTn?=
 =?us-ascii?Q?Yd9ccBS5pcgg4vuqPDZ6skbMwJlheYJKZ5xNNO7N9SPcf5M77pmH7kFaV/gP?=
 =?us-ascii?Q?rieAmy3EXMV/WuVV+4vWkTFPUA9R9tfXa4n3ydB/9CGUsJgjpOEjF9s5ZDUR?=
 =?us-ascii?Q?C2nX6RtPyi5PgqokjAjIzZOQfsIKG0o=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91d01f31-20f7-47cd-8a30-08da1d108222
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2022 05:43:17.7735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kign1VO16QyVzYKWsjV4EjrjZCpRGbOHFUyGnwsr5S3eJfkrzbMOXU/cKxISt7ymFoZXmpvokB/4SgOxdeiIVLexkOKycPcS3ya7IMmcunA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5345
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-12_06:2022-04-11,2022-04-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 mlxlogscore=885 mlxscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204130033
X-Proofpoint-ORIG-GUID: _W7Alxsa1s4VG3Hyu_hWpJarC068WIPY
X-Proofpoint-GUID: _W7Alxsa1s4VG3Hyu_hWpJarC068WIPY
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 06:08:24PM +0200, Fabio M. De Francesco wrote:
> On marted? 12 aprile 2022 17:15:29 CEST Dan Carpenter wrote:
> > On Tue, Apr 12, 2022 at 11:53:42AM +0200, Fabio M. De Francesco wrote:
> > > I didn't suggest a re-write of the commit messages.
> > 
> > Yes.  That's the problem.  If you want to complain about a commit
> > message then you *should* suggest how you would re-write it.  Otherwise
> > how are we supposed to read your mind?
> 
> Ah, sorry. I had missed that you were asking for a re-write (literally).
> 
> Here it is a sort of diff on Vihas' patch:
> 
> - [PATCH v2 1/7] staging: r8188eu: drop unnecessary wrapper _rtw_free_cmd_priv
> + [PATCH v2 1/7] staging: r8188eu: drop unnecessary helper _rtw_free_cmd_priv()
> 
> - Drop unnecessary wrapper _rtw_free_cmd_priv and move its logic to
> - rtw_free_cmd_priv.
> + Drop unnecessary helper (wrapped function) _rtw_free_cmd_priv() and
> + move its code to the wrapper rtw_free_cmd_priv().
> 

I kind of feel like the original is better.  Why would we want to remove
helper functions?  Helper functions are ok.  What we don't like are
pointless wrapper functions.  The whole motivation for the patch is to
remove wrapper functions and that's what it does.

regards,
dan carpenter

