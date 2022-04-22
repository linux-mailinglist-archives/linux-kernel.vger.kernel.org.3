Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25DAC50AFBC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 07:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbiDVF50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 01:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbiDVF5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 01:57:21 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BD04F9D0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 22:54:28 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23M0driN009567;
        Fri, 22 Apr 2022 05:54:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=0DxhaUh+pnZcpFm+U6Hs5UfuXDxIjVC2nlaKUdFMjpw=;
 b=X2RPPdUFirXgCU4NkK++GViLPzuf6D4rFapNYZA2ZiYMZqGMtgR+uEQQOe/x0WmvGDZe
 Z8f93iVE2YQN1RW3rNhplDHnSzqCKHXfjwLG8wkGQCvv4ssNwqNv0VUGiNSAzYclH2GX
 NWnHWUb2fmyNjRoSIzKgepu96aNERV7UiJbor9ekWOjfSPgp2w+0EBYJ3mAsv7o0oQwZ
 ap7M4tauJRxJI9OHY8qzlG7iZjxNxbURCjM4/bufrT1sRXE5h1ME0UaaIo1uDiItqeyD
 nqugNWTX30uhGDd3WhM055r5GtiJGYwD51isZxwz+K+m2kx7VzgYQd3XnzQhwmocBpQg SQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffndtnu32-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Apr 2022 05:54:21 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23M5ksb0003269;
        Fri, 22 Apr 2022 05:54:21 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3ffm8ag4u9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Apr 2022 05:54:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iBTvrSMvoliKbqpgsADLmeWJPsrYZwhDPsJesVSdqEyMpRGDIAYXd99FOeWM3IoJM+T+nhqTkpR+7yegAqEk5nTPDEpMclwXyqI//fs8U8yEs6TRUc/l4YIIZf3rkKkpjW4xopvZymWC3W7+BWbTgDgzyXrwtOItAZZ6Ppr9M3YIrfnKil4cBJlwnTE/mTIcw9TMfr3L5CJ1luRqPJcuIKyaj8OEZUXv14w38qR97egXsFE1T4DdTyKrmORQCWQqjVmG9jF/bJD76njJjtlZmB0xCviLUEkmmSrZFKkeX0Q34AmgbLITGuNQswWavAJPcSwyPwDJe2XHKDGI3fj/pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0DxhaUh+pnZcpFm+U6Hs5UfuXDxIjVC2nlaKUdFMjpw=;
 b=FTfALSuzo98k9e/ejkP16kHL0lewWKyoumzH7MDfPPJ9ODio9UEQdbgeE46+EeuXqJMXyTaoWjgaIDae9Ot1usjPKZBr53qH/7VFBXS1MzzbHaYg5Io1fHb5vVSCUb2xUpQh/LDmuP1C3UfH71R8h9lVlob+NE7LuWVQyw13kIq+vB2uE5gzQEWqEiyH7EmVO/BapkeCn6b/o0jL2LF3wOYcU+LxFpKWnb9xaGr6vMaCXNQB7ntTRzHnO+grKjwhHisgP+dAc9Vno03S3oOaMJuJtAZ+HKwHqoxLQ/nv7mFVS4ikiJXHNhkUIL0xbsuIaJNfK4Cg4HHVzeO/ONFZww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0DxhaUh+pnZcpFm+U6Hs5UfuXDxIjVC2nlaKUdFMjpw=;
 b=J2uW6LwoxjA349ZzphD3aoqkB0DbxHlMtFR5wxBYSnS4aUPhINwfVRkh3f1OJZir3Iv9ldahNqsB5XHOKv5HBPGcCpm6/sG2EailuwMpjy4xhTv3svihGXJDDJl+6eNQercRr7vpzcv+xVFyZiV3ooO4AtFaeVk/5CxXYddGZlY=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM5PR10MB1610.namprd10.prod.outlook.com
 (2603:10b6:4:7::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 22 Apr
 2022 05:54:18 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5164.025; Fri, 22 Apr 2022
 05:54:18 +0000
Date:   Fri, 22 Apr 2022 08:53:57 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Vihas Makwana <makvihas@gmail.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: Re: [PATCH v2 0/7] drop some unnecessary wrappers
Message-ID: <20220422055357.GE2462@kadam>
References: <20220411102136.14937-1-makvihas@gmail.com>
 <3484215.R56niFO833@leap>
 <20220412151529.GF3293@kadam>
 <3134226.AJdgDx1Vlc@leap>
 <20220413054252.GR12805@kadam>
 <CAH1kMwT0gyQNB1-j62-2ntJD9Lobsmr8-5h6n6-SJ44wykMyHQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH1kMwT0gyQNB1-j62-2ntJD9Lobsmr8-5h6n6-SJ44wykMyHQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0027.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::17)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc3e9ae2-bc7b-4943-13fa-08da24248a3f
