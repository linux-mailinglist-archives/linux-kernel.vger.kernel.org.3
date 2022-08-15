Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71944592CCC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233296AbiHOIGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 04:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiHOIFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 04:05:52 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1945BC05
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 01:05:50 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27F4hbHH027834;
        Mon, 15 Aug 2022 08:05:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=HQqcfaSpHvUgY5RGMHMnfzbr5RHSWSYFKVBgbUkcPsY=;
 b=rBKUguatJ2G3gmAODMH0cc8izz3ZW7O86HkToxEvs7eetfn2YPWr84dKucDWTUT5Wxip
 VyvFy5Bdurlh766YjMmtB+u5VzNd812NlKQBaKZLNtCiOnzarRXAESPztRHqEtvGI68G
 Xs2NP5TUIUIu54Dvg35jXjATkU7Cgnqv2l8tEFMn9MIlm2su5pNghZcW/pyaXwNlmqs7
 +HQxUia3DfP3AApATfK+0mBdLwZRPOgMBIBoHyjdOrjMd7I8W5dKtM0vavCiYOwjn3ej
 4feVghO5acK7u+9rOYFK9xVDjO0qJReupgADVMHQFBsgIGRwMO16SVRpewquWyzbH8IJ WQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hx2r2aeke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Aug 2022 08:05:15 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27F5B5ea034900;
        Mon, 15 Aug 2022 08:05:14 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hx2d16j34-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Aug 2022 08:05:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QtVW9A0DUjirCYhZHMxv9gxJ69kA3yYyXPpWpcW4dPTfZlPjYJPz6BRP4DcVig/rBpClRIG+ly3FZtW+ICmhtIELr31JhJovTpxKYbLNehZrHKTKt7KCSJRvCOjnCqFjx9u6PMg+ISLsRTBnBF8qJL/i0+Xasf6Uzyn3lvPNx5IbfmZuYDmJ7/mpTMVoc2aorbhaWMS7FF3pjhJ7OPSCSUsYIJ0aGrT4TPVTHTMkKynH7NApqkR6ExbGpMhRvpTmMs5s4CC/RiJnJ/j1s7IcZ1XGFQq0qHSQzDMS60d/M4L8qIXufVUaopbxPL9X0hjPBTuqHD88BBQ8gl+kbupMCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQqcfaSpHvUgY5RGMHMnfzbr5RHSWSYFKVBgbUkcPsY=;
 b=fo91wF+T/an9ZvztC3fGQ3oxB2dRgOX5wy5NHAH/mN6wq/MwlUsLup3Y51yusMCQea66z8pnZoLDc6wBNoP3MgEjet7ERjyJywmfV/VBAK5q48LDcjValSaYUq0Xf/qJMkKBx5s6WeaF6B+tTY6V60yDqnje8aemEGaWLjVvXNpSA52unP2a62sfDVrQwgtBLJcq+KmBkyxAVDPT/Bz+RY79CI+kw1owOci890fwSMvrYIP4P52PwPZ/lfPDsV3PUNffQfRfEb3KFga6GJ/1KlUoUEwb1kvonqBtMC473OwXnK8AcGYbm4rDDDHSS6bcV0j5UvjLEY/O93lPBxL0aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQqcfaSpHvUgY5RGMHMnfzbr5RHSWSYFKVBgbUkcPsY=;
 b=H99hJ6FcXlW+3z+baeHx8+iHqMC57sQLovm8e935UAjgvHOfP/b8hGCXY4gq9rbaZzY0YelWOfrbd2HHmW5+hFmJsK3afq/VaehO7k9LjBqMnAULNU7Lg+nAXZyT6p/Pru4ZT7szqEWJfIy8Txts7REMeqkJfzrQrQABfKgkdCs=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM6PR10MB3626.namprd10.prod.outlook.com
 (2603:10b6:5:151::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Mon, 15 Aug
 2022 08:05:08 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5504.028; Mon, 15 Aug 2022
 08:05:08 +0000
Date:   Mon, 15 Aug 2022 11:04:48 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Janis Schoetterl-Glausch <scgl@linux.ibm.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>
Subject: arch/s390/kvm/gaccess.c:1064 access_guest_with_key() error:
 uninitialized symbol 'prot'.
Message-ID: <202208140957.tRQQbiQI-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0028.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::16)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be4cc7f0-6f4a-4b0c-9bb9-08da7e94de8b
X-MS-TrafficTypeDiagnostic: DM6PR10MB3626:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: no7/03dJuJGm8vZmzFUmGLLV82EtxzM/hi/gx5FK0nZUGZcxtcXQCfUt2U9PEbYaLz1/V6P2sWfK3WpOkWDc5gYFLECh7qE9OCdvlt1vSqhO9/nTS/EO2ljarHBBgL5uAVIE9k9Df3Zss4KvfmYAUESphoKf8IU8I7VFVCBe36s8tZtHoBwD4bGtaV+IJ1UXcFcLetDek1OAnKVY/hynQ5sRnGlwo2KT8mK7+EjRrK6EQf+qGrONQztp5SjQTuwiJvWfSsMAWNTs9G+8CWsDYnh3jberpee/Azfkm0IzpiAFEj9t8Zm4IPo+Y00RNP06PRsYNXWFUGW20s5M2DYCGREwRxHpkrNGeBt8sa+nDflutYfMHeeCP+9Ru004HtGGSQtMV/MSE4wiGhs3CD9coSIdYeGj2c5tONXLdXo9XVqEJCPClX27mT8n6uOxzcV9FamO10x8DZaatHpedZbKPbnj0dcqBB3SGn8GG6sMN1wSuA2xaTMnHCrBO0/ANo0tWrfslfzYDT6T4mPNSB3mviLQpM+hyrKM2N8+zyHsJOst5U2uc8063YFbCWcBKg2+OLV55uXPtLjlI29byRrpHZ/HrxxgSlM8eTuaLdxMnC7C4btZOY2fUDv30GsQNXKeXtChEPfIMsPKhWEdHt/6krzQjGl8PFO/UmlfaYwNoWdLeP+jfmHb8DlMA06eWJ9kyOqe5goHiIbzk9CPDI7iVhAi2z7Jmh4zUXTZ8Z/EWeXA0EhFhDam4lIAAvq1OjZ7XkxJH2OJl5oLsfakdwHXwXSdOtqjyei/10zY0nUXAboysSdb+WqkOuFNbohQWwJ2YjxDEpUGZLJB3ykDmhWYmhcTORZUgL+BaTDOO8gxABGr70T8ewZbBCE/oobnVHH/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(136003)(39860400002)(396003)(376002)(366004)(54906003)(6916009)(8676002)(4326008)(966005)(6486002)(6666004)(5660300002)(36756003)(52116002)(2906002)(41300700001)(186003)(1076003)(44832011)(26005)(4001150100001)(6512007)(6506007)(9686003)(86362001)(83380400001)(8936002)(66556008)(66476007)(478600001)(316002)(66946007)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LhJaS7rkS+G3h1iUinSpYzAXior985/FiC3uMJDyYnagdcEZR1+cqL+urtvq?=
 =?us-ascii?Q?ERR+xg1NzV9nm/xBQN0zFFvLSqJrid1Q37wuhO6eT/8aSLJ4tANB1f0d22EF?=
 =?us-ascii?Q?kb4EIlUz8fij3hbjh9gD0LTR4XzLPME3poFeZYLJwVDWzGrpuoGUjPuJUit7?=
 =?us-ascii?Q?+6ag65pxFVfA7OapKveHeY1V9UEaYLQFoVleJxBTPjLgXOEqAP+Zhurpy10y?=
 =?us-ascii?Q?J+81bIjBnE63ElkNtY/Jga0pG7r4dhBMnPejyMMopfX+nqqexfHwsPMm42YT?=
 =?us-ascii?Q?E7iNRqq8SuRm9iRlyMwifMrtpLcnQaTJEPXm0a/YevuRsngXzXrg/Dom5tAh?=
 =?us-ascii?Q?U042IvZh7RVTgibja1YZn/YcTJnUkoSWSUdQNq/Ki9UTEoZzJQzNm3SdpqC+?=
 =?us-ascii?Q?a7J2CSXjUyDfWTFB8uqNJvcBZPSA31mDjOvCWYBL01s/JjPAOovvy81bS74W?=
 =?us-ascii?Q?DQ/izSPbfkaD99wLnfVH/p6rJ1NS5ZmkPgHNDgZWS2fekH5lLARu+efMQDvb?=
 =?us-ascii?Q?nsQPY3lPhgyi3mTQiOb8lKxRo1GYPDROoOgajowzbR/ZE0lqHxPAL3nbxTch?=
 =?us-ascii?Q?R1ko3ehjVLeQQgPndgj6xeCorES4EgwyRDwlvvjDx3LAP9joXL2qiHcVLJXv?=
 =?us-ascii?Q?5wkxfwqqrzzBVkhc1lmsfTbS+pgqmjpR+MsmbaCV44iK3SNo0pKm1ECKtcQD?=
 =?us-ascii?Q?E+ACr0CfFcJ+A6oawDdysj4r5xcVyKwU5oJbCMSc5/oYbJt5byK8uBkdDs4M?=
 =?us-ascii?Q?v+nr5GT6lGAb5JYZ6opSrkd3ePr0/Eb/m/QOcw7NY3uX/h2vKQWoVMrVO6rL?=
 =?us-ascii?Q?0acAyQg+fr+HUfahTOhebpu5l3k8OlzeEbnb0h9NNMIi+cMTnyYfaJ7rdvjh?=
 =?us-ascii?Q?+PWM4dpGFGsSOs3kWZgcdJRoswWUFiApP7peJU9riuU50X0+3IbVa6QVr+0u?=
 =?us-ascii?Q?0JeLMTnz16hFWbwITPaqxJBP49fscbHy/y9jGp0Fn3YmLJ9+2h1fEhq3s9Ct?=
 =?us-ascii?Q?MQSaO/Z1NFy42xZe347Xsg2FNq0HBWTahDSv1+AzaeCnR/VdqwKcY9CghPEa?=
 =?us-ascii?Q?TeZCVtKfxGpiUjzLzPRs8kvdM8M1VZ6SVCAIk/BbWY1dqH3wfNUChzD60lAL?=
 =?us-ascii?Q?DtS5lJkk+hiOYMCvY5pWcqmMIFjxLD2BLn3xSLY0ag5ZPsrX5jdhPSYAEbeM?=
 =?us-ascii?Q?Rxnge5ECZvHgWsQl/x5DJ05xFpWmX9Ptmf65ErEpcGntCiU/P8MpNjXzFPjS?=
 =?us-ascii?Q?i8JiW3ae2PoCUtVtRjHs+0gVowLxM0Lt4jV8iEnM0yLj4KF9xOJUbwyBsaPk?=
 =?us-ascii?Q?qAwEUN6wF5H15UZxZZnnOlzCz571i8l3wluzWppZcwjyTZ5Al8Y8Emtgt4kE?=
 =?us-ascii?Q?JnsKXWKRi3dA4Z/dOHjXg7tevTUDgoUVswt8to/b+cjE7nVzIxox5wAOiz1E?=
 =?us-ascii?Q?uchgY6wuEdWq/YU005x2dxllx/Vo8+3QBwYK19Oqawr7DbVW4GrjEhCBWlKo?=
 =?us-ascii?Q?0fQ+U8V2KeeHpinXvWschvbjOrGyW7EfsVN5DHycU3ZnZyFijRemGJURRdoE?=
 =?us-ascii?Q?ohN8yzniTUHkLAtO6NUWHbrT0l/IxiH8A6PmJ/lB7gnQXyd8mXjnb4RRJ99x?=
 =?us-ascii?Q?BQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?cjlY3B7+IvBq+cFqeffPv9Z9E7c5pZ6zR/4kaVmt+aG5EqgQFH73Vqv/nWeS?=
 =?us-ascii?Q?BByUpJw75yTPS3sfpX/qj/f+j9CruM5vEdq7hAfU92TtSC3FwZKBV5+LBMef?=
 =?us-ascii?Q?1lpg2hSSFcWdfUSo5v+jURJATGJB+oT25b4lEcDlX0ZnC4tUoab+XhYwwzhW?=
 =?us-ascii?Q?9GbO/jSelup4VeltEEAHpSJ3JyxRbLrY5QFTjnx1J/tdcf9jNQjk6DEUNC7x?=
 =?us-ascii?Q?ArgoqsTsyYH+FVLIg8UE+zPbGo2sD65Obi4ZwC7MAyd1gT3X9WVjZdnMFK3L?=
 =?us-ascii?Q?l7bp3fqTkpZhXnGfOJh7P/AOAET2B/DBWa+QSRf/mk3VoDu4CS7GCNKnSz9J?=
 =?us-ascii?Q?XV7Scen4rQ9iCKMPMH3D7y+U/O5Mf/lKLBDN2uPTCh19HMfA4bRQiLIMgatp?=
 =?us-ascii?Q?fnq2/fIzy8g6nfAOWFwivCbD+USetThPkTjSsCDgDeexWRaYfReEuqhKeGJB?=
 =?us-ascii?Q?acWS5g9GeGDtCmUfxtLhOCdjJtvKHYM3RSj123sjTCb0dqlThJi0z9D7XXjn?=
 =?us-ascii?Q?6+IeUhLZZXUicFCcQfcLfzit478RcJzwl9UueCSf6OYJvRpvniIjMmYFdWcc?=
 =?us-ascii?Q?98QBvDOvgGx9ymEqYIDS5yki19/rNjf/1kr4OEj4vLD07FFknkABMszIzpIW?=
 =?us-ascii?Q?CQEtLiPUdwwriagvkFl/MUfSXz63YTIRX5zI6R0TCHu83mQYrN0/eayQ5cHf?=
 =?us-ascii?Q?nH0KDBYNe6/an3mnFcVIxUPEZcPmWvAAPwYVy0ShqDUggzRyA0KZK4JDxIn7?=
 =?us-ascii?Q?KclmvJmluofIrIh8yL51o/hdvhcOnTvooKp8ey1WIKHbrmAJUVTTj7sbgLFT?=
 =?us-ascii?Q?s+ZShqZXFYCtiwBhCUO9NPNOrKolndPfWe7rpPJXbULDmLdjHrbDSOK16uK+?=
 =?us-ascii?Q?Lowvlsb5R4JJUVaey6jSKdtxNs+LFuo+7mbcA8xLuA0S+yWMS6eSzkPu+bZT?=
 =?us-ascii?Q?k/U9Vr+yKJNEk1zkLTgx5iTd8cc6bDMqXSJwgkxuFh0SC/xQDRG7PICW0QXF?=
 =?us-ascii?Q?UG8j2actJ6olpf+dqtTHnamXB/nptT+n63r8N4TDIV6zfRL2pDqORJWf6Amw?=
 =?us-ascii?Q?yGdvew3Y?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be4cc7f0-6f4a-4b0c-9bb9-08da7e94de8b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 08:05:08.2484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ESjNuSgcAcDM1idyXhfEOVLUGvjjkxu1kAnXAPbrKZNoMFpaLowAvnqIkUi02bQPEo68R5E+4sKpYcQszpjdyCaJcVhhK0SUfvJpFamidkM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3626
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-15_05,2022-08-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208150028
X-Proofpoint-GUID: qZad5KcnBB0tINyheJ2n35yHs9FIsSUX
X-Proofpoint-ORIG-GUID: qZad5KcnBB0tINyheJ2n35yHs9FIsSUX
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f6eb0fed6a3957c0b93e3a00c1ffaad84d4ffc31
commit: e613d83454d7da1c37d78edb278db9c20afb21a2 KVM: s390: Honor storage keys when accessing guest memory
config: s390-randconfig-m031-20220812 (https://download.01.org/0day-ci/archive/20220814/202208140957.tRQQbiQI-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
arch/s390/kvm/gaccess.c:1064 access_guest_with_key() error: uninitialized symbol 'prot'.

Old smatch warnings:
arch/s390/kvm/gaccess.c:935 guest_range_to_gpas() error: uninitialized symbol 'prot'.

vim +/prot +1064 arch/s390/kvm/gaccess.c

e613d83454d7da Janis Schoetterl-Glausch 2022-02-11   997  int access_guest_with_key(struct kvm_vcpu *vcpu, unsigned long ga, u8 ar,
e613d83454d7da Janis Schoetterl-Glausch 2022-02-11   998  			  void *data, unsigned long len, enum gacc_mode mode,
e613d83454d7da Janis Schoetterl-Glausch 2022-02-11   999  			  u8 access_key)
2293897805c2fe Heiko Carstens           2014-01-01  1000  {
2293897805c2fe Heiko Carstens           2014-01-01  1001  	psw_t *psw = &vcpu->arch.sie_block->gpsw;
7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  1002  	unsigned long nr_pages, idx;
7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  1003  	unsigned long gpa_array[2];
416e7f0c9d613b Janis Schoetterl-Glausch 2021-11-26  1004  	unsigned int fragment_len;
7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  1005  	unsigned long *gpas;
e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1006  	enum prot_type prot;
8a242234b4bfed Heiko Carstens           2014-01-10  1007  	int need_ipte_lock;
8a242234b4bfed Heiko Carstens           2014-01-10  1008  	union asce asce;
e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1009  	bool try_storage_prot_override;
e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1010  	bool try_fetch_prot_override;
2293897805c2fe Heiko Carstens           2014-01-01  1011  	int rc;
2293897805c2fe Heiko Carstens           2014-01-01  1012  
2293897805c2fe Heiko Carstens           2014-01-01  1013  	if (!len)
2293897805c2fe Heiko Carstens           2014-01-01  1014  		return 0;
6167375b558196 David Hildenbrand        2016-05-31  1015  	ga = kvm_s390_logical_to_effective(vcpu, ga);
6167375b558196 David Hildenbrand        2016-05-31  1016  	rc = get_vcpu_asce(vcpu, &asce, ga, ar, mode);
664b4973537068 Alexander Yarygin        2015-03-09  1017  	if (rc)
664b4973537068 Alexander Yarygin        2015-03-09  1018  		return rc;
2293897805c2fe Heiko Carstens           2014-01-01  1019  	nr_pages = (((ga & ~PAGE_MASK) + len - 1) >> PAGE_SHIFT) + 1;
7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  1020  	gpas = gpa_array;
7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  1021  	if (nr_pages > ARRAY_SIZE(gpa_array))
7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  1022  		gpas = vmalloc(array_size(nr_pages, sizeof(unsigned long)));
7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  1023  	if (!gpas)
2293897805c2fe Heiko Carstens           2014-01-01  1024  		return -ENOMEM;
e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1025  	try_fetch_prot_override = fetch_prot_override_applicable(vcpu, mode, asce);
e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1026  	try_storage_prot_override = storage_prot_override_applicable(vcpu);
a752598254016d Heiko Carstens           2017-06-03  1027  	need_ipte_lock = psw_bits(*psw).dat && !asce.r;
8a242234b4bfed Heiko Carstens           2014-01-10  1028  	if (need_ipte_lock)
8a242234b4bfed Heiko Carstens           2014-01-10  1029  		ipte_lock(vcpu);
e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1030  	/*
e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1031  	 * Since we do the access further down ultimately via a move instruction
e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1032  	 * that does key checking and returns an error in case of a protection
e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1033  	 * violation, we don't need to do the check during address translation.
e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1034  	 * Skip it by passing access key 0, which matches any storage key,
e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1035  	 * obviating the need for any further checks. As a result the check is
e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1036  	 * handled entirely in hardware on access, we only need to take care to
e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1037  	 * forego key protection checking if fetch protection override applies or
e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1038  	 * retry with the special key 9 in case of storage protection override.
e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1039  	 */
e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1040  	rc = guest_range_to_gpas(vcpu, ga, ar, gpas, len, asce, mode, 0);
e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1041  	if (rc)
e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1042  		goto out_unlock;
e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1043  	for (idx = 0; idx < nr_pages; idx++) {
7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  1044  		fragment_len = min(PAGE_SIZE - offset_in_page(gpas[idx]), len);
e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1045  		if (try_fetch_prot_override && fetch_prot_override_applies(ga, fragment_len)) {
e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1046  			rc = access_guest_page(vcpu->kvm, mode, gpas[idx],
e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1047  					       data, fragment_len);
e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1048  		} else {
e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1049  			rc = access_guest_page_with_key(vcpu->kvm, mode, gpas[idx],
e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1050  							data, fragment_len, access_key);
e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1051  		}
e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1052  		if (rc == PGM_PROTECTION && try_storage_prot_override)
e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1053  			rc = access_guest_page_with_key(vcpu->kvm, mode, gpas[idx],
e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1054  							data, fragment_len, PAGE_SPO_ACC);

The kbuild bot is not using cross function analysis and it's not clear
what access_guest_page_with_key() returns.  Presumably
PGM_PROTECTION or negative values.

e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1055  		if (rc == PGM_PROTECTION)
e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1056  			prot = PROT_TYPE_KEYC;
e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1057  		if (rc)
e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1058  			break;
416e7f0c9d613b Janis Schoetterl-Glausch 2021-11-26  1059  		len -= fragment_len;
416e7f0c9d613b Janis Schoetterl-Glausch 2021-11-26  1060  		data += fragment_len;
e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1061  		ga = kvm_s390_logical_to_effective(vcpu, ga + fragment_len);
2293897805c2fe Heiko Carstens           2014-01-01  1062  	}
e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1063  	if (rc > 0)

It would be nicer to change this to if (rc == PGM_PROTECTION)

e613d83454d7da Janis Schoetterl-Glausch 2022-02-11 @1064  		rc = trans_exc(vcpu, rc, ga, ar, mode, prot);

Or maybe change this to rc = trans_exc(vcpu, rc, ga, ar, mode, PROT_TYPE_KEYC);
Or both.

e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1065  out_unlock:
8a242234b4bfed Heiko Carstens           2014-01-10  1066  	if (need_ipte_lock)
8a242234b4bfed Heiko Carstens           2014-01-10  1067  		ipte_unlock(vcpu);
7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  1068  	if (nr_pages > ARRAY_SIZE(gpa_array))
7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  1069  		vfree(gpas);
2293897805c2fe Heiko Carstens           2014-01-01  1070  	return rc;
2293897805c2fe Heiko Carstens           2014-01-01  1071  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

