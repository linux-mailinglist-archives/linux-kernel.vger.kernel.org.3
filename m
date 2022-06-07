Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F4353FFB1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 15:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244430AbiFGNKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 09:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244428AbiFGNKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 09:10:01 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43AAC9658;
        Tue,  7 Jun 2022 06:10:00 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 257D4aiC007363;
        Tue, 7 Jun 2022 13:06:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=/YZGX+ay61CsFpDTLPdGPQ5sKy8D1yBQvXqReaoCHKM=;
 b=xPVGwJPqubCz2H9lVN1YsWKJFBVb3+nEpIkm8MxjhbKoItcFYVS9mopZUIYf++Ji1e11
 HKA/Q7MgogCWyMC4pnNZ9qvor7vhJnuLrE97QO64myTjdFVHa0p8Lete9xmKNL408xgO
 qTYjN9pK3t1xzSifzKaYmiv4R0byqHzX1qUQvYrnOewm74dkCUCOyYaobjr4jdU99eEW
 mdiItmrT1Q4ogxq/0MFOjhiwV88PvQe/pM6W+8xSEAqsXybHqofBJZDijWfbTCkeGB+u
 VZfJ539BI9FXfzOnGMMsoWw/JZwpE/L8+28ayg8kMsQhHI/i1K/Nn+ezzwnhIFjoRpiR xQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gfydqnq72-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Jun 2022 13:06:50 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 257CeR0Z018636;
        Tue, 7 Jun 2022 13:06:50 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gfwu2gdw9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Jun 2022 13:06:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dmv3XXd6H2yPunyuAbIl0jOQ2aIU/Xt80If07C2+ThJbu+R64ofhP1MOg9q+X33GxfeVMvS41thf7yOb3eNYDsRDmF7HTK6lBS2/VG3PPw31vsnWubXSGzJPuAASbVV2eP8sG4Nj28sMUaS597mRtsRTxfR3Jz7Nxab5jWGKqF9ovhrMF8kYKYAXxTQ/rNm37eA37YbwqpFoE+oBW1uguiSEgSOdhRsRwN5fvESJOhtGAzZ3towyz5KUJDlshxQUzOJj+0v7CMfrHehRuT1l8JiURp6xL0wXr5haKwEdPvc90bRholmzqMbxf4RWjpcePZd9J+MekIRIulvz7+LtEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/YZGX+ay61CsFpDTLPdGPQ5sKy8D1yBQvXqReaoCHKM=;
 b=dmHKYEv0m/yJG49JEV/nUBlTOyfbD5AjhODtruhm466xpDvr9i9x5Sk0E+QywXmyidtAmKVm+Felnhd3Zndvx3ePA3/J+m2AfdAiWIIwLdjFYlvKpdMay6d8PaxvXnbIwl2Z8r8aq+nQeinzkPB+Nu9eUgyZKmTJOwBbQjL08oRb1vbM3t46CnTqFNn38ykDwnnYmK11we46IEUo/AkJ6PWdYUMk/437MgKAPYeLT6Fu/SbcPglwFGa1LwuEMzRK4eSzUnyU58MNcfa1g3odilz9l3d31oseo5kwCYN2NUBdZNoKQpabqa2SJo8JiN9HyTvTK6Ac0FI2JdRya5EGIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/YZGX+ay61CsFpDTLPdGPQ5sKy8D1yBQvXqReaoCHKM=;
 b=vQTfNjhLhBIRRLo8zs05Oizz5RrZqgGUNXRA4BBEtAEwOWI3AGqGHEXsgyXcyl/xD8Mm3PZPmyFENgXUOq47CIhiSSjDA92YDvRdnuZRrw1ro+W421r8mDEoRd6+m/rgI3WBxMc4FxTisyiuSXQdZsJwJ4ikTeUjysW/6y7mTZQ=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by BN7PR10MB2468.namprd10.prod.outlook.com (2603:10b6:406:c1::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Tue, 7 Jun
 2022 13:06:47 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47:2730:1cb1:bd51]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47:2730:1cb1:bd51%4]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 13:06:47 +0000
Message-ID: <a0728939-0852-57e8-6d4b-8c11c73569bb@oracle.com>
Date:   Tue, 7 Jun 2022 15:06:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] Documentation/security-bugs: overhaul
Content-Language: en-US
To:     Will Deacon <will@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Shah <aams@amazon.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Solar Designer <solar@openwall.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Willy Tarreau <w@1wt.eu>
References: <20220606194850.26122-1-vegard.nossum@oracle.com>
 <20220607090726.GB32282@willie-the-truck>
