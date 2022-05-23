Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2AC7531203
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236145AbiEWNVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 09:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236171AbiEWNVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 09:21:34 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2781401E
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 06:21:24 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24NCDV4p016400;
        Mon, 23 May 2022 13:21:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=SJn4l9Kmfi1bkkQrII0YMs//kEbdABsR6UjNlSzS5WQ=;
 b=fe/ieItFSofuEKQFgLMBxGDCPv/hBms9aT1gxEhzDl9ZaoOauozqTnai0ah2jE+CVUi6
 xmIFWK08yTIMceIu44oNZcJvOpIfBkZTCcm0Xt09+yXjdt8He0HNUFlHN0LUOviYyHnU
 WnVfcsVYlN/vjSYmXOWrfRwQOFX7wyZFVQR6aoUDylwmmeEQF9kt9yio4fIU0TFpscUS
 cyVY66I9PaBQwom97MKN3EBNWvAhhp3uo3GZMde7iqyZyrhdsfeAtWsxZ9Xv3AoEAfff
 MExbSBKebpwxGNrp8pzzVs4Sfj9y27ORYBbwFO0/uv7d0gQSDHl0EvWAFuz8GFmmv0Hl 2Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g6qya389h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 May 2022 13:21:20 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24NDBnI8025372;
        Mon, 23 May 2022 13:21:19 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g6ph7stw1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 May 2022 13:21:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aw1jw312jvh2c9xbf2Qeig3FtpKz5lR8lKQ4cNvu7tgDKCwO7nFrx6T4iupaCKqUCKVw2rJHLlxa1ugd7H/zm0f7wX8WbBItBUw/C3bNc+HxFr8SaH6UNKmab21E+zqg7vqQpdrOablOZzieyK9WdjsckBDSbUPmt1RGvk7TV3/Z0CJ6pjGgc6RFrjj1QNHqDZ+8y1N2iCw29HirwLfZOdX1dCWFZszlJqTSqTPTYE9twE6fhgCp/osi1yzxfD+RY6l1zdHpQC+sFSEzeM6kkn2VxKLYDr5Hhxfmzjd27UYhvQuPh7CrRCCOBz/fwSdALlcPhnzOgf+JOHVoVyUZrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SJn4l9Kmfi1bkkQrII0YMs//kEbdABsR6UjNlSzS5WQ=;
 b=VjFzYlr+T/RIRnNGyJcYe+wxVy8fbYkQMj35lS1nTeA/schPWV5aWKRrtWUC1dpF4XJgroDEYUh0t3ALHkUrCifDBOCn7Cyj78B13SZH3vex3Ez//VAnPsjtEXz7LkIPdrDxcqo/kjqjFh+nCXOQEqic0dvF8cQyvIuL6ypmYXJcK2aZpophvMhJsegA13iL1M5GhUFvWQwPWUnh1qy3235RcLqcNeJSrXnS6pfZewcbbZyFJ1/VfU9fyGKp006WZ+ZN4oL02KXnLwVVg6FPpa6/x4wMavhI76sFlNIOFQnLSte1nA37u42sPvcaubeITTspt04bQdlMgd/uKuFbnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SJn4l9Kmfi1bkkQrII0YMs//kEbdABsR6UjNlSzS5WQ=;
 b=d71fzwMyTuBcUrrey1DBApDNRwIJvumVGUORx9P7GwoFyW/HtyYPDCgmEZVs846PpNuYHAEsvJucjL5Dv1V2iaD90j0KTJlRzqXOh5uRGU7TvuHE+42W3o+QXLVOPUuXUB89XM/43Qv6GBbAztpCe1jP5DWU8/IuqXHMCyyO430=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BYAPR10MB3639.namprd10.prod.outlook.com
 (2603:10b6:a03:11e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.19; Mon, 23 May
 2022 13:21:17 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e%2]) with mapi id 15.20.5273.023; Mon, 23 May 2022
 13:21:17 +0000
Date:   Mon, 23 May 2022 16:20:53 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Sunil Goutham <sgoutham@marvell.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Subbaraya Sundeep <sbhatta@marvell.com>
Subject: drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c:4360
 rvu_mbox_handler_nix_bandprof_free() error: testing array offset 'idx' after
 use.
