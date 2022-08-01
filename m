Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C086586826
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 13:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbiHALb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 07:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiHALb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 07:31:27 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA089E00F
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 04:31:24 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 271AnJUP032468;
        Mon, 1 Aug 2022 11:30:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=N76SRSVTJmbO1wJiuzKBU/HrZ9K0wmXWCL4qvVYifrs=;
 b=pFMBZ3ZclluxT7nD2/0G0vpru/WHPtyKA312gP1Ka07z1ZivMf/vfuADw7IQDjkDC2sR
 e1Qz2cj0XWq/JR/yDuJpnA8vm0Ki0mjXThqKGOmX3JNxyNzkt19TA0KeaqdRkScqaYMH
 X3wIZaUjTK1cJp3Kv/A5+3kEzdQnpAaAyvXWSRD/OlAI/df6/hKug1md1NHNMm1CcuLo
 XMmC5h9DMbiV5xgE6pwdlxONZ4DrQetWLEJs9IW9oN8aYTQ/TQagazdsRLId7RGOG1Q5
 /8s1g42SgjgfYZPc13I4VGATs4OH2rI1zxMZe1eaoz9lDXUDvbsQlZ6XQ7KRbH3/015c /g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmw6tbc2y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Aug 2022 11:30:42 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2719wiK4014927;
        Mon, 1 Aug 2022 11:30:40 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hmu316kra-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Aug 2022 11:30:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QH3hhWuhsaLubPZ6YB/SNXJfy91VhxXZh97TNv2KXO24KXsYfKmteIr6+Ag9F/4e6quTd8Gb/IVvTdN6EBMO2KzoKm5D5M14I6VHUodGSOux0ICKygz/jPIZ7/SaRcaCTuNxRReDr8jfE+lQe8TM5eg7sDTZOwGQ7qd5HGy4YbYB8bjUVpzDBGtKhhy62is3d6znDDqg4qY50GKqur/atGELKuvawewqdw6aviJK933VD05XXxaxCpQVF1LePBa3bbE7LOjzxWuyd6r1OTwlnJE+mN1np72iOBI6akMbbhjv5DFqZfuXPOCnMCuCJsAqGcuu7Q3IS6Log2Ete83nPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N76SRSVTJmbO1wJiuzKBU/HrZ9K0wmXWCL4qvVYifrs=;
 b=IvE2obQnIe8nFQVKWgNVb3RIRifRUv6lFfqhFwaspYktq9C/wWB/DhorBO0t8u8LhwfD2VXIfFrMLvU/LF+PYYY61hmSR3bcM7tedegpVvdgxPb6JCIwAMtJSfxBdxZVO9U9WiHZ3beEsW8viXuczKjUikndg22gdJBwnCq8z+lwaGtHdKz7wy8h8q7cMiRHYamjAmSb1yrrs70H859x7OzBj1jO8UfV+pftNngQrSrHy43Gunpq2BFImALTuQaWfNgj8anSUFZU4pRXa51rceZ1Q/FQWKfkmUG+O1+d8chyRgbHomnkQJ1xXmsqxEtp8WtLbNMNrn501N6yAvJBAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N76SRSVTJmbO1wJiuzKBU/HrZ9K0wmXWCL4qvVYifrs=;
 b=qcKUjv/jSIp14494C0WIPaaieeQZl3ULCwvNgr5G9tCaGQNAQ9nBlsTG4jaH3Uj1fvkMVhOttbLSscoOtsd3TNb/JK6rx5/dNdxJELNKUKCsFw4JtqKoZXMttiP5qQg0lS90sIUCBxxCskSTF/t1PAbWjnA+erYmzdcyHJ3hQ8E=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM5PR1001MB2300.namprd10.prod.outlook.com
 (2603:10b6:4:2f::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.12; Mon, 1 Aug
 2022 11:30:38 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 11:30:37 +0000
Date:   Mon, 1 Aug 2022 14:29:56 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Jiri Pirko <jiri@nvidia.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:netdev/net-next/main 20/29]
 net/core/devlink.c:6392 devlink_nl_cmd_region_new() warn: inconsistent
 returns '&region->snapshot_lock'.
