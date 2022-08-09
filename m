Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B80758DCCB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 19:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244836AbiHIRHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 13:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245433AbiHIRGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 13:06:55 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C66B1DA49
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 10:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660064814; x=1691600814;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=roB8gs1AogBo27nciRk48iDbwZySvzVOc51VK8Q33ro=;
  b=U9slZ8aU8uJ9GWNYZYixjpHrpQIwjKdh2bCyd9uHWxbz7nZ50WLTICFJ
   +Dtay0HV9r1zlMJmBid6F/OzCNI5MZQoIp/jyba/FgQjk8KkhZx04jCIp
   IQmOsWAYVNBq7k63WhXEGjoRizc2ZABTtiSd/luR0wW9ZXj6DYJRrC0AP
   8bLRuDSEbk9bnnDcmlWLojD92V7syL1Xx5iD/5FQro3n3W/1uxRElh1+c
   PiCkM1QJl0CYHd/83X0+xqlMj2li+IzoNCnggL6KobZcGIIlSRbT0i4f9
   8F4iTDG+LRsaHHay5YixauhgQg7WmPBEUpJB8cn0haWgiSIMFtXMEBdxI
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10434"; a="289643729"
X-IronPort-AV: E=Sophos;i="5.93,225,1654585200"; 
   d="scan'208";a="289643729"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 10:06:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,225,1654585200"; 
   d="scan'208";a="731201937"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 09 Aug 2022 10:06:47 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 9 Aug 2022 10:06:47 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Tue, 9 Aug 2022 10:06:47 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Tue, 9 Aug 2022 10:06:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jcmlqNM3XCGFcGssSv7iu5IKOHUCHgKkYTHBPIF8lsJOz/S8nhJq3/SNq+1ivzD1UN0apJLOrKqGIJoFKQI/E2T+/cLdzGiWe9uCDmnOmCv6Dk/8qU7Wj52NoqGgkrIWc1G0Vrd0QZF45r2geFkmiueKJB9hnCIy9pphBAdrRC+4O03OmOZyhZx6TqvESuoMhappL9hdmZmqVrxK/FzgGliTyT50lL06483T0zd6V/PJ3LZHB/04WLKrHgIQ082l3cQb6sTQ5HpOdjuPEo2lXkZAr+8TgOAejajPaBBy9uOBOZDsuMMBaEHF2sXzGT71yorgoEOq/3fjSHWEPnzL6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=60w78QVwKm2NlG+yZVF3gu/MxmskkNQcLfOZXw8b0Zs=;
 b=bEyk0/sTj4KNEvlzd0ZsJR34yNmrkfEs9zQjC+cEx0cpZhCCH2O2snHPWG8Hn5Lp1n+hnMRTrYiLWc+nlp8Lj3j4SmFcNHAvb1KsMM788lQ4/qHTRxfeTeFgpzqAfgu+LwzpXHs9HsuW0rG/fhJhap/VlsfhGEDV6JXQoxhdJYNG3YrdF8mhh7q1f37jjL68G9HkMMOFBaTircEugeBRkucxcvVpZMyTAdivOAMR8vYaIywLLoGceLHtxe78Oq9uZX+MjmV0F45TCGEmi2lhwrMyC0l/6HgPZeq/I/wtZiaYV/A2gQNA1aQTbPglatGOhOGU6cCkNA2d/8JX2YzCaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM5PR11MB1899.namprd11.prod.outlook.com (2603:10b6:3:10b::14)
 by DM5PR11MB1435.namprd11.prod.outlook.com (2603:10b6:4:7::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.14; Tue, 9 Aug 2022 17:06:44 +0000
Received: from DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::e5bc:d418:aa62:955c]) by DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::e5bc:d418:aa62:955c%10]) with mapi id 15.20.5504.020; Tue, 9 Aug 2022
 17:06:44 +0000
Message-ID: <be2329f9-747e-16e9-b212-74ff424c9a7c@intel.com>
Date:   Tue, 9 Aug 2022 10:06:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v1] regmap: add generic indirect regmap support
Content-Language: en-US
To:     Tianfei Zhang <tianfei.zhang@intel.com>, <broonie@kernel.org>,
        <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <hao.wu@intel.com>, <trix@redhat.com>, <yilun.xu@intel.com>,
        "Matthew Gerlach" <matthew.gerlach@linux.intel.com>
