Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB9D522656
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 23:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234925AbiEJVb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 17:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234850AbiEJVaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 17:30:52 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5501C8CB1E;
        Tue, 10 May 2022 14:30:50 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24AIHHJf007656;
        Tue, 10 May 2022 21:30:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=nc4SQ/XgQYEyvJmPnV8sY3vNsZoOvUf8GEwSMP0ZIV4=;
 b=b2863mt9TvNKBzJKXQB1M+1agveqQHR10DxBeCl6STpzlTSC1VeDqna7AWCPqcs/JG2b
 RzXTTeGTgg2wB1z3jzrudY8fv4XfRpsWypVXx4w4wRa+Kaa5xQA/38Inc/5OBhP3jhZt
 dYvbdHDQ12YAjT36QJwm4qz+f6/pTGC1i0G7hec7K2G8GGz8gJXNNk/7FnVCJ/lXQSPg
 jBdYq3w/oPa5eM4oSfMVvYHFpQxaD6tGOS1ozdIzKHCMqXxMLoPuU31isaQNd2waq6UM
 oltQKS34xRt+/FazpiH4HHoGcxNbWTkMZa4Jhd34BaubBKtAXxtVNizZLvg1RBB0kRst 4Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwgn9qqdc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 May 2022 21:30:34 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24ALFdK4023329;
        Tue, 10 May 2022 21:30:33 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2170.outbound.protection.outlook.com [104.47.73.170])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fwf73jfan-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 May 2022 21:30:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QlaIbFu4wXXAhRZ9PjFJcXFXh445DMRZ4bRAMCHzEgDCeoia2yuYmVbDJ5b6BCzh76IrY/O6m9z9+Ka+BnqF3CW5CkFUyQZD0OkXiKJeaxXiYYMyi13wzKmdRqo227jgVEnsTYTC5s3nXhRONd2AarVevDjAntTxkg0nI+4oTjOOuRuPgN86BZHfOI5pF03OkBl9yseqdRaeuY1Z0k9gsjvTm6vkWBKYxLWBiVq1mLwf1TcI26NWISW0ZZS1zRnL2HwBeEQlEpguun7yDHL78vNhHUi4G/X/riKNhD0F2vSF7meuNNOAJPuYlA0yMo0TBstRE4EkgSsff+/u7UqwDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nc4SQ/XgQYEyvJmPnV8sY3vNsZoOvUf8GEwSMP0ZIV4=;
 b=N0dIaclCVsfa+tNUfBwJl2A8OOBJ+kWd+64I60kmjVY72YEiwLU2NkQ0/6UNpFGbes4PC4gLblzr8/uAIBZWFeWnUtcyyvM0mUPguUIv34ias1ft7YjnyFxrH7mZxTtqZTnM7sdtpd4trrIWwE8ori/xYr2xZBMu2Oq32YpOdXXjxN3k5u1kRYCJWp55w7ATbFIgYa/bz3Y6KURd1lAPVELrBNAIoAF6bu2JHMmckYsUmjl9lydf6Z11rrJJShZHMUWpZthwJSbsNn4l3y3aJedbxBc4+hAbBUEwdkIesJlHG0oapko3nJLnaUgBttYsS6EwMYJebNE9itFGAxRnlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nc4SQ/XgQYEyvJmPnV8sY3vNsZoOvUf8GEwSMP0ZIV4=;
 b=aAzD/cm7/m73m11citI3Wx1rhtKM2jhiWCfuGxJG3RaF2CeXTunx9YRnLjL3UKMsr27oJVoF+Jrf32w86M9kjNyZ+9VPbAJ3mV1lGD29z0zMzAEszxj7z40dWCqVrEJ0K7tQw6yrJSjvpKGiFNCZJPrHG7aZkRCEjSL3mBjQww0=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CH0PR10MB5020.namprd10.prod.outlook.com (2603:10b6:610:c0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.18; Tue, 10 May
 2022 21:30:31 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::9d76:7926:9b76:f461]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::9d76:7926:9b76:f461%9]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 21:30:31 +0000
