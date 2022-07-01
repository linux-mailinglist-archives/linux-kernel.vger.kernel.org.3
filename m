Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 618BD5638D4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 20:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbiGASBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 14:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiGASBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 14:01:42 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6602403D0;
        Fri,  1 Jul 2022 11:01:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DSQltbIbV72YRAzgL2wFpXNCn69vhs+iud8zkw2KGn4WIjOpQqUKV4FfMUncGI6SeV/ofzl7ZbyO4m2bDKR+9lpQxB6r9XkmTdygqQvBeJnRYCLZ9UDK51TExohBM1CvgE9CMihvxSqu5ZifIhHpLixHQCsUIimaWu44z1+7ccuXCp5BZNFMtMwKVWw1XaLwoYOPDW5anGY6yi80mtMu2zvJnhpc7Rj8Nbdomm/SAPQtAX4DowlrSmmvFpYS+SDNnYIIIkrfgrYsfZyiZfJLZQDLx6+s1rizTEmU4PPPlxPeTmzmYTp6Gi8Ve+NvJowXFVDTakrTvxc1HYjgG24vGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YOokRvFsS+jZx3mdxZ0VdhW57u04R6rq+X1Cft4XwW4=;
 b=NoKZ4HlAntCoLXfqrhwH/TiUueiaBKt6qJcPxuE1WhJQc/1l0kyjR33Xub1Im2IZqvsbHPjr0aBPkGUPB0rVQmFRPB48GJwHj+HbYeXClycl0GFCp/9Q0s516wdFpPWyEoa72zGUkFBJSP10H/ol+aNJu/suhxDHXLIU/UyuT8+ErMJSeQBuIhUph2WBY5MbJR4ftS0Yl+XvGpAxuWZY+t+9aD6a7W1JToVdQSkjXNbyxHSLfz/G4n3dzPlhn6/MC9I+u2D9T9OPtNU8uO35zwLgCBe58hiq5ISOexEDllSGp1EW4CaSeHzHNYQHNgAqc7Xfm4G4WNbtpphx04sWCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YOokRvFsS+jZx3mdxZ0VdhW57u04R6rq+X1Cft4XwW4=;
 b=hInacaaBZij0a6W+2nY86y/IuK3u2uAD8fX9G8/+PJU9iHcj7Kajcz/uV2mUZArNxrgDrdIuZhkZL0AYFJxbz3rrCIuRzLvSUIDAeQcHsh5b2xL0nQCx2fpe+gErIHFlU/dQUKiJnFUBFwuEjHryXRjwdueNNz8wmddeztiqo6k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BYAPR12MB2728.namprd12.prod.outlook.com (2603:10b6:a03:61::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.17; Fri, 1 Jul
 2022 18:01:36 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::1143:10a5:987a:7598]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::1143:10a5:987a:7598%5]) with mapi id 15.20.5395.015; Fri, 1 Jul 2022
 18:01:36 +0000
Message-ID: <d97ece9b-98fc-e60e-71f5-06bd3d68ea31@amd.com>
Date:   Fri, 1 Jul 2022 13:01:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 04/10] ata: ahci: Use `pm_suspend_preferred_s2idle`
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-pm@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220701023328.2783-1-mario.limonciello@amd.com>
 <20220701023328.2783-4-mario.limonciello@amd.com>
 <4e0783ac-b9f5-24ff-f7c6-7b64549b8f9c@opensource.wdc.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <4e0783ac-b9f5-24ff-f7c6-7b64549b8f9c@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0201CA0038.namprd02.prod.outlook.com
 (2603:10b6:803:2e::24) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb7fcd00-8e0e-45d8-e419-08da5b8bbd71
