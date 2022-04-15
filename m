Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8615027D6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 12:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352068AbiDOKFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 06:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352083AbiDOKFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 06:05:11 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA5CBB0B6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 03:02:42 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23F7eD6Q031505;
        Fri, 15 Apr 2022 10:02:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=0ip8KHB0jSuJX4aJK3c5yKVUT761f1P803ApoHNEP6Q=;
 b=UG8BasRitZfGKntykOhraVsojvIjmvllfPp4QA77KqQ05uUb3InsamIKwow7onIj5umH
 uucAAsfOWa6Sw2ttsxEVeCFcQz/mBya3jvjteTexUg4/r1fIvNZVau3vh97R8Fp8DG6v
 po1VtANrTZRUnWbhh8XdUB67qfNT1cSw30EFr49XNf3dJZv1XUMUJvPu6+9B5veXJ/qv
 Wq9gZ0/cifG706L0fz/mDeYFiba2N8AuyUADTMzuSO4+jrB2E75HkD4PpXovd0JHhEvY
 AzNWgkNmCA/5c2c9XrS5mhsd3RhEv2nFkbiFI76UGd+KgpJLmzddgwDc/sfyI2+GFN7i 6Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb1rsf0pv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Apr 2022 10:02:36 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23FA2PGK032104;
        Fri, 15 Apr 2022 10:02:35 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fcg9mk8m5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Apr 2022 10:02:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=couexHe2ntC46IzgUGWYuVJXyIC7VJfsc0MVfj2pUOXdm2vWPDmM0vLL/l01mA2uMvjrZG8TkNwZ0D0RKlSRitjcADeyHzPeRwsCM5wXBMbNr3CvHF+1K1ko0+etWwSB67zWSp+pBLNV/qHpldBlquuUdpHLxFtugOnJ0RB3fpnNp39rUYWvrUFEWwhLbnnNu2unAwOgyqbHbggGgWUXLI+UXXshLy5/9+oxVlYC91CcWAVwZ1ewGcpaOa+woivASNQT4FLJasNxGCyw7yhTPGUoQXD/E2Y529T1GVTD3SpgGVYH0huDsB06oNjrszETiDvoyZ2MNmTYaRZ7NEMw2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ip8KHB0jSuJX4aJK3c5yKVUT761f1P803ApoHNEP6Q=;
 b=bQa/aT2kfMAGRwptN1MseOIEc9QUbLrp+GHCLFoBtbB5CziJo0KpLarqMQZo4CAxAA/6TAg/daccyLMBDUGSQPOo7E/Hw4Is3apUisiZRiDgkkqdvuwzLvnIYyzMNJMIgy/TN8vE4IdwR877e1KVNmouRj4Koztg46RVPNw0Y8KtAvePMrfUCUkLsTee/OcBy/I0N3Vmk/K/+oXSfKGMh24xXBlr9bJ9tOvCZvGdJ7UW9Y/7XY0hs+HfhILXLSmm2CnMAwNmK2cxTdczjibI0KK0YZBaDgNyrzxUuiZ2Fscw4r/wIN+mTEl2oO0HvL9ISI64PuqQMg+/2ftLnHcf6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ip8KHB0jSuJX4aJK3c5yKVUT761f1P803ApoHNEP6Q=;
 b=H5EWr36CLV2Btjbzm1hUxNe4hCTzcASHWtL4bGB/NBvnYzs2gzV6JIsYoMPRvS3JC9/TiLS2SuOJ/GIRRF6R3zo5eYLsIc+HXAQHhrfx6ydt/uM3Rqwlztv5gBRdxD3hyg1CTj6qzSin3vuCcfCV6/Hnq91+MjtlN4kFQTgukhg=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by PH0PR10MB5418.namprd10.prod.outlook.com
 (2603:10b6:510:e5::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Fri, 15 Apr
 2022 10:02:33 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5144.022; Fri, 15 Apr 2022
 10:02:33 +0000
Date:   Fri, 15 Apr 2022 13:02:23 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Wang Cheng <wanngchenng@gmail.com>
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8712: fix uninit-value "data" and "mac"
Message-ID: <20220415100223.GS3293@kadam>
References: <20220414141223.qwiznrwgjyywngfg@ppc.localdomain>
 <20220414154215.GL3293@kadam>
 <20220415094705.aibh3jr4wzhddmud@ppc.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220415094705.aibh3jr4wzhddmud@ppc.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0070.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:31::34) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf651488-8b25-4ee6-bf73-08da1ec70f81
