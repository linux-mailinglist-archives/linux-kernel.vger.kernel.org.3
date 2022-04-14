Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E1A500B3B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 12:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242366AbiDNKiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 06:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242355AbiDNKiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 06:38:06 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE62972449
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 03:35:41 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23E9odad018804;
        Thu, 14 Apr 2022 10:35:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=Dwx8pCjGln0HoG6Bvh8D7IhTjDyqIArZI7ngGcQ85TM=;
 b=BJIQSJidUq0v8nBXhrhlyp3mVJcLJpl8ZWw/BGUrv5qKP+7P+ZFWaF6emcTBnYd84JdX
 xaBvaeivH/nrQBEWffG0M7l0HYtp7YS9sHYEtVyLtd21NFMGqAyBCFyLSBBvGeFnbdXY
 ltZ+5VqkfIgeuQH2KzqcRAXYclhU7Y+FpLonuSF7PXYZnnsh8UQZAR4zBWY+eVazGqLY
 RKttYkJ9QLkQ37EeWgd5yIRx7RLTf3ocGkdpas+c8uEsE6lr0lfnsR3wizz+zaZhbIX3
 VBrnSZO8TfiM2ywMx3vsW7mxm0KBJJSes0IpDFeyfRbLGVBlc95VLQebMOkEZE3y2Jho Ww== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb0r1mg87-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 10:35:26 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23EAHVLN012215;
        Thu, 14 Apr 2022 10:35:25 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fb0k59ynd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 10:35:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XTSqvqW94ki4hV1nUmw6YA77nUirlp+TLwjEN6djL/Po/gJ7pPnj/36kLp27H6MCILaQfLe5qUNI9g6Uwidw5CPm4rgaSKTWAraW63miJ688BdlDsJaqKt2Rhv4+BlaoWT2iIyc1V8BsBkbghyBexwiDldI08pwvywgVPh2lkC6HLFwfeY+au1jxmL7f3waVvg4zxRSr3uL1G7cmS5tfFZwcUNTZpQy4wVavCEh8ikj+Uz2QqV8tprMoC9U3GeMxq7iCiZs5vHKOtfAsB6LRKtDWoueVzUzewA2Ev0WMXsQVoIVz7JWwkJtJHjMFU6D9Kf6K9GGxPmMtyRnU1WCExQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dwx8pCjGln0HoG6Bvh8D7IhTjDyqIArZI7ngGcQ85TM=;
 b=abWjfgbdPfwi5/f3DI5Lm4ogs04mLPlw9MJNYPsmTo7uprh3jgiM5phLqmlcbTZYxiF4lLlOfxnVF3ZhpBG2AiLrQLtAmF/GTpIrpa5W+KPPyNXGEDZWVI5fBwjLGK1llU0FHy10yaG4BeYgRZbG6RzoqVk8RpINfgK2jWmsQ7tgDo69SrIMxX/dwbV1e192a+DlDIkPAuhTzJbu89du3By/1RvfwNj/PIyOJIOS3CFWIrlmMaxsPgbSgXcT4q+tuBGChCbqu5BFY4npgyR2FyG4dRz/Q3nqh2hsUL/kmov/8MShYeZeqlvrrVPw9Xk6/ZYvWV+eEHuz56iabbLYyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dwx8pCjGln0HoG6Bvh8D7IhTjDyqIArZI7ngGcQ85TM=;
 b=geK2uIr9vHsm08to8nK284Jf8o/3W7v4NB+MOyR/8lIqYTvtqQuGSKnHrNsm0myQLxm/Ds4g+j+dHyOcZmoRMoQDFrWHhHWZoVA6SSQZYPhiae+Ex8Wsm3lYKIkk2GpcPP5GXua2yrMUg1krG9MI26vpJx7XIbLu6lPPPJQSlxI=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN6PR10MB1441.namprd10.prod.outlook.com
 (2603:10b6:404:43::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Thu, 14 Apr
 2022 10:35:23 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5144.022; Thu, 14 Apr 2022
 10:35:23 +0000
Date:   Thu, 14 Apr 2022 13:35:11 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Menglong Dong <imagedong@tencent.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Jiang Biao <benbjiang@tencent.com>,
        Hao Peng <flyingpeng@tencent.com>
Subject: [saeed:net-next 243/261] net/ipv6/ip6_input.c:169 ip6_rcv_core()
 error: we previously assumed 'idev' could be null (see line 167)
Message-ID: <202204140552.DxfWehz6-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0013.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:1::25) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78ed03c3-d589-4504-6407-08da1e027af3
X-MS-TrafficTypeDiagnostic: BN6PR10MB1441:EE_
X-Microsoft-Antispam-PRVS: <BN6PR10MB1441A3BCE5DA0932E2AAB5E08EEF9@BN6PR10MB1441.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c7YzzOfaCzdoDmj6JU8NuoKZA3pmTky1FM9OhY5FyKapNXwQ5gLInxQKPIB2hvXqD/PqGmtKb9/nmYAskL8n+aXRWvFeSe4jh3CTkOTD2G8dyyaFoful2ML4BF1PsXrBndXyUGKlzTQy/6u55ZD0Ke2Uf5rx7JX0No9WR7Z6233co6dn+FxDol0SodAZGSiBgC8wTW0JGaZWW00o/qPhODXp2HbKMNob/te5n2BoMndC0MBywfoUF9PBnXO7XPHs78GQx6bTu1QmepEc11ZF3+Scj3vyVmopOYsflwwSEEsq+U2N8SpH8MZD0GLXkAm70Cx8lw3+vAeLrQH8Uo6fmW9SeF/FeUxg79eNXpf65AqYc39kp7eUMTqkbs9kd7mWailp3oczaTrTLSIUJkHbq1V6b9oCKcE0ES1PjjPpLhCZr+JWLtIYz2KW+BSZ+kVhk4fTHm8SopDg9nKeZnKzg4v1IUtJ4U02cujXHBBBcQXfrHSJJw+BIl19VfjWqTo6+d5Y/m2ghpyMtcXgZN2+m6hcDNxzQfr9OviaocFekYlMi6CdgHcrLKBwo7ihEGx78kLxf7CnS5FFoUakrnixop1qUxlR6Fy7FW/x6zXdJXkP8vD2mzZFAMD0uh7EN/QPUZOt9lGQd8oetZpsd7Njn4Cc4tLXh1p5/oR9wpY9m0KdOi2n6u2bihb+iGYSurWXpv7i3+BtQOZCutkV+PbgkLdDME/MlwSagZu4hOdpOmky51S885NxKp6N4ZtSUmzunZ44MfoAc4TjGzLZNsmnbYt+1ncSrq31Jx+TeZ2MRpXloC/N13oJVco46b9sM9O+yKk4ibDuqqEE0Cdy2cTyPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(6506007)(186003)(36756003)(2906002)(26005)(83380400001)(1076003)(8936002)(6666004)(52116002)(6512007)(9686003)(44832011)(66556008)(38100700002)(8676002)(38350700002)(66946007)(66476007)(4326008)(316002)(86362001)(54906003)(6916009)(508600001)(966005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mQuY8tG4vLGAzDCx9LKbonku8Pb/l86ZMJhFlqZLAPpgggq484hmjCvvf2rA?=
 =?us-ascii?Q?CPVAWL40MfDMzv5qSvQoQvCWGbfGwZ/3Trz01/aMXnIFx6gffNA+2OmOPnbC?=
 =?us-ascii?Q?3k4IHZrUzeUSBP8mzRW0lvA+FukP8V5Vy6ztemKSSI6fg5ZcLlOQZK0JtDva?=
 =?us-ascii?Q?ZMmG3d0XpZSLIof0yjMGfc5JrBHEywUAVSzV6b6QKYxmaVe6+0UdJbZ9s2oM?=
 =?us-ascii?Q?nUFCdiQDv743EfT1Jfbrf2i6/WFZi5fElzmx5FyNBDh1cpFX0CnVfrByR92t?=
 =?us-ascii?Q?E1M7jWCq4Dm4poujTjqRiI+xaKYmMS5Zu6xh5ca06AQkLHip+8o0FUWVOTXK?=
 =?us-ascii?Q?e6NIyJ2QS39S+339kxzLhdH7alDvPkexeIVHFcfxGw33dlKDJvHv7Nt58EPe?=
 =?us-ascii?Q?NF3XpqNcEjUR3ZT94zsZbIIUy+0nc7p3aLY2sbsHGX29BCMoAeFgc2ms5in8?=
 =?us-ascii?Q?TCJJPyuEdNjFK4xk8eEzPih3pS8Ml2hJG6cPJlLz5ppHUlk/oFusX3Kdo71/?=
 =?us-ascii?Q?hYo3C+teZOakADP2TDnT54DsP+6sncLB+F7DP6wYfm9id52QpLjA90N4T5lI?=
 =?us-ascii?Q?FJ7yTBB4Zj7GdpvDSdeGiiiUaXRk4HTruQTHGrCrqmHJjYbpxoUFlkyk2A8r?=
 =?us-ascii?Q?TiysexjQ35VKWedi8NIxJOxPBvC/uvXLabKi5us7hTwOGv6dT1nyS9o1xkCD?=
 =?us-ascii?Q?Wol3uPn25YTPpc2EY0CCIXA6htBg0U5BhS7HmIKtDFdghJW8rphtUS9WwixP?=
 =?us-ascii?Q?n8MUr+VIFj9bDNb/TEVQ7VZL/sHDVXYrTtJnB9RlNEa/TAT1QQZ/RAf+s5vb?=
 =?us-ascii?Q?1zHVR+rRyYjaKN83pVImPy4u1nB8nnGmyNaI9vcBsxqYqwQxiNsQiq9CX+8V?=
 =?us-ascii?Q?UrUUBF60yzcibUGZE6SNoMmRzuKA/0NvPY60vnjif4YIr92naIsm79RoPvRT?=
 =?us-ascii?Q?nv7PtS/ofE6pWc+8CwSkRkrZQtsgSmsgoLzqVSZE6+AVGRdGkXbNYHSoaZCg?=
 =?us-ascii?Q?OGpwJuWBMOe/FoPXvEl6RGMEVE+q5hPoSIIB/KI4SvIBlmQKH0zvxktIzszB?=
 =?us-ascii?Q?Iqc4C/6plmoPUyKBKmFhu+BzmqzM4kZ1hN7nZ2tCeqsiyQx9LvhT/yuGH7uB?=
 =?us-ascii?Q?pQUyNHa/3ujHBZd7rKacQdmSRu7SayLJOtqh5IEX52sQ3g+xvYtmNZZJjYJU?=
 =?us-ascii?Q?Xk8DnfEjKCQM1SLy3gc8QjzrAlXR9LwlGenUwpToC7iST9BVUClqA8ccEvfe?=
 =?us-ascii?Q?LNCRo712ZEq3Fw7jLaPk2USpEGZfuTRLULEgYAzc7+qRL5DtmjZXRHoIJAbP?=
 =?us-ascii?Q?NLsNMumIia3H3MS/qSOY3S0ORyVFsOZiaRjFEbPl5TQyNf5X/DWa8k9cDab6?=
 =?us-ascii?Q?aKDT1xKDW4lR3kT6/ZoWe4AO+rci7rCaRW5eWaNJ1uqL/QBLxgO6NuropkKa?=
 =?us-ascii?Q?ugaHnACZrHCetKDe+TPQBV9KRX3KG8DT6tnO2vYL/QVsG5iveNvglNoIiudl?=
 =?us-ascii?Q?KuuAoK31A7vsNkp7RsdPLHI/lIYEvLlpxemHNThpBYetd7IBZrUw93WUIFj2?=
 =?us-ascii?Q?Iz09DIeWqA/soosX/M99zvUSzOQD+uJf7iRsIlF3Rz2lcBsxUb9UdFp/+OHV?=
 =?us-ascii?Q?qB65VXwAmU2cy7gigDibqgGfQDo8jGITjpcWDnD1Mw8bw7dT4uQxCbta4sau?=
 =?us-ascii?Q?Pqz7s+H2Yi7sM3BumegXrNqKhMirj8PVxdpPSaI5xaCnQQxg3Ngb7myJtkZj?=
 =?us-ascii?Q?aq5Qjypcm45kk0Et92zCm4YUqoxjrzc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78ed03c3-d589-4504-6407-08da1e027af3
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 10:35:23.0697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J6C0DG1VDDB19v54KNjjSIvpTL2rcb3ITvp4YqsAVWSaqjkxCKzQvjwMUnCrdZ4UAvikbm73K5qnYzD7ksqnyJxKlTkiObs0GV+Ll224pqU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1441
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-14_02:2022-04-14,2022-04-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204140056
X-Proofpoint-GUID: dTjl8QUeJBcIHgrI0OXyOW87f2htIyYT
X-Proofpoint-ORIG-GUID: dTjl8QUeJBcIHgrI0OXyOW87f2htIyYT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git net-next
head:   8ac2beba64a8c9072480094c86b9eab8b6cebd99
commit: 4daf841a2ef3b2e987894c8107d309ce2b67c202 [243/261] net: ipv6: add skb drop reasons to ip6_rcv_core()
config: i386-randconfig-m021 (https://download.01.org/0day-ci/archive/20220414/202204140552.DxfWehz6-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
net/ipv6/ip6_input.c:169 ip6_rcv_core() error: we previously assumed 'idev' could be null (see line 167)

vim +/idev +169 net/ipv6/ip6_input.c

d8269e2cbf908f Edward Cree              2018-07-05  145  static struct sk_buff *ip6_rcv_core(struct sk_buff *skb, struct net_device *dev,
d8269e2cbf908f Edward Cree              2018-07-05  146  				    struct net *net)
^1da177e4c3f41 Linus Torvalds           2005-04-16  147  {
4daf841a2ef3b2 Menglong Dong            2022-04-13  148  	enum skb_drop_reason reason;
b71d1d426d263b Eric Dumazet             2011-04-22  149  	const struct ipv6hdr *hdr;
^1da177e4c3f41 Linus Torvalds           2005-04-16  150  	u32 pkt_len;
a11d206d0f88e0 YOSHIFUJI Hideaki        2006-11-04  151  	struct inet6_dev *idev;
^1da177e4c3f41 Linus Torvalds           2005-04-16  152  
a11d206d0f88e0 YOSHIFUJI Hideaki        2006-11-04  153  	if (skb->pkt_type == PACKET_OTHERHOST) {
794c24e9921f32 Jeffrey Ji               2022-04-06  154  		dev_core_stats_rx_otherhost_dropped_inc(skb->dev);
4daf841a2ef3b2 Menglong Dong            2022-04-13  155  		kfree_skb_reason(skb, SKB_DROP_REASON_OTHERHOST);
d8269e2cbf908f Edward Cree              2018-07-05  156  		return NULL;
a11d206d0f88e0 YOSHIFUJI Hideaki        2006-11-04  157  	}
a11d206d0f88e0 YOSHIFUJI Hideaki        2006-11-04  158  
a11d206d0f88e0 YOSHIFUJI Hideaki        2006-11-04  159  	rcu_read_lock();
^1da177e4c3f41 Linus Torvalds           2005-04-16  160  
a11d206d0f88e0 YOSHIFUJI Hideaki        2006-11-04  161  	idev = __in6_dev_get(skb->dev);
a11d206d0f88e0 YOSHIFUJI Hideaki        2006-11-04  162  
c2005eb01044e8 Eric Dumazet             2016-04-27  163  	__IP6_UPD_PO_STATS(net, idev, IPSTATS_MIB_IN, skb->len);
^1da177e4c3f41 Linus Torvalds           2005-04-16  164  
4daf841a2ef3b2 Menglong Dong            2022-04-13  165  	SKB_DR_SET(reason, NOT_SPECIFIED);
778d80be526995 YOSHIFUJI Hideaki        2008-06-28  166  	if ((skb = skb_share_check(skb, GFP_ATOMIC)) == NULL ||
778d80be526995 YOSHIFUJI Hideaki        2008-06-28 @167  	    !idev || unlikely(idev->cnf.disable_ipv6)) {
                                                                    ^^^^^
Check for NULL

1d0155035918aa Eric Dumazet             2016-04-27  168  		__IP6_INC_STATS(net, idev, IPSTATS_MIB_INDISCARDS);
4daf841a2ef3b2 Menglong Dong            2022-04-13 @169  		if (unlikely(idev->cnf.disable_ipv6))
                                                                                     ^^^^^^
Patch adds unchecked dereference.

4daf841a2ef3b2 Menglong Dong            2022-04-13  170  			SKB_DR_SET(reason, IPV6DISABLED);
71f6f6dfdf7c7a Jesper Nilsson           2009-03-27  171  		goto drop;
^1da177e4c3f41 Linus Torvalds           2005-04-16  172  	}
^1da177e4c3f41 Linus Torvalds           2005-04-16  173  
6b7fdc3ae18a05 Guillaume Chazarain      2006-07-24  174  	memset(IP6CB(skb), 0, sizeof(struct inet6_skb_parm));
6b7fdc3ae18a05 Guillaume Chazarain      2006-07-24  175  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

