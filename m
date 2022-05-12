Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89721524A20
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 12:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352489AbiELKSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 06:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243726AbiELKSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 06:18:33 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC32169725
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 03:18:32 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24C91kH5024581;
        Thu, 12 May 2022 10:18:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=QdKg9XA1tqOX3ZDYcfT4jNso6jKuTb5sPxVSUGqEiAI=;
 b=kTEdGvR54lhgtU6ZZ2wRcrNbYObGmXD39Xv/FNIr896NGhWI2t/SI8Wnt4B2aJZUsbUP
 lqpLaWR6D9d5McyuXmHpX4R08TYQ5t2EYvbv8syD/NIUZEukJ8ZlaAjNHybxO3u+5ze3
 v4xEJjPtElBXqtk43OMt95u8SVk7M7P5Hsv499r5ATsgsYINfwoyeCSaU4ZskX3YwEZW
 zvOtbVWNUUiWEdwt9mQk6kxLZvHHdNrscYywrZLI7wL23Wte55IcqdCRbKPTOw+nhc63
 oB7BvF1OG7cL2Zw9Woyryk9xzP/IkKEgeaxeTBm6/kVIt0kNt5hApreYgnxlIo4gy4Ky eA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwfc0v9s7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 May 2022 10:18:30 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24CAFiqw012461;
        Thu, 12 May 2022 10:18:29 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fwf75eja0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 May 2022 10:18:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mTve0fDkoh2GHzSjYv1HA8HUPIse/HeQW34+jfquuv+8sMgEzavlKiIpZvxhfBRrJgZliprDmAM4gj0dWjjH5FwdeAsO4bE2fzYrsqnr11ciEaDQ2LpzbRt9OrwKbKU+yJnBbTVxhbI4d7+EmqSi1pqDtfbfcRFIdUhxAN0s247Co9lU5UsXy25+nqzAAvseMT7FkkAs90ddmYaAy0s4KU2acWtRdOYKc+4nUSzNyT9xhHMw0efdYsWLjI9AbWLuEiAYD+uypZUM1tDB/KzTh2JVvu4czX98wKwPEjxerTKnbiLgCHula9Lq9eblAdCG62xD7wBfTSGmQdNE1IFRBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QdKg9XA1tqOX3ZDYcfT4jNso6jKuTb5sPxVSUGqEiAI=;
 b=CqnkM6GfdJQ297VTVhFXmWe32ukYAqH/ICzb91HtH1O2UKNyz9wVXgKnEIId1+0MPZHjprUmlBZGCAe+DfCxoOQN+dLEHxE5OraLVVYU63bGv7Wbh0JoKOTHijl4wpHypdKP47eNMgCecZLtzTTSjU7xu6Z/wVEfaIYjRxta7gRvwvmKwP0jjr3afJZ2Wi4l7UtrA1urG82AHf61TyAq29UeVDKdRMThZpZcWKhQu1Y4/wPKo9OqBjDGzYMusVDyMmyrc6fmdnfkX7FWg+VB0USvpSmCOjbtLh1e72pMYW6wBTG5k+LbSZY2rn8ZkSCGzgg83xSeTGGYqDC8YFmjiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QdKg9XA1tqOX3ZDYcfT4jNso6jKuTb5sPxVSUGqEiAI=;
 b=Aujy/eZ8sDmWzkXJu35XbIcrI5KE3yGgU3grE/XCD7shmlxdbG2Of755iP/ilr3XZEngNJBn4L90/zoyaEMewq2zuXpxFy2m2r6ujXpxwnouvszevfHihjbUdjepYbf1LPqpC/M7CNJ2jpddeeTMqkde//Pdt6uJpcXGpep7kag=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CH0PR10MB5322.namprd10.prod.outlook.com
 (2603:10b6:610:c1::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Thu, 12 May
 2022 10:18:27 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c053:117c:bd99:89ba]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c053:117c:bd99:89ba%5]) with mapi id 15.20.5250.013; Thu, 12 May 2022
 10:18:27 +0000
Date:   Thu, 12 May 2022 13:18:17 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Joseph CHAMG <josright123@gmail.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: drivers/net/ethernet/davicom/dm9051.c:610 dm9051_get_eeprom() error:
 uninitialized symbol 'ret'.
