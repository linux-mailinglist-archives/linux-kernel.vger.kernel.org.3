Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6934C01EC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 20:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235177AbiBVTTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 14:19:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235117AbiBVTTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 14:19:47 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0953FBAB88;
        Tue, 22 Feb 2022 11:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645557560; x=1677093560;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=s2ZipIi5CuGfFLimKVt8w1E5Ug7gxsJrMK6khbD6qbk=;
  b=gAZ00EHBUq4pHxalJo3EQ3bqx8khtlz2OH5TP7yKDaTh4nyM8NhTQrhk
   LpY+1BQpWCZKY1S5JVyq5V5jZGKGN3jVySeE4eI/DA5raD8Brp0et0Mga
   /sVsX+ctV3bAsWNHawXBpsi60JUqTWYbXgYasuoDH1mkyzqvIOVgVPDLa
   sbpGsbTkjJrKpdfZaJEh/khscEQ05/6hj+fmatROF2QC0TRA2Y7Nmm1WO
   5w2SnFiBue4c1aVgPiyzz3+p9036oQrXQV50pkSDsHI0yKpelioD3E+Oj
   8+VvtVyMaRzpPGj2I7Gb6LDzPL4/kk2wj5L9dFQ4fNtDaG6kThzCW83A+
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="251980866"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="251980866"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 11:19:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="706732049"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 22 Feb 2022 11:19:19 -0800
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 22 Feb 2022 11:19:19 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Tue, 22 Feb 2022 11:19:19 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 22 Feb 2022 11:19:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XhYtkp1Rdtxt73NY0uPzml7ED9LpOIyjBMWZn2nyw29QXYnBT8NYwdWEw8pSIyANxigLv68IdcndGp6Etnhc56qftAV6kVozIh3bBlJd0o2We3oI12v5fHlHGjXCGGM5ETVGqpW+POWM7ED5gGskchQGh8EIzUTcqjVHCHyiGdw+xqnfIev5DaO0WAjAzSDMZg+p3ygtUbSgzlW8NlhkwERWNhWN+3kZ8aCwF0l6VdTTMCEJ5X7RS43vXDmWyoREHUIP6L3vwQAH9DRpEw3XPlaFPk3yrJnJOoFocT+2EfYiRy72FS9TunZje0kNR8GvijjR783M8ZyFeVRndz1zQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nFZVJgjsXlNCC/X7N9F6yXfOR7TBaD04lxNqI+IJNeo=;
 b=NUrAredJEtHAH5H/l38VR8Z9gOD0WjyTSzIKFP5oaNgBhPkuoZvgokflFMDUjMKHnRszpvACx0NICYZtVGvwwjeVHk7xo1e+9lbQFakJ5rkYmMWsLXOMAS6NMFHpt+6Ef2G/5iCwipMjlgBSzuuREqrdqo2mEWI0JOjQpNX3cSsHQhZhRuwskBJhLwmZ+saEvmBsExz0O4rUw1/IjX+k/Vqujqu2KViVuVnKzTfR8pD0YhqxZmEH8fiI5yaqTe5yokfAzHRkafKMbJ91DQT44/7fPq4n9QYfaFe76NN4zBxlimykJEdVUeBme+n+OKbzIW6Z8taNNUWABVk1ANpiXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by CY4PR11MB1477.namprd11.prod.outlook.com (2603:10b6:910:b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Tue, 22 Feb
 2022 19:19:16 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::55e4:9a32:8e6f:4774]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::55e4:9a32:8e6f:4774%4]) with mapi id 15.20.4995.026; Tue, 22 Feb 2022
 19:19:16 +0000
Message-ID: <80f3d7b9-e3d5-b2c0-7707-710bf6f5081e@intel.com>
Date:   Tue, 22 Feb 2022 11:19:11 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.6.0
Subject: Re: [PATCH V2 19/32] x86/sgx: Support adding of pages to an
 initialized enclave
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
CC:     <dave.hansen@linux.intel.com>, <tglx@linutronix.de>,
        <bp@alien8.de>, <luto@kernel.org>, <mingo@redhat.com>,
        <linux-sgx@vger.kernel.org>, <x86@kernel.org>, <seanjc@google.com>,
        <kai.huang@intel.com>, <cathy.zhang@intel.com>,
        <cedric.xing@intel.com>, <haitao.huang@intel.com>,
        <mark.shanahan@intel.com>, <hpa@zytor.com>,
        <linux-kernel@vger.kernel.org>
