Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F99595EF5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 17:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236016AbiHPPZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 11:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236135AbiHPPYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 11:24:55 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB06785FAE
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 08:24:06 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27GDdVWW015829;
        Tue, 16 Aug 2022 15:23:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=mV9woyiPRnlGHPS8Awc0ZejNBUTO7jMBIQ3dVirNKc4=;
 b=Qpe4PEKYiLnI0XfRDWO1JuLoCXUdOUJYOZfFfOBJ6jRmU3rNM9q5sPtSWwhYKQdBL4lD
 Pn/5bWWM86jsXph+cAS57lsnem1SQrgZazs2y+U/LTZWcpkEirRg9QoDSRN8MWnBBQKs
 KCW7H9lc5EW5zacnv6VZbMZjF6XXPTTUnD7tm4bDOUEyNihwUvALXqN6asyLf5KnlYxn
 zhYmiyQeBrRlujtefN1LPkAOMuOM1wOmmoxbJfVzMp0HixuKv4qtOUIiIpEc/d3/ucEy
 qB5pHYwhiBHWtaXKVQcRH7R97JqepqIkfBo51+bpHAotjCdxmpE8ao2zHn6PmbYpwOUJ JA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hx3ua640m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Aug 2022 15:23:35 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27GDPvUQ004484;
        Tue, 16 Aug 2022 15:23:34 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j0c46um2f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Aug 2022 15:23:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=isbjPWfjSTiHUZWgYE2bKCi9TtIASHuxevUJ4snvGWv9npKJb2H3ICN5aY1FWgdtRWRr6X5rFeauBtv3WZHWXmH6VuBlvE0Cq7BPMYQLP3FGWD7G/OUysERT9TJ5ytCfi4NIH7jTrnNmXzt0kogxHChP7+LSnj/oR42RYiYcwh1Dlv7WXqaGRa1Zz87MEldOW8h9treOCneUnkmd3k7MTDNKkzJQbXJiSLmz71IFL5cLy5o53J4Z4CYIr491pTzyXVfeebUrznzQwiaw9vUMoyECBC1dYJALxLXxzHMgg9SiC4Nk/TngtDmWeclohMpqbps4OdhW/l8afc7ufP7aoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mV9woyiPRnlGHPS8Awc0ZejNBUTO7jMBIQ3dVirNKc4=;
 b=CE3sJSNBLyBv4QAus/fdTpLM9VCgV/h0S8mTYKyqg8gorFyZbdHFZhX/utyMgwS1NToa8W0dh+ZXXgmJPKhdZY8mnmh9AzleQqQqjh9J+elxaLNQonHa8YeDaKUoA+ucp9AZ4V8DttS18jOf7DdgIHYY7+k8t2Km0tUexYVkz+xPPJDJO9RFaqg7hkNrt8CcHYWDgJnXDtYRXlUBFIpXN1+sWfIcDBBtcKrC6ndb8Xdi532CXf83odYvD/YLdTN7dS3OxFHkW7z/dcTRluHGhrKLp1VJGyeKQlBmh385T1vuWkfZfApTjbWpjvey7y3zeIyLWLwCZqjQFu/Ymw0P7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mV9woyiPRnlGHPS8Awc0ZejNBUTO7jMBIQ3dVirNKc4=;
 b=LQeR9kqSBNw6gxFQxKO555oKzRj3fgd/Pxs/Vt2YucuNQhaN9qsCoXdDu24uNgg39aMUHYMkym7TGZZinqUbAxGtT3R2TqEIyG1rL34Tl9WH+YFENY2Y9qjeJx1FJAQHCpTelzVRGEycxTOQjyUKVJinX2Ilwqcpbe21TKWbCcU=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by CY5PR10MB6022.namprd10.prod.outlook.com (2603:10b6:930:3e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.28; Tue, 16 Aug
 2022 15:23:32 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::4d5c:c5e9:7d20:43c2]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::4d5c:c5e9:7d20:43c2%9]) with mapi id 15.20.5525.011; Tue, 16 Aug 2022
 15:23:32 +0000
