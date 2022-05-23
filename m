Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3633B53144E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236161AbiEWNZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 09:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236045AbiEWNZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 09:25:09 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F6617A9A
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 06:25:08 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24NCDbIi005827;
        Mon, 23 May 2022 13:25:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=4p/BDHQ4PhTYgPjjsqQy+RDEbs2gc35mXDXoKdTI4N4=;
 b=1IBJgN1dv/cOzX6KVoMLG6KT0meBrBnTnFBVlZSZbAhpmnM6BzfNESzM2Fhxqd8bsQe3
 LyYunJl7yrhR/fNawgjPbkQgPxtRWkN7LPpnSVr8WnaXsyPK62rCYC8bxvDi4sis65Qz
 xD9ImrbOsVjV/XCjADoQvOD1UlZb66022+mw5NewRa2L1E4mE7w7uNKf+kUJEbDoOE7K
 t+2BMVJLFyzHTnuPkjjaSB58z2Tex8ngLq5e15a7Zq6AHCCzbKtbR3imDZvu1vyaPPPg
 rf/a7MRCGfomOFDxCPfcc6isWrhafD4Br7Z+7yTSYpU+h7ac+/TnDfii+JMKr6h0kJSY dg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g6pgbkbvm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 May 2022 13:25:02 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24NDA3kM019300;
        Mon, 23 May 2022 13:25:01 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g6ph1mfnh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 May 2022 13:25:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dzP1RpoS88EVCGKXJTsOvOAIDUnv+HmAgzeT5mbrnJ8eK+to9CsHd7nNjtwB1MJVLg8YiY49M5vQkWWQ82XHBIrNudGgnii0aa4DMyfQtNd1pltDBH62Kh0ZkjlwOUb1IA96HY4UxnPFSzrEYTuIqjYvkAKEPDYEd/qsqA4yL8MQ+WADfbSfZ7d2/U5m436SPcf30drkNzjJpGsGVIELXuvOZlFdbqqsOSwsN5nLoAQtSJ2gIHEkYEJk3jmp4h3bFIvgq0U4lhqj6L82w9696H3xksqnEhXUutX7MlSeJBAxL5FEkf7rO8TYojDgQflnUqVzfnZRkQ0vm7hnQn4czQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4p/BDHQ4PhTYgPjjsqQy+RDEbs2gc35mXDXoKdTI4N4=;
 b=am4h+eSRfQleZTaN88oIOLuvDgw6j9D9sZ3+kfJUI8Ue/o71F+Hd6dtURJCg4SbbCjaBTy3vqPSn+Llf0ZPe4Vq+Dk3VR5C65fwU7Ww0A6WRPDdjDgK8CrlNtebFbzfqbSMIe7i62YzVRODlrz6/PihhcKRiE1sg8YkR+VeOrIHm3IVGvKIr/DQxxERrc9KM+gD358rmhFlFcOc+bJE9P4EpzXM6sSkHy1Enxj5M+RLDmcDZz2g/QO2gA9lN8RuPtwNnmgU7Je21pdnAxWlUckOo/kQHgStxUHqgAbvMOm4ZwCMjhQaOG4YYABKWdti+KMb7maagt0BZ2ZhqJYX9Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4p/BDHQ4PhTYgPjjsqQy+RDEbs2gc35mXDXoKdTI4N4=;
 b=Vmqq4EUMMrfvnAo6XyBSE5vj12Qb14BnkbtC7UZbTaUK3LwssTPl394oxWBLO2LcB51e0Ky2X3vgCB718FYY2BSYdO9S4YshS8tC91Q7yq58juGVzrJeBP9rq4uD54sPZcgS6ozj4YfUdEku1lz451FKcUjo6TD9epjlDZfgVb4=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SA1PR10MB5526.namprd10.prod.outlook.com
 (2603:10b6:806:1e5::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Mon, 23 May
 2022 13:24:59 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e%2]) with mapi id 15.20.5273.023; Mon, 23 May 2022
 13:24:59 +0000
