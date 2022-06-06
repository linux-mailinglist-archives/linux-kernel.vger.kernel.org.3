Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D66553E985
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234856AbiFFLJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 07:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234824AbiFFLJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 07:09:03 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB12F1C866C
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 04:09:02 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2569Gx0P026432;
        Mon, 6 Jun 2022 11:08:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=luNEDk2Gxtfnkg+eyY2cf3QIlbgTrCBNHv4RV7N8Dyw=;
 b=d5eJgwLj/EiIy9oVTlxf+vbpiK2rS1MGCqlvCEGrgYnXxVJimSkIddbeT8Fo8aGOhVxk
 yjOATvVPidbOjfqNCKZpIbbudbFlQosCMEhb+kJYdRPBPOqvZetPj00LULnw7EohPEQJ
 XgVgt/fyx/jdogS0lSx1s1+UbVo65THe+NrunId3jrwqaT4hXBzcTLHbCbm1XnYot/q+
 kws5Ax2zszSPrDPCBvsOfC5+m8DM/elfl35qWWTTxsO92bf0gLUN9jrxuNT+TXuTQXWS
 ceqwm0hWOEX3pX+E6ha9S+rjT6mV90a++DRUS2ltaFQ4f9xfTvz0ejaMlIltc7DnzYzJ PQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ghahr8qdp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jun 2022 11:08:28 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 256B1sTT006924;
        Mon, 6 Jun 2022 11:08:26 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gfwu1h2du-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jun 2022 11:08:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cwKRQENxvN14Kz0tS9qfwaCNI28/K0k9AxcRe92XUvUa65zZV4JOCXHC2UMr5xYRnTLgKP2fzW87ym27Yah/ozATmN53VomwwwtQZo44glyAvLExCFCOwiFbdC1wUMwhwv+IvmkGhgPeBrzyb64fDDbz4swt9L7S+ZvtpHyhbUNgl3tKAbU4FuvsoLMicsVZTXcX91p4J6yN2ukulapDEICgaFKsRRBk8KDe2ynND1GeFUTvpHlisbM4bZbIzsrkt75MzkARgTtTdCRrG1lxWF/2DJnccvl2ei75CaoHi1YQLisajN9iGWqbkWX4GkSSVb10LLy++64ucDbNFWfpgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=luNEDk2Gxtfnkg+eyY2cf3QIlbgTrCBNHv4RV7N8Dyw=;
 b=eqv+ZaTWucS8LNY9i/y+GjgLDvT6/xml0zGRWjA87Skv4gcJe4M2pQ3IDzRRMGtNra5hy6KhHI3EYGX3NjO/yTW5DbVkaqYbANipgh/nkkFQU5nYQF4/jr9KHtClr8AoFOjzpCw0JvUQw2Sh00WH1Z3cSDiN8j5QSm82nEWaaJUVvQabvNXY5h9JbglxcIfxTJPW2PpzZ9tlmOeQrSlRkUJuqbB5nfc4qCnPoZQ4gQOYiu2RnN3s95Mkq/mHpJWXoffu4qd4hnxxT/qNx1ljc6LjtSK79sxr0nrKCc7whqUm3xpolbvF31Z1qTRJYVZacLoCX3/k/6nUKYOFTG2OGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=luNEDk2Gxtfnkg+eyY2cf3QIlbgTrCBNHv4RV7N8Dyw=;
 b=HiJH+Ou+O9v+vAmCq1kqmfclaz1n42rFIf7I6FT/14dJN/sf1OETgrrTGLFu2sleKXf6mu4SWEtPHilZi7TBoIRbxyU30rlbAj+3xYbU76/iiqMHv0yxXjDynu1hX4c7/Uzhj2aq4ceN9gwYgZwXbQhyqvti2WyUoO/uCtrvMtM=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CH2PR10MB3975.namprd10.prod.outlook.com
 (2603:10b6:610:7::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Mon, 6 Jun
 2022 11:08:23 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 11:08:23 +0000
Date:   Mon, 6 Jun 2022 14:08:03 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Hector Martin <marcan@marcan.st>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>
Subject: drivers/irqchip/irq-apple-aic.c:941 aic_of_ic_init() error:
 uninitialized symbol 'off'.
Message-ID: <202206010439.LRgjym7t-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0004.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::16)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80a9be7e-3018-4ee7-0d19-08da47acdeda
X-MS-TrafficTypeDiagnostic: CH2PR10MB3975:EE_
X-Microsoft-Antispam-PRVS: <CH2PR10MB39754C31781B157DD9A415428EA29@CH2PR10MB3975.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iHJv6ReFePIRp26N/6HcBsfAzeUQ33vHrihSzOscsnrhMuunj673RemP6Wo2r6uEPitcrGS1kGkPh5Ev1rT18doaH+9pPDcemkU72u7Du+a7E+ToY3VGEGkHS9CHOIPZb21SiolEn9y/onpp9HkyIFrwme02JyuJH/Lum7pvXR0SOPLhvkgo1CUrj4ipT39REjgc1KLZfy3F4e0v8aVcVYN6povpTg1XNGaFCoHT6qVjFsSF8TDXfvyiyJdb13VWIoxbz146dE8GcICDrMD8kZ/jo39IIHO4/itDZk1w3tmdevaOihyVS1xD1+AWA57VmUS8CFGKL0aj+hg3yf6ZUJq4ycxFklDqsjQeAjVUQ3rAHcBxGy2ZvDqPdK3M+Mcysw6J7IYWH+p+Ac9wxYUgSRxWxPKOi3vxU4ksfgYkvfGt3oPQDQxFazY4onDvXPF3YvKouHC6JA+bfo+fIKq+MCjvMFiNKDjG9w9W1r2WpmdlxA0tfUcHm1Vbgj/cqj3sGi3Dp1gCCVMXxG9ExEnfj3y+RBu12EMKZ3wNkzuUWW7K5AoEnOxVyhqCzRc3tD7yYERA0arfA+mQ2p0/jzVboD2hXgrWbkIDBw6GocGLi9rSjmm7loNGRHYQzNEmr6Uo/k+Hto1j1kYId7kCNt8PheYnehUAIC8IGD0LwKtLaNtoNnrRYQ6mYSpm4jcL3bGIo5Y9tWbJ1WUzgv1KzTVhrmbFz9KOLqSZmjQ/XR4C/8uG3KDoqtqUfMWMLVAah+ECq+pkluuwmuCcXc2ul4wGtsjKfEBMs231R+WgXPEzv8kNf3MAjaN1xT21LcJAOGhxvPZB6VFxm2HMvKUU6mzhuWdAGOTsvE8fABUCq4+mz+k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(47660400002)(86362001)(83380400001)(6666004)(26005)(508600001)(966005)(6486002)(38100700002)(2906002)(316002)(1076003)(186003)(6916009)(52116002)(6512007)(6506007)(9686003)(5660300002)(36756003)(4326008)(8676002)(8936002)(66946007)(66556008)(66476007)(38350700002)(44832011)(46800400005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gS674emL0h8pygtIVx3OcvDYxdvcDFpO1sIHVGL9OqiAIgTQws+WE7qTEQhE?=
 =?us-ascii?Q?q3rcDBwvPBvxGITzDKHb2qBa1PDDdgYCn2ufOCi9fjhare3njn2vvo0R7gUB?=
 =?us-ascii?Q?vMm/k3liZw9rwITDgK0i6aQUuhn7rQ0n/zDqUaVMgRErHRgmUzwM3VbKzWRL?=
 =?us-ascii?Q?nLxk52bQT6C93QnZm4deqY3D32f6ucKMlVICgDbL26o5H7IROXgguv2hLMMq?=
 =?us-ascii?Q?6Hx+Ogs6P1v1Fk7ZhTt7xz9BmYRkTXkfUMSvdvx2tuogfrCUTGGLoajuy9ZO?=
 =?us-ascii?Q?Cn3vUPPJ00T8/7DmrZyYaS0DBw0NHrt9En7xtoDMvE2zKxrh/yJpbPJnyqq8?=
 =?us-ascii?Q?7n1e3/ziPF1x2wXKjNJCy/9dokw1GNbYSZf5t85szZIJGdZXsqcQfGjon0Kg?=
 =?us-ascii?Q?f/bFW5gXAJEE/G9SUFw1yb6aDicnURza8KueXAM4xVkzWV+T7BIGTf2lMTLY?=
 =?us-ascii?Q?1YWO+4m1ZGLHUD8BrDcgLyVcNJh9oA5z0VhEZ+ZAk3GczR1R9nZlEbjWgxQ+?=
 =?us-ascii?Q?BHKk46I83ne8zx8DEMx8YD/6yWl+iY2eGX+4BpZfACKf4dogPosI7WuBT7Sg?=
 =?us-ascii?Q?qARMTv833c93zShG3pNBiXZdupZHcgDJcgi4YqaUbgJB4xpwfI69DDJag1yy?=
 =?us-ascii?Q?vtmsWEDorFYnhEFbQy7AuLdd2oBdbVlcN/urw5QBfO1606EzqLK9loA4kJiS?=
 =?us-ascii?Q?A9QBX2Za9sJvi68vv3bQBPdXmbaUrzEanlzioIKHk3+oXbzrdvMTQvyOKjcA?=
 =?us-ascii?Q?9gKoCbLTBapGYdALrg+PuZrXHj7r+QUbfiYNipUuZkRZ6JK+mHJaGfstUeYx?=
 =?us-ascii?Q?9YcI6t5LDDnGm0Ivb9Nzqk6UONDOPCUofkTVkvZToiKR6zbvwdizutyx6ht5?=
 =?us-ascii?Q?dqksJvAy130IWL2HPuzzRdLSERu45c9sRZRsEK9sURvKv5ARit1q1B7Ss1jY?=
 =?us-ascii?Q?yRajZze18WZvg42ZoZwJbKPOdwjYBgJkgWnb1hffjxKvr1q9Wv3tvNqoMoVA?=
 =?us-ascii?Q?KfVQ2ZqXrt9DhXe3cnDnlSVm2L3QvOqNRx7P3jOb6j9/GtFiX+NQilfwn6L+?=
 =?us-ascii?Q?9dCFaIuROTRs9UeoeJNDHm2LUwpLkmclx9gOzKUWW/s/Dxo4ePLUFPebDeYT?=
 =?us-ascii?Q?9ZYyyEXl3wK4CRXuNAQnYYl7q4Az2NKSI6skkdfB/R+Ed+XbT51P1AKTtpkZ?=
 =?us-ascii?Q?KFJ89/Te6mHXdT6tH/v3Ermg92HEUWxYQpjXLiIkXRqIlAfYuE6es4lm48FO?=
 =?us-ascii?Q?s8HnHKcW6YNYmUvZ7SCJGzN7M2fucil5Mj8xLeMIxiDzSs0FbbhyeWGxykFY?=
 =?us-ascii?Q?ZqoQ0R1g/dK1E0VZwnB8vOSsj98KKwz+UFJHWkaW0KSwr0H6cu90GH6Xr6vB?=
 =?us-ascii?Q?qKtVqcMumSMn80F++zPq0jmmyc9QOAE4aP3MRSvoiRh78KdhWXKnUuSU65/F?=
 =?us-ascii?Q?k/OXUJag2yqJelo1s2Mc4QTSM0iWCsyGSSm2kzfV5ylWHgjSEWvVGb+WnUyz?=
 =?us-ascii?Q?8KmcOJ9kgU+BiOEwPQDUQsjTfLmRnN/W9qXwOzd4SVvvbjgVKgpZ/hnJRUYM?=
 =?us-ascii?Q?rq6h4WNWa7t+WmglqDgekSHLh36uP43LEtOyU4i89ufGn7evm7sGYNk7BEan?=
 =?us-ascii?Q?A4owLNLRX/QH0XxbsE9j5J/85Wa2ZXHiK9Tm5mghUHcpsFue9LQCKQeXuhqr?=
 =?us-ascii?Q?/zpV/+AUbMI4bHGWccP8sBoxS7hklCCOH1+0QBAZr7C7Yzv0ExOhlUYnjb30?=
 =?us-ascii?Q?S8TR9wLssGvQna4Cv/45f4DhV4zMXe0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80a9be7e-3018-4ee7-0d19-08da47acdeda
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 11:08:22.9344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nyBmvJhZHw2cwa+oKcDJ0KWFXTvReo3yIuP2L7SmXQ2vFc9e1aWP7kRlBACaP0j+R6Y71E2a1LPDK4/cp8KQYvFA1y7SgWH2n2w9t42zX6E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3975
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-06_03:2022-06-02,2022-06-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 adultscore=0
 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206060051
X-Proofpoint-GUID: RXLuSWoOTd8WSI25EW09SfTNWeAKAUal
X-Proofpoint-ORIG-GUID: RXLuSWoOTd8WSI25EW09SfTNWeAKAUal
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
head:   8ab2afa23bd197df47819a87f0265c0ac95c5b6a
commit: dc97fd6fec009957e81026055fc99a03877ff3b8 irqchip/apple-aic: Dynamically compute register offsets
config: arm64-randconfig-m031-20220530 (https://download.01.org/0day-ci/archive/20220601/202206010439.LRgjym7t-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/irqchip/irq-apple-aic.c:941 aic_of_ic_init() error: uninitialized symbol 'off'.

vim +/off +941 drivers/irqchip/irq-apple-aic.c

76cde26394114f Hector Martin 2021-01-21   900  static int __init aic_of_ic_init(struct device_node *node, struct device_node *parent)
76cde26394114f Hector Martin 2021-01-21   901  {
76cde26394114f Hector Martin 2021-01-21   902  	int i;
dc97fd6fec0099 Hector Martin 2022-03-10   903  	u32 off;
76cde26394114f Hector Martin 2021-01-21   904  	void __iomem *regs;
76cde26394114f Hector Martin 2021-01-21   905  	struct aic_irq_chip *irqc;
2cf68211664acd Hector Martin 2022-03-10   906  	const struct of_device_id *match;
76cde26394114f Hector Martin 2021-01-21   907  
76cde26394114f Hector Martin 2021-01-21   908  	regs = of_iomap(node, 0);
76cde26394114f Hector Martin 2021-01-21   909  	if (WARN_ON(!regs))
76cde26394114f Hector Martin 2021-01-21   910  		return -EIO;
76cde26394114f Hector Martin 2021-01-21   911  
76cde26394114f Hector Martin 2021-01-21   912  	irqc = kzalloc(sizeof(*irqc), GFP_KERNEL);
76cde26394114f Hector Martin 2021-01-21   913  	if (!irqc)
76cde26394114f Hector Martin 2021-01-21   914  		return -ENOMEM;
76cde26394114f Hector Martin 2021-01-21   915  
76cde26394114f Hector Martin 2021-01-21   916  	irqc->base = regs;
76cde26394114f Hector Martin 2021-01-21   917  
2cf68211664acd Hector Martin 2022-03-10   918  	match = of_match_node(aic_info_match, node);
2cf68211664acd Hector Martin 2022-03-10   919  	if (!match)
2cf68211664acd Hector Martin 2022-03-10   920  		return -ENODEV;
2cf68211664acd Hector Martin 2022-03-10   921  
2cf68211664acd Hector Martin 2022-03-10   922  	irqc->info = *(struct aic_info *)match->data;
2cf68211664acd Hector Martin 2022-03-10   923  
2cf68211664acd Hector Martin 2022-03-10   924  	aic_irqc = irqc;
2cf68211664acd Hector Martin 2022-03-10   925  
dc97fd6fec0099 Hector Martin 2022-03-10   926  	switch (irqc->info.version) {
dc97fd6fec0099 Hector Martin 2022-03-10   927  	case 1: {
dc97fd6fec0099 Hector Martin 2022-03-10   928  		u32 info;
dc97fd6fec0099 Hector Martin 2022-03-10   929  
76cde26394114f Hector Martin 2021-01-21   930  		info = aic_ic_read(irqc, AIC_INFO);
7c841f5f6fa3f9 Hector Martin 2022-03-10   931  		irqc->nr_irq = FIELD_GET(AIC_INFO_NR_IRQ, info);
dc97fd6fec0099 Hector Martin 2022-03-10   932  		irqc->max_irq = AIC_MAX_IRQ;
dc97fd6fec0099 Hector Martin 2022-03-10   933  
dc97fd6fec0099 Hector Martin 2022-03-10   934  		off = irqc->info.target_cpu;
dc97fd6fec0099 Hector Martin 2022-03-10   935  		off += sizeof(u32) * irqc->max_irq; /* TARGET_CPU */
dc97fd6fec0099 Hector Martin 2022-03-10   936  
dc97fd6fec0099 Hector Martin 2022-03-10   937  		break;

"off" uninitialized if irqc->info.version != 1.

dc97fd6fec0099 Hector Martin 2022-03-10   938  	}
dc97fd6fec0099 Hector Martin 2022-03-10   939  	}
dc97fd6fec0099 Hector Martin 2022-03-10   940  
dc97fd6fec0099 Hector Martin 2022-03-10  @941  	irqc->info.sw_set = off;
dc97fd6fec0099 Hector Martin 2022-03-10   942  	off += sizeof(u32) * (irqc->max_irq >> 5); /* SW_SET */
dc97fd6fec0099 Hector Martin 2022-03-10   943  	irqc->info.sw_clr = off;
dc97fd6fec0099 Hector Martin 2022-03-10   944  	off += sizeof(u32) * (irqc->max_irq >> 5); /* SW_CLR */
dc97fd6fec0099 Hector Martin 2022-03-10   945  	irqc->info.mask_set = off;
dc97fd6fec0099 Hector Martin 2022-03-10   946  	off += sizeof(u32) * (irqc->max_irq >> 5); /* MASK_SET */
dc97fd6fec0099 Hector Martin 2022-03-10   947  	irqc->info.mask_clr = off;
dc97fd6fec0099 Hector Martin 2022-03-10   948  	off += sizeof(u32) * (irqc->max_irq >> 5); /* MASK_CLR */
dc97fd6fec0099 Hector Martin 2022-03-10   949  	off += sizeof(u32) * (irqc->max_irq >> 5); /* HW_STATE */
76cde26394114f Hector Martin 2021-01-21   950  
2cf68211664acd Hector Martin 2022-03-10   951  	if (irqc->info.fast_ipi)
2cf68211664acd Hector Martin 2022-03-10   952  		static_branch_enable(&use_fast_ipi);

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

