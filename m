Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA8FF565448
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 14:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233747AbiGDME5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 08:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233574AbiGDMEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 08:04:52 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45EC611828
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 05:04:52 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2648a9ow026803;
        Mon, 4 Jul 2022 12:04:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=hK2WXwCZOmAo4LXaC2j1P6S6Zzp1/5/zZzesa0hfVqY=;
 b=arybwj2kBo885Q/iI+BBp1vJstttCE6aD7MsKJd0qPcKOdeayNo9uUEUa32E33jcAaTB
 LMDXIaGIlEPlZok6UPI/VJQpcZrv5KZwWDIqQkTq/dnit10/FVMNIHI9auyGp79OGGow
 JCONejlescsoYZv+Fszz/bu/3VJGlnypNjHwItKhj/S/AY2OhZ2T0hQ6Ass/9/4PIIgW
 us+3MPjOBCloLC9//vzHV+JkVfiIle7DeJ7ssmJWkzSyOijGlFsBA1cau/zvgyI1S4rg
 m/fu5f3dvw3/itp3+eGImbQwj7lVMCF6c1tkn/+1fKVuzItXJOf5CkocKe6bHA0Ee+VH fQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h2dwak9gg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Jul 2022 12:04:34 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 264C1jlQ032250;
        Mon, 4 Jul 2022 12:04:33 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h2cf1hm0p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Jul 2022 12:04:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y1nvlclshxBj1jRFlZMFNAGuhgi4atA0dEe0UT7FBBoGCMOu0kn0su0hGK1P9IC36/7K0OCTaP7JvWjMTUIhZgS3YG7+j+C6qqaVP1yrgaGgXv+Ad4oJ35k+jlHfMfZED29SS5JG+xjXDi7nbsQ0Ms08XjtrSKH5lAwTWFrsakhj/mXSR1DD07SIQux06AtdDHbj7jBYRfMBdNserHQYHEoBt1a4s4f4IZ7IosUSzoeBWyvAWXEUC/PhBszGkyGIoA0Txf7VThjEBXXuLDWsXT6ryD1LHOCfcdyZThoh+n1Y52KQmsedHVIV6T1gq2pEKHq1lbQlhsAAJckVM3/rfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hK2WXwCZOmAo4LXaC2j1P6S6Zzp1/5/zZzesa0hfVqY=;
 b=S/BfFZkeKo/NePpgW5KE1VPnbh8uUW3nt9AsigPNJ9uHmg+dEkcm7YJKRvsiWa/k/l2YtKD2xHKaZk3sNzUe8S+Dd9MarEKW92+s0S510kk1Yvns/C93t0FRqBoQXVBYgRiHn4A7ZJ2vPyA46kxamuSsiOXGolCENXL7/L6muxe5K46PmdXeHrHCCAwzstlJlNCAR8FG742tFImvd0n6L9GUKOupH4Z/kZuRaDPSl0zFWEL8A+moQ4Y4Q8cejStwDve7YjXK7pRPZQCoVXb5+u/UY6P3sJvyO7c7GzIGR77PaFU5JUD6fOat7J21Vh7ktqB+cPyo0/9bI6XhFVc6pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hK2WXwCZOmAo4LXaC2j1P6S6Zzp1/5/zZzesa0hfVqY=;
 b=liJvlT/9Fc6xEGngIXlTbzihH89ejQzMhpHJsqLJv9nMUvyDn/Y8V28cifNftJd7XtQm3pyUXTgQpyaoZj2/CEbx1kRGNY+21iQsapuo7udVwgUhtEyyZACXXmGrbE6At0S3i/sPXphHM4JY2NjI72SoCgpwWqYisQptDZsL4OU=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by PH0PR10MB4760.namprd10.prod.outlook.com
 (2603:10b6:510:3b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Mon, 4 Jul
 2022 12:04:31 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5395.021; Mon, 4 Jul 2022
 12:04:31 +0000
Date:   Mon, 4 Jul 2022 15:04:13 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     Martin Kaiser <lists@kaiser.cx>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] staging: r8188eu: remove unneeded semicolon
Message-ID: <20220704120412.GA16517@kadam>
References: <20220630090937.4983-1-yang.lee@linux.alibaba.com>
 <20220630115848.hkzavd67cwjubjq4@viti.kaiser.cx>
 <7d763251-c761-1260-b03a-cecf8f6f9738@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d763251-c761-1260-b03a-cecf8f6f9738@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0044.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::21)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1cd4af83-b0fa-47c0-e51d-08da5db559d6
