Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F83F511A9A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237928AbiD0OcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 10:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237766AbiD0OcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 10:32:16 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE2615FCD
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 07:29:04 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23RCh5mu011361;
        Wed, 27 Apr 2022 14:28:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=gKBPQ2huTXDZ9OjS5VXFAimS886SpoadIylJxHoaC6s=;
 b=JqNfktv2/QERzZGQpsLI5K4kA1zqU0Zyz50K1VqIUdzjbE9MpTs3ZUm2OEp64zIhA9OQ
 XAgacGdELMtAAuKw92UDeC+N660y72tcMjVb8B4c/tyreZ0x88XIFrHpgVdUzhADEVvS
 OdqG6ym9JBZeBM7iHtqWWY+jjdZAtePyJmJySJB7ojjIVJ0rYfyTDlN74iVxyr+DKg2K
 euJdFaXaUaKYOUpHpmVhbqNEZ6HCgG3ngGZTKT9Ae0VD18Pg0CcviqoDYseQnUbeIPN7
 KsKcxijI2sGfzL9e86X0bs8CQv23E1TMAi+FaMtfcnpwombjk9w5vEE5ODshiX5FDI25 UA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmaw4h8s1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Apr 2022 14:28:58 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23REAcUZ000924;
        Wed, 27 Apr 2022 14:28:57 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fp5ym0dtk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Apr 2022 14:28:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cQsxoATFCqw4MAUArEjsUi2Z5NAh9cGFFHaamiT07hjOvl4Z4qHuv68fr79Vvr0AsTcxP5nHSiC0aO/UHnEzqdAvb93C7FwT5dV8AQQpTPKEEGZRJWJ9rSd3zY0unl/aKtpyuj+BaqJ2XwsY7InK8s/Wt6ni+SZ4mdpw60qhuMWeTEYado3YhxXYT/Wq3A0xvWbkI3zMG7l825QF+0HDJBmbAZ6sRpvQFqmw/ztYtsecGONrmqIeo1Vp0l4OWD8T9hrfQAsFYtWPtC4Fhz2qTayJq77cekd48S1A01eBZnAcy1vCjH40qEAwRFTH6gufU2b4mWyJuKRlW6qzaBeesg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gKBPQ2huTXDZ9OjS5VXFAimS886SpoadIylJxHoaC6s=;
 b=ES6Fi42FZE3siMraXpYLocZb8CbuWVQ5ZW0StFnQUw9Nb/Akuf1WpG257lNW+qqImwh6pKWDpM4cZ8kdTP1CaOX3uwtVHgiC8AaKvUFwrnsu29ZW5jJX/oZsd4n31YlTmHhe1SdRsJybUyknawzlNjAcXPpaiN3NTO2fbcfYaf/BQO38mUlzppaJeGUKZJ/kzRaU1tyrOcP8Va3oW+S8LHqmJGJmH1MggIARlQImQvzNCbgBOg3uxUIlY6diqdeR9IpX4e7TdbRS4CtVd4NN+H5ORTSuZQFmZrymqNpmONJBN/ldo8yf+BFBUqKpK4k0D+2YUhSyFvcZQjuoNtZpEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gKBPQ2huTXDZ9OjS5VXFAimS886SpoadIylJxHoaC6s=;
 b=q4nCb+KX1IAdJ3tBshn1PifmeRmdrDryWdMEQFAVTxOYv6Iy8pZYV2nji4X2c9TXTTyMlBvJYbpRaJY5yX/OjsK40PHIJx2lGRSwOz2tEb6ua5WYEbWyYyZnDThzvahn7zpQ6UQQvcONbukHJ1yzLDnxPaV8meZVj842IU5cL50=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN7PR10MB2579.namprd10.prod.outlook.com
 (2603:10b6:406:c7::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Wed, 27 Apr
 2022 14:28:54 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5164.025; Wed, 27 Apr 2022
 14:28:54 +0000
Date:   Wed, 27 Apr 2022 17:28:39 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     "kbuild@lists.01.org" <kbuild@lists.01.org>,
        "lkp@intel.com" <lkp@intel.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: net/dsa/tag_sja1105.c:432 sja1105_rcv() error: uninitialized
 symbol 'vid'.
Message-ID: <20220427142839.GK2090@kadam>
References: <202204270649.Eun9P40C-lkp@intel.com>
 <20220427135128.la6ifcrs2nmnx4ro@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427135128.la6ifcrs2nmnx4ro@skbuf>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0035.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::19)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 933958d4-52c4-47b2-ac04-08da285a41cf