X-MS-TrafficTypeDiagnostic: DM5PR10MB1610:EE_
X-Microsoft-Antispam-PRVS: <DM5PR10MB16105F3EA104930AE7B872198EF79@DM5PR10MB1610.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fnWilfWiFR6WBhUQ+W/vws9hWbt/VS/9HMlxy/EAtQ3os3u8qElupduzXD5BTzBvlaXzfMbNAKMPj2ds48MNePqo0RWiAqnTsUXhftMD1GTYCdPi5sjj6VFNtjvlyvsLF/3skmHdcuj3vsz7WowZEEA5U3fgAx54PIBByaw1qFuhC0fKl0bo8WmWSXwL+Dxi1ihPvHxBFSguJK5db3dZZuOu7ATE4TvbNJd3dY+EobgT50AIp2+g29mgjHg9LswOBJG/PnDNJ3SlNrrIdm0BuC+jLuJL0jYKZdBBv8Ewx8Q9zlW+PRU0Lce7xeyID3me9fZqxnNA8Nu/y3i8yyon85Zg5iNaeX6NtlBla9bVwfT/c9wH175hHZ0lb+J06eD9B1Tl5BfmUQOE9Ikpg6aLWJ6FtoLPzqvv4/Pgcj74S998cgs7qoTKzBD2yvKnfoTcGvaiYDVreVdc6to3CG4z+RajvIMYHmPa8iCpwnNidj9zaFih77UE6Tr3B/N6EluNJBQ12vSPtWwb5PotVprLz3WxTj1c84msAI+zGqhkFCaWGLjMDizz9lhU7S1WBS79j24YUmh44dYpG+HvA7j4ja4tnbywWVIl/F6TtUF4mZFpWw3c4w5TxmGck8UE4dhP4RfMnN1yg459KUrbWrSnoCgVrv9RbvbZWMb+JhZCJWIEesSsqpBjioRkL930Vju8DcAFLRaFKxWlAloiSC/SLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(86362001)(6506007)(52116002)(1076003)(33656002)(33716001)(558084003)(8936002)(316002)(54906003)(38100700002)(38350700002)(186003)(508600001)(6486002)(6512007)(9686003)(5660300002)(6666004)(26005)(66946007)(66476007)(66556008)(6916009)(4326008)(8676002)(44832011)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QBg1IHXlemHACxNcb/Cc2bGBAMbb6QDvLVJYgMssdCtCTn8igbUYDlnpkGQ/?=
 =?us-ascii?Q?uwGPzX/YOc8EWnPtmVaUpwesbWpfrl4zrvW8ZShZR4QKzSKZJ8kcArICAQ3T?=
 =?us-ascii?Q?gwl1xncd3PWaKY4DQ4rEbxsseQ9AK34IfO+4bD4vO1ADhgUORCiE7NHI35qE?=
 =?us-ascii?Q?WoP7czLXm6TPBMWvMMv8CTNGdwsJBpNqjJLAD7VJHVwV0rF/JjJnFrtlKybQ?=
 =?us-ascii?Q?en8NDLeTkImM7GBKwP3ujCvqQ/19P3+0ahaHncJeqjiO4v5QxnE1S3KaRkNR?=
 =?us-ascii?Q?iRpYlT6zOASzq3qs4PHa88AkNJju9d7x/W3c8DAvCdUmB7idpNu6XnmI73MZ?=
 =?us-ascii?Q?qlGdruyERm4ai8tBq2rvdCpx3lzuZIGdgXweTq2h7PBXdWpIblDnyGaa2MlQ?=
 =?us-ascii?Q?FZWRQ92NFlUjNwg9ihUcbJvkqq9sdvROFsFicTl8+KzhyXHgMm8oUELwGePq?=
 =?us-ascii?Q?pipdTFdBMBb2LFlvuTFhoQb1HDxTKnsAkJQIrmCmzvI7U3pKVbllNZWnBiDY?=
 =?us-ascii?Q?A3NKhDqFb/zLa9NJVynz53O1Uwg/1u5LZFn/FvGWRn2IqFNiXxz+UOmb40Jw?=
 =?us-ascii?Q?6u54ZF6A7JQ9eWDXQZXmX3mjdwJNLvF3CKlv8l2QQVX3KYiGyUBREPrLkmwC?=
 =?us-ascii?Q?b9w9FptEtjAXefEp/nbtzbxjNy9tSrP0I3wqTxWglT4EXW2TI5X9sA2BIZJA?=
 =?us-ascii?Q?SwWzuz+MOq7ax9Fb7NqEyB1KRVon1sLL/x8SsGr6ArUcjRy8TRQyH/V3NzkZ?=
 =?us-ascii?Q?1pD2jYERgJ7X5luGasjMsfhGhgWoTbeUxqwHH1i3EchKfk2Ts/kmlGvA5DHs?=
 =?us-ascii?Q?nkQ2giHL0Xfxvihu6yF9SXRom/K4SMqrjzhWieBQSIkIEgkC+xqrU1G61o74?=
 =?us-ascii?Q?8T1ULbdRX+Wb7AV09a0aOcZqex9+EkZHP7vBdKVZ8VIydU39izIYU+RWnzCi?=
 =?us-ascii?Q?DkzBhsuqCMw3mcWuqjcD8LuWr5SBmWCENvC3ThKOG7pDWF9blnjFfVK1g0zs?=
 =?us-ascii?Q?vZOJTiiyjTj5EdcEuN43rRAdpeyZ9vwTQeBiLZWVwMU+TJVf/KG7GUuBs+H3?=
 =?us-ascii?Q?ZOTveiX9ZVgDIuHtoRCuPt/6c4ndKn2nvuXzNgfNGjA8Xgm3XMWItv5oug7A?=
 =?us-ascii?Q?EbO5r8w/xlmZRiXZ5DW3++zGPCMiiqrat4JHnYCjTd8oczyyI+dgm5QL9+sZ?=
 =?us-ascii?Q?znD7tmZ/TTvBtMz6dd/J47PI1Y0MeZBSDUSxOfoHNgUeQFUdHCI8yg/sOC9q?=
 =?us-ascii?Q?P2xrN9p/lGOJZ/XzAj7z6Gk7d0qFMxMiFbag9MP3LKLLzGP7SZLEy07dJkTA?=
 =?us-ascii?Q?DTjJ0G74q7xSjfHCTcxWT4ikCgeAf75jCeKmea8l7ImytF3noXV7jAOXIBmF?=
 =?us-ascii?Q?zRnFcLVGiBETH5THCwDA1HPWJ5Hg+ylnQxdC2tBHBQxSGCNZ/7mNNghwJFmL?=
 =?us-ascii?Q?lDhpgLIXy7iFpPkGq3TS/Bq4jjT8taMzKgFffTVc7VGSJfk2svbOnkkbLKmN?=
 =?us-ascii?Q?kJUaV6tV1L2GJ34LSv8vRWbo99VVABkFP5GauUcOb3XAngxl9NazPjf/CANV?=
 =?us-ascii?Q?TMhAZvUQ5g8H/ZMN9czsHoAJfT9C3JCyJljqjiEHs7K87Y8jOidGxtlQQNCZ?=
 =?us-ascii?Q?KNEWUdaZ9WlMm5yNyKVIdmIyvLUpagwn5J/leDX6U1he2v3yqVLNdJ7NAj72?=
 =?us-ascii?Q?Z1t0i0QtDVKcaH51P62GZKLCziR8hjVjjzGDxZPAyNAmmct7vWWoRPUinpQE?=
 =?us-ascii?Q?+eu/O1iz7PmfgTuPbMyXDkuB41jbHuY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc3e9ae2-bc7b-4943-13fa-08da24248a3f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 05:54:18.5189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9UovP5Z8UEm5uUbQyBH5skB8anyXt547yjHfb6GPAF9Qy4OOvbRH3wnG8i+8YfTdAmCt4swGAesRZf4haAgcK3BfV1Me48fciR/pyKfVnEY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1610
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-22_01:2022-04-21,2022-04-22 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 suspectscore=0 mlxscore=0 spamscore=0 mlxlogscore=668 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204220025
X-Proofpoint-ORIG-GUID: TZWSZfybU480yCt53ZimOtq5rKDp8m6-
X-Proofpoint-GUID: TZWSZfybU480yCt53ZimOtq5rKDp8m6-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 12:26:21AM +0530, Vihas Makwana wrote:
> Did this patch series get lost?
> just pinging :)
> 

Wait for at least two weeks (not counting merge windows) before asking
for feedback.

regards,
dan carpenter

