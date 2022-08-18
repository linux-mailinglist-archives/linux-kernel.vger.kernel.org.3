Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4257598204
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 13:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244327AbiHRLMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 07:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244316AbiHRLMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 07:12:45 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB64AA5706
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 04:12:43 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27IB7KKq032507;
        Thu, 18 Aug 2022 11:11:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=+QgJn7r4vShrfQdNcrR4Wah9YHfX8ivn07lQGVG1zCk=;
 b=HsQ06cn3+gct+xU4MSw6uDKsYR/+FbAbzER15a7E0LvSYLFGTriLpjGlqyitUANp9xWs
 HZgxKJfryzL0aIN75b7PK9Hna4K9gZOUhhp+uetxjcv0RpYRCLuyzXgqZxXMU3JZheOd
 OxfpMWVmBjABnlAN/cO147sUq5wdXCwjDdpFyu/l+UNFOsRweBpz71eaMkh+gv31kmk+
 rpB/br+2T/8nDDVuUmcrtI85d2y5cFz7p7ZzYlvY40Iy9WYxF2s8TLOZGhIqKOll8V1P
 MzigwbzAEvDdr/qaKtRVmoziUXNMjaBHNbmOSA3Yl8R1rfaAV5fJ8ldQVbnIk5oG0maN jw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j1m92008b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Aug 2022 11:11:49 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27IAXqQp020827;
        Thu, 18 Aug 2022 11:11:49 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j0c48pxf3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Aug 2022 11:11:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XTY8hXGpMB+tBJVbU/IZexh96tuYVDGGpif453qToMUGlcqMdHM6qiM92xM0ZO+oXK39Trjll/xAPSyY8dcTEsjQdbYCIQB8MWCYkiV/mjts1gQNdAYqIAOH3ky9aUmtd0JhUJ2k9zXcvbEux8jhjGwEcIDRlpcZIDQJR0hKFJyjXaXGhKrdferyW3gi/wt7/Ww7dhSVm1P4Yc3S0p+VpJMsHMqqV4xdDiNce9UGo/eVJ1qyLSwEexKVFMtF6ZzBlGka/rZopp9kn/gpeMCe/jx2CEB38VGkByTZDRGSCt6JcoYtQDwugOJ6o8+tl07rA8UdCpqZlBfKI03djJPh0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+QgJn7r4vShrfQdNcrR4Wah9YHfX8ivn07lQGVG1zCk=;
 b=HI8+j5wR3Lw+abmxmXGmRi2IzRwUB5wxzWgrI1KrBFCVZ6Ise/xRMVpvnwbpiuqRot+5iLzaIifI98Rr13GATPGDrQ3pJqnii+YXNPN123bAAq/2BjOuiRKUkYSJnDmak8g9hnJyAnZGBKQoEAs4n/5lpwDLlAAmFv5VIYYTubxqkHCRjmwO/sy3tQCDBIpSJgmAji+tBM5o0OEr8F8zAkV76mXd17c7SnkR0b+P40cT/oHRjCw/TA5n9vwzNxMvC3Oi7I2yHQZYoAydatl5nGKelSuAeqT4Tr+1erMcOQnxbJcNCRg6Ul9Pf6OINs+A8x5MJoSs6NzB6Gd56d3m6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+QgJn7r4vShrfQdNcrR4Wah9YHfX8ivn07lQGVG1zCk=;
 b=uClVAXq3vAphX5vNNXICtnTv/8YQ1js98L51EhZQ2omTJdllzFGkT09kUMuE/sFR6SMoZDO6sDBs8iCShyNfDC4DsTxrpKNKvqFK1kVC0QIwmQwCMhkQY0jEy9/u2jxOKPh/7bzk+RJehy7/IrgZ3cvA4Iv9QIZaf9dwH/t99zQ=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BY5PR10MB3763.namprd10.prod.outlook.com
 (2603:10b6:a03:1f5::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Thu, 18 Aug
 2022 11:11:45 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5504.028; Thu, 18 Aug 2022
 11:11:45 +0000
Date:   Thu, 18 Aug 2022 14:11:19 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Hector Martin <marcan@marcan.st>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [asahilinux:bits/020-t6000-dart 7/11] drivers/iommu/apple-dart.c:918
 apple_dart_probe() warn: missing error code 'ret'
Message-ID: <202208181055.JPFYIeIR-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0003.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::8)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f461c8c4-259e-4d54-4254-08da810a7018
X-MS-TrafficTypeDiagnostic: BY5PR10MB3763:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WjgjW2BRGaX8yHAYxSk2Ux/9j2Vr9iDIcIpq92hSS4u+oiApMd6/oqQEnRw9t95n+VTycE7GMRff5OvIGzEEvEHM1StgoVHRSj7D43bv4svDjKAITdF29OjdTszrXmOfJbif8CaUgKKFvLzXGilG8zg+0+qZIOqOfyYJ2W3dMdLiO+WZWmhwfgk58Jj+rFRf/Z+oUo67cErGtGegz7F0mAh1oVYMEMqbTLF/eebR0QaK+jrPmiku7TRd9kQsc1e1jaRrG9KFUHV7MNDcWR0tuJXiFYLN+J9vrjE/iS5T81Y5C+3Q8yGUgLP5Chg38LyRY/T9LoMIweV+hT5DPUw4eAyUQZjzPll91oCMB1CY7RSVdBuyfU2trj+5XRLxDuH3lJK79ytXQI5d9mgdbeS9yF9JxaaqDwefp8qn2A8d1tASN5FbBxJePM8TOkAqaXz1L7YFlN+WGLyil/HhXEEuoMU8spl/vgPsKXJ4EMrW5YqSdY8Yea0gwWei6ocmnJ77KaRV9++rGDr7TME/j/JnZVx2lrcItw5FByYYhon+6UbqV791x5Cbeb53cArpLG6AAaNlSCbTBviFTCtPNzU7xIijLOoNnrHPv4PDiP1J2U3zZ/FB4J0IOvz3guz6CXQPzIWtlnBzkWrKerSFJToh34r8PeDhr2H12P5jd81qKarE04Burc5Z3nn8+1e16vxqbDjdXmdagrJnLQYGhdHhwQrGgSlzdBE5lzqm7USpgGPAWNVH0j/FuQpT3OP3yW28ppGjDuZ+2paB3a8pM/aCXwx55nJfGq1PJVi/wLbWqvRPGhM5EGG/Ew+wmtjXZ9SRzT9QtmCH8b5hur5BkX28GnuQgZqlLxBnF7tsPu5vo5G/aJ1gndqVQnjdkS8ooXcw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(346002)(136003)(366004)(396003)(376002)(47660400002)(6506007)(38100700002)(38350700002)(52116002)(41300700001)(6666004)(186003)(1076003)(6916009)(44832011)(36756003)(2906002)(5660300002)(66946007)(66556008)(66476007)(4326008)(8676002)(8936002)(6512007)(316002)(86362001)(83380400001)(26005)(9686003)(966005)(478600001)(6486002)(46800400005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NKPItP065E74YgsAGkqaesNoiQrCrfv1bNUzb1h54uGSaetzJbkX2DvOyxs9?=
 =?us-ascii?Q?NJWc2rFtcuESwwBb4cDnRSrNaTVdPpELXgQ+vf5nrMAU0D9fEl0LJSEhE+36?=
 =?us-ascii?Q?fVMb9ypsPsyjcsMN8biuVyHD0RpbX/LL190uFwrGp4SDAmqIw0YX0DAo5Fgl?=
 =?us-ascii?Q?IExZXoDt1lJ+AERiPjknt9eVTpWP+0Kyfjv2JxZ9AgBdSeCWgmOJJ0TJqJGM?=
 =?us-ascii?Q?MknGHCEpoBoIg5eLGqUhFYcYLI9jBbh7ONi/CM9RqjDMFgHDQ8wya7AJSs9U?=
 =?us-ascii?Q?WtTWSaRYhAUZ+GQI2KnaAdT2czFz/yT9j4AfxSxH1z/qsdPOBZx09KH/3+9F?=
 =?us-ascii?Q?9ESMkjURD0lm0rmdgNZqSmRE4m2MiaLdnO5rvR+4pElh2acQDgGmvb0ZnVjH?=
 =?us-ascii?Q?ZFGH32awur5g5J5uUVA094DSROcNyNr1uqrtCxPTQLK9nDXkdhGYwe50R9dN?=
 =?us-ascii?Q?oGU2YPoiyTf+BgHppovKWFlV2A9h6ppnnRwS/IJ1hbbaPeWQjwjbEFv3KEI/?=
 =?us-ascii?Q?wtcAlGA1dBV0vi7MeJ/KW9u+jj8EXq3jbXcu6GtWAZ7wh0Fvu00NLBqVmd4T?=
 =?us-ascii?Q?GJXDyglT2X/nrcsqJokPjDOZndBQ9j8/4SyQEsZZMUAp75db9JCQmlcC1I6X?=
 =?us-ascii?Q?MDTqJtTVX1bpDX7Y2C57JvaHh3HbxABpqCQNSGxydvYgP4+nOVcxdnVUx0bO?=
 =?us-ascii?Q?jXFHVIldyJoE64FzjsrAjgF08EcFC6h19aLbsFdf5rD0wrgIJX+8ITUbKUsh?=
 =?us-ascii?Q?Uv+I5jU1GcpdX9/gdoFq4SokJp3hPf3mgKwFKo+cRo6DMFSH90Pil/05K/6D?=
 =?us-ascii?Q?2j1HV8I4tJKLuFkkziyyf3RGUqM0aE/AiznmAzDDKK3uJ4ViwBs04zAY4Xca?=
 =?us-ascii?Q?EpUbWm4dwaWYS88/1QM4gFgLRQauMT1wxPKaQIw9DSwG3TlrYzu5P5nYyFKR?=
 =?us-ascii?Q?+r40tGhAkkQKFvrTEOdWPJN24/hPuNyIX1RoN9NdQ1rkyBL1umhQGiCjujo2?=
 =?us-ascii?Q?IYzTaUkyLVMYM9tv8RvAs1cvmX4dKl9LIne5Mf4Z6CR8BsaewF3+QlHLTpl+?=
 =?us-ascii?Q?oiENSPuelo3/eWAfO/x1VJDBQpFlweSc3WaGFHjEpjve6N981HCD/lx2dg7d?=
 =?us-ascii?Q?Nr0Nq0z5w8+BxTB023mq2vQQnE+2f0YRqeTMzXYaaz9B2aaC0OGydSKXIuLh?=
 =?us-ascii?Q?aG9+TpSwsBYcIYtaBM1RFTIkA+6jucfkW4uE8ZgWohGcLyEiVNOLcJpYEN4Q?=
 =?us-ascii?Q?Q6MStD2rvOyNVGjn6h9HcdLtjYPJXsiEjADDRiS9LnhBCAOprnLgdwdu650t?=
 =?us-ascii?Q?T2tjaNquoV63BKQ4+NVHF7/OGGeYA1sGcApGJZ5riIqGenyHVwJLN8+BgpDa?=
 =?us-ascii?Q?1bcUin89O5DQM1VYq1yLqV0MQ0oj3Fpby+9yKZ6JRosTeQXp6sk8i61yGvkt?=
 =?us-ascii?Q?hZXfyjrzJ67NCIXso22fH359V3iLucGh3Bgb1bDsk2be+jJvU9o8dbyRSfbi?=
 =?us-ascii?Q?nQO7Um/Ec0QEdC7dVawUSDJ2j4Hmg/njDoGF8ID50ZSIBCqcXRmx/rJq4pPw?=
 =?us-ascii?Q?YRULWnoJVGvA/ODC/FR+EKAnFZNKwApFXdnxtGCbQVECWn93E+cpSjQe0Hpg?=
 =?us-ascii?Q?3g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: M598yN/uARLKX61VmEYekWkMQndeTOT2oJD2+ZWLpqWjk9LSW1ZYQ55G6UVA4xBEMYqQllMuI0Zfwfcy8l8LALbzMXnzjpUdMWdZqpwUvvf/Y8Ccx7ItrTISRnFGMDrWYnXN/8Wvy/rhvVwnBxO/K8b0fn7F1fKhJiPDMV1gdUsd6xtDl4lalQ610eJ2WzEkr8w+pVH6SiVKviFsKnxM0NqJQlBVgLym+mKszlt5a8Vut4jv1K9r2FBzFQJEDr0mkOKsceVggQ5x8d0ufdzKwVg4W7jq+Ir46XWkHdJcykQvz0eQe+qoi9411C8awMAYScdalcgMNQfuutkVlG84c7w9BYVlEfQqhdCzyvS/03AYqNSAaECjQ8QrXzO+icBEr+1oddVVBhs9SzA+scPLixqowPraA7utug0m0yliVTWaDR+zX8p9fld74Cv3NDduWARqsPHojyhw5qx7Kpb7VQAFCfg5CGod2QnSz9XrmvniG4npTUb6FYGie34At0QFhOMgjtwkw2Da/odF95JqjoT60V8LQ1rSBNvKR9N2tAhuHVjpqHdgYij9aU9B7+ppXdzK0sTnXit4hq/AquyAUWN3glXcHUEzrZ4ihK/oR6yOb0MYBn7gOH3teAT3L4A/GBX+bwF7EBE3mS+AMhtxHCXtYm7aFByE+Ufvgl7NEMtoi1pU/p6ge40R2ZbJY4TXsofdf7ziOqaOMj3ZbtGIwzoP/jxQeDI42Sc2W05i9CzyRSu3Mrkyep8cO7G+d+vWCLVSo2ID/vG4lYxNKlOGd0x7v+xATVZxSqapY4/G8he5+XjNe2rykgKahyee5SUCypq5xsStqx9ZaCYRjowNn6S1B+0lDmEKjNetfHJ1TtU2Uk2jxmVnKrVk2l7wIwdK7NF5QA57PFhPLuzWTWHCV7ANEOfp0pGwl8iXhzhP7/I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f461c8c4-259e-4d54-4254-08da810a7018
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2022 11:11:45.7578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WASdlKGG+Yv/a2sgBOBb1QVrnt50ayNeXg6/gs1J0dkBPQXJmWa8UuwSTZ40l8hsgeegw4xzVg37bzWYwXtIpz5OOopnUP0jEYjy+Q2YJws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3763
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-18_12,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208180039
X-Proofpoint-ORIG-GUID: j8_YFMM8MB58_qC5DQjRi2I07psX-De2
X-Proofpoint-GUID: j8_YFMM8MB58_qC5DQjRi2I07psX-De2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux bits/020-t6000-dart
head:   a1335782bc0044bf5fc4ec4f8a4a785ecb02a652
commit: fe20c64837d183c09082887d0c96d338b438a855 [7/11] iommu: dart: Support >64 stream IDs
config: mips-randconfig-m031-20220818 (https://download.01.org/0day-ci/archive/20220818/202208181055.JPFYIeIR-lkp@intel.com/config)
compiler: mips64el-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/iommu/apple-dart.c:918 apple_dart_probe() warn: missing error code 'ret'

vim +/ret +918 drivers/iommu/apple-dart.c

46d1fb072e76b1 Sven Peter     2021-08-03  870  static int apple_dart_probe(struct platform_device *pdev)
46d1fb072e76b1 Sven Peter     2021-08-03  871  {
46d1fb072e76b1 Sven Peter     2021-08-03  872  	int ret;
46d1fb072e76b1 Sven Peter     2021-08-03  873  	u32 dart_params[2];
46d1fb072e76b1 Sven Peter     2021-08-03  874  	struct resource *res;
46d1fb072e76b1 Sven Peter     2021-08-03  875  	struct apple_dart *dart;
46d1fb072e76b1 Sven Peter     2021-08-03  876  	struct device *dev = &pdev->dev;
46d1fb072e76b1 Sven Peter     2021-08-03  877  
46d1fb072e76b1 Sven Peter     2021-08-03  878  	dart = devm_kzalloc(dev, sizeof(*dart), GFP_KERNEL);
46d1fb072e76b1 Sven Peter     2021-08-03  879  	if (!dart)
46d1fb072e76b1 Sven Peter     2021-08-03  880  		return -ENOMEM;
46d1fb072e76b1 Sven Peter     2021-08-03  881  
46d1fb072e76b1 Sven Peter     2021-08-03  882  	dart->dev = dev;
15720227e18019 Sven Peter     2021-11-02  883  	dart->hw = of_device_get_match_data(dev);
46d1fb072e76b1 Sven Peter     2021-08-03  884  	spin_lock_init(&dart->lock);
46d1fb072e76b1 Sven Peter     2021-08-03  885  
a15932f4377062 Yang Yingliang 2022-04-25  886  	dart->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
a15932f4377062 Yang Yingliang 2022-04-25  887  	if (IS_ERR(dart->regs))
a15932f4377062 Yang Yingliang 2022-04-25  888  		return PTR_ERR(dart->regs);
a15932f4377062 Yang Yingliang 2022-04-25  889  
46d1fb072e76b1 Sven Peter     2021-08-03  890  	if (resource_size(res) < 0x4000) {
46d1fb072e76b1 Sven Peter     2021-08-03  891  		dev_err(dev, "MMIO region too small (%pr)\n", res);
46d1fb072e76b1 Sven Peter     2021-08-03  892  		return -EINVAL;
46d1fb072e76b1 Sven Peter     2021-08-03  893  	}
46d1fb072e76b1 Sven Peter     2021-08-03  894  
46d1fb072e76b1 Sven Peter     2021-08-03  895  	dart->irq = platform_get_irq(pdev, 0);
46d1fb072e76b1 Sven Peter     2021-08-03  896  	if (dart->irq < 0)
46d1fb072e76b1 Sven Peter     2021-08-03  897  		return -ENODEV;
46d1fb072e76b1 Sven Peter     2021-08-03  898  
46d1fb072e76b1 Sven Peter     2021-08-03  899  	ret = devm_clk_bulk_get_all(dev, &dart->clks);
46d1fb072e76b1 Sven Peter     2021-08-03  900  	if (ret < 0)
46d1fb072e76b1 Sven Peter     2021-08-03  901  		return ret;
46d1fb072e76b1 Sven Peter     2021-08-03  902  	dart->num_clks = ret;
46d1fb072e76b1 Sven Peter     2021-08-03  903  
46d1fb072e76b1 Sven Peter     2021-08-03  904  	ret = clk_bulk_prepare_enable(dart->num_clks, dart->clks);
46d1fb072e76b1 Sven Peter     2021-08-03  905  	if (ret)
46d1fb072e76b1 Sven Peter     2021-08-03  906  		return ret;
46d1fb072e76b1 Sven Peter     2021-08-03  907  
46d1fb072e76b1 Sven Peter     2021-08-03  908  	dart_params[0] = readl(dart->regs + DART_PARAMS1);
46d1fb072e76b1 Sven Peter     2021-08-03  909  	dart_params[1] = readl(dart->regs + DART_PARAMS2);
46d1fb072e76b1 Sven Peter     2021-08-03  910  	dart->pgsize = 1 << FIELD_GET(DART_PARAMS_PAGE_SHIFT, dart_params[0]);
46d1fb072e76b1 Sven Peter     2021-08-03  911  	dart->supports_bypass = dart_params[1] & DART_PARAMS_BYPASS_SUPPORT;
fe20c64837d183 Hector Martin  2022-06-28  912  
fe20c64837d183 Hector Martin  2022-06-28  913  	dart->num_streams = dart->hw->max_sid_count;
fe20c64837d183 Hector Martin  2022-06-28  914  
fe20c64837d183 Hector Martin  2022-06-28  915  	if (dart->num_streams > DART_MAX_STREAMS) {
fe20c64837d183 Hector Martin  2022-06-28  916  		dev_err(&pdev->dev, "Too many streams (%d > %d)\n",
fe20c64837d183 Hector Martin  2022-06-28  917  			dart->num_streams, DART_MAX_STREAMS);
fe20c64837d183 Hector Martin  2022-06-28 @918  		goto err_clk_disable;

ret = -EINVAL;

fe20c64837d183 Hector Martin  2022-06-28  919  	}
fe20c64837d183 Hector Martin  2022-06-28  920  
46d1fb072e76b1 Sven Peter     2021-08-03  921  	dart->force_bypass = dart->pgsize > PAGE_SIZE;
46d1fb072e76b1 Sven Peter     2021-08-03  922  
fe20c64837d183 Hector Martin  2022-06-28  923  	ret = apple_dart_hw_reset(dart);
fe20c64837d183 Hector Martin  2022-06-28  924  	if (ret)
fe20c64837d183 Hector Martin  2022-06-28  925  		goto err_clk_disable;
fe20c64837d183 Hector Martin  2022-06-28  926  
46d1fb072e76b1 Sven Peter     2021-08-03  927  	ret = request_irq(dart->irq, apple_dart_irq, IRQF_SHARED,
46d1fb072e76b1 Sven Peter     2021-08-03  928  			  "apple-dart fault handler", dart);
46d1fb072e76b1 Sven Peter     2021-08-03  929  	if (ret)
46d1fb072e76b1 Sven Peter     2021-08-03  930  		goto err_clk_disable;
46d1fb072e76b1 Sven Peter     2021-08-03  931  
46d1fb072e76b1 Sven Peter     2021-08-03  932  	platform_set_drvdata(pdev, dart);
46d1fb072e76b1 Sven Peter     2021-08-03  933  
46d1fb072e76b1 Sven Peter     2021-08-03  934  	ret = apple_dart_set_bus_ops(&apple_dart_iommu_ops);
46d1fb072e76b1 Sven Peter     2021-08-03  935  	if (ret)
46d1fb072e76b1 Sven Peter     2021-08-03  936  		goto err_free_irq;
46d1fb072e76b1 Sven Peter     2021-08-03  937  
46d1fb072e76b1 Sven Peter     2021-08-03  938  	ret = iommu_device_sysfs_add(&dart->iommu, dev, NULL, "apple-dart.%s",
46d1fb072e76b1 Sven Peter     2021-08-03  939  				     dev_name(&pdev->dev));
46d1fb072e76b1 Sven Peter     2021-08-03  940  	if (ret)
46d1fb072e76b1 Sven Peter     2021-08-03  941  		goto err_remove_bus_ops;
46d1fb072e76b1 Sven Peter     2021-08-03  942  
46d1fb072e76b1 Sven Peter     2021-08-03  943  	ret = iommu_device_register(&dart->iommu, &apple_dart_iommu_ops, dev);
46d1fb072e76b1 Sven Peter     2021-08-03  944  	if (ret)
46d1fb072e76b1 Sven Peter     2021-08-03  945  		goto err_sysfs_remove;
46d1fb072e76b1 Sven Peter     2021-08-03  946  
46d1fb072e76b1 Sven Peter     2021-08-03  947  	dev_info(
46d1fb072e76b1 Sven Peter     2021-08-03  948  		&pdev->dev,
fe20c64837d183 Hector Martin  2022-06-28  949  		"DART [pagesize %x, %d streams, bypass support: %d, bypass forced: %d] initialized\n",
fe20c64837d183 Hector Martin  2022-06-28  950  		dart->pgsize, dart->num_streams, dart->supports_bypass, dart->force_bypass);
46d1fb072e76b1 Sven Peter     2021-08-03  951  	return 0;
46d1fb072e76b1 Sven Peter     2021-08-03  952  
46d1fb072e76b1 Sven Peter     2021-08-03  953  err_sysfs_remove:
46d1fb072e76b1 Sven Peter     2021-08-03  954  	iommu_device_sysfs_remove(&dart->iommu);
46d1fb072e76b1 Sven Peter     2021-08-03  955  err_remove_bus_ops:
46d1fb072e76b1 Sven Peter     2021-08-03  956  	apple_dart_set_bus_ops(NULL);
46d1fb072e76b1 Sven Peter     2021-08-03  957  err_free_irq:
46d1fb072e76b1 Sven Peter     2021-08-03  958  	free_irq(dart->irq, dart);
46d1fb072e76b1 Sven Peter     2021-08-03  959  err_clk_disable:
46d1fb072e76b1 Sven Peter     2021-08-03  960  	clk_bulk_disable_unprepare(dart->num_clks, dart->clks);
46d1fb072e76b1 Sven Peter     2021-08-03  961  
46d1fb072e76b1 Sven Peter     2021-08-03  962  	return ret;
46d1fb072e76b1 Sven Peter     2021-08-03  963  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

