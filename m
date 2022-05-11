Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35A9522FC3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 11:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbiEKJoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 05:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244038AbiEKJmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 05:42:10 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37F864C1
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 02:41:30 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24B8Qr75024470;
        Wed, 11 May 2022 09:41:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=O4m+2fSCEjYa1auXUNQyk9syT8fjy0yDQl4YwEZ8n3U=;
 b=WFosFeOWi1IhPNRoU6NKJJYuk8PU3jt5Bliz/YkY6oW8ddkftzrpp7qGib+fTCyY+89a
 AoU5fL6eUAqBgF8UDcVZHFOvBA2MG9wy/dQH5MTY2KIgXKesUywt7QZnCKAhqG1Fs/aZ
 xSMweuddau59r1zBC+eeGqCjdnXDybRYXc1CchGZMDikwggCZreYFd6DA2o9Ns2S7ERX
 Zy5Mh+yg2UKGmSREpfrGcf2Kevw8AUtB56/WxR/jJ5yMKX+KZPX+7ridfEG386v6mnnw
 x9y9u93Ombcsv41OE75bVqCcrUgXxNMBbXYmnKG906s71llxTmPFOLO2gLeOuDyGm+d1 Pw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwfc0s6xr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 09:41:23 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24B9fKV2014010;
        Wed, 11 May 2022 09:41:21 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fyg6ek0s9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 09:41:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V5w4usl5jZCmr6Xf54eINu3KM8lt2lpBFx+dCTFRULt1QJhiV1xsrfcZmGHYRpeYo/gSlDcWFH5Zhy+ovFAzICfYGZwJcX/V1dvR/9qCmPCzafgwTZ36Y+sl7zP9nUMgLVKfTMx5FUYuSD7jDKX39eb2epMI833BARnd4K3uOqC3fexTfgcqcOgPRD18YtIxYLCbP7WAZOMHjr1ajK1pcuM+j9Xvl0o1FcPt/C4ZkzkJGzMVcemLSCFkSKqarF1kOLyQySMWMQarMqwgdSWq1AUrPPiPQCNYYwItCkaM1M9ZLJX+Shi3g2V7hHiGu8Td1cIid1mcbc4vIiVgGLAgVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O4m+2fSCEjYa1auXUNQyk9syT8fjy0yDQl4YwEZ8n3U=;
 b=nZDkxEyPd2SefHzf8BTDqqQZPg89wmoWw3I04iPOOZF5pIUVwH1VCUDTG+HqLMdz5MhAP6LvuVIQea0W1SRuouH/IH4v4MQT3AeQq2t6ugAakGYwxZCAnvfdoE9tWLFda08K3ayaV0OhgrwM+sZ09ZD+KLNkw1t3ebH6j6lU59vA+BFSevvad5GQWoOKVn8GRrbSGBWd2tSvqic4qCzFbSo645CCoxzTln+Jql667Df7EGXHOpLbPKTmckT4B+69TJjOaX4HqBK6iaK17HUTtCrpxVnZ0icvAYdYsZFP8ZdJBOAFYAye8Ih2BvfSE3vCVOkN5iYmQEcXeLnYa8jALw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O4m+2fSCEjYa1auXUNQyk9syT8fjy0yDQl4YwEZ8n3U=;
 b=Ee4mXM0vivbt/pYVlFgItIH0Jk3D5f0QLVcYnQw4AILlnd8+NMiwQNxNHTaOKg+O1HQwK5qWy42aP6dtx9wHFEbJN7OPr3J2GnDA4Q+rdwdUv30za0ucWuZWDxjAttk/SGuaH+dlbUrOT7ZQTbjSManaRJaKHOi0gHB9B6WHuzk=
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32) by DS0PR10MB6176.namprd10.prod.outlook.com
 (2603:10b6:8:c0::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Wed, 11 May
 2022 09:41:04 +0000
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::e929:b74c:f47c:4b6e]) by CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::e929:b74c:f47c:4b6e%4]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 09:41:04 +0000
Date:   Wed, 11 May 2022 12:40:46 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Tal Cohen <talcohen@habana.ai>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Oded Gabbay <ogabbay@kernel.org>
Subject: [ogabbay:habanalabs-next 47/47]
 drivers/misc/habanalabs/common/habanalabs_ioctl.c:135 events_info() warn:
 maybe return -EFAULT instead of the bytes remaining?
