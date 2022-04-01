Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457F94EFA92
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 21:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348109AbiDATtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 15:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233551AbiDATtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 15:49:43 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2042.outbound.protection.outlook.com [40.107.101.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2FE1D2059;
        Fri,  1 Apr 2022 12:47:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AY8FXS9N5atjTQ54ypSQRDyYoDuNIg2QmDoTwIz/Pl8eNb9jOiLANIbqXCKWX3CPLhgbFtJNFQAwReaxSc4IPeFD9e0z8g7SMrZuHqaDj3QhxK1Ny9BiYprKfWvr7Bat5nKS5Td/7scYuXHe+PwmOwQNxkKLMhS+SPLDduM+Z0HqPHmpEs5XGHVASikHFMb0d4nSbfYmfDdZQzYC14gHNGjQW/6w+GULSD7zeeAmj0VkzrUWstWqT9SDbpe6SVeCR+fzSnX1GxS0IW6HmwOu4sMT9BTtXisHT6Nz45cEPUWlBdhp+1uPLj+ttAIB/kcRWcEd3Fm0GUKsSepboIyXLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jrMU/uAvMO64RSmUkIx5/83aWzrt6fHQUzsYK8kKFzA=;
 b=iVvTv/dbefg2DSKzfsTSAwEZYdLVyw79ykToRxIMs9NIpSH/+F5g96hQ0FyqbTje0HRkgbDqfRgd06TpDri4i2Ua/f8a1Hnas0nmLUChotfW7n9Il7dBdPaEreRiUvBI+LNCwVaWKlXUlpQvTXw+V/un3gZ3gInQY07Z8JeeQzMMgDgV0GA8W73Op3Tlrx5ZLiU5ffGj8ckItyDH52zDD6UYdEqV2TIqrRrY3ZHOzRHXnbAtJWzEpasavEYywCWZShY2knMs882BS6azmj4B7y9OEA3v895eh4akJuwtBfPSRhrlgMgs7d/gyKMeBgyhvL9QoFza8k/P0OL46eu1HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jrMU/uAvMO64RSmUkIx5/83aWzrt6fHQUzsYK8kKFzA=;
 b=yEAm9BBmvOj9Z72lJGqkM0LFpn+XHjVIn/y61Rjbqm97ySm43TVYxQPoKXlOyhCSpbsarCbcjYBKP7dxVxy6KUeSqGFa8ASauEeGmJNRFngVIaNcbKSqso6Emj6Pf49/g/JaNorYRfALeyBHHcdMBCvglBNpnluJDASEnTCHk3s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by BN9PR12MB5353.namprd12.prod.outlook.com (2603:10b6:408:102::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.19; Fri, 1 Apr
 2022 19:47:49 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::313b:8981:d79a:52d0]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::313b:8981:d79a:52d0%5]) with mapi id 15.20.5123.026; Fri, 1 Apr 2022
 19:47:49 +0000
Message-ID: <0499f8ae-6966-be4b-5af8-e7e568bfcd5f@amd.com>
Date:   Sat, 2 Apr 2022 01:17:35 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: Bug 215744 - input from the accelerometer disappeared, regression
 on amd_sfh on kernel 5.17
