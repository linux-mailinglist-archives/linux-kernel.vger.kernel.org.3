Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F37FC5741D3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 05:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbiGNDVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 23:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbiGNDVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 23:21:40 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E09240AA;
        Wed, 13 Jul 2022 20:21:38 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26DNFnKE023352;
        Thu, 14 Jul 2022 03:21:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=1sWJLV6LYswlSbUHt4F1UcELDyK+FRIUozQsZr3hooI=;
 b=FcxEn922XcCAoc8q91hFt4KSaeXRQj8LZjqwXZ0jvhO+JhLDhA71bXU66eTeRjuCtcrN
 34k1RIGZ/h423eJIqDGckGTznY2gLdVCEc2OYEbC8kGF09FglOpgXf+07nAzOh4Quri2
 qCH9KhyUFmRgkCLias9Z+hG/CawdUEiDI3yuX6pLQdCv1x7SwZrUmS2XJiEmSDh6AWFz
 uIneC8hLbxynaIIm3/VFdOqAfmD80QnwxsYSQOopmUvqSk0YeYEkmn7ThHUc4V4mSBKd
 LWzTd3RDM1/dCOei/8zfLtt3OGhdT0pMEUqMIUOYHgLftcgvUWaUIzr+uSZaJ7f19P8C 5g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71scc03c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jul 2022 03:21:33 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26E3AeSB001507;
        Thu, 14 Jul 2022 03:21:32 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h70450kwb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jul 2022 03:21:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JDWsM8aqPfM4Sgjo6DvSh/obl2TuepmCbeCjbKpMtEE6mxo7h8KRObjzVL01fPE6LZe+OGuHdlKZTRaYYlyd1F46Q6GY0NfYRVG3IWtuHXMywWEsSwZZMuRyifdiGOJZDdAD+3ow4hADWS8IYcFa3P+AftaGCTIOhoOoHFTrxqSv/effJhgsFUdnLfwWmBkxYhjiUdXXGf9mDPkXsZ2APjIn3tugOlSuFQ0fiY9ZVPYreCyuq7wJcUiVn229Tdc1aE/ZAgykKHgztu0gqSGABid2RS0Qyi3kw9F6Fz5h5CB5NZ6mQBcHEsGuelde7+ddSHrxUN0kkI2qNDeMnOoPmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1sWJLV6LYswlSbUHt4F1UcELDyK+FRIUozQsZr3hooI=;
 b=Fa/hN7IJD4Uvmjh2vtC7SJwdogg0pdYUQmhMvJIGWvNzdNIsXELifoJab39YejsEHB8HFDOZrSwHGbGB8nsdYiRTB5MbrVYCfg6eJriiu7PqGB3p8JKmCtZedG5YblkXY0eJ0LyMxZr5VnSK8Mus9zljRGjyDERGU453hXaSZW1wOF1Wg6egbmZYK+69JfZ8TudYYkl1l/wB68Jfq2C4WGQmqVVhaFL70VZDKQV03P8qAVoWGUm4NSA3aN0YGS6P6LOsECXXnyliirCNIBfkcnMwra9KKZPV1eccQuBkETRPo+PZb5plPmWNhAMV7Y80XNVV6sifMxT8cG26QC7yyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1sWJLV6LYswlSbUHt4F1UcELDyK+FRIUozQsZr3hooI=;
 b=0LwJQ19jmE3zn4SzVFyhtLH+YIA6rU3h2QhjW1lNEDaICGjt4z1ngCRpj3XTTKhJwBZsk8DZyPqyei4NEczT0Z6HN0atFsMMpHTVId+y9/tuS4SQ86kaBSjltumqcvx3K6uMDq8NBvGazhjPYXKwFyRyalbeOzxqsFJXdof5jP8=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CO1PR10MB4756.namprd10.prod.outlook.com (2603:10b6:303:9b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Thu, 14 Jul
 2022 03:21:30 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6516:e908:d2bd:ca45]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6516:e908:d2bd:ca45%6]) with mapi id 15.20.5438.014; Thu, 14 Jul 2022
 03:21:30 +0000
