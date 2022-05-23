Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D644F530F52
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236030AbiEWNRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 09:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236018AbiEWNRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 09:17:08 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464451EC69
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 06:17:04 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24NCDH8Z030650;
        Mon, 23 May 2022 13:17:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=d5r5F6qKbNJWfE4ttTDTKMaOj21DOK5Dk6fKZRIEH9M=;
 b=w6NTIgELK26bZ5Vpf00CLFmof8yLyKlWVQd9Ue4oD/+sPk4wF3EkHM8t8eAueGWsXgtw
 DfVhfpp2oVb2ceauDuHqVJxqo8zo7EkGA4zpsvn8Ct3e//AK/Sv/XWhtRbbSQTUw0J+9
 7kqIVlX7/Yp+e/eAHo5sigJe3k9fnelQD5ORiEG+E0j1DP+vXK44V8i3pFNL9V/vC9EA
 lxYTBC4lG8dWVvRbIuih8wjJW2lZBDCj2AcfzEmOYMu6Fv8uMTc/IRz44kiVtaEhgXg5
 gmf5q3sIaLapJWxp0DOUoojtMqBwJG9AoRDo7rzDU8tRzO371lgFyV2o/PF/A65zGZnz vA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g6pp03ae6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 May 2022 13:17:02 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24NDAGxA020923;
        Mon, 23 May 2022 13:17:00 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g6ph799k0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 May 2022 13:17:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XH+lHXGLby/boBVQl0mubRWI/ytZ/k7o9eKQ3wdVmpfN4HGqPPeEI0q9XeQN3f4la6FRO1/9fnI3Ppw5hslnZbSu1hHZr+FbFHpd9TTDlwj7aws0ikMMPv2L0MPRB1C5LIJ4IjwzQ2smzlXN2KrtwH9eajAfJi1VoznFVhOaafpD/FyABLMIVIPm4ukqiVc7Iw52D8kw4HjTiBTThVNFF4rflleOhNcNbqCWYPrSzMlcoEgnM7h2bLbY2XXxZ6OjXd5IUXgJRHL1NqijXsD4PIydgKbZBAN0Yf7pDbn/1Xnd2TY7Gp4RxOry2jk/Jl7ku9OsgFCk8+sB/GGD0fM+Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d5r5F6qKbNJWfE4ttTDTKMaOj21DOK5Dk6fKZRIEH9M=;
 b=TefVMeDn8nzmy8XNJ5RwIicRwDR04g69oLubygOTZYJdmepz2g8H8ZHOkLATyYCF3uPTgt3ATOkAf6Mw2oSrTxJfK1gEIHkcIGZ/LdDEqWal6otvMYEHT/DKXfdjWcmvswda6Ag6XHqiaJ1J2mUsW2omA29h82okK/ljm+jwOjez0ll/sIXJXgwbj0s8zAF6sc5FyxVvHCVZpCu4UMnmIX7CrHKAY5TbiYWrtT6/8/kretum2ZHN1avhtzN0lb5PT3aPFbCb0CrWL/Ie7C59vJOKbhEvZRKewoVeHDrkjmvt/q3RxhkJ0/wO1FbPrU8mWV35Ajpn05rRS+pQSEWVUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d5r5F6qKbNJWfE4ttTDTKMaOj21DOK5Dk6fKZRIEH9M=;
 b=0Kc7/LJsMQVBXq0FZforXoB8B8nkXeo7Xo1eW5Ggz8BTK0x4Peg3hH/SB+FxUcHVlo2YnmWDqczznCeV0NOM9w5H52w9WxIlK3ok4yeWrITShQFoQIjZkS5lFLq8dVc39TdDnxuvqBUsej9dJdP8cZvtgUVvwdEF9HnuUU3vy7c=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SJ0PR10MB4605.namprd10.prod.outlook.com
 (2603:10b6:a03:2d9::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Mon, 23 May
 2022 13:16:59 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e%2]) with mapi id 15.20.5273.023; Mon, 23 May 2022
 13:16:59 +0000
Date:   Mon, 23 May 2022 16:16:39 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Hariprasad Kelam <hkelam@marvell.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>
Subject: drivers/net/ethernet/marvell/octeontx2/af/cgx.c:622
 cgx_lmac_enadis_rx_pause_fwding() error: uninitialized symbol 'rx_pause'.
