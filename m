Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE3B53755C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 09:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232956AbiE3HXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 03:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbiE3HXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 03:23:51 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31FBD52
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 00:23:48 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24U5ukVV007190;
        Mon, 30 May 2022 07:23:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=uqcjBnBUEe3ERdqfq0pmqf3Wsea4oU2c2NJCElqKhPI=;
 b=Kqw7Ftj+QJu1fUY3a2dh9mfXORQA3E6CT6PhG5/7GGpjAFM0Q8M9FxReO/MZSXdx++cy
 F7F0csVptIjjqA+k5QFMTVKPm1I78xUIeGfkz0j4k5LnBzZPHWTYVHrXH1HfPVITJGbl
 eYaeJvaMrVOImrO8OhHRXGfC6XSW7WnbQxc6bySQ/DaqT317fYJnJfjyLYK3B5HFYxUu
 9xlxD6FsiWyifMhfX/rpzYpgvCUVxyw9fFR7Y3XLAsGvpqJWOQa7o1ldYwplknhEQtHa
 m2E/q1CIG/xlFSCxpYiW43fSH4lIk/u85NcjbjPTbynjWHP1ntUxS8pVbQQAsaiGdzhQ 2Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gbcauj8x0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 May 2022 07:23:45 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24U7FnUk030693;
        Mon, 30 May 2022 07:23:45 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gc8hqfcj4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 May 2022 07:23:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i44yLwflfDF1WFiG9v3uQkwGuDeDK0cDJymxMMSyzCotxnfAIwKNZX9ptPTreLEGPn/7bpFWMPfVpCEX5sHwCj4n67sJyScn9mFM106j2cYefD09cta7UXo7VjQ7EnhRWFnXBGNmjqc1qO7tL3MnPCcCTX3ElG4dAs00EHbyr/2VnvEj3j6kJ4hZauxh/bcMHEcbFMmbEM2qRHJDw+I3wu0IMeqhgcyWVxMJxxDtEHyij7ea59qUhWeoCZnhja7++d4/GLJ3ToMsBKot6RmQqsltgZ6fLv6nat7w371nZt7i0RxV0L5WkW8FNkrzYxgVP41MhHyuZZ2iCdtiwTviGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uqcjBnBUEe3ERdqfq0pmqf3Wsea4oU2c2NJCElqKhPI=;
 b=Lz8ga6EwBWMmMkZPl5LAEj8kqdxemumYKQAhTXDXe2iYcz34cxk82Kcl/+rCK7RzMgLhZHqynJI+9NU6ohNnqWMgYLQ2kod2OnL8Ptt+mlvolCBarEOjK9dMRH9XHTd12wwiufbN6ZSy1Aum9LkhNPAF7lUnulmk4vCHI17T6Huu4P2HVWl1PADy613pjixGrgu1yypMBWuzyEZpiB+poD96/2fwFmwaKD8P746NPZ8/UsZ8+zysTcjEydFYCenlSQAQiocQusaXuXGELYbaFKN2zdiRe8j6s+zDMqZg84eQQ+IGIPdyBXtDuhy7kwm17LGCiLRlg5apAamqtI5MGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uqcjBnBUEe3ERdqfq0pmqf3Wsea4oU2c2NJCElqKhPI=;
 b=LwY/GbKDPHLek8w1F1/Xtz7QA0RVYDLfAQHpIc0iasH30VhG2Pk94iJAIyJ9RUdsujZnx4r1I9X5QM1hbZMzaxppCjwq+QOW+sU2IUWC12luhHLXqSn3dNS2TvV+oDoW8eLf70l/EE1nP3z4I1ceCACvnez6us3r4uK1x9on9CY=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN0PR10MB5030.namprd10.prod.outlook.com
 (2603:10b6:408:12a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Mon, 30 May
 2022 07:23:43 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e%2]) with mapi id 15.20.5293.019; Mon, 30 May 2022
 07:23:42 +0000
Date:   Mon, 30 May 2022 10:23:23 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Jiri Pirko <jiri@nvidia.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jpirko-mlxsw:jiri_devel_components 1/3] net/core/devlink.c:6558
 devlink_nl_info_fill() warn: missing error code 'err'
