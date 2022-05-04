Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1473A51ACDB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 20:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351348AbiEDSel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 14:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377182AbiEDSdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 14:33:53 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5120F5C368
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 11:11:56 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 244GuKlO024988;
        Wed, 4 May 2022 18:11:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=qIwSnxhvRv8jNgDwHOAlQgyKyj5PFHdtRqcB3QFbYcA=;
 b=M7Rpwjfn5IR6FMhAlznGkOBvuC4ObhfzV/6i6XzKz7TKq/XMEEOs5KPuVzRkSmx8xhLe
 O6N7obqlGs28S+XAcmPnpvXLuMhjw59erRNoRSdnP2F/LBzB9fDl9vsN39G6izYSYB+x
 8dDkZblFBiD11XIL1n9HOzDhWn9KAPiDM1wU5WFxs7LTWKAgltN6sCbx+PIuylqqEi+0
 iCrmjQq6+GDcNM3QE6x8sW1+/QCKeW0C/3nwQ52fWN1W32leaqBK/AdNAt6GB0nS8aQa
 E0PLx7uIwxkSEJSB3itbRSibJhIdnBH06ayJr9WXb27eKFSzej8UHvAgRsmIF0rCDbuU xA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruw2h92p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 18:11:14 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 244I1LN2017926;
        Wed, 4 May 2022 18:11:13 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2047.outbound.protection.outlook.com [104.47.56.47])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fs1a5y4nq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 18:11:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RHsQ5RN6BOeBTDFj9x9X2JrYLiS+Rn2ixxD5TTJDOuThe/I8fbRnpBuMyTXNPSwWqBGJM7mLUqmOLvu9erg8AWa5SAB2/5MsVogfcaPPOUatt8/1Mv+seipgpz4hskXhyZCsznEOxHfj1K4ETtfvKe/vV/zsUxXd9j/MWvJRmjht6kCn+hjCL3wwi84aMLKBiD5W2161QASZWYxnJ6ucIGrpaAqrSr628CIhUpL6GmtSlkbgHNhNk7dWK9XWy1YIGncok9EfMpB00ZmL38QTyL1x78o50l4Uhy6PoCNpr2WkgTlXrrUFLLSyNHaa3cxY53lpNXFoxxGu5jAVP2dQ8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qIwSnxhvRv8jNgDwHOAlQgyKyj5PFHdtRqcB3QFbYcA=;
 b=KS1mYBHSBjtYt8ImCNlzKC1ED2RveSX0V4HDDHa9fI019Fi+sSAb0t10d/IxX2OK4GnVyKX1niVHWSRPhbCZOJtqj/1sdmcHOyd2MBTROoMkXQexL70/Y2gyEdaLbjTYkPjY1Mwi66BIEXAr3/mAXlggqWUUGuyq1dDvr3DkWn6/t12m0rVuM/zup+hmMD2l0fAYKnkYZACu7RFcpUyU8/v7G+d8/DVD9ZLuggRoe5h9LVMC5Vdbe7ofWWDnVd3gPKYbnASOGZMIY8cKMJ6ZFWXRMCSbKyfXDMjyAMQMKTp2unF8MtoeYj0Edugk7BbnSulgEFDdPaAZ9lAiAt/Ipg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qIwSnxhvRv8jNgDwHOAlQgyKyj5PFHdtRqcB3QFbYcA=;
 b=vzwvspDT5kcqsFZg+5Fn3oDsfFSOmW5oHfJnScK3BoztGMlon9blRtUaj4nTVFhgb06xRHxP9f7UONRt2wcBFJQC/hL5TwnKqMc/UbXtakgmTLrJKoVz9bp8LCm9oTXwsM8PJr21z/s6dm0id+zV7So/obG3wSLv3v3tIrRhQOI=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by BY5PR10MB3811.namprd10.prod.outlook.com (2603:10b6:a03:1fc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.25; Wed, 4 May
 2022 18:11:11 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::bd49:f0ab:b476:860c]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::bd49:f0ab:b476:860c%7]) with mapi id 15.20.5206.025; Wed, 4 May 2022
 18:11:11 +0000
