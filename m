Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7EB56A126
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 13:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235092AbiGGLkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 07:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiGGLkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 07:40:11 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A75F4D4D6;
        Thu,  7 Jul 2022 04:40:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=agFHVcFUFF2YiXkPJdSmmm/zk2hZ150C4wCDqxCw7sej7clau7ZExwCu/p7WEb7vSKwd+F4oRHqZGMTZ7qxGcs3un2GIRiA38fbDKuV4eF/M+kiwMWpi2XkrUpBWBAJGhXvR1OeZLtW8wqMd53VQLKG8WOJf2IGwD/pquPRMb9iA55je65SisdcZfLiApHOsYQceT1FRIeD0UhjhH2eW+YmRkjcTWNW9+471Ih0N80cMOk+xc8lQrWQAaZSVmzztzuHE2p3DyHv6/WywiH5fNUFc45zzoHPNamU9cx0AI53N53FzDfW4n3kmVyYPli35Hq9K3d1nlfUfXQs8LzlxqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ijQD2mVC7rheYj6NsPUMO11vyxM/x1LiWheEx/MW1I=;
 b=Hpmy/YjHjRZtMBg5RNPhadHGgyb09wc/hWaqP4wCHlpiHHaKx6psdLF9fhewXFBuYuXY2KiUEOYVeYogfXiFM17tU+8OuplB5SKMj/MCYLGnDNTIErT772ZcWVnKkKEEj7HUJ8+6Ua/BBgfXiDO0hGYIDw82ccrar8fPtrJPUzwnMdLp3U/5NTkYkpF+CCCEWyDp4dmlF/sF/CiCOmieuEUA85kWWoclrEN6GklIN2cW4qBd7PlWdxFteRq3yltCja4iOdn7PGqPmh536EF3MBz5NcEBjnOgORNx2o5g/nXX0JFwdOacQf96AsE/WPOhBKw7pn5wnp/VFpgnNZu23w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ijQD2mVC7rheYj6NsPUMO11vyxM/x1LiWheEx/MW1I=;
 b=o1V0qJM0Ij6V19st7tYYjRD6uLzELp4pD8KETl/Dw3YeAjuwVLRK/LjqM/IsDWwxr5/+DCvZd+M8mtzwvlbf4NgKEbAvj8PS2yzhdsiqj1pu5WdgcVcIDzNdO58gZqz2gtHd+wy5YdvU3Kvtne4nEUlMtrwt7/bah5GXe48eATE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by DM6PR12MB3706.namprd12.prod.outlook.com (2603:10b6:5:1cc::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Thu, 7 Jul
 2022 11:40:07 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::6d50:f6c5:cea4:1d95]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::6d50:f6c5:cea4:1d95%6]) with mapi id 15.20.5395.021; Thu, 7 Jul 2022
 11:40:07 +0000
Message-ID: <9f4d8898-eb5f-aa91-57d3-66a78e9c4316@amd.com>
Date:   Thu, 7 Jul 2022 17:12:31 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: linux-next: build failure after merge of the sound-asoc tree
Content-Language: en-US
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220707200428.3eb1a20e@canb.auug.org.au>
 <872891aa-11ea-ed60-5090-940e8e7e4458@amd.com>
