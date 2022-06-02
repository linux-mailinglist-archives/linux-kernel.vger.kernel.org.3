Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F8753BBA0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 17:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236415AbiFBPd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 11:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232539AbiFBPd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 11:33:56 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292F5D9A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 08:33:55 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 252DvYcq013141;
        Thu, 2 Jun 2022 15:33:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2021-07-09;
 bh=SOIYb+JUvtqaDbTyA8WlIFkhLliOSYQMoDb4Mrz9dLU=;
 b=iMKXhJwGgmCd+p0PzU8KikeCVJg3GTv168S9bGJ1OxWyE79x1XTdVCEcWvO1VswzDN0E
 1iwWf4NErU1O+AnkU1HrLob1riEPJ8jLuBFjSL/g6Om12zMi6jNelkoqHYL8An52Vob0
 tfwoAWrXi9mrIGiDpBHPnd0S+dsCPWTv+3C+Al0B8IFmZnw4NzAQq5i1vo3plb6QK9Gl
 tgle2ivXVrDUnv0jkw970tgVGuCtG/RpYIFBZTmLl8E2zZ39EDphvV8xJmWHY7NU7/+4
 yDtE72pQC4HK5ZMjNGxxgjjGLIGwT2aflIBaK42/P26HQgyRGRQ+uvAiYntvk0ce4yAh Lw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gbcautvcc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Jun 2022 15:33:51 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 252FBYa4009613;
        Thu, 2 Jun 2022 15:33:49 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2045.outbound.protection.outlook.com [104.47.51.45])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gc8k1hy5d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Jun 2022 15:33:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WGnY0k4Y3ALyMtNfXPTs3WvevbLh/1vYmIRv3qEvJt35CoagiELolBq9SM6jx8VouLzkRdvj6eZLmVHe/4SMb0JiHh/r2VN/+Ff1ZtvqfSRqUNCe87SJse6WZnOyCYY1Hq/+zpI8ZazJ5rgDGwDlHPtbgxUTT/Y3qFRmlQ6DSESK0vrb6nr8buXU+wCsDfebjpLzoQij7DGgROfDJuafuLUNu7SWa80uEVgLQlFTuI/D2JX9lVqaF4hVXzJqeosZOz2hY67Qt60JxkfMkLUnWwoIqAQyivCxmzyyvj0Re/CgV7eWzt3nuhP+Cw0PiagrOyagksuf+SVTZQC3hgZBxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vrd5zP5wAZDgMH9PigH6XC3RCC8+pA8OJt7NkqRPoC4=;
 b=gQLzNV5tGPTaDB5teC8UN01XG248gY72CVdb3S4mqzG683ZLzWrHN/UGJrmWkW0Rb4QO6XhkEf8tLpkn+NNI2afO66syF6b91fKApKbPLfyGrABgLrJJY95ApFBrCo1X41QjZEe4ORqvFFMyVami9Z1u3GJx+DvRhBrI8zTE57WVT+nkLAHhylh4zSyMoIzQEVsgyo+NzZj9+hakfFOcmBYD+8hrRS/Ltfw68vyp6ooZcLBCcKWiG8zSxBm6ixZjL03e/Q0lu9EHgcE4D1r4UP8gKZeLfBotl+i+SrZFGK6mG9Hs5QoamsJkpQhA3uLiur084Xu7OTa6YsLugvxK3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vrd5zP5wAZDgMH9PigH6XC3RCC8+pA8OJt7NkqRPoC4=;
 b=h/zbaAX/4t89Cr6Vwo6OnFyrMiYfHtLrrT5Ac1peiuy8l5UCzbL2WdIptaHJjNlTmKFVDOkY78F10/n/Xh7fiT3qn8OnmZo0A88mugJDTsXGqhcw7JkFn6/YSiy+Uuis5TioOiK+iLiFrKHhRk9+Uh2XyvqG5LsPIUPNpebS8j4=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MN2PR10MB3870.namprd10.prod.outlook.com
 (2603:10b6:208:182::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Thu, 2 Jun
 2022 15:33:47 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e%2]) with mapi id 15.20.5293.019; Thu, 2 Jun 2022
 15:33:47 +0000
Date:   Thu, 2 Jun 2022 18:33:27 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Ernst =?iso-8859-1?Q?Sj=F6strand?= <ernstp@gmail.com>,
        kbuild-all@lists.01.org, kernel test robot <lkp@intel.com>,
        kbuild@lists.01.org, LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [kbuild] drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:1433
 amdgpu_discovery_get_vcn_info() error: buffer overflow
 'adev->vcn.vcn_codec_disable_mask' 2 <= 3