Message-ID: <202205221009.XjbSXonE-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0036.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::24)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f2f6b1e-012a-4d00-7398-08da3cbf1e48
X-MS-TrafficTypeDiagnostic: BYAPR10MB3639:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB3639997B7303B4488F01DFE68ED49@BYAPR10MB3639.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5RBmFXNx+z9ZulTHNYOXucwGRXJ2yCOgUbbg3svUX0pi/pZjqjLt+4kmbBGpl/lYZ8dLxjqM3kTvGwuQwrJfCbXqESGXM6BiUadCd9eRWhChr76prg8jjGcu8Xj5fVjaqvIxSShMB4A2JDhnnUoJtVKhw/ruVO9+BdzGD1jCgaDwgLqUFcBcpzPi9yEBfrgTsQmI25gDs3y0CwQ/ge9LJmv4XterBEA6FuZ1Deeq/lKxY37G5fclQ2CaI2FQAPZKhWCN6zdhPr4qQg2qgnzRynzAaZbwCXscz5tUh2hnLLjeZShvX1EAKe+t2eLtY8GcsvnrqVsmSjm22nzz+U8Gzwc96ddrIuJQ5kPHnJkbcLemex8Y8lL/mi9Q9ZQ/5F2JyIxjgiAIYFuB2b+tMGHmTJKv3IE2R19AMeXfBUBNPMGclHIqnc60ZuasRkgJTkW66XAAyjnIdQG2eVZalmPUoE+shQ+ffdcuD+yC7rx0zFvc53kPtaeHoovwbckjsUnfopMbfqO7wqPp06LOnE/gRdPBcDl4sheDUwhPnpEJeG4fciNZjjaeVmV25qkCLoWvqVa0YkYFoSvLRRiHfngU18s3xDTnL6h+g+/fz8VmMlXBeYj9otiw7tYS2vmAscLS/8xWX6019+6uvWDwOPeEiYP3HMnyJLv6QiDroUYfDzpmr9z6JqBfXAvvm6yPvTtxHiLvPyPjN5sxHcIAg/yz2ATZmCtNVSpWQfAo1DNO01PFKor7Bmj8gW7tSUOVH4xsL7KJX+WJbUs9M7RHHr9NGhHPwfux+WT8ckZ99MBE7hooA4VSAeVkfShh5FewkPRV+1o3Jp6Q4Vcy37Qjoo3KsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(6486002)(966005)(6666004)(26005)(8676002)(52116002)(316002)(4326008)(66556008)(66946007)(86362001)(36756003)(6506007)(9686003)(6512007)(2906002)(66476007)(44832011)(83380400001)(38100700002)(186003)(38350700002)(5660300002)(1076003)(6916009)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fuViH4XvF6gFez3CcUzjWRZZIHtIw8nXdgG1GC4MfEwwTlFO2yoWDr9HQwUh?=
 =?us-ascii?Q?3//AYRy8AI2ttGtODuJ+1942EtFOJ5qX0b2PZFohMfiCTIDtTbBi4HlMCT8X?=
 =?us-ascii?Q?BugVDkXeQHDF5b/tawNWhy8d4y08mOeYGcDZowONoGbilx0uiCKL+ONgnn4P?=
 =?us-ascii?Q?re6ntJrPHFtJxEmWwIhlamI+dMSPhniaqA+Rdhi/C1hqJtTXWvZrcNP460uE?=
 =?us-ascii?Q?zG54digy+4+VeuwJ5ZANY3sHtKcdwxV4RyJrj/4viylfUJpNk54EqJAMYPit?=
 =?us-ascii?Q?oXyX+3RoujfUUe1tIOeql7JWmlD2YV/M+11gvl6x9Je0/LCzGhbgi4u9W+Ho?=
 =?us-ascii?Q?9JRuckIWyaK07t7yjbtZRtgefYuNLZBILZyPa7qdRtHBvOhXYzfZiqUtZEpc?=
 =?us-ascii?Q?u1F0N+PfLHq8Wv288hiPhkWXN6Bk4F5qh0BFbXUACANMzesNbYeScNj36jyG?=
 =?us-ascii?Q?tXL2Z9GF73j8gKV0sdJZqFDyybmSHEBJMA36/nneqOJus5xMrPjkS/RZhlW9?=
 =?us-ascii?Q?K8Fkmv3ZEU6L7UoYjnoezj7vEcl0ISoOL/T4DPTjS/C2xmPsic5zYCf5Grg7?=
 =?us-ascii?Q?S0yzcB2PpBn+A758eITfsWrUeWuDpnVWFT6ak3g5oPNRaGJph/uTQxU67uDF?=
 =?us-ascii?Q?Oe2g1jp2U64JDi5EzSbp9xmqFq6WCpSLIoPMf6YPDpMskEBeZVQuRLNcTYcw?=
 =?us-ascii?Q?9ukM8hDNw3QIfBQU6MqvPaHrghrZ0HyT4T/HVkOxk3g5MacuTvQwfgkzzEGr?=
 =?us-ascii?Q?5dOxVOZsJxCgp+3rcTCcR5dvTcV6sr6C5RvrktiHHdJkpcEvjF//VvO+PDIr?=
 =?us-ascii?Q?zllkvV54mkdbWlrvlDhzwE5YKEfG2zB3LQ3O53FI/sNxdshD2ARZ4furRSOM?=
 =?us-ascii?Q?Sb4gY8xQI3efJoYF4fk5otxxTZTzU1m+/+z3GfPvzt3tUuMJrzBf6MVD1U0B?=
 =?us-ascii?Q?+M5C1mYEdByJoG2zWdrAfX8p9Aa3cjcNVE/tfQBlzc92D1mk6xIzSmKyQVC7?=
 =?us-ascii?Q?X3FLH/PeryPeeGVAvPudBPB1889+2oXrDSJjPDpTG8npiiGSD8Iw3YD6v1yv?=
 =?us-ascii?Q?GmBxAeS7YrL2qLf7OII3cY4xsW1/bxlQiB5HZzJrOOMwCnqSSJHxjft34gSn?=
 =?us-ascii?Q?8P4PjCl0NuiY+te38MNig+QBYyeLqTaummGO+SJQ4900bAXe5lK0kTFhzF3P?=
 =?us-ascii?Q?ZEfESfQOE1TOYqEsAbWF4gG7YaFZCcafW4ddiLCXB6H0/p3+Db3qV71zOd/k?=
 =?us-ascii?Q?lboP+PnYb9H+amQ/MuX2bLiXTXHu5mNJNYdR98p3cwRmM/cmnbI5q8cgBbPB?=
 =?us-ascii?Q?KXQHa6iTkUUlH5uOrImEPNBRPd6WeimSTIzQwM7mORZPwBPd9zJC7IZJscd8?=
 =?us-ascii?Q?CDjHzy3d37GAgSoucQVrAhB0qHViwa5wsoF5gPt5YijwiaD5TLg1MTaA5XCc?=
 =?us-ascii?Q?094HCYeB1ageas1pRpdkIzi+pGqWShBMCbJomnhs0dpGp7/gstFZhwbySkED?=
 =?us-ascii?Q?9xBoXLhX2MzENYA31gzeI9v7XGwAdRYVSwR1BqnNMO/XTxhv90OKDEfjcc0X?=
 =?us-ascii?Q?BaVR2EOIIm4c/w6d92NyJ/4LmypVF8OnjE9S/6uiuJN0FOB2vZpw1eaBv0Gs?=
 =?us-ascii?Q?dg30CWUJf4z/Y18wuBiZk0SZLhC2cV5obpQZ4XxkH9/2H2QIjtFDungTK+eH?=
 =?us-ascii?Q?itz0RDJ6l6EfKyZkeNqX0dIQPIO/imtI95Gv88C7Wbg1Hbr1Y3eyQPKM2d7Y?=
 =?us-ascii?Q?kNHSN51t5/U0LjTb51A8OhSKqMXaQ/M=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f2f6b1e-012a-4d00-7398-08da3cbf1e48
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2022 13:21:17.2237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bv6ElnXrmuO9iVCz1dJhqzU+XfOccJRFv9Kaadv2ApySK+VCj/eVciusgLhWZLNkAZoZSH63ckFrSFDQGZvtm7t7Dp5DgrsoopLSzlNFwrU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3639
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-23_06:2022-05-23,2022-05-23 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=997
 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205230074
