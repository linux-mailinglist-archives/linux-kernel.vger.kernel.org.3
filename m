Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3BC3590E9A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 12:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237994AbiHLKDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 06:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbiHLKDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 06:03:03 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A37A5C77;
        Fri, 12 Aug 2022 03:03:02 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27C9nt2d012730;
        Fri, 12 Aug 2022 10:02:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=V8881YP21Fflb9+XDKTDN7O6VgvUo0xEU3rqv1yGjLI=;
 b=DEpE2wWAqd9T0maRhWcWcjNOhlvUWs1m79f0FnL/vkg8P6+8Y7m0KxMxvr6enTOqn2DC
 5LD8dk2FOiVjSVV6cFRgnuRWej1wJBbBkV2BhWA2CReyg8zR2VayGHJwgPG3AtfUF00k
 TUb7ADUyoHZIMabb0dqA0HVXX8IJ9dbEOdLA71R/mVlYx7JB7/oLiCx+Tkyy40Sup8Vb
 Wk/soo6f5COYyxCF3apcmBA8s8ABENP+G1EcjjqNtyivvTvbNQIVfeQGEt0dRTKNAQFA
 OKQ8yCPEFO8W9KdPrFGFbU/Gy6CQ6nvRLbhUoX6lO0kloRABV2HXE7b1NmGNNOpzFGWj GQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3huwqbq5uj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Aug 2022 10:02:59 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27C8x9Hf004908;
        Fri, 12 Aug 2022 10:02:58 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3huwqkh0a2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Aug 2022 10:02:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EK+gqzqXCRfajG+6+SytrZJFfjN23Q7Ci3i+Pvsen++mHWRzNEWsQxaqi9NuMX0tatvbqA12fZCHbndiSJIaVsMN5DmbXwDWSOqEmaAv5RfR8960heWGEEf9cG4AbSI5N2Mn5wKw//Pty9GciECob+VPV0MJ9NuMiR4pgEnbobNhgLBEIjOBbIB9JSvmpAMbyNDTwYje5c8mvjgR602QYEwKDH/+5pYgLmT/FD9Hisb8B5DENdZMB4kvKoZtR+8grag63iEZ9WZtmEon/SmViGvaEYSLcRGM5wSQ1kMdjynektWD5NgaEaLIUY8chpgoQClBxsKHS5sQ55jDtZqZhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V8881YP21Fflb9+XDKTDN7O6VgvUo0xEU3rqv1yGjLI=;
 b=hAHD7X7/l/WtG1s8QS1+BpVKsMqCrSOp7VvKfBeKJ2sLCs17EFX+DZlhjKWx8doka0KQl7S68+YNmcI9nV80UpJx3R8XLTgCrtd3JN2gLa2HFpyjV6Tdvw8KDIGLwu6XUCaN1dovDLZssxNRpIa/pkTpoHQOcg2PxyaXG9VrrFipqVSZFNGQUxSoqIrUIreNttisMn/GBY4IuHBgVQrhvfQaF6gMyTZwHcsq4Ret7L7xWobm4rwQmCp9I8DSKePm1SUN8+x4U9CC7bk+u4Nk1rdBHMVmU7wpX2g5m+Vx4TjdbcVKHemOt/dR7Ouq9aGwHlSxjdCFF2xL8wUxjhkD5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8881YP21Fflb9+XDKTDN7O6VgvUo0xEU3rqv1yGjLI=;
 b=mea7SAzPQae9kQw5ZUCzbM5zCI3GK9nab/1wf0qbP93b9STHd6CjeDq7ob7kOzXzaskG0S4MfJ9PZuzGll0au/Fu/DUeah2TqxbdrGmDfxvpeOn4QW9oOvRpyZR7BQjUemktVFkOsTnoPFkdOPhfvwsEzznNCSM7At86KRpby6k=
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32) by SJ0PR10MB4495.namprd10.prod.outlook.com
 (2603:10b6:a03:2d6::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Fri, 12 Aug
 2022 10:02:56 +0000
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::eccc:6ecd:41f7:ed02]) by CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::eccc:6ecd:41f7:ed02%5]) with mapi id 15.20.5504.020; Fri, 12 Aug 2022
 10:02:56 +0000
