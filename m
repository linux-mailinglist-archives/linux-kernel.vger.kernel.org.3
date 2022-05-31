Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3DF53953A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 19:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346383AbiEaRHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 13:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346315AbiEaRHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 13:07:18 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2FB6813FF
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 10:07:17 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24VFv1qj028638;
        Tue, 31 May 2022 17:06:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=8U4ZGWQJX3FXNtClj998oVsookEPx3++d28pe+AyIWY=;
 b=Z969OfS6XwwyRV31HhuoM4tJ89RVdQakhKlYtsgX/4uJ+8xYCVlIuS3CjGpyCDzbZjs+
 IRoIml83zMOZHpNtw3wqHC03BcqMlAiPPzvpyiLdviJN38aakKZlk43lbPhqpBSUlkWV
 lmSE4jJ8jzrQ9QmdsZwp9yuHXd9Q5XBuxFNRsDxpm1HkmLsK+rpXAzKFylDWdVgt/rq8
 5/xcunkFT9tnzqmbVTC4yMmP63cqQUKuOk4XM08fj+DhIZdPmPnCeO7Di24h/mOiBnv4
 iVS7O1bgbsaZ/worGoORWPootMCQe9O3REnTS15KXmckq0nWzezIfMNa+f4kL2id/rBe WQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gbcahnqvg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 May 2022 17:06:57 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24VGpSDl036691;
        Tue, 31 May 2022 17:06:55 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gc8jxfec6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 May 2022 17:06:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UMumAKeI4aoaaSrTxmfVanEo02m/DWUi3iDeG23mMFZg3iuj1YoyH0mspTCB0rN+VnlaCulnwr3kT7Har6f2BE2kgXP8IKfC+ZrD9L4xEiPJqd8sZOeenaLAtoRngbK0icNLZvsLr7Z/d2w9hztDfdvbXid10GQOA6sLMYzRAc2MwxECymMx0zCtWlFocJEKQsbwK1PqJiUdwyjb4ztm3p7ihMrRpp2M+s8R6PYfrpWDXrbwkW9GjoaV/Y0nxMxBuSt9p17EN42iUjpKaSfCnh3pOjbZsayGSBZyZkjdd5uBJ0F26ofjZj5vK7fyp5quyNk9AeyEsIu4kfUo7upa7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8U4ZGWQJX3FXNtClj998oVsookEPx3++d28pe+AyIWY=;
 b=nHnoXQhbpfYxtEt8FDynz4RMjORVrX5xfv3wbnWgLoi8vPPWDqlXVLXXSaAjL87+lDbU1zlRGxU6IVxn3IuW6/Q6K+aZ97Ups5hobZHbgxZJ41y+oaBGjH/WKm+knixwbOfY2z+/wfk5FPN+sBEis2I0GKse/c3/ryUQaWfhnKZaRd/MHXwUD8agz5LwsrtMn7yNEKUuhFH1wzRNaH9Zh6YCBsL4Dt2/fv2Pn9jHGO2tB228ABRzkLE78ssPYbXUpnV3JR9FL9KYWObtDTtGec3RdmIKHt/3aiPmQ5SGBn6oGdMqxCgCHuvlyPa5An5S5Ck1LZkTjeveVGmKgSFtwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8U4ZGWQJX3FXNtClj998oVsookEPx3++d28pe+AyIWY=;
 b=Owc8D5ZvZFl706gyZ3BCA8DwvGTmhaS/NfcBcp5YXQ3XRvMEfIEU3zE26e8exokxnOHgUXEi6kfwVtPF6nIWw3/JOiHCquE3ZNkkjztUpWaxyREnohhOobHfU1PKyYNiCSmgJfR8mheCQoTS3s8ZQC4M3sM/I0/x2sxdi9w1vhc=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DS7PR10MB4895.namprd10.prod.outlook.com (2603:10b6:5:3a7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Tue, 31 May
 2022 17:06:53 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9%9]) with mapi id 15.20.5314.012; Tue, 31 May 2022
 17:06:53 +0000
