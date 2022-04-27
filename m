Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1788851122B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 09:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358664AbiD0HRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 03:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358657AbiD0HRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 03:17:10 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA5349C90
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 00:14:00 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23R53UNb015530;
        Wed, 27 Apr 2022 07:13:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=oqN7DQ3TWe5qxrW1eGFXTbTWPB8cKRmHHJ9YRGYXV80=;
 b=EsM7QsGI16NpNNsXYrYCsaayYcanrMKyQKWVIG4hlad1uZf9qSKzwG6J7sYNv4WwRKsg
 d2J6p3IkCutvUIyPcszYCwWdARggo8cczqRAMmXgn47FKLCq+ZQ1MyMHZLUDylR6Ezyy
 jIuu2kpeEnawqvkdXZNKr3+IGzJ26rIuL+lZGNrkbpT9pZ3u/vs540pZwi3B+xThb+Do
 gXF16ET07auqn2H4DH+yLue3AVtQvd+JSLEGqRf4ZuRRl7+G1ENrPoOy60t/vzi3lzkb
 d02bE6Fvoc6qZJA/iJOx0qSH3/Lv2unOr/4N8ldnrpMBzCM7ZESi17n3lFmk7H0CTn+m 2Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb9ar4ev-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Apr 2022 07:13:55 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23R7B7S1010692;
        Wed, 27 Apr 2022 07:13:53 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2047.outbound.protection.outlook.com [104.47.74.47])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w48jjc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Apr 2022 07:13:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fHvAMrkChmkZarUVNLfPcFcFAYV8s2NqBOgun1jRfGBqG3x8RM8KxuZH6ILjKuWpYH7bJahuWuAGiTNBSxMyXOdt4/zrEsjaHsXRZSblk0ZgyL9vlzmeH8yFk35odgVwI5U69dyC4ROiA6wwkj9XLPLVw0727ViiTMUwCUwovFGRCaCFOFFyycpkn4pAXIbxZgi4iZsyXipXrQwDi77VfzKZR7S9IdMP+QRUudlPoxekkLoVfYCS7WWAZEEu9ze5RoTEL8NFhaInf2K7pIE5P1PPZBd7F0QSC/gpC2EGYE9kZmoQQo6bcXF1vY6Cic9p02Boi9xX9aIMD6Vu/DKoQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oqN7DQ3TWe5qxrW1eGFXTbTWPB8cKRmHHJ9YRGYXV80=;
 b=YvVo/6rivAlAbc95x0iMSp3T8vvhedWUxkTmcc1Q7VeHUZcosKzfW+WHZq69DfnrtVVEl+aTx7xz4GWUKynuFakbJyqCYd8lF1gexqj9UQ5ydsdw3pBl4N1PCfhFm1A3o9E8acespRHcSOZYr8paQ6VNLPfoDaeJV6zSWA5KxLG0vcqPKCC25XFE5tSlPACbPJLVbtRJ23yDEhjIBnEksWRoJLKVrLqvBct8qoOe3biNqLa4kqjKDwSfPFgkNeYIvF+WnB2eKHgOjZtiPbAUg1wkwfVf7ycvkeaRDXZnVLpxJ4uvQXcZKNwCdE4F9/xWN/eD3sJyALEcErJOmDULrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oqN7DQ3TWe5qxrW1eGFXTbTWPB8cKRmHHJ9YRGYXV80=;
 b=TVkOlp99YPC7I+XeWVys+wTFLDkHgtkp1L/rf8QG5JvXfz6s+KZdqqW2JH63wXN5RGaifeC1C5vs7XNGHXY0Pfj3maI0wHKmKieHa+GaWFW2FdeLU5LX3Ez1CaWJ6Ol1gpas1S4e2AMSqI8CmbS+xoBLyzqa72AqNKr9TMW6UJM=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM5PR10MB1435.namprd10.prod.outlook.com
 (2603:10b6:3:11::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Wed, 27 Apr
 2022 07:13:51 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5164.025; Wed, 27 Apr 2022
 07:13:51 +0000
Date:   Wed, 27 Apr 2022 10:13:30 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: net/dsa/tag_sja1105.c:432 sja1105_rcv() error: uninitialized symbol
 'vid'.
Message-ID: <202204270649.Eun9P40C-lkp@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0042.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::13)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4fcb997-b121-45a3-ffeb-08da281d7afe
X-MS-TrafficTypeDiagnostic: DM5PR10MB1435:EE_
X-Microsoft-Antispam-PRVS: <DM5PR10MB1435EE1BC79E51A6A7FEC6728EFA9@DM5PR10MB1435.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6dKGibp30mFAl76kujLeHKT7oQaIAC8/cof4Jk4aZxODqHt0I/1K/eGrKRARFBU5ZXrrW28SVO5MSuFetL8JlD7kHbvmD+XdIQKIlJrM6wTJ00LySeUOARjVLKh7+4LDaepJRx2psM/kbtCdBZnjqNMg4uxrhRqlpFRUPzWJbU5gJKIkSmEhfmpLXwWdu9vvBBvEuBA6EcdUaS3p5NOecO1F5a/QZvO/OAjLdeW2hNRfEefkDjs+PgRMQieN6pBrokufZ/Bt9gsHGIuz9K9Q8iAitmtsBOtfvbn+O/W5Yf93vs8anD/2uPLLxsIuaKZ2SrTqeCnhpqo2t+c7h+jOXs51OL6TMSg6s1qt3dtu7MZavJZltV2bGO+GNdmm48g655IKdfxNg9W6sN3NUjQhOw4fBsRgvA9BOJOn3v7Ep4O55x7xGgbVDCqT8zcTPc/+xipc8pAug45Dnrski97K3Cf/Mx6zTWAF6mnEZeHiHUOcgvrdAiGGoTTxAy99I1e1lHbGhGnH6iTNoGKuH9NLJta8SOQ8O2N+L2MDdyYtHSv3d79yRZ95sF2GmHkf0ocB5OYOuksl6K1wKnkjeOBQ18m6mi1MbUR6H/IBw7KuE8w1NoR9Veo6vWxj7669Rjg7g8D3dMw+AWxYin/tJgk1ktvppzoZzEVZljCVJHa+JQU6TKmvD3OpxLMNKO3gZ9Flb7g6eqR/zFO0zt/bpc+53DfvybwQx6cnXXLEMOPdu/gKfe1UIGVzL5agtbyUaGEV71Qd5mWaHjCGugKFdI6Q8aHNQCAGzRDyC72kv+lFivAB4r1GcyKpwL1UNAke82mFRRpvIjPRHLGjOr/cfocFqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(38350700002)(6512007)(6666004)(52116002)(86362001)(26005)(966005)(6916009)(316002)(8676002)(2906002)(66476007)(4326008)(66946007)(508600001)(66556008)(8936002)(6506007)(9686003)(5660300002)(6486002)(36756003)(44832011)(1076003)(186003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2V2WGV1MHZNSGgxWVdoQWgrbzhCUzdkem9FM2d4RTdKYi9ZRHJ5KzJ1Y25Z?=
 =?utf-8?B?Y293TUN3TFZBbUVjMERmdjc4REVNaXlIaFRjSk50ZzhVcUNBc0gzYmN2U1Zl?=
 =?utf-8?B?Y1JxeElKenJyL2tuSTJKT2M5eUFRWkRNT1MxN1lPZklEMElReXp1MzM3UVpY?=
 =?utf-8?B?eTBOTVYxQnUvczJQNmMxa1R0YTd4bURSM3R5VHhjTmY3VGc5Z1dHUnd2dUMw?=
 =?utf-8?B?VUdvRVlCTmdFZG02ZjM4ODdCZkhpcXB2SHRoRjJMUk42ZTVOZWlWN1QwWFdu?=
 =?utf-8?B?b013VnErTDJDVE8rMVAvcnIvcVBDUGgreUlLVWg3b01EWHIwMW5hMldHdU9w?=
 =?utf-8?B?Uzh1UitwSS9tMTVjQXJNWWl3TlJlNDY2dXkyZ1ZDVlB6dzV6UVdVbnNoY2hO?=
 =?utf-8?B?c05QdjU0VWF3ejlSSzVaamxleXlMZ2F3S01UWWhwSU9jQUVFbTFWNWhzcTVq?=
 =?utf-8?B?eXY0cnNtbGg3eDJwUm51bC9TTmNKVDJPQ3hpUDRnUC9uSkR4UHduN2dNNHFJ?=
 =?utf-8?B?eUdpdG4wek84NmlmNlpIM3hJN05qbVpNd2FDMGFST1NwdlQ2bjI4azI4M1Q5?=
 =?utf-8?B?WCtiMDR5RWFRMXpyYjFkVkFrZU9kQ2lVT3VxVGlUejZZaHFBbGhnVUxHVGtF?=
 =?utf-8?B?ckhtTjR0Z3NkMG4yVE1JVHloU2NaYnQxazltR2k5cmJqTThKRGwrVFNoakJO?=
 =?utf-8?B?SmJpalBRVmRQNzFMSUJLaXlEQ1hwTlpFSGNOc0t6Um1IZHlaOTBJaEluT2hn?=
 =?utf-8?B?eFpzUjlESURYS24zQk5TdnBOaDlpNkZTcnFTdkZSYVhJc0ZZNnlXNnZsVE1z?=
 =?utf-8?B?VFU2OVdvVHJ5aDMrMzh3NUVmSkhqRVljM01TdzI4QktNZURTT2pmQURpRllk?=
 =?utf-8?B?dGYxa1VETTYydDZmKytndUxjS2ZGQm84L242WWI5SVc2eFMrTVpBdVdJNEpJ?=
 =?utf-8?B?dVlPSGc2MFd6WW9vUHFxY2xNYitkSElnS29YUUNKOGlsNGdQT1NLYjRFb2p3?=
 =?utf-8?B?dUd3NnI0WUl1andiTTRzUW5EY3diQnFvclA1dkpOeTBmcFlMU1ZKVmQ0WHdW?=
 =?utf-8?B?RnZBcGhQMDBvVVNUd3ZYMkpyN1lhVUE0alFUbnBvZE1vSTFSU1crbFdzckZo?=
 =?utf-8?B?N0NzWWNGVGZ1ZHN3QUp3TlFzbWFUaEJ4cGdEM3B3OTFaaXlHbFUzc1NCOXdP?=
 =?utf-8?B?ZEJvdWxBWGNMUEt4QXRxMmJvaWV3WWlTczVWWHMvbUxtUEwzZnRDZkJwVkhx?=
 =?utf-8?B?SFRuRWJhQXFQRXFtRER2MWNOS3NFOHdGUnFiRWhhU1ZSU1czUTZtZ1F0aDAy?=
 =?utf-8?B?eGs4QlN1ZjVIOXE1Vysxcld5eVQ0ME5XS0JzcWRxMjhYZExMb3dhRGNHeENj?=
 =?utf-8?B?NzVtYitWWTBWRUhiWnByMmRIeC9uVEJXOGRGS0IyUmswTThqSmM4dldDNkhI?=
 =?utf-8?B?b3ZSQ21scDduY0MrNGE1S0x4b0NaTStNWlZmWnlVS21kNFVPL2ZnWXNneWVM?=
 =?utf-8?B?dGZQcHJaMWN1Qyt1dnNxQmFPSnhjWkRjRmwxSUluZU5yMFZYUDRtbUMxaU8z?=
 =?utf-8?B?ejJJWnA3emh4MGVxUFl2ZkZqT3ArbW0zNFdweU5URXpTaXhXbGltN2hFSmNH?=
 =?utf-8?B?cWpMNE9Pa2Q4U0hHRUErWnNzUGNmeHZiZm1hcmhkM2Z3d2NkQnl2T09tQXkw?=
 =?utf-8?B?djhTRW9UUThrVkJTVStFbjA5SDFtN3JxYVdRSEFoTWNKZXUwQkpGMGh6VmR3?=
 =?utf-8?B?ZkVOdi9ERDExZzFvemFOMXBWYjA2MWY0NUxqWnVEaWJKZGRPV2dhRE5nc3Z5?=
 =?utf-8?B?TVdray9LQ2l4N0VRVzBoVnRIdUNpTXlzVWlJYS9KRi9NQkovTFI0bFg2WDVX?=
 =?utf-8?B?LzQ2eXRGWVRSbGExc25vSndhcTB5RWdvMjUvVzY2T1NvaGxYMHVEKzBscis2?=
 =?utf-8?B?YklTajlNNFozV1VieWV2SjV0ZTVZN243VzNvV1UrYzRTRzNjdlRKcjR1eFlz?=
 =?utf-8?B?MmlqWVoxaHlmK2lZaStoYzFTWGVpaUFyL1g3b0h3QkRtTVc0UURIUk54REZ0?=
 =?utf-8?B?TjNMQW4zQitKbVFoUEtIUnVyUzV2aTlQeXpkNzYxbnNiMkhGaDZpYmtLNHFP?=
 =?utf-8?B?QXB6ZUYxdGFpdlVhQVNnNldaaXBWejhwdFd4UjcxeXlzY3cvcHdwdURwZW5K?=
 =?utf-8?B?NFAzTDMzWldDRTd2NUNRQWpKNEtYbGRiVnVWNkhjK0NnL21lbU1zR0N1M0h3?=
 =?utf-8?B?cHRmb1dvL09nNkdaTE1Cc1drOXlUZTY1VzBqOFNHYWtiQnNnd2x6YS8rcUdj?=
 =?utf-8?B?SXA5cmRJY3dyeWt3dmJka3d2REhEZHJOOFVob21QWEFIb01RZVluRjl5MkZ1?=
 =?utf-8?Q?cbTWnjjoC77V/Whc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4fcb997-b121-45a3-ffeb-08da281d7afe
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 07:13:51.3259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bG8LTPy7wiTpbTssrmtgAJ7v16I1DMo1hCtpoRbaZX0dVzKCEPEsA3lOw2GCfLB2qv9uhaXWJplxF51gojuOrDvXBqdIh7rt6pYdiZWi93o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1435
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-27_02:2022-04-26,2022-04-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204270048
X-Proofpoint-ORIG-GUID: Aalkh4td4_sm5hXHfTeSmPRpXKUXWboC
X-Proofpoint-GUID: Aalkh4td4_sm5hXHfTeSmPRpXKUXWboC
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   cf424ef014ac30b0da27125dd1fbdf10b0d3a520
commit: 04a1758348a87eb73b8a4554d0c227831e2bb33e net: dsa: tag_sja1105: fix control packets on SJA1110 being received on an imprecise port
config: openrisc-randconfig-m031-20220425 (https://download.01.org/0day-ci/archive/20220427/202204270649.Eun9P40C-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
net/dsa/tag_sja1105.c:432 sja1105_rcv() error: uninitialized symbol 'vid'.

Old smatch warnings:
net/dsa/tag_sja1105.c:564 sja1110_rcv() error: uninitialized symbol 'vid'.

vim +/vid +432 net/dsa/tag_sja1105.c

227d07a07ef1262 Vladimir Oltean 2019-05-05  393  static struct sk_buff *sja1105_rcv(struct sk_buff *skb,
227d07a07ef1262 Vladimir Oltean 2019-05-05  394  				   struct net_device *netdev,
227d07a07ef1262 Vladimir Oltean 2019-05-05  395  				   struct packet_type *pt)
227d07a07ef1262 Vladimir Oltean 2019-05-05  396  {
884be12f85666c6 Vladimir Oltean 2021-07-26  397  	int source_port = -1, switch_id = -1;
e53e18a6fe4d3ae Vladimir Oltean 2019-06-08  398  	struct sja1105_meta meta = {0};
e80f40cbe4dd513 Vladimir Oltean 2020-03-24  399  	struct ethhdr *hdr;
42824463d38d273 Vladimir Oltean 2019-06-08  400  	bool is_link_local;
e53e18a6fe4d3ae Vladimir Oltean 2019-06-08  401  	bool is_meta;
884be12f85666c6 Vladimir Oltean 2021-07-26  402  	u16 vid;
227d07a07ef1262 Vladimir Oltean 2019-05-05  403  
e80f40cbe4dd513 Vladimir Oltean 2020-03-24  404  	hdr = eth_hdr(skb);
42824463d38d273 Vladimir Oltean 2019-06-08  405  	is_link_local = sja1105_is_link_local(skb);
e53e18a6fe4d3ae Vladimir Oltean 2019-06-08  406  	is_meta = sja1105_is_meta_frame(skb);
227d07a07ef1262 Vladimir Oltean 2019-05-05  407  
227d07a07ef1262 Vladimir Oltean 2019-05-05  408  	skb->offload_fwd_mark = 1;
227d07a07ef1262 Vladimir Oltean 2019-05-05  409  
233697b3b3f60b1 Vladimir Oltean 2021-06-11  410  	if (sja1105_skb_has_tag_8021q(skb)) {
42824463d38d273 Vladimir Oltean 2019-06-08  411  		/* Normal traffic path. */
04a1758348a87eb Vladimir Oltean 2021-07-29  412  		sja1105_vlan_rcv(skb, &source_port, &switch_id, &vid);

There is a return where *vid is not set

42824463d38d273 Vladimir Oltean 2019-06-08  413  	} else if (is_link_local) {
227d07a07ef1262 Vladimir Oltean 2019-05-05  414  		/* Management traffic path. Switch embeds the switch ID and
227d07a07ef1262 Vladimir Oltean 2019-05-05  415  		 * port ID into bytes of the destination MAC, courtesy of
227d07a07ef1262 Vladimir Oltean 2019-05-05  416  		 * the incl_srcpt options.
227d07a07ef1262 Vladimir Oltean 2019-05-05  417  		 */
227d07a07ef1262 Vladimir Oltean 2019-05-05  418  		source_port = hdr->h_dest[3];
227d07a07ef1262 Vladimir Oltean 2019-05-05  419  		switch_id = hdr->h_dest[4];
227d07a07ef1262 Vladimir Oltean 2019-05-05  420  		/* Clear the DMAC bytes that were mangled by the switch */
227d07a07ef1262 Vladimir Oltean 2019-05-05  421  		hdr->h_dest[3] = 0;
227d07a07ef1262 Vladimir Oltean 2019-05-05  422  		hdr->h_dest[4] = 0;

Not set here

e53e18a6fe4d3ae Vladimir Oltean 2019-06-08  423  	} else if (is_meta) {
e53e18a6fe4d3ae Vladimir Oltean 2019-06-08  424  		sja1105_meta_unpack(skb, &meta);
e53e18a6fe4d3ae Vladimir Oltean 2019-06-08  425  		source_port = meta.source_port;
e53e18a6fe4d3ae Vladimir Oltean 2019-06-08  426  		switch_id = meta.switch_id;

Or here

227d07a07ef1262 Vladimir Oltean 2019-05-05  427  	} else {
42824463d38d273 Vladimir Oltean 2019-06-08  428  		return NULL;
227d07a07ef1262 Vladimir Oltean 2019-05-05  429  	}
227d07a07ef1262 Vladimir Oltean 2019-05-05  430  
04a1758348a87eb Vladimir Oltean 2021-07-29  431  	if (source_port == -1 || switch_id == -1)
884be12f85666c6 Vladimir Oltean 2021-07-26 @432  		skb->dev = dsa_find_designated_bridge_port_by_vid(netdev, vid);
                                                                                                                          ^^^
So the static checker complains

GCC would also complain if we enabled -Wmaybe-uninitialized

net/dsa/tag_sja1105.c: In function ‘sja1105_rcv’:
net/dsa/tag_sja1105.c:567:28: warning: ‘vid’ may be used uninitialized in this function [-Wmaybe-uninitialized]
  567 |                 skb->dev = dsa_find_designated_bridge_port_by_vid(netdev, vid);
      |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

884be12f85666c6 Vladimir Oltean 2021-07-26  433  	else
227d07a07ef1262 Vladimir Oltean 2019-05-05  434  		skb->dev = dsa_master_find_slave(netdev, switch_id, source_port);
227d07a07ef1262 Vladimir Oltean 2019-05-05  435  	if (!skb->dev) {
227d07a07ef1262 Vladimir Oltean 2019-05-05  436  		netdev_warn(netdev, "Couldn't decode source port\n");
227d07a07ef1262 Vladimir Oltean 2019-05-05  437  		return NULL;
227d07a07ef1262 Vladimir Oltean 2019-05-05  438  	}
227d07a07ef1262 Vladimir Oltean 2019-05-05  439  
f3097be21bf17ae Vladimir Oltean 2019-06-08  440  	return sja1105_rcv_meta_state_machine(skb, &meta, is_link_local,
f3097be21bf17ae Vladimir Oltean 2019-06-08  441  					      is_meta);
227d07a07ef1262 Vladimir Oltean 2019-05-05  442  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

