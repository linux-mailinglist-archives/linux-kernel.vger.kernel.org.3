Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0907351CE80
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 04:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387533AbiEFAjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 20:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238580AbiEFAjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 20:39:35 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A5B220ED
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 17:35:53 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 245Jnu6d019152;
        Fri, 6 May 2022 00:35:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=YReq+tqNWt5ANmqnYcunl0IRaKTV/fL01HmO4MB5M4M=;
 b=Dje7VRErxRSrhXbUg0ro+dPTxXQQvIV9vkf16iQ3oqFGIq7KQsas031YSnVqtgO+OJ4K
 4RTVUfCbN2HmLtPHuBH5cgr45PZv8104flJqxADIpSkyyT67x+IGozrpJ6G3URIzbFOn
 lp8jFGOcB65pq+7enD1JS4Xe4l6JEnD+UbpeLN6FbXvSHNOEZ0Qsdknmj+Y1dGyTdnYo
 WrREAdMmMj6g8ma0h/3Hy6OBsY472sxCERpIFQRPnFv+yRQcFUDDNn6hw0WjfTwiHsDZ
 GYjmFDZgm/+Q3ppBHB86DbowqTODII8N/y1WZlDLZ206bgow1+PmZ7kLalpuLJo/wIsL vw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frw0avfpr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 May 2022 00:35:48 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2460UtvD030672;
        Fri, 6 May 2022 00:35:47 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2043.outbound.protection.outlook.com [104.47.74.43])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fruj5aum7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 May 2022 00:35:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E/+qcfZhFp9A1aRJgS6K1IwO56Dbx+9rrHas0SEgI3oRUpn1Dqm4x6hZRIz6uNfj5aFXKrkKRqOQxcjsmiqmMOrmF82EYe8gqW52bdrLZkkOHW8VRUCpVL9sZXUEluwFjhN3yYnxNpKT75m7x88Cn8ftrR3FkvyX8hhCITDBtmAtLaNs096LW0qQQkY/brRL6w5RgyQv2i7X19mGxG//Czr8xz868InYvrzycj1n3mkkzutdgiz30/hun6cguntpteuk0e8egnTRSE3IPicRQ7ciLEeqaCTZVAGIiXeAAlfqS6XwVo2Yhv+q62j5lBKdE1wT9jnythAbknnJZ8Pmbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YReq+tqNWt5ANmqnYcunl0IRaKTV/fL01HmO4MB5M4M=;
 b=mQI9J1N3cOL2WHOBJ5ALqmhkz5tWT8l+phW+37cEy/mgl2MWkBydSegsrpYlpVHPSkZ+MvV3qEtMUmnpwH3HKW6GuLZtCoG3QLaT2fKdSU9l/4JgAbWpJoEIz/gg6vXlgxOP1SA67AdItvgEujStYHo1cOaltcl66dOfCDSQ2oD0wbMA7WC+EeGV9gi5Srcp8NQWEHb5SIFKaWWxpJB0IvZoMZL4+6EqAKnQSpZH/gt28oTwKSb4kfBMFhmmECpFZzTa532RKsMCmtHaGd7MSfqYU1OKEehR36vP333K2ghaJyo5yjyYYcfHUmJIdM7SC9fWl7LXHLTSHgr3MTl20Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YReq+tqNWt5ANmqnYcunl0IRaKTV/fL01HmO4MB5M4M=;
 b=oQdFKUVv/KQg/zrxLYdBUxgTi+d0M24Ix0Fq5aXWv91GdQqwW74uVH+VyKamUPXSxyo0SfBycJm69WzzKjMFzu9KEcLIn0FJqjde8omSYpPj41HbiRTL5NQlixH1iSY30EnwSFvjL57C5SUph3hvxepyrENda+qh5wiOFYySCQA=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by MN2PR10MB3168.namprd10.prod.outlook.com (2603:10b6:208:129::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.25; Fri, 6 May
 2022 00:35:44 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::c89:e3f5:ea4a:8d30]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::c89:e3f5:ea4a:8d30%2]) with mapi id 15.20.5206.027; Fri, 6 May 2022
 00:35:43 +0000
