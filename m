Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 992545190D5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 00:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243158AbiECVzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 17:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243312AbiECVxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 17:53:36 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D75B43492;
        Tue,  3 May 2022 14:49:43 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243LFfTf018740;
        Tue, 3 May 2022 21:49:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=5ysg2ejlqTYBFtw8Z/kLbfRgZonrHzA6mPYFANHNAgM=;
 b=Yw1QyXVoJaH1AGQxwqSGZgQTkB4BypwHwUfsU8iH7yGc0w0LHLAppblctBSZplsX2kWo
 TNDTlWYbWIyAw60ifAX+Hg2dQ0PUArflZ2icoA75GuLL4+VCJxgR+ryCi6ahXStJ0AZD
 +TjRYKA57AByZ4dGr11RSVbpO+l3Lnn5SOhy5unBfFcEchn/6tofxKQfasyE2MtGRq2M
 xTFlNxulCdmlJhCR1BuZ4hDn+Vz5N5A10S14Z3+s2Tu/YPz6KzBVPRvuyMEi82LcJyGH
 Ssoff9SQOxce3giN//0PoEHga1pi468eR5HcPiuyEn8ahE60BaRFzufMDBkhUEl1wwJB 9w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frwnt6w03-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 May 2022 21:49:24 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 243LkSMk008873;
        Tue, 3 May 2022 21:49:23 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj9cngh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 May 2022 21:49:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JTvP/S6cSyz3lUg7+iDzMGSaFmPDkJNRGEZC6DANo/vRDhETs5lfJkEncOW4gk0t/c7yo1imm9WTWwtpeHOidgqp0bl74CHSw6F0psRFvwl/E2FhpQbesZQujLKupLg3kayFHbF4kh+ThU8p8oIV0WJIUkXpaNKRnA6/y4tZ7kALzo63n8cBIlPuZndjJC0aQDYnlwtvGjNuSk0LN1vfJJ1qhnWeglCO9RBCZEPEzEL6OmC/EJK18+mEBp646owwzqPqdh1uYkNkCmf67nV7wcoS5RFMMDOi5kDj0mE3ulMmyC72XLZu5KMk4oqJYuYYSTzh8RVsFT1nIZPpSmfdZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ysg2ejlqTYBFtw8Z/kLbfRgZonrHzA6mPYFANHNAgM=;
 b=YVLscVlARWk2bVSoK7I1TARr19NbnDynDWMfVb1DgDsLQU5EYV0a3pelRkEG94VxSOXPN8JQ2L9uOPmy3jFcnXOK5aCRYN8ZHHXoouSaL3YP+8tJxyjrXQLBv+r6LniakNJtK0KA6j5KLj/410DMVPaDGwghopgWROhq0hcIcpbEp4dfl+0OMmrDoTXrPUJfpaTXqiO7WlgnzEx9GbRxwyN8rZ6QrVrRX/0aAI6YOQaW0CrmYkhJR+k0zotGgQGez3HM9lAYp8IDeJ9N0gScFzB9qxr/ImTDF5ptycdhCdWpdcLixTL1fXE0iom0Ow3RsVZarpZNy+voj6z+yzjFNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ysg2ejlqTYBFtw8Z/kLbfRgZonrHzA6mPYFANHNAgM=;
 b=XPlA54dKr7M7tDnMi4LKJZUMAxwjyc31wM1YMVeI5hI7MddVYoejP+SXTRPnuMQKvFDV0HdkXDBo49rJNXP8+AGYoC/xsAY7E/bFCdCZ1Q3pUfBhiW5bxMIo9c4Jkjjfd8R6U0BNiRUfebQIABUzZX5rrI1VvC7MN20mcDFxOmM=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CH2PR10MB3943.namprd10.prod.outlook.com (2603:10b6:610:c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Tue, 3 May
 2022 21:49:21 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::9d76:7926:9b76:f461]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::9d76:7926:9b76:f461%7]) with mapi id 15.20.5206.024; Tue, 3 May 2022
 21:49:21 +0000
