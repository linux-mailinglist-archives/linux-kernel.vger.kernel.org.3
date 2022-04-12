Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70E04FD3CD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 11:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358986AbiDLHmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 03:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353779AbiDLHQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 03:16:06 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF8B403F0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 23:57:25 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23C1fvVg031505;
        Tue, 12 Apr 2022 06:57:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=SYm94z001zvMwtrZJlgKIaJr+MI/AuX7OJWiiXiV4mA=;
 b=KcyZikJj79C1k6CffJyKp0mdy5zyG8PptFVvsqfVrwadJQAEDSQK+ef1O1uJZ/cf2m7T
 SlAgugykc7/NMByC/htjKKnngF0zLQ41n6BP7t4l4kUgf4JgTz6AYVU01Bjo/JBWC6r+
 INQ5JqSVJhLr3sbQgN7xLd8uBYRJ8up67fWH2H5qxHefUBpzf3P0w5FgjhF0xe7mFYSD
 d9AaRR8fjZk469IwbRr15XtQhvNi8C9aqdpbhhfsmWb+bgkm13WhP0gqihhfgeHvPvVG
 oLe3DG+XXshkYGQA1QLscfXmIYh+mdPrZko9YL5rcUeZo2ljxlWTFcNfY6g3y1lqOlni VQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb1rs5v1b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Apr 2022 06:57:20 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23C6uDWW013500;
        Tue, 12 Apr 2022 06:57:18 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2048.outbound.protection.outlook.com [104.47.51.48])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fcg9h2pa8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Apr 2022 06:57:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iqUgNmqq6OHTOM+i+iWNOTYX0Ni4pJKNkej/H0pRpODPO/2GFmc7+xc2WdJXvfsPl/sEGRGgdgTaXZIdO/w8OK/fRTF02Sk+Gb4z+dS0YPMw+FYwK0JtvLVliIRbL7qvk/q9qNifvIT25mOtvxNk3BV1n3QLvzLevfHd3Wk4B7pa3PQF22JRV+uWQ2madQZ4nwMt9YlxwgIxYvuEVO3efjDqdsoOvsEqWqcagktUupQNEK8OPYRPN8Uvd9en1V68vMu3S3kZPrhkegOatxsR9jEshMWyf71P5pwGdHHi5/FBBC/HCBI/e0Cla+kwV3UQzLyuWtyrX4bIM/GpZXugaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SYm94z001zvMwtrZJlgKIaJr+MI/AuX7OJWiiXiV4mA=;
 b=BYGlh8ZGw87iPZ8Nj+LeHaF1BuRf3D7+qr4BMdO4TbM6SDX1Zp+YxdSag531JeZ6Tje+RVOKlYLCF574viGqW06BNAbth4eD5ePRGY8RMTgVjfseIpONf3vipvgK5sNL8kMVKm45v2lepp18sxaEfV63YkX70CtkLRoRa8pUoLBImdwEyqtDPlEBYhdW1C+3FlVZmzhDuh2MzJY9DJ2ubWZeRguKclHIbPGGxCRWIff0FPpSBndv645q3p52vfQnpMmlDt2Y7Ur1Yk7XAQKWqMWrZUeMMJ+jFQC/BEQ76qy+z5DBuh9AhSS9QCHYUKVChWGdZ4939zj0y3vhE0N7vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYm94z001zvMwtrZJlgKIaJr+MI/AuX7OJWiiXiV4mA=;
 b=PvPt8JflzSBXmhNkTrLFNmLfJJflVJWYWTjbAOThvTul8OjrocyLjUEhG9niNr1vsqYp6i19vR3ZaxxWbfat+xbp804L5Z/NB3UAEjlgLqnTUmYuR3w+H6FmHysLXXuk0VXcV6Zz5gDyfcmxEB8HvnIrCqykxGcnpinab1kMXnc=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CH2PR10MB4181.namprd10.prod.outlook.com
 (2603:10b6:610:ac::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 06:57:16 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5144.022; Tue, 12 Apr 2022
 06:57:16 +0000
Date:   Tue, 12 Apr 2022 09:56:43 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/7] staging: vt6655: Replace VNSvOutPortB with
 iowrite8
Message-ID: <20220412065643.GB3293@kadam>
References: <cover.1649706687.git.philipp.g.hortmann@gmail.com>
 <3cac1ca7000a56e82b390ea0ddbab5aa549ee7ec.1649706687.git.philipp.g.hortmann@gmail.com>
 <20220412063731.GA3293@kadam>
 <25a1bac5-7758-9602-7c9f-9d8b02d845e4@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25a1bac5-7758-9602-7c9f-9d8b02d845e4@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0027.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::17)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1cc035b-2674-4ad4-0a39-08da1c51ad4a