Message-ID: <202205121231.hPQrGSE5-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0016.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:1::28) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75c4af1d-64bf-4aa4-a9b6-08da3400c0ff
X-MS-TrafficTypeDiagnostic: CH0PR10MB5322:EE_
X-Microsoft-Antispam-PRVS: <CH0PR10MB53225B1F932169C49E6DA7178ECB9@CH0PR10MB5322.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T2DK884fyfibkXNocAYQXcWruwqbrAFx3h3xpr6hvuKQkMdY4cbe7R/LKVwScz/4kDVJtfZctlY7+yV0sG7SHnNeeM7X+GypTrXbJ9uy+78NO5JYd3NSaBwBMSmloaMwIiVE0ki4nbwDnu4lrw9a/dlCzr5t6JdceCJQ7uEZD4PHJdn4Mb3cd0I0MXUCXEY18skegUCukQRhQroSRQaVnS+jZu2XpNVcjMCr3Dysbu45CnvHDSOy24b1anGPs6ttxndS3DuZbdDQ4ffVzit4FBaBGJolqpu5bexRs3cThu9nXkzptUFTlH/reQ8GXdzIPGB2UyOWHMJQS3JVFS6KVzluKxcolW72is9faqg+ICM2uRm3fPSqZBC1jVPIxfUrUmveTotvD5LvXQqr6nMYK+r/eXM6FrhFDRbm8yNl9rvXf4IIdV+UFzYTYR9+Z/f9Nk5UhJ+i18DgYr3FBVevzslezXs71Jb47NYrcMQjegKTY1V0NBJHD5ci4kMZ/Otez63V75EYKFO0T7VMtTFJ4HbiLBXejKBVhs+z8P7hKq/EmEoYPFm/nrIBEd3WOcxmzdLUGGQwVeYNEwYmJ0Ms/x5onbaYxHLwq/gtN7osjbfq8O29lFun5jY7/mFPLOzWP0AtleZokpTTv44bmMnZkNBr974GQWL9aUoW4a9PrfF532HIJSPDv9Jcu2mtqCXlEe4V3gVFRiEjN1UD1FCATQCfaj3NscuJ55OlOW4wFuHm0k7YX/SW3d693V/a9BpJo6XB9irCbHu3htT/yNUVdeyme5Z2GH216noAXVrfC2b3XYBPo2DNScJ3DHNSQpdcGubo/lZnqsdjKmwmw4fz4g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(316002)(36756003)(1076003)(186003)(4326008)(66946007)(66476007)(8676002)(66556008)(9686003)(26005)(8936002)(2906002)(6512007)(38350700002)(38100700002)(86362001)(6486002)(5660300002)(966005)(44832011)(6506007)(6916009)(52116002)(6666004)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?97d40vplO4u6x4Nrm5adq9rDKSp0dOzV8oVAUukh8YjvgLNOTgP8LRkT9A0q?=
 =?us-ascii?Q?FmVrOgCNhbwTNHbzLgOizs6v19hS/znvOykhNa2dwfHVJzsTOmqWF0h9BD+l?=
 =?us-ascii?Q?5EpreApg5b9dHnZwnE9sLlnqln2r0C7YfMDtPf1Ya3heK28JLV3bDQYc88a6?=
 =?us-ascii?Q?lb/EJIpEAQnI2RuRgfe2wTTZO/detmM28emOTC4gTWff0pe4fVFdIVeLbWIz?=
 =?us-ascii?Q?R5I8i6vJFJoCPDjq9eZLP+Dxb0hE5BdtqWXK/7rgxqVyKiPCl7QU0xlPlXXC?=
 =?us-ascii?Q?UADofuufqclzDUb5cFIisAuj7jMfQovDcTL/6Dlac6V+WBhoG/CMTh4sDs/C?=
 =?us-ascii?Q?9Qp95ewCJiNWdmfmUEnBPkPIwUHmO1j6MLmwKCif0D8DB69IxAzTnmDZztxc?=
 =?us-ascii?Q?A1lpnDraaNr93ZmMkRiGHgBr6nO9LfEQ9jr+1oCA96hgqq1LOEVI6GteraKs?=
 =?us-ascii?Q?qxvi1Q3ZrJ3qCvlG4n0H7sgz315zzSeB43vA0NgVZ+gBWrt1LhB+ItNf8mS7?=
 =?us-ascii?Q?Ah8XPua7KbkywvjCvkgpfuenAc6aF/WrRifG82VwX2uV29WV+iC8bibb9ktK?=
 =?us-ascii?Q?uxpOfk2Ffj5grlPLNSJ67z16uADfu7Nx4h4Dc5r0PV2p5nb8Aw1yU2cdPwMi?=
 =?us-ascii?Q?8woRQy9SvHpnwzpAYIZIRUNyF2+q3y5sYPsGOdcRPHVq0gTwYoJk2nONU+6W?=
 =?us-ascii?Q?5vgv8e9AadFmvj62Yo3d1Zr4Gld14jDfWyqH0pxjC/s0hqFTpj1+pJh0oI8S?=
 =?us-ascii?Q?fg9yiGYEqlBWfMAgbk+RGWCmYw7QpT1SDO8883+SH+nacvlbUNzqjCOig0yz?=
 =?us-ascii?Q?8VQSG4Fv4AhaxdcbCqy/yTUGGtG75dqw9LVi9BbUa4Ff7EDRcMy2PoqxPABM?=
 =?us-ascii?Q?h3Gi240+VqdZy/jEOt4VreMZpW+bnmVkPpjTrzkE/ldWHuIwqLKErcCct0AW?=
 =?us-ascii?Q?wP7sMzERjAQ7VcUsrTXHHuM+zfhfx4ItqqmZX3Z+9xx8fi/GL0dZg86AqOsQ?=
 =?us-ascii?Q?WrHGGBKl4FWlDKkP4rZVUkxHWf5lQamtw7TA3c1jAcP+DT6gyBQCAruaxZQS?=
 =?us-ascii?Q?ojiY4+LWom0qnbghnDnJk65vv0UyLuP+5ZPEXLhF4DupCrtE2KgDpfD91+8k?=
 =?us-ascii?Q?7tUTgypDpQmx88GGOX2FEb4j7hdqaT5kXlNUrYwUBKZx+u/QzhK0Ytq1m9TL?=
 =?us-ascii?Q?6w8bs+CWbbMnzG4XaKugiHrqZFOF1qqThIYinnrbt2EeQW9AZaqj4KRV3px+?=
 =?us-ascii?Q?dqsGa1E9mL9p1C8ArHPsl8xScPbxrH/BXmfnl7UlfAnBByy1w8uP/6bjJvuV?=
 =?us-ascii?Q?hB/UF2KUOIGqSA2p9gdxjmuLml9ge/TyAinFOf3Th1YODCorHpR333Riz8M3?=
 =?us-ascii?Q?cIdl9EGGbUWDknjICl2rXTf8uBV1yo7xLsr6GLKmGq7gd9BEGTjCPVJXCDGa?=
 =?us-ascii?Q?+sbhktz3jYA+uY0mhhDp2Dq4nNAR5xuR8kzPBw7Oo4Zde8eyj06feS9zYCZm?=
 =?us-ascii?Q?DJ9LZQIbuC4utiyjjgByllUrJ7drhnIEuVSbIdEYYaJ/rtgLbpnMvNsDcxrZ?=
 =?us-ascii?Q?Wu9v/bHpIPU5s9+cgTcXjOm8XxaEqOGyVbtk/y17+T0drG8vYFpOQQ4EPAcx?=
 =?us-ascii?Q?XtAE7n2Hs72pFu7ltz/DUxYukA0NA+MciBl8RfMk4Oq3gry2bbZYjPAmWIfu?=
 =?us-ascii?Q?sy3d9Lof0Kz6Qim0A9GmxhcKHAvq/FRD9gznAB0GrSJHBrlgBA8GH0sun8/8?=
 =?us-ascii?Q?8ytuhcAYqKVbrkhMOJMAqchqAK1Z9yI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75c4af1d-64bf-4aa4-a9b6-08da3400c0ff
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 10:18:27.1783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0bg2K2IuV4gU/WQCtTyQY1e6gjLzEjK+UxvHcLKl89dBoT8zSM1Aj6DfP7vMVvoOAXmDVJZ5n4pm/VBxbUSyqR31zk4RC3kI5BdDYYvPiiE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5322
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-12_02:2022-05-12,2022-05-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205120047
X-Proofpoint-ORIG-GUID: 6QaAO39cxa8DbUqUGKFVuBfXCtxoSPIB
X-Proofpoint-GUID: 6QaAO39cxa8DbUqUGKFVuBfXCtxoSPIB
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
head:   feb9c5e19e913b53cb536a7aa7c9f20107bb51ec
commit: 2dc95a4d30eddac9679f295ba4304a7ab0e4ae02 net: Add dm9051 driver
config: csky-randconfig-m031-20220508 (https://download.01.org/0day-ci/archive/20220512/202205121231.hPQrGSE5-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 11.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/net/ethernet/davicom/dm9051.c:610 dm9051_get_eeprom() error: uninitialized symbol 'ret'.
drivers/net/ethernet/davicom/dm9051.c:632 dm9051_set_eeprom() error: uninitialized symbol 'ret'.

Old smatch warnings:
drivers/net/ethernet/davicom/dm9051.c:527 dm9051_map_chipid() warn: unsigned 'ret' is never less than zero.

vim +/ret +610 drivers/net/ethernet/davicom/dm9051.c

2dc95a4d30edda Joseph CHAMG 2022-02-11  592  static int dm9051_get_eeprom(struct net_device *ndev,
2dc95a4d30edda Joseph CHAMG 2022-02-11  593  			     struct ethtool_eeprom *ee, u8 *data)
2dc95a4d30edda Joseph CHAMG 2022-02-11  594  {
2dc95a4d30edda Joseph CHAMG 2022-02-11  595  	struct board_info *db = to_dm9051_board(ndev);
2dc95a4d30edda Joseph CHAMG 2022-02-11  596  	int offset = ee->offset;
2dc95a4d30edda Joseph CHAMG 2022-02-11  597  	int len = ee->len;
2dc95a4d30edda Joseph CHAMG 2022-02-11  598  	int i, ret;
2dc95a4d30edda Joseph CHAMG 2022-02-11  599  
2dc95a4d30edda Joseph CHAMG 2022-02-11  600  	if ((len | offset) & 1)

Can len be zero?  The kbuild-bot isn't doing cross function analysis so
it just assumes that it can be zero

2dc95a4d30edda Joseph CHAMG 2022-02-11  601  		return -EINVAL;
2dc95a4d30edda Joseph CHAMG 2022-02-11  602  
2dc95a4d30edda Joseph CHAMG 2022-02-11  603  	ee->magic = DM_EEPROM_MAGIC;
2dc95a4d30edda Joseph CHAMG 2022-02-11  604  
2dc95a4d30edda Joseph CHAMG 2022-02-11  605  	for (i = 0; i < len; i += 2) {
2dc95a4d30edda Joseph CHAMG 2022-02-11  606  		ret = dm9051_eeprom_read(db, (offset + i) / 2, data + i);
2dc95a4d30edda Joseph CHAMG 2022-02-11  607  		if (ret)
2dc95a4d30edda Joseph CHAMG 2022-02-11  608  			break;
2dc95a4d30edda Joseph CHAMG 2022-02-11  609  	}
2dc95a4d30edda Joseph CHAMG 2022-02-11 @610  	return ret;
2dc95a4d30edda Joseph CHAMG 2022-02-11  611  }
2dc95a4d30edda Joseph CHAMG 2022-02-11  612  
2dc95a4d30edda Joseph CHAMG 2022-02-11  613  static int dm9051_set_eeprom(struct net_device *ndev,
2dc95a4d30edda Joseph CHAMG 2022-02-11  614  			     struct ethtool_eeprom *ee, u8 *data)
2dc95a4d30edda Joseph CHAMG 2022-02-11  615  {
2dc95a4d30edda Joseph CHAMG 2022-02-11  616  	struct board_info *db = to_dm9051_board(ndev);
2dc95a4d30edda Joseph CHAMG 2022-02-11  617  	int offset = ee->offset;
2dc95a4d30edda Joseph CHAMG 2022-02-11  618  	int len = ee->len;
2dc95a4d30edda Joseph CHAMG 2022-02-11  619  	int i, ret;
2dc95a4d30edda Joseph CHAMG 2022-02-11  620  
2dc95a4d30edda Joseph CHAMG 2022-02-11  621  	if ((len | offset) & 1)
2dc95a4d30edda Joseph CHAMG 2022-02-11  622  		return -EINVAL;
2dc95a4d30edda Joseph CHAMG 2022-02-11  623  
2dc95a4d30edda Joseph CHAMG 2022-02-11  624  	if (ee->magic != DM_EEPROM_MAGIC)
2dc95a4d30edda Joseph CHAMG 2022-02-11  625  		return -EINVAL;
2dc95a4d30edda Joseph CHAMG 2022-02-11  626  
2dc95a4d30edda Joseph CHAMG 2022-02-11  627  	for (i = 0; i < len; i += 2) {
2dc95a4d30edda Joseph CHAMG 2022-02-11  628  		ret = dm9051_eeprom_write(db, (offset + i) / 2, data + i);
2dc95a4d30edda Joseph CHAMG 2022-02-11  629  		if (ret)
2dc95a4d30edda Joseph CHAMG 2022-02-11  630  			break;
2dc95a4d30edda Joseph CHAMG 2022-02-11  631  	}
2dc95a4d30edda Joseph CHAMG 2022-02-11 @632  	return ret;
2dc95a4d30edda Joseph CHAMG 2022-02-11  633  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

