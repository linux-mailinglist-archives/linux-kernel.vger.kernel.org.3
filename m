Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4CA5A371F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 13:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233883AbiH0K7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 06:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiH0K7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 06:59:51 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA8610B7
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 03:59:46 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27R1ht25006665;
        Sat, 27 Aug 2022 10:59:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=D5IH0fkM0m87nFUzNns8ei7BbEM64lcrROBJApaFmJ8=;
 b=hDllTq4+jo50b4zuRnH/xzbSXS1neeDfx3YS3MG0Bkoxgp9dhG6XClu3FjFUNYVld31t
 sCBZURn5xdnb01Ez8uGWhPs1l7k8ap9M56AZrPakVU5VYRtjntoBapKSwWYoIuX7d7mT
 gVd0vCTDcNN0I030rzj+g+w4bUMBG2qEJFXdYVNnxR+jFyVfRLoAEGvHnsUxpErayZez
 nfoKYdS98mnW2xrf/VLENwshlaSUbnK+3RH0ekntzStaODCKHcSb/tzhb9NbS6sSZuxM
 4N/HYK/DNeX2qlNh88+ZyNCVmS73+5RJ5LDRrDC+elbeGfngMW/sZ6M35RNWZe5kRKBR aQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j79v0gfcj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 27 Aug 2022 10:59:10 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27R7YMLo034090;
        Sat, 27 Aug 2022 10:59:07 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j79q01tux-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 27 Aug 2022 10:59:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=etKCk4As1CoUK3rXntYY1u6YlsYhzqPaCW8Dcn8T8bsNLrkjuDaxUn1Jvkm31rHO0SG3As3xNUGBdcnkIS4XrS7OzGX4oFZ1luyrFDe2ycqvY7cf01GyWaZ3aUUFni2VWEwjp7tB5mCyPCE+Fa2oVAitBpJGHvEzI7eEV5VSVAkJg3Br8J88KI12sLrWqFbnnjplrO5gWwLNfSbHMbJnUwIcTmslU+biDL3+NpPxivlyqsnWEqQdVBdE/Kgnumfj8U0YOejMt+wv3xqq6rTp9vfKs4kfiPMFGtbbimBEptFa8ECFHMxWH9TE0d8SMu22lZY5gBX1tu80C5IqDTwS6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D5IH0fkM0m87nFUzNns8ei7BbEM64lcrROBJApaFmJ8=;
 b=WpI1KLuS9XCRL0H4dmGK/24bG2nCx3SCnB0IU39nwssjM+gm4LExgQ2I1KbroEBa9ENB0Zo1/4xMXbmvz1Zn8bSKHCq1uzVcrtlTlSHLJUTb5oUApn6CahVb/kSTzlp7r+zC03jLQsueZjhold5z+72QPxAimIhVbMrdH0uPg+wrOLk78uXPyw7WeDuYWjaO4vrVzW+g/z5ISUXYU2fhcL3eS0urKwOdLUfG7Piabg2kKRP1ehuvzkDp/8QMi4VTgEYA/ogmm93Yk8OCOzeOK0P7PIfZXOKI5sPT/h2JmatKShX2X9V97tOa1mb10VDqchADC4H+OZEgU60E8aZz4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D5IH0fkM0m87nFUzNns8ei7BbEM64lcrROBJApaFmJ8=;
 b=uyzYwpYtax+bGrw0PMTITIigS4K/RlIiolXx9GIOKG2x1680GkTpheLusHw8/jpFGmk2UAojdI1fVL/Gb9pVCU0eBJOXfL3WOlOOdZrCut27NJ/auADUOpKxwVWf9CyePN86qQBWQEQAicYuPgPi+aOw0ObYsBkj09KCM0j+G9U=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by PH7PR10MB6380.namprd10.prod.outlook.com
 (2603:10b6:510:1aa::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.16; Sat, 27 Aug
 2022 10:59:05 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5566.016; Sat, 27 Aug 2022
 10:59:04 +0000
Date:   Sat, 27 Aug 2022 13:58:42 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Hawkins Jiawei <yin31149@gmail.com>
Cc:     akpm@linux-foundation.org, anton@tuxera.com,
        chenxiaosong2@huawei.com, linux-kernel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net,
        syzbot+5f8dcabe4a3b2c51c607@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] ntfs: change check order in ntfs_attr_find
