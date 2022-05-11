Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C5252288D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 02:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239831AbiEKAkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 20:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237827AbiEKAkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 20:40:05 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298891339D7;
        Tue, 10 May 2022 17:40:03 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24AKa6oI024483;
        Wed, 11 May 2022 00:39:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=C0yWt55fZHZ4AXQM/Paz4YVRhXOV1nyt83/95U1XhK8=;
 b=gVa2I2IHowiTjAdrCIpzjHfwyV/KJ2L/V10EJu7iZq04qr+XD7JGzaQ4zO6FR11GKzSq
 QGko2e1ENoYxxCobAAaZYiJmOxkjaQiX1pTg6ynWJfbNFqID0JD/+dnEJY3Vlpvdiksn
 XwyP3rS0OHkBhHZfEoBK3w91j1x0ue6UWQJijEP+NZu1MIimbaVLZM1Q7UWw4+4Xo/N5
 ZMUENJzuLI3FDPbvMJfLWn9wsAOLLa0nrxFjQYbgFCorFuirWEOyYr6uiQ9rC/R7ZhtM
 DL9j8Wn5Ozu50VHznB8DcmAxPFa+vRGQAeuLrxqYbQTZ4LwhbG4/yl2o+xkjwwytat98 oA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwfj2gber-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 00:39:46 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24B0ZOZq024391;
        Wed, 11 May 2022 00:39:45 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fwf72ymnb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 00:39:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OMIIOxgxCAlDL3V3giVs3XOAzzsQ6XRr/rxfsUewySvTYiAKGmvhwRtgMq+GtVdAs0Dvkp2K39vxbM7Og7F96au2jf9xkZAR+4GVO5h8cvYaXXn0fstJn1sjgagL75XIjss0rSw8Lftv55mW78di+hZWJxKA+jCTBgjGgqxZTlGy7NLb11xXyjwnCyVPWFnDlBx/A7DCYw/YU9fPhPEIhOMpOkpooyXcDxPJb49+wvcvvZnn0Q93iiKpi3/uqTDMgMPwpBMDttMW/UVZPLyp6lSEWb7sqyzDQHCfDXmGWuEurspix18dRrSMrKzBFF0v6TsrBiVpR+NZ/Ab8NscWVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C0yWt55fZHZ4AXQM/Paz4YVRhXOV1nyt83/95U1XhK8=;
 b=cvx2e2dsFWo+Uvry9neT96V9lg5uuTphLuAt6Gdteh/fI/LNor1zzChxtwF+XJTRmha2QN3PnFWNx4sdOK8QTgWxgNyy/dNPSEi/x7YyVfM82NFBkQmqUNky9PxzV1Bx/WVQ6s1owt8KI6MsodoULe0WWSnxJQgrFgxqmQ7AL6fe1p8OrMLHq2lk3KBiO1r2vSeEuTPQhHc+6Gv53uo+tIby01P0+G7A68amqilbzZKhnaIf5Gz95lRhj8OMqzf0N2vBvXl+xjW+hY8MWOf6kNJd6nTCjdBRsFlZhgU9IdVLkgXVCNkJrFxNwl9qFFRwqehRshntu6LfP353fogy+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C0yWt55fZHZ4AXQM/Paz4YVRhXOV1nyt83/95U1XhK8=;
 b=Fld8GjwGkqXF5YVTB00VtMzirMz6QOX8h4OXobInbMdCAUW6LJr0JI6faGnY4Nw7fKriUyczJFk1T3G2YdZnVKXFDRbYSwlBvc7UrATqJVehc9QvdScaxDmPrjMXF/S0yj5JaFs4GhYYojpw3VcsBNX/ZaWTy4gmBY2ri4Ipcwo=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MWHPR10MB1872.namprd10.prod.outlook.com (2603:10b6:300:10b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Wed, 11 May
 2022 00:39:43 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::9d76:7926:9b76:f461]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::9d76:7926:9b76:f461%9]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 00:39:43 +0000
Message-ID: <9d64809f-db8c-0a3e-1ae9-d4a8ab79041e@oracle.com>
Date:   Tue, 10 May 2022 17:39:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v10 4/4] mm: hugetlb_vmemmap: add hugetlb_optimize_vmemmap
 sysctl
Content-Language: en-US
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Muchun Song <songmuchun@bytedance.com>, corbet@lwn.net,
        akpm@linux-foundation.org, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com, osalvador@suse.de,
        david@redhat.com, masahiroy@kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com, smuchun@gmail.com
