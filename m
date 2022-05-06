Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF7651DDEA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 18:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443961AbiEFQzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 12:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443932AbiEFQy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 12:54:58 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2245D5FC;
        Fri,  6 May 2022 09:51:14 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 246E6tFJ013502;
        Fri, 6 May 2022 16:51:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=uAtArhcT4aRKkhq86EhHDQqKgvar5k4IDo6j06chwt4=;
 b=sWYUASWuNDifbQaCX9xqRPMOFY7sgD5t8N0KuayNU68xOfQea9dssvcMTc6mb3KFkgzt
 cpgc/ZN7ANfsTzFyJd99siH7kznykH3/JMoM475oGl61sHk8Sp7BDxYfBwk6ixTVYhGm
 IUnVg43S8pMj7zZY/pFXnnOU81LDrZcUbnfa8tUVX0HHZfTF5OnowUDuP1j8Wc+evaAn
 uKq21DSkb+CCzirz4UIqyqLJ9pn1lnsUAXgvJX5bvj6w0AkEXsrn2/OAgy1j9S0z252D
 FWU95h9PPaARQUp8BQaMEw3fMnxn+83Zty8tblLAsRhoBZl9swx4D5F1foKlDUW/At0w MQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frvqspng4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 May 2022 16:50:59 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 246GPTUk031310;
        Fri, 6 May 2022 16:50:59 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fs1a8hdqk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 May 2022 16:50:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gupy9ttZksJ9YMBpofpjr62yh7hAgyQYs3mj3hkrtHHvZzlomg8aVOXQ+bKusbHRCHKcwrRfpB0bZgnISw8C5d91FZ7O6zZY+N/H+Vz03sbU8uakQi8htqyVyHVCOpAh3TBoW5MOWUXJUcEf4FXavTbwChrhS+duYhQ3iepKLOynI2+s5ptfHsbA+oE7GH1flzmNWjgX5k8rYnzEbxB+3XgIABMCCWQSUiNBcni80AYZ2Hz51boR4Q0zy9EPpkr6GeL6xM5qY6qiNdWXwAUu4bQGHFiRTm3eUpulE/zI+ky7DgIP02YKaZRgCfL8JX0iYCkHZ2Ik9DPdHWjHuUUEWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uAtArhcT4aRKkhq86EhHDQqKgvar5k4IDo6j06chwt4=;
 b=SGkmFCILWn237gKhovhxFHX5KuJZPRVuhZmeVRlyUkFTvGy6U0jV0nIxdmvJ9n/fSY1o9kebmuFozAscjiYDikga+13m4Lcjz7yBiGymZ17GPVQYlPV9KjsogE8N0dp2Lh/uR9/PrfP5Gk+7pw87RJA7niM0Y7FjIl3EAgtpbJlkny0COuPKJ+m4lMZQqG2FPo8A6AXzyOxcuk/1MpdyEwN8yyu04drJ1hJVgICELLeqLShXxCeqQk5RKDmdoeEUQn/IbP3YVGtKzc5fu3t1aF9c3nQtavLtKTOEVYy5adeenDvfQZIl8QsuBleuPRBu1W1IcCR5Ug5w9DRT027nBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uAtArhcT4aRKkhq86EhHDQqKgvar5k4IDo6j06chwt4=;
 b=fayCTukLeHzB7u8miIHSRtrYNB+IzXiuPeTJtPZFsNmmKvBgS9Us8EtpPVDoo1fl9uEHAIeFyWMTvHa3VmpE7CY/CAa3e8FxDxwToLCOOcv93l5ctiHpQoH99XZwcUKN00xip/4gGWTnytZmHNW21sxOqL6oVmA0YP3NzjGTqpY=
Received: from DM6PR10MB4201.namprd10.prod.outlook.com (2603:10b6:5:216::10)
 by CY4PR10MB2021.namprd10.prod.outlook.com (2603:10b6:903:11e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.25; Fri, 6 May
 2022 16:50:56 +0000
Received: from DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::e81e:38af:cb6e:59e5]) by DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::e81e:38af:cb6e:59e5%4]) with mapi id 15.20.5227.020; Fri, 6 May 2022
 16:50:56 +0000
