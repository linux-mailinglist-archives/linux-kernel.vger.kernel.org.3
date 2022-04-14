Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00755017D9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238499AbiDNPvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 11:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356631AbiDNPlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 11:41:09 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80665E41E5;
        Thu, 14 Apr 2022 08:22:43 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23EDL603028053;
        Thu, 14 Apr 2022 15:22:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=xZHqCmDLgsjS/TmZy8wfUv0qHIJOO9LZg0ZS2oSiJuE=;
 b=FTAFPBcHIcn4aXOXcHgKg8FkKOh6eb1n+V6fTtIJB5RPPT5SGbo8mdBe/DlS3ek+Dk37
 42EMhrkMDAEw81/QFsxKVTlPWjzF0U6LlJ/aGz2qskYuiAUzWc/1qT/QIzvWQPl0rzz1
 BbM9tGdSx1+VqNu2F1qrxDJrL7/Zfvq8LJ5g7bagHk25pKZMIWp5dP7ABUymZdOb4Yqo
 pKP1D4QXDdCq1udxI9fOWpunp7r+eZr26P7tOjArr/sBA2aMoqgl7PMwKj8TTT9gRYW0
 egZG17HCMksztv4ro+gj0stky9gyDhai/CGEUdpgC7Q/Q0Y9inQI05UWfGpRtRJePyKn fQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb21a4p07-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 15:22:28 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23EFEUnT020441;
        Thu, 14 Apr 2022 15:22:26 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fck152m5m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 15:22:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V9MN2bEDm7uomMKEAXEwdguq+DAcs+DSX/Ta5leq4zIB7J0Z0oaMV8FWxByg6zhvEH1GEjrfuu3a93wxNnVdiDzV585zfM5I9HNgC0VkOWHKR0NBek5mouMg23EACtYlcuK6P2vVqme00G4LxsMVFS8xpOhtMF9zv+Nxt6Vn76r0hdcLZ7uS8rz2jt1RYe49Rxf5mAnlrO9+nD8T6RfxSZLHndmWHY90XczsCKREHOcgTw1TMo83Ie4Y/DQVsCekPdlphdX/l+tFNV0d3b9/p1zq2Rn0Vb5t8m8tbQ/XiS9atbWAL4/GgxHHCpn82PhMiiuLaLMOLde9FcESBWbQUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xZHqCmDLgsjS/TmZy8wfUv0qHIJOO9LZg0ZS2oSiJuE=;
 b=GTgyJJ98wQYdzowPAIS9NHNVivOi8Fy9BAoQzXVbz36kDm3EOJURhZOpZtdUIEEuXMBK/xZGmxa4bAEP8hDpI3GBcUX2C8USXdpZqEtRv0EZdCEa5v/wXpRWqkG3AhhR+aR85blnNqYv7VjHsBt6LUp1lT85O3bfoEPGeWYzPoF4TWUG7AN6DZ9cls5GyUGsYdj+WvUhiEB6zUg7S1f8JkdAVohWaAkQ6bE3+7b2xUd5ssoKCThii+nSJEhPJY5Nxpejn3B+kgAOl+zccI8qCrUbFiPQkhZn4FvHYYHrIgCpK/ilFv1thUQ3A73IVw+7g+pVoWw5ZaJJAbhvJni/xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xZHqCmDLgsjS/TmZy8wfUv0qHIJOO9LZg0ZS2oSiJuE=;
 b=Wc3TkVnpW7ASZWXrpk+1uYN0PcM+elC/11F1d2QUsN033hquqsn0RIgg9dB84J9RPLDCWH45pOarkKUd7QTUDxtJa22DOHQ1m6QyHsXgJeiN//gMLF7GOYp6LijpBrS0E/v6wo+qB7MFqkGnv/GHgBbTVV0GNci7OI726vn/3/g=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 MW4PR10MB5774.namprd10.prod.outlook.com (2603:10b6:303:18e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Thu, 14 Apr
 2022 15:22:24 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::3cb2:a04:baff:8586]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::3cb2:a04:baff:8586%2]) with mapi id 15.20.5144.029; Thu, 14 Apr 2022
 15:22:24 +0000
