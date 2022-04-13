Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD484FF207
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 10:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbiDMIin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 04:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbiDMIij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 04:38:39 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8A41D8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 01:36:18 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23D7baRI029074;
        Wed, 13 Apr 2022 08:36:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=kUAju9CM8NdsHhTVHfmiGu9ftd57HxdSFlXgEKxIWuo=;
 b=hZx6t9Hhdym4odv7vG2XbcJ6shwPgXuAkrGA6+L2Ugx2nNf45DfqUjbq5xvnBt3W0cxz
 VTaBXlhqzGwPUMNd6pqI75nw7LKNrDI26urwSJ+AsCZCxf6Q8b4ThaSgI7k/jLary6QW
 sLqmnk2vbAlXLlPQ3bHO4yk77kNobyQxbmqcApG3ICoe0/AZfMS91b7aFZaTfje99jxM
 O44JMXGjjpEkKl9cSRn4mytCsf1fG7Gl2CqFong07sQsDLNSkjQO7JWPAA0etpjjBvFg
 cStieznQ+yhPtLk5CXGA6yk2GljnzHFeawMxkcug5S9lPhb1SeW7vGZR/rfRK9WUHC49 cA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb1rs98hs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Apr 2022 08:36:02 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23D8GKmI023091;
        Wed, 13 Apr 2022 08:36:01 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fcg9jfkb3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Apr 2022 08:36:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bHsUCumKElQCyjs45VRAk7SoxnQDFt7U0izSccENq44+eG9K5ou8nPgcZwr+xuGFuU5/4jfERWzLcTfqXbPN4P/dG93RkdZLt2XWugSt/WPh5OYzdFK4MaAw6FYJ1whVLYDjwr6hTkteMr4S/99x69dLQFKyorBbsegGFHiLalhO1l+lZZSOou+VTszZUK2GqlimQ40x+wta7bGBQC33I9RIfnnHCR2ggS/bTE7XXMatdCPFtyYmrR55Br0QkT3EB8xoikdd8KMR5vuVEcHILrlUfyrv9J4WOtLFaWy1QmBHTa6PL4/jvNlJW6GR5XdeSe5wptorWKUSs5WXHTn8Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kUAju9CM8NdsHhTVHfmiGu9ftd57HxdSFlXgEKxIWuo=;
 b=eTpzVIykCjYI4qBASWDyUsC3PTvI/NTEBz2AvIBP42tY1qJk5VV7W6Co22LDcTblwGfFKNvTcYerZGe7tNXXgNavYCObVfySqD17hgUv3ht3DFJWj968oiLbp8km/zB0cIeMRBH96eeCEg5q2kMO3chbZ5Lzg6Erc8bzad6Jk6hfuKBQrWXTQMHYkRXchEX2xHdnGVV2orJ26JAhFmkflWWxolWkyoAlKYIgfexUxdaG08rXl25mIQhH1GzPLe/KYJkAm7ksLRcjK8jt8rAal7yfJnSkhCl9egmHWMKVBV8eB7Is8daT+mJ//0yyGmPfalxMy90/wlYU8VBWN0JIPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kUAju9CM8NdsHhTVHfmiGu9ftd57HxdSFlXgEKxIWuo=;
 b=0VHKoEGA6HYq1GjUSnWHa9/87E/x/Gh6VhJvJCODQisGcxGUYCyKNj68JKlrJ8FhFWShD1FbUBkuw0qwga4JzbiO3oBD8zli6BloDFay1Z956hX6A/DZmdTTgS7m/xrxUMDV9Qnpyj4+huJ3r58flyvZJaAjO1TLyUWYz3Vmddw=
Received: from MN2PR10MB4191.namprd10.prod.outlook.com (2603:10b6:208:1d1::14)
 by BLAPR10MB5266.namprd10.prod.outlook.com (2603:10b6:208:331::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 13 Apr
 2022 08:36:00 +0000
Received: from MN2PR10MB4191.namprd10.prod.outlook.com
 ([fe80::5038:9bbb:59f6:1a95]) by MN2PR10MB4191.namprd10.prod.outlook.com
 ([fe80::5038:9bbb:59f6:1a95%2]) with mapi id 15.20.5164.018; Wed, 13 Apr 2022
 08:36:00 +0000
Message-ID: <3cec4568-1a54-2ca9-57d6-ee6635d59a3b@oracle.com>
Date:   Wed, 13 Apr 2022 14:05:47 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH] cifs: potential buffer overflow in handling symlinks
Content-Language: en-US
To:     Steve French <smfrench@gmail.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Steve French <sfrench@samba.org>,
        Stefan Metzmacher <metze@samba.org>,
        samba-technical <samba-technical@lists.samba.org>,
        LKML <linux-kernel@vger.kernel.org>,
        ronnie sahlberg <ronniesahlberg@gmail.com>