Message-ID: <970166e0-f70e-dd2a-c764-af23a8425f87@oracle.com>
Date:   Tue, 10 May 2022 14:30:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v10 4/4] mm: hugetlb_vmemmap: add hugetlb_optimize_vmemmap
 sysctl
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>, corbet@lwn.net,
        akpm@linux-foundation.org, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com, osalvador@suse.de,
        david@redhat.com, masahiroy@kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com, smuchun@gmail.com
References: <20220509062703.64249-1-songmuchun@bytedance.com>
 <20220509062703.64249-5-songmuchun@bytedance.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <20220509062703.64249-5-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0280.namprd03.prod.outlook.com
 (2603:10b6:303:b5::15) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc232cb9-dd1d-40d7-c209-08da32cc4f1a
X-MS-TrafficTypeDiagnostic: CH0PR10MB5020:EE_
X-Microsoft-Antispam-PRVS: <CH0PR10MB5020485D6D045CF82BF16182E2C99@CH0PR10MB5020.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9TjsxvPwqLApWtPma+AP3H6ZTqtRXJoopKaKguWdlb74mKwMLr2dDbl5WMg+nopujYeaPYrHtzpRQWylDpz3ptimo1M3yUE1cM8tqrR+ixihP8BDEVYqqcONUfsFlHBYsDXHvUnmwH1JBf5OzRidUmT3z+yfqokPOF0ARdrTDLL36oFNPCfvoeuA3B7bGohdbJE4Cv/h87vu+FyVpbTZ3pZNOI/2UMydBm569FNyrVTSiMqXbN8XQmLF2fWlB39bEXnu0Oqrmdu/s/qdk4xFsPVDgfm8lFbhh1fMwzK2pdSTK3begnb3wFJ0PcqnNOm+BhG4KiIlVM65tCfBP+ZRGxuccEc1FIM4Ej92f9GBEMYlsuqqTZ8i2R+ax5nJV+YqZFXFov4OwHYLPPENX6XxpYUzskIMzte2ofUhXXCFjOP2kN+hLuyps7s0xlcm0ftHJfZbSkABl+n2gwX5oc1hZslSV+hEdVe0sBzUZ+2Jh7y8i8lGvaA+ohczaNlArfxsbZew6Za5/RiwpEPRHgsxvb+bXwWG3Qwe8JVoMv+Scbgc/NuJmk9izVYXiYncAys3q5u2oK2sg8qo/9n/XP5rIQ3ZZVPKCsDyWwzVMg0qt+IHaGhWzZcjQ9JyS3XVsaefGbE1+IWbNw1mHXYlj/fSy5l48XVTKRiF6F59kTBvWW9wJB3aE9JFc0PniJWZCns8gwqd7djFoJGHquZzEdVCgpQgEAC7hwu2fODpJEtA6eDT3FtuIgOdQ1hQ3ZaDl5TssrkFSoV7AY+gqOQCM11TSQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(38100700002)(38350700002)(6486002)(7416002)(8936002)(316002)(186003)(8676002)(6506007)(6666004)(36756003)(4326008)(52116002)(2906002)(6512007)(26005)(66556008)(66476007)(53546011)(44832011)(66946007)(31686004)(2616005)(31696002)(5660300002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWd4NWpUcHIrM0pmQ1A3MmVtM0dVQTdINFBZSDF0cGVTdlpIOEtPMXA4NnFp?=
 =?utf-8?B?cy9leTM4UERmWUdMZ0duWEdQVitSN2wwV0ZYTERiTWRidWRFNTM4NlJYS0o3?=
 =?utf-8?B?OXF3djhySVJtMkpCK0o1ZWluaTRXWnJDcUFjbGVLZU4wZmZVTnAzdjc1My9J?=
 =?utf-8?B?elR5WWJxWlBJVG9vU3pVUGZ2c2cvcXJmOFlZS3J6N3o4NG15UUVZUytSaFNN?=
 =?utf-8?B?bVNodlBYQUoyRGR4RXlRNWZINkIya0JZM2Z3ZDlOV09ta1A5eG5vQmZPZldH?=
 =?utf-8?B?OHRjWjdxVVhUMy8yY3VTa2dPNkVVK01zMkJ3ai9wMjFhYzlPQUJFUVhVTFBV?=
 =?utf-8?B?REFJeHZUMnRnVUN1UFN5QkR0WkxFcWU3aFMrZVgyWTF5R0JiVE1SUmRONWRF?=
 =?utf-8?B?bzV4dS9OajlEbE11WGFmUTUzaWMxRnlIQndWcHFLdmJpNW5VcVA1Rmw4ZGxW?=
 =?utf-8?B?bUhlbThFdVdyMGFVSW9wMUhBSk1hMHRZeWpMS3c3OXRNakgwcTNPdncrdUpo?=
 =?utf-8?B?RTB0S0E0VW5zVUNFbEVMU1FSQjJjUjk2c09Ydk9SNEZIVnhnVXJPbnBiM2No?=
 =?utf-8?B?YzdONHVQYXpNRzVWdXNkQk5FUkdRNVkwLzJTbDRQcStoRVF6UjdNRCtWLy9z?=
 =?utf-8?B?eldHTXJYZFU2QVhQc2QydXZYRm50V2VSYktqaW1ObVEzME5VUDJTVjl2WjRK?=
 =?utf-8?B?WkpzWTF5NUdGRktvOVQ1d1JRczJEaUlzdFFxWnVySDZCMnFHLzZOd0o4VHJJ?=
 =?utf-8?B?Vk5jWTRWQmVmSHZVT25Na05YN2dOTk5SWXNmZ2EydDhuVWo5bitwYlpOZ25Q?=
 =?utf-8?B?ZGY2Mk5qeU1NRWE5U3JDcGhsVGFnVzZMRWc2ZWx3ZTZ4SzA5S1JoTWk4Q0Fw?=
 =?utf-8?B?V0dlZDdETktmdFVMVHBvWERLVlV4dmU2Y1FuRTI4RGNuMDNUa3R4WnJjbitI?=
 =?utf-8?B?UGN0RU9oaVY4MWNlREw4T2J3ajAvQUoxekd2Q3ZWc3JiM1BIdERUNlJxcFlT?=
 =?utf-8?B?Nzg0QUo0RlRrcUt3NURDWTlCbzBmeHA2NDJhT2ZaVWROaFlFZHdkS29uNGJG?=
 =?utf-8?B?ZklUL3BSS3VGY0hMVGF6VkcyMW5jT3NKSWZpNHB0Qk9jZW9WQnBQanlYNE56?=
 =?utf-8?B?eWhSRU1HU0pQV0ZWRXE1cjNBYXUvbWh6dmdZZHYwQnpha1F1d1pVSFVMMzdU?=
 =?utf-8?B?MDFSOCtqb2tMUnU2bVp3QTBaQVlpWGNKZm41Sk9uL1VEZFhoRmxSRjZRbktk?=
 =?utf-8?B?UFh0SWFaQ29tMWZiU2JGVVNKZU1aOWU4bHNNelVYejZ4Ym5Dc0FWRU9ZbzJ0?=
 =?utf-8?B?bmdrVzVGT0huNmQwck5Hdlloc1NFTGdHLzRvc01xcDlOVU9LRTJObGl4QjM5?=
 =?utf-8?B?b09OSWJZK3BPbEdsMUEzblFEemJsRUFSSDJpSnZoN1ZWK041b2hwYU9MbU5C?=
 =?utf-8?B?NkIzVHZ0YStPWjJ1VW1CVkFjK0NwZ0psNjA0dmloMllXMlVncWthWUR6ZnQz?=
 =?utf-8?B?bVV2cWw3U1VUdVhDck9lcHpTdmczL1NGR2REU0FWMVdOOHROb1Nld1NBRkY3?=
 =?utf-8?B?ODdudkJKbXpZbk5qWWlCcmw4SDdnK3BFZ0l1MVJmaDBMT0ZnVzF1VUdyUGxh?=
 =?utf-8?B?bmh3R2JDTWxrVks2S05xR1cxWmdmUTdydlQ4c0tRK21vUlBHNkNaVUxGcXk5?=
 =?utf-8?B?cHZUZVoyYmY2MkdtYmlTWDhHVDZyVXdmaGZxUVRiUDhOd0FHeTJSSVArMnVu?=
 =?utf-8?B?TlQwYWgvNDdTcm5OV05idVVrSjFMdnJ2Ny9xRUlFL1hYZFIvYWlwMXp0aE95?=
 =?utf-8?B?YWxzNWZxTHFDai9mQjJwaFA2YWFMRnU4b2FsWTYydzdBZStwVys3YnZTL2RM?=
 =?utf-8?B?VXFISDRBa2Eyd1U4Q0N4TnVWUmtGeVVLcG1HVHpoc0dSVFM3cXhzd1BPYUd2?=
 =?utf-8?B?VFV5cjlEanZtQmg5bVBSQlJEYWQxc3hxTXNZWFVuL0RRQjFjdjFmZjU1UTZt?=
 =?utf-8?B?M2x2VmFyQTlVek5vS0VpUXlNWXRadHdhdEtVdVpqeHNVYXcwbm5ydnZJeHhM?=
 =?utf-8?B?YTVQWk9FYW9tYjB1clVCSUJkS3RlSW1iZ0xVQmFDWUVqdmxnM1BrTXNtZDlO?=
 =?utf-8?B?bHZtdlVkSVZaRmFhMGFkY0ZIMnc1TTJlbWdQUDBRekpJeTBta3hCY3l3cXQw?=
 =?utf-8?B?c0tWNXZiL2pseGpqYVpkM2M4aG9aRmVYcXVzdk9kWXVWRUFrMzFIV0s4dklK?=
 =?utf-8?B?U2JONFlGd2o4TzY5Lyt0RHlKbzJMUHBSZ1dVTnVUY1piZy9TSzUyRGpSTVZR?=
 =?utf-8?B?aysrVUtnUHEvN2h2UmlYaW9jcE13enFPbDE4YXZ1S2x6TC9LcHU5YlBtRStW?=
 =?utf-8?Q?vU1S8RI6RTrem+So=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc232cb9-dd1d-40d7-c209-08da32cc4f1a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 21:30:30.9467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mnug/eBnWyv9g6ViFNKque8Pddp42XT5FDtBAnJuQBKN0+iWvQHmlyGa3lqiDGp1hyl6mrX2c8C0RkHx4iTCIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5020
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-10_07:2022-05-09,2022-05-10 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205100088
X-Proofpoint-GUID: cg83EAWd4yl2vZ4StujmXSBz591BYKCc
X-Proofpoint-ORIG-GUID: cg83EAWd4yl2vZ4StujmXSBz591BYKCc
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/8/22 23:27, Muchun Song wrote:
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index 029fb7e26504..917112661b5c 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -351,4 +351,13 @@ void arch_remove_linear_mapping(u64 start, u64 size);
>  extern bool mhp_supports_memmap_on_memory(unsigned long size);
>  #endif /* CONFIG_MEMORY_HOTPLUG */
>  
> +#ifdef CONFIG_MHP_MEMMAP_ON_MEMORY
> +bool mhp_memmap_on_memory(void);
> +#else
> +static inline bool mhp_memmap_on_memory(void)
> +{
> +	return false;
> +}
> +#endif
> +
>  #endif /* __LINUX_MEMORY_HOTPLUG_H */
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 8605d7eb7f5c..86158eb9da70 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1617,6 +1617,9 @@ static DECLARE_WORK(free_hpage_work, free_hpage_workfn);
>  
>  static inline void flush_free_hpage_work(struct hstate *h)
>  {
> +	if (!hugetlb_optimize_vmemmap_enabled())
> +		return;
> +

Hi Muchun,

In v9 I was suggesting that we may be able to eliminate the static_branch_inc/dec from the vmemmap free/alloc paths.  With this patch
I believe hugetlb_optimize_vmemmap_enabled() is really checking
'has hugetlb vmemmap optimization been enabled' OR 'are there still vmemmap
optimized hugetlb pages in the system'.  That may be confusing.

For this specific routine (flush_free_hpage_work) I do not think we need
to worry too much about deciding to call flush_work or not.  This is only
called via set_max_huge_pages which is not a performance sensitive path.

>  	if (hugetlb_optimize_vmemmap_pages(h))
>  		flush_work(&free_hpage_work);
>  }

Here is a patch on top of this patch to show my suggestion for removing
static_branch_inc/dec from the vmemmap free/alloc paths.  It seems simpler
to me, and hugetlb_optimize_vmemmap_enabled would only return true if
hugetlb vmemmap optimization is currently enabled.  I am not insisting
that static_branch_inc/dec be eliminated.  It may not even work.  I have
not tested.  What do you think?

diff --git a/arch/arm64/mm/flush.c b/arch/arm64/mm/flush.c
index fc4f710e9820..2f80751b7c3a 100644
--- a/arch/arm64/mm/flush.c
+++ b/arch/arm64/mm/flush.c
@@ -9,6 +9,7 @@
 #include <linux/export.h>
 #include <linux/mm.h>
 #include <linux/pagemap.h>
+#include <linux/hugetlb.h>
 
 #include <asm/cacheflush.h>
 #include <asm/cache.h>
@@ -86,7 +87,7 @@ void flush_dcache_page(struct page *page)
 	 * is reused (more details can refer to the comments above
 	 * page_fixed_fake_head()).
 	 */
-	if (hugetlb_optimize_vmemmap_enabled() && PageHuge(page))
+	if (PageHuge(page) && HPageVmemmapOptimized(compound_head(page)))
 		page = compound_head(page);
 
 	if (test_bit(PG_dcache_clean, &page->flags))
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 86158eb9da70..8605d7eb7f5c 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1617,9 +1617,6 @@ static DECLARE_WORK(free_hpage_work, free_hpage_workfn);
 
 static inline void flush_free_hpage_work(struct hstate *h)
 {
-	if (!hugetlb_optimize_vmemmap_enabled())
-		return;
-
 	if (hugetlb_optimize_vmemmap_pages(h))
 		flush_work(&free_hpage_work);
 }
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index fcd9f7872064..8e0890a505b3 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -41,9 +41,9 @@ static void vmemmap_optimize_mode_switch(enum vmemmap_optimize_mode to)
 		return;
 
 	if (to == VMEMMAP_OPTIMIZE_OFF)
-		static_branch_dec(&hugetlb_optimize_vmemmap_key);
+		static_branch_disable(&hugetlb_optimize_vmemmap_key);
 	else
-		static_branch_inc(&hugetlb_optimize_vmemmap_key);
+		static_branch_enable(&hugetlb_optimize_vmemmap_key);
 	WRITE_ONCE(vmemmap_optimize_mode, to);
 }
 