X-MS-TrafficTypeDiagnostic: BN7PR10MB2579:EE_
X-Microsoft-Antispam-PRVS: <BN7PR10MB25798537CE62F5A117182DB78EFA9@BN7PR10MB2579.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mQdZvm/UZg0RSwKhhkoNyJhHhrSJ+5O31B4n3Wzb5s698Phc1lp7Bmv18gUdDd6uFzfWMqsJ0gsj3Lo+aE+a7v+OgRexs/rFVaH9OO+UmIbxaLVcpjicOKTgsQcjaHON8IV5PmMyA4OjB3FEay6GZ+bduanx1aq3zUSJdD/lPqhpfUIgN8ytdepKBrGYzVwCqD0djmLEDhXyxoelWK64RHcx6ZGGsKf1eks4LnCEnmoqObSbxFxQUWdZk7Vlhmb9IzJu1iccqZ8KoPsE41mlr8P+4q5Mk/evzFeqXHGxjAO3MUfvb/7jrrAnSejDAFprfJDcJowC7qiwX79EKSUHglRog8eTDoUJi/+ySF3WQHj9bEK1dEVshT7BD4CZBOAfx0eH6EjJsbw1sdTYZGjFkwicIoLFhmujPUmThuMgM6pBiAo7feoSks1zl/xnY15inp6JxFh6GmUW+MCDzNhN5ujlR4Di4gXeHEDljp6fwjkO6RMD0CguK6n94RsfLPxpRUGiOeHelVmgzt43REGrpVUuhEFODpDd4zXURtS7MXj6CwM2qaCj0yBjj2dNQki4I0sF1HsRFBXc+ZlbnAkS+VQENj1/SJuPc4f6x5YLdbWXNYpuJf5iflxAfxEtDLAFxGYAWXSr2tBXH89/bYR4IpxVQ7aM+43qjCnAz+nzRRk+T9ObZDEqis/M1d9xqwlePQagOOfm/A96xevdTJBc16niEbvoZbvHyQ9Chzpdy7n9fgeyzlYBdhtKebXP8v7Nf3QT8LG8g705TeQOmZwyJ94BLsnOgB0iVGNrT1TcOwbUemjzGn9vOJ2+zN2eMwKCubUWp57OCclTJhaiQORhVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(8676002)(66476007)(66946007)(33716001)(66556008)(6506007)(2906002)(4326008)(6666004)(86362001)(5660300002)(38100700002)(38350700002)(9686003)(44832011)(8936002)(508600001)(33656002)(6512007)(26005)(966005)(6486002)(83380400001)(6916009)(54906003)(52116002)(316002)(1076003)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CElWpqX+PErbC7Ctz5DIaLqnTxPIMJ3vXVEszNLZK5ADDE9m6XsMSlQXxbY3?=
 =?us-ascii?Q?3jyvvo/FyzgUad6lvW9VraeHZilsR7XfQ43qDQZuFAlhXLklx2wUyTqQhyuh?=
 =?us-ascii?Q?pZvIBWe8yG2FpHeWSelg/v7JEdF6VXs0DoF+tPAgwipQ81W/RxC/QiBByUaT?=
 =?us-ascii?Q?De+EhBhTpfpYZgm/yGFKV1TAWRtCpluGoI2HCU9qAeZgHWRs8QY9kIBBdWHP?=
 =?us-ascii?Q?ULXnkH93AXaMFYH89smM2ISRsqgKixnQFMmbYwnMUl9IeG+uTn7vCv9BWDLJ?=
 =?us-ascii?Q?7kO2RO1uyKXpOX/48Q5MgFOhFK9SzHcKsBgfvI3cU4JeeMvwHncMOa4MHYpt?=
 =?us-ascii?Q?+KnHERM+29uU2xvu0XXNp5OkwvWhATyGDITojv2N+0EUi+OCF1y3IVt1Znwm?=
 =?us-ascii?Q?xBnYKrAFLvZRGtrQ56rnyq3mCSkHNYG+cgYgE8eUsC+/Y6O+kyb+fxEEFDFq?=
 =?us-ascii?Q?Kdxak08jBdmyhLt3mO6CBQbg/QrtErh51g8emhjPKhLTsYNlN+bSuEorwHsW?=
 =?us-ascii?Q?Bq09NQhDxgXsTSW33jlgn+DfK5uNUDtd6xkWXqWFVcDQsquePTYbU9qm8p1c?=
 =?us-ascii?Q?fwsGA1KLJzpAeNxRpC2aenOkVjBCwNyRwil1G5HELDKmZ7F8XEasQT5mBE9M?=
 =?us-ascii?Q?W2t/5zdcrkXL85PYh/LR2m5qznYdmIkE6xaP+r/Xd8WKAXdsbg3U/6CzULYL?=
 =?us-ascii?Q?ujBT5jk9YQq39q1edWuo73IQpbpjVohoQjU/J7ou6gYb2gNZEP+J6n9WQl16?=
 =?us-ascii?Q?p+x+y3K05qd9G0dikWJow15F/D/8K9KJoWRCBENVueGaH7PtNeU2Ctro00RI?=
 =?us-ascii?Q?FrQySoX3jC8tMEStyZL8cqUlt3xNzNsi5Gd+3OCQH3FBcWt/nqzsAMlFHXI8?=
 =?us-ascii?Q?0TcK3XRJasfio7PivXri1pwaFbDERL/bYy+OyULozpkWF9rdOD4L7HX0+8rW?=
 =?us-ascii?Q?yxsqGSUR3htdks4npn+fxzCX/Di8V5x5yY2c104vnJwwJtKSgjHfmFHZNRlA?=
 =?us-ascii?Q?Hsp2WG9VAHNEXEphnE01cYIwTvxPVVDQDSnEMP7QrlWGzdBjgckKNIjCEmua?=
 =?us-ascii?Q?drf6jZLN9DC3jNK51U1ypWKioE52yGIL3I1SlEd7mHogtF7Zw1wb9dOV6gA5?=
 =?us-ascii?Q?dSn1TAkKQ8+ENL/QuE502dXOUwascMESxcZ2y2xZTtfF8qnBozb1mub0y//M?=
 =?us-ascii?Q?YGaEoz5UuOpDi5KqjS5w317wfrMfg+6jcacMQibHHezCc1Du6Uvy4vPA0wyI?=
 =?us-ascii?Q?JUEh4QBkqGQrwSDa04Gy0snCPdoGTOffXPXVOR9CcICvsY/VlC7xdTyvkEB4?=
 =?us-ascii?Q?yFje3KPpF4JnYl+AaMM1eovMk2uPVcAiMhhmG1zmO2kL6wQ8p278CkTJE7TN?=
 =?us-ascii?Q?nI1urHenLTjVyTmCRAL04Hh4g8de4XixzLIVGh1/jfGfBUaMd+FPwio5esBF?=
 =?us-ascii?Q?oI58NKYFjea2BGKkl0YgoncPV54yvWW7rWCWpwkHTBxsbyZ8jKumYhgJkqE6?=
 =?us-ascii?Q?TxiJNVa+eFgMYe883LgWvs2tiV+bzaVBIyNo+d+hTTOrHXoyWkpZLAuhZa/t?=
 =?us-ascii?Q?XV2HK968ZNDWiNL5XQaHKo2nDf8BMNL+T9pO4dHgC4pKAjzeq3EQleBQLOrg?=
 =?us-ascii?Q?GP/hGVzzw8Y/XxNhFf9OhUBurhvoP0wq5Wh30mMVV3uch6IuA8GtAFYaylIO?=
 =?us-ascii?Q?fTDQ7uzcyVb39j+t9wRLfnBRlfLp+00lAjEmT+I7NxdC+h/E+ifNpJ/7+/Tf?=
 =?us-ascii?Q?1cDx7+Ef1S1TMwdTZNh8fjwIrp8XOFI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 933958d4-52c4-47b2-ac04-08da285a41cf
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 14:28:54.7017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dVyhBIeA9c+RDhHZwEVm7g3T+8GciaHgB3rPZS2ccsx/IQCU/IVZGZKSM/1bEReRsC8YOQ0wqEJJ/O9HqYj9k6BwIz8FXp2bwPa8bEfc0Kw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR10MB2579
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-27_04:2022-04-27,2022-04-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204270091
X-Proofpoint-GUID: yYSnQEajG0FtPyZekQP9OXFL1j3uTk8U
X-Proofpoint-ORIG-GUID: yYSnQEajG0FtPyZekQP9OXFL1j3uTk8U
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 01:51:28PM +0000, Vladimir Oltean wrote:
> On Wed, Apr 27, 2022 at 10:13:30AM +0300, Dan Carpenter wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master
> > head:   cf424ef014ac30b0da27125dd1fbdf10b0d3a520
> > commit: 04a1758348a87eb73b8a4554d0c227831e2bb33e net: dsa: tag_sja1105: fix control packets on SJA1110 being received on an imprecise port
> > config: openrisc-randconfig-m031-20220425 (https://download.01.org/0day-ci/archive/20220427/202204270649.Eun9P40C-lkp@intel.com/config )
> > compiler: or1k-linux-gcc (GCC) 11.2.0
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > 
> > New smatch warnings:
> > net/dsa/tag_sja1105.c:432 sja1105_rcv() error: uninitialized symbol 'vid'.
> > 
> > Old smatch warnings:
> > net/dsa/tag_sja1105.c:564 sja1110_rcv() error: uninitialized symbol 'vid'.
> > 
> > vim +/vid +432 net/dsa/tag_sja1105.c
> > 
> > 227d07a07ef1262 Vladimir Oltean 2019-05-05  393  static struct sk_buff *sja1105_rcv(struct sk_buff *skb,
> > 227d07a07ef1262 Vladimir Oltean 2019-05-05  394  				   struct net_device *netdev,
> > 227d07a07ef1262 Vladimir Oltean 2019-05-05  395  				   struct packet_type *pt)
> > 227d07a07ef1262 Vladimir Oltean 2019-05-05  396  {
> > 884be12f85666c6 Vladimir Oltean 2021-07-26  397  	int source_port = -1, switch_id = -1;
> > e53e18a6fe4d3ae Vladimir Oltean 2019-06-08  398  	struct sja1105_meta meta = {0};
> > e80f40cbe4dd513 Vladimir Oltean 2020-03-24  399  	struct ethhdr *hdr;
> > 42824463d38d273 Vladimir Oltean 2019-06-08  400  	bool is_link_local;
> > e53e18a6fe4d3ae Vladimir Oltean 2019-06-08  401  	bool is_meta;
> > 884be12f85666c6 Vladimir Oltean 2021-07-26  402  	u16 vid;
> > 227d07a07ef1262 Vladimir Oltean 2019-05-05  403  
> > e80f40cbe4dd513 Vladimir Oltean 2020-03-24  404  	hdr = eth_hdr(skb);
> > 42824463d38d273 Vladimir Oltean 2019-06-08  405  	is_link_local = sja1105_is_link_local(skb);
> > e53e18a6fe4d3ae Vladimir Oltean 2019-06-08  406  	is_meta = sja1105_is_meta_frame(skb);
> > 227d07a07ef1262 Vladimir Oltean 2019-05-05  407  
> > 227d07a07ef1262 Vladimir Oltean 2019-05-05  408  	skb->offload_fwd_mark = 1;
> > 227d07a07ef1262 Vladimir Oltean 2019-05-05  409  
> > 233697b3b3f60b1 Vladimir Oltean 2021-06-11  410  	if (sja1105_skb_has_tag_8021q(skb)) {
> > 42824463d38d273 Vladimir Oltean 2019-06-08  411  		/* Normal traffic path. */
> > 04a1758348a87eb Vladimir Oltean 2021-07-29  412  		sja1105_vlan_rcv(skb, &source_port, &switch_id, &vid);
> > 
> > There is a return where *vid is not set
> 
> And also one where source_port and switch_id are left with their default
> values of -1.
> 

I should probably have wondered why I hadn't emailed you before...  For
some reason I got confused and thought it was an arch/ thing...

My desktop build does cross function analysis so it doesn't print this
false positive.

regards,
dan carpenter

