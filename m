Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50843508D52
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 18:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380591AbiDTQbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 12:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380584AbiDTQbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 12:31:48 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9820243ACB;
        Wed, 20 Apr 2022 09:29:01 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23KG50Us014729;
        Wed, 20 Apr 2022 16:28:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Ve1mpS0/tyiJVFn7F1lDPQEKAlNnVcGWh7KE3uDjZ0Y=;
 b=dV6QaqS4FulzBMCLk50khbV4NdDunyGcQg5zBdF1Dvfm9X9BlK7sLqspxRyYQAW2SnME
 3gNF6wm96bPh1dRkGfsxL1SR1WliMLwNLNloloqKpQ+NUNsXJFeR1+OEIIHKCKRQVXSx
 1lcUUB2hLyOxwuAx27zeb06TqYzotGJHI5gQy9G1Zntj6224xnyEqxElP7590zJ7vA+y
 IpusLiGQlmDrMFeIYbcZJQxb8I4iFKJZqrCd1Bvwa344CPtpn0KM3q4z2qAYfXkBowIf
 E2Mv6DS2Dtb8EjxYukksn5EjJdUTfbux6lJlI6jI0qCth0eDwdhrPMRwz1YlsAHYq3aw vQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffndthnt0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 16:28:49 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23KGAgrg030857;
        Wed, 20 Apr 2022 16:28:42 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3ffm87jme9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 16:28:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J2Bf1QtcbS4+XM/1wKSPaEEOUFzC+Jlsba2urL31BiskbLqY9+zBPRlAjZKtuQ0CID8l/R/ccRf99nYiUKvFb4gRWDgjP0Vcmu1pO5KP04ex+TyDltccZzCHSyjr0MG0hdEvZ6F8xY2UJa/LVMPF4Ocl2GKSZFR06fixkTshsCv/yNvx2KLgDJ/trhFFKJ+HTaEGqZoF3PXSdX+wgkJyMyudu8RLcJv593rAVInbk4hHzazHi8zfDu74Z7K9LrKscG2m1fD6ARtRP967U/IqcsL4ICnIhZkumm7iR86drmudKzaVdH5ZCCpEHgW43NTfMMj8qg9fV/+yXCEbBD/rUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ve1mpS0/tyiJVFn7F1lDPQEKAlNnVcGWh7KE3uDjZ0Y=;
 b=X3QL0m/UCnc8WvPXqVP/jIzkpzAPyOY4cZAOD4G99p97E/F0gSFT3wZx7PWNfaslzCxILl3our0z7aBdKEQFA/Bz4/xGSRG4RV+a4tO6d6vWkYlBM+zS7nuMjlJbYOr4UuGQFiNlpj+QkQZgue7r4a53SNsbd7RbLNB9UZqym15+JnEUUEACihgCH7IYuk7bZQM7mF321PrRe9jeQKWXkdMMaMvTRejqzlqsmxlyNVfeL9l6N1kNFY5N/7GSw71m/JzM+Xdc3Z2zY3QFFIuA0Qg5jntEsioPkeQ+rDDL12yqoFVaNI34G+Qz82dkHj+L6Q3nCz2YTttE4wgFe/AP/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ve1mpS0/tyiJVFn7F1lDPQEKAlNnVcGWh7KE3uDjZ0Y=;
 b=xppCwIqQxlDQ3K3PgIikb4mK9gMOacIRsPZIB6lmdKnSUOi+xi48gG61RQNXbTcSotjkXNyTpG4aQOyoyKX32d2mIdHDf7cT6L5eLNyFpr7YWr0rV6PtYK3wFlSXMTAynEt5ORcJhNpX1Ape/8kquhU9KBH2vCmDcxWWC05O/Ew=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 SJ0PR10MB5422.namprd10.prod.outlook.com (2603:10b6:a03:3ad::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.13; Wed, 20 Apr 2022 16:28:39 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::3cb2:a04:baff:8586]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::3cb2:a04:baff:8586%2]) with mapi id 15.20.5164.025; Wed, 20 Apr 2022
 16:28:39 +0000
Message-ID: <938bca13-2dcc-24c0-51b5-26f7e7238776@oracle.com>
Date:   Wed, 20 Apr 2022 11:28:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2] scsi: iscsi: Fix multiple iscsi session unbind event
 sent to userspace
Content-Language: en-US
To:     Wenchao Hao <haowenchao@huawei.com>, Lee Duncan <lduncan@suse.com>,
        Chris Leech <cleech@redhat.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        open-iscsi@googlegroups.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linfeilong@huawei.com