Message-ID: <202205100736.Y0Vi5Fcf-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0017.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::22)
 To CY4PR1001MB2358.namprd10.prod.outlook.com (2603:10b6:910:4a::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a7c1fe9-a491-4ec1-e696-08da33325de3
X-MS-TrafficTypeDiagnostic: DS0PR10MB6176:EE_
X-Microsoft-Antispam-PRVS: <DS0PR10MB61767748FFF9AB722D8C09688EC89@DS0PR10MB6176.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NWrS1WwTlVEpSo0fEHZ26iq+4od72R4yLE1VHi7kPPXQ19iMze5eClfM5A1UUkOBxV18efvs8l3QWMxcSfAgnmrB1XdBHKfcH1SQ/pPTWUzliGVliAeERolzDFRBX883KKrPF/h89xXyX1J0XLJGWiqRk+Blm8vCzR//2mS9TVxGAVxNjT7JAJhPkBZCdXfBH0ZJb5KpwBqwShGHrh3Hei4ckfA4wrLKEKO2sfYE3MSrhQ3UlryChxrkRT8SgFIsn2tB8m4co7EPiQrqQ8fDyHDejfMas87ElZYCm+VA9evvumQf0xnopFRelDF11TfoYA8CqdBqymwkT/phTtr7+gszh+xX74MWhQxI67ouFurWEcqodbCStEIBX0Mzjg1kWC481z2kVnDTWSbxpEcC0zT1FMheE/3+dWh9tSGteWg59yGASmChztuqfW7aQsB/3Uv8xY4su1aMMqXQmvO0DG7Cg5rPM7/ojA6GADSYFnLDTfbm2RiSS5oCPmHB+L1vj7id3K1gRTvgrBgEd8m5tJeRsbodhPa/2Dxl0hc8RuJ/q0G9uky59Lnruc/OOyLCDqVHNF11eiWeQ1R8G1PNhppB/7VMU/vA1/eveniuUngPf/1a6ktrSTUxPb/MHaTysfNn30H0mXRs8qQlWnwJt6QRT1DMo0usE29jWwjmgplHPPoiyxlq6gMwkzlCd0mpG8IO8dJZzYhq1qoULM7yft/2MYe9wCB9QpLjO/6YHeKZbBZLwm1urj6zInmOF/V30hAND4tzpf9gHluqa2qQH9xEa6WClSvdhzK5BBur6V4L29K17JtnhRJcFeUk3jkq05yUhZ8maTWE0IX4Xeduqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2358.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(4326008)(83380400001)(186003)(66556008)(66946007)(86362001)(8676002)(8936002)(5660300002)(316002)(2906002)(38350700002)(44832011)(38100700002)(26005)(6916009)(508600001)(6506007)(36756003)(9686003)(6512007)(6666004)(52116002)(6486002)(1076003)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WryF0vJ6VUgKyRhpFJUW0Rs6UroesvOdIKkS5HFI1X9w7Fhqw98XJOgS2S/g?=
 =?us-ascii?Q?wd0zhpTs2h9h+Eq2lE/f7FafUDYNnmQJdf17Q6TEu1paVF5h0pVZ75TVweE8?=
 =?us-ascii?Q?ou3XJnEsIjWl+0+bZOaF0UXgK7QH3m7FCdG/M/X3c10hRqb5/WYNSlu8fACc?=
 =?us-ascii?Q?pKrg6Bwlgt287PRCgSJCXRQrAbwsi0HNEckGD0gOxnAvVPhRg0V1rdudBv4y?=
 =?us-ascii?Q?+SqRFihiEeJvHrHV1ZdRuTSOVRLQfmw0RrHyRUq2EwaHm3JIkCRqhzpZoACc?=
 =?us-ascii?Q?yeNBCXu71H5g5XwDdil5omWo2PuAEi5xE3+PN2DF+mc3auS7YDS8Moj9oGcp?=
 =?us-ascii?Q?ZjCny6r8Ex8R+J2HbO1kyLmqHVr/LgED/UZBYfAtjtp8Juu3qhJtvot/0EHM?=
 =?us-ascii?Q?uo42zp8518FA/mPcutL18ySOr6ebJSjHhNd1kuFwGV/zW7lc7dc+KMolhD50?=
 =?us-ascii?Q?LLu/076TaZcS7IX1BEwTIoSfHRucsOm78uLrZANrUfYDGgotTshbTdZDocEh?=
 =?us-ascii?Q?2vwdVmXaeUYgFTWwoIAsM62lBRk0IK1LPX+wvSp5+ybU5E7YWuSFI7JWmlAR?=
 =?us-ascii?Q?Sd+isXGRM3Xc55RoIlvf/blCoeJXVajXyYfQPS/dP70eqUYMX75h0FvgL0bl?=
 =?us-ascii?Q?DRxfahQpx38foE9H30pZga44XMYbD4dM1Vo+uLHb87aXFZmPzEkhi7ipuy07?=
 =?us-ascii?Q?JS8NdQYnXOQ9JrKTFlV27yF0jWtYlc86BYYIVQZy2AD6GwXtiAe0HyR19s3j?=
 =?us-ascii?Q?KBl+Kw8F04B9V+cY2+3SGUGTkpZKItWUbegTEYFyALg/F0ajfohWimUVc0k9?=
 =?us-ascii?Q?lRo/a6Sc1iFhO7zKNU4HJVlNNvtBf9Zbe01jbgDrShZ5LHIE7rJP+Ver6tkw?=
 =?us-ascii?Q?B0uMh33YTe5NkA1ADi/DIrvx7KILEfmE3ASaOT/TpKvyv54y/4xru8rAhCfs?=
 =?us-ascii?Q?OkG5pajOrUAFQnq0en1Li7AszNWpshaW8Gd5B1w6BHkAp0JFjVPgJSVVwK51?=
 =?us-ascii?Q?OMR/K30C8FwY1iVqmybKMZYZzFv96jeG42nnm/cmcqlX/xQDsMukqXssah7e?=
 =?us-ascii?Q?fB7MWEg7HoCrDfxRKoX+OPWKHRN489phO6i3dnbHOI+ZJcgHaXkWSLT1b1Bl?=
 =?us-ascii?Q?uSquD6VY5gTjv0+86CIL5KJUH5ii6sn5v2hDZH/ls5Dm3TNt/d4ZTxmmH6Tu?=
 =?us-ascii?Q?r1NfGZswoh78gH/sH3GamBXE2LLIUhkgUslaXpoHam09EJeN+JLxFPJU0yon?=
 =?us-ascii?Q?Ehud7ilaJuP/uc6rwWs8ROGD2mRo0iMbGt2iLWHc1YQUpqow3sUzyUOpSLPx?=
 =?us-ascii?Q?t63fSYrFYIgjff79TnxAPBqAwQ8IL6DW/9qGKgAlFiNhjSueKCsR62pjN1i8?=
 =?us-ascii?Q?VeJp/H2P73qXaRiMhpsZUuBhUfSmrFCX2RN6jhxYsoDROsmatDGXbIj26PYO?=
 =?us-ascii?Q?TE+3CGrn6uLsc95LZcH01+w7GvKzFBKO10+ANr2AhuUyl+8bO+ZaZSucDOUY?=
 =?us-ascii?Q?usqsg9fL7TCTcBjynnSI0db8f/x8W+B/Anf+DBEWPfo9EMxSJSd30eeAHWxl?=
 =?us-ascii?Q?AOCGlPj5WnrM3BfNJ4iFmo1FsIlQ54YhlleEqfAbZZNdzzoVnpXADpSrSxFs?=
 =?us-ascii?Q?Iihwsrf28E/JY1d2oAkjX4vbeS4tyP8pOTG7IgJL4KEBBfPPeDj1clgYYs/j?=
 =?us-ascii?Q?U7mINZBmQ7DK9/k96BzSX+Y+t4nGU6UWH2jFJULYEIY1099gQCBwBD4ZEUfZ?=
 =?us-ascii?Q?J1t3Mot6ZCMTWC0Unno1KFJkErD8CFk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a7c1fe9-a491-4ec1-e696-08da33325de3
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2358.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 09:41:04.4350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +jD8YXkdZ71Hu0SBD9xiTMHOw5oSy2P29QqjQmbvgfSyhigT+8onD2z9lYRjxZral1iuHhvzLcenyqevy1s2+In8jMbYcnicGOQjaXWLYZI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6176
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-11_03:2022-05-09,2022-05-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 phishscore=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205110043
X-Proofpoint-ORIG-GUID: 7HCpEyMZKb7usW3Kg58pARoeqjvUcQc7
X-Proofpoint-GUID: 7HCpEyMZKb7usW3Kg58pARoeqjvUcQc7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git habanalabs-next
head:   20c59ac5d71e766235e74f353b74e60facd733c8
commit: 20c59ac5d71e766235e74f353b74e60facd733c8 [47/47] habanalabs: add support for notification via eventfd
config: x86_64-randconfig-m001-20220509 (https://download.01.org/0day-ci/archive/20220510/202205100736.Y0Vi5Fcf-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/misc/habanalabs/common/habanalabs_ioctl.c:135 events_info() warn: maybe return -EFAULT instead of the bytes remaining?

vim +135 drivers/misc/habanalabs/common/habanalabs_ioctl.c

20c59ac5d71e76 drivers/misc/habanalabs/common/habanalabs_ioctl.c Tal Cohen   2022-04-28  119  static int events_info(struct hl_fpriv *hpriv, struct hl_info_args *args)
20c59ac5d71e76 drivers/misc/habanalabs/common/habanalabs_ioctl.c Tal Cohen   2022-04-28  120  {
20c59ac5d71e76 drivers/misc/habanalabs/common/habanalabs_ioctl.c Tal Cohen   2022-04-28  121  	int rc;
20c59ac5d71e76 drivers/misc/habanalabs/common/habanalabs_ioctl.c Tal Cohen   2022-04-28  122  	u32 max_size = args->return_size;
20c59ac5d71e76 drivers/misc/habanalabs/common/habanalabs_ioctl.c Tal Cohen   2022-04-28  123  	u64 events_mask;
20c59ac5d71e76 drivers/misc/habanalabs/common/habanalabs_ioctl.c Tal Cohen   2022-04-28  124  	void __user *out = (void __user *) (uintptr_t) args->return_pointer;
20c59ac5d71e76 drivers/misc/habanalabs/common/habanalabs_ioctl.c Tal Cohen   2022-04-28  125  
20c59ac5d71e76 drivers/misc/habanalabs/common/habanalabs_ioctl.c Tal Cohen   2022-04-28  126  	if ((max_size < sizeof(u64)) || (!out))
20c59ac5d71e76 drivers/misc/habanalabs/common/habanalabs_ioctl.c Tal Cohen   2022-04-28  127  		return -EINVAL;
20c59ac5d71e76 drivers/misc/habanalabs/common/habanalabs_ioctl.c Tal Cohen   2022-04-28  128  
20c59ac5d71e76 drivers/misc/habanalabs/common/habanalabs_ioctl.c Tal Cohen   2022-04-28  129  	mutex_lock(&hpriv->notifier_event.lock);
20c59ac5d71e76 drivers/misc/habanalabs/common/habanalabs_ioctl.c Tal Cohen   2022-04-28  130  	events_mask = hpriv->notifier_event.events_mask;
20c59ac5d71e76 drivers/misc/habanalabs/common/habanalabs_ioctl.c Tal Cohen   2022-04-28  131  	hpriv->notifier_event.events_mask = 0;
20c59ac5d71e76 drivers/misc/habanalabs/common/habanalabs_ioctl.c Tal Cohen   2022-04-28  132  	mutex_unlock(&hpriv->notifier_event.lock);
20c59ac5d71e76 drivers/misc/habanalabs/common/habanalabs_ioctl.c Tal Cohen   2022-04-28  133  
20c59ac5d71e76 drivers/misc/habanalabs/common/habanalabs_ioctl.c Tal Cohen   2022-04-28  134  	rc = copy_to_user(out, &events_mask, sizeof(u64));
20c59ac5d71e76 drivers/misc/habanalabs/common/habanalabs_ioctl.c Tal Cohen   2022-04-28 @135  	return rc;

copy_to_user() returns the number of bytes remaining (positive).  This
should be:

	if (copy_to_user(out, &events_mask, sizeof(u64)))
		return -EFAULT;

	return 0;

20c59ac5d71e76 drivers/misc/habanalabs/common/habanalabs_ioctl.c Tal Cohen   2022-04-28  136  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

