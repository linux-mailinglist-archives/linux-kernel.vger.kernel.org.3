Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566E6535DDC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 12:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350692AbiE0KFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 06:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350778AbiE0KE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 06:04:57 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693E91157D5;
        Fri, 27 May 2022 03:04:50 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24R9K94B021664;
        Fri, 27 May 2022 10:04:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=flYTVmZqrhoZu6w+yhg2hLr8qkIZnE2uLxD5tkhCDjY=;
 b=DIb38Vt0i5bU7teIdD8MykqvV6n5AMFP+Lt6lWyG3cNnlvjCWIqKovCJDzHGM+hVPTlU
 s2yaihqDFoHTZrUmcRNHThA/z2D+/Y2r34rYN+42tx5/ByI0Yve7U9BkekGpMTG4m/D1
 kONz5DiYMpUltqUCXd9ARgIedQO87UjalXTsUPe/e0MkKPoI8mjjdtoaPzy8IrTTQkNE
 doQfAw9vc3pPFTdT+Y0I/RH5v1GAgHNccdb6Y5450EmwqM3cUi9mCXZw97BysmgvHL8y
 6VrH5NDE+AUZoIMx0IfQASzgReHPTpfkPLb5U5WgASrURrv0szFxKj0iTH9xA5JoATZ5 zw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g93tby054-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 May 2022 10:04:33 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24R9u7Tw012858;
        Fri, 27 May 2022 10:04:32 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g93x1m27j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 May 2022 10:04:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FEpWbGZzIPSbIhAsy3yqN97YABE9Fg9sQmdv0C0dCxBU7po18pEq3g8x//Ra4YHEg/Au2vuMltTEo2OIJo+1cZt/ALCCO29kw69R/e3JD/kQNEy5E6dMaPfjEiip021NmE2jBewIi9yOqtJOIljSfOtOyt7m+HBxVHXy/GW5Q2thoyrsR1N+jcoLVp2gm6vwSUnKCLAMGPUtYSMqFMRpIFzEoRY4xVkeNwZLysrdh98jdrJKm2pHwBhCpKrDrl45YxJGmo8t506z+7DfbaDcZKXVCUcDY1LY9cpGyXCslMaNbHd0k4pQTKWsdRZOWZuecETDEDlvXWXjLDosSftPLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=flYTVmZqrhoZu6w+yhg2hLr8qkIZnE2uLxD5tkhCDjY=;
 b=PGRIq4pXFbe+E1dZnEXljkULVrNsOUH8zW3ZsFLOHot5LxbL7uicXlC0vLJXNlIADSoaQYBxlVvwAUyu95Immrbvnnp5TDXALgG37YwKJLRX0btAaPP6/hA3vabC2TjYNV4+tV6xC0mFo/jkf0bGKCpPVHvkX1xvvwiHTKxLi7Tb39VeohDWqA7NCXMHtCZgNg2MF+tVFOmfHoIvXSNM+Ch3QAYPXydHLqqCjt2C2VI92Pbvv4xp0dyHGuqH97ocv1a5LqdA6ozqqUC5661qAslRj4QhFcsVRG1ije4mnn6l6H6MY3x2Rw49cqJ5IRQO531qHR367xpU/SkqY2IYmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=flYTVmZqrhoZu6w+yhg2hLr8qkIZnE2uLxD5tkhCDjY=;
 b=c8Ml0KRrgz6uORLTWgNSOAqHpN2R97uUxJ2DpPvhwwmFXy+r0AWLpECUV1kt0LUvk3Qo8Uwadd9bZ1mXMOdEnlBLdXr28MkmPQrLg67+AgfbnF6zr1icY3JeRMcqhg01NyvweUXxzbScaCOY7zOOcXM7WXukFygCzzkuEj6v8bg=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BLAPR10MB5378.namprd10.prod.outlook.com
 (2603:10b6:208:328::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Fri, 27 May
 2022 10:04:29 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e%2]) with mapi id 15.20.5293.013; Fri, 27 May 2022
 10:04:29 +0000
