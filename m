Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35FC58A737
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 09:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237573AbiHEHgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 03:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbiHEHgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 03:36:31 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D555163CB;
        Fri,  5 Aug 2022 00:36:30 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2757YNqc005547;
        Fri, 5 Aug 2022 07:36:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=mGRp34HXRnu9kdhlNN4HAkHyXexlJSxoYeytqYbyFh0=;
 b=EISq2sSH2a6XYsgvDRO9lFqIHU8RH37TBjTSRu8PlH5nkp2I1+yuDYkxCDOh0wUmayGD
 90ydp00BHFqGrdTX4EbA4LK27UUDsN+4yK8vVf9vaXyswn0U/23vQFqovhpBANme2aCX
 8zI/2Wxk8Uol91LmtrkgULa5qhD0ojPYd9tIB00ZlJWOsfWFMae5eca1L8GozhOzkNQ7
 zDahVsldAUEG9f17+WfIOduBg2vvTj3mC7UnCfLKCxOzObCEhmYLY8+tCi4zFqrx0GSN
 IBPTW7Qgcqh7cFfp7QHoFHFpSipOsh02MmZ0EiIfysqZeEWH8N7lL1nD3M/HYBwcPUJp KA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmvh9xpgx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Aug 2022 07:36:08 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27579lwv007324;
        Fri, 5 Aug 2022 07:36:08 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2042.outbound.protection.outlook.com [104.47.56.42])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hmu34ub73-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Aug 2022 07:36:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g6N2nBZphJYCNhOjsT9sL6wk7iZBfit/HyL7LU6PNeGNPvz+Rxghj0IyYqR4oqDPhJ0zDTTQKFpAg57swqsHn/9KxmdWniyiapa77wxBvsWuAi0xNFPD4eeQG4u8YK8sn+DICvThsR3IGTVeOxgeNu2hDXDFbLZk9R1eGRVssq/VX4M/OGintj+VqS1mOnHV/68jU/Um1pOEwGhYHmqXc4X8xrv7OvN8m4Tmfk3FNqksLFJo0a6BozuA21fNypmUK17zUdcwfALeitgX3TIuaTTMZ/OJp+UGv7uXlkheWdPGg3RF+alUXEWwYmN9d/CZwUwQMUGgGX3dvrA1dl+Mpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mGRp34HXRnu9kdhlNN4HAkHyXexlJSxoYeytqYbyFh0=;
 b=mx2ovsPS0IlvZwSrN3iuRYSJWvvATYE/UgqYl1aufriQDVgUUHh9XcN5sqXD/VqhFOmwA6FGy7tewAajU+tnyjRkh++qXp6TRP6j8+I5witw/o3AHlIXmlmDTc1kbg7KIETDJ1qvz/Zgc7PEG9QPfBwAZj6vTRMvAGs7nmZWIBPJWxxm/2k7uKoc0aKx/V/zx+25IpR4fTT3KuJNs19DkHdZ+wBaACIyW9GcfiSOvtfsRvSKvIhTy1iZGQ/u75VX7JSPAeqwPQuZuYs9lzUfdtrwdLq+zSPoozSbAYwc9D+DYQ+qgTmvAQL0tk/7pByl52xlJ7AxniKnXMvB41SKmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mGRp34HXRnu9kdhlNN4HAkHyXexlJSxoYeytqYbyFh0=;
 b=pOT5OzltGjV7qSOo642HULv8x1NxuJ+jKAWUt61b2r0+XAuX65VSBShyap3uEzM+SRFOwJibBJOX+Wcf/I0zEfoIV5uVIGT5ZOXrWyjSvehmYU1BPmO9TbFs6rBTQR9rKpOy2ukg7SEn8uNroCgvr1fHxA1zZEX0QjCyYdk7q/4=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CH2PR10MB4277.namprd10.prod.outlook.com
 (2603:10b6:610:7b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Fri, 5 Aug
 2022 07:36:05 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5504.016; Fri, 5 Aug 2022
 07:36:05 +0000
Date:   Fri, 5 Aug 2022 10:35:44 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Randy Dunlap <rdunlap@infradead.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Felipe Balbi <felipe.balbi@microsoft.com>,
        linux-usb@vger.kernel.org
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: drivers/usb/gadget/udc/bcm63xx_udc.c:1861 bcm63xx_udc_stop() warn:
 sleeping in atomic context
Message-ID: <202208050012.uDlpcTiD-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0018.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::30)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35258afc-2e75-41c8-b9c5-08da76b5273e
X-MS-TrafficTypeDiagnostic: CH2PR10MB4277:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: csxCZ7IBe5oqxmYB34qpJQENfeuRXa0HBGPFqUHIDvHEBr80NDKnnVut3o+4BPonEtEFHSU+RvMM8vIhUvu2JMgYM9woLdOjMQvgP1LlHaLILvTsBpKleuJ/MftIW/CU2DMYItTXQEDofP0ySia2QORA8wCiO2B3dHHMrd99kEaBwARBiRaUpHK7ak9qeMuMT7SXRrF4ft9fnxPzstlI73+qyPIu6f/eCykm+cDcajmYKVxlaHvGQPj487QIx88mpKhVMtoal3egXuAWyVxzPogqe3AKYIdWIveLQfNxJTpOFVuEDFFZPqsv1DWoYq0IJGOPGE1EoIoBLvzhIQm6VFKO1PnU5rTEmXhyVo3Rq67sqfdNH0WlTUmK66gNIXSGxwMOADU6Y8YB486vCuyTLrkEYvjGEW8eCaZ8Q9xS+EPXCoSBlXfjcwwC58TLzarzE60Tab+vHFWYgouSb3oe1/6ook+2pkO4FoglrMlM1TbklfQ/xVnysh5SS5j5yyVSMdu+L88uDPwqXfPt+F6tBphlU/52Cj7jNEo2HihdrZLmMUhgBodyxGl99YRXSY2eU4Isu0+lWrvHQT7WbSRBdSqb2rsubMoh8GOxSMNqs5aBjZi/WS2aX4ynJLeoPp+SKGGAd/Slv/00wyL9lINPwL0Lpsrtgwws/iQUMpk+3f8OHBKWfd2Fqcp8OzVKote8Lj7m6GFgV/FOwdu5mePFqNTWA+Wb93k9GAWY7d6A8WZSR9Ik5/pRe9mHxgRsi5CnF2tAuW0pfwAnbNvKZ13pXmse/bm35EsjgpsJpqvl7GiySZeC8sAQKu9KntPm5j6PPutyBlMIGv4K3NGPIUJOEMzWaiPz3FuayNzc4/q37h1e7hGKU6+YyLP7cq5FLDGP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(366004)(396003)(376002)(136003)(478600001)(6486002)(966005)(41300700001)(86362001)(38350700002)(38100700002)(36756003)(9686003)(6666004)(6512007)(6506007)(26005)(52116002)(83380400001)(186003)(1076003)(110136005)(66946007)(66556008)(316002)(4326008)(8676002)(5660300002)(66476007)(4001150100001)(44832011)(8936002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ScV5MpjAs/t/dziDiKWHr4u5BJR07xoFzBWSijTfHTVlhjIf9Qx/PxUo25oX?=
 =?us-ascii?Q?rzn6BkkrXMAr+HPdqmCj/zFWnfspQzF0rpK7lJhkvHvL8c0rnX5z43BR2liD?=
 =?us-ascii?Q?2wSphSeXEwFCcOIQ6T9TBnce4/HQnalb51r86jYrfn5zlF1dBlhrc39fO/On?=
 =?us-ascii?Q?Vb+Q0dbSt7pWpGz1GyLN4o7KIBA+LDcxTRv6JKFZf7voiNWI6OyPaROUd1f8?=
 =?us-ascii?Q?JsOWYYU4PaLT+cHXstiAjyYpLr3BrL3cv9u/cPYe1/r6J3Q2mFDz0+vOgAjW?=
 =?us-ascii?Q?bEYfnL6yYSg9jKytFXURRk/vKjw1HHPi3AQMW8QrKfT/Iumewl5WaqVfznaV?=
 =?us-ascii?Q?l4dS+JoOJjdJkqFWNWuyODmw4COpQsLd7RIl1UQRGx6AdlUKhTcxT6h43PoT?=
 =?us-ascii?Q?ndyUFZHlpwoZZVyQy+65/W8jZZV8ek0OAbyTcfxoZtXMT2Zgi5qPn+1NwArE?=
 =?us-ascii?Q?D0ulIsekXlptGDf/jmQQGiwaLzP25KRC0WMtnYaGw0ISXMJZBRy11tDEq/BM?=
 =?us-ascii?Q?KPACFykU7qr8pSd1d13M/os1pp8DlqdqBUXv8svksmw+Kdhfqr1DY3crIA09?=
 =?us-ascii?Q?0Jl9K7vZF32vWLouyncFd4oy8KtvQieNNlyoDbopj6dN6MblCFD4BG56vlZN?=
 =?us-ascii?Q?lBGdtQVRvekW3g+2oYnrJA6g5on1ZL6V0p13MGsL/Q0uOvkGwBg46rzl+d3d?=
 =?us-ascii?Q?BUbGmZ+Wx61J0WKIU5xadzCaToUueKTtpF21Sn30kxouzCCnZl+JxlqIq3Ec?=
 =?us-ascii?Q?zaI1ZnSLaM75Gs8G4/IIQJ7L3kVzoMv+m2rNXezlD7r6P/Nz6Z6Wrz1/0WgB?=
 =?us-ascii?Q?QkBK5dp0kHp0BlRHTIutIPrlk+UgSgSCMad/i5rmBoIE3Ge5K5pk2ryS9PgA?=
 =?us-ascii?Q?HPX4gkYTNv3BPupAlbmPw1JaAVKpAta3b9K46ynuigxFgvAEA11oBd7S54x9?=
 =?us-ascii?Q?IuRUxWdcsHX2gGwlbVmB6pUWia6oaSFmWBeyh1SWkP2SlVDTQr4+GE+zC2i0?=
 =?us-ascii?Q?+fdDnnyo2fUP+WD/JVZA8YKpgA4AO47HN9bm8S9qG1hGXfKW+CtBDT/11I9i?=
 =?us-ascii?Q?Fe41/mx4jobpszek8cDsqISvbDC99LI0fhHqwjPo25KAUNcIkvS6MlTbqMUc?=
 =?us-ascii?Q?4NRDunhf3GATsEPm5jT1BIE+pDH7jDQWIMAJn0DrcyeYfP11SFYvcDRm44bo?=
 =?us-ascii?Q?Ilrsb1a6/qOq8CH0mly4Aa5qW5LfIMiaoTJ/6SvjY7ph38EnanPh3n/Ox+pp?=
 =?us-ascii?Q?xDGtgjmDvM8GJIniTGHTituwFO/EL3CyLAex/tS5PgB8BxN9uSLbbViDokjp?=
 =?us-ascii?Q?NC+4AEtOKr2IdEo4nUTyL9b00d18FZI8XRlVrCzu3v2a6sYQWrwkI8XhPMYO?=
 =?us-ascii?Q?rEFHoiJh4FTiLwidCst70hA+7w4EwathNElaNmvzq4VCD6olQsVcwitP/2sf?=
 =?us-ascii?Q?yr3ipDoT3PtgSVP9zP0M3gimd7eT+kgukwwtJ+voAI+HSrDfVMQKfQ7UheSe?=
 =?us-ascii?Q?oWL9bmWDZ6/vCBL75w7oyDah86qvzl5AqwTlUWWyKftl0AzFi2Dmz6UT3zWg?=
 =?us-ascii?Q?u9vl5RddhGMAsp9RQzUgEqbKY2LBrEC3JBGYZ4NUmgdwo/txOdc8TJY51BrX?=
 =?us-ascii?Q?gw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35258afc-2e75-41c8-b9c5-08da76b5273e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 07:36:04.9520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gFo5yEgkmh7rTg95Gcp8omBXPO6h8gMxD+RUEhejRon3RzW3ruqZ75iZ8Azm9kAspVLwqehjBQrYZ5CSCxeoKYeAbXQi5uTdxGVguLc3Mfo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4277
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-05_01,2022-08-04_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2208050036
X-Proofpoint-ORIG-GUID: 7kTL0wCNoWi12_h0XVv9WenWOfJpe_Xh
X-Proofpoint-GUID: 7kTL0wCNoWi12_h0XVv9WenWOfJpe_Xh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ This patch just enabled the build-bot to test more code, so it gets
  blamed for the new warnings even though it didn't introduce them.

  The actual bug in a USB driver, so I've added linux-usb to the CC
  list. -dan ]

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b44f2fd87919b5ae6e1756d4c7ba2cbba22238e1
commit: 5eeaafc8d69373c095e461bdb39e5c9b62228ac5 mips: BCM63XX: ensure that CPU_SUPPORTS_32BIT_KERNEL is set
config: mips-randconfig-m041-20220804 (https://download.01.org/0day-ci/archive/20220805/202208050012.uDlpcTiD-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/usb/gadget/udc/bcm63xx_udc.c:1861 bcm63xx_udc_stop() warn: sleeping in atomic context

vim +1861 drivers/usb/gadget/udc/bcm63xx_udc.c

22835b807e7ca9 drivers/usb/gadget/udc/bcm63xx_udc.c Felipe Balbi       2014-10-17  1846  static int bcm63xx_udc_stop(struct usb_gadget *gadget)
613065e53cb191 drivers/usb/gadget/bcm63xx_udc.c     Kevin Cernekee     2012-08-25  1847  {
613065e53cb191 drivers/usb/gadget/bcm63xx_udc.c     Kevin Cernekee     2012-08-25  1848  	struct bcm63xx_udc *udc = gadget_to_udc(gadget);
613065e53cb191 drivers/usb/gadget/bcm63xx_udc.c     Kevin Cernekee     2012-08-25  1849  	unsigned long flags;
613065e53cb191 drivers/usb/gadget/bcm63xx_udc.c     Kevin Cernekee     2012-08-25  1850  
613065e53cb191 drivers/usb/gadget/bcm63xx_udc.c     Kevin Cernekee     2012-08-25  1851  	spin_lock_irqsave(&udc->lock, flags);
                                                                                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

613065e53cb191 drivers/usb/gadget/bcm63xx_udc.c     Kevin Cernekee     2012-08-25  1852  
613065e53cb191 drivers/usb/gadget/bcm63xx_udc.c     Kevin Cernekee     2012-08-25  1853  	udc->driver = NULL;
613065e53cb191 drivers/usb/gadget/bcm63xx_udc.c     Kevin Cernekee     2012-08-25  1854  
613065e53cb191 drivers/usb/gadget/bcm63xx_udc.c     Kevin Cernekee     2012-08-25  1855  	/*
613065e53cb191 drivers/usb/gadget/bcm63xx_udc.c     Kevin Cernekee     2012-08-25  1856  	 * If we switch the PHY too abruptly after dropping D+, the host
613065e53cb191 drivers/usb/gadget/bcm63xx_udc.c     Kevin Cernekee     2012-08-25  1857  	 * will often complain:
613065e53cb191 drivers/usb/gadget/bcm63xx_udc.c     Kevin Cernekee     2012-08-25  1858  	 *
613065e53cb191 drivers/usb/gadget/bcm63xx_udc.c     Kevin Cernekee     2012-08-25  1859  	 *     hub 1-0:1.0: port 1 disabled by hub (EMI?), re-enabling...
613065e53cb191 drivers/usb/gadget/bcm63xx_udc.c     Kevin Cernekee     2012-08-25  1860  	 */
613065e53cb191 drivers/usb/gadget/bcm63xx_udc.c     Kevin Cernekee     2012-08-25 @1861  	msleep(100);
                                                                                                ^^^^^^^^^^^^
You can't sleep when you're holding a spinlock.

613065e53cb191 drivers/usb/gadget/bcm63xx_udc.c     Kevin Cernekee     2012-08-25  1862  
613065e53cb191 drivers/usb/gadget/bcm63xx_udc.c     Kevin Cernekee     2012-08-25  1863  	bcm63xx_select_phy_mode(udc, false);
613065e53cb191 drivers/usb/gadget/bcm63xx_udc.c     Kevin Cernekee     2012-08-25  1864  	set_clocks(udc, false);
613065e53cb191 drivers/usb/gadget/bcm63xx_udc.c     Kevin Cernekee     2012-08-25  1865  
613065e53cb191 drivers/usb/gadget/bcm63xx_udc.c     Kevin Cernekee     2012-08-25  1866  	spin_unlock_irqrestore(&udc->lock, flags);
613065e53cb191 drivers/usb/gadget/bcm63xx_udc.c     Kevin Cernekee     2012-08-25  1867  
613065e53cb191 drivers/usb/gadget/bcm63xx_udc.c     Kevin Cernekee     2012-08-25  1868  	return 0;
613065e53cb191 drivers/usb/gadget/bcm63xx_udc.c     Kevin Cernekee     2012-08-25  1869  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