Message-ID: <6af5bf76-065c-9167-a73e-21908f4b5ef3@oracle.com>
Date:   Wed, 4 May 2022 13:11:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v7 4/8] crash: add generic infrastructure for crash
 hotplug support
Content-Language: en-US
To:     Sourabh Jain <sourabhjain@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>
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
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <f2dbd4fe-6201-b5c4-2725-dec9c3dbf13e@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0133.namprd13.prod.outlook.com
 (2603:10b6:806:27::18) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e4dd7dc-098b-4e94-1ed6-08da2df977d9
X-MS-TrafficTypeDiagnostic: BY5PR10MB3811:EE_
X-Microsoft-Antispam-PRVS: <BY5PR10MB3811D2216EEC577599C6824D97C39@BY5PR10MB3811.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kYuy5r9HtssAlGD5chJXqj+nzQpPQMsWE536j4AfGHJocvNu1ziWCep6vN1EWN4UUA+tXp3iIMH0shp89UMxYEkR9DuCmlwkayNpQYLYbkz5JFwtZC0Dja1nF3BxgCLj2TuQeYzAAAh9qagOMnovoaPcfO3SyE00HlgbLpwCHII5Puy7RYPohFsT5M3Sl8sZCzdKy+F5AK3L9R5keq/CUITuENs6H3SKe+MKOHNxO4atyI8TKqkBXITKsSgxfZNmSLyqD10ksx5JMpDtGA+vqPZmkbR2DuJsrvlwZV8VSWyjMFm4Gw/RH5RkAB9UCjhABVLL7mb5WoFvoTmaB0Z2nvHODmb4zeol/7gzc5LMgD3O6U4WK9URaXEvAJYjaWoTIieyf4bauxVD3OTrwIKorDchLJCjkJ0nt5T3O4xs7JSR/JheObpbV9NfJkhP0yakogoaBEaFJTPpjcLQe6XlGD6fes5lixA4WrK8O9U/k7EVMyS91RBzVKTOprrv3+EPGHWep3xHN+rw1fS22odw0nOO9VmwInyORzQHGXtHxXKe8/OD0wEmHv27Uq8e2ghVIV5MVb0Nh3mdUYZaG+LKjj7wDTVB3oVi4nJx3PDhzUgAnYRGIBCl4KnSdXuuXb074325eAWue+MhnDjWEGXDq3nzb4iiVoln3gs6k3uNLwv3HEUaU0nOb/cH3Lfwp+YdBVHL5SbuEoV/ADzm2jtKg9PPA3quW7SFaYYxOq5cMjR56/dJ6WmQn/8mh/4KAfUKsucnoYCm51cC2F+hz5PBcw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(186003)(107886003)(6506007)(53546011)(6666004)(2616005)(31696002)(86362001)(38100700002)(83380400001)(110136005)(5660300002)(508600001)(7416002)(316002)(66556008)(4326008)(66946007)(8676002)(66476007)(8936002)(6486002)(31686004)(2906002)(36756003)(41533002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eE5tN0k2VkltbGJkcVhoTDRUelZnY25ScEpDaWJGMGowQWlmSzVuTFhTeHc0?=
 =?utf-8?B?cTFHWmtsZXRRRWt2RThBTUhpN0FOZzVrN2FCaFJLTHRIYi9NT1pQb2xKVDJB?=
 =?utf-8?B?dUJBTWdpRllaNFNGbGZQSTY3ZU1tTElESEZCNnBrWVhRencxUlNJQzhmbDZ4?=
 =?utf-8?B?Q0ZyZjJlOUhxYWJvT1JjVE14MHVFWnhpZjIrajA2UUFBYWdGd1EySU5GUmdy?=
 =?utf-8?B?aUVCMWhITjNKVkE0RW8vSGRmUDZGakRLUTVKTVZCbFVreTFvYnUxL1ZNTUpw?=
 =?utf-8?B?amN6S0dwenBwS1ZUR05SQUdBdTJqdFg4ZXZRVFAwODhpRUx5MVFnTmFFZ2sy?=
 =?utf-8?B?c3ZEL3RQeGhsVkdETnU2RXRjOE1ienlsRkNIREo3UmFyNjBWOWtkN3Rwbi9X?=
 =?utf-8?B?bU44b1BSYlJzMnRaVTEyMG9MZ2JnN0JyUmsycUlmbzM2OFFjd2NOdmlxakZI?=
 =?utf-8?B?am1vaG94QjBkendMN2hPYWNzRWRXZlE4eHRKeEQzUUQ0bkhNOWw4eEhFU3d3?=
 =?utf-8?B?cTdzazdlUDFqa1pxVC9vUkJFM003UXBOZGI2cWZPU1Z3dDVTZ0J6ejVsZXo4?=
 =?utf-8?B?VkVyVkFhMlVGU3hoV2ViUy9kalg0MnhoWFo0QWRzSUU5NlZyQ0toMzNpdUM1?=
 =?utf-8?B?bTgyOU5TcWU0YUgva1NDLzdncFM1clpOb0VhUmVnb3FnOVdpU3ZkTkpabjg5?=
 =?utf-8?B?bXdKamFJdVg0YmQxSVRpUllNS1FoQjBzeEk3RkNHVDhpU0Q4a2lVN3R4U2Vz?=
 =?utf-8?B?STFiSEZmdG00REl5T1FNdlgwUFZVK0FNWUpYaTRJQkdndmVOSWdaL1ZnZ21h?=
 =?utf-8?B?R3hXSFAxSnY2WndJOVVPN0k5dWdLZ2E2V2hlUlIwaDR4TWhTTWJjeTJmbG5t?=
 =?utf-8?B?SytuNjRoR3hPbHVMY0VpSVpmQXcxc2wrVXJoaHR6d2dlSHV1TW9SdGF2Ty9j?=
 =?utf-8?B?dXA3eXVSQUxTSlEySzIycHBtTzRtYzlDeVdDMG0zeWpNTlRjamd5YjRkYjBH?=
 =?utf-8?B?QTM1R3BBVnRxVTRWZW9CdEthNnBnV2hZZE5zVThmYUtLU3cxaHJmcVphMExs?=
 =?utf-8?B?M2hPTFNkU21oaG1LenRwTHN0QTJBVmFNcCs2ZVR2QnRnVEJzWnRnc3Fsek9H?=
 =?utf-8?B?YWNGMTd5NXRVQWg2ZGs5b0czMUJFamwyaDdURlFvUHBqWUpzdFlaVGd1MkJr?=
 =?utf-8?B?Z3dqZkRIUGlxeDhtTVFIWDJUa20wdllDQlZWVEExV2ZBR2orLzUzaVc0Vmxj?=
 =?utf-8?B?YmR3Q1VoU05zcVQvUlRuUi9vb3dCczB6ekdvbkd2cmdUNXh4UCs2VW55ZlRJ?=
 =?utf-8?B?aXN2akRZWllkM3V1eVd3bGc1MEJFZENnVmxndDJzbExFK0VOUFFMd28wdTg3?=
 =?utf-8?B?SjVsMVRtYzA4MHIwNFQ5WUhRL1NrRnJJUTFkSUN3ZGdtSHpXcndSTmlZZjVK?=
 =?utf-8?B?QnRKQnlpbm1IMGFLUnd6TmFlQ1RvbzNOS1ZlaTRlemVRcXFSaWZHQXJJa3dr?=
 =?utf-8?B?L3JlUmNmdmhaaUxNcitoSXhIak5yU0ttcnJsdFQ1d1BxUzJNb1dmUHFTa3Bk?=
 =?utf-8?B?VTMrbWhkZ2oraS84UEx5TDRTOEtiaklLckxwYzlhQWhoRDBKMzdKcDZPZGRW?=
 =?utf-8?B?N3Z0QStRdmUvU0w2cGpsczlPeno2S2x5M0EvRHRlaVc2ODZHSmRUN3dMclFr?=
 =?utf-8?B?WjVMMm5hd0x5cFZKZmI5cGN2WXpFek9JVis1cVNkYm5aZitlbWFzTzF3Ykdm?=
 =?utf-8?B?Y3MxbzBlc0RCYkdMV1d3N25aWU1VYTJ3MWtSSG9BNldoLzc2SmNXUzVscFpx?=
 =?utf-8?B?cnNqNGg5ZUJaMEV2WG13Q25SUmhEL1d5dWQ2S2FvN2FNcWptNlhmUTNySExn?=
 =?utf-8?B?Zy9QRUR3NUthNEppbjZTSUc2STlzU1BhakRYOFpHUXFHWEJQNG1LNjBQYVFF?=
 =?utf-8?B?M1ZxTWc3c08rT2RQLzZJeEprclUzT25sRlVzYUdLNDN3YW9iOUQxS1VaeTFm?=
 =?utf-8?B?d0dhOGJpY3BDRkthVTRLemR6UGpCci9SUmVJQUJ0bmc1ODJqUmQ5NVUyZkZ4?=
 =?utf-8?B?SW5RclkvdmhmL0gyV1FRelh0clZsL2pVS1RuRkNlRDBLNktkaGUra1hqenVF?=
 =?utf-8?B?ZncwN3BmVFVZcXMyNTFUTmxydmJiWlJpdVIxQ2JuZTdmaVh1d1FKRWZCdEpT?=
 =?utf-8?B?V3M1bldsK0hPcFd1ZDFNeUtzaFBiT2VkcDRKQzVkZnl5OFpJZ015b3IrcUhv?=
 =?utf-8?B?MEo2L1h4cXVQRVVZZUswZEZQMStVSDFsbW9QT2kyaFJWTm44QWVKRnRFakYw?=
 =?utf-8?B?RXJRaFNCN2F0b01weCt1TXg0YVpYbUkzSzdsc2duQ014Qkx3OWhyenFSbS9a?=
 =?utf-8?Q?6U/PgyGd6mMEf1WRmPf8G5Idu2rcqUxNNTfVy?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e4dd7dc-098b-4e94-1ed6-08da2df977d9
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2022 18:11:11.0764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rdRIrXmutXGnOsQ8COkNm1UUuXX2gRkbGi4wJ4QCyGwEIVkx4WD/AJ22kvNFwo7WkJOiftkA70tUb0TYqiXnDrtgEe7UE0Q9lzutsIwwF20=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3811
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-04_04:2022-05-04,2022-05-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205040108
X-Proofpoint-GUID: Bl9zTsz75vQ8QVHi1thOfSTJcevxauaK
X-Proofpoint-ORIG-GUID: Bl9zTsz75vQ8QVHi1thOfSTJcevxauaK
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/28/22 00:18, Sourabh Jain wrote:
> Hi Baoquan,
> 
> On 26/04/22 10:52, Baoquan He wrote:
>> On 04/26/22 at 09:36am, Sourabh Jain wrote:
>>> On 15/04/22 03:59, Eric DeVolder wrote:
>>>> Hi Baoquan,
>>>> Inline comments below.
>>>> Thanks!
>>>> eric
>>>>
>>>> On 4/13/22 21:45, Baoquan He wrote:
>>>>> On 04/13/22 at 12:42pm, Eric DeVolder wrote:
>>>>>> Upon CPU and memory changes, a generic crash_hotplug_handler()
>>>>>> dispatches the hot plug/unplug event to the architecture specific
>>>>>> arch_crash_hotplug_handler(). During the process, the kexec_mutex
>>>>>> is held.
>>>>>>
>>>>>> To support cpu hotplug, a callback is registered to capture the
>>>>>> CPUHP_AP_ONLINE_DYN online and ofline events via
>>>>>> cpuhp_setup_state_nocalls().
>>>>>>
>>>>>> To support memory hotplug, a notifier is registered to capture the
>>>>>> MEM_ONLINE and MEM_OFFLINE events via register_memory_notifier().
>>>>>>
>>>>>> The cpu callback and memory notifier then call crash_hotplug_handler()
>>>>>> to handle the hot plug/unplug event.
>>>>>>
>>>>>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
>>>>>> ---
>>>>>>    include/linux/kexec.h |  16 +++++++
>>>>>>    kernel/crash_core.c   | 101
>>>>>> ++++++++++++++++++++++++++++++++++++++++++
>>>>>>    2 files changed, 117 insertions(+)
>>>>>>
>>>>>> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>>>>>> index f93f2591fc1e..02daff1f47dd 100644
>>>>>> --- a/include/linux/kexec.h
>>>>>> +++ b/include/linux/kexec.h
>>>>>> @@ -306,6 +306,13 @@ struct kimage {
>>>>>>          /* Information for loading purgatory */
>>>>>>        struct purgatory_info purgatory_info;
>>>>>> +
>>>>>> +#ifdef CONFIG_CRASH_HOTPLUG
>>>>>> +    bool hotplug_event;
>>>>>> +    unsigned int offlinecpu;
>>>>>> +    bool elfcorehdr_index_valid;
>>>>>> +    int elfcorehdr_index;
>>>>>> +#endif
>>>>>>    #endif
>>>>>>      #ifdef CONFIG_IMA_KEXEC
>>>>>> @@ -322,6 +329,15 @@ struct kimage {
>>>>>>        unsigned long elf_load_addr;
>>>>>>    };
>>>>>>    +#ifdef CONFIG_CRASH_HOTPLUG
>>>>>> +void arch_crash_hotplug_handler(struct kimage *image,
>>>>>> +    unsigned int hp_action, unsigned int cpu);
>>>>>> +#define KEXEC_CRASH_HP_REMOVE_CPU   0
>>>>>> +#define KEXEC_CRASH_HP_ADD_CPU      1
>>>>>> +#define KEXEC_CRASH_HP_REMOVE_MEMORY 2
>>>>>> +#define KEXEC_CRASH_HP_ADD_MEMORY   3
>>>>>> +#endif /* CONFIG_CRASH_HOTPLUG */
>>>>>> +
>>>>>>    /* kexec interface functions */
>>>>>>    extern void machine_kexec(struct kimage *image);
>>>>>>    extern int machine_kexec_prepare(struct kimage *image);
>>>>>> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
>>>>>> index 256cf6db573c..ecf746243ab2 100644
>>>>>> --- a/kernel/crash_core.c
>>>>>> +++ b/kernel/crash_core.c
>>>>>> @@ -9,12 +9,17 @@
>>>>>>    #include <linux/init.h>
>>>>>>    #include <linux/utsname.h>
>>>>>>    #include <linux/vmalloc.h>
>>>>>> +#include <linux/highmem.h>
>>>>>> +#include <linux/memory.h>
>>>>>> +#include <linux/cpuhotplug.h>
>>>>>>      #include <asm/page.h>
>>>>>>    #include <asm/sections.h>
>>>>>>      #include <crypto/sha1.h>
>>>>>>    +#include "kexec_internal.h"
>>>>>> +
>>>>>>    /* vmcoreinfo stuff */
>>>>>>    unsigned char *vmcoreinfo_data;
>>>>>>    size_t vmcoreinfo_size;
>>>>>> @@ -491,3 +496,99 @@ static int __init crash_save_vmcoreinfo_init(void)
>>>>>>    }
>>>>>>      subsys_initcall(crash_save_vmcoreinfo_init);
>>>>>> +
>>>>>> +#ifdef CONFIG_CRASH_HOTPLUG
>>>>>> +void __weak arch_crash_hotplug_handler(struct kimage *image,
>>>>>> +    unsigned int hp_action, unsigned int cpu)
>>>>>> +{
>>>>>> +    pr_warn("crash hp: %s not implemented", __func__);
>>>>>> +}
>>>>>> +
>>>>>> +static void crash_hotplug_handler(unsigned int hp_action,
>>>>>> +    unsigned int cpu)
>>>>>> +{
>>>>>> +    /* Obtain lock while changing crash information */
>>>>>> +    if (!mutex_trylock(&kexec_mutex))
>>>>>> +        return;
>>>>>> +
>>>>>> +    /* Check kdump is loaded */
>>>>>> +    if (kexec_crash_image) {
>>>>>> +        pr_debug("crash hp: hp_action %u, cpu %u", hp_action, cpu);
>>>>>> +
>>>>>> +        /* Needed in order for the segments to be updated */
>>>>>> +        arch_kexec_unprotect_crashkres();
>>>>>> +
>>>>>> +        /* Flag to differentiate between normal load and hotplug */
>>>>>> +        kexec_crash_image->hotplug_event = true;
>>>>>> +
>>>>>> +        /* Now invoke arch-specific update handler */
>>>>>> +        arch_crash_hotplug_handler(kexec_crash_image, hp_action, cpu);
>>>>>> +
>>>>>> +        /* No longer handling a hotplug event */
>>>>>> +        kexec_crash_image->hotplug_event = false;
>>>>>> +
>>>>>> +        /* Change back to read-only */
>>>>>> +        arch_kexec_protect_crashkres();
>>>>>> +    }
>>>>>> +
>>>>>> +    /* Release lock now that update complete */
>>>>>> +    mutex_unlock(&kexec_mutex);
>>>>>> +}
>>>>>> +
>>>>>> +#if defined(CONFIG_MEMORY_HOTPLUG)
>>>>>> +static int crash_memhp_notifier(struct notifier_block *nb,
>>>>>> +    unsigned long val, void *v)
>>>>>> +{
>>>>>> +    struct memory_notify *mhp = v;
>>>>>> +
>>>>>> +    switch (val) {
>>>>>> +    case MEM_ONLINE:
>>>>>> +        crash_hotplug_handler(KEXEC_CRASH_HP_ADD_MEMORY, -1U);
>>>>> We don't differentiate the memory add/remove, cpu add, except of cpu
>>>>> remove. Means the hp_action only differentiate cpu remove from the other
>>>>> action. Maybe only making two types?
>>>>>
>>>>> #define KEXEC_CRASH_HP_REMOVE_CPU   0
>>>>> #define KEXEC_CRASH_HP_UPDATE_OTHER      1
>>>>>
>>>> Sourabh Jain's work with PPC uses REMOVE_CPU, REMOVE_MEMORY, and
>>>> ADD_MEMORY.
>>>> Do you still want to consolidate these?
>>> On PowerPC different actions are needed for CPU add and memory add/remove.
>>> For CPU add case only FDT is updated whereas for the memory hotplug we will
>>> be
>>> updating FDT and elfcorehdr.
>> I don't understand. For elfcorehdr updating, we only need regenerate it.
>> Do you update them different for memory add/remove?
> 
> We have different actions for cpu remove, CPU add and memory add/remove case.
> 
> CPU remove: no action
> CPU add: update flattened device tree (FDT)
> memory add/remove: update FDT and regenerate/update elfcorehdr
> 
> Since memory add/remove action is same we can have common hp_action for them.
> 
>>
>> What I saw is the added action for memory hotplug is only for message
>> printing. Is this really needed? And memory hotplug is even not
>> supported. Please correct me if I missed anything.
> 
> I agree that currently memory hp_action is only used for printing warning message but
> eventually we will be handling memory hotplug case as well.

Baoquan,
It appears the straight forward thing to do here is just to keep the 4 cpu/mem add/remove 
combinations. It appears there is value in keeping them as currently defined. However, please 
indicate if you agree or not.
Thanks!
Eric

> 
>> +       /* crash update on memory hotplug is not support yet */
>> +       if (hp_action == KEXEC_CRASH_HP_REMOVE_MEMORY || hp_action == KEXEC_CRASH_HP_ADD_MEMORY) {
>> +               pr_info_once("crash hp: crash update is not supported with memory hotplug\n");
>> +               return;
>> +       }
> 
> Thanks,
> Sourabh Jain
> 
