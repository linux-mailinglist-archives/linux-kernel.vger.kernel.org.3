Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD8B4F1734
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378043AbiDDOkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377571AbiDDOiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:38:07 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868423F319
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:36:03 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234DiQjD000758;
        Mon, 4 Apr 2022 14:35:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=CdpO/7whJBwmvpBvPFUXwH5jsekHK7IMju6nxYzYYKU=;
 b=Q96rfpc9vGWbBFfihQw5Jtqu5t3KSsls5G/GvCwzfjYUuZ32BZUx/aXMlJNWFIpCTqep
 84d1qRL97BIXl6GqqTKn/w4upV4FesXbSvqdzcOCFV/LAPefiuz8F3CV55wQtalqvU7Y
 4ES2hqhD14dKkek5+kVUECHcQbHuGn736lLw3Sj7c7j2qiHwQfDi7ylsqj04QYQIxxih
 cIvP4BLDA/rv265DhplGdSb6EVyAcXYFuyIeDyW5iMAj9q3ZczOK5CSDRC2441r+5t6l
 XxvaRr/ux/bJFcMJ/YBZK80kStfSXsOhqPBqpV8LvRxIHfz5FqlB73knVNvCfK+aeDI9 2A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6e3skbk5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:35:56 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 234EGij5012762;
        Mon, 4 Apr 2022 14:35:55 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f6cx2h2yj-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:35:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R96sgkeMR0W1kaP+ODgxZy9DlyEb0CTfz5iDsBgWS+JVc/Dg/9o+lxAyi/uzkekues886B6yhkWUabGaffOkEKEzr5/Li7LScbvg4VB49GNs12Bxy/Ofz6rh7y2CcXpxJY0iseRTuBHeR1bKfBtaHa5CbKY8GavqE/c5iFXzrT1C6tPE6XQkBaK58wBACtnuPaQPlEdSjQhdqfq/hVtAez2PMarB8Q5TG0h7ju+oXI2nniC+8CrNCdVhmVpiEcUZFJDRsTxaNSkkGgQjWqzVsBI0QCfyumKSbRGgGJPFC3ug5n+0fLZ3BH/r6pVtDd+Mns/C/a2pThQbK9fjZLDbmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CdpO/7whJBwmvpBvPFUXwH5jsekHK7IMju6nxYzYYKU=;
 b=HFTnm9yjzvuBs9TLZMsRjozer6WOAgcTbElPrbiR73x2ccSPt3cjslGCe6E0mPiddjaO/uhyv7TwCS/A9MgKK8nAN2BBY4fi9Bl/ECUgHXJs8ucwSWn9Zi11e69+vYoPqGaWI3BLa0w5GnAIiKZMGqfCu35/3QHxkMQZ2Q0Wj+ZPJFV5I1WXEILSrwElQu7uFe3mSDDYUAml4pXLkE4wGKj3P45GqWfiJmxsma3xgfuMypunRCj3jeK+t+sVai22V9a7gl5qz73oyU7dZKhBxYufNhbZyVoq49ttcs77tiAObf4/et18BWDFiMgx642zUjSwGap00LM3g5YrctPB2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CdpO/7whJBwmvpBvPFUXwH5jsekHK7IMju6nxYzYYKU=;
 b=IZreXhWqjQY7EO2V48zm6wFMnqnCTZVxxORdoNSypQjIe1ymiMgmpb36yIC4jNJlr6alO+YpmHLceP2n+TGEMgXltWoVS7TIp7754JSNwLI6n8tFdDWsitQlIahbfja9WxvW07zlPnqBViJeRvROzgeH5OX/15yaHRfqeQbYUZs=
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32) by BN8PR10MB3250.namprd10.prod.outlook.com
 (2603:10b6:408:cb::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 14:35:54 +0000
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::ddcf:9371:2380:d00f]) by CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::ddcf:9371:2380:d00f%7]) with mapi id 15.20.5123.030; Mon, 4 Apr 2022
 14:35:53 +0000
Date:   Mon, 4 Apr 2022 17:35:31 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Charlie Sands <sandsch@northvilleschools.net>,
        gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, paskripkin@gmail.com