Message-ID: <47ce55ff-2c99-7832-06a3-246cca530827@oracle.com>
Date:   Thu, 5 May 2022 17:35:39 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 1/2] vdpa: Add support for querying vendor statistics
Content-Language: en-US
To:     Eli Cohen <elic@nvidia.com>, "mst@redhat.com" <mst@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>
Cc:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220502102201.190357-1-elic@nvidia.com>
 <20220502102201.190357-2-elic@nvidia.com>
 <f279bbbb-6af2-95f4-08c3-97ba72deb6cb@oracle.com>
 <DM8PR12MB5400350099D5A2C932C32B07ABC09@DM8PR12MB5400.namprd12.prod.outlook.com>
 <f54e1450-bdd0-860c-5962-90f312234134@oracle.com>
 <DM8PR12MB5400F57667C36D579F2EF95CABC39@DM8PR12MB5400.namprd12.prod.outlook.com>
From:   Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <DM8PR12MB5400F57667C36D579F2EF95CABC39@DM8PR12MB5400.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0140.namprd11.prod.outlook.com
 (2603:10b6:806:131::25) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bcca2e27-c4cc-4126-b584-08da2ef85acc
X-MS-TrafficTypeDiagnostic: MN2PR10MB3168:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB3168E0DCC2CE99DA59A57A20B1C59@MN2PR10MB3168.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +TcFsygSNCHArj8WX9lc4KdOECDtzm65S10dgsIu988E+IqhA9yzmTs+rYzplVIKTFPXbzdev7SzEK15M07cF2Ev8MdQjyv1SfRTVaff60n99PC9TCzMKhiteupWL7HZA6+V2GWKzjmU6enacDubRpWyIk8V7tD9MkG+jMZALfJKSX/m1VYIaINbn5sLfaDPXoeQwlnEnj2s06DOfnCmKWduBsBabwBuYnkskT4RPkNvV7xsE0LvplxBqCRFH0aOqA3aClWG2N8cG46H+vP/KKg+XYGbueY1pkgMMCwYaYmRt9nOPqmH5IIHM30eaZ3NVp4NN6xcThNu9JY6GkbNCo9w1Iv5DpIw2ziCg8mET8fAjhL4sQo4mYqNAJwVgLF60t6mH9vXFfls/soi3lg/SfB5HjoYMFYtscGCQfmHe+6kq2l+umjaGAXH2L3qAEs/BGbroSWT6VTGUjD3kg+MKyp/5ebD42eonZF3rw9ZcQT035Y5ggTGM+OsElc6YzkU3DFV8KzvExsMyCY+4rC1cY9Fw38PM1S1qgaPq9psO+wUsJYpAFiPXzvepq4QF/bN8gDSSNXYEYvLIDGlRFlQ+SkqZgznR1j0P5UoJWRQAPZLiBCML23OeN0GWYnyQw4iA5/lT1iJc9JjJdmHFbXE0vkOgoENTlod2ayhhpK8ysDF+NxlCWK6zQr/T8mnBX1wTSd54ModR/x32PYLzJ+raDgrPjszvRMVQuAbbRSuZuc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3287.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(31686004)(508600001)(86362001)(6506007)(2906002)(6512007)(110136005)(316002)(38100700002)(26005)(8676002)(31696002)(54906003)(36756003)(66946007)(30864003)(2616005)(4326008)(83380400001)(5660300002)(6666004)(53546011)(186003)(66476007)(66556008)(36916002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTZrRkZ5cnBqQkROL0t5Q1gwcE52V3lDQllyRTBkZWY4Z0kxTnhpbEYvNHh1?=
 =?utf-8?B?SGl3S3duQ3ZjZ09EeHd2QnBxcjAzVG9aMXhVUEptMEMvQXNucFl2Y0UzUThG?=
 =?utf-8?B?bzhwSE9reWxDN1RmK3RlTm5ObWJBZnZBK05XQmxuWXV4OUNDMlRKNytyWkZD?=
 =?utf-8?B?bzlUblFOVG5lN01rOTY0dzJ0VEFwWCtGRTYrWVdrZ2JDYi9ER0xKUFJrRmVa?=
 =?utf-8?B?bDNyTkhlWXM3SjFiRE50WERuMHZ2ZStWd1JoZDFacTRaYTNnK1RLMU1yYm1Y?=
 =?utf-8?B?WWI4Tkh3V0NvbzV6aHk0QnoyOTJlU2p5VnJpb3Q0dzFNNjVmNlpjcCt3cTMw?=
 =?utf-8?B?b2tjNTVzOU9IdXFDNzJiZHB6Zlk4Z04ybVk3TUJ5cmVUcC9WNE9MZXNyWUpy?=
 =?utf-8?B?WlRYMFJkMjRxVnpva1FaY1laWDFRbzdxMEQ3dCtHRUhqNWFwVG5zKzZiVngx?=
 =?utf-8?B?OWdKWUdLdTFudTlDWWx5SlhKWXJyVHJ4ZUd1Yk1QbHpBbFA4VDg5UEp1aC9h?=
 =?utf-8?B?bSt1b0hjRDJkMUozbUlzTWhzbk41YkxhdGgydDdIa014SmdWZWtjN256RURO?=
 =?utf-8?B?Q1BwQXJDNHByU2NQOGdvUjRqQWFwc3lJUWRFLzBQS09LWUJ6L1JLWkFPbC9D?=
 =?utf-8?B?aU9xaG1ld3phVjkyaEdrQ3lFem1ad3hiYi9JYzJnZDgxbU9ETk1IVFdYN0Zw?=
 =?utf-8?B?KzI1S0Y5Q0JPTVFmZG1HNitPNnc4ampxVWgyQ2d1QUlEUUYzVmRnTWVkemZZ?=
 =?utf-8?B?aXIvNkREOS82TlRSRDVMN01Sd01hVmJFbGM1S1gxaGxlTHhXVVBycDNDNm9Q?=
 =?utf-8?B?N3d6WHFRSThjbW9FRzNNSzlTUCtUekQrZ3NXK3RYVXh4bEZWaTc0eDU5alhK?=
 =?utf-8?B?bkFDektaUXRFekRsV3crWXdBaWgwRld6YUFFKzJqVFB1R1JPOC9MWG1xT0J5?=
 =?utf-8?B?NTMrUlhaTFVPOGhoUWZFcTFaUVJzVVNPeHFaN3pFZ0MrYXNPaXBpYkRnTjNX?=
 =?utf-8?B?bEU3N0ltUCt6djJuNC9acXA5SzNZZk9MRWlzMWVzZW5LM2cwMEc4TWlVNENv?=
 =?utf-8?B?SStISkxXMnI1UzFCMGR0SUhyc1pDUVZqaDhCY1RyQXBWM3dZOGJiRUxxZUJ5?=
 =?utf-8?B?d29uVzNqZUtTSHZLcEt2SmFQWEFQWXBqTHRPcXhWYTdzLzZQYkVxcC9wVWkw?=
 =?utf-8?B?cnJyR0YvVld6dXlaOTFiN2ZtWFZVSVpKUXNiNHg5Wmd3ZTZmTU8rdDM5Z3hE?=
 =?utf-8?B?cG45bFVNQ0RCeTltZUN6VjI1SnVCd0lwMHdPZS9JS21qYjh2a1JiUXRSQ0NU?=
 =?utf-8?B?VHdpUXVFQWg4SFdFdm1xNE05M3VHRCtQN2hGcTVxTm1wVlBVQkpvSDhaYzli?=
 =?utf-8?B?RmgwTDk2OUU1dEhCNWhUdU5obEsrSkJLSmYyZ1R4TERsS0tGREdJNWluTGFm?=
 =?utf-8?B?Q0lZZEFCK1E1dXBndHFqV3NpYWcvTkdtR0g2Y3pONGtEUkdoeU05Zzh5NWJx?=
 =?utf-8?B?OXBjY01OYlpqcU9yWWp5Rk52Y3NpTzNzdnEwQVJpQTFJWlhTWWRtVThhOG12?=
 =?utf-8?B?OWVaTXRnd2NkREY0TmdTNnJuSDdXNzR0WGpDRnZaTUpxaHI0TVJIbVNrdUhS?=
 =?utf-8?B?R0xEOEJPRXhzeFBFZnhpT2NUdXVzdnJlSS81L3FpL1pDQ2xVR2ZYS3JQeXZB?=
 =?utf-8?B?aHBTRUh4TS9RN1AvWnluQ1ROYjZWN05PdndVQm0vZjVUbk0xUnM2bytPN0ZD?=
 =?utf-8?B?UHJEMllCMTVEeGJ1OE9BWUY0ZXJNRTA3T0JnNEhVRUxnZEFlczVuWnV6a3Rh?=
 =?utf-8?B?dFVEb0svUXRMS1RwSFgrd1kxQXhxNms5TGpQYzJ5VmVicXRpdFYwcS9FM1ZK?=
 =?utf-8?B?V1YrQmRpdTNFemJkaml6aFplUDVqdnZOSjBWTEl5dlk3dlc2MXdPQnIyK1U5?=
 =?utf-8?B?TWF6c1lVTEFaVVJkV0tMYU9tVVRpZk9vS3JDSDhBTWg5VGFUc1RMRW5SMkF2?=
 =?utf-8?B?UFdnZ3d2Qm12Qng0NzF0YWI5Smp2Szc5U2FuakNSYW8rVzJxNDQxSXdrKzdI?=
 =?utf-8?B?WUU3RGRsQ2craUN3eXZJa1FKSmFxbFY2TjVoWkZFbCtZUDBuN2xYdzB3NmFp?=
 =?utf-8?B?RVQ1cVh2VWpaTzM2cytLMUQ3bmlRS2dTTWlYc1RaMVd3Vk1GZHVna0REYWdL?=
 =?utf-8?B?dUQzQk1TU3grV2l5dFhIeVJuOTNZZ1MxU3pvNHRQNXFDVzJVMWlqZ2w0eFRh?=
 =?utf-8?B?L3g5TEkvaFlrUUZPQjBJQ213dnU2RXdzZE9QenZYVCthaHpXNUpvYTlqbHdn?=
 =?utf-8?B?T0luNFA5T0kveWJISmo2RHVMeVUwczczQTZPRm52SmxTZlFrbUs1QT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcca2e27-c4cc-4126-b584-08da2ef85acc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2022 00:35:43.8041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lAerVNwQ25biLlwD2FQ1aKFog06liIXLTzNhKAOzXd587Vg9FovB3IOWMbDuAps7Tii/9IHwn97NyNCwdMnVpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3168
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-05_10:2022-05-05,2022-05-05 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205060000
X-Proofpoint-GUID: puBI1_Y5fr_hsgDCZk8UTE9CiZa84Avn
X-Proofpoint-ORIG-GUID: puBI1_Y5fr_hsgDCZk8UTE9CiZa84Avn
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/3/2022 10:44 PM, Eli Cohen wrote:
>
>> -----Original Message-----
>> From: Si-Wei Liu <si-wei.liu@oracle.com>
>> Sent: Wednesday, May 4, 2022 7:44 AM
>> To: Eli Cohen <elic@nvidia.com>; mst@redhat.com; jasowang@redhat.com
>> Cc: virtualization@lists.linux-foundation.org; linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH v3 1/2] vdpa: Add support for querying vendor statistics
>>
>>
>>
>> On 5/2/2022 10:13 PM, Eli Cohen wrote:
>>>> -----Original Message-----
>>>> From: Si-Wei Liu <si-wei.liu@oracle.com>
>>>> Sent: Tuesday, May 3, 2022 2:48 AM
>>>> To: Eli Cohen <elic@nvidia.com>; mst@redhat.com; jasowang@redhat.com
>>>> Cc: virtualization@lists.linux-foundation.org; linux-kernel@vger.kernel.org
>>>> Subject: Re: [PATCH v3 1/2] vdpa: Add support for querying vendor statistics
>>>>
>>>>
>>>>
>>>> On 5/2/2022 3:22 AM, Eli Cohen wrote:
>>>>> Allows to read vendor statistics of a vdpa device. The specific
>>>>> statistics data are received from the upstream driver in the form of an
>>>>> (attribute name, attribute value) pairs.
>>>>>
>>>>> An example of statistics for mlx5_vdpa device are:
>>>>>
>>>>> received_desc - number of descriptors received by the virtqueue
>>>>> completed_desc - number of descriptors completed by the virtqueue
>>>>>
>>>>> A descriptor using indirect buffers is still counted as 1. In addition,
>>>>> N chained descriptors are counted correctly N times as one would expect.
>>>>>
>>>>> A new callback was added to vdpa_config_ops which provides the means for
>>>>> the vdpa driver to return statistics results.
>>>>>
>>>>> The interface allows for reading all the supported virtqueues, including
>>>>> the control virtqueue if it exists.
>>>>>
>>>>> Below are some examples taken from mlx5_vdpa which are introduced in the
>>>>> following patch:
>>>>>
>>>>> 1. Read statistics for the virtqueue at index 1
>>>>>
>>>>> $ vdpa dev vstats show vdpa-a qidx 1
>>>>> vdpa-a:
>>>>> queue_type tx queue_index 1 received_desc 3844836 completed_desc 3844836
>>>>>
>>>>> 2. Read statistics for the virtqueue at index 32
>>>>> $ vdpa dev vstats show vdpa-a qidx 32
>>>>> vdpa-a:
>>>>> queue_type control_vq queue_index 32 received_desc 62 completed_desc 62
>>>>>
>>>>> 3. Read statisitics for the virtqueue at index 0 with json output
>>>>> $ vdpa -j dev vstats show vdpa-a qidx 0
>>>>> {"vstats":{"vdpa-a":{
>>>>> "queue_type":"rx","queue_index":0,"name":"received_desc","value":417776,\
>>>>>     "name":"completed_desc","value":417548}}}
>>>>>
>>>>> 4. Read statistics for the virtqueue at index 0 with preety json output
>>>>> $ vdpa -jp dev vstats show vdpa-a qidx 0
>>>>> {
>>>>>        "vstats": {
>>>>>            "vdpa-a": {
>>>>>
>>>>>                "queue_type": "rx",
>>>>>                "queue_index": 0,
>>>>>                "name": "received_desc",
>>>>>                "value": 417776,
>>>>>                "name": "completed_desc",
>>>>>                "value": 417548
>>>>>            }
>>>>>        }
>>>>> }
>>>>>
>>>>> Signed-off-by: Eli Cohen <elic@nvidia.com>
>>>>> ---
>>>>>     drivers/vdpa/vdpa.c       | 129 ++++++++++++++++++++++++++++++++++++++
>>>>>     include/linux/vdpa.h      |   5 ++
>>>>>     include/uapi/linux/vdpa.h |   6 ++
>>>>>     3 files changed, 140 insertions(+)
>>>>>
>>>>> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
>>>>> index 2b75c00b1005..933466f61ca8 100644
>>>>> --- a/drivers/vdpa/vdpa.c
>>>>> +++ b/drivers/vdpa/vdpa.c
>>>>> @@ -909,6 +909,74 @@ vdpa_dev_config_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid,
>>>>>     	return err;
>>>>>     }
>>>>>
>>>>> +static int vdpa_fill_stats_rec(struct vdpa_device *vdev, struct sk_buff *msg,
>>>>> +			       struct genl_info *info, u32 index)
>>>>> +{
>>>>> +	int err;
>>>>> +
>>>>> +	err = vdev->config->get_vendor_vq_stats(vdev, index, msg, info->extack);
>>>>> +	if (err)
>>>>> +		return err;
>>>>> +
>>>>> +	if (nla_put_u32(msg, VDPA_ATTR_DEV_QUEUE_INDEX, index))
>>>>> +		return -EMSGSIZE;
>>>>> +
>>>>> +	return 0;
>>>>> +}
>>>>> +
>>>>> +static int vendor_stats_fill(struct vdpa_device *vdev, struct sk_buff *msg,
>>>>> +			     struct genl_info *info, u32 index)
>>>>> +{
>>>>> +	int err;
>>>>> +
>>>>> +	if (!vdev->config->get_vendor_vq_stats)
>>>>> +		return -EOPNOTSUPP;
>>>>> +
>>>>> +	err = vdpa_fill_stats_rec(vdev, msg, info, index);
>>>>> +	if (err)
>>>>> +		return err;
>>>>> +
>>>>> +	return 0;
>>>>> +}
>>>>> +
>>>>> +static int vdpa_dev_vendor_stats_fill(struct vdpa_device *vdev,
>>>>> +				      struct sk_buff *msg,
>>>>> +				      struct genl_info *info, u32 index)
>>>>> +{
>>>>> +	u32 device_id;
>>>>> +	void *hdr;
>>>>> +	int err;
>>>>> +	u32 portid = info->snd_portid;
>>>>> +	u32 seq = info->snd_seq;
>>>>> +	u32 flags = 0;
>>>>> +
>>>>> +	hdr = genlmsg_put(msg, portid, seq, &vdpa_nl_family, flags,
>>>>> +			  VDPA_CMD_DEV_VSTATS_GET);
>>>>> +	if (!hdr)
>>>>> +		return -EMSGSIZE;
>>>>> +
>>>>> +	if (nla_put_string(msg, VDPA_ATTR_DEV_NAME, dev_name(&vdev->dev))) {
>>>>> +		err = -EMSGSIZE;
>>>>> +		goto undo_msg;
>>>>> +	}
>>>>> +
>>>>> +	device_id = vdev->config->get_device_id(vdev);
>>>>> +	if (nla_put_u32(msg, VDPA_ATTR_DEV_ID, device_id)) {
>>>>> +		err = -EMSGSIZE;
>>>>> +		goto undo_msg;
>>>>> +	}
>>>>> +
>>>> You seem to miss VDPA_ATTR_DEV_NEGOTIATED_FEATURES from this function,
>>>> otherwise I can't image how you can ensure the atomicity to infer
>>>> queue_type for control vq.
>>>> And should we make sure VIRTIO_CONFIG_S_FEATURES_OK is set before call
>>>> into vendor_stats_fill()?
>>> It is done in the hardware driver. In this case, in mlx5_vdpa.
>> OK... So you think this is not vdpa common code but rather individual
>> vendor driver should deal with? Seems fine at the first glance, but with
>> some thoughts this would complicate userspace code quite a lot to tell
>> apart different cases - say if the VDPA_ATTR_DEV_NEGOTIATED_FEATURES
>> attr is missing it would not be possible to display the queue type. On
>> the other hand, the queue type itself shouldn't be vendor specific thing
>> - only the vendor stats are, right?
>>
> Right, although this feature is really about displaying statistics and queue type
> is just supplemental information.
Well, in the userspace implementation perspective it might be so, but 
thinking it from user's point of view it might not be easy to infer the 
type just from queue index.

>
>> Furthermore, without FEATURES_OK the stats returned for a specific queue
>> might not be stable/reliable/reasonable at all, not sure how the tool
>> can infer such complex state (e.g. negotiation is in progress) if
>> somehow the vendor driver doesn't provide the corresponding attribute?
>> Should vendor driver expect to fail with explicit message to indicate
>> the reason, or it'd be fine to just display zero stats there? Looking at
>> mlx5_vdpa implementation it seems to be the former case, but in case of
>> device being negotiating, depending on which queue, the vstat query
>> might end up with a confusing message of, either
>>
>> "virtqueue index is not valid"
>>
>> or,
>>
>> "failed to query hardware"
>>
>> but none is helpful for user to indicate what's going on... I wonder if
>> mandating presence of FEATURES_OK would simplify userspace tool's
>> implementation in this case?
> When you say "mandating", do you refer to kernel?
Yep. Either the vendor driver checks the FEATURES_OK status alone and 
rejects incoming request when negotiation is still in progress, or the 
vdpa core could double check on that. Or else the user would get to 
either of the above messages, which is kinda misleading to users.

>   The userspace tool
> can do that since it will have the negotiated features.
Are you suggesting if the userspace tool doesn't see the negotiated 
features attribute but the get_vendor_vq_stats() call was successful, it 
would simply assume no FEATURES_OK is set as yet?

For now I don't see the need of per-queue stat query before device and 
driver get done on feature negotiation. It would be simpler for the 
userspace tool to assume valid per-queue stats are available only until 
feature negotiation is done: the kernel could just reject the 
.get_vendor_vq_stats() call if not seeing FEATURES_OK. We can further 
extend by introducing new attribute to it whenever there's future need. 
That way you don't need to add a lot of future proof code to the 
userspace tool and try to cover all of the cases in the first place.

> I am reluctant to splitting attributes insertion between hardware driver
> and generic vdpa code. If this is vendor specific feature I think all attributes
> should come from the vendor driver. But, I don't insist and can move to vdpa
> generic code.
It's fine to insert all attributes in the driver, but please try to come 
up with sort of common abstraction/interface for userspace to digest. 
And hopefully it would simplify tool's implementation rather than 
complicate things up.

BTW, please pay attention to the comment I made for vdpa_dev_mutex 
below. I'd rather get the semaphore conversion done earlier than later, 
or there'll be side issue popped up with regard to locking and atomicity.

> Given that stats_get() is a read-only operation that might happen quite
> often from time to time, I wonder if it is now a good timing to convert
> vdpa_dev_mutex to a semaphore?
>

Thanks,
-Siwei
>
>>
>> Thanks,
>> -Siwei
>>
>>>>> +	err = vendor_stats_fill(vdev, msg, info, index);
>>>>> +
>>>>> +	genlmsg_end(msg, hdr);
>>>>> +
>>>>> +	return err;
>>>>> +
>>>>> +undo_msg:
>>>>> +	genlmsg_cancel(msg, hdr);
>>>>> +	return err;
>>>>> +}
>>>>> +
>>>>>     static int vdpa_nl_cmd_dev_config_get_doit(struct sk_buff *skb, struct genl_info *info)
>>>>>     {
>>>>>     	struct vdpa_device *vdev;
>>>>> @@ -990,6 +1058,60 @@ vdpa_nl_cmd_dev_config_get_dumpit(struct sk_buff *msg, struct netlink_callback *
>>>>>     	return msg->len;
>>>>>     }
>>>>>
>>>>> +static int vdpa_nl_cmd_dev_stats_get_doit(struct sk_buff *skb,
>>>>> +					  struct genl_info *info)
>>>>> +{
>>>>> +	struct vdpa_device *vdev;
>>>>> +	struct sk_buff *msg;
>>>>> +	const char *devname;
>>>>> +	struct device *dev;
>>>>> +	u32 index;
>>>>> +	int err;
>>>>> +
>>>>> +	if (!info->attrs[VDPA_ATTR_DEV_NAME])
>>>>> +		return -EINVAL;
>>>>> +
>>>>> +	if (!info->attrs[VDPA_ATTR_DEV_QUEUE_INDEX])
>>>>> +		return -EINVAL;
>>>>> +
>>>>> +	devname = nla_data(info->attrs[VDPA_ATTR_DEV_NAME]);
>>>>> +	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
>>>>> +	if (!msg)
>>>>> +		return -ENOMEM;
>>>>> +
>>>>> +	index = nla_get_u32(info->attrs[VDPA_ATTR_DEV_QUEUE_INDEX]);
>>>>> +	mutex_lock(&vdpa_dev_mutex);
>>>> Given that stats_get() is a read-only operation that might happen quite
>>>> often from time to time, I wonder if it is now a good timing to convert
>>>> vdpa_dev_mutex to a semaphore?
>>>>
>>>>> +	dev = bus_find_device(&vdpa_bus, NULL, devname, vdpa_name_match);
>>>>> +	if (!dev) {
>>>>> +		NL_SET_ERR_MSG_MOD(info->extack, "device not found");
>>>>> +		err = -ENODEV;
>>>>> +		goto dev_err;
>>>> Missing nlmsg_free().
>>>>> +	}
>>>>> +	vdev = container_of(dev, struct vdpa_device, dev);
>>>>> +	if (!vdev->mdev) {
>>>>> +		NL_SET_ERR_MSG_MOD(info->extack, "unmanaged vdpa device");
>>>>> +		err = -EINVAL;
>>>>> +		goto mdev_err;
>>>> Missing nlmsg_free().
>>>>
>>>> Otherwise looks fine.
>>>>
>>>> Acked-by: Si-Wei Liu <si-wei.liu@oracle.com>
>>>>
>>>>
>>>> -Siwei
>>>>> +	}
>>>>> +	err = vdpa_dev_vendor_stats_fill(vdev, msg, info, index);
>>>>> +	if (!err)
>>>>> +		err = genlmsg_reply(msg, info);
>>>>> +
>>>>> +	put_device(dev);
>>>>> +	mutex_unlock(&vdpa_dev_mutex);
>>>>> +
>>>>> +	if (err)
>>>>> +		nlmsg_free(msg);
>>>>> +
>>>>> +	return err;
>>>>> +
>>>>> +mdev_err:
>>>>> +	put_device(dev);
>>>>> +dev_err:
>>>>> +	mutex_unlock(&vdpa_dev_mutex);
>>>>> +	return err;
>>>>> +}
>>>>> +
>>>>>     static const struct nla_policy vdpa_nl_policy[VDPA_ATTR_MAX + 1] = {
>>>>>     	[VDPA_ATTR_MGMTDEV_BUS_NAME] = { .type = NLA_NUL_STRING },
>>>>>     	[VDPA_ATTR_MGMTDEV_DEV_NAME] = { .type = NLA_STRING },
>>>>> @@ -997,6 +1119,7 @@ static const struct nla_policy vdpa_nl_policy[VDPA_ATTR_MAX + 1] = {
>>>>>     	[VDPA_ATTR_DEV_NET_CFG_MACADDR] = NLA_POLICY_ETH_ADDR,
>>>>>     	/* virtio spec 1.1 section 5.1.4.1 for valid MTU range */
>>>>>     	[VDPA_ATTR_DEV_NET_CFG_MTU] = NLA_POLICY_MIN(NLA_U16, 68),
>>>>> +	[VDPA_ATTR_DEV_QUEUE_INDEX] = NLA_POLICY_RANGE(NLA_U32, 0, 65535),
>>>>>     };
>>>>>
>>>>>     static const struct genl_ops vdpa_nl_ops[] = {
>>>>> @@ -1030,6 +1153,12 @@ static const struct genl_ops vdpa_nl_ops[] = {
>>>>>     		.doit = vdpa_nl_cmd_dev_config_get_doit,
>>>>>     		.dumpit = vdpa_nl_cmd_dev_config_get_dumpit,
>>>>>     	},
>>>>> +	{
>>>>> +		.cmd = VDPA_CMD_DEV_VSTATS_GET,
>>>>> +		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
>>>>> +		.doit = vdpa_nl_cmd_dev_stats_get_doit,
>>>>> +		.flags = GENL_ADMIN_PERM,
>>>>> +	},
>>>>>     };
>>>>>
>>>>>     static struct genl_family vdpa_nl_family __ro_after_init = {
>>>>> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
>>>>> index 8943a209202e..48ed1fc00830 100644
>>>>> --- a/include/linux/vdpa.h
>>>>> +++ b/include/linux/vdpa.h
>>>>> @@ -276,6 +276,9 @@ struct vdpa_config_ops {
>>>>>     			    const struct vdpa_vq_state *state);
>>>>>     	int (*get_vq_state)(struct vdpa_device *vdev, u16 idx,
>>>>>     			    struct vdpa_vq_state *state);
>>>>> +	int (*get_vendor_vq_stats)(struct vdpa_device *vdev, u16 idx,
>>>>> +				   struct sk_buff *msg,
>>>>> +				   struct netlink_ext_ack *extack);
>>>>>     	struct vdpa_notification_area
>>>>>     	(*get_vq_notification)(struct vdpa_device *vdev, u16 idx);
>>>>>     	/* vq irq is not expected to be changed once DRIVER_OK is set */
>>>>> @@ -473,4 +476,6 @@ struct vdpa_mgmt_dev {
>>>>>     int vdpa_mgmtdev_register(struct vdpa_mgmt_dev *mdev);
>>>>>     void vdpa_mgmtdev_unregister(struct vdpa_mgmt_dev *mdev);
>>>>>
>>>>> +#define VDPA_INVAL_QUEUE_INDEX 0xffff
>>>>> +
>>>>>     #endif /* _LINUX_VDPA_H */
>>>>> diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
>>>>> index 1061d8d2d09d..25c55cab3d7c 100644
>>>>> --- a/include/uapi/linux/vdpa.h
>>>>> +++ b/include/uapi/linux/vdpa.h
>>>>> @@ -18,6 +18,7 @@ enum vdpa_command {
>>>>>     	VDPA_CMD_DEV_DEL,
>>>>>     	VDPA_CMD_DEV_GET,		/* can dump */
>>>>>     	VDPA_CMD_DEV_CONFIG_GET,	/* can dump */
>>>>> +	VDPA_CMD_DEV_VSTATS_GET,
>>>>>     };
>>>>>
>>>>>     enum vdpa_attr {
>>>>> @@ -46,6 +47,11 @@ enum vdpa_attr {
>>>>>     	VDPA_ATTR_DEV_NEGOTIATED_FEATURES,	/* u64 */
>>>>>     	VDPA_ATTR_DEV_MGMTDEV_MAX_VQS,		/* u32 */
>>>>>     	VDPA_ATTR_DEV_SUPPORTED_FEATURES,	/* u64 */
>>>>> +
>>>>> +	VDPA_ATTR_DEV_QUEUE_INDEX,              /* u32 */
>>>>> +	VDPA_ATTR_DEV_VENDOR_ATTR_NAME,		/* string */
>>>>> +	VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,        /* u64 */
>>>>> +
>>>>>     	/* new attributes must be added above here */
>>>>>     	VDPA_ATTR_MAX,
>>>>>     };

