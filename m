Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD83585114
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 15:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236679AbiG2Nsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 09:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233738AbiG2Ns3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 09:48:29 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92503B962;
        Fri, 29 Jul 2022 06:48:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XDmp5XtizYvYPXDZPJ4ncGqXOW5X8vlynCObLkbJXZ0pU3CnxOrPyaF8m4yT9W3wdzQ8tB42Vz1Q422TeS+c0HwA4oCkkYisWg/yQSV1jqtiD6hF9a/pt+61MwSpbhB9UoxWu6TSCmFJWWzoF8nFSRXE5OD2kezIimBMk2sbI0RXq6ujJ101D8jpvfo+YxH1B+PRVRU390PWrskfG44DSSPYv7vwyVABnA1ay0yp4nUzLJKuX3S+doZZMEmMZzD3fsYIVmDzPkM3DGrU2X8z3vCJYXQoqkAPaohgkZVsDkQN8W5VSCikPlnF8poc4L1lSFFztKHjc0H62D746Qj3mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9SIln8c1xGuwZn7642SrM18TbKhJoPU/BvrFpqXZCKI=;
 b=k6BIGagWs8g2vNbGz747RBB8arszIYdxEbpaLwEy6iVK3I7/ZBDhUKWxWDC0nuljuJyqZv32GDQrvShwWzLD2PPlpXI2GVfXnTWtBedw97gYBYncg0YZk+QKY3PN3gTe8y7Ykw6znOuNnIjtjiI+gAAvU7c/LN84MI2UANlc1F+P3ykx6CeKz65+NuTlqjTMteIbc384MKpCx9SWF1AHfgTFosb18kAYyQhnZhmv0CGhLnQXl8pIDVClR84KSovJa44w1wIg/fYOln3tzropg02/1+H1VB25zK910skruKSuxtuqj4FyS0zRxhwNnxjDyEP6VyGymo4S7l5szE1iyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9SIln8c1xGuwZn7642SrM18TbKhJoPU/BvrFpqXZCKI=;
 b=JuuJ0ECXbnjMPmO8fdEbb25oUA2q/41kWjp5SNvVEcPrT+1IdRylrwRSUEchykWfXE4dhT82qEaaylgK6Z7XKV9cDC285WdFt0phGtC+M+90sRVKomAQ5EsdDG0lIqk8xoD2Ph6PTnrJHGDybC2NOZ2I5NB+T//SIiTNnzEcUtM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB6663.namprd12.prod.outlook.com (2603:10b6:8:bb::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5482.6; Fri, 29 Jul 2022 13:48:23 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1dac:1301:78a3:c0d0]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1dac:1301:78a3:c0d0%4]) with mapi id 15.20.5482.012; Fri, 29 Jul 2022
 13:48:23 +0000
Message-ID: <3531fa50-106b-35e9-d064-a1c9c6598817@amd.com>
Date:   Fri, 29 Jul 2022 08:48:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] docs: embargoed-hardware-issues: fix invalid AMD contact
 email
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net,
        Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>
