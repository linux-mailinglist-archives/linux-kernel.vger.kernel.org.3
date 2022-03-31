Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125574EDABD
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 15:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236967AbiCaNom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 09:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbiCaNol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 09:44:41 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E801B214F8C;
        Thu, 31 Mar 2022 06:42:50 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22VBY3Mn032352;
        Thu, 31 Mar 2022 13:42:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=DmZc/ANtc+F1F4i1bejttGxyoE6eGgDK7WNzVU7FRUw=;
 b=rbKxoCIsrFIdRl/LBov0szm8bauMXZwj6RznUt2e4qCYaIi0x7mSQ9tuUKbkSbw+ANAM
 lkBnk7T/hlEO4u1QvFblbA2FpLY5HZCMS8o1CLh5sGnCGojAsd44OPL727DCYvb3/cmz
 qEBsHek/jt7xYv7xp/IAVooFMffvxJsMnqjC1yWOSZK+j4TD6PH3ttU3w2m7iBzaml4C
 aRn0lxFOF4s56ywCB+rhEbMkaOjopvfqKySr2YBdUAhASfS9SSJDJ5DLEpR/m/AyqlqX
 LIBK6+LDczyOeXhrmB/9PpSLTlpfKKjnHuGGyIt8nfBV3JBMeR25C7QcpTGr1xtD81Wd jQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1uctvk16-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 13:42:38 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 22VDbLf3016966;
        Thu, 31 Mar 2022 13:42:38 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f1s94u4pj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 13:42:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nd0oZAzB5UZe0tcfxDiO7PXUC434tLDAS72dikn8MJRNwcu/d4sa20Rh8hr0AZthZWPmfe2b3ao0F63GdeC5PCIxFsZINOp8HLz/qrctlfF3q0wJMMbP6LWMy/60jJMSI8Dp7Ow3gD5YtcnGgMaT2+bKn93rqEbyLwYjxvKw0T4UT3LSZXBNzK0ldG7ptyQxPplxpOL9k8ntMlEBHOgPIAw5kYanw/hYt9ZBOxzcsCNjmo3Rgf5qyrzGmK2UL+VZFKAWeScgcShrKwIudpKOvtlHzqjol1dp1nRMR0oPv8ODLzAGlugLL5rA8SEqTO8aBZ/GC8nzAz3rYkFCs02yCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DmZc/ANtc+F1F4i1bejttGxyoE6eGgDK7WNzVU7FRUw=;
 b=BoaazybFqnVzkcBpyE7wGJf+X/exoA1IW/k6Q5udabJmmwa1eDXscEk+GOKj+0MSI5cDxgXEUJ4OvEXUYxh0xCen6J65WpWsjS+gKcfAZQDCdl8dS+CAsw2OZkKMZkvl3bXWTzqaTOIJHs4YHQD1eHNChUrbXm+LTO2OVVuaOjFUc2lPXbFX1pgXjzy8PmHnRZSCXSx2RwdqdSoQSY1/bigEcEmxCvYrOTCxUIcwX94WsPeu4/TwfVX9i43PjH3/820OtHq77ZQj6ucnhAYjmXzdG+uircKRE35A0CjAZLDfgL2AJEQexmtR2GWsjQJ5C1QrDteUiNTLZ3BujcNcrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DmZc/ANtc+F1F4i1bejttGxyoE6eGgDK7WNzVU7FRUw=;
 b=TFeQfix1fHl6/KTMp3Qozdx1xHkX3pGTbhds76nxyz+Y2JqgwFAfcU5lo/uD/2eyQD3c6Ug9ecNtECrCJR2l1/KUidMXAZK1kQ1dXRrh9K9zdOCfa81lq13X74YmMYGwlfwVHoif9wnWz8hSddMQWNG8uiJF6HTyySnLxRP53BU=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SA2PR10MB4699.namprd10.prod.outlook.com
 (2603:10b6:806:118::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.23; Thu, 31 Mar
 2022 13:42:35 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c%7]) with mapi id 15.20.5081.025; Thu, 31 Mar 2022
 13:42:35 +0000
Date:   Thu, 31 Mar 2022 16:42:10 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Wenchao Hao <haowenchao@huawei.com>,
        syzkaller-bugs@googlegroups.com
Cc:     fmdefrancesco@gmail.com, axboe@kernel.dk, jejb@linux.ibm.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
        syzbot+f08c77040fa163a75a46@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, linfeilong@huawei.com
