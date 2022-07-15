Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24E56576298
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 15:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234490AbiGONLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 09:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiGONLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 09:11:47 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A665E317
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 06:11:43 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26FBZugJ016644;
        Fri, 15 Jul 2022 13:11:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=vh7iSdzvr7okfya/6V271OzBWagVp/6n6bZo6iTlwOw=;
 b=NzyoBYLCkXmWqcv8c+yqYoEFPvXjQInFZ/J7N2D+36JN73mMWPFDdvhLeU3Ljqy9Abpu
 ahyCqYhn3S8+9mewKNEjQIybCUADRgUHF0Td5sAmmQ8dK/dfSUu9UDKDz0zcOKB0E4LI
 34H1e4wOdGge/ygDX1L7NTzzI9u/0u07DulBhxJHysKZwxCtZjgvDxC2vXC8dxLNHY5t
 Rg/Zl+oUiaB9H+ZFRcK4hcKNm6pEDaB8jsZkzXxWO6KEg6emQ5fU4Mk5VtSlrYZ0Ly65
 zdPle/leeFzlt6QVOxojBM1GFkvnJKpb1izj8KkQV7JSrueG8RPq0ljy2hVSmli5FjJC HA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h727srbx7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jul 2022 13:11:10 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26FD5jKZ017520;
        Fri, 15 Jul 2022 13:11:09 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h70479g01-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jul 2022 13:11:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QcE9H7JqsIIvl95M+l/93/HTX+rC89c3KHjnoZEDqV4/2EwrLM8fleV6FFhtvlcWaEHlJMxZ4ZvzgQ81ggZHS+BK37mF24OnbyHkWJgP+atipjKrKWiLZPbashWSERQT361awNKmxo4Pe4ifALN/reyf31PwWbcLjCkBhFXFlq9J6XvrE5kQVTcsZCW8nsZ5HCKD7IwEC7pG8vvrhfYWXMzcsW9ged6ZzA5YsUQfrgMw7mbCn7miR9gpzfsZzwmr4fOVdCI7NcD/VkkHuRF5ruKno+3H2Uk3/LNFu1dmujM/B8DF2qrwpaVNCAmIslU+fS/dmLYSukRWnv9Mbpthww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vh7iSdzvr7okfya/6V271OzBWagVp/6n6bZo6iTlwOw=;
 b=TCcoxRUgfMzrTvbjL0QcVg0oaKajrs/u7rWHvj4MEFUXSXap1W5XSQfqgzjv2O9+MXEN6FHeD7+vTiH0iBN+USebU7fwEzeW1fMisa4nTs/WSLJj7i1dFGCXQCKk/jBn1z7yRZnX0lwAtqN+1BF6fBxIJzOwa6nSC48q+KiEP7DRcsBaw7qZV/gCTLNHxnu8L4Rc6ZQI5RRj4kzfhxGB1fytymoFZfpR6DG2tQfqZI+P0uLXGbY2KSkqx7zO5mJoMeX12If52+/3vN+XIPJrmi2q4c1LG9bb5kQhfoB/Ml2BI8h4jCX0Y/hHNQwzMIOpZjizn7oEqZAD5lerKEpyIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vh7iSdzvr7okfya/6V271OzBWagVp/6n6bZo6iTlwOw=;
 b=QJXybN+bwxGh2JG4NfhYFXb9qOwJy7QOV0phZf46c1TD/NtllQ+F2bnot9vHr14Bep9k//gwSZtHGiXYTOZKBMIawAPHcaVkD/iw8gB34JT8zx/uBxG9eJm83M9rrbUOcktZAADRrs/oZkiN2yaVk6V92FCZ/BAkuS2iDytfWNg=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by DM6PR10MB3387.namprd10.prod.outlook.com (2603:10b6:5:1aa::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Fri, 15 Jul
 2022 13:11:02 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::80e:be92:1fd5:b066]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::80e:be92:1fd5:b066%5]) with mapi id 15.20.5438.014; Fri, 15 Jul 2022
 13:11:02 +0000
Message-ID: <3be61417-6e58-1d9f-dd3c-7de00daa8d0a@oracle.com>
Date:   Fri, 15 Jul 2022 09:10:58 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH] x86/xen: Add support for HVMOP_set_evtchn_upcall_vector
Content-Language: en-US
To:     Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Jane Malalane <Jane.Malalane@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Maximilian Heyne <mheyne@amazon.de>,
        Jan Beulich <jbeulich@suse.com>,
        Colin Ian King <colin.king@intel.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
