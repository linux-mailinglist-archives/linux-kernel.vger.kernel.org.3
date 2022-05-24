Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCCA5532158
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 05:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233835AbiEXC6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 22:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233805AbiEXC6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 22:58:46 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9F99CF09;
        Mon, 23 May 2022 19:58:45 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24NMhkc7029163;
        Tue, 24 May 2022 02:58:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=hCwmoTdrJdTxr+lDv04Zlj6RSj5+92JKNmS3/lwNZvY=;
 b=r8h5YduypujSo86bfOCTpl1ycMPQns+FnKE93Co1JxEGDWG9c/yiuwrHmN2BEI27OMqO
 jNcuTK8tuHckFgbcO0RGbJB5H5StW7QncfFLcSBkmuc6//X3/ZACIlN4crRxqXtlhHmE
 quNr2INOyoKp5N0isux/PT3+IYQbSif/5dUa2Dyx6hy8tGkKo8jTUENb5vH/gH7DlYrr
 S53ywkG/jKDTKFWaYord4xIhKvmdEdMwe0q26cdNfHUbJnWoc7EojEEh5uuM9jwHeV3Z
 hcUqJ1b2zFvu3T9vUwc4vjz6AFvrNrb+9Ua1NYGRvb8YA0OdccvnODyXRNvk99n2Cdqo vA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g6qps54kh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 May 2022 02:58:42 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24O2wLCM035582;
        Tue, 24 May 2022 02:58:41 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g6ph8cj6k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 May 2022 02:58:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=odTnGFLAV6e5AUQWFlgxNz+7e4ow7Neq33L4DX7O4LOtT38O1DUk0P+x1eDV5L+kLlKcFgSyT4Rn+hWwMe0tXsXQ7C4XrnqwOEzTQkHbreo8n4VYHDRZmXdWI2f//QKlko69y0fEd9pe7sAgCVpC3s+KVFeJ0ZzegqAuplPuhJStBVAOsgeF04rOW0mz9ZF+60zIMOBVRMksegKwyPaSU14nzunTSXq8T8lzzlRcW6BbR14lrwGA4IWbEF7tANyIYgBLKVIWs0BfAo6laqrQVKWJ+rgohMHGepOwAsvU8m6GSsitxnhvq3O0NiBQlM460oz30dHnGrEsJExV4acSIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hCwmoTdrJdTxr+lDv04Zlj6RSj5+92JKNmS3/lwNZvY=;
 b=FoYUwNrorKCiT4wIqfdQiknc78DDHYyjuAMvyxduwCUvTcWqKvnCVAA4PQfGcu6l8pfoyi+HslDj6XpH2yJUBq26HqJzU4Q2LzuBfO6+JVAoVDhck3YX4+JKxRbBtIz37fr7TtzQrb21t7qJsKQHdSsVhEYUT2OGK5vmP7OoyIi7nA4d09i4kBo1ESg7sUP9DUxFqqbu5t/R/P+h56vIb5df1ZSdaLn7tnNyH/G+23hcRUBohYCNZqRw88CqEFUN8y8u8P83yEdI6WNHIkLG+Kwh0L1jh3ywMDV2sm2prHEVmkrqvW9XPW+leJ7Ir9uQWvjDhg/kziTQqd7pqKZDSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hCwmoTdrJdTxr+lDv04Zlj6RSj5+92JKNmS3/lwNZvY=;
 b=Wkxi/lCfDr4I/3eOf9c1u2T6ZtL8A8MDBtuA+Cgi4HY9V5Xko0EIxFgANFJHPZGI0oCrrbh5wn0CY52nBvyOzfsmuvZFMY+GHSON0iVn1p/bjZ1dBS/VV80h53CC0nWfXJDHYnW3koc2ZCMYHD8UJU0vX609Kc6mBz6ueRb+NGs=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SJ0PR10MB4685.namprd10.prod.outlook.com (2603:10b6:a03:2df::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Tue, 24 May
 2022 02:58:40 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::d1db:de4e:9b71:3192]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::d1db:de4e:9b71:3192%9]) with mapi id 15.20.5273.023; Tue, 24 May 2022
 02:58:40 +0000
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        kernel-janitors@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: pmcraid: fix typo in comment
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1zgj7hc13.fsf@ca-mkp.ca.oracle.com>
References: <20220521111145.81697-89-Julia.Lawall@inria.fr>
Date:   Mon, 23 May 2022 22:58:38 -0400
In-Reply-To: <20220521111145.81697-89-Julia.Lawall@inria.fr> (Julia Lawall's
        message of "Sat, 21 May 2022 13:11:39 +0200")
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0025.namprd13.prod.outlook.com
 (2603:10b6:806:21::30) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e1dfea1-0bdb-4260-3ed4-08da3d314e39
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4685:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB46852DB3C471783CE8A312508ED79@SJ0PR10MB4685.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ve9IsoAVxcDgt+6VRpEKDsvACQyL1hudozrOiMQ5vc11bEEsEtp98e80ExON56/JiEkbBCOSCqJWEKWNIbk54oM5sk6mniLx4USjRwhFGE3lSmASy2qUId/6gqA9ldst8qghsOe7O7g1hTwMo/JsZKT0S5JCQBKIFtAT7nAOgXdFEtbhk1OpNH0qm1aTtBliZELJ/3plYx8Sf3n4TXXwacv8gJ1Er0Dkd+ecgmbd6Np2MMTt/tByyhqH4f/1F7ZUvs0IG742cYbxqcMDo8+7g93rFFWOV8RhivJt5ub8nKIZgxznOKEHx9RxIMMUAnnKgF5rKL9QcJrWKTuz1LjrhKB3pzLiMjeNi0yfmer+g3YYiDyHs7tpscwNY7lDdlTLJ9TW+Na2ZwdjMl+RnWaK5Dn0X1k5Wn+dO+9KyIivYLyx7SC3Ok5kYPC9MfnfRIBhqpRAEZKXH/Sfx1j2CjICIeyqTP2PNQ1/Wo8/7ejB+ltaG0PYURiov3thyCtombt2WfCYMp0PCJacs+/sQhX8byga8LTUhmFQHIrKdV7L9y1m/7ss225UN81hZggE6ikfFOCyEvu++LPr3eDLGeKUTnkLiRgdvNMwgbJYh5T7DQLqwgIl1pvqfvfFmzgGHsRnB865zAn0XJPIaU4rLi/8mrPwE+Wdy1B2T2BWzxAkc6I6BsFfUnj0WvVtQcHC/leK1ANm9q0/WFgl2OnFJvfZsw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(36916002)(38100700002)(52116002)(38350700002)(6916009)(5660300002)(2906002)(558084003)(54906003)(6506007)(26005)(8936002)(316002)(4326008)(8676002)(66556008)(66476007)(66946007)(186003)(86362001)(508600001)(83380400001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?igt4ZrqkFR9lMpPxw1/lprvRYiwbbDPGfRdjN06HwhvjEROpt80cV6i6QZtU?=
 =?us-ascii?Q?HRshYXD7FP+XhVB8H1RxZyHbRaQ21pygHQzrM/dh8v1QKehzF+/s32sW0COj?=
 =?us-ascii?Q?FjKO9dVhz3U0TdELnpmD5e0Z4ol1QsUg1pvBRF+q+iW3p7yvHG0Hub8HMm94?=
 =?us-ascii?Q?M7TYXnpywYwasKfO8oyOfHTpcFzpiWz5p4ggdfyphVCMSxhleBfk/zUKQhw/?=
 =?us-ascii?Q?hMrZvd3vDcXJLjQmrGb10t7wdHMvW1kRR0kFT3XTgdT4hh4Z7K3kK0lx+CmW?=
 =?us-ascii?Q?f+xgOr+u8L7KrckmADJZV46lhT3WuG9RKDYPwAtqoIvHy9aU/VJDeZ0TKLbG?=
 =?us-ascii?Q?wtlWB/bjrL/vQ91rUuptPZLkyK3SQpci+iEJsLwjKoz+f28KMheKniFf7oBf?=
 =?us-ascii?Q?qHyynTy7gW9VgFFG6rdXEwlz5KC80vQvi61E/51eqxFs+Vz9waX4cCwtBjlN?=
 =?us-ascii?Q?fTUK/y72Ks8p2StSQaaR2yayX2VKAiIqcv6ffb6l97TYrqnDp5CnkjDaWHdd?=
 =?us-ascii?Q?eEL6xJWCjK677LfaloSwKtTanSt/t/SPW0NOJGn+eEtxSSLRcrKCNog/eUDA?=
 =?us-ascii?Q?tqCcPme3SAo8XXCmiyXfWkQNyxzX7daA2Fp+6ADiGCrk8JjcOuyfL7LZv8YC?=
 =?us-ascii?Q?x3/nPfdgNdYjl1DaU52ED2wCJLDpGQGTaZYturJeyo8Rq8EXzOQg//R6VvwP?=
 =?us-ascii?Q?+Awnaw/gYkjNn/AKiCGNmweWxphw52qCfF16rSoumI3clnNdLJWJnTBF2gOX?=
 =?us-ascii?Q?AL2S0e74TGPqpD3XPKUVFMb/vINjm46799pgmFTMAvnxlf47S5OqBBSNqKjk?=
 =?us-ascii?Q?FB/GtHKcn5qtBd8cgUcjFYP2gmmufFQMg8N8uVqk5Kk1fGmVKCjaK23g95oi?=
 =?us-ascii?Q?ET5cnxf0Nmf+tEMQD6pio9cauEgHuN/BX+vyI8TQTJMPmfz25gbGg1EsMy20?=
 =?us-ascii?Q?l3dVJxaGtfyEfsyF9yf7LGtDDE/omsJkUJipq6NR4jt980yv+OzX9lzznrWs?=
 =?us-ascii?Q?BpBb1UPsF382RvLgpQzwFYgaBx8rJfjq7bzqr69YDutfw5GNBwHJFIcD4bHc?=
 =?us-ascii?Q?ekHOfY9kK9oa+XOP03C0nNv6Kw3fuFN1MCj/oKN240p74D5pMSYFF1My1UGt?=
 =?us-ascii?Q?bsekkBCKaKudLquxrKFWAVlFaudUE0Rt7guTTTxOxKMGuHm5xrUoBCbBHY2v?=
 =?us-ascii?Q?cwRDHshnfQDutJbzpD72qFAy5cPW/dV3B1hHZoLi6vvQMIQTmAQCkKHa+dWA?=
 =?us-ascii?Q?ppDYChbfMViCob5Jqf2O3RATGlmYj0h5nz9iXdCV4bHqJW0dxCl4YELZPzKA?=
 =?us-ascii?Q?VI6LgftEZt7jZrwy8gj9qmqH5hVCwzvEKePuPAxqWbzlsHfbeqfgIWrhegO4?=
 =?us-ascii?Q?wmRFO/eftsjzVoueFBLJVuemTd0RX5dhnoCzDq5OfyP7Tjb72eI0T1pnNgi6?=
 =?us-ascii?Q?ff+pxj/MHTaNcUubuy+k+H2BBWFOmOUwHQQYbKACs+K4g8uUyxHDjVA7ftDe?=
 =?us-ascii?Q?o0Byx6Zuv9xHUo64GyDOSHAmSHJ34HzgWnTxbS7c/8rt7MGnWdg+0bxEDTck?=
 =?us-ascii?Q?M3FlWPdtYIjsirLUVHwIEIeXlYjEOLvwxyZsAiI4NSbwGmPCqddbsMTOX/9V?=
 =?us-ascii?Q?TuocBWmAlo0dqRzMrbzhkwAT8BZbmAAO9gdigM1GHH/SXhh0tv+BYI3jCBtZ?=
 =?us-ascii?Q?6VypIw+dxk9PdDLXG9xetulmxj2bITDHikEr6/oN+CtOYT7NSkeZTBFj1BjG?=
 =?us-ascii?Q?uPbLWz1BwRFh3XgVuIAa3r66v1FJ/1E=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e1dfea1-0bdb-4260-3ed4-08da3d314e39
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 02:58:40.3287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UccL3CPIDYDcn75UAF6ia09Gsb/8Hm+ft0Cj8AEYY+P/Ou4FwiI22IEeT47ftHv2y3i2u2744kEw0TBhEhgk3yn73KbwUh1QpDiiNgx/CFQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4685
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-24_01:2022-05-23,2022-05-24 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=900
 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205240014
X-Proofpoint-ORIG-GUID: _vZtYBo54DCWdq5L9FhBZO8wfX_-UWlI
X-Proofpoint-GUID: _vZtYBo54DCWdq5L9FhBZO8wfX_-UWlI
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Julia,

> Spelling mistake (triple letters) in comment.
> Detected with the help of Coccinelle.

Applied to 5.19/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
