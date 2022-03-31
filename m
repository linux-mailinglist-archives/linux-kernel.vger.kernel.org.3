Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3544A4EDEC3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 18:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239874AbiCaQ1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 12:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239934AbiCaQ0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 12:26:55 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B93A62A1C;
        Thu, 31 Mar 2022 09:25:00 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22VEx5gv007047;
        Thu, 31 Mar 2022 16:24:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=Yq8+2qRMKeLRoqN/aZe1kpvfpI6vhl22zU0q135oV90=;
 b=BLOuylkPkEHSaE/A2/pC7h6HifchkYOe/IvcGMDRvLpnQ3cvrNKNX8hY4xsCJy/FK2yu
 vrnhdcV4qUF67bGxQVIXyHJ3T71FnAxVe7nsaZJ7LmlfDNzn9IWXl4Hq1daZA6SXv9V7
 x2V2OjYFVn7y2KbCEFM3yDRTP28GHQZorXZqptuFM4FfFlqk3D446JbMAthoLSRHjM0J
 MqwYm8l6CJ/dq1iCQGf2mGmZm0bjHNhbhHdHCkdgfxJjPmZ6k3TK6tWMoS/m7QQRLWj8
 06/sHI5sEruyNImVwVSTFEdqk7fe1/TCFvfxENyR6zZQJAW2HyFYS1Cg5PT0YAT0T66/ Mg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1tes4tgp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 16:24:46 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 22VGHKcd010056;
        Thu, 31 Mar 2022 16:24:45 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f1s951pc1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 16:24:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SkwqXA03soDgxnQbkLU40gv9WePXWAxuV7uZQDXpAzNPEPTbokCwW5j0Ttf2YlPj9j2KO2n1bBPO27QRfDHw2vtC9J/L90/MFWgRMAwMLd3Z/z+pkPQ0OGRkVT09o76+px49EPLjb6NIDG6T8QnD2+ILMewigh5Pp2sh24OtmDdzdfcLfTs2V1LhNcyWBsgNhm/Y3/EKOSQZeAJV9Ov0+0nCsXIardKvpYRGQaO3Umv1I1jG0sL5Ree2qBUmNxCR1+k5rRbsq+Pm0iEXwvNQuzK7eGSvwvvimkmK1M5TLL37UGP7f+BldORlCQ0S8lSwn06SDmMnxd0PyzvXRe8gLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yq8+2qRMKeLRoqN/aZe1kpvfpI6vhl22zU0q135oV90=;
 b=fpeGNmyyspsKl1vR5c5RJ5NJkG4HMP9NiiXckWvQSUQiFidMZAEKvbz6hACpiQQf9HRl8Cb7VdkBtQq21UhtOyZJSX5djYcQwiKNjTox2QF2bqEeFIKFsYg7MEDDCfuY9kEdgytR9Wm1DOTpXW/TJ1dnnI8YwF0BaZr1tMrPgFXkNtrDVhZUBZtbk/7IuRHwTWUnrWLgofq/mGBWor/z04KYbLoZ7COOmj+EDbZquxfuRI+E5rHGrJYSGTgH7XQUIcMjUO+8ui9sYxVBLF7c1/AVoiKa7kuJpup7azL83reICxJbzpQU6Gme+8Ry/BYHinA4dogfxz6rSohjP6kuDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yq8+2qRMKeLRoqN/aZe1kpvfpI6vhl22zU0q135oV90=;
 b=EWQlIZvTJukdE1uoAt3hES52m2ExIdXdcB/+ITD6/MJ6GEbFaJlC6ak6HZWclNfRk1Ls6tCw8O2/T6su2PwwIVweydyvPJaO+Hnc8vmDfMzr173KlKCoYwIktoDvQji0aYGV0mzpzrZU9GA2MFuiGWGpj4XL2HwYHn4lmow5l1E=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by PH0PR10MB5870.namprd10.prod.outlook.com
 (2603:10b6:510:146::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.21; Thu, 31 Mar
 2022 16:24:43 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c%7]) with mapi id 15.20.5081.025; Thu, 31 Mar 2022
 16:24:43 +0000
Date:   Thu, 31 Mar 2022 19:24:16 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Wenchao Hao <haowenchao@huawei.com>,
        syzkaller-bugs@googlegroups.com, axboe@kernel.dk,
        jejb@linux.ibm.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        martin.petersen@oracle.com,
        syzbot+f08c77040fa163a75a46@syzkaller.appspotmail.com,
        linfeilong@huawei.com
