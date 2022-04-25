Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A99E350E4A0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 17:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242856AbiDYPpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 11:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234777AbiDYPpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 11:45:10 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF8D38BE1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 08:42:05 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23PDT9DH027852;
        Mon, 25 Apr 2022 15:41:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=Sd/TUge6l3lSjLcovFH5ZzD4GmIUvtEUB34erOi2jeY=;
 b=tqDf9qYNk4eH1vqrKtm+BERqIy0ZYSnxJWfbeRoIT9a37Mec1hN9jEVDwfTZ8fJfR0TA
 XxrvpyxwlTIFddqqti2gRzAIh8EOFUUtUyBA5RYlW9LLeSWyPZvcAiB+qRDza8R1DhRI
 zPJ3g17yDjYABvroEBloVzM+2WIp71Vuhj2bNsAnPs7638yrK3iPlQh3fGAQ6Xm+mZeR
 8PU7IsIp9qsAGwljpigsyP7dj5CXftAZRNjnLEE0gn1yuPe+1QggQb2Qu6M+HCXJ3USP
 zCcuAIboPXgmtF2uB+nMrEgXvs/7ayU8NK3Lu88Yj8akWwKt08igPE1CRX/4A9CMp8iz Hw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb9akjt3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Apr 2022 15:41:54 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23PFe5Qt011961;
        Mon, 25 Apr 2022 15:41:53 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fm7w2r15r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Apr 2022 15:41:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ALQvjOlLQs6C/m7QrzfHHbm61ZiA5i1T75kBNxC4f/rtCqpf4HrTQuFAHhB9RosRIdGUx2yLrafiFZ1g/YI7ZUBIubfiHvVQOk+kEYwQJn/j2NE3gf4YG0mGwkBEUIs80Cms/JBSou2zD4oyUVYPlq3x4EKYTRlRsiCwvg3o3GD0Qj6Ml0Y0eFmP2HIW8AFDCw4yUXjx0tSw4yvWr/cb3Fd+bPtjHOGqDxgb2UxdCR6YJFvg3E7ypoFJBxCgAxzEmYsQ9MEezfA3Jgh9DgRbsupBM1CUSpaDZtr4Oh1gwqFx+lPcpvJ/NG6Ffm8OdnTY8hRwkmF6bz78oo1KmlY42g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sd/TUge6l3lSjLcovFH5ZzD4GmIUvtEUB34erOi2jeY=;
 b=JWDkZSbkgRUmdmcI0d4Zs8NsPJ7VPVkjME2YwL/tefjuVjN8Qst0XQ4RqRtguZGroR56nq4Y7NK/zjR5UvEGWThcGhckeBFMUQ3GY0TdG8xdMmx5BersLs9gkQRGhWliXCPIFkz4QOowDB57PcZlZVi8X7XOxploOetl00mKqMDftEieai+d+iVh9irE5W/fa3KmqIs6O6DbIkpn2U9EusW9R+bARpXiB3CHMMUzKuMCK1BbAFU8XA3FRaBEPUnRwQ3/P4YVbdMFMK53lIddyp7NkKLt1BrGWCEeRuE+BVBDMxffmb3m+MBsEs0bVEjlFBDyv8VkMJDb+Zxet5sfwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sd/TUge6l3lSjLcovFH5ZzD4GmIUvtEUB34erOi2jeY=;
 b=C7ooa8bWMaZToyb782V+qt7qU6fBzdLWs7opZklsylzl/Qg7m1iXcFnjUK/CF74TkNBU4V43uaz84pmdXOm4Y4yu5JJei7x1gVr2HB84LgTaohPjfbTzYaBe2z0spnpS5/qDShOO9+X8t5mE+qn28W8ykbf3byr19k+qpCfPpRI=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BL0PR10MB2851.namprd10.prod.outlook.com
 (2603:10b6:208:7b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Mon, 25 Apr
 2022 15:41:51 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5164.025; Mon, 25 Apr 2022
 15:41:51 +0000
Date:   Mon, 25 Apr 2022 18:41:38 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     Solomon Tan <wjsota@gmail.com>,
        Michael Straube <straube.linux@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] staging: r8188eu: KASAN: slab-out-of-bounds in
 rtw_cmd_thread
