Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B61C51C0F4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 15:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379797AbiEENkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 09:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379804AbiEENkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 09:40:01 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD47C56C34
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 06:36:20 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 245CI4B3026110;
        Thu, 5 May 2022 13:35:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=eeuPFhI5iYHP/XSvtiYC5hSjM+vqcjiEKLNHEnOpa78=;
 b=Fz9e2v5t7Qb4ruE9jxDMNMrH28i/2OoxcX3GAZ9aVQKItHh0HIxcK043UU+rwfCWKQQV
 OhxRcXobbCclf3h2f5H0b0JCjNu8LT/h7AVWEbtOQ7ESa40kLpwCo83JsQX5LkJDCl29
 nTKzilf6ocid0PY3hzWYZZBxSl0s9wqVj6NxmNXNbfK0jQXm7V28OrgvpT16vpgj5G9k
 ku/HQTXLB9+iA/0zIJ9sfz6qLA1GSwPoBbxtuJejXXLzqC8vxBHpkDc48wLs5AZBmV1U
 jv14IMDyYpdCJcMWK3Jl5dfM9x7Y/VB1K513/VJcEZOZso4CVeaxRWdxipb4YDSS9afa EA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruhcb5ph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 May 2022 13:35:45 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 245DQZb8002464;
        Thu, 5 May 2022 13:35:44 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fus8y1yjb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 May 2022 13:35:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QlqVz5/4nCZ5BYQiptruMo9DkOY0Fl3CNgsshyns/SW3jqKfFEownb4yWQVDoxSNZBy0Qjx+ndBTgaW7nsj8kfGLEsxDQM8Kl39NkScA4ig7EtTKE/xHbLNfXGckV9lMmNLYLa1rmdoiWQSs1G7zq8xpknyaqms/7B5QVu+euH/UGooR6Dxw82aiv2ET4czt1MmHrOyh3uGr3ImgXKl2qaz5HJL4rR7bCEzdAFnXdwd2CP/Ew2XqfGZdrmh+m2xpoUaZDjbze3/Jn6qi0ZhPHIyYlRBan911oLlv8HxB5/EKd7BCwfhPL0GjnqFcjipUox7n9PL3LucNCzGE1Biz1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eeuPFhI5iYHP/XSvtiYC5hSjM+vqcjiEKLNHEnOpa78=;
 b=F+Po/eb0VlYz1+OId3wO2WM/gczvfEhI5GQYJBvAAdiCLEG5xOWGJHjuU3lWzuhk0tcXN3+1T2GR/1Td5VAPj17mpdtdGDuz0MPEm+b3LPE2TSqZTvIcaHiF0j80BSFTJd2xXjtv+02AAU4AgNdKiJS2X6MmnldrmcIqyVKN6X0D0Q7osb7C0D1aUg8OtE+eIbdlQ8Zqi+J95AVxCVfcfAmVUCK3J6ZLeHGlELFh5F5IC//PYLr5Qi+jf9n2w45MbklBm6kewiR9w40eAYWJ2inmT4E9VvBjuqcug0VIvxx/6pc4aItnrP1/LTBvkTJBPvn7DiY01+w2mnqmsITHwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eeuPFhI5iYHP/XSvtiYC5hSjM+vqcjiEKLNHEnOpa78=;
 b=oI+SzU8igWyHQdyk7tTqwQtf0LKjw2bm9irao/odbHpE0FiAkPD6FbTW70noXRISfvDHy6Zz+siYXRHjdvicMnguUdwXnFWYAh4WeSXPFZIDDe+lkv0nWR0zJoqADS/wCMPQRCfK/dmciS1Zt/ad0tin54eJbQlRKlHXHLoZ6Z4=
