Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901E35375BC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 09:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233792AbiE3HpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 03:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233777AbiE3Ho5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 03:44:57 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDF618E24
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 00:44:55 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24U5ukbP007190;
        Mon, 30 May 2022 07:44:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2021-07-09;
 bh=Zk9eMw5C3wdquNxQr52IWXyGw2mc2qWUmNlBDUPC+8U=;
 b=o+N+pP0/onP+eZhLg8/6f2LOfGUPcQZQmZtaqi/2Yliz3PY70Ui7dyVLvxzoisPhcX73
 j8AzKWnHTEg+Ml8B+Yx7LWo5qu7DQZoVJawMEAghFvwcvPdP5NVz1Ac4G11owunUCLWQ
 KFNZUIEWVvocuAtLd4HOImGRw76BtQj+1aS7pWk2jUbV6lRmaV24fI2pwni6cm5CDDMx
 xMjqJV5dBCBqu48oNQP8hhie5xRYa3+r9oF//Tjmx412jR+fC7ayxgE0qJk/GYzOnK9b
 KSJZV0VWzf3eVpnuQYy10FVtEluAgn1ljn1/IKCaqr7I7O9zb4IyH7bofNuMUO4vkNxi ew== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gbcaujabs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 May 2022 07:44:43 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24U7ZWoa038671;
        Mon, 30 May 2022 07:44:41 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2040.outbound.protection.outlook.com [104.47.56.40])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gc8kdq300-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 May 2022 07:44:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kVnGiC4Gk+AMdqRZoMVWHvAf9m3/vSSe8R8+OOebQYQs2LKHtkydllJNhB/LRIR/QzuLVsk4JcOqDUNzk8e0zHIlHDoOEwug50e14kh35TzUVC7Q1wGDQfE2YkdirQoTYGf3iycTjO0eOl8D5aiAKK+up5vSSBueJ6Fd5OmOTF/8fG+vaBq1wANETc8uP0vx7uJj9no5/eAmMytwZ38TasDVCY7smt9Omd329dG7OJOnTggVgGpCdBEvsRQKR9uYLYpG0ye+tfgaCi9jREtrrkRAiIZG8P2e7RM/2NApkOzhxVuocea/mS9F+AucH4F0e/JQdVTkrpvRBbWdIQupsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zk9eMw5C3wdquNxQr52IWXyGw2mc2qWUmNlBDUPC+8U=;
 b=M28LxF0H8XduyL2PPmWQb7jof+Y0YPJW5AuD/gkXr0UBFvZNb8vk8oXUuJtDLWJPz9CStcm+/Q4LtJ10Dr8vdSn6/QqICVK2huFuym67q9xjkn2cntJNJqYjrqkP/w9LQ9Rkz5Hbjq8KWW1cQaCrfQBodp6mQvc10/UJDpDrtD/0zoyxYB02a1f7dhUrk4Tz3J5hpOJXHnvbhGn73clL5EMk7oHuxZGcLXGfMAAesgbR/4Q8G1ILHcYc6zlkvBW7zPvAfyKocDj+ZRWEv1kfURjNhKV3a8YOYdEVNJc6dnM7IZJ6tac9EASkEybU/FSpD60szD0LhWdSVEO6GGAW5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zk9eMw5C3wdquNxQr52IWXyGw2mc2qWUmNlBDUPC+8U=;
 b=eRUsl7GxKSkg94fGk/k0UPC9F1LzJHsFEyA4xxwCy/LWHfmeiXYQWEJFNOHuPQiudVzPkn3a0af++AKuOLEpS2lOOlXSNOB1KTJeQ8K5C4bVqXGatCcMJFAXH4u2VRijYE5UOAA996H9N2L81htmBSh+14KY84hI5XqzZXMylxg=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM6PR10MB3369.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Mon, 30 May
 2022 07:44:40 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e%2]) with mapi id 15.20.5293.019; Mon, 30 May 2022
 07:44:39 +0000
Date:   Mon, 30 May 2022 10:44:21 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     gregkh@linuxfoundation.org, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] staging: r8188eu: Fix warning of array overflow
 in ioctl_linux.c