Message-ID: <20220425154138.GQ2462@kadam>
References: <67e2d10b-7f0f-9c5a-ce31-376b83ffba9e@gmail.com>
 <YmU+cqEZfrGz5XsT@ArchDesktop>
 <c2296090-2e9b-fafb-35da-e01b025b53b7@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2296090-2e9b-fafb-35da-e01b025b53b7@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0163.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:1::26) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b3b0f05-65a8-4802-f0fd-08da26d21d9e
X-MS-TrafficTypeDiagnostic: BL0PR10MB2851:EE_
X-Microsoft-Antispam-PRVS: <BL0PR10MB2851CC41E6FEC6D10B7AB4828EF89@BL0PR10MB2851.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MgAWPWtzp2UlgjR1VvlizoXV+gScAwHyCXl8j2qWKm/04Q1H72LslEHGMTqYUEeQVkSdQOu8sdrbUP7UVLw16oI9JoLx17+EuCFUc1/+Lc/MoFyIWXH1LHhwekFOATgG5DIm+7nSnq27HSaDSymKYSARlTvaaNGFYV+Yye1gKEORduQwOF5DI7Zh+l3neLx1eZX9PSuteq71SR6QgWOXAY+RzQdaSL8dD+WIw/ds/RZJTOnTR/jFt6c3kMFmxZ1wyudyTosPxB9Kp9iRMzwQ/167ZgGkoUUiVe/c2127WO5syU3rD4iFdi9E0P4nZlIW6iA+cXgkFDvLJhks/SrvKZ1IU/ejRkeI9BVs3TKoh0u+X0NSBszIGrShCUwrqupOKN/nkUAoPXPukHKs+S9+Ka9TfauZZzqElcq8SYQG2QRUza2C6/4TEni/tzPC2STrLreTt9iA2HjjTpkrOYyByiw5+uZdPRliMAfW4em7nD+x+wTOY+/UZwYMffl9gvrQIaCc+jolhcE9Sq1nb8Id02vdKwtFPuBgQ9gMcZOdKK2KL9+bDQuIL0+qFkQZH2kEbEOdZ1VxMumg8a6d2hMGAsx8bCK/sRTddGkc+O1AXP3KH0zE1SccYw8ZxfW7zKsdb1GA+UfzcywuYHPAChTJa+jfV09B5NuHjT3knB3eoiiVFCKKQTSs0a9HqmMQQppTez/3nr4MOoFKtmhzzDecyQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(83380400001)(1076003)(66476007)(54906003)(6486002)(66946007)(66556008)(5660300002)(4326008)(8676002)(316002)(6916009)(44832011)(86362001)(53546011)(52116002)(508600001)(8936002)(186003)(33716001)(38350700002)(38100700002)(6506007)(6666004)(9686003)(6512007)(26005)(33656002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LGjycM9bXL3ULKHWpAkjRL1rNRpNue9Bh1bGxdsZZznI9Dd1VCGeSWpdcycF?=
 =?us-ascii?Q?+iLai4GmepV6AamAaIFl9QQy0TC/8/1QcHsGLU8FV/j1gFDGMlcZ+ghJbIXx?=
 =?us-ascii?Q?GUYpXefcIe0oTrIKQy5MlqautfUZerD5LTwLqKQTY8MgPBvs1xdSClU+/s2H?=
 =?us-ascii?Q?hpUCno+F98KjU+JSuE8EsNrAjUrUt4E+LD6c/PGKmX42YrrgQTn7hA1IX+PZ?=
 =?us-ascii?Q?8cR4D/Z1ZMwGyqVXws0r5R3zOQL3LCMUJKSk2uQaehtyreklTypRkUYY5HLX?=
 =?us-ascii?Q?6jsW0AdgT22C2hWEti+sNkS2lNN+eN0MNbBbcFbyBkIzrRq8CKZ52+eHMMjY?=
 =?us-ascii?Q?O783Exxyuna3tOY1ijjOFBafd4OB5M4YQzJpEhJm+S+gGyazNfk6qcDY4kP9?=
 =?us-ascii?Q?BRQv+hVcxCr+nDWf6SDt8lp51PuSEHHW4jLIszgDI3RV09UDJSwoPCT8ZXKU?=
 =?us-ascii?Q?TNa2SG1B59nGYM0ahAxm4XXvBlgJ3VQKAfVc29rIyn12828ftRh0Q1Ln7ong?=
 =?us-ascii?Q?TDH1IInpL/yVpmwZdlwioLa0DYDgx15DndJ6/3mnNlT1BaaHcGfZm/a8+72H?=
 =?us-ascii?Q?FjPDUQDcbbt/XZBD8O/Mo6uaK0GRxI+MgrqyWE10bbh0ak86XnQEkKDiX6Yo?=
 =?us-ascii?Q?VhNqV4soWqTHPjZqHunm3KPFDDO+ElVtDhfYmoKvmbMuNqkgNINpo7h9BCho?=
 =?us-ascii?Q?24PloUfXBXydRWlgF7HfoDNhjZJsV3Y+Z3d7sjFrrrlGxFmTUAN0ZHEqECnV?=
 =?us-ascii?Q?+QqMr7miwG8VSLClXUCiec54JT6+A9xFKVb1XFU7fPvbxSAa7xhOgnlV6gUa?=
 =?us-ascii?Q?aefEdc4C27yTl8maUCDWamnoJgUJNRB90QJK/aoorFIpRh/SQUi19mxolfGj?=
 =?us-ascii?Q?2J4pJdh9tIYHWiLd8EktsPJ+DgumdTSxkpXfj3nKWftgrrY9oCS1R7c0oGZs?=
 =?us-ascii?Q?C27Z0KWk9JR03YpOjD418Ex8Ax8H9oSLDRErGc/TtsZlO4c/xiIx5l13Yhtm?=
 =?us-ascii?Q?p9mVZKDwmpNhfIe1jAJwUdF/NSV4cbwSaOK1/OvnfNkzNPyMyegjmsrRaY6f?=
 =?us-ascii?Q?QQok/nFZRRrNu8k5JjM1NNdUAGsDN9g9lFg2eHUhMw4Axyflnp97QHu2U29K?=
 =?us-ascii?Q?z9q2BmMPyvPvK3Py2QdmV+KZ0sQXyzLKVBdV1mzBG/d/wg/+/sM+0nYMU3mH?=
 =?us-ascii?Q?x1j/RZ2rPZ1MkRhJaWoi1YAEFqnnxCZGyxl6Lxz4Wa6MSMGQkylS6b8t9MF9?=
 =?us-ascii?Q?ymbOGcTEsphoecJXciV9l77mvu4VoBwz4QH7KzW0oygH1x1iv1HxinKnr+f5?=
 =?us-ascii?Q?HTXKvMQKfr02FGWodBmWwPMfbgrEyvnnOovM13MG+jc2I1mbbCjpYBp/X9Ll?=
 =?us-ascii?Q?MWfG2JhdysPgs1pu7h1p95FwSZIh2rGx3hPsEjsCVRNT6CHwPtCmUZ+U9XXB?=
 =?us-ascii?Q?eIkNI3nuU94trp0RGV4xkFOyhLXRn3/Pe1lt6I7xHLzgpBosxUJz2aN/U4zY?=
 =?us-ascii?Q?RtiSZTtk6v+wR9RRfLE+96OJ/rtLiYPI00SVf6WbY0K1OOon0Q1zGOedNOdK?=
 =?us-ascii?Q?wdW7Onqu6RJbfz7/qDMVaZTbLN1Oy2Ns7FsGr79FkLXje9zbAb9BgwJbWIZa?=
 =?us-ascii?Q?8oTR4Cp4pWVyRlcCP7fwWw6JxzEGyNP1kvmVL7tsVbz9B4RWfFOX7p7cxgng?=
 =?us-ascii?Q?Ij3gQ+96YzZDCoFiJy+YGZdJaljEA0k0ncMPtalqaVdzJ3Tz4sZSodvX1Fuc?=
 =?us-ascii?Q?8Nhv65i0OCqiLsfD6ho/uyZSi8ZxaM8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b3b0f05-65a8-4802-f0fd-08da26d21d9e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 15:41:51.1883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P3qT1pAU45LDKVWoZ2HHFt4MU9a2HmXZJcD1cey+qdyyjwgMYLRXkooskWU2jP5SxA7sibWOoumGOihZAN5jDvUDnSQ9RpjeifDDwCSrNgI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2851
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-25_06:2022-04-25,2022-04-25 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204250069
X-Proofpoint-ORIG-GUID: XD_NeoFxydOixGpvVROCvDC-XUQAV42B
X-Proofpoint-GUID: XD_NeoFxydOixGpvVROCvDC-XUQAV42B
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 24, 2022 at 06:06:32PM +0300, Pavel Skripkin wrote:
> Hi Solomon,
> 
> On 4/24/22 15:11, Solomon Tan wrote:
> > On Sun, Apr 24, 2022 at 12:00:12PM +0200, Michael Straube wrote:
> > > Hi,
> > > 
> > > It looks like
> > > commit 0afaa121813e ("staging: r8188eu: use in-kernel ieee channel")
> > > intoduced a. See KASAN output below.
> > > 
> > > That commit replaced the use of struct rtw_ieee80211_channel with struct
> > > ieee80211_channel.
> > > 
> > > There are several calls to memcpy that used sizeof(struct
> > > rtw_ieee80211_channel)
> > > and now use sizeof(struct ieee80211_channel) but the sizes of these two
> > > structures are not equal.
> > > 
> > 
> > Oh no. When does this issue get triggered?
> > 
> > > regards,
> > > Michael
> > > 
> > > dmesg:
> > > 
> > >  ==================================================================
> > > [  422.214237] BUG: KASAN: slab-out-of-bounds in rtw_cmd_thread+0x1e8/0x430
> > > [r8188eu]
> > > [  422.214277] Write of size 3600 at addr ffff8881e149d200 by task
> > > RTW_CMD_THREAD/2563
> > > 
> > > [  422.214289] CPU: 11 PID: 2563 Comm: RTW_CMD_THREAD Tainted: G C OE
> > > 5.18.0-rc2-staging+ #47 94e3ca73bebf5b7fec506721475e4fff2a023bb9
> > > [  422.214301] Hardware name: Gigabyte Technology Co., Ltd. B550M S2H/B550M
> > > S2H, BIOS F15a 02/16/2022
> > > [  422.214309] Call Trace:
> > > [  422.214313]  <TASK>
> > > [  422.214317]  dump_stack_lvl+0x45/0x5b
> > > [  422.214327]  print_report.cold+0x5e/0x5dc
> > > [  422.214335]  ? kasan_set_track+0x21/0x30
> > > [  422.214342]  ? kasan_set_free_info+0x20/0x40
> > > [  422.214349]  ? rtw_cmd_thread+0x1e8/0x430 [r8188eu
> > > 91924fe1575bf49b9b37985ffde2c585d847446d]
> > > [  422.214386]  kasan_report+0xab/0x120
> > > [  422.214394]  ? rtw_cmd_thread+0x1e8/0x430 [r8188eu
> > > 91924fe1575bf49b9b37985ffde2c585d847446d]
> > > [  422.214430]  kasan_check_range+0xf6/0x1d0
> > > [  422.214436]  memcpy+0x39/0x60
> > > [  422.214442]  rtw_cmd_thread+0x1e8/0x430 [r8188eu
> > > 91924fe1575bf49b9b37985ffde2c585d847446d]
> > > [  422.214479]  ? rtw_setassocsta_cmdrsp_callback+0xd0/0xd0 [r8188eu
> > > 91924fe1575bf49b9b37985ffde2c585d847446d]
> > > [  422.214516]  kthread+0x15d/0x190
> > > [  422.214523]  ? kthread_complete_and_exit+0x20/0x20
> > > [  422.214531]  ret_from_fork+0x22/0x30
> > > [  422.214540]  </TASK>
> > 
> > Sorry, I am not familiar with KASAN. How should I interpret this output?
> > I see the paragraph above has references to rtw_cmd_thread. I assume
> > that is its way of indicating that rtw_cmd_thread is the cause of the
> > problem, but the one below refers to other functions. I'm not sure where
> > I should start looking. I would start looking at `rtw_sitesurvey_cmd` and
> > `rtw_scan_ch_decision`, which call the memcpy on the
> > rtw_ieee80211_channel structure, but they are not on the call trace.
> > 
> 
> drivers/staging/r8188eu/core/rtw_cmd.c:276: memcpy() call.
> 

What git hash are you on?  Is that the line:

	memcpy(&psurveyPara->ch[i], &ch[i], sizeof(struct ieee80211_channel));

Are you sure that's the line which crashes?  According to Smatch and my
simple grep that's dead code because "ch" is always NULL.

> As Michael said the sizes of structures do not mach and the memcpy writes
> below allocated buffer.

I feel a bit bad for not spotting this in review because I was looking
for that kind of bug.  I still don't immediately spot where the bug is.

regards,
dan carpenter
