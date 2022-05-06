Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 584C551D210
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 09:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389457AbiEFHT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 03:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244190AbiEFHTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 03:19:23 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451DD2B1A9;
        Fri,  6 May 2022 00:15:40 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2465n48q013665;
        Fri, 6 May 2022 07:15:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=0AbS3K42uCiSiop31oqh+T23sCtG5ur1fLUIy8HJcis=;
 b=cyqQvGYP290Ulpm2u6ShOVcX7sMzXX1Mmt9eCI4GTRGFl5isztpNyGBXzmip2Dq41Gjf
 SJ4svlg1+98ZHuhQCGu1SUCl5TcVtPPJtxmdtFspc3MHQbWqUS2rnAvxerwYPfpH6U5N
 m6+x3o1FqQJl5lSP/H3ltlswptSO5QDwnyeT9KmCKWz9O02hoOJfLZg5Pxnpa4VstLZI
 OBOGyANs6hj/hF10lTGxSWLwP1MVBdbSWxvvay3mcpwHokQs3hTkfVyD7jouIDF5kDSy
 9J3BifdhQzXmtNvWUODbYbwQ3EOXY3bJQMsxAcPOCGKObNy6r+s0HJQTKMSIKEF7ZTN0 Mw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frvqsnavt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 May 2022 07:15:18 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2467F5fK027952;
        Fri, 6 May 2022 07:15:17 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3frujbq1wh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 May 2022 07:15:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TB1t4lVylLr3ROvPKZmHFChMcBLoJAsIU2+vBXHKu0kbDDA7AK72UJDJvi10NgAw6OZTmlupPpFUiz8L19Lz07xO24F3lis183qXJ3rvPRBo4BHg7tyo7534sYpsPGXm/eZDwRYTdBkmbHdTyUsAEi9W7Uoe8WEYt9smhxAQ3jDPb1T3E5mS0bSKGZKMjdizwMqWK2akMG/Wkno0LSMeinQ4IdQg+PqLBhax64Jy48Nb9CYMR2LrDEeYEm2bWPUnoE2plchtKy28MuZkjOpKL5qWa30hj32biiZ2jyrUmnLts+AALFHa36nvrAeGbivFmrGX9gferb9szPaeWLVxlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0AbS3K42uCiSiop31oqh+T23sCtG5ur1fLUIy8HJcis=;
 b=M3AVjtpO0pYdfd2xuMg1npy1IOOhQMdkZc2hAFRRK7k2YyvAaj2d7ykcREVTbmn/OdhgrAiMV3MomDMc1fAK4/SNvDvKyo2XcaMvhoHT4IXIwOTTJTRbziDzZAelhCDu26xzwZ7OiTwGNgLCNQR4e4Peb7xHKaDXbgbxiSs3miBrV3m7zpGQQHY9isK5HARZ20UB7ULOecDJ4o2lv/1/AOQhmlkLAsKS072C2ZvLG/q5CovCwU59kBwLYLl22ATGBcAnOu6TTL6yIHyMah7vgFph7XufxiMHu3bLxXl9sezkTUmCeaWX7R9osbb7c7gcbDlnDHEhS8CrEvCqlhM6Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0AbS3K42uCiSiop31oqh+T23sCtG5ur1fLUIy8HJcis=;
 b=EqKzyqH+gIwJMPMkPWSP7fjoCYu/q+8Z5FnJ0A3BqsWUUMK0c5+A/BLHBj8E80wJO8F/W1u9eDTzm8bJfU0ur8adE3nzfk1XEtMB6BpF1N1sA4EqQn75nixs6ARQoce1s9ulSTrX62cUVYArl7vmGMrPtA9Rq+OI/Ol5UXL8n5U=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CY4PR10MB2022.namprd10.prod.outlook.com
 (2603:10b6:903:123::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.25; Fri, 6 May
 2022 07:15:16 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c053:117c:bd99:89ba]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c053:117c:bd99:89ba%5]) with mapi id 15.20.5206.027; Fri, 6 May 2022
 07:15:15 +0000
Date:   Fri, 6 May 2022 10:14:55 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Ian Cowan <ian@linux.cowan.aero>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Corentin Labbe <clabbe@baylibre.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        mjpeg-users@lists.sourceforge.net, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] staging: media: zoran: replace dprintk with new
 debugging macros
Message-ID: <20220506071455.GC4031@kadam>
References: <20220425144110.133316-1-ian@linux.cowan.aero>
 <3270dd49-0d68-5b60-d766-940b39aa463e@xs4all.nl>
 <YnSyZEF8n7luVvHM@fedora>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnSyZEF8n7luVvHM@fedora>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0046.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::23)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4bbcbb6e-80f2-4713-6b30-08da2f302b22
