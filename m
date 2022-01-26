Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7146749CC50
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 15:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242123AbiAZO3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 09:29:02 -0500
Received: from repost01.tmes.trendmicro.eu ([18.185.115.2]:58341 "EHLO
        repost01.tmes.trendmicro.eu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235227AbiAZO3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 09:29:00 -0500
Received: from 104.47.17.110_.trendmicro.com (unknown [172.21.176.152])
        by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 9AC8A1000009A;
        Wed, 26 Jan 2022 14:28:58 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1643207338.131000
X-TM-MAIL-UUID: aa96cf6a-c4fa-4adc-8dba-1746a9c4ed1c
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (unknown [104.47.17.110])
        by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 2023210000E4A;
        Wed, 26 Jan 2022 14:28:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wh6MNXk83q3PE+GRShAdv8KmJR7PT3ZXL9qUocuvGFecl3C2eBCRbsvjpBeFXIMu3j2EDfZiZ1laJJgwsmUBAlUViuxjuFJiJY7kFwrgb/eEiRknPmETKmZQH/6FGXZrgRdlH7F5n9z41cN8CHvSgW48xdRkfdOD8GvEIFJoOTzTgrrAceG3Qb0caHdcsgGXxhakgPWTMViQ1QM9KJhXs+ST7fAyiNdqhg5l5d95Dfi2SU+/uMStf9BOVSGCR+wMGM0P6Xsi0b/W5ZHcjPGzr8F8D9Pk4R3CZXom0VGjaq4QRs4PAhrozM5X3Jn5HUmNP+Hld1jgmqF/mzFN1ue/Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rQnL3dD+LJiatHfnogXEpRKaSDyOSnD77SYL47DlJ7w=;
 b=eIhgHDJB83+VBMr2IQG9ogm1sizRInvqn+JW7v9RPeCMjnjWNGTw2hQOp/OxtNf0glGICepTgCPen0Ia5BPEfVOKaAP2oeiowxEcuMDs8pRH3XY1N8/Qe7aafFSHCmCQp1OK/OO1KdWXd7CcnB0FfIpFxdw09YEdf3XDoR8hOWKCsURzHkydw5OUmPa+X98J9L7LBvNmNlhChQUi1xl0Q8xPGRkSqkMBuIfSbh7++nQWPebkYzc86nfyRd7DqwBhrnYc7S/nnrUcWHwaUipguUxU6pcHficEOcrsPDGQ8cwlB3N5mB2Z3KL0qRePwzb2RXmzAGO9zTV4Xwa/8tbfCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <425e9a2b-a03f-a038-2598-33f28cd5f4e9@opensynergy.com>
Date:   Wed, 26 Jan 2022 15:28:52 +0100
From:   Peter Hilber <peter.hilber@opensynergy.com>
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, igor.skalkin@opensynergy.com,
        "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization@lists.linux-foundation.org
References: <20220124100341.41191-1-cristian.marussi@arm.com>
 <20220124100341.41191-2-cristian.marussi@arm.com>
Content-Language: en-US
Subject: Re: [PATCH 1/6] firmware: arm_scmi: Add atomic mode support to virtio
 transport
In-Reply-To: <20220124100341.41191-2-cristian.marussi@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6P191CA0063.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:209:7f::40) To AM9PR04MB8084.eurprd04.prod.outlook.com
 (2603:10a6:20b:3ec::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa51ba12-d944-4a3c-c102-08d9e0d82eb6
X-MS-TrafficTypeDiagnostic: DB8PR04MB6764:EE_
X-Microsoft-Antispam-PRVS: <DB8PR04MB676429424706DEBB5E7D2B968C209@DB8PR04MB6764.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EB9sCp+vpMV4UzqSR2JgKknuh28XWJDi0tzUU2MhvDaWnYCNlShyXXVYGpqBd5LQwSsq9SSHxoKVLqiTJuKnR81x/0iHYu+v8RiVf4D4e56o/VC3vw/yIJAhAd85WceSERF3ASYxYuBJNtHCUsYg/+aYBKCv4xhwZy1fxMEyOfd8RI0t9+viTmmVujUURRoe0UdjJ76lUtIHZSUgAJvFSTJc4vb+DzPURdHpfQ/GD/o6CFZqBJlNwj1gR5zRmg2M6ZewA8aluZC61VDHW/5fQu1e+peO6hlZAGRtZwrpTw1kOY91h/Z0yn0zGDXLdTkiOXTpqQd5mMGFfIgMvuGQHlaaoWlbutDJJcrch6EM16f/nCcSTHS/RGe1j8yvo29Cfsy75+BrSXDdS+Pq2fOA7QvzAYOoDcBGO444eYD7qvqPR79kXfLEWx4Q6/DrV9bTyq4Psvct4IzJ9r/h9jJBAFw5PLQHxpPLI2Vaj0B8t1La4LaShKWg5VlgqlRbd8BO3LHGgMStpD9EejkvTdZqVrjIoQjJC0Ntw91m4oT7KqR9tHUGhz9xMisiUKVfG9dZMkgNsqYrJRPGFsIYC43Iw6UEwxNxIuPqHe9Fk1WYl0I1ShYpaX7VZmETQM6T/txqPHS+5eTjxjZMVPhu42dIyg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8084.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(2616005)(36756003)(8676002)(53546011)(83380400001)(31686004)(66476007)(66946007)(8936002)(31696002)(86362001)(5660300002)(4326008)(66556008)(30864003)(7416002)(44832011)(38100700002)(2906002)(42186006)(316002)(508600001)(20210929001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTcwTDdxbWJjLzNDNWYrL3FMNU9XUHdsRUljUXNWZWdncVZsamRYdkI1Zld1?=
 =?utf-8?B?dUpkSTd4Tmd6RVBIS1R1VFJ6S3dyOThFWjM3NUlhS1YzV2ZzUC9sWjhIeXpo?=
 =?utf-8?B?bWUzY3RtdTRFZmRQcXVZbTJJNlVudDBaWnRSSkJQNm0waERQYWlOWEVmYlFM?=
 =?utf-8?B?LzRpTWI5dkp1UGlnY1lieCtLRldKVVJWdWpoOFZWUnJQNW9EWk9sczZES0kv?=
 =?utf-8?B?RmFud1RGU2RJc1ROV3RZeFFRUm4vUXBqeVBXTkZva0lVT1NyVkVmR3RiNjFI?=
 =?utf-8?B?UU1hSXlXRXdzK2R6NnJCdmtpRWI0TmUzc09GZFJFcWNxY3F6Y2hjR2lxUjFB?=
 =?utf-8?B?enc4WEw1OS9mNmYrWHhSU0ppK2t1eXRDMzBFQWRHTW4zUzJ6YkNqd2RKMDYr?=
 =?utf-8?B?Q2RVN1NHTHl3ZSt3QUJkR1dnY3R6L0ZwU2p2SzRFNzRHdk8yWkRtNkY4dDZm?=
 =?utf-8?B?Ukt4RE1UZjl3UEEwc0Y3bURoSDlyTzdFUndrUVpJNFlJTWFRNDNvY3Y3ZXRJ?=
 =?utf-8?B?aVFnTzNjVThsM2RsRlFSWnFWcWxnSnpaU3JlNE1NL1JKaDMwWGdCSmhwYlhW?=
 =?utf-8?B?Ni9Gd0VtbGNmZlk2VzArUm1BQ1ptY2lhNDlqSiszVGsycVlxWkpwcGRrR1E5?=
 =?utf-8?B?M2IyTEZWaEZ3b2hITXViOW5kY0NpQXF3WjZqOUxWY3g5VEw3TUFoNXhXUHhY?=
 =?utf-8?B?MGNMM0RyRWZDb2EwN2hhVkxDSndqcitBUzBKYS9VUnpaNTl0YnlVekxSL0VK?=
 =?utf-8?B?bFl4SVM1ZXRDeTBQNTZzZWJ0NlZ6bXROZEhNOWdLZHhxWTNiSnpaRFp5enF3?=
 =?utf-8?B?NUIxZlR1UFpTRUxCR08wVzYvMkQ1THhHQkFNTVUzT0ZRbnphQ3Q5Ym9IeVVu?=
 =?utf-8?B?djF1Z1l1R3A3eUZ0Z3h6ellHMm9VbUxwVlFPNksySnFMU3JpK0tKZkJHeUtB?=
 =?utf-8?B?Q1NxdWgzcGw3S1Y3OE9SSDB4Q1FWRmhpOVhna3haVXVoQmc1c2hOL0xFZnV4?=
 =?utf-8?B?ZFJmMWkyTXBJbnl6aXFRMlR5SlNFYy9rc09PcGd5cmRGdjdWOTRDSE5XRTRQ?=
 =?utf-8?B?ei9tRlFlMVBqWGFETHVCWUhkbmxxTVZHR0dLM2VzMVNzUVJIUUI1VFRxMkxm?=
 =?utf-8?B?NDVnTEdobjN4eVRmMENxKy9HSitLdktOWkUzaUlDc1lEb0RWWnYzMTdETk5R?=
 =?utf-8?B?c0hsdEUyWU9DZDF1M1Ntbzh5QjZkdEU4ZHRTMEpWY3Z1SUtTaWU2VGVlZzRa?=
 =?utf-8?B?ZXc2V0N4MFA3STh4VytFTXVSekt6RnpUOXE1MW1BQ3pmbnlaQ3kxODBWMld0?=
 =?utf-8?B?L0FxVlhVUG5JUjcyRnc1ODdJSFFIbkQwQUJtNElkeGJPN25taHg5ZEZQbG9q?=
 =?utf-8?B?dnMybk5xbUZhd2FIVFdhNXdIV3J6c3JwU1ZPc2VsRk5GM25qbXFoRkxiK241?=
 =?utf-8?B?QVdEVTd6ZkNJdGFZOVkvVEJUZnVINC9DY0lCNWF1TDBtRVQ1YU5qWGFPOXM1?=
 =?utf-8?B?QkhSZFlBK1VDMUk1RTdoMGx5cW56dWFaVm9QNW0rbmFSWE1ITStYUkN6clJG?=
 =?utf-8?B?N3hlRUIyZC9qR1MrZWhmL3Nlb1JTVHJuUTVtZUQvZDhuSWtFUFpFZEdzWktC?=
 =?utf-8?B?azhSMVdsUHZVTytPVDQ4ZWd1VXVrTDRqcU42OEhkcFdncDhmNlJHaDVsRnBT?=
 =?utf-8?B?UWE2YnJ1NjlLRWNDdm1qNVJjanNpcHNxdnJHTlRZSXNZRUFSc0thM2E2dzJk?=
 =?utf-8?B?TkFFU3gxTklSYWxmNkY2YktGV0dMSFFUYVI3eGRJWUEwMlBaNTFPaC9qY1ph?=
 =?utf-8?B?QTRka1pMUWNqVUs4R1o5SWIzTDIza0k4cm9ESzdwcE1DUUtPNUF3VWdacnYw?=
 =?utf-8?B?bHlKK1FocDVNRUdXQW5sS0ZNU0ZCRDY5Z0dNdTNYR2VhUVYvMS9rdVlNN1A4?=
 =?utf-8?B?R1hqRDA4NVMvQnp3QkpSUW9TR1hxOWExNU9ZRGVLVy8vTkpmNUtTTWdYN0Rn?=
 =?utf-8?B?ajZkazBtaTBvYUo3RVl0YW84d1dTK1J5Q3pLQk96RWovdEtLbFFUd29lbkVt?=
 =?utf-8?B?L3JGZElLUlFlU1RvdDhpNjNRUytNRXVoeW4yRW9BengrUkhxY0FZR2d3ZEJX?=
 =?utf-8?B?d1dDdFdmVnQ2U1VPZDE4RklKMkVpbGpBSkFHdFRQbWRNdUFIbm9iVkNqcU5H?=
 =?utf-8?B?eGJBc2poTERNS2RSaENGTFdPSmljYkpSMkhod3NrMU9WSjNlRkFLcXh6cTVE?=
 =?utf-8?Q?XfPp5V3MrS1wGekDZsU4l2Nj1B5zWejrDeuSh/Ojdw=3D?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa51ba12-d944-4a3c-c102-08d9e0d82eb6
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8084.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 14:28:55.5452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZAHgBIQ5m9M9UjLzQzbSuTqKAT1i4sYaYBZXia9I2KVBFo5eGrXYHtGAsvOp+FhwVs2UIl1kYLiRo3F66QSXXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6764
X-TM-AS-ERS: 104.47.17.110-0.0.0.0
X-TMASE-Version: StarCloud-1.3-8.8.1001-26678.000
X-TMASE-Result: 10--14.073300-4.000000
X-TMASE-MatchedRID: jFqw+1pFnMzmLzc6AOD8DfHkpkyUphL9F4r8H5YrEqzYzDFd3mQzYSlA
        /rS07QvhX4tQOIJWO43nxOAx7X1mP8CoX5/lejxbiVJZi91I9JjKIqAq0jIHir59Yrw3aQCH4qA
        BsUMuHjVqTcsbvCUXs5Cpr+27xAE1qI4fCVjNwZy8coKUcaOOvUwZMwX4tEtqIMaS2qEOOLAJpY
        vTYc/nRWEfInhJIqbZj0RC7hmppJuB//TxCalW+m5vKXd3+k+/Eqfa6mOo3hI1Y73PdzvXZJ/r4
        ta+5ZgH4xQoYvWP3RejtDT2vMV7DzazU4L7Sybu0Az+qa2CoAqg8867bIwmU/Z5Vxjb3pQXVWmi
        qp0IW14YsW2wtHtt/q/8+cki49t4x/Z5eXpUUhSwWQIt56582w73P4/aDCIFh7/KLUHlCEIi8sF
        mfwgCGCB9s68j6n2DcOU+CGo+d/JiWV0DQ85LUttNtOEgicP6TxL5U2EWalu0lrTE2xf8T3d7bc
        i/LVuNgiaxgB32RJMcNKy16RpEsDRFgrISksby2os3ueKAsFSmJtY0iSfJ/Xv8jfaFjr7yxMZZa
        StlEQuErQMKFbfXd7tRrLgy7wgC0MWGhVp0M3GSvRb8EMdYRY+97nzD8A3/a0TOsL14A2kFluWp
        F18dpA1RC3ntAMKQ+1TIDEVT+HXvEJY6jb7hujMvozJIQnRWSoCG4sefl8RGM2uNXRqsUm1q5fN
        A5saQXOTxnrk4SK2NwU9vCE9TsD58xbJHDY3rFqifzwY4bVq6hgVvSdGKo5buWcWUwHZk2Huw61
        jLswAirGJSljGIWDb7U+mGMjLL0X7fLHhLOBx+yskgwrfsC30tCKdnhB58vqq8s2MNhPCy5/tFZ
        u9S3Ku6xVHLhqfx33fj+sMArfMaMUyeC0staJwDp1OIv3zjUgMxkgR6r4UqOFmGkGfVJ13UiUuy
        m8qQfcb4sgBoecvgm7GE1alzIw==
X-TMASE-XGENCLOUD: 3f5e77a3-4046-4653-a8bf-d8041ad9286a-0-0-200-0
X-TM-Deliver-Signature: FFB7A70BCC882BCE93AB196926D2361A
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
        s=TM-DKIM-20210503141657; t=1643207338;
        bh=FEECUfuu9vHtqMfDXD/xYIaPfN72l5VLtFMPOwOdT0k=; l=22931;
        h=Date:From:To;
        b=FSheowjNloNZQnm5rvS+7FSDP7n5htFCZ0A/7vuFhr9FE5f+o/RIB7gnmNcr/IyFZ
         WsognB2YNoWo4YkZwygHkdKuiAG0vkxc7xtwv5UFnf/VOQsoNKnEqq3V33Nzn4FBCy
         5GxVNOOsDAIENmRWm2gkNnEfs9QYmUM4PfpgHo2y93B/xryjY0d3MadzlVrzD7jBNS
         65WkD57fr3uf+F8muxZ9ICFvlnNlU0GPsYqBKgcMblz6eejm+uEbxg0Ofy+dewu2QH
         Zp+fukLeV5ui+bd1Xnk0T9KUGyjPi7QSUC6Tt1zUw5QzLI9xNPRepf0U52ZbS2gJTg
         bMVvlHEklRAug==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.01.22 11:03, Cristian Marussi wrote:
> Add support for .mark_txdone and .poll_done transport operations to SCMI
> VirtIO transport as pre-requisites to enable atomic operations.
> 
> Add a Kernel configuration option to enable SCMI VirtIO transport polling
> and atomic mode for selected SCMI transactions while leaving it default
> disabled.
> 

Hi Cristian,

please see one remark below.

Best regards,

Peter

> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Igor Skalkin <igor.skalkin@opensynergy.com>
> Cc: Peter Hilber <peter.hilber@opensynergy.com>
> Cc: virtualization@lists.linux-foundation.org
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
> - check for deferred_wq existence before queueing work to avoid
>   race at driver removal time
> - changed mark_txdone decision-logic about message release
> - fixed race while checking for msg polled from another thread
> - using dedicated poll_status instead of poll_idx upper bits
> - pick initial poll_idx earlier insde send_message to avoid missing
>   early replies
> - removed F_NOTIFY mention in comment
> - clearing xfer->priv on the IRQ tx path once message has been fetched
> - added some store barriers
> - updated some comments
> ---
>  drivers/firmware/arm_scmi/Kconfig  |  15 ++
>  drivers/firmware/arm_scmi/driver.c |   9 +-
>  drivers/firmware/arm_scmi/virtio.c | 315 ++++++++++++++++++++++++++---
>  3 files changed, 310 insertions(+), 29 deletions(-)
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
> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> index c2e7897ff56e..dc972a54e93e 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -648,7 +648,8 @@ static void scmi_handle_notification(struct scmi_chan_info *cinfo,
>  
>  	unpack_scmi_header(msg_hdr, &xfer->hdr);
>  	if (priv)
> -		xfer->priv = priv;
> +		/* Ensure order between xfer->priv store and following ops */
> +		smp_store_mb(xfer->priv, priv);
>  	info->desc->ops->fetch_notification(cinfo, info->desc->max_msg_size,
>  					    xfer);
>  	scmi_notify(cinfo->handle, xfer->hdr.protocol_id,
> @@ -680,8 +681,12 @@ static void scmi_handle_response(struct scmi_chan_info *cinfo,
>  		xfer->rx.len = info->desc->max_msg_size;
>  
>  	if (priv)
> -		xfer->priv = priv;
> +		/* Ensure order between xfer->priv store and following ops */
> +		smp_store_mb(xfer->priv, priv);
>  	info->desc->ops->fetch_response(cinfo, xfer);
> +	if (priv)
> +		/* Ensure order between xfer->priv clear and later accesses */
> +		smp_store_mb(xfer->priv, NULL);
>  
>  	trace_scmi_rx_done(xfer->transfer_id, xfer->hdr.id,
>  			   xfer->hdr.protocol_id, xfer->hdr.seq,
> diff --git a/drivers/firmware/arm_scmi/virtio.c b/drivers/firmware/arm_scmi/virtio.c
> index fd0f6f91fc0b..39c293f0ffd3 100644
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
> @@ -58,6 +64,12 @@ struct scmi_vio_channel {
>  	spinlock_t ready_lock;
>  };
>  
> +enum poll_states {
> +	VIO_MSG_NOT_POLLED,
> +	VIO_MSG_POLLING,
> +	VIO_MSG_POLL_DONE,
> +};
> +
>  /**
>   * struct scmi_vio_msg - Transport PDU information
>   *
> @@ -65,12 +77,22 @@ struct scmi_vio_channel {
>   * @input: SDU used for (delayed) responses and notifications
>   * @list: List which scmi_vio_msg may be part of
>   * @rx_len: Input SDU size in bytes, once input has been received
> + * @poll_idx: Last used index registered for polling purposes if this message
> + *	      transaction reply was configured for polling.
> + *	      Note that since virtqueue used index is an unsigned 16-bit we can
> + *	      use some out-of-scale values to signify particular conditions.
> + * @poll_status: Polling state for this message.
> + * @poll_lock: Protect access to @poll_idx and @poll_status.
>   */
>  struct scmi_vio_msg {
>  	struct scmi_msg_payld *request;
>  	struct scmi_msg_payld *input;
>  	struct list_head list;
>  	unsigned int rx_len;
> +	unsigned int poll_idx;
> +	enum poll_states poll_status;
> +	/* lock to protect access to poll_idx. */
> +	spinlock_t poll_lock;
>  };
>  
>  /* Only one SCMI VirtIO device can possibly exist */
> @@ -81,40 +103,43 @@ static bool scmi_vio_have_vq_rx(struct virtio_device *vdev)
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
> +	msg->poll_status = VIO_MSG_NOT_POLLED;
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
> @@ -144,6 +169,7 @@ static void scmi_vio_complete_cb(struct virtqueue *vqueue)
>  			virtqueue_disable_cb(vqueue);
>  			cb_enabled = false;
>  		}
> +
>  		msg = virtqueue_get_buf(vqueue, &length);
>  		if (!msg) {
>  			if (virtqueue_enable_cb(vqueue))
> @@ -157,7 +183,9 @@ static void scmi_vio_complete_cb(struct virtqueue *vqueue)
>  			scmi_rx_callback(vioch->cinfo,
>  					 msg_read_header(msg->input), msg);
>  
> +			spin_lock(&vioch->lock);
>  			scmi_finalize_message(vioch, msg);
> +			spin_unlock(&vioch->lock);
>  		}
>  
>  		/*
> @@ -176,6 +204,34 @@ static void scmi_vio_complete_cb(struct virtqueue *vqueue)
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
> @@ -244,6 +300,19 @@ static int virtio_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
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
> @@ -257,6 +326,7 @@ static int virtio_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
>  						    GFP_KERNEL);
>  			if (!msg->request)
>  				return -ENOMEM;
> +			spin_lock_init(&msg->poll_lock);
>  		}
>  
>  		msg->input = devm_kzalloc(cinfo->dev, VIRTIO_SCMI_MAX_PDU_SIZE,
> @@ -264,13 +334,12 @@ static int virtio_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
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
> @@ -291,11 +360,22 @@ static int virtio_chan_free(int id, void *p, void *data)
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
> @@ -324,16 +404,33 @@ static int virtio_send_message(struct scmi_chan_info *cinfo,
>  	}
>  
>  	msg = list_first_entry(&vioch->free_list, typeof(*msg), list);
> -	list_del(&msg->list);
> +	/* Re-init element so we can discern anytime if it is still in-flight */
> +	list_del_init(&msg->list);
>  
>  	msg_tx_prepare(msg->request, xfer);
>  
>  	sg_init_one(&sg_out, msg->request, msg_command_size(xfer));
>  	sg_init_one(&sg_in, msg->input, msg_response_size(xfer));
>  
> +	/*
> +	 * If polling was requested for this transaction:
> +	 *  - retrieve last used index (will be used as polling reference)
> +	 *  - bind the polled message to the xfer via .priv
> +	 */
> +	if (xfer->hdr.poll_completion) {
> +		spin_lock(&msg->poll_lock);
> +		msg->poll_status = VIO_MSG_POLLING;
> +		msg->poll_idx = virtqueue_enable_cb_prepare(vioch->vqueue);
> +		spin_unlock(&msg->poll_lock);
> +		/* Ensure initialized msg is visibly bound to xfer */
> +		smp_store_mb(xfer->priv, msg);
> +	}
> +
>  	rc = virtqueue_add_sgs(vioch->vqueue, sgs, 1, 1, msg, GFP_ATOMIC);
>  	if (rc) {
> -		list_add(&msg->list, &vioch->free_list);
> +		/* Ensure order between xfer->priv clear and vq feeding */
> +		smp_store_mb(xfer->priv, NULL);
> +		scmi_vio_feed_vq_tx(vioch, msg);
>  		dev_err(vioch->cinfo->dev,
>  			"failed to add to TX virtqueue (%d)\n", rc);
>  	} else {
> @@ -350,10 +447,8 @@ static void virtio_fetch_response(struct scmi_chan_info *cinfo,
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
> @@ -361,12 +456,174 @@ static void virtio_fetch_notification(struct scmi_chan_info *cinfo,
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
> + * Free only completed polling transfer messages.
> + *
> + * Note that in the SCMI VirtIO transport we never explicitly release timed-out
> + * messages by forcibly re-adding them to the free-list inside the TX code path;
> + * we instead let IRQ/RX callbacks eventually clean up such messages once,
> + * finally, a late reply is received and discarded (if ever).
> + *
> + * This approach was deemed preferable since those pending timed-out buffers are
> + * still effectively owned by the SCMI platform VirtIO device even after timeout
> + * expiration: forcibly freeing and reusing them before they had been returned
> + * explicitly by the SCMI platform could lead to subtle bugs due to message
> + * corruption.
> + * An SCMI platform VirtIO device which never returns message buffers is
> + * anyway broken and it will quickly lead to exhaustion of available messages.
> + *
> + * For this same reason, here, we take care to free only the polled messages
> + * that had been somehow replied, since they won't be freed elsewhere;
> + * late replies to timed-out polled messages would be anyway freed by RX
> + * callbacks instead.
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
> +	/* Must be a polled xfer and not already freed on the IRQ path */
> +	if (!xfer->hdr.poll_completion || !msg)
> +		return;
> +
> +	/* Ensure msg is unbound from xfer anyway at this point */
> +	smp_store_mb(xfer->priv, NULL);
> +
> +	/* Do not free timedout polled messages */
> +	if (ret != -ETIMEDOUT) {
> +		spin_lock_irqsave(&vioch->lock, flags);
> +		scmi_vio_feed_vq_tx(vioch, msg);
> +		spin_unlock_irqrestore(&vioch->lock, flags);
>  	}
>  }
>  
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
> + * Note that, since we do NOT have per-message suppress notification mechanism,
> + * the message we are polling for could be delivered via usual IRQs callbacks
> + * on another core which happened to have IRQs enabled: in such case it will be
> + * handled as such by scmi_rx_callback() and the polling loop in the
> + * SCMI Core TX path will be transparently terminated anyway.
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
> +	spin_lock_irqsave(&vioch->lock, flags);

If now acquiring vioch->lock here, I see no need to virtqueue_poll() any more.
After checking msg->poll_status, we could just directly try virtqueue_get_buf().

On the other hand, always taking the vioch->lock in a busy loop might better be
avoided (I assumed before that taking it was omitted on purpose), since it
might hamper tx channel progress in other cores (but I'm not sure about the
actual impact).

Also, I don't yet understand why the vioch->lock would need to be taken here.

> +	spin_lock(&msg->poll_lock);
> +	/* Processed already by other polling loop on another CPU ? */
> +	if (msg->poll_status == VIO_MSG_POLL_DONE) {
> +		spin_unlock(&msg->poll_lock);
> +		spin_unlock_irqrestore(&vioch->lock, flags);
> +		return true;
> +	}
> +
> +	/* Has cmdq index moved at all ? */
> +	pending = virtqueue_poll(vioch->vqueue, msg->poll_idx);
> +	spin_unlock(&msg->poll_lock);
> +	if (!pending) {
> +		spin_unlock_irqrestore(&vioch->lock, flags);
> +		return false;
> +	}
> +
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
> +		if (next_msg->poll_status == VIO_MSG_NOT_POLLED) {
> +			any_prefetched++;
> +			list_add_tail(&next_msg->list,
> +				      &vioch->pending_cmds_list);
> +		} else {
> +			/* We picked another currently polled msg */
> +			next_msg->poll_status = VIO_MSG_POLL_DONE;
> +		}
> +		spin_unlock(&next_msg->poll_lock);
> +	}
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
> +
> +	spin_unlock_irqrestore(&vioch->lock, flags);
> +
> +	return ret;
> +}
> +
>  static const struct scmi_transport_ops scmi_virtio_ops = {
>  	.link_supplier = virtio_link_supplier,
>  	.chan_available = virtio_chan_available,
> @@ -376,6 +633,8 @@ static const struct scmi_transport_ops scmi_virtio_ops = {
>  	.send_message = virtio_send_message,
>  	.fetch_response = virtio_fetch_response,
>  	.fetch_notification = virtio_fetch_notification,
> +	.mark_txdone = virtio_mark_txdone,
> +	.poll_done = virtio_poll_done,
>  };
>  
>  static int scmi_vio_probe(struct virtio_device *vdev)
> @@ -418,6 +677,7 @@ static int scmi_vio_probe(struct virtio_device *vdev)
>  		spin_lock_init(&channels[i].lock);
>  		spin_lock_init(&channels[i].ready_lock);
>  		INIT_LIST_HEAD(&channels[i].free_list);
> +		INIT_LIST_HEAD(&channels[i].pending_cmds_list);
>  		channels[i].vqueue = vqs[i];
>  
>  		sz = virtqueue_get_vring_size(channels[i].vqueue);
> @@ -506,4 +766,5 @@ const struct scmi_desc scmi_virtio_desc = {
>  	.max_rx_timeout_ms = 60000, /* for non-realtime virtio devices */
>  	.max_msg = 0, /* overridden by virtio_get_max_msg() */
>  	.max_msg_size = VIRTIO_SCMI_MAX_MSG_SIZE,
> +	.atomic_enabled = IS_ENABLED(CONFIG_ARM_SCMI_TRANSPORT_VIRTIO_ATOMIC_ENABLE),
>  };


