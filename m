Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5050649F42D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 08:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241385AbiA1HNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 02:13:06 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:35168 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233473AbiA1HNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 02:13:04 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20S7CqGw019637;
        Fri, 28 Jan 2022 07:13:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=QrA1R+ni093xiWnEhTECOpr7Vnh7P9nggZNqr1Km8SE=;
 b=aWhTEYJugf9adUgIYEgEJb/QKjiD8PLRYZ3pCaCvL5A8FuWvnl7bKWqDkhW0/tN54THV
 4SkvbYHxYd0vWwDGwc972VY6xu9i4dcPwa9T0ZvWZoOeZPfdznSiokzuZEdjVCIekSHA
 5p73llthbjGqDdPef2MhGik0wEZQBWnbLJVOWX/UDf5Ewuomr8cVt5h5tk64cr/Gsesu
 +5CUAOdLTxk99EJDj+rrurxiXd15Hy/i7CnPuPWQJe9LOSd+OWHCCrPgJixIBZ8jYyvU
 lxzTImPliq6U6t/BMeSQWAV6zUZxM2iNHylQ+9TANBv11Ex6B43IywlR+qbjVPEs+3DR +A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3duwrxjb12-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jan 2022 07:13:01 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20S7B7jx108789;
        Fri, 28 Jan 2022 07:12:58 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by userp3030.oracle.com with ESMTP id 3dr725289s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jan 2022 07:12:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nuIjmWIpAiFcHPMZsy/kjcA303HklLnzMiMDcHJ2ewsf++J+F3ssfZOIZdUCz+5HJt62N4lcn3t4SDyxZ8ZlVy4Unzo2kRfmMZLhJh1hw3xki8fQ9VgwLxWM2gMAbrGA61y97DwJMV5EsIqUxqgosc7xw1gL5B1fVvqfzezWbrJOb7HPhV5u4rsHllRQGi3zTzNYRRUSLFgiESc2m/jBDu7Ta59cajElAiKeeVQAj3FTgY9TxGoKH/lbKLO/fjK1L99uVrTSSmBZwFjax5+vhISgIGiTDp+WdSLTgonHWh+KlL0gmNMcyf3uQ3tqtj8zPvo8huQb6xk6D3lrHqqJqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QrA1R+ni093xiWnEhTECOpr7Vnh7P9nggZNqr1Km8SE=;
 b=XimSW6zHtWlCUzzMP6X1m9yDE5A835uppmNYD+jRNrFsuycrxtVJTFwmYwrSSJ6V0ors9j3NZGNF/9oc6hnBi1unKXPBV43CTvtVMr+ZKsUQ/9SPrzmn/x7DMxrGl6nr9/K8CFL/+dZ5kYvJjbyaFyEXfrKtX7Ar4vP/8eN+xVGMf1II0RLVxaj7mWYhd272cXYz4feiJtvNPg108jij98IPqOZ1xyNRVMmA+JFqTV7H6/pyg7OoM7cDUlvII+Kl/VudDJmgGiZYH/vMVxZvsRv8W1Qm0WBvXiMvsiBopn/689uXp7215/WQoLo7ibwv2PKtDQEqnWmT0mD7E1S3wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QrA1R+ni093xiWnEhTECOpr7Vnh7P9nggZNqr1Km8SE=;
 b=xLYyrHh9TxLLn8Ro7KXhLfW87YLs+dqjj+YeqEJ5h24aq3yOscel+r5eDrhC2lum0y2SUpF3FgL3jo1t3IYSTeZrLI7WydQSeEQBoeD9U4QJ/Udq4KbciRKHJo1Mm0lUoJxfrAm1QuJfYw5kAVVgntKh+UhLNxK5anGb4Vzker4=
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32) by BYAPR10MB3544.namprd10.prod.outlook.com
 (2603:10b6:a03:121::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Fri, 28 Jan
 2022 07:12:54 +0000
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::cdcc:584:3514:f052]) by CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::cdcc:584:3514:f052%5]) with mapi id 15.20.4909.017; Fri, 28 Jan 2022
 07:12:54 +0000
Date:   Fri, 28 Jan 2022 10:12:36 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Wen Gong <quic_wgong@quicinc.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Kalle Valo <quic_kvalo@quicinc.com>
Subject: drivers/net/wireless/ath/ath11k/dp_tx.c:511
 ath11k_dp_tx_update_txcompl() error: uninitialized symbol 'rate_idx'.
