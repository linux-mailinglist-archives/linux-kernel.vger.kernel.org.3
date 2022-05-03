Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7DA51835B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 13:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234762AbiECLlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 07:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234763AbiECLk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 07:40:59 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7C234BB1
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 04:37:25 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243BDPDR027626;
        Tue, 3 May 2022 11:37:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=Y/oiPWwmfD9AlijOFsMTosfaNt+M6v3io4+sJJHtRVg=;
 b=Zklq23vy3EFffJ+xa9hZq9bSClTsc7yjyHljcsYsJWyiEBbn9CqRJDT16cENuBYOjxRl
 ZOZ89FkYET2/2Zf2J7k5kMIe89vZad9N0lCnjEg/za+0tzPmF9ZVCy210ebTH1KWPGKF
 iDPJML9pEeGXHlNgeRbwrA4lnY+WQUYWhgv0/WokCDjC/1HCtOesXA1zvZp+Djex50Jm
 M+ypd2U32fp6llx+9EZny6vM6nSXbmcXCZsdQMeq4nvxr/NcIGDfFMZUn90w8gADBZ1A
 g2V4ojBCnsX0J5z1EDbcVaeXiZBHxcGw1R3k7yB3p2qmVHD53V0BhJJutIF1HUdh7oXT Ug== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruw2dg16-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 May 2022 11:37:13 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 243BVUEZ002745;
        Tue, 3 May 2022 11:37:12 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fs1a4ma1h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 May 2022 11:37:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g/mp3E2K09HR9n/bWMa5QGx/rT/+/F2uqNiqTJyeZlPi+bxm4l86904oQkOXc+LfT6e4qXGJvdUlhImA0I3CtnvPmtb1wHmtvsnZxb1EdvMmcZglAGt3EubuUkU6BLommesDy43F9R9XU5cE6uaV1nzXC0bDhPYqJuJohMC7egWq99+2SiGsmnjmr/E1P7S9r10OZHSIx3iMUFTL9ZgN44vtR6gQWRjj/115ru7JLbgPUb61slBtt8u2QdbrkbPBWGE5VG1hO/YHgoU7Fq5XcosZXfnPs3gticWRu0NmcoQBJmiSXm64ipQWftmG0mRUztrPZEV0gJ2VVtSyEouzvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/oiPWwmfD9AlijOFsMTosfaNt+M6v3io4+sJJHtRVg=;
 b=SfOSGRooYbt0DLbQQF1yDnXORnR1LUsB547OiSLCfuinvdcrSrH8h9MdbbhXJL9eoXowg4U+ZG7YzTbCfjWGYDMVCxfbbowRzYMPthdNWKSHRk1xX2kH3tIE3qlJkeUHxuKw1F1TjJJOBmzuiLm1MHOvo0An5kiwhJFyq7C0GoT5fRTGwRD+3dwAt/mkM3qhIKAhCCBlRU2xVXw1SN9Eftx8FCO03aWMTJHYoF6ePQd91FP7QirBR1y+9zOLE9Xn3cNVP1NAtvnqeXlpGnjpsEmz8W+UsBrO+X3Y/+PU4raT2i5k1xu84uwfDIn3Z4RfYgLhsz4xWGv+gHNuz3csZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/oiPWwmfD9AlijOFsMTosfaNt+M6v3io4+sJJHtRVg=;
 b=c2iniwk/BpmVegbyS4NpEMVhs4aqjWNf1XFn0PCGy/8OP6F2StdxaAO4U9XpH6Mj18tVUABv7UIAyfhXsGk0cxO9NmG/F3/BzBQjG/2SuFcW0reT8YIHWaqv24RkbnsSuV84KUupBVXlEJcRizuqNl5LovXNPlSwNeDqXNmktNk=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DS7PR10MB5184.namprd10.prod.outlook.com
 (2603:10b6:5:38e::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Tue, 3 May
 2022 11:37:08 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5164.025; Tue, 3 May 2022
 11:37:08 +0000
Date:   Tue, 3 May 2022 14:36:56 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Charlie Sands <sandsch@northvilleschools.net>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, paskripkin@gmail.com,
        straube.linux@gmail.com, fmdefrancesco@gmail.com
Subject: Re: [PATCH V4] staging: r8188eu: Remove broken rtw_p2p_get function.
Message-ID: <20220503113656.GA4009@kadam>
References: <Ymy7C/A2q+VzfBhO@sckzor-linux.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ymy7C/A2q+VzfBhO@sckzor-linux.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MRXP264CA0011.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:15::23) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 125d00ad-361d-4d86-6b8b-08da2cf94125
X-MS-TrafficTypeDiagnostic: DS7PR10MB5184:EE_
X-Microsoft-Antispam-PRVS: <DS7PR10MB51842879C2C0221059A30F308EC09@DS7PR10MB5184.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Yjkr6O0Du0aqMseLussZsj0ZxzPBrJP2mivhR4M8qTbPjAFj5m+G7ACSr/lvJl859fuOAUi7xozJq1Ld0Pw408RxPNk8Fhw4gQRpkvdM2LwRKTtBgPmSSGI1N279GBvrYaKAGBDFPtv3jFQy+xUjSH+QPIVOkRt/UAipk+CvAiSNKXRK0RzEhW1PSxYMNgkn+adTIHdF3BdLMOxn0IcAXj0vuijqERTQOzcva4bdtw5OU2cNbdGJzP5xIhEar4A22SXBRHuIXfzdxr/+6QAg53oHrB+DWkQSA4blkuDPCA6ILK+jxL31aJnR7PwRam6eZjfVjPinyc/00RmxtCqWcdgkbBShPqtSdu0pG3Q6pc7JxrmHPn9gDUAkT54LYxAh9tM62kL+JO722OLOUZNG93fdKDoo4+10EVkmV8unZpupVhSwWMIan67dUzcZ7+F+xlasauBHUbKezSwIplQsPJ6iAMLeeH50dbt2mnyoWb5wNXeMJUtjFjfkSpUQ9GBYxqP5dvpo0amlUwRiBNHCq9IPjpb4uO9JIpk8IKyXR+uw2TdBckvuf0YWcpG5qRiici4fVGK0bgaMj4swRaTxdjbd4Ohu08s6kLQvUbr+Nj5ziHutCrCm8+oFadVwigtOYsQrlWP+1IV7RkxNiI4cSQDNnTY/CYbRBvx+Dz7m/Av8z0ZR8CjzN2Eo4cl8XcMU4eIa0iWgR2IBuLFxQQ8R09Du1VilwPdK8cX3lbulZQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6666004)(9686003)(26005)(6506007)(6512007)(52116002)(1076003)(186003)(83380400001)(508600001)(2906002)(38100700002)(38350700002)(6486002)(4326008)(8936002)(44832011)(33716001)(316002)(6916009)(4744005)(86362001)(8676002)(66476007)(66556008)(33656002)(5660300002)(66946007)(70780200001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TLfyCgOkjC1QxMijY1/WJA9PnD0caEhsk2a9ZRp7MAg1pcyTDJFcsFMpiwWl?=
 =?us-ascii?Q?nhPIMOh/Po+DKyW0IAlpWvvaSOMAS28jXsJZa7D3wDWlQggXokDAKi22U4aY?=
 =?us-ascii?Q?d4cHqW3tw+UkRptrEO/V2yWEHWXxYYci0ZMg2nvI4Zuj+jUN3Sil2yLB2avw?=
 =?us-ascii?Q?aNVradQzw8zdF9hFkTTc0Pd7PlVrSigjkAZFpLL2M8qy4ytlXiOd74JUxLOg?=
 =?us-ascii?Q?Zx0tMjBwqSpYklw5mXLcHCWy3YhMCA/rvhTuHjOfLSqLEu5ZnDXJYWanfmeh?=
 =?us-ascii?Q?FzNaoNVkLvfMVxYdPN14GxSWvCt4FAfsXmi7iVmcEoUnOqV+0MJvb/mmaLB/?=
 =?us-ascii?Q?bKB5dt2HjZwU+5Nmyi9uvAA6nKQ06Al31sGKB6LHtzpI68r1ykonhR0To2TX?=
 =?us-ascii?Q?LpYj4rWtmClDwxJ7Gq8/b81jUJHiBVIp5zkMkDJ8ucbmCn01JHA92OSRRTms?=
 =?us-ascii?Q?2AI1uO9zrv1V9Ma4tIOEbgajKIef391mhEcFHn0mDhB2pIcEcmpmpGb4Ni1g?=
 =?us-ascii?Q?eYc9JlVD2cS8WBQGPUjaGYrcUtYFelzZjvDJr6llcjh4C5hTIE55VrrIUoju?=
 =?us-ascii?Q?36t7M8sIT1yk9T3MfN66iar3y2z7Ltz+DI81/8EYB4vTrO0uYsgtZKDigC/m?=
 =?us-ascii?Q?xAvyk5MW1wNr1D5WJqm+zSBFLjgXkkq9FOP1rs6WXUziUGdPjIvP0vEjSJLK?=
 =?us-ascii?Q?Ecdl0M0LPclQmImUkR2e8HGD/QVVB9JbTDL2B10o1i/2sFDxh56tSpGlBZRD?=
 =?us-ascii?Q?vNVxJJpYf4nF4m52evVLBnuC/2UeRl+QaVCETEnhLPyqAywtFgu6PrAsnnHJ?=
 =?us-ascii?Q?H4srIfVotHygtFudMJtoWf4g3hiDZJoi7kEbrrQihxF3xjuh6w2N3SoCmvky?=
 =?us-ascii?Q?escQrEzSD/E0KHB0wEyWVvlnhtcX4mmP23iH1Ezr4y70njsUrghmFJ7sPbfD?=
 =?us-ascii?Q?0L6y5v2dc8HRdC9OZVyR+Gh5NJ+SivppMrATOrwy4KAVTQ+9TQCFcx44D+pB?=
 =?us-ascii?Q?tNY3HU3XL+92cVWhkGC3U1oHTiOFNeuP3h1KVm86oCvMCc98XUICG8illOU5?=
 =?us-ascii?Q?XD+Rco7wveSn9Y/p/TZF5cDZPMjaD5fcPs/Sce8BbH8GIEvuVBdEr0kGobrC?=
 =?us-ascii?Q?/qHY0AKiD5vm735hid+GkvWJo114m7ohSyJ0snqc6gJCG2j676/b03gj66ot?=
 =?us-ascii?Q?MUvn5zrK8HAFvNHEALRr2fDFHnSrx/Cq5jfq7CzzCt6DZS+UWCn6M/3+4elH?=
 =?us-ascii?Q?8bYutcuCzC0YDDLXkxd+uSGjrYnZdOioEpDBsF5mrmo1oGsn2qmkFSAVKOGt?=
 =?us-ascii?Q?oHL21QuL1ktEZ9W7kVaJkeGKUHZ6gYso7eYWGUSBC/ckr1P0lhYrugKZ9oGX?=
 =?us-ascii?Q?t9YiH3PHR7HgJOM/MxISSmZAC5U6mzDLR7eazFETXYv3OVl48H3c+2gj72Kl?=
 =?us-ascii?Q?+RpRd6tyAf/u4mlY5heE6yYM25VtNOUQ0tU9ubB9URt/eWt4hIgrjlyAKPeL?=
 =?us-ascii?Q?hR5IVxdcT8RIi+nTyFedNx0VxhGesOUjtKpg/yryEezDU6HfObGPRI1nYVxv?=
 =?us-ascii?Q?KcX5/ZKIHYHz3h1APwOsMGYGX8aQ10oNZZbdV5aStVD679dMeFiKidhePDvH?=
 =?us-ascii?Q?+cc6SLFg8dqLAwsBS1MTmoOiT1FMvFlZAiVjK/OGaWQzaeAwt8k1w+aIB7dC?=
 =?us-ascii?Q?k8+GhOyL/bg+2ktPw72KYW/RKz26Vvw5r6sFprhcCYAHNERpCvWMig2sFAXR?=
 =?us-ascii?Q?2PLsKSpsxILLbWIgW2s3yaQgHaJca7o=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 125d00ad-361d-4d86-6b8b-08da2cf94125
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 11:37:08.1702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7kSmQ5ez33CG8JjOg7jQQj0O0/3OI8z3jDABd0hOYkzMVKEzf+Nm63FutxViXMJtRxvM9tkHb1MflRQE/hMmFffiC/U17tAJJufUsdOToT0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5184
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-03_03:2022-05-02,2022-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205030086
X-Proofpoint-GUID: inmLsHLhOf8do4Oo00ID4CQ6bXR0iKJs
X-Proofpoint-ORIG-GUID: inmLsHLhOf8do4Oo00ID4CQ6bXR0iKJs
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 30, 2022 at 12:28:59AM -0400, Charlie Sands wrote:
> Removes broken and unsafe rtw_p2p_get function and all of the code
> associated with it from the r8188eu driver.
> 
> Signed-off-by: Charlie Sands <charlies256@protonmail.com>
> ---
> 
> Follow up to the patch called "staging: r8188eu: Fix unsafe memory access
> by memcmp." 
> 
> V2: Fixed checkpatch.pl warning and changed variable name as suggested
> by Greg K. H. and improved error checking on the "copy_from_user" function as
> suggested by Pavel Skripkin.
> 
> V3: Return -EFAULT from the function when there is a memory error while
> moving it from user space to kernel space and fix incorrect subject from V2
> 
> V4: Updated commit message and changes to reflect those sugested by Dan 
> Carpenter.
> 

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