From:   Vegard Nossum <vegard.nossum@oracle.com>
In-Reply-To: <20220607090726.GB32282@willie-the-truck>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0023.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:19f::10) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9d8599e-3dbd-4438-c3d7-08da488693f5
X-MS-TrafficTypeDiagnostic: BN7PR10MB2468:EE_
X-Microsoft-Antispam-PRVS: <BN7PR10MB24685DACDBE27032B41DB7CA97A59@BN7PR10MB2468.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h7qIAbR8jUrglOtGcKXIRUuOQow6bYuisQnBf1QKk5O2Xh4Ix/dJ3fn+I2/6muRVgm6lsogwoDXoTTUmTUGgnhtQP5YndaNKnk/74wLNEzuvo00z3nZBIM3J3m5XIheUVE4+LMzcps7Bn+5/Hr/ByjC3TiRi2rlYM49Bi2CN1p5G0c61jz+Ti3v3vCg5wwtjUf9m0HXADZVkCJQRGRJ6sK9JvuicsM3p3jG9Uu2azVJOz567sIeCL/ANueQOI/IIfPKGy4Q3GOfTtok6oBdjjRW9/1j29kMRNQzGgS674tyqs+sTRLN7tbSdp1BEtCdPuwP6rpB8TlqHNz926qt9Fqn67uymuAIGi3XzhQiZikKDCgtlm6BbyTlj0GV0wrqfToeoUVEdMae+RGwksro5ul+6BNftCx8cxgsv8X22xfOvX+v9p+uSv2IGVECryKRXRy4yYGslfBJbPzojFuTopax+tUqKPNrSOYlJguMDernv6UZ788dMSP0o4tP0HPFXmwyb2ARhepSOh/4VXiRaybSRO3dv6np50Qs9v+EG/SVcu8RR9UsB7qo5bBsxgLjc5sPMKVMG4z6QqkmbYuR7Fb/CWAj/ZTulrvhDDtom6zac8jzC0eGiOmpPg8BnMs16cYNR7AYg79C3avWwnOgVUjrTWrVwWdwOBLyhlcfdcOaDgfflyDQs4j8gBOCVGBRMRVn0lfxcR7OufiXILULGU17loCUxkYWFSKp5ZkHZV0cIpt6LnZyvjeStq4hiW717flDQs+Cmw6C2iivbv6uGiA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(31696002)(6916009)(2906002)(316002)(54906003)(6666004)(66946007)(8676002)(4326008)(53546011)(186003)(44832011)(66556008)(66476007)(2616005)(15650500001)(7416002)(6506007)(26005)(508600001)(52116002)(6486002)(86362001)(38100700002)(38350700002)(83380400001)(5660300002)(8936002)(31686004)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bU1Mdy8vYVpTYVhwRFdDSVpteFR3bEVMQzNVc1dMQWFUZllOcThLOVlwUno2?=
 =?utf-8?B?cEZZSEtPQVR4VUs5Rkp4b0pZOUNXWFJFanFlS3ovS0RQdW41R2lqdGdRbzdN?=
 =?utf-8?B?RHgrODdnVTlPcXZpalVpN3ZVbXVtQkdqM3A3Um1IdVFqYTRRNTBYWnBsa01D?=
 =?utf-8?B?OGxpdnA0TXlXNS9Mdm12ZFljMm5INnRGL0NSSUFKcWlmdkdJcU1WQXcrRHZx?=
 =?utf-8?B?V1BVRUZzME1FSWhSTjVzNHhJdTJkcVF2U2R5WFBDeC9iMGMxYUkyUGRGZ2tI?=
 =?utf-8?B?TnhOUjFqUk9yVHhPc1pEM2lVUGM4aEhyRzN6TnF6bWk5eVpYSVRUc1lhNkRp?=
 =?utf-8?B?T3ZnWmZsVkNoQ0phRmFMb2U5R2pIZ29KVnUya3NwdDF6NVk4bnllR3JxWjBH?=
 =?utf-8?B?dXNTemVNUzA0MUpSUk00T3d0MzZIcXdGSWkrSTlFUVNYS1FYWHpOTU5YOW9B?=
 =?utf-8?B?VlpIRHdwaFhZS0hGQm96MHRMeWIwdHlzOUt2UVRlZHlNWXJwWm8wdnlYSlBP?=
 =?utf-8?B?R1FkZWN0bWZBT0dXSHQxZDBsTlhlZ3RJVFdqWkVpOFZFMkpialNtMDZHbjFH?=
 =?utf-8?B?UGRRYkFmSUhoakNBL2xHRTBOQ0EzODB1alRFdVVRSGZNWWFUUmRKOGZHN1Ew?=
 =?utf-8?B?cmpGT1dKWW90Ny9iMmNUdzU3Qkd1QnFKZ2hrN2pCQTg1cGYwUjdIVCtuNWdy?=
 =?utf-8?B?Qm5URUM5RmJUb0owbCszSUhzaXpHSXBBQ0lDRDZhTEpwRzdETnhNMlJEbFR4?=
 =?utf-8?B?U0I0RS8rdk9qbVgzWVNPMzhPdVF6RXg4OW85TlpMZGZyN1Z2SjRGTllvMHpy?=
 =?utf-8?B?K0gvTDhBa051R0srL0JwRlQrMVQ0bnhBTDN6UWZzNU9rK1ZuNHhLWUFuZEJ0?=
 =?utf-8?B?MTBNWE9JNFFBZTQ4UXpmOUpQZ0FhZ1hMM1JGbG9BSXVQUzdHcENJdTZsait4?=
 =?utf-8?B?MTQvaUxYVUdTek1IbElkS0RnNEYxOHV5WEd3NWZ2dE4zd2VtTEdBeVdOck9X?=
 =?utf-8?B?WWtGYzNjUnhaTzNLSHZMVHh3N2JaSHF3bTY5bEtzRTlHM0pSQjZQdFFqeFRP?=
 =?utf-8?B?cmlNdE42YkdTRE1SbFBCYVM3cGpEcVBRRTh4NCtGQ0Z6blhTWjZoRFpTamlz?=
 =?utf-8?B?ZWMzc3BTM0NDMWQxdzJrVEtOOEYxSkpMV1JKcERkTkgvMDF3TWNuVkQzcmRG?=
 =?utf-8?B?T2xOS0I1NGlBWkszcTZvR2xLSnhVcWt3RmN6eEpLc3J3b3FWSnYvT2IxOGhX?=
 =?utf-8?B?R3llVVNVU3grTG92K0NyaTg2TGRqbjRCM0o0L1dqZWxhVkdFYmRZcGdUUUh1?=
 =?utf-8?B?WVJTOElSWnBsTkpCYk9qRUttQWNZaVdTdCswNjkrQkhoTVNBU3ZXTU9UdFBa?=
 =?utf-8?B?My83YUdvZU4zanF0SlhlSVc2V1A4MERrSVgyVFJjaWdHSFozQ3RBVXJReTRw?=
 =?utf-8?B?NTkweEFrcGRValo5K3VlcFl3TlVRci9aNEVxbmhBRHgrWk5ocG9rRmUzeVVT?=
 =?utf-8?B?ODFEdVdIUm1YODh3VU9pMXJoSGl5bkxKak4xalA1RTRkdjNmbmppK2cxOVFl?=
 =?utf-8?B?aWQxTG51SVhlRWFXek91cHVtS3gzNVMyNlhJSEg1dTVmZmlFREl6RDF4OVpu?=
 =?utf-8?B?bGc3cFU3WWZZUytWVTh4clI5clVxa1ZzSXF3bFlaQU9kbWFCWm9nSGZxRnVV?=
 =?utf-8?B?TjZjV0NmZzZKTEZFeFd3Sm9UYmlsbXNUeVNMcWZlSEFXTmROSURxUVlTeUE4?=
 =?utf-8?B?RnBNNXZha3ROQWVRcWdsZldlcjNHK1JMZVNZa1YrN2U3KzB2cFM4YmtPb011?=
 =?utf-8?B?dFNTbG9kRkM5WmVZeG9lcmFJekIrTGZsVU5ZMjY2MXYvcnhSRmp3cU9RckNB?=
 =?utf-8?B?aE4rYWpOQTNtVHZHYWxEMWtvanFsYW1EclpISnkybTVhWDFtWXQ4WjF5M2dL?=
 =?utf-8?B?T0RaZlNKdWpaaDBwcHI3V2krSDFMVnN4bUUzSE9oUVB0Vy85UVpZZm1kTmlj?=
 =?utf-8?B?aGVvMUpmNVNaOGI0MGlNbWdJckZjNXZHQzR0SnF3bFBHWGlNRTVHa29NaE1E?=
 =?utf-8?B?S0o3MURVQXJDU0RRZ3h3STdUSnFqZHBHNUpnOE54Q0FhRlRQUFdWNi9XQ2hw?=
 =?utf-8?B?MnV1RG1uUnpEc3N6Y2Izd2dQZWxobW5XNjMzQndzVFdqMHZISXZrWmNmYXNj?=
 =?utf-8?B?RllwOWtNRHc1cVQ2elN6NjNjUmRGbUtlNFREcnBLWXcrUWVjYStrSS9mc1Bi?=
 =?utf-8?B?UzZldHBmd0JtY21zSEJuaTNUemx3d0t4T0U1a0pnV01JWmRlNWFlMzA4S2FE?=
 =?utf-8?B?bG56Y2JzRnkyQldTQnZkRnlrRkJTVFJKMkttWXZEeFRUN0RETVhiZnJEOE5L?=
 =?utf-8?Q?9NFSwE59rAPjkzUo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9d8599e-3dbd-4438-c3d7-08da488693f5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 13:06:47.6832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JNoYwtGgPRvnsuh/PO1pV96got1fru8C8xJVnLEDuL6Ol0AFJSRT2SoT98vqrtCZPC0naKBB07dGoNNUKzFKycVRh2yV6vmMOMwK0AAwxas=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR10MB2468
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-07_04:2022-06-07,2022-06-07 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 phishscore=0 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206070054
X-Proofpoint-GUID: hcVdzeeiEelmaPg_gsGsHdwax9cNRgOX
X-Proofpoint-ORIG-GUID: hcVdzeeiEelmaPg_gsGsHdwax9cNRgOX
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/22 11:07, Will Deacon wrote:
> On Mon, Jun 06, 2022 at 09:48:50PM +0200, Vegard Nossum wrote:
>> +**Disclosure.** The security list strongly prefers to have patches posted
>> +for review and testing on public mailing lists and and merged into the
> 
> typo: "and and"

