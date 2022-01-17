Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC7CB49049E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 10:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233695AbiAQJLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 04:11:36 -0500
Received: from mail-bn8nam08on2066.outbound.protection.outlook.com ([40.107.100.66]:44192
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232619AbiAQJLf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 04:11:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eIatK0w3CKBUzFMFdePnf0s+RZtDsP2CNyQy1p4dOInWkTkP/QqdZ6gfh0KjeZfRuh7vtA8dqmefuBiMS7l18/z/AERjyb5aKGfs+lF8DEYYj9CWdiKqprPAplZnpIHpYJ6fo2/dJv5H6L10gWc5yhDhK5mvdtpMBeN0tKPKmTbZP0eeZEmuJS/wn13oMZVahp1j65CDX7tZgGYLU85SR4wkqqLbDmtOqPLeTx5VzTWLH722DnKyuE/2lYRxUhykKMwt3/Hncvx62qoGbgX9YYPO2hvUjRi2MV/OMMyOZGFvkdyMa+3qnYQ9SLarkV/J7tS51DyTKEAjCnjADxDaMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ifnf/ynwjsV12LShpKjCfim3XnZYGXliWAuVbZIHOuQ=;
 b=dX35v3BAuBnEQI2KOCY6/auJ06b0pn1qKT/jrELY+RYSpTvtgc9VdgmmegobGX2NydYQv5Q+IyThg6YstgzD4o6gqKxTHaEM/klXHIt/E9p0hfJkUrt0STd7s3DoSW0vnNmv61e4U0tRXIU+Lo1F3FV82dTO+rJuxY2sork3BeNJtioHa7x8gdNaa7eHt4CyUhCANfxCiW3SMExSUzxWmiohZ7ca6Y6T2IT9QSd7RJecEuPjQcOFTfIiCLpZp4C7mmv9GzBW9E6eP8Js1SPjVJng1ArTJuJMpGTzzXYJZi6tP3X9z8+eMQGSMBvb3EG5auB6RV7diMnQCCq4q7TlKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifnf/ynwjsV12LShpKjCfim3XnZYGXliWAuVbZIHOuQ=;
 b=A5IjQWj21+QjCl6Zse8tFqqqpfYd3KG2Py/xGnaH+nvCGG4zEZr0E7PNYHvRI3H8Maon6/9EPKepcE0y9Try6DpOOMly0ARi9uar0nyJ7LivCVtwbX8N/67uJXOREVNJ3rrfLjeoQmWHZDh8hQZIZWVSO9eJ7qwekTtC/XQpS38=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14) by CY4PR12MB1573.namprd12.prod.outlook.com
 (2603:10b6:910:d::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Mon, 17 Jan
 2022 09:11:30 +0000
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::b4d6:f148:3798:6246]) by MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::b4d6:f148:3798:6246%7]) with mapi id 15.20.4888.013; Mon, 17 Jan 2022
 09:11:30 +0000
Subject: Re: RIP: 0010:radeon_vm_fini+0x15/0x220 [radeon]
To:     Jan Stancek <jstancek@redhat.com>
Cc:     Borislav Petkov <bp@alien8.de>, amd-gfx@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        lkml <linux-kernel@vger.kernel.org>
References: <YeLyToEyBFnQqQGB@zn.tnic>
 <1049939c-422f-787a-7481-21a2598eeedd@amd.com>
 <20220117084158.GA2673957@janakin.usersys.redhat.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <369435ef-8e3d-dc82-8c89-c043fe8ac756@amd.com>
Date:   Mon, 17 Jan 2022 10:11:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20220117084158.GA2673957@janakin.usersys.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AS8PR04CA0206.eurprd04.prod.outlook.com
 (2603:10a6:20b:2f3::31) To MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25a14113-bb8a-485c-616f-08d9d9995917
