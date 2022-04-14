Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F58B501C19
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 21:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345807AbiDNToI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 15:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345800AbiDNToF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 15:44:05 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03833B9198
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 12:41:39 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23EJ5dOj028053;
        Thu, 14 Apr 2022 19:41:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=VZ7LZHQVWemv8eiH1Acho0FJgl+SlIln/N3cQxx2/SA=;
 b=aP2CzTsnhoHhbH+gUPnh7NPGd55S/EqYKWcH00zOuOxRrrD6+suntUFfvYK5DHuggZRx
 qiW1wWHIGSUxaUbwkNXB2it3d8S032onDxHtKHadSZWSenDeAVwZKVNMYPiLKIA//kIB
 jwEd5BzDTDtDRV3SG5hpWiuAaYO9nQrsqTvPHhcD4nxf745604xkMhhq3bK532W2Johd
 INnvZTIfrEANDhEt8wtXFW8DDzB//n528hY0lJrnHld4Z26XBuvHX1iHXgG4H4aW8MRi
 6ouBO+BNjoooXbj6GU7wB21DkGRH8kzbExhGwWNdN1qi3AoTn/1cuNN6WDZva6v1U9t1 Ww== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb21a5afd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 19:41:25 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23EJaN9K027116;
        Thu, 14 Apr 2022 19:41:24 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fcg9m334p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 19:41:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZFyrePzDUlR6mbP0BdeN1XHCD5cqALVCVVoNjgvaP+NvntMPljwf+Zb3/8a8oyjU+JlFQy90GPYAwK5w2SCz0WO4KP0RORwAdH9aPtvyqkVQqcXTdTobSoW7J3gWq3n9tz+CsBDPi85f6+FJSSUAJt7wpR8heLEcTRiGBE8JPEG4I2/j4jOwSfuZ3hY6iP3NWDVlR8hVIqOjxMXhvHKqPdw4PWE2QidSd5dIv/RRnaK49504bVBMEyVCQ5Kf0/n/jmlOTum+MQqQj5Kd7vBDUy4m0p3MNMvPj4Pi5FJhzFfjZTtu/B2q/YphD8KhtHY3F6ZF1b3r0wZrA3H5CPzmaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VZ7LZHQVWemv8eiH1Acho0FJgl+SlIln/N3cQxx2/SA=;
 b=W7pDDDmSD9wn794B7xd3MNjZgEflJMAFuDfLQHIgpUT95fm1Lz43q6zLV48KVYadbVN9mfpFdti0E5UuUDuP72BsDH6P8Mxrk+ie+qKj9mi/f09t/mcT7Rhe6K0cBX0mSGYnCLKCbaEDXFE8DcXJ5i50okswrMAN1fPyo6Tc6GBotq/5G24jttokmNd+14NJX1Qky1YubVEmvbzYqeK8Q6oS9HmcIQt7ME0qyQ7w52GkAPrajrqcOasTgct6G7RGgihLY1NOzTfwfrY7r6dNQPCzTG3joL630e+vNgoRhhLNzE3EohSyxwaS69U0xGPMpDfUc9zGsPTuAavI88jcTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VZ7LZHQVWemv8eiH1Acho0FJgl+SlIln/N3cQxx2/SA=;
 b=FCzVAPuQaKMedbezCAb3WXJ3UqX9EdG2NDeg2vYvWXT9UG75Wx+pBfPVRR/1MMWw05h6CgCnyh59vRf/wTpoRn2mQJE/NqDATVrA5j91fdmlGVv59hbaNE/gHKbRvprr6bCwxFVu5QVBAOv1G4ylLWYYWK2GBYXam9ZLrFZshqk=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CY4PR10MB1429.namprd10.prod.outlook.com (2603:10b6:903:28::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Thu, 14 Apr
 2022 19:41:22 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::b1bb:21c2:580e:922c]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::b1bb:21c2:580e:922c%4]) with mapi id 15.20.5144.030; Thu, 14 Apr 2022
 19:41:22 +0000