X-MS-TrafficTypeDiagnostic: PH0PR10MB5418:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB5418A28DD436633BFCDF26038EEE9@PH0PR10MB5418.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mLcR88mEeTE8XgkrgPwHxef8qYmoNGpQ+Xw+hjPDb1eQ1zpSjOIdD9qU4V72bf9VtRidrNQuwUKooe4IfgrFHR04JUf2Kz1QYO60+BIneJuBFHD8S6seBFqWmEKryypLS933d6kMnmDOumRPqgnD7fIk0at8+NmPjBtvVdZsBQX5KtPNJEwrVnlctWN42peO4Krt3sThOOPS0nVyuLbjym51cF0ojDCm5ksqORk4fCHQeDAxw5HuwbJ9wivS6bTvNGHQ4s8T26hsJpLmfEW8tj4l6mabK02CJQ/n7PfKhymApYZ1D4Ad1lwFPZBqrZE66bjNYO4xoBNev63Obeu7erPQHFpntptINZNKykOpu82SvQy0tusfaM2QGlxaA2zzXlwUsuQOxIKGDwulrES1Xycb2jknpnOBYVYHV4YUYo/F/SXY2E08p+wU2s2jPQmPBTEoVyYHNGRMuo9eoLQxnoDcQYzep2wZ2M1/ixZT1PlyBsV73jaRt8qBmdwn2l5RHD0Vg0T2VKSTdyDAVeKkAOkvCRHdawKoGPq3gkcp1YPo8+UBDxA7wlvF0iiBQsAzP/bV316exfrxROG9MQZxlYYnEa/Hbod9gmvku23rIcnbDwQXgCi6z71EGAf5pTXZM/fLUiZ0hj9RoEwkdrLfmV3fQy3gWw4CbheC83fBSDoAu0OsTcWTOaOeg4jw6DyHp4zXyxJPCY3fOaca87VnaQD+6AwymulPhaauMf/sJUyPg55w5nlDwSPEFMy29oy6yahkgY3RjnaCIbaTbfXH5LKT6xBqWiemQvM9U2Npxcrai2nKXIAcu+/+mH/9P/hYZ5IJpl44CXYAVD3xAw1ZDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(2906002)(6506007)(6486002)(86362001)(33656002)(966005)(1076003)(316002)(6666004)(83380400001)(44832011)(186003)(26005)(38350700002)(38100700002)(5660300002)(4326008)(8936002)(508600001)(66946007)(9686003)(66556008)(6512007)(66476007)(52116002)(6916009)(33716001)(8676002)(334744004)(99710200001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YUtE4+KA7YG0EDJ8p9aSllx5tc4N3pWqu1PDebnUOu56BnxJ/JU7tJoMPCs/?=
 =?us-ascii?Q?f2oHn8ORDkrU9ra4yBVKmuVXWLK446W2zoJ5Pe4xu21X4nIaBCMC1/YBQ4/u?=
 =?us-ascii?Q?XDueQej+6wTtmmLlc44IVEnnTiVAsK0i28urbhuTYoLhso9Ss8BqZxp0bLzk?=
 =?us-ascii?Q?M0yDXKKwmfxadMlguikAd9nSPxqrEzUQW/V9yUyVCaFvsmK0m7zpsscY5za+?=
 =?us-ascii?Q?5Rr7mPv7XmTcX4hRH6zIgpVxIcMDfxi1k0YgCbSjUzudDf8x+zQlzvJdCJhM?=
 =?us-ascii?Q?vMQBEKioQ2FatqiC2bGdfXtIUG6C7daxcbrarT8HR0hEs92lJWDvsy9d3iFT?=
 =?us-ascii?Q?BxVdVwjmGK5hM9vLAgLQvGIf660DGKjRNvErYwT0+Eey8Fumk+hyAwgtDX+h?=
 =?us-ascii?Q?+PwnlAds1RpbSY3SIWm8NREFpPzlWWEi3sa1/lsQhjHsXq6iHvwFOES5leVt?=
 =?us-ascii?Q?6xjTrsXqJ4SrNcOambtrMrHR7WDow7fSebbK96fH/p+GaKP2A3tMjiL2/T16?=
 =?us-ascii?Q?HWEwqlRnAepVNg+1jKmKOeGkDS+6qzxmVGUEKuu3IO0CMFx2Po5poUqQdtTw?=
 =?us-ascii?Q?BdgQwXuOdUffNjW1GK/K2JrtlZtOt6T8IKcf8R/YA6CG/j7Pe5xm0FVwBPKe?=
 =?us-ascii?Q?vyN1OGyMzfcr2hcmJHQW7kZkwkLlGZrbMFrC5h4YaItOidegKpH6toowi9z2?=
 =?us-ascii?Q?dNLHcYaiwR42arNO/n7vC3yNRU5xQl1yd7EOjmcE+vt5VBMo28QlROndKZoU?=
 =?us-ascii?Q?4g+PArxymo2BPwoALE3vJpcqMMZOH2c23iD/byZb/iH3gzR/uMfyCKs8KoZJ?=
 =?us-ascii?Q?tr/rd64GDxc5TGY71+U9EKZxeVxscO+r56RjVDcE4D/4OgiV/xIi5IM6m4Oi?=
 =?us-ascii?Q?/fOLGiAkAVKPTbPdTMtYL9fd9gd5x482G1YzDEeNlOpULeVMF66tXEKMTwYr?=
 =?us-ascii?Q?belDec/bGL67mSCpZG6Sy+CWwFnWRZafpH/R5PzmBjz0hwHTSw7cOYshZhjk?=
 =?us-ascii?Q?F5ohCCIqWfMCUDkQq/+5TrpJNLLHO3GynHubPeSgw6URr61PAXBlGn1bqVsu?=
 =?us-ascii?Q?0dDPR2B9K9Btr+6S8UA2mLMbwlEteepBtgYiC7esvPt8wx0djAsJX6qKW7wU?=
 =?us-ascii?Q?hANwGujGZZV7c/gAzFECGIWAq/bCvBh4qhW4p4F+eorxXPJ6LG751g236mcC?=
 =?us-ascii?Q?wYvNVcvm8szNpJs9G+ePlPHDxkzyQbYVQEKMSLIzAxsvi8g5IH0bGpr9uA3h?=
 =?us-ascii?Q?BIgKhnATHrbc5yl3ERmkVtzAgfDI8bbejui8oU8e3eUOH7yOhn5itcMO7t2L?=
 =?us-ascii?Q?JAiClxlo8Ha+r49yRLlGMW3Xp+vfXNJrAko1AO7+XgiU6iSPzFHf5fHV6gtz?=
 =?us-ascii?Q?FrJxBkX3X3V1y9BMPn+FwOD+tzgw5qjVzQzcYOa/xAvbBw0i1CdGu0jJmgn7?=
 =?us-ascii?Q?nbQv04DhxFmgvM+Ud8UvRqFL4uQ6TikSbmjet6U0f2cToCw4fhCLmMSmNKYI?=
 =?us-ascii?Q?dT6fYvdLGE6AuDvMw53an8jPyrs4gStPbJPKIzt/Lay75oN3HdKnYxt7TkIk?=
 =?us-ascii?Q?Nhq783ZeSgskr43Di1hsDgUIXsttehDY3R+NxT7/DZP1EdzT4ctJ6OWNqWQh?=
 =?us-ascii?Q?b0sYaP4KTswOjgY2x8qS2xM+f7aphaF8C20noApWPSvcf3Jwefqz0FIPekSQ?=
 =?us-ascii?Q?GPWaVf510Bm6DMKTqAF5yGk27oPOFLvBYdU7696Cff32iIF5hsPce2b4TIsa?=
 =?us-ascii?Q?wVIJfrUuhnjTAcxzqlPLMnCIPLP/mxY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf651488-8b25-4ee6-bf73-08da1ec70f81
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2022 10:02:33.5082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uGdh//x6SIopayFJdaVLT9cbFkpVLOfDXeEdoRINNkaOIBoCIrvyPvzfmMVrHRQjZ+cMG56QNh3SzR5zYRTiv91vOwXEupAY5dPhCYOJFgM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5418
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-15_01:2022-04-14,2022-04-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=890
 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204150059
X-Proofpoint-ORIG-GUID: axMkpAKGCDVu9ACDtxIWPV2HiGGYRrXC
X-Proofpoint-GUID: axMkpAKGCDVu9ACDtxIWPV2HiGGYRrXC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2022 at 05:47:05PM +0800, Wang Cheng wrote:
> > > diff --git a/drivers/staging/rtl8712/usb_ops_linux.c b/drivers/staging/rtl8712/usb_ops_linux.c
> > > index f984a5ab2c6f..e321ca4453ca 100644
> > > --- a/drivers/staging/rtl8712/usb_ops_linux.c
> > > +++ b/drivers/staging/rtl8712/usb_ops_linux.c
> > > @@ -495,12 +495,14 @@ int r8712_usbctrl_vendorreq(struct intf_priv *pintfpriv, u8 request, u16 value,
> > >  	}
> > >  	status = usb_control_msg(udev, pipe, request, reqtype, value, index,
> > >  				 pIo_buf, len, 500);
> > > -	if (status > 0) {  /* Success this control transfer. */
> > > -		if (requesttype == 0x01) {
> > > -			/* For Control read transfer, we have to copy the read
> > > -			 * data from pIo_buf to pdata.
> > > -			 */
> > > -			memcpy(pdata, pIo_buf,  status);
> > > +	/* For Control read transfer, copy the read data from pIo_buf to pdata
> > > +	 * when control transfer success; otherwise init *pdata with 0.
> > > +	 */
> > > +	if (requesttype == 0x01) {
> > > +		if (status > 0)
> > > +			memcpy(pdata, pIo_buf, status);
> > > +		else
> > > +			*(u32 *)pdata = 0;
> > >  		}
> > 
> > This isn't really correct.  In many cases status is "len" is less than 4.
> > I'm slightly surprised that nothing complains about that as an
> > uninitialized access.  But then another problem is that "status" can be
> > less than "len".
> 
> Sorry, I should explain it clearly. If I did right, watching "status"
> with gdb while running syzkaller reproducer, "status" returns from
> usb_control_msg() is -71. In which case, *pdata won't be touched in
> r8712_usbctrl_vendorreq(). As a result, "data" in
> usb_read8()/usb_read16()/usb_read32() will be returned without
> initialization. I think that is why kmsan reports:
> Local variable data created at:
>  usb_read8+0x5d/0x130 drivers/staging/rtl8712/usb_ops.c:33
>  r8712_read8+0xa5/0xd0 drivers/staging/rtl8712/rtl8712_io.c:29
> 
> > 
> > A better fix instead of setting pdata to zero would be to add error
> > checking in the callers and then change this code to use
> > usb_control_msg_send/recv().  Probably just initialize "data" in the
> > callers as well.
> 
> I tried something similar which also works fine, but I think this patch
> does't fix it at root.
> https://syzkaller.appspot.com/text?tag=Patch&x=15be2970f00000

Oh...  I meant initialize data on the success path as well.

	__le32 data = 0;

You're saying that kasan generates a warning for your updated patch?
Earlier I mentioned "I'm slightly surprised that nothing complains about
that as an uninitialized access." so I guess maybe it does complain?
Good.

regards,
dan carpenter