Content-Language: en-US
To:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Cc:     Jiri Kosina <jkosina@suse.cz>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Marco <rodomar705@protonmail.com>
References: <048ef583-4a8f-96b0-68a3-45ab9ec8d6df@leemhuis.info>
From:   Basavaraj Natikar <bnatikar@amd.com>
In-Reply-To: <048ef583-4a8f-96b0-68a3-45ab9ec8d6df@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0098.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::11) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6c587fb-e7e3-47ee-64f6-08da14188069
X-MS-TrafficTypeDiagnostic: BN9PR12MB5353:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB5353E84EABF14B8B0F615F76E6E09@BN9PR12MB5353.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jG2hyzoNfaW7dfjr1jiKFH6nePMxKmSnN7V9XY91MtWtach+fovD/LjApRORPDM1hGUeC/lsCMyqgPEUpDx0EEkST67GpIMfGFEXhfrUTaF6rzqUa9Ai5tkbmiUD2OiMutFS/JCMhgpXpqdUsWt/pn2Ggw7MFUVKmPUKviJEc893yx3jHcs80lxtvjIO9Eou/EdOqF96y+a+PU8sFmvn33eJ6Mdj0YHovEo7VtQpT3BRWE0C188UN8dc5JMtIKq3APAcioBFJqjM8WU07tEp1oh6zXaur42FLwt/WEpM2KrTaTTyb0RRNYXsy3OCpJr7wwK8FaEqeEA8OBRxgNS4sc1zwzba1bEbpIyPerrdxoCHK7F7sZKQwpiFSFo76zKIvN1xvQyovR5iAqwHA0Rx1f25k8Gh/0N0NDdpIRLna1M7/vZK7AUwacB/Jc6yzkWZtLlZaUQFXrVVlH+mQrKpmoV6gctLRraJciE8W1MyuT0fYVmtoB5BzumgpK/bRu2haIoI5zaJAJWKwT3kpRU8OHhIPcienuS10N99ktGWo2epQ0muiLIuRau0FHC86Yajht2ZnLZepQw4yqfBb2ftLjNMwUmg+jRWoZAjPttkiT05vX9187QsdsgpDcrt0UfK+kkxupRuegj2sA3ixRaIxHXUmJwU/LL8PgeiEzwY407B3tXwlDIV4Pvi9GiYOZz8xC40mRTL0Yp4pQ/yAblhsS7NsNfrllyY8mDvJxZOKW2AlPmRTl4xvgRTFAEyW6q/fTR8a7v3Juvaf3n+Dynb84Lnp6OdfkiRvPGsUOyrrP6px0s/PyI4/J/nXjZnZxaekBDLCXbet5ulnTuXSddW8mYMt6ES/bnqkFhM9BK3ff0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(2906002)(83380400001)(8676002)(45080400002)(6636002)(54906003)(66556008)(6512007)(4326008)(66476007)(6486002)(6666004)(36756003)(53546011)(966005)(508600001)(110136005)(66946007)(31686004)(316002)(26005)(186003)(19627235002)(31696002)(38100700002)(8936002)(2616005)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmtMT3NOMmVWL21uU2JLOXA3dkpYMm9QODJrM0hmRk53RXo1VlcrQzJxT2Er?=
 =?utf-8?B?SXFyTmJCaE9ad0FvQUloUVhtMkUzc1JUcmJNeUs1eURhaXI5Q0tjK0pkTjZB?=
 =?utf-8?B?UWI5QmRKWU1lajNEMkJ1ckRycnlHcVNQWUxLWmpTV2NRN0sxOWxFTWI0WHJQ?=
 =?utf-8?B?NlpDQkREczljc0NjQTVkb3ZlLzVxM09hU1kvcDVzS1dCekN3Zy9wcXRaVUpV?=
 =?utf-8?B?QWk4dGZvVUdCaGNXQ0VwVW1QbTY1aDE2MExsWmQrMXFId01rT1E2Y0VPbVI1?=
 =?utf-8?B?UlNuc05Ja2RqNkt1TTZTNXp3eEZSRzJqM1FkU3FkR2p1Mng5clhzZUliNlJ5?=
 =?utf-8?B?UERBZGtmTUZ3dGdNQ1VRZnpKOXI2VW1ZTm9DY0lLczVGeEkzaEs0YXphZ3Y0?=
 =?utf-8?B?VjY5a0dVZDJyMTRnTkg1YVJ2bVBYTTJoR1NiVGJlcVRIZXE0ZTNmSUZPa2ZI?=
 =?utf-8?B?SUduUFRMUGtDb0FnSmtjK1o5djNmRktNL3h2U1hGZnBlWnZTN3FaK2Y1N25p?=
 =?utf-8?B?RzFMckZjMElpNnBTRmpERkVNVEFOaTUyb3lseXp1NUJvSUxKbno5QXQ2UE9j?=
 =?utf-8?B?UVRZUTh0dzdtRkI1d0RNN2w0N1dmTGNFcUhQQmI0SHJCSzJGUUVHSkVJcGNK?=
 =?utf-8?B?RGovRjFVdnN6LzdCTTFFV3lWZ3Q3YlhrdVVzVDZlOXhYWVE2YTYyWGZMVWdq?=
 =?utf-8?B?bnZhU2lvTjlMbXV4Mk9NVkpmK2sxQmpGVUhaRWNpVU9pVVZzYVFkenJheUJo?=
 =?utf-8?B?WlRFVDlpZTZ3M1BJVzJHKzdZcndWQVY3WmlwekJYWlE3YWFGZU8vUWJhUHNh?=
 =?utf-8?B?ZDhjL2NyMXlBTEZtNWg2NkVNbHgrTHIyWkFCUy9SMzFXc1hKTWNjTjk1QW9l?=
 =?utf-8?B?VlZWQXdNTVZ5QTlXSmlnTmRwWXBTYklIa3k1R21JV3JJR0kxblgrVlZ3cDZw?=
 =?utf-8?B?NWUyQlZTS25reU5EVFkzWjRkU3JCM1o3eElhWTJiRXk4elVLOVlxSlh1SEpM?=
 =?utf-8?B?eHgrLzVvaDRWeDd5REQyUi9zZzNDUm4vVGhUVFBiMzNORUtQLzB5STJhNDh4?=
 =?utf-8?B?MUJSemlSRm1hckpsRkN6R1lCUUQySlo2VVQybDNEN09rNmpSVU05VDd4NW5l?=
 =?utf-8?B?QmZ0MVQxZWljeTRGSDdzSFlEWmxibUdzRHJuNHFtSW9LRUtKS3F5aVV3aGlo?=
 =?utf-8?B?MlJJSmRMQjJUQmZWMG15RkdtZFhkTkZlMGhCSnhxQklHQjIvQXdSZWtvY2Ir?=
 =?utf-8?B?SytQSjJGMVJpWGRtVmdMczJUTW05Ymw4THplZ3ErRS8ydTV5eFhpQ3dmUmlM?=
 =?utf-8?B?ZVFUcXpLWGxxK0lZMW5acUFmMTlZNFhWay9HVmJXNlA2dWJCUVlUVGtXSEd5?=
 =?utf-8?B?azJjeU5ka1A2WWpFVERwTlI2aWUyVUFkWWhLNTZBRXlvM05KOVlnL2V1VTF1?=
 =?utf-8?B?R3pGbnRYR09ZMTNCMEFLWmNrTjByRWNLMWFBTUlLN1NhV1liTWxJZ3NON2tP?=
 =?utf-8?B?WVJVU3NuU0ZOUEcxbm92WTlOdDlFYzcrdks4c1pJMzcyeFJxRWFDOHB6VDNk?=
 =?utf-8?B?bnNTQmtMWGdjTnlZSk53ZHZTbStUZWV4MjJZeVhXS2dxcVRINU8vRkJqRmdH?=
 =?utf-8?B?Y0NwK2tMc1Y5b01ZZ1hMNGZUcXljV3lqTHN4cmFNVWdWL2pKVGFKN0NNenNm?=
 =?utf-8?B?TGdVM3hPMDZkWnFrTHV4SzdjU2lwWitCZy9WTHhkK3J3Ri9Nbmp5cUV6Z2pP?=
 =?utf-8?B?bEhIZWdSY0pKMGtFdFB5ZEY4SFAySDdPMVp2bmxYdzQ2SEZRcWRHVzI2SnlQ?=
 =?utf-8?B?cVFmN2tkUDM4eGFCeEEwTDJJbFdwdnZzNzE1NW15ZS9mVExKbi9Sb29HSnpW?=
 =?utf-8?B?dlZZdVZ3dGtlcEluOWdYRFcwWXdvNUI1c0NMODdXaTg3RGFtb1FBRGhBellp?=
 =?utf-8?B?Q25kMWtIQzdzT2laR3lkWkYxdVhPc0dNV1FyYjQ0Z0wwd0FvMjBYaWJGYXQx?=
 =?utf-8?B?SnZKUzZMQzZHL3ZJMUlGVjRwZUdIUW5IdVIxZHBmTTIwdFRHdU1XU2RqR1I1?=
 =?utf-8?B?aVdsVDVOVzQyUFBic3FrQllzL0o1dmtaM0EyeXZmTUFaVWMrVWM3SDhsWnNa?=
 =?utf-8?B?d09DNWxCcVZIUHV1TE82VzNBTUkxYStaeDJwWTV3QWN3WnFMeVNPYWl1QStw?=
 =?utf-8?B?bXdrc01qLzY1RjFHWXkxYmJ0MXF6cDU4LzZVWXhWNmhRSGlNdkN3cjlnMVhU?=
 =?utf-8?B?M29UcWZGY0dEdkNIVXV2KzRSbVc0NldCOEI1dDlaV0JxVE8yeCswNXg1c1l4?=
 =?utf-8?B?RkRIMytITndLMHl5ZmFONVlZZ1Rpc2dVK0NwRUhhbFhUK2VacitGdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6c587fb-e7e3-47ee-64f6-08da14188069
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2022 19:47:49.6100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EBaQieawHy0qRr7OYDGsd3364OpSefbPAApol6zY68x6muUzRUWSBMBVydtuoMEUPPfkHd075mBzEBpmiu4Jyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5353
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Committed patch is disabling the interrupt mode and does not cause any
functionality or working issues.

