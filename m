Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B70501E7C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 00:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243925AbiDNWfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 18:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235739AbiDNWf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 18:35:26 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2A0C55AD
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 15:33:00 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23EKYWX2028126;
        Thu, 14 Apr 2022 22:32:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=xxcmCSZjfrMsLYX8wYqOQ4uxYSRtRJqoiCKoWY2kNFs=;
 b=PuHoLBKV3c2vtHVNr/IVSmRkNKwvJNh2XyYFWTrdIqlkiZyFTPxDI/8vV1ypKJdNj3xC
 1TD89VqvS5wFQ/JRvhmRLQ+WhEUfOGdK57XyzbE8bco+/PnHaUwnTubVlUWleEjSe4KU
 JQ9r6QgWn8GKfqr8FBO9H5VZoCgzCXcOqbkNur0z+KpnNUo951aA/jICc+zzXMc7dD7J
 en0h6guInFCYBPkUuAbI0CAZ4F0d8mDXogkzhkTLvbns7jWItElucLtklAXj3IjZy2i7
 zPVUOvR/D2g1VytLzisYtMbSeEET+mOmCfiRcYRZWoCxipbQiqbI5A1eVvrZbEU2gotC Yg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb21a5m3k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 22:32:36 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23EMVS90006252;
        Thu, 14 Apr 2022 22:32:35 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2047.outbound.protection.outlook.com [104.47.57.47])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fb0k57gwb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 22:32:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dcQDAIk7MZedVn7FOnMxyUU/iLmCfqDBtcstr2ncJGmUdP9sEjGDb7yxf0y50AB84xdYVbzejfLtUgZte1pcDSrkNuglVbPgE8vlDfK2YDQDMcVerlOYhM06PEznDm/t8mWxL5z60PY6mz87Lk+jYoqxi5Yin/IUCGCFZ7SI8VWuNu29W9WCpiI6us5dRahsWRPweyW0YkLGDoqSCvfVG342RZdNYw8a7HIJGe8TmEaz4/Iyr2O80oUMCmj0AbPwbspea6i9B6Rjb5tN6EQTdseZSP1rsyf9W1cj7iPwMqbSaDRQ4yVB+tDOyhYacmwkK795IPJIYC5l0LgB5V8r8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xxcmCSZjfrMsLYX8wYqOQ4uxYSRtRJqoiCKoWY2kNFs=;
 b=Hhwlcl1EXQWt8i8ulmkRJ85UAXMuqelihI5uuz4voOoAxJXogwyZa+F0kdt0o4EZ/8ghv7plb0RIdMIO0aoNWpLwV3rpMxQ0yZJh/wsawfDoxuURhfjD/Ckq7TfxcA6B1m/kgwRlO0CwRr4mDSNKdb2vhNVI2O72w3GlXrq+Ti8yRucPEY/yzKVQzQNddlXgTFrIzncLv4uYPOsY9Bres1W2TJzT1lv3ggf6jbNMaHadqHO2rYsEOZ6UPcyqjc94JLHfoPd9FlSDgwTMFwTw36JOoHEkXbtoHb3CkpkOXdn3RjEWVitvm7UdZEYzZEoaL66kHZVlcIlCGcbJov2/Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xxcmCSZjfrMsLYX8wYqOQ4uxYSRtRJqoiCKoWY2kNFs=;
 b=BTCL8oEvUuPs/IM9m2jEFFzgUdfnpWV3sbxJNl8RtCs0rGM7A9Jb6GGME5PQYVuQRpWW4LaPvVAzlAaH5tHkE451+XFn18SwxWeRrnv1MAMujKFVi/cqyhtb88dGQuUPhSFvpkISsckh0vjIecdJSFB3Jisu5MmUU79RQucpHPA=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by MN2PR10MB3757.namprd10.prod.outlook.com (2603:10b6:208:182::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Thu, 14 Apr
 2022 22:32:32 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::65fa:78de:f4d:1a5c]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::65fa:78de:f4d:1a5c%3]) with mapi id 15.20.5144.030; Thu, 14 Apr 2022
 22:32:32 +0000
Message-ID: <ab1145d9-acca-4c2b-deb7-e954a174e15a@oracle.com>
Date:   Thu, 14 Apr 2022 17:32:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v7 7/8] x86/crash: Add x86 crash hotplug support for
 kexec_file_load
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20220413164237.20845-1-eric.devolder@oracle.com>
 <20220413164237.20845-8-eric.devolder@oracle.com>
 <YleMbVq5XcSX+mWZ@MiWiFi-R3L-srv>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <YleMbVq5XcSX+mWZ@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR06CA0098.namprd06.prod.outlook.com
 (2603:10b6:5:336::31) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30643b88-226b-4e60-d388-08da1e66aa9d