Message-ID: <20220602153326.GI2168@kadam>
References: <202205271546.oV14N2r8-lkp@intel.com>
 <CADnq5_NOkqRsoqELkLayNU+xArXd-4RO=_banvJpXHtSW4-YdA@mail.gmail.com>
 <CAD=4a=WRbp8w4DA2c6hE7W5A2-woRyHLvtC-GPitFwQireCeNw@mail.gmail.com>
 <20220602115046.GH2168@kadam>
 <CADnq5_PZBV0wAnNSLSdTc_8acaK3F6ZKDpcgwktmNaR9DKxG9Q@mail.gmail.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADnq5_PZBV0wAnNSLSdTc_8acaK3F6ZKDpcgwktmNaR9DKxG9Q@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0040.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::17)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c53b5e24-f918-44e3-cdaa-08da44ad48bf
X-MS-TrafficTypeDiagnostic: MN2PR10MB3870:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB38700E3E8D67675EF39CBC5D8EDE9@MN2PR10MB3870.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zRy7W27mq3AnBgLi7JXigGXsaqhyiA8CNeHZKQzwFbzqVRV6noQzfbG136PNlhwNniolegYzZ07DE1eLjf6e7SLBCsERqKxFn3JlmBtwQN0Si0KZ/qJ8cpt1wmDm8X0cZjmXJ6abei31S8up4L1ARY3v0RTHtpzAkOfx2dF9wseExpgU/3/2Tv9glJZPXPRv5lP1bgpl+21JLVUl0p5uKzPQgANvkeHNdrtho/duRudbXyNHW1AwJ3IXC7xQ9SKSx5amaZajxn2z3MWekGOvCX7G6PspYmN8k7I7VumnWiS/oKMhlhRYPPAe3e/biKUJcRJTUwQcrKv14JcMKUbA2n6v9WzZVzX16VIvVWg9tFrq40x1X00+AJ9UyXz3lqtRkLwIy2uafVceTnSP7gsI5gWoN/+fReYZgik9YyQxlL2ieNYMuM8D7ObAT1g8IjQtmY2AYny23dWwclpFh5eP5KbINqA825e/ySbZxlMmJkQnQpYUcG29ovZ35ac8csG17gP6nljbIs3hAfdL9a4A6lKwo2Q/GzdR2tOtlFzasgCkoifEdNwZqs2UNoiHyEKF2dP3KmdSdWp967x3Jk06eh7rVUrFz6RYPAHKwJ5mZjwGlDknihD5mBbOE5/jBqK2yaKJh6/H4lxNDRxcRM4NjHYtwCdUhIDoGT0klWp0pua7dMOyps0kYDt7DeP1m7949YbOkeNDWqnZnYxVc+oW3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(5660300002)(53546011)(4744005)(44832011)(66574015)(38100700002)(6916009)(33716001)(8936002)(26005)(6666004)(2906002)(966005)(508600001)(316002)(6486002)(83380400001)(86362001)(33656002)(52116002)(186003)(1076003)(6506007)(54906003)(66556008)(8676002)(66946007)(66476007)(38350700002)(4326008)(9686003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?AY1oFytdZt0N/YbHRM7ShzodLRbCLns9MribDRt6GoGIV94gjWfHPo82VA?=
 =?iso-8859-1?Q?kgTnxfwMGDvGZGP3eG466QBxreTjUGRKMysCJ5EiRHOrgrjb9ERWD/Gtu0?=
 =?iso-8859-1?Q?dNxbfGsJDGlhXdCjUBnpuS3NhhnImikR4+mnj1opXjl8KqvnnPcA0Dqygm?=
 =?iso-8859-1?Q?Z4gMQJLSmt0vzO2blTyVGvixysd2NB3FtxDxCYsKiTcnZiH/LcO2h+EMq3?=
 =?iso-8859-1?Q?Iq12KTcV+pFr1ND2qBWYB0B3aMrNsTHI2bYMnWw6/95z499qLG7ZSqCUPw?=
 =?iso-8859-1?Q?0p9neS9ziwKz5dCV10VGTh00DN9W+dH4AuGqfHmsBZqUzcpYEFfTossn9g?=
 =?iso-8859-1?Q?5WStrXKelqhYFjY23KkZerqrkCkplORLw4yFInWAueBKzh8ECg85lWTPuJ?=
 =?iso-8859-1?Q?gP/TB1IuoxhyUq6rsxpySzHO7hYcmiRRn0Fz0Ue0wbWlAOvimGC0pWCLpp?=
 =?iso-8859-1?Q?syulKBHKLLIDMDaoyR/mkLP+Xl8VBqAPNliaCmsbnhokophEC03vxtX8EK?=
 =?iso-8859-1?Q?SrNzQu+nphx2sYZ5Jnfbi3XQnro4ftAuFleK5x08jh5te0ynE8UOwpXCmB?=
 =?iso-8859-1?Q?NniBG/Ht+OtmQwtJaEeSq1dhfd3DpYkmMWdGVSUQ9GWvQMVj/OUPF9ArdF?=
 =?iso-8859-1?Q?//tNTKQYBhSmw3Rtdfuixk27ycvDnU1zA80sRkbF8XY7Q5g7/4U8nTnVQ0?=
 =?iso-8859-1?Q?ddMArzPREEJTfGY9NqWa81cpcBqE/yULgnea4Q3rZ0nqL8/GkNJgVPPh/A?=
 =?iso-8859-1?Q?upgPr8QMmFAIAdc/mYKv1ctAwTvd/GlsnieKDf5gI2lCF44RGaAD08q2PL?=
 =?iso-8859-1?Q?sH9YYnzZfS4HpSYbYWvS8yiQ8dQo57EC9R72etRdE1lMsnocI23OM5UMtO?=
 =?iso-8859-1?Q?iCSB5r3nQgxR5SbzxOBqpUMLHUisvJveZYl1wbrg1lkiUaG9lHH2v7BcT7?=
 =?iso-8859-1?Q?E/1JBnO094P5D3gS0+/qPWorYjnV+a658MwzSQt84X9lTX4N6rYqFtI909?=
 =?iso-8859-1?Q?/ziEXa4u5zN9xCav/BLn21eopcJKfp2pf30uGVUuWXOW53I2bQmBZcCuWJ?=
 =?iso-8859-1?Q?LQQEmS7BxZ3MWTx/It+twgGgbYGBxqmHW5cyQHO0j4seQ3kg90GTyqwgHk?=
 =?iso-8859-1?Q?RmXBnVeMzZiqah5s6t43fBUpRT37MaLo8hVBYXqJef212eVJLQmTRe1pGh?=
 =?iso-8859-1?Q?BL5uIu7YX3xFxAm+JM7XXRfmzZWq7fK5AS4J/pMDFNhkIawOV+M0mY1eHT?=
 =?iso-8859-1?Q?eQvoV04lVExg3fSvfCY1rP/fM0joFUrusZudKWI4zIlMy5NZWhiIHcGPkf?=
 =?iso-8859-1?Q?rg0LynWCj3lLGlpmqBsm/lDJUojvr86f6/47W7TxZLzjUiCV9fDYnNdwXI?=
 =?iso-8859-1?Q?k3ArWMNde7I/zRNn7OSEt74jdWyllkAqLEc2BOkJVqKLgwizWelMvIh81f?=
 =?iso-8859-1?Q?CKNWYGpf2pSGQmXsHvZ+DY1DTrkNFuwgsmOOdv7JB0acawxKoUu59ENHxi?=
 =?iso-8859-1?Q?85OFid1B4zR9/erSE0N4Suesku4SWPeOhHKLEr0tCNBSFJnJw4/MaBANJF?=
 =?iso-8859-1?Q?q+Ojy4+oxzxOHul1Jc1lgWNXOynWUqeCAzIBgXL8FG+RTp1ZXBvrmqijEE?=
 =?iso-8859-1?Q?BpnnXgm5da6rvRqgT6i0UfsXiUxEmP+4dGAYsqx/0yAJP4uQ76e/+mT5LL?=
 =?iso-8859-1?Q?IwFOn4lRmsDcqUfH8iTfiROyXqZ2slWpTKsRV6VzahaCalnL7USYKMvtXY?=
 =?iso-8859-1?Q?7fw0W6nj/3v3uiqAuTxBusV5tgXc5rhyREz0hevw4JNNTm4hyvBevixt+s?=
 =?iso-8859-1?Q?0xx2UJ98gaXK34R4uZjd8ZhCXV13r4Y=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c53b5e24-f918-44e3-cdaa-08da44ad48bf
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2022 15:33:47.2219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: InWVBinP4IdK4a1CBVh3k6q7QeUGj7eNqNvuZqwuiWbOchayPjh6mEa7nUNxxMaq4lWLIiWRV7RsOa0gsWfw/JbnlKBUWXVbVbZrCgnYs8w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3870
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-02_04:2022-06-02,2022-06-02 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206020065
X-Proofpoint-ORIG-GUID: oo5PLSp8YfQkDxWwtbpHiB1kPi_dtZ9P
X-Proofpoint-GUID: oo5PLSp8YfQkDxWwtbpHiB1kPi_dtZ9P
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2022 at 10:24:58AM -0400, Alex Deucher wrote:
> On Thu, Jun 2, 2022 at 7:51 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >
> > On Thu, Jun 02, 2022 at 08:26:03AM +0200, Ernst Sjöstrand wrote:
> > > Dan: I also ran Smatch which resulted in the following discussion:
> > >
> > > https://lists.freedesktop.org/archives/amd-gfx/2022-May/079228.html 
> >
> > Since the bounds check is dead code which does not make sense and is not
> > required, another idea would be to just delete it.
> 
> It wouldn't be dead code if AMDGPU_MAX_VCN_INSTANCES ever increased.

Or we could add a comment to the code I suppose.

	/* Impossible in 2022 but this check might sense in the future */

regards,
dan carpenter