Message-ID: <202201272110.Z8STyrTC-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0025.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::18)
 To CY4PR1001MB2358.namprd10.prod.outlook.com (2603:10b6:910:4a::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eeb77e6b-bd00-477f-9d40-08d9e22d9a9c
X-MS-TrafficTypeDiagnostic: BYAPR10MB3544:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB3544B06BEDA22DC304BEC62B8E229@BYAPR10MB3544.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:51;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UHoQbUIk9/sPWbaTagw56HqXrlXI3rv9BosdIigdzyH7Y9ShM8da9Zu6J26B6+OV1n9noUzo0kOvf0CtMw+JM4vTs0MKHR3k1O11qDDT2jxCpagwbuKPeItT5RudTB4T4fgu5ZoCTDmeGMhB8BimkQqJw+ddcw1/HD5MZ3Cz8l5xXs/0/xy3VLLjcXTvkn9/EuY70GkY5P8wznqC1lDiIQUEmL7WbAUMm9JkHXlV+7dR52bXNy9WssqzhAZImIM2sD6V9DvgRTkeBQFVl0DLTtI5I7tt6XD1rTsU0LbYhPNEqxKnb7MJiXrlU3hB22tnZDyAVNDVkK6GQCYPSF+hoH3Yzl+s3uC4bNOb/YDg19e4/jj7ri5BQUETtU+Ay25Lt/LLo8bDnsjS4/KeLzH/6hR06lf6IT+mih3hQTes/fE5xEXgCiymRf5NuL4vVhFY345F2f0n92rMU94gdud8CCIvYN7bv0Wb3mLjrA9+HzcfssVG5cN+W9xYDC6GQy+F41/e9WkmaF1WdZ7rfvgIdBtRkgZ5tLEKYdItm+V7QC1Ucwi1RNza/ojlR+wd6HceG+KEqkyTDZND4TXCLv9GH9QbVSEKN5KI7LU56YMOnHKABTGSytSsT3cT1a3qMIxVM4YYrr0in/El+8lYlcqhRefWWiP2FtytMeW7tR9W83QoVuA0/gWGAH0r9tzmJ7RGCl+wJL+bcf6Z5XW+vbAVyhK+GIS3XyUWo2Iz5+6FOo7gemZCfK8NuXQ+2JKq96SP0X7pOouVklwLFom7FVqTmPQtQJfTyBor+yYCe0xEHF8O48Zekx93dxBzsI1d4nkOeqWIHotr9GpSjWtNgrLAUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2358.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(186003)(1076003)(2906002)(38350700002)(26005)(44832011)(8676002)(36756003)(316002)(66556008)(66476007)(4326008)(8936002)(66946007)(5660300002)(6512007)(4001150100001)(9686003)(6916009)(83380400001)(966005)(6666004)(86362001)(6506007)(52116002)(508600001)(6486002)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IF8wAH/5iHDrSfmwCp3Dbekp2vxQDkJQAYyHiLIBzpDmcfEt8PBx/EdPprIw?=
 =?us-ascii?Q?EBpB5kZK0kicS10SO5w5NAIjQOQbFDu+LXPcGUQfs6Cot302ee/7UjjzbDmx?=
 =?us-ascii?Q?29hgy0/uY33QfMrs/p64STUyCaIsJyfRrsIb3qDsqPMBPHnZ2iXdIiZ9JFQ0?=
 =?us-ascii?Q?eamZdyhEIp0sgWL5QXhi1PlrUqgzfwXILSp283XrAUCO/SiBlxGFDjVvQt3N?=
 =?us-ascii?Q?g8wUrm16LpZ1HFaYOk/dzcOYpfHAaiv8fhfluTWP/v8jQ0LYhSmPs5/yHhmV?=
 =?us-ascii?Q?tA/S6KC2VbJtbVC7pB0+pC9qjOvM0+PSiNfWs4TFLX2pY0eSnIOmrNcEoq/J?=
 =?us-ascii?Q?mZdB88+0bjhZq9E8Jo2hp7l1FRTZOY+b6ia+aol3+T+1bJ7Y6tRGaY+jLYfJ?=
 =?us-ascii?Q?jV5ALGy4XR0WapUfCArYwPCAHfLvXbHj3yjZDq3toDTWa9aSCeTP9KNd9cS6?=
 =?us-ascii?Q?pUxHQUu/KlpLdOAyiwBSVMtL7LxN5ryizcCIKFWjF8ZwioYWA2+ehYF5r90d?=
 =?us-ascii?Q?Zknx6Fw+bSHbJ4LTpzDDDyVAmYo6TzTQ/OaSdZ50+81XEkAhFmdCeG7hX4sT?=
 =?us-ascii?Q?mL7KTv0ghZmXqDCISds6sco9PuBUi4HlUha5udHBG56pzOpKriaw/IRSm0wn?=
 =?us-ascii?Q?iXTHV6bFTiVfja4RxnPbk4R9YpHR9lXev9DY4uwrN7ZEmcuG3hk+K2GCPkX7?=
 =?us-ascii?Q?HT/LPWjbz0imtmmRLxtpzbgbO3h0d/tDDM54J2G/slvYO8+BGIHUVQV0XqAB?=
 =?us-ascii?Q?fIaG4NtUcbrOnEs/2vzD7dkBwF1Fh9WZr2xMG2DkfJ2QtFu3mx581sXuOPoK?=
 =?us-ascii?Q?UfzUFH/jc5z2uZnWl6jbeFTCwEcS1unqGXRBdtV7hM+jrDtCu0TdDmbd17Om?=
 =?us-ascii?Q?Tm9GvZNzVjw9gTti6YnptoSkwQpbRnTH3+mlR/5tB9uAfuJZRCtXxmYIP12a?=
 =?us-ascii?Q?BnRacTghtJHqUV9eEP79cE8/L09C8LoFpeT3OHKEBmLzp7atRCmkj7bE0me9?=
 =?us-ascii?Q?py46u9hkXLX0tkGd9cFk1m6qhe5VN4GgFnzrZrzKljc8JpcfyyqdvZYKQ9Jc?=
 =?us-ascii?Q?70H7tzrXkEG4wlVk1QgtVo4OHZZg5/BjFalQ/6gJ2N1j2TEXFdy/I+9Xdyj+?=
 =?us-ascii?Q?fA/EAIfgU3w4yXSpHDQrKjyDkAemk1gt2jEsJiNt9h/jTmJ5g20lWvvtpcsK?=
 =?us-ascii?Q?QbA/kP6oqw7iq6S/hk+dXzWbKnL38F/3+dHFfgkjs+Ot2G6pkdFYZgajbp4h?=
 =?us-ascii?Q?g6NShkZeiwocySCd84N/PRB72qc6FJB9GbuJKe9yaTWkkgfr+Wc5GjOg/TTt?=
 =?us-ascii?Q?16PESBPnqi7LP0BpHgvGg8gbURcTFWBBpiOZcjMZ/cZm2r13CcCjzIPedQ4z?=
 =?us-ascii?Q?WWLuIcXJWt/2X+ZlwbvC3YnN+tJrsmZvn7dXPIyO6tqrcAMGEa0E3BXCs1t4?=
 =?us-ascii?Q?3Dr4WiS3Gh64JQiGd7usfhvCIRrRp+LwnHTLmSssl/XMyqpf8etX/Hw3Skq3?=
 =?us-ascii?Q?pl3ZFbFHx64FzXjLXyi0q1fnd8A4CBrBd2vCTrUTMKDUoW5HX0akZEcaKL42?=
 =?us-ascii?Q?XwOgwm34bh/G7TWPZVO5eFq9CRd9DB1dNJgE45uNrUrGux517c7/AR/uBVLy?=
 =?us-ascii?Q?uwH7mXVeYOLg+4IIb/g+ohhl3LelAVpxGPFfhDxZQfuoUWmc6RZCANQW7RLx?=
 =?us-ascii?Q?khw9B9J4MyX5f/NOesb9GueHQ94=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeb77e6b-bd00-477f-9d40-08d9e22d9a9c
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2358.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 07:12:54.7965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f2QNt1H1JEYlGSEvvZ1nmkjbmM/Sjhd/2pHWsgqmfRWK6H+S3tqh69w27lbAQAKEq+6IbUTpn7blSOqiPgJe2juZumCRITjRS1tGhJUnJYM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3544
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10240 signatures=669575
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 spamscore=0 bulkscore=0 mlxscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201280044
X-Proofpoint-GUID: kY_e_Hm2F-fGotLdqmb1OhqamZ6X75Il
X-Proofpoint-ORIG-GUID: kY_e_Hm2F-fGotLdqmb1OhqamZ6X75Il
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0280e3c58f92b2fe0e8fbbdf8d386449168de4a8
commit: 1b8bb94c0612cf32e418e90ae93cf37214d84669 ath11k: report tx bitrate for iw wlan station dump
config: microblaze-randconfig-m031-20220127 (https://download.01.org/0day-ci/archive/20220127/202201272110.Z8STyrTC-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/net/wireless/ath/ath11k/dp_tx.c:511 ath11k_dp_tx_update_txcompl() error: uninitialized symbol 'rate_idx'.

vim +/rate_idx +511 drivers/net/wireless/ath/ath11k/dp_tx.c

1b8bb94c0612cf Wen Gong   2021-12-20  418  void ath11k_dp_tx_update_txcompl(struct ath11k *ar, struct hal_tx_status *ts)
1b8bb94c0612cf Wen Gong   2021-12-20  419  {
1b8bb94c0612cf Wen Gong   2021-12-20  420  	struct ath11k_base *ab = ar->ab;
1b8bb94c0612cf Wen Gong   2021-12-20  421  	struct ath11k_per_peer_tx_stats *peer_stats = &ar->cached_stats;
1b8bb94c0612cf Wen Gong   2021-12-20  422  	enum hal_tx_rate_stats_pkt_type pkt_type;
1b8bb94c0612cf Wen Gong   2021-12-20  423  	enum hal_tx_rate_stats_sgi sgi;
1b8bb94c0612cf Wen Gong   2021-12-20  424  	enum hal_tx_rate_stats_bw bw;
1b8bb94c0612cf Wen Gong   2021-12-20  425  	struct ath11k_peer *peer;
1b8bb94c0612cf Wen Gong   2021-12-20  426  	struct ath11k_sta *arsta;
1b8bb94c0612cf Wen Gong   2021-12-20  427  	struct ieee80211_sta *sta;
1b8bb94c0612cf Wen Gong   2021-12-20  428  	u16 rate, ru_tones;
1b8bb94c0612cf Wen Gong   2021-12-20  429  	u8 mcs, rate_idx, ofdma;
1b8bb94c0612cf Wen Gong   2021-12-20  430  	int ret;
1b8bb94c0612cf Wen Gong   2021-12-20  431  
1b8bb94c0612cf Wen Gong   2021-12-20  432  	spin_lock_bh(&ab->base_lock);
1b8bb94c0612cf Wen Gong   2021-12-20  433  	peer = ath11k_peer_find_by_id(ab, ts->peer_id);
1b8bb94c0612cf Wen Gong   2021-12-20  434  	if (!peer || !peer->sta) {
1b8bb94c0612cf Wen Gong   2021-12-20  435  		ath11k_dbg(ab, ATH11K_DBG_DP_TX,
1b8bb94c0612cf Wen Gong   2021-12-20  436  			   "failed to find the peer by id %u\n", ts->peer_id);
1b8bb94c0612cf Wen Gong   2021-12-20  437  		goto err_out;
1b8bb94c0612cf Wen Gong   2021-12-20  438  	}
1b8bb94c0612cf Wen Gong   2021-12-20  439  
1b8bb94c0612cf Wen Gong   2021-12-20  440  	sta = peer->sta;
1b8bb94c0612cf Wen Gong   2021-12-20  441  	arsta = (struct ath11k_sta *)sta->drv_priv;
1b8bb94c0612cf Wen Gong   2021-12-20  442  
1b8bb94c0612cf Wen Gong   2021-12-20  443  	memset(&arsta->txrate, 0, sizeof(arsta->txrate));
1b8bb94c0612cf Wen Gong   2021-12-20  444  	pkt_type = FIELD_GET(HAL_TX_RATE_STATS_INFO0_PKT_TYPE,
1b8bb94c0612cf Wen Gong   2021-12-20  445  			     ts->rate_stats);
1b8bb94c0612cf Wen Gong   2021-12-20  446  	mcs = FIELD_GET(HAL_TX_RATE_STATS_INFO0_MCS,
1b8bb94c0612cf Wen Gong   2021-12-20  447  			ts->rate_stats);
1b8bb94c0612cf Wen Gong   2021-12-20  448  	sgi = FIELD_GET(HAL_TX_RATE_STATS_INFO0_SGI,
1b8bb94c0612cf Wen Gong   2021-12-20  449  			ts->rate_stats);
1b8bb94c0612cf Wen Gong   2021-12-20  450  	bw = FIELD_GET(HAL_TX_RATE_STATS_INFO0_BW, ts->rate_stats);
1b8bb94c0612cf Wen Gong   2021-12-20  451  	ru_tones = FIELD_GET(HAL_TX_RATE_STATS_INFO0_TONES_IN_RU, ts->rate_stats);
1b8bb94c0612cf Wen Gong   2021-12-20  452  	ofdma = FIELD_GET(HAL_TX_RATE_STATS_INFO0_OFDMA_TX, ts->rate_stats);
1b8bb94c0612cf Wen Gong   2021-12-20  453  
1b8bb94c0612cf Wen Gong   2021-12-20  454  	/* This is to prefer choose the real NSS value arsta->last_txrate.nss,
1b8bb94c0612cf Wen Gong   2021-12-20  455  	 * if it is invalid, then choose the NSS value while assoc.
1b8bb94c0612cf Wen Gong   2021-12-20  456  	 */
1b8bb94c0612cf Wen Gong   2021-12-20  457  	if (arsta->last_txrate.nss)
1b8bb94c0612cf Wen Gong   2021-12-20  458  		arsta->txrate.nss = arsta->last_txrate.nss;
1b8bb94c0612cf Wen Gong   2021-12-20  459  	else
1b8bb94c0612cf Wen Gong   2021-12-20  460  		arsta->txrate.nss = arsta->peer_nss;
1b8bb94c0612cf Wen Gong   2021-12-20  461  
1b8bb94c0612cf Wen Gong   2021-12-20  462  	if (pkt_type == HAL_TX_RATE_STATS_PKT_TYPE_11A ||
1b8bb94c0612cf Wen Gong   2021-12-20  463  	    pkt_type == HAL_TX_RATE_STATS_PKT_TYPE_11B) {
1b8bb94c0612cf Wen Gong   2021-12-20  464  		ret = ath11k_mac_hw_ratecode_to_legacy_rate(mcs,
1b8bb94c0612cf Wen Gong   2021-12-20  465  							    pkt_type,
1b8bb94c0612cf Wen Gong   2021-12-20  466  							    &rate_idx,
1b8bb94c0612cf Wen Gong   2021-12-20  467  							    &rate);
1b8bb94c0612cf Wen Gong   2021-12-20  468  		if (ret < 0)
1b8bb94c0612cf Wen Gong   2021-12-20  469  			goto err_out;
1b8bb94c0612cf Wen Gong   2021-12-20  470  		arsta->txrate.legacy = rate;

"rate_idx" only set on this path

1b8bb94c0612cf Wen Gong   2021-12-20  471  	} else if (pkt_type == HAL_TX_RATE_STATS_PKT_TYPE_11N) {
1b8bb94c0612cf Wen Gong   2021-12-20  472  		if (mcs > 7) {
1b8bb94c0612cf Wen Gong   2021-12-20  473  			ath11k_warn(ab, "Invalid HT mcs index %d\n", mcs);
1b8bb94c0612cf Wen Gong   2021-12-20  474  			goto err_out;
1b8bb94c0612cf Wen Gong   2021-12-20  475  		}
1b8bb94c0612cf Wen Gong   2021-12-20  476  
1b8bb94c0612cf Wen Gong   2021-12-20  477  		if (arsta->txrate.nss != 0)
1b8bb94c0612cf Wen Gong   2021-12-20  478  			arsta->txrate.mcs = mcs + 8 * (arsta->txrate.nss - 1);
1b8bb94c0612cf Wen Gong   2021-12-20  479  		arsta->txrate.flags = RATE_INFO_FLAGS_MCS;
1b8bb94c0612cf Wen Gong   2021-12-20  480  		if (sgi)
1b8bb94c0612cf Wen Gong   2021-12-20  481  			arsta->txrate.flags |= RATE_INFO_FLAGS_SHORT_GI;
1b8bb94c0612cf Wen Gong   2021-12-20  482  	} else if (pkt_type == HAL_TX_RATE_STATS_PKT_TYPE_11AC) {
1b8bb94c0612cf Wen Gong   2021-12-20  483  		if (mcs > 9) {
1b8bb94c0612cf Wen Gong   2021-12-20  484  			ath11k_warn(ab, "Invalid VHT mcs index %d\n", mcs);
1b8bb94c0612cf Wen Gong   2021-12-20  485  			goto err_out;
1b8bb94c0612cf Wen Gong   2021-12-20  486  		}
1b8bb94c0612cf Wen Gong   2021-12-20  487  
1b8bb94c0612cf Wen Gong   2021-12-20  488  		arsta->txrate.mcs = mcs;
1b8bb94c0612cf Wen Gong   2021-12-20  489  		arsta->txrate.flags = RATE_INFO_FLAGS_VHT_MCS;
1b8bb94c0612cf Wen Gong   2021-12-20  490  		if (sgi)
1b8bb94c0612cf Wen Gong   2021-12-20  491  			arsta->txrate.flags |= RATE_INFO_FLAGS_SHORT_GI;
1b8bb94c0612cf Wen Gong   2021-12-20  492  	} else if (pkt_type == HAL_TX_RATE_STATS_PKT_TYPE_11AX) {
1b8bb94c0612cf Wen Gong   2021-12-20  493  		if (mcs > 11) {
1b8bb94c0612cf Wen Gong   2021-12-20  494  			ath11k_warn(ab, "Invalid HE mcs index %d\n", mcs);
1b8bb94c0612cf Wen Gong   2021-12-20  495  			goto err_out;
1b8bb94c0612cf Wen Gong   2021-12-20  496  		}
1b8bb94c0612cf Wen Gong   2021-12-20  497  
1b8bb94c0612cf Wen Gong   2021-12-20  498  		arsta->txrate.mcs = mcs;
1b8bb94c0612cf Wen Gong   2021-12-20  499  		arsta->txrate.flags = RATE_INFO_FLAGS_HE_MCS;
1b8bb94c0612cf Wen Gong   2021-12-20  500  		arsta->txrate.he_gi = ath11k_mac_he_gi_to_nl80211_he_gi(sgi);
1b8bb94c0612cf Wen Gong   2021-12-20  501  	}
1b8bb94c0612cf Wen Gong   2021-12-20  502  
1b8bb94c0612cf Wen Gong   2021-12-20  503  	arsta->txrate.bw = ath11k_mac_bw_to_mac80211_bw(bw);
1b8bb94c0612cf Wen Gong   2021-12-20  504  	if (ofdma && pkt_type == HAL_TX_RATE_STATS_PKT_TYPE_11AX) {
1b8bb94c0612cf Wen Gong   2021-12-20  505  		arsta->txrate.bw = RATE_INFO_BW_HE_RU;
1b8bb94c0612cf Wen Gong   2021-12-20  506  		arsta->txrate.he_ru_alloc =
1b8bb94c0612cf Wen Gong   2021-12-20  507  			ath11k_mac_he_ru_tones_to_nl80211_he_ru_alloc(ru_tones);
1b8bb94c0612cf Wen Gong   2021-12-20  508  	}
1b8bb94c0612cf Wen Gong   2021-12-20  509  
1b8bb94c0612cf Wen Gong   2021-12-20  510  	if (ath11k_debugfs_is_extd_tx_stats_enabled(ar))
1b8bb94c0612cf Wen Gong   2021-12-20 @511  		ath11k_debugfs_sta_add_tx_stats(arsta, peer_stats, rate_idx);
                                                                                                           ^^^^^^^^
Used here

1b8bb94c0612cf Wen Gong   2021-12-20  512  
1b8bb94c0612cf Wen Gong   2021-12-20  513  err_out:
1b8bb94c0612cf Wen Gong   2021-12-20  514  	spin_unlock_bh(&ab->base_lock);
1b8bb94c0612cf Wen Gong   2021-12-20  515  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

