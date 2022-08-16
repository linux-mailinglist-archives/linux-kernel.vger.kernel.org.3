Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2427D5965B3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 00:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237801AbiHPW4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 18:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237785AbiHPW4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 18:56:07 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B5E65247
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 15:56:06 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27GL9NXW013576;
        Tue, 16 Aug 2022 22:55:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=QLlYcC1O2LlMn6Ta5nyPtMUbVStS6Z+1nX0C4xQ/Nt0=;
 b=E8Cq2XzbPNDkqDVxOVcWnoCcsW5FG3ouifARR+j0lpMrBivsYTZ9ou1fPfr3Tw8pFqwM
 QOLBvWROPocBimqBt6cjhp7UnSkbSzXgr2h22LdvtiCfUBobfs+vksJCpOpiCg/JVfyn
 oLaNyuNqW+Z5rKWqij3TPhgznVhBFxNqUK/ZyDRfaL9H0SpTDaoS4ECFejBD0yweiHIf
 sTncIzA3wxHtYjoJ1keIC87YaNXZx5d5LXiwudK2vh0QubB8O9zWoxvmbfpyjfll8dZF
 ra6Te4+rGt1fpZN9IfPvdTROykH+kyCdpHrv5fONO2BZUrld4nVpzA4f/6oHwhV45FtH kg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hx2j0qc8q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Aug 2022 22:55:57 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27GL03bq005111;
        Tue, 16 Aug 2022 22:55:55 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2045.outbound.protection.outlook.com [104.47.74.45])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j0c4782r5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Aug 2022 22:55:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LkNAJ6AGfCNc1rc8CYgmJp8eeCNzexuVBTNRyoqsOtoI/GyjM7UJyi2ZwFf76hl3MXLW6jCQdNeyLARcy6olMkL8c1TPkIUi7L4iG8I9v43ZTBs5bSquxGrBtJY7aVTfQOHzHT0FsHanMtEVDLf6hlrgU4lYvD728/+6Xa7Oub8OrfX5EkxGs9FRskbKXeSVbLP8bx0Q257SV5fSK4nhQSpPpJ9EmRjYMthfKdtdf7fSejUr7JOVTyoJ0ATNHjRDwGjZjP+EY+9AEiVH/oq+VtCPofBCMubUHtpAp8DPbvsVaA7QL/vckFprGFKSiJxcBdu6Tcvsr113iSsARS03Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QLlYcC1O2LlMn6Ta5nyPtMUbVStS6Z+1nX0C4xQ/Nt0=;
 b=fcY5wzQpVJGTWhoocaHlMYCTNgPP58oS3fisy2Sn8TxXQE2wBw2zye05CojE1LIVg+dKAoYoWMwO0hZhHv3qcOyrQ/FT5wE67BxOYZ0bAHwQnfygry5UflGCrTN9YmvXremuaN9RoV8MHdIwuKCLdCWAu9yLQW/ZcBFrTxnenJUzw2Zfb5dOytM5dTMu8MCr1oPMnXoREJDtjJgDeMivmKjA5OAz8S2atDXUMJlcZvf6iJXkjfLEGy7UDeGeQZeQj52ugJAyQamWKk1+QKd5yGZ72//94XlOILtYKmMyIcFiVU89oq4i2eRwbNstS7hm6qNFXLSCQwHmRb0tPgYW+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QLlYcC1O2LlMn6Ta5nyPtMUbVStS6Z+1nX0C4xQ/Nt0=;
 b=KTUQFdGutfXtDdYWlJm7FMCEb1pDxcQGV4kIGVDanswC2UYGv1mqlBKRcA81jHVnzfotPiTQE6vxMziofKxf8P0KlpNJQ2Emx/sRL2pPuY/boUJxsepYmqJ+x4e8RaR0VKI69dhl63yYSXln73VkfdPybvQLHnOtBcvDRb3fLxM=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BN8PR10MB3601.namprd10.prod.outlook.com (2603:10b6:408:b6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Tue, 16 Aug
 2022 22:55:53 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0%5]) with mapi id 15.20.5504.028; Tue, 16 Aug 2022
 22:55:53 +0000