References: <20220509062703.64249-1-songmuchun@bytedance.com>
 <20220509062703.64249-5-songmuchun@bytedance.com>
 <970166e0-f70e-dd2a-c764-af23a8425f87@oracle.com>
In-Reply-To: <970166e0-f70e-dd2a-c764-af23a8425f87@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0048.namprd03.prod.outlook.com
 (2603:10b6:303:8e::23) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77cf0bb4-c4c8-4384-5a60-08da32e6bd65
X-MS-TrafficTypeDiagnostic: MWHPR10MB1872:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB18720B2AC8FDE1EB14EF4C43E2C89@MWHPR10MB1872.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AESCIQl6wJ2yJXbTI2h8aFkw6JJBt5k+tf2AewUidrtje8uL3GHybUuWOdg7WS2MAqseNMmGa7qQiW7uXpKUNEQte4tMz7VMtMVQ4pfZTBadI8AAexPmSLYUiB1I3E3z+arxDQQGl/Nh8qWJ5VfNX6y73nAr2pTeE8SnjiDQBrz+BniosRQs4fD4XtfC+IH/LB5N6nuxa7UCY8CUdt9xFX2d3eZ4tEfMhsqlNIzOUf0ymiqpGKwehhgk1z/vr9lMRlK9KJ6oXMx6Y6s7rYan8/b0RPMkXs0nyt8ueiHKPeITRqWBjEpqnJA1s9TqNazQ8E66e+NyF2f5v8V64tJDEIGvzbMQ4ApaM6VpdHTIiHfXmbaX7tyFGQxn+a36M9CcjpQkrX7/tFHO+r8jGSQXH+hwXIyGFCkOJHLOhFmSlYaZ20/gCMEQHPYnlr2AajVPMnkkW8LbYOx1ZgteIu6iJ4Q6SmkktIkHmTC2EDh/oWHcgtYPQcIIVtVl6ThvtS6EMEegJSSYeaIMlT1WaC7QHf59L1Ee95WyYlsOC/VTsdOlg2zJubpQhRklkIYpbsRjc5jhJKEFGKduLB23YNqvN0EGh0wqAqYLiLf3FgKQ0tKuriRlgHUCfnaHm9AIeIefjKgkSSxHDFnIKyADv98Uezqth3FvnCB1z59jRhBu2tEZZ9D+omdSCfYwJpOkkNTilML0m9IhiIaTcsYgl228sxx3pUDz1umK+KtBp9MVyu1X1NEKljm3wik3a/yVstxrOTUWnzTnNlDLzZuay+sPlg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(7416002)(5660300002)(508600001)(38350700002)(8936002)(38100700002)(316002)(66556008)(66476007)(186003)(31686004)(36756003)(66946007)(2616005)(31696002)(6512007)(26005)(4326008)(8676002)(86362001)(2906002)(83380400001)(6486002)(6506007)(44832011)(52116002)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zjd4R2UxYldiZnBzaUdWWmJvV1E1VGFobU9rS0ptWktpbHV4RFRJazVaR1hY?=
 =?utf-8?B?azNvcFh4YVl5bmtEMGVPVFpSWG1oM2MvRnZFeXVGNnRGOUt5cFVPSWl1Wmky?=
 =?utf-8?B?eWU5a1cvdW1BYmE2VmVHNUxWeUNRWHkyNXVYZEthblFwakxNYnVlZlgrcy9V?=
 =?utf-8?B?dGVuOW1ySWVEc3lIWGFqTEFLUlVZcGJ6N2RRWmhtZTlOd2xTM2V0bEFKTVpu?=
 =?utf-8?B?S2FucmE5ZTRPcjZ5em43MXNITitubThQa2R2ejg3cnpIUXNoT2Y0QTdqK1hs?=
 =?utf-8?B?RGpQMTl4TmFITVd4WmxzUi9qWXlZQ0VRc2Q4dUxNUmVSN0ZvZSt0cUJ4MFEr?=
 =?utf-8?B?WmI5Wk5hVVJsVk5jNDFLMjVyY0dlbGdLT0tUL05EQjM2amd3a1RiYTh0UUEx?=
 =?utf-8?B?STUyTVc3UVdSaG82ckNibnRNcXdrbXorMzRPalQrc245K0tUWHlaVkFCTEM3?=
 =?utf-8?B?NmRLbVVlSVVDYmNieXkwTW1zRlh3N2NtWVJacGNZVG1oeURleDczcG9EV2hm?=
 =?utf-8?B?akNUZUhQd1V6aTRPeCtUNml6YlhQaUYzV051eCtJUWMySVZxaEVKQ1M3OG4w?=
 =?utf-8?B?dFZqQTlSQ3ZabmVyeEVyd0xnbnFycDJsNVJQVzVvN3JST1FIa3FUNkM0K0Fi?=
 =?utf-8?B?TzlheFFFZW1obkpWMTgwMHd3d1piNnB2Nm1MYmExVExzVlJaTWg5YzhscjdF?=
 =?utf-8?B?dkRxUFMxdWNsdGVVSGZHNXVWZndrM3AyOWpOb2J5ZUMrVHNuY2ZXelRhWmMw?=
 =?utf-8?B?RmxMR2F1QnhMeEdyVnh0UlFwTGJQOGJzREtFZ2dXZzNQSnZWQkQ4QWFTWjBr?=
 =?utf-8?B?N0EyRXByb01ZSTZ6VWltSXB3T2xxV3BOeFhxZjZXeG81ZzVucks3MnpqRVpw?=
 =?utf-8?B?MHRkUjFjVE1zM0NEVFJ5QXYzV3dWcjE2N0FYMUJ6YkxyaG44UWMraThKTkt0?=
 =?utf-8?B?ZjhtdUlNOFVCazdJcFV0Q3Jydld1cDlkSmt6NHZBZm5Ubm54RTBEelRHRGwr?=
 =?utf-8?B?dVQySS9jOER5MkE3WTFTMGJOU1EvMFdDbHNQTjFOVDhqcWJwb1ZBOEUxSjQy?=
 =?utf-8?B?MVl0MHJrKzA3a1dKRm81eHJQcm1TbnEwZSs1MW1VT2IzZzNtenV3MVdYdldv?=
 =?utf-8?B?NEVwSXUyTitJYks3OW9oek9iUVVJRmU4dW1yTWRnTGVianJVNUlkNW1XTG5F?=
 =?utf-8?B?a2NrdzUyVUlNRlRuVDFtMzhrSWFIcmVrWFM5eHlHN21BNU9FRXN5YmNYZ1gx?=
 =?utf-8?B?cUJqVmtobXp6MnJsY210Z3prSVBySjArc0xyT2ZVZFdadGo3SkROcTl5WkxQ?=
 =?utf-8?B?czBCdmx3RVVVVFRIUE5aS1kwNkZvdncrNnpGbE5xSUY3aFUvMmoxSGJVQmZQ?=
 =?utf-8?B?Rm1ENlB1aVB6WjUzd1FpdVk3YzE2SDBxSEsvSU5NN0dyRlNVUG8wdVh0V0c2?=
 =?utf-8?B?SG1VRzV0RFl6OVB0enRCWktyTkxBYnJUVnBEc1NWcFRrVFQ0WW1NMjV5NlZC?=
 =?utf-8?B?QUlrQmpQSFZ5c3ZINW5udXgwVWdsaVJOK0JqbW00UUlDeFFTVlBWLzZBR0Nm?=
 =?utf-8?B?VGlCV3JYQTY3K2RrcTFPUVBmRy81ZmVzbDZuZGsrQU1aQTZWTDEzaHdUSDRn?=
 =?utf-8?B?OVhrWHFWRFYvbUhMT3JvRGtnS0x3bERwNWl1MGhIWU9yb0p4WWlBSmN5Y3JW?=
 =?utf-8?B?V0pyamxnZjdkMWJCdGxmRktBcWhmNkxTMk1IZkVqRStOcjZ6ZkRnb01xMzlh?=
 =?utf-8?B?b0ZZbzkwUUZEZm5iK0FpOTJIUGt2TTZjM29GUkRJV0kxMWt2ZngyV2VqR3Yx?=
 =?utf-8?B?SjdnWVNGSExTLzRFSnFwbDQ0Sit1NktBczBEbll3RUJKb0pzdmJ4Y0pkQnAr?=
 =?utf-8?B?L0ZFSy9CWWREWUxwa3lEVjAvVk5wN2tDMk8zVDBMUkRXR0xPYVdoU2l4LzFX?=
 =?utf-8?B?RXpWcUQrSTJsQS9sc3VkTlNvQU9iSVFOMUVNaWVtYzZyZTAwakkrVnBmMnJU?=
 =?utf-8?B?N3VBYWJrMlJSWnZaanZVUUVyU2FyNFFTREVLN0Q0VDlrY1pOMkpTMm1mdjBV?=
 =?utf-8?B?dytvT2hvUDR4NzkwRFdGWENYL3AvdDhMRUQ3OS96VVZSR25ocnV4Y2pKZHlU?=
 =?utf-8?B?dlVTbDZJSC9lM0FYbk1aVDUzS1pVT09yemxhREtySTZsRTU1K2tmcnVOdFNU?=
 =?utf-8?B?TjJSSXdCdHFVQmluakRaeC94ZkZucUgvTmdzc0lWOGorWUZQSHI3bjlNcFpo?=
 =?utf-8?B?V1hoSlRUbnFMd3VyakM0TStubkNxSXkrS1dGeU45SitGS2tSaTk2dERwR21N?=
 =?utf-8?B?VTZVbW5ET2dHd2ZGbXRJNTArWDNldVlWd2dSUE1zd3VORElSczgrTnZrbloz?=
 =?utf-8?Q?JKrxyTx8iXJgfX9g=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77cf0bb4-c4c8-4384-5a60-08da32e6bd65
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 00:39:42.9624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GubFXcN4Oiluwpd3DgncR4LQD5OL68IwQnRjznMg58Lwll0XQb/I2CTTM9ZXdiEj5GUtcJPt9PBQuREHFf7HDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1872
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-10_07:2022-05-09,2022-05-10 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=856
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205110000
X-Proofpoint-ORIG-GUID: M2BZ_9kCC44_yXE7FXcoS2kbv6p9LzEX
X-Proofpoint-GUID: M2BZ_9kCC44_yXE7FXcoS2kbv6p9LzEX
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/22 14:30, Mike Kravetz wrote:
> On 5/8/22 23:27, Muchun Song wrote:
>> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
>> index 029fb7e26504..917112661b5c 100644
>> --- a/include/linux/memory_hotplug.h
>> +++ b/include/linux/memory_hotplug.h
>> @@ -351,4 +351,13 @@ void arch_remove_linear_mapping(u64 start, u64 size);
>>  extern bool mhp_supports_memmap_on_memory(unsigned long size);
>>  #endif /* CONFIG_MEMORY_HOTPLUG */
>>  
>> +#ifdef CONFIG_MHP_MEMMAP_ON_MEMORY
>> +bool mhp_memmap_on_memory(void);
>> +#else
>> +static inline bool mhp_memmap_on_memory(void)
>> +{
>> +	return false;
>> +}
>> +#endif
>> +
>>  #endif /* __LINUX_MEMORY_HOTPLUG_H */
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index 8605d7eb7f5c..86158eb9da70 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -1617,6 +1617,9 @@ static DECLARE_WORK(free_hpage_work, free_hpage_workfn);
>>  
>>  static inline void flush_free_hpage_work(struct hstate *h)
>>  {
>> +	if (!hugetlb_optimize_vmemmap_enabled())
>> +		return;
>> +
> 
> Hi Muchun,
> 
> In v9 I was suggesting that we may be able to eliminate the static_branch_inc/dec from the vmemmap free/alloc paths.  With this patch
> I believe hugetlb_optimize_vmemmap_enabled() is really checking
> 'has hugetlb vmemmap optimization been enabled' OR 'are there still vmemmap
> optimized hugetlb pages in the system'.  That may be confusing.
> 

Sorry, I forgot about the use of hugetlb_optimize_vmemmap_enabled in
page_fixed_fake_head.  We need to know if there are any vmemmap optimized
hugetlb pages in the system in this performance sensitive path.  So,
static_branch_inc/dec is indeed a good idea.

Please disregard my attempt below at removing static_branch_inc/dec.

I still find the name hugetlb_optimize_vmemmap_enabled a bit confusing as
it tests two conditions (enabled and pages in use).

You have already 'open coded' just the check for enabled in the routine
hugetlb_vmemmap_free with:

	READ_ONCE(vmemmap_optimize_mode) == VMEMMAP_OPTIMIZE_OFF

How about having hugetlb_optimize_vmemmap_enabled() just check
vmemmap_optimize_mode in a manner like above?  Then rename
hugetlb_optimize_vmemmap_enabled to something like:
hugetlb_optimized_vmemmap_possible().  Sorry, I can think if a great name.
-- 
Mike Kravetz
