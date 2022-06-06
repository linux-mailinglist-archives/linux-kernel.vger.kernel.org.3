Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5935553E658
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237745AbiFFMsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 08:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237718AbiFFMsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 08:48:14 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B1F2228F;
        Mon,  6 Jun 2022 05:48:13 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2569PSDb003670;
        Mon, 6 Jun 2022 12:39:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=mzoLE1PbtRsuOiEM9z9fQ5vpTZBc7ax0h8g634BqWUw=;
 b=qojsxE3/eqexqnP11dCmtR2McvQCDFYa9hrijZqF31Gir1vrGUG7Quz+6fLcznaFikea
 a6lRt4gsbmwnZQMfRQV6ydvFV2uvoK5v43jHpor1PkHyQ29OK8NKIhPI8lolw5wzW5ah
 q5/oi0iGU3J8FovP0DyWHPRY4gTwpb+v1O9xpd/6jnLDnIDGqGHPgHq18pkwUpZBdHys
 1cPNYqa+1Hw7LyUrRfAqzm01wSu7XTVG6ptzeoATSyoM2pnipNTwp9P091E55YSqjfes
 pe0gwTv9Q/YEh7+I/mXzMT/WSQWIigv0TkPEtnzq7ULR/jmfZyEH82/6sA6Af2vYOiz0 NA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ghexe8btc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jun 2022 12:39:05 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 256CGDh5005066;
        Mon, 6 Jun 2022 12:39:05 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gfwu7m6tb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jun 2022 12:39:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R9s/uBwOHFtQhXJhjnszTSAXK+ooDS818BKEy/NJIm4H1cNJP+4QbderqCeAC7NguncE38XKTCGYxq1Vc7sIHOI747uv7rwskYdfTu9+3L5tPcuhHj7q6aJu8kqqGsJkHfoU5Nb7uYfEXA57qcAiLFmwYvTS2tGI7v0adhnhu3zA2TIOq1efwSdzJaKzT6dgOYprVEAhfsg0lqilu0lizY48DaMkP1pW8f5a2GNbzRB//ilAQ7D48M7Zwqcxpz/Bezkur490VhPIL1hvxsgo1GXXpsvsHDDbNAnDEC9NmhGIyriuDf5W6SL6jQa41YkDx1jL0Wn6lmBZIaNHvdWD8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mzoLE1PbtRsuOiEM9z9fQ5vpTZBc7ax0h8g634BqWUw=;
 b=bw1YWi/xCMQGWqKXNpPg0b6j10ZEFS4exLSxTAmtZLDEmHN/QfhuWu5KzzHQpH5O9W7pCZqQmp1RvGeHMM52aCjuJfZAwdXrOk+yZiyAVsiyjsHkiZp56jVuATA2MIdLNk7AUeAh9H7HUGR6wT34naLUj4ny+WjZmcOc1cyOabgonBxEMxh/mDxtlgbE/20Ltuvn4BgmNlthJDllMcOcFV5z7Zb8ihVTlEFLACkYlMgnWyJ2R35VgZWh4pE8mrac17wXgDdGD0ypM2D4vl0By7KFtmxKa2a81pPrwGZsl68xDtobA4F1bXXeVMAZRAdG1HfMN7D/ML7bxxvXKal9BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mzoLE1PbtRsuOiEM9z9fQ5vpTZBc7ax0h8g634BqWUw=;
 b=LQnna/k/X+YUSppwnuZEE9PCs0z/fJtRt8PkHLn5UFmmpA7VUtVwCI+ITXdFSZkcHEL/KzJCe+bYk8omP9ElsCJtRedBlf0AReoBIIb3Hbu9pHYM+T75Zz6Gmk9RUYL6V4TwShPaK5gCwpct12MWQXGrxB42ttR3IEGG4DWAwvU=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BL0PR10MB2771.namprd10.prod.outlook.com
 (2603:10b6:208:7b::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.15; Mon, 6 Jun
 2022 12:39:02 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 12:39:02 +0000
Date:   Mon, 6 Jun 2022 15:38:39 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        syzbot <syzbot+dd3c97de244683533381@syzkaller.appspotmail.com>,
        hdanton@sina.com, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com,
        rafael@kernel.org, rjw@rjwysocki.net,
        syzkaller-bugs@googlegroups.com, linux-usb@vger.kernel.org
Subject: Re: [syzbot] general protection fault in __device_attach
Message-ID: <20220606123839.GW2146@kadam>
References: <000000000000bb7f1c05da29b601@google.com>
 <00000000000010b7d305e08837c8@google.com>
 <YpnqpMYcokTwCB6u@smile.fi.intel.com>
 <Ypor265BTdnmgwpM@rowland.harvard.edu>
 <YpouRmanvCQeKA3S@kroah.com>
 <Ypow1LRZ3Hau36ci@rowland.harvard.edu>
 <Ypoyy/stICFdHauR@kroah.com>
 <CACT4Y+bBWrLRwiowaWk8o4+XAtCHxxJiEQfiSkgM3BDut9atAw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+bBWrLRwiowaWk8o4+XAtCHxxJiEQfiSkgM3BDut9atAw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0004.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::16)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 223c68ac-a1a6-4e45-8b37-08da47b988c7