Message-ID: <202207311503.QBFSGqiL-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0010.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::22)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c312770d-b77f-40bf-8f42-08da73b141bb
X-MS-TrafficTypeDiagnostic: DM5PR1001MB2300:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8pJZ+mreuurvbe2Vzp9/qGE9ae14oyZZFng7v4g/IFpcBPl7fiRInKqRoulu2NP3iCcfnDt54Zifxiz01OZ+O06SLcifH7K/3AKHO4Cro7slc3Opr2B1IXgKoRGLTbY6fvbwrX4grk8jUxTVLWEMJK1seaAQ12yLg7PvlZISuGNSc0KVlYmuzRm2KPX3gXLk9AT1c8BcWI4D1FLV4Z5I2r1STbi16XoJq9hn1RQgr90daEEzU7Fb9p+FNSYfCmssP/UbUORGbawC9oNXDhb6LkrF/3jRUqA77UHzAjD+5zknatZdRMTj4QM4DVYQe7w87aLWyzsLOJCixKvlDZYpcg8fdMRl8cmYPer9XvwMAFWlCpA0ysEPLGJHSANq3SCQ7XbPK0100Z4llWW8QhyBYq3pVJZg1vG18ckCW70st4A1hlzNyZ4hKsbvY6gdXhS8LY1KjFpjJwf9GKGHnW1uvb7gPq3ZTrP4SwFrGZjx0gpGd/8H20q1aq2DRXhxq8UeaMAmo+qdq5ewmHij9SuawwipBbcfmTholuWJTNxDW8GILhVeNO/5F3bNdPHTSWczITKJUwPe/9EYnK6f6sPWA2Wqw7PGCTyBRRxB48vKIwt9gp8QaNr1UkmQgHm0nIKIi/FlMPspCxuEbfsmgpDfaNBATYk6jHomzvlsMLWTpPd1XJvKzSmkVV0dmYjpS2EMaoTjBBL3D34dyhdOcXTOTIo9GD0o4RhBxscLnj521YWoYQk7YJfl8j09OIM64tstg42zQbTHnBaQ95cv4i3jwpG4ZBsDq00FIht5kN5QiKwKzOJHXyAZ17pSY+HOEBZAzw9Cma3U5kIgyvX24YDfE/spqy6S31WcNiE/vLqwFTuWN7AQFt+mgjcXPGR1UtyG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(39860400002)(136003)(396003)(366004)(8676002)(4326008)(66556008)(44832011)(66946007)(5660300002)(66476007)(38100700002)(38350700002)(2906002)(54906003)(478600001)(36756003)(6486002)(966005)(9686003)(6666004)(26005)(6512007)(86362001)(6506007)(6916009)(186003)(316002)(41300700001)(8936002)(52116002)(1076003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4RJ/8W3cj68NHEnkWhr+RpvLwBYgDBdaY2/7MEgO/ttS/xdZeuM59eKUMtbl?=
 =?us-ascii?Q?gCqX3eMFncr4yCjuysp9baxCQLQJZtm2gAhabDey78lwvtkt60BeiCgIQC1g?=
 =?us-ascii?Q?9iDoSHCFGl5nB1RIFcWb8FasEubwrUUCctiwgba4XFJWZ+TCzFHFlJRKir7Y?=
 =?us-ascii?Q?+rUa+04OrmVBgOLtGBCIuBQAZsHd6JeKwhr4grbgkPftYTu2IdetGWANOoJs?=
 =?us-ascii?Q?phDSMr1h5fVXx5tEb7/mxa/jcTWue6JjPez1zcxz/NYPqHmGN+KrHZ+Nfok4?=
 =?us-ascii?Q?xKfd6bckBtKTXhiRAvW926rwL3pAufVD6ep7mD8c/qESb6vhrSGCkC2M+cEq?=
 =?us-ascii?Q?sbsJ/VaDC46UEa4mIMkSpO3/rrZ60eHUMem5IJE14EXrRhEnORuGRlVwhzlB?=
 =?us-ascii?Q?DuRi1oGk2xp9hMidMODbKgsu9yc1MTLhQQBeN6EghSL+KcdPVhat9Aje0tr7?=
 =?us-ascii?Q?Feg6a2OUxjmmAlEQA7k+pWiqb4UZCp3LVwTiFhCz8Qj/1ocyhNlzPW0xGZgX?=
 =?us-ascii?Q?6Mj0fWYBAuYyN+y5/ra0lvhUfXUdG65TOqoPWUOwPtW4KogSWDqQTAglSHaD?=
 =?us-ascii?Q?QAxpWGRfo0WVXzWFyRQaLNTCOgt3RbafhPX0OlWLRh2u9BlQ2YGOOQnVgHF8?=
 =?us-ascii?Q?D8MVNmWHpBU82mMTEFGVmDqz8qBxkAIVKoxc9nna5zApdZTIzuMeTu9cqtby?=
 =?us-ascii?Q?mKTeOUcnU40J4Llzcm2P4h/SMrgeeVmKsVtscb1dHfJOWLh5KtBp/vr36yi3?=
 =?us-ascii?Q?JBaAWpBGx2m2eSLu3AHhwUDEcECzUqgiU1wVI8TLTmNUBu3JcpfYzG3/m11D?=
 =?us-ascii?Q?XriBEPGGNYXkQuU9u5LGTQteSUbFwXHUcMt9VYegqt9WaTR8aU+lMblMXm5H?=
 =?us-ascii?Q?whUw/JoNbcPE3HeNooeOnnlVUmhILTWRSfhA8xu3drngOxRiI4Qzy4oPqchE?=
 =?us-ascii?Q?PkkVTf0CRtsBGtWcrMssdNWfuNxEOxDF0IHudFAOI1ZWI48fOB5wZD/dYyB6?=
 =?us-ascii?Q?u2lhgw9Zg+MlsZu2W3gjfqirczWhSjpiOEVvxnCWMzEM3sWTCGvFKDVoowER?=
 =?us-ascii?Q?aDqmOcsexTa13XR6xADDg189j8yuUkoYDceY88oFI+UWP6OtXPc8FvrpYsMA?=
 =?us-ascii?Q?wICMiM1tmSw+Oq+xyD5NiF4BZKThyW0kn7GRjw8c2GM9laiQhFJcWqcuOi5/?=
 =?us-ascii?Q?Bi1H4WV6VN7lRAfhvC/ADPXA754gXL87pDdg/CHIukZFkmGZz41Yj4ruAc86?=
 =?us-ascii?Q?jbkqOcquCzfIY6YK58hlQ8NSyR+oVS+zIz68+cMG3rwuuYQnnWjMyaGmgWaO?=
 =?us-ascii?Q?TTXkQvrQVI0r3t6HnFL0nKTgvnGQgR4vSPwivTqZ8t20/HHp8dZk3B/CB6hS?=
 =?us-ascii?Q?KPVt9hpL/YFI/O1rTpGQXz8F70pHT/qDb/ss4fa2Slk0THwxcRZL31YukNbT?=
 =?us-ascii?Q?7ZSidFSgQXJGwKGLuDhyJskcp0vR4SdlaGmNzh6ILydcs9XjRq014uezr+BO?=
 =?us-ascii?Q?yPRXupKMA4kyrxvl8mxCOfjxhXVoHHPTdhaC/TMejMqNpZ70eEivX2jWMCgO?=
 =?us-ascii?Q?fVMjnfih6nH2BLaul6J4zHT4aeqkmDYMTprNE8FNQZ4WX1PLYnCAm+MpIVrO?=
 =?us-ascii?Q?EQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c312770d-b77f-40bf-8f42-08da73b141bb
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 11:30:37.6812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IZE8hSRWitOYHp/jzX2aFdqn+I9nqIyHKUJ4bw1hT2SNQ3iXhA5XZlWEvce7dW3SAgQLD99VLG0mJ4e6eBu1Ewngpzja/YkBmop9yq3nqLc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2300
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-01_05,2022-08-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2208010056
X-Proofpoint-GUID: KdjbPTLPf6ZHroW8KBoC17Q2upXq9f9i
X-Proofpoint-ORIG-GUID: KdjbPTLPf6ZHroW8KBoC17Q2upXq9f9i
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block netdev/net-next/main
head:   63757225a93353bc2ce4499af5501eabdbbf23f9
commit: 2dec18ad826f52658f7781ee995d236cc449b678 [20/29] net: devlink: remove region snapshots list dependency on devlink->lock
config: arc-randconfig-m041-20220731 (https://download.01.org/0day-ci/archive/20220731/202207311503.QBFSGqiL-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
net/core/devlink.c:6392 devlink_nl_cmd_region_new() warn: inconsistent returns '&region->snapshot_lock'.

Old smatch warnings:
net/core/devlink.c:7284 devlink_fmsg_prepare_skb() error: uninitialized symbol 'err'.
arch/arc/include/asm/thread_info.h:62 current_thread_info() error: uninitialized symbol 'sp'.

vim +6392 net/core/devlink.c

b9a17abfde842b Jacob Keller   2020-03-26  6271  static int
b9a17abfde842b Jacob Keller   2020-03-26  6272  devlink_nl_cmd_region_new(struct sk_buff *skb, struct genl_info *info)
b9a17abfde842b Jacob Keller   2020-03-26  6273  {
b9a17abfde842b Jacob Keller   2020-03-26  6274  	struct devlink *devlink = info->user_ptr[0];
043b3e22768d5d Jakub Kicinski 2020-05-01  6275  	struct devlink_snapshot *snapshot;
544e7c33ec2f80 Andrew Lunn    2020-10-04  6276  	struct devlink_port *port = NULL;
043b3e22768d5d Jakub Kicinski 2020-05-01  6277  	struct nlattr *snapshot_id_attr;
b9a17abfde842b Jacob Keller   2020-03-26  6278  	struct devlink_region *region;
b9a17abfde842b Jacob Keller   2020-03-26  6279  	const char *region_name;
544e7c33ec2f80 Andrew Lunn    2020-10-04  6280  	unsigned int index;
b9a17abfde842b Jacob Keller   2020-03-26  6281  	u32 snapshot_id;
b9a17abfde842b Jacob Keller   2020-03-26  6282  	u8 *data;
b9a17abfde842b Jacob Keller   2020-03-26  6283  	int err;
b9a17abfde842b Jacob Keller   2020-03-26  6284  
b9a17abfde842b Jacob Keller   2020-03-26  6285  	if (!info->attrs[DEVLINK_ATTR_REGION_NAME]) {
b9a17abfde842b Jacob Keller   2020-03-26  6286  		NL_SET_ERR_MSG_MOD(info->extack, "No region name provided");
b9a17abfde842b Jacob Keller   2020-03-26  6287  		return -EINVAL;
b9a17abfde842b Jacob Keller   2020-03-26  6288  	}
b9a17abfde842b Jacob Keller   2020-03-26  6289  
b9a17abfde842b Jacob Keller   2020-03-26  6290  	region_name = nla_data(info->attrs[DEVLINK_ATTR_REGION_NAME]);
544e7c33ec2f80 Andrew Lunn    2020-10-04  6291  
544e7c33ec2f80 Andrew Lunn    2020-10-04  6292  	if (info->attrs[DEVLINK_ATTR_PORT_INDEX]) {
544e7c33ec2f80 Andrew Lunn    2020-10-04  6293  		index = nla_get_u32(info->attrs[DEVLINK_ATTR_PORT_INDEX]);
544e7c33ec2f80 Andrew Lunn    2020-10-04  6294  
544e7c33ec2f80 Andrew Lunn    2020-10-04  6295  		port = devlink_port_get_by_index(devlink, index);
544e7c33ec2f80 Andrew Lunn    2020-10-04  6296  		if (!port)
544e7c33ec2f80 Andrew Lunn    2020-10-04  6297  			return -ENODEV;
544e7c33ec2f80 Andrew Lunn    2020-10-04  6298  	}
544e7c33ec2f80 Andrew Lunn    2020-10-04  6299  
544e7c33ec2f80 Andrew Lunn    2020-10-04  6300  	if (port)
544e7c33ec2f80 Andrew Lunn    2020-10-04  6301  		region = devlink_port_region_get_by_name(port, region_name);
544e7c33ec2f80 Andrew Lunn    2020-10-04  6302  	else
b9a17abfde842b Jacob Keller   2020-03-26  6303  		region = devlink_region_get_by_name(devlink, region_name);
544e7c33ec2f80 Andrew Lunn    2020-10-04  6304  
b9a17abfde842b Jacob Keller   2020-03-26  6305  	if (!region) {
b9a17abfde842b Jacob Keller   2020-03-26  6306  		NL_SET_ERR_MSG_MOD(info->extack, "The requested region does not exist");
b9a17abfde842b Jacob Keller   2020-03-26  6307  		return -EINVAL;
b9a17abfde842b Jacob Keller   2020-03-26  6308  	}
b9a17abfde842b Jacob Keller   2020-03-26  6309  
b9a17abfde842b Jacob Keller   2020-03-26  6310  	if (!region->ops->snapshot) {
b9a17abfde842b Jacob Keller   2020-03-26  6311  		NL_SET_ERR_MSG_MOD(info->extack, "The requested region does not support taking an immediate snapshot");
b9a17abfde842b Jacob Keller   2020-03-26  6312  		return -EOPNOTSUPP;
b9a17abfde842b Jacob Keller   2020-03-26  6313  	}
b9a17abfde842b Jacob Keller   2020-03-26  6314  
2dec18ad826f52 Jiri Pirko     2022-07-28  6315  	mutex_lock(&region->snapshot_lock);

New locking

2dec18ad826f52 Jiri Pirko     2022-07-28  6316  
b9a17abfde842b Jacob Keller   2020-03-26  6317  	if (region->cur_snapshots == region->max_snapshots) {
b9a17abfde842b Jacob Keller   2020-03-26  6318  		NL_SET_ERR_MSG_MOD(info->extack, "The region has reached the maximum number of stored snapshots");
2dec18ad826f52 Jiri Pirko     2022-07-28  6319  		err = -ENOSPC;
2dec18ad826f52 Jiri Pirko     2022-07-28  6320  		goto unlock;
b9a17abfde842b Jacob Keller   2020-03-26  6321  	}
b9a17abfde842b Jacob Keller   2020-03-26  6322  
043b3e22768d5d Jakub Kicinski 2020-05-01  6323  	snapshot_id_attr = info->attrs[DEVLINK_ATTR_REGION_SNAPSHOT_ID];
043b3e22768d5d Jakub Kicinski 2020-05-01  6324  	if (snapshot_id_attr) {
043b3e22768d5d Jakub Kicinski 2020-05-01  6325  		snapshot_id = nla_get_u32(snapshot_id_attr);
b9a17abfde842b Jacob Keller   2020-03-26  6326  
b9a17abfde842b Jacob Keller   2020-03-26  6327  		if (devlink_region_snapshot_get_by_id(region, snapshot_id)) {
b9a17abfde842b Jacob Keller   2020-03-26  6328  			NL_SET_ERR_MSG_MOD(info->extack, "The requested snapshot id is already in use");
2dec18ad826f52 Jiri Pirko     2022-07-28  6329  			err = -EEXIST;
2dec18ad826f52 Jiri Pirko     2022-07-28  6330  			goto unlock;
b9a17abfde842b Jacob Keller   2020-03-26  6331  		}
b9a17abfde842b Jacob Keller   2020-03-26  6332  
b9a17abfde842b Jacob Keller   2020-03-26  6333  		err = __devlink_snapshot_id_insert(devlink, snapshot_id);
b9a17abfde842b Jacob Keller   2020-03-26  6334  		if (err)
2dec18ad826f52 Jiri Pirko     2022-07-28  6335  			goto unlock;
043b3e22768d5d Jakub Kicinski 2020-05-01  6336  	} else {
043b3e22768d5d Jakub Kicinski 2020-05-01  6337  		err = __devlink_region_snapshot_id_get(devlink, &snapshot_id);
043b3e22768d5d Jakub Kicinski 2020-05-01  6338  		if (err) {
043b3e22768d5d Jakub Kicinski 2020-05-01  6339  			NL_SET_ERR_MSG_MOD(info->extack, "Failed to allocate a new snapshot id");
2dec18ad826f52 Jiri Pirko     2022-07-28  6340  			goto unlock;
043b3e22768d5d Jakub Kicinski 2020-05-01  6341  		}
043b3e22768d5d Jakub Kicinski 2020-05-01  6342  	}
b9a17abfde842b Jacob Keller   2020-03-26  6343  
544e7c33ec2f80 Andrew Lunn    2020-10-04  6344  	if (port)
544e7c33ec2f80 Andrew Lunn    2020-10-04  6345  		err = region->port_ops->snapshot(port, region->port_ops,
544e7c33ec2f80 Andrew Lunn    2020-10-04  6346  						 info->extack, &data);
544e7c33ec2f80 Andrew Lunn    2020-10-04  6347  	else
544e7c33ec2f80 Andrew Lunn    2020-10-04  6348  		err = region->ops->snapshot(devlink, region->ops,
544e7c33ec2f80 Andrew Lunn    2020-10-04  6349  					    info->extack, &data);
b9a17abfde842b Jacob Keller   2020-03-26  6350  	if (err)
b9a17abfde842b Jacob Keller   2020-03-26  6351  		goto err_snapshot_capture;
b9a17abfde842b Jacob Keller   2020-03-26  6352  
b9a17abfde842b Jacob Keller   2020-03-26  6353  	err = __devlink_region_snapshot_create(region, data, snapshot_id);
b9a17abfde842b Jacob Keller   2020-03-26  6354  	if (err)
b9a17abfde842b Jacob Keller   2020-03-26  6355  		goto err_snapshot_create;
b9a17abfde842b Jacob Keller   2020-03-26  6356  
043b3e22768d5d Jakub Kicinski 2020-05-01  6357  	if (!snapshot_id_attr) {
043b3e22768d5d Jakub Kicinski 2020-05-01  6358  		struct sk_buff *msg;
043b3e22768d5d Jakub Kicinski 2020-05-01  6359  
043b3e22768d5d Jakub Kicinski 2020-05-01  6360  		snapshot = devlink_region_snapshot_get_by_id(region,
043b3e22768d5d Jakub Kicinski 2020-05-01  6361  							     snapshot_id);
043b3e22768d5d Jakub Kicinski 2020-05-01  6362  		if (WARN_ON(!snapshot))
043b3e22768d5d Jakub Kicinski 2020-05-01  6363  			return -EINVAL;

unlock before returning?

043b3e22768d5d Jakub Kicinski 2020-05-01  6364  
043b3e22768d5d Jakub Kicinski 2020-05-01  6365  		msg = devlink_nl_region_notify_build(region, snapshot,
043b3e22768d5d Jakub Kicinski 2020-05-01  6366  						     DEVLINK_CMD_REGION_NEW,
043b3e22768d5d Jakub Kicinski 2020-05-01  6367  						     info->snd_portid,
043b3e22768d5d Jakub Kicinski 2020-05-01  6368  						     info->snd_seq);
043b3e22768d5d Jakub Kicinski 2020-05-01  6369  		err = PTR_ERR_OR_ZERO(msg);
043b3e22768d5d Jakub Kicinski 2020-05-01  6370  		if (err)
043b3e22768d5d Jakub Kicinski 2020-05-01  6371  			goto err_notify;
043b3e22768d5d Jakub Kicinski 2020-05-01  6372  
043b3e22768d5d Jakub Kicinski 2020-05-01  6373  		err = genlmsg_reply(msg, info);
043b3e22768d5d Jakub Kicinski 2020-05-01  6374  		if (err)
043b3e22768d5d Jakub Kicinski 2020-05-01  6375  			goto err_notify;
043b3e22768d5d Jakub Kicinski 2020-05-01  6376  	}
043b3e22768d5d Jakub Kicinski 2020-05-01  6377  
2dec18ad826f52 Jiri Pirko     2022-07-28  6378  	mutex_unlock(&region->snapshot_lock);
b9a17abfde842b Jacob Keller   2020-03-26  6379  	return 0;
b9a17abfde842b Jacob Keller   2020-03-26  6380  
b9a17abfde842b Jacob Keller   2020-03-26  6381  err_snapshot_create:
b9a17abfde842b Jacob Keller   2020-03-26  6382  	region->ops->destructor(data);
b9a17abfde842b Jacob Keller   2020-03-26  6383  err_snapshot_capture:
b9a17abfde842b Jacob Keller   2020-03-26  6384  	__devlink_snapshot_id_decrement(devlink, snapshot_id);
2dec18ad826f52 Jiri Pirko     2022-07-28  6385  	mutex_unlock(&region->snapshot_lock);
b9a17abfde842b Jacob Keller   2020-03-26  6386  	return err;
043b3e22768d5d Jakub Kicinski 2020-05-01  6387  
043b3e22768d5d Jakub Kicinski 2020-05-01  6388  err_notify:
043b3e22768d5d Jakub Kicinski 2020-05-01  6389  	devlink_region_snapshot_del(region, snapshot);
2dec18ad826f52 Jiri Pirko     2022-07-28  6390  unlock:
2dec18ad826f52 Jiri Pirko     2022-07-28  6391  	mutex_unlock(&region->snapshot_lock);
043b3e22768d5d Jakub Kicinski 2020-05-01 @6392  	return err;
b9a17abfde842b Jacob Keller   2020-03-26  6393  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