Message-ID: <202205222253.Mj6ywHyJ-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0049.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::12)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62bbfe56-c9fe-41a2-dbfe-08da3cbe8432
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4605:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4605A6FC8D25FC944D490F4F8ED49@SJ0PR10MB4605.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B9qckKLfk4JbNfMxuqzcf5X0RO1b0toEXdCim8lthoF1ixiUgyJBpU9xtURJHxIezjB5jivpP7Y/jh2XmJlvDShgWtKDLnT6lDmHnEzfLf9e6y+w5y0ecTqjA1AVEhCB70mKtVnO4uEE8G97JDhRFgI6UX7qC6aSP+IvlB3sdZorq46v4PS6EknMci0uPfyiEZev9B3bwkOiV+O8XCUpwGFmOTj2D89EVGh+NPQbE/WtL6MseRRTdCmbt74ycK6DP+ExnWyhRdFoOW4n1Q5pjk4j2UJnvjyjpVXRIX4vPSjq0ze35y+FingP+W54ns4AOvj2GDK7I7++FknuzRTIH1A/KWajfafL6sx5scrfUcFq4JbkXS7hzkOkWc7ONf+gpJim0O6ScZWLTeruEl0gSLBCwjm+MlP/CK2gObrj6BOF6aCN7vbehf2ZoYBCTNrOaDhPV4QYx3M+HIGsCQ2ZK15WPQp77y424UD9hR9mUQQJWH6WnJRlVYbQ6U/h0U4sja0uoHyhdXztaonjhbDSFhf0cEHP5PeBKVPY4Qn/jgAjF2/0/y6DogRNFQ/Y5mqkFjbFM2P73j+YzmeXgfTGfeXuQe4I7ygKE7F4LNMNl/1sbfgDaYVx4cSlORrzSH/pon31J8GP16juFRVkXB6Wo2rPYQQAeSjBaIkF1bhaVhfDKQUUAv+ukut2W8+96K4vTMzMhxOlgAsV4r0ezLQ/WBWn2LpjjN6nGwHeAP1PV8VJrHqC8tKz08Jp5f1PMNWZCu0AYT9qI00Cc5bxFV+nzazB1kf1APicjlFc3CmM7dZSVQHtj/bgPBhrEO3Ei3w0B59w4oaZXgEIreZMSJwpXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(1076003)(316002)(38350700002)(2906002)(6916009)(6506007)(38100700002)(52116002)(44832011)(6666004)(66476007)(8676002)(66946007)(83380400001)(86362001)(66556008)(4326008)(5660300002)(966005)(186003)(4001150100001)(6486002)(8936002)(6512007)(9686003)(508600001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z0GFP0HCzxBkIe5zr8gOPJlP3Mxy4g6ImXPd7VapON/0qqbk9y0oO7EQO7X8?=
 =?us-ascii?Q?/Q/LXqaxr7YGuy77pexKaoCNB/cq+3gQyhUigeRvvilHNNkL9So3QITdZyqZ?=
 =?us-ascii?Q?afr1KZLF2Q5ZWVyHC8+wA+a/7nAC7OlP/m1H0tK5BlCRa/8soYTm2Ps3oF8d?=
 =?us-ascii?Q?BMnehriq3f4AgXltLE1acCiSpMjqr3bxuHVNpPADEDAseqy+pTqgGzabebbP?=
 =?us-ascii?Q?DpC8cH2G0WoavZ4HUmE1RcXJK90MW6WUrXwfxpG27LizWsBCTj5lr/yBw9qu?=
 =?us-ascii?Q?ZCfPTtudQtdYSn3sm8to0NgnUtTDdP017SlptONeTrGJIDFS03YjsUl8fqd3?=
 =?us-ascii?Q?MVSHxIH9krQLCi9ua1RjRALDGks1I9mymC3FgKxoweHl8OIAo6/E7mHlqXkE?=
 =?us-ascii?Q?0k4jME28xm2WsMV7rIRT0b3/QkUfsh9/oLip/FnfPF/I3pWz9l10nyc0Ry4q?=
 =?us-ascii?Q?b2az2S1+H6QAID8K4SFm8bOl3yTBiD63p1X+ESt+rwRaPgLxF09ZJ5NbVWyb?=
 =?us-ascii?Q?KVHpsYVDIaWuIX3XAuQtKTx5I8IPzSm9aaeTwX2DSsre91rHIP+ZZd0ilUJR?=
 =?us-ascii?Q?Fcem1nts28drigGZU1HhH11oeyN26xULmMONDBNsGZv1/SGv5yYLpzGxmBr4?=
 =?us-ascii?Q?4Rlrs3zcBlJEnqoP17RdgaD8tGKySh/lWIBXzRZinn612IXOPzRZwTzA14uC?=
 =?us-ascii?Q?qWD6GgfpfsU3qOgqL49HPx+nqXRPw4VU3+GzhMYX2FoNdF+t2jkImQTaGDLT?=
 =?us-ascii?Q?zV+YLidAnDShiKU9XrMqM08UFt+EabmrYwAl9diNVHf0MhWAD3vh5DpjIMsh?=
 =?us-ascii?Q?HPlffrObyQFpdAPeKAtHLfNuk+L1uJEd9uZr9AFdDUAftumj4eRsAbIBNIND?=
 =?us-ascii?Q?zHOPtyjP+s7Wk1+JPbbGcy79bctM+Uc1pwdaJ8lW6ldht+MTELggskSSkFau?=
 =?us-ascii?Q?6D1WnHkdF32VJMaR+r4YdUPqkACWMbWRKvhUGLdpdkB+gDZVlguTeF4hAuH8?=
 =?us-ascii?Q?6eD6hhjCHPqnu+tXeal7ezUflU7LWq0ld48AB+uF6Vp5LNuOZPfXA+n/R7bo?=
 =?us-ascii?Q?p/vtIpWmOWMQFeQvxr6S28no/6kwlFRLpI61iHd4wdQrm35WzxTJ2ZSkDR5U?=
 =?us-ascii?Q?axzlmZEChcINzx/hgkwkkFlUcdxfWGy4cK3rpppUo7NbdI+azfD0TSCQpeDl?=
 =?us-ascii?Q?/qwfPsxggEtRQPIugn5pLHVSR5/eqwk46ZYgDgPbRnjHXFhG5M1LzK+++3ly?=
 =?us-ascii?Q?/e+cStWgj/o12rLuxmLGoBqMywZcXOvL0p8ts+uTben52tXjJmzfUh/xSzKo?=
 =?us-ascii?Q?uof3+FWoUDzPR3iFboQakDc5HtLJ3efa9yBxCXbbcPRK6VxobU/HHLENw3WR?=
 =?us-ascii?Q?eIKfJCJITsBAF0GX5L0qnoXmpXQ7p95V6FrPxcCIZ9TuHoB1mhKJjdW9AvU3?=
 =?us-ascii?Q?qUzowJLF4Xe8qUTjIczZjw5Vb4XQIgJAOs9qOWHm1OPrEexFEsQcbI32/Ouj?=
 =?us-ascii?Q?0OnTH/uRlAGQEso7puIVaHI7bORZ/RbqGVgoLKuSpAX6GrXxePOEyOXVLBir?=
 =?us-ascii?Q?kvA8mKJWOC9vU7BAZWnHIp+wR8wFly38jWiswu2Lw9PE7GLx3d40+7yFxhc1?=
 =?us-ascii?Q?O2zMoM7TJpjdyhOSv1oNh7aELsjgZDUtLGXREYKlFnh+IiTuf2M6c55ZasKR?=
 =?us-ascii?Q?pVvqu8kide2Evt3pgr1JQKYwK2Rq1VfKouYDkt0hNWhz/BR+n/aqbzRS1lFx?=
 =?us-ascii?Q?stGMfn1Hz10D7zKoaIxjBb74sQ15AOY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62bbfe56-c9fe-41a2-dbfe-08da3cbe8432
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2022 13:16:58.9787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v/lQlZMxpTDlWQKd5OoklguRlJjm9aTuUNb1H83Z8zM8L9sM69yiVDcB8AUZq99irqaEBdAoUGzelQmD0o7ryl3gmkl3PPVWp7hDb40cb64=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4605
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-23_06:2022-05-23,2022-05-23 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205230074
X-Proofpoint-ORIG-GUID: 0JRYoDQQh5sxY4fYehp8mfr8Lt24-In4
X-Proofpoint-GUID: 0JRYoDQQh5sxY4fYehp8mfr8Lt24-In4
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
commit: e740003874edc13e468d19233f99787bedb4bb8e octeontx2-af: Flow control resource management
config: s390-randconfig-m031-20220522 (https://download.01.org/0day-ci/archive/20220522/202205222253.Mj6ywHyJ-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/net/ethernet/marvell/octeontx2/af/cgx.c:622 cgx_lmac_enadis_rx_pause_fwding() error: uninitialized symbol 'rx_pause'.

vim +/rx_pause +622 drivers/net/ethernet/marvell/octeontx2/af/cgx.c

5d9b976d4480dc Sunil Goutham    2019-11-14  602  void cgx_lmac_enadis_rx_pause_fwding(void *cgxd, int lmac_id, bool enable)
5d9b976d4480dc Sunil Goutham    2019-11-14  603  {
5d9b976d4480dc Sunil Goutham    2019-11-14  604  	struct cgx *cgx = cgxd;
e740003874edc1 Hariprasad Kelam 2022-02-09  605  	u8 rx_pause, tx_pause;
e740003874edc1 Hariprasad Kelam 2022-02-09  606  	bool is_pfc_enabled;
e740003874edc1 Hariprasad Kelam 2022-02-09  607  	struct lmac *lmac;
5d9b976d4480dc Sunil Goutham    2019-11-14  608  	u64 cfg;
5d9b976d4480dc Sunil Goutham    2019-11-14  609  
5d9b976d4480dc Sunil Goutham    2019-11-14  610  	if (!cgx)
5d9b976d4480dc Sunil Goutham    2019-11-14  611  		return;
5d9b976d4480dc Sunil Goutham    2019-11-14  612  
e740003874edc1 Hariprasad Kelam 2022-02-09  613  	lmac = lmac_pdata(lmac_id, cgx);
e740003874edc1 Hariprasad Kelam 2022-02-09  614  	if (!lmac)
e740003874edc1 Hariprasad Kelam 2022-02-09  615  		return;
e740003874edc1 Hariprasad Kelam 2022-02-09  616  
e740003874edc1 Hariprasad Kelam 2022-02-09  617  	/* Pause frames are not enabled just return */
e740003874edc1 Hariprasad Kelam 2022-02-09  618  	if (!bitmap_weight(lmac->rx_fc_pfvf_bmap.bmap, lmac->rx_fc_pfvf_bmap.max))
e740003874edc1 Hariprasad Kelam 2022-02-09  619  		return;
e740003874edc1 Hariprasad Kelam 2022-02-09  620  
e740003874edc1 Hariprasad Kelam 2022-02-09  621  	cgx_lmac_get_pause_frm_status(cgx, lmac_id, &rx_pause, &tx_pause);

The first two returns in cgx_lmac_get_pause_frm_status() don't initialize
rx or tx pause.

e740003874edc1 Hariprasad Kelam 2022-02-09 @622  	is_pfc_enabled = rx_pause ? false : true;
                                                                         ^^^^^^^^

e740003874edc1 Hariprasad Kelam 2022-02-09  623  
5d9b976d4480dc Sunil Goutham    2019-11-14  624  	if (enable) {
e740003874edc1 Hariprasad Kelam 2022-02-09  625  		if (!is_pfc_enabled) {
5d9b976d4480dc Sunil Goutham    2019-11-14  626  			cfg = cgx_read(cgx, lmac_id, CGXX_GMP_GMI_RXX_FRM_CTL);
5d9b976d4480dc Sunil Goutham    2019-11-14  627  			cfg |= CGX_GMP_GMI_RXX_FRM_CTL_CTL_BCK;
5d9b976d4480dc Sunil Goutham    2019-11-14  628  			cgx_write(cgx, lmac_id, CGXX_GMP_GMI_RXX_FRM_CTL, cfg);
5d9b976d4480dc Sunil Goutham    2019-11-14  629  
5d9b976d4480dc Sunil Goutham    2019-11-14  630  			cfg = cgx_read(cgx, lmac_id, CGXX_SMUX_RX_FRM_CTL);
5d9b976d4480dc Sunil Goutham    2019-11-14  631  			cfg |= CGX_SMUX_RX_FRM_CTL_CTL_BCK;

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