X-MS-TrafficTypeDiagnostic: CY4PR12MB1573:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1573F0DB1E6B2272D7EE257C83579@CY4PR12MB1573.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QrM98xU63azmUdZJU69bPLWJzq/M/OTjwpdkKGEcvfeRvE1cj3LjcOY9hyuGzJMAjBBNxwEdpCTTyACWHReISG1e15EVAFskIWP1p2OHltE5t6Gf9bJh1XP2vOApl/hcHSvMYOMmx19SL2tL5hj7lOOI17H0L62FYwX+NdxtDp5VBy++RGps5midtLHZQc48V63i394btKjzbXNVWQFyHkX+Fwb2GXjw8zfd/854RvRnQeF0/09JSQEMbuO/z5tI1dMX3y6JRBgj4ptspPr3LFluiInXl5cHfAYJPERBhOfCdgOdHLg8ngV0598Eu8Ntp4yASOzoXwuodeSUD6E08m4cwQGiFU7Pn9/cEatoohqzxp3AIFnzyNaRUIS38T7Nw47eQJrgM0LqxQ15WVqaGCjkSEKJnqQjixE9LzoLeKMpbLQ62JuWwDrVPHiZRvYRPY+RmOpfaqcUD0IrA5ZKnebfqCAg4852G62G7zkSOcgt59vT+rHxQn2EHXkCbTwdQ4/z4ZVAolw7A3wQ40NILTt4ptAcWB9Sz69N11bkevWaeyQlhwRgramACVlt+iCCjddaQKKX0laKIpsNb1cs5WZcKCmu9gY5nuP7HRMvOr/RNs3HxWUC0elaLhJTkA+3pKp/H3IbpV/TrCeVheEeTqjv+pb5ibOLbGQYaU4jX+s4M37WM9SIA/u7/S4hZrcUlY18E7cDNHK4QlfdY+t2gj9wZFhe0pKSYouDPl0enzslYBGqcDftDiblMEWEVg4ziai6ef/5dFsbijixgLA+Y1RT+MZELAphI1kY4B+KxHNlsLFP1HXRGNLXFMaj30fN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1201MB0192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(966005)(5660300002)(66946007)(66476007)(4326008)(86362001)(6916009)(186003)(508600001)(26005)(6486002)(83380400001)(31696002)(316002)(6666004)(6506007)(8936002)(66574015)(8676002)(6512007)(2616005)(54906003)(66556008)(38100700002)(45080400002)(31686004)(2906002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGdSaTVsaEhxQ0oxaUcvTTlTK3pPQjFOYU9qaGdnQXpVNGNJWmtaMElvNXVH?=
 =?utf-8?B?RDNPcXpjVWpTZkp0UWxvVndYV1EwUzgzR21abDBGSSsxbmZKNEhRZFh5QnRr?=
 =?utf-8?B?OGh2UUlPYnpUKzcrSGVLeEc3MlpiazBuclU2dTMrV3V2TlpxQm9GR1NLS3lQ?=
 =?utf-8?B?bU1ic3pRL2E3c1lzYW9LWXJxZXhZa0xLbGNOemN1eFk0Q2ZOdHFud1JPT0pj?=
 =?utf-8?B?Rk1XaGdTamU0MHpidnQxbnoxY3FIUllEaldNeUg3QzFqUkdkMnptUDMzSnR0?=
 =?utf-8?B?TGhSQmFER3F6Ly9zVWp0N0t2RnhaYnovZVdpa3JtNU53R1dKVlJvQzJpV2M1?=
 =?utf-8?B?MTBGNzYwU3FpVkZhbEgreE5EM0E2bXdmSklmSEg0RVZMRlJVNUI5K3IyN0dU?=
 =?utf-8?B?Um5EcHRmNGZQcVFValhRN1IwMlhJVFJRT3h6bStQRWhoTzJiZkxDaXpsTlpO?=
 =?utf-8?B?SHhwdGI4UEZkRDVQNFZWL2dZN2p4L3hCSXVxZzNNVlptM1Bpd3lkbUMvcm0x?=
 =?utf-8?B?dnhBNzQ4dmZIMjFZa3BMblV2ZVB4bXlQWmpIc3dqSlk2aWJFV3g0R1lWUEFz?=
 =?utf-8?B?ODh0MzBjdXdXUmNHaktBbVhiQWlQWEJ5M0N4NDR4WHBIUUYzUjNCWDhrNjUv?=
 =?utf-8?B?dFkvRHluTmVzL0ZPeXZCWmpJSnVLZmh0QkxWWlVaaURSK3U4aElJS1ZLaG41?=
 =?utf-8?B?N3ptR3B0R2tQMzR5MlRHUzN2ckpjS2xYOU5SS1Ixc2czVTk4MUJ3bmxHdUlV?=
 =?utf-8?B?NEgvQTNETzVjZ2F1ZlVpY3FSZDRZTTByeU0zTDBNbnNxVXBOTnltWk1EaVdB?=
 =?utf-8?B?RGt6TzYrbFVZV0FYeFE2TnFwZzkwT0pjS253VFJrVjFUTWxueUd5TVhDbHZC?=
 =?utf-8?B?Qzg5NEhrdE12ZzRvZG5VNms2REU4Nm92cnRJUVh6WmtsZFJ0TjI0c0xTVGZR?=
 =?utf-8?B?ejVhTUF1YU5LWmplZHhxc1J6WmFkcGl1TkcvT3hGVHdveSs2ODFLbWxUYzlF?=
 =?utf-8?B?VlpUSHF1UVpWcTA3KzB5SUNVZFV4VEg1YTJzbnliS0NUNDB1TXR2Z1RMTmRj?=
 =?utf-8?B?cjBhVldQSzV5NnpaTnVab2w5TWovMmhaVnVJcSt4bVpicmZnOENkNFh2c3Mv?=
 =?utf-8?B?Qjluc3Y5OW41M0VzclpzS0UzWEh4M3dibGxPN2U5VGN6YzlmbGxMemwrVmlx?=
 =?utf-8?B?bFMzbE5ZUktzWlYzR2JsN1JVcFhqdjB5OER3RHVaaEsyZkQzbVZWblBqbUYy?=
 =?utf-8?B?b2N2dnhWZFFsMjNCYnVheExmYm9QSmUzNm95K1EvbFF3bkFUMjB0YTcxV1Nt?=
 =?utf-8?B?M3FrS2xXVExvVE5YSDNVZHlyemtEbzN3WnNUaGNuaStnSVUzb1BiNWNHckt3?=
 =?utf-8?B?RFlua3R1VnlDR3BSYnl6Y3lOMjFUQXgwcE9LclFkQnhZSWZvckQzK2JiWDhL?=
 =?utf-8?B?a2lidTQ4eGlTdkFKVzZRNjlvR2xHYmxJZDVISFp2Q1JWYXh0SjN1dFhMMytn?=
 =?utf-8?B?cXh4MUtHVi9oZDRQWTlSQ0g4UGNsM25yb0ZDR0IxV2t1SjlMSmNHbFpOV0hV?=
 =?utf-8?B?RmZQOFR4U1hKRHg5SlVDb0xKby9XYlVmU25WeHVNT0k0R1BoOEFlSUFGWVNh?=
 =?utf-8?B?MUJibEsyOVh6TnAvaSs4RnBXRWtpUWpHeUhKLzI1Q1JGSDV6TEo3NDNaWFBR?=
 =?utf-8?B?ZVlOWUY2MGVLdjIvZGUrRjJWZnBFa2lLY0tYZ3NYeTc3M0l6RlB1Y29YQ29k?=
 =?utf-8?B?RXVGQW5ScjA0MzVscHdsbk5zY2JMOHljMTEwQ2dEVWxOV1E4Zmo5bUk2aDdF?=
 =?utf-8?B?SWpzQ3lQbURBdkx6aHo0bVBRbmZFcEYybDhKMjc5SmtHQ2JDVHVpYmpJenNZ?=
 =?utf-8?B?ZkdhU0JwUktYMjJCY3A1RzIxOHBHalVWWVpablhkVlBseWlMQ082YWlwdzM3?=
 =?utf-8?B?T2JpYVRTNmdSYnNYM0g1dDY4cjFsYW1CeE44bmxnT0s4Nk5RTGk5MFM1Nk5y?=
 =?utf-8?B?Vk0ySzhqUnBoU09EYm1Bb1VCc0l2cG8zUDNaQk52VXp1dDM1bi9UU0FUZFIz?=
 =?utf-8?B?VzY3ZEp3VGhNN1UzTUhITGNVbS9QbEpydStvVGpKQjFhU3I2MDZlVG14empZ?=
 =?utf-8?Q?Srlo=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25a14113-bb8a-485c-616f-08d9d9995917
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB0192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2022 09:11:30.1313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1I8a4HSjtQy2H7BjLATYyS0skcVz245bQbQvUG6EVT4EWHr2KSmd0pg0diNkVdtf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1573
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 17.01.22 um 09:42 schrieb Jan Stancek:
> On Mon, Jan 17, 2022 at 08:16:09AM +0100, Christian König wrote:
>> Hi Borislav,
>>
>> Am 15.01.22 um 17:11 schrieb Borislav Petkov:
>>> Hi folks,
>>>
>>> so this is a *very* old K8 laptop - yap, you read it right, family 0xf.
>>>
>>> [   31.353032] powernow_k8: fid 0xa (1800 MHz), vid 0xa
>>> [   31.353569] powernow_k8: fid 0x8 (1600 MHz), vid 0xc
>>> [   31.354081] powernow_k8: fid 0x0 (800 MHz), vid 0x16
>>> [   31.354844] powernow_k8: Found 1 AMD Turion(tm) 64 Mobile 
>>> Technology MT-34 (1 cpu cores) (version 2.20.00)
>>>
>>> This is true story.
>>
>> well, that hardware is ancient ^^.
>>
>> Interesting to see that even that old stuff is still used.
>>
>>> Anyway, it blows up, see below.
>>>
>>> Kernel is latest Linus tree, top commit is:
>>>
>>> a33f5c380c4b ("Merge tag 'xfs-5.17-merge-3' of 
>>> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux")
>>>
>>> I can bisect if you don't see it immediately why it blows up.
>>
>> Immediately I see that code is called which isn't for this hardware 
>> generation.
>>
>> This is extremely odd because it means that we either have recently 
>> added a logic bug or the detection of the hardware generation doesn't 
>> work as expected any more.
>>
>> Please bisect,
>> Christian.
>
> I'm see panics like this one as well on multiple systems in lab (e.g. 
> ProLiant SL390s G7,
> PowerEdge R805). Looks same to what Bruno reported here:
>  https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fall%2FCA%2BQYu4rt2VHWzbOt-SegA9yABqC-D36PoqTZmy6DscWvp%2B6ZMQ%40mail.gmail.com%2F&amp;data=04%7C01%7Cchristian.koenig%40amd.com%7C42f29e6eb93243584c2108d9d9953e25%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637780057291895847%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=HO5dYKo7kQHtneS%2F5ftl9KobWa%2BIjgXKjf7SXe0aRcw%3D&amp;reserved=0 
>
>
> It started around 8d0749b4f83b - Merge tag 'drm-next-2022-01-07', 
> running a bisect atm.

Not necessary any more. That is probably caused by commit 
drm/radeon/radeon_kms: Fix a NULL pointer dereference in 
radeon_driver_open_kms() ab50cb9df8896b39aae65c537a30de2c79c19735.

I'm getting other bug reports for that one as well. Going to take a look.

Regards,
Christian.

>
> [   15.230105] SGI XFS with ACLs, security attributes, scrub, quota, 
> no debug enabled [   15.234816] XFS (sdb1): Mounting V5 Filesystem [   
> 15.342261] [drm] ib test succeeded in 0 usecs [ 15.343311] [drm] No TV 
> DAC info found in BIOS [   15.344061] [drm] Radeon Display Connectors 
> [   15.344330] [drm] Connector 0: [ 15.344961] [drm]   VGA-1 [   
> 15.345174] [drm]   DDC: 0x60 0x60 0x60 0x60 0x60 0x60 0x60 0x60 [   
> 15.345991] [drm]   Encoders: [ 15.346617] [drm]     CRT1: 
> INTERNAL_DAC1 [   15.346942] [drm] Connector 1: [   15.347561] [drm]   
> VGA-2 [   15.347746] [drm] DDC: 0x6c 0x6c 0x6c 0x6c 0x6c 0x6c 0x6c 
> 0x6c [   15.348598] [drm]   Encoders: [   15.349217] [drm]     CRT2: 
> INTERNAL_DAC2 [ 15.349521] BUG: kernel NULL pointer dereference, 
> address: 0000000000000000 [   15.349974] #PF: supervisor read access 
> in kernel mode [   15.350305] #PF: error_code(0x0000) - not-present 
> page [   15.350675] PGD 0 P4D 0  [   15.350814] Oops: 0000 [#[ 
> 15.431048] CPU: 0 PID: 410 Comm: systemd-udevd Tainted: G I       
> 5.16.0 #1 [   15.443401] XFS (sdb1): Ending clean mount [   15.451541] 
> Hardware name: HP ProLiant SL390s G7/, BIOS P69 07/02/2013 [   
> 15.451545] RIP: 0010:radeon_vm_fini+0x174/0x300 [radeon] [   
> 15.452689] Code: e8 74 cc 7a c1 eb d1 4c 8b 24 24 4d 8d 74 24 48 49 8b 
> 5c 24 48 49 39 de 74 38 66 2e 0f 1f 84 00 00 00 00 00 66 90 4c 8d 7b 
> a8 <48> 8b 2b 48 8d 7b 18 e8 30 1e f4 ff 48 83 c3 c0 48 89 df e8 34 f3 
> [   15.454412] RSP: 0018:ffffa3494800001 R08: 0000000000200000 R09: 
> 0000000000000000 [   15.533944] R10: 0000000000000000 R11: 
> ffffffffc04f7810 R12: ffff979b4ba46730 [   15.533945] R13: 
> ffff979d5c260000 R14: ffff979b4ba46778 R15: ffffffffffffffa8 [   
> 15.533947] FS: 00007f3a13141500(0000) GS:ffff979d4ba00000(0000) 
> knlGS:0000000000000000 [   15.533948] CS:  0010 DS: 0000 ES: 0000 CR0: 
> 0000000080050033 [   15.533950] CR2: 0000000000000000 CR3: 
> 000000031c7fc005 CR4: 00000000000206f0 [   15.533952] Call Trace: [   
> 15.533956]  <TASK> [   15.533959] radeon_driver_open_kms+0x118/0x180 
> [radeon] [   15.533998] drm_file_alloc+0x1a8/0x230 [drm] [       OK   
> [[   15.961755] drm_client_init+0x99/0x130 [drm]  [   15.961777] 
> drm_fb_helper_init+0x32/0x50 [drm_kms_helper]  [   15.961809] 
> radeon_fbdev_init+0xbc/0x110 [radeon]  [   15.963653] 
> radeon_modeset_init+0x857/0x9e0 [radeon]  0m] Mounted  [0;[ 
> 15.964003]  radeon_driver_load_kms+0x19b/0x290 [radeon]  [ 15.964474]  
> drm_dev_register+0xf5/0x2d0 [drm]  1;39msysroot.mou[ 15.965196]  
> radeon_pci_probe+0xc3/0x120 [radeon]  [   15.965972] 
> pci_device_probe+0x185/0x220  [   15.966225] 
> call_driver_probe+0x32/0xd0  [   15.966505] really_probe+0x157/0x380 
>  [   15.99bus_add_driver+0x111/0x210  [ 16.467150]  ? 
> 0xffffffffc0412000  [   16.467805] driver_register+0x81/0x120  [   
> 16.468069] do_one_initcall+0xb0/0x290  [   16.468359]  ? 
> down_write+0xe/0x40  [   16.469008]  ? kernfs_activate+0x28/0x130  [   
> 16.469267]  ? kernfs_add_one+0x1c8/0x210  [   16.469563]  ? 
> vunmap_p4d_range+0x3dc/0x420  [   16.469858]  ? __vunmap+0x1df/0x2a0 
>  [   16.470466]  ? kmem_cache_alloc_trace+0x1a4/0x330  [   16.471224]  
> ? do_init_module+0x24/0x230  [   16.471485] do_init_module+0x5a/0x230 
>  [   16.471779] load_module+0x145f/0x1630  [   16.472022]  ? 
> kernel_read_file_from_fd+0x5d/0x80  [   16.472762] 
> __se_sys_finit_module+0x9f/0xd0  [   16.473480] 
> do_syscall_64+0x43/0x90  [   16.473778] 
> entry_SYSCALL_64_after_hwframe+0x44/0xae  [   16.474123] RIP: 
> 0033:0x7f3a13d11e2d  [   16.474422] Code: 5b 41 5c c3 66 0f 1f 84 00 
> 00 00 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 
> 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d bb 
> 7f 0e 00 f7 d8 64 89 01 48  [   16.476010] RSP: 002b:00007fff9cb92b78 
> EFLAGS: 00000246 ORIG_RAX: 000000 R08: 0000000000000000 R09: 
> 0000000000000002  [   16.977414] R10: 0000000000000012 R11: 
> 0000000000000246 R12: 00007f3a13e6d43c  [ 16.978320] R13: 
> 0000555c5eba3080 R14: 0000000000000007 R15: 0000555c5eba3d70  [   
> 16.979218]  </TASK>  [   16.979381] Modules linked in: xfs radeon(+) 
> drm_ttm_helper ttm i2c_algo_bit drm_kms_helper crct10dif_pclmul 
> crc32_pclmul crc32c_intel cec ata_generic ghash_clmulni_intel drm 
> serio_raw pata_acpi hpwdt  [ 16.980516] CR2: 0000000000000000  [   
> 16.981179] ---[ end trace d6f7f573dad76bd2 ]---  [   16.981861] RIP: 
> 0010:radeon_vm_fini+0x174/0x300 [radeon]  [   16.982257] Code: e8 74 
> cc 7a c1 eb d1 4c 8b 24 24 4d 8d 74 24 48 49 8b 5c 24 48 49 39 de 74 
> 38 66 2e 0f 1f 84 00 00 00 00 00 66 90 4c 8d 7b a8 <48> 8b 2b 48 8d 7b 
> 18 e8 30 1e f4 ff 48 83 c3 c0 48 89 df e8 34 f3  [   16.983766] RSP: 
> 0018:ffffa3494801f8e8 EFLAGS: 00010286  [   16.984124] RAX: 
> 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000  nt     - 
> /sysroo[ 16.984981] RDX: 0000000000000001 RSI: ffff979b4ba46730 RDI: 
> ffff979b4ba46750   [   16.985898] RBP: 0000000000000001 R08: 
> 0000000000200000 R09: 0000000000000000   [   16.986730] R10: 
> 0000000000000000 R11: ffffffffc04f7810 R12: 0 ES: 0000 CR0: 
> 0000000080050033   [   17.488057] CR2: 0000000000000000 CR3: 
> 000000031c7fc005 CR4: 00000000000206f0   [   17.489013] Kernel panic - 
> not syncing: Fatal exception   [   17.489404] Kernel Offset: 0x0 from 
> 0xffffffff81000000 (relocation range: 
> 0xffffffff80000000-0xffffffffbfffffff)   [   17.490485] ---[ end 
> Kernel panic - not syncing: Fatal exception ]---
>