I also cross verified on 3 system and working fine on 5.17 and not able
to reproduce or recreate.

Output on 5.17:

--------------------------------------------------------------

root@amd-HP-ENVY-x360-Convertible-15-eu0xxx:/home/amd# uname -a

Linux amd-HP-ENVY-x360-Convertible-15-eu0xxx 5.17.0+ #5 SMP PREEMPT Fri
Apr 1 23:28:34 IST 2022 x86_64 x86_64 x86_64 GNU/Linux

root@amd-HP-ENVY-x360-Convertible-15-eu0xxx:/home/amd# monitor-sensor

    Waiting for iio-sensor-proxy to appear

+++ iio-sensor-proxy appeared

=== Has accelerometer (orientation: normal)

=== No ambient light sensor

    Accelerometer orientation changed: right-up

    Accelerometer orientation changed: normal

    Accelerometer orientation changed: right-up

    Accelerometer orientation changed: normal

    Accelerometer orientation changed: left-up

    Accelerometer orientation changed: normal

    Accelerometer orientation changed: right-up

    Accelerometer orientation changed: normal

    Accelerometer orientation changed: left-up

    Accelerometer orientation changed: normal

    Accelerometer orientation changed: right-up

    Accelerometer orientation changed: normal

    Accelerometer orientation changed: bottom-up

    Accelerometer orientation changed: normal

    Accelerometer orientation changed: right-up

    Accelerometer orientation changed: normal