References: <20220711152230.17749-1-jane.malalane@citrix.com>
 <272ea76d-0099-873e-b8a8-1cc43b7b1e11@oracle.com>
 <0b5ec408-197c-7e34-28d8-7505e1f031df@citrix.com>
 <01cc9e39-242a-3cbf-13b3-cb3ecccd5737@citrix.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
In-Reply-To: <01cc9e39-242a-3cbf-13b3-cb3ecccd5737@citrix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0188.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::13) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ce6f684-995a-4d8a-3a33-08da666377ba
X-MS-TrafficTypeDiagnostic: DM6PR10MB3387:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xHcZUSlXQ/MoX2tNAkSdvH+5k74yh+JrOdTnVtxj89rEVEJrX8NxW9AGQcXVqeod2vUGPDYMURYlajogtAfROIwLWlfBHCg80i7LY0b7ThuuhfG3ia6gE2iWd/mGf+9F/8NJ8CUz2QCSHUkL+Lk7ZhCDxkatblayMD6XIZDR4kVZpulieYk5ck3uOcu24ebtvmAOuL0UV+9kYsQWnTD9DFc9/blTnG/tuw4N8AsFGSnDn55OhJDM8lyHUNJ7ZQyGAgM4nF/obDdDshhtT+G1icrrZFyrK0bicCbAmzFLPADSzG1stEdqshdk0PXodO4DPfqRBPCIBq1LsOvXHk669VUrMFxMbQhMffFe6PBxXjQS+OojMk1eK0mxugerB9xDST+0oV0UuYuKluFpdm63RUsuJOKUwse6kXQbFbBSfLei4tEShkMNY0zCJ1iTeWaltoVpmhXRdlDPmPJICogEDYKmpohzt6D9Ih2YYJ90Lwywa42/TJI5/gx2c45hgMClefV2gH7QcYGp7J5iUZ1XUzay7Ao8xeNSGruyFLnTrcY3BZO5AVbmKKkcJDdMiC6+9UmzAllRZpJUBgdKHSlxKrTMeTm92qTAqyM37e2LrFMgrTo/IYFaPz33NjrqQkp76Bwf7lW48UAmucONsJVO5DMQvAuFMozmDFzeu9SbSVDOohfZclfIgOBBNuHZONfsWNSJTQybxLFbBd+NtdEgddAQjTmw5cVX6rmpUT+euXEFFeSkFMYrQ72JuR+up2Fg62qovy8JYxqKTvVLfLEdC33Nb2cU0HxQHTCB72XpObeche7NrJ1pz/CWU1Wx/K+12B7m89YilVK+RmV6scjrXWpCN6qLj7llWkxz3C3DANE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(136003)(366004)(396003)(39860400002)(376002)(186003)(44832011)(31686004)(36756003)(7416002)(2616005)(38100700002)(8936002)(2906002)(5660300002)(26005)(6506007)(66476007)(110136005)(478600001)(8676002)(6666004)(41300700001)(316002)(66556008)(83380400001)(6486002)(4326008)(66946007)(86362001)(54906003)(6512007)(31696002)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTJtNVNiYzBOanBjZmF3K2cxNVl5dUNRS1liMHdQVWlJc3EvRWV1QjdOaUc2?=
 =?utf-8?B?UjBWT1dIWFhPdXhSeXAxZnhzNDFCdUkzTnQybU85NTM3VWJjQk1wb3J2WUg2?=
 =?utf-8?B?QnBMTkk0dVczcit0azhMY3M1bjViWmgzUGxkakxvSkFLOENOVWo3clpad0Ri?=
 =?utf-8?B?UUltRktyTWtVeXpnOW1zUURDeWFMa1NSd2hyeXhrTjlWaFZ5cDZVOFJYWWJq?=
 =?utf-8?B?d1N3YzVzVHdzZXV0Q1dyMVAvaVFwbms3M3VsVlJ1d1RBZForS091MnRyNnFZ?=
 =?utf-8?B?Ky8zMjh5V3I2c0ltMXQ0SGxXek9YNnJVLzc0QlZTVnBiU3ZiTDIzTHF3OHB2?=
 =?utf-8?B?MEVKbGhSNGF3OHE4aG5HTjZZcVRwbFdNdURwUmVhWDVVSHpwOTY1UXhaK0h5?=
 =?utf-8?B?TmtIYXplOUxBaEpNNGV0WStoVUYvNEQ3cGQ1WXlnUmtVa0c4NFFzUVNMQlcy?=
 =?utf-8?B?MVBLZjNPY2pnRkVhQXhzd21pdUtkdUloSmp4eGcyQTZxMmRjVHBzODZFNHBJ?=
 =?utf-8?B?WjVGcmJqTGRQRHdlUjVYMzZ2QlV0ZlpjUmkyWXlzM3hFZUpIMzYvV3Yycktu?=
 =?utf-8?B?NDQwS296RURUaVBNcVkvUVU4eXlaS054RzJMRTVkWmJNcUZyVHBtSm1yVTBh?=
 =?utf-8?B?ZUZRVXovWjBpbVlvMXBrVXI5Rmx0NUphQ1NWbmxrN2ozS1I1cnRZeXRQTmRV?=
 =?utf-8?B?c0pFSGE5RGxFOFhZWkttRGhXbTVWZFpaUDdUdXRzajQ2YTlxL1paNTA5aXEz?=
 =?utf-8?B?Umd5dHE1MFhzSXdSWHJXRFhtN0ZhVkhtRmdFdTJiWFNxMWFMNnhwbU5NY21x?=
 =?utf-8?B?a2owQ1lIMGJwcDV0cGE1ZXRuUlVCcHpXL1JzaTR6SDN0bDdwcW5IcklFYmpv?=
 =?utf-8?B?ZS9FdnhPVHVJR0RwVTk1SG5IZkhMQW9IcmM4TjB2L3FMSHNVc2tMMVZnOE42?=
 =?utf-8?B?LzZXS3RsWHBmRUEzRmhjd0xtRG1WSU1ma1g1ZzQ3TmVSa0l4T0Y1MlZaVFZ4?=
 =?utf-8?B?U0NkaXZKR3ZidkloMFFmWGg5QWVkcWpzNVF2SUlZWW0xczNlaklzUXJrc0Vs?=
 =?utf-8?B?bUZIWlEycGVzeEFpMW1NR2RuQS9vYStaTGphSGpsZDVSRXFEazM2bWp2Tkw3?=
 =?utf-8?B?alEyRlNCSnlka0s3U0tORmNHcmJ1N0hwYTVuV3dVRG16eE4rcmFJdk13RHhD?=
 =?utf-8?B?RjFlSjNQV3VQNWR1eXhUZmFXMlhXamZjMW1aUmd0a2RSRmlweExBaHJKNDNn?=
 =?utf-8?B?WEhOejM3WDZyc1JHK0I3VE5QdHdBNWVsUnVINWlhMmFWZGk1NnFBNlprSllJ?=
 =?utf-8?B?TTNNdVA3TVJQSWVXRlZwKzBGV1AyWGlCQzlpWmN4elhBUFlWWHdrZ0ROSWlM?=
 =?utf-8?B?am9lZEplclBqSWt6NUxqcWRralQwNkppbytYQ3REN29ad3lFbzVJaVl3QkM2?=
 =?utf-8?B?VDA4TTFqUXZMYlFORFdHeHY3K2FuQmpFWllKamdYaTB0ckUvWFhlVmRuSFNs?=
 =?utf-8?B?TUNxbkFiM0hEZHMrcThJVUlVTWc2ckZDeVVWa1B2ajJxU0pPalY3SEtpVTBr?=
 =?utf-8?B?TUN6bWpJT2c0RXc1VWQxU0l5cXQxRkUwUkEwY0RCRVZPanl4Q1hsMzVYRWQ4?=
 =?utf-8?B?KzRjSm44b05wOUJNZmI0TWNmVHZyeCtNbWN3UnBGSWlXczVVMFZSWVVPVHpx?=
 =?utf-8?B?RU5kQkNmcG5vVHpjNVRKb20xWkVXZ0xCWXQrTVQ1NTJsUUFDY1NIVzdnU3dp?=
 =?utf-8?B?YjRTTVhraXdJM1BTeXNtVHBLWlphM3NscmhERlVQVmhGZ1crR0JmbEsyNlgy?=
 =?utf-8?B?V294aVc1cDBVclJhRHRkVkZDRzgyVVFMK0l4cnd5V3FjbHoxcmwzdC81ZkRM?=
 =?utf-8?B?ekZGT3M1VGJkT2cxMkxhUEQyeWFCTVcrb3JVTHN1Znd2eWV5QzhaQm4yb1A1?=
 =?utf-8?B?UWJGMVBCNVV3NGdXSFQ1c2xicExCNU50a1czZ2M2RW5HTldJQTkrcUM3NGhi?=
 =?utf-8?B?bFhHUUlkOTZmT0tGN1RWVVZBemc5c1FiNmJiMUJ4dlIrMHpOamlqQWpubjA0?=
 =?utf-8?B?QU94aXo2YjFZdlc2WlFZUkNuTUxFS1d2aGhUbjF5QmtYQUdvTDZUWm11TXdF?=
 =?utf-8?B?YWJqR29IUWwxVWtxTHJBZWl1cFRLQ0NYRzBzZ1l0dDU2ZG91dDNaMnNZZXpm?=
 =?utf-8?B?b2c9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ce6f684-995a-4d8a-3a33-08da666377ba
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 13:11:02.4241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T7VAEVTM5e1rT8TKWch4Wys3WzAbejtey+tW0UPgqLe+Saw6D45uHu+Zx1vjVg4FcieWmuVuBPqeBbnWyJcDq/I4rByjXlmPFqxtqDD3mfo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3387
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-15_05:2022-07-14,2022-07-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207150058
X-Proofpoint-ORIG-GUID: wumeSia-bQlmqPpV1mP4ekre0fCVp65j
X-Proofpoint-GUID: wumeSia-bQlmqPpV1mP4ekre0fCVp65j
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/15/22 5:50 AM, Andrew Cooper wrote:
> On 15/07/2022 09:18, Jane Malalane wrote:
>> On 14/07/2022 00:27, Boris Ostrovsky wrote:
>>>>        xen_hvm_smp_init();
>>>>        WARN_ON(xen_cpuhp_setup(xen_cpu_up_prepare_hvm, xen_cpu_dead_hvm));
>>>> diff --git a/arch/x86/xen/suspend_hvm.c b/arch/x86/xen/suspend_hvm.c
>>>> index 9d548b0c772f..be66e027ef28 100644
>>>> --- a/arch/x86/xen/suspend_hvm.c
>>>> +++ b/arch/x86/xen/suspend_hvm.c
>>>> @@ -5,6 +5,7 @@
>>>>    #include <xen/hvm.h>
>>>>    #include <xen/features.h>
>>>>    #include <xen/interface/features.h>
>>>> +#include <xen/events.h>
>>>>    #include "xen-ops.h"
>>>> @@ -14,6 +15,23 @@ void xen_hvm_post_suspend(int suspend_cancelled)
>>>>            xen_hvm_init_shared_info();
>>>>            xen_vcpu_restore();
>>>>        }
>>>> -    xen_setup_callback_vector();
>>>> +    if (xen_ack_upcall) {
>>>> +        unsigned int cpu;
>>>> +
>>>> +        for_each_online_cpu(cpu) {
>>>> +            xen_hvm_evtchn_upcall_vector_t op = {
>>>> +                    .vector = HYPERVISOR_CALLBACK_VECTOR,
>>>> +                    .vcpu = per_cpu(xen_vcpu_id, cpu),
>>>> +            };
>>>> +
>>>> +            BUG_ON(HYPERVISOR_hvm_op(HVMOP_set_evtchn_upcall_vector,
>>>> +                         &op));
>>>> +            /* Trick toolstack to think we are enlightened. */
>>>> +            if (!cpu)
>>>> +                BUG_ON(xen_set_callback_via(1));
>>> What are you trying to make the toolstack aware of? That we have *a*
>>> callback (either global or percpu)?
>> Yes, specifically for the check in libxl__domain_pvcontrol_available.
> And others.
>
> This is all a giant bodge, but basically a lot of tooling uses the
> non-zero-ness of the CALLBACK_VIA param to determine whether the VM has
> Xen-aware drivers loaded or not.
>
> The value 1 is a CALLBACK_VIA value which encodes GSI 1, and the only
> reason this doesn't explode everywhere is because the
> evtchn_upcall_vector registration takes priority over GSI delivery.
>
> This is decades of tech debt piled on top of tech debt.


Feels like it (setting the callback parameter) is something that the hypervisor should do --- no need to expose guests to this.


-boris