Message-ID: <137ec5f5-dbdc-99f0-e9b7-deeef5001a01@oracle.com>
Date:   Thu, 14 Apr 2022 10:22:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 1/2] scsi: iscsi: introduce session UNBOUND state to avoid
 multiple unbind event
Content-Language: en-US
To:     Wenchao Hao <haowenchao@huawei.com>, Lee Duncan <lduncan@suse.com>,
        Chris Leech <cleech@redhat.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        open-iscsi@googlegroups.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linfeilong@huawei.com
References: <20220414014947.4168447-1-haowenchao@huawei.com>
 <20220414014947.4168447-2-haowenchao@huawei.com>
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20220414014947.4168447-2-haowenchao@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR07CA0091.namprd07.prod.outlook.com
 (2603:10b6:4:ae::20) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5311dfce-87c0-45d1-bd57-08da1e2a9382
X-MS-TrafficTypeDiagnostic: MW4PR10MB5774:EE_
X-Microsoft-Antispam-PRVS: <MW4PR10MB5774F83EB647E881D378DA4BF1EF9@MW4PR10MB5774.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KF06z1XjsOOh8J62TVi8Fr8RNiaVhH0PvgenbcB6uwXm8gVUhQ+DnF7vxITQZzf/fh6SSRg+C+FDe5QbKWUziWTTNtwwytATk87f9dNoK4F66E9kXpxDk7Bmnzgq3v0mwy93R5qrJpUbSIiD2CsjT24FcCe8DnfHk9bLF6mtXO35DAYuZNyz9gvYhQj1KxjrGCtSLdQ7xKqgQzpz2FlMw+hCKrZ+qBWYS9/iU4LLdvpsWxH1mxn9v3U++DWsNW53hM+pvconl6hkYPRLJd4w68OXEJ+HT2XnklKh8wLYLI4pOTBtrOViE7uWGsQY+OlL1olpEribkNKfsdsHLfNvdI5ui7RC6lIdgc9eNRL09OKIcGOD7yw51NckvptsIiWUFC35NFgSdfhE9g4cxuBsMDq/ym8/Be7RgGkFHyzupYci0vVZB+LFbOdHjgzDBd/27wLZso3x4dy11t+rNY3uVoUy6SLkulSAWAa1CUXU9lj1hRxX9PlCEFTkWHAjE6PwC6CLAoDG0u4DeAaI7sW584q7tC6rGMBKYFLouPJaOqW3GaR1q1Cpj9weJrdcA0/Uy5pWHV2P7JAtxWYG/zlW5T+6+/ef7hiJWdl6JlaKbM/WLdbKHHRZgSLrfUuc53hx2g1fGUlkg9YTqtBwCYHNYjRe77lnfoLjIFesRhS9boF2TMW1aH6CXiW2H4E+9r7MWEmFtHe/co0XRi+Dti7UdqMoBbUBifyPyunTSOi72dCt1P1mMFIzYneIvIeKMER8QRyhKdFQJ5oXQEDoBXVwf9xHvLwwSHD1gFtdhnNVWwMJVz6Ntl9mPutWCEkNkZVW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(186003)(8676002)(4326008)(2616005)(31686004)(66476007)(26005)(6512007)(36756003)(2906002)(6486002)(5660300002)(508600001)(8936002)(316002)(83380400001)(110136005)(86362001)(66556008)(31696002)(6506007)(66946007)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3BPUDUvY2Z5YkRDVVhzaVVwTGcyMnlkN2w1OTdLVDE0NWt4YTk3Vk5vU21j?=
 =?utf-8?B?c0lCUWZrN3djWlRGWmVPdXJoa05jckZ4bnJhZnBmSEJMcmp0TmRkb2g4YzJB?=
 =?utf-8?B?MVNWY0F6WEtRWGNwR1VoTXJuMmhxT0U0MmpMZjFXb3RPUXZ2SnZuN1hva25T?=
 =?utf-8?B?b0xQSDYvbzV2bWlBUTJMczI2K0ZvNnJzbElHaDlPMnc5bm95N2NydWVKRVU1?=
 =?utf-8?B?d1lIRWp5eHRpYVZQdWI3eWpxOWhZU0NZWnk0MVI3c3p5WGpkVVI3Y0tTdXJE?=
 =?utf-8?B?SFoycGFnZ3NPS2tQOVp5b0hjSnQ5bXNjUTJobVU1NVQydFFyVmUwRjFHc0g3?=
 =?utf-8?B?KzFFRVZLaVFGZGtXM3pMTkc5VVVuZTQ4eTVtRVZGTUlXTGtlRHRnc2RYbmEy?=
 =?utf-8?B?a1B3eVJnSENtaXMrcjdtd24wcEZKMFZiRFBrU1I1ODhPQndRR2RNSGE4YVVI?=
 =?utf-8?B?TGJSd2wwb1F0OFg2dU9MZ1pMOFU5TmwrR25GeU9GRVQ1WTBGRk8vQ0pmdE9v?=
 =?utf-8?B?MnpBazNqUEhuWVE2N3M3QTdDd2tmUVJLdGlCZ0Q2aHdKdVdqT0p3MHVvMjFl?=
 =?utf-8?B?UXFWVnVTV1A5TW1ER0FnaVFtNWYxd285QWxCNDlsK3dYNnpPMEpyekNDK09Q?=
 =?utf-8?B?TXQ3TjZaWXBFRWk4SEZlQVZJNm83TWp6SzBhaExKNG9OUUY5RzM0NnlsZ2N3?=
 =?utf-8?B?TGRMb0E2ZlJpV2JlWkUwR00zSUxHMEpPN3BMbW5FeDBEM1kyT0c4aE9USFJK?=
 =?utf-8?B?VWkyYVk5WExORFpoRU5jcU52SmxNbkJxdFJBaWFXaktIMWNNM3k4b2EyOU52?=
 =?utf-8?B?RE1XeVdNS0xIUUZoSkhESzRHRkozTWI1NUJWWjlvZ2ZvRWhhNmZtTUE1Mk84?=
 =?utf-8?B?c1ZZSXVvZURpcWhENE91Y0Q2TkVTaG93TDNwQys3Rm93M1lIK0ZBQTdMQmJj?=
 =?utf-8?B?Rk1sV1JNWjN1UFd1Z2xMd05uUk1YcHZ1emg3aE0vNlN4VHdBVE9qTXN4cUVH?=
 =?utf-8?B?M1FSSzNYRDZubDJibVJmelJBcmpsQjJ2eW9NcHlLOXFrUVZGQmFNMW5DZ2Nq?=
 =?utf-8?B?U1U2YXlPaWZkWmpUTVRUTGpSY0U2eTZIOGEzKy9RWHkreU9YY3dQNGVjQ29t?=
 =?utf-8?B?NzN0UnNPcDhjZ3BMeDRPeGl4VnB2WTQ2dzM3aTlSY3EwUmYwZlpGMFphcmt0?=
 =?utf-8?B?aFFwV29pM3NYd0ZaUlJGWVNhS21RMjNDNU1ZdDhIOGFGY0ZkQy94QTc0OEFR?=
 =?utf-8?B?VnQwd1hGNnB2aWVqV2tuZm0wZFJTUmlxajlKWDRsMUhzWFlsMWVZVzZJRkhi?=
 =?utf-8?B?RW8zcll5MXM2T0ZHeWwyUWNyVUJoaXN6OGhLV0h2alVzaWhuZTZYWHdST1VG?=
 =?utf-8?B?NkpnM294MEx2MTRseGNpZitUT09WbXE0SXE4TC94S1o3K2o5UU9QdElZdmR1?=
 =?utf-8?B?N2lwMVcrVnRMUDB1N0VOMk1WOHdFTnk2MWZ5bHJKVmV4Q3F0QlZHbjZOOHV4?=
 =?utf-8?B?b1VXNGJrZ25CTWl5SmpvYmszenJLdzh5eEFxSFd0Q1NmRisybDNCdmwrRmZE?=
 =?utf-8?B?OGE1WjFVU3ZraTROclpTV05kTlkvQjhKRWU3aDRILy9zWERzVzlWOWc0MXNK?=
 =?utf-8?B?VHJ5dUdtalhVamxEZEJaUmM5akVxSGpjUDl3ZjYzUWhiRTZRelk1eFRNR0tk?=
 =?utf-8?B?eUxxSUxTaWNnZUVvRUVKWWJRQWE0SUNYS1BSVk8wbzRnbzNUTk1DOHRuRDRM?=
 =?utf-8?B?azEvY3lxTXMwajVMZ3FubWFZU3lQZVZXTTZFVVMvTm1IV2hhM2YyU0ptbDR1?=
 =?utf-8?B?OE9mK1Z4RGNUL05xaUJPcEJiS0ZEaFFEaTlOaXlxWVc5RTdSd005aTZvMXdW?=
 =?utf-8?B?NmJxbkhrZVVhZU5abVpXdkRrZEpmTlk5M1Z6bkFJRHJ3ZmZIWm9GV3RDcGtO?=
 =?utf-8?B?UHVVNXFEYnZDbFYvdlBmSmRlUm02dkFhYVhWajF4Vmd1czJmWGh6K1JqMEtj?=
 =?utf-8?B?eWFuVWtUd0dNOTBnUGtTYUZ1UEdEYzNvTnFlSFJhUHo0bUsyaFZwSkFVRFo3?=
 =?utf-8?B?dVRNZHgwSGk4V202eG00eG9QTTA4YkRNRndtV29ITlZiRTJLWjNlb0R4ZG9H?=
 =?utf-8?B?T29FTjhFdGY0OTZIekUxdUVXOWNrZXpIZko5MU1hYTF1SFF5WUd3TFZrM2tG?=
 =?utf-8?B?b3NWRDV5NXhSZEtqY1h0Q3dEeUcraVc2ZHZKbis3V24ycElNZmUvSmw0Ris1?=
 =?utf-8?B?dXZSaElzbnJUNHloY1FUWkkrZlJFZGpqSGtzL2RjemlLQk9vWStXWVQ1MkJI?=
 =?utf-8?B?bUVqbi9GdG1BTTM1K1J6emRjblR0YkNhMWQ1ck4wSTAwa1FkZ0NQQXUzNzJT?=
 =?utf-8?Q?BeUCtMGf54GpYxck=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5311dfce-87c0-45d1-bd57-08da1e2a9382
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 15:22:24.0812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nzXZV/v+wXigGz/eB/MY8jyHeIxBZN3+/iqz5AzuVtiUwjGqD4KOrmDREu2AiGd8euQywkMMu8uxMd16UDLolA2a5yorPy3vlnO9pujGaBE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5774
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-14_04:2022-04-14,2022-04-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204140082
X-Proofpoint-GUID: PP47LRSUrYeNRRi5XAyCub-hcq_H2wS5
X-Proofpoint-ORIG-GUID: PP47LRSUrYeNRRi5XAyCub-hcq_H2wS5
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/13/22 8:49 PM, Wenchao Hao wrote:
> Fix the issue of kernel send multiple ISCSI_KEVENT_UNBIND_SESSION event.
> If session is in UNBOUND state, do not perform unbind operations anymore,
> else unbind session and set session to UNBOUND state.
> 