Subject: Re: [PATCH V2] Fix unsafe memory access by memcmp
Message-ID: <20220404143531.GE3293@kadam>
References: <YkpdVyuQguGzPSNE@sckzor-linux.localdomain>
 <4729027.31r3eYUQgx@leap>
 <20220404120332.GY3293@kadam>
 <1890716.PYKUYFuaPT@leap>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1890716.PYKUYFuaPT@leap>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0007.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::19)
 To CY4PR1001MB2358.namprd10.prod.outlook.com (2603:10b6:910:4a::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c34f9af3-7b5a-4318-b778-08da16486c5c
X-MS-TrafficTypeDiagnostic: BN8PR10MB3250:EE_
X-Microsoft-Antispam-PRVS: <BN8PR10MB32502E171F9228CF3A5CCC3E8EE59@BN8PR10MB3250.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mD4GNSRg2LEyuXcZwc0k+klwTvxc+bA1Bk5WZbVFuqHQRQgrf3x698N8/+cLLzSFjjKeymODZNPOzAprM5RPlpGFLz0AsHmnlbTqKwMQ3nXtNFeS1WAfhROLHM1AO9rgWDbmF5h0mjFjwT6sr6zZV+FTReHBGjh6fJ0+h7Y4bsVCMoRcSPM0YPKJ3UQ6ziv6uLRZXvWJxEeaR+opvFeAH+liOZVpCYaJy9ZPSalkxLXdozWz9T701sMEGV8kzu0d4ioKgD47UiRDLjMXvG+hO6ex7qHO+6heb/1/ep2tDCrRlC3TgVVNSjWGM/Myrr408jlWYG7VTlRK4yYYLQeK8WBJANQCUv+GXWGsLISL+kou/uCn08FUa5ub5EcPfeqLsBNlfYKxgrvXX50MmjAe5j5zfmXtFaBhnshekcgbU+3ZJPmbMY5FLnfDQWDGZ2bbXxl+I132YF1eq1V7JoYZYtao2xbn1zJe0o5xb9qvx5QslfxqFTRWv8KCInCKPnKnr2okV+VO3g/T/I/1EuYRrSnv6LRRj4FR1fpElqa4PurupyeT8Uy51ZEGv//JeSECeRMYvg/zWbLf0xxypQ3Klf2UrdNTNWOM81wXXx8a4bdHZiRAR4I575Rf1UIFuBdPV/nGkCb5w1LkVX4cmaPOt0ZThPuT6s4GtED9f5fDQKO+Q2bNfcG2kqkrvZ07crsVX7safj05N/SCEPyMsOXSIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2358.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(44832011)(33716001)(33656002)(38350700002)(38100700002)(508600001)(8936002)(5660300002)(1076003)(86362001)(186003)(83380400001)(6916009)(66946007)(26005)(6666004)(6512007)(6506007)(316002)(66556008)(66476007)(2906002)(9686003)(52116002)(4326008)(6486002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?swfSJEUo0Q5mJgSGDihBgNYN42GgZn8h0KsXRMj/5PnSZKayXgQy5GVbK/g6?=
 =?us-ascii?Q?nVrppriWN05phBNof0L0pym1cfDcto8IWDtQg7Oxd3oOcCLmOuivxGkAzh+a?=
 =?us-ascii?Q?D7AZHEAgEMvzmD+rCDbWGAdMo92zF7az8/VZfS0S7PmvlD+twbkTUJdBEUJQ?=
 =?us-ascii?Q?cPAhMjtDHg6i7SFoAhkVKT+Xt6VY4Ob4IjQ6daZWBvnE07YC+fIKnR6XAK3C?=
 =?us-ascii?Q?hcItaAdzyUtVrDlL54rk/VagrVXs7LZ+vPT2ttUwwcF28Fo0eqU0FAh2TlRj?=
 =?us-ascii?Q?lu3LsgcIKJoaIZAOmzz+oINf+KByHipthctaPaYFWnF3qzrGbv+i+BhlxhzJ?=
 =?us-ascii?Q?rlsibcLrnY9jESydd/egs6K9vYHVO/oWvPiO2QZcsMX23vkHlfx43rMb7Mbv?=
 =?us-ascii?Q?OERJqbuUGZAZ7n8U8Gq2pVbejuhX6i48RS7N0i53nQV/EwsVAMCo0BGJ7F7V?=
 =?us-ascii?Q?axXm3XMTz/daBIqYZox3cKc3cKnh3Ar2HyjfOOJR5+SwFHHGoXPhvgrMZYLO?=
 =?us-ascii?Q?PAPgOjvQrLzYluzBGXHAPVYjRFMAQ6LAJiRl8w3uNi2IzC9wsVlZpH7FUOyT?=
 =?us-ascii?Q?mDJ996i8STryaDhdPQnaPI/0zOmQ9CvZiWmKrZcIRI8AVfDgQtHsfAHwJCuU?=
 =?us-ascii?Q?7hP46CSiDAxM6zfIk/0J2g6Q+OaRCo/ytjI4VFwRow5YADoUrGzrmzJYUmMK?=
 =?us-ascii?Q?fTL5onAH1SeEj3KmU22FTBcgZNSyl0tEagSGZ5pOokmQ7j7yg+agJPtTvRaN?=
 =?us-ascii?Q?m1lr0s0CBS7i0SOV3iB3t9/dg/tFc7eU91Xu6sbL4CrTmnPpQuWmvgrdT/sb?=
 =?us-ascii?Q?AHTyApwAq9vtdjftEgeNCH5MAlFZ/XT+bM7t/lLBwWoWxBdir027y1SOEEic?=
 =?us-ascii?Q?4jqf2be5U+5HGQ44IEnYYiyFfX++AZOa7G+qhbzq20T7t/mEM0dJRYr3TPC4?=
 =?us-ascii?Q?RDRcPbbGe+yZfd4Xg27BEkerQh1R0dP6HZbGBSr4YjjYs3ztZIPUFKjdurfn?=
 =?us-ascii?Q?fgu2u2P5BrVcyChXKoZwaCJsEKsst22PZKmSv7jmxvfiAerKcGHMZ1H1FZFL?=
 =?us-ascii?Q?6Cw8bWoqmygF6KJ7QCME2qixkM/beaIfW4I/K5y4/BtbsoQ2UODsV16uYE3S?=
 =?us-ascii?Q?CPCh40rp5O8bDQvMT/4u/OfSnOzk10MlLHbQUZWAkAEIilhxveBhY1z8KwMp?=
 =?us-ascii?Q?FT+axO01PPOtYEEaGwRLXDrmFHiEI6GEQqcQxoUUr0F9S/N057lqIGCyk+VG?=
 =?us-ascii?Q?1NgZUNifUspqLvlZZH2XEd7Xmf9b2SsJ0m46nf/kew8LIsOBlHBEz1UsoEMa?=
 =?us-ascii?Q?JXMVOtHPJPOy6+0Nk8p+IMEq2gfWQc1sm+5PUe64MmAOxFC4GIt3VpPSnpGd?=
 =?us-ascii?Q?znv3xBLhN+UjunfoBEiLbgYZp0ANULvywlvG3OKAfu2215bvrDNy32K1xaJ9?=
 =?us-ascii?Q?DNgwfp9FA24ac7QyXI/IyZ6+hUeZ/lD76FV7xGXk3/t5ZA1jKOzE8PKoR3Dg?=
 =?us-ascii?Q?AVoZ6AXhUzYOjrAaBKrZFjYG2H4Ys+3bSJHxphRfvuSWO61EcEuisLVi9Qke?=
 =?us-ascii?Q?xBUn5551Wx+4dqYhNjgcIPk/bVrMCy7+tL2kqswHaekmUw8YDfFwQLZEb9Q3?=
 =?us-ascii?Q?8zcmq4tX0PiIp4aJChTXlBtzx2I8ZYddjHlEJUSP3JGVfZf4ZDVZnVm2lFPy?=
 =?us-ascii?Q?MGONQ5osEYEFfIzXppHnuhFX1+pPU/91RBOyT4hD34HCgNo3BPd40Iqv9QXt?=
 =?us-ascii?Q?VAPXIWMnAgeTK/pjSFpj2dQNajkazTA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c34f9af3-7b5a-4318-b778-08da16486c5c
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2358.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 14:35:53.9068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rwJDt/9T+C5WqxXfX5MofJ4AMsOJBQN7MvgFYFekLiN8NeX6psJe9zhZJ/gw1LTQ9i9sqmiyqXSDTuN9rcEPuJiCRDYitaliL5RTxhl/m20=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3250
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-04_05:2022-03-30,2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204040082
X-Proofpoint-ORIG-GUID: M0ERy4Bi8M5h8xz_n8aJkJWfE4KKaOQY
X-Proofpoint-GUID: M0ERy4Bi8M5h8xz_n8aJkJWfE4KKaOQY
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2022 at 04:29:48PM +0200, Fabio M. De Francesco wrote:
> On luned? 4 aprile 2022 14:03:32 CEST Dan Carpenter wrote:
> > On Mon, Apr 04, 2022 at 01:25:37PM +0200, Fabio M. De Francesco wrote:
> > > On luned? 4 aprile 2022 12:50:41 CEST Dan Carpenter wrote:
> > > > On Sun, Apr 03, 2022 at 10:52:07PM -0400, Charlie Sands wrote:
> > > > > This patch fixes sparse warnings about the memcmp function unsafely
> > > > > accessing userspace memory without first copying it to kernel space.
> > > > > 
> > > > > Signed-off-by: Charlie Sands <sandsch@northvilleschools.net>
> > > > > ---
> > > > > 
> > > > > V2: Fixed checkpatch.pl warning and changed variable name as suggested
> > > > > by Greg K. H. and improved error checking on the "copy_from_user" function as
> > > > > suggested by Pavel Skripkin.
> > > > > 
> > > > >  drivers/staging/r8188eu/os_dep/ioctl_linux.c | 21 ++++++++++++--------
> > > > >  1 file changed, 13 insertions(+), 8 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> > > > > index 7df213856d66..4b4eec2bde96 100644
> > > > > --- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> > > > > +++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> > > > > @@ -3233,23 +3233,28 @@ static int rtw_p2p_get(struct net_device *dev,
> > > > >  			       struct iw_request_info *info,
> > > > >  			       union iwreq_data *wrqu, char *extra)
> > > > >  {
> > > > > -	if (!memcmp(wrqu->data.pointer, "status", 6)) {
> > > > > +	char wrqu_data[9];
> > > > > +
> > > > > +	if (copy_from_user(wrqu_data, wrqu->data.pointer, 9) != 0)
> > > > > +		return 0;
> > > > 
> > > > return -EFAULT;  We can't assume that that user wants to copy 9 bytes
> > > > especially when they're passing a 4 character + NUL string.
> > > > 
> > > > This is a custom ioctl.  Called from ioctl_private_iw_point().
> > > > 
> > > > I think if you try to dereference a user pointer like this then it will
> > > > cause a crash, right?  So that means no one has ever tested or used this
> > > > code and we hopefully we can just delete it?
> > > 
> > > After a quick look, I'm pretty confident that we can also delete 
> > > rtw_p2p_get2() and rtw_p2p_set() unless I'm overlooking something.
> > 
> > What are the problems with rtw_p2p_get2() and rtw_p2p_set()?
> > 
> > regards,
> > dan carpenter
> > 
> Is it safe to access user space pointers without using proper helpers? 

No.

> In those cases I mean: is it safe without using copy_from_user()?

Correct.  You need to use copy_from_user().

> 
> As I said, perhaps I'm overlooking something. However my conclusions 
> follow by your own argument.
> 
> If I understand what you wrote, you asked to delete rtw_p2p_get()
> because it looks like nobody "has ever tested or used this code".
> 
> rtw_p2p_get2() and rtw_p2p_set() use the same pattern of rtw_p2p_get()
> when they access user space without using the proper helpers.

Those functions use "extra" which is a kernel pointer.  Which user
pointer do they use?  Sparse doesn't detect it.

regards,
dan carpenter