References: <20220412043823.57037-1-harshit.m.mogalapalli@oracle.com>
 <CAH2r5mvBH8wO9rS2UwCpgjbhcLp89-RLbr1wxK76Pj=OprKwOA@mail.gmail.com>
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <CAH2r5mvBH8wO9rS2UwCpgjbhcLp89-RLbr1wxK76Pj=OprKwOA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGXP274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::34)
 To MN2PR10MB4191.namprd10.prod.outlook.com (2603:10b6:208:1d1::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0182f887-fa7e-4327-67e1-08da1d28a311
X-MS-TrafficTypeDiagnostic: BLAPR10MB5266:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB526659650478ED673D478258C2EC9@BLAPR10MB5266.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fuvIaS5Bj0DgnhGg11GcivaTo/EiSQWV7KCCkXev+NP1tqyAxFq17O2x+Y6UI90aj92M8ZneWHaPxJ256W/IuH6wdURljUeZvfUN9tGittqXxO7NgrzdBkFFzmZs9MoqEOmDG0my9LC5C4Ce6N2ude0RtW842mPym7SqzUuDlE/7Eemd4GZaESCxto6lbOHsz62wQ7toboWapExc9lmhg44Lo4MrFPDDcLF1XPVqa4S783yMxc3DJgP3ChIzq027pGD9+ArNskpG03iLzSyIJvDfJKLohQnKd0JIYrUHvYRr5o4i6pk1T/k7biqPDYeGrB5JumLkIYMW8ENq/CE1JHdQofVblvmWeRb5x2dG/dpx4cuyIbOFRA5VjFwzSyJqXeXsscV8W9q60AntEXGb2d85Knn614V4Rufic5+kMqJCV+TUEy2HY68Ixzjjzx1jWSOG1iAEoBdCCTLNa1taF+iIe8mfx3iUWvz0V9H67uGIfhs9ARXi8jfNUWVhbAIN3FI9W9WfdHwMFVchsTt7eJkqQqDugPQe2URqgSs2yG4f6KVgPrPB/ysfdxJgpdp/q2WzqusO+SDM6PcenQQ2LKUMfinJZDu93jnkYgL3rYu4YBqbFCANGgYL4xhOCBWnjFR926bdmDiB8N9Kqb4djEkyO6ZoV41AOZsHowh9KKhpUn2b6mqIBkLna3N6lTbaOsrP8nwSBaTYpkebsUjiHibbNphNevUU1XR9SNggHIs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4191.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(83380400001)(5660300002)(508600001)(8936002)(38100700002)(6506007)(86362001)(31696002)(4326008)(8676002)(26005)(2616005)(6512007)(186003)(53546011)(66556008)(2906002)(6666004)(6916009)(66476007)(54906003)(316002)(36756003)(31686004)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0dqUW5KTitBMm9ha29JZVZyYnJER2Z3Rmo2OHA5clFRTGg2WVA1cndybVcx?=
 =?utf-8?B?WTE2aStocWxKZUlJa1V5U1F0R2VOeExuWkdUWmJCNFdmRnNDZG5acTBZM1hI?=
 =?utf-8?B?RGxTZHJMSW5WUzlYMmVSaTJWdlNNU1hIS3dRQnZRTHlUckhhK1dYVGxmYnp2?=
 =?utf-8?B?dzVPWlBkUGZ0T0J1TnplTXY2dWpxMmdUcVlBTDRMbFRsOXZPUllqbnhUemxO?=
 =?utf-8?B?VVEvK2phWVVRUkcvOTNkU3Y2K1VRM0ZOazd2ekhzRW1LUWZ2TitSRWhQQVZ1?=
 =?utf-8?B?MENvaloxOXAwQm9kbUdqQ045bEtnUkZLdDBMRVB4TU9ST0JFUW51Z1hwdHUy?=
 =?utf-8?B?bTJrcE9iWDdKVjFsSDJrT0QzTkZQUHNWeC95ZVY5b05JRHNzWFBTSGRPTFhl?=
 =?utf-8?B?RDdRU0RSYXpQTElDYXpmZWJKR2R0cmFDcExvYnRkYTlOa1lTbmNuaE9XZkYr?=
 =?utf-8?B?NjJPUEJLYzZZeXpKdE14UG1BSWRUZ2Z6VGwzaXVWc1V2SW85RFF3Y0lNam5V?=
 =?utf-8?B?QXRMQTZEcDNiK2VSNmljckJCbmYyMk1raUNwZnRhL1dhbjlYUzU2VjI0L0o3?=
 =?utf-8?B?RDQ5cTM2WHZXR1ZwK1JQRnV4VGVyMWlFblNNSEJKeE11UG9uWXBnRTdpQUkr?=
 =?utf-8?B?Q1h6M3RVNW1lMDI4ZEV3YWFHZjY5emVMcW53bU9lVlNXakJtNmZOZ1k2L0E1?=
 =?utf-8?B?M0hkWUNod1pJbit0SnExMTVRSWdxVXBpcExRUGwva1pPZ2lsSEJ3Ym1EWThs?=
 =?utf-8?B?SnlObjlkUzZ2RnlZTUZLdnBwcWk4aFd0Ly9RdGFCeGp3VlR3UFVjVXdjWCtQ?=
 =?utf-8?B?S3YwVkcwWWp6VkVOY09palVaL0xjaDh3bGQwVmptNDRWK1I4ZC9zVHlRTFFm?=
 =?utf-8?B?Q3dkYjNodFRuSHc3dGhLRGY4emZSTHJ3NEtEQzY2TmVDRHRYQnhXTjFETXRJ?=
 =?utf-8?B?dC9FTC9MbFQxOFlpeHJDYXJoY2Fndk5VRzdZQ0NkV1ViYy9aeG1BUDFpN2N3?=
 =?utf-8?B?ajdzS3o0T21rei9zVG1rMUMwWWdsR21FLzc5NVdJK2RiTm1MYk1CVVhwMytm?=
 =?utf-8?B?VUw2WlIwM0VqRHNHeTF2ektueUpGcTNmbFRBOXA5SjJSbVZ1UDU2NEV0cUh2?=
 =?utf-8?B?eXFsN0RoRjA3NjBvb05PREpiNHFHRDQ2NHBKSFc4bit0clJ6Q0ZaaU92cHl4?=
 =?utf-8?B?MXhuTml2RytSdndHMTJubGxOZlc2emd0a3BFNUdDQU9lUVU5SENtcXlhbE8v?=
 =?utf-8?B?TC91QitObFpPb3gvMkRidkxIckVEOHBJd0pKOGxGVElmZHVtcUhVVzVwTnNP?=
 =?utf-8?B?S0c0OVBVYi83NnBheDVCSm1KWW0yOTZQRTkwWXMxMnNrQnVLcEk2ckVrQUdL?=
 =?utf-8?B?bm1YM0ZCcVlGb1lzbS9GWURxWk5hWElNaWUvR0UvLzcvNGRoL1pNa0I4aXFh?=
 =?utf-8?B?QVRhWElpOWVtaWNiQW1hWlBSWXB3Wnl4VjdvUXVrV3FFZFpFdEJtTTExenc3?=
 =?utf-8?B?ai93Q21DMEwzall3dTZZQk44ejM5ZllJRTFKTEt0R1lxMDBJS09laVhwOXVw?=
 =?utf-8?B?L0NWS3A5bUJSQis2Q0hYc1dMRFVUYStSMFplQnBZU3ZLZ1dFMllzaCtXZ1J5?=
 =?utf-8?B?WGdMdHhoTnJuT043bkl3Sm5kMU1yTm9zeS9yWFptKytIbUZQMHZmaUdmMnpu?=
 =?utf-8?B?RFF3YzV1UTJMQ1owRks3MzhzR2R2VGhzZDhodlVNY0tOK29MWGtXSGx4ZG0y?=
 =?utf-8?B?QUNoNFNTcFQxRDZGeVBVL2JRTEJqdWtJS2pzZmY3MUJLck5qbHhnZDZvVWMx?=
 =?utf-8?B?WWxxaFVtckJ0blpSb3hyVW1obVkvVk9jZVphWHZLRzVPMVd0WHdEcVBTb0U1?=
 =?utf-8?B?SmJEYXNPVllYYWNtOVNObVV1eHNFd01IZVhFc1hidkhlWG93K3VDUUV2SXlE?=
 =?utf-8?B?RFZpT0VmZFBIQ0loZGxUMkVqelFJaTJjcFdIMUZlQldJNHhDbFZMa2Jmb1dM?=
 =?utf-8?B?eHo2MTlaNUw4SVE3SmcxTGdhS05wTHg0S0tqWEtBaXR6R2hhbkJrcXovQVZH?=
 =?utf-8?B?S1FUdFZjUXZ4M1lpT0RBZS8wVG0xMEprVnlkbzB3M0wvaUNKNWxUVk1vMHd4?=
 =?utf-8?B?d2dzdjJZZkNCMjg2VUVNVEIvRHVKd3A0RlplTFRsYUcrUWhKVjk4d2tROGNG?=
 =?utf-8?B?YmUxdHBaakVnL051MDVQSjA1Nkp5ZFFpZmpTRkR0RXF1c3BLeW55aWRER2Rs?=
 =?utf-8?B?ZjIrWW9Cd0U2YzkrcG9reGVYQ28wSHJxcEFXc3NQVG4rdndwTWtHWHJ2OVJ5?=
 =?utf-8?B?L1pyYjRSb29iZHkyTWZTckFXb1dqc2RsYmxQSlRVS3kweTF4a1o0bTQ1Tkxi?=
 =?utf-8?Q?MqXhImCnknCrG9hO3pRXfHc739NJ6szmrOzk/?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0182f887-fa7e-4327-67e1-08da1d28a311
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4191.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2022 08:35:59.9164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CSTeaxHBjD6S+vWG6QnXEfHJlMN5T0JuIZA/LQy1tVrGMBq/C9PZf0p86sLsDEXpYBGfyObJP0fhZC0dlJ20LT5pC/AYt1VKd2cs5Mm9Db+SjWJMESpNMirrPHP487dd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5266
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-12_08:2022-04-11,2022-04-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204130047
X-Proofpoint-ORIG-GUID: SGEhhrPkx86fYMUJn3MIgxDFeNWacvgi
X-Proofpoint-GUID: SGEhhrPkx86fYMUJn3MIgxDFeNWacvgi
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,
On 13/04/22 4:02 am, Steve French wrote:
> Wouldn't it be easier and clearer to do the compare vs the maximum len ie
> 
> if (link_len > CIFS_MF_SYMLINK_LINK_MAXLEN)
> 
Yes, thats cleaner. Will send a v2 patch.

Thanks,
Harshit
> instead of
> 
> if (link_len > buf_len - CIFS_MF_SYMLINK_LINK_OFFSET)
> 
> since buf_len is  CIFS_MF_SYMLINK_FILE_SIZE and looking at link.c line
> 26 and 27 this means we can use CIFS_MF_SYMLINK_LINK_OFFSET for the
> comparison:
> 
> #define CIFS_MF_SYMLINK_LINK_MAXLEN (1024)
> #define CIFS_MF_SYMLINK_FILE_SIZE \
>          (CIFS_MF_SYMLINK_LINK_OFFSET + CIFS_MF_SYMLINK_LINK_MAXLEN)
> 
> On Tue, Apr 12, 2022 at 1:01 AM Harshit Mogalapalli
> <harshit.m.mogalapalli@oracle.com> wrote:
>>
>> Smatch printed a warning:
>>          arch/x86/crypto/poly1305_glue.c:198 poly1305_update_arch() error:
>>          __memcpy() 'dctx->buf' too small (16 vs u32max)
>>
>> It's caused because Smatch marks 'link_len' as untrusted since it comes
>> from sscanf(). Add a check to ensure that 'link_len' is not larger than
>> the size of the 'link_str' buffer.
>>
>> Fixes: c69c1b6eaea1 ("cifs: implement CIFSParseMFSymlink()")
>> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
>> ---
>>   fs/cifs/link.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/fs/cifs/link.c b/fs/cifs/link.c
>> index 852e54e..ebfedae 100644
>> --- a/fs/cifs/link.c
>> +++ b/fs/cifs/link.c
>> @@ -85,6 +85,9 @@
>>          if (rc != 1)
>>                  return -EINVAL;
>>
>> +       if (link_len > buf_len - CIFS_MF_SYMLINK_LINK_OFFSET)
>> +               return -EINVAL;
>> +
>>          rc = symlink_hash(link_len, link_str, md5_hash);
>>          if (rc) {
>>                  cifs_dbg(FYI, "%s: MD5 hash failure: %d\n", __func__, rc);
>> --
>> 1.8.3.1
>>
> 
> 

