Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2955312BB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236109AbiEWNXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 09:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236144AbiEWNXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 09:23:03 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326622FFE3
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 06:22:51 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24NCDIm4030654;
        Mon, 23 May 2022 13:22:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=+SXZrsuD+83MndmFPYi8oCRFHJ6/4UN2f9MR24WggGw=;
 b=fjj9pIXJFulHeIb+nfNG5P6JaEuDm6mjlr9oG9v1dtk5Aj2UXNlAvhwvXss+eVlpBc0F
 SQM2e+MgQNftR7+ZyRm84A2Y0FSRFJUJEwNeBhD3qcrdYqxSat1Fsvj5y0JAVkheSTBZ
 7LUAslxrswlntc+NHxy74TH5vr0i1PJLWc+ujqXShHjrh+feSD5s+9jLpqu49jqoORj5
 OkpiLq7YtIWPClpjzjFdSObovzKBTpUwU30hs2LbSp24X83RDkaYScFT1GuccZXRVyOF
 MmwZd+DEFeVGTom2Okk8wC172IhYzBiGmlfPpB1r+pXhf4LhX+C3mmbqRzXLTUP6kXo5 rg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g6pp03avw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 May 2022 13:22:49 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24NDAIBq006400;
        Mon, 23 May 2022 13:22:48 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g6ph1k233-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 May 2022 13:22:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HBJfEeoHL89CTlWmve56hoJqOBhxoqf91KByuE+3uUx9vmMtvqvVlCHuHWODS+BUoco4p6GcpXRHM/BNuW6YoeSbU+eQL9ZkpntgBr79oDJ3TgQwqRI4tl8HVRShUBN5u0GCwwFUQuDz59FoEwEPaoZpVL32OEzOs1ex8HPpoexZxBivwNsV3w4kNclWeYkocB4gG95m0NajFUwgilnQVCeM8fE5G5ggQYIgT3qNNzPQP3N77WSdHsexxtEwF2Gqq42qxEi83P7eW05G/nICQwU2kxBSLVQivlNC+vwwSMGczte8Rdn7VigRB/wAAqiLeNrWeD2Il02/lJeb9w8fog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+SXZrsuD+83MndmFPYi8oCRFHJ6/4UN2f9MR24WggGw=;
 b=j30JdWjw/7a8N4kdd4tBadJsnNLR4zlfKy8XToOAOzwXh1QxO/uk16cjIv8HU1bz1SjVBvQWPvwliUXnXSA/1hwvKU4Akx4BNIpDbip4uDiZK5yXOhbuYYt24Pi/ZuCVTxguSgB92YfRA8uswYVAx+LoLM4zlreQnuSiBGJtIS8WniraQOujyhw76kBAjLv/uLD6tmLk3gWXsm7VJR9NCAA2ob54lrkDjl/kKVGM3Ccy/v9rgQppZ7DBgj7D5f2AEQe/NTLCxYcczs0z5aNieKH5uqRs1xXGjKOHOawkXkwUUk5pmSLmwPGRmMlOdVXIR3wbS7/fS0CBLLvJL1mkxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+SXZrsuD+83MndmFPYi8oCRFHJ6/4UN2f9MR24WggGw=;
 b=yiAyfQ/O5LamTIGyivfxt9JOckdyWyflH8XGCkgu7QNRMAhzRudhTf8Fe/IipoKr7CjSgT0l0E0fLpf/SYnCYmGIC3TdKHVZQTR6K0pX/ZR7vHfZY+TVanJJXnb7S+UKymCJlZz+ygmkJD4csHWA88ohAdENSuIJOE11astmYlE=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SA1PR10MB5526.namprd10.prod.outlook.com
 (2603:10b6:806:1e5::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Mon, 23 May
 2022 13:22:46 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e%2]) with mapi id 15.20.5273.023; Mon, 23 May 2022
 13:22:45 +0000
Date:   Mon, 23 May 2022 16:22:15 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Cong Wang <xiyou.wangcong@gmail.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [congwang:sch_bpf 2/4] net/core/skb_map.c:175 skb_map_get_next_key()
 error: we previously assumed 'key' could be null (see line 170)