Message-ID: <e199085c-d89d-093b-4257-0102980861bc@oracle.com>
Date:   Fri, 6 May 2022 09:50:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v9 4/4] mm: hugetlb_vmemmap: add hugetlb_optimize_vmemmap
 sysctl
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     corbet@lwn.net, akpm@linux-foundation.org, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com, osalvador@suse.de,
        david@redhat.com, masahiroy@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, smuchun@gmail.com
References: <20220429121816.37541-1-songmuchun@bytedance.com>
 <20220429121816.37541-5-songmuchun@bytedance.com>
 <eadec7de-2e1a-2fb3-3317-c7b492a84e2b@oracle.com>
 <YnM4DRFhdD6iZIs1@FVFYT0MHHV2J.googleapis.com>
 <f77412f1-ffe5-659d-8a7d-578e0e8c5e2c@oracle.com>
 <YnOEl6Qwp5jp7RHp@FVFYT0MHHV2J>
 <a0c54e91-dcb2-debd-a1ef-b4906fed8ab1@oracle.com>
 <YnSM0Wd/lEc9wnwJ@FVFYT0MHHV2J.googleapis.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <YnSM0Wd/lEc9wnwJ@FVFYT0MHHV2J.googleapis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0268.namprd03.prod.outlook.com
 (2603:10b6:303:b4::33) To DM6PR10MB4201.namprd10.prod.outlook.com
 (2603:10b6:5:216::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a761dc5d-0e13-47e2-c806-08da2f809716
X-MS-TrafficTypeDiagnostic: CY4PR10MB2021:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB2021D188908FDE1589BF5B85E2C59@CY4PR10MB2021.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JGP+GOiYKVdzPpdNj0uabUzyboLbxW33DEg1t8EcbH9a1S0iNz4UV8mvCgMNzQlF9sprctdb+kLkBO0GR9T8tizqZd1n/0pbPgp25VJ3T7lY5bgbF5XXwdmF79NGiKnPcd1L9e52sw6AN3/XdqLt1GbYULpvcIbhAVk8uEbQKxw5Pxmjcp/aiuBPfE6OyvdQgeWnUu6Goz50GqSii55Qww12kO9bXMuOXt2itgNWtDVcKtzmbfkyhAq1WGdimv9VSBw0Kgd7QLD96JaekCa0ZKGFVmAalanWzjWqK+bWCDry+n1FZWwKL7oAV9HBdOZbNzF/nPrJgVU5Rq/vgDmq9xIC4V4hkd9grPQJQyFNxL3GUhdsTB4htcLuuh6T3bWBW7Ia8eTy6cZyOFuO/V8k7TgBfvJqBelxTLCQiv3JMbSuVK3G+LMY/E9Etd8r8o18XJhwVWrgQQKxpVA2APuvzcIwOnVSb9ig/iC0rqVTjdVqs2XzCo+BcMjiIyyo92ZUyMM3zIMhjBH1GZQvdgbZ0B8ornLx5fiOPTz0nNWoPLe86+dtsMe4HhbYIWtUX04Hgyb8B364QFegGLmQjma2uf8DU6So5K1IdyQd+ADBxJ2sstiquysiD3EdzrfLlHjeckqkw4xznWJarxO+SDv+QU9XRvhbLUBVx4bxyzjFIRWu1md563L2KwpFKx2nIpRE/Nrfj+BDNNwEvDhcjMg5LCec7cpjSzbh5ztmHOvvKCNgmON4vGAeJ96fb6dNmILMU3IJpWworvo0RT0v11eoCPSmPT8ACEL1hCF37GGEwv7wC4KVu1iFLp2O+WYQrBGKq6fgTrDmLXJcdATUVsIIuQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4201.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6666004)(186003)(6506007)(53546011)(52116002)(26005)(6512007)(2616005)(86362001)(31696002)(38100700002)(38350700002)(83380400001)(44832011)(5660300002)(508600001)(7416002)(316002)(6916009)(66946007)(8676002)(4326008)(66556008)(36756003)(66476007)(8936002)(6486002)(966005)(31686004)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUdhOWZRMWE2cGt1UjEwM1NtZDZVVjQwYS9aRDhiWUhwTnQwY3ljbUVWcVBD?=
 =?utf-8?B?NjRvZyt2dElGUmM5SkZMWXRXbEx3RC84elVuUmtHLysySS9TR1FaSnhSVW11?=
 =?utf-8?B?U3c2cEtwV0hBTnJDYjI1MmducnVUVzlQakF4Yk01ZHVYM2JUSTVxZkNSdXFv?=
 =?utf-8?B?dStDUmNPV1l0N3hXRzczaHNXVExRWUk4Ui9DZnRiYkRTekVsWkpLWUJJZXhN?=
 =?utf-8?B?V0FZbkVKQzI4Ti92aUdpZXZ0UEpKMzlIT2Q2MUdkeUlRWk4yb3pyZFYySjQy?=
 =?utf-8?B?SjJVOEgyalpndjI2Mm1WVXhvQ3lmMWVIMXN0am8xYVoySGFRdnFwbzEzTito?=
 =?utf-8?B?OEJIUG9uZGJxU1grbUhZS0cvSDh0OWZRVmc3bXVWUW5TRHoxZFlhVkI2VHBN?=
 =?utf-8?B?MXFmTWNyYkdDL1NNTTJlLzFwM09mNW41c3M2cEZCV0ZWYVJyb2dWdWE2bHN4?=
 =?utf-8?B?bHdvdTBoREcrdzU3b2orSEhuaHFKbThCZHgvQ2JiS3A1eEgvYSs0WXhpMjh0?=
 =?utf-8?B?dkVEcDhXeXFDQXBNR0UvR2E5UTVHZ2V1RDNKdFlmU2pLV1Z0RjV1alMzLzli?=
 =?utf-8?B?L0xRMlo0V01PVWw5d2J1TmszaTY0dXJsQm1yZU9KZkhkNXo5U1dQclZwSGRB?=
 =?utf-8?B?UHBMczUxS3lLWXFXUG1pYW9sY1NMdm1DODg1Um43V2s0MmF6TWZtY0VnQ1hE?=
 =?utf-8?B?bWsrT2xvbzRJZFI0eUNtLzZORytybm4vL2ZGd1FMbzNva3Z2c2ZRZDRQQnIx?=
 =?utf-8?B?VkJaQXhIMVEyVW0wRlpXanZPU0JNRTlsK25TWXIwVU5yeFlOeklkT2JnMklP?=
 =?utf-8?B?RTRKVFdYMkhXTllRQlVXM2thU2ZucE01Q0t0WVRoeVdIL2xIY0JYY0RXOFFj?=
 =?utf-8?B?RXAvcll1alN0L1B2bW5iVEZ3REt1VEpCaTlpTWRqaWhHTHZMWUpYYXI2MzdR?=
 =?utf-8?B?aEV6aW04bjRTUml2c2l4NHRra3FqZnRhOTRBNDRKdy82ZjA4TitxVFJucVVI?=
 =?utf-8?B?T3IxTDhKMTZYU1VUSzE4TFY1Z29PQkpSOExoektKVVg1UEJBNE54RXU1bkFP?=
 =?utf-8?B?MGpOYzBrdGd6cVo2dTJHd2NkS3cxWjBWdkttbC9WUk1iNWk3Q2RLejdVUGZE?=
 =?utf-8?B?MEoxMFJxQmlBWjdwTE90c2FQaU04d2hQMVZDbXk5OWVESDhUeXhZY2ZmTUl6?=
 =?utf-8?B?MWZPcHpKUUNQRHpQblF1L2JVMFB6WjAxZ1RKTGpGTDI1QStjcEY3WGZOQ01V?=
 =?utf-8?B?Tk1TR0VNWjRTcmhoVm5oVTkyTkJtSUFZYzhvMDg0US9HM2p5WWVWai9wZThh?=
 =?utf-8?B?UlExaS9KZVlobVNaL2M5aXRlZ3VDMnozRUo0NjlnUkVkWWt5WGJ5MTh5QlNq?=
 =?utf-8?B?YlNORFd0QisvaURtMno3dkhSTEYvMkd4QkVBS2lFdEQ5Y0ZiQ29jb1o1czRn?=
 =?utf-8?B?WjA5bUFnblJzd3IwQkNuVTdXVjdNZDFnanpVT2FQdUxpUHdiSmpBbVVwZEhV?=
 =?utf-8?B?N3FYNVV6Q1Q3Y09pRkNiSUVOZWp5QWVFQjcyRDU2WUI5L2M3dHE1RjVxa3hK?=
 =?utf-8?B?NU90a252NXp5Qll1VGJxR0pObHZOckV0aGZMcFZwcHdsTXZWdlMweEJjQy9t?=
 =?utf-8?B?TFIrS2syV29RN0xMUWp0NHVOQUUwTFhJKzQ2WkYvY0MrQXhVZGZhYWhTZnJ6?=
 =?utf-8?B?NC85VjdhR28yS092UDhXYnBDWXdVRVBkV0UvcFFkQk1DVkZxTjFxYzgwVXBC?=
 =?utf-8?B?dHZPMUc1N2ROZjFVcnNtbjBlV0lLOVl0ZmQ3WER2VmhrRnVhaHRNdkpsRUVH?=
 =?utf-8?B?eHVCRFhQVkoyYUt4dEJtcXZCOEd6citUL1ZOVmtyLzRQdWlrbElvUUtvdEFo?=
 =?utf-8?B?Ty9wUW4wRUhRMEpzc2JpMDlxZTR3WmtFUjlJcm1yci9oWnYwWmRvNkRTU3JI?=
 =?utf-8?B?T0o5dkVFTC9NSldXdTh1VFlOcGgrWkd0S0lnek4yQnBMQkVPQko3V01rQ1cr?=
 =?utf-8?B?bFN0S1REM3JTSktFOVR0ZldFTHlXSElkc21VTURwWG55MzNaYTVXYzdad252?=
 =?utf-8?B?c2V6c1IzalNOWUxOdU9kN1ZGeklzcVp6U1hHTTZyV09wenZteEtCTGZaZ0lE?=
 =?utf-8?B?dkFjL2dHUDZEZ2NxdmdwbVVueDI1VEkxd3VsT3lYa1JkN21GckJRazNzODdT?=
 =?utf-8?B?eU90SWlCc1NzSWFnQUZDMXl2THRIUm1mTTQxcnZJKzltVi9xTU1oTkRBUHlG?=
 =?utf-8?B?QXdERXJ6UU45MmJUYnZyKzdlMkZnaUhqZ2JBM2wxUk9sWUdMVFR1SmphZDJD?=
 =?utf-8?B?bzUzdkFiNE5RLzZlaTE5TkxhY0ExdVVhd21PUVErTEhRVTJ1d3RwMHV5Yi9T?=
 =?utf-8?Q?qU4RjcEUNMrub8QU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a761dc5d-0e13-47e2-c806-08da2f809716
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4201.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2022 16:50:56.5706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bd10e6KBRVNa+Ko4fG0C/hVH4CnBtbSoUAuVk9sheiclIFUzYQvOGN92mKyfPIESNDA1ZpjGj0gOnvGxk2BdmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB2021
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-06_06:2022-05-05,2022-05-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205060085
X-Proofpoint-GUID: p4CeherCt5KHTB3-MngVhF1RlTObVa4Z
X-Proofpoint-ORIG-GUID: p4CeherCt5KHTB3-MngVhF1RlTObVa4Z
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/5/22 19:49, Muchun Song wrote:
> On Thu, May 05, 2022 at 09:48:34AM -0700, Mike Kravetz wrote:
>> On 5/5/22 01:02, Muchun Song wrote:
>>> On Wed, May 04, 2022 at 08:36:00PM -0700, Mike Kravetz wrote:
>>>> On 5/4/22 19:35, Muchun Song wrote:
>>>>> On Wed, May 04, 2022 at 03:12:39PM -0700, Mike Kravetz wrote:
>>>>>> On 4/29/22 05:18, Muchun Song wrote:
>>>>>>> +static void vmemmap_optimize_mode_switch(enum vmemmap_optimize_mode to)
>>>>>>> +{
>>>>>>> +	if (vmemmap_optimize_mode == to)
>>>>>>> +		return;
>>>>>>> +
>>>>>>> +	if (to == VMEMMAP_OPTIMIZE_OFF)
>>>>>>> +		static_branch_dec(&hugetlb_optimize_vmemmap_key);
>>>>>>> +	else
>>>>>>> +		static_branch_inc(&hugetlb_optimize_vmemmap_key);
>>>>>>> +	vmemmap_optimize_mode = to;
>>>>>>> +}
>>>>>>> +
>>>>>>>  static int __init hugetlb_vmemmap_early_param(char *buf)
>>>>>>>  {
>>>>>>>  	bool enable;
>>>>>>> +	enum vmemmap_optimize_mode mode;
>>>>>>>  
>>>>>>>  	if (kstrtobool(buf, &enable))
>>>>>>>  		return -EINVAL;
>>>>>>>  
>>>>>>> -	if (enable)
>>>>>>> -		static_branch_enable(&hugetlb_optimize_vmemmap_key);
>>>>>>> -	else
>>>>>>> -		static_branch_disable(&hugetlb_optimize_vmemmap_key);
>>>>>>> +	mode = enable ? VMEMMAP_OPTIMIZE_ON : VMEMMAP_OPTIMIZE_OFF;
>>>>>>> +	vmemmap_optimize_mode_switch(mode);
>>>>>>>  
>>>>>>>  	return 0;
>>>>>>>  }
>>>>>>> @@ -60,6 +80,8 @@ int hugetlb_vmemmap_alloc(struct hstate *h, struct page *head)
>>>>>>>  	vmemmap_end	= vmemmap_addr + (vmemmap_pages << PAGE_SHIFT);
>>>>>>>  	vmemmap_reuse	= vmemmap_addr - PAGE_SIZE;
>>>>>>>  
>>>>>>> +	VM_BUG_ON_PAGE(!vmemmap_pages, head);
>>>>>>> +
>>>>>>>  	/*
>>>>>>>  	 * The pages which the vmemmap virtual address range [@vmemmap_addr,
>>>>>>>  	 * @vmemmap_end) are mapped to are freed to the buddy allocator, and
>>>>>>> @@ -69,8 +91,10 @@ int hugetlb_vmemmap_alloc(struct hstate *h, struct page *head)
>>>>>>>  	 */
>>>>>>>  	ret = vmemmap_remap_alloc(vmemmap_addr, vmemmap_end, vmemmap_reuse,
>>>>>>>  				  GFP_KERNEL | __GFP_NORETRY | __GFP_THISNODE);
>>>>>>> -	if (!ret)
>>>>>>> +	if (!ret) {
>>>>>>>  		ClearHPageVmemmapOptimized(head);
>>>>>>> +		static_branch_dec(&hugetlb_optimize_vmemmap_key);
>>>>>>> +	}
>>>>>>>  
>>>>>>>  	return ret;
>>>>>>>  }
>>>>>>> @@ -84,6 +108,8 @@ void hugetlb_vmemmap_free(struct hstate *h, struct page *head)
>>>>>>>  	if (!vmemmap_pages)
>>>>>>>  		return;
>>>>>>>  
>>>>>>> +	static_branch_inc(&hugetlb_optimize_vmemmap_key);
>>>>>>
>>>>>> Can you explain the reasoning behind doing the static_branch_inc here in free,
>>>>>> and static_branch_dec in alloc?
>>>>>> IIUC, they may not be absolutely necessary but you could use the count to
>>>>>> know how many optimized pages are in use?  Or, I may just be missing
>>>>>> something.
>>>>>>
>>>>>
>>>>> Partly right. One 'count' is not enough. I have implemented this with similar
>>>>> approach in v6 [1]. Except the 'count', we also need a lock to do synchronization.
>>>>> However, both count and synchronization are included in static_key_inc/dec
>>>>> infrastructure. It is simpler to use static_key_inc/dec directly, right? 
>>>>>
>>>>> [1] https://lore.kernel.org/all/20220330153745.20465-5-songmuchun@bytedance.com/
>>>>>
>>>>
>>>> Sorry, but I am a little confused.
>>>>
>>>> vmemmap_optimize_mode_switch will static_key_inc to enable and static_key_dec
>>>> to disable.  In addition each time we optimize (allocate) a hugetlb page after
>>>> enabling we will static_key_inc.
>>>>
>>>> Suppose we have 1 hugetlb page optimized.  So static count == 2 IIUC.
>>>> The someone turns off optimization via sysctl.  static count == 1 ???
>>>
>>> Definitely right.
>>>
>>>> If we then add another hugetlb page via nr_hugepages it seems that it
>>>> would be optimized as static count == 1.  Is that correct?  Do we need
>>>
>>> I'm wrong.
>>>
>>>> to free all hugetlb pages with optimization before we can add new pages
>>>> without optimization?
>>>>
>>>
>>> My bad. I think the following code would fix this.
>>>
>>> Thanks for your review carefully.
>>>
>>> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
>>> index 5820a681a724..997e192aeed7 100644
>>> --- a/mm/hugetlb_vmemmap.c
>>> +++ b/mm/hugetlb_vmemmap.c
>>> @@ -105,7 +105,7 @@ void hugetlb_vmemmap_free(struct hstate *h, struct page *head)
>>>         unsigned long vmemmap_end, vmemmap_reuse, vmemmap_pages;
>>>
>>>         vmemmap_pages = hugetlb_optimize_vmemmap_pages(h);
>>> -       if (!vmemmap_pages)
>>> +       if (!vmemmap_pages || READ_ONCE(vmemmap_optimize_mode) == VMEMMAP_OPTIMIZE_OFF)
>>>                 return;
>>>
>>>         static_branch_inc(&hugetlb_optimize_vmemmap_key);
>>>  
>>
>> If vmemmap_optimize_mode == VMEMMAP_OPTIMIZE_OFF is sufficient for turning
>> off optimizations, do we really need to static_branch_inc/dev for each
>> hugetlb page?
>>
> 
> static_branch_inc/dec is necessary since the user could change
> vmemmap_optimize_mode to off after the 'if' judgement.
> 
> CPU0:				CPU1:
> // Assume vmemmap_optimize_mode == 1
> // and static_key_count == 1
> if (vmemmap_optimize_mode == VMEMMAP_OPTIMIZE_OFF)
> 	return;
> 				hugetlb_optimize_vmemmap_handler();
> 					vmemmap_optimize_mode = 0;
> 					static_branch_dec();
> 					// static_key_count == 0
> // Enable static_key if necessary
> static_branch_inc();
> 
> Does this make sense for you?