Message-ID: <20220530074420.GL2146@kadam>
References: <20220529004711.27545-1-Larry.Finger@lwfinger.net>
 <20220529004711.27545-2-Larry.Finger@lwfinger.net>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220529004711.27545-2-Larry.Finger@lwfinger.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0069.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::15)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af3aa2e4-dc1a-4215-0a6c-08da4210404b
X-MS-TrafficTypeDiagnostic: DM6PR10MB3369:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB336940A523757A528A6DAE1B8EDD9@DM6PR10MB3369.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wMZushe1HMhGfG24+0mRNDfH6q1ljH04rhvCKgLBV1LUAVzJ+ghfVwsek+5qyFiFuxkb8ZI1H/LtCzUf+w3ym76geS1kZrzUYhfHzd52kWlQkmUb6xFpwPjV8Pwhjugs1Pbxg7YhLCASSwuwWhVENAME9tkdBgB0yvOh2RzvRwSe7nXQq9CaZ2Ybb4BBy0Iv0IMAm34rORvS651+Y2cwdWZVIs8B7xjijkytuiAEKJNMPuxswWo8rw3Wft043IzJsTDwX5B2gmVmm+/uM1VOzFrk3inUa8J9OPPGaSFDLwDyX6BFuffWCuwi9rttIXMWsvDtGkBt43lj52A5/Bpoo8xOB1tK6ty3cOCX0hyd0SU7BUWW5KIExyHgw4mJu2XsCu7KnGwzA2UgPch6fTv3b+LBfHOWUhndhriGB/62nu1QqgpIPXDM3IXboxJzJhLUW2w5OHH/B5ZG4BlgE/0GSAjmjvfA6LWJ0nsTZRgZCM+aqBY8arERJh3LdVIPjPu9z6YEoNdJ3A1jPz/jkWTabRS+lzsaHAWb1fOwVgQhgDX+7d6qhyqxkWSqeJI5nFCr2t0GFMOIYXBjmbeVXOPQZudY7ojtHG7v40DaGiPqHGOtSYLa6luzZdK4aJY02tIEaar0X9aB4KY9Htrg9WU/f1RXn3YH6gNwYAdBWCGgVdxGXsspne0lQsO71LoigHWSKg4G8ScO4zDbauBsMtG5WQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(186003)(508600001)(6486002)(26005)(5660300002)(6512007)(6506007)(52116002)(9686003)(8936002)(44832011)(2906002)(1076003)(33656002)(86362001)(38350700002)(38100700002)(6916009)(4326008)(8676002)(6666004)(66946007)(66476007)(66556008)(316002)(33716001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDMrSmxvT0JRLzIvRnJBRjZXdGFnQ0M5ci9KdzBMUFh4MHBXb0lDR3ZuUUM5?=
 =?utf-8?B?SDZwUXJvT1N2UjhTMk80VEtibkJPc1hvQTVmZ3RGVnVhdHZlSTZHd1R5c21K?=
 =?utf-8?B?cm8zK04xNXJObU5DQTR0RDRaeHpoOVZwZ1RNV3lHall1UGFQOTZ0Z2JDRnhK?=
 =?utf-8?B?V05HMGVhVkJqaEFMZDdsVXR1bmtlT2ZIWERIK1RUbG9MSzdQTkVOUmlPVjZy?=
 =?utf-8?B?Q25tRHAxTmhURXZMQkZNd2g3ZUFHeFd5TFRxMlZuVWxCcGtWdk81M1NyajFB?=
 =?utf-8?B?dUpFNHZhcXhHMnpvaUxLU0JkRGNVcFg3d2pzRm4ra2hlOFRMY2pUTWg2Y1I0?=
 =?utf-8?B?NGNUWkZWcWRWUm1GU1hiN2ZtdE0xN2E4djJ4bFJVbGlKVHJBdlVNdWxkZUtw?=
 =?utf-8?B?ampoQ01xMVpKZXZHQWMzY1RUSXdLMUJIYm5uMzJKVmFhMWQ2L091akpMM010?=
 =?utf-8?B?MmdNWUN1OWdJVkNNMjFxQ1A5UUlQQm41aElVVGZEMlJLNmNoTmE2UnFIS3pS?=
 =?utf-8?B?Y1AvSWtaR2taYWFNRnRNT1Z2M0tidFZMWW9ZSkh1RGNNVlI3L1ZpeHllekVk?=
 =?utf-8?B?YlpWaThGb1FvUlcvNklnRUI3a3UxMThDNkhPNEY4TWVtKzRsTGhCRDR6VHlm?=
 =?utf-8?B?c3phemNPeEhYT0diL216dkw1aTJHU09CUG1GcjAwTmdyTVB4Yks3Z2s1K0hK?=
 =?utf-8?B?d21zWW1wS3RkUVBIcC9yeEluNWZCK3ZRQ2QxRzdwZHJEeCtGT1l1dzc0L1BT?=
 =?utf-8?B?djhaaytWTjRndHBDdGp0SlRLM3o3ZmFPcW9vazg5MEhQdmVnMWhOaUthTmh3?=
 =?utf-8?B?ZXk3VHhyZ2hienlQN01oOXg3YVlwc3ZjeVdpQllMZktDeXFweWFmMWNvN3Mz?=
 =?utf-8?B?emRUR05ocU1Wb200ZjREYzg0WGZhV3diV1Q4anIvYzlJMzl4bWZsUEluZ290?=
 =?utf-8?B?Vk1ZMEMxd0RJdDZzTWdVN1RSYy9sMkdnSHo5TUJZVlVKQlU1Kzg3UWxsOXBV?=
 =?utf-8?B?RnlrUnhLVjdWWUxoSFpKWUVDZWszVzBZUyszRlF0TGlIeHpRRUdJR3Q3Yy8z?=
 =?utf-8?B?eVJMS25nNEh3UEk0TjNtNzRrUXVjTEJjTkh5aW1oOGgrenZSSGNJaFF3V21s?=
 =?utf-8?B?aVZ0VCtWUGw3bmpKRGlacG5HbWN1ejRXZnE1RmJxK3lQSHdISFpEbGRlZ3h0?=
 =?utf-8?B?Mmw2Rm5ObnE2R0FiaXorb1lTdER6bHRNTUl4cW9neDgrVmNJRXI3N0w4RE5a?=
 =?utf-8?B?OEE4VUdxTFRaMkpCMGdsQldjSDJHaWxqdVlDZFRxYXowYjJKVE1iVVZCYkNt?=
 =?utf-8?B?ZW5LY1hLRnZUbk0xNnIxL1FJaEZWQ2FZaThvcm9GNlZOY1NORm5DR3JoRVU2?=
 =?utf-8?B?SjZsZGVqUTdHamV3UHFOa0wvWk1sQU52ZjBUWlFKSG90eDV5bi9nY2V1OGZY?=
 =?utf-8?B?UmR0aFljMEhWRmZYL1V6TUFwTUZ5NzZaUU9WWkhVTnBIRWdpdFVDaWpoZVAx?=
 =?utf-8?B?SC9ZNFA3T0hOdzcrbmk0K2ZubzNveGNSYWQ4R3hZT3lPMThnaWp5emhJamhX?=
 =?utf-8?B?M2FWZXdkUXREM3pXL2dvQ25kdENsK1RPZml4UDlzdEJ0UEFCY0V5cmZtTjdO?=
 =?utf-8?B?bzhhbE1Jd1VjQUZMUG1BZHB0T2k2SGoyK2l5N0tET0N0L0hsTmYwbm5sNzBP?=
 =?utf-8?B?TTJzdThIWDU1cFRyVmhQcEJiMnJwU2F5Tmc2ckVkdktsOHRZVXcwRXllaThu?=
 =?utf-8?B?VnhkV1VoSHRUVURrYXZFbWNjR29pSjJPdTdiNkk0TEp1dVkxdDk2ek94Tnli?=
 =?utf-8?B?dHQ0dGtmS05mOGtMbnI5QTk5M29yT2dFV201U1NQVlZXT1VjUVVqTHRVNnFk?=
 =?utf-8?B?WlFrK2FBblNleEpyQko2MnhnTFNsd3BtZlYxVGdyOEg3QlFvZ0dlL2J1TUp5?=
 =?utf-8?B?NmFYYkxFUklqUmJnajBqZ25ZbG5sOWlScE53TnI2VnMrUHBNR2ErVFUzY1d5?=
 =?utf-8?B?VE5TMWgzZ0VjajhEb3oxSlg1YTh3eXdmWnFtcCtMY1UxQkp5dVQzTUp0dzVq?=
 =?utf-8?B?VEZkQUhKSEdVaGVSRitjMUZXV0kzblQxZ3NuYUlROGw5a3huN09YMHdkVDU5?=
 =?utf-8?B?QmIwMTNLWnM0Y1J1Y0xBUkFGTHVTSmRiMHZGTzBjQytnK2tEdG9lajN6aExv?=
 =?utf-8?B?U0dZRmtDRXI1MkxjNWVKUmdDa2R6aVFYcXVSOXRsOFExT0h6dE1wdnhzY2Rn?=
 =?utf-8?B?VkZrdFcyTkZmN2tXWHRXMnVxQXRqbHYvdEg1UHFnSU9Kcm8wQ3hiMXVtRHkx?=
 =?utf-8?B?QTZtbWlISHhlbkdsbE92c0VrQWhYSVBZUCtiZnNoV2NzaHNkZ3JCOUErZmpq?=
 =?utf-8?Q?bekbgmYGpoz5WMRA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af3aa2e4-dc1a-4215-0a6c-08da4210404b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2022 07:44:39.7540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ibswX1emwDIAeRs7B71mzwsz97/zc0nxfN+nHTMeFKP+aqiH57hA6NlJLyy+0VjfXpRNfpSUneK2Npu4B7H3y8ySD3VbHi4TOpJEjTp3Rk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3369
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-30_02:2022-05-27,2022-05-30 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2205300039
X-Proofpoint-ORIG-GUID: i5C4BBS64_67mZzSjkXInfEYDZZ7FkPo
X-Proofpoint-GUID: i5C4BBS64_67mZzSjkXInfEYDZZ7FkPo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 28, 2022 at 07:47:10PM -0500, Larry Finger wrote:
> Building with -Warray-bounds results in the following warning plus others
> related to the same problem:
> 
> CC [M]  drivers/staging/r8188eu/os_dep/ioctl_linux.o
> In function ‘wpa_set_encryption’,
>     inlined from ‘rtw_wx_set_enc_ext’ at drivers/staging/r8188eu/os_dep/ioctl_linux.c:1868:9:
> drivers/staging/r8188eu/os_dep/ioctl_linux.c:412:41: warning: array subscript ‘struct ndis_802_11_wep[0]’ is partly outside array bounds of ‘void[25]’ [-Warray-bounds]
>   412 |                         pwep->KeyLength = wep_key_len;

I'm not totally sure I understand where the void[25] comes from...

This is a false positive, though?  Another fix would be to just declare
the struct as a variable size array?  I don't know where the 16 comes
from either.  :P  I have not followed this logic to other functions.  If
the 16 is important then the bug is real.

Your patch is harmless and less risky than changing the struct
definition so I'm fine with that.  But I'm just trying to understand the
situation better.

regards,
dan carpenter

diff --git a/drivers/staging/r8188eu/include/wlan_bssdef.h b/drivers/staging/r8188eu/include/wlan_bssdef.h
index 9d1c9e763287..0d4fb1d0b22b 100644
--- a/drivers/staging/r8188eu/include/wlan_bssdef.h
+++ b/drivers/staging/r8188eu/include/wlan_bssdef.h
@@ -158,7 +158,7 @@ struct ndis_802_11_wep {
 	u32     KeyIndex;      /*  0 is the per-client key,
 				  * 1-N are the global keys */
 	u32     KeyLength;     /*  length of key in bytes */
-	u8     KeyMaterial[16];/*  variable len depending on above field */
+	u8     KeyMaterial[];/*  variable len depending on above field */
 };
 
 struct ndis_802_11_auth_req {