References: <cover.1644274683.git.reinette.chatre@intel.com>
 <fcbde9c3e67289eaff9cd8b34989919629fe823c.1644274683.git.reinette.chatre@intel.com>
 <YhDbGfzGWQ5RtwTU@iki.fi> <YhDb/QRYMa4+xsyv@iki.fi> <YhKLNqgPNNLS7JyN@iki.fi>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <YhKLNqgPNNLS7JyN@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR06CA0005.namprd06.prod.outlook.com
 (2603:10b6:303:2a::10) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f00f804-5ff6-4635-8562-08d9f63837a3
X-MS-TrafficTypeDiagnostic: CY4PR11MB1477:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <CY4PR11MB1477891E409014CB668B756DF83B9@CY4PR11MB1477.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qkWgEEB+i8CdCgkqMmg2PEBtGvWsg2c6U15W2ZdjIIorYV9+oys6bdM7WzG0tOBkaKRcdYgPw5WDlraO41jC98GTi1IBkPmKKL8/5oZ8pkwpqnzOUDX/jz2RergyoSvQpLjq8dNPVKACdbiRBoZyCGZwiHD2I6EGOx1AH3REcgwCmz89ua6rSlkMBysiQMKVEY3Qypu7JaJIHdzT12I9s6JqQmg64GfNqiJN8NIHBBo7g0/Zo8CXQetwnDWqnBY0zoa+xCoLT0tSBQYZpKScYrtXM+525+C7YUsuONq9+goivuWgIXfdzbNAkP44o7ZbAcKGey07fOYI9WiwIGoEPm4vI6jlHRGajLUhN7/p7XPMSdP24u9cX+TQdbJalKVRoy6EfrNC6B5Su+7b543RhV9rbYWl2ab3dLv64S6l9zI+X1+V8S5G8YRZttYr80Oe6QCqpVDa85KPxY6nEYK7j2s9AMLCdspM8qISHg7aIHY8pTSuOt0oMamjsCSHMh2ayoo4NyMXwgdB2LbqNAykfDrtHfgbQkPftXcC+OKpoYILyHC/hZUIwYwOV4LB/73uLSmWGEH2bCIm0nJ6BGEnMcpfbfxiLVX6qiNJUrDBO4Kl19KaE2sudoTT0eBTyOlxsf8uPZ2bbP/y9YTs1D4QKqmsw7lSBUp63exfB5wMXJjWYggo5o/Umdxpa4qeO9w4Ti77quYexlRRTLzYGSFDiNQ8/oWlqCRIWdioVJTVrtq5hh+jk2DywGL9FKgDBX2E
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(8676002)(66556008)(26005)(66476007)(66946007)(2616005)(6486002)(186003)(508600001)(6512007)(38100700002)(82960400001)(86362001)(31696002)(316002)(2906002)(7416002)(83380400001)(6506007)(8936002)(31686004)(36756003)(5660300002)(6916009)(53546011)(44832011)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3BIY1pSK1V4aiswamlYbmdtdHQ4TUZPdDdRL2NNU25taFNLVVk0Nk96RDZ3?=
 =?utf-8?B?bytLaWpUV3huWk5MYXgweEhYaDhvQk41My9KMzZXSU1mV002YnkvSXdYbVJn?=
 =?utf-8?B?dFk2YzQ0WGR3TDBvTkl4WlR6OWhFS05HeXFXVDY5OEk1Z0FsZ0g3TGNLWWc3?=
 =?utf-8?B?elF0NU5SSDBpTGR4NUJ6SkpQdnpOencrWHY1czR0NWcvcER3dWxYcEVFdTJB?=
 =?utf-8?B?aW1JV2xReTV6Z3cvRzljM1FGT1BrMnBpc2RnU3d4QTF4N1FQaHhnTDVScFRF?=
 =?utf-8?B?eU9JV3liTzlBYmJ2ZlBGeGlOcWpSZ3k3NkY3SkNQcVBMdHNPaUtHbFV6ZnJs?=
 =?utf-8?B?cCtsM3dZUWxKaWhlSzFkZ2tDd3dDNnFnWXhIRHJ4WUpoc0dUbnljV3ZKSjNi?=
 =?utf-8?B?ZjM5bHJydXk3emluQkQvVS8yekxmUVRkQ0JUSWZuaUVvRG8rbzIxN2F3NzZm?=
 =?utf-8?B?TlZ2elNJbzd0MHAybmF3bng1OU9ycmVkbnlyOE1JeCt5Sk5Ed1JEUTlCL2pl?=
 =?utf-8?B?QzdPSWt6SDMzWnNRMmJ6b3hGdUJ2c2NZQUE5NERqY1piSW5lT1ZzNFUxOEJq?=
 =?utf-8?B?ejlnY1pFNFFaeWRyZDE1WDA3YUxhQmtwdXhMSlBNM3dEbDJxViszZ1NneXVh?=
 =?utf-8?B?V1JGazRUK3kvQlc2QTBkd3pucjkyV0ljenU5alEwN0ZjSUxqZm1yMDNTQjl1?=
 =?utf-8?B?UW5MR3QzbzhTbnk0eGo3NXQ3VFkxUXVqM1lGVzVtRHVEKzZNaVQ0SjhWV2tN?=
 =?utf-8?B?K3IrZ3NJSkIvaDJQTGZIY0lLTXFCclJvaUxIdG91b1pxZysvalpsSkd3aWQr?=
 =?utf-8?B?SUVoeEVjTGxhSGpweGQrM0pqNDB2Z1BoZExQSUZsN2NaUjhZT2crTHd0a1V3?=
 =?utf-8?B?a2Fjai9uZkV5SjJreU1mQzFXbG0zTnozVGxuSENvb205QnhkdmpKdE9DVG9I?=
 =?utf-8?B?bTY0TlhaV1ZndURPV2xtSm9lbXdLOFdaMElGQW8weG1RVjhFV1o5VFdMMUY4?=
 =?utf-8?B?cmFSTTE2d3oxMlZ0cDVXbGczZFgzSmpoc1hSMlBhMGttRXlabmVFRGRCV0Ix?=
 =?utf-8?B?SDBSM283UktqMmpzK1llT0UvdTVMNCtpcVVSZSt4NFpCZXVTYy9nRjI4bk1U?=
 =?utf-8?B?cGpZNlpvN0FsejFmdjlkbXF2bGJHVVpwWktUb2tBSDNGSTdvYmJ3bFAvclAw?=
 =?utf-8?B?bStsMXFkYStxK21hQmFXWEdZZjB3ZklkdGpJdExNcmc1WGxuV0RETTRmNCs4?=
 =?utf-8?B?SzlTdlMySmVIdCtIM0xVVFI0ZmZUdWdSbjY1WjJxUU90eE9oZzRuU3VmdUxt?=
 =?utf-8?B?emdZSXNQMXBzYisxMTcwMlQrQ21XSllEbmRvUVJUc3FZWWlERVVzMDdpVzIx?=
 =?utf-8?B?SkdLYm8wRE5vT3FmVURBTFZVRU1KeXVQRUo1TFlqMTNMWVNyWGg0SVNSQ1BM?=
 =?utf-8?B?b216eUFjSXR3SkdLNTJKeEdIQ3VXVlVqTS9Wa3ZYNEJPY0pOZC9UQ2sxT0dK?=
 =?utf-8?B?KzFlVjhrZm9OU0NKUWNWVVVMQ2VrbUVzZjdOcWJ1djZPV0R2R3pQckwrdVIv?=
 =?utf-8?B?Yjh0d1RibXhxbThmRDZFQWpyV1J6RVNNUC9ZdFp3R1BzV3RJeHpKOXJPc3c1?=
 =?utf-8?B?dHNnWnk5ajJoWGp2YzU5YXBPSlZaMG9UY3FraGs5emg5Z3dXc2JCYTFNTmdX?=
 =?utf-8?B?bjQ2MG40TEhaNGhncklEdFZKQ3M3OTRWMmlVZHdEUWVOWWlhcXM3SDcxTDVl?=
 =?utf-8?B?N1NibWIxekZLTjlZUUI1ODJkdmpLcWsrRFcybVlkV25QQ3AzS0tEMlRuQzRU?=
 =?utf-8?B?SkFqN3VOUm5MSzEvRTQwU01XTlZTR1cyMG1ydDR4NE0yd2lEaGdwbVVZd2l3?=
 =?utf-8?B?KzY0NHY3NmZkZW1OaWwxZ09QWk9qNWI3MXJwUHlyalJkSXRPUUdGRWJvY0ZP?=
 =?utf-8?B?SEFlYlhPbS9RSXVXUWF3Q2wzMDRVSDhLa2JHRmZrRlV5VGtoNzdsZ3hxd24z?=
 =?utf-8?B?QmYxYUNsUlNTdFFyRWR2QnB4VGpJbWhNeURFdnhyYjVWRytiYjhpMFhOekYx?=
 =?utf-8?B?K2EvSVV3NUhYdjdjTjloWmoxUDFYdnVhbFM5ZTlCUmNvMTRJVTZNUmlFZ2hw?=
 =?utf-8?B?Z1hEZXdzaXFFY1kwdVJDazBnYTBiTDEvdmk5MWhJS3Rxc3dWQy94VFZLSllO?=
 =?utf-8?B?NlNjdmtzaWlvUXhDRTFIMnFMdW5DRkhBc3Q2Mm9iZUMrT0hSZGptSHJWM1o5?=
 =?utf-8?Q?SfO3ukYYppRo/t9/myJq6ePr6GcvwwVA9EyiyDRYEw=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f00f804-5ff6-4635-8562-08d9f63837a3
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 19:19:16.4668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HPRKNtStHy610A97Os59BrU1YJKi1x0X0sHmhgfg9vinxY0w3EFO9AKE6wwtHPHkbuCW+uaOlOKhO59ZLtftHYlox7L7hgk2kzsnF6z6DCI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1477
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On 2/20/2022 10:40 AM, Jarkko Sakkinen wrote:
...
 