X-MS-TrafficTypeDiagnostic: MN2PR10MB3757:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB3757F53400BD4B2C715DC58097EF9@MN2PR10MB3757.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6+mPEhq/NDg7bEbqbT+F0ptHK1+GX0ozFwnsm7xcnapq1h6sQqL2unNOF7CoGzrYWATdL+7TaJ6Y2CBsy/jZq07ktOTMAzD4abon0lL3qzvY/sKktU2fYv9HNW8h9NR2USoBXms0lVWBk+i/01HvobPHlTJ19tz2Q3yTiCLYnxqeyLWSsUgRx632wbCHLtwmy1C2o+CvR16pb0xkVO2UbtHUxy6iiSQmpEyxF2PV12r5C86VHDrYvGJmkRJW5xo9vUmPX7HmUJF++9XahXPYy3ffBbRl1cUli/uNVrSc/YT/BgmnB8RMNx8/VQssOzcflPGCKvUqkw+iQ/7nM3Bcq4/Z5mp2cMrmOsQfj06SfbOD6e6wyO8sO7atTYMF+Ry7rdDtU5xFC2f3Oc1vf1G21fZ7NNiPB3FrpI5ePyKSsNEHiByRYen+VUaw7L4WrV21dRUITTkeM5UtiRTHxftx1nEkW0gddi07NwRYUDMwFROWy0ASYzRiW2AqO9cQ8shSrBrMnfPH6NGhvQA6yX34rUkIr9RzYLTxdXNJsfNBHvNmc9a8UxoDyYVqq14mz29zwSnnqrKYokxMb7zaHxGmdEbm11JLDaQkr5WiBlNaI5ClC19oBQuo8zJC4FheXi43sWYHjiYkTuRi6+AmB+0nytqOfqTSyEbUXnFY+2kAZV7ERYFfTHqjrqglAP62JSLhTivxU6mHUvZFOcVhqexXmGvhWn6vVo8aMjqkMSJ2JDHrBafi6B2qN0QQD4sw1MGL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(2616005)(36756003)(316002)(7416002)(53546011)(186003)(6916009)(107886003)(66556008)(38100700002)(66946007)(66476007)(83380400001)(31686004)(5660300002)(6506007)(6666004)(2906002)(8676002)(4326008)(31696002)(6486002)(86362001)(8936002)(508600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTVjYXhwVCsvbGcwVGV1dVhiSVZFQUtncTNyRjIydTVJWVRnRkMra3NuNXA0?=
 =?utf-8?B?ZzI1UmQrdzlyaEVoS3N1aXJ3cmMzdUdUUHZYcE00dXhZQ0c0TlpSYVRuYW1p?=
 =?utf-8?B?QWpIRzZjZTREUDN1Y2hycUo5STZ1Szh5R3NOUTVWZFk2REdBL205bUQ5bm1P?=
 =?utf-8?B?RkNQQlc1TWp2aitMWlFHcVUvcGIwRzlmdm41ckdKWHlDblBubTNYK0xndEl5?=
 =?utf-8?B?OW5BYWJhc1dQbE85cCtwU1NOR2pWdlZsYXBZWUV6bFdJS1NBdGdNWjNuNkNj?=
 =?utf-8?B?ckduSmtyUWhUd2NVb2xXcDlDWE1yVFlPbWxkQm1kaEZZYkpaSVpmVWJNaldz?=
 =?utf-8?B?K05aUXMwYm1sS0xFQUk0OFJVOEpnMmpOT0t0OVNybTBZUDhZTzBaYnVKaUQ5?=
 =?utf-8?B?VlFMWDBLUEMxQjFqN0VNRGh4R1pxS2NtZjlObkkwT1h3YXA1ck9vWlF2cmtJ?=
 =?utf-8?B?U1NYMEF5RDM2dHAxdFhRd09YZEV4UVcwbURQWVVZR3M1aFlGTXFtc3VpeFdh?=
 =?utf-8?B?Ynd2WDgvai9UQnhsLzJjOVhraXRHOWZVMjhrUUZSSU01aGs1NC9rSUUwUDRK?=
 =?utf-8?B?dFhsYSttUkI0TUJDZHh5Wnh2UHB4YjdXV21IRE1XTGNwa1kwSS9iZVR3OUhB?=
 =?utf-8?B?NCtRUEtuQkd5UVE3bWZyekRDZHVWQmF0TDVpYUJ6Wk4yWmZOTmJCS05IQ0t3?=
 =?utf-8?B?bHpEWlZNU3R6RGozZXQvb0ZpN2k1WTdROGFHOUgzUFdhZzhRMitsdmdvaGVj?=
 =?utf-8?B?Z2JZOE9TbnZuWUEyRytDbGJRZEdTVTBHTXlqRitQcnkyRGMxZTRZdmVqV2hV?=
 =?utf-8?B?ZTRreWNBbWNPNzN0NXRZdjNkUVBhdHNKdWhnQURyMWpzbFYyWUJDTFdEVDN0?=
 =?utf-8?B?Mm1uVnY4UEVpdWhvZTlmaDhaYmNZV3l6QTdpdTFLUytoalorL1J6NlZWU1J6?=
 =?utf-8?B?L2FXMk5maUJiSU43aTNMRDFrcmJadS9raUtNRDYralB5MGErTWFFM0tpcTY3?=
 =?utf-8?B?YW9VY1pOTnU0Y0lzUVlRTXJyT0NFMktRS29aVEpDZ3d3aTgyV25SSmxGemkz?=
 =?utf-8?B?czY1MXloV284SXRlNVBaTzZYdmVLTWJzbytRcjFGdW4xT0JtMDYzenJtTEFG?=
 =?utf-8?B?alBZSDlNK2dTRExGN0xtcXZ1QUp5d1M3UzlOUnc3Nkx4Mi9zOHYrMmVreEt2?=
 =?utf-8?B?WTlkK1pEYlNDbktnRXJhSGRadlRjQ0dlRXpyejlEL1dIRzBhV0lrTnJKaWox?=
 =?utf-8?B?Ty95R3dsSFdzWWRYZk9ReDAzTDFxTUNES0Zod1BXM2xhRjdNL2hxejdHeHhI?=
 =?utf-8?B?Mjc5V01qUExXbmZKNXpDa24raWZTOE5ZR3lWcFJaL0l0STJqdnlFMlorM0Rj?=
 =?utf-8?B?WkJDU3ZvbHFUS2dkUEhDMFhpSTVSb3NDR2kvcERBK2UyVWo3M2todkt1RDRx?=
 =?utf-8?B?bWxsRGhFcjhIbkV1QmJHM2FkeEhWQXB5UjJORU5BMU5pV2NydkJOeXVBKzE5?=
 =?utf-8?B?MXg1ZWhkQWMrT25Dd0hWWk5OeWI3blZOR2N2MGJVWjQyZk5NeTd4TUtvRlEz?=
 =?utf-8?B?WTUxbXJTaXpnTXplT1ZmY24yekpZN25HSndJY3FwclN5dWFRS0dJdFpzZ2xv?=
 =?utf-8?B?bm1mU1l4VzlHYzVQQU9IVDVxcUp6UGdybXNaZjdUKy8xQzB1bDhaaVFteHAw?=
 =?utf-8?B?a2ljbzB1ZEFFSkF5SEt3bDZrTTFDM0MvVm5mamh4RGJUWDZ0Sy9mdm90Z2tr?=
 =?utf-8?B?Ylc5RTVjQkJXUTVCM0FoSWZHNytxWHJJemdJR2MxRDBieWtMamNvRksxQ3hC?=
 =?utf-8?B?WUVPejZLMWJWNGtia3Evd3pNbmVyNDNyRk9tS1krSmNoUFhSMFlGeWdzUGJR?=
 =?utf-8?B?SlV3VCt1eHkraFRPMmUwSnJZTzNEWG5qN2liZllRWlFWSFJwQytrRjI5czFm?=
 =?utf-8?B?eHdWemlsMWtudzRLVE1BSjNoeU9iNE1tQzZFNEE3alBmNnN4UTAvbndpcDNw?=
 =?utf-8?B?NVc1K2VKb3FEQ2p4Q3lFaUp6YWhpa0U3YjhyVjF4SlEzM0Njbks3cXVkT1Bj?=
 =?utf-8?B?TGZYS3drMjNLQU9nRnI3alBsazFZRXlCa0hieG9NTDRnSUlXbGs5WTkwVllN?=
 =?utf-8?B?dlBZWk0zV3o3TWJvbUtrWk1MNmZ5OG9YUnUyclpzWFhINUhvOFRzekFXOW4y?=
 =?utf-8?B?YUt4N1M4QmRtdENCcHh6b0IvMGU0aVcrVGx1OFpZTXd0RlJpcnk1K2J6R0Q3?=
 =?utf-8?B?WjYvUUNOallxN3JmQ2RZYTlDRHJESlpQUjgwK3g2dEp4M29NTHJWU2RyR0lp?=
 =?utf-8?B?NEV6UGVmMUt0bVY3dEdlK2Y3ZnU1UWJ5Njl0OFU0MlZwQmRjNHBqRU0vTzRM?=
 =?utf-8?Q?/hrycvd8UJW/zCdI8N7Igl/C19gg6nwk/5un+N3p3RvIv?=
X-MS-Exchange-AntiSpam-MessageData-1: wwjCxBgZ3eFw0w==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30643b88-226b-4e60-d388-08da1e66aa9d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 22:32:32.5876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cghNj0DR7gTZmUOawk0x2J+jl4o+8stgAH2npu9I2M+OozA5+lNeja4SZ6hPZnAmiFtAgtSfiOA2qRnIYM5z8LacfY6ReqME3v5jYHTlIBU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3757
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-14_07:2022-04-14,2022-04-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 mlxscore=0
 bulkscore=0 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204140117
X-Proofpoint-GUID: UGkdOONnt2saI7cITwD_XeroiZjU1aQw
X-Proofpoint-ORIG-GUID: UGkdOONnt2saI7cITwD_XeroiZjU1aQw
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/13/22 21:52, Baoquan He wrote:
> On 04/13/22 at 12:42pm, Eric DeVolder wrote:
>> For x86_64, when CPU or memory is hot un/plugged, the crash
>> elfcorehdr, which describes the CPUs and memory in the system,
>> must also be updated.
>>
>> To update the elfcorehdr for x86_64, a new elfcorehdr must be
>> generated from the available CPUs and memory. The new elfcorehdr
>> is prepared into a buffer, and then installed over the top of
>> the existing elfcorehdr.
>>
>> In the patch 'kexec: exclude elfcorehdr from the segment digest'
>> the need to update purgatory due to the change in elfcorehdr was
>> eliminated.  As a result, no changes to purgatory or boot_params
>> (as the elfcorehdr= kernel command line parameter pointer
>> remains unchanged and correct) are needed, just elfcorehdr.
>>
>> To accommodate a growing number of resources via hotplug, the
>> elfcorehdr segment must be sufficiently large enough to accommodate
>> changes, see the CRASH_HOTPLUG_ELFCOREHDR_SZ configure item.
>>
>> With this change, crash hotplug for kexec_file_load syscall
>> is supported. When loading the crash kernel via kexec_file_load,
>> the elfcorehdr is identified at load time in crash_load_segments().
>>
>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
>> ---
>>   arch/x86/kernel/crash.c | 117 ++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 117 insertions(+)
>>
>> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
>> index 9db41cce8d97..47adf69c9f71 100644
>> --- a/arch/x86/kernel/crash.c
>> +++ b/arch/x86/kernel/crash.c
>> @@ -25,6 +25,7 @@
>>   #include <linux/slab.h>
>>   #include <linux/vmalloc.h>
>>   #include <linux/memblock.h>
>> +#include <linux/highmem.h>
>>   
>>   #include <asm/processor.h>
>>   #include <asm/hardirq.h>
>> @@ -398,7 +399,17 @@ int crash_load_segments(struct kimage *image)
>>   	image->elf_headers = kbuf.buffer;
>>   	image->elf_headers_sz = kbuf.bufsz;
>>   
>> +#ifdef CONFIG_CRASH_HOTPLUG
>> +	/* Ensure elfcorehdr segment large enough for hotplug changes */
>> +	kbuf.memsz = CONFIG_CRASH_HOTPLUG_ELFCOREHDR_SZ;
>> +	/* For marking as usable to crash kernel */
>> +	image->elf_headers_sz = kbuf.memsz;
>> +	/* Record the index of the elfcorehdr segment */
>> +	image->elfcorehdr_index = image->nr_segments;
>> +	image->elfcorehdr_index_valid = true;
>> +#else
>>   	kbuf.memsz = kbuf.bufsz;
>> +#endif
>>   	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
>>   	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>>   	ret = kexec_add_buffer(&kbuf);
>> @@ -413,3 +424,109 @@ int crash_load_segments(struct kimage *image)
>>   	return ret;
>>   }
>>   #endif /* CONFIG_KEXEC_FILE */
>> +
>> +#ifdef CONFIG_CRASH_HOTPLUG
>> +static void *map_crash_pages(unsigned long paddr, unsigned long size)
>> +{
>> +	/*
>> +	 * NOTE: The addresses and sizes passed to this routine have
>> +	 * already been fully aligned on page boundaries. There is no
>> +	 * need for massaging the address or size.
>> +	 */
>> +	void *ptr = NULL;
>> +
>> +	/* NOTE: requires arch_kexec_[un]protect_crashkres() for write access */
>> +	if (size > 0) {
>> +		struct page *page = pfn_to_page(paddr >> PAGE_SHIFT);
>> +
>> +		ptr = kmap(page);
>> +	}
>> +
>> +	return ptr;
>> +}
>> +
>> +static void unmap_crash_pages(void **ptr)
>> +{
>> +	if (ptr) {
>> +		if (*ptr)
>> +			kunmap(*ptr);
>> +		*ptr = NULL;
>> +	}
>> +}
>> +
>> +/**
>> + * arch_crash_hotplug_handler() - Handle hotplug elfcorehdr changes
>> + * @image: the active struct kimage
>> + * @hp_action: the hot un/plug action being handled
>> + * @cpu: when hp_action is KEXEC_CRASH_HP_ADD|REMOVE_CPU, the affected cpu
>> + *
>> + * To accurately reflect hot un/plug changes, the elfcorehdr (which
>> + * is passed to the crash kernel via the elfcorehdr= parameter)
>> + * must be updated with the new list of CPUs and memories. The new
>> + * elfcorehdr is prepared in a kernel buffer, and then it is
>> + * written on top of the existing/old elfcorehdr.
>> + *
>> + * For hotplug changes to elfcorehdr to work, two conditions are
>> + * needed:
>> + * First, the segment containing the elfcorehdr must be large enough
>> + * to permit a growing number of resources. See
>> + * CONFIG_CRASH_HOTPLUG_ELFCOREHDR_SZ.
>> + * Second, purgatory must explicitly exclude the elfcorehdr from the
>> + * list of segments it checks (since the elfcorehdr changes and thus
>> + * would require an update to purgatory itself to update the digest).
>> + *
>> + */
>> +void arch_crash_hotplug_handler(struct kimage *image,
>> +	unsigned int hp_action, unsigned int cpu)
> 
> We have stored the necessary information into kimage, e.g image->hotplug_event,
> image->offlinecpu, do we still need to pass down the hp_action and cpu
> in arch_crash_hotplug_handler()? Do you foresee it will be used in other
> architectures?

