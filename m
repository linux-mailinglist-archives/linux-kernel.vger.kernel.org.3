Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E023551392
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 11:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240209AbiFTJAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 05:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240193AbiFTJAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 05:00:45 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B1AEE03
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 02:00:44 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25K5oCGX030221;
        Mon, 20 Jun 2022 09:00:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=MQF9ewiHoWzxB2nNdT1k1mMkxDejywqtUwy5KcEwly4=;
 b=DiG61iVU3+WoVQxAcce+4wnsvXYuOT6as+PYWrd00Wwaciz0BPr6lArHYp5JGvSvxSsT
 L3Hoykk0keepFE48G3c/9g4TRI/x6r6St/qRQxduLoQMlyn/vauoJk+ivd+ycTXlob4d
 poMY+NzgGeADXu0EYo9unZCqN8DR2qFJsseRkdG6ZjIO+hEn84FGHXv8+GajigxuxvZi
 cfyqFSA5d5Hh43Mljc65g01PsVnE3mtgAHldPPS2SGz83UcvvmHU9OrtV7vcM82pYikG
 Iagsru1S/GTm5JhDIBc9Ah91AknLzcUpacEQJ6f1jQghykeI8otE5etfYzotDQf8vSbj GA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs6asts0b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jun 2022 09:00:38 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25K8unAQ039028;
        Mon, 20 Jun 2022 09:00:37 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gtg5t7f85-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jun 2022 09:00:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hzx7jOWfeWMx+w4yORObQIgyfnaKRLYUFG2kCIb/DuQSTh9AXdycLjkHyNwhXFWxlVNCoxZ8+cn54q6Y73s58eKGngrF6a5Q0iL532aKGArPbJa0wS+1p4Ck25KGAc5yy0z2OSCxj9t04mF0mXheWtoYqzkIlNrkz9RZTFWfgHLCbWLCLJDnPS1iS5+8JdnhrjCsAsv6EjRU0INXZRGQ5SQWEN4dIhCQx0YPFqJfYcO3GPdHQp03IbcqK9QRFEqZUHEQyL4b5qAnTJqH4QBq3+YxyTlCim8BLM+4OsniwUVgjO8IYDHKvi5AnbC5Ef378nNA8HoS9/3ZrcdGQnvr0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MQF9ewiHoWzxB2nNdT1k1mMkxDejywqtUwy5KcEwly4=;
 b=oXm3b3YCSwZobox70ggk0lmI/thHJgZrKzbkqhc/3LqY/X/m61gxuMRlytgk9fkZwQHDK7Yd1D6vhzEzlSLeeABLFXXExkprybCz9KNKGIu44nks9+bYNI++a5eAUB+Ugl0/fC9Uo663MSXS89HySOaskYrdWx6O91IWKLbR+UwWoQQwC+iz2ZA6i5Wy2YTovcPS6fyydT54te5p3InIZBsRjUnSgKqncUZ3LKXd+mntKoTbtZcIdvU+IAxZYYNBuZJORs5V0J4yRwvJ26gQ6H5Dkf6GRQKyXmA0et9r/Qf2pJq/rjdDXateTSPooWQtxJBy4uHrA4GcHXbFzfVxPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQF9ewiHoWzxB2nNdT1k1mMkxDejywqtUwy5KcEwly4=;
 b=dDLAPqh/w+Dvr/SQHzkNupSZ/5N/yDzUW85X1ETdxe46hq7Cz0WmriCsz5Iusfi54iGCO7HyAZxCMjqpFksxT7S+2RCfb95gEefEf0v9KbW7HrJ8OkGdD4vW3jPoc3dxW5IKuNlCMitY4dnqTbKWz12MjsFyhutwLnFFe2A3/eE=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BYAPR10MB2792.namprd10.prod.outlook.com
 (2603:10b6:a03:87::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.17; Mon, 20 Jun
 2022 09:00:35 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5353.018; Mon, 20 Jun 2022
 09:00:35 +0000
Date:   Mon, 20 Jun 2022 12:00:16 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c:261
 dpu_encoder_phys_wb_atomic_check() warn: variable dereferenced before check
 'conn_state' (see line 255)
Message-ID: <202206190637.iURVxsik-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0043.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::31)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5118453f-aace-44a1-a6de-08da529b5627
X-MS-TrafficTypeDiagnostic: BYAPR10MB2792:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB279265D516519BF6A0492E5C8EB09@BYAPR10MB2792.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IbC00OP1rdBACeahXQk2mvg/x5gBBwMOTyu1SYqZtlmYUSh8/y2NPqP8gUbqmItWac40sPB1JQ4GM+ywqIfzVak1WAdBn9QgAAJZq94cu9hevDZ7Sn2+yL/s5ZHNbpJCTy40iIRqS83cE3AVWGtooDDI6jVvYv+DNhSvD/p0yTyRjesH83xXNXrcyoe2QdU9TsGpwYD1/rHcd9euT8kNkOS+krPmfILnqHO0u8ut2eCcSPHKOMbPFwDAKYVU5IcC7jydEFjodlCTuihNUgtXXgadr+h5shGoSo83aFif688xqYXuFl5wVSgf2gi7gQZN5fWBNn0YaCRDH1qKKTdXo3JvvAApp+HBLRTHkGOszT5j3QJutd1XE4+sHN6rvoaq4oQujUlcYNNwCyD+cr63Hu6h7DnkG6Q+CRCG3QuAvgddkZw37c8XcrnLrnV7mNKwwyip1FGyUiFvcUIqWD02L7XwlrLfQemH1BDcGRwerJLSYTeifkNM+rKjEehfXAsCAkrq7v4KgshpbLxMoDzl8VHD/O5foEElkxltPPWb8sWXAJScrOsFgcSQ7EABj6FinFe3/VnJav0xzA8SVdE8vsVZdRDBboVZNq51wTBGHKJvve2ZApxzVFW6B23xwtwRzGp3cZFkta31y+LsGt3pMV1JLuxvCC130DtubzD9VWHUvtpLLqxr+a7mypXS1UZrsWKV7fNxfnmkpAd6NkdYugyfeUYEplJ8JBJ3w17/7P3x4Al5t5AXAYJE9fkk5MXTlqfxaSv84RAsHtGXL6tYb2bAm9/u/ZrZ9Oh4EnjIXFBQOOXCbqn8GLSKjpmqnad3BbYYmsMP6L5lPCQ+qxX/ww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(83380400001)(36756003)(26005)(186003)(44832011)(6666004)(4326008)(2906002)(86362001)(5660300002)(66476007)(1076003)(66946007)(66556008)(38100700002)(38350700002)(8676002)(9686003)(6916009)(6512007)(6506007)(498600001)(966005)(316002)(52116002)(6486002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MzMyiGnrBnf6zPIThVPYtkshdmvtPfzmEXco5mVoR/6AyzxSTWPpUL5UToHq?=
 =?us-ascii?Q?TU/WESpmVxIecO6LP40BcY+oMBtocwLomvtUqzIw/gtuphaLcK3X+1CRa89g?=
 =?us-ascii?Q?sPOsQe81iUmDr+7nytqQJJ9bGBl2+oXUygBMSeebvtAzOUI4puMYRS+ZSPpW?=
 =?us-ascii?Q?UhFjyhOwIYCRelBFB3Vn0w9B9TtNJ6YylHCswcTqp+5WLrQ+EVIZBxKdT6DL?=
 =?us-ascii?Q?TYdvSheo+QN+hSh4qex+ArK/AYkorPT23dDqLue2EoRQYZdlKCefDFoE+XyD?=
 =?us-ascii?Q?3wGKwfWUXR5G2wgukXN2qbQBtxSc+OuBVGRkb+DjRXpxPcZ2wAspE4NuHZhg?=
 =?us-ascii?Q?YSM+J9Mgedlg9udnF2AH5HdULVBClmShI3kowFiE2CrZeMegmH8nk9f3bMK1?=
 =?us-ascii?Q?At/oYr0S4PwER927SdLBzGkjnCNlhvu/rTGocDcEsR6CUksTDHGsLmBDRvAu?=
 =?us-ascii?Q?568yHO2gl5hDe5C3HlkMEnRTllOXwvWyWx8EgTqoy9GZdeZ0AaYwJXS33m8G?=
 =?us-ascii?Q?kJfI/iN43nxsYvgzIqAuMDUCPrJqs2TjsatdZchB83QYNFuhIlSqZcJMUXd1?=
 =?us-ascii?Q?CkvzK3rgxoTOKx5kKF56e6HMDTsmrnHt28f9peVeuIv42UAyLqi9CfXkFJxl?=
 =?us-ascii?Q?VbtVwbmJ5GRT9ICVeM3XCUyD40Q2joEMndLGKt+NEwB0BSI3suU/OKHbIlQ3?=
 =?us-ascii?Q?vjBBCOu0fRMn6psN//44OrSN6Kopq26MeiJBwYvP5EWHtZmpgbYVd02906u3?=
 =?us-ascii?Q?M/SIo/CahtoiozZE1m3YvsBgPNMYYdJRShPSFFf863mYxGHAXzWrHx5bgoCH?=
 =?us-ascii?Q?umLgLI0Yv7QnkzfmXCSW7o2gJt/OLRy0PFYpEZ+0WiM42lBaqmqd5Rd9+tBo?=
 =?us-ascii?Q?+2Wpl6/dcAYBJflXOzab7t9TVqGrt/PXzpqI+W8kOVdbJ5MEPxiSUvMq7nm+?=
 =?us-ascii?Q?JDP9CTD7snGmVJjUzIfDquDtrBjARwzk9goW1euK1qAN2BEIUirRCt7fqDBW?=
 =?us-ascii?Q?X9AuJPnvG082p6GnE52zPvsC7EeOK3Pz84v1CaSa4L2x5Eq5T80MpxgHhlA3?=
 =?us-ascii?Q?0oNB5HFj/hDyxehJJVAbqZOPs45fAdeX0kWcqyLjRLP+DaCDVYTbT8sHfQ9+?=
 =?us-ascii?Q?AjBIK5ywwNIGF4GHGB7qtEs7JzsbjP5ZGAY7M4S4jXkvVfCES/5eh45el71b?=
 =?us-ascii?Q?gB6QcPlaI5o5Ybb1j86j2gyJYEDXb+go4bW0c0Jz8dMADjxsMyC3JU+3Dral?=
 =?us-ascii?Q?uhMto+13aZcSTlzZ+HM/zg1FB0lqB6DWKkvMinHJxbLZmWT5ofxYXmX6nq57?=
 =?us-ascii?Q?2W63OLb9QE7XS7POJhG8GosiFWISMk0bt3oDVNSAP/5Dq58igjg4ApBYWQHc?=
 =?us-ascii?Q?35YLbMFAqljEkv5NtWwXBNaMljc1PTFTdK3v6Tg9plUKvUC55T8FdH+EKECf?=
 =?us-ascii?Q?29v5RgDFdHRbOo4cKUzpyZtslFdxfVn+Xy8itYmSOOIvG9s6ddWI/iGqMXA4?=
 =?us-ascii?Q?qRifjre1k0yiJKKr84gsFtnKgrv4+V+N9ylyWIpKO+ZNWWP3/aPHtEoaICOG?=
 =?us-ascii?Q?8n3/BJnoOFWb+9zqH7tIcIzPt+NLKUCYtgGTIDaU6ZI4bXG/1D5RdbHrSDdA?=
 =?us-ascii?Q?GuUjtIHU7N8Fgf+PntpbGClH3WJeXHGk2cEb8O6008ecaEv5GWAqifBhOyUl?=
 =?us-ascii?Q?Qel3TE1R93MTgsgqDep5MIBZ45XVcLU9htVBr3yZrgQoaoD4CTR6y5/WCh+/?=
 =?us-ascii?Q?KhGqMtmROUUtGVYbwjuS38fBt+sGpt8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5118453f-aace-44a1-a6de-08da529b5627
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2022 09:00:34.8787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +aTMZUpjSrWlWrq+3YDeyrkLfHrMFOy/RzqLZgcqDiYtbW2SdIok8DPXvJpYltNLFz9cZVPEJs14w9VOdYnSIcDAu2WBXhtSdRDvE8+zwy8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2792
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-20_04:2022-06-17,2022-06-20 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206200042
X-Proofpoint-ORIG-GUID: 4owmBSn6RyLL01Pqqs6HifqPQ5ljh6T1
X-Proofpoint-GUID: 4owmBSn6RyLL01Pqqs6HifqPQ5ljh6T1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4b35035bcf80ddb47c0112c4fbd84a63a2836a18
commit: d7d0e73f7de33a2b9998b607707a3e944ef3b86d drm/msm/dpu: introduce the dpu_encoder_phys_* for writeback
config: ia64-randconfig-m031-20220616 (https://download.01.org/0day-ci/archive/20220619/202206190637.iURVxsik-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c:261 dpu_encoder_phys_wb_atomic_check() warn: variable dereferenced before check 'conn_state' (see line 255)

Old smatch warnings:
drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c:252 dpu_encoder_phys_wb_atomic_check() error: potentially dereferencing uninitialized 'mode'.

vim +/conn_state +261 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c

d7d0e73f7de33a Abhinav Kumar 2022-04-26  244  static int dpu_encoder_phys_wb_atomic_check(
d7d0e73f7de33a Abhinav Kumar 2022-04-26  245  		struct dpu_encoder_phys *phys_enc,
d7d0e73f7de33a Abhinav Kumar 2022-04-26  246  		struct drm_crtc_state *crtc_state,
d7d0e73f7de33a Abhinav Kumar 2022-04-26  247  		struct drm_connector_state *conn_state)
d7d0e73f7de33a Abhinav Kumar 2022-04-26  248  {
d7d0e73f7de33a Abhinav Kumar 2022-04-26  249  	struct drm_framebuffer *fb;
d7d0e73f7de33a Abhinav Kumar 2022-04-26  250  	const struct drm_display_mode *mode;
d7d0e73f7de33a Abhinav Kumar 2022-04-26  251  
d7d0e73f7de33a Abhinav Kumar 2022-04-26  252  	DPU_DEBUG("[atomic_check:%d, \"%s\",%d,%d]\n",
d7d0e73f7de33a Abhinav Kumar 2022-04-26  253  			phys_enc->wb_idx, mode->name, mode->hdisplay, mode->vdisplay);
d7d0e73f7de33a Abhinav Kumar 2022-04-26  254  
d7d0e73f7de33a Abhinav Kumar 2022-04-26 @255  	if (!conn_state->writeback_job || !conn_state->writeback_job->fb)
                                                     ^^^^^^^^^^^^                  ^^^^^^^^^^^^
Dereferences

d7d0e73f7de33a Abhinav Kumar 2022-04-26  256  		return 0;
d7d0e73f7de33a Abhinav Kumar 2022-04-26  257  
d7d0e73f7de33a Abhinav Kumar 2022-04-26  258  	fb = conn_state->writeback_job->fb;
d7d0e73f7de33a Abhinav Kumar 2022-04-26  259  	mode = &crtc_state->mode;
d7d0e73f7de33a Abhinav Kumar 2022-04-26  260  
d7d0e73f7de33a Abhinav Kumar 2022-04-26 @261  	if (!conn_state || !conn_state->connector) {
                                                    ^^^^^^^^^^^
Checked too late

d7d0e73f7de33a Abhinav Kumar 2022-04-26  262  		DPU_ERROR("invalid connector state\n");
d7d0e73f7de33a Abhinav Kumar 2022-04-26  263  		return -EINVAL;
d7d0e73f7de33a Abhinav Kumar 2022-04-26  264  	} else if (conn_state->connector->status !=
d7d0e73f7de33a Abhinav Kumar 2022-04-26  265  			connector_status_connected) {
d7d0e73f7de33a Abhinav Kumar 2022-04-26  266  		DPU_ERROR("connector not connected %d\n",
d7d0e73f7de33a Abhinav Kumar 2022-04-26  267  				conn_state->connector->status);
d7d0e73f7de33a Abhinav Kumar 2022-04-26  268  		return -EINVAL;
d7d0e73f7de33a Abhinav Kumar 2022-04-26  269  	}
d7d0e73f7de33a Abhinav Kumar 2022-04-26  270  
d7d0e73f7de33a Abhinav Kumar 2022-04-26  271  	DPU_DEBUG("[fb_id:%u][fb:%u,%u]\n", fb->base.id,
d7d0e73f7de33a Abhinav Kumar 2022-04-26  272  			fb->width, fb->height);
d7d0e73f7de33a Abhinav Kumar 2022-04-26  273  
d7d0e73f7de33a Abhinav Kumar 2022-04-26  274  	if (fb->width != mode->hdisplay) {
d7d0e73f7de33a Abhinav Kumar 2022-04-26  275  		DPU_ERROR("invalid fb w=%d, mode w=%d\n", fb->width,
d7d0e73f7de33a Abhinav Kumar 2022-04-26  276  				mode->hdisplay);
d7d0e73f7de33a Abhinav Kumar 2022-04-26  277  		return -EINVAL;
d7d0e73f7de33a Abhinav Kumar 2022-04-26  278  	} else if (fb->height != mode->vdisplay) {
d7d0e73f7de33a Abhinav Kumar 2022-04-26  279  		DPU_ERROR("invalid fb h=%d, mode h=%d\n", fb->height,
d7d0e73f7de33a Abhinav Kumar 2022-04-26  280  				  mode->vdisplay);
d7d0e73f7de33a Abhinav Kumar 2022-04-26  281  		return -EINVAL;
d7d0e73f7de33a Abhinav Kumar 2022-04-26  282  	} else if (fb->width > DEFAULT_MAX_WRITEBACK_WIDTH) {
d7d0e73f7de33a Abhinav Kumar 2022-04-26  283  		DPU_ERROR("invalid fb w=%d, maxlinewidth=%u\n",
d7d0e73f7de33a Abhinav Kumar 2022-04-26  284  				  fb->width, DEFAULT_MAX_WRITEBACK_WIDTH);
d7d0e73f7de33a Abhinav Kumar 2022-04-26  285  		return -EINVAL;
d7d0e73f7de33a Abhinav Kumar 2022-04-26  286  	}
d7d0e73f7de33a Abhinav Kumar 2022-04-26  287  
d7d0e73f7de33a Abhinav Kumar 2022-04-26  288  	return 0;
d7d0e73f7de33a Abhinav Kumar 2022-04-26  289  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