Message-ID: <e713ea07-0e9e-9033-347e-cbf6429cfef5@oracle.com>
Date:   Thu, 14 Apr 2022 12:41:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v8 2/3] mm/hwpoison: put page in already hwpoisoned case
 with MF_COUNT_INCREASED
Content-Language: en-US
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
References: <20220408135323.1559401-1-naoya.horiguchi@linux.dev>
 <20220408135323.1559401-3-naoya.horiguchi@linux.dev>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <20220408135323.1559401-3-naoya.horiguchi@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0245.namprd03.prod.outlook.com
 (2603:10b6:303:b4::10) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: beed69a4-d679-4f85-956c-08da1e4ec13f
X-MS-TrafficTypeDiagnostic: CY4PR10MB1429:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB14295C2A41E9B43CC2F7DAF2E2EF9@CY4PR10MB1429.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KEEO4WbLoqedCYMzWOGfKwG1CUj1TNw6cVWGBxL+evU6dvw7DMPYf/lmvqz0eZocQuye6LIRX19Jb/ro9MPE4SkGClEX6M/Eb0rINxLCx7PRyHn1s4SFSZxd/4setO2YfgNYCqDmwwZMHPrBYq/Q4zP9OXlkwR56OaGFaPP8CIY6igTAG6UiTt1Q1j+DgSSEPKTsfUz4BP+67TL1E8vUb3MOaXmNqbIPOSs3DgoencuZHNkp47c8QTT5g+tL2hkhn2vCJ+sls83MStumvUrjjYJD1WEOh8Gyf/4Oe3a3EsmW1G5cjpb40vkRIFwkxFZhZHH3R5K/59glPQGz+xcjXxT3xkxQj2azu+yTJl61gkEhPq4U/uSuwMx/WuPwFTcQnwVqVVg+abEOv81MroDwehsIetRhe7Al6lSWkBh3jPr5+2MQgYZVkCoKD7TToyeYksY3yhicq6GFJcBZtccMSUy7BD1SfDIt7P+tkelAnajU+SsfcbQEgKhVz8iHonlF5htpAxjFHdCwNXkaXCXZ7oyIBTuDQnu8PfOmts7EdjX32/q56/EcMgLXiIh5WQ/b6NBQ/aBQg6E9mKzwZ2sxqIr/Y5q94QWSqs2GnHf1LiOTI7djXfYVKR2R0YO9NPebxsWKlg6BentAnDbsXV7k8TrCjKIZ6wuEi3Blbq7OGQRW4U+fm0oeBXNCtR8BeBlY/hTtdgDpeh4qL/lbGyyxq4oOJSZc0YTcIdBFm+cnlyUzUD7O4yq9/AWI4gjY//OX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(2906002)(36756003)(186003)(26005)(316002)(31686004)(6512007)(54906003)(83380400001)(66476007)(53546011)(52116002)(38100700002)(6506007)(38350700002)(8676002)(4326008)(66556008)(66946007)(44832011)(508600001)(6486002)(8936002)(86362001)(2616005)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGtOU01naHJ6VVVQbDEvTFFlU1hlNml6YUhUNDFUNG00Y1liQUd4ajdkSFZ4?=
 =?utf-8?B?ZkNHZ0E3dFRBWEw0T1pTNnVsMjRrZHlZWWp0cGg5b05QRWx1N05hQ0tabkU5?=
 =?utf-8?B?bWlBTmlhaXQ2Ti9McThMNVVtaGNWMUR3RHBPOHdCZjEvQkVKSFJoaHlRcDda?=
 =?utf-8?B?NGFUZmtRWjJBaEFkRVluZ0syS3F2Zk1XNFJqUG1JMk5SS0Z4RjBseXBZekw2?=
 =?utf-8?B?N050SzVZWGtFZEkzUmhFN3BBVmpEcWtUSEJhb3lTbnV6Q2drN1ZCanpJTjJV?=
 =?utf-8?B?VkJKZlJlVzA3UXM3R0dIL0lOdnFhY3JkMzR3MFFDVFdSQzFHdGV3bUpKNUFD?=
 =?utf-8?B?RlFyY2g4cDRaUTlnejAxS3BxQUNGWS90UXloQlFTTmNTcGhpcEVEdTdJMkZn?=
 =?utf-8?B?aEFkVStCKytSTDdmMzdCdTdVRUI4OXUyUU11RlBLTW56dTZlc1BkMlB6OW5N?=
 =?utf-8?B?WUpzWDJxdGxKejhmVCs5UEdQRWRjNHkvVllabFk5MXk2YUhQcVpUenY1cUlZ?=
 =?utf-8?B?T1gzOUFDWDNTQ2dSV2FteHFLelIvak9VV2hOTllYYVRCTGgzNW5tZ1haNHZF?=
 =?utf-8?B?UzF5S2gzMW9IWjRWYVZwaDlQV1hWOTBXNjB5RExaUXVNdWx4Tk9rV2daWXM1?=
 =?utf-8?B?M0lnMjhFeU9NQm1uS2RGaUpGTGVGQmRKeE9ydU9uUkg3MDhKVUVhTGcrWTNE?=
 =?utf-8?B?RUxGa0thanltbDh2RGdJRnEzRngvdlRaeGxXYTVUMTJnRkRjU0tIQlpaQXR3?=
 =?utf-8?B?L3E2MjA3dk9hTjNZcWtMSlBud1dYeTc3YTJMdWZQTEVia3g0bWxlVjBTS0ZZ?=
 =?utf-8?B?Q09OcXFvUS9ZMFp6OWdGL3A5NFFKRS8wcXkzVzJ1TFBHSGVlendiN21LbHp1?=
 =?utf-8?B?WWlJbTVZdGo1UUt4MzM5aVVjTEFiVVoveXBTU2pPNVJmYU5ERWF0UWZ5OC93?=
 =?utf-8?B?V3lRNFk5MjlEakFtWE5LUFQrbC94K3RQTlJqbkxwK2NnSFVkZWJ2UWRlRUxS?=
 =?utf-8?B?Ulh1K3BSenNCaFhyZzVNM1Y2Y1Jqa3JUSXBRak5JVGxGTU5PL244TWZ0Ly9R?=
 =?utf-8?B?Wi9wQWxVSytFMTdUMGxPemxyT0gyY2ZSZ3J4ZW9XKzQyUGpKMmpEL3BkZ21w?=
 =?utf-8?B?Z1dkc01VaUE5MXdndktqNWdGMU1jS2k1NHB1aXpnbHJNbWlNbE5lTVJvOTVJ?=
 =?utf-8?B?RzZhY25Dc1o5dEJLWTRoNWVsUVBIWitLMWhZUEVhTEI4dTRDSXdvZjY2cHdr?=
 =?utf-8?B?Y1FjYUxBMUJGeDh3NWo0MmowSVVhV3JRUmZHVFp6M21WL1lvWUhVT1lzdHlo?=
 =?utf-8?B?QVhDZGk2bmZqYjQxWU9OZFI1bjJlUUhUYmVXandmbmtucmlnZ205VDFiL3l5?=
 =?utf-8?B?YzY2bi90SEU0bVZVd01kbFlIc2tvUlRCY1RZc3dFRW1HMml4QzJGYUNYOCtx?=
 =?utf-8?B?ZWFBcjlJRTlEMHA1MXFqamh6dVNlbUJDdjdmbjVxUU5ZMW5QdnZxSGdsd1hq?=
 =?utf-8?B?ZS9WZWU0YTRjUkpwU0lhaDV1bVQzL3VKbEVPM2FOS2t1QVhBYnpRWFFsVFow?=
 =?utf-8?B?MEp6bGxqdWp5bFRvelZqWHdrNmNWN3dNcjllZXNxeDRnTXg4RStqQTJQZ3Ni?=
 =?utf-8?B?czYxRFVyRjl1aHZjYjZZbDVyM1FOakl2L0p0bjJ0T085d1QxVlZrSWxqOVpJ?=
 =?utf-8?B?S1VsdGJ4bEpjSzQyS0VEVXYwRmI2elMydzY1V2RjV2VXU21ZVkdBZTVsQzFU?=
 =?utf-8?B?TXEyZmFDbHZJeGkwTUdyZzN3YU9HbE9LRFVLWGNHa09aTkRqSGF0eWN4UXZE?=
 =?utf-8?B?ZStzc0RCSmRqRlNVNERQZjRubmRmZUpuZVI4U2l2WGJEWGpjMk1JUC9zNjJR?=
 =?utf-8?B?aXBERkxMdjVqSHlMWG9jR3ErblZyQVpHdHFwdHFGRTgvK2hjR0poOG5IRk1z?=
 =?utf-8?B?NUw5d3piV2hMRSs0bXM3OWxaRnNUNmROdndRNXF0WTErUGRlTys4WXRWK0l4?=
 =?utf-8?B?ZGQ5SDVOTG15MGdKcFBVSDZUQjBhZmN5T2JRTlhOY1RpWGRBZXU3REFDRlo2?=
 =?utf-8?B?QnpzeXBSOHVZOE9hZ0U0VUN3cDZydCtpemVNa2JqZ0ZsSVI1R2dUTW1nVmM1?=
 =?utf-8?B?Y2NEVzZXTy9UUGNQNWxoeDROWGduN1pXRmtqbUlGUUI0eElKT2plRFhFTDBi?=
 =?utf-8?B?MFBNbTBQZTdJUzZlV3VyRVl6VHBFQTFKcGZqa0lCNnZSSjBGMlJ2RjRtN0JE?=
 =?utf-8?B?bTFuR2FJOEFhMzRXUE9ZRlRiWTFRNVhQQkxSSVhPQndhRExLUUhKQUZpbnZq?=
 =?utf-8?B?endkQWVXWWtkQUlyNVVXQ3lwT3BFbG1uZHlzays2bmdUa0pjdEtialZ2T2lM?=
 =?utf-8?Q?SJSV9lqTOsxIMIZU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beed69a4-d679-4f85-956c-08da1e4ec13f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 19:41:22.6517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IrH98jGbIO/50elw1uOSdiXU3GupXXZQ2TfcSWuQ9CUsJNb9eWTvkLN4F3DPt0bDnGzOAFfkjSvg5HFcUxmICg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1429
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-14_05:2022-04-14,2022-04-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204140102
X-Proofpoint-GUID: zpVOuHq36ntN9ii5Kd0tPCEixXN9fgey
X-Proofpoint-ORIG-GUID: zpVOuHq36ntN9ii5Kd0tPCEixXN9fgey
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/8/22 06:53, Naoya Horiguchi wrote:
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> 
> In already hwpoisoned case, memory_failure() is supposed to return with
> releasing the page refcount taken for error handling. But currently the
> refcount is not released when called with MF_COUNT_INCREASED, which
> makes page refcount inconsistent.  This should be rare and non-critical,
> but it might be inconvenient in testing (unpoison doesn't work).
> 
> Suggested-by: Miaohe Lin <linmiaohe@huawei.com>
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> ---
>  mm/memory-failure.c | 2 ++
>  1 file changed, 2 insertions(+)

Thanks!

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz

> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 2020944398c9..b2e32cdc3823 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1811,6 +1811,8 @@ int memory_failure(unsigned long pfn, int flags)
>  		res = -EHWPOISON;
>  		if (flags & MF_ACTION_REQUIRED)
>  			res = kill_accessing_process(current, pfn, flags);
> +		if (flags & MF_COUNT_INCREASED)
> +			put_page(p);
>  		goto unlock_mutex;
>  	}
>  