Message-ID: <202205221325.tXVMMrOx-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR1P264CA0164.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:55::15) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 062f58eb-d318-44a7-2235-08da3cbf527d
X-MS-TrafficTypeDiagnostic: SA1PR10MB5526:EE_
X-Microsoft-Antispam-PRVS: <SA1PR10MB5526DC9C66ECD45FA61D2ABA8ED49@SA1PR10MB5526.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vOpBHsX0M9ma0HXkmqpQlRnw1FQr8Di2hsQ+PNGDr/rmCyzfMqgS2KGTkFpAuLqxqHwEnvWJ6GXbbWWcf81lLsHIIz0sn6H63wrsqd78q1UqLDJx0FVaK0eik697I289i4Kt8Hsi/xGfPYN3h3RtbpQ2EKN7u2aSbGacL5ZXNfqHY1m04vr9j04WzLDPZF1A8VdQwfDm9FvvK4D6divgDhLUm51zb3QwH1U92iTKagPga9WASyKTMtMgZUkmg98bw26zZoZI02DW2WdtbOCMgsnJlQ8MKYsyyM7Od7KyWuKVZav49fMzUIEwyjhWRrgWAVi5iIc345E3GfiS+lh8ALSn15LwfBDoVMoUpMFl7vX/US0nKKc31QgVe0HNNDIca/hRO7dOg1dVhnfqBKHT4u05mErlO7Qo4ui3Echar+5L/1XXBj2cdW81yTqyDC258gZswUeVWGoDXqijXfE1YynWbsO2IIzOPyKP7obV7a2LT/qNdl6d/FI8YAjEgzEg0YpVC+Dd4CwNAsfC9tAdI3huFb3QzKoQCYG26Bqza7fJ20TdN3RJ72Sh0up8+MEgQuXxXQ89FM1Wv1im3oycpmv6zt8btCzQec0MgzX9J/Vr24qZOnDmfZy9H3Jl6WjL8xjYWOhBPuQYXcI4Y9prvHjCpovK/W9z+i+aR1Hv7T5Y0XWXyKFQ+3cdsK0hwAwDDBlkPVIg1I0mMGHKds0z0DHXwlOM74yQYXR6kaY1B2OSTj3BnQ2QIZ6qgzlDf+zj/Dtfjg1Z9CvMzQQrS4/cBwab97t9emaVYqERlrK7COKugVBxFLR3g+Iuyzf5Hgon2S71OD6m6YmHdsKmH8MqAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(6506007)(52116002)(9686003)(6512007)(83380400001)(38350700002)(38100700002)(44832011)(2906002)(36756003)(5660300002)(1076003)(8936002)(6916009)(8676002)(66556008)(4326008)(66946007)(6666004)(86362001)(66476007)(186003)(316002)(966005)(508600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+xAVpzpkXT5ZZ4pVOLHG7/n7Ea/VqH4Fl41EAkIFtkmV+1+DVPycWRj48ZWW?=
 =?us-ascii?Q?L7g+jjM8lTEq1IjKtNcMBk2UePoSK+Nl/kzKQUlzUYZ4iQFH/zcGrxjdTgPu?=
 =?us-ascii?Q?6vqFNI8dvl3t7nnZMxOvXUU8laqmSVmnUVvci77lPvdcOlOZs+RwihGUIVaD?=
 =?us-ascii?Q?jGsyIaKZOnXA3f1aHtMphtrqRQ7YhpHR2xeOlGKC4NVxq+5h21rEMCoGVXjD?=
 =?us-ascii?Q?c+VMB+2WMZvFl+IgiSq6dZr2oPh/b/el6UK4RRDO2rqM30pQTNVNOEjV5g6o?=
 =?us-ascii?Q?ibIU7sSlbvD6lhznO+MP9uFlbVVOuPgGfOxJJqLl/sAXuI2Sg4iABganXXNm?=
 =?us-ascii?Q?zrcJ4Xkzda4XI6lm/3zbKro+R2DOTx9XQ9b+Hc6KaUrit+BhO5n3ivxFDX5t?=
 =?us-ascii?Q?9EhDasJ3J5W4/Rab/PVgMViYNmLn2KUKOGNX8dllKzNqvMf/6cr6H6G6yVv7?=
 =?us-ascii?Q?SaK4hCT++aeaio570MWjT4/iD40wwa8cjX3YK1M6XCZejvFEG/IpmQVnMpLZ?=
 =?us-ascii?Q?9sLWeN6LT2Q9xJn6BLefLA0ThVa9sRywmcHxaDqRLYPP8NRjGJ/BdDu3zrbt?=
 =?us-ascii?Q?CDC2sapIJc82IcAuJFnb4kocr1AM3rXsTaLZLtm9KBRprxWDE6zvDIcSedZb?=
 =?us-ascii?Q?isgHNsjjipITJriyRIXkd0bhyF8Rq/S3dVGpc+McH8mVxkQCeEpzHAslgamH?=
 =?us-ascii?Q?mcOxdpd1VGFrBKAWn3pZzBZpUzRbV4MeFmkWN588hpt6kxMdPBgWuntnCGvH?=
 =?us-ascii?Q?PqxfDjXpqpqVNXSV95LM+kvy0TAbTgpVbS9UpGxTWOIOOVJGvL514lGAvTMh?=
 =?us-ascii?Q?EPPfxIlE18DWcagpFiUH27Yds2eY1UODGc8vipAvibnl9AbLvjadhT0Y+xbH?=
 =?us-ascii?Q?lgyBsZQAkV1cUwYO+RCAKPuqpKm87xNLGMX6tTD8VIwEH7X4/QejyMr6d1bW?=
 =?us-ascii?Q?ydEiygnjrzXs+hLoV7CoOgFGObQAqnf40k71a0Nswr7wUa8J9OlpBispL+Ta?=
 =?us-ascii?Q?bKyWmfY9J+H9Gm93lh/F4omvy09yQjvoX1k+1qkdfpUQ9MFJ8IeWp0FASz5Z?=
 =?us-ascii?Q?yBYCJPHmpjj3LbGI0SbZOhXTxUjxvxW7e4t0RcTKyPfqT52LQTXyCx1G+p3P?=
 =?us-ascii?Q?RxIzIqCz8T5UQGACXxkhYEqaUk8bQrEHluFkK1cvnXInKW39LjrB1/gFvDSi?=
 =?us-ascii?Q?6pO6mcmZovdFadh7XcG22T78595dSi2IwTSQ1yq4qUGzIHapOn940XX+sDfX?=
 =?us-ascii?Q?seQA9TaJxy+1QGR1mARa1q2l26inC7AIySqbyUx0p/dTW+SJUW0Dp6P2SNYf?=
 =?us-ascii?Q?jbOgNo0rSiaUP1BsUPJWAW7fX4tHXJutC5drinP7BXO1bvycOlGJuBasEuqA?=
 =?us-ascii?Q?7/rvmO8ZnWl7KxUzIA5HvsT09hQTTheH0tJaRhbbqeY7oRUSq1dFqhsqpJhG?=
 =?us-ascii?Q?E35scMKkKpS18bICYS986dceTYCNBDZBc3kkvx375fl+QDNR/uYH3i1UU28F?=
 =?us-ascii?Q?wq/O26KDOO1tWKnLEjyon+r4OFd9m/cs6iLaK9i/+X640/KjbmE1gOxdE7mU?=
 =?us-ascii?Q?nCIO3ji6uqQACDfnoSgy5TO5BXHe5Kc6334EpaEIW5xvwHA1TBXLeoPbYZFz?=
 =?us-ascii?Q?2iJsZV6/5qo/UJi8LMqvoMrYHOjmge1eiAGhgq3PcrwCv2GndPhPFqdaUF7B?=
 =?us-ascii?Q?8a+YVVUeCXjk8CqScXZYBrXuKqY4adyqO39Ju3LxGqDv3PMzdoDXTCavHQtj?=
 =?us-ascii?Q?/SHkdtWHkvbhY+CLG/qbj9gUJrUbZhY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 062f58eb-d318-44a7-2235-08da3cbf527d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2022 13:22:45.4667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 67qRZahCVKEbwqxlVPWN3zJnqtz7eFaCYbgeOFH8ret32ySKarOUm3UPK2UKRsjMbDdZV8HJjp11DDqQjOHqZ3AdZg+VYAPsLpX8BE0Uzq4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5526
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-23_06:2022-05-23,2022-05-23 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205230074
X-Proofpoint-ORIG-GUID: pYl8apvApfGV_I7hdxDILQ7fd0rRMcxB
X-Proofpoint-GUID: pYl8apvApfGV_I7hdxDILQ7fd0rRMcxB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/congwang/linux.git sch_bpf
head:   6ffa225aaaaa22848f4629fc911a682553f17770
commit: 87784a11f90e7582ee664b531af17f7ca6ce2b62 [2/4] bpf: introduce skb map
config: i386-randconfig-m021 (https://download.01.org/0day-ci/archive/20220522/202205221325.tXVMMrOx-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
net/core/skb_map.c:175 skb_map_get_next_key() error: we previously assumed 'key' could be null (see line 170)

vim +/key +175 net/core/skb_map.c

87784a11f90e75 Cong Wang 2020-11-08  164  static int skb_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
87784a11f90e75 Cong Wang 2020-11-08  165  {
87784a11f90e75 Cong Wang 2020-11-08  166  	struct bpf_skb_map *rb = bpf_skb_map(map);
87784a11f90e75 Cong Wang 2020-11-08  167  	struct sk_buff *skb;
87784a11f90e75 Cong Wang 2020-11-08  168  	u64 rank;
87784a11f90e75 Cong Wang 2020-11-08  169  
87784a11f90e75 Cong Wang 2020-11-08 @170  	if (!key) {

If key is NULL

87784a11f90e75 Cong Wang 2020-11-08  171  		skb = skb_rb_first(&rb->root);
87784a11f90e75 Cong Wang 2020-11-08  172  		if (!skb)
87784a11f90e75 Cong Wang 2020-11-08  173  			return -ENOENT;
87784a11f90e75 Cong Wang 2020-11-08  174  	}
87784a11f90e75 Cong Wang 2020-11-08 @175  	rank = *(u64 *) key;

Then we are toasted

87784a11f90e75 Cong Wang 2020-11-08  176  	skb = skb_rb_find(&rb->root, rank);
87784a11f90e75 Cong Wang 2020-11-08  177  	if (!skb)
87784a11f90e75 Cong Wang 2020-11-08  178  		return -ENOENT;
87784a11f90e75 Cong Wang 2020-11-08  179  	skb = skb_rb_next(skb);
87784a11f90e75 Cong Wang 2020-11-08  180  	if (!skb)
87784a11f90e75 Cong Wang 2020-11-08  181  		return 0;
87784a11f90e75 Cong Wang 2020-11-08  182  	*(u64 *) next_key = skb_map_cb(skb)->rank;
87784a11f90e75 Cong Wang 2020-11-08  183  	return 0;
87784a11f90e75 Cong Wang 2020-11-08  184  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