References: <20220418000627.474784-1-haowenchao@huawei.com>
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20220418000627.474784-1-haowenchao@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0325.namprd03.prod.outlook.com
 (2603:10b6:610:118::31) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ef6b0ee-d76b-4a59-ea30-08da22ead3c5
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5422:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB5422257C2D989A67D279337CF1F59@SJ0PR10MB5422.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2mNjNoGDT1TH0cYRA3gJKSxLTday55jNB/rsirdJQUYPXL4VlV26E/A1btfRKLlAjXLMC0d+hAnN50hpejD9A8Mh7P6Z429f22SxDYwB82QID5dxweJ9fEgG/mCM5l5u52FLwpgtM3WpxHdItUeZvmleme1sp0/RLFWEcJioAOp0xAEIVJUO4g7WRiQeEj7BYDNaY1BXXzK0qdNlcCtMNUnwlG35e/7IdzVKqVvNjtGZKHC6rzoEYUv4uMNiDGMcae0uAFjYog9rDLhegof9p3XnQqNzOFcUDBFUYtYHssD1jU2Czns8dEdFKWvgz0JooddLdlTSpDZwZGTwKw/cfAv8QP8lE5BdeHs/fdEWfmKjdtOcV7YsYfgPmZgcvQ2qQYY7tdDchoaKF1V37FXfvV8EAdnxJuwA1DB5k7gaNfn4WR0Zhs6mSXBct6XDGY70KFD/ErUoXLAacQCUnbdmRlycGKIAP96IBzCT2cueTwPaxf2UfeiCOpgdXUUFzAMT+RW8gJr09J20yg2JAwtU57AaTRXf3elaLyRSG8Hc8YP1vy+hAcCdgXliD1m5d9/+VTy5sV2rr5O3Cx/182B6OZvMcdttR87W+2GcTRyLlNkgZZNzAizYr0LZ51ZhtHcawytfrJasyXYSUsSdkttocU6h9u2R1uzttHIq3/mZUg7AL1aIfpmWcKbZbxPrCEg9S5HA9AAUjUa8Fn2ZG2NZ+TfSLx2X2D82ASIPnszBGO8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8676002)(66476007)(66556008)(6512007)(4326008)(66946007)(83380400001)(6486002)(53546011)(508600001)(6506007)(26005)(36756003)(316002)(186003)(8936002)(2906002)(31686004)(31696002)(86362001)(5660300002)(110136005)(2616005)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXRGUURMNnlDZUhZdUZkNjM0aWszZmxpcm9iYXA0VGxZYW1sVWVJUzVrT2JF?=
 =?utf-8?B?ZTVEUjlibWhYYmJIcnlBRllIbjdLZEtrWkFrYWh3aVlPSndMMFo1SnBnVWor?=
 =?utf-8?B?ejVmL3NIVCs2U0hpNkVRWlZ5US95QzRablowWTkxVUZOSXByYW5aL3QwM25O?=
 =?utf-8?B?N09oNGpPeU5SZDBEdGNzNWpmSEdsQ2JxSm00djRmcTk1ZFNmUXNPRS9IZUtV?=
 =?utf-8?B?VFNCbTJBOXY0d3hNcFVNN1JUUDdNU3RxYmFIZjVLc3U1NjRlelZiV1p3TDFu?=
 =?utf-8?B?SjJyWVlwaU8vMTFSV1RwVmxoVGoyeERqVGJxRGVEQ3hwRFE0ZXgwQ2VQRnRy?=
 =?utf-8?B?ZjRpY1FaWi9lWWJwUVJnc2lyNS9sbzdhOTFPWHltamV2SHBNZTdESUd6SDl1?=
 =?utf-8?B?dEltbFpmTkptRkZGZWVxZFVvV2JFVGxsZUhMTENuRXBxbi9EbzJuWFl5WVlU?=
 =?utf-8?B?U051Z2E1aFNvMFQxMnl0SHJSNW1zWlpqZXhQUHQvZUdUWjY3MHhvRlNIOXRY?=
 =?utf-8?B?K2VsY296QWN6azlVeUxnYjZZWS9xOWdwUkc4Ykxhc21mZWZ1U2JucFBaUVNq?=
 =?utf-8?B?R2xxcG94S1BtSEErL1ZQNEc1dzNBWEtHclArajdSSm5UU08wWmIrNngvamEx?=
 =?utf-8?B?VFZMKzJQWGxpdlAyMFZrSlBUaStDajdZbU8xdkM0ZXE0OTJCNmhnUExlcUh5?=
 =?utf-8?B?MXNoTGxSUjA1OGV6OHE1Q2h3SktrRitHbHl5ZTBCeFFpbm9obGhXSloxQzZ1?=
 =?utf-8?B?REsweGRjSjVMa3BORmUvbzJpTU16RUo4TkUzSFJtMFdNaHE2Znh0RU14Wk9o?=
 =?utf-8?B?SVJSZ2dUOFQ2aEMrZGFxQ3I0cDJ1YUJqeFRxNnM4cVZGanM2aHhhVlVXUlNp?=
 =?utf-8?B?K1ZrdElsOGVTbUNacW9zaW5mOXU2emkrbFd3MEJvQTRVU3JsZEsyNWI2YTRF?=
 =?utf-8?B?aE5YNnBuVnVnVTdqemJtMVRVaDZzR0trdGl3SSs0UDBLdzk1QVFmUEdBTjRM?=
 =?utf-8?B?TEY5R0s5UnpuOXdOUnJiaU11T0VORGxxdUd2WFBTNDY0ZlpId2xBSzE5NlFw?=
 =?utf-8?B?NDhnNXRaQ3lQcThDNmZhVXgxYzY2a3lWb1JzamY3b3hOVTRhdmZ4RFJObWpH?=
 =?utf-8?B?VkJQaHp2bkVkQXFSMzg5dTJMRTZyR2tyK1MwcnM0TWhZRzRic1RRcFptWkhw?=
 =?utf-8?B?VUxCRU1NdTlYRlh2V3VIRUFpVitPU1g2UnduY0EvYjN1cFdIWndFcW94SmQ1?=
 =?utf-8?B?YWZuOUczaGJadGM1ajlNRk55Yll1TWY0T1d4Y294ZkZvbHRHQnlrTlRoeWM1?=
 =?utf-8?B?dXBrZ1FFSE9yVHVrdzZiN0RIZllDcjRPVmxKV285eVNYakpUWUY5UnNFRmkw?=
 =?utf-8?B?dk5vTGRGMlMzaGhVQzZ4Z1lkcTdNRGJKS1BDQ3JEODhaOVh3eURsZ1NmVEZp?=
 =?utf-8?B?aUNRRzhNS2E4NzQzS3pEdHhIQzZKYTNwREJXVDQyc3V2S2I2dE04c0tRT2E3?=
 =?utf-8?B?QVZsUHdwTzJJdTBxL2lIYW14eVYwbmo0RUNwZGNmNlJHY09UK3pDU1hCVlhs?=
 =?utf-8?B?Z1huSVc4bGd4L01GVzIvM2M5VXdmdGRmMUhIQzhtWENJbDZ6MzJ3WlBZTGhy?=
 =?utf-8?B?ektiK2ZOdWVWQ1pzMTJLbzc1TTNNMTdybmt6NnM3cTRiV2R3TVNhU29ONHgw?=
 =?utf-8?B?NHFneE53RGlMSWdKRlpQWkdjdCs0bnVTSDVHRDVwRkxUaC9Dc29Zb2NpRGoy?=
 =?utf-8?B?YWp0V1RrNERIV2ZGWU1PNG1uNWpMZm9LcnBvUGRmelRaR0tWa1dycjB3ZjNv?=
 =?utf-8?B?ZVc0MG5nUjBYRENmMXl3RW05eHRBeVl3Si9IVmgvMWNDV2V3NFhGVndtUTls?=
 =?utf-8?B?YkpsUWpWMXU3RUtnQkZRMm5XUW5lTnB1T080U3lZNGNMU1U4ZjZvblB2ZDRK?=
 =?utf-8?B?U05wcU9IVzVLVWoyT09Wa3NsNkhhemdIQW9iOEQrS2FsdTJPbFkvTDU4b3px?=
 =?utf-8?B?YlBzVDJXTHRkL3RRMmRYSlVjZ085cmtKNjIzZ3FKOWZhcTRUSkRWdW92VFdK?=
 =?utf-8?B?NjJIaTJ1S3RLT3hNc3RsK1B5SzFYUVNaTjdoaFgrRzBBNmRPUlNidXhONmZY?=
 =?utf-8?B?NTAwM0hqeVJEQ2FScnlUdlowdUx6Ti9UNkJVb2twSjNUZWVlK2VPSTA1SCsv?=
 =?utf-8?B?cmVyYTRFcThJakpPKzlYMENLOEMxSG5GVkZTSXJOQnA5T3crL3dKcGE5djJT?=
 =?utf-8?B?NEE4akFmald2dGtBTWVUM1NMZXllU0pvUG9aUkR4WHpoWk9LelBkaU5xNmJn?=
 =?utf-8?B?R2pUOUQveWNZUXVSZWd2Z21CbDNjYkYrTmZiVXlRazRTWkw5YUF0RDI5RzU1?=
 =?utf-8?Q?ECEhLTjtNGOmeR9A=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ef6b0ee-d76b-4a59-ea30-08da22ead3c5
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 16:28:39.8251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VjasT0+ZH167whf2e5Py+rd3jgOLAyarHkvomTiwxWpxYHdvLwnLx400SkhZslHWsRqs9su0ZnjbKtDGqLBhUEHsBFD1vjVn8gR69EXysP0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5422
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-20_04:2022-04-20,2022-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204200097
X-Proofpoint-ORIG-GUID: 26w_kTCShLVlA9Szzfgrd5x6BmaDkwtS
X-Proofpoint-GUID: 26w_kTCShLVlA9Szzfgrd5x6BmaDkwtS
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/17/22 7:06 PM, Wenchao Hao wrote:
> I found an issue that kernel would send ISCSI_KEVENT_UNBIND_SESSION
> for multiple times which should be fixed.
> 
> This patch introduce target_unbound in iscsi_cls_session to make
> sure session would send only one ISCSI_KEVENT_UNBIND_SESSION.
> 
> But this would break issue fixed in commit 13e60d3ba287 ("scsi: iscsi:
> Report unbind session event when the target has been removed"). The issue
> is iscsid died for any reason after it send unbind session to kernel, once
> iscsid restart again, it loss kernel's ISCSI_KEVENT_UNBIND_SESSION event.
> 
> Now kernel think iscsi_cls_session has already sent an
> ISCSI_KEVENT_UNBIND_SESSION event and would not send it any more. Which
> would cause userspace unable to logout. Actually the session is in
> invalid state(it's target_id is INVALID), iscsid should not sync this
> session in it's restart.
> 
> So we need to check session's target unbound state during iscsid restart,
> if session is in unbound state, do not sync this session and perform
> session teardown. It's reasonable because once a session is unbound, we
> can not recover it any more(mainly because it's target id is INVALID)
> 
> Changes from V1:
> - Using target_unbound rather than state to indicate session has been
>   unbound
> 
> Signed-off-by: Wenchao Hao <haowenchao@huawei.com>
> ---
>  drivers/scsi/scsi_transport_iscsi.c | 21 +++++++++++++++++++++
>  include/scsi/scsi_transport_iscsi.h |  1 +
>  2 files changed, 22 insertions(+)
> 
> diff --git a/drivers/scsi/scsi_transport_iscsi.c b/drivers/scsi/scsi_transport_iscsi.c
> index 2c0dd64159b0..43ba31e595b4 100644
> --- a/drivers/scsi/scsi_transport_iscsi.c
> +++ b/drivers/scsi/scsi_transport_iscsi.c
> @@ -1958,6 +1958,14 @@ static void __iscsi_unbind_session(struct work_struct *work)
>  
>  	ISCSI_DBG_TRANS_SESSION(session, "Unbinding session\n");
>  
> +	spin_lock_irqsave(&session->lock, flags);
> +	if (session->target_unbound) {
> +		spin_unlock_irqrestore(&session->lock, flags);
> +		return;
> +	}
> +	session->target_unbound = 1;

Shoot, sorry, I think I gave you a bad review comment when I said we
could do a bool or state kind or variable.

If we set unbound here and iscsid was restarting at this point then
iscsid really only knows the target removal process is starting up. It
doesn't know that the target is not yet removed. We could be doing sync
caches and/or still tearing down scsi_devices/LUNs.

For the comments I gave you on the userspace PR parts, would it be
easier if this was a state type of value? Above you would set it to
REMOVING. When scsi_remove_target is done then we can set it to
REMOVED. That combined with the session and conn states we can detect
how far we got in the session removal process if iscsid dies in the
middle of it.

What do you think?


> +	spin_unlock_irqrestore(&session->lock, flags);
> +
>  	/* Prevent new scans and make sure scanning is not in progress */
>  	mutex_lock(&ihost->mutex);
>  	spin_lock_irqsave(&session->lock, flags)

...

> diff --git a/include/scsi/scsi_transport_iscsi.h b/include/scsi/scsi_transport_iscsi.h
> index 9acb8422f680..877632c25e56 100644
> --- a/include/scsi/scsi_transport_iscsi.h
> +++ b/include/scsi/scsi_transport_iscsi.h
> @@ -256,6 +256,7 @@ struct iscsi_cls_session {
>  	struct workqueue_struct *workq;
>  
>  	unsigned int target_id;
> +	int target_unbound;   /* make sure unbind session only once */


We don't need the comment since the code using this is so simple
and the name of the variable tells us what it's for.


>  	bool ida_used;
>  
>  	/*