Subject: Re: [PATCH] scsi: sd: call device_del() if device_add_disk() fails
Message-ID: <20220331134210.GF12805@kadam>
References: <20220329154948.10350-1-fmdefrancesco@gmail.com>
 <20220331152622.616534-1-haowenchao@huawei.com>
 <20220331054156.GI3293@kadam>
 <fdebdbd3-575b-b30e-d37f-dcc6d53a4f53@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fdebdbd3-575b-b30e-d37f-dcc6d53a4f53@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0011.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::23)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec4bd794-ad49-416e-7b29-08da131c501e
X-MS-TrafficTypeDiagnostic: SA2PR10MB4699:EE_
X-Microsoft-Antispam-PRVS: <SA2PR10MB4699901F59708254842B834D8EE19@SA2PR10MB4699.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n218QrYXxCdwSrm68kdV3ZBY4bBYJGx1iRwCOvWi7Rf1ry+K4H0yibfmU0bV+vaQPUYKji7iLDBzxXPjuAgEfPdC2Qt/20ZLBGdDg/G4Z0xx5uBLR0EJEASdwulyGEqGcHeMCEEVcPIIO6+3g3/12gW0yBGVzVocBnmthopWrrz9qseF/VFqcCw+O3vif2JhuQG4qXwHzRXO8x+gfHCDkNbhk64acWSiI5j08DrIwlTGE+/2tpGdf/1j1B/+VI8ZOeIdjedCZVTmKZ/wvGoWdcZ7xv3pcJJWQfE+IyHdea9KpTjKyfL4I13QoiY91/VtOoRE2h7EmizpK8UdByOX1nEoP5+11e150fqppVypqwf/eExfsLwZbemmxkAI0v5yjCNf57qWTssKXA/s2I4JZsk5ZlC9tnwdVJ8Q2PzNYH4Uhp3etU/a0YA0LJq2gbUWOwLYxLaAIC2AezHd80oNNyQ3Bukg5dgVPuZ6hJ06vX13Ct0p2U5nxwaRtspl5Ntb9/s4h6IrLvtIk5KMVNdnVoeay3vSE2vtTX6i8uTb0/4daT/Yq29Y0vaFy3EdWVbXS2PzoyssKI4kSmaPybN3aEUD1Mgg9x/O0giDQxRQocrU7EE5eNo7IXFKxykTs9rSKtLL6DlabBB6/ue1iMVryzxFWxFbGzIVF6g1FycxydjhWCERqsOQW+agSQp9ZsQf6YBfHWXSwgL4PDonpI66Rw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(8676002)(8936002)(4326008)(44832011)(5660300002)(6512007)(66476007)(7416002)(66556008)(9686003)(38100700002)(52116002)(6506007)(4744005)(6666004)(66946007)(316002)(186003)(33716001)(2906002)(1076003)(26005)(6486002)(33656002)(508600001)(86362001)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?89iP8+qw8YGX8WIzvgzCvU5V6zzg0xo7KjHWg79uWp/FaPCoDJPDZPzr2zcZ?=
 =?us-ascii?Q?wWQMPkK0d4I26xlvRDWgZ6iULgBSymbJoZ2NGyaTbmRfmthKe8P6wo/zxswQ?=
 =?us-ascii?Q?9sFXmy5qEG5YJlRFhJO0SQRlTz2cMhBxQsrY4VnOT1rj7v8RlUp5AKcVHrpT?=
 =?us-ascii?Q?hQvLpS7ZCzL09G6szYkjudzHL6Kr7kpQbYbk2g/8SKGBLxxmbMQ3DBStoigH?=
 =?us-ascii?Q?jIOTqDThKdB7FH6nyntxQtG/M2yjTHrGcJ0zWGgmvJ+txCMH5hZjs5exGQYj?=
 =?us-ascii?Q?HkLzpqo3aH3Uf8bVPxGcowsyVf638ye6j9OCRjWxzK4Ujg49/O/xewiBqP6x?=
 =?us-ascii?Q?orMEk2RyAYtuNe3qKTSK7iX4yM3G4OmBHmfvUxJzL8RZ0S63acIZTd1K86KA?=
 =?us-ascii?Q?C0on6RD/LjYCgNQh1sK42gOr54PlRoezm1Ypi1QMRlBVa+eXv47dKJhF9u0s?=
 =?us-ascii?Q?ineY/RCnwiBTfmU2QeIibY150RuyuSOQG8F1oEV1iDS2fH6Ag+mlmjshCcW1?=
 =?us-ascii?Q?2GffADUaxAOKKapz0K8WBWg+VFQ7+95KyIE1jN8vaKxNP8O1PewedbaWEhmy?=
 =?us-ascii?Q?5yyic22UdsMNl2P2vaRTGJUePaWukKaRsG7u2eofaGmEy5GQoEIwEzE3Y+ZD?=
 =?us-ascii?Q?0bdkG4dd8Y0DxXnNFNjduTI8m0snM9fwVvhaA1XhXV+XiwwppdZ9YYPdtHpR?=
 =?us-ascii?Q?k1Dw3pjqByfHAcJxfTCOgZempd41KHadi9pMtkot8NY3H9jnWTtcZaUTS9z0?=
 =?us-ascii?Q?j9xd9kTix+rARvpvp6Na3/QvBbk0qw5J7rBzWsHzciR3a7GHujAtBzWnG4pe?=
 =?us-ascii?Q?TXGr1gGIDg4SQgm005CfAuKatCIeNXV9wpASjJVLWVGOiJOR69DAnIc/gk2h?=
 =?us-ascii?Q?dzM+lxwgjKsoVcXIUaWWIULIKavLOBRWOFWTbJ9R2uADAKAwnt+suyyn15Tt?=
 =?us-ascii?Q?sehWB254kCvVP/12+g8Q4Vcn96par0eUD57S8+qPmCPpGi7nyZLhuSkNILha?=
 =?us-ascii?Q?anTAcLZA8ccn/OdXIbhumxyLp9r0nKxlA5yjqoidGYssqOLsG0US8kx4JPFs?=
 =?us-ascii?Q?OJ57d9jxyfedm6eC6MWa9S7o1PgMHXR+nCcxmQc9zOqprve+u9ODRbvqrY8J?=
 =?us-ascii?Q?pTjA8LmNvbw08IWThzcyz4ik3M9K0U/cxGDY+U933IPmimfSZLyK5bPDbPmQ?=
 =?us-ascii?Q?a2kzWdg8QAbvsQABvKAwoGuKES5Cybi/moRjtQ5yqfXWye4CI7o+SszyGDiv?=
 =?us-ascii?Q?0zxe4Zr3k8VVvayeQQ03NmjP6+ykcZKhG+YIpIbaAtMxWe+An9BUY9YoqdhP?=
 =?us-ascii?Q?KISZqXlhmfwNndYnagH2EXB65YOVmrH+i4jq6bSivpliqNhOfR6QHcrx7bvj?=
 =?us-ascii?Q?uNKx0yDzgZ5WJAMHsj3MR7CQg2SlcW+RkYfk5lTxR/GF9ZrUD2MiHTUcflF2?=
 =?us-ascii?Q?bA6NK8L0xhXZdH/sMKLrRAyvCWaT2UAd7M0LpTRJ8nsaxmn0XYjO9izy6Ht0?=
 =?us-ascii?Q?LshA5gh7x1TurcR1eE3wVE+drjh86+veqvUoKEvU8IegNROOOUO3ZRl9fRpr?=
 =?us-ascii?Q?xbVU2wWxqIU1JBScFbsOBreRdQMN4aQsRoYzQCbQm48Sx6Vq3WUhGzunB43/?=
 =?us-ascii?Q?Ent1mzzFVBpicP10QrGBlOKT05E56A3E98CQWhRpogqYAxGk+NzZEGHqPxQw?=
 =?us-ascii?Q?tXjRl2ZOVlBAvXNSMLlapAcrFz6dnvpnHnlPNshKRkGYFlUdUxEIGh8Qkhig?=
 =?us-ascii?Q?B2iSyv8bIyVhm8tmoE+qeouamkvxaGM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec4bd794-ad49-416e-7b29-08da131c501e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 13:42:35.6001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jPgyvNhxG54Ukro155kj12MyvMMKhGmvNC7C5agIVjYKulx6Q3kKbmZdA0Sgt/W/GltdO/A02vjAM6mpOxAO2DeMsdv7pbdBTnKZrRlto3I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4699
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-03-31_05:2022-03-30,2022-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203310076
X-Proofpoint-ORIG-GUID: x0CHvfquX8-A3of-5-sSiUwpb2KtaYtO
X-Proofpoint-GUID: x0CHvfquX8-A3of-5-sSiUwpb2KtaYtO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wenchao Hao, what you're saying makes a lot of sense but it raises a lot
of questions in turn.

Fabio, did you test your patch?

This is another reason why syzbot should display the whole dmesg because
otherwise we can't ask people link to their test results if it just says
"PASSED" with no additional information.  If syzbot provided a dmesg
at the end then I would require a link to it under the --- cut off
line for patches that I review.

In a way this gets back to the original testing that syzbot did do.  If
Wenchao's reading of the code is correct the Fabio's patch caused a
series of use after free bugs but because the test results just said
"PASSED" with no additional information.

Either way, failing to call device_del() is still a bug.

Also, I don't really understand why we don't have to call
put_device(&sdkp->disk_dev) at the end of sd_remove().

regards,
dan carpenter