X-MS-TrafficTypeDiagnostic: BL0PR10MB2771:EE_
X-Microsoft-Antispam-PRVS: <BL0PR10MB27712A01833A9A4EA08D82298EA29@BL0PR10MB2771.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kVUFdzJG21l+ndYERKoh+h+Z09O60YAcPP3IJ0Sy6ukS9URn3H4rgtv/0tSO/VeQtifzuOKklqKQXosJs3K2mX7CBfePq8qVotkUhLS7xq59AV8l4Bi2mxYSGnIk5MEJaezJ2I283Wp4C8UNPjk6iwed3rrzvMFrfansFmHGK0GrP/wO9gwDBaC06W050LUzOko2kqglFLSZKDViYK0x8/zAP+I2mDIPUaBC+6oE/c4NueGh0B7jvWeI9LsrsnqJxZSFE3/Z1FfrxjJB6aO7JANUNUvf/9e5tfKCBI72BmfDxzY14FnZw+/piBC7YWDQdWuJG7eE8CrG/oQlhXpotG2+hxYdAuDJOQ41EnDILEFX2T1cXqEOR88gnrvFWMWvOrhMEDrLsATs3f+D3F+xgpknqdxrNxOPai2l4m0M4+c8EvnNTdhKBQZ54cu+Bl6qltsG4qk2ZtPiwUm7whHaO6yMS0sev1gfPW3W9QMPy6fiCJtQZdCCKidsspyGf8fsVCN6QNDfIWdKXl/vJWl6/ExTffQLzqocGPF4qCxQmiy0zLMw8mP5SWqZc+BPCdfQ85dG8bsV2U47NOprdAUsZXXB2Jvu0hiQhtwo68UXDLY0dmgrtkkfS7UvJvfUcIji71cAuR3XohXnZTHNsiUKueoSawunK+VGIFSXjjTWd/01BKRIpCsg+QRJ8WZx2lZ1pu4VITqBnE1ynhr48J0rtZQkZyvqaCQkAf5SjpSt51XkoKR5YYJrYai8Jwu9vTS9kRx4OxKOB8wWPcKfAxUmAIQPPOSYgUIBcCvD7GajisE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(8936002)(7416002)(6506007)(66946007)(66556008)(9686003)(4744005)(186003)(38100700002)(1076003)(6666004)(508600001)(966005)(44832011)(6512007)(26005)(5660300002)(38350700002)(6486002)(4326008)(54906003)(8676002)(316002)(66476007)(2906002)(6916009)(86362001)(33656002)(52116002)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P3E/zmTKKU61ALlh9qq53cK+KsxLXu010Jnhsc+UsFG0yzRfKidpPnGgOGYt?=
 =?us-ascii?Q?1Js0hN6euCcE7uc4uSjj2fj1c8BYkZY3Wf0r6CgQDMiyqA/0eMCNgpwPsdnR?=
 =?us-ascii?Q?l7jNZWhyLY5GBMtAEMMuY/onWXYo6zHMSkOQij7OypdWiqww8cwYSuFX1gYT?=
 =?us-ascii?Q?xAhEcA6nR+8tPvbzlXQicMtxxSezIstvRMdSMOq5qawzArepb49Y0u6zZp5Y?=
 =?us-ascii?Q?Dn7JVIj1h2sVDeLWLS/a9A2Q9c1Y7P2AIbu3ZsdhmW4VF0qwmTblION4xwoC?=
 =?us-ascii?Q?qBVed5WkVz8j6yrvEzdtiv8eaCPJTYKoWbB+PFkO/ZwgjBYAULXc1unYZILl?=
 =?us-ascii?Q?6wWRUTxQME1AB0io8M9ah7BJjsakSvBbvs+gJzOmS3I3xiAr9xYvY0nicAWK?=
 =?us-ascii?Q?PACrmdkZJTwCmEXWfe3DNRBwmLjtgBdBCGZ8rs6/YgLAQCfDIJ9P+a9I2sDp?=
 =?us-ascii?Q?fVnBqXg2Hwe45Pq/NtZkM4Tu0ojTQwuNvHDqweBtIYirQZH6UCsiDqIZbByJ?=
 =?us-ascii?Q?+G3bjEOUaPK+MhdDj6D/QZ/2scZx22s2wixRKdf6WQIuEjNO3K9WxREEKPHV?=
 =?us-ascii?Q?+FToc3j5Y/QStlsQDsU6m3IK8zyvLzWNpsw9ll7U52k/ri274j0uJQ+jb0GS?=
 =?us-ascii?Q?tXn2rE+yjvH0wLKdT+DKj0+rhOwuWiDkbpbnCDrI6ESAjNsdV1XE0HRcrg5r?=
 =?us-ascii?Q?Y3bA2aBSoDHk/l4dSaBhaXQAJBMsrmJGm0WhXDjSrxWNa6/iQ7XzAW/nSV0D?=
 =?us-ascii?Q?Q0BtW8D7K9zRdh+fKzZY+MeY9FoN2IWKv7XQJv3F3Msf7NxBmh9/AuAcbw37?=
 =?us-ascii?Q?hrOF1zIqMZQ8AWoo0JdZZK+w8NK+fTwfsef7cIvzTFYGbRTp+7kI9u4zISyr?=
 =?us-ascii?Q?H1XvbCVq8mtwHpmbLHxb8Jmx8iZu02J+K16epAOkb0wBejIin87sqlDBmsR4?=
 =?us-ascii?Q?HYAcoeFEV6jhBc/BJOcEJ8VZe66kPRX6fDKD4+NOMW67f8U8k4Km2UF6hz4b?=
 =?us-ascii?Q?pBwBavyw1BcF3jWVGNnWM1B6LijqtqK/II92AarKCz6H5UG/iO4O5vMYD7uJ?=
 =?us-ascii?Q?wHmsG/YFvBlIxYM7LnHS5aBfNnTAIUACmfIDGISNMTt2xIrfa+5J0TWAE3k6?=
 =?us-ascii?Q?/yOErUda8gE5yXaSKDg1Fy6qSAMcbQ0R4a74xxw146vroduRCBAuXwjFbNsF?=
 =?us-ascii?Q?FaynI47vap0x+xs/5Dw/t0FKpm91P92/xNADSxxNdO7vpc9JjiuyG+pQUX5+?=
 =?us-ascii?Q?Aycx9A7TRp3zOgTFRvFBWcBlBifWYnr4fBYe+53rB/S2P3gTPvgRgtHPjC/0?=
 =?us-ascii?Q?HF1H9cYIs0r86NIivUfRviUikgz3FfEaa3kE3ZFD1yZ63ICSUySnppQdm90m?=
 =?us-ascii?Q?rHdh+SYf3EuUvPGWsxdLjSUoWZnfXMeNBSzxGwmHf6WrR1aVwZN7YTcYJlJf?=
 =?us-ascii?Q?HgTTSj+jYcmvH6JVmTZdpq8P4jW9prj6bR1536jIcoy9QR2uQQdGZ5Q1c3iG?=
 =?us-ascii?Q?wQI7cc36GE1vIbQFW8xv2zGFb1AnP/htVZhrH3AAsz3OOjIr3byRcBA3xqde?=
 =?us-ascii?Q?FE7GcmFcwks1KyhdO1DF3kck59ulo6IiA45mX9RIiUlfOWe8fQEe40odb49G?=
 =?us-ascii?Q?Y/bswzfer82Qvtvdtmj0OQsR/67pE3uH6obNV+DCesrGsprVu6LI6u0iv7Ad?=
 =?us-ascii?Q?nEX1w/9wiKE91w5MhJfUbu3lH+HBNOvR058oQWgus8lpKvcEPrm+rHOJjQyL?=
 =?us-ascii?Q?ArxfHa4Hyif9TiBRlT5SxcBBWdc1Yj4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 223c68ac-a1a6-4e45-8b37-08da47b988c7
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 12:39:02.5333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BCu1+G0di9Z8Lt7xFCK5nwVyIz3D1O7uUQ7V3kDX7TEAa8eu77nadxfcxXwBZCF3JO3GB9Yu5z14IMUoFvD6Kxb/EZsUh6VIW4XM06yaVHE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2771
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-06_04:2022-06-02,2022-06-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206060057
X-Proofpoint-GUID: US79jBR1Okx6VGFzX-oFqaIeMf7ecGb1
X-Proofpoint-ORIG-GUID: US79jBR1Okx6VGFzX-oFqaIeMf7ecGb1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 04, 2022 at 10:32:46AM +0200, 'Dmitry Vyukov' via syzkaller-bugs wrote:
> On Fri, 3 Jun 2022 at 18:12, Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > But again, is this a "real and able to be triggered from userspace"
> > problem, or just fault-injection-induced?
> 
> Then this is something to fix in the fault injection subsystem.
> Testing systems shouldn't be reporting false positives.
> What allocations cannot fail in real life? Is it <=page_size?
> 

Apparently in 2014, anything less than *EIGHT?!!* pages succeeded!

https://lwn.net/Articles/627419/

I have been on the look out since that article and never seen anyone
mention it changing.  I think we should ignore that and say that
anything over PAGE_SIZE can fail.  Possibly we could go smaller than
PAGE_SIZE...

regards,
dan carpenter