Date:   Fri, 27 May 2022 13:04:02 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Shijith Thotton <sthotton@marvell.com>
Cc:     Arnaud Ebalard <arno@natisbad.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Boris Brezillon <bbrezillon@kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Jerin Jacob Kollanukkaran <jerinj@marvell.com>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Srujana Challa <schalla@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Harman Kalra <hkalra@marvell.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Kees Cook <keescook@chromium.org>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [EXT] Re: [PATCH] crypto: octeontx2: fix potential null pointer
 access
Message-ID: <20220527100402.GQ2168@kadam>
References: <da89ba20819ad3ca6b99f9ef056f2bc1b076dc6d.1653632699.git.sthotton@marvell.com>
 <20220527081928.GO2168@kadam>
 <PH0PR18MB4425FE9F1CF5BA4B7F981F94D9D89@PH0PR18MB4425.namprd18.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR18MB4425FE9F1CF5BA4B7F981F94D9D89@PH0PR18MB4425.namprd18.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0024.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::15)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e036d3f-4699-41e7-256d-08da3fc84988
X-MS-TrafficTypeDiagnostic: BLAPR10MB5378:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB537877EFF9830176C75986208ED89@BLAPR10MB5378.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IArUw58Rc4WDUDHRj4JJkZlE/2+3UUhmjQRtALCMtBeJHbHPzKe7hy30XVHDYeEzDBpjmBoyFfQhf3bedFhga4fDNv2ymNwo1bQYI0Tf3e3x9z5uGeImZKxHMmlimeFzmwWw5/WqQwI/EnJXLOwOHB+i5k+RJ/OMRfOkdWuJPsOXY+CKtz9ZiAveegHzP5TbXTUNDom+56J003BJLLZ9YWNxlNFnxMyAK+X+ooJzmiyz8uQL8D9vSjkxPQdSj1MF1rcynu2ozu1u2aHXnTJeNOFGo4x9R9tFw8EHGRj8B7K/DmTAshKRA6dmnkVE7QzJkLju9muOMWuvY3aGPohe8XXdLE+5H4BaIs4kjswyXnuXn2S3UTEBh9JW39G9r0bC6H7CpuYg651XRPxtgFUcM3M52HngzSdBErNUNsfw9Dm3uFDco/eSRXPxfIiRAtWjoPwH7OMbrdedYtDUvI0JIkk4CHny1Vl+49Tw5SPhJ3rKMXGH89CUCGu1omPR0+9bOw79qiSqGrjEesBhgGTe7xZPeRCm+sNf6Mt+c2NO4UCBnqLF7hiGpfu68Z02lRxvHyT+TScjtlN/kiBWL0ZXHCpEgxLSktNDIY/YWXqI1PD8UBhqsLS1LgFAaR9OEGKcU+eGOr29xSrzCM7Ucl6Jc6+jTHn9cREpPVhI3pnSvn+B7o77d8y3M1dTn55iqL8KmtWCoc68xLIFMmadIr/SUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(66946007)(66476007)(66556008)(8936002)(8676002)(186003)(4326008)(5660300002)(316002)(2906002)(6916009)(54906003)(44832011)(6486002)(508600001)(6506007)(38350700002)(86362001)(7416002)(83380400001)(33716001)(1076003)(52116002)(6512007)(9686003)(38100700002)(6666004)(26005)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2sbuAqJN5cDm5LJ43IFgGbQPgTgraOk9TncH0zZDCGFW9Q0cSDlhhelLrXIX?=
 =?us-ascii?Q?RYHXBVHHku7HEJILSjF2ZrpYVsg1rfkZEXbOqIGdPHwjQnOCVHDq9odggQHd?=
 =?us-ascii?Q?1PqHbdv7A2RshnSsZH85BZNtAOoB1M66u+23NAL4bXdjjHnJ+i/sBT7omamo?=
 =?us-ascii?Q?K3vCTty229o+qy1aZP/wKz9LlLWG60BIfVaS9qw9GUkJUnTvmcr50ivXLnVF?=
 =?us-ascii?Q?+r3ysL7VTQBvEKEkiie99CevmVzQWicSP9/xqvbG1TpjES7tJwL1DIxHnruP?=
 =?us-ascii?Q?gIWoY7KcOhq1Bcmbg8jIH+u9VhJx7RC5V52oq/FFPLxPmzX8sLfIoyXb6i4p?=
 =?us-ascii?Q?ShuY9hcK2m5Gf6PqdlFMf5LioeK4YDJpd4VQoSL2GsTTpy/RH8Ig/iL9ICYt?=
 =?us-ascii?Q?jqoSOSGNoGLShdsHkkpHk4oW4JEHzYykfr6uBB3uwB40eTzJXbLNU5vwllkP?=
 =?us-ascii?Q?FRyE7OuPhmFuinZ2Vih5r5e2MfaaZ/ysgQOAD6l1S9glT8BUw7l82wzN+zcf?=
 =?us-ascii?Q?FA1tflF28sA8/oI1CQHaZC9GsKTL/4iGM/jZAlM5HuJsoDPEPbWOIg3p6GhT?=
 =?us-ascii?Q?dSjR8vqg6e/ZvRjzRjCNvsA6GikgIOIhv+2Ld3oGE3j7KSXALrjqias0IkIF?=
 =?us-ascii?Q?wyZBPfg/3DbthXW7riku7QIEj/jz5sb6DPuVdZmojQFfKoWSiZWvPrVDI0oX?=
 =?us-ascii?Q?OfWJNC3BMak/O+oi50+XKIAeZQcr/74sRpIpyZoYsKD9G6oLxGPisiUygH95?=
 =?us-ascii?Q?xunRYFM0fcYePeXHGhoFqa5oS8z1IjaJF/bCjCq6IeD47vhkaKrHRHvxHbWW?=
 =?us-ascii?Q?czeoLtZLXr7ySZAS4qeyT1K18wqcV2iYfjDaH91CbR05tMWXiyeyy9T1d1wJ?=
 =?us-ascii?Q?W3lxgQMfOJbmvP6sjcVnecaFPnJijI8+TzfYQL/BQSaRXimgbpMlwxYEmF2Z?=
 =?us-ascii?Q?5B+LwCZw4BDctUNDUKf9GiymQmG5rrgdZl0iLBv1vzyjuM+nSrlEM9wEgMsX?=
 =?us-ascii?Q?ki9/VIOE1vdVqYTuCnWE4NRDYSBcrLRV3D2u+mvy1YK+p835cS3Y558NKl0q?=
 =?us-ascii?Q?BOmHfhtI5KiLJ4tr2gPdy6bKntE6Qcnz+yT6d2QuMPqMsE8rTAaBy7lYw7uy?=
 =?us-ascii?Q?J9Kvrd/hfHRnfBSM4oYcqK7IydN0lfVrwSAQg7RELm90Oi9BX/VxWG4LhuTU?=
 =?us-ascii?Q?Esh12xeKN8iUW1SRhbSmQAtOy3u5lCx3ztQZa6NfdCmrXwGzSEryTwnr3dVX?=
 =?us-ascii?Q?ND2banfUClJoMrkB64y+Gf3C0vpUwgwzdXiA7kV8EqBw+qr6bYZRl1Likxov?=
 =?us-ascii?Q?tttxVmYsAliRYHdTgIADbzr1UPFlGre4lwg632xHNbIrAOgWPn7t17xHattd?=
 =?us-ascii?Q?k2my0gpJl7s2EVW1XjnhRs9m4TFRy10/xKvCcbIzHQjOtncwFIRZqbQBEOCz?=
 =?us-ascii?Q?3CkdEGV17XfTsSwlkvrAtBV3+jzuhzaf5k8oxB7M5JIKImSodiq/8isBqbLK?=
 =?us-ascii?Q?wckZBh+kIymH2KDcfnjmNlhQlqeHgyHcrJSfafC17qUYntA/nP04IR0M+8CE?=
 =?us-ascii?Q?QKiNA5ngkOmju5s51lqjEbvIL0jGpxhib7GUpr5yXcD1BNb1myUeLXmYC8RI?=
 =?us-ascii?Q?6s4ZiYb7pd3ZahSu+5g52wFtocv2DMm7CEDAA91zCUZ9nUN+9iUXH6qCAiCn?=
 =?us-ascii?Q?jD8b51YETxTCFuUZIzTWwSTguy0YhJ+i9ONrX6lWYKMAdJ9UjsUwbKb59RmE?=
 =?us-ascii?Q?+iwqI0xmWJChKw3Toy1d0ZfJLDbml6U=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e036d3f-4699-41e7-256d-08da3fc84988
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2022 10:04:29.1639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uH5Ichp24V/kBLFu6lNGQySEfQl0YXFdAeu2u6ixtmS8dS1ZMvX2okKI3vjkXrBgowHIGyyRZvBhFf9D/LqL7frby0AmILYqGpqYF2+m/fA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5378
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-27_03:2022-05-25,2022-05-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2205270046
X-Proofpoint-GUID: TnZaw15x_u-tiCuUP1JFcxJkFQ9z-cQl
X-Proofpoint-ORIG-GUID: TnZaw15x_u-tiCuUP1JFcxJkFQ9z-cQl
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2022 at 09:40:16AM +0000, Shijith Thotton wrote:
> >> @@ -731,7 +732,13 @@ static int otx2_cptpf_probe(struct pci_dev *pdev,
> >>  	pci_set_drvdata(pdev, cptpf);
> >>  	cptpf->pdev = pdev;
> >>
> >> -	cptpf->reg_base = pcim_iomap_table(pdev)[PCI_PF_REG_BAR_NUM];
> >> +	iomap = pcim_iomap_table(pdev);
> >
> >I don't know if a check is required here or not...  The comments to
> >pcim_iomap_table() say it is, "guaranteed to succeed once  allocated."
> >
>  
> Will keep the check just to be safe, as allocation/kmalloc could fail.

No, it cannot fail.

I don't care if you add pointless NULL checks to make the static checker
happy, but it's important to understand what the code is doing.

drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c
   701  static int otx2_cptpf_probe(struct pci_dev *pdev,
   702                              const struct pci_device_id *ent)
   703  {
   704          struct device *dev = &pdev->dev;
   705          struct otx2_cptpf_dev *cptpf;
   706          int err;
   707  
   708          cptpf = devm_kzalloc(dev, sizeof(*cptpf), GFP_KERNEL);
   709          if (!cptpf)
   710                  return -ENOMEM;
   711  
   712          err = pcim_enable_device(pdev);
   713          if (err) {
   714                  dev_err(dev, "Failed to enable PCI device\n");
   715                  goto clear_drvdata;
   716          }
   717  
   718          err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(48));
   719          if (err) {
   720                  dev_err(dev, "Unable to get usable DMA configuration\n");
   721                  goto clear_drvdata;
   722          }
   723          /* Map PF's configuration registers */
   724          err = pcim_iomap_regions_request_all(pdev, 1 << PCI_PF_REG_BAR_NUM,
   725                                               OTX2_CPT_DRV_NAME);

The pcim_iomap_table() is allocated here inside the pcim_iomap_regions()
function.

   726          if (err) {
   727                  dev_err(dev, "Couldn't get PCI resources 0x%x\n", err);
   728                  goto clear_drvdata;
   729          }
   730          pci_set_master(pdev);
   731          pci_set_drvdata(pdev, cptpf);
   732          cptpf->pdev = pdev;
   733  
   734          cptpf->reg_base = pcim_iomap_table(pdev)[PCI_PF_REG_BAR_NUM];

It cannot fail here.  It is not allocated here.  We just look it up and
use it.

   735  
   736          /* Check if AF driver is up, otherwise defer probe */
   737          err = cpt_is_pf_usable(cptpf);
   738          if (err)
   739                  goto clear_drvdata;

regards,
dan carpenter