Fixed, thanks.

>> +appropriate public git repository as soon as they become available.
>> +However, in exceptional cases, you or an affected party may request that
>> +the patch be withheld for some days; as a rule, the maximum is 7 days.
>> +Only in truly exceptional cases will the security list consider deferring
>> +the publication of a fix beyond this, and the only valid reason for doing
>> +so would be to accommodate the logistics of QA and large scale rollouts
>> +that require release coordination.
> 
> I think there's a semantic change here, and I tend to feel that these sort
> of changes would be much easier to review if the semantic changes were done
> separately from the reformatting or the addition of entirely new sections.
> As it stands, the whole doc is effectively being replaced, but what we
> currently have has been tweaked over the years (often as a result of
> spirited debate) and I'm keen not to open up some of the issues we had
> previously if at all possible.

My goal with the rewrite was to clarify the policy for reporters,
include the updates to linux-distros policy, and turn the document into
more of a step-by-step guide for reporters that corresponds to both what
happens in reality and what the "ideal" flow for a security bug report
is. It's not my intention here to modify the policy itself.

My impression of the current document is that it's a little bit chaotic
and difficult to follow -- perhaps exactly because of tweaking over the
years rather than writing for the reader/reporter.

> Case in point: the new text above removes both the mention of "calendar
> days" which is a useful disambiguation as well as removing the "extension
> to 14 calendar days" which is a useful upper bound. Why are you removing
> these?