@@ -91,7 +91,6 @@ int hugetlb_vmemmap_alloc(struct hstate *h, struct page *head)
 				  GFP_KERNEL | __GFP_NORETRY | __GFP_THISNODE);
 	if (!ret) {
 		ClearHPageVmemmapOptimized(head);
-		static_branch_dec(&hugetlb_optimize_vmemmap_key);
 	}
 
 	return ret;
@@ -102,14 +101,10 @@ void hugetlb_vmemmap_free(struct hstate *h, struct page *head)
 	unsigned long vmemmap_addr = (unsigned long)head;
 	unsigned long vmemmap_end, vmemmap_reuse, vmemmap_pages;
 
-	vmemmap_pages = hugetlb_optimize_vmemmap_pages(h);
-	if (!vmemmap_pages)
-		return;
-
-	if (READ_ONCE(vmemmap_optimize_mode) == VMEMMAP_OPTIMIZE_OFF)
+	if (!hugetlb_optimize_vmemmap_enabled())
 		return;
 
-	static_branch_inc(&hugetlb_optimize_vmemmap_key);
+	vmemmap_pages = hugetlb_optimize_vmemmap_pages(h);
 
 	vmemmap_addr	+= RESERVE_VMEMMAP_SIZE;
 	vmemmap_end	= vmemmap_addr + (vmemmap_pages << PAGE_SHIFT);
@@ -120,9 +115,7 @@ void hugetlb_vmemmap_free(struct hstate *h, struct page *head)
 	 * to the page which @vmemmap_reuse is mapped to, then free the pages
 	 * which the range [@vmemmap_addr, @vmemmap_end] is mapped to.
 	 */
-	if (vmemmap_remap_free(vmemmap_addr, vmemmap_end, vmemmap_reuse))
-		static_branch_dec(&hugetlb_optimize_vmemmap_key);
-	else
+	if (!vmemmap_remap_free(vmemmap_addr, vmemmap_end, vmemmap_reuse))
 		SetHPageVmemmapOptimized(head);
 }

-- 
Mike Kravetz