I don't think we want this to be a state because you can have a session
with no target or it could be partially deleted and it could be in the
logged in or failed state. If scsi-ml is sending SYNC_CACHEs as part of
the target/device removal operation, and we lose the session then we could
go through recovery and the state will go from failed to logged in, and
your new unbound state will have been overwritten.

I think it might be better to have a new sysfs file, target_state, for
this where you could have values like scanning, bound, unbinding, and
unbound, or just a sysfs file, target_bound, that is bool.

> Reference:https://github.com/open-iscsi/open-iscsi/issues/338
> 

You should add a description of the problem in the commit, because that
link might be gone one day.


> Signed-off-by: Wenchao Hao <haowenchao@huawei.com>
> ---
>  drivers/scsi/scsi_transport_iscsi.c | 19 +++++++++++++++++--
>  include/scsi/scsi_transport_iscsi.h |  1 +
>  2 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/scsi_transport_iscsi.c b/drivers/scsi/scsi_transport_iscsi.c
> index 27951ea05dd4..97a9fee02efa 100644
> --- a/drivers/scsi/scsi_transport_iscsi.c
> +++ b/drivers/scsi/scsi_transport_iscsi.c
> @@ -1656,6 +1656,7 @@ static struct {
>  	{ ISCSI_SESSION_LOGGED_IN,	"LOGGED_IN" },
>  	{ ISCSI_SESSION_FAILED,		"FAILED" },
>  	{ ISCSI_SESSION_FREE,		"FREE" },
> +	{ ISCSI_SESSION_UNBOUND,	"UNBOUND" },
>  };
>  
>  static const char *iscsi_session_state_name(int state)
> @@ -1686,6 +1687,9 @@ int iscsi_session_chkready(struct iscsi_cls_session *session)
>  	case ISCSI_SESSION_FREE:
>  		err = DID_TRANSPORT_FAILFAST << 16;
>  		break;
> +	case ISCSI_SESSION_UNBOUND:
> +		err = DID_NO_CONNECT << 16;
> +		break;
>  	default:
>  		err = DID_NO_CONNECT << 16;
>  		break;
> @@ -1838,7 +1842,8 @@ int iscsi_block_scsi_eh(struct scsi_cmnd *cmd)
>  
>  	spin_lock_irqsave(&session->lock, flags);
>  	while (session->state != ISCSI_SESSION_LOGGED_IN) {
> -		if (session->state == ISCSI_SESSION_FREE) {
> +		if ((session->state == ISCSI_SESSION_FREE) ||
> +		    (session->state == ISCSI_SESSION_UNBOUND)) {
>  			ret = FAST_IO_FAIL;
>  			break;
>  		}
> @@ -1869,6 +1874,7 @@ static void session_recovery_timedout(struct work_struct *work)
>  		break;
>  	case ISCSI_SESSION_LOGGED_IN:
>  	case ISCSI_SESSION_FREE:
> +	case ISCSI_SESSION_UNBOUND:
>  		/* we raced with the unblock's flush */
>  		spin_unlock_irqrestore(&session->lock, flags);
>  		return;
> @@ -1957,6 +1963,14 @@ static void __iscsi_unbind_session(struct work_struct *work)
>  	unsigned long flags;
>  	unsigned int target_id;
>  
> +	spin_lock_irqsave(&session->lock, flags);
> +	if (session->state == ISCSI_SESSION_UNBOUND) {
> +		spin_unlock_irqrestore(&session->lock, flags);
> +		return;
> +	}
> +	session->state = ISCSI_SESSION_UNBOUND;
> +	spin_unlock_irqrestore(&session->lock, flags);
> +
>  	ISCSI_DBG_TRANS_SESSION(session, "Unbinding session\n");
>  
>  	/* Prevent new scans and make sure scanning is not in progress */
> @@ -4329,7 +4343,8 @@ store_priv_session_##field(struct device *dev,				\
>  	struct iscsi_cls_session *session =				\
>  		iscsi_dev_to_session(dev->parent);			\
>  	if ((session->state == ISCSI_SESSION_FREE) ||			\
> -	    (session->state == ISCSI_SESSION_FAILED))			\
> +	    (session->state == ISCSI_SESSION_FAILED) ||			\
> +	    (session->state == ISCSI_SESSION_UNBOUND))			\
>  		return -EBUSY;						\
>  	if (strncmp(buf, "off", 3) == 0) {				\
>  		session->field = -1;					\
> diff --git a/include/scsi/scsi_transport_iscsi.h b/include/scsi/scsi_transport_iscsi.h
> index 38e4a67f5922..80149643cbcd 100644
> --- a/include/scsi/scsi_transport_iscsi.h
> +++ b/include/scsi/scsi_transport_iscsi.h
> @@ -232,6 +232,7 @@ enum {
>  	ISCSI_SESSION_LOGGED_IN,
>  	ISCSI_SESSION_FAILED,
>  	ISCSI_SESSION_FREE,
> +	ISCSI_SESSION_UNBOUND,
>  };
>  
>  #define ISCSI_MAX_TARGET -1

