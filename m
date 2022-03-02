Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE1614CA8FB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 16:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243444AbiCBPYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 10:24:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236652AbiCBPX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 10:23:59 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2051.outbound.protection.outlook.com [40.107.95.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9846E527C0
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 07:23:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ofvG1TjM3GASBnbnZpVdhsojL9hafUyOdYs0nEvO+5gUpbquLbP/McuhxdIkunzqkPJ/GIRXHtRbXjO2UNasVmwjRVU93iAbRSv/CMM9XPUoOcl1sskEje4K0KkB6iCfoQERDUE4waH1XkWle0mKigqLZ+FYhmEcJf4Bwy51AJcv/TM8QVVzyCscaSf//sTJYHUEXdVl/VUPlZOWoTXLQO256d0ECCOzwA7BN2gmCR6b5ZpHvtSdNwYDqaNl4EeWTrn9P/3RB7BODe3sfouusTZemS0dXSrqWm+jEXR1GTQuyHfzl6U4b2tDvy/5tWGAHqLnKqHFGgKVAd3N+6vCLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iYtftxkv8G198spSZH9kRhU5w3RT3qyW5gt0UcWVjf0=;
 b=B8mK/zhoSdyPNqBcy46Hk/iZO5b0Am+9wcvIINVItt3XKcvp6qNm8kuO7Dzjseu8+2nI9YQIHmW16NTXdEw9jm14NvtLbWHAZWpXUiYICQ3I+TLUBzA2xgZUC1CFJNH8yPwI/EMv+NLBUlU6f6wdNL3PB5Kd/Zd3Kw9Ox6V+3x+gzE5f8Mdch26SMF+8dC4eRZa/aXhtHUnSbKcGoe+UmBsE7YmoznolL0EBXEPnP12YvYaFE9ykBJZt9lcbCrqEDXz0d3QblyR9cWKWHFLAlKTCPR7LZaJr747tKBmjFYcBPnxhASGnUO+V4nria+qembIilcBLIspMe9DqpXOBSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=calian.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iYtftxkv8G198spSZH9kRhU5w3RT3qyW5gt0UcWVjf0=;
 b=b/qAXFsPGvHrwoajQ9vkHAmvP/Crrk7u04p1dSK8m4NElUN/fmzfygM43XlwU9rkMqkw7hLMtbuIfWgaNV/TEX7fFnihKDJawMyNx3z3iU+x2pS5N3+z4l3VfPZ1rNqqEJRhgeskuVIv35nVwPNO6YqB2X0lDu7Ykln4++NsYT8=
Received: from DM5PR22CA0008.namprd22.prod.outlook.com (2603:10b6:3:101::18)
 by BN6PR02MB2817.namprd02.prod.outlook.com (2603:10b6:404:fc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 2 Mar
 2022 15:23:13 +0000
Received: from DM3NAM02FT029.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:101:cafe::a0) by DM5PR22CA0008.outlook.office365.com
 (2603:10b6:3:101::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Wed, 2 Mar 2022 15:23:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT029.mail.protection.outlook.com (10.13.4.98) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Wed, 2 Mar 2022 15:23:12 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 2 Mar 2022 07:23:05 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 2 Mar 2022 07:23:05 -0800
Envelope-to: robert.hancock@calian.com,
 lkp@intel.com,
 kbuild-all@lists.01.org,
 linux-kernel@vger.kernel.org,
 maz@kernel.org
Received: from [10.254.241.50] (port=54602)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1nPQoj-000Fm2-N0; Wed, 02 Mar 2022 07:23:05 -0800
Message-ID: <42bb9699-dd87-9e26-30ae-d2d4b4c03b21@xilinx.com>
Date:   Wed, 2 Mar 2022 16:23:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: drivers/irqchip/irq-xilinx-intc.c:127:14: warning: no previous
 prototype for 'xintc_get_irq'
Content-Language: en-US
To:     Robert Hancock <robert.hancock@calian.com>,
        "lkp@intel.com" <lkp@intel.com>
CC:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "maz@kernel.org" <maz@kernel.org>
References: <202203011058.VcuVhghd-lkp@intel.com>
 <f6c6273d66174a2cf86b43c8ed7d5c985f9410dd.camel@calian.com>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <f6c6273d66174a2cf86b43c8ed7d5c985f9410dd.camel@calian.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fca362bb-03cc-42fa-8ee7-08d9fc6090da
X-MS-TrafficTypeDiagnostic: BN6PR02MB2817:EE_
X-Microsoft-Antispam-PRVS: <BN6PR02MB2817DC0369691D3E140B9769C6039@BN6PR02MB2817.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4EwYyaUo3brmagHqZci1H5tFZQ/A5FL1eGMuRPeJQy74i0goZmiHG40hNVShz3yM/aZHoYgbOHezLfc1epl5AoLdCguj6I7GVXeOEhm55U4YFKQZZz5PL0QkFz5CAmXN5HVpmb5s7tbw0ymZj3cisQjyAOnhA4UKgiPdo58XRNQPWIAv8eaLQeoNcOOFcTrjZhVFMzCPtaBZ4BPrAqeEgVCFKLLbaBUZH7cuGQiNMAA0cq5GJL2AoZHtI3Lj/dDPaL3Gj4wtfHGiOy7DRHa4TZ2wM5AsO0i48d8THzKnpOrkodm7TzMsB2BTO83gfcjulNB13xNxQRYAv4HP5E+fWb40eE7G/cwiDQ5oQe6WsYjm574uBwT9EIrvdndsaVZb5ElQvp/yfB2l+FtwjL7atH2LTxVvVgansdm+D4UOAOyOuSeGz/VfSJnCEAReP59y5bezFKmaAD+fUPf8jCtm4i/OccAprflQO1kKP1XNBz6ZN9yKpgcMC35MjeX/6fb37f9GbNcU6OGnMZ7kSN/vIb1ci8fi7OaiSl/Gor2lHberGKlwm/Sf9LhkGDVwrLHhCys6iB0bSv2k6tKCcEJSebjJpUuWdELILzjC0BdpBoQqyrkYQOUHD9P5RRRsu8EIycdPp1dTliMyKDtehakxkZcS/LsAnphkMffDaY2HI/2HFPOieZat8yR/DFhuDUUyvuPj9kVp3Nd1K7sUZQqLNlbw42e2DFZXb4RpQ1a8oal+yz+RMYq/HohAxz45+rA+0Oj6gCcApnrsUCVlgGww6DxxnS6qxIW5/hN2VCefQ6Kff4vVax/CWomtsumUU6GPJ1cJQ3n6HGklW/2g8oaGBQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(186003)(26005)(426003)(336012)(110136005)(40460700003)(53546011)(2906002)(2616005)(82310400004)(36860700001)(31696002)(83380400001)(47076005)(7636003)(356005)(54906003)(44832011)(5660300002)(4326008)(31686004)(70206006)(8936002)(9786002)(966005)(508600001)(36756003)(316002)(70586007)(8676002)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2022 15:23:12.6000
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fca362bb-03cc-42fa-8ee7-08d9fc6090da
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT029.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2817
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,

On 3/1/22 17:34, Robert Hancock wrote:
> On Tue, 2022-03-01 at 12:18 +0800, kernel test robot wrote:
>> Hi Robert,
>>
>> First bad commit (maybe != root cause):
>>
>> tree:
>> https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git__;!!IOGos0k!2JH7Pv3yO6KGoGUAasL6gdyffBveJ7sKR_ufk10CoE_SvRF6pyxPfYs8jFbEg2JhJnk$
>>    master
>> head:   719fce7539cd3e186598e2aed36325fe892150cf
>> commit: debf69cfd4c618c7036a13cc4edd1faf87ce7d53 irqchip/xilinx: Expose
>> Kconfig option for Zynq/ZynqMP
>> date:   10 months ago
>> config: arm64-randconfig-r031-20220227 (
>> https://urldefense.com/v3/__https://download.01.org/0day-ci/archive/20220301/202203011058.VcuVhghd-lkp@intel.com/config__;!!IOGos0k!2JH7Pv3yO6KGoGUAasL6gdyffBveJ7sKR_ufk10CoE_SvRF6pyxPfYs8jFbE3gypuYE$
>>   )
>> compiler: aarch64-linux-gcc (GCC) 11.2.0
>> reproduce (this is a W=1 build):
>>          wget
>> https://urldefense.com/v3/__https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross__;!!IOGos0k!2JH7Pv3yO6KGoGUAasL6gdyffBveJ7sKR_ufk10CoE_SvRF6pyxPfYs8jFbEO8rziu4$
>>    -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          #
>> https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=debf69cfd4c618c7036a13cc4edd1faf87ce7d53__;!!IOGos0k!2JH7Pv3yO6KGoGUAasL6gdyffBveJ7sKR_ufk10CoE_SvRF6pyxPfYs8jFbEPEVofBw$
>>   
>>          git remote add linus
>> https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git__;!!IOGos0k!2JH7Pv3yO6KGoGUAasL6gdyffBveJ7sKR_ufk10CoE_SvRF6pyxPfYs8jFbEg2JhJnk$
>>   
>>          git fetch --no-tags linus master
>>          git checkout debf69cfd4c618c7036a13cc4edd1faf87ce7d53
>>          # save the config file to linux build tree
>>          mkdir build_dir
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross
>> O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/gpu/drm/tegra/
>> drivers/irqchip/
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All warnings (new ones prefixed by >>):
>>
>>>> drivers/irqchip/irq-xilinx-intc.c:127:14: warning: no previous prototype
>>>> for 'xintc_get_irq' [-Wmissing-prototypes]
>>       127 | unsigned int xintc_get_irq(void)
>>           |              ^~~~~~~~~~~~~
>>
> 
> The issue here is that on MicroBlaze, xintc_get_irq is called by do_IRQ in
> arch/microblaze/kernel/irq.c. The function definition it uses for that function
> is in arch/microblaze/include/asm/irq.h which the irqchip driver obviously
> can't include. Possibly the solution is to move that declaration to a non-arch-
> specific header file which can be included in both places.
> 
> I think this would warning have started showing up on aarch64 when the driver
> was allowed to be selected for ZynqMP platforms, but I would assume it was
> there on Microblaze all along..

I solved it in xilinx linux tree by this patch but didn't sent it out yet.

Feel free to take a look at it.
https://github.com/Xilinx/linux-xlnx/commit/731d1aa34bdd78ffcd81b35f1d90d9667451fcf7

Thanks,
Michal