To:     Karan Tilak Kumar <kartilak@cisco.com>
Cc:     sebaddel@cisco.com, arulponn@cisco.com, djhawar@cisco.com,
        gcboffa@cisco.com, satishkh@cisco.com, gvaradar@cisco.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: fnic: refactor code in fnic probe to initialize
 scsi layer
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1r12owf9x.fsf@ca-mkp.ca.oracle.com>
References: <20220707205155.692688-1-kartilak@cisco.com>
Date:   Wed, 13 Jul 2022 23:21:25 -0400
In-Reply-To: <20220707205155.692688-1-kartilak@cisco.com> (Karan Tilak Kumar's
        message of "Thu, 7 Jul 2022 13:51:55 -0700")
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0085.namprd03.prod.outlook.com
 (2603:10b6:208:329::30) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12d41459-69f6-4d10-37f7-08da6547f1f1
X-MS-TrafficTypeDiagnostic: CO1PR10MB4756:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xaBDIkbGPIcaHZ7kRKdrIKKU84LaPDgdWw3gHRJl373zIz3eUTbgL3nylwyJt0AtJJZpOJ1YCUo+xc4dKqUXXznpRzxMgIvIuxmE1PsxF3N6j5hPZn3sunf+PEpxFYNzrAIxQ5Bwxd9oomKY57hEUDH7w6CqKJ2hwU2LEblwezOtfM9SxcCPK+RY72BfIZ8bw02ynePZIdgwweAkog8R8rx3FkvDdavt9+w4INLHeT9wAKeHhrtHGyFh1Fhb/tOiXcR82K7Om0Bss4+Elre4sIzSjW7dt9wOyz6U1tl0F6COEfhV6wRAlDqLgEffntAADoViXGK7o1a68v3lHnSLRaqaVQOM1nbKPvhrK3ZxzNykOp/dBcysEgnE8FPGoIpPNZRbxrLpXELrs8/j3X1v2ULOEar5fxW/SYwgfoHJ0dPbnBEhOpLw7px/m5qJXz+fliUUVMB5jiZIL6CVn84MPPi5CUe7i6O0MWITRjUU8l1iuZN6fmb6BvKkAKWWnZ6Npo3YSJ1ypcbwHo38KtWiSBkDgTFSovWZIIFk019n/9b6YtxempbQ4b4daf9rTpLqnQkL/sEHI30AbW3+O3LlJfjRZEIWlCsynfWHBB0guIsHI45R6RRTPXxwexyH8lz7G83TI/MUK091Y8jj1fIlVNojbQ68vWOcez3tdZlEhqcBtz1fTH+ICzQNEWDi/Oj8yDAKUHxlQ68QJV0bjUNMbB1lYPbMI9wnopPFuMhyQjNXC+T05jXCM1bqY8HstF8CiFKNapXIMpA6vyce/AFljLZNYd2xKABWHrVnsUvZTQ+U6XYZ22xScmFwT+UY9NrB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(396003)(346002)(366004)(376002)(8676002)(6666004)(7416002)(186003)(66946007)(8936002)(4326008)(66556008)(5660300002)(66476007)(2906002)(83380400001)(26005)(478600001)(6512007)(316002)(52116002)(6506007)(38100700002)(6916009)(38350700002)(41300700001)(558084003)(36916002)(86362001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O90Uplz+juI4un5pKzp9A9x+OUNjT/tDCZTCuO4IGc+uEfCkJlOly1HoMkfp?=
 =?us-ascii?Q?fTu7qmQPIJoW8EvPTB3gTxD7MQLnhhAUFkNQ+AHihwoHDlcxDUfvXkhInCgO?=
 =?us-ascii?Q?SZA3l/WhwfynXsQZoEDqcifHfG1PzESi0ttwJFd+xvvsP1SmyZPT52lrXHmN?=
 =?us-ascii?Q?hzbNjte6Efq+YyA4Sbpk8fgib4t9ISVDrErgeC1COiqvWE/jbej52qJoRR9U?=
 =?us-ascii?Q?Iiv4clllEjg45OQJTBVuMk9j3NqS/DWIGynqIsUQGw2PVA073VEa82MLbhU6?=
 =?us-ascii?Q?orkszRjcRUb7fadTmckuGf8osRPTaUY/ukZOjyuriiBkLMv99qYQ856MkPnm?=
 =?us-ascii?Q?Cbd7ns5hKJlQarc2TVLm6vYtCvKp63FXLe/z8x+JOfS1rrQ/E+Wk6aMFQiZW?=
 =?us-ascii?Q?nhOBd4Bl6g5jOYM2Ph1U1PJ3X68Yi80ML56ZM4yzhpl0QK5tBSB+bav/2SDp?=
 =?us-ascii?Q?5S9uz7sal4iNBMq6+cXdzOjLVceql+2TWnodeEmVXApxeCa1VS80T4CcQONS?=
 =?us-ascii?Q?T6HYm/5yLa4WdFMGvsgy06HPey99nrkzAbOqe2xNUCrmqNxdel8WihMsXM8g?=
 =?us-ascii?Q?5nN3nqOzJvukAc27FYxik9UsYMv6CTLQEsuepXOKjGNmiz/y0tRrFL66200q?=
 =?us-ascii?Q?F6s3YtUJlekXyPwG3V3xHyCp+3TDXlUu9NUJcUfFiGtT8D3E1u8sxEaaRfVi?=
 =?us-ascii?Q?VE9+0bqDcVm6qFkUlD1hXBPNVDkRoLz8CGKrhIOORhoIYKZWmBYPHt/6oaMj?=
 =?us-ascii?Q?vGooP92aUQjIi7XUMCzbKEmmu+nY30RAZc5vixGZtGoj1MxvDkvyKMHJMmz2?=
 =?us-ascii?Q?eMQOsw3uOoh6B+rVKsLxMS8HJKijm8t53U/UWyDL6syy4KxZJwg8qyf/bexB?=
 =?us-ascii?Q?VupoVUtvtzUSmzI8G1Qg+llBj3nYnOgLYpIgKR/jFvnHuSFjEn0V5bwtChyO?=
 =?us-ascii?Q?F+aArLpeuAhV4HgT6mObKFxwFXkNk4wpvAyIxunLVcpO9YPIXro5fvPK8B/3?=
 =?us-ascii?Q?a19BLOIzjSGejsFMT08z/fmC6YIx+gp5/STUZKdCzYtZy7rXg6MCVKS7z6qh?=
 =?us-ascii?Q?wbRPR25sPMbddO62tDFegnLb7JaET2GO/QELEFbB3mBkgwEafYhcor+JF1Fs?=
 =?us-ascii?Q?sQnFhBmAwyxRcK0EZqTc0F4D5ahWk2W4w2C/ZkQ7LsH6vEmb8t8K+rNGbtRC?=
 =?us-ascii?Q?vCwxBQNkN5645uSVRaK841JGDo7QDBjbiqf1BF/GakHFu+1hNRxMZHiJGPSw?=
 =?us-ascii?Q?K7EKXdQwY9qfDjbkc3POyXjdubkighSVyv9jJCNqHzqBbQUY0Dv1SJZAUEKz?=
 =?us-ascii?Q?c8cwwJnahe8wsovemWTzPOSPtl4ppRLsmrXsWpbQ5vSk1MOnNCFyqNJvI+hT?=
 =?us-ascii?Q?d20b1muuNzfbxsX0SabHWTo1IwaJzNjNBq+GO9YkU0MNW4IVWK01NdJ/CN7l?=
 =?us-ascii?Q?i7uIH3+TSICTwnoXFYAJbdTd3xe7HdsKUNu58TUwCbhIB+Q8EPUjj6390fL/?=
 =?us-ascii?Q?95Hyj+rWjXe9uqvuRBLWrWFZ1E87/nEZz2ldlMHOjUH2dxUuvS+qfwGKrAQF?=
 =?us-ascii?Q?3iulL4up5LmcRirtj0jIV/VYIEYkReo7z7dU9ZLtuH4oywdMIsuIE/MvzCwG?=
 =?us-ascii?Q?fQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12d41459-69f6-4d10-37f7-08da6547f1f1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 03:21:30.3953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ErE0r9PDOtz8Q0WjNnSCHuvgXNtZnBEbU/OBbzg4HIn1okTfPd5fSlSt0kBYDCCYWVZ80iCr3GfAg2H8TXC8fr89wHs1Y6o10rHTPUaWXqE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4756
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-14_02:2022-07-13,2022-07-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 mlxlogscore=665 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207140013
X-Proofpoint-GUID: 9CSNbFzrPv2vpolG5E-q6xi7ov3Noyk-
X-Proofpoint-ORIG-GUID: 9CSNbFzrPv2vpolG5E-q6xi7ov3Noyk-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Karan,

> Refactor code from fnic probe into a different function so that scsi
> layer initialization code is grouped together.  Also, add log messages
> for better debugging.

Applied to 5.20/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
