Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0D1533B84
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 13:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242256AbiEYLPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 07:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242898AbiEYLPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 07:15:04 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0102E8D6AA
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 04:15:01 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24PAQvsD018618;
        Wed, 25 May 2022 11:14:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=NFNBBawxeZ3pcs8oDJ3gHtd3SqvMH93LqPgaUvI3DWw=;
 b=Q0nxB6fJaN2CMhFcTAucsS+ey0AUZwL+Gzr/aRMqqZ6jOW3e/UQKWandsnQiOwYiTkJ2
 W9FBlul30z/N7xKlYok/i7X7wNQO03TzvpJWusE0g21Zo1etu/n8IrPL5DV/dzCisxbP
 NfbFriwbbUF4GkRbQwMZU8cpIpjG8QTk88IVZ5g41K3WiXiQySMcUMJxCE2Bt81EPn4Y
 L4SA5J7mFqJjJ7jBLYUyMUqRE1cSfJCqzLm2bPvuBodYQ0sF3pbvSPclvBk8anNydTII
 OPyXuVzKeCfcemom2WrWRUQG7X+v5rbLoYWngy+ChAo35wvhve1JzFXsBrcT1AziCsF7 6Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g93tc1vaf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 May 2022 11:14:54 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24PBA6ND021665;
        Wed, 25 May 2022 11:14:54 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g93wv6ekf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 May 2022 11:14:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kquaB7CX0jcVoJForNgSAEYi2yaYcfYznzZEuOIEhOeLRMjaTy+WoEpwZUvHZeFhM9sKHbSco+IgTzvehGqnd4KCfArNU6xcDUg+rQIsSOFBSYklw5we8dy3KS7Kubv6qT0UjIq+8wToJ7U3NRwi9jpsdE1fSHqNjNBgbUiVzz8glKknAuh2z8XTq+EnSwSkZoPcDWc10+68WK44gTo2Kg0O51SgUXwELNoVP5Z1hO1HiOCdrghU21c8hcfS8IT21DYFCdfxy4H8zDy/8U4zyTZl5aaMn7oQCOPepkOjXCTihwJocZlU/l3OigtQBTt1qsuWCtYiMX9sjURrLjHjdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NFNBBawxeZ3pcs8oDJ3gHtd3SqvMH93LqPgaUvI3DWw=;
 b=kpme9CxU4vkKB/jtnlV2PXAjy0sQcUtEQwBc/8F2aIv3jjsWK2ie4kvkuB9hYq+6Ea9O7C1iR4rgq0Ccm3D9zBXhKf+uBhX1ZCUZo4tL4RDX2T3innheWhUcKlz7OkGB8gj8GD7VJJx9HRg/SLJZeOInScy/sB83i3XQCHmfTcmdNElerklBV+s1rZZ6Ru8MJjLg2xufucbiZwOPg3IaDskGQQW1NKvRf5HCmM3+yGHqfTTzVGop6almImwc+hH4unIVdTytti85ayyGLkwT8B7y9j4NwmvMCL9X72YzN9cHp+AUHghbfTkzccx0fRrr+GuT7W5u/PshznIpgFGt6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NFNBBawxeZ3pcs8oDJ3gHtd3SqvMH93LqPgaUvI3DWw=;
 b=k6GE6aVY5+FoCGH742oAVoQYa8HA0YMMx95BpmLkugWn+SEoiFrLcbzEjGRgdKMb6JoUd4KRhduhk/ffMHjR6ZQOJOKWOvM2Wt16PIz5CN4H5uEAIklPfox9xQbllyDbOmSRl8dOEUkU7UYLoy28EfBfddDx0iY6hqixlCWYqZQ=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM6PR10MB3899.namprd10.prod.outlook.com
 (2603:10b6:5:1fb::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Wed, 25 May
 2022 11:14:51 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e%2]) with mapi id 15.20.5273.023; Wed, 25 May 2022
 11:14:51 +0000
Date:   Wed, 25 May 2022 14:14:39 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Krzysztof Kozlowski <krzk@kernel.org>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [krzk-github:n/qcom-bwmon-v3 18/22] drivers/opp/core.c:1162
 _set_opp() warn: if statement not indented