Message-ID: <05aefa7f-1f0d-b10a-946b-07a581d89467@oracle.com>
Date:   Tue, 16 Aug 2022 10:23:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v10 1/8] crash: introduce arch/*/asm/crash.h
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
References: <20220721181747.1640-1-eric.devolder@oracle.com>
 <20220721181747.1640-2-eric.devolder@oracle.com>
 <YvCCOY+mRshu1tHi@MiWiFi-R3L-srv>
 <52d40562-ee6f-bb89-6d21-2d6baf67053d@oracle.com>
 <YvYhYdV6F2zH4o3X@MiWiFi-R3L-srv>
 <2b44bbd1-6e6f-40d1-73ac-19348d1ef48a@oracle.com>
 <YvbvQ5+cmExVNaGE@MiWiFi-R3L-srv>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <YvbvQ5+cmExVNaGE@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR06CA0069.namprd06.prod.outlook.com
 (2603:10b6:5:54::46) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 841b44b1-ae4d-47a1-adce-08da7f9b4721
X-MS-TrafficTypeDiagnostic: CY5PR10MB6022:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 88OzPU01PIYzgxb3rPf33BTNnvuzcxn5nXtjcDdhjWSbPWNhLNpW3h729RlByt46m4aInKa3pNacdBoJzlMAjvym1kgqoOTGsJJmbMb8GSfc4TTlam5UwSpZ9gCTbxiLghBiz2vBoKDrGUStY/gzqm3bNe31XwR9aopYK5YDFMVSa2nyT7mgGQhqN+YfqxGPXO2j9F623C1SJ0chDqOr94RFcfloDtd8HlN7EDsJBVMaVE6g246H2opsGBHC9BH9j0PeFO/595QFjwINg+pDzhMQeIOEpJx6wqRfR8SMpz1W2o1orhrjpSOV8aoTeklyAVqdwDYWVImlcBLJuaNz6PZMS5yX9/W5Dq2diiu6v+GosagwdaoKqTAO1pnwd+k9HzitN1qVuKK21//HawRqgu3ib0hFQ9psuwfg4nqd01k1y6LjMku/JuOLIioVEA6lwJ/bIUlPnuq/gaBoaOCC6FoTlO8e2o8LzsU8oC8XE50M58Ldhc47EQdit/jhpi1t+IrUXZLEJexjWYIKhGzW/T959IzPnWFh2H2EDShfCxcnMYn7srNLcz2vmW5Um5RFyJ6fSoNeZG9/YubweiKPsAEsUn29R/Rmd2vWPTjcOAmJej4rz6ojUXYvP0tOxCt8mQ/jP69/vme2gG1pqa7mvTK7Fx8YP5kmfOctyx2w3MN3FEwvf4XVAFkpYArPxC/cBQx0/HUmzkwyx02e/md/oH4zcZv9ouLBEGfGWMdQDvMuSo1elVvEzSJHYrCRsNJ1sfLVo1XdtAQAuiwqJkjfKv3U31kOvTXBL8hLYtu1n0+xkwldU5K280umvpp+0N3GkIgiT98krkPb2F/L/nM3+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(376002)(396003)(39860400002)(346002)(31686004)(7416002)(5660300002)(36756003)(66946007)(66556008)(66476007)(6916009)(316002)(2906002)(86362001)(31696002)(83380400001)(6666004)(8676002)(6512007)(6506007)(6486002)(38100700002)(478600001)(53546011)(4326008)(8936002)(107886003)(2616005)(186003)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXRUUyt5Nnh1U0VQZ2o5bEhkS04zNHRMTlRjTmkyTUlRTFR3QWNPdG1KSi8y?=
 =?utf-8?B?dXFGZ2NRcGpRaGpGWGptTWVtTGhpdGRoa2hoOHZTeWNZcGxCMkYxaUwzZzZG?=
 =?utf-8?B?cEJtN21DTHg2WWhPZ2VTWFViekY4MDB2cENYUDJmQlp3Y01qY3lFRTBJTHFN?=
 =?utf-8?B?UXRMWWlabHVvdDRmaTBwNjQyUGltRWpVL0IrcFd2aHk2a21oZThBRzB4VS9i?=
 =?utf-8?B?c3FZZk1NeEV5VW9kblJiTUE2TFVRZDlrejFQTmtXdGNkMUN5bytUUHVrNjFJ?=
 =?utf-8?B?RitLdkxNUE1aSndocUdkTGhrMW5IWldpK24rSEZ4Yldwd1BjWFN4SjNDQWFI?=
 =?utf-8?B?MmRtcjVYOW1OUFVMcnhzK3hoZUNsZ0c5c1NMTEJjbmNHRTJlaHhtYnZIbjlI?=
 =?utf-8?B?MUwyL3BQWDJqam4vMHRWS3VER2ZmSzF5OVlnSWF6WTlCYWtGUXBhRS81Skhv?=
 =?utf-8?B?eU95ME9iRjV4Mjl3dGRnMldpelY4Z1QxQ2xrenMvSFdza2JFVk8zbDE5Wkk3?=
 =?utf-8?B?d0JtSVRkYkVpZkh1Ni9leDFGQlhKdENxNGZBVlNHSi9XWDRMMnVZK3lQQ25J?=
 =?utf-8?B?WU1naWVOdlZDcGpuS3A1ZEpQRis4NmNZL2RxaXdLRkJLdy9naWdhbDZKTk84?=
 =?utf-8?B?VG5DSzNQZjZUZjdyeWpsL2ZMY2dUYi9QdXFUNE9IVXo1YzN2Z1YxU2RuZFhP?=
 =?utf-8?B?RzdHa1lURUp0d0ZwTlh3TXZURTByK1h1SEpJT01lR245RlVTdlJMeGlQbm9w?=
 =?utf-8?B?c1EvcFIwSmNSbXJ2dCtGSVM5eEJHcnB0NHVMVTZCL1N5RzhhalFsYVdEVTBt?=
 =?utf-8?B?Q3E0a1RDMGQwMkl4R1lMakYwSENodEdWbTYyYXIvRHBzTi9oYU9Yb1hPTUFj?=
 =?utf-8?B?QlZTT29Ld29vQS9hZWhoYTRnUExxZWUwa2RhVHdCcjI4SHVEcjQyOFFITDBD?=
 =?utf-8?B?RndHTjdVdFRqVWRxSzJlTkYrRWxzVHdMTnc2UUsrTXhWK0lmMDJYV1l5b0dI?=
 =?utf-8?B?K0ZzTU8rdFJiWHdxMCtlQUFUbWJzL1pWT2JGRkk3bThEWVh0UlZyOXBhblRS?=
 =?utf-8?B?ZUMvalUwaWRkazhqeG9vVVdVWGFVVWdMQzk2RmVCU0xtVXJsclhtSGd4Mzh3?=
 =?utf-8?B?K1FKUitIR3dtZVRLUy9vK3FucTc2ZUdPYVRTc0VoeWpqMit6YUJna2ZrQWVC?=
 =?utf-8?B?ZXkwZjRBcHdnN2tlaUxWeURMQlFudlJ0Q2ZwREZ6blV1WFNyQVJCVEYyUkJ5?=
 =?utf-8?B?OXRBaXVYVjRIQ3pKZlRkMTFFeThTb3RLSEEyQ0pkbG54bFoyKytFTXpqTmc0?=
 =?utf-8?B?NUFCZXFBSUhycU45a2txN1JINmxtMm9pdEhDNHNCR2J5WDhCUGRaRTlRVGhr?=
 =?utf-8?B?ZWQ0US9YcDJMckx2TEJYVzdNYlQ1SWt6Um1Fb1g3cENmZ082NGVldlVKeURP?=
 =?utf-8?B?aGh4eUhBQnFEcjJ2dWxLLzlaZWRWVllzSndYZ2dxcjhnUTVYVkl2czl0OUIz?=
 =?utf-8?B?UXJFSmc1Nno2R1p4V1ZrZ09UbFZLUC9WYm5iQk5OSXdKN25yMnhZZVlrUEwz?=
 =?utf-8?B?UXBjU0tCQ3NHN2hqWHh2UmVLYnlmdGhJSzVGVVlSSnNvS0kybVpXdVNNSktO?=
 =?utf-8?B?ZHh6ZzJnVkhCSXlYMGZpU2RXYjg4OXVFY0RPT3JwSU44a2c0RmUxdHc1V3NI?=
 =?utf-8?B?eHBGZktadVpmMDBqR2xDNUpZMm41RE9nTjBKV1YwdHU2amRTdnhZUHhFcitS?=
 =?utf-8?B?YUJtK0ZIMUthNng4UGErZVhWampWSDFNMXRnNHFzdFQxaTF4a3gyaW5IWE1Z?=
 =?utf-8?B?MFRHWjBjV0JDbnV4MnNzYnNVcmRMY2hoMGY3Lyt4RnB4ejYxM2hxazFiUUxp?=
 =?utf-8?B?VnZOaXNWZ0Fyak1keHdQNmY4ZU9uOUYxZzhVMWZHQ2JYWFJsZ2dQS0xMcWVq?=
 =?utf-8?B?RWFCeUkwSC9JYzFVR1VuY1J5QjljL1Q3YmR1RllJajRycy96T3dXUDNXSUFw?=
 =?utf-8?B?YTd4cFNDQktSMnFyYXRPUHZmcjVsd3paV1dpMnNWTUk5KzhjKzFLU1hxVWgx?=
 =?utf-8?B?bGNzTWF2NXlwdFp5SE9uaXkvNHdSbUIrVFNLSXVzNmJXUjN4bVhQMVRXUDB6?=
 =?utf-8?B?QXZobEJhck9UOUQ1OFZyeE1iRTlmSzZLKzMzUHpta3E5WU1hMFViT3dCeVRT?=
 =?utf-8?Q?5Ojutr5/26vJoDuSMTF2n8Q=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?bng3SUZRaW1neFE1cHBiVVd6N2p0V3JCSFllK3I3T2M0NmZ1UlRsZk4rK3NO?=
 =?utf-8?B?MzBwTmRnckRXSG5YSytGMjN5d3ZUVy9uUjAzS2NsYmROMkhlRWxHNVBwRUox?=
 =?utf-8?B?SldiOHZGcys4dUhEWVJtYW96dklIQW1WSXJsTVFNQThBNWNnSGd3VjBvVHhV?=
 =?utf-8?B?TktzbWpxSWFYSjFaZGYxak1LQXdWeTNuQ3RyY2lRM0hDRVlyMmF3RFpLem9r?=
 =?utf-8?B?QjREWHNRbndGR1gvVkw3NFhHR0RqL291N3BkaHNEZ01hRExXOWRnY0lONlhE?=
 =?utf-8?B?Rkw0NG9wMmhCekYvN2Q3YmR0d0gxbFlNdEVGcmxVdVo0K25JQXVnd0toZmUy?=
 =?utf-8?B?cUpFVm9hT2cyalpRcXpHbHlGNzhJZFZPSEdYYzZ1ZHR5bENJUGN0KzAyVUEw?=
 =?utf-8?B?aDRBQlNRNUszVVprNk1NSGl6Ti9KeGpNVzlIQS9nbHFVVzZNNS8yWWFwT2dO?=
 =?utf-8?B?WFJ5TzAyT0hxQm1FVER3b0tFcVVPTGZOMnNjWW42SmRiUnNtdkd3aXJkTk9x?=
 =?utf-8?B?dE9KZEJhZ0RtRVI1d0VqVkVXSHhoa0RuQzVZMXhyZGFiMU9ESXZ3UzRxT25x?=
 =?utf-8?B?UWc5ckVIME9YSEpqL2hJdWhZUTNHLzdpbFJuamphM0hndXV4Zk91cklLcUM1?=
 =?utf-8?B?aXFQYWhibTBBUnZJdDFvMitzcVgzWEphREhOR1pjM25zb3dzUEtNVUtYc1JH?=
 =?utf-8?B?RVlTT0hkR0VjUjk1QlM2Yjlnekk3QVNwcDRPNmhDRmU4UHMwRFBESWVwN3Fk?=
 =?utf-8?B?VmF2TXdZRVdqSDk2T1dBQ0JUQXF2Yys2WVdqNGN1ZzBma01PR1BLSHQ0M0FD?=
 =?utf-8?B?VDJOb0JRdnpiUi80TkVOTGFtNzRWOFBTMTdXTitUNFU3R0VZWUFZeWp6S09K?=
 =?utf-8?B?OW9IdWx6eG1TTkpNVUtiSHJlSVFrVS81Q01rMy9vSXkzdU9jWlhxZnpMdnc4?=
 =?utf-8?B?S05kWDVFckIwVXV0S0tudW4xOFdDQTZCN3ZDeEpjdklyMldlWmFkNS9nL3or?=
 =?utf-8?B?WWprd1ZkNjVJa1FiWlVGcUczejhxdkN1ZjkrOXpvSHorNmNUME1ZcmI2eUtn?=
 =?utf-8?B?UWlwY29iQ2dTY0xDWWJYcUpRM0FxWTRid3I1enZKcnh6bnhWL0h5dkVuajFx?=
 =?utf-8?B?VWZiZzJGay9jL2l2azh1QlQreUQvZ2lFL2VwaExPSERJRGFPVlJpRzhhZXFa?=
 =?utf-8?B?c1dOZDBwTm5zNnZ6VTFzMCtjTmhYWitJK2VLYnZQMWtKQ0JRdUFRRVJJYSsx?=
 =?utf-8?B?dzc1aWcrc05zTkFxT0NJN01OYnRaaFNDQWMrWEVqc0JUejh6S3J5Qk4vWHB6?=
 =?utf-8?B?NE1SWHh1c3RiUkhlZDJrY3J3anZndnUzTUQxN3RPMFY1VTROWmkwUHNpeDFx?=
 =?utf-8?B?Z3hHR25NYjdyVGNTVTErZmx4YnFRVVhjVXBuV0NYZTI3aGpVOENPOFNSZ2hY?=
 =?utf-8?B?ZVp1ZFh1YlN2OUgrRGsvVkRiOStvdU80N1M1THRSRkZYSXR5VXdMQUo3ekVR?=
 =?utf-8?B?WThlS0FPVEVKWEZKcm15OG5pbTFTTFNBcXZOYTVLeENyaGVENDlOa2Zid0pB?=
 =?utf-8?B?WGF4TlhwM1FYOXZaV1NZbmVrMnZzYmdnaXpLQlBtcGtyazZ1YTJra25oa1Vl?=
 =?utf-8?B?WC9ibGdYNFAvWXcyZ0lPUVFsOVdhQVYxVEtVNWhYTFozVGFSZnNwWGJMbi84?=
 =?utf-8?B?L3RaeTlOWml4N29tTHUyOEMwcXFkY29kR3FwaVBYTDcrTTlMT3lqekJ6QTNR?=
 =?utf-8?B?UXVoNTJYemdVUjlLMlVCNHlBek4wMFBkWkY0S0ZnbkhqY1RKcS8wcnVmZnNR?=
 =?utf-8?B?S2UwdWZNUlJIV1ZGM2FUZ3A0OU9aL1NiTDJlRmdnWW1OQnoxZVhtVWl0UU9F?=
 =?utf-8?B?Vkp3d3ZST0NsRjljWXk3NVRhUHdpazh6ZXJoVHdrU21iTnEvSitzS3c2c0Vj?=
 =?utf-8?B?ZzdKcTRWSmQ5cHh0VWtmRi9zTVY3TThlTDl4dHo3endMT2xxYStpMjNpK3FM?=
 =?utf-8?B?SnBnV1I5bmlSVVJ3MTYrOFU3eHpPNlU4ekx2QUNPQlJabHMxTktkWDBSbUxH?=
 =?utf-8?B?TE5yRkd1OHBCdEN0bjJIUDFXNEI1WG1ndnhxY05maU1CVlk4bWRoMFpWUjZy?=
 =?utf-8?B?dzRVNXQ5azk0d1hxZURURm13NEpyUldkMEZ4SXJVUGZmRXNhdTZBMlpvMjBW?=
 =?utf-8?Q?aixgSjLatYEUMPHKZXOQPeG64TocxEl0rZsIbtfPrnlo?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 841b44b1-ae4d-47a1-adce-08da7f9b4721
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 15:23:31.8425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4N+Oxd+G1VdjIGN9qBJJrWpCAjc5xRCfGrS3GnA3TOnXCq1puHeimmZ6USV6DzR1QH+YXKMg0ib1tqjPRZA6FogFCLJuOcgZ+8VAt8HylRc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6022
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-16_08,2022-08-16_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208160059
X-Proofpoint-ORIG-GUID: TiWIYqLo0B0MljSaEiLISfNNO1ghM-iK
X-Proofpoint-GUID: TiWIYqLo0B0MljSaEiLISfNNO1ghM-iK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/12/22 19:24, Baoquan He wrote:
> On 08/12/22 at 04:23pm, Eric DeVolder wrote:
>>
>>
>> On 8/12/22 04:46, Baoquan He wrote:
>>> On 08/08/22 at 10:18am, Eric DeVolder wrote:
>>>>
>>>>
>>>> On 8/7/22 22:25, Baoquan He wrote:
>>>>> Hi Eric,
>>>>>
>>>>> On 07/21/22 at 02:17pm, Eric DeVolder wrote:
>>>>>> The use of __weak is being eliminated within kexec sources.
>>>>>> The technique uses macros mapped onto inline functions in
>>>>>> order to replace __weak.
>>>>>>
>>>>>> This patchset was using __weak and so in order to replace
>>>>>> __weak, this patch introduces arch/*/asm/crash.h, patterned
>>>>>> after how kexec is moving away from __weak and to the macro
>>>>>> definitions.
>>>>>
>>>>> Are you going to replace __weak in kexec of arll ARCHes? I don't see
>>>>> your point why all these empty header files are introduced. Wondering
>>>>> what's impacted if not adding these empty files?
>>>>
>>>> Hi Baoquan,
>>>> In this patchset, to file include/linux/crash_core.h I added the line #include <asm/crash.h>.
>>>> I patterned this after how include/linux/kexec.h does #include <asm/kexec.h>.
>>>
>>> I am sorry, Eric, it looks not so good. I understand you want to pattern
>>> asm/kexe.h, but we need consider reality. Introducing a dozen of empty
>>> header file and not being able to tell when they will be filled doesn't
>>> make sense.
>>>
>>> Includig <asm/crash.h> where needed is much simpler. I doubt if your way
>>> can pass other reviewers' line. Can you reconsider?
>>
>> If I include <asm/crash.h> where needed, which is kernel/crash_core.c, then
>> the other archs will fail build if that file doesn't exist. A couple of
>> options, which do you think is better to pursue?
>>
>> - use asm/kexec.h instead of asm/crash.h; it appears all the architectures
>> already have this file in place
>>
>> - go ahead and put the appropriate crash macros/inline functions into each
>> arch asm/crash.h so that the files are not just empty, and leave the use of
>> asm/crash.h
> 
> I think we can do this in two steps.
> 
> Firstly, make do with asm/kexec.h since all other ARCHes put crash related stuff
> into asm/kexec.h, except of x86.

Baoquan,
I've made the changes to utilizes asm/kexec.h. For x86, I did have to put what I
previously had in asm/crash.h into asm/kexec.h.

> 
> Secondly, clean up to put those crash marco/inline functions into
> asm/crash.h.

Yes, in looking at kexec.h, there is alot of crash items in there that would make for a good cleanup 
pass...

> 
> The 2nd step can be done in a independent patchset. What do you think?
> 

Yes!
eric