Subject: Re: [PATCH] scsi: sd: call device_del() if device_add_disk() fails
Message-ID: <20220331162416.GI12805@kadam>
References: <20220329154948.10350-1-fmdefrancesco@gmail.com>
 <fdebdbd3-575b-b30e-d37f-dcc6d53a4f53@huawei.com>
 <20220331134210.GF12805@kadam>
 <1787706.atdPhlSkOF@leap>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1787706.atdPhlSkOF@leap>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0023.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::16)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ac9266e-f168-4390-ad3c-08da1332f614
X-MS-TrafficTypeDiagnostic: PH0PR10MB5870:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB5870AB050225AF32B56441178EE19@PH0PR10MB5870.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BiUNm0o/5zDXNANA5rxTbo9yJjGbqF75BprVe7IZSjiDmfqxAV6mS1Ugw0KC7IKwKooye2uGk0cO4cdAyhOj5W+JLPUetQIsNiTVVMQu0yDRWS2woBaLUVoPqWIWD8EwiGNBnUv0N9IkMPJesIAeuO4jcpgTtAEvicKru+S7Lk0niIVrEg96nWXvYY/pv2apvztZ9rVZ9rNfsYmSZllwEHfMIeOhcMIuSAz+biyDWhux88wUxuQOcmxAPOfuWlfSCBT60GrwsFJIoNmVzX9a+SeGpil3KqiUsHOak1jfq+zcwFLnMnGa9uSdF69BTBvTrkh93TddNAMMHdB3pmyQbatTt4IRrV+7G22oSf00NFHpKcKM4gywOv/GvbctfSzTG6oAd876lCwdmn+U08CoCL/kG3onwWhYapw1Gt/cK529Zxv3/V7x9gIbUm49ihiT93nKtvijPgYsOHhUUR6Kw3bZjN7g1oAPh+sGba2N2dgLI+AOqtRMBGJjIUaG6luC9KzIF5vz7Q8QligB4IsioM3kdKT+Y0OreZdw3We7U27J512Sc+20xn4O3l7zCkK9I9G3cRGarn/F1KMu/xVgG+tjAcAQmdydI0vsl+BqAubaFDjSH3nI1J+NVRYU/bK8YLI7lhvKKAkixDlXAgCSbOLXG1dYFk3KU0zIJM1lks62Mj5Pm75o+wnI6bgNshTuNCPpx1f+hZcWIXMO5UNc3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(508600001)(38350700002)(38100700002)(7416002)(33716001)(6512007)(86362001)(33656002)(2906002)(6486002)(9686003)(6506007)(52116002)(316002)(6666004)(4744005)(5660300002)(8676002)(44832011)(4326008)(26005)(1076003)(66476007)(66556008)(186003)(8936002)(6916009)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iM2eOEd2BZ2UeUDvbJFYY86sstJ/sNEVN5dfU6tU+E+obINabc7d9bV1IIzY?=
 =?us-ascii?Q?v6fuzSc0x+LZlK+XZkWx7lvaV8FOk6eJLDCQEDe78cQvndwrp3FEdpDiaDgN?=
 =?us-ascii?Q?zQsB6JCh7nXwNKw7CYTnqaH+Xl1irUXqxTJ7r/POzDrBtmKzj1WKy03srAj/?=
 =?us-ascii?Q?d5pgqUssdZjSWnUcS1lcybqdwKV2TIUSF0Cio1kVq3PZVSGp2N0RrjXU2GUy?=
 =?us-ascii?Q?mKskQIB+Pp5S6Mz/ASdGP4KAsAVWijBpLNkq3HLhM/NjXHsfVYeUNhuKNKOv?=
 =?us-ascii?Q?jS2b5AQDMLTDqN1vN8LO3JxuAb9Gs1Y7Ll/lkg9X0KBjGL7UgtvzEqJ0OhMM?=
 =?us-ascii?Q?Dywg30Di/TXQ49w/joolLVZDHR4FjOX1zsyeMvHXArdP6tDv47kitrPWDaOF?=
 =?us-ascii?Q?/xb+f6DNGcKf73jgN8q1pfxfQVrsIb4UBURXp0iMYHlzDgIRfnMtDdR9iEt6?=
 =?us-ascii?Q?ecafZ1BnNvqFFy1rvkSlB7hSywoN22mrBjJu4ZEDZlRzk77M5BcrA6CfYbc+?=
 =?us-ascii?Q?SQIaWQ/eeMgbTifowmg5n7Y7Mcm6CjdQ7iAWQ1jqvV1pEjaWkTxUkl4ix69W?=
 =?us-ascii?Q?LbLl3LBpHbcW6z/67YPQCkQ9sWIXgXVR+i7ATlhsKbCudfHF+H5v9+Lecjco?=
 =?us-ascii?Q?L+GS/TDCIDHILt8k7LTV9ZZnjC4Z4tTvXVR1Y0TP3uIwQ4x+fgHZ4zhLaUR+?=
 =?us-ascii?Q?7Y2iGRIsPwxpHfMJwXmaXHg9URQCBg7csIxHAE0appISEpmVrkMYza0bcYAC?=
 =?us-ascii?Q?PgEnCCqRxv4bjockm7VU5Pzl+1/srdZu2FqoIosP/lrPFHtaLH3Fjv6C0qQv?=
 =?us-ascii?Q?8/LjyIqNUut3Et5EIoYnU2B1ZrsnVxEorRK8G6RbD46tAmRoM8m4s27MOr6L?=
 =?us-ascii?Q?rOcJf0e3qekXlvaIbsvpXZKKZSO90S0UHKwH/f3ineWRysvVCu6UuyPMhP1v?=
 =?us-ascii?Q?7OxSfr2CUBQIG3flPS4ZWk6D+LG7T6xqRwFhLH73e6TvbBkcisPIINQZ2lQp?=
 =?us-ascii?Q?fnzwcovpMcQyBLziMEIZKwpItCw3K6S978aUEGHfM8zHZ5oSoyGfctn19TJ9?=
 =?us-ascii?Q?DQhX76TlOnoYXoQFOdj+htJs04RvMBB3J1dp+9yJalw9aLJTWjZB4yJgUbjf?=
 =?us-ascii?Q?/BN6KJHlpkt8pMXdNFUD0PcjuaTJuRWIDN9i/ymy71hSZfAIUC7k+e0c2eIa?=
 =?us-ascii?Q?1kPZtxibZi5FxcZVDnGt/72c12+Gh/w86URg63Yzft4SXoOYGiCyeS+I6MIP?=
 =?us-ascii?Q?mYHw4jnF1vJtSdwsS/00QFwTBhp/ERnRnTnfRuiTPiCJoddeafxoa8+s5rDT?=
 =?us-ascii?Q?lGsyDcXRzDHS0Gg2+yS8YiTKYWnGMNqUu8xqJY42UjmWl65ulisftZoCYM0l?=
 =?us-ascii?Q?AeTqvi6QU3TgSQCsd7yqzERJKDEbG7GhzCnY5WCOh6BF5VGhOW5j7NnUfP1O?=
 =?us-ascii?Q?Fmmyz5u6dnp1ArWn9/NUKtIoBJm3DfgNQY5fkA+xBty/YBxnPA3+UUQll74j?=
 =?us-ascii?Q?4crRFqqwHWxnbQvC9Q4itQAFw0vRIRC2OtYCvDcAqyJwOgw2LxC/6d+Hz8Kc?=
 =?us-ascii?Q?zR9Q+R87UPPVAY0YCta1Wqr8Xpq4FdB85ccm/RV2h04NQADozWFsGwRZ4CQQ?=
 =?us-ascii?Q?8wjZlpeXfbX69s/+28tpvjuu0NmkSz4gZC5j3WjA9kysYNYgSS2XI6QW0/M6?=
 =?us-ascii?Q?9NmLBFbZxD9VDyccz2oj8qn+AzwWV992LDYvVHCBv16Vb+7Y0hVS96IttzEG?=
 =?us-ascii?Q?eJZ9IE/dT/kvXvPdkCN944njYIInMXM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ac9266e-f168-4390-ad3c-08da1332f614
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 16:24:42.9657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c9VWKN9ggo+HbWnGZp2zUazhcc36W2YNBPk35Fk6Ax8R0Np0KXh3EJ4GjiLWFO95q9yO3Zd4OwUrU7hVyOWTOPPxAi6H4uVWMzwwBTuuKrE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5870
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-03-31_05:2022-03-30,2022-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203310090
X-Proofpoint-GUID: EP6NiaObFWaMerlAqXFDaT492otoLsy4
X-Proofpoint-ORIG-GUID: EP6NiaObFWaMerlAqXFDaT492otoLsy4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 06:14:27PM +0200, Fabio M. De Francesco wrote:
> On gioved? 31 marzo 2022 15:42:10 CEST Dan Carpenter wrote:
> > Wenchao Hao, what you're saying makes a lot of sense but it raises a lot
> > of questions in turn.
> > 
> > Fabio, did you test your patch?
> 
> Yes, I did, Dan. I tested it the usual way with the "#syz test:" command.
> Obviously I have not the hardware to test code on it.
> 

Yeah.  What a nightmare.  You posted a link to the first test.  It said
passed but definitely introduced some use after frees but how was anyone
supposed to know?

No way we would have figured this out.  I'm working to make Smatch
understand device_put() better but this one is way difficult.

Sorry that you went through this.

regards,
dan carpenter

