Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1619C533E4C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 15:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243851AbiEYNwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 09:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242647AbiEYNwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:52:44 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C6F87A3E
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 06:52:40 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24PD3vU6003169;
        Wed, 25 May 2022 13:52:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=x/c4VaN5A+MweU2dDbAR6NNTcGpjiLQ+aznshbF/+OU=;
 b=BSxIlnGeP+WE4lnz4KXIMKyUqxAx+4Wg+v2hUtxRfAdRYji+0v3EFqPBd1GgkhLhp+mW
 kMZ2/J13Vc4imxZd5e7+F6sAb8BjLo7SYzlIpf5O0ftCwb3va6YAgpvk3oKm2Ln0Nd8B
 gvAcw2G264LpIqq1/rorqbw2+6efWuq3lmtMnjBflpENL49ylKFL0p/KQHttehia2Mp8
 oRghaU3OIvD18yET7FIoi3xOcDlV8LQs1jVQJFZLM4TTDVxRpWEy1IcgUCst3G4w0bMV
 plXmbWznbZXq2jTL8Z2m6FFQKb3fCCC4GAhlre64+6uG21oR++T1QmOjrGQkXN+u0yAI Zw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g93tat9a5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 May 2022 13:52:06 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24PDoOdx013573;
        Wed, 25 May 2022 13:52:05 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g93x0jcff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 May 2022 13:52:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UFEVlvRxJU52trTWwyL8QlFvR5LN3IvEX6xT+unKUmJpvfIVg9bqBsQLdufvX4r0hMAc1Cya0FCm06S66c6h5qyet4+h/WBbYl5OyKo+7cREI2L4kurGaDHcjSx8WsECWroo9EBDl7n4CT1UinM7vtAFea+2upLXTpkqE2OhsXqthbO8TpCIln0qq8mxaLt8sb+/WsiUp6TUTLjCRzt8v775Z7aGYtmfp/wunxfvuVi3cCZW8646PsJEVIMI6KlR0jc37m29aOAJy6BtWaPFPnpMvx5fp6udsR1eYTqAEWWOIv4ZBjrz3ebHewsU/RhU3yTlXCZkZb1p7s9sUZXJ0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/c4VaN5A+MweU2dDbAR6NNTcGpjiLQ+aznshbF/+OU=;
 b=hxSCFbrMT60zU63qpgWQRHA8A/Y7sf/lu7WE6DGifnxszjAeqHdlzBwRGXzzMqsrF+QngZvbt4XwIP38nCM5zh2VZPbYHEbetUqLLaJOyDuqb+Yw+iUlL617BaTDZzD/aDF9q6LR0IIwDy/C2ALMzhwglFj9N9taw2wK6HDFLp9N0GFReKH8e8ds6fo3avtv81/9xa0Asz4dlHfeoTO4hwf3pVnviZSD8/WFjAMnXAm1+YYzB9CYoX2sKrkLKwFs97g/GwrVaXP99G0bLoGuGyGyxGIDM19fCzqCr/zHC8vQCeLox3RKhvXL8LKhjoh2KB9OZx+PZYcbDeluEaSqdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/c4VaN5A+MweU2dDbAR6NNTcGpjiLQ+aznshbF/+OU=;
 b=SfpBK3xrRyVj43e/w+9kDFNT1Bq487RiCKwZ6nxvLaeXSEOLerFNVO7XhmwBpKIXxVlJA33r4OHN+D5LjrV56kIodOHUVbKtLLMp4jrGADYKn1kztWpaC7Us9hDsJ8hdWWyP6m8YmQha11y9Kmyxywp1zLAxUXA+KBojslRZqu8=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by BN6PR1001MB2195.namprd10.prod.outlook.com (2603:10b6:405:2f::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.23; Wed, 25 May
 2022 13:52:02 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::bd49:f0ab:b476:860c]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::bd49:f0ab:b476:860c%8]) with mapi id 15.20.5293.013; Wed, 25 May 2022
 13:52:02 +0000
Message-ID: <526d44b2-0120-2d52-aac3-57155a2bf80b@oracle.com>
Date:   Wed, 25 May 2022 08:51:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v8 6/7] x86/crash: Add x86 crash hotplug support for
 kexec_file_load