X-MS-TrafficTypeDiagnostic: BYAPR12MB2728:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fz6kY9Ca4kzSD3e3rpkcGSRCbm40/Q1PK0FhQ4mFRUKicDhCibwMfCzegqk/jbviN2OQu8yOTU2sHgslduYuyq0GYChhuii9XSJN2kBAoGPCmqQ5/XsR5EvOb94IfzNmqdQLXveIYp1M7sF46XnM7zonfy/BuSE7+4PBIyE4iFcaFgzbEcVXYNSBPjER0cfP7P0741P5kB0WzMH8JqxHYbgHQ3QAWyvknrmLo0xDjrUjw1QN+7u45sog95tyeAL9e9Zi4VB0a6aqfJJU0U2PztfiUVnD4MONjVwgePDdIgQSb+5vjVR0rfvCcNlj8hbuhfLzA5EfNsPEm4e9lB6Q4NyRqMQOXjFr2VsWVItazRg2tMmjC1aBWwDy4j6OaZE1As4tsofQtqrRYci9/EhlEC2k76jpRQxUqfFye75iJkcF5F7NjoJesEJ/JvwUYOAqYAoJm+dZ03ye39Nxq3P1Ov/CRcLi+JOrK8U0AZ9f/Z2WOhSs6x5CQU1As9l2/zRzdCaaWsFrqFJec+DgIHI/IlJnSNhcKWyHO7njTQq87LwXFaWteGup+hNLc6B8y6aAjzfkbX6EWE2LowRZdAEzpD/y+Jx+SsiLf88eXDQ83JBzCRW+ELa/j1rZIxeXKfyyEHXXxVC+IRabMasoS1ikD98T7XaipP40O8E/7nhl9CoCB/xZ0hC5eRkrcH3vzKyHk/acLeZ9fTY1mfHFLy82YGLw0/jhotmF3A1U2YCSvW+Rn/kUS5dgY1maCFNHkg7pPhTPTJuVcUVRuiAcKBdg06YTUk/bFI6wvO6CMo1t99sKc4UOkVzaR38RmyDOSIVYpT1wgVgIC4AnYzyMEphb08AFdy0D7yJSwahSLbfjDOm+jxuhck8Ld+4PPuYUQn5faxxr4IZLETWB+L8ZoTs5VA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(36756003)(4326008)(8936002)(31686004)(478600001)(86362001)(6486002)(31696002)(53546011)(6512007)(44832011)(5660300002)(8676002)(66946007)(66476007)(66556008)(83380400001)(186003)(2616005)(6916009)(316002)(38100700002)(41300700001)(966005)(2906002)(6506007)(81973001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUREQVA0WFlGM1FNMW0xWStucGhFOFVZTi8wUFpvMDFRaFRPRzBjWkRJUGtM?=
 =?utf-8?B?OXNGdFNqcXVLQ08wWnQwMHcrWWJrUjQ0VWw2dG9saDkxY1hlemROUkdnUTZZ?=
 =?utf-8?B?Q1dCc1dqbjFJS01abUg5WGVZNmxpSnYwd2lyU0VDTk8xcjNsOGtPVy9lT3px?=
 =?utf-8?B?ZUNSRDU4NmJUOEwwRVl4UngvVUl6YkRJT0dWcjZqTG5pczFoU25lQWgzd0Mw?=
 =?utf-8?B?MlJzVkxBWFVkUTJQNjVPaHlhbVhYb04rSzVNRVJDUEhYTTN5a0dFTmpDaUFk?=
 =?utf-8?B?MW91L3dUMWE3enJKM0dHRUJDK051MnpWdktOTmpSSWZydytGRkZ4VmxOblYw?=
 =?utf-8?B?VURSRTE3VDBuNk9YNGlyR1d4MS94TDZJL3lRVGpVWWtTMTdaMWlabGJCcGo3?=
 =?utf-8?B?Kzhhem1nYVdDZVNPS2pqeEV1Q0diUU9UTEdiQTFPS1FlWXFOSHdjUXJoUDNt?=
 =?utf-8?B?dlFlZGxXOTlndFg3V01YQXZ4aHZxWmI5OVhoejJpU1lFd1ZZbEI5TVY5NHVM?=
 =?utf-8?B?dkc2R0sxVmNQMm94WkUycFdDYXUyZE13U2xTdTFIaUwxTHJMM1pjQ0txNjRC?=
 =?utf-8?B?YnJaTVIyUjNBbGsvWkR0Y05URDlNTWtzR1FzRGYvTjZUUHZNRktOYXd0Yi92?=
 =?utf-8?B?Vm93Z2lHSnZtRFNINUNVZ1hmMEZhRlM2REZBMzR0YktWNDFXS0pPZHFDalh1?=
 =?utf-8?B?NlFnbWsyK0ZKRks2WnlvNWFCUHRERUlqREJCc1lGeUlMekJucUFxRjh3MlNY?=
 =?utf-8?B?cmZaZ1lUdTNpY0JUcCs2RXlQdG1Za2w3MXpMaElSYXhDd04xSFNOWXl2VlVR?=
 =?utf-8?B?QTB3VThjMllUQTBUZ002cWw5cnhxQkZ4N21CR0FLOEFDdU5XNFp5ZEEvMU83?=
 =?utf-8?B?eHgxLzc2c25QcFducXd3UDZxRDBQSUFUdUdmU09lckY0SHJobkV5NkRySEFh?=
 =?utf-8?B?c0s4OGY1Sm5PSGNSN3E1V1RCZVhnSzFkNXlYVXVNa2tLN0xoa1JNbVcxWk5D?=
 =?utf-8?B?R050VjNhdU0xa1dGQVhPYlFndFUwbENDWUpUUFh1bWFUZjZIaHQ5NE1ndWJG?=
 =?utf-8?B?cFZjd254VUZQN0ZCODRGeThSNU14UHRlWnJ1QnY0bXVkeVFrOW1pdDFoVjN2?=
 =?utf-8?B?NFZUTUg1TjIyRjl2c3NRRStJZnhEcmJyWldqbXZzZXNYdVJuamZGMzNDN0Vm?=
 =?utf-8?B?TkR0Z1pZUzNlUlRhaVBNb0FMdisxbDhBeVJobW9KTHdUcnhmVDVNY1BqYU41?=
 =?utf-8?B?Qmt5Q050U2FtRmhhUGp4RXMrdzZ3cTU2Q0JCUlJIZThPYTJlbU14M096aW9m?=
 =?utf-8?B?NEZQYis3blJZQXlZMFcwU2hxU0ZMdVdqQ3VrUjYxRm53Q3BqNmN6MEhCbHVZ?=
 =?utf-8?B?NTdlamp2ZE1pOGQ3S3FPSGxRVU5zdjBwc0k4dWtNOWFIZFFKYUM2dHhCSUYz?=
 =?utf-8?B?VHIxSjJMN2FWbGhvRVNNSWVVbFQzcGxDcThyWkF1cWQ2WjVVTGZlbTBoSGRY?=
 =?utf-8?B?QU1rUTNMYnZPUUE4Tnp0OFFUalIxME4xTnQxZDhzVkpER1pJNHBNNm1wY0R1?=
 =?utf-8?B?WXdYL1g2RUkrODlVMlorVU1jVE1WUTZHdHhBVjE2cDRXelJlYzNhdXNZdFVH?=
 =?utf-8?B?K2YvRDR1SmxCTENKY1drZkpHS0lia2trMmJlRzBZSHN4NENlUjdjelJPWHV1?=
 =?utf-8?B?d29jQXIwcFE5dU9EOEZ5QjIyUDFDUXE3V2tBUzJhSk1takdObjVOL3VuYStM?=
 =?utf-8?B?bE9XRWZ0aU5SdzZXQndJSTQvWVhwdHpWdXNvemNwUjQ1c2dnc2xkNDRoUHgy?=
 =?utf-8?B?V0Qxa01EV0ZjNHovbVBYRHhSUHZSYTFUYnZqd3BYc25JQk5XVWxwSVQ3MXNC?=
 =?utf-8?B?cFl6UWJLMk9NQTFrMW8yZ2h6c1ZEQ1M0VDlzemxaVm1sOFdYZmVCdmg3YURZ?=
 =?utf-8?B?QkZCSzVVRkFLbllwOXVpbnJGNTVzTVZ3RHNmRlZ2Q3NTcmlMTGFuL0VBS1R1?=
 =?utf-8?B?RGdSeGZZSVg0VmhkemJKS1RiL2E1bGllRXNhc2Q5OWlyTWxQbXBNdGhIeUZN?=
 =?utf-8?B?ektHOXF2U2tqRmh5K05zeTQ1SWxvbHlQSWwyeFVKRGhiOHdxMHkwNmN5bDVr?=
 =?utf-8?B?bjFrNTZmVit4dHFFbEVVM2VLak5maUhPQXdrTFdPZWRLOWROS3JmSGxPZGp6?=
 =?utf-8?Q?XJhcNEsKEcfMXWmGhxdcQxpGT9yhVwZwXX1pvE8bpLZR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb7fcd00-8e0e-45d8-e419-08da5b8bbd71
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2022 18:01:36.7517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7EuZaaClZ70xRie8Hqqz7OwBlNPstS2q1v9RolJ7QWwgyYxOOnc3jVuI+UTzVZBMLTA5INSZtvU1lrmmqDDgOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2728
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/1/22 00:06, Damien Le Moal wrote:
> On 7/1/22 11:33, Mario Limonciello wrote:
>> Drop the direct check from the FADT and use the helper instead.
> 
> Where is this helper defined ? Seeing that this is patch 4/10, I have no
> context for this patch. Please send the whole series next time.
> 

My apologies; I should have also included you at least on 1/10, but was 
trying to save your inbox for the other 8 patches that were not relevant 
to you.

The whole series is on LKML here:
https://lore.kernel.org/lkml/20220701023328.2783-1-mario.limonciello@amd.com/

If there's a v4 I'll include you on 1/10 (unless you also want to be on 
the others too).

>>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/ata/ahci.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
>> index c1eca72b4575..3f79b732dd00 100644
>> --- a/drivers/ata/ahci.c
>> +++ b/drivers/ata/ahci.c
>> @@ -1611,7 +1611,7 @@ static void ahci_update_initial_lpm_policy(struct ata_port *ap,
>>   
>>   #ifdef CONFIG_ACPI
>>   	if (policy > ATA_LPM_MED_POWER &&
>> -	    (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0)) {
>> +	    pm_suspend_preferred_s2idle()) {
>>   		if (hpriv->cap & HOST_CAP_PART)
>>   			policy = ATA_LPM_MIN_POWER_WITH_PARTIAL;
>>   		else if (hpriv->cap & HOST_CAP_SSC)
> 
> 

