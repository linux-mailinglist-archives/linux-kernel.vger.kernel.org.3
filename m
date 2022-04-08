Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84EF4F9802
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 16:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236880AbiDHO3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 10:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbiDHO3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 10:29:31 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4FBA353A86
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 07:27:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TKbRu+WuiZxsSU9n7kClWqoRlnztCljlL816yzz62hI0Y/3Z5qmORN5LMkiTDRtaJA9PHI6O4vpTFlENkzX6vQRcPQii7Jj9CjZwhTVXfv1xvGGMeJsk1/QfsuR5o4crZ8S1oG4ncMxELqTNydsxAa5JnnWtjv2q0zWEVVTqQrYOju1h9y1u79xH2xKzBeKbIiQdYvEOe4kR5b28fLKk6MBkKRq57o90cw9+GZ6X2Wj8Q4/Q3BY2Izo9J+hPjxTrORlxJrImYYKuxSJPv7JN91Nlwm1fPQMFOE3+X2go8u/NgC38oBDAsjbAWvuA9265NHnYceqn1l2HqV0r/whoYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mdfeIjT9ub9khEkZEBaV4vbP3OwvaIBqB8Cr+uM9TpM=;
 b=AEbtHqgb8c6LaMTTVmQiSUqu1i9WB1ZuSP1XilJNFwX3Bg5GupKwk/3J6olpr+eKlm9HXBWNG7dRAmbTNr+7+yNfk1ghSKRSCReNyhlXuc7D3iacxBUgjgG3a7EZVurcHLiMZUYPciFz1SFhK0lfc0mJwlXUpF2P2e/9Grmc7o5Fu3CUymAThHDvRSh+xTMQTYxlSR8H+XWYNv2kzFVytCXEkfyFcLmF9Jxxz8qdl6dqBhcTXlWQ7zAMkLOmVSqHXM52vm329u44y05ZgytN/GNYN2Z95dh8qmRpxZxMVaK6A7X6rMOC2/SCZXHDvx/w8xHxNTfnDGQjCKojFD9FwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mdfeIjT9ub9khEkZEBaV4vbP3OwvaIBqB8Cr+uM9TpM=;
 b=XE2lG8q8BXSMWVT00PbnXXfaaVNBNED5c9gj0fAJfp5zpk43coVtrjrgQyQ2DpzpBsTadNw7uyeMyfXWrIKyqgioLehhLjtXzlBf5Bvr3Qb31DWeVOObyA5L6yMdK47aGHK0GFKR/jTwt0S+sInWFbggSDWYum776k9xrEoqugM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SN6PR12MB2717.namprd12.prod.outlook.com (2603:10b6:805:68::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Fri, 8 Apr
 2022 14:27:25 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::a5fb:7137:5e64:cf8]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::a5fb:7137:5e64:cf8%5]) with mapi id 15.20.5144.022; Fri, 8 Apr 2022
 14:27:25 +0000
Content-Type: multipart/mixed; boundary="------------0k7B5PLwfnhdoEa8AI3ZXC0H"
Message-ID: <eef04fc4-741d-606c-c2c6-f054e4e3fffd@amd.com>
Date:   Fri, 8 Apr 2022 16:27:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Bug][5.18-rc0] Between commits ed4643521e6a and 34af78c4e616,
 appears warning "WARNING: CPU: 31 PID: 51848 at
 drivers/dma-buf/dma-fence-array.c:191 dma_fence_array_create+0x101/0x120" and
 some games stopped working.
Content-Language: en-US
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc:     Ken.Xue@amd.com, "Deucher, Alexander" <alexander.deucher@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        thomas.hellstrom@linux.intel.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
References: <CABXGCsNVp=R5zC9B3PXWJ5nddtt3gkRzDsAsRKvhXq7exGjSAg@mail.gmail.com>
 <f3bc34e1-0eaf-84ef-486e-b7759e60b792@amd.com>
 <CABXGCsOD+tDdFcM37NP_1nS9eLym7qC=jUQy3iqYkc1m2iQgxw@mail.gmail.com>
 <0d5f66d8-9852-b6a9-0e27-9eb9e736d698@amd.com>
 <CABXGCsPi68Lyvg+6UjTK2aJm6PVBs83YJuP6x68mcrzAQgpuZg@mail.gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <CABXGCsPi68Lyvg+6UjTK2aJm6PVBs83YJuP6x68mcrzAQgpuZg@mail.gmail.com>