Message-ID: <20220827105842.GM2030@kadam>
References: <20220827064217.GK2030@kadam>
 <20220827090230.3287-1-yin31149@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220827090230.3287-1-yin31149@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0048.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::36)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c934454-4557-41db-a291-08da881b2807
X-MS-TrafficTypeDiagnostic: PH7PR10MB6380:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WagHWTOp4PU6GE8567L3pcZB1JyKxJ5z9SqHSMBQHmrFTSIHwaoR+dDYtm7ROVWsB8X/2r6pFSa5I6NZvMXpNhBAYkbbXnGjoFo9eoON6vnmzRpW3ITQI2511UgkvnsTzspufcioLEOY9TnQl6xJ3bdXl9lnvyK7xVJBSpBPm/PIaL0SU6wKDw4dD0DpbbSEhjnTs4zxIkbiu8RNs0oC5Fkzd4A23x9Nl/SYcZVmn0thz8OQZfwjxjhsPCMHgoHdaN7plgFCJFoEhROS5h5UOmMIdNNuEujVqPORzG7DCBFvpId6tdSqEEfBSTwXVadSVlHEY9zAX4hX49cHOnj4EdpHqCNKkCXuesmMYpgkCY0HBChJ1jAZg146OWl9L7IxzLKUUbh0TJZZAv/GD4s30HzJcyYjINLrgATC/nN2wERxRuVrdd0Kd87vI3nCSNNZT83wzbiwQJ5biCK8JqdNMDi6ZROoW799VAGiBFF2LvTw7ZCr09b1GE2ZvjC+TJUSxuEf+iUWy+ulwIsC0dLhH3Nw8heekrjNXgykSFRdi/mD4oAzyyPP5rDNXuF9/IFEzQBsO2o+WdQFmtLDxPEeMNkPqRgwCq7xpnGZFWwIl2IRBJPvxxkUSjkcF+fr/AHCtrhLYnq27tPYL78x6msE3VFZNNvjtUytX2pivoWhGNNi2crFZAuisfZjr669wWZ8Bf3X2LiGeW58igPLeB43bQ0HlQeobXZp2fssdunkGZcy+U8PaVT1kqtH4Yn5trjLSEoaLcxuqLGF+Ezc34ZYVHDWP9QEcekFYAI7lUnllSw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(136003)(39860400002)(376002)(346002)(396003)(66476007)(66556008)(8676002)(66946007)(4326008)(316002)(6916009)(33716001)(44832011)(8936002)(2906002)(5660300002)(38100700002)(38350700002)(86362001)(33656002)(6506007)(6666004)(9686003)(52116002)(6512007)(26005)(966005)(6486002)(41300700001)(478600001)(83380400001)(1076003)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AWI8iIWaqrpBaVcmbxAwP5/Eo7bmpCb2qznA+WyivY5gaOjPVeWiPGxCDI7V?=
 =?us-ascii?Q?wmX/QB6oOv8E+AuExnY30G5JAT2ehXAayrHmAplz5LfYLl5FfLKdsgS5+Rk/?=
 =?us-ascii?Q?rBeIqim9T4yfqJBSXWxpCvrg4PaF+wj8j/vY9x4cQgseKc+tXqfFC/UuBXma?=
 =?us-ascii?Q?BIeUGRCYSjCYvOtNkUzkheC5kh02gf0cyJvcBu/dmnb7EBafdEtHmGE47n7y?=
 =?us-ascii?Q?CyxbKGhEAR7tnmA3e6br8f98GK9DPPLoPHgTZYrRxOyq3oBAP4v5tjdi7vu2?=
 =?us-ascii?Q?FHISw/ltYiwSxLa8vb2o60TTEE2w1YdibcwDysc2L+OftVU2mJ4pGCHERt9z?=
 =?us-ascii?Q?Yw/kU5uCjmDYTtk/jQE2dbVnVLq9aVJyuqPivtpSlXHauUvrsu8PaQMjynH+?=
 =?us-ascii?Q?rJ/b23hkIQrSAGEptAG+iUVokXoyfsqCi8ghtJ9jN1p001Mmzd6b/HzkEE+O?=
 =?us-ascii?Q?TzVz+t/2MC6UNikUV2y/CRVmu1KFviIswsXvjUmmMp2lIE9G45b/9b3I8egW?=
 =?us-ascii?Q?dgcQQSkx6I9o873o2+VjEWQl1cIRDDTqgu4ASgJ55r3Tq2fxwEz+it3QnS/t?=
 =?us-ascii?Q?yzXjvgzf92lGDV0qs1Eud8lcBip1YbTSYVEXxBcaAyiunGIXmZIAHcJuq++Q?=
 =?us-ascii?Q?Yur7asdfIdsPqcakqiEFNbbVxTDm7ll2/FTSvU/S1x/uGk0DCblOhBRisN/W?=
 =?us-ascii?Q?xR3Owc3JQSAnKd4NYV7PA94A1tOUgvY4Z95Cd8xYYhXy/dDSh6CN+oIMrvDk?=
 =?us-ascii?Q?VTFKoXqHOJVRZaenzvtbL3BmRCctSj7vOEcrSHDWgA9cl6AJhaAxoYnmxrXV?=
 =?us-ascii?Q?h3hfPMxXz2h6qn1XzxKzLW7pEycKeKrg4LwAgVgM8gTG18lxaorQh07TJBzw?=
 =?us-ascii?Q?s4XXBbJcqedPjUzG3BoFT6s6jNwbuG+mGF1n95G55Hn3ZaurPjMQeDsMt5TN?=
 =?us-ascii?Q?ZCKzCtxeVk/ChBzzTt4UL789r+uACnkdLWhxpXHq0XUrUN9c7VK3ObfPEW9m?=
 =?us-ascii?Q?ECl0EU1zLneiquCI3dTxoX7V2mwhbV+4GEqFh2bt8xGPJ/Jw/MiQSPxiJKrs?=
 =?us-ascii?Q?lIeRFo1n1acy5xFEMJM69UMc7fi1lBwmZfRkZrv/1LGAfR+gHMG35kz5y/Ku?=
 =?us-ascii?Q?GcmysSLt2Z9l3n5X1NK1CaCHrCqhGks5ZgV40B4gewWCaiCsd1BB4iZrQsoB?=
 =?us-ascii?Q?PXvWoa2dW/Uq+A1MIS+w87bKJf2qj8kP32uEpf60HUZdfywjMUEDPYUp5rMv?=
 =?us-ascii?Q?si8rgf/V7lOJMtzLUrV0I9r/Fl4I2A0g9zABGIlIaTNxWY9afZazwt2Sr6Gb?=
 =?us-ascii?Q?li7OZUBJLBRMMySDGdbsw34EHKsE0spnVhSExy0ZDao9m5kGnmj/Kn23EyKR?=
 =?us-ascii?Q?PEWzo6RTvvGNIkod9Lm+0ynfJIjuXgjSdNv46arxZVkh0UTeqGuTc01Lyvan?=
 =?us-ascii?Q?wi8UnwGKwIBgEhHo3YEinI/yHGZPPgZrRHMi86uB+47BuoLgfZIN3iiho6lP?=
 =?us-ascii?Q?z20NcE2abDAZYv8gB1ewKfWRRSBp5pqPWpCPOUS8WqNG+KT+t/JpWZ41qJWM?=
 =?us-ascii?Q?Cj1Z1tQpU9imKeUUp51rCW0aCJSmPntlNQou9WUW?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c934454-4557-41db-a291-08da881b2807
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2022 10:59:04.8742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PEQSsYt4HkkbwKc5/3eVzp+ZYkkfKHRpS5w18zio7hJjoZKXHVaXW5XXkOrYZlorm4QDzWIzWEZPkbmWeHUuoRccXYjF21GB+2l7F9ln5uk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6380
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-27_06,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208270044
X-Proofpoint-GUID: YjOFzs67ITduo1rnd66grmru5WOvcs0B
X-Proofpoint-ORIG-GUID: YjOFzs67ITduo1rnd66grmru5WOvcs0B
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 27, 2022 at 05:02:31PM +0800, Hawkins Jiawei wrote:
> On Sat, 27 Aug 2022 at 14:42, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >
> > On Fri, Aug 26, 2022 at 11:42:32PM +0800, Hawkins Jiawei wrote:
> > > On Fri, 26 Aug 2022 at 23:15, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > > >
> > > > On Fri, Aug 26, 2022 at 08:32:57PM +0800, Hawkins Jiawei wrote:
> > > > > > syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git     master
> > > > > >
> > > > > > Looks like it is improper check order that causes this bug.
> > > > >
> > > > > Sorry for wrong command.
> > > > > #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git     master
> > > > >
> > > > > diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
> > > > > index 52615e6090e1..6480cd2d371d 100644
> > > > > --- a/fs/ntfs/attrib.c
> > > > > +++ b/fs/ntfs/attrib.c
> > > > > @@ -594,10 +594,11 @@ static int ntfs_attr_find(const ATTR_TYPE type, const ntfschar *name,
> > > > >       for (;; a = (ATTR_RECORD*)((u8*)a + le32_to_cpu(a->length))) {
> > > > >               u8 *mrec_end = (u8 *)ctx->mrec +
> > > > >                              le32_to_cpu(ctx->mrec->bytes_allocated);
> > > > > +             if ((u8*)a < (u8*)ctx->mrec || (u8*)a > mrec_end)
> > > > > +                     break;
> > > >
> > > > This definitely seems like a bug.  But your code won't build.  Syzbot
> > > > must have -Werror turned off?
> > > Hi Dan,
> > > Did you mean we should put the variable declares at the beginning of the function?
> > > (Correct me if I understand anything wrong)
> >
> > You can declare it at the beginning of the block.
> OK, I will do like that.
> 
> >
> > >
> > > >
> > > > Btw, this was in the original code, but those casts are ugly.  Ideally
> > > > there would be some way to get rid of them.  But otherwise at least
> > > > put a space after the u8.  "(u8 *)a < (u8 *)ctx->mrec".
> > > >
> > > > >               u8 *name_end = (u8 *)a + le16_to_cpu(a->name_offset) +
> > > > >                              a->name_length * sizeof(ntfschar);
> > > > > -             if ((u8*)a < (u8*)ctx->mrec || (u8*)a > mrec_end ||
> > > > > -                 name_end > mrec_end)
> > > > > +             if (name_end > mrec_end)
> > > > >                       break;
> > > >
> > > > regards,
> > > > dan carpenter
> > > So maybe I can try to refactor these codes. But I wonder if this can be
> > > done in a seperate bug
> >
> > The kernel has a strict "one thing per patch rule".  Those rules are
> > for reviewers and easier backporting.  So the trick is to write the
> > commit message to persuade the reviewer that the way you've written the
> > patch is the easiest way to review it.  So here is how I would write the
> > commit message:
> >
> > [PATCH] ntfs: fix out of bounds read in ntfs_attr_find()
> >
> > This code deferences "a" to calculate "name_end" and then it checks to
> > ensure that "a" is within bounds.  Move the bounds checks earlier and
> > add some comments to make it more clear what they're doing.  Then
> > calculate "name_end" and check that.
> >
> > (Btw, are the wrap around checks really sufficient?  It seems like it
> > could wrap to something still within the ->mrec buffer but before the
> > current entry so it would end up in a forever loop or something?)
> I am not for sure, but it seems that it is OK before.
> As for the forever loop, there is a break when a->length is 0 in the loop,
> So I think it probably would not end up in a forever loop?(Correct me if
> I am wrong)
> 

Checking for zero is not sufficient because it can wrap on 32 bit
systems.  It needs something like:

			return -ENOENT;
		len = le32_to_cpu(a->length);
		if (!len ||
		    (void *)a + len < (void *)a ||
		    (void *)a + len > mrec_end)
			break;
		if (a->type != type)
			continue;

Sort of ugly, but hopefully it gives the idea of what I'm saying.

regards,
dan carpenter