X-Proofpoint-GUID: zuYEbMsaT4bEuIEtzMKml-AbIO0pGDdt
X-Proofpoint-ORIG-GUID: zuYEbMsaT4bEuIEtzMKml-AbIO0pGDdt
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   eaea45fc0e7b6ae439526b4a41d91230c8517336
commit: e8e095b3b37004a4048af69de60c9af2d2268a1d octeontx2-af: cn10k: Bandwidth profiles config support
config: s390-randconfig-m031-20220522 (https://download.01.org/0day-ci/archive/20220522/202205221009.XjbSXonE-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c:4360 rvu_mbox_handler_nix_bandprof_free() error: testing array offset 'idx' after use.

vim +/idx +4360 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c

e8e095b3b37004 Sunil Goutham 2021-06-15  4318  int rvu_mbox_handler_nix_bandprof_free(struct rvu *rvu,
e8e095b3b37004 Sunil Goutham 2021-06-15  4319  				       struct nix_bandprof_free_req *req,
e8e095b3b37004 Sunil Goutham 2021-06-15  4320  				       struct msg_rsp *rsp)
e8e095b3b37004 Sunil Goutham 2021-06-15  4321  {
e8e095b3b37004 Sunil Goutham 2021-06-15  4322  	int blkaddr, layer, prof_idx, idx, err;
e8e095b3b37004 Sunil Goutham 2021-06-15  4323  	u16 pcifunc = req->hdr.pcifunc;
e8e095b3b37004 Sunil Goutham 2021-06-15  4324  	struct nix_ipolicer *ipolicer;
e8e095b3b37004 Sunil Goutham 2021-06-15  4325  	struct nix_hw *nix_hw;
e8e095b3b37004 Sunil Goutham 2021-06-15  4326  
e8e095b3b37004 Sunil Goutham 2021-06-15  4327  	if (req->free_all)
e8e095b3b37004 Sunil Goutham 2021-06-15  4328  		return nix_free_all_bandprof(rvu, pcifunc);
e8e095b3b37004 Sunil Goutham 2021-06-15  4329  
e8e095b3b37004 Sunil Goutham 2021-06-15  4330  	if (!rvu->hw->cap.ipolicer)
e8e095b3b37004 Sunil Goutham 2021-06-15  4331  		return NIX_AF_ERR_IPOLICER_NOTSUPP;
e8e095b3b37004 Sunil Goutham 2021-06-15  4332  
e8e095b3b37004 Sunil Goutham 2021-06-15  4333  	err = nix_get_struct_ptrs(rvu, pcifunc, &nix_hw, &blkaddr);
e8e095b3b37004 Sunil Goutham 2021-06-15  4334  	if (err)
e8e095b3b37004 Sunil Goutham 2021-06-15  4335  		return err;
e8e095b3b37004 Sunil Goutham 2021-06-15  4336  
e8e095b3b37004 Sunil Goutham 2021-06-15  4337  	mutex_lock(&rvu->rsrc_lock);
e8e095b3b37004 Sunil Goutham 2021-06-15  4338  	/* Free the requested profile indices */
e8e095b3b37004 Sunil Goutham 2021-06-15  4339  	for (layer = 0; layer < BAND_PROF_NUM_LAYERS; layer++) {
e8e095b3b37004 Sunil Goutham 2021-06-15  4340  		if (layer == BAND_PROF_INVAL_LAYER)
e8e095b3b37004 Sunil Goutham 2021-06-15  4341  			continue;
e8e095b3b37004 Sunil Goutham 2021-06-15  4342  		if (!req->prof_count[layer])
e8e095b3b37004 Sunil Goutham 2021-06-15  4343  			continue;
e8e095b3b37004 Sunil Goutham 2021-06-15  4344  
e8e095b3b37004 Sunil Goutham 2021-06-15  4345  		ipolicer = &nix_hw->ipolicer[layer];
e8e095b3b37004 Sunil Goutham 2021-06-15  4346  		for (idx = 0; idx < req->prof_count[layer]; idx++) {
e8e095b3b37004 Sunil Goutham 2021-06-15  4347  			prof_idx = req->prof_idx[layer][idx];

"idx" is used here

e8e095b3b37004 Sunil Goutham 2021-06-15  4348  			if (prof_idx >= ipolicer->band_prof.max ||
e8e095b3b37004 Sunil Goutham 2021-06-15  4349  			    ipolicer->pfvf_map[prof_idx] != pcifunc)
e8e095b3b37004 Sunil Goutham 2021-06-15  4350  				continue;
e8e095b3b37004 Sunil Goutham 2021-06-15  4351  
e8e095b3b37004 Sunil Goutham 2021-06-15  4352  			/* Clear ratelimit aggregation, if any */
e8e095b3b37004 Sunil Goutham 2021-06-15  4353  			if (layer == BAND_PROF_LEAF_LAYER &&
e8e095b3b37004 Sunil Goutham 2021-06-15  4354  			    ipolicer->match_id[prof_idx])
e8e095b3b37004 Sunil Goutham 2021-06-15  4355  				nix_clear_ratelimit_aggr(rvu, nix_hw, prof_idx);
e8e095b3b37004 Sunil Goutham 2021-06-15  4356  
e8e095b3b37004 Sunil Goutham 2021-06-15  4357  			ipolicer->pfvf_map[prof_idx] = 0x00;
e8e095b3b37004 Sunil Goutham 2021-06-15  4358  			ipolicer->match_id[prof_idx] = 0;
e8e095b3b37004 Sunil Goutham 2021-06-15  4359  			rvu_free_rsrc(&ipolicer->band_prof, prof_idx);
e8e095b3b37004 Sunil Goutham 2021-06-15 @4360  			if (idx == MAX_BANDPROF_PER_PFFUNC)

So if it's == MAX_BANDPROF_PER_PFFUNC then we are already one element
beyond the end of the array.

e8e095b3b37004 Sunil Goutham 2021-06-15  4361  				break;
e8e095b3b37004 Sunil Goutham 2021-06-15  4362  		}
e8e095b3b37004 Sunil Goutham 2021-06-15  4363  	}
e8e095b3b37004 Sunil Goutham 2021-06-15  4364  	mutex_unlock(&rvu->rsrc_lock);
e8e095b3b37004 Sunil Goutham 2021-06-15  4365  	return 0;
e8e095b3b37004 Sunil Goutham 2021-06-15  4366  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