X-ClientProxiedBy: AM5PR1001CA0007.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:206:2::20) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d1bb892-b413-484e-049b-08da196be696
X-MS-TrafficTypeDiagnostic: SN6PR12MB2717:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB27175051F74A3C7C3D6C7ED483E99@SN6PR12MB2717.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mo7ysWndcEYB3r7f3jrAabLjCznwjc8CZpQEATGciCDL8EcZkPE7CnUAJBnLTPicP8/jpAZeSsXuTDPrDcdWIJuOksOjuUVGVvmrQEtpXEFVplqpJkbDYANg/sGiC5vm47+wU4qLp2AjGxvWL/XkiEpGYDed4qfPayEzWQOGoBav9Xf+SEuyGDxkV8tZG5Gy3mLt/Ay4mfWABrYT0CVbC8RQdYMOOZesl3drGkk/swYFLDU6zUSmNYervRuDMemaVRBZf8Wj2C4okKoobkBJcaXjOvy0U5SCp9PP5ko+8FAoAoI8RgF93QoG+XKD8iXRu09dQFmjK9c7YOB0arPd2zaPleN6oh7nQUqMCPAiFiJkHwZT1DJ6U+AWE/Lpvb+z0HkAH5Y1XAnDIN4jvL1RJJmVk1HT+KdJjXVjfmDwNvwky8QO8yP5WChNaO1W/hykFgerps7O5/Df5l8X2O9nlmpJAWKaVsppWbk7SdQl441yf6FdHssXQzc0j5ONX7oqLxti9Tck7p44kWzGaLFxEAHWbUWX9Im7Csy5SswRgtFu7bRIVjZkFNeziFSuwgSAql/ChuNib2fQy/e+m5qokuUCQ+6Z1K89p0CbiHhogw37fxcllME2hA1Gbg1qIoh60K5JLFOxNczRkyP83Kcc2KtGY2X7ijiJ1DrntGd+16krYTToTcKY67QueGtzGgRY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3587.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66476007)(8676002)(66946007)(186003)(66574015)(54906003)(8936002)(316002)(6666004)(6512007)(6506007)(2906002)(508600001)(2616005)(83380400001)(31686004)(33964004)(6916009)(4326008)(31696002)(86362001)(38100700002)(5660300002)(6486002)(235185007)(36756003)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aktiTnM1aGtBQXNZbEdmVXZBRzFORzU1ZFIrVE5VUVkxWkl5c0Y5S05pOTVn?=
 =?utf-8?B?azlBM0VxcU41ZEI5V1V5YTY3OWNqVEYxWURFWThiSEQvQ3Bpb1huZWFpTk1q?=
 =?utf-8?B?V2ZDTFdiUTQ5Z1Y0N1F3Wm1NOUp4Q0hNS3ZFSk9GcFR0WDAyOVo0b0RUSGVR?=
 =?utf-8?B?WDFjUjhnS2FiR1NHdjcvdjlERGlSY2Vwc1VxVVBZZTVHWU94R0NLalNBVTdJ?=
 =?utf-8?B?dFdRZVJtMk5MWGNlWG9INUVwczZRb09EcitPVU9mb0Z3dVdqU0ZmNitTODhE?=
 =?utf-8?B?OVdzTmpKdHRCWVNsUHZvMm5takRmVmRMUmZxSlhIcnV5ZkJTUWluS3JXNTB4?=
 =?utf-8?B?a3lwcks4d2dYT0FsUkVhb3BQT1U0RDB5a3YxWkVJcTVrMzJ5NVJ1L0pvWlUz?=
 =?utf-8?B?Y24wcVl3VVVvRHhCUHNLbUU4OEhrUlRhYzVYekZNejhlSEhLeFk0NjlmUHNT?=
 =?utf-8?B?ZGpVWVE2bjVKSE9xbmk0cTMvQjFVMmpwVG16ekIyWTgyL1RYVW1XYmFhTE1L?=
 =?utf-8?B?blduMXBsVlVRd3NoNTRUV2EzT0o1SkNqMzBDUnVBT1ZBd292ZGh2ejVOVkNE?=
 =?utf-8?B?dWVXaWdIUmdLdWtEWjdRRUZyUTFpck1OMERRekhsb1gwZHBEM1lhSjAwSkpL?=
 =?utf-8?B?bWdnNGpCMVFBbUpxSkkzZDFmQlJrcFBFa0pZTXlwTlRXeEYzNzUwMGtlK0Vj?=
 =?utf-8?B?YnNKWmpXbHFjZ0lDNW9ITWV6ZUVqSTJEdVZwWFhzdHZLK1d0NXFxL0FFd0NE?=
 =?utf-8?B?UmsvQUhPNmhjMkNRenczQlpXSkZ1OCsxekMxWXozeXZqNWlLK2ZtZys1OGlZ?=
 =?utf-8?B?dG8xTHdPS0cvbWExUkZSWVVSRmlmWFc0bFQvM0wxSHdGMlR5WkRsUGx6NXk5?=
 =?utf-8?B?S3MzVm9ZU25lS2kyYWt5Y1MwR040Z3gvMXQ3a2VUYWU5Z0FXUWFXaUJTT05V?=
 =?utf-8?B?NmhTcG5uM2hjWjB3Y1dHU3FNWDYxSTFJKzVFbm4vTDVQNzFiYU0xUTdlcGhN?=
 =?utf-8?B?SXhYNVMzODVsSmJLdWZRazliWWxrdm9iOGhka09EZWVrdGdMVFppWmNkM2FR?=
 =?utf-8?B?RHNJSys0Z05PZGMvOU03S29EbWhpZjAzaTdrcTlXQlJxUGwwdi9JMGRBY3dx?=
 =?utf-8?B?eUxBc2Ezczd6YVhGUlMxN3kva1pneWpyNDhGb1hYUEJhTHlHSEVGVjJPNzJZ?=
 =?utf-8?B?WjkwR0tQeTZkY2g4b1BNQlJ3RTRsQ2FTT0JRQ1lRSG1wWlNWU290UkN2V1lp?=
 =?utf-8?B?WS9Vb1JkR2VMVmVzQVVaVE1rTDc4b3U4ZHIza2hKQ2RBRW9JZzhXV3k2TVY5?=
 =?utf-8?B?TldaeFBrOWVaeW1WaHdnMEt1eVkyV2hBdnRZSVpYQ01QNkE2em1JekwvUWRm?=
 =?utf-8?B?WHBUQWtENTg1MWlLaE9UN25lV2ppbmxtcldkNlh0WTBwR1NtSTkrM2YrWmNZ?=
 =?utf-8?B?NnVkSlRDajlHU1RGQ2RwRkhqVkcvSnh6bzF0VmNhTFdsMTFxYnQxbkFpWkRV?=
 =?utf-8?B?MEdhNzNVcE80RXJtazhvOVg2QzlLTzVJVndZdWczS2R3a29xTUM0b2tzTkxi?=
 =?utf-8?B?TTNWUlpNMDJQemJsenFLbVNPU1ZIUFhYTXdWbi9jNXV5MkhBS1AxRmlsRGNI?=
 =?utf-8?B?TVJkUEdJNGh2QnZGRWthem9BL1VrQXRaamQyOWtlZ21UeHMxQy9FM25sank4?=
 =?utf-8?B?c3Q0OUFJRWtwR214TXg4SFdXQUUwSnprUVUyQWVuNHVWWUhrbVV4R1h6ekNj?=
 =?utf-8?B?RXVOUDVqakVWTkhGWklXVmxOKy9BbDFuTGh6aHZ4cFdWbCt6Y0k4MG5JbmYx?=
 =?utf-8?B?c2EvbGZaREZJeUNlZlBzMnFoQ2tvNytYZzFoZHc5RVVqbEtHckRlbkVHdVVz?=
 =?utf-8?B?emhRK1cvUnFlVmx4bWFYTmlrTE96a29lTmdKdjVFbmFRaDFyZzhsWDFyYndI?=
 =?utf-8?B?bllkcnMvME83aHZOU3Bva05ZeUowOFVqNVZWK2V6SVo1UVFIOE82eUltTCt6?=
 =?utf-8?B?ZHJVZzlLeHd5d2VzMXVTOTN5WmRTNEZiaWV6RTJyRUo3WnBqUitSOUZieTZS?=
 =?utf-8?B?YnJCdXlZRnlDT1lGOGNnUWkrU2VDbGpibVd6cFd1Q213TnpXNEExMmVTRGFw?=
 =?utf-8?B?eWVDZUJHT0t3V2RKTklPMHgxOVZ0enlHeitVVjkwTkcwWXhSSlJxOWdLS1lF?=
 =?utf-8?B?SENVa3dKcHIxZUllSDdjVkU0b1ZJUm5paWV2MTBCOVNPUlR2UUF3ZGRteW02?=
 =?utf-8?B?Ym5Rc2hKTFdmM1VBUjNnQnRmcnpZSXh3cFB4a0xCNjBYY0J2cnQ2TzBjVVQx?=
 =?utf-8?B?cHY4UWpKWW92dDB2eVlIb3BhUDZNeVVQWnQxTjJ3c1JYYTFUU3NIano3ZWtp?=
 =?utf-8?Q?hl0OEMEU1hrqxFJJ8mnDsVHQP+CyRYZ6oYxmdaDxFog38?=