Message-ID: <60998a62-eebc-7c95-2d48-943fe62d09b9@oracle.com>
Date:   Tue, 3 May 2022 14:49:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v9 1/4] mm: hugetlb_vmemmap: disable
 hugetlb_optimize_vmemmap when struct page crosses page boundaries
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>, corbet@lwn.net,
        akpm@linux-foundation.org, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com, osalvador@suse.de,
        david@redhat.com, masahiroy@kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com, smuchun@gmail.com
References: <20220429121816.37541-1-songmuchun@bytedance.com>
 <20220429121816.37541-2-songmuchun@bytedance.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <20220429121816.37541-2-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR2101CA0035.namprd21.prod.outlook.com
 (2603:10b6:302:1::48) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14d994e4-73ef-4bfd-4be7-08da2d4ec811
X-MS-TrafficTypeDiagnostic: CH2PR10MB3943:EE_
X-Microsoft-Antispam-PRVS: <CH2PR10MB3943A2943B29446FA2C3DFB9E2C09@CH2PR10MB3943.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BUeDBCl6gF60IueU3n6vXVneEkplZpEsH8pkb3WAXay8fbTqAqCeJTsM9ACMkZi0dCVFOgJiL3qkYJ5ZpmBtYXYpM2yqMDvaGTsvUNiau5vATlgc+6uN2NeIXkzgxphrxCYmawyB7jwiPLp7eM4kWW8/UBvS7KI1H48wJAwDEKppbgRbYxzBlLB97KXJxlnhp6BUgMiztmbaq07fvD9bMBJ0Hx3XdON9OgJjjR6dI6J1JnXYvRlh3KOTiqs2D1EBSWHzqVrVdDDzvxsbTTcMzBLGxtcg8DGbGT3Hx0jTaZSYnHQZwImL6XstDEbCX/k0i+Er+rBFdMnGUFi3Wg4z4DXeau6CXi1U3yppGWpHrSyAz/U2UOMqsR2+IDAuUd/E4962UomTU/Qmv9QgKtQ9me6NSFAEufvoohwD/Q6LZsVdP9yQE3PJQOUrxh+ZegsbJNnZo/vUlR+gIsqjEXNp6G/iP8CUmxPt81xvUq8o+xZoq+bjDqfEDOfHMQTi5H4yokeQ76dzS40THWvFu9h7D8pviTRkrsKTWbOlIKInRD+sIGAf9xP20kBNXGXPu/ZJ1maKGwQdUeSEjyvca6cggpIY4CRlN4UTKaH7TDwO9bMRQfXPfh4MexGYECidgYnZkfeeg2if2tU5bZ3pHErz8oYM3zz8hMlljAVaNymbDFnd0MUy/77SO1tnqbfbtRjiUqa5CTOqwNad1EoMlds5+4KD0BM0wpfKYGqp5+imNvBZty83Z2/RuUSFa2JFJioPsKkpqPGYxCziu4LcYSRGTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(53546011)(6506007)(6512007)(26005)(52116002)(2616005)(8936002)(4326008)(66556008)(66946007)(8676002)(66476007)(86362001)(83380400001)(7416002)(316002)(6486002)(5660300002)(508600001)(2906002)(38350700002)(38100700002)(44832011)(31696002)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWJoS0x2cWwwQlAvSjIzVjFSYXlBM0hWN3MrS2t6bVY2NnRHeU1xVXM0RkFr?=
 =?utf-8?B?VGphWVpHMkVwczNzTG5oZEZXUmI0eGg3YUVLWlhJb2g5YXBLZzFGQ0xzT2c1?=
 =?utf-8?B?OTg0K1hLQXhtZTZERk9rWGZkeGd5a0hoVElYZFliWnA2R2h1anh2TnkxUnNr?=
 =?utf-8?B?UXkyR2w3czF6SyswNXYxT0VRWFljY3R5R1FCdDREaWgrcVd3TG96b054dkVn?=
 =?utf-8?B?L0tKWU1jUTJoeVkxa0NYTjQ5YWk1MXBpZk9YbnJxeFpQNWpPUWhRaHNRaVhO?=
 =?utf-8?B?cGpOU2tlRE1kVkl5bjlNb1QxQ2FQTVpOR2ZjMUp1dCtYeWZKdTNLTDlzdXhp?=
 =?utf-8?B?QjJFMU9SZEFmMVhLQTVIdlN6V0xZTTBpcEpQMng3Q3d3SGNHKzNVaEdnYXJr?=
 =?utf-8?B?elFVTSs2Vko1c2o2WksxODdHa1ZNWEJLL0ZCazl0RWtLNkRyY3R0QXhJRCtS?=
 =?utf-8?B?anllZmt3N09yNXZ0VnRkZnZCN292OFo0bjA3NkFRc0dBWTRaQ0I2eUxCd1Fs?=
 =?utf-8?B?S3lhN2t1WVFXWFZkcldVY1d5a1lnMTVDdFpkOUtBZEVlMWpxdklBOFpoaHpi?=
 =?utf-8?B?WXlFL2RPa0NPOXFVckJjSjQzYTMwSG5tOVlrL0dVYU9vUUx5MVRVUThtUVRX?=
 =?utf-8?B?QWxuVjQ1SmNzNHpvK3JtRFYyRDBNbWlTVWJ3ZE92TXVob1MwSVBWaHk0aVFh?=
 =?utf-8?B?NG1KcmhpSmJmRmwzTW9IY1NmL010WVN0bjV0MVJKWHVxRzZYQkpQS1B5azhN?=
 =?utf-8?B?K0QxYnV0TnNDY2NOWEdKTXJQZnp0NE8zakdsaGNGUGFjazE4ZEJkNDdVWTBk?=
 =?utf-8?B?OGgzRlVoN3ZPUlk1ekJuc3dDVkRVWjhieGRhcDlGRGVNQjJOTlhieW5jbnkv?=
 =?utf-8?B?Mk10VjZEMFFlaHFSWXFCSzVzWWlJRFBPN1p4bFdXV0tIWlJySTZ1T1lEZEJO?=
 =?utf-8?B?RDBjWUFrcE5JcThNVDM0aEtrSVlRbTcrdkRjZVNkUUVTM2lXQkZtT2xXWENl?=
 =?utf-8?B?ZW9OR1RaLzQ3TzJWR0EzZWZmMGZMTjVQN3JSYVhoQWNrVU5KeVBUSGhsSGJL?=
 =?utf-8?B?Nk9EeWlZTCtYRVhyU1V5WllaNk00WFdzZ1RVSG9VdUpMYmJIbVZXLzRGNFl2?=
 =?utf-8?B?R09BcjUxVFRodFIvZTl5ZUFMYkQ3M281TC9XditaYzF5SG5EMC80V0lpelJM?=
 =?utf-8?B?SVd6a1ppQmZWQUh0T056NUdkUC9XZ0FtVmQreFZKdnZQMFZ1NDIxRjRaaXRt?=
 =?utf-8?B?VHd5TWx4eENDMWlEcy9zQjU1K253T21oOGhSTElzYjRsM0ZUcEc5cFdaZGtH?=
 =?utf-8?B?cEh6NGx2dVc1T3FoclNyakhpem1MNmNCTkJaWFNxUUh0dW9OeDdBbDh1MXp2?=
 =?utf-8?B?K2RTM29mZFVyWkl3dGF6bjQ5b09aYmtyZDAxNTdwdG8rVTlVOEp0TklEcGtT?=
 =?utf-8?B?RkVsN1RubC84STlRVnpVSDRMdkNIaWNSM2RsWHlhaHJ1blcyNnlyK2szNFI5?=
 =?utf-8?B?K2g1TWNETWtPbmJDUW13UGVlMG5LRGRmcWhlRXBXSEF4Wm1UQnNkdDQyT3Jz?=
 =?utf-8?B?alIvK0xnR0E4RTlEOCtpVTVDWGdPWDNuWndBeldoTjl0R1l4ajNOMFh0WHVl?=
 =?utf-8?B?VlNaK2xBTWNoUjd4YkVkdFBEWG14cHFNSjV3bkw3NldIYWt4a011S3NiRkdw?=
 =?utf-8?B?YkxrYVNjVEdhVUY4d205NWo2T3pQUjBEdC9laStlWDVONzNzZXlPSmZUVU5T?=
 =?utf-8?B?Ymo4TnVpVkUzSEJEb1RLVWcrOHV1MzBTY1VIQmcxQkFSaEdZb1FCOVp5ZHIw?=
 =?utf-8?B?MFN0TzJVQ05rbmo5NkZSRXNQTUQ3cXpjUUJ0NU93SytRK216MlVVTS83eHgx?=
 =?utf-8?B?TVQveCtEK2x0Vkh4bnVYSDhHUGNvOVlRc2RPY0VIVk1mV1hRejJ2bFFDUmxR?=
 =?utf-8?B?S3RFS1FHL0lXUXBvVElmeDFzU3BNaHpzM3MvVko4RUpiaTlyMUdPZnFwOURp?=
 =?utf-8?B?UWdhRzRSY083VkN2VFFlWitXV0hua0JWT3BNZEU3a3YxaVVnYitmQXBMbzRB?=
 =?utf-8?B?a0VBRFBVVE1tNFp4RUZkWnFIQ3Z2Y1lNb2FNR1JnbUFtR29zMFhKU21FSUx4?=
 =?utf-8?B?R1UxdUEzVW5EWitWeDFPMW9MRndZdzJHcFdYVG1MM29SSU9rbHh2Y0JETGdp?=
 =?utf-8?B?QTFPNGxWL3BZN3F0QkNYMjNZeVJTNk5pZWo4YUROaCtVVWIwWS9yb2tzZ2Yr?=
 =?utf-8?B?N2tCTWtLdWFtYmtIazNCWnloYm5BTVdScjlrYkZlcDVEMmZhdGlvNFdYQ3Bp?=
 =?utf-8?B?ZFR5c25qRXZDR05KN2Y2cEZ6TWg1SHJLTGlsTkRyemZzSTVKSFNCVjl0bWlZ?=
 =?utf-8?Q?zEWJO6stQqkvPELI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14d994e4-73ef-4bfd-4be7-08da2d4ec811
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 21:49:21.5518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kteL85l+GsI6eU0zb3R9EC9U+nuR4hIFDE880ma4cyfX/zgkwypisgXYL87xjQ0cgfQtvLW8cuA8/Okkty2YjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3943
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-03_09:2022-05-02,2022-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205030132
X-Proofpoint-ORIG-GUID: E6C9IaDOW3n4DLoRsMTpGhgyN2UDhNKJ
X-Proofpoint-GUID: E6C9IaDOW3n4DLoRsMTpGhgyN2UDhNKJ
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/29/22 05:18, Muchun Song wrote:
> If the size of "struct page" is not the power of two but with the feature
> of minimizing overhead of struct page associated with each HugeTLB is
> enabled, then the vmemmap pages of HugeTLB will be corrupted after
> remapping (panic is about to happen in theory).  But this only exists when
> !CONFIG_MEMCG && !CONFIG_SLUB on x86_64.  However, it is not a conventional
> configuration nowadays.  So it is not a real word issue, just the result
> of a code review.
> 
> But we cannot prevent anyone from configuring that combined configure.
> This hugetlb_optimize_vmemmap should be disable in this case to fix this
> issue.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/hugetlb_vmemmap.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Thanks,
I think the runtime power_of_two checks here and in later patches are
much simpler than trying to do config/build time checks.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz

> 
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index 29554c6ef2ae..6254bb2d4ae5 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -28,12 +28,6 @@ EXPORT_SYMBOL(hugetlb_optimize_vmemmap_key);
>  
>  static int __init hugetlb_vmemmap_early_param(char *buf)
>  {
> -	/* We cannot optimize if a "struct page" crosses page boundaries. */
> -	if (!is_power_of_2(sizeof(struct page))) {
> -		pr_warn("cannot free vmemmap pages because \"struct page\" crosses page boundaries\n");
> -		return 0;
> -	}
> -
>  	if (!buf)
>  		return -EINVAL;
>  
> @@ -119,6 +113,12 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
>  	if (!hugetlb_optimize_vmemmap_enabled())
>  		return;
>  
> +	if (!is_power_of_2(sizeof(struct page))) {
> +		pr_warn_once("cannot optimize vmemmap pages because \"struct page\" crosses page boundaries\n");
> +		static_branch_disable(&hugetlb_optimize_vmemmap_key);
> +		return;
> +	}
> +
>  	vmemmap_pages = (nr_pages * sizeof(struct page)) >> PAGE_SHIFT;
>  	/*
>  	 * The head page is not to be freed to buddy allocator, the other tail