> Do you know if it is possible to do EAUG, EMODPR and the do a single
> EACCEPT for both? Just looking at pseudo-code, it looked doable but
> I need to check this.
> 
> I.e. EAUG has this
> 
> EPCM(DS:RCX).BLOCKED := 0;
> EPCM(DS:RCX).PENDING := 1;
> EPCM(DS:RCX).MODIFIED := 0;
> EPCM(DS:RCX).PR := 0;
> (* associate the EPCPAGE with the SECS by storing the SECS identifier of DS:TMP_SECS *)
> Update EPCM(DS:RCX) SECS identifier to reference DS:TMP_SECS identifier;
> (* Set EPCM valid fields *)
> EPCM(DS:RCX).VALID := 1;
> 
> And EMODPR only checks .VALID.

After that check there is also:
IF (EPCM(DS:RCX).PENDING is not 0 or (EPCM(DS:RCX).MODIFIED is not 0) )
    THEN
        RFLAGS.ZF := 1;
        RAX := SGX_PAGE_NOT_MODIFIABLE;
        GOTO DONE;
FI;

Attempting the SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS ioctl() on a recently
added page (EAUG) that has not yet been EACCEPTed is thus expected to fail
with errno of EFAULT (indicating ENCLS[EMODPR] failure) and the returned
structure's result field set to 20 (SGX_PAGE_NOT_MODIFIABLE).

I confirmed this behavior by modifying the "augment" kselftest test by adding
a SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS call between the new memory access and
the EACCEPT.

Reinette