X-MS-Exchange-AntiSpam-MessageData-1: BAXwSxHIq1pgRg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d1bb892-b413-484e-049b-08da196be696
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 14:27:25.0570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7oleEl1rQCq9OzeiMmDzMduPujjS4x7ythSDJhIg9UR4WeJwTnXXSF/5rLpwEoeI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2717
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------0k7B5PLwfnhdoEa8AI3ZXC0H
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 08.04.22 um 14:24 schrieb Mikhail Gavrilov:
> On Fri, 8 Apr 2022 at 16:13, Christian König <christian.koenig@amd.com> wrote:
>
>> I own you a beer.
>>
>> I still don't know what happens here, but that makes at least a bit more
>> sense than a patch which only changes comments :)
>>
>> Looks like we are missing something here. Can I send you a patch to try
>> something later today?
> Yes, please feel free to send me a patch for testing.
>

Please test the attached patch, it just re-introduce the lock without 
doing much else.

And does your branch contain the following patch:

commit d18b8eadd83e3d8d63a45f9479478640dbcfca02
Author: Christian König <christian.koenig@amd.com>
Date:   Wed Feb 23 14:35:31 2022 +0100

     drm/amdgpu: install ctx entities with cmpxchg

     Since we removed the context lock we need to make sure that not two 
