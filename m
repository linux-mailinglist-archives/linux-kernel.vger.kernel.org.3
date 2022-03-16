Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67E294DAE32
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 11:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355117AbiCPK0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 06:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241893AbiCPKZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 06:25:57 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2103.outbound.protection.outlook.com [40.107.223.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8475144757;
        Wed, 16 Mar 2022 03:24:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ErHVX95cCwUbQ4cix2wz8rOSBMJ7b9G/uOkWh7qhvdDjBc5Li/dmSNMc27BhST44qPortQNTZWIMcb8lafcXEZOIA5V2EaN3dR1FzkFduibxjdua8TDE0YCKZ2jXad9nzZAsQ8AFh4pmPg4Dy7aCM8rG6Vhusyes3m3hI7bus+ZDt2alEPKi0QzuWBgJbzzKLt71Obwu3KNKYu9uQhNX1xjFBniDTfUyA00NwRunZea+kQ/5EubDXVkU0aIn+r8m2nK9qmumf3gv6o9dvQTPVYq2L6faQHkqKUPXrH8FfYHbyytI0Uqq/npHzcSZS9Qhu0aUVmGlXhsj+01P+FVbFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yWvSj3CcfxK3i2pV0scJAuJXi8beyIK/jWRBTvFKsgA=;
 b=CVkSxk9zgv/ScjpLcqRshjXYrEJoqe1DjUE4/j6mjU4ZEBytW5bcIC83rJaD3X5b/eeRJ6Wd3btavQq3yZ0eUct9geYEArI5QosUBRcoYkWoUqzjjP7HVhePSxGyCKxCPaxiPWu42d6UPbf/Dk+P0KRKnxrZKfA6Tt//jrsIKTP/nP/aR2wJuwXEdzHI2AKn7ARA9v7C6ddSSF2VL17pcdyaWkiGBcVMnS11dPYo6fAL+NzrhAElwfiTqzJ5AAlgELZnYecUaOHaDz7m31x+BM9e/jGpWHIJiKlyfTLtTZ0Q0ytFCbzS9O4F4pXbelrZhGYP+ecDKk3rzD2hINAEpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fortanix.com; dmarc=pass action=none header.from=fortanix.com;
 dkim=pass header.d=fortanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fortanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yWvSj3CcfxK3i2pV0scJAuJXi8beyIK/jWRBTvFKsgA=;
 b=LuFLKbv3RX+OwzqNobY3+6DB5wW52tSRkIYQj+0LKj20YAtyV2NTXmC2fWnhT+rvgj70r0QiVPIDKwSEooGVvnC9MYdwzWy98irMe84f/kwTsdi2fBIOPMN4IIP+LEEbPhFCe205pwkUyvVRzXd1k89L4e1HGGfCmm94ZwODzsE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fortanix.com;
Received: from PH0PR11MB5626.namprd11.prod.outlook.com (2603:10b6:510:ee::15)
 by BN6PR11MB3907.namprd11.prod.outlook.com (2603:10b6:405:83::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Wed, 16 Mar
 2022 10:24:40 +0000
Received: from PH0PR11MB5626.namprd11.prod.outlook.com
 ([fe80::919c:b806:f259:e276]) by PH0PR11MB5626.namprd11.prod.outlook.com
 ([fe80::919c:b806:f259:e276%5]) with mapi id 15.20.5081.016; Wed, 16 Mar 2022
 10:24:40 +0000
Message-ID: <e1682971-4821-8e57-3232-de7a72086991@fortanix.com>
Date:   Wed, 16 Mar 2022 11:24:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH v2 09/10] x86/cpu: Call ENCLS[EUPDATESVN] procedure in
 microcode update
Content-Language: en-US
From:   Jethro Beekman <jethro@fortanix.com>
To:     Cathy Zhang <cathy.zhang@intel.com>, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@intel.com, ashok.raj@intel.com
References: <20220315010300.10199-1-cathy.zhang@intel.com>
 <20220315010300.10199-10-cathy.zhang@intel.com>
 <53e7d3a3-a576-7ef1-fa2d-d170fa1172a1@fortanix.com>
In-Reply-To: <53e7d3a3-a576-7ef1-fa2d-d170fa1172a1@fortanix.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms010106070604040104010501"
X-ClientProxiedBy: AM0PR02CA0015.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::28) To PH0PR11MB5626.namprd11.prod.outlook.com
 (2603:10b6:510:ee::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e58ec859-0600-41c3-101f-08da07372e09
X-MS-TrafficTypeDiagnostic: BN6PR11MB3907:EE_
X-Microsoft-Antispam-PRVS: <BN6PR11MB39078F4B98992E6B53CCCB55AA119@BN6PR11MB3907.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9VG4WL4eFDXCQ2SztTQWZ+n7u9NzkUQvo2BDuekd7JabzOhmPZNjMom8mAYPr15B1uL3XICCToarzyx54GcBoo9snfxlATEInrf1fWcWHqXB3rIYHpa9MhJLz+YDvkeIEzmiXx31zfCZOsLW0EO+qfqwwZXz+fADmw5KGkLJdC5M6CqV1w1GkNndDLzP2TciM8u6iSPMZBCDKcYxzAPqFuwoiSx0hq7n3RiscCLjJgH1Alo5guKDpUxi7fvRX/2mw4X7DH3izGKiN4Bx6+/U3EhD1N/7rZKqSYeX2eVvR7SAOh5rzjNZRgys1B72RVfba0UZf8aCCJKl0ZKPQ5Z/BptTr55ATn3xIIsLYg8KB/gdhyyEXcRLEPrk9AWqX3j8EbsYTEJP7rs1Z9Dp1gnL81Y8d7bGnkl984dsOaYdHFDI04Bqg0HuhQmFY2U3x+MZ/U7COKyG0H/F2xYyZxnjLIKEbLj7fNGmuws50z2dHlR1TQWDXkFXwye1ziBhADN14wzk5U+ep1pwi4TrsmGqURfJTjMaoS4mx/M3v20j2YkYgmgIpN9j7Yd77qtRAZCJvcXF/a0CUYX52dGCXgAiDyZdWflBfHY1Hzd4Ve2pFRCLHQYpALO47nHXHTX6worf+JVy346UvOukhWHeJoNciaqq2qRmI+qMAsuYfp/y/9Q6JfAZkORmsUKfkh5HGUSQm4lwtuWhROwmtRdM4yKERJS+M9KeoNID488BM3Mdkp8Au35IPfxb54VT9xH93KSoGvsqp5ysU8eg5XhDeUgPAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5626.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(15650500001)(38350700002)(31696002)(86362001)(2906002)(8936002)(5660300002)(235185007)(26005)(186003)(6506007)(2616005)(83380400001)(36756003)(316002)(52116002)(33964004)(53546011)(6666004)(6512007)(508600001)(8676002)(31686004)(66946007)(66556008)(66476007)(4326008)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1JLM3RJVkVXNzh6UEVSR0V2YngvOUtWQWNxbGp6WElqc1JXUm10Zy9zT2N2?=
 =?utf-8?B?Rm9xekF2VGtwRitjTy8yUnFlUEFYQ0VJK1pPdUtKbDJZMEtNUmx5OERBdlM1?=
 =?utf-8?B?dmVmY2pMdEZjUHBPTGVIQndLWHVMRWRJVDdLOERQTFpXQkJBTS80WnlCWjNa?=
 =?utf-8?B?UGN4VkF2T3dDMkM1bkFobVYrYmxGN2EzZEZyU0taczEvYWlpSWZ2VDErdFBy?=
 =?utf-8?B?ZWhwZjlwNHBwbVptNGhYNVpwa1BGTjRsdlFFVW9wOFdCcE1aUkU2V3c5ZnJy?=
 =?utf-8?B?MDlpUC9DU3JDUDRXbC9URTlrNDNZUXR2V0RoTFF4QkxYQVpSayt0dDBXVHVK?=
 =?utf-8?B?UWV0Z2JHamlDUVNGVmEySlNoM1pjcWRJS1A2QSs5RUhDR1Rka3F6a3c1a01P?=
 =?utf-8?B?OCt3d01RVVI3ekl0M2llWXAvKzRSVGVPcWlULy9PeDFiUHN3a2QxZEJZdTdG?=
 =?utf-8?B?cHBHbGtIcXRhSElBemdYVVFySDhRK1B6VHFMSDdIYTRxL1Q3NFhjR3Z1ZENJ?=
 =?utf-8?B?TkFzNHVZaVhIdEQ0a0ZSV1QvVExOV3UwekJleUFpVlQzYTR0ZXNZMjIya2dQ?=
 =?utf-8?B?aWtRakRPZFFnUUE4K3dHSWlwUFRabXNKMjd1eVJQSUJpR3dxbE4vUytzZjVF?=
 =?utf-8?B?blJFYnFQaWx1cTNMaVlIWmNyMStBeE1UME41b2o5ZGNPYUNoQmhKZlJiamFx?=
 =?utf-8?B?TGJTQXd4aUp2ME5yZWdnZWlYaG9hbSt1UldVMnNMUGdyM1Q5ZllBTUYzU1Z4?=
 =?utf-8?B?UTdUcjZHaXkwOStWMEk4RXlkN05SQWs5Y0xSSXRNVTlPUkNIZG5lYnRoNnBr?=
 =?utf-8?B?UGJhL0VqTzlKZGQ0a2pTT3dxQWRGSVBqNzltNzZrMmtZNC9OSTY4b3Y5N0tn?=
 =?utf-8?B?UWxEYXhuVDE0TWVFTG9ScUliM28yTm80Q2kzTTN1aGM0dVpneWxZQmEwdk45?=
 =?utf-8?B?dzZKUFZUYkxZWnR1M2loejBGak8rSDExTFpFL3RqYlptUEtVSThlMXJXZldy?=
 =?utf-8?B?SGhOY0NlVTNjMnlNUXo0QXZjejZzR0pzS2xyNlF5Q1lRUFc4RVhHSExicEVk?=
 =?utf-8?B?T05BdVNsSVRCWDZEUGZKajdyV1pldGNXaU5IaWdPSGc3QXNqVzBaTVh2Q3k2?=
 =?utf-8?B?aHVRRDlHTGtwQlQzOG1KNWZNVXRtK1AyMktNYWg0ZWJycHppSU00cnFlaU1G?=
 =?utf-8?B?SG5DUlZIZjJmbGtSelBKYWxYbnhaTlhrbVIyTHFKeFp0b1VXQ2lQcG5EMkMz?=
 =?utf-8?B?cTZCV1BOTTFWK25KclFWNytUeWEvQ21CU1lqQlhpNXBhQzhHOWY5TSsvV2Nw?=
 =?utf-8?B?S2FDTER0akRUemc3cmVnMWdaOSsvSys3Y1Y1NktrZG1NNU9qLzI1TmJFSkVv?=
 =?utf-8?B?VHBvdVVjUmRTcTNMbXhsWVpPc09oTG4wVkhuSHFMb2VqOFk1ZmhtNDNBMito?=
 =?utf-8?B?ckxoMnJMUno0elhma084M05BcUY3OEVGdFl1NldBTlZFRzhjZXQrYWFaVWlW?=
 =?utf-8?B?aEZWcWVraWNEc09IUVFiY21JdkNYUWtlZDJ3b1JEdGEva0x4em1EemhFUGw0?=
 =?utf-8?B?YkhFSEdraHRWUXhudnduVFJjTlBxNmxkYXhPVFFoYklOWU4rRmVqR0t4aG9V?=
 =?utf-8?B?UGJtc001WmZoc0V1aWloZXNiRU9wWFI0VnQwKzFjVXV5VUZwaUIwMlU4bWhZ?=
 =?utf-8?B?RStVa3poWC8vM0dmMTRJRDdFU2xFdTA1V0w5RGhoQWxoUnhlVGpCNG5xOGV6?=
 =?utf-8?B?endFb2p1dUFPWmtmWmdwbUxha0JqdmZibit4ajlJNEpwaElBUDF3VFMrVHZM?=
 =?utf-8?B?S1Q2SjA0aEIyelBxR2pUU2pxalRzY3JaaXhGUmFQRlptWDB2d2l1QzR0THdX?=
 =?utf-8?B?WFZEZkpFRStxMXpWbmdpS3c4eWQ0N0NaYkkrVEtEaXI3QmRqQ2ZPYXN6eTlU?=
 =?utf-8?B?S3hkVERyWXRIK3pUak1Wc0VBWUhHc1dpeUpZZHhjOXRIMFZBMkpZQ2ZXdndZ?=
 =?utf-8?B?dnNxc1pRR0R3PT0=?=
X-OriginatorOrg: fortanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e58ec859-0600-41c3-101f-08da07372e09
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5626.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2022 10:24:40.6049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: de7becae-4883-43e8-82c7-7dbdbb988ae6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xpqJMPMpqAver+yQmCCxnG8e/RsSI25+PwbgFQHM2HJlJJFFvjh61Ogoawg9+Hf2HRCrPahWljIJ67P1qvjGOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB3907
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------ms010106070604040104010501
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2022-03-16 10:46, Jethro Beekman wrote:
> On 2022-03-15 02:02, Cathy Zhang wrote:
>> EUPDATESVN is the SGX instruction which allows enclave attestation
>> to include information about updated microcode without a reboot.
>>
>> Microcode updates which affect SGX require two phases:
>>
>> 1. Do the main microcode update
>> 2. Make the new CPUSVN available for enclave attestation via
>>    EUPDATESVN.
>>
>> Before a EUPDATESVN can succeed, all enclave pages (EPC) must be
>> marked as unused in the SGX metadata (EPCM). This operation destroys
>> all preexisting SGX enclave data and metadata. This is by design and
>> mitigates the impact of vulnerabilities that may have compromised
>> enclaves or the SGX hardware itself prior to the update.
>>
>> Signed-off-by: Cathy Zhang <cathy.zhang@intel.com>
>>
>> ---
>> Changes since v1:
>>  - Remove the sysfs file svnupdate. (Thomas Gleixner, Dave Hansen)
>>  - Let late microcode load path call ENCLS[EUPDATESVN] procedure
>>    directly. (Borislav Petkov)
>>  - Redefine update_cpusvn_intel() to return void instead of int.
>> ---
>>  arch/x86/include/asm/microcode.h |  5 +++++
>>  arch/x86/include/asm/sgx.h       |  5 +++++
>>  arch/x86/kernel/cpu/common.c     |  9 +++++++++
>>  arch/x86/kernel/cpu/sgx/main.c   | 12 ++++++++++++
>>  4 files changed, 31 insertions(+)
>>
>> diff --git a/arch/x86/include/asm/microcode.h b/arch/x86/include/asm/microcode.h
>> index d6bfdfb0f0af..1ba66b9fe198 100644
>> --- a/arch/x86/include/asm/microcode.h
>> +++ b/arch/x86/include/asm/microcode.h
>> @@ -3,6 +3,7 @@
>>  #define _ASM_X86_MICROCODE_H
>>  
>>  #include <asm/cpu.h>
>> +#include <asm/sgx.h>
>>  #include <linux/earlycpio.h>
>>  #include <linux/initrd.h>
>>  
>> @@ -137,4 +138,8 @@ static inline void load_ucode_ap(void)				{ }
>>  static inline void reload_early_microcode(void)			{ }
>>  #endif
>>  
>> +#ifndef update_cpusvn_intel
>> +static inline void update_cpusvn_intel(void) {}
>> +#endif
>> +
>>  #endif /* _ASM_X86_MICROCODE_H */
>> diff --git a/arch/x86/include/asm/sgx.h b/arch/x86/include/asm/sgx.h
>> index d5942d0848ec..d0f2832a57b3 100644
>> --- a/arch/x86/include/asm/sgx.h
>> +++ b/arch/x86/include/asm/sgx.h
>> @@ -412,4 +412,9 @@ int sgx_virt_einit(void __user *sigstruct, void __user *token,
>>  int sgx_set_attribute(unsigned long *allowed_attributes,
>>  		      unsigned int attribute_fd);
>>  
>> +#ifdef CONFIG_X86_SGX
>> +void update_cpusvn_intel(void);
>> +#define update_cpusvn_intel update_cpusvn_intel
>> +#endif
>> +
>>  #endif /* _ASM_X86_SGX_H */
>> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
>> index 64deb7727d00..514e621f04c3 100644
>> --- a/arch/x86/kernel/cpu/common.c
>> +++ b/arch/x86/kernel/cpu/common.c
>> @@ -59,6 +59,7 @@
>>  #include <asm/cpu_device_id.h>
>>  #include <asm/uv/uv.h>
>>  #include <asm/sigframe.h>
>> +#include <asm/sgx.h>
>>  
>>  #include "cpu.h"
>>  
>> @@ -2165,6 +2166,14 @@ void microcode_check(void)
>>  
>>  	perf_check_microcode();
>>  
>> +	/*
>> +	 * SGX related microcode update requires EUPDATESVN to update CPUSVN, which
>> +	 * will destroy all enclaves to ensure EPC is not in use. If SGX is configured
>> +	 * and EUPDATESVN is supported, call the EUPDATESVN procecure.
>> +	 */
>> +	if (IS_ENABLED(CONFIG_X86_SGX) && (cpuid_eax(SGX_CPUID) & SGX_CPUID_EUPDATESVN))
>> +		update_cpusvn_intel();
>> +
>>  	/* Reload CPUID max function as it might've changed. */
>>  	info.cpuid_level = cpuid_eax(0);
>>  
>> diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
>> index 123818fa2386..d86745d8cc7d 100644
>> --- a/arch/x86/kernel/cpu/sgx/main.c
>> +++ b/arch/x86/kernel/cpu/sgx/main.c
>> @@ -1380,3 +1380,15 @@ static int sgx_updatesvn(void)
>>  
>>  	return ret;
>>  }
>> +
>> +void update_cpusvn_intel(void)
>> +{
>> +	sgx_lock_epc();
>> +	if (sgx_zap_pages())
> 
> Doing this automatically and unconditionally during a microcode update seems undesirable. This requires the userland tooling that is coordinating the microcode update to be aware of any SGX enclaves that are running and possibly coordinate sequencing with the processes containing those enclaves. This coupling does not exist today.

Also, a microcode update may not affect SGX security at all and doing the EUPDATESVN procedure may not be required for this particular update. This case is called out specifically in the EUPDATESVN documentation.

--
Jethro Beekman | Fortanix

--------------ms010106070604040104010501
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
JTNkQWN0YWxpcyUyMFMucC5BLiUyZjAzMzU4NTIwOTY3LGMlM2RJVD9jZXJ0aWZpY2F0ZVJl
dm9jYXRpb25MaXN0O2JpbmFyeTA9oDugOYY3aHR0cDovL2NybDA1LmFjdGFsaXMuaXQvUmVw
b3NpdG9yeS9BVVRILVJPT1QvZ2V0TGFzdENSTDAdBgNVHQ4EFgQUvpepqoS/gL8QU30JMvnh
LjIbz3cwDgYDVR0PAQH/BAQDAgEGMA0GCSqGSIb3DQEBCwUAA4ICAQAmm+cbWQ10sxID6edV
94SAhc1CwzthHFfHpuYS30gisWUfWpgp43Dg1XzG2in3VGV7XrzCCGZh4JM/XQWp+4oxmyV4
2Qjz9vc8GRksgo6X2nYObPYZzQjda9wxsCB38i4G3H33w8lf9sFvl0xm4ZXZ2s2bF/PdqvrK
0ZgvF51+MoIPnli/wJBw3p72xbk5Sb1MneSO3tZ293WFzDmz7tuGU0PfytYUkG7O6annGqbU
1I6CA6QVKUqeFLPodSODAFqJ3pimKD0vX9MuuSa0QinH7CkiPtZMD0mpwwzIsnSs3qOOl60t
IZQOTc0I6lCe1LLhrz7Q75J6nNL9N5zVwZ1I3o2Lb8Dt7BA13VFuZvZIzapUGV83R7pmSVaj
1Bik1nJ/R393e6mwppsT140KDVLh4Oenywmp2VpBDuEj9RgICAO0sibv8n379LbO7ARa0kw9
y9pggFzN2PAX25b7w0n9m78kpv3z3vW65rs6wl7E8VEHNfv8+cnb81dxN3C51KElz+l31zch
FTurD5HFEpyEhzO/fMS5AkweRJIzwozxNs7OL/S/SVTpJLJL1ukZ1lnHHX0d3xCzRy/5HqfK
3uiG22LPB5+RjNDobPAjAz2BKMfkF/+v0pzn8mqqkopQaJzEAbLbMpgQYHRCjvrUxxwjJyUF
b2Z+40UNtMF4MTK7zTGCA/MwggPvAgEBMIGWMIGBMQswCQYDVQQGEwJJVDEQMA4GA1UECAwH
QmVyZ2FtbzEZMBcGA1UEBwwQUG9udGUgU2FuIFBpZXRybzEXMBUGA1UECgwOQWN0YWxpcyBT
LnAuQS4xLDAqBgNVBAMMI0FjdGFsaXMgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIENBIEczAhAo
rKRKpFwMN77KaahISgU8MA0GCWCGSAFlAwQCAQUAoIICLTAYBgkqhkiG9w0BCQMxCwYJKoZI
hvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMjAzMTYxMDI0MzRaMC8GCSqGSIb3DQEJBDEiBCCC
/d/yxQtHJp36eFsFW2mmfcRvBgUL4oC4UPVpXYRMQjBsBgkqhkiG9w0BCQ8xXzBdMAsGCWCG
SAFlAwQBKjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqG
SIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMIGnBgkrBgEEAYI3EAQxgZkwgZYw
gYExCzAJBgNVBAYTAklUMRAwDgYDVQQIDAdCZXJnYW1vMRkwFwYDVQQHDBBQb250ZSBTYW4g
UGlldHJvMRcwFQYDVQQKDA5BY3RhbGlzIFMucC5BLjEsMCoGA1UEAwwjQWN0YWxpcyBDbGll
bnQgQXV0aGVudGljYXRpb24gQ0EgRzMCECispEqkXAw3vsppqEhKBTwwgakGCyqGSIb3DQEJ
EAILMYGZoIGWMIGBMQswCQYDVQQGEwJJVDEQMA4GA1UECAwHQmVyZ2FtbzEZMBcGA1UEBwwQ
UG9udGUgU2FuIFBpZXRybzEXMBUGA1UECgwOQWN0YWxpcyBTLnAuQS4xLDAqBgNVBAMMI0Fj
dGFsaXMgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIENBIEczAhAorKRKpFwMN77KaahISgU8MA0G
CSqGSIb3DQEBAQUABIIBACtsH+L8l/+6G9np3lvQ03KZHU4ITg6XJ7HKK0vRZ2NArEj80YCQ
qrNcbop/NMO+eNFgJxEiot1h1wfEKk84ZT8qfFzhy3C87MOqOQEFCpcHf04qB1PXf7StpOog
ShYEG4GKUBqQthmlBEVPHCE2MsV2DjYAc88D1PI1xLw3b1Gi+HzCg861Twe35sGgEus3wxa6
exfviTOaFl0kNUBuAVWEcKrrM5Hxn2MNO24aHyHeeCGjMW1uUJiK5FqtCGBeDXqIo+HNwzaJ
hEYggfWqR0WW79ZdalNbKWHbXHlugCCENat9zkzQ89ldAGchkOPMq6QsdUEbHbb8DkU0bCYl
ibgAAAAAAAA=

--------------ms010106070604040104010501--