References: <20220607013755.594554-1-tianfei.zhang@intel.com>
From:   Russ Weight <russell.h.weight@intel.com>
In-Reply-To: <20220607013755.594554-1-tianfei.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0050.namprd16.prod.outlook.com
 (2603:10b6:907:1::27) To DM5PR11MB1899.namprd11.prod.outlook.com
 (2603:10b6:3:10b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d7cefe0-0770-4174-0587-08da7a298939
X-MS-TrafficTypeDiagnostic: DM5PR11MB1435:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VY1r81OK9tJv9DGMHJ+sDheIGOSG/nUzJ7fuh9TZV8rKyUC7gSvJxXt+iqOePi5dXTgerxQXWud7aAvkdRSTKW8a2NAgiON6tmewFmbEUsJmG22jTf924W2ap9AiDnbJlC6y9gi3hdY8P/MVrqA5UTbCVQd+CaL9RvpVE2LwRIuWe8aXSK6TuUy14u0/TFx5QNCdivH2zuzsV+KsxKLArmRYSDKZcxqvXBnkcQRaRisl0e2hsfEJxqAFpYLo8Pl8xRuXRR6Eusl/LMvdFxqKyRFk3/Gb6CnXgw0kBaFsPWCmZddN0+8eLUCM3bQQgu+MZwd9dyadOma20sKhn15g5N2MUmYD1/6l+z/i5nJVkRQKcB583vPd1qvwV9nxshXVGUOgwBRUPyHfRrCPUPApeRgIW4PG6oV37V28hIPS0axaM2WM2oXPAypUF+NonAkjVivRu9tyyjYc9QWCd/IFQGDbYPC6N+p48rbH7fzGOfiuJcS/6VbyK+hxVsrYgbiWE6TF1PtVo/UNi7EdZRVAkHOP8Ku248G/XZ6AFrRxQmw8J7vNlnTyDGIu+UNtleo3M4yLnay0uUT1SGKsgzWERB9uf2oELTt034ifAJ3azI1p8qWP7gr86bmOzOcW6zlFJNgmue9tMDYri6eOqJYncO/Uycw+JY0yZQNbRhavngokG/GsnAoi8Q3iMbX0hjBJYAfnuj42Maso8laOAQ41FPWTa7RilV91xF4cm8Ui0TAD4U68Ul/EUX63xsA5xKZPZDIOE0dnh2aa7CH+oJrMa2VpP29fWr+GzKmOd3NZoVy2eBwv7/kVbVnapQiaXvkheWVwFF2dFyrIOmqM7JrrVhiY79Qc1Z0Zvlp0DVzeN0Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1899.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(39860400002)(346002)(136003)(376002)(396003)(2906002)(83380400001)(316002)(82960400001)(8936002)(38100700002)(8676002)(4326008)(66476007)(2616005)(26005)(6506007)(186003)(5660300002)(41300700001)(53546011)(478600001)(6512007)(6486002)(6666004)(66946007)(86362001)(36756003)(66556008)(31686004)(31696002)(41533002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTRzdFFTUEJlMityRHkxOVh1VEppQ1d2MFVWeGxubjZaK1NpaWZRVVdZSXNl?=
 =?utf-8?B?VnkydmtQM1hSbnp0YXFNQlB1VXcxeXlydTlBcmpBY2lBWkY3Z0JJM1RDdGFV?=
 =?utf-8?B?N0YrRzBpMkpsWWgycWNTUFpmSHp1LzJJbkt5SDdQWjIrZmdHVHMvNXZyQjBu?=
 =?utf-8?B?ZVZxcjZUWWhQQjRYdVprZkFDRGdwdjd5YmJVYTB3bVBBQ2VNaWk0WmtWQ0JO?=
 =?utf-8?B?RkNzL1Q0R2NmQllGV1VTZzBaQjc4YVU2YndJajBkNDdvMWgzYWhMUHBpc0l1?=
 =?utf-8?B?MStQd1h5NVJmSkpDWnN2WFZWcHJXVndHRVJxV3FVZWk5ZTRyY0F0Ynp1bjlE?=
 =?utf-8?B?YVlyN3ZDK1ZwbHBMRFFFenVra1FKb3J4Tk5jaVJWVVpxTDlIVUtONk9Pc25s?=
 =?utf-8?B?alBoUjZCVXVNTE5maUl1ZnQxRGlZbXozbzlJVDhEajN0Z2FJMFBXTmlST1BJ?=
 =?utf-8?B?TDdySEdTUklWQ29Gdm9TZW5TaVpwSE5ZOFRyVVNuNzAyWlM0dCtyNitpOHVJ?=
 =?utf-8?B?SFRLbHhqQmhqVFZ5T3A2Vkg2aDhJeUIzeCtZM0NXazZCdWNJWUV1QmIzb0Qy?=
 =?utf-8?B?TmRnU3lRTWlEalY2T2k1TVlVQ1owenh6MWxHRGk1T3FVWEI0TGdVYk93bS9o?=
 =?utf-8?B?N1dzUCtZeG5SdkJla1p5WmMwT2hua1Q0Uk1iUnU0SFBxOGcxUFBGcURaUi93?=
 =?utf-8?B?MEQ3QUR1d2t1b0x5NGdSSit1ZloyRXpuNms3MndyOG1RNEk2Z0poempqeVZx?=
 =?utf-8?B?L0xOaU9iSG4vWmQ2TFFYbGtBTzFZT2I0aFN2NFlINkl6ek8rV0JISUZFSGlJ?=
 =?utf-8?B?dWFZRHIya0xnb3l2WFJtVjBzVS96RCtNTUpFV0ZKOVJVWGN4SUVlbk52MmJj?=
 =?utf-8?B?SklsbzNpdFRvN1NyM05EUnBXV2ZSU2JGazhjdzRhNkwwdEFqamVwdndHcTZL?=
 =?utf-8?B?MFVoRVNHVXdGWi9qN21qMk1lOGliZUp4ejhxb00rRjhHT045VVZMREZvOVMx?=
 =?utf-8?B?UmhBV2tPU2kxUzQrcFY1US91Qy9VNHpWTXFvTHNxRi94VXRJdWcwcXNZMzJC?=
 =?utf-8?B?RHVPOUhkR1YydHIzcU9zbmJOVnJ6aGVoNEp2ZXJmRXZoK3JIUTlmQk1UZjVE?=
 =?utf-8?B?dGQwTjUvT3BFYmQ5aFVzM29qQ004VlczTTdtdjArMG5lZmJLYVBFZmVZSjNE?=
 =?utf-8?B?STdlYTliWVVLNEFhRlJFNWF1SzF0bWM5OStHbC9Jbkh0VEt1NC9wVVJzNU5O?=
 =?utf-8?B?Y3E1eE5uZ3VxcDQvQ1dQdC9FQUdOMVJlUERzdEpmQ3RzVTNOUW9mYTFHRFR5?=
 =?utf-8?B?bEJxSjhvRmxVZlNZKzJJSzI5MDNBQVJ6T2FDRlRZZ2xKMVZ1Q09zTzB6NCs0?=
 =?utf-8?B?SE9JWk5ycUEyd3o0dzMvNkd0NHhtMGI1dG9WZWh3RnZjRlNRcURjSDVmMHEw?=
 =?utf-8?B?Sk94S1hQbGxhK0VlQkZ1R2wyaThhdi9oZFhwNTJ0OWNPeGlMa1VncEZlRkFv?=
 =?utf-8?B?Zmp4Y0FvcnkwZUhxQWVOa3V5TXRBWEY1Vkd0c21OTFdoc0MrM1VFQnJLZU9j?=
 =?utf-8?B?SE40QzVZNGh4M2dYZDRqV0VlamVVUWpIN2JLQzVrdENQZnJQM09ycDVEamtv?=
 =?utf-8?B?Y3JmWVhlN2dPSEZ0OHVtcjI0WTNNMHNERlU2QWdWcytndGJjdDNDQ29obWY3?=
 =?utf-8?B?eGExaHIxRkVlbitSRHUyTGJtUGwyaVppb1dTUjUyMFlvRkN3c1VJa1JkUjFN?=
 =?utf-8?B?WnZnYmwwSXhXR0hyZTB3Q1liR0diZVBzTEk2L3VtdnVlNy9GNWFBa0FYYlUv?=
 =?utf-8?B?OS83NkRPcHBEbk03TnlVRFpXbWoycDBIOU80TEdaWFRlck1EOGhsUWUrVHN1?=
 =?utf-8?B?M1R1dWFHMjlDRG5zeWNHcVZxVXVjb0I4VXJkNlMrWHpITC91M0QzOVh0eDF1?=
 =?utf-8?B?Z0tCaE1rK1RmK3dUbjFwWnd1TVVsUFV5dEIySXo0TkU0djFmRkdtQUFvNlE1?=
 =?utf-8?B?c0VrR2MrNmM3UnVESzIrVGtyWUN1eE0wb3gwQVhWRXVVT3hCcUplNkpHZTBY?=
 =?utf-8?B?Qkxid0t2WXFWU1NXUVhzbk13aWxmanNEZnBFd2RiM0VZWnJBVzFTdE56MDQr?=
 =?utf-8?B?SlFEbE1lL1J2a2hEWUFVbFNkYVVpSy95VGFEL3YveDRDRUR4L1BwaDNaTGJx?=
 =?utf-8?B?bmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d7cefe0-0770-4174-0587-08da7a298939
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1899.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 17:06:44.3622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qXEH+5XF2eaj8eKpqkmShtbrlY1S91ZkwQ0o4gWRJp/LGwwpWg3V+ghA0nBhNjq3CnfrLbTJ6S8BrM2by5zLlqWWwRGk3SuAKTRqRtNHyyw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1435
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/6/22 18:37, Tianfei Zhang wrote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>
> This patch adds support for regmap APIs that are intended to be used by
> the drivers of some devices which support generic indirect register access,
> for example PMCI (Platform Management Control Interface) device, HSSI
> (High Speed Serial Interface) device in FPGA.
>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
> ---
>  drivers/base/regmap/Kconfig                   |   3 +
>  drivers/base/regmap/Makefile                  |   1 +
>  .../base/regmap/regmap-indirect-register.c    | 133 ++++++++++++++++++
>  include/linux/regmap.h                        |  12 ++
>  4 files changed, 149 insertions(+)
>  create mode 100644 drivers/base/regmap/regmap-indirect-register.c
>
> diff --git a/drivers/base/regmap/Kconfig b/drivers/base/regmap/Kconfig
> index 159bac6c5046..4ea590604f8d 100644
> --- a/drivers/base/regmap/Kconfig
> +++ b/drivers/base/regmap/Kconfig
> @@ -65,3 +65,6 @@ config REGMAP_I3C
>  config REGMAP_SPI_AVMM
>  	tristate
>  	depends on SPI
> +
> +config REGMAP_INDIRECT_REGISTER
> +	tristate
> diff --git a/drivers/base/regmap/Makefile b/drivers/base/regmap/Makefile
> index 11facb32a027..504a32b79d8c 100644
> --- a/drivers/base/regmap/Makefile
> +++ b/drivers/base/regmap/Makefile
> @@ -20,3 +20,4 @@ obj-$(CONFIG_REGMAP_SCCB) += regmap-sccb.o
>  obj-$(CONFIG_REGMAP_I3C) += regmap-i3c.o
>  obj-$(CONFIG_REGMAP_SPI_AVMM) += regmap-spi-avmm.o
>  obj-$(CONFIG_REGMAP_MDIO) += regmap-mdio.o
> +obj-$(CONFIG_REGMAP_INDIRECT_REGISTER) += regmap-indirect-register.o
> diff --git a/drivers/base/regmap/regmap-indirect-register.c b/drivers/base/regmap/regmap-indirect-register.c
> new file mode 100644
> index 000000000000..0b748e48bd87
> --- /dev/null
> +++ b/drivers/base/regmap/regmap-indirect-register.c
> @@ -0,0 +1,133 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Indirect Register Access.
> +//
> +// Copyright (C) 2022 Intel Corporation, Inc.
> +
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +
> +#define INDIRECT_CMD_OFF	0x0
> +#define INDIRECT_CMD_RD	BIT(0)
> +#define INDIRECT_CMD_WR	BIT(1)
> +#define INDIRECT_CMD_ACK	BIT(2)
> +
> +#define INDIRECT_ADDR_OFF	0x4
> +#define INDIRECT_RD_OFF	0x8
> +#define INDIRECT_WR_OFF	0xc
> +
> +#define INDIRECT_INT_US	1
> +#define INDIRECT_TIMEOUT_US	10000
> +
> +struct indirect_ctx {
> +	void __iomem *base;
> +	struct device *dev;
> +};
> +
> +static int indirect_bus_clr_cmd(struct indirect_ctx *ctx)
> +{
> +	unsigned int cmd;
> +	int ret;
> +
> +	writel(0, ctx->base + INDIRECT_CMD_OFF);
> +	ret = readl_poll_timeout((ctx->base + INDIRECT_CMD_OFF), cmd,
> +				 (!cmd), INDIRECT_INT_US, INDIRECT_TIMEOUT_US);
> +	if (ret)
> +		dev_err(ctx->dev, "%s timed out on clearing cmd 0x%xn", __func__, cmd);
The line-return in the above dev_err() is missing a forward slash: \n

- Russ
> +
> +	return ret;
> +}
> +
> +static int indirect_bus_reg_read(void *context, unsigned int reg,
> +				 unsigned int *val)
> +{
> +	struct indirect_ctx *ctx = context;
> +	unsigned int cmd;
> +	int ret;
> +
> +	cmd = readl(ctx->base + INDIRECT_CMD_OFF);
> +	if (cmd)
> +		dev_warn(ctx->dev, "%s non-zero cmd 0x%x\n", __func__, cmd);
> +
> +	writel(reg, ctx->base + INDIRECT_ADDR_OFF);
> +	writel(INDIRECT_CMD_RD, ctx->base + INDIRECT_CMD_OFF);
> +	ret = readl_poll_timeout((ctx->base + INDIRECT_CMD_OFF), cmd,
> +				 (cmd & INDIRECT_CMD_ACK), INDIRECT_INT_US,
> +				 INDIRECT_TIMEOUT_US);
> +	if (ret) {
> +		dev_err(ctx->dev, "%s timed out on reg 0x%x cmd 0x%x\n", __func__, reg, cmd);
> +		goto out;
> +	}
> +
> +	*val = readl(ctx->base + INDIRECT_RD_OFF);
> +
> +	if (indirect_bus_clr_cmd(ctx))
> +		ret = -ETIMEDOUT;
> +
> +out:
> +	return ret;
> +}
> +
> +static int indirect_bus_reg_write(void *context, unsigned int reg,
> +				  unsigned int val)
> +{
> +	struct indirect_ctx *ctx = context;
> +	unsigned int cmd;
> +	int ret;
> +
> +	cmd = readl(ctx->base + INDIRECT_CMD_OFF);
> +	if (cmd)
> +		dev_warn(ctx->dev, "%s non-zero cmd 0x%x\n", __func__, cmd);
> +
> +	writel(val, ctx->base + INDIRECT_WR_OFF);
> +	writel(reg, ctx->base + INDIRECT_ADDR_OFF);
> +	writel(INDIRECT_CMD_WR, ctx->base + INDIRECT_CMD_OFF);
> +	ret = readl_poll_timeout((ctx->base + INDIRECT_CMD_OFF), cmd,
> +				 (cmd & INDIRECT_CMD_ACK), INDIRECT_INT_US,
> +				 INDIRECT_TIMEOUT_US);
> +	if (ret) {
> +		dev_err(ctx->dev, "%s timed out on reg 0x%x cmd 0x%x\n", __func__, reg, cmd);
> +		goto out;
> +	}
> +
> +	if (indirect_bus_clr_cmd(ctx))
> +		ret = -ETIMEDOUT;
> +
> +out:
> +	return ret;
> +}
> +
> +static const struct regmap_bus indirect_bus = {
> +	.reg_write = indirect_bus_reg_write,
> +	.reg_read =  indirect_bus_reg_read,
> +};
> +
> +/**
> + * devm_regmap_init_indirect_register - create a regmap for indirect register access
> + * @dev: device creating the regmap
> + * @base: __iomem point to base of memory with mailbox
> + * @cfg: regmap_config describing interface
> + *
> + * Return: 0 on success, negative error code otherwise.
> + */
> +struct regmap *devm_regmap_init_indirect_register(struct device *dev,
> +						  void __iomem *base,
> +						  struct regmap_config *cfg)
> +{
> +	struct indirect_ctx *ctx;
> +
> +	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
> +	if (!ctx)
> +		return NULL;
> +
> +	ctx->base = base;
> +	ctx->dev = dev;
> +
> +	return devm_regmap_init(dev, &indirect_bus, ctx, cfg);
> +}
> +EXPORT_SYMBOL_GPL(devm_regmap_init_indirect_register);
> +
> +MODULE_DESCRIPTION("Indirect Register Access");
> +MODULE_AUTHOR("Intel Corporation");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/regmap.h b/include/linux/regmap.h
> index de81a94d7b30..72eb38883e88 100644
> --- a/include/linux/regmap.h
> +++ b/include/linux/regmap.h
> @@ -670,6 +670,18 @@ struct regmap *__devm_regmap_init_spi_avmm(struct spi_device *spi,
>  					   const struct regmap_config *config,
>  					   struct lock_class_key *lock_key,
>  					   const char *lock_name);
> +/**
> + * devm_regmap_init_indirect_register - create a regmap for indirect register access
> + * @dev: device creating the regmap
> + * @base: __iomem point to base of memory with mailbox
> + * @cfg: regmap_config describing interface
> + *
> + * Return: 0 on success, negative error code otherwise.
> + */
> +struct regmap *devm_regmap_init_indirect_register(struct device *dev,
> +						  void __iomem *base,
> +						  struct regmap_config *cfg);
> +
>  /*
>   * Wrapper for regmap_init macros to include a unique lockdep key and name
>   * for each call. No-op if CONFIG_LOCKDEP is not set.