Content-Language: en-US
To:     Sourabh Jain <sourabhjain@linux.ibm.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20220505184603.1548-1-eric.devolder@oracle.com>
 <20220505184603.1548-7-eric.devolder@oracle.com>
 <60bd09e4-91d6-d81c-3b97-1d5334efe6e7@linux.ibm.com>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <60bd09e4-91d6-d81c-3b97-1d5334efe6e7@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN4PR0501CA0153.namprd05.prod.outlook.com
 (2603:10b6:803:2c::31) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a264585d-d133-4d74-0f3b-08da3e55bebe
X-MS-TrafficTypeDiagnostic: BN6PR1001MB2195:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1001MB2195662D986BC629B671A8BA97D69@BN6PR1001MB2195.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x7Ah40vl4PDqHNaQjf1dy/t11eX3JngwOHYZlt2iLeqAzW+kOrNvAThxX2a3qd+uyB48IE6TBOBXvrpmSShl9rpt7eKYLy8kjttzPcQdDEkUy1+pHAolI0RURB1HRuAvhdtLnTL7gbCeI0hSYpz9U/MlXPVHU72gFa75tD9dpd9BaLDLktrFB7a592Sjnl58YW+5txJ+FzhxLVQSavWhg98wbyq9SNvrtgQEAxVzFvygSux08vov0U2ivBHQsbth70gzrRUlOoNUNwkGyEbI0NeKTa0ajWO/WCXiNOjNl2x4mftxb9M2C/k8CORIujXW+ZRmRaKcvSO5janQiEtv9AzYdVpXDWtonRnllPITbrYzzEF5LM6UNF+KJrDhzyvs/S+Q19GMbU3CFxmcEh+Vr5q/62pbMtAyI0ujCLiH+z/8YX0NW+F8lCkKrPxzADGoUUw/LF8PNuL9Kvlk8YSygR10oxQVsa9oTKJTH75OnxOv2gAiILVYjgYZHQZ+O03q5qqZtX3Sw7xln64jlifc67J70Vbx2EfLHnMXIDLK/6PuY7f53Y0PNYfojXhUDPHi8eEr4+a5YrsR/2paDjB7DSGa6aFim54GSblaRMOyH1Q6q3uqtCQgAqhPf2e7aPiCVXRQmIUZIZ3ps2la21LtzF9W9D5BHqd6vphkm38CMFwaKdP6PN71cPJlfDpYfNp05EDaNF4Sf0x1irMHEx4VFPjkmW1SQUOWllP2orbP+cM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(2616005)(2906002)(36756003)(86362001)(38100700002)(508600001)(83380400001)(6486002)(7416002)(31696002)(8936002)(6512007)(6666004)(6506007)(186003)(31686004)(53546011)(316002)(107886003)(66476007)(66556008)(66946007)(8676002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2lMZEcxUjViTkE1a1NKR1ltam00K1NtUENrSEUrc2R6aStEVk9jemVSZ0xH?=
 =?utf-8?B?Y09ReHBoMDlGN2dtUmlzcnFVZkpKMnByYmNUQ3VlTGhWTEhodTF0c0hPSDJ3?=
 =?utf-8?B?ckFQN0pZalNDSGpHR2lJZE9ZeGFlWkFYMDI1Q2s4SnFveFd2ZHhVeXkvVXlR?=
 =?utf-8?B?R2RGellIUGpia2JFOTg5RWhGRVpFem5pYkU5RkljMEdST1FGZzY5TGFOQVZO?=
 =?utf-8?B?ZGtZalBtbXhSenNJZWZMNGRVRE42RnpxZHZ2ODVVUXRiTE9qejNPTEprSmV3?=
 =?utf-8?B?MWZaYXNnOFJ1aDNQTDU4Z1NHUEZCaHNuY0o2Q1N5b0o1d2dDYWlDbzRvUGhx?=
 =?utf-8?B?aHdReWY3eDlOWHJwYmZyWG1hbmROcWtCZVVNZlVVdDJsODlxT0JpWXVJQ1l1?=
 =?utf-8?B?QTFBMWE0TGkzRFBLanBMVU1VQ1ZXTTZmM1VRNTFJNi9ScHdEN1R5MnR5azFK?=
 =?utf-8?B?dERoNVg3STNXaG90a2wwYitPQjNvVEMzeUtSbWlvaDZaQWZLVk5uYlRSUWkz?=
 =?utf-8?B?VFBxWm94UHhhRnBlVzBDUWRDNllWenhQTnRBTko2Yk5lMUkzak9ZR1NSREdE?=
 =?utf-8?B?eWZyRUthVGlSZlVNU3g2SklScEhlRXVEUjd6eVFVQWxmTE5pT0RDbG12TGpV?=
 =?utf-8?B?b1RsYnd3dmF2TlVNRVFzWWNLUHQ5MWViWjJVRlBEbkJuWC9kaTkxOE5TbVJT?=
 =?utf-8?B?bUJOekFOaWV1Nk1IbjVkZkZhL2RleVJJbkFBdmJuSG5YcFBlclIwaFZmVGpU?=
 =?utf-8?B?dnh6ajZFaHErQUVTYUs3VHBFMS9ZbVYvZ2pma1F0Ny83VXJNcFZUZ2lUVFhL?=
 =?utf-8?B?QVlZN2xHVldaalY4NUpuQ1dEVGVjNjNaRy9YaEZHQU11aVplcnREMGczQzkw?=
 =?utf-8?B?bnkrT1N5TW9sT1pqRXh3MWJrblp1VjNOMU90NFl2WUN6dmNGQU5jOWFXWWY5?=
 =?utf-8?B?MUpkdkYrYStMd3MyOC9Jc2Z4ajBFOW44cUhjQ1g1aVBoai9GbGlxVHllL1pm?=
 =?utf-8?B?N1ZHWTl2UFR4bFZWdDFaZU9vTSt4TXB2WWhOTEozblB6cHpES3ZaYWNFNGJv?=
 =?utf-8?B?cTVrVjc2L202YkxId3FRdDdvL3JwVnRpN2JocnVrdHZOQ0FoK3ZEMWtBb1oy?=
 =?utf-8?B?T1VRczJLdmpKVXFnb25vOGhDRnpydE1YZWVsQUFUV1BpUEt1eFYwZEduVE83?=
 =?utf-8?B?TmcxUEZFWFNsNlhCZkJVcERsWFVnQ2J6V0dYS0U4WDZneVN1Rk9aenBZclRK?=
 =?utf-8?B?cjFMMjlkNXRhT1ZDT1RneDBscW5MNDZIZDFuVWZuWkk3NTBVRG9IbW55MmE0?=
 =?utf-8?B?T2pCMWxERk8xODhaczF3cG56TnpHczZWN2VtUTcvcHNQZUplcXhvQmpRUHhi?=
 =?utf-8?B?Z1JsekNXaHR4MzBrL09CZDcvU0t2TXFtd05OaEpDZ3FHci96SHlZdFZhYTFy?=
 =?utf-8?B?QXhHR3NpbnFjMTN3a3dNcVZGMXYxZEg2RzBZS1BoTjFhRWpnOU9lbFUxVEI3?=
 =?utf-8?B?cTl5eVFKM1NGUjIyK1U2bjIvd1lvTWZLbXpwN1B1d1NCVjl3dGxtMU5QSi9w?=
 =?utf-8?B?elZqNktlZFVDQ0MvQlY3eWNpOXdha0VsRGg0eENEZW8wdWV1dXRIWTU2aENC?=
 =?utf-8?B?dExySVQyaEJ5N2VKQ1NVSmU5TVZacExxVy9KR280b3hOZEREd0xIa1ZIR25V?=
 =?utf-8?B?eWtod1htMXRUTDJPS0NXL2hwUWpMbnJTalBtVzd3Zyt0SktLMm5JSzRhc2Zr?=
 =?utf-8?B?M0pFUmNCbEdzM2hZZ0QwV0E3aU5HcDlxL2sxNURNcUNGU2ZwUWNSVEFwak5r?=
 =?utf-8?B?UzBKUDZhZThYSFEzWFNPRTJpR2dYMFpPUUg5cm4yRnZYWUt5djVUS2RBdE9a?=
 =?utf-8?B?YldZeldRQjNDOU9ZU1Y2TU9FN1NjcHcvZk9BRWRCSlRyZWpwT3N4UTJySVpH?=
 =?utf-8?B?UjRJQUxldm8ySjM4ODB4STU0SmpIcjk0VmJ1T2RwWnd4WEJVaEE0MWRQWHJP?=
 =?utf-8?B?alMxU0plSkhCc2duRGlYbmdHbkMvdjMyWUJNTklkYmRSYUNBS0hHZFdINWQ4?=
 =?utf-8?B?Ykl0ZHhvaVNIb3lMUWxOMzk3cDl6Um4rRmNrRjY5UVBqSzRYQ2tld044YVRw?=
 =?utf-8?B?TVBOOXFZVXFKMTErSHQrQ0tZQWlxZlFyUWlWUFZTMC9ueFE5ZndXOGxOMXVt?=
 =?utf-8?B?SDF4YTNma3FhVUszTklLSzJLQ3lVNm5sNWpjLzdpVnowMllZcHp0Q1NNelV6?=
 =?utf-8?B?aEcyYUVpc2ZKZzRPWUo1VUlLR28vd1VxdUVDSlZiVFQyRCtzWVI4NVc4VGJI?=
 =?utf-8?B?ZmtXaCtJN2JUL0NwaTErdVFWMHlpajNiMUdrRGVEQWpTRXNZVUNxUGphNHpr?=
 =?utf-8?Q?xNaby1QqGj9v06uw2YYfg8tRDyibj/FS2iAsZ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a264585d-d133-4d74-0f3b-08da3e55bebe
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 13:52:02.1958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j6UnPFpDYTx9syTMunM2nyjGzVsoMFS5Gl16xiQLa424/v3ZeX6C21Pr5qcE7hSpQPSg0QxspO2578gButJKeGNctm2fyp2qYGzn+JddjO0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1001MB2195
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-25_04:2022-05-25,2022-05-25 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2205250071
X-Proofpoint-GUID: 8UawQ6ElrM1XZk9xxgzIP6m8sbFBGXCZ
X-Proofpoint-ORIG-GUID: 8UawQ6ElrM1XZk9xxgzIP6m8sbFBGXCZ
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/25/22 00:25, Sourabh Jain wrote:
> Hello Eric,
> 
> On 06/05/22 00:16, Eric DeVolder wrote:
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
>> eliminated.  As a result, no changes to purgatory or boot_params
>> (as the elfcorehdr= kernel command line parameter pointer
>> remains unchanged and correct) are needed, just elfcorehdr.
>>
>> To accommodate a growing number of resources via hotplug, the
>> elfcorehdr segment must be sufficiently large enough to accommodate
>> changes, see the CRASH_MAX_MEMORY_RANGES configure item.
>>
>> With this change, crash hotplug for kexec_file_load syscall
>> is supported. When loading the crash kernel via kexec_file_load,
>> the elfcorehdr is identified at load time in crash_load_segments().
>>
>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
>> ---
>>   arch/x86/Kconfig        |  11 ++++
>>   arch/x86/kernel/crash.c | 117 ++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 128 insertions(+)
>>
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index 4bed3abf444d..bf1201fe6981 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -2072,6 +2072,17 @@ config CRASH_DUMP
>>         (CONFIG_RELOCATABLE=y).
>>         For more details see Documentation/admin-guide/kdump/kdump.rst
>> +config CRASH_MAX_MEMORY_RANGES
>> +    depends on CRASH_DUMP && KEXEC_FILE && (HOTPLUG_CPU || MEMORY_HOTPLUG)
>> +    int
>> +    default 32768
>> +    help
>> +      For the kexec_file_load path, specify the maximum number of
>> +      memory regions, eg. as represented by the 'System RAM' entries
>> +      in /proc/iomem, that the elfcorehdr buffer/segment can accommodate.
>> +      This value is combined with NR_CPUS and multiplied by Elf64_Phdr
>> +      size to determine the final buffer size.
>> +
>>   config KEXEC_JUMP
>>       bool "kexec jump"
>>       depends on KEXEC && HIBERNATION
>> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
>> index 9db41cce8d97..951ef365f0a7 100644
>> --- a/arch/x86/kernel/crash.c
>> +++ b/arch/x86/kernel/crash.c
>> @@ -25,6 +25,7 @@
>>   #include <linux/slab.h>
>>   #include <linux/vmalloc.h>
>>   #include <linux/memblock.h>
>> +#include <linux/highmem.h>
>>   #include <asm/processor.h>
>>   #include <asm/hardirq.h>
>> @@ -398,7 +399,17 @@ int crash_load_segments(struct kimage *image)
>>       image->elf_headers = kbuf.buffer;
>>       image->elf_headers_sz = kbuf.bufsz;
>> +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
>> +    /* Ensure elfcorehdr segment large enough for hotplug changes */
>> +    kbuf.memsz = (CONFIG_NR_CPUS_DEFAULT + CONFIG_CRASH_MAX_MEMORY_RANGES) * sizeof(Elf64_Phdr);
>> +    /* For marking as usable to crash kernel */
>> +    image->elf_headers_sz = kbuf.memsz;
>> +    /* Record the index of the elfcorehdr segment */
>> +    image->elfcorehdr_index = image->nr_segments;
>> +    image->elfcorehdr_index_valid = true;
>> +#else
>>       kbuf.memsz = kbuf.bufsz;
>> +#endif
>>       kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
>>       kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>>       ret = kexec_add_buffer(&kbuf);
>> @@ -413,3 +424,109 @@ int crash_load_segments(struct kimage *image)
>>       return ret;
>>   }
>>   #endif /* CONFIG_KEXEC_FILE */
>> +
>> +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
>> +static void *map_crash_pages(unsigned long paddr, unsigned long size)
>> +{
>> +    /*
>> +     * NOTE: The addresses and sizes passed to this routine have
>> +     * already been fully aligned on page boundaries. There is no
>> +     * need for massaging the address or size.
>> +     */
>> +    void *ptr = NULL;
>> +
>> +    /* NOTE: requires arch_kexec_[un]protect_crashkres() for write access */
>> +    if (size > 0) {
>> +        struct page *page = pfn_to_page(paddr >> PAGE_SHIFT);
>> +
>> +        ptr = kmap(page);
>> +    }
>> +
>> +    return ptr;
>> +}
>> +
>> +static void unmap_crash_pages(void **ptr)
>> +{
>> +    if (ptr) {
>> +        if (*ptr)
>> +            kunmap(*ptr);
>> +        *ptr = NULL;
>> +    }
>> +}
>> +
>> +/**
>> + * arch_crash_handle_hotplug_event() - Handle hotplug elfcorehdr changes
>> + * @image: the active struct kimage
>> + * @hp_action: the hot un/plug action being handled
>> + * @cpu: when KEXEC_CRASH_HP_ADD/REMOVE_CPU, the cpu affected
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
>> + * to permit a growing number of resources. See the
>> + * CONFIG_CRASH_MAX_MEMORY_RANGES description.
>> + * Second, purgatory must explicitly exclude the elfcorehdr from the
>> + * list of segments it checks (since the elfcorehdr changes and thus
>> + * would require an update to purgatory itself to update the digest).
>> + *
>> + */
>> +void arch_crash_handle_hotplug_event(struct kimage *image,
>> +    unsigned int hp_action, unsigned int cpu)
>> +{
>> +    struct kexec_segment *ksegment;
>> +    unsigned char *ptr = NULL;
>> +    unsigned long elfsz = 0;
>> +    void *elfbuf = NULL;
>> +    unsigned long mem, memsz;
>> +
>> +    if (!image->elfcorehdr_index_valid) {
>> +        pr_err("crash hp: unable to locate elfcorehdr segment");
>> +        goto out;
>> +    }
>> +
>> +    ksegment = &image->segment[image->elfcorehdr_index];
>> +    mem = ksegment->mem;
>> +    memsz = ksegment->memsz;
>> +
>> +    /*
>> +     * Create the new elfcorehdr reflecting the changes to CPU and/or
>> +     * memory resources.
>> +     */
>> +    if (prepare_elf_headers(image, &elfbuf, &elfsz)) {
>> +        pr_err("crash hp: unable to prepare elfcore headers");
>> +        goto out;
> 
> Prepare_elf_header uses crash_prepare_elf64_headers function to generate elfcorehdr.
> Since crash_prepare_elf64_headers is defined under CONFIG_KEXEC_FILE option we
> will have build issues if CONFIG_KEXEC is enabled and CONFIG_KEXEC_FILE is disabled.
> 
> How about moving crash_prepare_elf64_headers function to kernel/kexec_core.c?

Yes, of course. I originally protected against this scenario with having the
CRASH_HOTPLUG dependent on KEXEC_FILE, but as we eliminated CRASH_HOTPLUG, your
suggestion above is on point.

Thanks!
eric

> 
> Thanks,
> Sourabh Jain
> 