Date:   Tue, 16 Aug 2022 15:55:50 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] mm/hugetlb: fix WARN_ON(!kobj) in
 sysfs_create_group()
Message-ID: <YvwgdkHdzOQSCfmh@monkey>
References: <20220816130553.31406-1-linmiaohe@huawei.com>
 <20220816130553.31406-3-linmiaohe@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816130553.31406-3-linmiaohe@huawei.com>
X-ClientProxiedBy: MW4PR03CA0206.namprd03.prod.outlook.com
 (2603:10b6:303:b8::31) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76482dee-6f92-4b00-04ef-08da7fda78ef
X-MS-TrafficTypeDiagnostic: BN8PR10MB3601:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xtsPXPusGj3RwtEZOKuyi2mPUURVPQT5DEBg4x7tqv4BCteSa5CLXu6lNTCRYDz8Su1iNOMkld7qm9r75tPraMMNR6D7g825a2BDRj5Fir5ebMAgA/iG4cBEsDuxZDN8JyGc4T8pFueHdUvCPykOa+OKwoPGXE9s/XVwrY0eZpki5X8ipfcNDsVA1GfW7CtBl7ix32f6vSPrKXIivq13MleiML54lHphN27AZdI5e/GHpWBKNkoeiHcnFoNz/rAqiKFJp34rQg8LZKkrk9VRgj22vx2NQE+yLQmoQNWObkhCvW7O7ZXTbbumTHG21Ccv/UdbtKpYFOoA4NwmEm3DLjhPfdnbYMYwV629i74ekKz6QS8GRI8j5NHe6aja1Jci8A2/3uTauUlZh5pKRDcfwAF6OmHFwxPw6cXKB0WUZ1GhiBxOL2FffVBs/5+LN1eCw+JY6lUorHH02fHoow77Fd0HgTZ/vG7qkCLRbtQtWUC4RbuJShzuxRcBNd0EwdEPGxDVzbuueGRsfsOB/hkK5hB5N1MJKT/r7Py4tSEntZUhhjSONCJiHhv7ArUMw/3fEFvxaswpw9JfxQNUlPXgt/7gVXBhqICzYL3gCRkECgq37b5N0R3P4DhnOlqdkpSvylqCMyWnxoDLOz9zDfCsF+PguQsTxbbUf3sVH/2f8zC3JMRLzQD4hP9jCSlpE+ytIuad/u8x3CYQ0P+MPXBIpEC6cR/+lQBIWUox7tkwAlTVFoRVIOP5Oew9ss/fBOpU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(136003)(376002)(366004)(396003)(39860400002)(6916009)(44832011)(5660300002)(316002)(66556008)(41300700001)(9686003)(4744005)(86362001)(6506007)(66476007)(8676002)(6512007)(4326008)(53546011)(2906002)(8936002)(26005)(66946007)(186003)(83380400001)(478600001)(38100700002)(6486002)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VBIMlZuI6Zo1I12kZhIE4H/DBLHmOrM3znB/4Ki9rNbwnzJjw6lWBUS6iU3p?=
 =?us-ascii?Q?Mu7c1CVPRRxH0WVtOJD1e51FwVkLvz9ihMHlhVTNk4VIbAdHNNlWHOFw+26K?=
 =?us-ascii?Q?FQ50BkwvRCv+wkVP7bmTpWxwoTsLcoJ9ZtkP+39CzPkceaeIT1VfMWUIGcKs?=
 =?us-ascii?Q?8Jmi9EzC3c1LfFKGQ7+s1iPC57oWFVucQxwwDoATNElygcvu1lOBIT9Krx4k?=
 =?us-ascii?Q?oywatJHvz6afLmtSk04ostKZzbFVY/tLSl9MB16GMslVdzinCxkYmw+TadnX?=
 =?us-ascii?Q?MHO4i2uvWvX0FAc2dEb0gzk9OiwQh+aPecIqGSwX1l/nZfUOJCJMPLnWorCP?=
 =?us-ascii?Q?ivDPWXb/dDHKJbyXoK3yaZKkG86LnHOzwYCBLnGDwHegJvVtde/NYPdCOiCm?=
 =?us-ascii?Q?jnHkomcZYTrlQ15UYOTBX5rJcG/nLrJQQQGDbtcof+Nwx1lDCI+7AQOIWXlp?=
 =?us-ascii?Q?mDJkk+XapyMII2oKOajOC+EuVhmYzjf04zMNF9biBY3vtZu+mYbkPbQ9w/bu?=
 =?us-ascii?Q?blQTe6kRtl9n2bM06zck7Fi+lRGABDCo/I5gQfGGi7yevqkgC7x4HIhQrwt2?=
 =?us-ascii?Q?nDMW/CNNPuRpooFDWi1Sr9q7SC0qmMD9LuwlpTMuzL+v8OgsgGVhZVetUkrM?=
 =?us-ascii?Q?7OyKgKYM3+YvLXrAzi48TVjKQ5r00u+tjDt/hHJOKjZ4iDbQ1o9/8NucYc+I?=
 =?us-ascii?Q?QSBspEnvv99imXngmKcn5KrcF81zj/g43HCn5suERUnAZ5D7cAcxb3ZRIqcC?=
 =?us-ascii?Q?Xh4chKJXXSA6blqeB6/f1HH7PX3Gy3tm7zokqsjoIPND9+/5nt3IaC83qfwG?=
 =?us-ascii?Q?ywJwm4V+VztATe3tQ/fygiEYUJ67ep4hZqx3TV7f0BMwSaOe1oTHpSjlTZGd?=
 =?us-ascii?Q?+atkeQFjN9HNJhl5B9toQpxC5Yx0LR5Tvy96ecKAW06Ex5RXG0LMblEl9b9q?=
 =?us-ascii?Q?WRq+dnLCn6EJZSoeKryC9qam/6PnSad78f66KjFw3gw2KHf9uZfWxlgbp//a?=
 =?us-ascii?Q?K2snWICzXGP9YDjDhk962NDaQe2W0GC08qoflwR0RMJ1h3loy0P+SiXc5X8y?=
 =?us-ascii?Q?aWLP7V+/rtXSRZVDrFbXtnlp0XOunwJarbSYbJO/+qkg6p8IUDDmmzUTaPmQ?=
 =?us-ascii?Q?D025ilKxGNi74tqMDn0aWhqcoqzKzUXPGHhMkNxTeDWEgoPFgxEuumRZqFq0?=
 =?us-ascii?Q?UdtbTIG7p5Mq1gLo+cHlbFa8HfCAWMnJPMabSIKrY50+DoRO/kuLxBnc3pyV?=
 =?us-ascii?Q?y1s6apEPDoUe2njK/TTVOUwg9Tb5i3+R9/qUavsYxLJDZJufqf+UJEtxkLQR?=
 =?us-ascii?Q?PlteRO2JMkBdAysjzFTKU7RKoc7VSKdBCLnbUCoAwTZ3donltoazOS6u4ONY?=
 =?us-ascii?Q?1QRdTbJvYhhoIGmONib5N4J2HUDcETAAFbSiy/X6lmDpx90JDudcShzfXFus?=
 =?us-ascii?Q?qvAvAoccrW/nhn5N0bVKhJSq65rcjvI7hjwO7KSfI3SMhN91jGNqog7pTLFJ?=
 =?us-ascii?Q?NOMsPAeG6lMsdpLOA7YJvZFZtdgYwkPoXxPOo35bClVcYj//ehpGz89BsIqh?=
 =?us-ascii?Q?FErD1vOOnLhkv44EwVMwFVbTT4hMjCzFAZ+Xz4mdHg0hlo9o69cy6YA5aSoU?=
 =?us-ascii?Q?2A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?PJvlHDWnSVQ6kM4nrjEENGFGiOpSGe0rDRixq3opiHvgldevRLYhi1EuGl9G?=
 =?us-ascii?Q?WfML0wxAdjTInYuZGbyjlA2G3O4TDSiOwny/u5k1Qy1HMQJjB6qj36V9nJIk?=
 =?us-ascii?Q?LYCpj19dJHfNNOOwBOKx+nghgxRLNrhfW9A3Fut8OVqWgQhhJV333oWT7+yH?=
 =?us-ascii?Q?SKZkWpmyEvUDsKSPAoAC+Ufug/7oeeuJScuoouG3ViBwYBci2ay22qyc1PDO?=
 =?us-ascii?Q?YsxSX7MQyiyZxEk+uq0GoKj5CZ1KwDu+a/He5HXfwA1qi18cKOffoVWsy5WT?=
 =?us-ascii?Q?xjToZGQYR3f0bkPDTZmcIbyPfYFbNPdwxL3gfk32CK3+xYSX1Bk/JHw96i5t?=
 =?us-ascii?Q?dslgaOaQMt/mt2dvo2RdL9dzz+BieEwrDlDHJSMoZNoUGVM2F8DBvlW7D+OH?=
 =?us-ascii?Q?qX1/2cKe1F1hqzCI1mXHTBXnaRpixKLrVcBMxHwelJ+ewJLPh3xTRWy5W0df?=
 =?us-ascii?Q?DWA1KqU9k212/xczOqx2WeQrU5/SNqI4J9DjF7o8XL92Sc8v76AKEKQ6a8Np?=
 =?us-ascii?Q?uyUHblhhoCOv9Wbj+rwiMwtAe5JeKr1MCWwAMb4PpWdWilZNW5bcbw6tSv+q?=
 =?us-ascii?Q?eWHuDrdFuSdK1LwGHjjY2XBxvT5CILURxu6139f6LqOw96m3i+c70U2L+aQd?=
 =?us-ascii?Q?GMfybduOEAMBBYkpcvatipq+uFu+5bGaNpTTHvXoQ3YEC1JSreQSBq4l+yCI?=
 =?us-ascii?Q?SUFsBQiDcUHNs+opBmz/5Dq0PdORMryyCmqO3qo3rFXESzpOAg1KGuco/8LZ?=
 =?us-ascii?Q?QfhV3WpsrTzijOAsTlwrYEj+akJhDE/Gni7zwPAjQP5pZVaZJCITc2BWw6J+?=
 =?us-ascii?Q?4Q99xF861Sq6DofMS/WtVpiagVf7Sx2vVX4DpqojoXUIftowogN3lP7RlHHx?=
 =?us-ascii?Q?Tibx7Gj+B20MhwHbBjb0eTwGMYvMN2+VDSwPKaDRla8/lc+CMcgPpKz0uj09?=
 =?us-ascii?Q?+VM2tCCKousVCQ5XPqd9SA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76482dee-6f92-4b00-04ef-08da7fda78ef
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 22:55:53.6593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5iPQ5GTWuCsnp0f9nl2VpVTAw+fH32a8LWiWwxXvgDgw9xnR8MR35Q4BZhM340oaHQQqQ1Wmow+byvefo82pYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3601
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-16_08,2022-08-16_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208160082
X-Proofpoint-ORIG-GUID: AS6AlL0D1YnS-50lstWtR72r5GFq5tOQ
X-Proofpoint-GUID: AS6AlL0D1YnS-50lstWtR72r5GFq5tOQ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/16/22 21:05, Miaohe Lin wrote:
> If sysfs_create_group() fails with hstate_attr_group, hstate_kobjs[hi]
> will be set to NULL. Then it will be passed to sysfs_create_group() if
> h->demote_order != 0 thus triggering WARN_ON(!kobj) check. Fix this by
> making sure hstate_kobjs[hi] != NULL when calling sysfs_create_group.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/hugetlb.c | 1 +
>  1 file changed, 1 insertion(+)

Thanks!

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz

> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index e72052964fb5..ff991e5bdf1f 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -3846,6 +3846,7 @@ static int hugetlb_sysfs_add_hstate(struct hstate *h, struct kobject *parent,
>  	if (retval) {
>  		kobject_put(hstate_kobjs[hi]);
>  		hstate_kobjs[hi] = NULL;
> +		return retval;
>  	}
>  
>  	if (h->demote_order) {
> -- 
> 2.23.0
> 