Sourabh Jain's work with PPC is using in fact using hp_action and checking its value.
eric

> 
>> +{
>> +	struct kexec_segment *ksegment;
>> +	unsigned char *ptr = NULL;
>> +	unsigned long elfsz = 0;
>> +	void *elfbuf = NULL;
>> +	unsigned long mem, memsz;
>> +
>> +	if (!image->elfcorehdr_index_valid) {
>> +		pr_err("crash hp: unable to locate elfcorehdr segment");
>> +		goto out;
>> +	}
>> +
>> +	ksegment = &image->segment[image->elfcorehdr_index];
>> +	mem = ksegment->mem;
>> +	memsz = ksegment->memsz;
>> +
>> +	/*
>> +	 * Create the new elfcorehdr reflecting the changes to CPU and/or
>> +	 * memory resources.
>> +	 */
>> +	if (prepare_elf_headers(image, &elfbuf, &elfsz)) {
>> +		pr_err("crash hp: unable to prepare elfcore headers");
>> +		goto out;
>> +	}
>> +	if (elfsz > memsz) {
>> +		pr_err("crash hp: update elfcorehdr elfsz %lu > memsz %lu",
>> +			elfsz, memsz);
>> +		goto out;
>> +	}
>> +
>> +	/*
>> +	 * At this point, we are all but assured of success.
>> +	 * Copy new elfcorehdr into destination.
>> +	 */
>> +	ptr = map_crash_pages(mem, memsz);
>> +	if (ptr) {
>> +		/*
>> +		 * Temporarily invalidate the crash image while the
>> +		 * elfcorehdr is updated.
>> +		 */
>> +		xchg(&kexec_crash_image, NULL);
>> +		memcpy_flushcache((void *)ptr, elfbuf, elfsz);
>> +		xchg(&kexec_crash_image, image);
>> +	}
>> +	unmap_crash_pages((void **)&ptr);
>> +	pr_debug("crash hp: re-loaded elfcorehdr at 0x%lx\n", mem);
>> +
>> +out:
>> +	if (elfbuf)
>> +		vfree(elfbuf);
>> +}
>> +#endif /* CONFIG_CRASH_HOTPLUG */
>> -- 
>> 2.27.0
>>
> 