Received: from SJ0PR10MB4542.namprd10.prod.outlook.com (2603:10b6:a03:2da::19)
 by PH0PR10MB4693.namprd10.prod.outlook.com (2603:10b6:510:3c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.18; Thu, 5 May
 2022 13:35:42 +0000
Received: from SJ0PR10MB4542.namprd10.prod.outlook.com
 ([fe80::2cad:be53:725f:ba00]) by SJ0PR10MB4542.namprd10.prod.outlook.com
 ([fe80::2cad:be53:725f:ba00%3]) with mapi id 15.20.5206.027; Thu, 5 May 2022
 13:35:42 +0000
Message-ID: <81bd97b6-d32c-61b3-b615-06bb2d67273a@oracle.com>
Date:   Thu, 5 May 2022 08:35:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v7 4/8] crash: add generic infrastructure for crash
 hotplug support
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20220413164237.20845-1-eric.devolder@oracle.com>
 <20220413164237.20845-5-eric.devolder@oracle.com>
 <YleK3J/4HNuFioIh@MiWiFi-R3L-srv>
 <4eea2373-32f3-9960-cbec-21dc1a428807@oracle.com>
 <6f3a6cbb-0ac4-f178-fc17-18f9594da319@linux.ibm.com>
 <YmeBjrChOHsIYG3e@MiWiFi-R3L-srv>
 <f2dbd4fe-6201-b5c4-2725-dec9c3dbf13e@linux.ibm.com>
 <YnNkgfnHlUTky0lt@MiWiFi-R3L-srv>
 <e677f11b-32f9-0c89-9592-b987b00c4353@linux.ibm.com>
 <YnOvIuSRZX1cct4Y@MiWiFi-R3L-srv>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <YnOvIuSRZX1cct4Y@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAP220CA0005.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::10) To SJ0PR10MB4542.namprd10.prod.outlook.com
 (2603:10b6:a03:2da::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7b48aa6-bbdb-431c-080a-08da2e9c25a3
X-MS-TrafficTypeDiagnostic: PH0PR10MB4693:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB469346A0BE03737146102DEB97C29@PH0PR10MB4693.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C3IR8Lzs96f9RcQLqve2zUXUp7dogIe3tnYFomGeTVy3bjO0ThVt5osI3/FCYW2qxyHLamHPXqDsq2hnuJo6EuYB8Uc1vNSOsBSnX6uQX7VTl+Czs2oIxbgS/orVKGIxLoA5cMkeN0NbUOuzlF19/x5MOgeHKCWR8hc9TaaSpunAh3I8hxyUGaZacm9k/HjnVKMPPJccCYH2GykXd9pnCFHeE5iATiy1exgLdyzuZQHu5i3UZVcyPDJ6NwAbJelhvK+srSdfYEdfwDXPoKTVbsYYmsxrQ2fuwY8UYLrNr287zlj+2PLHCBLsW+4Ts436qrRTViGQtHAwMj5CE/1HnDRw/3JD4mTM4uDcaVZ9Yyk+et83UzJuOdE0qcTnfAHaKc80UX9vFGGT9JFa90uFi+NAqd2xFOHqBAtyeANHgQZhogvAOqMA/Jup0eGsOd7d9Xb0pXEOoE+bdGkHC4KpOkNBnyU8LPTIZaQtCt2l9yeZZ/Z5dthg41NycBAdALzWx8sBgP055dc7LAtT9qFIT88xGoXb9Zs/ET4YcUa9xH9B8X11U2hbSMOPT6ddhGEU4iirYRR5GLVWBFc1cyhXXj53o90A9uvYFu8ta10L9G8QS8SUqe2QhylBTzfwNW8vIa2GtnBZPS+NuheFSszifU1e9YzAC0/6CHyQBxUZodoU8w+qxVb2aHPXcT4WxglhnOQsPXkNyk4643NDdyqVJ6Pl2TfpxxquJ/nJuJ0P8I0LmIzCl4HVtH4xPpZ0ob5p7UlLOfI12Dg9AEgS6z/e4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4542.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(7416002)(8936002)(316002)(53546011)(83380400001)(31686004)(6506007)(6666004)(5660300002)(2906002)(36756003)(6512007)(2616005)(31696002)(4326008)(8676002)(86362001)(66476007)(107886003)(66556008)(186003)(38100700002)(110136005)(66946007)(6486002)(508600001)(41533002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGk3MlR5T2pRcGd0bldBRmNieXU2dG1WSWFmajllZUhFdjRDOHU2MXBOaUUx?=
 =?utf-8?B?Yy9DMU5ta2NEMHBRdWpFWjI3TVlSTVhySHFyeFhsVTg5RFBBK3FIOFFscHNh?=
 =?utf-8?B?Qk1OQlppOGNOWXNJUlNlanlocVF6dVNVbkN0VGxBaU9vV3EzUVNMZG9GUlN0?=
 =?utf-8?B?OHBIb3pYOTlpcFRlTzM4Mnp1NG50eUtEUFIzWExVZWlTUFhXY3ZoUU80WFcr?=
 =?utf-8?B?M0c4UWV0QlFHWXZVdWd1RGMrRnFhSEFhMlA2ZGxhWCs1VXY4SjMydm9XOVZB?=
 =?utf-8?B?a21tWTM3Mlk4Ym5IcGtaNnA2anNKdVVXSFF6Znd6Z3BWZk94cjlWRC8xTURK?=
 =?utf-8?B?UkFhUk1CaTd1bUZnRGtpUjV2dlFicXBGZFBLaDFraDZ6WkduRXQveU5nT3Q2?=
 =?utf-8?B?TWNWWTN4dm9KamUxUlFsZVVtRS9GMStzbUlPZXRFL29WMWl2dTc5TjdTa25Y?=
 =?utf-8?B?SUdRVFZ2U3lMdHVpU2tLNTIvT1RGRXlwZ0RPM01LYVliaXc5TjlmOXVYWDBF?=
 =?utf-8?B?bEc5dWJiY0xDUmdHbTFsd0l3ekFrem1YN1pDajJYV0hyeTBQTFFxSmxXajlk?=
 =?utf-8?B?WTBXS1RXQUx1Zmc0cGRNeUw2N2VBVlRUQmNSUzRwRkRERjdhalYwZE5yMDJ5?=
 =?utf-8?B?bVRLNVdFR1hJQ1huc083ZzVQN1dqVkhrSk5HSlJFQ1NJTHd1eXN3eGVyVmRa?=
 =?utf-8?B?STEvRHFzOVcxUGl5WUYxbjREVUtCdjNDSGhEdzFsamdzNWo4MHJhT0F6cit0?=
 =?utf-8?B?RFNwMUVUd2MxU3RLUC84SWVYQlRpQ25Mc3RQMTUxMzcvOHl5WldpSXY3RHVJ?=
 =?utf-8?B?N1RMUWhDZ0pSMFJjT0hqbDU4V0JhbGs0bHRJQ0tQSXZBQlRVaDkvWEtzVWhU?=
 =?utf-8?B?VjNxUWNUNm9oTWFITzY0RFp0SkVEeS9FN09NVFBjdFNsRWVzUGtZaklEYnkw?=
 =?utf-8?B?ZnE2aVFldFRhSG5iZGkzcTNqR0ExWEx6YnllSG9PVnIwbkpuT0hnZzFaT1h4?=
 =?utf-8?B?eWcxRjZ4SklJdnNob1B2dE02bjNraEtLTXM1K2w0M2QwS3p1aEkrTkhqTUMr?=
 =?utf-8?B?eG10aVRVeHhiTEJsQm5pbkpXUkhwS1FnUjVveXQrR01ObzJlWk9mZ0N0SzZW?=
 =?utf-8?B?NW9VeVJ6QkozTTdIUitjRmZGb2l3amdSLy9LanNlZjBGVE9tSXI0OElHekNJ?=
 =?utf-8?B?REtiSlcybjg0bnhBQU5MZlpBbk1WdC9MYkliQWYwN3lvcWR5NU81QzFvWFlP?=
 =?utf-8?B?SEoxbEI5bm5lSGVyY3hwRHhMcGFLUjZrUXJTa29QV3hhU0xmWGhoVTcrc2VR?=
 =?utf-8?B?TUplaWxldzhzbnBHUDJCOHc0U2c1ZG5PaWRQRTkrSXlGRHVHYW9oVlhmK01K?=
 =?utf-8?B?cFRTOHZaMzdKcFF5aGl6SVNDM0NLQm1SUWFHVXNqREtRekVWamFkdTFnbXZx?=
 =?utf-8?B?QlZ2STV5VXJ2aXF5ZDBmQ3hwNkJGQXdKWmREVGp3ekludUZ1OEVuQkhVZ3Jq?=
 =?utf-8?B?SVlCOURKQW5WK0JlSVJvL0lZY0d5QjJ0VTFxZktnbTkrclFzaSt3eno1QThi?=
 =?utf-8?B?MkhNSjhPRktscG5SVU9mY1RiWlF6ZmFybE5CclpuTjhkNGk3cXZCZXBaenhp?=
 =?utf-8?B?RHZkaW1qQWJuaHFRWEJCa2pCd0ZjM3UyYVgvK052WmlWWHQ5MGYyeFNlM2lt?=
 =?utf-8?B?SVlRM1JrajBONFZMWElnMzVtRnREMk9odnd2Nm5vLzVzWFcycis1cjZJTUJs?=
 =?utf-8?B?NklyaUhaYk1jbWpaUU5RVy9LcTJlWHh1OTRvbUhGWXY1MS9OVm1wdWtwTXkr?=
 =?utf-8?B?NDhHTjhtM1BIcmZZVXFkTFp5cVZNbGhZaVVkbmxsSlE0M2dwSlRwWEJuU1VX?=
 =?utf-8?B?czlmelpnTWVCZmF1R3RQTklsOGtsZzNES3llQUhnbmhzUi8xamw4dGhNcnFp?=
 =?utf-8?B?VWg2YkRtVURrcDhWa1A3SEVZZlVTU1RBd3k0NmhLazF0c25Ma201SDNrV0w1?=
 =?utf-8?B?ZEIxbENEd1BpVHBWaXB3cVJ1ZEJXRDJVOGFsOXVaalhxVkl3VVNjd212Ujlr?=
 =?utf-8?B?Z090K0dLdWxOS3Jsd3FlQlZaZlVYV2Ird1pFV280VUxGZVprcXBxZUpsdDgx?=
 =?utf-8?B?bDZUSUh4M1VianAzc1dVNklmV2FNNkFHU3NZYlFMdW1aU3FacFBWZ0lDd29t?=
 =?utf-8?B?WHQwQnJEQzdNSUdXUFBKcHNUUmlEYlZoNm0yU3pFbkxBRHdPSDR3K3RXUU1G?=
 =?utf-8?B?Vkx2c3pvWE1tcUxubWRLbjF1R2NEQS95SUZodVJEbHN3ZE13NGVwemJlTFU0?=
 =?utf-8?B?aUxhSGFhZy95OW9FZFRFQ0U4ZHJIeGZMWDlvRElQZFhGbUJJTzJwYVBjU0hL?=
 =?utf-8?Q?oodJLDRhQUU+oyrgjnAB2HjVV4ttfiAXHfvSE?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7b48aa6-bbdb-431c-080a-08da2e9c25a3
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4542.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 13:35:42.0074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2zHLiIvz8AN0+TaCV6f+XGRvctzSyKCQgPEbzZ1SEhPUTvm4epJDLPuM3QOOxR3hj4vNafpOrzQIngiy5jxcA/+LPpfMe1LujgLoOAgAkFE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4693
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-05_05:2022-05-05,2022-05-05 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=830 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205050098
X-Proofpoint-GUID: etz6drfkDH5NgaKklSBMgmZdQal50dFJ
X-Proofpoint-ORIG-GUID: etz6drfkDH5NgaKklSBMgmZdQal50dFJ
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/5/22 06:04, Baoquan He wrote:
> On 05/05/22 at 03:29pm, Sourabh Jain wrote:
>>
>> On 05/05/22 11:15, Baoquan He wrote:
>>> On 04/28/22 at 10:48am, Sourabh Jain wrote:
>>>> Hi Baoquan,
>>>>
>>>> On 26/04/22 10:52, Baoquan He wrote:
>>>>> On 04/26/22 at 09:36am, Sourabh Jain wrote:
>>>>>> On 15/04/22 03:59, Eric DeVolder wrote:
>>> ......
>>>
>>>>>>>>> +#if defined(CONFIG_MEMORY_HOTPLUG)
>>>>>>>>> +static int crash_memhp_notifier(struct notifier_block *nb,
>>>>>>>>> +    unsigned long val, void *v)
>>>>>>>>> +{
>>>>>>>>> +    struct memory_notify *mhp = v;
>>>>>>>>> +
>>>>>>>>> +    switch (val) {
>>>>>>>>> +    case MEM_ONLINE:
>>>>>>>>> +        crash_hotplug_handler(KEXEC_CRASH_HP_ADD_MEMORY, -1U);
>>>>>>>> We don't differentiate the memory add/remove, cpu add, except of cpu
>>>>>>>> remove. Means the hp_action only differentiate cpu remove from the other
>>>>>>>> action. Maybe only making two types?
>>>>>>>>
>>>>>>>> #define KEXEC_CRASH_HP_REMOVE_CPU   0
>>>>>>>> #define KEXEC_CRASH_HP_UPDATE_OTHER      1
>>>>>>>>
>>>>>>> Sourabh Jain's work with PPC uses REMOVE_CPU, REMOVE_MEMORY, and
>>>>>>> ADD_MEMORY.
>>>>>>> Do you still want to consolidate these?
>>>>>> On PowerPC different actions are needed for CPU add and memory add/remove.
>>>>>> For CPU add case only FDT is updated whereas for the memory hotplug we will
>>>>>> be
>>>>>> updating FDT and elfcorehdr.
>>>>> I don't understand. For elfcorehdr updating, we only need regenerate it.
>>>>> Do you update them different for memory add/remove?
>>>> We have different actions for cpu remove, CPU add and memory add/remove
>>>> case.
>>>>
>>>> CPU remove: no action
>>>> CPU add: update flattened device tree (FDT)
>>>> memory add/remove: update FDT and regenerate/update elfcorehdr
>>>>
>>>> Since memory add/remove action is same we can have common hp_action for
>>>> them.
>>> For memory hot add/remove, we need rengereate elfcorehdr, and add the
>>> new elfcorehdr into fdt. Except of this, FDT need to know the hp_action
>>> and the hot added/removed memory region, namely the start and end, e.g
>>> [start, end]?
>>>
>>> I checked arm64 kexec code, seems we only need to know if mem hotplug
>>> event happened, then regenerate elfcorehdr and embed the new elfcorehdr
>>> into fdt. Then we don't know pass the [start, end] info into the
>>> handler. Please tell if ppc is different or I missed anything.
>>
>> Yes we don't need start and end info as such but we expect arch
>> handler to have info about which hotplug action is performed.
>> It is just that I don't see an significant advantage of consolidation of
>> CPU ADD, memory ADD and Memory REMOVE in one hp_action as
>> KEXEC_CRASH_HP_UPDATE_OTHER.
> 
> I see. I don't oppose all those passed info, just worried the
> unnecessary info passed down to the handler.
> 
>>
>>> If I am right, I would like the handler interface as Boris has made
>>> in his draft patch.
>>>
>>> void __weak arch_crash_handle_hotplug_event(struct kimage *image, unsigned int hp_action,
>>>                                              unsigned int cpu)
>>>
>>> static void handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
>> The above template works fine for PowerPC as long we have four different
>> hp_action
>> to indicate CPU add/remove and memory add/remove.
> 
> Cool. Then all things are clear. We can pass the needed hp_action and
> cpu number only.
> 
> Hi Eric,
> 
> The consensus is reached, please proceed when it's convenient.
> 
Excellent! I will post v8 soon!
Thanks!
eric

