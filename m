Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A51CB492860
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 15:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245562AbiARO2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 09:28:36 -0500
Received: from refb02.tmes.trendmicro.eu ([18.185.115.61]:52831 "EHLO
        refb02.tmes.trendmicro.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245503AbiARO2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 09:28:34 -0500
X-Greylist: delayed 466 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Jan 2022 09:28:34 EST
Received: from 104.47.12.59_.trendmicro.com (unknown [172.21.10.52])
        by refb02.tmes.trendmicro.eu (Postfix) with ESMTPS id 84BC01021EDB8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 14:21:11 +0000 (UTC)
Received: from 104.47.12.59_.trendmicro.com (unknown [172.21.176.152])
        by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 38AA91000175A;
        Tue, 18 Jan 2022 14:21:09 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1642515667.691000
X-TM-MAIL-UUID: 32a89732-4483-4598-b692-71b3bdd48c8b
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (unknown [104.47.12.59])
        by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id A8FAE1000030A;
        Tue, 18 Jan 2022 14:21:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nmLw7qcWq+IaMsIO9J3rlC2MqdLAyB0m+T0ea1uEAcl/I38BWKInSDo5N3UYUAkD2jNkAgNu6sMhQ0BfT30pExloXtRjRhM9civdhDmmoppao2IYe16cYE97LyujUhTKQ8xahkwV3AJXquapDuzHSFbqmTWD4QlD1vBC/n1mMEBvxdZ4pSs345relDZqmUyiz39MkOtj3sDIuVZ5koK6qnCQerZ2DhPjEtjrQt1SkLPs39d5HSQjXhlZckV7H4ibuvON2xeqHbSC59evcfZXZDMINm6swp1oCrznP07OOFtW1DMr4QEw91qPlbfHuU3jL5W5vQHvCwT3sS2Sa0929g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8lzndUIXO306r6kktNqzW6DFxOnO7rJpTqqErzWUaNc=;
 b=aaUQ2VeXVY7Y242Wh3KbUeGBFztVZ7ch11G9fkjiCj6A88vAJV0au/beKz0yZKTbXvUX+eFYlur10Tgv64Eukx8326s+tPdlhe17f98fDxLo4irCRM57yCa+pMGg9ED2iBzGWA05AnMrv6GmQDE+6UhTtP4SldgS3Z2A5OVku3Z7r81lExuTkWy/bUOhV35+HLhpenTg3OXc2KdXoStcum2Ub72uEnnr8SMVecGkvnZJaMYrWj4LWhs73ygiiVtHl5yL9mhKo+gO0YBjBXz2Sz6d/paK8e2ORC/EyE/HaOV4YOFoNczsCa40kK46NMo5imjwyE0EJQB+1ExfVu9Jzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <f231094a-6f34-3dc1-237d-97218e8fde91@opensynergy.com>
Date:   Tue, 18 Jan 2022 15:21:03 +0100
From:   Peter Hilber <peter.hilber@opensynergy.com>
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, igor.skalkin@opensynergy.com,
        "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization@lists.linux-foundation.org
References: <20211220195646.44498-10-cristian.marussi@arm.com>
 <20211221140027.41524-1-cristian.marussi@arm.com>
Content-Language: en-US
Subject: Re: [PATCH v9 09/11] firmware: arm_scmi: Add atomic mode support to
 virtio transport
In-Reply-To: <20211221140027.41524-1-cristian.marussi@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0033.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::46) To AM9PR04MB8084.eurprd04.prod.outlook.com
 (2603:10a6:20b:3ec::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 112db9c9-a527-4ed9-a7ec-08d9da8dc3d0
X-MS-TrafficTypeDiagnostic: AM0PR04MB5572:EE_
X-Microsoft-Antispam-PRVS: <AM0PR04MB5572E31E2B9F7F367607780F8C589@AM0PR04MB5572.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EFIu3qymis3iUnBn50TkwNaFniGcJRISr3HeBveSnRbhBa4IIoOnrJZR/qLuOxbHn1d4PzCvjZOBz4CoVHmVKOsKHZk3nOeXUoqtm8eYj+Pxjr8zZAQETnX+AiB1f0q6dEN7y8t8X1fvw8LiZX8ue+l0Cg7axCT9IDXKEEEE7A97t4cSL3mRwkbbQ/JIdQ+vz+yVk63PnkbHc6lE/A3vPiKrW178awlB/BlxDBcINHmO5Qqzp73lXK2/RNk5Bailil8pIXXCzsE/x9h4pMoWZDBgxqDWGzms2h2XbECw+ET3OKH13pkmSrMBav19uIg9b2hNcU7FMaVQAYVoVNKpzFZYYVGPIbz/ugywN6AKp90DrbQ6atjwQFFjs/g3pcM686jkOZok/7DE/SFtce5VD//OS1Dy+bC+rqYvNcXqeNv0DUt1yQpktk8rGssOxlctXQ9YVIL59mZQiPQFYue+OLg/aRWJIx4MB4Gp5xWITa+T0W1oM7md8yF+oIh+fWsx3dOlPGxTuGfMvw2e5HWoL5ubQPBGnGG/zW8e3t5Az6Lae0jN4JnCRH70YOvSwop+csJ/nm0QzrjpuIcwWeq0D0bEqtwAWmigueu+lFZwGVvvfktkUiZvpnVJh0rkkw7epbUxzUEw+1NDw0YXB/TLcw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8084.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39840400004)(136003)(366004)(346002)(376002)(8936002)(44832011)(8676002)(31686004)(36756003)(86362001)(30864003)(2616005)(38100700002)(186003)(53546011)(508600001)(4326008)(42186006)(316002)(83380400001)(5660300002)(2906002)(7416002)(31696002)(66946007)(66556008)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUE0OTVtOVlkWTR3dXJ0b0ZPZXBjT1dsVHdkU1ptWTBOR0lUV2h6U2pNSHRn?=
 =?utf-8?B?eUxZK0kxaDRJd25aODk4NUpzWkpWbnlHRXJDQTJjSVNiVERiRFNTKzdUQkpW?=
 =?utf-8?B?SFh5Rk5zYWJ6SUdrdGNFamtZcUkySW9zQWdmZ1MrR3ZNdFFHZzdhQlM2WTg4?=
 =?utf-8?B?cUdnOGd5cmpPVzdVWm1aZmV3ZTQ1VjNIK0EvaTl2dkVLNkFiU2dNZkQyVDZN?=
 =?utf-8?B?MmFVYmhnWW9sUXJDc0Zxc1RaSERnRUsrRWRCWlBkcmJvTDI0QlN0dG9pUlJZ?=
 =?utf-8?B?b3BaSmdzZU9YNElxT0JoTjd3UlBwWGZqN2c1YkZUSlp5ekZzcXZHRzZYMnA3?=
 =?utf-8?B?emVHQXl6cVgyU3Y5Q0pZejVONVQ3ZDZZcFE0YStxSFV2MWJTZjFER3RySFhQ?=
 =?utf-8?B?QkY1MHY2cHF3aHQwL2k5RDlGN051TTlWcUtCZVk2KzcyRjJpVVlXWmhFU2pQ?=
 =?utf-8?B?OTgxVFp6amJVQ29hVHhSNXRNZ25zbnhjZXZGd2hWVStuV0ZhQUZuTkw2Y1dL?=
 =?utf-8?B?RzNYeTFOZDhoeEtqNll0d1g2ckZTQzZrQ2RHNnVhb0JCMm1Oa2IvbmtMV1h5?=
 =?utf-8?B?RDBuWU1FNEhCbytrVWo2K1FJQWd2dTgwazNEME44WnRXaDRlSkdEd1NUVkRN?=
 =?utf-8?B?VU0wRjRVbE9QQm5QcFRpVlFKcWJ5VDhtMk0ybDdsZE51RmtiN0VtWkROZXlX?=
 =?utf-8?B?d3dZZUN2Nk9ncHhxVnhLYTdnRmVlWENiRkEwTC9WVGRUSWRkZzFvOVlXNk9S?=
 =?utf-8?B?RjFuN1A3dTN2YnQ3ckpwQklQeGtWbkZRMi92R1dNczJaVUdYR3Z6cWxLWG5o?=
 =?utf-8?B?UUh3UUlFYVhaYjRleFJaWjJTTkJNeFdtbmZaY1pqZURBNFhLMVNkMmsrT3Zz?=
 =?utf-8?B?VTFDWW9BbFhOMW96TGtLRitLZUM4azh4Q1dlZlUrcExIV2cwbG84VGlZb2J6?=
 =?utf-8?B?Q3I1V2dUcEtzMWVmQ3pjSENqY1lRYnFPVDRTUnBYSElBMUdReXFIVE9qMHBp?=
 =?utf-8?B?cXphdDVBc21iWktZMWJxemZzbFR0dnIzdHpldnpieXZhZXlqQVVURHduSEJH?=
 =?utf-8?B?RmgrRnN6eG0weG04SnE5dk42Zk9VRnVXMG5INGR2T3J3WDBXMGU4RkdNc2k3?=
 =?utf-8?B?dDFsOFRYaHdpbVBWbTBwaUVVRVk1R0pUZ24wNmZJZVhJNyswMDN2QU5RUXBj?=
 =?utf-8?B?R1ZXTDFnK1ROd1dnTThObXZSeGJzTlhFeU9uaitFTCtjdXdaOUFXZ1VFNWpm?=
 =?utf-8?B?UWEvQkF4NVMzUEpscW45ZTVGa0FnRkM1akZDdjJxVERvbm9nOCt0NWE1WURJ?=
 =?utf-8?B?MXpuSlNZampLSjc0ZVN4RVRwN2NnK1l6S3Z0eUtTaEhSSzZlTnZ3SWhaN1VK?=
 =?utf-8?B?NWhqZmdrdmM0VmgxOG9oeXB2YUNSYTJxWFFHTmhpV2tLTVNhUXl0dkQwalZC?=
 =?utf-8?B?N01PQks1WFpHSG9YK3NZTENnOURWKzkxZzhRY3A4cDA4QVR3M2RWWXhqNVl4?=
 =?utf-8?B?aHhQcnIzYlJENW9KanJFTVh2VEJmMWFodE4zT3hVMWFuYzZTQmt6UEhtTzV4?=
 =?utf-8?B?Tmd2VlU0QWRnTmxmRGkzWHhvWXJCMm5ROXh2KzZuUDJ5a3RXR1dhSU1VUjJV?=
 =?utf-8?B?eEdrWisrTnV2aHVWU1A2ZlprSzE4cFN0SmtDVmNUTG1zeVZteGg5SjBzQTNr?=
 =?utf-8?B?eitKMmFRRkRENUJhWXJhZ0ZVamtYL1M3NGtkSXJWOWo4T3V5MEkrMFRNYktQ?=
 =?utf-8?B?Q0pDSU9lLzd6RW1aeXNxTWo4Vjh0Rk9RRE5OMjN1NlROWUNLOVF5eE9KM1VO?=
 =?utf-8?B?TmcxaWQvU21UU1JUNk1CaHpuNS85d2U0aDlUN2hjSmNvZVN4MlFqbjlPanJa?=
 =?utf-8?B?RU5DSXBicU5QNDY4L1p1ZkxLMEpPakY3VkpWZ3N4VGgwa09VQ0RTRXBIUnNq?=
 =?utf-8?B?UlhSMEZUL1R3eUp3TTE3VXZxK1FrclVHSE1BTjlyUXUxcTdhMnRUam5NUXV0?=
 =?utf-8?B?anN4RmlWMVd2TG5pK1VQV0Q5MTdrdEl4Nk5waHNaMnNFaXdIbTJKWXYzV1l3?=
 =?utf-8?B?S254S3BOakkyNlBYc2xZdHhqUE9MQmE2ZGdWMjFoNEZTOVZLZjJvb25pYnEv?=
 =?utf-8?B?KzB5Wm83VGNUbkwyOVgxOTJFcWVESTJzSisyWUhpVk0yOHFoZjNxaVhHOUNV?=
 =?utf-8?B?MU5KdEJ1YnZ5WUxheXlGYUZuMzlzTE5vdVFTeTQyM2dwOFBLdmNYZjV4NVk5?=
 =?utf-8?Q?MMwkjEOmyEe9uakDExAckvDa5608Lokd8YpnUJOOdM=3D?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 112db9c9-a527-4ed9-a7ec-08d9da8dc3d0
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8084.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 14:21:06.2468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jCHDqhEpfxebosena1ZOO+WWfETiKKiAn4KHJY+/bz2wqRNhheChfv7YHVOYTtYNwN3N89AmMiSLLXPN+YL0Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5572
X-TM-AS-ERS: 104.47.12.59-0.0.0.0
X-TMASE-Version: StarCloud-1.3-8.8.1001-26662.000
X-TMASE-Result: 10--13.741000-4.000000
X-TMASE-MatchedRID: IeZYkn8zfFrmLzc6AOD8DfHkpkyUphL9F4r8H5YrEqzYzDFd3mQzYSlA
        /rS07QvhX4tQOIJWO43nxOAx7X1mP8CoX5/lejxbiVJZi91I9JjKIqAq0jIHir59Yrw3aQCH4qA
        BsUMuHjVqTcsbvCUXs5Cpr+27xAE1qI4fCVjNwZyOtWfhyZ77DrvGYJkNeu61y5JfHvVu9IsRiO
        ci/49ZaMQ1xvPMAvfZSPgILy+ax0swGJP81FXnYtp259tRcqxnjWP6asaL88WmHGfEsRqk4RskA
        daEfeQKDEt2jZXyR95Bg55Qm/xAOMx079ojRyOinFVnNmvv47tLXPA26IG0hN9RlPzeVuQQ5OxG
        90p8C4Kss/CBOtjUEL6JpuDQeZ+D7Fr/H7icxDXaaFkDJQUn69PaSXiLjsu7WfjPRPx8eihCEGb
        QKi8nMP0cHnRsMpNbTEPBiExjgy3sEz9ycWwbCnMTJAXiPSt3N6i7v/DQHPwCee5LF8ChVL5BEq
        XwSs2UhnpL7CO7mCfBCG3PhgdWqOpT+6c6+qYhkiSxx29igC2OQOsE4nDCdGwimY8Q6v0Vzdlo2
        6al4KGFiZuoVC0g/LM02Zhw1AOmxrdsXS7GN2TBjbyj5wYDmqCHGfJA0hsdIokLn81eLCq20nPQ
        2eZ7CQvsV1JRJhuqgUgNTTsO35KOhHkPCXAFR+E9BBUXDccUzqAF0wFSjjV32Xz6cV3Ps6Aufzk
        MIEUMp8/kD+PfeX7TOhCt6PITrXYUDZjh315mqyM0cPww3Mya6qNdVN6ezTYspit1Dw9ni1RbZN
        1JuSju9s1Tb1CRqbKodXcpkwj38wnpWh97YMp+yskgwrfsC30tCKdnhB58vqq8s2MNhPCy5/tFZ
        u9S3Ku6xVHLhqfxIAcCikR3vq/7H+ruSnOXDuwxuqXE0HKoMl7YXAYuhYC/mrWU4rEgqKUtRpQ1
        Vbsv
X-TMASE-XGENCLOUD: dbfef93a-3489-43d8-b115-e6135f539118-0-0-200-0
X-TM-Deliver-Signature: 47EDC4048860917CA64C15A00D688870
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
        s=TM-DKIM-20210503141657; t=1642515669;
        bh=JEz2nYvlY+epSyJyJbpQ71zA68j9jWPB984epJXDN7o=; l=21481;
        h=Date:From:To;
        b=OXP+BferMT5Wv6vEuN7oYa2liM0+X6enFjrkMbBQfBJzQvGC6e8B18gGYZ6KZNjBT
         BqLzB/BD1gZhrR07QuQzFd/xILFGt1+WMn3LtUZzrcUJBPSdMnkWNlOtoPoWLEb4zh
         nm9z0m6XGFq1Es/QoXlWQuuX1PQBO91lLWFjgNepTw0twUN3DeZtIYqstA0C2uFfWR
         gB5QzcY2LulHCZISQiiE17f4RasVup3sNfJoD68Obz6WhyKI0RAaA+j+OFbZTbVKQt
         58VbRVv9flaJnbymY2dWyW0l2fSzhZRXFL9xROHTN/ZSQ+TRcGNYdzhQRT9HeS2FzE
         B0M2cxCtCryTQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.12.21 15:00, Cristian Marussi wrote:
> Add support for .mark_txdone and .poll_done transport operations to SCMI
> VirtIO transport as pre-requisites to enable atomic operations.
> 
> Add a Kernel configuration option to enable SCMI VirtIO transport polling
> and atomic mode for selected SCMI transactions while leaving it default
> disabled.
> 

Hi Cristian,

thanks for the update. I have some more remarks inline below.

My impression is that the virtio core does not expose helper functions suitable
to busy-poll for used buffers. But changing this might not be difficult. Maybe
more_used() from virtio_ring.c could be exposed via a wrapper?

Best regards,

Peter

> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Igor Skalkin <igor.skalkin@opensynergy.com>
> Cc: Peter Hilber <peter.hilber@opensynergy.com>
> Cc: virtualization@lists.linux-foundation.org
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
> v8 --> v9
> - check for deferred_wq existence before queueing work to avoid
>   race at driver removal time
> ---
>  drivers/firmware/arm_scmi/Kconfig  |  15 ++
>  drivers/firmware/arm_scmi/virtio.c | 298 ++++++++++++++++++++++++++---
>  2 files changed, 287 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
> index d429326433d1..7794bd41eaa0 100644
> --- a/drivers/firmware/arm_scmi/Kconfig
> +++ b/drivers/firmware/arm_scmi/Kconfig
> @@ -118,6 +118,21 @@ config ARM_SCMI_TRANSPORT_VIRTIO_VERSION1_COMPLIANCE
>  	  the ones implemented by kvmtool) and let the core Kernel VirtIO layer
>  	  take care of the needed conversions, say N.
>  
> +config ARM_SCMI_TRANSPORT_VIRTIO_ATOMIC_ENABLE
> +	bool "Enable atomic mode for SCMI VirtIO transport"
> +	depends on ARM_SCMI_TRANSPORT_VIRTIO
> +	help
> +	  Enable support of atomic operation for SCMI VirtIO based transport.
> +
> +	  If you want the SCMI VirtIO based transport to operate in atomic
> +	  mode, avoiding any kind of sleeping behaviour for selected
> +	  transactions on the TX path, answer Y.
> +
> +	  Enabling atomic mode operations allows any SCMI driver using this
> +	  transport to optionally ask for atomic SCMI transactions and operate
> +	  in atomic context too, at the price of using a number of busy-waiting
> +	  primitives all over instead. If unsure say N.
> +
>  endif #ARM_SCMI_PROTOCOL
>  
>  config ARM_SCMI_POWER_DOMAIN
> diff --git a/drivers/firmware/arm_scmi/virtio.c b/drivers/firmware/arm_scmi/virtio.c
> index fd0f6f91fc0b..e54d14971c07 100644
> --- a/drivers/firmware/arm_scmi/virtio.c
> +++ b/drivers/firmware/arm_scmi/virtio.c
> @@ -3,8 +3,8 @@
>   * Virtio Transport driver for Arm System Control and Management Interface
>   * (SCMI).
>   *
> - * Copyright (C) 2020-2021 OpenSynergy.
> - * Copyright (C) 2021 ARM Ltd.
> + * Copyright (C) 2020-2022 OpenSynergy.
> + * Copyright (C) 2021-2022 ARM Ltd.
>   */
>  
>  /**
> @@ -38,6 +38,9 @@
>   * @vqueue: Associated virtqueue
>   * @cinfo: SCMI Tx or Rx channel
>   * @free_list: List of unused scmi_vio_msg, maintained for Tx channels only
> + * @deferred_tx_work: Worker for TX deferred replies processing
> + * @deferred_tx_wq: Workqueue for TX deferred replies
> + * @pending_cmds_list: List of pre-fetched commands queueud for later processing
>   * @is_rx: Whether channel is an Rx channel
>   * @ready: Whether transport user is ready to hear about channel
>   * @max_msg: Maximum number of pending messages for this channel.
> @@ -49,6 +52,9 @@ struct scmi_vio_channel {
>  	struct virtqueue *vqueue;
>  	struct scmi_chan_info *cinfo;
>  	struct list_head free_list;
> +	struct list_head pending_cmds_list;
> +	struct work_struct deferred_tx_work;
> +	struct workqueue_struct *deferred_tx_wq;
>  	bool is_rx;
>  	bool ready;
>  	unsigned int max_msg;
> @@ -65,12 +71,22 @@ struct scmi_vio_channel {
>   * @input: SDU used for (delayed) responses and notifications
>   * @list: List which scmi_vio_msg may be part of
>   * @rx_len: Input SDU size in bytes, once input has been received
> + * @poll_idx: Last used index registered for polling purposes if this message
> + *	      transaction reply was configured for polling.
> + *	      Note that since virtqueue used index is an unsigned 16-bit we can
> + *	      use some out-of-scale values to signify particular conditions.
> + * @poll_lock: Protect access to @poll_idx.
>   */
>  struct scmi_vio_msg {
>  	struct scmi_msg_payld *request;
>  	struct scmi_msg_payld *input;
>  	struct list_head list;
>  	unsigned int rx_len;
> +#define VIO_MSG_NOT_POLLED	0xeeeeeeeeUL
> +#define VIO_MSG_POLL_DONE	0xffffffffUL
> +	unsigned int poll_idx;
> +	/* lock to protect access to poll_idx. */
> +	spinlock_t poll_lock;
>  };
>  
>  /* Only one SCMI VirtIO device can possibly exist */
> @@ -81,40 +97,43 @@ static bool scmi_vio_have_vq_rx(struct virtio_device *vdev)
>  	return virtio_has_feature(vdev, VIRTIO_SCMI_F_P2A_CHANNELS);
>  }
>  
> +/* Expect to be called with vioch->lock acquired by the caller and IRQs off */
>  static int scmi_vio_feed_vq_rx(struct scmi_vio_channel *vioch,
>  			       struct scmi_vio_msg *msg,
>  			       struct device *dev)
>  {
>  	struct scatterlist sg_in;
>  	int rc;
> -	unsigned long flags;
>  
>  	sg_init_one(&sg_in, msg->input, VIRTIO_SCMI_MAX_PDU_SIZE);
>  
> -	spin_lock_irqsave(&vioch->lock, flags);
> -
>  	rc = virtqueue_add_inbuf(vioch->vqueue, &sg_in, 1, msg, GFP_ATOMIC);
>  	if (rc)
>  		dev_err(dev, "failed to add to RX virtqueue (%d)\n", rc);
>  	else
>  		virtqueue_kick(vioch->vqueue);
>  
> -	spin_unlock_irqrestore(&vioch->lock, flags);
> -
>  	return rc;
>  }
>  
> +/* Expect to be called with vioch->lock acquired by the caller and IRQs off */
> +static inline void scmi_vio_feed_vq_tx(struct scmi_vio_channel *vioch,
> +				       struct scmi_vio_msg *msg)
> +{
> +	spin_lock(&msg->poll_lock);
> +	msg->poll_idx = VIO_MSG_NOT_POLLED;
> +	spin_unlock(&msg->poll_lock);
> +
> +	list_add(&msg->list, &vioch->free_list);
> +}
> +
>  static void scmi_finalize_message(struct scmi_vio_channel *vioch,
>  				  struct scmi_vio_msg *msg)
>  {
> -	if (vioch->is_rx) {
> +	if (vioch->is_rx)
>  		scmi_vio_feed_vq_rx(vioch, msg, vioch->cinfo->dev);
> -	} else {
> -		/* Here IRQs are assumed to be already disabled by the caller */
> -		spin_lock(&vioch->lock);
> -		list_add(&msg->list, &vioch->free_list);
> -		spin_unlock(&vioch->lock);
> -	}
> +	else
> +		scmi_vio_feed_vq_tx(vioch, msg);
>  }
>  
>  static void scmi_vio_complete_cb(struct virtqueue *vqueue)
> @@ -144,6 +163,7 @@ static void scmi_vio_complete_cb(struct virtqueue *vqueue)
>  			virtqueue_disable_cb(vqueue);
>  			cb_enabled = false;
>  		}
> +
>  		msg = virtqueue_get_buf(vqueue, &length);
>  		if (!msg) {
>  			if (virtqueue_enable_cb(vqueue))
> @@ -157,7 +177,9 @@ static void scmi_vio_complete_cb(struct virtqueue *vqueue)
>  			scmi_rx_callback(vioch->cinfo,
>  					 msg_read_header(msg->input), msg);
>  
> +			spin_lock(&vioch->lock);
>  			scmi_finalize_message(vioch, msg);
> +			spin_unlock(&vioch->lock);
>  		}
>  
>  		/*
> @@ -176,6 +198,34 @@ static void scmi_vio_complete_cb(struct virtqueue *vqueue)
>  	spin_unlock_irqrestore(&vioch->ready_lock, ready_flags);
>  }
>  
> +static void scmi_vio_deferred_tx_worker(struct work_struct *work)
> +{
> +	unsigned long flags;
> +	struct scmi_vio_channel *vioch;
> +	struct scmi_vio_msg *msg, *tmp;
> +
> +	vioch = container_of(work, struct scmi_vio_channel, deferred_tx_work);
> +
> +	/* Process pre-fetched messages */
> +	spin_lock_irqsave(&vioch->lock, flags);
> +
> +	/* Scan the list of possibly pre-fetched messages during polling. */
> +	list_for_each_entry_safe(msg, tmp, &vioch->pending_cmds_list, list) {
> +		list_del(&msg->list);
> +
> +		scmi_rx_callback(vioch->cinfo,
> +				 msg_read_header(msg->input), msg);
> +
> +		/* Free the processed message once done */
> +		scmi_vio_feed_vq_tx(vioch, msg);
> +	}
> +
> +	spin_unlock_irqrestore(&vioch->lock, flags);
> +
> +	/* Process possibly still pending messages */
> +	scmi_vio_complete_cb(vioch->vqueue);
> +}
> +
>  static const char *const scmi_vio_vqueue_names[] = { "tx", "rx" };
>  
>  static vq_callback_t *scmi_vio_complete_callbacks[] = {
> @@ -244,6 +294,19 @@ static int virtio_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
>  
>  	vioch = &((struct scmi_vio_channel *)scmi_vdev->priv)[index];
>  
> +	/* Setup a deferred worker for polling. */
> +	if (tx && !vioch->deferred_tx_wq) {
> +		vioch->deferred_tx_wq =
> +			alloc_workqueue(dev_name(&scmi_vdev->dev),
> +					WQ_UNBOUND | WQ_FREEZABLE | WQ_SYSFS,
> +					0);
> +		if (!vioch->deferred_tx_wq)
> +			return -ENOMEM;
> +
> +		INIT_WORK(&vioch->deferred_tx_work,
> +			  scmi_vio_deferred_tx_worker);
> +	}
> +
>  	for (i = 0; i < vioch->max_msg; i++) {
>  		struct scmi_vio_msg *msg;
>  
> @@ -257,6 +320,7 @@ static int virtio_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
>  						    GFP_KERNEL);
>  			if (!msg->request)
>  				return -ENOMEM;
> +			spin_lock_init(&msg->poll_lock);
>  		}
>  
>  		msg->input = devm_kzalloc(cinfo->dev, VIRTIO_SCMI_MAX_PDU_SIZE,
> @@ -264,13 +328,12 @@ static int virtio_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
>  		if (!msg->input)
>  			return -ENOMEM;
>  
> -		if (tx) {
> -			spin_lock_irqsave(&vioch->lock, flags);
> -			list_add_tail(&msg->list, &vioch->free_list);
> -			spin_unlock_irqrestore(&vioch->lock, flags);
> -		} else {
> +		spin_lock_irqsave(&vioch->lock, flags);
> +		if (tx)
> +			scmi_vio_feed_vq_tx(vioch, msg);
> +		else
>  			scmi_vio_feed_vq_rx(vioch, msg, cinfo->dev);
> -		}
> +		spin_unlock_irqrestore(&vioch->lock, flags);
>  	}
>  
>  	spin_lock_irqsave(&vioch->lock, flags);
> @@ -291,11 +354,22 @@ static int virtio_chan_free(int id, void *p, void *data)
>  	unsigned long flags;
>  	struct scmi_chan_info *cinfo = p;
>  	struct scmi_vio_channel *vioch = cinfo->transport_info;
> +	void *deferred_wq = NULL;
>  
>  	spin_lock_irqsave(&vioch->ready_lock, flags);
>  	vioch->ready = false;
>  	spin_unlock_irqrestore(&vioch->ready_lock, flags);
>  
> +	spin_lock_irqsave(&vioch->lock, flags);
> +	if (!vioch->is_rx && vioch->deferred_tx_wq) {
> +		deferred_wq = vioch->deferred_tx_wq;
> +		vioch->deferred_tx_wq = NULL;
> +	}
> +	spin_unlock_irqrestore(&vioch->lock, flags);
> +
> +	if (deferred_wq)
> +		destroy_workqueue(deferred_wq);
> +
>  	scmi_free_channel(cinfo, data, id);
>  
>  	spin_lock_irqsave(&vioch->lock, flags);
> @@ -324,7 +398,8 @@ static int virtio_send_message(struct scmi_chan_info *cinfo,
>  	}
>  
>  	msg = list_first_entry(&vioch->free_list, typeof(*msg), list);
> -	list_del(&msg->list);
> +	/* Re-init element so we can discern anytime if it is still in-flight */
> +	list_del_init(&msg->list);
>  
>  	msg_tx_prepare(msg->request, xfer);
>  
> @@ -337,6 +412,19 @@ static int virtio_send_message(struct scmi_chan_info *cinfo,
>  		dev_err(vioch->cinfo->dev,
>  			"failed to add to TX virtqueue (%d)\n", rc);
>  	} else {
> +		/*
> +		 * If polling was requested for this transaction:
> +		 *  - retrieve last used index (will be used as polling reference)

The virtqueue_add_sgs() called before already exposed the message to the virtio
device, so a fast response might have arrived already, so the reference value
might unexpectedly correspond to the current message.

> +		 *  - bind the polled message to the xfer via .priv
> +		 */
> +		if (xfer->hdr.poll_completion) {
> +			spin_lock(&msg->poll_lock);
> +			msg->poll_idx =
> +				virtqueue_enable_cb_prepare(vioch->vqueue);
> +			spin_unlock(&msg->poll_lock);
> +			/* Ensure initialized msg is visibly bound to xfer */
> +			smp_store_mb(xfer->priv, msg);
> +		}
>  		virtqueue_kick(vioch->vqueue);
>  	}
>  
> @@ -350,10 +438,8 @@ static void virtio_fetch_response(struct scmi_chan_info *cinfo,
>  {
>  	struct scmi_vio_msg *msg = xfer->priv;
>  
> -	if (msg) {
> +	if (msg)
>  		msg_fetch_response(msg->input, msg->rx_len, xfer);
> -		xfer->priv = NULL;
> -	}
>  }
>  
>  static void virtio_fetch_notification(struct scmi_chan_info *cinfo,
> @@ -361,10 +447,166 @@ static void virtio_fetch_notification(struct scmi_chan_info *cinfo,
>  {
>  	struct scmi_vio_msg *msg = xfer->priv;
>  
> -	if (msg) {
> +	if (msg)
>  		msg_fetch_notification(msg->input, msg->rx_len, max_len, xfer);
> -		xfer->priv = NULL;
> +}
> +
> +/**
> + * virtio_mark_txdone  - Mark transmission done
> + *
> + * Free only successfully completed polling transfer messages.
> + *
> + * Note that in the SCMI VirtIO transport we never explicitly release timed-out
> + * messages by forcibly re-adding them to the free-list, even on timeout, inside
> + * the TX code path; we instead let IRQ/RX callbacks eventually clean up such
> + * messages once, finally, a late reply is received and discarded (if ever).
> + *
> + * This approach was deemed preferable since those pending timed-out buffers are
> + * still effectively owned by the SCMI platform VirtIO device even after timeout
> + * expiration: forcibly freeing and reusing them before they had been returned
> + * explicitly by the SCMI platform could lead to subtle bugs due to message
> + * corruption.
> + * An SCMI platform VirtIO device which never returns message buffers is
> + * anyway broken and it will quickly lead to exhaustion of available messages.
> + *
> + * For this same reason, here, we take care to free only the successfully
> + * completed polled messages, since they won't be freed elsewhere; late replies
> + * to timed-out polled messages would be anyway freed by RX callbacks instead.
> + *
> + * @cinfo: SCMI channel info
> + * @ret: Transmission return code
> + * @xfer: Transfer descriptor
> + */
> +static void virtio_mark_txdone(struct scmi_chan_info *cinfo, int ret,
> +			       struct scmi_xfer *xfer)
> +{
> +	unsigned long flags;
> +	struct scmi_vio_channel *vioch = cinfo->transport_info;
> +	struct scmi_vio_msg *msg = xfer->priv;
> +
> +	if (!msg)
> +		return;
> +
> +	/* Ensure msg is unbound from xfer before pushing onto the free list  */
> +	smp_store_mb(xfer->priv, NULL);
> +
> +	/* Is a successfully completed polled message still to be finalized ? */
> +	spin_lock_irqsave(&vioch->lock, flags);
> +	if (!ret && xfer->hdr.poll_completion && list_empty(&msg->list))

Could this not also be a message which was already finalized and then
immediately reused for another polling xfer?

> +		scmi_vio_feed_vq_tx(vioch, msg);
> +	spin_unlock_irqrestore(&vioch->lock, flags);
> +}
> +
> +/**
> + * virtio_poll_done  - Provide polling support for VirtIO transport
> + *
> + * @cinfo: SCMI channel info
> + * @xfer: Reference to the transfer being poll for.
> + *
> + * VirtIO core provides a polling mechanism based only on last used indexes:
> + * this means that it is possible to poll the virtqueues waiting for something
> + * new to arrive from the host side but the only way to check if the freshly
> + * arrived buffer was what we were waiting for is to compare the newly arrived
> + * message descriptors with the one we are polling on.
> + *
> + * As a consequence it can happen to dequeue something different from the buffer
> + * we were poll-waiting for: if that is the case such early fetched buffers are
> + * then added to a the @pending_cmds_list list for later processing by a
> + * dedicated deferred worker.
> + *
> + * So, basically, once something new is spotted we proceed to de-queue all the
> + * freshly received used buffers until we found the one we were polling on, or,
> + * we have 'seemingly' emptied the virtqueue; if some buffers are still pending
> + * in the vqueue at the end of the polling loop (possible due to inherent races
> + * in virtqueues handling mechanisms), we similarly kick the deferred worker
> + * and let it process those, to avoid indefinitely looping in the .poll_done
> + * helper.
> + *
> + * Note that we do NOT suppress notification with VIRTQ_USED_F_NO_NOTIFY even
> + * when polling since such flag is per-virtqueues and we do not want to
> + * suppress notifications as a whole: so, if the message we are polling for is
> + * delivered via usual IRQs callbacks, on another core which are IRQs-on, it
> + * will be handled as such by scmi_rx_callback() and the polling loop in the
> + * SCMI Core TX path will be transparently terminated anyway.

Why is VIRTQ_USED_F_NO_NOTIFY mentioned? It is a flag associated with only one
of two buffer notification suppression methods, which are transparently handled
by the virtio core. Cf. `Driver Requirements: Used Buffer Notification
Suppression' in the virtio spec.

> + *
> + * Return: True once polling has successfully completed.
> + */
> +static bool virtio_poll_done(struct scmi_chan_info *cinfo,
> +			     struct scmi_xfer *xfer)
> +{
> +	bool pending, ret = false;
> +	unsigned int length, any_prefetched = 0;
> +	unsigned long flags;
> +	struct scmi_vio_msg *next_msg, *msg = xfer->priv;
> +	struct scmi_vio_channel *vioch = cinfo->transport_info;
> +
> +	if (!msg)
> +		return true;
> +
> +	spin_lock_irqsave(&msg->poll_lock, flags);
> +	/* Processed already by other polling loop on another CPU ? */
> +	if (msg->poll_idx == VIO_MSG_POLL_DONE) {
> +		spin_unlock_irqrestore(&msg->poll_lock, flags);
> +		return true;
> +	}
> +
> +	/* Has cmdq index moved at all ? */
> +	pending = virtqueue_poll(vioch->vqueue, msg->poll_idx);

In my understanding, the polling comparison could still be subject to the ABA
problem when exactly 2**16 messages have been marked as used since
msg->poll_idx was set (unlikely scenario, granted).

I think this would be a lot simpler if the virtio core exported some
concurrency-safe helper function for such polling (similar to more_used() from
virtio_ring.c), as discussed at the top.

> +	spin_unlock_irqrestore(&msg->poll_lock, flags);
> +	if (!pending)
> +		return false;
> +
> +	spin_lock_irqsave(&vioch->lock, flags);
> +	virtqueue_disable_cb(vioch->vqueue);
> +
> +	/*
> +	 * If something arrived we cannot be sure, without dequeueing, if it
> +	 * was the reply to the xfer we are polling for, or, to other, even
> +	 * possibly non-polling, pending xfers: process all new messages
> +	 * till the polled-for message is found OR the vqueue is empty.
> +	 */
> +	while ((next_msg = virtqueue_get_buf(vioch->vqueue, &length))) {
> +		next_msg->rx_len = length;
> +		/* Is the message we were polling for ? */
> +		if (next_msg == msg) {
> +			ret = true;
> +			break;
> +		}
> +
> +		spin_lock(&next_msg->poll_lock);
> +		if (next_msg->poll_idx == VIO_MSG_NOT_POLLED) {
> +			any_prefetched++;
> +			list_add_tail(&next_msg->list,
> +				      &vioch->pending_cmds_list);
> +		} else {
> +			next_msg->poll_idx = VIO_MSG_POLL_DONE;
> +		}
> +		spin_unlock(&next_msg->poll_lock);
>  	}
> +
> +	/*
> +	 * When the polling loop has successfully terminated if something
> +	 * else was queued in the meantime, it will be served by a deferred
> +	 * worker OR by the normal IRQ/callback OR by other poll loops.
> +	 *
> +	 * If we are still looking for the polled reply, the polling index has
> +	 * to be updated to the current vqueue last used index.
> +	 */
> +	if (ret) {
> +		pending = !virtqueue_enable_cb(vioch->vqueue);
> +	} else {
> +		spin_lock(&msg->poll_lock);
> +		msg->poll_idx = virtqueue_enable_cb_prepare(vioch->vqueue);
> +		pending = virtqueue_poll(vioch->vqueue, msg->poll_idx);
> +		spin_unlock(&msg->poll_lock);
> +	}
> +
> +	if (vioch->deferred_tx_wq && (any_prefetched || pending))
> +		queue_work(vioch->deferred_tx_wq, &vioch->deferred_tx_work);

What if queue_work() returns false because the single work item for the channel
was already pending? Couldn't it then happen that the worker CPU will not yet
see the updates implied by `any_prefetched || pending'?

> +
> +	spin_unlock_irqrestore(&vioch->lock, flags);
> +
> +	return ret;
>  }
>  
>  static const struct scmi_transport_ops scmi_virtio_ops = {
> @@ -376,6 +618,8 @@ static const struct scmi_transport_ops scmi_virtio_ops = {
>  	.send_message = virtio_send_message,
>  	.fetch_response = virtio_fetch_response,
>  	.fetch_notification = virtio_fetch_notification,
> +	.mark_txdone = virtio_mark_txdone,
> +	.poll_done = virtio_poll_done,
>  };
>  
>  static int scmi_vio_probe(struct virtio_device *vdev)
> @@ -418,6 +662,7 @@ static int scmi_vio_probe(struct virtio_device *vdev)
>  		spin_lock_init(&channels[i].lock);
>  		spin_lock_init(&channels[i].ready_lock);
>  		INIT_LIST_HEAD(&channels[i].free_list);
> +		INIT_LIST_HEAD(&channels[i].pending_cmds_list);
>  		channels[i].vqueue = vqs[i];
>  
>  		sz = virtqueue_get_vring_size(channels[i].vqueue);
> @@ -506,4 +751,5 @@ const struct scmi_desc scmi_virtio_desc = {
>  	.max_rx_timeout_ms = 60000, /* for non-realtime virtio devices */
>  	.max_msg = 0, /* overridden by virtio_get_max_msg() */
>  	.max_msg_size = VIRTIO_SCMI_MAX_MSG_SIZE,
> +	.atomic_enabled = IS_ENABLED(CONFIG_ARM_SCMI_TRANSPORT_VIRTIO_ATOMIC_ENABLE),
>  };
>