Date:   Mon, 23 May 2022 16:24:47 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Subbaraya Sundeep <sbhatta@marvell.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>
Subject: drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c:363
 otx2_tc_parse_actions() error: uninitialized symbol 'rate'.
Message-ID: <202205221311.6ubyABuA-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0174.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501::13)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc368697-a1ae-4b0a-7030-08da3cbfa261
X-MS-TrafficTypeDiagnostic: SA1PR10MB5526:EE_
X-Microsoft-Antispam-PRVS: <SA1PR10MB552662BD55B95E3F49A8F07C8ED49@SA1PR10MB5526.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ap+9AHynXZNq63TPS8k1dmVJfqVpJ0XXdNZ8p8KE2Zfdx6N4JddWSYyWCLkOiKZtjoGmyVk9F+KJOCVip8m1WKI8tc0kRk3oeBUQsB/hgv3ZrXXDpAz1FhO61Xdn8O6HuW4SzaBAO4y2u8PPF/SZiU5Ol/M9NVVmjbQWPSyuon2zTqoMz5SnFkBZHlcoYKRqiSqBD8aOGxWIY0ScGwLArRLnyuleR+ovUyOi/2X8qUCEd+ZfUDpxW8sii/HqyokRoKEQ33ygr869hFdVmDnaluOsDdwmAM9r2SVhSbpD1Lm3MI8Hiq9aikFUzK3GoHxG/YNrchF06n44xqq/icFwnljgPgZGbYcH/q0H7yQjMlNuFJvd+bTJtCBPGPg/ArJJjlJyJxucwXSvBkI7qCAIFMXdQn55ST1Js2Ndm+46J58pVPM4Q7HHXiPngkZbxGjhtJG+PhqdQdR2yfRyTRtdkQk5NlBRZHX8Kn6jBKHMKVl3Nj5fUEm6+ILBxXM1lL9HBav64lbWUSPIDkpWzpbtzmVT4dKRIn0Cmpmuo0hH2fds8O5hImz1XiNhrD2MwuFoU8HxwIPnWiBwKUIFdQYrXpsOUSjpoPd20ab/BCDBBTF6xt6WSvEZUcmpm6cPAgZ+Ul/Pm1CjJb7GpcdKQbE1ABggQV4laNEJM1Czdrwa/5cVRUJkiGKLh4jJB0sn2wcQeBJuaz6Yl6fPQtgsHRZlmgMQBYHNdd5G33zttorq53c4pvr6jfIMLORRRuacNvFghxURRR6K2bk9VCykUS2xlBhsTmWE5N4O7vy5LrIpXJjWxAkYKGl6+G2+X7UOmg0ZVjH5TmdD0jJSjTqYZf+HDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(6506007)(52116002)(9686003)(6512007)(83380400001)(38350700002)(38100700002)(44832011)(2906002)(36756003)(5660300002)(1076003)(8936002)(6916009)(8676002)(66556008)(4326008)(66946007)(6666004)(86362001)(66476007)(186003)(316002)(966005)(508600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qcQWBh0NZtzUP7O4Hz0v669C9mvcb7Ywf6sqrN8zgJCplUxvmD9Usu1YMoCw?=
 =?us-ascii?Q?hHLV5ZpOGLtmOeFbnVjzKmarfXLvKRd5vuY0fpwKUdwAE1/VgwQLQkNtIJ6m?=
 =?us-ascii?Q?Kokr3ui8+tvp2LI6ZXoTCK1AOfUvZeo9P1dc0cXAAgTHBQnGY0HLFNxrCsvN?=
 =?us-ascii?Q?PcLGWmuuDxEfGTpZipnQylcETxBAEYKlnyDFaPAO8GPK9hOfOQobfZ9KnD1Q?=
 =?us-ascii?Q?8ihRZ7emX5IWPSQVLislgNW1cpG5nmq48nK75OjZiofSrPzGFxyQgueE/1ME?=
 =?us-ascii?Q?yDOnI2yL/qF/0HBiPGsShqSqxeeprNnS5qs8htINThh2I9IX6Rna0W8D/UK9?=
 =?us-ascii?Q?7dBnhR3IRLxYJSU4gOrvv5OMv42QYMsdMbjBMo/EvZtgYc1ee1apAO2w1PH7?=
 =?us-ascii?Q?dQLTwQglmjNtOEjWprGcimOy7EEkoL9hWhNZJFd6a37vDBLo8PpJ020cgTHF?=
 =?us-ascii?Q?vLuX5z4JacUOEK0FqTBWvde2HAQrqol0ANLFIkGbs5ELP+FYc7JOV9HLgRf3?=
 =?us-ascii?Q?uR5sIApUUWciwXnA4JDgJZQP4G2br1TCXttVfAzi6YFxTi6TgVvfVqEuU9VV?=
 =?us-ascii?Q?Yfxm+JjdGFLZx6YCvtYm5ZPRJztg6o7Va6difjVKVnuap9F0pv6iWshu4muE?=
 =?us-ascii?Q?CrNmz68iDm38ZrehnELa7CIDgMgWnicBOioGz7mLQ7Nn///2PJC529kDSTFp?=
 =?us-ascii?Q?gIojihlyq9QWZqNjzNcWlbYkedK/WyKXvTu4Ip0uifTI47O6YnwhDOElWonU?=
 =?us-ascii?Q?3zvxjZqurP3UQ0h2S9n3WGV+W/LIzpdUsx3q6S8vV9Ph6m6+o52CKCFZK9EA?=
 =?us-ascii?Q?JVu3ftl5aCKqB4sNS9s6S+n6/bxvnWxiDLoj1MeoD6JH9HnOD2yVqhl4p5+t?=
 =?us-ascii?Q?yt0ktjuZRn79OnyVpxanytJcJCfTt7PBry/8dIgiPZQElOhtCda00qSW34PQ?=
 =?us-ascii?Q?z11FgQtSLC9RPQH7hSyg8bwgnp4vvGCndrokl56SR05YPqBKs1BqD3piLAu/?=
 =?us-ascii?Q?ipuAL5PXbF1GBcIa9txZHg9zQNwhGmSkH0vMtPg1E0TAab6iiVuhj/W0f82m?=
 =?us-ascii?Q?wA/PFsLcjSTOfb/zJr7kPRHEq++4GwJzxgi8j0OVL3osqSlzWSFzsIDV4Rit?=
 =?us-ascii?Q?PbjUk2k9sqYnHXTX++YdHuPo6EdFIi2uajsfAimgZuO/elISAj7EpaXSDLgv?=
 =?us-ascii?Q?lOcK99BA5Xxo8kpnnOvTZD6YsG6rXDUDb3FNE5bSCZfjTJLGGE89tpUaqjvR?=
 =?us-ascii?Q?UxMwWso4xt6rqe/+Cg95fYr6waeIetElpdVDnxbqr/Fe3KNP1Qb1KU0s7jot?=
 =?us-ascii?Q?SCIF39pmd+Am1S13aLTGC1zADiX0AwqrrtfRr0Pd7ZiWk2xX0Wquo5h/KPgP?=
 =?us-ascii?Q?jFlCGoiPfc2QyFkfUTzbHOggy23H7plG4iyrdam9NHJ5CHMtjDreEwG+F/Zv?=
 =?us-ascii?Q?77GMD1PT2+ud4CXLERG60BX6CuPgOBFyq13P5YMXI5EBoggZ60L47cWSbPE/?=
 =?us-ascii?Q?uBgjKYcEa0h50zFKTne4vgmGccXIqOSeeIPfXVBLELUUVRDA+1Nw8ovNayES?=
 =?us-ascii?Q?7MscP1HnkDZh2yRnpS9PXCZSbe6o58SYWeY8cKEJFsMsbw/K6pxjBDutYwqz?=
 =?us-ascii?Q?6TkUqGUoYyMzwxlDvsCv8f2yv1aDeJDKsTcbSS/uwssT1pSnlIjyc/cyXbsD?=
 =?us-ascii?Q?TG1ItQZ8TCqnRwVztaK9UU5hc847UjnqzVeFpM3P9ihE2W3HrqrFWy4mzrFQ?=
 =?us-ascii?Q?sBN+07zxsxjUkSQm7u/tfXXEuKpHY7Q=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc368697-a1ae-4b0a-7030-08da3cbfa261
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2022 13:24:59.0029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w5EDtsquQHL3LbBPyRBZ/zKu1sLlAJ4RRdF9px64jiMtXtLZOc680mOoUVqd+/HWUugrJRaTk1yh1nPYQWK6ruFCY/otRpPtmaIsP7GnZUM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5526
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-23_06:2022-05-23,2022-05-23 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205230074
X-Proofpoint-ORIG-GUID: G_VtfamDo4xtV0swzUd6wcWYXdRAKopc
X-Proofpoint-GUID: G_VtfamDo4xtV0swzUd6wcWYXdRAKopc
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
head:   eaea45fc0e7b6ae439526b4a41d91230c8517336
commit: 68fbff68dbea35f9e6f7649dd22fce492a5aedac octeontx2-pf: Add police action for TC flower
config: s390-randconfig-m031-20220522 (https://download.01.org/0day-ci/archive/20220522/202205221311.6ubyABuA-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c:363 otx2_tc_parse_actions() error: uninitialized symbol 'rate'.
drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c:363 otx2_tc_parse_actions() error: uninitialized symbol 'burst'.

vim +/rate +363 drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c

1d4d9e42c2406b Naveen Mamindlapalli 2021-03-18  279  static int otx2_tc_parse_actions(struct otx2_nic *nic,
1d4d9e42c2406b Naveen Mamindlapalli 2021-03-18  280  				 struct flow_action *flow_action,
5d2fdd86d51735 Subbaraya Sundeep    2021-06-15  281  				 struct npc_install_flow_req *req,
68fbff68dbea35 Subbaraya Sundeep    2021-06-15  282  				 struct flow_cls_offload *f,
68fbff68dbea35 Subbaraya Sundeep    2021-06-15  283  				 struct otx2_tc_flow *node)
1d4d9e42c2406b Naveen Mamindlapalli 2021-03-18  284  {
5d2fdd86d51735 Subbaraya Sundeep    2021-06-15  285  	struct netlink_ext_ack *extack = f->common.extack;
1d4d9e42c2406b Naveen Mamindlapalli 2021-03-18  286  	struct flow_action_entry *act;
1d4d9e42c2406b Naveen Mamindlapalli 2021-03-18  287  	struct net_device *target;
1d4d9e42c2406b Naveen Mamindlapalli 2021-03-18  288  	struct otx2_nic *priv;
68fbff68dbea35 Subbaraya Sundeep    2021-06-15  289  	u32 burst, mark = 0;
68fbff68dbea35 Subbaraya Sundeep    2021-06-15  290  	u8 nr_police = 0;
68fbff68dbea35 Subbaraya Sundeep    2021-06-15  291  	bool pps;
68fbff68dbea35 Subbaraya Sundeep    2021-06-15  292  	u64 rate;
1d4d9e42c2406b Naveen Mamindlapalli 2021-03-18  293  	int i;
1d4d9e42c2406b Naveen Mamindlapalli 2021-03-18  294  
1d4d9e42c2406b Naveen Mamindlapalli 2021-03-18  295  	if (!flow_action_has_entries(flow_action)) {
5d2fdd86d51735 Subbaraya Sundeep    2021-06-15  296  		NL_SET_ERR_MSG_MOD(extack, "no tc actions specified");
1d4d9e42c2406b Naveen Mamindlapalli 2021-03-18  297  		return -EINVAL;
1d4d9e42c2406b Naveen Mamindlapalli 2021-03-18  298  	}
1d4d9e42c2406b Naveen Mamindlapalli 2021-03-18  299  
1d4d9e42c2406b Naveen Mamindlapalli 2021-03-18  300  	flow_action_for_each(i, act, flow_action) {
1d4d9e42c2406b Naveen Mamindlapalli 2021-03-18  301  		switch (act->id) {
1d4d9e42c2406b Naveen Mamindlapalli 2021-03-18  302  		case FLOW_ACTION_DROP:
1d4d9e42c2406b Naveen Mamindlapalli 2021-03-18  303  			req->op = NIX_RX_ACTIONOP_DROP;
1d4d9e42c2406b Naveen Mamindlapalli 2021-03-18  304  			return 0;
1d4d9e42c2406b Naveen Mamindlapalli 2021-03-18  305  		case FLOW_ACTION_ACCEPT:
1d4d9e42c2406b Naveen Mamindlapalli 2021-03-18  306  			req->op = NIX_RX_ACTION_DEFAULT;
1d4d9e42c2406b Naveen Mamindlapalli 2021-03-18  307  			return 0;
1d4d9e42c2406b Naveen Mamindlapalli 2021-03-18  308  		case FLOW_ACTION_REDIRECT_INGRESS:
1d4d9e42c2406b Naveen Mamindlapalli 2021-03-18  309  			target = act->dev;
1d4d9e42c2406b Naveen Mamindlapalli 2021-03-18  310  			priv = netdev_priv(target);
1d4d9e42c2406b Naveen Mamindlapalli 2021-03-18  311  			/* npc_install_flow_req doesn't support passing a target pcifunc */
1d4d9e42c2406b Naveen Mamindlapalli 2021-03-18  312  			if (rvu_get_pf(nic->pcifunc) != rvu_get_pf(priv->pcifunc)) {
5d2fdd86d51735 Subbaraya Sundeep    2021-06-15  313  				NL_SET_ERR_MSG_MOD(extack,
5d2fdd86d51735 Subbaraya Sundeep    2021-06-15  314  						   "can't redirect to other pf/vf");
1d4d9e42c2406b Naveen Mamindlapalli 2021-03-18  315  				return -EOPNOTSUPP;
1d4d9e42c2406b Naveen Mamindlapalli 2021-03-18  316  			}
1d4d9e42c2406b Naveen Mamindlapalli 2021-03-18  317  			req->vf = priv->pcifunc & RVU_PFVF_FUNC_MASK;
1d4d9e42c2406b Naveen Mamindlapalli 2021-03-18  318  			req->op = NIX_RX_ACTION_DEFAULT;
1d4d9e42c2406b Naveen Mamindlapalli 2021-03-18  319  			return 0;
1d4d9e42c2406b Naveen Mamindlapalli 2021-03-18  320  		case FLOW_ACTION_VLAN_POP:
1d4d9e42c2406b Naveen Mamindlapalli 2021-03-18  321  			req->vtag0_valid = true;
1d4d9e42c2406b Naveen Mamindlapalli 2021-03-18  322  			/* use RX_VTAG_TYPE7 which is initialized to strip vlan tag */
1d4d9e42c2406b Naveen Mamindlapalli 2021-03-18  323  			req->vtag0_type = NIX_AF_LFX_RX_VTAG_TYPE7;
1d4d9e42c2406b Naveen Mamindlapalli 2021-03-18  324  			break;
68fbff68dbea35 Subbaraya Sundeep    2021-06-15  325  		case FLOW_ACTION_POLICE:
68fbff68dbea35 Subbaraya Sundeep    2021-06-15  326  			/* Ingress ratelimiting is not supported on OcteonTx2 */
68fbff68dbea35 Subbaraya Sundeep    2021-06-15  327  			if (is_dev_otx2(nic->pdev)) {
68fbff68dbea35 Subbaraya Sundeep    2021-06-15  328  				NL_SET_ERR_MSG_MOD(extack,
68fbff68dbea35 Subbaraya Sundeep    2021-06-15  329  					"Ingress policing not supported on this platform");
68fbff68dbea35 Subbaraya Sundeep    2021-06-15  330  				return -EOPNOTSUPP;
68fbff68dbea35 Subbaraya Sundeep    2021-06-15  331  			}
68fbff68dbea35 Subbaraya Sundeep    2021-06-15  332  
68fbff68dbea35 Subbaraya Sundeep    2021-06-15  333  			if (act->police.rate_bytes_ps > 0) {
68fbff68dbea35 Subbaraya Sundeep    2021-06-15  334  				rate = act->police.rate_bytes_ps * 8;
68fbff68dbea35 Subbaraya Sundeep    2021-06-15  335  				burst = act->police.burst;
68fbff68dbea35 Subbaraya Sundeep    2021-06-15  336  			} else if (act->police.rate_pkt_ps > 0) {
68fbff68dbea35 Subbaraya Sundeep    2021-06-15  337  				/* The algorithm used to calculate rate
68fbff68dbea35 Subbaraya Sundeep    2021-06-15  338  				 * mantissa, exponent values for a given token
68fbff68dbea35 Subbaraya Sundeep    2021-06-15  339  				 * rate (token can be byte or packet) requires
68fbff68dbea35 Subbaraya Sundeep    2021-06-15  340  				 * token rate to be mutiplied by 8.
68fbff68dbea35 Subbaraya Sundeep    2021-06-15  341  				 */
68fbff68dbea35 Subbaraya Sundeep    2021-06-15  342  				rate = act->police.rate_pkt_ps * 8;
68fbff68dbea35 Subbaraya Sundeep    2021-06-15  343  				burst = act->police.burst_pkt;
68fbff68dbea35 Subbaraya Sundeep    2021-06-15  344  				pps = true;
68fbff68dbea35 Subbaraya Sundeep    2021-06-15  345  			}

Smatch is concerned that there is no else path

68fbff68dbea35 Subbaraya Sundeep    2021-06-15  346  			nr_police++;
68fbff68dbea35 Subbaraya Sundeep    2021-06-15  347  			break;
68fbff68dbea35 Subbaraya Sundeep    2021-06-15  348  		case FLOW_ACTION_MARK:
68fbff68dbea35 Subbaraya Sundeep    2021-06-15  349  			mark = act->mark;
68fbff68dbea35 Subbaraya Sundeep    2021-06-15  350  			break;
1d4d9e42c2406b Naveen Mamindlapalli 2021-03-18  351  		default:
1d4d9e42c2406b Naveen Mamindlapalli 2021-03-18  352  			return -EOPNOTSUPP;
1d4d9e42c2406b Naveen Mamindlapalli 2021-03-18  353  		}
1d4d9e42c2406b Naveen Mamindlapalli 2021-03-18  354  	}
1d4d9e42c2406b Naveen Mamindlapalli 2021-03-18  355  
68fbff68dbea35 Subbaraya Sundeep    2021-06-15  356  	if (nr_police > 1) {
68fbff68dbea35 Subbaraya Sundeep    2021-06-15  357  		NL_SET_ERR_MSG_MOD(extack,
68fbff68dbea35 Subbaraya Sundeep    2021-06-15  358  				   "rate limit police offload requires a single action");
68fbff68dbea35 Subbaraya Sundeep    2021-06-15  359  		return -EOPNOTSUPP;
68fbff68dbea35 Subbaraya Sundeep    2021-06-15  360  	}
68fbff68dbea35 Subbaraya Sundeep    2021-06-15  361  
68fbff68dbea35 Subbaraya Sundeep    2021-06-15  362  	if (nr_police)
68fbff68dbea35 Subbaraya Sundeep    2021-06-15 @363  		return otx2_tc_act_set_police(nic, node, f, rate, burst,
68fbff68dbea35 Subbaraya Sundeep    2021-06-15  364  					      mark, req, pps);
68fbff68dbea35 Subbaraya Sundeep    2021-06-15  365  
1d4d9e42c2406b Naveen Mamindlapalli 2021-03-18  366  	return 0;
1d4d9e42c2406b Naveen Mamindlapalli 2021-03-18  367  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