X-MS-TrafficTypeDiagnostic: PH0PR10MB4760:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gfsGeeTLaDfd131f5OGektw2TBSUuoPP+9nEaz4Y69x95VYVC30wSOmTiZfGncLzitR2vjrRse8zT97vAciVNh/jDXokeVjj/Ms7ZlezWZAxNyjZfmQqh9WA08k6m5R54Kbrzf+/mscAPBGzg4Wj0W/zJqDL9jBa2DXLt3sE94mIGKao6NBb/tRqwqCS6XhaFlg4RSESZCOtN2Tm93TL0BzUwSXSE5LqYpLjRyn9HtN1ph75jff1IXgY4XtwGIv+gX8yjJvIiXMkSuqBzuwzTwnZBZ9JtfzGjwOFhB6+lo2AUWsLeAvSHLd8NJq19Spl7IkbyJvDmTN4rPA7AuuV6t7vuR2/sJ34dK2yWG3tSFi5WOfFlwv7WJq9L/y/NQdnAR3Zemo7zhvBgb0qlx5aQm+5hPcGcLATXBESWwzzt/kDNzSltZWz19OLGtInXmfJUyOGaCPN38oj7Eg285U8TAFj2IIRTj+uGciZkEq54JYA6q3i5ksTA8nsPTVwDQBrFYL3zHsz1EHSA+Kkg/jDCpt8411Wi38IsKCSrkcWTbWXmULQGGCYObmvnG8ESrpDPG4/PEBUf3R5UKSl8GQ5+5O/cuOXRAitp6mdO6GF+PRCyizu7xuqSeO+6bOxx6YZr6TxsVqlz6IEqXzJi0Hek0UutUe6Af+REH66Fm5Fb+ukPdncHYwXT/dMFD9O0AcdYt5NOhpaYUzsBdj15qBnJoWRE13MTtzmAxLQPeLvWYoc9fqh5cBgv0FW9oEGpqj4n3MAyTsNERFcCzWB/NTjtwArGUaOZ1k7XCj24730koiQYbOq5+vZtoMEo0dgQk+K
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(39860400002)(366004)(396003)(376002)(346002)(54906003)(38350700002)(38100700002)(6916009)(19627235002)(66556008)(8936002)(6506007)(316002)(2906002)(66476007)(4326008)(5660300002)(44832011)(8676002)(6512007)(26005)(83380400001)(9686003)(52116002)(66946007)(186003)(86362001)(6486002)(478600001)(41300700001)(33656002)(1076003)(6666004)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VrcsAEnOTc6ZkdWe6BfHbkcXKLI+TbcJOtY1Xf2IgB4I7AixWVe13JCq1pHE?=
 =?us-ascii?Q?NfCtPL3uQADRnlJ8LHs+ALu2ICuNeYJNuAL1Tp/BmrBu9EXACZ08sFPzJUT4?=
 =?us-ascii?Q?iDuJ87fY4Wvd7ChVcqaQTk7r5IySagq3iT1rI2J1WjAglWNmkf4iPQAHpMYG?=
 =?us-ascii?Q?gIv1T0IzwwLTEayhoJ+AEN6zqnI+JVuvmPOWGMWjhyND2uwFkJn8XFebnRQE?=
 =?us-ascii?Q?8LBdqBDYz4IFTKdG7OO6mCRAeyA7olT3xNcOn/+qOU+qj4oBXSrmmQJc4FP1?=
 =?us-ascii?Q?P6xVDBnVJm9KK0nXvWHbVdm8QdVpdZxUl1ZIk+6Ah7O0YXiESKIxqCtnVker?=
 =?us-ascii?Q?cLYx89qSwTyDVwQPgs4coMxO6pgz//WaMimjiDBJBCa578eDPrsKAAKGEWYC?=
 =?us-ascii?Q?r+B0hBKXzrlsdbHe+Gp8IAB1avSQ8L6W4qSdDGsJ2m+t2OZmc2b3bSMVS1DK?=
 =?us-ascii?Q?Kmq2JNQgYZAPIkYGy5IOZrZCwTG3puapThHeWMH8C5FpvDKoDr653JH6HBmb?=
 =?us-ascii?Q?U6GU1UVWxBBy4OtiE6TA6at6VqOKJzz6kYNgcyTszSJFONtHHQzP03hQ1U12?=
 =?us-ascii?Q?kLAQl+SOvLAyYvREIcvdxVKU2vi3Fk+X6JpHd6utnm+5GXgaOdUFFbHWQcxP?=
 =?us-ascii?Q?D0J5rOjqkHA8X9DultVqjIZCvi2Ss1k5p6613eYOjRU0NfWgHlzOGsCPYJ6r?=
 =?us-ascii?Q?IjBidNG7DHPs83GqSbC5XjCcuYFO3toq4k6URmf20R9zsiWKPv1fzWXWD2J7?=
 =?us-ascii?Q?U9urcpuXXZFEbHy2xSBOHoMGTguxRtN9IUYG4Pfr5a0VX1O0NrFZnqpjIv3v?=
 =?us-ascii?Q?/tfJsxKxTLs9+W3vivVGDV6NKrx40kj93w1Sui46veCaitVDleImDhPrnIoj?=
 =?us-ascii?Q?LdkorUVc5nV1/xripFftVyoyGeZOeWTVNWmghiR4LgIgtJFrjfzgbqLX38nI?=
 =?us-ascii?Q?DSN4MPnOqez1X4nWcf4sfuzFWdXRGTMGPzO8NEUH/TWUZ+9YA6tMPUcWYmbm?=
 =?us-ascii?Q?2V3T2fH+UQFZ50z3k1PE2br11fqZUJxAOxbot6o9Eb4pvLfr6rUVWt6Csm1f?=
 =?us-ascii?Q?GX/ptunPepjVCeZeLafVog4YkK3fTz/TQIBIqEw62/Ogz+98tfvm2iygqLQI?=
 =?us-ascii?Q?/n4oIPjlmA//0JlP2fhQe5MGSgQMoIVNH4hIbJDnH2BnaIwuSbNz/iIWdQt7?=
 =?us-ascii?Q?L7Y7EutjHmsMWeyiYjIrt+sy0Z/2v0DAsKcK6T4snT3jdW4MlVocLWt5EmI7?=
 =?us-ascii?Q?qGGOjW2jkosDJC86j8SHVyN8p4wsDyQh/RuNQ8ETB/MzLquTgOKgXOr3wtnz?=
 =?us-ascii?Q?xHPeskpx3rPhI4awdlge0Je/kdfE3QFTEI/3Sigsn/etln1uA24MxmPnQdq5?=
 =?us-ascii?Q?cGG7TfQv0A4TKJ+jW9svlf5bZZAYk/R4zV24c2lmOEVeZd843prd2BuwRGyx?=
 =?us-ascii?Q?o9o1/WSMcxSZi7cTUtTUrIYb78CT06LMubG58SoVmhWWkLT5M+HbnU3Vs76p?=
 =?us-ascii?Q?7MXVHJW7VcC/Y9mjLIc5DgvaHj71Yn9E0cBzMElJq1CHGyZqeTtMpdl3NxBp?=
 =?us-ascii?Q?FXRZaxojROUi2oTMmuCmCIazP5savkVrXBMUsHPJpkOUwUouDvPNsvJvP/Zl?=
 =?us-ascii?Q?MA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cd4af83-b0fa-47c0-e51d-08da5db559d6
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2022 12:04:31.3596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DKjn43dBD6DN48RE9nzOpxQLGnfhGoqqGq4bmNiVlajMMlbNB8kKSveYIw15tsQ1YQ1CxKIVwcYWAMWdHiykuTFNmBRSzLwTDEHexxlwKzY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4760
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-04_11:2022-06-28,2022-07-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2207040052
X-Proofpoint-ORIG-GUID: aVPBa6AX0bdsSOFisvm3GXENrh-UFSjt
X-Proofpoint-GUID: aVPBa6AX0bdsSOFisvm3GXENrh-UFSjt
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2022 at 10:58:58PM +0300, Pavel Skripkin wrote:
> Hi Martin,
> 
> Martin Kaiser <lists@kaiser.cx> says:
> > Thus wrote Yang Li (yang.lee@linux.alibaba.com):
> > 
> > > Eliminate the following coccicheck warning:
> > > ./drivers/staging/r8188eu/hal/HalPwrSeqCmd.c:70:2-3: Unneeded semicolon
> > 
> > > Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> > > ---
> > >  drivers/staging/r8188eu/hal/HalPwrSeqCmd.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > > diff --git a/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c b/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c
> > > index b5f6d41464db..5b0f66573d94 100644
> > > --- a/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c
> > > +++ b/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c
> > > @@ -67,7 +67,7 @@ u8 HalPwrSeqCmdParsing(struct adapter *padapter, enum r8188eu_pwr_seq seq)
> > >  		break;
> > >  	default:
> > >  		return false;
> > > -	};
> > > +	}
> > 
> > >  	do {
> > >  		pwrcfgcmd = pwrseqcmd[aryidx];
> > > -- 
> > > 2.20.1.7.g153144c
> > 
> > Thanks for spotting this.
> > 
> > Fixes: df8d0a55047b ("staging: r8188eu: make power sequences static")
> 
> ^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> No need to backport code-style warning, so Fixes: is not needed here.
> 

The Fixes tag doesn't have to do with backporting...

I do think it should only be used for bugs.  So I would not have used it
here.  But other people do encourage it for style issues so I have given
up fighting about that.

regards,
dan carpenter