References: <20220729134517.2284700-1-gregkh@linuxfoundation.org>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20220729134517.2284700-1-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0046.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::14) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a20c8b4a-faaa-4ef6-11e3-08da71690128
X-MS-TrafficTypeDiagnostic: DM4PR12MB6663:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bmBPEPmK5xKs5ODZcn721vPMOtjU9cQOTi6EvAmPqt0GQnk3KRYvOe8c+XNvtXgZDLAQySD0dPSnL0mCYNsA3XenwMqzQfLSlpVcfL0HLqt7eo0x9rxgjb20HXreP7xZ+39dxbSgNjRswx4H+08b2VDmwdFPy+18JmhAoVx1euNo+ejhkQNZah0nQIbWl5OgD0+t/fu1RqIAo3aw5OVLO5Y+QCx0dQSNaHL20zlb17i7QwjzFxMBSQXiY5ZHywMsT9X06/8AOxBLvSRMHWTFd3L4KagCaXm3yW8BAMfESuSy7hb4I19jvjEDfowfhMGjlrecFES/ecWpfE+pMyf5hW1lKuhl7KfTqx+YugigVrItKefDBqza30twQW6wVvQwhanuc9XUGE2vCCa6DsQcBt644Zhyq3Q394EmdR4Q1QESoUw9jIOuFGcqIGYvCk5NDSHAejOahHfnqKx8CX41m1K2829qeVT8bdRGevwlvDn5MJJdWWBM86FmzlioEw6+nd6ZWB5ULFJFKiIPKQbzs7fA+2pSCMXpR4DlymewGYbC1zbekPebbRsV7mA96dmmtSqsXsfNrPHMJcPsw/USpVmfFOfoMZOi0ddezf4e8VM8a7/bBjHEO47iN1wIJ9T2WOVBRBeaUXtAnB+r45SYA9GS8nwNe3tfbvIeFvCCPb1dfvHceX/IHTNn+iL/38W6vYYd2DI/9or/9lOm/wcqCDWYrh/nGVOP8hjY987Do/jx1+SUETuz1r1TlpDX/Rrg4o7IKk6N6oZaHC0OjLZxumCdo+KvUTj34geC1tGMJEr5Tp9Q8LQWZcc9cD1D8F2/97WvnZEWOky1qnN96OHZmw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(346002)(136003)(396003)(39860400002)(8936002)(66946007)(66476007)(66556008)(8676002)(5660300002)(2906002)(186003)(83380400001)(4326008)(86362001)(316002)(6486002)(36756003)(2616005)(38100700002)(31696002)(6512007)(6506007)(31686004)(41300700001)(54906003)(26005)(53546011)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2lGWFlKS2x1VDd3Q0hRQkxjbXFFeXVYZmlKRHByM3ZOeFBwZS9RNjlFY1VL?=
 =?utf-8?B?ZjFXMXJwM1o4ZU5WUEJyNXJFc2hsSENCZVBRU3hqb1kvRXUwcGlyaWNZcENR?=
 =?utf-8?B?VnJPZHpNUW82cjhQekxpMjAvRW10NGRYMmE2SlNvYzVnc2xJK3krb3Q4OUJz?=
 =?utf-8?B?ellKTzFoZ0phZndkVE5MbHhkcnBOUlhDdndndUM2QlVpd3pjWDdHTlo0ajd3?=
 =?utf-8?B?ZG1nYVhMcGJmNFY3V1VHUHJKSUloRENDUUJuSy9vblpsTlV4K1gxNmJGblpL?=
 =?utf-8?B?ZVQ1UnI0eGMzTGxCSTh3ZnNuYU5PM2cwR2xORXMvUzlIRnR2QStERXNBNlJL?=
 =?utf-8?B?V0N5ODZlSm1qRTEwNlNhb1UyWjhpQ1lnSUQvNkJ0SnB5R21OY2ZSR1A4ckN5?=
 =?utf-8?B?VGNRV09SWU41VDkzaFdORUs2QytuUHo0RmVER0NVbFlacGhZeWQva0FHNWtO?=
 =?utf-8?B?RU8vMEhCQm9MYzZSSW14bDI4WTZaMVloSmlxeWwwNjI4WEhOSUJiVndMUXFx?=
 =?utf-8?B?Qko0QlMySW5HcGFrOHEzZXp6ZXhqaVNwRmd4VnJ0SWhSWkJBWWFHSW41THFx?=
 =?utf-8?B?aG5BSWRjZzV3YUZwR0VYV0gwc2lsam5jdWw2Q1RsRmZtam8raG52dTkxeGJG?=
 =?utf-8?B?U1Fhdi9xcmlacWhBWEZSaVlJWHdTeDlCd0ZSblBMTkJEZ2JlMEM5amVrZ3dB?=
 =?utf-8?B?N2JjajNFZHBGaHFRYzZqRXhFZGZ1dTFZRCtBL3dnK2R3NTZFTk1TQTZ2N1dM?=
 =?utf-8?B?OVNvUFBkSlJENzhIdC9aZjJFeUZXcGMzVFV6TzJYWXJvM0hNQXRDRkx6MUxP?=
 =?utf-8?B?ekt5SG9lRzI2TGdjNVB1YVBZaUtaNk9DZ3NBQk1MbjBER0R2OXVEUDY5MzVp?=
 =?utf-8?B?NHZMcXk5QWYwZUYwaks2SmtQZHcvOWFTdy9ZNllISjhxNzE0S1k0ZHZqQzgv?=
 =?utf-8?B?MkJiWEd1cEk4anZrdENuL3BFdFhwRU9ONGdxSW5scmZwTWJkUCtsS3h6UlM2?=
 =?utf-8?B?TTdLZjBtTnVhYm0zR2JTN1FnUk15Y0FMUVlxWktWQ2JZRStsUVBjU2ZZV0du?=
 =?utf-8?B?REUvVWdpV3Y2YlJpRkZWTWJKQ0xLT1ZMOW5kbGVrRzhoNWp6REh1bEw1UEJ2?=
 =?utf-8?B?VFB3TW9FV01CV1B0T05oYkhxWHlKT1VmbmlHZHVJQVFGVHFhaitFQ281dDlV?=
 =?utf-8?B?NkhQcDVCRmF4b212OU9pZEdYUm5xZGE0QnlsRWRDMlJlQUExSGtGMnpjYWVp?=
 =?utf-8?B?MXp1Kzk3SDVtSW9sS2hEbW9FZUc1UVdGY05iSmcwdVVzY2E2WGxqN1FMNitB?=
 =?utf-8?B?N2VMQTNBOG1wNjVnbjFZSmRCSEo4ZFdBOUZ6c1VvYU9IQjB4WmIyNjdwWFNs?=
 =?utf-8?B?cjJkYTM1MUN1VDU4QnNYdVFoNlYrZ24rVW5WMkRLV00rb2pVS3VGSCtKUFV2?=
 =?utf-8?B?cWd5SXNodGZ6RzlWeWU0cVA1d3dGUExzYVpvYzZrNTVaciswVFh6a1VlcmpE?=
 =?utf-8?B?aFFWVkwzRnhNL25QN0JnQ0RkMHpaM3VDUVZ6T2U1RlRYeUVKOERzZXMyM1B3?=
 =?utf-8?B?S1BtcFpBMXllZlNVS0NVY1lxS1h3d2FhVzJCUWx5OUlBek9RQ1plOWNQQURL?=
 =?utf-8?B?aEVCZk81VkUzZERkRy9DNUNJa0FlcVpSbThKZjVsWFkzSzRIQkQ1MCtRNEtj?=
 =?utf-8?B?ajhjV2dPWURIcmtWSnZENzNmSiszeURvM1kzOEgzeE9NRGk1Y0V5allONkhW?=
 =?utf-8?B?aEdUd1RtbmpjRnFyOHlKTmE5OUNLaGNxZUpXTVpLKzFYRFRmMStISjhrU0sx?=
 =?utf-8?B?N25LU01aN2liZlVXL29Gc0svQktwWk5JNVFCRTZRZk13NmVMMmpMQk5HSDRu?=
 =?utf-8?B?SWVqTEZaS3UzY3lmTU9uVWcreFBHT1RYVzRJVVJYRUlob2VZT0F3WExkRDhN?=
 =?utf-8?B?WWlXMjN1bzNSeWM4WGhPcXc0dGI3NEJ1bjJqQ0ttNW0zd2lRbWVYWG9uVkFC?=
 =?utf-8?B?eTNQOEZwblVleWlDVUdJREtpSUtnNmlPNXVUeThjL3BCNi84d3ZlTG5ORUJX?=
 =?utf-8?B?R05BQm1tSk8wTzNNOXNtYVN5cjZhb1J4VHNsUTgyeWd0Tmd2Z3VlWUlYaWNh?=
 =?utf-8?Q?981IA6drqnAXxWWg4ty1wW+kx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a20c8b4a-faaa-4ef6-11e3-08da71690128
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2022 13:48:23.2504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Us0hM5H9hSZo1ymmpuW/320zispG5qPcM7x91SK3PLUOQ5puc6GqbXmA1gklxGcqj+uk3hcwZmhAg4BWCwFxeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6663
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/29/22 08:45, Greg Kroah-Hartman wrote:
> The current AMD contact info email address is incorrect, so fix it up to
> use the correct one.
> 
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Alex Shi <alexs@kernel.org>
> Cc: Yanteng Si <siyanteng@loongson.cn>
> Cc: Hu Haowen <src.res@email.cn>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Still can't believe I did that...

