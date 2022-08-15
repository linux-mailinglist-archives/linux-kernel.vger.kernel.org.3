Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82DE592D40
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbiHOIZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 04:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbiHOIZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 04:25:32 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F8BF5B3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 01:25:28 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27F5CcXl012534;
        Mon, 15 Aug 2022 08:24:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=8f63TwLcLWPmUp+/33qlgbz7HBqhDuB2prDSkAbLGiQ=;
 b=bmNB98LtsbHSxUP3G7DT9UdYqNlw0cDuQyuiZDVGen/HtOP7BIYqMLqAVEjGy0su+k79
 LrfnnEHZk8d+G5plMYkr6/622iCXh+ycNk9y0X5cmglqU4LPHjL2/ARkBQJQ2aj6/oU+
 ljfujKEMyYCSvlUQ197h78w8nuyUo2nQqcv0Q7vuWnWnzqBhaiSrj3c1P9H6N78jvJmM
 4O6I9V2EA5p9UY+5NGmfEk2DmB3jlCFdfv2PiIIqyFslLIAD/Ec/DTh3vB9YSlyx+vN1
 th58rSjhyYZuR1eQrMpLZOdTz+4tSHeRbrhol0g/9Ouv1p75R9WJpdxRkYWLd1UTtK4d Pw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hx4gt2c7y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Aug 2022 08:24:52 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27F8LuI1032859;
        Mon, 15 Aug 2022 08:24:50 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hx2d7715m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Aug 2022 08:24:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=efLmDAnF0VjjJjmaHYvhVQkGRDl1tk1NpxujgWfISY5SuRpSnGpwQsO/vhYuev63g359ugh+h4jJbsFlfmBjbY5vF7XK1Nnuv/EhenXuf81TtKOn5mKrvh0D6UGtSGOa3ts6e4umz9dNVPS7Ay1yb511ZBbEkqRHaFVtvuGxTUxOvUiPatz9y3We6oLtR5V/YveiERQcUSyL8iLritz1Z3KNsuKpFwvAyIuC0/g7/7HDPb+ekyWQMEDUVHo+C6JGlaj2ygh6j0K7yGF3Lncvv7S5bdcuLmBinJMN9Ss6KAkWgJd+UE+kiQo6OW3jvyOrUrRe+Q3FZoveIuYtDpauUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8f63TwLcLWPmUp+/33qlgbz7HBqhDuB2prDSkAbLGiQ=;
 b=hRIX43kVjTufwY9ahB0tTwZEIAnUaSBtAWNUbCo1YtKs9f+6oPsJqXeBbByceG22MDxoc86fcvLSm0THaxq02M5aDxyzoHJu1Cq+OlotF8YVWBR1Q5L3REQtHAUh4qldunxL6hl5ji7kTpLOxR5weO82rw90Xa2htI/ICHeETG/H1py9zIYemZ70tQ5Rv7Aw4xw9QLPBEkMyi+FCZnICu5g8lhdoweCzE4JH7VMJHy1eFRGiWQJQwFnnfO1DfxTHr3olWFyKfwdMqQCLdJ3J2fyj2LFlzmHIiIWxYRllDq/BWZX7SB3/W3YMGWBDySwZgYtbb0poHTHOzqJMUldQtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8f63TwLcLWPmUp+/33qlgbz7HBqhDuB2prDSkAbLGiQ=;
 b=zguJZj7R/LPfzGnNe3Z+uMcKFOPkN6HHAU5uWtcyhVlwstDzAJakp71HD8zc6bbknxlurHBcBzX+39vIcTYTLj9n0/GYXlZBgOg76yHw7SUPT3To0xAb0cb4YTUZ7/HJAZAmgykfZDt3DLU5iuIcOF/6+z0qznOAz4BW9RcrSsg=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SN6PR10MB3056.namprd10.prod.outlook.com
 (2603:10b6:805:d9::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.25; Mon, 15 Aug
 2022 08:24:48 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5504.028; Mon, 15 Aug 2022
 08:24:48 +0000
Date:   Mon, 15 Aug 2022 11:24:29 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Ariel Levkovich <lariel@nvidia.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
        Maor Dickman <maord@nvidia.com>
Subject: drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c:142
 mlx5_eswitch_set_rule_source_port() warn: variable dereferenced before check
 'attr' (see line 130)
Message-ID: <202208150418.3WdXNdnr-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0009.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::14)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 196312fa-05e6-4f69-85b7-08da7e979e07
X-MS-TrafficTypeDiagnostic: SN6PR10MB3056:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HVXZODtJVcLqCqlOwiSyZNKWwb5CNhEKpMP82v2vAhD1kVRCC4T3lkwD4nIkOq9vyEnyY/LAcXstEZJrPPpqTfY8WfhVm7p+Hj4S9Rg5tInPHG+e0KCzwwTsYStKq534BNoyWlbJgyqJjcwrvUDLrLH8qQ6wdCL0J2heM/NYXbMPxnE16e8OumFm6nd0kswRDer6WaYeiqga2qnhDAi0AFvuFJp+G4/q5GikzBzzwqNdvt+vVvk0tsdXsVdvnzXPXoFGzuSsdsNfXKiljLpLSRSsm5zf0OB5FzoIdWLnk7jNjUS+oJBbzKysCH/2bdIpJSOIhJhYNy6f6SweroiQwddER2N1Nb6Jm/caIeLd1QnqIwY3hIQUY3ZRRUWemYFE0Bl0D2MALB9vpkRMP/fPNs6RcYOAHOd8/tm7nDTG2OOOPPekYnuO6SU5wq88n6GGodQFLX6JN15leboSW3UZAgCcb/X7h8m9cQtoQu1mmpkqm11C3FMly8ZH6hogo5F62wJGjgS++0xosSUC0RKY4uIHJOozEpa5hx0ViajTRJRR8S/ZEMgryPdfbn443wF7/XkmzjMFUVKz6LCmNcqDZ16zYV+QogvUkT/7FdVGlM3TonF91myGfAVFDb/lekOjXdCGgVtKY+xW4tk8rJQNXGiP/1QsoVbzUzJajaDXH8H+Wjkg58Dz260KT+JGEvyLjvBwj6Ieh9NNCtKd0h4i3co5c8bU4aRzFdMBGE4G1eplOQLPd5gRw7gB9oRQoqaNzYXn+LxO96I0oEUZgFSE7YKHhPln1LaI+eS8CoWKG/GY4K5X3nvFm5CO0znZgcOqa8wVWCm9XAD4c/XGkYDBj+w27K2itoOInL1funjTRRKADT0B1GrArmrcfxD9EGfh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(136003)(376002)(396003)(39860400002)(366004)(5660300002)(44832011)(36756003)(66946007)(66476007)(66556008)(6916009)(54906003)(316002)(8676002)(6666004)(86362001)(83380400001)(26005)(52116002)(4326008)(6512007)(9686003)(38100700002)(38350700002)(966005)(6486002)(41300700001)(478600001)(4001150100001)(6506007)(8936002)(2906002)(1076003)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HcayqfRSdBROhKSzog56T8wt7ZphYVg0hPYzC94hPOSDcgUGke/mCucka250?=
 =?us-ascii?Q?+uGfi75ijtR2spl+kj1/MkzCU3LnHKLv73H9/XEjkHNSJY0LrSheoy2F29/N?=
 =?us-ascii?Q?I40KAKvGoO37dGkXWWdFvNf5vQOWvcvKRzfYcT4eqLaH4Fx//x8L8ovpfq1q?=
 =?us-ascii?Q?Ouo0GUNwp5W3kBE97MZ3z1oXwnCW+Dp9IsKAEi09oD3blzcuRsn211cfVYNC?=
 =?us-ascii?Q?59r64MPi3eguJznmRN9E3NuSboHILBG5oA8zGyxzWM4wPmCpzQSX+Ya8W5M1?=
 =?us-ascii?Q?Py5aZKlRy/0q+n7lSClZFfqsDS/fuU6sJvdyg+dcJI+g7fleF4bOXf7t6L5H?=
 =?us-ascii?Q?uGFu0GQ+kdaQBllUeZJGO4XJH9/HDYooUZ1/kMB9ruYePHsQnpzCL8MRVxIv?=
 =?us-ascii?Q?2BpZMxxAn6HVuoWcrK950l+t3icfzlPaXxAA5+7OEpW6mEf/sa00y455cFGA?=
 =?us-ascii?Q?aKcugRWIhOZEXLXTjscRVDrjMAsmn9wHjT397liVcuOi8lv5GQRLlLKZjycn?=
 =?us-ascii?Q?PoCKsowwj30jkaLiAsK1umEiIUsbv9PLBUmuyo3Lm/G+eNANDIKQHwXQE6Fc?=
 =?us-ascii?Q?vNtSMymCE2w6v9HWO5/IwOuKgWVGvKncEG5B7SnAwzLsp9NUewWTwJtpZZPZ?=
 =?us-ascii?Q?dOynOHXcZtKXgQHKExRFH4vcJamJbokB9oDn1h53eyUB16/BKMBomVKp9cOt?=
 =?us-ascii?Q?UtBZuqzn6RJueiI9c5kP6MarDvJ40WJBLacP0QLiGBBbeCoD/HVAYJfdl74j?=
 =?us-ascii?Q?Y7lE0HXCCgpIPB0QnyWIFS6jAYb4K6Tu5IfEDE4Y7q81eGkUNeUOauXXph1U?=
 =?us-ascii?Q?XDXhCy4ogx54cpHs1Gh6/PFeAalIvdityV/BdEKctiiA/G7t5JYAoCKzMTCF?=
 =?us-ascii?Q?l9FPbTWpoZudTIGHvGPc2itkCyUkE//ZPHc31Fba0LNQXT/+R1EquUtLMqCV?=
 =?us-ascii?Q?d+4yIXLAEjpgtmfVwxi2qNlHFEChIMMFSOaG9J59Rq4nma/nip3TCdD+2BeX?=
 =?us-ascii?Q?UtLd+ls+83Sr3AhKW/yekK3vp+v9CbMzM5DwLB6zBj83jZwnglNhb645Cvfd?=
 =?us-ascii?Q?Pq9lgOHZ9YnPG+thVYXfV7S0tG1jsC0YyA5HPKucW8JhZ0FWgbcV0M73ZfjU?=
 =?us-ascii?Q?AFKBR2RFhXnkuUR0j46UCJ6C/sWM5Arz5LyNw0bKbdzFo7yY6bhzR0MWEQ06?=
 =?us-ascii?Q?4zrI7+2DoC9eBUs5gZlyalTeWQvUYt9K4np8iYJQf4XFpJTSKSYEMQZYzPy4?=
 =?us-ascii?Q?gqyU1MSuEhETgfsDQVy7OfbSl/F5T8UXg+rmetzAmyd0ugAOl4f1lsvF3P+3?=
 =?us-ascii?Q?7eZ+XVQFMmuyZc2bHZEev5nxBObjJp8E3lmThKCzXNNaPYAPkQCnvDJStLcU?=
 =?us-ascii?Q?HldpcNAs2R3iPhOcqQpo7LtGGc1WxQuPWFegCl9Y2damLWpD+2JnYnnl+olq?=
 =?us-ascii?Q?njgISMezw0vvIORReKJzxIz0PTYmr8QpayrF03/v7QEWMSxC+rF4c+U0us+H?=
 =?us-ascii?Q?wLzC+2HiYMOohZlKNjTrSs8nPYAYqzCenCHipyLJ7QVN1W9Z/4CZuJuccpj7?=
 =?us-ascii?Q?Hq0GoKGy5UNvCMUh9UKntVJsniUes4HSuHbWvCTktNt/L59NawCclq7VhjcT?=
 =?us-ascii?Q?hQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?P553yzcMfnV/BdOppx8Y6FOjbYQCP6RDQLN/2P9APMio54v7zPz9BkLq5n3t?=
 =?us-ascii?Q?jF1xaYS+USCDP/9qwLG089EfZjqnYuzVf83RbB55j8g3CykrwOLaQjt/ZCVe?=
 =?us-ascii?Q?I3qZlLNG0fdrCbnhPC3d6r2DtcSw+tK6hj9SSdY4T+zE3R/FLvoeqg+hQ6PP?=
 =?us-ascii?Q?WyFMlr32oS7113iq0Fuj3j+hA4wbro8o01sIL8M8ra9uzPMgnNKKQQihde3N?=
 =?us-ascii?Q?Ec7wzUOS6tlzAC4o3DIrkslP04AgTbgbGxGcEHf2gawWI8Ti659AdBuKDot1?=
 =?us-ascii?Q?Wf/kMVZRS91WmYNxM1oQYmreqyAxYm3OdP1JzoYXfGu+Ow7jWiXurR1+k9wA?=
 =?us-ascii?Q?z5a6KrrH/30vJYSHQqigWMproP40Ln2eXLc2Uon2D2UHDKC83LNsvbosFqr9?=
 =?us-ascii?Q?bHB6kQDsYIPLgsfEmx9wqcIWX7iYqRUur8LP5ionlASc3n+L3SJpG5WGn8dZ?=
 =?us-ascii?Q?JiEZTYltvKc/m2SvuDbBoDnm7l7O3fB3TRrFDUpNG3xqYkq4AKNSD0GiWU6H?=
 =?us-ascii?Q?1TMSS3fC48q8TWZDAFhgg2ATPWAZeUgoJ+Va/uowmFGxREyLvWhmdr+jqrv4?=
 =?us-ascii?Q?5YRdzzsi3ROvDx39jS1WW2oUyaWWO21nhPIQlftrNOVCGRS/LdNINckoIDLB?=
 =?us-ascii?Q?IA3KAT/VzzyxrhniXFLOKfGBvFH8LmZqPxKfsZ4sngAOrQMSpyU6mA/TuW43?=
 =?us-ascii?Q?j6ex2t5ijWb9pxEMkH4jQwWSOjptwuGcnQTzqOLB/Up2kbOQBT9iRAgx/kw9?=
 =?us-ascii?Q?2RSK9Cld7AyrCg2FjgIl18Vj7PB9EIgnSDdDIHrVF2PQHXlc7xvLMfQW29CR?=
 =?us-ascii?Q?nq1pViwmAlU/K8TwwLCHqGHWjhFZejGXZ4D3iL78Uywbg8oAhQVNIdWnlOGZ?=
 =?us-ascii?Q?JGmiSAcbZHWDWPvuU3MVObWssMXBOgdmKdn0wczno+UZTxFOK/PCaqja/0bd?=
 =?us-ascii?Q?HZG4L2hpvA5x7gzNqA25Lsj+2gpYCAFOFZlui1Ux3Vgn6UQmwSrBaSp/Yfrf?=
 =?us-ascii?Q?RmGL34dcgmDYVu13OvNh4c41DQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 196312fa-05e6-4f69-85b7-08da7e979e07
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 08:24:48.4363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lp0/bDvceAfyi+RM8gRnKkCVGAClU4Luh0gHh1MjXgjrs1+K1sbqzFC9UiiQpzpXRvz9TxfYrqYK2Q5xAVzGkOJOD4soZwInv5BPaOpitWg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3056
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-15_05,2022-08-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208150029
X-Proofpoint-GUID: fuKBFekB2Aodm9dM5-6lB9otCWIOO-BI
X-Proofpoint-ORIG-GUID: fuKBFekB2Aodm9dM5-6lB9otCWIOO-BI
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5d6a0f4da9275f6c212de33777778673ba91241a
commit: cb0d54cbf94866b48a73e10a73a55655f808cc7c net/mlx5e: Fix wrong source vport matching on tunnel rule
config: parisc-randconfig-m031-20220807 (https://download.01.org/0day-ci/archive/20220815/202208150418.3WdXNdnr-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c:142 mlx5_eswitch_set_rule_source_port() warn: variable dereferenced before check 'attr' (see line 130)

vim +/attr +142 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c

c01cfd0f111511 Jianbo Liu      2019-06-25  123  static void
c01cfd0f111511 Jianbo Liu      2019-06-25  124  mlx5_eswitch_set_rule_source_port(struct mlx5_eswitch *esw,
c01cfd0f111511 Jianbo Liu      2019-06-25  125  				  struct mlx5_flow_spec *spec,
a508728a4c8bfa Vlad Buslov     2021-01-25  126  				  struct mlx5_flow_attr *attr,
b055ecf5827d81 Mark Bloch      2020-10-12  127  				  struct mlx5_eswitch *src_esw,
b055ecf5827d81 Mark Bloch      2020-10-12  128  				  u16 vport)
c01cfd0f111511 Jianbo Liu      2019-06-25  129  {
166f431ec6beaf Ariel Levkovich 2021-04-29 @130  	struct mlx5_esw_flow_attr *esw_attr = attr->esw_attr;
                                                                                              ^^^^^^^^^^^^^^
Existing code has a dereference

166f431ec6beaf Ariel Levkovich 2021-04-29  131  	u32 metadata;
c01cfd0f111511 Jianbo Liu      2019-06-25  132  	void *misc2;
c01cfd0f111511 Jianbo Liu      2019-06-25  133  	void *misc;
c01cfd0f111511 Jianbo Liu      2019-06-25  134  
c01cfd0f111511 Jianbo Liu      2019-06-25  135  	/* Use metadata matching because vport is not represented by single
c01cfd0f111511 Jianbo Liu      2019-06-25  136  	 * VHCA in dual-port RoCE mode, and matching on source vport may fail.
c01cfd0f111511 Jianbo Liu      2019-06-25  137  	 */
c01cfd0f111511 Jianbo Liu      2019-06-25  138  	if (mlx5_eswitch_vport_match_metadata_enabled(esw)) {
a508728a4c8bfa Vlad Buslov     2021-01-25  139  		if (mlx5_esw_indir_table_decap_vport(attr))
a508728a4c8bfa Vlad Buslov     2021-01-25  140  			vport = mlx5_esw_indir_table_decap_vport(attr);
166f431ec6beaf Ariel Levkovich 2021-04-29  141  
cb0d54cbf94866 Ariel Levkovich 2022-03-15 @142  		if (attr && !attr->chain && esw_attr->int_port)
                                                                    ^^^^
Checked too late

166f431ec6beaf Ariel Levkovich 2021-04-29  143  			metadata =
166f431ec6beaf Ariel Levkovich 2021-04-29  144  				mlx5e_tc_int_port_get_metadata_for_match(esw_attr->int_port);
166f431ec6beaf Ariel Levkovich 2021-04-29  145  		else
166f431ec6beaf Ariel Levkovich 2021-04-29  146  			metadata =
166f431ec6beaf Ariel Levkovich 2021-04-29  147  				mlx5_eswitch_get_vport_metadata_for_match(src_esw, vport);
166f431ec6beaf Ariel Levkovich 2021-04-29  148  
c01cfd0f111511 Jianbo Liu      2019-06-25  149  		misc2 = MLX5_ADDR_OF(fte_match_param, spec->match_value, misc_parameters_2);
166f431ec6beaf Ariel Levkovich 2021-04-29  150  		MLX5_SET(fte_match_set_misc2, misc2, metadata_reg_c_0, metadata);
c01cfd0f111511 Jianbo Liu      2019-06-25  151  
c01cfd0f111511 Jianbo Liu      2019-06-25  152  		misc2 = MLX5_ADDR_OF(fte_match_param, spec->match_criteria, misc_parameters_2);
0f0d3827c0b4d6 Paul Blakey     2020-02-16  153  		MLX5_SET(fte_match_set_misc2, misc2, metadata_reg_c_0,
0f0d3827c0b4d6 Paul Blakey     2020-02-16  154  			 mlx5_eswitch_get_vport_metadata_mask());
c01cfd0f111511 Jianbo Liu      2019-06-25  155  
c01cfd0f111511 Jianbo Liu      2019-06-25  156  		spec->match_criteria_enable |= MLX5_MATCH_MISC_PARAMETERS_2;
c01cfd0f111511 Jianbo Liu      2019-06-25  157  	} else {
c01cfd0f111511 Jianbo Liu      2019-06-25  158  		misc = MLX5_ADDR_OF(fte_match_param, spec->match_value, misc_parameters);
b055ecf5827d81 Mark Bloch      2020-10-12  159  		MLX5_SET(fte_match_set_misc, misc, source_port, vport);
c01cfd0f111511 Jianbo Liu      2019-06-25  160  
c01cfd0f111511 Jianbo Liu      2019-06-25  161  		if (MLX5_CAP_ESW(esw->dev, merged_eswitch))
c01cfd0f111511 Jianbo Liu      2019-06-25  162  			MLX5_SET(fte_match_set_misc, misc,
c01cfd0f111511 Jianbo Liu      2019-06-25  163  				 source_eswitch_owner_vhca_id,
b055ecf5827d81 Mark Bloch      2020-10-12  164  				 MLX5_CAP_GEN(src_esw->dev, vhca_id));
c01cfd0f111511 Jianbo Liu      2019-06-25  165  
c01cfd0f111511 Jianbo Liu      2019-06-25  166  		misc = MLX5_ADDR_OF(fte_match_param, spec->match_criteria, misc_parameters);
c01cfd0f111511 Jianbo Liu      2019-06-25  167  		MLX5_SET_TO_ONES(fte_match_set_misc, misc, source_port);
c01cfd0f111511 Jianbo Liu      2019-06-25  168  		if (MLX5_CAP_ESW(esw->dev, merged_eswitch))
c01cfd0f111511 Jianbo Liu      2019-06-25  169  			MLX5_SET_TO_ONES(fte_match_set_misc, misc,
c01cfd0f111511 Jianbo Liu      2019-06-25  170  					 source_eswitch_owner_vhca_id);
c01cfd0f111511 Jianbo Liu      2019-06-25  171  
c01cfd0f111511 Jianbo Liu      2019-06-25  172  		spec->match_criteria_enable |= MLX5_MATCH_MISC_PARAMETERS;
c01cfd0f111511 Jianbo Liu      2019-06-25  173  	}
c01cfd0f111511 Jianbo Liu      2019-06-25  174  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

