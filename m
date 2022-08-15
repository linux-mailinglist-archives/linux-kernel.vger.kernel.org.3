Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108635929E4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 08:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241132AbiHOGxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 02:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240393AbiHOGxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 02:53:14 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20951BE8F
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 23:53:12 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27F4j2YX032307;
        Mon, 15 Aug 2022 06:52:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=C60fQDSdRoNBPMUV/wbwDRQncEwAgqWw/H6MqPmq5p0=;
 b=GjrWuomsHCpTU6PqGbaKah2D7A6Y0LEdGzf0yfWwhFuuhKz2RV3oejhOPc7f3FwHYhqT
 Wyzdsbmf0dPzql1W0gj1LT4pEs8pdr6sjEoin/d2L4mvjClyz1K9dIw9+qZB2qSn3bp2
 oXHA7AT/YvWOL1cz+UOCrHh/iNu+/X2jUoQMXfWI+f6KD3P0CGZPFHivc17LEJyrAb9m
 dN9UIbJ4V04YtR7I6iMSGixs0gcafIkwbZTeaTmDl6hD2DmnYRahhtfJj7R/i3w1rJAi
 KROb0PCXGAGzOq+6Zy4ZMglqxFoEsBW8o2k0hEWG6JgoTDK89aFCgI3y2kjhatZqwgW7 ww== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hx2ccjas1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Aug 2022 06:52:08 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27F3UIIF034875;
        Mon, 15 Aug 2022 06:52:08 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hx2d1572e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Aug 2022 06:52:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IPF67aoB7bRSv4WqoQP86wUhPeU6h+xzjVUYN5dQSV/DR4jc/I/ONtP2dFxtSut+YXV8Ksao1WdOrPOTGK826n6++oh5us4OkA1dWcM4O8BqLtdlPAuM3eKDit9ceYEppM0k1utBpBReLPbV2YCtIfeOMn+CMyxf5nZ6RqtTnx/27UdC9s1tuNe+fme3aUqeP2GkIVl3JAb3DvjeSkYwLJT6K82xOLFpAO4sSSwuMcm/qaoyHsHAXvhzqp4/3MICAZgcDfqGr/k5te2Kw4/GyBIcfj5mra7RKQ0QpYGbhndzhjIxBD5Z9uCiUJfLQfIXzxPOjG0ZewQA0qfoPAZ2rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C60fQDSdRoNBPMUV/wbwDRQncEwAgqWw/H6MqPmq5p0=;
 b=dEBtv+g8KzJqlLzTicEYvCPD7X8DYweghwE02CAyrP8Rfhg1t6JWOuiWrbOJCi0rZaZMOuSbVzhH+UIS0zPHk3csxYobE/C0iASW7o3gDS5mhMVCE5z2hVX8fFvbT4A8pbWQXPqq9O+uinnt7eajKKMOHR/iFx8aS1+qUKF4DV313a8yWzeLdof5zPVLmDWefbM0UDa0bDAld7V+IRNRaLi2ewx9dfBsTecnwBdl/uWJxq4145xGo1SKoi/Nff8Hj+QvgvbXI4fVl63YAFX/KFh3WoDRY86A9wQ/7QuYe2ajuxudnTMG9RDp5ZiWQati5YUtQ8qMIISt+Hn09OKVjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C60fQDSdRoNBPMUV/wbwDRQncEwAgqWw/H6MqPmq5p0=;
 b=Zif63bHA4Jm6dd9FgSbILAV0xGZFKEOvr9yD5UW9fFmYEEILKBIZa/is2DvU9yO4XJoUdHoYgZuq4zeru+1ojvyB9tDHbq6YG6PTsC63KvThBlrHzc6we9BX8JBsCg9qWBzsK5iudQ8U3IbO/gsRVp4o4030MAsMkXZ+IGDhZdE=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BYAPR10MB2488.namprd10.prod.outlook.com
 (2603:10b6:a02:b9::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Mon, 15 Aug
 2022 06:52:05 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5504.028; Mon, 15 Aug 2022
 06:52:05 +0000
Date:   Mon, 15 Aug 2022 09:51:54 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Antonio Borneo <antonio.borneo@foss.st.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>
Subject: drivers/irqchip/irq-stm32-exti.c:719 stm32_exti_h_domain_alloc()
 warn: variable dereferenced before check 'host_data->drv_data' (see line
 707)
Message-ID: <202208131739.gJvcs9ls-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR1P264CA0214.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:56::12) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1569a902-bd4a-496f-a308-08da7e8aaa0e
X-MS-TrafficTypeDiagnostic: BYAPR10MB2488:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dp/m7OWnsYkrIaWJxG04APrGRoiy7MamdcLYUPMdYNcxo9ewwZf1rJ+Zr1gHQV/o/F90tnBVfvXI6m6gfqhVY03XRnQneGRblkkXzFfaixQPfwlFYpuA033aSePdHUmcAQ8d3Sd0gClOE2VDbUIWvfS4ungP9WpAIqL0hR6c1CNoadt26W1y8n3qoX6hU936HVr3xeXPvzusNHG/9SkMJx7TnTebE6rlBbpVDhIWcErnGhh+MfwxgTQDrTJv+hR8WnV2GG5hvDBCFQg575geXu72rTZyN5Lte5zblpdHjvi++Pqz7M5geDklsDqVZgM8lWs8vrAKwBpMP61nIjICJLcBlcJyAo3GoJzriu4wbbkvL4SOVdMnbaP2ZexgeZcJ+xStQJoqJfQMaPpzEbAkwXVhpke9sHMp611j3iJ+f7vYPYpzagrZBo0u4lCLWGBXDsOeDZONlNlBo1t7n3rB9crqjMyP04ouHNfsnSeA8ybbKqs3pl6oxWPk9ITU6PtVkBOMeTyKo/X6BwGnWE/fptFUcNOx1FcCPaeiM1DjTmDmcNJFZ6IZXBbeUBj/6RW8hZRMk/fFLYHxFhPBcHL0iuOAofKBKUspdCe1qytCNyMdfkm3to8/AxT6ZDc0PWnqRrhUflNU3hv+rRoSLwC4gOM7OlXnN/eCZV5/th+ozb1AF5/ptnvKyrn2SWeW0DcYvU4yUqFGQyRoaYdrJ0qkhXQFbjrQGzBnIpbqtDTHOUcN5cm3S7w/gtigFu2D5APk1iihrkU6CRnj6xuOfX2dZF7d5Z/fm5cE5gG+SYrDpjBbXWgOY1a5NvtY1o5ppiQHjiJWBPDYjTuMgKAQZ2gGod80Nfw5P4YfAapn7JCGL9eJTp35nkUnpgI13dFL8gyJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(366004)(39860400002)(136003)(396003)(6486002)(38100700002)(66476007)(4326008)(38350700002)(8676002)(2906002)(66556008)(36756003)(1076003)(66946007)(186003)(86362001)(316002)(6916009)(83380400001)(41300700001)(6506007)(966005)(44832011)(478600001)(8936002)(52116002)(9686003)(6512007)(6666004)(5660300002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EsKugH/sSzN+8/SsTuN6AfWzgNXj6tLDldSKgJEajJ0TbJwuH/l/ur4bNSJ3?=
 =?us-ascii?Q?yyhfaJB4aX/4daqs1UH917g4wMc1KHx1qZlnoTOjN9hPlKP3YMG92/g+/aeC?=
 =?us-ascii?Q?ACVeFBzrIHtD3ZhwnHGuxrw8pTto05f1AcqrEVm3xZC22UDoMj34z4I6Rlyu?=
 =?us-ascii?Q?AWXlMKb/01lbXapKk2gaWF8eALaI0NDTwGkFhbZCYSkBR9oFuxeO55tmH/rx?=
 =?us-ascii?Q?qk48GnEONvRH8rSCplJgYGqsvoA+H+jtjuUrCdAAjkkY7j6MJ5ABvRJia1Co?=
 =?us-ascii?Q?UFO2nMr1ZU2uvJ+W1zzyfexEaWLdbQdG7hOEgyVQY0JyB/TnG/0LuXLlwpUK?=
 =?us-ascii?Q?+kTA+5j0itwhy8cjwIK8rs/m5i2Ez1MxA9gnAquWLjW+QNGS7h58CiumNm1B?=
 =?us-ascii?Q?diA9YwF5hW4QS+iMYWVijtpvYMbYawsqmAHfzV/C/mccNmcgdeTI8pDWaHK9?=
 =?us-ascii?Q?3TJiOwH9rVqtgfQdmZH15koHCP2pukX4OaNVviXvYY40R7lUMDSBKqIKr7+k?=
 =?us-ascii?Q?e2PBWqOajVg5u84OOY6pv4oBTj2mQja8qP1fEjQ3l+GUQXZVgBYRdhi1HKsw?=
 =?us-ascii?Q?j6oDYzhkKWZNyA1ydvs3CU/b0QoV/cxUbBigoZmIOQAcuj59H6cvoYckm/RL?=
 =?us-ascii?Q?mH49iIfcdmv1Ti14LHPaTcGPzp2M9eEFb6RMw1PBy4Rpj1eloZbxbDVu5uQV?=
 =?us-ascii?Q?mQXwOV+pMWrmHwTfkYnEZsaliCQ7z7BeUS+8z3mZGMWlyJwycT126hXaFQK4?=
 =?us-ascii?Q?j31AQlYR08kE2ggSRov2YmBYa65K8TFE6mb0jkpbVUqH0/l/MxDiMUo6HqUL?=
 =?us-ascii?Q?Ia6JhWrZdz3osoP3N3l8gFZntSxrM5JABSOUz5QEH3HVD3Wjr8K5c67gK+Ob?=
 =?us-ascii?Q?2KrSXJhalhoTxrSPUbRguMgDuGZMLh+7SA//DBRbf8BLg7+b4kOmhjEA5qRq?=
 =?us-ascii?Q?2/vui9W76K+PtTK1mTJMZJ6zcorTpkBbLo4ZjlKw3Av8W2AftjKLOOKo9h7B?=
 =?us-ascii?Q?A6mnb8lf/M9eguupbO4hFBrEaMgDTn55fGjtHeDc3ScluFhrKCA0DmdJ/jIU?=
 =?us-ascii?Q?Ec3PI5thvZZH5HzDArnjwVQc00bpIzvbNiauZE/uAWijIgQVxpm6q7NFJltt?=
 =?us-ascii?Q?JORNofYIeaq0a470D5XPgGqc3cnJxOgq8r6PuuKlmcjlDRxr7m3eY97MPG9T?=
 =?us-ascii?Q?3+XiH4dQ2KIjiVPX902vvFL+lK+Uwjm7WEal5EDx1oWOFRaiCJhdiUDCYUGJ?=
 =?us-ascii?Q?s1ZJ/IVlEPOeitMI3oth+zYW2cjqfXWyWJxXjc1KQPhuM/YFa9NMf2MUkQzC?=
 =?us-ascii?Q?bExJdtsXQ0M8+o1gDx85QGfAhf3mzILrQ6s3HGPfvhwv1uRy9UOHykiAe0P0?=
 =?us-ascii?Q?KdVcAJWJ2B4GNnJeFZRqHD2M+9piHsA8joW9ZzENXRUCGF4izNyUM8vO6uE6?=
 =?us-ascii?Q?QUtyjAC3d/iLLYkuPiDD9/XPb6Lb5ocmyd1IadpROaC3acJkjrnDddHizjWI?=
 =?us-ascii?Q?GWCOIF6l7r9Pc1eo2S45ygdoCxc2H+zN5TJF10JAeSRdCF9i1SHVhhlD8eWU?=
 =?us-ascii?Q?rxKDLNsZse1/7K6KWx6+2vbvv1uL1YjQD2oLGkiZ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?qy2XLB48INODdNT6NnF45feuiaXIzWpwCaiSv2YzffNMR4bK2Bx94QOQg0Hj?=
 =?us-ascii?Q?gR3wF8nFAtaMjur8KAPQ50hypST5Isr4acGrUw4YLqcahiDiUZeADl6O2dsB?=
 =?us-ascii?Q?Ku/DFMb6sJ2BIGeHTOr1zRhZMAiarZa/Wy52UUdDl5ecybyYSMjCc2zgUyh+?=
 =?us-ascii?Q?muh9/IZ9od2kmVmlCeOv8cDzif6ck7Hy3H2QfJLFizwR+SKYCo2GOtwTxkyZ?=
 =?us-ascii?Q?+bbQFY+29SuqlFAlXywBgHvCIGBmXFPPVYfn7XSbqtHYz30yO3bSGDOPPd7s?=
 =?us-ascii?Q?5DSK/IL6+BBY96qmbupINqDUx2IM5HBUN1znftA3Fgn5WhS2rO8rweunQpU1?=
 =?us-ascii?Q?UXFs1x0oiqjRMxKOhmShJYqBcS7hpxEPXB9I7IPdLqaktaX5v3srycxZ8Ktq?=
 =?us-ascii?Q?gE0Kxys8pDsTICtKbzuRmZEnekiUG+2FH+pxXiMXg3K5ofA6PzvthormRf2h?=
 =?us-ascii?Q?TlmyMJUmkJpe9kFjIEe0ktz6nSL+aVu2v+karpBgajMc2mVgKP2T4wg6GTnC?=
 =?us-ascii?Q?su9LyeYuMuNbeQTlNZV2aNncUsAT14GajSXPLiB6PTN95SaYihrFc7/L4eTn?=
 =?us-ascii?Q?DuUvoxlZkuX9/vqh07R0AsS5JAQ0bvRcCW+Ul53h2zd/rqGi27atuo+bH6+d?=
 =?us-ascii?Q?G3bhzApfLmHUBxtR9jxQYYrY73tF6pYdBK74+9NhBJiNUomI50FSpw4a11nN?=
 =?us-ascii?Q?RvsEUCB+ja/VL6gokdShwIgjY/A1b2iPX/0O87JkSLrlH7di9RcfMhPt5OGv?=
 =?us-ascii?Q?OtqNfyjv2eSq9OTI+p+1ik8hCdfwXMHFSO39hajZ/W/7Uwav1o73LfUjvF9k?=
 =?us-ascii?Q?sY53nNJxT7oemEbEy5U7Ue6j1Lc2sjGJAjhXypNCeR5nK3NWL57HaTCeXw0p?=
 =?us-ascii?Q?1uxsgI6wAVrUXOFA7Lhiza0RLip4tl8mOztcEAKZjXvXMDae7amHUV3oP2r2?=
 =?us-ascii?Q?zNf7YrrNMj0twWp6Mil2W2qPvs/lM1e1JIme6ayW2NM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1569a902-bd4a-496f-a308-08da7e8aaa0e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 06:52:05.2050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AyyAoHWoTkITGpcQv618ow1d+tKPI1IUr06EQnAW2qHFCfo5aUaSXhviO6M37/5He0OAggKLcnuBXkctYJ5n+JrZDyHfFsWrLtwwROgYSVQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2488
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-15_04,2022-08-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208150024
X-Proofpoint-GUID: 2Z9PR8uYfb2IQxnlIT1nNkaHYZR5aggQ
X-Proofpoint-ORIG-GUID: 2Z9PR8uYfb2IQxnlIT1nNkaHYZR5aggQ
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
head:   69dac8e431af26173ca0a1ebc87054e01c585bcc
commit: c297493336b7bc0c12ced484a9e61d04ec2d9403 irqchip/stm32-exti: Simplify irq description table
config: arm-randconfig-m041-20220812 (https://download.01.org/0day-ci/archive/20220813/202208131739.gJvcs9ls-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/irqchip/irq-stm32-exti.c:719 stm32_exti_h_domain_alloc() warn: variable dereferenced before check 'host_data->drv_data' (see line 707)

vim +719 drivers/irqchip/irq-stm32-exti.c

927abfc4461e7fd7 Ludovic Barre    2018-04-26  692  static int stm32_exti_h_domain_alloc(struct irq_domain *dm,
927abfc4461e7fd7 Ludovic Barre    2018-04-26  693  				     unsigned int virq,
927abfc4461e7fd7 Ludovic Barre    2018-04-26  694  				     unsigned int nr_irqs, void *data)
927abfc4461e7fd7 Ludovic Barre    2018-04-26  695  {
927abfc4461e7fd7 Ludovic Barre    2018-04-26  696  	struct stm32_exti_host_data *host_data = dm->host_data;
927abfc4461e7fd7 Ludovic Barre    2018-04-26  697  	struct stm32_exti_chip_data *chip_data;
c297493336b7bc0c Antonio Borneo   2022-06-06  698  	u8 desc_irq;
927abfc4461e7fd7 Ludovic Barre    2018-04-26  699  	struct irq_fwspec *fwspec = data;
927abfc4461e7fd7 Ludovic Barre    2018-04-26  700  	struct irq_fwspec p_fwspec;
927abfc4461e7fd7 Ludovic Barre    2018-04-26  701  	irq_hw_number_t hwirq;
9d6a5fe1757cbbd9 Alexandre Torgue 2020-07-17  702  	int bank;
ce4ef8f9f2abcf10 Antonio Borneo   2022-06-06  703  	u32 event_trg;
ce4ef8f9f2abcf10 Antonio Borneo   2022-06-06  704  	struct irq_chip *chip;
927abfc4461e7fd7 Ludovic Barre    2018-04-26  705  
927abfc4461e7fd7 Ludovic Barre    2018-04-26  706  	hwirq = fwspec->param[0];
c16ae609214e8356 Antonio Borneo   2022-06-06 @707  	if (hwirq >= host_data->drv_data->bank_nr * IRQS_PER_BANK)
                                                                     ^^^^^^^^^^^^^^^^^^^^^
derefernce

c16ae609214e8356 Antonio Borneo   2022-06-06  708  		return -EINVAL;
c16ae609214e8356 Antonio Borneo   2022-06-06  709  
927abfc4461e7fd7 Ludovic Barre    2018-04-26  710  	bank  = hwirq / IRQS_PER_BANK;
927abfc4461e7fd7 Ludovic Barre    2018-04-26  711  	chip_data = &host_data->chips_data[bank];
927abfc4461e7fd7 Ludovic Barre    2018-04-26  712  
ce4ef8f9f2abcf10 Antonio Borneo   2022-06-06  713  	event_trg = readl_relaxed(host_data->base + chip_data->reg_bank->trg_ofst);
ce4ef8f9f2abcf10 Antonio Borneo   2022-06-06  714  	chip = (event_trg & BIT(hwirq % IRQS_PER_BANK)) ?
ce4ef8f9f2abcf10 Antonio Borneo   2022-06-06  715  	       &stm32_exti_h_chip : &stm32_exti_h_chip_direct;
ce4ef8f9f2abcf10 Antonio Borneo   2022-06-06  716  
ce4ef8f9f2abcf10 Antonio Borneo   2022-06-06  717  	irq_domain_set_hwirq_and_chip(dm, virq, hwirq, chip, chip_data);
c297493336b7bc0c Antonio Borneo   2022-06-06  718  
c297493336b7bc0c Antonio Borneo   2022-06-06 @719  	if (!host_data->drv_data || !host_data->drv_data->desc_irqs)
                                                             ^^^^^^^^^^^^^^^^^^^
checked too late

c297493336b7bc0c Antonio Borneo   2022-06-06  720  		return -EINVAL;
c297493336b7bc0c Antonio Borneo   2022-06-06  721  
c297493336b7bc0c Antonio Borneo   2022-06-06  722  	desc_irq = host_data->drv_data->desc_irqs[hwirq];
c297493336b7bc0c Antonio Borneo   2022-06-06  723  	if (desc_irq != EXTI_INVALID_IRQ) {
927abfc4461e7fd7 Ludovic Barre    2018-04-26  724  		p_fwspec.fwnode = dm->parent->fwnode;
927abfc4461e7fd7 Ludovic Barre    2018-04-26  725  		p_fwspec.param_count = 3;
927abfc4461e7fd7 Ludovic Barre    2018-04-26  726  		p_fwspec.param[0] = GIC_SPI;
c297493336b7bc0c Antonio Borneo   2022-06-06  727  		p_fwspec.param[1] = desc_irq;
927abfc4461e7fd7 Ludovic Barre    2018-04-26  728  		p_fwspec.param[2] = IRQ_TYPE_LEVEL_HIGH;
927abfc4461e7fd7 Ludovic Barre    2018-04-26  729  
927abfc4461e7fd7 Ludovic Barre    2018-04-26  730  		return irq_domain_alloc_irqs_parent(dm, virq, 1, &p_fwspec);
927abfc4461e7fd7 Ludovic Barre    2018-04-26  731  	}
927abfc4461e7fd7 Ludovic Barre    2018-04-26  732  
927abfc4461e7fd7 Ludovic Barre    2018-04-26  733  	return 0;
927abfc4461e7fd7 Ludovic Barre    2018-04-26  734  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