Acked-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
>   Documentation/process/embargoed-hardware-issues.rst             | 2 +-
>   .../translations/zh_CN/process/embargoed-hardware-issues.rst    | 2 +-
>   .../translations/zh_TW/process/embargoed-hardware-issues.rst    | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/process/embargoed-hardware-issues.rst b/Documentation/process/embargoed-hardware-issues.rst
> index 95999302d279..420bf4a4b006 100644
> --- a/Documentation/process/embargoed-hardware-issues.rst
> +++ b/Documentation/process/embargoed-hardware-issues.rst
> @@ -244,7 +244,7 @@ disclosure of a particular issue, unless requested by a response team or by
>   an involved disclosed party. The current ambassadors list:
>   
>     ============= ========================================================
> -  AMD		Tom Lendacky <tom.lendacky@amd.com>
> +  AMD		Tom Lendacky <thomas.lendacky@amd.com>
>     Ampere	Darren Hart <darren@os.amperecomputing.com>
>     ARM		Catalin Marinas <catalin.marinas@arm.com>
>     IBM Power	Anton Blanchard <anton@linux.ibm.com>
> diff --git a/Documentation/translations/zh_CN/process/embargoed-hardware-issues.rst b/Documentation/translations/zh_CN/process/embargoed-hardware-issues.rst
> index 88273ebe7823..cf5f1fca3d92 100644
> --- a/Documentation/translations/zh_CN/process/embargoed-hardware-issues.rst
> +++ b/Documentation/translations/zh_CN/process/embargoed-hardware-issues.rst
> @@ -174,7 +174,7 @@ CVE分配
>   
>     ============= ========================================================
>     ARM
> -  AMD		Tom Lendacky <tom.lendacky@amd.com>
> +  AMD		Tom Lendacky <thomas.lendacky@amd.com>
>     IBM
>     Intel		Tony Luck <tony.luck@intel.com>
>     Qualcomm	Trilok Soni <tsoni@codeaurora.org>
> diff --git a/Documentation/translations/zh_TW/process/embargoed-hardware-issues.rst b/Documentation/translations/zh_TW/process/embargoed-hardware-issues.rst
> index 6c76fc96131a..fbde3e26eda5 100644
> --- a/Documentation/translations/zh_TW/process/embargoed-hardware-issues.rst
> +++ b/Documentation/translations/zh_TW/process/embargoed-hardware-issues.rst
> @@ -177,7 +177,7 @@ CVE分配
>   
>     ============= ========================================================
>     ARM
> -  AMD		Tom Lendacky <tom.lendacky@amd.com>
> +  AMD		Tom Lendacky <thomas.lendacky@amd.com>
>     IBM
>     Intel		Tony Luck <tony.luck@intel.com>
>     Qualcomm	Trilok Soni <tsoni@codeaurora.org>