threads
     are trying to install an entity at the same time.

     Signed-off-by: Christian König <christian.koenig@amd.com>
     Fixes: 461fa7b0ac565e ("drm/amdgpu: remove ctx->lock")
     Reviewed-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
     Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Thanks,
Christian.
--------------0k7B5PLwfnhdoEa8AI3ZXC0H
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-drm-amdgpu-partial-revert-remove-ctx-lock.patch"
Content-Disposition: attachment;
 filename="0001-drm-amdgpu-partial-revert-remove-ctx-lock.patch"
Content-Transfer-Encoding: base64

RnJvbSBlMmUzOWNiMWE0YTFjN2MwZTNmZjJlNGUwMTg4Mzk0YjBlZGEwYmE2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/Q2hyaXN0aWFuPTIwSz1DMz1CNm5pZz89IDxj
aHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CkRhdGU6IEZyaSwgOCBBcHIgMjAyMiAxNjoyMjo1NSAr
MDIwMApTdWJqZWN0OiBbUEFUQ0hdIGRybS9hbWRncHU6IHBhcnRpYWwgcmV2ZXJ0ICJyZW1vdmUg
Y3R4LT5sb2NrIgpNSU1FLVZlcnNpb246IDEuMApDb250ZW50LVR5cGU6IHRleHQvcGxhaW47IGNo
YXJzZXQ9VVRGLTgKQ29udGVudC1UcmFuc2Zlci1FbmNvZGluZzogOGJpdAoKVGhpcyByZXZlcnRz
IGNvbW1pdCA0NjFmYTdiMGFjNTY1ZWYyNWMxZGEwY2VkMzEwMDVkZDQzNzg4M2E3LgoKV2UgYXJl
IG1pc3Npbmcgc29tZSBpbnRlciBkZXBlbmRlbmNpZXMgaGVyZS4KClNpZ25lZC1vZmYtYnk6IENo
cmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3MuYyAgfCA0ICsrKysKIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9jdHguYyB8IDIgKysKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9jdHguaCB8IDEgKwogMyBmaWxlcyBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKykKCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3MuYyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jcy5jCmluZGV4IDhkZTI4Mzk5Nzc2OS4uNTQ3
MWI5M2Y2ODA4IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
Y3MuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3MuYwpAQCAtMTI4
LDYgKzEyOCw4IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2NzX3BhcnNlcl9pbml0KHN0cnVjdCBhbWRn
cHVfY3NfcGFyc2VyICpwLCB1bmlvbiBkcm1fYW1kZ3B1X2NzCiAJCWdvdG8gZnJlZV9jaHVuazsK
IAl9CiAKKwltdXRleF9sb2NrKCZwLT5jdHgtPmxvY2spOworCiAJLyogc2tpcCBndWlsdHkgY29u
dGV4dCBqb2IgKi8KIAlpZiAoYXRvbWljX3JlYWQoJnAtPmN0eC0+Z3VpbHR5KSA9PSAxKSB7CiAJ
CXJldCA9IC1FQ0FOQ0VMRUQ7CkBAIC02ODgsNiArNjkwLDcgQEAgc3RhdGljIHZvaWQgYW1kZ3B1
X2NzX3BhcnNlcl9maW5pKHN0cnVjdCBhbWRncHVfY3NfcGFyc2VyICpwYXJzZXIsIGludCBlcnJv
ciwKIAlkbWFfZmVuY2VfcHV0KHBhcnNlci0+ZmVuY2UpOwogCiAJaWYgKHBhcnNlci0+Y3R4KSB7
CisJCW11dGV4X3VubG9jaygmcGFyc2VyLT5jdHgtPmxvY2spOwogCQlhbWRncHVfY3R4X3B1dChw
YXJzZXItPmN0eCk7CiAJfQogCWlmIChwYXJzZXItPmJvX2xpc3QpCkBAIC0xMzMyLDYgKzEzMzUs
NyBAQCBpbnQgYW1kZ3B1X2NzX2lvY3RsKHN0cnVjdCBkcm1fZGV2aWNlICpkZXYsIHZvaWQgKmRh
dGEsIHN0cnVjdCBkcm1fZmlsZSAqZmlscCkKIAkJZ290byBvdXQ7CiAKIAlyID0gYW1kZ3B1X2Nz
X3N1Ym1pdCgmcGFyc2VyLCBjcyk7CisKIG91dDoKIAlhbWRncHVfY3NfcGFyc2VyX2ZpbmkoJnBh
cnNlciwgciwgcmVzZXJ2ZWRfYnVmZmVycyk7CiAKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9jdHguYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9jdHguYwppbmRleCA1OTgxYzdkOWJkNDguLjhmMGU2ZDkzYmI5YyAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2N0eC5jCisrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jdHguYwpAQCAtMjM3LDYgKzIzNyw3IEBAIHN0YXRpYyBp
bnQgYW1kZ3B1X2N0eF9pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogCiAJa3JlZl9p
bml0KCZjdHgtPnJlZmNvdW50KTsKIAlzcGluX2xvY2tfaW5pdCgmY3R4LT5yaW5nX2xvY2spOwor
CW11dGV4X2luaXQoJmN0eC0+bG9jayk7CiAKIAljdHgtPnJlc2V0X2NvdW50ZXIgPSBhdG9taWNf
cmVhZCgmYWRldi0+Z3B1X3Jlc2V0X2NvdW50ZXIpOwogCWN0eC0+cmVzZXRfY291bnRlcl9xdWVy
eSA9IGN0eC0+cmVzZXRfY291bnRlcjsKQEAgLTM1Nyw2ICszNTgsNyBAQCBzdGF0aWMgdm9pZCBh
bWRncHVfY3R4X2Zpbmkoc3RydWN0IGtyZWYgKnJlZikKIAkJZHJtX2Rldl9leGl0KGlkeCk7CiAJ
fQogCisJbXV0ZXhfZGVzdHJveSgmY3R4LT5sb2NrKTsKIAlrZnJlZShjdHgpOwogfQogCmRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3R4LmggYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3R4LmgKaW5kZXggZDBjYmZjZWE5MGY3Li4xNDJm
MmY4N2Q0NGMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9j
dHguaAorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3R4LmgKQEAgLTQ5
LDYgKzQ5LDcgQEAgc3RydWN0IGFtZGdwdV9jdHggewogCWJvb2wJCQkJcHJlYW1ibGVfcHJlc2Vu
dGVkOwogCWludDMyX3QJCQkJaW5pdF9wcmlvcml0eTsKIAlpbnQzMl90CQkJCW92ZXJyaWRlX3By
aW9yaXR5OworCXN0cnVjdCBtdXRleAkJCWxvY2s7CiAJYXRvbWljX3QJCQlndWlsdHk7CiAJdW5z
aWduZWQgbG9uZwkJCXJhc19jb3VudGVyX2NlOwogCXVuc2lnbmVkIGxvbmcJCQlyYXNfY291bnRl
cl91ZTsKLS0gCjIuMjUuMQoK

--------------0k7B5PLwfnhdoEa8AI3ZXC0H--
