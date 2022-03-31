Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B594ED98F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 14:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236029AbiCaMYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 08:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234134AbiCaMYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 08:24:01 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7268C1E6E9F
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 05:22:14 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22VC82He007021;
        Thu, 31 Mar 2022 12:22:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=68XfDTeQK5pj6T/YPhJ9RDmWYhmMSyaD+fphflcEBEQ=;
 b=XbJqgRCcPqdV07/+RxtZJzIfJbRKVTGOnwkDWm0WiSAlAUZtqvy6Zdpssdkdo2aaNnmC
 Jja6LbCWiNIErEmg66b1bQQGI4CCUPmiyodJUwo1fWqEiA1Jmo6cFeRXwMK7Qq1tDpn8
 MvzH5ilKwVP4NUmCJqA4Mq7B7MfNuh4TMNtdIzk74xTA4BFr6pYALasrcxcOJ5GYuenN
 f9Z8P+dWbWmbrgCPl+WdBjTYtVc8SBTzEH1vMaSsgRfR7n9+0ZTuD3AEYo8Ba05ajHNv
 ZiuwSp+gjHfZt0ZDDGNtP2dvf/8aaQpV76J0s1N3H7RvwrbMx2/sifNZMlNk+8Trd6lf BQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1tes44xp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 12:22:06 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 22VCHN7N035810;
        Thu, 31 Mar 2022 12:22:06 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f1s959s81-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 12:22:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WtPGcKLvxVVmP7FmJKMOFRM50qyY7OkyOGZTTye/YP+6BClNARur0EgEkhuT+1qiNE+3XPM4ZPbiKy1dBErQj3fc7VICsP7Sek43/pnc3Zwt37cUHp9xmd2oUpf0CR3HmzrW2+b5cktR4OXzCxaP8vXgY6UuUj0Zh6ZCTBJmOW+/2WTvUmffCwDWRi2XnFsF7YRh33L1D229Omc1cAyEfjc6TqINilqwR3Jg5CfBYu/TPlZZ3ToIEDMu2obb34mMAu+usKAyRum8VaaHxRkwCatNYMpXF3+7Yox2+s19M0iophDhduddzGabDk3aIE4ndvHcgfCEzlgFfNaQbV8yBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=68XfDTeQK5pj6T/YPhJ9RDmWYhmMSyaD+fphflcEBEQ=;
 b=hUfjYR1Kj49K2F1x4PycpFJO6b2pnyZze8TeP1chx5AY+z+S7yTq6zNwWjDRU3O861xsNZetPHD5bmgBIvWayk9cErGzjfLfj2XcY7oaFco2Atj//yDUWLIe0X9LigLOoahRaNaPfwvLOG715jtJjvo4UMGgnb3SWrRA5kXCmGaR5YvfC0sSSqBW0YtIItFcEg4DhmRRvZHx52yWM2nzvRzFHDXFVPAlilKj/zOl0YwMaV5zsGTDsfBUm9jdUjcF5QmUZswn992tSp8GSdcJZuFBC81hlqk7w7RfaX7BwgRODEQrqFuLeeFElXh5x3SH3f8TABux2G+qBra4P/U8UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=68XfDTeQK5pj6T/YPhJ9RDmWYhmMSyaD+fphflcEBEQ=;
 b=o/wLP66gnsSm1adH4vdP21DBQcMZwI7FIo4l/gKIWrBwZrDOr52mOotZi+evzMZ1Docor2lWUoBcpNsVKc3OTM9OR5UQ1wLAZInmff9tJ3JyaM6FbuyHId1ZBqLX88AeHHy0bJ1PQEuixzkTmvtNuBJvnaFGANP5RUDVDucmS5w=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN7PR10MB2530.namprd10.prod.outlook.com
 (2603:10b6:406:c5::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18; Thu, 31 Mar
 2022 12:22:02 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c%7]) with mapi id 15.20.5081.025; Thu, 31 Mar 2022
 12:22:01 +0000
Date:   Thu, 31 Mar 2022 15:21:39 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Rebecca Mckeever <remckee0@gmail.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: r8188eu: fix suspect code indent for
 conditional statements
Message-ID: <20220331122139.GE12805@kadam>
References: <YkK7ABTVt0TCbd18@bertie>
 <20220329161632.GA1169956@alison-desk>
 <20220330062829.GF3293@kadam>
 <YkWZKOvThq5paUi3@bertie>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkWZKOvThq5paUi3@bertie>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0047.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::8)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13f20252-d2f1-400f-387b-08da13110ee2
