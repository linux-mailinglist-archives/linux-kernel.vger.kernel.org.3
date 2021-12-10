Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56C4B4700A5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 13:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240974AbhLJM3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 07:29:44 -0500
Received: from refb01.tmes.trendmicro.eu ([18.185.115.55]:57929 "EHLO
        refb01.tmes.trendmicro.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235433AbhLJM3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 07:29:43 -0500
X-Greylist: delayed 825 seconds by postgrey-1.27 at vger.kernel.org; Fri, 10 Dec 2021 07:29:42 EST
Received: from 104.47.18.105_.trendmicro.com (unknown [172.21.9.124])
        by refb01.tmes.trendmicro.eu (Postfix) with ESMTPS id A7A4311093BAA
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 12:12:23 +0000 (UTC)
Received: from 104.47.18.105_.trendmicro.com (unknown [172.21.182.53])
        by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 7980110003CB9;
        Fri, 10 Dec 2021 12:12:22 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1639138341.670000
X-TM-MAIL-UUID: 2389f985-bb83-4566-a6e7-1018350100d4
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (unknown [104.47.18.105])
        by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id A3DD3100002E0;
        Fri, 10 Dec 2021 12:12:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KplDmwb/t8OC6WYsIArhDNNRufjNy6gBDRMHBP33TdvHdTnmfvmN5QhlaW6OtTBIks3+UHRMqIzo1VfPJX+QHCJJd8bSIju3UlkjXFKjxSGlYf79JQo8qH2oGa2F5A5ylLzz/WRVuC+hfc9xMLRaTag05vNdSjwN2mZ4Qwu/rzDwtNdnJUzZx4NdsfVI+WqSaXolavg5x1eH+y2R9yE16ilXAmA+WNocB6+53Tt75npDL+94SQQYoQz/8jiKajDLebe/MTuT/DhWSvFNrmKbVSX6T3wspuoV/orWM2IGPRbHGYaALezbE4dlXDWxoX/kTI5hMuYWIxrDB2YdbxIarA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QrN9aq1oUgauOb4gPX6Qe9+6qg0x9e0ZpPClxmkOD6k=;
 b=FUmEoNQJXXVKMSLo2EirbakDDaae7bmuSGCFoCJ46EhMDUfCIMdDc/1qjHBrRt4LkhUKCbW2JcFp0JXgWFEKUzBuXO7HWDhXdd9xK6QiieN3cazmM9nd7od4ipY4KBUYFXQOPizfM+DIxczxoQvvifkCXfJEGDRlwS/CYDnByL3armQkG3GBGqVZzknaBCxw1mwVkWVjJuAtzv54vKjYLbF0gtU2Ckkr+dH7pP69kar5gvHGWhysobkPeOcUkbReDISIz6UZOjZr4C1RfpO7zg5ZUGVN9EGtLWFT8gtp2atsXKE2C/tFFH3IMPz9lDoAwnZIMp8oOH4RdJOU1dxbUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
From:   Peter Hilber <peter.hilber@opensynergy.com>
Subject: Re: [PATCH v7 14/16] firmware: arm_scmi: Add atomic mode support to
 virtio transport
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, "Michael S. Tsirkin" <mst@redhat.com>,
        Igor Skalkin <igor.skalkin@opensynergy.com>,
        Peter Hilber <peter.hilber@opensynergy.com>,
        virtualization@lists.linux-foundation.org
References: <20211129191156.29322-1-cristian.marussi@arm.com>
 <20211129191156.29322-15-cristian.marussi@arm.com>
Message-ID: <75e651e9-a273-5bd1-c7f7-37a072ad6608@opensynergy.com>
Date:   Fri, 10 Dec 2021 13:12:18 +0100
In-Reply-To: <20211129191156.29322-15-cristian.marussi@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM5PR04CA0020.eurprd04.prod.outlook.com
 (2603:10a6:206:1::33) To AM9PR04MB8084.eurprd04.prod.outlook.com
 (2603:10a6:20b:3ec::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9df0149b-9387-49b2-13e8-08d9bbd65095
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3905:EE_
X-Microsoft-Antispam-PRVS: <AM0PR0402MB3905C2132883C7B78A8D77A08C719@AM0PR0402MB3905.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y0OI2En0C+YevMxfpxi55TUQTv4uXBwaoJ/lbYC+DHw4iwa9C5NGjuT4mJMT7/gykh/dLIEjBY5vQD7VcZ+YDpAl0lGQiAj2Ht6O+/IEFGDR+9kZF28YF4VWzUsE78HeJvIOUs1e/usljYCVBLKSzuVqtRborErFbDVmQBwTrlA+w3y7sKbtvXQLDy2DgwJ+w1e8+jLW83dfq9i/gyjMjQWRNOOKEaFiOkgNMzlgG70Lu96hNvrPx9lgnF+JybTHckQLFOyv2LwS/YnjHjQg2xP4MxzNh8Auw7BbgxwZ1EqZDYSAEn3fdmGhd6XB5JL014fdA+i4xpDZWjb/PzJEcZYZIX50qqDFdrXFz5y8HiBkJCdS+yEWw0KXSwdcwAkf3yTUSFGpou9tdLKGlTghzEFyXOP8Xpx+oubOMQxKHOSkzQc8T5+/Z3YTPod4zrD+AEWU+RM6tbEr4daLWvtgtGJzQAVdplKnOyRx9oZsAuotePYn7Qf2/uhHR1vCtmuRl7/Gi+uGzXFJlnjS6a10mHbCHqMEnzQR6LQBPe+dimnr5UIzuNUn4UkjFNXKdwJy2rmInrvpH8XRlRXxnHut2KbSxz84/XQsT3Nh83r+oqqBzzUdeCJ2TJG5xPHU1lbb4I4ZamJJ+eDtdGwukiNxYQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8084.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(39840400004)(376002)(136003)(346002)(2616005)(31696002)(54906003)(7416002)(508600001)(4326008)(44832011)(83380400001)(36756003)(31686004)(53546011)(186003)(66946007)(8676002)(5660300002)(66476007)(86362001)(66556008)(38100700002)(2906002)(30864003)(8936002)(316002)(42186006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2Q4Z3FLclpvM3RBeU1xWDJjM1prVUtRVHlBanFCQkdoMDRXVkZJZVhCeGFp?=
 =?utf-8?B?Ym42UXNsbGlLTHJnUGlGTUp0c0pFb2N2U3c0clJQN1h1SElrc0x0TkZYNk9r?=
 =?utf-8?B?cXlMSVBvYjI0aGRxY0tSMzRRUEJ4ZnZSaG5VL3p6eXhmUEU4NVFRYTNKU0xX?=
 =?utf-8?B?TzhlOEp2NWcvR3doS2xjZEpRUmozN01kc0ltWldmekhrM3JUcmt1RDZZL2Fo?=
 =?utf-8?B?Y3BFMlBRV3lSbUN0bi95bVdLaDlkODFPVmg2SEVsNnU3blB4SlA5OHBwVjRR?=
 =?utf-8?B?TGpPZXN3ZFpqcDR3T1FvN2xtQVhseitNeVJaUjdTZWFMVXl1cmFIUG1hM0t6?=
 =?utf-8?B?bTJoTlRvTnVlK011Z0tKL1VWV0VBZ01qMk5mRkZnSHJKMWhxRno5SmVaWEVK?=
 =?utf-8?B?bWlaODRDRVplR1diNXlQcithOWsvQWJOSUgybStvNEFhSjkzbXdkTW04cWho?=
 =?utf-8?B?cEs1YnhMZEhQdTM4N01TbGxFOFpIMjhvdXRwUlk0cVRWZTNIRFdLM3dGS0ta?=
 =?utf-8?B?VUExeFdRYW5IaHRPck90T2FISk00QXVZWlUvWGVoVzZicFFQTGliS0NCZFRz?=
 =?utf-8?B?YzNhR1YwU0tHMEFoUGIySDdXYUZmUlBMazIxYkw0OTltNGtmVmYwZno1VVU1?=
 =?utf-8?B?ak5Rd3dwQUFmWTczME41dmRZajJVZjNDZlZ5TW52bWpRVURqWXNEZkhOM3B2?=
 =?utf-8?B?WEF1T1ZnLzdSUyt4MFFyeWFSbjBUeEdlb2hDSUpNYUtsdlRJa0hkYzNOZ2lh?=
 =?utf-8?B?NnFOOUlYNCtUbG1oODNMQ3d2elp5T1JibUZ6cHQzb3pjOUN5TkVqU2l1U3Zr?=
 =?utf-8?B?VTJoTFkrRnY2MnJnSzR3ejZzZ3BTZmEyMFM0OGxFcDJhUkFBKzlybFRtTmJZ?=
 =?utf-8?B?TThONXRSWDR1TWFBem5raUNCYUcxWkRQc3JjbXpXRG94ajF2OVUzMGZuWWZU?=
 =?utf-8?B?TXpxY0xXS1BTOUw3SGNKUkoydHFGdmlUZEVVck9iSks2L256VEdhck50aDlV?=
 =?utf-8?B?UWc2cGZOcGVrSWlPNUZ4TG1WY2dibGZoTnJzZFFTckxZTytYVXZLU0ZoTFlT?=
 =?utf-8?B?MXk5aU9PaDlkRzZUdG14WCtRQUtwbWJZU3NCL3I1b1d4bVBldlZ3NUE4cUpH?=
 =?utf-8?B?UlR2dk05VE9IM3VWWTJsZlBwZlFXQU5WcnN4Q0lyZmJ0emFqNHlGdW5CZWY2?=
 =?utf-8?B?OXlLVUNmSkhQNzN0VStRZE1jcTRlYk9uZGl0b2FuWituYjR4NkJEWWxDUkpm?=
 =?utf-8?B?Mi94Wkh4ZmlsSTdETGRBQWUvZjNBdEQ4dk1MYVl5SVptOHh3WGtUY2dGUHZK?=
 =?utf-8?B?SVhWa0g4bndvNFFGWW44MkpSYlpKMjVGOXlDa3pxZjhiYVBJdUJySTFielFF?=
 =?utf-8?B?SlhtWXc4eFFnR1hmMkZ5bFJrU1FoOW9YYTZHdW9iOTg4Q0dudVFXL3ZuMHNJ?=
 =?utf-8?B?b01VZlZ2cXpzZ0swMVhBMzZyS2M3WGZ4NjlWZ1lDdHlyV1NYTGFvWTJhN2Er?=
 =?utf-8?B?dlRPaXZFSXlzTGtNVkZJWHdsbmgxR1ViT00wdzNCUzBOQjZUL3Vud2JUN3Jj?=
 =?utf-8?B?ZCs3TXlBUnJXbEhNcnZLTXhvd0pqYnNibkpqLzBtR0ppMFZ6M1Uxd3lVOVVE?=
 =?utf-8?B?MU5rSU9oTkU0a1QxWmZaTEQ2RkxiY1JXUnE3WGY4NDJ2UWs4NU95MFRlTDdu?=
 =?utf-8?B?bzVqZEpXL25mZXNoUVYwbmRTc3VWUDdSWmRUd0Fia1RCTXpBVS93Z2lqL3cr?=
 =?utf-8?B?VHRPZjZrYy9zUFZJb2RjQ0xLRi9TT1ZZOHZmRU15Qk96TUdVN2RRaFlKVDMx?=
 =?utf-8?B?dkJXbEVzc0RucFRENDJGQm5CTzk0Q2xPNHBObnA2Z1JZdnJabkxRU214UE9o?=
 =?utf-8?B?ZzRjNmRnZ2NiRGtYVzlaZGhWZHE3VExma292YXJ1bDJJTlM3TUVIeG5Ua3c2?=
 =?utf-8?B?QUlkM2JzOGhIRHVDL2NlU1BuSkluS2cybW1EZHhMUzZ2UHBzQk9PbjJoYldk?=
 =?utf-8?B?Z21jMmprOENObW93aFRKRFh3NXBncFBycHJvUXU3dXZYamVoRDBmck9sY0ZN?=
 =?utf-8?B?ZkF6bU96YTJMdm14UitwdEJGaWxQbTJrNmhNMkJacUJ3MHdONjlaQ3dKQkQy?=
 =?utf-8?B?OEtGSzVBbHp4NnNITHZBVXJDVWdwdFZkYVNlU0MzaHltclRsUUIxeUdVaGE1?=
 =?utf-8?B?bmZ6T05pYkswYVZKRk5vSGFEb2NBSHJ1SU5JWlJxVU85M3duOXcydEdMUDZ2?=
 =?utf-8?Q?zuPy/s120dF9abKVRNaqcYrHy1Y5N1Jp8CJStBGhTQ=3D?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9df0149b-9387-49b2-13e8-08d9bbd65095
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8084.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 12:12:20.3665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UZ/rRAnXiT9lQCHAzRYPMocf2LFyhHrhq40jQClygZHOhAck9G57aAjgQXARmzr3B3lHOdQ2+MYnSZtDJSVANA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3905
X-TM-AS-ERS: 104.47.18.105-0.0.0.0
X-TMASE-Version: StarCloud-1.3-8.8.1001-26580.007
X-TMASE-Result: 10--15.407700-4.000000
X-TMASE-MatchedRID: IeZYkn8zfFrmLzc6AOD8DfHkpkyUphL9F4r8H5YrEqzYzDFd3mQzYSlA
        /rS07QvhX4tQOIJWO43nxOAx7X1mP8CoX5/lejxbfid4LSHtIAM6En2bnefhoMuSXx71bvSLeOb
        QA+fBlTa/kncURpSLEJj6diuO2+nJzroGAhCVDDXW4Mz461fsHMu99zcLpJbCnr4oKU6nK6NQpg
        p7LA0fukYTGkfzd6Xbbm/JJSqFBqVPEtzipOABjE2jweCvkWdh/qWl+m17jWFxO+7mhphLS8TFv
        mr6ouga5WG6R9fEDAvMdHm3E7kFwCHhSBQfglfsA9lly13c/gHy++SyyVe4t+ZAlRR6AIJ7WXMa
        owod38xQHUQ3QyKlE9emgBnijyoYQPhYfVNEOHp9Na8belcvhEloPruIq9jTaYn7tXmtFzNxXGp
        ar095wTSvW4EeMY6WDuY6Gwb0mlQ+fMWyRw2N60f49ONH0RaSGkSehlxL4826pZ/o2Hu2YWps62
        rLXqkAxI6oRO6x/PH7eGMTOEm28DuBsKLHO7oUuLHENGl+3A9ZDdHiTk9OcLSAmG8slgF0xOv8b
        bijtGv7LqapE8Q/bN5Sk65l6T+sMP8ChIjkR+ITF1LtYW9law48ME9K+hF0Mv8YehqjR1WQB9Ee
        VI0Jp7zW3xDWf4F1vZPGvwoZA0mV3H8C+VQp7vSG/+sPtZVkhC75d8s/Kwrg91xayX4L8yXi8Z7
        hCx0oNMC2Uo0JAnBN+tYFDfyQFp2c71ZPgwobkr0W/BDHWEUPo0vi0aZfNUjINjnv2/BMRyqMLI
        j/WA0fN5Xr87RgOg7J7FU9Sm2pXxyK1urLTpN+yskgwrfsC30tCKdnhB58vqq8s2MNhPCy5/tFZ
        u9S3Ku6xVHLhqfxIAcCikR3vq8ysOeb0dC7biNc/bgADV/tbbqh3xRSTJaXOTcJSspE49QdUktm
        ZNae
X-TMASE-XGENCLOUD: d31f94b9-a9c7-48da-965c-f9a62f2c773c-0-0-200-0
X-TM-Deliver-Signature: 1CDFDBAC623AC0DE77403C02DB8E9264
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
        s=TM-DKIM-20210503141657; t=1639138342;
        bh=Rkeh/BtSGf3W2OQrxH0PhWiNkKg7qBDglTbH8znA0dA=; l=16587;
        h=From:To:Date;
        b=vvzBe29gRAPW+BwN+FDN+Us4SdnMIoK/NVxiDKl+SFJAIrZQ/lwyWb8XUSZke0Qay
         l3UPrjWWSxy75WC3kcnTEzCIJiqZDptcv3PZCrzxcIdAtcD6YiB/fVWTShuhXMIB4/
         kyyI+1W5JpaUeqH4DTl+5Ez097bO5TRbMx1XH/MvyRAQWrs4/y/nmo+LJLjAg81KRg
         h0Pxgpe1MCK6zSxXbQ2I0lK04IMXFdIeH8EJLqCFuOL4B+BwMFybfST0piR16nVuud
         FviBHh0MdWVQWV/Lt+joTKkPGakeGVgiCl9/v+ecpjYLp7gFab+TmRJoT7EfNkAJMX
         QGtSDp/lKsKxQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.11.21 20:11, Cristian Marussi wrote:
> Add support for .mark_txdone and .poll_done transport operations to SCMI
> VirtIO transport as pre-requisites to enable atomic operations.
> 

Hi Cristian,

I see no conceptual problems with this patch. Please find some inline
remarks below.

Best regards,

Peter

> Add a Kernel configuration option to enable SCMI VirtIO transport polling
> and atomic mode for selected SCMI transactions while leaving it default
> disabled.
> 
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Igor Skalkin <igor.skalkin@opensynergy.com>
> Cc: Peter Hilber <peter.hilber@opensynergy.com>
> Cc: virtualization@lists.linux-foundation.org
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
> V6 --> V7
> - added a few comments about virtio polling internals
> - fixed missing list_del on pending_cmds_list processing
> - shrinked spinlocked areas in virtio_poll_done
> - added proper spinlocking to scmi_vio_complete_cb while scanning list
>   of pending cmds
> ---
>  drivers/firmware/arm_scmi/Kconfig  |  15 ++
>  drivers/firmware/arm_scmi/virtio.c | 241 +++++++++++++++++++++++++++--
>  2 files changed, 243 insertions(+), 13 deletions(-)
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
> index fd0f6f91fc0b..0598e185a786 100644
> --- a/drivers/firmware/arm_scmi/virtio.c
> +++ b/drivers/firmware/arm_scmi/virtio.c
> @@ -38,6 +38,7 @@
>   * @vqueue: Associated virtqueue
>   * @cinfo: SCMI Tx or Rx channel
>   * @free_list: List of unused scmi_vio_msg, maintained for Tx channels only
> + * @pending_cmds_list: List of pre-fetched commands queueud for later processing
>   * @is_rx: Whether channel is an Rx channel
>   * @ready: Whether transport user is ready to hear about channel
>   * @max_msg: Maximum number of pending messages for this channel.
> @@ -49,6 +50,9 @@ struct scmi_vio_channel {
>  	struct virtqueue *vqueue;
>  	struct scmi_chan_info *cinfo;
>  	struct list_head free_list;
> +#ifdef CONFIG_ARM_SCMI_TRANSPORT_VIRTIO_ATOMIC_ENABLE
> +	struct list_head pending_cmds_list;
> +#endif
>  	bool is_rx;
>  	bool ready;
>  	unsigned int max_msg;
> @@ -65,12 +69,22 @@ struct scmi_vio_channel {
>   * @input: SDU used for (delayed) responses and notifications
>   * @list: List which scmi_vio_msg may be part of
>   * @rx_len: Input SDU size in bytes, once input has been received
> + * @poll_idx: Last used index registered for polling purposes if this message
> + *	      transaction reply was configured for polling.
> + *	      Note that virtqueue used index is an unsigned 16-bit.
> + * @poll_lock: Protect access to @poll_idx.
>   */
>  struct scmi_vio_msg {
>  	struct scmi_msg_payld *request;
>  	struct scmi_msg_payld *input;
>  	struct list_head list;
>  	unsigned int rx_len;
> +#ifdef CONFIG_ARM_SCMI_TRANSPORT_VIRTIO_ATOMIC_ENABLE
> +#define VIO_MSG_POLL_DONE	0xffffffffUL

virtqueue_enable_cb_prepare() returns an "opaque unsigned value", so
this special value should not be used for .poll_idx.

> +	unsigned int poll_idx;
> +	/* lock to protect access to poll_idx. */
> +	spinlock_t poll_lock;
> +#endif
>  };
>  
>  /* Only one SCMI VirtIO device can possibly exist */
> @@ -104,17 +118,22 @@ static int scmi_vio_feed_vq_rx(struct scmi_vio_channel *vioch,
>  	return rc;
>  }
>  
> +static inline void scmi_vio_feed_vq_tx(struct scmi_vio_channel *vioch,
> +				       struct scmi_vio_msg *msg)
> +{
> +	/* Here IRQs are assumed to be already disabled by the caller */
> +	spin_lock(&vioch->lock);
> +	list_add(&msg->list, &vioch->free_list);
> +	spin_unlock(&vioch->lock);
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
> @@ -140,6 +159,26 @@ static void scmi_vio_complete_cb(struct virtqueue *vqueue)

Looks like this function could also scmi_rx_callback() for polled
messages, which should probably not happen.

>  
>  		/* IRQs already disabled here no need to irqsave */
>  		spin_lock(&vioch->lock);
> +#ifdef CONFIG_ARM_SCMI_TRANSPORT_VIRTIO_ATOMIC_ENABLE
> +		/* At first scan the list of possibly pre-fetched messages */
> +		if (!vioch->is_rx) {
> +			struct scmi_vio_msg *tmp;
> +
> +			list_for_each_entry_safe(msg, tmp,
> +						 &vioch->pending_cmds_list,
> +						 list) {
> +				list_del(&msg->list);
> +				spin_unlock(&vioch->lock);
> +
> +				scmi_rx_callback(vioch->cinfo,
> +						 msg_read_header(msg->input),
> +						 msg);
> +				/* Free the processed message once done */
> +				spin_lock(&vioch->lock);
> +				list_add(&msg->list, &vioch->free_list);
> +			}
> +		}
> +#endif
>  		if (cb_enabled) {
>  			virtqueue_disable_cb(vqueue);
>  			cb_enabled = false;
> @@ -257,6 +296,9 @@ static int virtio_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
>  						    GFP_KERNEL);
>  			if (!msg->request)
>  				return -ENOMEM;
> +#ifdef CONFIG_ARM_SCMI_TRANSPORT_VIRTIO_ATOMIC_ENABLE
> +			spin_lock_init(&msg->poll_lock);
> +#endif
>  		}
>  
>  		msg->input = devm_kzalloc(cinfo->dev, VIRTIO_SCMI_MAX_PDU_SIZE,
> @@ -324,7 +366,8 @@ static int virtio_send_message(struct scmi_chan_info *cinfo,
>  	}
>  
>  	msg = list_first_entry(&vioch->free_list, typeof(*msg), list);
> -	list_del(&msg->list);
> +	/* Re-init element so we can discern anytime if it is still in-flight */
> +	list_del_init(&msg->list);
>  
>  	msg_tx_prepare(msg->request, xfer);
>  
> @@ -337,6 +380,20 @@ static int virtio_send_message(struct scmi_chan_info *cinfo,
>  		dev_err(vioch->cinfo->dev,
>  			"failed to add to TX virtqueue (%d)\n", rc);
>  	} else {
> +#ifdef CONFIG_ARM_SCMI_TRANSPORT_VIRTIO_ATOMIC_ENABLE
> +		/*
> +		 * If polling was requested for this transaction:
> +		 *  - retrieve last used index (will be used as polling reference)
> +		 *  - bind the polled message to the xfer via .priv
> +		 */
> +		if (xfer->hdr.poll_completion) {
> +			spin_lock(&msg->poll_lock);
> +			msg->poll_idx =
> +				virtqueue_enable_cb_prepare(vioch->vqueue);
> +			spin_unlock(&msg->poll_lock);
> +			xfer->priv = msg;
> +		}
> +#endif
>  		virtqueue_kick(vioch->vqueue);
>  	}
>  
> @@ -350,10 +407,8 @@ static void virtio_fetch_response(struct scmi_chan_info *cinfo,
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
> @@ -361,11 +416,163 @@ static void virtio_fetch_notification(struct scmi_chan_info *cinfo,
>  {
>  	struct scmi_vio_msg *msg = xfer->priv;
>  
> -	if (msg) {
> +	if (msg)
>  		msg_fetch_notification(msg->input, msg->rx_len, max_len, xfer);
> -		xfer->priv = NULL;
> +}
> +
> +#ifdef CONFIG_ARM_SCMI_TRANSPORT_VIRTIO_ATOMIC_ENABLE
> +/**
> + * virtio_mark_txdone  - Mark transmission done
> + *
> + * Free only successfully completed polling transfer messages.
> + *
> + * Note that in the SCMI VirtIO transport we never explicitly release timed-out
> + * messages by forcibly re-adding them to the free-list on timeout inside the TX
> + * code path; we instead let IRQ/RX callbacks eventually clean up such messages
> + * once, finally, a late reply is received and discarded (if ever).
> + *
> + * This approach was deemed preferable since those pending timed-out buffers are
> + * still effectively owned by the SCMI platform VirtIO device even after timeout
> + * expiration: forcibly freeing and reusing them before they had beeen returned
> + * by the SCMI platform could lead to subtle bugs due to message corruption.
> + * An SCMI platform VirtIO device which never returns message buffers is
> + * anyway broken and it will quickly lead to message exhaustion.
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
> +	/* Is a successfully completed polled message still to be finalized ? */
> +	spin_lock_irqsave(&msg->poll_lock, flags);

.poll_lock is acquired before vioch->lock (in scmi_vio_feed_vq_tx()),
but e. g. virtio_poll_done() uses the reverse locking order.

> +	if (!ret && xfer->hdr.poll_completion && list_empty(&msg->list))
> +		scmi_vio_feed_vq_tx(vioch, msg);
> +	spin_unlock_irqrestore(&msg->poll_lock, flags);
> +
> +	xfer->priv = NULL;
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
> + * then added to a the @pending_cmds_list list for later processing within the
> + * usual VirtIO callbacks; so, basically, once something new is spotted we
> + * proceed to de-queue all the freshly received used buffers until we found the
> + * one we were polling on, or we empty the virtqueue.
> + *
> + * Note that we do NOT suppress notification with VIRTQ_USED_F_NO_NOTIFY even
> + * when polling since such flag is per-virtqueues and we do not want to
> + * suppress notifications as a whole: so, if the message we are polling for is
> + * delivered via usual IRQs callbacks, it will be handled as such and the
> + * polling loop in the SCMI Core TX path will be transparently terminated
> + * anyway.
> + *
> + * Return: True once polling has successfully completed.
> + */
> +static bool virtio_poll_done(struct scmi_chan_info *cinfo,
> +			     struct scmi_xfer *xfer)
> +{
> +	bool ret;
> +	unsigned int poll_idx;
> +	unsigned long flags;
> +	struct scmi_vio_msg *msg = xfer->priv;
> +	struct scmi_vio_channel *vioch = cinfo->transport_info;
> +
> +	if (!msg)
> +		return true;
> +
> +	/*
> +	 * Keep the spinlocked region as small as possible: don't care if
> +	 * missing something this time it will be polled again next.
> +	 */
> +	spin_lock_irqsave(&msg->poll_lock, flags);
> +	poll_idx = msg->poll_idx;
> +	spin_unlock_irqrestore(&msg->poll_lock, flags);
> +
> +	/* Processed already by other polling loop on another CPU ? */
> +	if (poll_idx == VIO_MSG_POLL_DONE)
> +		return true;
> +
> +	/* Has cmdq index moved at all ? */
> +	ret = virtqueue_poll(vioch->vqueue, poll_idx);

In theory, if polling gets delayed, virtqueue_poll() might run into an
ABA problem, if 2**16 descriptors have been used in the meantime (and
activity stops after this).

I think this could be avoided by clearing .poll_idx of each returned
message everywhere (also in scmi_vio_complete_cb()).

> +	if (ret) {
> +		struct scmi_vio_msg *next_msg;
> +
> +		spin_lock_irqsave(&vioch->lock, flags);
> +		virtqueue_disable_cb(vioch->vqueue);
> +		/*
> +		 * If something arrived we cannot be sure if it was the reply to
> +		 * the xfer we are polling for, or some replies to other, even
> +		 * possibly non-polling, pending xfers: process all new messages
> +		 * till the polled-for message is found OR the vqueue is empty.
> +		 */
> +		do {
> +			unsigned int length;
> +
> +			next_msg = virtqueue_get_buf(vioch->vqueue, &length);
> +			if (next_msg) {
> +				next_msg->rx_len = length;
> +				if (next_msg == msg) {
> +					ret = true;
> +					break;
> +				}
> +
> +				list_add_tail(&next_msg->list,
> +					      &vioch->pending_cmds_list);
> +				spin_lock(&next_msg->poll_lock);
> +				next_msg->poll_idx = VIO_MSG_POLL_DONE;
> +				spin_unlock(&next_msg->poll_lock);
> +				ret = false;
> +			}
> +		} while (next_msg);
> +
> +		/*
> +		 * When the polling loop has successfully terminated simply
> +		 * restart the vqueue, no matter if something else was queued

"restart the vqueue" should better be phrased as "re-enable the vqueue
callbacks".

> +		 * in the meantime, it will be served by normal IRQ/callback
> +		 * or by the next poll loop.
> +		 *
> +		 * Update the polling index to the current vqueue last used
> +		 * index, if still looking for a reply.
> +		 */
> +		if (ret) {
> +			virtqueue_enable_cb(vioch->vqueue);

If this function returns false, how is the race described in the
function documentation handled? (The same comment might also apply in
other places.)

> +		} else {
> +			spin_lock(&msg->poll_lock);
> +			msg->poll_idx =
> +				virtqueue_enable_cb_prepare(vioch->vqueue);
> +			spin_unlock(&msg->poll_lock);
> +		}
> +		spin_unlock_irqrestore(&vioch->lock, flags);
>  	}
> +
> +	return ret;
>  }
> +#endif
>  
>  static const struct scmi_transport_ops scmi_virtio_ops = {
>  	.link_supplier = virtio_link_supplier,
> @@ -376,6 +583,10 @@ static const struct scmi_transport_ops scmi_virtio_ops = {
>  	.send_message = virtio_send_message,
>  	.fetch_response = virtio_fetch_response,
>  	.fetch_notification = virtio_fetch_notification,
> +#ifdef CONFIG_ARM_SCMI_TRANSPORT_VIRTIO_ATOMIC_ENABLE
> +	.mark_txdone = virtio_mark_txdone,
> +	.poll_done = virtio_poll_done,
> +#endif
>  };
>  
>  static int scmi_vio_probe(struct virtio_device *vdev)
> @@ -418,6 +629,9 @@ static int scmi_vio_probe(struct virtio_device *vdev)
>  		spin_lock_init(&channels[i].lock);
>  		spin_lock_init(&channels[i].ready_lock);
>  		INIT_LIST_HEAD(&channels[i].free_list);
> +#ifdef CONFIG_ARM_SCMI_TRANSPORT_VIRTIO_ATOMIC_ENABLE
> +		INIT_LIST_HEAD(&channels[i].pending_cmds_list);
> +#endif
>  		channels[i].vqueue = vqs[i];
>  
>  		sz = virtqueue_get_vring_size(channels[i].vqueue);
> @@ -506,4 +720,5 @@ const struct scmi_desc scmi_virtio_desc = {
>  	.max_rx_timeout_ms = 60000, /* for non-realtime virtio devices */
>  	.max_msg = 0, /* overridden by virtio_get_max_msg() */
>  	.max_msg_size = VIRTIO_SCMI_MAX_MSG_SIZE,
> +	.atomic_enabled = IS_ENABLED(CONFIG_ARM_SCMI_TRANSPORT_VIRTIO_ATOMIC_ENABLE),
>  };
> 