X-MS-TrafficTypeDiagnostic: CH2PR10MB4181:EE_
X-Microsoft-Antispam-PRVS: <CH2PR10MB41818B4513BF39B131B599098EED9@CH2PR10MB4181.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MjTZkgl20FM3NdGeUw+KBxSVPajQp2oYN9GEvNO5kAqkqsahUxrWxpGVgkZCtrAjYYSSRPF6Z3Xsw5TxypwXDXDVgUdBwCis84oRcq6G+GD6eoGtJWkkoaMEsNk/94BLqhn0V6DtlnalwjjqkERJ5Ur/uQVMQethiy4n/54A1yObZ+q6UeVL79Fv8zvopYSzJKeHRB0vIj6LsJN5OSOezEGO7GYetnq4+eZ/p3FmcgJphLDTmUpesNfduGwmqWbbkHowe+3dwdn6s4nXSa2bNXE3eDWK2C5GvA03GYA4slzcoeUIOP+j6fNMON++53UvAamjPk+nSkYKagQqtj83ENbraP7ZtnioA/k4GU+EphOuL6/o5JRgBCEjprkOGpbPCnfoHmWDDJTIhm7lEpRDAobz9FWJazxbKf/Tj8aKS1luQRxl9cnNR9iI76Frwy13Ncizk41CUYe+Zolr6OfmM91SThOgWU7JQG97/AhxNBd8Jcrj0ZMPLxZwy5qCDuAP35B5u3wSCn6R1DJb83IpUzQvLm34QsUygNctCkJt+bXdq/WYEIjhpVV3IxwiApzNeZKY8XGCzsBjTw9KS3R/oausmzmxNeN0yDbDegXeIKjJw7Ildx7MZH/XJ5hN+32jYyMW1W3r2Rc2gKP7BK0IsPDPxvQN5fHgf8uM8Ol8y5FSvZ86SBfUsy2vz+bDDXZ77FXrJkBG/LppuQYqOONKCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(6029001)(7916004)(366004)(6666004)(33716001)(6916009)(83380400001)(33656002)(2906002)(9686003)(53546011)(6512007)(52116002)(6506007)(86362001)(38100700002)(38350700002)(8936002)(66556008)(6486002)(508600001)(66476007)(26005)(1076003)(186003)(316002)(5660300002)(8676002)(66946007)(4326008)(54906003)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3WYpzhy4JdzKxLdj9tOgxig6d/VXhWQzSxo25YELSv+bX3BAvyXJC5eFUBgL?=
 =?us-ascii?Q?i41NBI1KjfCXVXL5eFh30a1+6sB5UTcx4MpgX3xIkJ/Q16Snh/5IJen4kPxv?=
 =?us-ascii?Q?F1XsBqOrhI0IhdYB2eBPPUt6VEU9KAkTWuE84u9+ufxeq2wKafixOsSCkhRN?=
 =?us-ascii?Q?BEBl+loVzVirhlP1TjtGfY+omkCgFimhk7aJf8EuqAZr3CWrbWIP0LZBJnRK?=
 =?us-ascii?Q?8mgMkj19nsvPfbUeBf3hN+bjPYNO9/Df626qy2XrIrQ4/6cIGzZgHML5jeN0?=
 =?us-ascii?Q?S8w3sjPDjAPFfqIlLT+Y0G11s7bqeuzcwnrciLMyFoeqmKjY9HPpe6nRVmAe?=
 =?us-ascii?Q?+XfOKFszzMQDbQel10OalKYKWIq9M7B1hMpgVnunGIGiggfCI8voiC4HSIqA?=
 =?us-ascii?Q?Nl0GtOpD0tISmVw9du4fhTumbV9RHYr75h1yQ2cSV8etp34dyM9vnrcWwtP2?=
 =?us-ascii?Q?UYOdNvpzjmaLjHpnbuZji66sQITBbMvS9eiouu84mO/6BjBNxnm26lnn4RJf?=
 =?us-ascii?Q?lA7jpGb+cxb5Ks7wQtfyDPDigxEKpbBaDxJiRnRsjhwq8YNItbR9Go7RQAXZ?=
 =?us-ascii?Q?FBEf3onhN3DMfzf4LAPcvqSg4Ap8UgugfmxhHW++jaadeXINW2Fleb3SxUZI?=
 =?us-ascii?Q?gTLdtrfnSR0HLd8BAn/yx2i/qo6FT44SYc7JjPhX4ycWeUS7+ywGHGFgDbP1?=
 =?us-ascii?Q?OQQyOgKhqtySLJtU31UzbZdWOeRY43vurQWFIIgL1Gs6Zxxx/BJa/oIno+F0?=
 =?us-ascii?Q?x0WLMweSFYT4B2qXw7EMo36gX+TELfaI/FWB316bNHJ0h5kYzcYW1R55ao1e?=
 =?us-ascii?Q?HWqgQMvTpATIhN4XuuVECIzyIFRMO+L6eSlg+P8YbfjnPHecXdgVOR/lnvyp?=
 =?us-ascii?Q?u55Yvb/JBLAXjtT+T9tn0YNlEVRTyEczjuftZl7cYC/j7+xh0aiqIdfgG5gx?=
 =?us-ascii?Q?aLTsLpkZLdYUi6Jjo4rhk/HqLvrTLU0X/p8Bk2dsMsnsFXe0H6EKxbwXg78p?=
 =?us-ascii?Q?UrGtSEpCeGbCW/ev8f7jspPytAEaR3wcN+EVnLA2gEAvn9ncqwALcIW2MJrF?=
 =?us-ascii?Q?0EY8CJrT/o9OCCJbxYeYqG07Jt1bTmw49BYX/lLG0p5em2wTDPupYuwdZ96A?=
 =?us-ascii?Q?Q0oFygL2RHw3t7L2BhP/iBgid/P6DfJ799XFOZwQUDOFHaWMw76mbsh6uBnR?=
 =?us-ascii?Q?L+zmD4yNi4JrMGSglEKcwAKNg+xg3LJgA1ILEWHHTBk8Ype/VW/8xLXJj1zD?=
 =?us-ascii?Q?drFxnX2fLMqVdhd8qgQrUIq1mtxYvHFAPNcX74Ce8vBlmQ6FGvS9sDNHO3Ep?=
 =?us-ascii?Q?zCpDBEu6K7JNlmXCxITLWGBl3bLvdyaStN9/1gh5PJ0nuGimBb82HSxrwsyP?=
 =?us-ascii?Q?rUx5sytdOcOA4aFNRuELD/H6pEF8s+NsuvnBHSA4diCKjWisF1ovmS4K/Ek+?=
 =?us-ascii?Q?31FAYh0CaoSKE98IRkaLWWgSNgRHc634lIl4mI2pPBTi1oUP4ir9Ev5xawXa?=
 =?us-ascii?Q?qIDZlEakGp2Dkdo11rTzYHi5o2VzuGzQBEeChrztfJKKRwiMxpm015cgUjiL?=
 =?us-ascii?Q?24SeYTv9kztQQPm0CKfXyTu9NpRrXcw/YdjjqDoripH0InU6JXG7VtvruRsc?=
 =?us-ascii?Q?eG9b1OeTLkfWLBC0/bPCEgFVSxK1iUtNXxAK4UYXzx7MUp46ssyxFfglyO/S?=
 =?us-ascii?Q?IEYTMfVRqoXyl69Eongty5KKkcY/At80oj4Z9jNq88VgBe7wuavc+MPKt+sV?=
 =?us-ascii?Q?wo4iD+VWRpDSrCIhhjFUmR5rqa7F0B8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1cc035b-2674-4ad4-0a39-08da1c51ad4a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 06:57:15.9241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ae76Y+qEIRx+AT0/WX4oi+cSpdMoHCLnnHT8ZV8nlqwnHl6r1T0rZ9yrBzgmqhN8Vg6dOwDfliezkYqDfsUDjz1i/pZYNK3n+U9e82l6pc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4181
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.858
 definitions=2022-04-12_02:2022-04-11,2022-04-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=739
 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204120033