Date:   Fri, 12 Aug 2022 13:02:38 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: mac80211: clean up a needless assignment in
 ieee80211_sta_activate_link()
Message-ID: <20220812100238.GM3438@kadam>
References: <20220812094438.18291-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220812094438.18291-1-lukas.bulwahn@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0027.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::15)
 To CY4PR1001MB2358.namprd10.prod.outlook.com (2603:10b6:910:4a::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b085a238-dd82-4dc3-e1b0-08da7c49d413
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4495:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W5c7CSAO1kHQr7MBbXSTo0Q1tGN+eQxqUiMD8nX+TsiWfcz4Qq9lFCy41lYuPEn/s3xgb3Uw7KPsmD94omC+qLOUmgOUEISaLbMeuxcxoWukuI18eCbnX+xcyYHs3l5xVauyszor7XDbvFliWYilpp5TjiHBPNFSohiI40uF3SEDZCwPGeC7pGdlfea00+c5ek28Kkty1yCL80dsKQHZ+BA1FUJo5r6WwQcjSOWP8CsMk5pIP6dRwisapLgat2klJcXLgQCaamaJKsuNvjB27pZWiqWY24dHbgk40p6ivGGIMQffEOKi2Jv3d43dMIl4AAKj+8FNvdFcLJiWBsjH/zKOxGLUueY4k19QUc83QjZf3g0C0CAtK91nAGSbLCsBylaNiBt54iAcrOIwlp9zD88SS2b2I74FnckKP8rLFk9K7T/60NTwqy+aWyQeZ4R2wc/XfGZ7FpC0z2lw36ajOzOL6hj65F2WWHANefsLYwiQl32uwfAc1LoOMuFi6ShThk4qch4kPhpF7D8Cly58c+D5Z/LBVMwmsVUd3zENE2NobMh+PSd971SKcLgm5QcY3ww0f5FeAJLOrDSpldm+WyUwMre6E4pURb1uHYgo9JWf11JQtFHs+mTFfA8wG+/NFi7q+3U7WDeFcuH3jO1PAej4pfm1CNlAQ9ESC49HJdqxj9mp7dFpY+i73WEtRGEYaxh8RXV5HFbM6sG1veblC1EPXIwkZ25OIjoFJFsutME496/5a0OSBVoJH/mZVpkzeX95THvZh7vEu15YLd5vnH1Sy1U8q0ksEQusuzZJJ8OxVL4QtUoj9F2bRAcsW3ec
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2358.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(396003)(136003)(39860400002)(346002)(376002)(186003)(1076003)(41300700001)(52116002)(86362001)(6506007)(6666004)(9686003)(26005)(6512007)(33716001)(83380400001)(6916009)(316002)(4326008)(66946007)(66476007)(66556008)(33656002)(2906002)(6486002)(5660300002)(478600001)(44832011)(4744005)(8936002)(8676002)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bnXFEg/6T6CFwtoId5jDQ+f/MUZSh1dlI3ISTCrCqs+OPthUw8wc97tEsYN8?=
 =?us-ascii?Q?h1ahxr9EF7bcHNdysEj71cnpfUHIUAnB53jZMAx6SYLa+yXnNSOT5RdtULkT?=
 =?us-ascii?Q?cH9MwQedGQjHZQ9Ox3I0l1Q/1pBchCVTIWhR2aCOn81g6WNsrz3g6zpvoeSo?=
 =?us-ascii?Q?eldIvMH1R/5+WL5VaLArafVlu9phHo9EKNQyVyKiQpbc9cZUHnden8gZ55jC?=
 =?us-ascii?Q?W9WXUbOIk2ckKaXy+H20BzxYDR+oy2NxZJuu7xmcaZ6bqsUjfcPcElUhK5qh?=
 =?us-ascii?Q?hw1Xl2xzA5zjnLzXAHZsnBgkmLE1uCmEr9EXeQ925SoLsUrhTY3ttyj9wntT?=
 =?us-ascii?Q?FT0Y+dFuPgHInVEQ2munk+2IM6kweQkunzE/n4tWr73c7bFynm4wV05sIX5w?=
 =?us-ascii?Q?Mhj1H97Jf59s1xsXOZ0RuRTjFArA2Qch59xD+JhLXjvVxagHSK0tLoKfaDcV?=
 =?us-ascii?Q?E7VJPlHxG2y0IwxQTajcKyAGByWxuyCBmzf+bly15Xo4k3Pqj8OCvUfnITey?=
 =?us-ascii?Q?hjGcFtwwi4qPGtRLEG0+jf3U+EYu8WloIrRAwhOm2d/63rU6z2bpjdNNYaRD?=
 =?us-ascii?Q?bSIeLrGhosQUJeX6ppfF/h4Cs3yMmxM8glAKAOdiuA8cMN8GleMhjEcckjd5?=
 =?us-ascii?Q?B2iE+J2W6ZuksLxN813DjJsVk0u5a9ea9gihGC25OjswSyyRaqytEI9qrAOi?=
 =?us-ascii?Q?Awrt9EMPlrZBRqAKLWgPaUMXFqsIbVgBz8hHvKJ1EoNJX2C2Q4YKtK/T3DN1?=
 =?us-ascii?Q?BmpFh1zKxPC0Zllm0Pt0K3IJqJRpBoa3c6gCZRglzXDX+Rim1ot9azsE9KXU?=
 =?us-ascii?Q?yFGQy+hGpeTIYms/2IzO/vTChvPMLpL/XdktJ9JwHNJbAtIj+xEL9Wcvy5b1?=
 =?us-ascii?Q?4z2Z5ggTfoYSCR0rGQkDnqZ/+x8mSk7NXUW8GGNPqW6ywYGH2vZJ9MSToHop?=
 =?us-ascii?Q?tbzsStuZ4qbKFrq5DNi0kEIsS2BSbBlPWe/2f8+nemPVYyqPR5wnRqrpD2+d?=
 =?us-ascii?Q?KGuLD9UghQYMXBmc8u4SKsFuBBtwSiRMUaL/nsbV/mHTLsdZhIVSwBvHDFR7?=
 =?us-ascii?Q?cEcFokeUCouZgSMUcKXgdpvoEZn5kD0D4aDEM7JHctW4DhwLvBWClN9ngKm9?=
 =?us-ascii?Q?/8ava1RRlC7yAVd1T4YMiFIBTWq+0d0Dw+MuU4JtUsqn6CiL8P/yZ/yI4Jx3?=
 =?us-ascii?Q?9Xt65/PjpdYhW3kLdysoYCA9rgKlteLcST7/o1xND707vhQXZP2bdNcBnthn?=
 =?us-ascii?Q?BsPr+FK21ujfKx5UHtiTgMO/8EQuUkoe9D/zS2ngJBJDXJEo4D+jw6OOA1bx?=
 =?us-ascii?Q?B2jU3DAZsZ0izhSQoBk5UuxeR2yiTCjH77kVTqujW90ORhvVuXgU4HeikDtm?=
 =?us-ascii?Q?rJCZxOeaeNHYKb24Akv3TZVaIFnEhZtjcfvyy3nBwnTUu7MTaynyUzDCcpRz?=
 =?us-ascii?Q?n6V4FVHLl+PySOeoSMgmNzT/IKWU2+q3l62c0ubF0ByGj1GX2zZf/0NzwiVi?=
 =?us-ascii?Q?DkuoyW1xecmKgYgo4Lh7/hzbq75UuNdnOkx0t1jQ6RNW3DZKujQgelvopTa5?=
 =?us-ascii?Q?3SgJxSna6/iuhXZOLLTgaVX9pSBvDS+EBYHhQGg+o8s+sChea04KGiC/CKK/?=
 =?us-ascii?Q?eQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?ki4CJyIvj6Ijdu1Z1+ZHOlwUCQgTqnnjg4J6/HPd9tL/VxA0Tnqpyigxc81D?=
 =?us-ascii?Q?rUZ0SanYUmBakMAmHh/TD4kNVMp4KPCGRFhEdE1gKL7oFIZcJJfbM4+2RmU2?=
 =?us-ascii?Q?jUo2JVCIRyVmUewyoYZPq4lk9A/+l6eoJ43wLHHQ1OyPdypRZTLPmmPaiMrX?=
 =?us-ascii?Q?VbfzyeUJCXkDtSy7AhWwbl3IoWTEXeHOeimvVgkD3KgLQgXz+kTX0e6Ipqsp?=
 =?us-ascii?Q?DZWV+LXV3cFytlDVR6Q5GauJEppt7x5yE/UhCLdd7yWmGn4haTi6y9nMoYDX?=
 =?us-ascii?Q?z/e72C/VbIbJU8cfW9NYNLltm5o4ne9QMWbQQ+M+efeuZQG0RAuIrRbpQM3r?=
 =?us-ascii?Q?HHYBmYoQr6jzUj/oDuHtOKbI/zsE8e11DflKcuQbUvef58ZITe03sSibAgLq?=
 =?us-ascii?Q?7Ec4E3vjXEMvWltfCwflpIGWdcKt/VPs3/7fDTfc6Su6KJPUgpTLXhL53Kei?=
 =?us-ascii?Q?zwnS7pNrBGLl+f3umBLQw1WIktcilqbgR6PxjyJq2vskJAMMzYdqAPmCYVY/?=
 =?us-ascii?Q?S65LYz9EzKDUHGLPaslsGh21QeJB2i29WCTZmLdwWVLFEvaWEy+mBY6jB9Sp?=
 =?us-ascii?Q?TIoBUIIwJi3XniX1/LCgW3rR4ilpQRE73Xy+Jxv+Bs2Ty6YXFkATjzhoNM8a?=
 =?us-ascii?Q?ptXu/D9jKgtzAMhgRzsvuekpQUyLiGtauQm9N689d4JqgUfmxNLubkNgT7/k?=
 =?us-ascii?Q?28ZH1b4eZr5T35qB8JT8zglB/OQ8bKSd/QmogRF/JzQr1HGXiqbkJ3FTJeET?=
 =?us-ascii?Q?XXPuJPkBjl4FAt25ZvwmZn8npNWjyzBneZ1aOiVPSojAdrkS69N1FwOqge3Z?=
 =?us-ascii?Q?xWDbOR793DiKqjtTKbC/QsSvlk8flexdyr3c9YFH9+AtkY+2aipwJ00uzUuh?=
 =?us-ascii?Q?goAisd3u5uON1H4QR0mnY6IWrpMVUPzYDR4EYEyOK47fGpWu+DNVFXGJK3uC?=
 =?us-ascii?Q?D7sySae6e0D5zxLKirilJKyd/BJYdAKvejUI54ypo4NP2pEyx2s2zRQ7HOQ0?=
 =?us-ascii?Q?zSCMGpOoTssaj5doG2haP/XjLA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b085a238-dd82-4dc3-e1b0-08da7c49d413
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2358.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 10:02:56.3563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vuXkNo3oPI6joekRNrfB5s+kC1FsSe46Hn6NJZZ7+Rm2WP47vprcXPSEVzi2YnwtrIFUjsf1XwfQvWmXgYpOreC4Bl4/TGHnLUruD2HtaSs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4495
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-12_06,2022-08-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208120027
X-Proofpoint-GUID: HHZ0sDsY1ZFn6EZvj48vl0XdjwdCOSqc
X-Proofpoint-ORIG-GUID: HHZ0sDsY1ZFn6EZvj48vl0XdjwdCOSqc
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2022 at 11:44:38AM +0200, Lukas Bulwahn wrote:
> Commit 177577dbd223 ("wifi: mac80211: sta_info: fix link_sta insertion")
> makes ieee80211_sta_activate_link() return 0 in the 'hash' label case.
> Hence, setting ret in the !test_sta_flag(...) branch to zero is not needed
> anymore and can be dropped.
> 
> Remove a needless assignment.
> 
> No functional change. No change in object code.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  net/mac80211/sta_info.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
> index cb23da9aff1e..492c7a29d797 100644
> --- a/net/mac80211/sta_info.c
> +++ b/net/mac80211/sta_info.c
> @@ -2778,7 +2778,6 @@ int ieee80211_sta_activate_link(struct sta_info *sta, unsigned int link_id)
>  	sta->sta.valid_links = new_links;
>  
>  	if (!test_sta_flag(sta, WLAN_STA_INSERTED)) {
> -		ret = 0;
>  		goto hash;
>  	}

Please, remove the {} as well.

regards,
dan carpenter