Message-ID: <069d55ca-ca62-0841-b52f-c4352f37959a@oracle.com>
Date:   Tue, 31 May 2022 10:06:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [RFC PATCH 2/3] hugetlb: do not update address in
 huge_pmd_unshare
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        James Houghton <jthoughton@google.com>,
        Mina Almasry <almasrymina@google.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220527225849.284839-1-mike.kravetz@oracle.com>
 <20220527225849.284839-3-mike.kravetz@oracle.com>
 <YpTki4Tvv2muTeJu@FVFYT0MHHV2J.googleapis.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <YpTki4Tvv2muTeJu@FVFYT0MHHV2J.googleapis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0017.namprd16.prod.outlook.com (2603:10b6:907::30)
 To BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 275ad877-5b5e-4384-c558-08da4327f5bc
X-MS-TrafficTypeDiagnostic: DS7PR10MB4895:EE_
X-Microsoft-Antispam-PRVS: <DS7PR10MB4895F277479B9B2BFE68C39BE2DC9@DS7PR10MB4895.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b0cnk4c98TsZcXBBbs59pkwcyGEZTRb0cLhwYfJ85bSMlff0352olJ6eMS8V7IkYSWPhnXMlpa7nxM5BgTOydUwk23OWf/eWCv+VTN8COrs+ejbNnXYxwp+e6OgYgB49egoowQG1VfOhiAX2HYjgEdXycvTkC5kV7H8GWe43ZZNWWBOEDYDxVs0VN83r4r9xi4/Z2rDU+TY0kSdqz+MuwRozkid/bDFtNgaSPQWcForC8HsycmZra7okJbIObSs5gaHCEfg/23n+Lag4fW0ilfTCL2z6bM7YDJUwmTOHjr1ydTxwzbazhBWH/hE0hCb7DoPrNRMW0kwdlqQhonuYEzpIoj+iRDCLI0DnG4znp3vzy8KTfO/HBCku3fef27z068YhSdZc/ZOg9MVlatqm1/6b66NQNOf3JQE2FnE/9SeZ3kUvxOu3+K6xUxB3msIX4eYCehB4aqZJBUOFHYdPM0LvTNSCO5g99OHheNiuJEdymVq+nxP4Rf55KymR3Vzk4GfIFeJUMe81f66e5pLlHESgRkhiZHynSVtEpEDjAkS0Ge6yxuUfsEmbTAz8sO65VxQVXCdAJ339TSD/dDJyMsTkN28pcpdOjp2WVrMijiHDJ33MNTMqpt2hyuw/ndTdJC5w7aQuWEiXzhNZidIbita4Ksbrhi+QUBL5gxk/U+q3oMUzy8GuNw/XYw9j/j8Bkx/woZnlqpc8FUZVcZ2dNPO+O6XTDo5kdN1EeC5Q/qVys2O6xKSfE/pWeOm4h7zI4xmifKxV4ipd0KfM4iuOvkZONmx2ZN+Ob1oXNIlwyRI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(186003)(5660300002)(31686004)(2906002)(2616005)(7416002)(36756003)(15650500001)(44832011)(8936002)(31696002)(54906003)(316002)(6486002)(6506007)(66946007)(66556008)(8676002)(6916009)(52116002)(53546011)(86362001)(6512007)(66476007)(4326008)(26005)(38350700002)(38100700002)(508600001)(14583001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c29SbkRQODV1OEY4aERPZytXNDRsN2dPajl2MkJ6LzVwYWVVMHk3RW1Bc1VT?=
 =?utf-8?B?alUwN1cybDk5NExUS09SUFhGTUh4Tk54RmRMQytVMnNCWkxZUFZidHBvRml1?=
 =?utf-8?B?T3o4UEUxdmVrcVIyeGtQclNCSERNbUZyQUlSWWxYQlFnUUF3cWhFcUk1d3Yz?=
 =?utf-8?B?Z2NDcHZBN0d1d3paRE1zcTRSNEV1eWwyU3VwbTN4cytUS3FvTU1sd2RvSTN1?=
 =?utf-8?B?ckxGVDVYN0svNXN5bE5ybnp6dlowMTFuci9wdGMvWHMzd3M0OVNYQzRFSDVx?=
 =?utf-8?B?OG9RZkFOSTcyK1gvWmRudUx2U1hPTy9TZ3dORHBYN0RuTXZyU2N3QVB0OHJj?=
 =?utf-8?B?dXZxd0VCQTBySzVWY0RuNkV1THE5dzhwNFNIb1ZOQ054WWVtR0pOM3lSd3VO?=
 =?utf-8?B?U1Q4UzFPMFVSdzNKTmVGNlNqbUFYOFhaM3cweDJwNVpGN3VGc0NlZlBvZEgv?=
 =?utf-8?B?MklBMHdTK0dva1hkeFZqbE5WQ2hJcHJvOFhGUUd0aW1FYWxqT3MyZlJXMXBH?=
 =?utf-8?B?N0NnNXI4MUM3bWtucDl0anJqOXU2MlBVQk9DZWpGRXFERVdSZjJqQkxhODZX?=
 =?utf-8?B?amRnZlN6aXVHbkpGV0VIajAwMkF2U0FzRGx3dUQxcGoxLzJBZDk5K2phWUZz?=
 =?utf-8?B?YmRzRFd5MnQrV1RNNWhzcC91T2l1OEhRVzZmVnQ1OU9wZ2h3YjlYTUgvUGFr?=
 =?utf-8?B?SUIvR211ZFU0VTNDTEd6REZLMVRBZ2g4amd0SUdGbm1EZm1TMEFCN25FVnlo?=
 =?utf-8?B?RnFyYWhWMXlDQ0Uza0Juc1h0eDhyQUphQ0xRK0tzOGJvUnY4ZSswRDlsK3Vm?=
 =?utf-8?B?L3poY01OVFNUZ3Vac2c2RVlJZWttcE5jRFo4OFZWcUFuNmNtMXFZd0NONzRS?=
 =?utf-8?B?NE04ek96QkV4b0VTRmtqa2lIN1ZKLzB1bk5xS2FETFJHb3JSRDlYY3NyUTRm?=
 =?utf-8?B?R3lEbC85eEZGR3ZxMklGQTFzNGNhdDFLVlcvdjAwRUJVR0gzQXJJcDg1cTVa?=
 =?utf-8?B?dlArWUNFRnVkVzVSNFpPb1ArL1BpeGMyVEpOUXpQN09lRGE5VitKdllxUHp4?=
 =?utf-8?B?RDV6bVJwVTdyZDJmdWJiei9XQ1RtaWVhRk1TeGVYTEIrdTZrTjVuQWUxQ2Vu?=
 =?utf-8?B?dkMwc2d5Nk0yME9GTU1lMXVzZ3MyWG1ObDVEdUdiZHVoNCtyc0lJeTQ3VG05?=
 =?utf-8?B?dnF0NEpIV2JFSi91NnlDZ2RzN2YxWExZRGJEclNYTmRGMzFhS3crRVFyUUlU?=
 =?utf-8?B?YkZzM3Nuc2JHZEg3UTF6U2FuQXhoQXd3RVB1N3lmeEh5WU1qT0hTUUlEN3gx?=
 =?utf-8?B?b0RMTUVJMjBreUlKYUxTMDFDUE1DdUNaTXRwbllaMTM0WHpTemdjZlIzVi80?=
 =?utf-8?B?WURwaVk5K2h2MVhMNzJTeGhDenRnd2lVaUFqNktIWVM0Q2pEMUNsank2QUJ0?=
 =?utf-8?B?MW9kZ1paaVN0M0ppZ2ZJYmF4ZGFUY3lZSyt1UUVPRFRvZnBzV0RjSTlCck4v?=
 =?utf-8?B?Rm9sbDJvblhxNXhudjlzVm90OCtabVBFQ1F1TlF3V0ZHRWFnZ0MxN3NLTENS?=
 =?utf-8?B?eVRzekJBSXlxK0JHTzlOeVBkR1Z3TDJZVkdwVlBCOXdsWmh1Qm01MGdhY2Z6?=
 =?utf-8?B?dkxZNjlnVnR2WjVwelpWSFF1YTJERGVqKzdZNmExalNLUDZDV1VCS21od2xm?=
 =?utf-8?B?bFlDdE5YYUVkS2x5M29HUitGNnRqY2wrRXI0elVuM3dWckh3V2diVjdmcnBF?=
 =?utf-8?B?NytHVkNvTVdQVHJsRy9GM0tMS3ZiemlCVElBZjRtbXFmQkN1MnhNeGFvTzZB?=
 =?utf-8?B?VWRvYS8vRG4wQjEvQTREUVhPT0Y4cVo3TDJsZkFXTmUvanZtRUt4OEpJc3Zy?=
 =?utf-8?B?bmVIc3gzRS9qSHBPSlBVTHNrejhMbzYvSHZJSUVEZkRWVHdGS0hGdy9nYUha?=
 =?utf-8?B?b0kxeUJMNW1zaWJ2RFlvOTFzcCtKQWdSdG5ncys3aVdUM1FtL1B6TGZVUmZI?=
 =?utf-8?B?Njg1YXM2QUJzbDE4ZlpLUWdFNXVpMVFpcEFHVTV3YTRqSzlKaDJkdi9JUVRj?=
 =?utf-8?B?ZVZDM015TGtLQU82Nmg3WEI4V0xNcWV1cVdrN0RnK25HdDQ1Q3pVRmNJeHVI?=
 =?utf-8?B?K2RTK3JSME1pL0JsUi9IdVp0d1RQZVNtYXJIRG5lWGJqSEtUL1FHVEpqMnJy?=
 =?utf-8?B?RTBIaWRFUGhZQ3FTLzQxODZrYjVwK1FpOE9FZGNhNDRFSWNLZ2FZMVUwdWxP?=
 =?utf-8?B?dEJvWGJxOWJOUldRTmRoTTZ4RS9iaUNlWHozeUVYZ1hiR0xKNU12ZUN3bUZY?=
 =?utf-8?B?Vlg2cE50M3NrcnpuSWF5VUlSUTBCQW9TbU9ld0lwOGtEZUFKalF6ZlkvOU5G?=
 =?utf-8?Q?dyT/Q+kFq55HhrdU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 275ad877-5b5e-4384-c558-08da4327f5bc
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2022 17:06:53.3171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H0XQgm28pIf7eqb+pImG18vb77mqpwrXJaJEDD1kFizq3v/qNEtEA1SKjMy1Vp9jAwbhUMLt9mQFOFlWSGSmDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4895
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-05-31_07:2022-05-30,2022-05-31 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2205310080
X-Proofpoint-ORIG-GUID: epLe5ioaYwWqkdDGdQLJAsU_wpTVE3M0
X-Proofpoint-GUID: epLe5ioaYwWqkdDGdQLJAsU_wpTVE3M0
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/22 08:36, Muchun Song wrote:
> On Fri, May 27, 2022 at 03:58:48PM -0700, Mike Kravetz wrote:
>> As an optimization for loops sequentially processing hugetlb address
>> ranges, huge_pmd_unshare would update a passed address if it unshared a
>> pmd.  Updating a loop control variable outside the loop like this is
>> generally a bad idea.  These loops are now using hugetlb_mask_last_hp
> 
> Totally agree.
> 
>> to optimize scanning when non-present ptes are discovered.  The same
>> can be done when huge_pmd_unshare returns 1 indicating a pmd was
>> unshared.
>>
>> Remove address update from huge_pmd_unshare.  Change the passed argument
>> type and update all callers.  In loops sequentially processing addresses
>> use hugetlb_mask_last_hp to update address if pmd is unshared.
>>
>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> 
> Acked-by: Muchun Song <songmuchun@bytedance.com>
> 
> Some nits below.
> 
>>  		ptep = huge_pte_offset(mm, address, sz);
>>  		if (!ptep)
>>  			continue;
>>  		ptl = huge_pte_lock(h, mm, ptep);
>>  		/* We don't want 'address' to be changed */
> 
> Dead comment, should be removed.

Thanks!  I missed that.

-- 
Mike Kravetz
