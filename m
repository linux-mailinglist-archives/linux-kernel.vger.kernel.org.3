Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7BF6590A06
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 03:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236136AbiHLBxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 21:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiHLBxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 21:53:42 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CBBDA1D00;
        Thu, 11 Aug 2022 18:53:41 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27BN69Xp002833;
        Fri, 12 Aug 2022 01:53:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=91LpU7HBk/J52bB9Tnon5auaCLG02b2t6Vcl8CgsvqQ=;
 b=Olhyv7/oYoWqxQm8V/e2rH3q441Rl1yhIXQOWz76C48/K7doI71zokw+spmaYY+59iUP
 YT9iDxHJIM/WVH0mKyYfPrL5v2MBQm4C2+tuTkARW8HdR0T+CH7mtbaxLcztWrWMrAJg
 bluC+bApIec0Nj9zMjDA5bDd6M6zTRvuPE4HNh6N7yTe11h3Puz+pLVFwW0X2InnDQi0
 X2/KveHSlawJqU/OHugFJ5c64Dg3iTXkcuhd+Zj+3DRXOpOF2zgnnuO8252+I05b6pGF
 LuGkGn4UFngegfW//SNA0LAO8OGpXietCaORdDrLTwe1j3HGetgtuCjACfgYDHObWOIZ CQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3huwqdxar5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Aug 2022 01:53:22 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27BNhIQP019088;
        Fri, 12 Aug 2022 01:53:22 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2042.outbound.protection.outlook.com [104.47.74.42])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3huwqkp5ba-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Aug 2022 01:53:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T3mkNX8PrqWLW05u9y042hNprLs8zP5ReeS42qQ+qf6/lMHV6RAFEgH4Al4cFDTkkyVqzZdfRYvtNXc3erUTxIywy3UOzFPFaWQZrKkPd7EjOtAIUw33O+llVAim9TB4xzw+r/A3a/VESswcDKm7fsXvSXxTftojx2WyFUVDURrRG/SybTeCAA3JhGhkWx68tvYQRg5YAeL5VHxUDf1uUcOdO6G6UlRJyRF3RZ5Zs2yJGAoVhVoEOZa6KwsB+wTVm2fRaZlWAGJR7P3CAdy7z+pj2Cq/lvKp+TBfUUdgMl61Rn6fksM5GmDMLdnkkdVdu1PJbfu7nY5y6YjkRkz4RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=91LpU7HBk/J52bB9Tnon5auaCLG02b2t6Vcl8CgsvqQ=;
 b=GRSb0YCMuwaEK9Jd4wqYUtvWR6RGvzSxFkNy/EVcgptbhGIQmDL9LdTI4uExDyLOeYr8wH6zzggiSAVcUFWEe7VuTZOBKnohc1gRR6v5MYd4FzccXrukXdehHGV/7EbhWc9f8yqcUTvYFRG5AYHQUZa32znXnR7nNPlo99uftftAISa3nYNW4mKBDlxbqPHfrZ/wtUmPKUUDflf1Dt5AJuhGNfYqR09sVNCleW6jrv9LKEeYB0CAz7xgkx3D6OjtGqIYoI4UrZsxlphVLZpwWIl+9T5UNNOpbLl73fez7WUy/GmPHaYt2AxPD7GGk5QweqiP0ddB5p0kXQ7xzYcjsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=91LpU7HBk/J52bB9Tnon5auaCLG02b2t6Vcl8CgsvqQ=;
 b=0ABw5DvNF74Nksx26ffZODgnPlvyveF/ewFiyYXP4fqW/3ZmUabuc+D3ai/RKTf2A8Fina/2w3WvAfhQD2NaweRZ4O8PdynOMg4deI+cmS4bkyUOd1YQfMXEf0mrmKQ+ow24I5wyto6FNS3kLe5VQfZXbUID7MnFUvY1S3+liOs=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by IA1PR10MB5922.namprd10.prod.outlook.com (2603:10b6:208:3d6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20; Fri, 12 Aug
 2022 01:53:19 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::89a7:ad8f:3077:f3c0]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::89a7:ad8f:3077:f3c0%8]) with mapi id 15.20.5525.010; Fri, 12 Aug 2022
 01:53:19 +0000
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Chao Yu <chao@kernel.org>, jejb@linux.ibm.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        hch@infradead.org
Subject: Re: [PATCH v4] scsi: support packing multi-segment in UNMAP command
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1r11mmdpi.fsf@ca-mkp.ca.oracle.com>
References: <20220616013617.2284341-1-chao@kernel.org>
        <yq1wndgnj4i.fsf@ca-mkp.ca.oracle.com>
        <a15badd3-b9db-929f-1dc2-863fbff03992@acm.org>