X-MS-TrafficTypeDiagnostic: CY4PR10MB2022:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB2022065539129E9A0D06EC8D8EC59@CY4PR10MB2022.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FzHMxXjqBXkjWtx3Vsv0ATlFZq9YLqYBhEr/vchptUpg8lFoddT0yvXcYbUitqckXAYp1JTbmP2W6v3Wpl7NZu1YlQkN75XIEH8m9Qr1i6lpB0mT62RAlXZ1fGajM446zLs1s0pUDjg376m2j+va2IjtTKZQbAB4ycG7OqVG62qxdsxbCDzKvz6AMcTA5wr3xVp+na3SoHYDwZT6KaYH0eemTiYVzYqhdpX/YxciiqMqNApItX5W4Z3ac+dKHvWGj5ii4Pi5XJNkU1JHObgH5l4JFUzGZk9Dc2g6Sn3Ln/8XGeybE+cTdoI44kuwEV8LZxSUzg9osdiIlKBgPZ22UB2ico5Pj5x8feMwm+Hl4Rz3XYIEbCJ7tVau4E15tE+N5ZKe5fl0rbJmmPxiMbTk0EbR0Oh19kEMzrLB2izjLmfH0xblNLEEiTmU9xnPjLbVusTC3IuPO0n4lbIEr+ullJRGB9TtEGA50SViupVzMgY8MYvWJAbfSxnwYFPkS+CKXyvmceNEiU4a1YzYwyunNC/uDj3izpggISJh2fPgJmMEjfPxBYpXrLZRFV3Yte6O2FR0+VuPCkF3HSH5lgcsbNMEOZD/HCWxcwA7/mbJW9HLAvirU/4lBlgSbTjIlU+XyAXpc2w/C/51aJBtky0LbJQ3EzS4CJmapx80SCPD0pWBLpskNoq+LXaKlTnIv2RB3sKU6r8TWA7t15kr7CmTcmWGrm3WdtNgemfVDK3PpDbA5BJrB/LXS7RXALW//nPe/5RYZnMAEwvcoBirlD6UuWkOrFzwqcPJCkblIqo7Enc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6916009)(54906003)(508600001)(5660300002)(6666004)(38100700002)(38350700002)(33656002)(52116002)(8936002)(66946007)(186003)(83380400001)(6512007)(9686003)(26005)(33716001)(6506007)(6486002)(966005)(316002)(44832011)(2906002)(86362001)(66476007)(1076003)(8676002)(66556008)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6YOB8lka/flOL3sUNTctihPS5q31WwzZ/cothZDTseoPSGqgC+jRUkFvQQ7v?=
 =?us-ascii?Q?4JQ6nkBQ0S4rpt3eOM7FMmebN2d8i2/j8rafX6FJP9NsL25bMbz/o69sGvPw?=
 =?us-ascii?Q?ntrZCfhAY6wPMeH3vfQ6n+0p7BlkiFFy9z4kirRnbypjNNBJ2FkGkEeL+Vfz?=
 =?us-ascii?Q?bjOw9JCiiFJml1AE5qPQ2L6D5YLqNbweXU+PwJ0xiVEi0U6QHrlW32YhnBbW?=
 =?us-ascii?Q?WUhesSLiYEX6u4u7WgGB61ozQGAT2SgmACcBGpdCSNs5H+rO44S5V/N12K36?=
 =?us-ascii?Q?O92K29WDMAgAOt1NDnXVGvFazd++H9j6wEK+rrJn9GwDXLgrJvfNhJDl15eE?=
 =?us-ascii?Q?+ywk5kHKjBq4IXVfeQNfz3qZVVmPSa848qAgdcK8Yl7avsGdQjOmhNFB5sBc?=
 =?us-ascii?Q?EGDPpeFQ/KjOPPlXwNm6aRPBz9JByp55I+LdW1+xhUNJ/GqEi0L3qU7exn9t?=
 =?us-ascii?Q?8U5UPgCs3j+5EP3+6IxzHV+ZSrpzeMNFYE9MQnpZh3S4HNvG40HSK1DiEFfY?=
 =?us-ascii?Q?res6CoRdffCwD7yAnT7OttQmq0zV9Uco7l/IJIpRRtl2xRGAF+x1Elxb1qfG?=
 =?us-ascii?Q?HSByZQQjPgKUJUT3pQW6Ptzu33ihcEZtR2ULAZ9mp3Su0UozZYsfil7G8m1S?=
 =?us-ascii?Q?6C/8ljUs+NT4UgUN9SEyckWRUb9GNdEOKVhnz1TcZDwiIQjElnWlUPsghIIl?=
 =?us-ascii?Q?oc9ibWRcKFWILYAWH3B34KL6W4DKXSA5gllFoT8df3k459JfjXk86UXdIk1X?=
 =?us-ascii?Q?S2McFFBNOZY9j0Na43PM50+W0OX42ALMu/H4xgNC687VVoXS/gd/Rj5bX+Tv?=
 =?us-ascii?Q?YOsZlA6rfUwwW8AWgweAWkqSuqD7uyKkTO9E6ZC5sZ+EarzpWQhrXvHWl3ra?=
 =?us-ascii?Q?8q7UouT5qk5kIRpsCl5VcxYoXjMYyc754//I2HEBJZqM1LMeaK9Lv3KsMHad?=
 =?us-ascii?Q?CZ9YfeF6rzyYM4j0gyyGoyDH2y8paolskubwReM0/SvySB2kQmrFFhprs26k?=
 =?us-ascii?Q?Y2MYvWRpFU4yTROeAH4Idlyp9W4UXMFn4t5ivd2IErwA1Hfe9jFa/WhklSRJ?=
 =?us-ascii?Q?zooHqoWhLQ6+7n+dMkICqeKhF5np6awc6pyysbZpZ4IsE8e4QR4WKKY4DpF+?=
 =?us-ascii?Q?s/ERKNQlvvQyYFSb+Nwsp0BpLaFjneb58Rx/l/TI6z3cK3Jv2IBwlyCr+Oth?=
 =?us-ascii?Q?eGPW4tKdkV4AUXSxGpOSiCZu+Yl0G9NShgwHZ/bQvRFMCKCsojMyQUY+4bRB?=
 =?us-ascii?Q?jFaIJzPxcVRDtn24w3yDs1c96dJo47KQqf46FdgvbXSvciQLxLet5JcycOe8?=
 =?us-ascii?Q?k8/U3Umukn8MciT3vGhSdZGKSIpcVG9KrJ7J61JjBoU0ZDjgXScpKbj0A+As?=
 =?us-ascii?Q?/FYGhNInsTclZxwQ5+ND+93qA/S2/bQiuQXs96K8fTu5PKTt+5H7HcYa4WnG?=
 =?us-ascii?Q?fJkG899X0yhVJpuEwXtzc5v1MPUt+ADqcIHgAk0V3ZBGn8ctwQPxq38d1rjE?=
 =?us-ascii?Q?YKekSxCC0fReUf0Dy5qrwAsGQB1fftoeN75J42FAJZPnIJx+wzg+xC2fMwFx?=
 =?us-ascii?Q?kJRsodbmi5jKRFlkTW+bUWB6XIresTSrAz71JF57x8jocTec35Kr9wk1Dd6u?=
 =?us-ascii?Q?keHsu+p+l9Wbw3RoAERDgst3JcaiybIeK69JSNyhalW4OZu7d2GVl5sYijar?=
 =?us-ascii?Q?bFsCPn+d4WE4P5f0HJarGI5KIzXWvJyNxxiudUWFtlJwpQPeJABJGLqbBxlH?=
 =?us-ascii?Q?d/AB6mNbPUsB8EBgRNKuT/Be4LXJrWo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bbcbb6e-80f2-4713-6b30-08da2f302b22
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2022 07:15:15.9176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ia/hB4DWXIQRmqaVyA/slJMdnUErWewrAZF0rZovHIGprUSnPUp0Qo72oABuD0GbNU2EhPN3HYknCzJJyhRSPiN+DdiPDiu195OSV683j/o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB2022
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-06_02:2022-05-05,2022-05-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=861 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205060038
X-Proofpoint-GUID: QRUMUZpbZ0fO_X-4T1B3j7vdYnPtFPpX
X-Proofpoint-ORIG-GUID: QRUMUZpbZ0fO_X-4T1B3j7vdYnPtFPpX
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 06, 2022 at 01:30:12AM -0400, Ian Cowan wrote:
> On Thu, Apr 28, 2022 at 10:15:03AM +0200, Hans Verkuil wrote:
> > Hi Ian,
> > 
> > When I compiled this patch series with smatch I got these warnings:
> > 
> > zoran/videocodec.c:45 videocodec_attach() warn: variable dereferenced before check 'master' (see line 40)
> > zoran/videocodec.c:115 videocodec_detach() warn: variable dereferenced before check 'codec' (see line 111)
> > zoran/videocodec.c:168 videocodec_register() warn: variable dereferenced before check 'codec' (see line 166)
> > zoran/videocodec.c:200 videocodec_unregister() warn: variable dereferenced before check 'codec' (see line 198)
> > 
> > And I also got this warning when checking the kerneldoc:
> > 
> > zoran/zoran.h:307: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
> > 
> > Can you fix this and post a v3?
> > 
> > Thanks!
> > 
> > 	Hans
> 
> I just resubmitted v3.
> 
> What did you use to see these issues? When I ran the checkpatch script
> and compiled, I did not see any of this.
> 

I have written a blog entry about checking kernel code with Smatch:

https://staticthinking.wordpress.com/2022/04/25/how-to-run-smatch-on-your-code/

regards,
dan carpenter