Message-ID: <202205250514.5udea6OJ-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR1P264CA0125.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:50::23) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7114d4fd-d91a-4e84-a066-08da3e3fc958
X-MS-TrafficTypeDiagnostic: DM6PR10MB3899:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB38998ED99B6F97465349C3F78ED69@DM6PR10MB3899.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NgQ4MXn4J4uOtZRiIppECHLRNf/uEWDv4TLTvBU1ThCDpBVwceCab5F6E8A0tXQvEnvstpBskDMglVu0n8CZ97HWtsgX2Pzmn8yRAL2d6uqS1//+Hb0z9ESTcXjremQ6KrOgjGtTXOsRWpU4yL+TnqEVScGx9+6j6XAg1kYEQsxDsvwG0XQhubJ+Y64EOZ8nCNRSIiIt1U/PHOeavSvf9D5wO7XLowbNRl9tjYgqICcDhRm8nt/gt7TwU+dFRcBopIHTiJ38Jxh4V+e4A0pIZmUXJ2nHboA2Xx4rfFlsmjNqTL1qB4bidFg50mw6Dy1dXhracGYvooGfvQAn76ES5xZTqttD6i6PxcjppE7+5b48tSj6byNsR4Yq99vq4TWKrT2B6FForKy00E+OCiiI8uLB1xxVe8Q7nQAc5xZZeub3QLG4goKWe1QnEMRfy8zugnJVhYR8HLx1+Wl7yaOKkQ60siLxZkXHsPAxtUsrVPXahw4H+WLyi25UbxjaRRm1h9cz8uCRIZQpSLSBfhVG6Hrs0UVh2tATjmFKE3YPbjCYkA/K7jEGg5o068NoKYgGE8EXD0wM7G2y/sos04DGeyS0zg78CSID/0Yiz0r4Aqad2CHKP9ZGu8Pdqv4bCCuaKbqyQrUzSHIJbEDMMh5iInQe7fLLwlzdNs9epvIhDalQS4Us70mjuPlOFbP8YPiMWt9IQXL7rsDLXjhVaimSxPz/lwZdFDFZjylMzHIRgubDiuesTz0ToqH/mqGDO1HDOEzvxoiEhSBpTAdCPGIFCDTKNNsWbYIEUJfFAKACBZeFXWvsmvnAN0xGRC9Jo/OPeyx8UpgELI+Ixo5+F/QnGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38350700002)(6486002)(52116002)(38100700002)(966005)(508600001)(316002)(5660300002)(6916009)(8936002)(6666004)(1076003)(186003)(2906002)(44832011)(83380400001)(66476007)(86362001)(4326008)(66556008)(26005)(66946007)(6512007)(8676002)(9686003)(36756003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1J4qco/ejKJibbav3srWg72vmJFUYoRyeaHDntOaw2NRrAunjibabaovwrwO?=
 =?us-ascii?Q?+NHGAzzysG8zSrC+/AN+5oaCvy8KufxndzrU2YwnIPMeE/lR6z2ZJ+rtbcLa?=
 =?us-ascii?Q?fv0rOfsYlA5Gbd7lYjysekh8aXLGuRv1D/1zXwLfnWwtKPkVl16ATZUKQs+t?=
 =?us-ascii?Q?fkGHn7XfUPtkuBzc7G6wzVniZvSthudLQbjN+WChufmmZ3Ws5nN9NKDweGPJ?=
 =?us-ascii?Q?9GujzcBe8DeW05LLUJh4jB6HUitQiSN/kp62TWEF6q8CQSPocc5KIz/uT1Mr?=
 =?us-ascii?Q?GPRGZ076Q13g8MzfFU3D4pwL61zxjD8yc8ZcBXjvoEqTRXTVvkiljJ3BQQ5p?=
 =?us-ascii?Q?Smzo67utW4AfuJgZtbH5gCFrX84BDSKl3F450kyPCsOfJdVAryaLtrSwr/Ja?=
 =?us-ascii?Q?13ZUkvBPsmqcfQwx0uSY9t9Cx4CHc95cjhiYuNpck8cf2qxm+yT1BCYhKH99?=
 =?us-ascii?Q?MfKGK/xVqH4pyQAr4xY4gkFSO4KunJDswOkuLlyJv1ZjQioXPm0d96QGq/gI?=
 =?us-ascii?Q?BTafZcIFvVqXk8gl2qfSTw1We1DSXauoQTUUtTLu2AsRckqyArpX6trTnjeY?=
 =?us-ascii?Q?4o72lZ/VkZMNZRvNkM1b1unWOORqlCy95a8EqY8F18GNh+XnDybGzAK2qYEp?=
 =?us-ascii?Q?/gE09sJcGD3XPX9bQwpTX903WyjTo/MlguX3oseOh+He9sSCDYtv5NbUoNhD?=
 =?us-ascii?Q?xM5A1+eTXpb6xTmZUA+SkXWD8Z4YBkzYhMSKgmHnOqsWIbDEPU2zvqHnLLS5?=
 =?us-ascii?Q?I2RLPjOwDkG5JTm/XDbiE4YjUDF81mpCadlplCeFsGZ9bkek1XjgrNzCt7Kk?=
 =?us-ascii?Q?yhjvrFd1X2uHvfC1+I7CBKWLjz5ZHW8X6013NX63kM3FI93B07vn1RX9mgVr?=
 =?us-ascii?Q?yPfTadTiJbFs9zgmGWXvFOrKswjauoTEpQHNLVUa775d46untkcabHZ2wc1G?=
 =?us-ascii?Q?C2HxF+Pq3h1ewu5Ap3LQa7hpk5/JlNgxByC0FMIO94nxCPE316mAbfrdRHx+?=
 =?us-ascii?Q?8rkVPZvrgnKMzHX5ZifXfwvKEFdydjkkNOtPNpQroK+t0RyfB62UbaBFfD6w?=
 =?us-ascii?Q?4qVeQSFlMI9Hvv8HZpKQynxP/Nz1QCABUM8zYYomV8AHlfixxu97Zj7MxzTm?=
 =?us-ascii?Q?SNx2MFEo3J21inOttMnwahrVySJh8TzqfRgg0kOkV+HiQfaDae0UA74qUFRX?=
 =?us-ascii?Q?G5NO1LPRttqTyo0lgT1jY747VVYzssnO3+oIyU2UhhNkezxlB+GG4G5GawJb?=
 =?us-ascii?Q?3fnqCrOXGjFUjLEXA4AxhDJ7kn7R3Y3rOzQ+pLFgGqOJp8dy27P7Ns8i+wvn?=
 =?us-ascii?Q?J1G0CZtIxOuiJJ6oVISt8+DOY+8HsALI8YS196gMVnUKPXtarKhdKdg0qjex?=
 =?us-ascii?Q?8JePNQoYq2P7OQchEzeYLTaPqr57JIXZAcl1d2TSZVZXDYAC+QO+p92u3Uzb?=
 =?us-ascii?Q?IyY6WDX8TiLvwlmMNR+/X2FrGTSdAr9XTXGHiUdZf8VkvT9Kb3lZTjs3Gapx?=
 =?us-ascii?Q?QLnmGB0+38W3Vr6OFlNS1xhHvcNNds8Qa8h7tZ0dpIkOhAAG6PxRbWnU47Z8?=
 =?us-ascii?Q?JT6p1fergA2Gb80Zv2Jccwb1t3KTlIDRLK+yBa742zqFL3HZEIQ7m1I4b7Bn?=
 =?us-ascii?Q?vcJEbrPXomHZiiHjC0+8L7k6JAK2hPCZNVqek/3Ly4JApLWps6mPz3lDBuRL?=
 =?us-ascii?Q?t3N/xDUL5rb5gj4GHyEvLW/eGYzA26xbnT/gGCwZ/5+KWEiQT2Ama8b47PXS?=
 =?us-ascii?Q?y98WN2iL/ZdQD14fmguv936Dzpy0tD8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7114d4fd-d91a-4e84-a066-08da3e3fc958
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 11:14:51.5736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g6K//3xwHRzbT5Ib34XpQyTNHDJsuHulhKI1n2KJ4mQs4dyBmG0wXnWLTTvlVf0rtaH/ezs+CaXNZ5+Cod3h5Kyjm/b8MZZLo6HDKzzwAqY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3899
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-25_03:2022-05-25,2022-05-25 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 bulkscore=0 suspectscore=0 phishscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2205250056
X-Proofpoint-ORIG-GUID: i3U5IxbaleKu0khvQjAb7YIGZBbqZHc4
X-Proofpoint-GUID: i3U5IxbaleKu0khvQjAb7YIGZBbqZHc4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/krzk/linux n/qcom-bwmon-v3
head:   f595f77c2d91820ce85df16e278315e522172710
commit: 9dcc827f8b0062cea637d4a5cc449f2b88134266 [18/22] debug
config: i386-randconfig-m021 (https://download.01.org/0day-ci/archive/20220525/202205250514.5udea6OJ-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/opp/core.c:1162 _set_opp() warn: if statement not indented

vim +1162 drivers/opp/core.c

386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1140  static int _set_opp(struct device *dev, struct opp_table *opp_table,
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1141  		    struct dev_pm_opp *opp, unsigned long freq)
6a0712f6f199e7 drivers/base/power/opp/core.c Viresh Kumar        2016-02-09  1142  {
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1143  	struct dev_pm_opp *old_opp;
f0b88fa4559525 drivers/opp/core.c            Viresh Kumar        2021-01-21  1144  	int scaling_down, ret;
6a0712f6f199e7 drivers/base/power/opp/core.c Viresh Kumar        2016-02-09  1145  
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1146  	if (unlikely(!opp))
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1147  		return _disable_opp_table(dev, opp_table);
aca48b61f96386 drivers/opp/core.c            Rajendra Nayak      2020-04-08  1148  
81c4d8a3c41488 drivers/opp/core.c            Viresh Kumar        2021-01-20  1149  	/* Find the currently set OPP if we don't know already */
81c4d8a3c41488 drivers/opp/core.c            Viresh Kumar        2021-01-20  1150  	if (unlikely(!opp_table->current_opp))
81c4d8a3c41488 drivers/opp/core.c            Viresh Kumar        2021-01-20  1151  		_find_current_opp(dev, opp_table);
6a0712f6f199e7 drivers/base/power/opp/core.c Viresh Kumar        2016-02-09  1152  
81c4d8a3c41488 drivers/opp/core.c            Viresh Kumar        2021-01-20  1153  	old_opp = opp_table->current_opp;
81c4d8a3c41488 drivers/opp/core.c            Viresh Kumar        2021-01-20  1154  
81c4d8a3c41488 drivers/opp/core.c            Viresh Kumar        2021-01-20  1155  	/* Return early if nothing to do */
de04241ab87afc drivers/opp/core.c            Jonathan Marek      2021-02-16  1156  	if (old_opp == opp && opp_table->current_rate == freq &&
de04241ab87afc drivers/opp/core.c            Jonathan Marek      2021-02-16  1157  	    opp_table->enabled) {
81c4d8a3c41488 drivers/opp/core.c            Viresh Kumar        2021-01-20  1158  		dev_dbg(dev, "%s: OPPs are same, nothing to do\n", __func__);
386ba854d9f316 drivers/opp/core.c            Viresh Kumar        2021-01-21  1159  		return 0;
6a0712f6f199e7 drivers/base/power/opp/core.c Viresh Kumar        2016-02-09  1160  	}
6a0712f6f199e7 drivers/base/power/opp/core.c Viresh Kumar        2016-02-09  1161  
9dcc827f8b0062 drivers/opp/core.c            Krzysztof Kozlowski 2022-05-24 @1162  	if (old_opp->bandwidth && old_opp->bandwidth[0].peak)
9dcc827f8b0062 drivers/opp/core.c            Krzysztof Kozlowski 2022-05-24  1163  	dev_err(dev, "%s: switching OPP: Freq %lu -> %lu Hz, Level %u -> %u, Bw %u -> %u\n",

Just go long.  Or put the string on a line by itself.

de04241ab87afc drivers/opp/core.c            Jonathan Marek      2021-02-16  1164  		__func__, opp_table->current_rate, freq, old_opp->level,
de04241ab87afc drivers/opp/core.c            Jonathan Marek      2021-02-16  1165  		opp->level, old_opp->bandwidth ? old_opp->bandwidth[0].peak : 0,
f0b88fa4559525 drivers/opp/core.c            Viresh Kumar        2021-01-21  1166  		opp->bandwidth ? opp->bandwidth[0].peak : 0);
f0b88fa4559525 drivers/opp/core.c            Viresh Kumar        2021-01-21  1167  
f0b88fa4559525 drivers/opp/core.c            Viresh Kumar        2021-01-21  1168  	scaling_down = _opp_compare_key(old_opp, opp);
f0b88fa4559525 drivers/opp/core.c            Viresh Kumar        2021-01-21  1169  	if (scaling_down == -1)
f0b88fa4559525 drivers/opp/core.c            Viresh Kumar        2021-01-21  1170  		scaling_down = 0;
947355850fcb3b drivers/base/power/opp/core.c Viresh Kumar        2016-12-01  1171  
ca1b5d77b1c69d drivers/opp/core.c            Viresh Kumar        2018-06-14  1172  	/* Scaling up? Configure required OPPs before frequency */
f0b88fa4559525 drivers/opp/core.c            Viresh Kumar        2021-01-21  1173  	if (!scaling_down) {
2c59138c22f17c drivers/opp/core.c            Stephan Gerhold     2020-07-30  1174  		ret = _set_required_opps(dev, opp_table, opp, true);

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