Date:   Thu, 11 Aug 2022 21:53:15 -0400
In-Reply-To: <a15badd3-b9db-929f-1dc2-863fbff03992@acm.org> (Bart Van Assche's
        message of "Thu, 11 Aug 2022 12:34:15 -0700")
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0082.namprd03.prod.outlook.com
 (2603:10b6:5:3bb::27) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91d4b530-1566-497a-be2c-08da7c056e53
X-MS-TrafficTypeDiagnostic: IA1PR10MB5922:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LIZW861IUDexAWXLj0JgI6tSEe/HZufHfqP8mC8mU0xGOK+zE8ytTZ1GcjQjleZfR9jm7J9aThPqlWrwZbWgKoSr17mgMR33B0yDDbX99MUBLqmCq87v6scoTBvwE/s9Y4BV/OgKAzlPStLiomXEskurE3l+EC5bS2vf4OfU99CVLAgYr3jcZal6YbhBGeDw0hmHN13mcMykzoxSPMIq9J8pS/UOKYqmXecZ/uoTFC78ZyFiMLeMOFCHz7mQIjPh8GkvSBo/IjimgZnN/424bTqMHhGRn/qj7Ww4uMNOkdW7gfWziOr3LL8c/4xm5qySOV/rE559zn76C6skhiaIBzbGYwwnLo5Wy8WvJyoZLyWz2g03Evv1J3TMzitx4FcJxw3IblRISdbVQPIuxm9KB/mslZqGPHkl81RoR99h+avV4YXqFNHj9mlVOjUC42gq7x6XujRGtuX7VLA4ovqLCd0Ms/VdKfHSP6naTTDwWxLa4yZQceUgQUUrijkqAacZjvorjctQDbaHpQe2zhe3zsT+rpRKlZ7P9LkNIkNDlo3YLMrFbqvrjFBie28corEXjKO7oDl3acReZfd1v29vvlzA++CggHdzg2gut4AGc9ce0WU2T+dPwUpON1SJPEhH4Bd2ZREmDvvPKtxtMgYSmgQQI5dBnxPC25n5ssA30CmczHCvKdRxZuvlg5FxUabBU9YDxXHSe1j5ClR0jxyzlOPAIuyycgRvBU49JIhKNHdllJCDg3V7CA/7Fn76FjC3+lkgaT8ByB2iP9NhGRN7NQT15PTXtRx99fYtYZFIKkCT/cufIX/XQYuYv1VAVOzccrPNYnQuM6nTIO2CQtA6ug==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(396003)(136003)(39860400002)(366004)(346002)(6666004)(2906002)(6506007)(36916002)(26005)(6512007)(52116002)(38100700002)(38350700002)(41300700001)(186003)(5660300002)(8936002)(8676002)(4326008)(66476007)(6916009)(966005)(4744005)(478600001)(86362001)(316002)(54906003)(66946007)(66556008)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9CdtKiMqDNsG3zWhSmk8OdiEjrQU321yV9qc4YU0rdRjdPAJL2I9wa/4iE3N?=
 =?us-ascii?Q?8BXGOpJtyhE0IxM3JvCxcVm5eyVGElFeS3Njq3UeJ0MjLvfe8i3xrsNmho/O?=
 =?us-ascii?Q?j/kjZwkzN5Pk4+VY0QpHhoS/Zn1NuDeka3YLH7GJpBdqClA5SyR7RLXzH8j5?=
 =?us-ascii?Q?yllpVMXmxf+2X5k/X7CCu45GSfZ/jK3bPN/QlcaroNXWBZ0gYwLAVPuq8HYv?=
 =?us-ascii?Q?7bR36KmTEeAey8ntFupJrtrz/pj58orZx9UGnmuj71I2arpwqzXe+Hja9Plr?=
 =?us-ascii?Q?w2LhOhIhBwOWotO2egkw5guwZrx738ehWUgQXrHaUY3lG3Dc0Mn9PvL+XC/H?=
 =?us-ascii?Q?L/SFLESrmXP3ANkS4pBUAWrWZDlFj2pk11UyfeOeFSYVKmDTwXebNy5LM1Wn?=
 =?us-ascii?Q?X/fI3eR0c9txUt0b3ljnwbK92+kFtw2JL8hTNJ6u5Fu49ljds8aWZfJo4Xg0?=
 =?us-ascii?Q?xUxx7SChcBPLNryAMNNCTC670knRQRW/a+dxfmf+LHdbGd8KJztC18xSVBG6?=
 =?us-ascii?Q?EBW32wtV7LmH9O2Vig8jQjsmYU7eipv4oBRPSBJlTX7U5PpVrjUYh2Q+QPmY?=
 =?us-ascii?Q?g5yxY/9+5BJ1U8uzOKoxiCVJllOz4Ldu83y9+rEXvzT9PJuw8jB0lzaEkAhU?=
 =?us-ascii?Q?wXTftYgVvjul7XLM/lTLJf3aZU5Y+HvjQGV1FyNTzYMVwrZDRuc11DR1piIN?=
 =?us-ascii?Q?w/3ampJjCHNxH+WcnNzqqL31IEIGDIrulrQ+SsNkWTu/Y3d2UR4JTbT4fgYT?=
 =?us-ascii?Q?Zm3ggE6M+uQOYeGvsWXHXV3BpE4i7YiHuM9KRC7YiyOG6+rVSRNlhjk54/Dm?=
 =?us-ascii?Q?0K59JPpYAjRcXn4fnR5PdVWplPvZ+1pr5Q1UwLf9SZjrty+AOLzK9nByQIsB?=
 =?us-ascii?Q?JgsHLz+1vQnbQslE8TtvW7NffNhzziNrX0ALQHUDeEXAbeQOF7emvQt1/vly?=
 =?us-ascii?Q?az4LRAIdlVuqizS1HrJPh4ypBTibP+bAQWolpnqoimnFN5RaxKya8P8zCPXc?=
 =?us-ascii?Q?xxvhl5Q99LCnB39eb+J8HvTiBpXc55O6/zMLdPgoH9bvBdXayoDTlq6LLVkm?=
 =?us-ascii?Q?/1PwiO4aq218H6C7p7jq3KR3kx0qz4pO1Fh174BpwP11Cq2hitTHZi/hydGJ?=
 =?us-ascii?Q?LikqEPn3r5/BbQOEWGvfNOUlfqvpRxPeSMTzD3yS1mQc0YfkU0sTzhoV0GMm?=
 =?us-ascii?Q?gJ+f/EGF+BnxW0tdEF5QURJwR8FDF9iPjWpojPNDbvPf90sJOmS8XtkcOt+J?=
 =?us-ascii?Q?nk+ijvVfbptOxknJJQqBYrhmHUF6QocT9ZV/qefQlxpdKwC8Hdjg4IIeLlVS?=
 =?us-ascii?Q?vGf07xNnsQZYYDzvyDcoIcH6DuvGrDE1VN6dN5FyO/GseWBXpxk2/w/8CEMQ?=
 =?us-ascii?Q?55M2yNuY/T7voRrVlPksRx3d/GZn8j1WpiUY4+ZcXlX6ZGeWmL01Krsch8Yx?=
 =?us-ascii?Q?XcEKwHS2GRJTS+wrF+Gy9/1WcuT4ob686xS8bQzip+2JwTQiFAUViQ7wHINA?=
 =?us-ascii?Q?1xhS8PGPvj99F7A6q2veZpVG9TgTz9yO8eKH7CkZTPFRnWrx9eleULH4MBAy?=
 =?us-ascii?Q?pUlMtYlYrdERaSXP4Sr0e8Gea/sSkeUz8aNmqUJbZIlPXoI+5EX41gKdW3X2?=
 =?us-ascii?Q?eg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91d4b530-1566-497a-be2c-08da7c056e53
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 01:53:19.6040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VrsVMGO3F5Xos2eTXtCnzNHgrZ/fdjjlVMdIF3l9z8aHBnG3eIP4Fa5O2M9d+DrnliDN5L38qeKRoYuvI2TVrgKq8/Lk9fX7KkdntfzsAbU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5922
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-12_01,2022-08-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=954 suspectscore=0
 spamscore=0 phishscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208120004
X-Proofpoint-GUID: q0_a7-mUB2RgScvX6IfMvI1N2meycbfv
X-Proofpoint-ORIG-GUID: q0_a7-mUB2RgScvX6IfMvI1N2meycbfv
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Bart,

> Have you already had the chance to test this patch? We would like to
> use this functionality in Android.

https://git.kernel.org/pub/scm/linux/kernel/git/mkp/linux.git/log/?h=5.20/discovery

Had to drop the series from 5.20/6.0 due to a couple of reported
regressions. Will try again for 6.1.

-- 
Martin K. Petersen	Oracle Linux Engineering