root@amd-HP-ENVY-x360-Convertible-15-eu0xxx:/home/amd# dmidecode -s
bios-version

B.16T19

root@amd-HP-ENVY-x360-Convertible-15-eu0xxx:/home/amd# dmidecode -s
system-product-name

HP ENVY x360 Convertible 15-eu0xxx

root@amd-HP-ENVY-x360-Convertible-15-eu0xxx:/home/amd# dmidecode -s
system-manufacturer

HP

root@amd-HP-ENVY-x360-Convertible-15-eu0xxx:/home/amd#

------------------------------------------------

Looks like this is not regression. May be some hardware/firmware bug.

Just curious reverting this patch how it is working just suspecting
firmware undefined behavior.

If possible, please check on other platform/system also if same behavior
occurs.

Could you please provide me platform/system details so that I can check
this behavior?

Thanks,
Basavaraj

On 4/1/2022 1:36 PM, Thorsten Leemhuis wrote:
> Hi, this is your Linux kernel regression tracker.
>
> I noticed a regression report in bugzilla.kernel.org that afaics nobody
> acted upon since it was reported about a week ago, that's why I decided
> to forward it to the lists and all people that seemed to be relevant
> here. It looks to me like this is something for Basavaraj, as it seems
> to be caused by	b300667b33b2 ("HID: amd_sfh: Disable the interrupt for
> all command"). But I'm not totally sure, I only looked briefly into the
> details. Or was this discussed somewhere else already? Or even fixed?
>
> To quote from https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugzilla.kernel.org%2Fshow_bug.cgi%3Fid%3D215744&amp;data=04%7C01%7CBasavaraj.Natikar%40amd.com%7C9155f6987d45479f721208da13b682f9%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637843972013904577%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=HbQ5LymDwsc94RZhNuzN83%2F0BUplqRUG7bB%2BXymViP0%3D&amp;reserved=0 :
>
>>  Marco 2022-03-25 15:22:19 UTC
>>
>> After updating to 5.17, the input from the accelerometer disappeared, completely. No devices available from IIO tree. First bad commit causing it is https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git%2Fcommit%2Fdrivers%2Fhid%2Famd-sfh-hid%2Famd_sfh_pcie.c%3Fid%3Db300667b33b2b5a2c8e5f8f22826befb3d7f4f2b&amp;data=04%7C01%7CBasavaraj.Natikar%40amd.com%7C9155f6987d45479f721208da13b682f9%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637843972013904577%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=odHA0EIxLb0xpSJJ9ShzgGL0%2BOAJ6tbG68lQe0QOqLY%3D&amp;reserved=0. Reverting this and the the other two on top fixed this. Tried to not revert only the above mentioned commit, but it's still not working.
>>
>> Marco.
> Anyway, to get this tracked:
>
> #regzbot introduced: b300667b33b2b5a2c8e5f8f22826befb3d7f4
> #regzbot from: Marco <rodomar705@protonmail.com>
> #regzbot title: input: hid: input from the accelerometer disappeared due
> to changes to amd_sfh
> #regzbot link: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugzilla.kernel.org%2Fshow_bug.cgi%3Fid%3D215744&amp;data=04%7C01%7CBasavaraj.Natikar%40amd.com%7C9155f6987d45479f721208da13b682f9%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637843972013904577%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=HbQ5LymDwsc94RZhNuzN83%2F0BUplqRUG7bB%2BXymViP0%3D&amp;reserved=0
>
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
>
> P.S.: As the Linux kernel's regression tracker I'm getting a lot of
> reports on my table. I can only look briefly into most of them and lack
> knowledge about most of the areas they concern. I thus unfortunately
> will sometimes get things wrong or miss something important. I hope
> that's not the case here; if you think it is, don't hesitate to tell me
> in a public reply, it's in everyone's interest to set the public record
> straight.
>