X-Proofpoint-ORIG-GUID: hnoaoW14rFqPcKumyfzOaLyqAQNN-xpb
X-Proofpoint-GUID: hnoaoW14rFqPcKumyfzOaLyqAQNN-xpb
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 08:45:53AM +0200, Philipp Hortmann wrote:
> On 4/12/22 08:37, Dan Carpenter wrote:
> > On Mon, Apr 11, 2022 at 10:49:39PM +0200, Philipp Hortmann wrote:
> > > Replace macro VNSvOutPortB with iowrite8.
> > > The name of macro and the arguments use CamelCase which
> > > is not accepted by checkpatch.pl
> > > 
> > > For constants from 0 to below 0x80 the u8 cast was omitted.
> > > For variables which are defined as unsigned char the u8 is omitted.
> > I hate that GCC prints warnings for this.  Useless.  Horrible.  But I
> > understand that GCC does and we haven't figured out how to disable it
> > or who needs to approve that.
> > 
> > But even then I still don't understand the casting in this patch.
> > 
> > Shouldn't the rule be to do the minimum work arounds to silence GCC?
> > My understand is that the the casting is only needed when you're dealing
> > with a bitwise negated constant.  These are macros so the parameters
> > might be constant so basically any bitwise negate gets a cast.
> > 
> 
> Please send me the compiler flags you are using.
> I was using:
> make "KCFLAGS=-pipe -Wall" -C . M=drivers/staging/vt6655/
> But of course more flags are set.
> I did not see any compiler warnings.

I think I was not clear.

Why are you doing these casts?  I do not like any of them, and wish we
could remove them.

My understanding is that if you remove the casts kbuild will complain
and the build will fail on certain architectures.  But I have not tried
to compile this.  If we can remove all the casting let's do that, but
if we can only remove some then lets do that.

regards,
dan carpenter