Yes, it makes sense and is require because hugetlb_optimize_vmemmap_pages()
performs two functions:
1) It determines if vmemmap_optimization is enabled
2) It specifies how many vmemmap pages can be saved with optimization
hugetlb_optimize_vmemmap_pages returns 0 if static_key_count == 0, so this
would cause problems in places such as hugetlb free path (hugetlb_vmemmap_alloc).  I hope my understanding is correct?

Would it make the code more clear if we did not do the check for
vmemmap_optimization in hugetlb_optimize_vmemmap_pages()?  Instead:
- hugetlb_optimize_vmemmap_pages ALWAYS returns the number of vmemmap pages
  that can be freed/optimized
- At hugetlb allocation time (hugetlb_vmemmap_free) we only check
  hugetlb_optimize_vmemmap_enabled() to determine if optimization should
  be performed.
- After hugetlb_vmemmap_free, we can use HPageVmemmapOptimized to determine
  if vmemap pages need to be allocated in hugetlb freeing paths.

Perhaps, there is something wrong with the above suggestion?

I know you have always had hugetlb_optimize_vmemmap_pages perform the two
functions.  So, splitting functionality may not be more clear for you.  I am
OK leaving code as is (key inc/dec for each page).  Just wanted to get your
(and perhaps other) thoughts on splitting functionality as described above.   
-- 
Mike Kravetz