"calendar days" -- this got changed just to make it more readable. Maybe
it's just me and my personal experience, but this wording seemed
redundant. Why would "day" default to anything but a calendar day except
in a business setting (which this is not)?

That said, I agree if this has been contentious in the past there is
value in being explicit. My goal was maximum clarity, so if this could
be unclear to anybody then it's better to leave it in -- however, if I
leave it in, then I should also change all other occurrences of the word
"days" to also be "calendar days" so that the reader is not left
wondering why it's specified as calendar days in one place and
unspecified in another.

"extension to 14 calendar days" -- I changed this after comments from
Willy who said too many people took this to mean that 7 days was the
norm and that 14 days was still an acceptable proposal in most cases. I
_think_ (but I'm not sure) that 14 days is not even really the absolute
maximum, depending on the severity of the bug.

In my mind, this document is more for reporters of security issues and
less a formal standard for the security list members and so the "Only in
truly exceptional cases will the security list consider deferring the
publication of a fix beyond this" already covers what happens if
somebody wants or request that the patch be withheld for more than 7
days -- it's basically up to the list members to decide whether to
honour requests beyond the stated maximum.

Any new thoughts with all this in mind..?

> You have also removed use of the term "robust fix", which I think was
> useful. That is, security@ isn't going to post a broken patch to the public
> list just because it's been available for 7 days; that period should only
> begin (if it is even needed) once the fix is ready to go.

Okay, how about changing it like this:

-**Disclosure.** The security list strongly prefers to have patches posted
-for review and testing on public mailing lists and and merged into the
-appropriate public git repository as soon as they become available.
+**Disclosure.** When a robust patch or patchset has been developed, the
+security list strongly prefers to have these posted for review and testing
+on public mailing lists and merged into the appropriate public git
+repository as soon as possible.

It's always possible to go into more detail about what "robust" means
exactly or who makes this decision (and how), but I think brevity does a
lot to keep things readable.

Thanks for the comments.


Vegard
