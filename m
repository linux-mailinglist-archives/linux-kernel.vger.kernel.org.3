Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C85F596BA0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 10:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiHQIw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 04:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232929AbiHQIwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 04:52:20 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B037F120
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 01:52:16 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27H73wWI004028;
        Wed, 17 Aug 2022 08:51:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=QJ0YIkz2EFmuSdHcGclxWNQOsT1nuv36dymFgAufq/I=;
 b=Nf7vQaA8hCz+lkd0prUF5fUo2pHnUOR2fSWS7j6+HHStOGTcpNV72tXnEamCt4kuMBlR
 eZK1JB7J5gouRGz3YHtn40tUKGaDYCKKL+F88q9Y5yPNw8cuIXQ4BO6ozk5aS9sf6/x2
 XkrDA4UHbHEBEEq1YbRefMt1+zOVFTDWyTcCSQHm8yX7x1LBe8XUrF021nFsMn3BU2/d
 vcPMySSS+3ikbDtSLh4DKSAk9X/YDe2N5IlzkDESKmSv5M5/cl/oOGKW2uOkDOggR63I
 m0yTJG0XKE/zcb2cg2dsfQ/disz3QbpdrGJhV673aXFtQ1s6JC+i/TM805ynK1YAA3mF Dw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j0nms0rg9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Aug 2022 08:51:14 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27H8cb0k021480;
        Wed, 17 Aug 2022 08:51:13 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j0c47m84t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Aug 2022 08:51:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BFcWYK9X06F8Eo8qEb539zhsFp7dPVMbj4ZtXypdIHuRBixPGSNneU8OpGHpDBfC2lF9B1i8p0psGwaWR2EASqQAcsixGwO4JPPMMbysdE2pYUK6avrbCNgKZwMJ8/85FpHpusYgYr8ug6gQiVpfObGvWVEcuusuQS/2cikiJH9IqulqgCmwQIXD5RYYLnxR+sSzpGWbfKuUuyiNODi7x5rs8s/FuAJFf3hjxXp7FjPod69tqZWufuxyHeLjt7vh8yMAA+v/807D/5Mf4DESa55cJj99ZfNhgeB8mrrLh1LWn2L+2X8x1ibhxBnMRdH/BwvD6SN8NKeFykgLNERkjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QJ0YIkz2EFmuSdHcGclxWNQOsT1nuv36dymFgAufq/I=;
 b=JO2/ZsBpbMmiVrO0oUOwZDpdtGy1eyZzb7rNTDN4W5YSRux+NwtK0cAT8GibT28xU+Yd8zSBxN+3eEmo9pFBstaB+ChN8zm/JuX48p0MWV+h/mNN9ERX/1hatoa7i46YnVxEZoDpRELF52frQND4C43GAazCuHAFDWFXUxDpveNhhzctCf+kLWmxzjGb8MKZ5ZdqpV0Reqgo3xztGeLRtZHAFnp6mmqUDT74Foooo62fM6+87RhXNIcXzcvUypv6TN+timQbAPhBqE4RVhp3L1Iy/HI+jO8+QzvGN2K5nP3LFQin6CPjqjK9Z4BsDHgdmGc3MYh5uOT80XcDfmRwkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJ0YIkz2EFmuSdHcGclxWNQOsT1nuv36dymFgAufq/I=;
 b=nUthQxJxXN5jZ+lk9UaERRD7JF24GsSy7WEQ0/ZWyDvCc44JEWWxTZk4+JQmm8rHMEraXi8nbECL1bRAg33wrXX0YLAcGfQP/Ak7GQCJpVDgvZfT88D4Ya5zv07Xvo3681+rQTuGvyfnn1CfSc0Hoba2VBrJ/Aktxz5qAHOQvgM=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN8PR10MB3603.namprd10.prod.outlook.com
 (2603:10b6:408:b9::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Wed, 17 Aug
 2022 08:51:10 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5504.028; Wed, 17 Aug 2022
 08:51:10 +0000
Date:   Wed, 17 Aug 2022 11:50:58 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Zheyu Ma <zheyuma97@gmail.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Subject: drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c:6771
 rtl8xxxu_probe() warn: variable dereferenced before check 'priv' (see line
 6665)
Message-ID: <202208162305.WUMVi6BN-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MRXP264CA0004.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:15::16) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c42f55b-f37b-4939-66bf-08da802da1b6
X-MS-TrafficTypeDiagnostic: BN8PR10MB3603:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ek+EACE77u1GwcTfPe9VlWy9YtsFkCdGCvhQqYPeTMNoQ/ug60cOKpJ2vvqkBC2ZsMxzaXTnQzsWu3gFJtrhilAYVerVryUa3efekm/7iUwZkW0eQDbYLWXIF10VKtlHNZkI77HpzY9VxmJzVHDTD50FPVsrKMw0lSUsnUgf8iJjBmHVVJEU18ewgiLHk/l3TcTNWySNZLgc6k1AgtlpC/NUaaq9Y+jS1/8Qh33SfM0HHb1L/aGcW3LzqB6yLuEWVhgFw8GmWSaJx9HDXxvnxXC4vWb+otFPKF3FSiaQGKVTAeejo6fhfwd99W9NGq76E/+jqN68MOXmoVsiefDNDuZrPwrLgAngczIUmH1lMqiQBAy22nLQulbOCQPY82uv6vobxxqbaEa0+Thh29hTTfUFFgCYVKBp0PrXI758ZwyNDMnRdhx9DH12JV06mGb8wi+ySUqSNcTZBjwhllY9NnBmSZagMiFb4dfvG+FHR2ugdMRRo3gqy4Jwxd8aZRIxpCs5eq1hs+jZfxj9BL2MKGkgFrI/b7oX0CYFQqenwRUppHWIz/wa1b02MMK4cFk+OSBeioVi9ulrIlzbAjgd8MsXcfc4WqLYZsfZAjJWY9JYy+yVIomenBV1B8OeqRpuL6jz+isYef9YrcXSu5HhH+jmbBYm2KTSuEX8Kxy+OUXsh793KYxZRzHFV4bD+Qpy0hPWbXnjp2tCNms9EQpuIwoNSmDehqX7KdmATRW+HonarQPU9At9fynjAuIBZvG110G5QkMVrJ9yJDgGx9fdSQl04nWj93L4bYfOgt7vuxVb95Qorr/dChC0UuZBXvyG0cQ+74B575nkeIq5y8T9v+2vaWtqozkHedzkIE3O9Es=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(39860400002)(396003)(376002)(346002)(136003)(4001150100001)(86362001)(186003)(36756003)(83380400001)(52116002)(9686003)(6512007)(1076003)(6506007)(6666004)(316002)(38350700002)(478600001)(966005)(41300700001)(66476007)(30864003)(66556008)(8936002)(66946007)(8676002)(5660300002)(2906002)(6916009)(26005)(44832011)(38100700002)(4326008)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I3BUF99+s5mHOTdI3aimUkWVMdGGGdOtmJOlcTZn6zZqPTixtqij19GK3/iI?=
 =?us-ascii?Q?2tpZUDZZlJgqiwSCSoQINzvwY5FOmHAh9DhqImzd6SpemClHsURdPrGL6qjx?=
 =?us-ascii?Q?oZu0WPUMN2nmpqcS8iGB8Sw3JyuHJvue5j6160pl9lhodLcald+ooXQ1ECO6?=
 =?us-ascii?Q?R7mGs8Y1kvs1iw+80V9hbKoWtpZZw5uZUPtBLZ6tjPH5FUx3MLol2nqOY+Kk?=
 =?us-ascii?Q?TxzoOk89oBXN04TysBbfxgEVNy22WIjV9xO/mxZIr9JrRw+r+hAGgQAO0jDx?=
 =?us-ascii?Q?fr9IDzEpiNK0wNhgM0WY5YTOZBONfvlI/SaNlAYaYOCnf/2oWsb83dAVLktt?=
 =?us-ascii?Q?Ilwlkg40FFKxx5vIk+TN+YoOEQzu+Z+XuhxrCOHegWCbCYm455sJD4zbwSU6?=
 =?us-ascii?Q?icH9EA5PUqzYkkkxnJLXsu0LZQmwb4Cg9h3PVcTkkly6P/pbtDuzAeYY4SZU?=
 =?us-ascii?Q?9QfvNcB5lRkLu5fsUlPCUXDY4n5wGhEfW/LDYqKk2wa/GUE+aSwJ/2iBDYn5?=
 =?us-ascii?Q?QTwViZM/RHOOUO1i2HelDs499IKpsb9lJ4QAOZqMkvgW9sNFaVtBIx2zcfwa?=
 =?us-ascii?Q?mtBqJc6Y2hY/LuPJdjHTYmea/IaE3OgLVe6BB9VZLQDDwnzP9uBTBjHz9Ss+?=
 =?us-ascii?Q?SZgpJ4YW+rGVCCSvdYd8k5ODo9npHdtYbQq2FI0KNG3mAzMo7MYinUirtNmi?=
 =?us-ascii?Q?+MZVPZEXwkA0f5m62/iZ8o6+hkSOGuVhSblfB4i+/YGIf+8QUwQ9TlS7zlKD?=
 =?us-ascii?Q?dwol1lWsJl+CjVe9zns6tvMg7FLvt/0uhFmDANGXwvz/Z98Ly7oGfr6LYiMr?=
 =?us-ascii?Q?rj/gAH3pyKiDEQqwquEgiqciAR3mkl70QxyMANKxp2uWmKYgI01LZUHIz6f7?=
 =?us-ascii?Q?PTJG4d9UQovazeFl13NBThCTddZjo/BwSCVrjpInLR0+y2cUJEnNsUy670Tu?=
 =?us-ascii?Q?kEpzA+fdzcEaX4RYaZfHiEoXdASzSpJiT+oSiBKePBsqJ7KVqxobG3y4Nwz+?=
 =?us-ascii?Q?8wxpu72+LIb8mB+oZpPlDuM/MsQsDVIK5WorVaPzu0UUCzgRK3Lanb0nuBAU?=
 =?us-ascii?Q?Ts8T9P2MLMmlA53X5JVTvey/O2MsVIjZuu2VE1Sj9YKzJX/K6jjLmeBcU/Y1?=
 =?us-ascii?Q?112w6QaFPHcOoJI4qfXIxQeEhpjD3L4Qz20wuiJUPrkrhJDlTFDoWK951nxv?=
 =?us-ascii?Q?pLvRwckkXuZU5mrQ704PU/C3wAwgjMeNCCiKXFcnIlzL66EvsUUi8cooAjg7?=
 =?us-ascii?Q?ywSpFmN14InaJKkDEek2ePEbK4Y/xT9h+VTGKAytGUVDlgt2AdocfitCr9Ft?=
 =?us-ascii?Q?rEnppLATU4pnJT7gNBX6uuQmxbyWCM2f/rSeN0ucx+nw4mhbbU7lKSpX2J4O?=
 =?us-ascii?Q?2AWlDNtrgIf/Q9SnknEKuv6KPz1TQKszISbQTwK4H92gEEaMLMrf205aXp8O?=
 =?us-ascii?Q?xQnORPcwqF/EkHC9s19KafHmPNJihPhEfyTN9NDV71bnX1bN+AN2dItOtxDQ?=
 =?us-ascii?Q?PLJlZ8M+93NF7zAlMMHMmK06+swe07r8JNBxKRnmk6Zz/vkbYLzzoCbeBnXk?=
 =?us-ascii?Q?qyBGJfTB8R/czE6eL93Yy1r1Tt+ULXUHmHMmKycY?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?N0giq8cFX+iVGOs5RIp1qXt+EoH5u2zsgdylJPynxmxPhEPp7C5r8LVTYM08?=
 =?us-ascii?Q?4dZBwU4vgtjOCY2HwWGO2Fm14ivrdeGg+xwhaaYt3SiZk+lcsxT+EaeAI3jy?=
 =?us-ascii?Q?Ys0aqID+4x+4q6wZqdWu+M3CAvGEzYzqiHsDM3c6a2wr8+dimpGHabsKGMhT?=
 =?us-ascii?Q?Rc/kLqcoE9izoPu4P/Y2GpG5en2+4urr9cA91ZYXdOa/wge3c64I/Z1UCf1H?=
 =?us-ascii?Q?22GgDLkXAFA3ZQLb9c4t/glVYE0ICprC+sEkXrsDzEuELF34CGhD7u5rp3vu?=
 =?us-ascii?Q?fphn/Ax4fhg3BhRM5Kixwt8gS9wS2TJalHz78E9uYWAGEWqTdYOZdqGQ6NGS?=
 =?us-ascii?Q?gJgbgFO/2/ZJ3olJLDKpLpqX6+dYqAyaFuLyr/p06N3m016b0hEbAc4NjDRj?=
 =?us-ascii?Q?r7ofHnv9i8dBTA25ZASMFaEtQZEeYZJkFnvSO3WmcK7h5mA7HbveFXIeJUs6?=
 =?us-ascii?Q?YJW0PwgF7xuvqUXRDOU8/NZ0MXfk/SXos6J8vBIAVjh60Lc6o//WNNr+tX7f?=
 =?us-ascii?Q?MuieKiY0lUmpEqsijpEJi3Ca3Af0npt+RUzQ2aHlGMgNs7rez83QnIhdHtwc?=
 =?us-ascii?Q?xXhlLh7fxScK/Rnb4WFNOV1IAaM6BwNkYGHSRqchA59II79/EFsCwBRjgZDY?=
 =?us-ascii?Q?7ySrE5mzIRjSRnVL/axyoCkew8Vygj6Xv6o8n6JXKrbgDQS0QloIhi0uqi3L?=
 =?us-ascii?Q?Oh63UqoQAfkCIv5OK89PjddKFg6NKfgwcLo1UEuDR347NY2k2PLZPS19BRxO?=
 =?us-ascii?Q?X/XC3JhAG9lMtAynJ8KGMSmHb07hkq6Oo9Y9+9QA0lVD5VOtZL/6be4LNRBW?=
 =?us-ascii?Q?gtlxHgWp3RhqInHLHL4oUx1/B6ukcER0SJN6d8MMfcmmQlk+m3lPtKNRakFL?=
 =?us-ascii?Q?u/On4u+amPFiXL6HrjB7TCLy3hTLiOvIAvLNQDTxWH7Y9U1VUOAAXfTjwBfn?=
 =?us-ascii?Q?/Ue8RKuk6/KlTGcztPtMPlEoc8WKeaEwdgyjDJGWnR4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c42f55b-f37b-4939-66bf-08da802da1b6
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2022 08:51:10.4440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dxyd/7xwiXRg/M3jPYzDqRi0QPnR0F4uhhM+ei2Z23sXsEu9cmFtGxCdwvhiBvuxLjn/YvvhP5kpd9ZRa3bPxt/fG2Ij0oCuSgcxcs97x2s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3603
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-17_05,2022-08-16_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208170034
X-Proofpoint-ORIG-GUID: W_RNp_fpxoWyWMKLIlJue2avUFeXDXZF
X-Proofpoint-GUID: W_RNp_fpxoWyWMKLIlJue2avUFeXDXZF
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   568035b01cfb107af8d2e4bd2fb9aea22cf5b868
commit: 13876f2a087ad352bf640a7a0a4a4229ea6e9e4f wifi: rtl8xxxu: Fix the error handling of the probe function
config: ia64-randconfig-m031-20220814 (https://download.01.org/0day-ci/archive/20220816/202208162305.WUMVi6BN-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c:6771 rtl8xxxu_probe() warn: variable dereferenced before check 'priv' (see line 6665)

vim +/priv +6771 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c

26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6600  static int rtl8xxxu_probe(struct usb_interface *interface,
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6601  			  const struct usb_device_id *id)
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6602  {
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6603  	struct rtl8xxxu_priv *priv;
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6604  	struct ieee80211_hw *hw;
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6605  	struct usb_device *udev;
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6606  	struct ieee80211_supported_band *sband;
deb6176e561324 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c Jes Sorensen      2016-08-19  6607  	int ret;
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6608  	int untested = 1;
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6609  
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6610  	udev = usb_get_dev(interface_to_usbdev(interface));
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6611  
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6612  	switch (id->idVendor) {
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6613  	case USB_VENDOR_ID_REALTEK:
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6614  		switch(id->idProduct) {
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6615  		case 0x1724:
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6616  		case 0x8176:
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6617  		case 0x8178:
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6618  		case 0x817f:
d607e396566a10 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c Jes Sorensen      2017-01-17  6619  		case 0x818b:
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6620  			untested = 0;
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6621  			break;
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6622  		}
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6623  		break;
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6624  	case 0x7392:
408f122a1f9230 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c Jes Sorensen      2019-11-12  6625  		if (id->idProduct == 0x7811 || id->idProduct == 0xa611)
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6626  			untested = 0;
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6627  		break;
e1d70c9b04000e drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2016-04-14  6628  	case 0x050d:
e1d70c9b04000e drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2016-04-14  6629  		if (id->idProduct == 0x1004)
e1d70c9b04000e drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2016-04-14  6630  			untested = 0;
e1d70c9b04000e drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2016-04-14  6631  		break;
b81669b9e0b486 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c Jes Sorensen      2016-08-19  6632  	case 0x20f4:
b81669b9e0b486 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c Jes Sorensen      2016-08-19  6633  		if (id->idProduct == 0x648b)
b81669b9e0b486 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c Jes Sorensen      2016-08-19  6634  			untested = 0;
b81669b9e0b486 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c Jes Sorensen      2016-08-19  6635  		break;
76a8e07d49b652 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c Jes Sorensen      2016-08-19  6636  	case 0x2001:
76a8e07d49b652 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c Jes Sorensen      2016-08-19  6637  		if (id->idProduct == 0x3308)
76a8e07d49b652 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c Jes Sorensen      2016-08-19  6638  			untested = 0;
76a8e07d49b652 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c Jes Sorensen      2016-08-19  6639  		break;
690a6d268bdf85 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c Jes Sorensen      2016-08-19  6640  	case 0x2357:
690a6d268bdf85 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c Jes Sorensen      2016-08-19  6641  		if (id->idProduct == 0x0109)
690a6d268bdf85 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c Jes Sorensen      2016-08-19  6642  			untested = 0;
690a6d268bdf85 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c Jes Sorensen      2016-08-19  6643  		break;
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6644  	default:
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6645  		break;
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6646  	}
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6647  
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6648  	if (untested) {
eaa4d14c97c199 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2016-02-29  6649  		rtl8xxxu_debug |= RTL8XXXU_DEBUG_EFUSE;
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6650  		dev_info(&udev->dev,
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6651  			 "This Realtek USB WiFi dongle (0x%04x:0x%04x) is untested!\n",
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6652  			 id->idVendor, id->idProduct);
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6653  		dev_info(&udev->dev,
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6654  			 "Please report results to Jes.Sorensen@gmail.com\n");
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6655  	}
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6656  
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6657  	hw = ieee80211_alloc_hw(sizeof(struct rtl8xxxu_priv), &rtl8xxxu_ops);
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6658  	if (!hw) {
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6659  		ret = -ENOMEM;
deb6176e561324 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c Jes Sorensen      2016-08-19  6660  		priv = NULL;
13876f2a087ad3 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c Zheyu Ma          2022-07-16  6661  		goto err_put_dev;

It you wanted, you could delete the "priv = NULL;" assignment.  It's not
used any more.  I think it will cause a dead store (unused assignment)
warning on clang.

26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6662  	}
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6663  
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6664  	priv = hw->priv;
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14 @6665  	priv->hw = hw;
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6666  	priv->udev = udev;
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6667  	priv->fops = (struct rtl8xxxu_fileops *)id->driver_info;
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6668  	mutex_init(&priv->usb_buf_mutex);
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6669  	mutex_init(&priv->h2c_mutex);
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6670  	INIT_LIST_HEAD(&priv->tx_urb_free_list);
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6671  	spin_lock_init(&priv->tx_urb_lock);
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6672  	INIT_LIST_HEAD(&priv->rx_urb_pending_list);
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6673  	spin_lock_init(&priv->rx_urb_lock);
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6674  	INIT_WORK(&priv->rx_urb_wq, rtl8xxxu_rx_urb_work);
a9bb0b51577835 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c Chris Chiu        2019-10-02  6675  	INIT_DELAYED_WORK(&priv->ra_watchdog, rtl8xxxu_watchdog_callback);
e542e66b7c2ee2 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c Chris Chiu        2019-10-05  6676  	INIT_WORK(&priv->c2hcmd_work, rtl8xxxu_c2hcmd_callback);
e542e66b7c2ee2 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c Chris Chiu        2019-10-05  6677  	skb_queue_head_init(&priv->c2hcmd_queue);
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6678  
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6679  	usb_set_intfdata(interface, hw);
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6680  
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6681  	ret = rtl8xxxu_parse_usb(priv, interface);
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6682  	if (ret)
13876f2a087ad3 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c Zheyu Ma          2022-07-16  6683  		goto err_set_intfdata;
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6684  
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6685  	ret = rtl8xxxu_identify_chip(priv);
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6686  	if (ret) {
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6687  		dev_err(&udev->dev, "Fatal - failed to identify chip\n");
13876f2a087ad3 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c Zheyu Ma          2022-07-16  6688  		goto err_set_intfdata;
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6689  	}
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6690  
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6691  	ret = rtl8xxxu_read_efuse(priv);
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6692  	if (ret) {
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6693  		dev_err(&udev->dev, "Fatal - failed to read EFuse\n");
13876f2a087ad3 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c Zheyu Ma          2022-07-16  6694  		goto err_set_intfdata;
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6695  	}
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6696  
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6697  	ret = priv->fops->parse_efuse(priv);
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6698  	if (ret) {
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6699  		dev_err(&udev->dev, "Fatal - failed to parse EFuse\n");
13876f2a087ad3 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c Zheyu Ma          2022-07-16  6700  		goto err_set_intfdata;
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6701  	}
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6702  
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6703  	rtl8xxxu_print_chipinfo(priv);
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6704  
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6705  	ret = priv->fops->load_firmware(priv);
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6706  	if (ret) {
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6707  		dev_err(&udev->dev, "Fatal - failed to load firmware\n");
13876f2a087ad3 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c Zheyu Ma          2022-07-16  6708  		goto err_set_intfdata;
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6709  	}
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6710  
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6711  	ret = rtl8xxxu_init_device(hw);
deb6176e561324 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c Jes Sorensen      2016-08-19  6712  	if (ret)
13876f2a087ad3 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c Zheyu Ma          2022-07-16  6713  		goto err_set_intfdata;
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6714  
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6715  	hw->wiphy->max_scan_ssids = 1;
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6716  	hw->wiphy->max_scan_ie_len = IEEE80211_MAX_DATA_LEN;
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6717  	hw->wiphy->interface_modes = BIT(NL80211_IFTYPE_STATION);
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6718  	hw->queues = 4;
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6719  
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6720  	sband = &rtl8xxxu_supported_band;
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6721  	sband->ht_cap.ht_supported = true;
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6722  	sband->ht_cap.ampdu_factor = IEEE80211_HT_MAX_AMPDU_64K;
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6723  	sband->ht_cap.ampdu_density = IEEE80211_HT_MPDU_DENSITY_16;
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6724  	sband->ht_cap.cap = IEEE80211_HT_CAP_SGI_20 | IEEE80211_HT_CAP_SGI_40;
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6725  	memset(&sband->ht_cap.mcs, 0, sizeof(sband->ht_cap.mcs));
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6726  	sband->ht_cap.mcs.rx_mask[0] = 0xff;
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6727  	sband->ht_cap.mcs.rx_mask[4] = 0x01;
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6728  	if (priv->rf_paths > 1) {
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6729  		sband->ht_cap.mcs.rx_mask[1] = 0xff;
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6730  		sband->ht_cap.cap |= IEEE80211_HT_CAP_SGI_40;
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6731  	}
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6732  	sband->ht_cap.mcs.tx_params = IEEE80211_HT_MCS_TX_DEFINED;
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6733  	/*
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6734  	 * Some APs will negotiate HT20_40 in a noisy environment leading
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6735  	 * to miserable performance. Rather than defaulting to this, only
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6736  	 * enable it if explicitly requested at module load time.
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6737  	 */
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6738  	if (rtl8xxxu_ht40_2g) {
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6739  		dev_info(&udev->dev, "Enabling HT_20_40 on the 2.4GHz band\n");
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6740  		sband->ht_cap.cap |= IEEE80211_HT_CAP_SUP_WIDTH_20_40;
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6741  	}
57fbcce37be7c1 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Johannes Berg     2016-04-12  6742  	hw->wiphy->bands[NL80211_BAND_2GHZ] = sband;
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6743  
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6744  	hw->wiphy->rts_threshold = 2347;
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6745  
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6746  	SET_IEEE80211_DEV(priv->hw, &interface->dev);
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6747  	SET_IEEE80211_PERM_ADDR(hw, priv->mac_addr);
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6748  
179e1742569620 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2016-02-29  6749  	hw->extra_tx_headroom = priv->fops->tx_desc_size;
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6750  	ieee80211_hw_set(hw, SIGNAL_DBM);
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6751  	/*
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6752  	 * The firmware handles rate control
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6753  	 */
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6754  	ieee80211_hw_set(hw, HAS_RATE_CONTROL);
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6755  	ieee80211_hw_set(hw, AMPDU_AGGREGATION);
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6756  
ae44b502669d0c drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c Andrew Zaborowski 2017-02-10  6757  	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_CQM_RSSI_LIST);
ae44b502669d0c drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c Andrew Zaborowski 2017-02-10  6758  
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6759  	ret = ieee80211_register_hw(priv->hw);
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6760  	if (ret) {
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6761  		dev_err(&udev->dev, "%s: Failed to register: %i\n",
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6762  			__func__, ret);
13876f2a087ad3 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c Zheyu Ma          2022-07-16  6763  		goto err_set_intfdata;
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6764  	}
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6765  
deb6176e561324 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c Jes Sorensen      2016-08-19  6766  	return 0;
deb6176e561324 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c Jes Sorensen      2016-08-19  6767  
13876f2a087ad3 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c Zheyu Ma          2022-07-16  6768  err_set_intfdata:
deb6176e561324 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c Jes Sorensen      2016-08-19  6769  	usb_set_intfdata(interface, NULL);
deb6176e561324 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c Jes Sorensen      2016-08-19  6770  
deb6176e561324 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c Jes Sorensen      2016-08-19 @6771  	if (priv) {

You can delete this check now.

deb6176e561324 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c Jes Sorensen      2016-08-19  6772  		kfree(priv->fw_data);
deb6176e561324 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c Jes Sorensen      2016-08-19  6773  		mutex_destroy(&priv->usb_buf_mutex);
deb6176e561324 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c Jes Sorensen      2016-08-19  6774  		mutex_destroy(&priv->h2c_mutex);
deb6176e561324 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c Jes Sorensen      2016-08-19  6775  	}
deb6176e561324 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c Jes Sorensen      2016-08-19  6776  
deb6176e561324 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c Jes Sorensen      2016-08-19  6777  	ieee80211_free_hw(hw);
13876f2a087ad3 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c Zheyu Ma          2022-07-16  6778  err_put_dev:
13876f2a087ad3 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c Zheyu Ma          2022-07-16  6779  	usb_put_dev(udev);
deb6176e561324 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c Jes Sorensen      2016-08-19  6780  
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6781  	return ret;
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6782  }
26f1fad29ad973 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.c      Jes Sorensen      2015-10-14  6783  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