X-MS-TrafficTypeDiagnostic: BN7PR10MB2530:EE_
X-Microsoft-Antispam-PRVS: <BN7PR10MB2530374451EEF2506A1EB2A58EE19@BN7PR10MB2530.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: prTkrrJVUjME/M2DO+4ZHeCL0HNJPuEE/6qcWyC+Gsb3fogdnUl307O5MDWRS50qbzhCC7OWN4sbACUxHM9HARaGPSeVegoqiEDLCrwSKg1b93hVeAENDS6Qn4oJVD+pt87PD0Vntu0fIiMl2SiLx2MTAcpiX23T4mA3/maXLQ4k3jBHneDwwcFFAi5ImaL5vJ8h6qm52R3CD1JU8Ms5BUeN9SwAQW+nbjH0xXGOC1JaDoyzaZkx9Zmg8ZdUUVkyX7qO1efIMmQx3HBeHnxY/Nx2UnQZn7WCuCsWIMdn7HqKcA0G2mGBvBkIOhmmxDIBxAFQLbL/UC3Lyi+HJsdqn1IiWfwmGP/a/0oya+8Vtgmrm5DGVGrlbkf6QhpedEQAyaW01aHBV0tanJPlbTSorbRg2FickgAdE0rPkciEleM8NIwrhIifontW+2ct6tQ+UVVM+26JdKVq5oKDkup3Snr+cuRI57TkHwCDAtotmUjb4SF3Mp1u42lfgKbob6G8EoYSfNRJmS5DGzTdQz6Jl2bMocVGUTTBUdlExkKSVbiarpMEt5CEyma8mydphuVvYOiffeh4sxc91m8E3Aa2VIvC+6cw3sGR5uJTJQwtFZRxJ1Iw/jS5+CBwGNzf0MmGJ9GiUeWreb4yf4w7Q4L4sFoJ3zuGaxxD8voE8L0qbJ7iJhMQFIUaK/osT9cAtZya5IYj3Cqqz3sDEwU56+WeWw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(33656002)(6512007)(38100700002)(38350700002)(9686003)(2906002)(66476007)(33716001)(8936002)(83380400001)(66556008)(4326008)(66946007)(5660300002)(8676002)(44832011)(86362001)(26005)(186003)(1076003)(6506007)(316002)(52116002)(54906003)(6666004)(508600001)(6916009)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a+IKuH/KV1Kk8gK4B34TwHoYJnTbU1xDWo8vxb3jmM5SEWCNoQjtEkH1CyMh?=
 =?us-ascii?Q?MLkipnye6IibIkRcFNL+IndVRfHEpnAkpqK9GimfHpxiQejWYfEMHaqMK7BU?=
 =?us-ascii?Q?WPNqWIXZcQaEdquZdVz/1Lt1QB9EbAK0ckIV8mfC399FEmCVhndQUF1ho1J1?=
 =?us-ascii?Q?gppn/PrbveUqwPODJEC95lo9ywL8EDsTJO6kh2/Ay+1m1N0VA8puWeHGJ/jE?=
 =?us-ascii?Q?xuNI/Rm++acjz9GcH+qmjZaiVIaWuk4zNnP77hpxvmlaLlSeHb0SRoieeOzu?=
 =?us-ascii?Q?TbkasvR+fJuSzst7j6O2aSub6bPb3vZCJ27huch1zaiYCPhR4IPjP0k3V1IX?=
 =?us-ascii?Q?yxyIGjsL4qcREwvjAZ62XXpmP5sngPs2Y9k0fbSF0StqjNfGKzb5JJtDfEG0?=
 =?us-ascii?Q?f2707QppsPE0B+z+FB6fAIUGkPdLvK43T9/a4lNWt7IhIo+zRo5oiprVzhWI?=
 =?us-ascii?Q?SO6wrmT0yzN8pDOkkLX8je1w3B3RIkOBVnR/u5tigD3S6M3ynT5XOJkUnjle?=
 =?us-ascii?Q?t3ZgZ+V5C5qGpE7xlV2pBRkR8pcYlvOqIbvA3YhINMdWoqmDqNrX4Yqeq2N5?=
 =?us-ascii?Q?1dqMdYqND6BkpXDhS8Wl9Qbvx/hS323A7RPBQ+Y/HJBS+HJv/t4SNsZBTRBW?=
 =?us-ascii?Q?9OiFjNQDZgBYXfQk5VE+WTPUC4AObvEnTD742IZzY1T72Arjide+pm5TlMQc?=
 =?us-ascii?Q?wyGyu1hrq+VtWROM35+RNccWm11ccT713AbNFHtz03lWEPhXR07yTCDuWkAK?=
 =?us-ascii?Q?+M84T8a7+ByyJ1P43+sWr+bPDVIrGGOT9U43LqXbeShLxJGa76o3LQuYrema?=
 =?us-ascii?Q?+SKfWgF4U/9WaxvfaNs3owMlgfR9MaB1FMFwK/sMr/ThX6ybsZ7sPbDjnKpt?=
 =?us-ascii?Q?eZeoD6jQDrFbUqGb3/kMamn6VyHOO+ee9392ABMkP7t4KTqRJeRNVjGN4cTn?=
 =?us-ascii?Q?wh/zRf/mgHb5+JUQCy049xu8Z//P5ZIptcEPG82XcbjrxsndkPV1mnI3xz8S?=
 =?us-ascii?Q?8ays381+eAB0eUBb4Q0w48Ua1xsXjbeUNSJYl27WqV0YkcbZiSsdutQvtsAa?=
 =?us-ascii?Q?5OoILyV+G6QxqySo6xGeXFU7l0TGTtyNB1zmI8sNLcb3kSoC6XVOrYtZrh/v?=
 =?us-ascii?Q?ttznFNSFwU8azIvzGFlTUaGl0QNNDUu65ubM2vmR6/cLXIq36ZT72kX9uaYM?=
 =?us-ascii?Q?eIjFoCs3YTYjnMAh4uKuyMW7FNQ2AVrXl+PCTb8MGVeeG2MhVrzg3Knvi5qo?=
 =?us-ascii?Q?ZCWyrhBjt39y4zaG2NQSt4Gh6q5dfhgTntaGP2bzEnupqZYBTIfs1F8Vm5kz?=
 =?us-ascii?Q?qf+cLKy9DmmhZN4DxWPXVNAvecpCUWgbB/ZPUwRZcZC8zUu1XMKApLAOWHg/?=
 =?us-ascii?Q?IYU7Ee4OpIeMavXpVEcBt0icyOlhbIM1iO4XSEqksQ8jYCs/Ntit2Ouqs/wb?=
 =?us-ascii?Q?cJjNRj75FJyc28U2y5iXFwVSVvsgV5D1FiSaNxDNhVJ7QqQR+X4UwUgQoNCH?=
 =?us-ascii?Q?GFpc10MfYSQmcEyTmMd4DYrIC4bOpPVRKsP6roPPnJZtWyNS/LyF+QVIt9cS?=
 =?us-ascii?Q?jf6sIWyMw1DhvvOF4t+SHCLhOeCHynhyRQo65LSGMwhH46Y8h+1o+/DN4+d0?=
 =?us-ascii?Q?h430Qpwc2v7CQcPpGnzfPmEUMMMdj22++FKgUPx17c7TeI/wi5pNsn3yuOR2?=
 =?us-ascii?Q?4MpIX5G7fwoimXz7px0G4J2x7Ig4BEDIAlWh3mH7mwlkEGwLSc0qvr6kQk2P?=
 =?us-ascii?Q?4wwtEyk57qvSSo5ps8G/q9DDAq6Fh/g=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13f20252-d2f1-400f-387b-08da13110ee2
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 12:22:01.5955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yUwgCR8yw8ENamgQQoQFrRCL66Dqu+IPij7CWnlN+aE6E4yndGM3JSjacEqv4xwKfWlkRnVDH+2M4vBUDTMCm0rIhVOhbw4QY1HzpTPSUm0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR10MB2530
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-03-31_04:2022-03-30,2022-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203310069
X-Proofpoint-GUID: tQJ4923-MzJUhiiv2tENMApG_hy-ppR7
X-Proofpoint-ORIG-GUID: tQJ4923-MzJUhiiv2tENMApG_hy-ppR7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 07:06:00AM -0500, Rebecca Mckeever wrote:
> > diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
> > index 6eca30124ee8..dcf7b24f95a8 100644
> > --- a/drivers/staging/r8188eu/core/rtw_cmd.c
> > +++ b/drivers/staging/r8188eu/core/rtw_cmd.c
> > @@ -1404,11 +1404,8 @@ void rtw_survey_cmd_callback(struct adapter *padapter,  struct cmd_obj *pcmd)
> >  {
> >  	struct	mlme_priv *pmlmepriv = &padapter->mlmepriv;
> >  
> > -	if (pcmd->res == H2C_DROPPED) {
> > +	if (pcmd->res != H2C_SUCCESS) {
> >  		/* TODO: cancel timer and do timeout handler directly... */
> > -		/* need to make timeout handlerOS independent */
> > -		_set_timer(&pmlmepriv->scan_to_timer, 1);
> > -		} else if (pcmd->res != H2C_SUCCESS) {
> >  		_set_timer(&pmlmepriv->scan_to_timer, 1);
> >  	}
> >  
> 
> Is it okay if I submit a patch to implement your suggestion? I would
> include a "Suggested-by" tag.

Yes, that's always okay.

I would probably send it as one patch, but I suggest you would be better
off sending it as two uncontroversial patches.  patch 1: delete the
"handlerOS independent" comment.  Patch2: combine both sides of the if
statement.

regards,
dan carpenter