Message-ID: <202205281346.ewkXalBD-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0054.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::20)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27b41d1b-a808-43c3-c09d-08da420d5355
X-MS-TrafficTypeDiagnostic: BN0PR10MB5030:EE_
X-Microsoft-Antispam-PRVS: <BN0PR10MB5030629F33C638E551469DEE8EDD9@BN0PR10MB5030.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mdDXbFh++c7CjwVmHHls9+FPwz5O07lhSj7PpRyMOEPDRVm5IrFsODMgTWu9NwH524lOMGNmhbJCyNRxFWDUK2+iaEVFr6+e8lJwkVO7bssjshUIK22viKl9Nn0KxLJ3zQzftwS9jE5cy03fhnad9zk1InuxPmDSanwAPNROdNtf8M12haPa15GnOUj2xxDC86ejBfT9vKPI00XCldyRIiGCd0XT3r137o3saCKGUESo4q9bTjY4zWTNsRnsjlMdoZ5MGcPASakbncGNSK14U1PqUT9K+WM+DQ6bWz99FN3sOovjeIoXj1a64EjdlK6dwahXLgj+pHpm+2avaVdP43YP8assZQASqovbeXvm6dRCTBi2zIBZgyk29k2H9CMLecIIAabIXOvvapuNT1i1/VV7GcFBT12NhMbETpDeRRUbB6ZutcrpuJMvP9XKiUrQSqfOiLTUmOP7eV+npraUWhBRKVxiVInSJNtAtt9D1oU6ynPLTbsIF3Hn5YTbEQnb6ThMmCZOPkooHWBHpfswqwP5dad/1PymDRjg4XyxdKXBs0RDjdvLpSiW3AMeAY/NqhhD/R7nM4kv3vZCk6fH2apR3QNKgiA+dz1PVR5WbfXDeIxnsw7feyY3aj2kFvVc/MwkEY0LCcoIdaOpAczjv9WNrek8PBp0Q+qSDLHToYyIrF44hXInaaVOmze14COLvaTzeTzWhfXVzBzOvQ9sxcHqDjGnNNe2LQKm267RlU41p+HyiB4B0SHpfE+ECoI44/Al/alBR+HZHdlipSrwFWjj8GIZORcZRYnsegZ5m551+h6b5QZDmdciJ4SKHiSa7/+WYMUi5kKLg75qMAzvng==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(186003)(52116002)(86362001)(6666004)(2906002)(38350700002)(966005)(1076003)(6486002)(26005)(6916009)(6512007)(9686003)(508600001)(8676002)(6506007)(5660300002)(83380400001)(44832011)(36756003)(4326008)(66946007)(8936002)(38100700002)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EWd4T0qbhv1isHCwbn8f/xhHfcE2LF7p0S8/hlcbpA7jxRK2GFaGACJTknbc?=
 =?us-ascii?Q?PV0s5Ty8Ek1StM0uYTUP1ephJut3JNKGjvo0twyY4HD6oYB/1MwaXtj00L2q?=
 =?us-ascii?Q?rtUZ9c+VJAj5YUU0j56XGqPOGWvafdEHHfeAr//QV9Da4f9hbre6NLGc3eEY?=
 =?us-ascii?Q?3jC/LBQLfok1Bea5bBkVtQ2LrbwGa6CjkXYiGu4UrxJg1FaChvS+3KPFx9d0?=
 =?us-ascii?Q?VdT/OcheuFsEHAxjQ6oT1Mxr0J2Njfn6Oxz2Bo9Hkpr2dDne2jhdbwTSbBp/?=
 =?us-ascii?Q?vYNeY3nBP/5dnXTmXD3zidOykOszfn29e33lIuMIaaUArOcYcJB8VjBPN8GD?=
 =?us-ascii?Q?oMBtp/Uve3HfvSjk59bZYHvmA1gu/4gVuENBBC3BU7e2tzCrTRQez7MH2LfA?=
 =?us-ascii?Q?0fQJrDfsZxR8/7uY7HQnV+BA1ef72SGtBty2m/bYA/Ju2Cv32LBryt62QYr6?=
 =?us-ascii?Q?NkZujKEfI8mUGnyYrs6gQYb6uynBRk94lbYO12YZHdXyLcZfbtSkEGdoXxm1?=
 =?us-ascii?Q?xvBg8Aef26P+wLDw0PeGtujHpgRDcgi8if3QfUtYVFmakwpkPwMf4CGj2tn6?=
 =?us-ascii?Q?qbcF+khDbf3x9l0+PCsyt1fyIso1aqYBFJl0OFJOOkzkMkfFTc9I99AvIIno?=
 =?us-ascii?Q?su9Kx3YlbLaUmmSDlnqt2mzhVsAZHBnWC5BBZv4LhayP/fEZIabnMkmyB4xP?=
 =?us-ascii?Q?kSEhAsg58sOryFY89pa19dQ3pfcksb+I79XWI2a9Qdcrwn5maE+L5Rx3/HRr?=
 =?us-ascii?Q?YbT57oFR/Wkay2GdX2RPPXKmTPgh8AuG+Y8zCmgGBdesf7y1GFTf+geUb9G1?=
 =?us-ascii?Q?3cMWM5n1DxLnsA4iHBWJ677ACpcA3ebo1By5rdQlkQyb0BkW8ikpkFFBxzH/?=
 =?us-ascii?Q?JLG6/YNtEXiZUlGhzmfOey8ZEk43P3wYDekKmMMJE8aiMI8g+CQUMR26KlWa?=
 =?us-ascii?Q?DOQXvEdgfy2LWMPZ2xZ2lu0X7n9rriTyp1pvIlJn2rWDVB+zs/rNINqFH1aJ?=
 =?us-ascii?Q?xzenAQWQ8aaW+kOzNwGmcLp4qyayYs4ivajeYBQDL+JbIH8xOE2xq4wAKVJy?=
 =?us-ascii?Q?KpNjKZDTEL+r+/RCvjeTIh3GY6PGeJ4UWOokuywaaNHPie5GC25rh5oNatKL?=
 =?us-ascii?Q?kE9via70xneQ5CNp4S9LzMeHKzQ+ov7u3AyM8/ZdKcYtj8tIMRfmc3oNen+2?=
 =?us-ascii?Q?qwqpMwp/g7CmAMBkqVTXY9MWdSgoKbeVmark/IZCI7rwIQSWIWH/4iGAtG4X?=
 =?us-ascii?Q?2WNdaXFkB1uEPky0goM8bpvwEtN6itDCGKEIttDmZuV2BvhdtnlPnBsONvhd?=
 =?us-ascii?Q?i58SB/oBzUuEQDhG2ekTKzsKUhWmF7zYpXqJz9WWHc7IT5/DNvXVc0+NM8q3?=
 =?us-ascii?Q?XVg08xLQpEV4HDWjrLAokrGPF3cwl8pghvF0uQ/KUIEu4Vqrjdf9+pXa/0gO?=
 =?us-ascii?Q?wIn+yAzA4n2j6KAyPm3qw8WVhnMo6RLR6f7T6TnKTsIamxjVrD7vCxDZXhhr?=
 =?us-ascii?Q?ekrbxIcH78rUru/wQRwqJ9SyW5v3XUN4Ir+o6bZ++LcMSwmtzgd+Gq4nR1wq?=
 =?us-ascii?Q?Lm9u6EkJ/CqSK8QFNOEYd+sARzzxmzUi3kJCpScLGlifLtYG7/Ig1J+QgcLf?=
 =?us-ascii?Q?FIN4bggb4/FxWgdMg89COyZB+sOdzRWnEjImQBDbRk2dRjV8YUrNBIr7kYvv?=
 =?us-ascii?Q?Ij2lFzekIETybDWMssrROd15IACLXGj0qnDmirAOVhxLEOJmEnvzaquR52OG?=
 =?us-ascii?Q?/75K+GYuasY601S8+Ah9MldBuzHZRLo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27b41d1b-a808-43c3-c09d-08da420d5355
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2022 07:23:42.8358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +9bT/fjByHUEYi+9iBEQV3vyYytsTO7WjTPYlAdwjekzZihtHinDIABwu9ZYP7DmJXv33AkNDNQ3CDJpYLVZIiyJlEAQblCYGja44vswZEs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5030
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-30_02:2022-05-27,2022-05-30 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2205300038
X-Proofpoint-ORIG-GUID: vfJQgJql7Qfg7BXMTESzaIK6kez-1pxf
X-Proofpoint-GUID: vfJQgJql7Qfg7BXMTESzaIK6kez-1pxf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jpirko/linux_mlxsw jiri_devel_components
head:   9360f04ac2b51764d94b40113ef1b21b95835ae6
commit: e7261a9db46b29988444322b7b506954c06a7f4d [1/3] net: devlink: introduce flash components list
config: arc-randconfig-m031-20220524 (https://download.01.org/0day-ci/archive/20220528/202205281346.ewkXalBD-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
net/core/devlink.c:6558 devlink_nl_info_fill() warn: missing error code 'err'

Old smatch warnings:
net/core/devlink.c:7154 devlink_fmsg_prepare_skb() error: uninitialized symbol 'err'.

vim +/err +6558 net/core/devlink.c

f9cf22882c606f Jakub Kicinski 2019-01-31  6530  static int
f9cf22882c606f Jakub Kicinski 2019-01-31  6531  devlink_nl_info_fill(struct sk_buff *msg, struct devlink *devlink,
f9cf22882c606f Jakub Kicinski 2019-01-31  6532  		     enum devlink_command cmd, u32 portid,
f9cf22882c606f Jakub Kicinski 2019-01-31  6533  		     u32 seq, int flags, struct netlink_ext_ack *extack)
f9cf22882c606f Jakub Kicinski 2019-01-31  6534  {
e7261a9db46b29 Jiri Pirko     2022-05-27  6535  	struct devlink_flash_component *component;
e7261a9db46b29 Jiri Pirko     2022-05-27  6536  	struct nlattr *component_attr;
f9cf22882c606f Jakub Kicinski 2019-01-31  6537  	struct devlink_info_req req;
f9cf22882c606f Jakub Kicinski 2019-01-31  6538  	void *hdr;
f9cf22882c606f Jakub Kicinski 2019-01-31  6539  	int err;
f9cf22882c606f Jakub Kicinski 2019-01-31  6540  
f9cf22882c606f Jakub Kicinski 2019-01-31  6541  	hdr = genlmsg_put(msg, portid, seq, &devlink_nl_family, flags, cmd);
f9cf22882c606f Jakub Kicinski 2019-01-31  6542  	if (!hdr)
f9cf22882c606f Jakub Kicinski 2019-01-31  6543  		return -EMSGSIZE;
f9cf22882c606f Jakub Kicinski 2019-01-31  6544  
f9cf22882c606f Jakub Kicinski 2019-01-31  6545  	err = -EMSGSIZE;
f9cf22882c606f Jakub Kicinski 2019-01-31  6546  	if (devlink_nl_put_handle(msg, devlink))
f9cf22882c606f Jakub Kicinski 2019-01-31  6547  		goto err_cancel_msg;
f9cf22882c606f Jakub Kicinski 2019-01-31  6548  
f9cf22882c606f Jakub Kicinski 2019-01-31  6549  	req.msg = msg;
f9cf22882c606f Jakub Kicinski 2019-01-31  6550  	err = devlink->ops->info_get(devlink, &req, extack);
f9cf22882c606f Jakub Kicinski 2019-01-31  6551  	if (err)
f9cf22882c606f Jakub Kicinski 2019-01-31  6552  		goto err_cancel_msg;
f9cf22882c606f Jakub Kicinski 2019-01-31  6553  
e7261a9db46b29 Jiri Pirko     2022-05-27  6554  	mutex_lock(&devlink->components_lock);
e7261a9db46b29 Jiri Pirko     2022-05-27  6555  	list_for_each_entry(component, &devlink->component_list, list) {
e7261a9db46b29 Jiri Pirko     2022-05-27  6556  		component_attr = nla_nest_start(msg, DEVLINK_ATTR_INFO_COMPONENT);
e7261a9db46b29 Jiri Pirko     2022-05-27  6557  		if (!component_attr)
e7261a9db46b29 Jiri Pirko     2022-05-27 @6558  			goto err_cancel_msg_unlock;

Is this an error path?

e7261a9db46b29 Jiri Pirko     2022-05-27  6559  		if (nla_put_string(msg, DEVLINK_ATTR_FLASH_UPDATE_COMPONENT,
e7261a9db46b29 Jiri Pirko     2022-05-27  6560  				   component->name))
e7261a9db46b29 Jiri Pirko     2022-05-27  6561  			goto err_cancel_msg_unlock;

Same

e7261a9db46b29 Jiri Pirko     2022-05-27  6562  		err = component->info_get(devlink, &req, component->priv,
e7261a9db46b29 Jiri Pirko     2022-05-27  6563  					  extack);
e7261a9db46b29 Jiri Pirko     2022-05-27  6564  		if (err)
e7261a9db46b29 Jiri Pirko     2022-05-27  6565  			goto err_cancel_msg_unlock;
e7261a9db46b29 Jiri Pirko     2022-05-27  6566  		nla_nest_end(msg, component_attr);
e7261a9db46b29 Jiri Pirko     2022-05-27  6567  	}
e7261a9db46b29 Jiri Pirko     2022-05-27  6568  	mutex_unlock(&devlink->components_lock);
f9cf22882c606f Jakub Kicinski 2019-01-31  6569  	genlmsg_end(msg, hdr);
f9cf22882c606f Jakub Kicinski 2019-01-31  6570  	return 0;
f9cf22882c606f Jakub Kicinski 2019-01-31  6571  
e7261a9db46b29 Jiri Pirko     2022-05-27  6572  err_cancel_msg_unlock:
e7261a9db46b29 Jiri Pirko     2022-05-27  6573  	mutex_unlock(&devlink->components_lock);
f9cf22882c606f Jakub Kicinski 2019-01-31  6574  err_cancel_msg:
f9cf22882c606f Jakub Kicinski 2019-01-31  6575  	genlmsg_cancel(msg, hdr);
f9cf22882c606f Jakub Kicinski 2019-01-31  6576  	return err;
f9cf22882c606f Jakub Kicinski 2019-01-31  6577  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