In-Reply-To: <872891aa-11ea-ed60-5090-940e8e7e4458@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0168.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::8) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a86088b0-fa7d-4552-a12b-08da600d7133
X-MS-TrafficTypeDiagnostic: DM6PR12MB3706:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bfh71laPS9cm7lfK+nMkPfP2lLvk0EUlksCKJFrJDGS/Bz6iTQ6brrjB64rI68qLNrEwkYV3OX4wdRVnJ5xUD9y7VaJ3tIO1MbxBX6wWlbJ6Xmf+tNlx4hl+py5Q3stX630BQIf57tugmcHtn8txcGBx1wGWZHUtEDo4fJayJTP+GsRcHjy/2Swrghummstdasw8IfII03WcpNxIlvrQxDRlRFLW6PavLVkFFUnf8Cbm2Ohuwq5qZNSA0Y22JIcOxuyxDKC5Lz7bh2s7KSgSFVaXvdzaQhfizyHnX0OQoqtXf3FbPeOvsgc+dmbWTH+NpXNdmQuk+d7it/QlU8l++Xmvn8ozc6E/eUVmjqyl1zNwRpcYmKM0LWK3BsMsaSV2b/xu4T8ze28jZrXlCOjk770V7nzapswNconhfFMbPlvC86y1ekmgj1lkac1PK+Nnz/hH7BM5R6plZMNQMHISkrdkDAzR6DNT72MSMigxiM2rrqC/INZCKAJhKo9r7s1CAW3BSb2HtcsYs4Q3BCJxeffnPFbQOD08wMlM8mEjimMQj+SxVxumGpF1FNX+uhl7HEdD76iG0bQjuDIpYPjy+ab0gcMbSqNXGeYYzm/DHEjnAqBegjL3ShhEwFHQOjYUv4hJZNsWoJMDyxPnI+tUtcHnFqNaGHwUzpvJbEh6JNEzLMiuR3pBHhrfBf+0nJuLATCUB2nfamCkbi1PhWCKh7AwYO1pknfZIYWVYgN5NepMaijBtJAg5waFo5YVml+aA4YalrsI1hcfeiWFzzkUehl7C6XLqKcY2MCCNXUvLv9tkfUmCiU618oJ5BswCai7D1AVsajUQe+aib/zLVBh8GLHug496uTUYhj1zkjHanqFOG5TJyWzgCtsDRsOGeh+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(376002)(136003)(346002)(366004)(41300700001)(5660300002)(478600001)(54906003)(6666004)(31696002)(6486002)(8936002)(966005)(316002)(86362001)(38100700002)(2906002)(66946007)(31686004)(8676002)(186003)(66556008)(66476007)(2616005)(36756003)(26005)(83380400001)(4326008)(6506007)(6512007)(53546011)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmVWRFNsbVNZeWNVNkM3RnRhM3R0WWxmN25yeDdMbnY1SnJLN1ZtWUcvTnRt?=
 =?utf-8?B?bTZ4K0NrdytoeTd4a0ZmeWRsQjluYzRVSEhLNE5QOHkrMG5TQllzS09PN1p4?=
 =?utf-8?B?R3FSZVJkUCs3MWlMc1hyTVhFSVZhdlhlQzl1WUhIYmNQUUpCMVFZeTc5TmNS?=
 =?utf-8?B?SzBRZHk2S3pBaHBUM0lHQ3RRWjRzbTlPemVMTCsxUjR0MnBXNXBsMXJibkQ5?=
 =?utf-8?B?RTRPVmEvOUkzK2c1cXYrYktMaGpuamdPK3JPUGZqVlVCVU9FNmVPQy8yWHFV?=
 =?utf-8?B?amxnazFLOVdOT3ZIdUlsVmttSGxwM0lIZDA4OVpTcTRNOE5JT0hEbkpvVDJS?=
 =?utf-8?B?dElxdk1wQ1JxZ2dRZ3RybEZnd0dSOFVVRDFjRXJ3OXVVNXFiTjJySG9EV1Bk?=
 =?utf-8?B?ck1GSml1L3hIOGdaNTI3STNGQloxYWhTZkI2WWRxQ1Bla01hR2Mxa0U4Szdn?=
 =?utf-8?B?UXExYjBGN0RNbFJBZFpsSzFFWmRxbDVHL0UxZFFLc1RsYzR3Ujk1ekh0MXlO?=
 =?utf-8?B?UmlnUWdyZFB4bVA3THJWNnRjNHhMN0MxdW05U1M4bGl0by9MTGx4am5GaDVs?=
 =?utf-8?B?QVk4dHI3d05qaDAxOUFQU3htRjIvRDE2c0lFNWtWQXFuUTRBaFFvOVRHWWZx?=
 =?utf-8?B?aWRlMXdEbzJvUHRsekFTelBCbUR3d3JRaFhBRDM0S0ZaTUVVSFMydXgxT2Jy?=
 =?utf-8?B?akdkNkV6TGpmNXRWK2kwVzdiTW5SUXVEK1NvVFl4OHZvc0EyRHVIUHhxTzFB?=
 =?utf-8?B?cnVQeGgyNjIrS3JsM28vQmNaV09CampzQXhKTG8wY3hLcC9qWElJSjYrV0tw?=
 =?utf-8?B?OVNUOHVZSEJMSTdBQlVTS3ZGclZFYkJHODhlUXVxOFgxN0FQSkJTWHhpVzI3?=
 =?utf-8?B?bDd4OGFLdTJyejQwTmphOW9hdFA0Y29ram5obGVKbmQxNEx5N2FxeWNpTWNu?=
 =?utf-8?B?Z1NDTW9tdFQzN3dLWGs1akhpRmRTYUFjTTU4S1cxSUR2eEhEbXZHTWFMck85?=
 =?utf-8?B?UGk0TjN0TlVIVmR0eEtsTXkrdXFnTS95QXByeEp4VWhXTURjSEQ0Y3B2WVBk?=
 =?utf-8?B?Ymh5N1Jac3l3bmlLT2lST0dqMzlRQmZ0clNLQmtadUN5SG0zN1RGdndHSnJK?=
 =?utf-8?B?Y1puOXE0bjNTdjQ1NE5uREtMU1FPdmtqa3I0bEQ2RjUrTUNVUUFnZWtkVzZ6?=
 =?utf-8?B?WnhsOGxoL1lPQmtpbk1zbWlmS2dzUkRCTzJ3Tk1rRlNqK2JGSGFCOFBDZzJ3?=
 =?utf-8?B?NkZHRm91OFpJQnJEM3BqNzFSMEZhcnc0djU0MXU1UzB0cWhjSC9NdVI5amc3?=
 =?utf-8?B?UTZXT3VkNjcvV3d1b3d4SDJjWUdhVFB0eUNMVFhVRnRZK1IwWFkwb1J4T0FR?=
 =?utf-8?B?UWxLOE5ya2dTcEM1V2RmNTVTRWpUU1pYdURNd1A3YTZyTVRUU3BMTlZURTFL?=
 =?utf-8?B?S2dnS1hVLzN0ZXF2SDRYYy80UUZNVkJVWEMycTZFOUlhaVdZbDVHSE1neUJ0?=
 =?utf-8?B?bW1sTDQ2YjF0aHlYUjdiVVJ1WUF0c1RQdnZhYVU2VkhOUFlXL0M4QitiT0du?=
 =?utf-8?B?MjNua0F5bG93UUFWbGI5TVBZcVFoR2VTOUZ0SkJXWldVcE51YTFTWkFmSnJu?=
 =?utf-8?B?Ukt0VlBtZmM2K1I5cTNIY2ZZWG0wMU9LWlc4VDNKMGVtSzNyNldpaVRUd2JY?=
 =?utf-8?B?djZqRWlxbzF6Y1lKTmNOcmx0Z0NMUzc0K1VEUVpod0FYVEY5amlhM01JOGRC?=
 =?utf-8?B?WTRVSHVURUM4clYrWVphV0VxU0lmWFNGQXNpMXpZTjEwbXprdzJpN2I5b25D?=
 =?utf-8?B?Q0wxcXFkQU5nWTdvUkVXVTVXbnU3KzNGYnFydmpwNmRPVTc0dVk0TStYbDI0?=
 =?utf-8?B?dmVMS0FvQ1lUQXg5NDlIT1hIZWtFcGRXMFp6bllxU0NscXVJdDF3TEo4Zy93?=
 =?utf-8?B?Tk5LVzVyUzNqVm1CQzFjaXBqbnlFdDZPMjFPaTBqaHE5RWtndThIZitHSnp0?=
 =?utf-8?B?QWo3Wm5wZUVHa20rMjc1OFJmK0k2NXQzRjZsRHJUd3UwdExZQXZkSC9UR1dH?=
 =?utf-8?B?Z3UycnZESzh6M3NybldidktTRTduRmpUNG1vY0pnSWErZW0xbWI2ay9lSCtu?=
 =?utf-8?Q?Q454wqOG7KJGmMbsIuiXJjWMR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a86088b0-fa7d-4552-a12b-08da600d7133
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 11:40:07.9220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bfzIdiwZLCLrT9PMh5dAODJNmW72l8NHF1PnY6GI+VweMghI+iG+SErepZ8lFB6TEXBJIm4UEcAsyOBNpNpbgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3706
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/7/22 4:38 PM, Mukunda,Vijendar wrote:
> On 7/7/22 3:34 PM, Stephen Rothwell wrote:
>> Hi all,
>>
>> After merging the sound-asoc tree, today's linux-next build (powerpc
>> allyesconfig) failed like this:
>>
>> sound/soc/amd/acp-es8336.c: In function 'st_es8336_late_probe':
>> sound/soc/amd/acp-es8336.c:204:33: error: invalid use of undefined type 'struct acpi_device'
>>   204 |                 put_device(&adev->dev);
>>       |                                 ^~
>> sound/soc/soc-acpi.c:34:1: error: redefinition of 'snd_soc_acpi_find_machine'
>>    34 | snd_soc_acpi_find_machine(struct snd_soc_acpi_mach *machines)
>>       | ^~~~~~~~~~~~~~~~~~~~~~~~~
>> In file included from sound/soc/soc-acpi.c:9:
>> include/sound/soc-acpi.h:38:1: note: previous definition of 'snd_soc_acpi_find_machine' with type 'struct snd_soc_acpi_mach *(struct snd_soc_acpi_mach *)'
>>    38 | snd_soc_acpi_find_machine(struct snd_soc_acpi_mach *machines)
>>       | ^~~~~~~~~~~~~~~~~~~~~~~~~
>> sound/soc/soc-acpi.c: In function 'snd_soc_acpi_find_package':
>> sound/soc/soc-acpi.c:58:36: error: implicit declaration of function 'acpi_fetch_acpi_dev'; did you mean 'device_match_acpi_dev'? [-Werror=implicit-function-declaration]
>>    58 |         struct acpi_device *adev = acpi_fetch_acpi_dev(handle);
>>       |                                    ^~~~~~~~~~~~~~~~~~~
>>       |                                    device_match_acpi_dev
>> sound/soc/soc-acpi.c:58:36: error: initialization of 'struct acpi_device *' from 'int' makes pointer from integer without a cast [-Werror=int-conversion]
>> sound/soc/soc-acpi.c:64:25: error: invalid use of undefined type 'struct acpi_device'
>>    64 |         if (adev && adev->status.present && adev->status.functional) {
>>       |                         ^~
>> sound/soc/soc-acpi.c:64:49: error: invalid use of undefined type 'struct acpi_device'
>>    64 |         if (adev && adev->status.present && adev->status.functional) {
>>       |                                                 ^~
>> sound/soc/soc-acpi.c:80:26: error: implicit declaration of function 'acpi_extract_package' [-Werror=implicit-function-declaration]
>>    80 |                 status = acpi_extract_package(myobj,
>>       |                          ^~~~~~~~~~~~~~~~~~~~
>> sound/soc/soc-acpi.c: At top level:
>> sound/soc/soc-acpi.c:95:6: error: redefinition of 'snd_soc_acpi_find_package_from_hid'
>>    95 | bool snd_soc_acpi_find_package_from_hid(const u8 hid[ACPI_ID_LEN],
>>       |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> In file included from sound/soc/soc-acpi.c:9:
>> include/sound/soc-acpi.h:44:1: note: previous definition of 'snd_soc_acpi_find_package_from_hid' with type 'bool(const u8 *, struct snd_soc_acpi_package_context *)' {aka '_Bool(const unsigned char *, struct snd_soc_acpi_package_context *)'}
>>    44 | snd_soc_acpi_find_package_from_hid(const u8 hid[ACPI_ID_LEN],
>>       | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> sound/soc/soc-acpi.c:109:27: error: redefinition of 'snd_soc_acpi_codec_list'
>>   109 | struct snd_soc_acpi_mach *snd_soc_acpi_codec_list(void *arg)
>>       |                           ^~~~~~~~~~~~~~~~~~~~~~~
>> In file included from sound/soc/soc-acpi.c:9:
>> include/sound/soc-acpi.h:51:41: note: previous definition of 'snd_soc_acpi_codec_list' with type 'struct snd_soc_acpi_mach *(void *)'
>>    51 | static inline struct snd_soc_acpi_mach *snd_soc_acpi_codec_list(void *arg)
>>       |                                         ^~~~~~~~~~~~~~~~~~~~~~~
>>
>> Caused by commit
>>
>>   f94fa8405801 ("ASoC: amd: enable machine driver build for Jadeite platform")
>>
>> I have reverted that commit for today.
>>
> 
> Hi Stephen,
> 
> We have provided fix for build error and pushed patch for upstream review.
> 
> Patch title: " ASoC: amd: fix ACPI dependency compile errors and warnings"
> patch link:
> https://lore.kernel.org/lkml/20220706205515.2485601-1-Vijendar.Mukunda@amd.com/
> 
> We will resend the fix for upstream review.
> 
> Thanks,
> Vijendar

Hi Mark,


If we have to submit the patch freshly then earlier patch should be
reverted in for-next branch.
Should we resend the fix again or else should we submit patch freshly?

Thanks,
Vijendar


