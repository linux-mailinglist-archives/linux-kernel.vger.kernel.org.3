Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2660349D8C3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 04:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbiA0DEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 22:04:08 -0500
Received: from mga12.intel.com ([192.55.52.136]:39731 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229668AbiA0DEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 22:04:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643252646; x=1674788646;
  h=message-id:date:subject:references:to:cc:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YE5w5PnJn8cayenNpXXIeCy24wGFOPWeRxwCCP3XDR0=;
  b=eaIaxGI7ai4Uqd8TR7AKYu8K0ZoDitpe8wkkwFxoG41ZC7MNH8vaGI5x
   sSleqoqPxyZsREZfnuom6TLZwBC7xizjJi94H6S+xtM36dbYFP2/5VpCo
   sgAD6hNaGr1xlCDpG29clU4kLVqGMc/t5cpa6suwKee9BiGfdj7lCWNmK
   cavSZqO0ZWyPCV97wkcL6erWRPpZK6KwhylbonXoXHyig55t+dUN3l9Rs
   DAh6ubpK09jm1FKX4lGRgDqVKRcaUPFTiXP1ogCa39AKDswgfo38RzE7c
   SI/rDbcg0y0hhWAUI5mxqH7DpbOxhE4BnGeJngmfwbec19vs7YblCMYN1
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="226708812"
X-IronPort-AV: E=Sophos;i="5.88,319,1635231600"; 
   d="scan'208";a="226708812"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 19:04:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,319,1635231600"; 
   d="scan'208";a="696475700"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 26 Jan 2022 19:04:05 -0800
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 26 Jan 2022 19:04:05 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Wed, 26 Jan 2022 19:04:05 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.44) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Wed, 26 Jan 2022 19:04:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OHzW68kcDzd8JIGHqy6wGk30m+EWOJ6sFNn2HPzPglJPm/2zOum59iVtwdFlrztUyi8DDQL4E+lwHY0xlTwr3HmbaItv6XKCbe5CiKDYztQrQzR7UOiE5y1qgJKxNaTBgeHkJirsAR8OvAvbm6GgtzDeq8EENv3W0JroUxoPYmr0YV6YK17ualVq6QOnuS8wSfPO5e/WDsDJy0As6qttZXlhUIffsYiQ/aY0uT1telnRGSNAL7143I5Tap0SqI41vjB7c6DiuGf/RflCrNTpKuP4yBFA3Xt6stGBp+Gs9fqtRVRmD1MEkTL1UV4WQ0aK+ZNeYcwZ1f1r5HVjFYpobA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gHFaqG8YuRABkMf18EiinC5Dec2DgZbT+evqJcQqUVs=;
 b=l4sRRJsQBN20RzBRa4Cq9ysCZC9DUITr7dwXLT7oZvO565exEDiCiirqieUlXzxjjsZ+eh+X9TfpSgpx6e5PAWR7xuQzayZ434rHNB0a194Cl3/AlvX1JEvxfQm64NpxY3WkmOOKXK26wgfSowsZ/CI0YbWo4rsAgWtThfTlOYZOZiT9EOyiBKGRUMskFJmMVjMDeiSE71clvrZ4pYPSgj+ECiK1QcUaKh/K0Ul8HABGysVx93lmxZykr5sz8RE+n+ILOd/dMSN3YsUjH/ua2nzFtma4Zktfq1G4l+UT2HrIC+fZJTH6ILBnYoTpM8v0jNxMGyWApw1x4b4YgRyciA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com (2603:10b6:a03:304::12)
 by BL1PR11MB5255.namprd11.prod.outlook.com (2603:10b6:208:31a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Thu, 27 Jan
 2022 03:04:00 +0000
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::c4a2:d11d:cb7b:dc8d]) by SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::c4a2:d11d:cb7b:dc8d%6]) with mapi id 15.20.4930.017; Thu, 27 Jan 2022
 03:04:00 +0000
Message-ID: <69bcc1c1-5690-1d23-e811-4a7393a76c27@intel.com>
Date:   Thu, 27 Jan 2022 11:03:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.1
Subject: drivers/misc/habanalabs/common/command_buffer.c:472:24: warning:
 Assigned value is garbage or undefined
 [clang-analyzer-core.uninitialized.Assign]
References: <202201242342.1CK6hoP8-lkp@intel.com>
Content-Language: en-US
To:     farah kassabri <fkassabri@habana.ai>
CC:     <llvm@lists.linux.dev>, <kbuild-all@lists.01.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Oded Gabbay <ogabbay@kernel.org>
From:   kernel test robot <yujie.liu@intel.com>
In-Reply-To: <202201242342.1CK6hoP8-lkp@intel.com>
X-Forwarded-Message-Id: <202201242342.1CK6hoP8-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0362.namprd03.prod.outlook.com
 (2603:10b6:408:f7::7) To SJ0PR11MB5598.namprd11.prod.outlook.com
 (2603:10b6:a03:304::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b8a0eda-1741-4fa2-a064-08d9e141aad5
X-MS-TrafficTypeDiagnostic: BL1PR11MB5255:EE_
X-Microsoft-Antispam-PRVS: <BL1PR11MB5255F847298E95D117B880A7FB219@BL1PR11MB5255.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:46;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /NkHMfC6mcJND2nd7SoPM61SE+LWOvqOEUBB98EXDsFfxnoADx1r1R1gctXjVHMGUzoW0sofku2ne2qy93AVuZMdQtLwA9SKhB1IfXNKnXu3nP3lO9u52HrCRgR99irtY/MgqXwT8qA0uayypNMyx6QFx6viPi1OuwwRNMLaKdQ9Ci6E9Ej+8rMo3NIrBbEFQha5GgGMiOJxeLosOkRNxQtO7Po0a0/qvnDJKWDesEqCvP0AV0l/RFWid5OkvOobI5oMRAJd7JPjVFMmxVpMS/2gZfsF8sl9PDGZeSN9vJizeBeMbf23g/oRGo6azSnqvGrBbjWEQA+KV7ryUxLi8nH3aV82n0OsHtTgfCAWyHEDFnZVZRCwFiFlKbO2FAmsZf8FaTkFt8Uo/qzYarNzxFW9rnsPGYZ7atiPCfNPWuHzrs5XYtjFuZkFw6fxyetylP1fTBSGFQ4jMBPE/l0XNlzIwCuCVTfyQdlQpZNrclFvXeZd7+qUBt9OvEWBDwx6ZrDi2Z/KV1dGR9vUbLei3s+6TrZyQBP51L/+tM6+o8Kuf+XMHa/4bCaD5eBa3z0HpC4/1GR5JOzSuXH7vl5YQt3A9mngRZuTSLeyYRUq2TVGdDJcoRleTwADzcnXxVAdihxsWQV3Ev+WwvPq0tF0wvgp3cvX7nB/GV5N9GePXYifMf2XQbpFrvQa+mvyX/7Gsfx4hrmNGsXl4Fwi4GVITsDS7b3fDfzv3r5wePkSA9ceAJfY0VIH2z2Y7tyKRo8UDxwK2vN7qvBLhe+ov7TfxSX3VfK7JceiAdI0bPUE0VsamBK7Qm30jr3kCDxlW6Zp9kYjZkm35ieCi5ez8785GzGblqQ0u+y5190eFAWmr60=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5598.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(36756003)(4326008)(82960400001)(8936002)(66556008)(66476007)(54906003)(6916009)(316002)(6506007)(66946007)(8676002)(38100700002)(6666004)(31686004)(6486002)(31696002)(86362001)(6512007)(508600001)(83380400001)(966005)(186003)(26005)(2906002)(2616005)(45980500001)(43740500002)(20210929001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z290WmVCbXBXdXYrVjEzcFd4R243M3R3NDZnVm04TzBTeUVSUEk3bnk2OW9D?=
 =?utf-8?B?VUtqY1hZQ1pKNjMzVUNFR3NzUGQyTlU0SlRtMkQ3ZDRWUlVsVkU1UUJkMXBO?=
 =?utf-8?B?UFBMVWpTVWgzUkplbGt6bDNYWXBnR3RPK211M2loRGowWDVZcjJaV3l1RXVO?=
 =?utf-8?B?R1VZcE1NWVJOTDIzS01OWkNPWVBINElaUEtUKytWaUNnaEdNeWxIQUF3dDdn?=
 =?utf-8?B?a2JRMXpOQ1BBY3lMMVFqNE9SR3dpaFBhc05URE85WVI1M3M4aFpEYlhFYy9x?=
 =?utf-8?B?dTQzcHhadE9aQUpEQ1pucS9OMmM0R0FaN3ExVW92NnRsTjFiYlh1RkdwQ0RD?=
 =?utf-8?B?cmloTVpvaXl0TC9zVm1sUFBQTVVVb1hJT1g5KzBRZHowMFZrUm9FTWRCNEVJ?=
 =?utf-8?B?Mk44bnd5Z1hKWjFxL21PaHdvNnJwdnQwZS8ramdodG9WZUN4UytDSkdhSE5G?=
 =?utf-8?B?ZDZzeWlHVGxDRm4vMEdGQlYwQnBiMUVVM0ZheGVPRkhCVXcrNnQyR2NKbENG?=
 =?utf-8?B?VXIrSEJCTjVvU3I2Q25ESlZybGgrb2NtbG9CUUFUY3BjYUl2L2VxNlRwZGtE?=
 =?utf-8?B?amNLVWx1cWcxOVNCcHp3VS9QTUJoQVFYZEYyRUZKdkwveWE4M2lWTDFNMzU5?=
 =?utf-8?B?SXU2N2ZEdkdCQmgrSnpxS1ZoWC9hTzd2ZFdEWTYyRGVOVWp4UmRGdjJxQndk?=
 =?utf-8?B?OUd6d2FhMmdONVVWMjY0SU10SDRITFcxYVVCUCtkS0swZlBpRTVwSE82dzE2?=
 =?utf-8?B?UGNQbmtmNVhKa20xdVNqTThuMjNrbzNxemxoVDl4VTQzZURBZnl6SUQrVWNU?=
 =?utf-8?B?NnpOTURUWTlCTW1EcGRuUzNGVmtOMnJLbXVuUmVrVjlsSWdrVmpUa3ZlSWFZ?=
 =?utf-8?B?ZUg4ejRHeitEbU9GZUQ4MUFIZFRuNmY2bDQ3ekhSMzgwUzA3ZmJ5Zm1TL0tJ?=
 =?utf-8?B?RkYrK0FKZzFKZkNVT3l5WUh0VnFmTnFzZWZSMkYxVEZwbU12MVRhdXREOVNL?=
 =?utf-8?B?Q1dhTm8xMUhJWkwyckpJaXc0cFpnRGpib2tidjUrb0pwRy82VndWZzZZSUVI?=
 =?utf-8?B?RTNvWHNDUVE1dkhTTm1ORXljbXo5TGVjV0tySWEzQzB4eTN4N3NDVVc3OEhz?=
 =?utf-8?B?VGpWL2xZQkRRQ2xUMHNuS2U4QldJd2tiaXJBKzRpeXJPQ3JxcFdscFRXeHk1?=
 =?utf-8?B?dlBEQ3lEVHhMYUpTaDNkcnFRMFVKMXplN2UvdWpVUXpLSmpobzZ2UGlQbWpX?=
 =?utf-8?B?eXhTV3FrYk1JczJFRGFCRjFNdWNhQ3BWeks4RDJwWDJ1ZGt1c3F3ZGdhaHlH?=
 =?utf-8?B?alJHQnpaMy9BSEpjTE4vUTcwNVFSK1c4MllqZUJxcm84UDIvUFRDaW5OcVdD?=
 =?utf-8?B?UnExYm15TTlzZVNwdFpYRnhPV0FwdnJlejZQMlZVQmdTejRvMktEV2JEelRV?=
 =?utf-8?B?TmxJOVQ4OE0wamx1MmkyRG5YblRqMmJXVDJMQjFuVGh6QTBmQXFNdGRMRUZP?=
 =?utf-8?B?VXQ4RzJ0em1Dbm9wdVhTY0N0YzFqZng4Z05LUlk3UzhWT0ZCSVdHNi85TTJz?=
 =?utf-8?B?bURyaVhHZWxVN3p0Q0hqYnJVcW8zWUV1T243djUrcVFQQVM4MHNtSE15TFBl?=
 =?utf-8?B?Rm10d2kwdThoL2g4eHB5RHlUWGpwMWdlUzJTdGY1K2FkTllldFpiU0d3cjkr?=
 =?utf-8?B?RlFxYVpucHF4T01aVlhnQWZxTmlHY05yY3psZ0RFRGk2S0plQUVySzlINFR2?=
 =?utf-8?B?VTBDUjJkMWdUblg4ZlFWVzAxNThkTCtsNmdzR21iSVZIN0owRDJXRnFZUmZL?=
 =?utf-8?B?ZkdqR1V5dy9SSTZFY2ZGdCtqVWc1YS8xNnoyYVpVamppVzV2N2pEZm9HOVh2?=
 =?utf-8?B?NFAwb2NEMTgyb2d1V1ZLRlYrV2hjemVUajYyVEJSdWwrbnNqKzVxNExlWFA1?=
 =?utf-8?B?b1BRZnJuSHdOaWtMOS9qd01iOG9tT1F2NkFiTHdvU0FnamhUQ3MyVTZ5T3Ux?=
 =?utf-8?B?dTIrWWlTOGwwTjVWZTRpR2NZVnh2aUc1WHN0WE04YkR5aU5wTlRSTEZuWHd4?=
 =?utf-8?B?QUJrY1EwUGRSMHBhQ2xsWTcrcjMvbWdDM3FJaXl5Y3JVdERuc1czOU5QRWZT?=
 =?utf-8?B?OWZrQzB6bXlCbjgyVnJIVDg4MWk2RzJqci9uMjFBRmJrUy96ZkIyZ3VHc3Z6?=
 =?utf-8?Q?0vjgqm/1Q0oEXCLP8fE48Zc=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b8a0eda-1741-4fa2-a064-08d9e141aad5
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5598.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 03:04:00.7242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hwEKoWhvf6SOjX874k/PX2Y7QcJnXHduxr0bBnAOdDZqZ0DPv4MknbDu6paZ52/hrqBMWSqH4lr99p91yh57nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5255
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dd81e1c7d5fb126e5fbc5c9e334d7b3ec29a16a0
commit: b9d31cada7d9f137028c11534fff77fec8511690 habanalabs: change wait_for_interrupt implementation
date:   4 weeks ago
config: riscv-randconfig-c006-20220124 (https://download.01.org/0day-ci/archive/20220124/202201242342.1CK6hoP8-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 9006bf424847bf91f0a624ffc27ad165c7b804c4)
reproduce (this is a W=1 build):
         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
         chmod +x ~/bin/make.cross
         # install riscv cross compiling tool for clang build
         # apt-get install binutils-riscv64-linux-gnu
         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b9d31cada7d9f137028c11534fff77fec8511690
         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
         git fetch --no-tags linus master
         git checkout b9d31cada7d9f137028c11534fff77fec8511690
         # save the config file to linux build tree
         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=riscv clang-analyzer

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


clang-analyzer warnings: (new ones prefixed by >>)

 >> drivers/misc/habanalabs/common/command_buffer.c:472:24: warning: Assigned value is garbage or undefined [clang-analyzer-core.uninitialized.Assign]
                            args->out.device_va = device_va;
                                                ^ ~~~~~~~~~
    drivers/misc/habanalabs/common/command_buffer.c:429:18: note: 'device_va' declared without an initial value
            u64 handle = 0, device_va;
                            ^~~~~~~~~
    drivers/misc/habanalabs/common/command_buffer.c:464:8: note: Calling 'hl_cb_info'
                    rc = hl_cb_info(hdev, &hpriv->cb_mgr, args->in.cb_handle,
                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    drivers/misc/habanalabs/common/command_buffer.c:399:6: note: Assuming 'cb' is null
            if (!cb) {
                ^~~
    drivers/misc/habanalabs/common/command_buffer.c:399:2: note: Taking true branch
            if (!cb) {
            ^
    drivers/misc/habanalabs/common/command_buffer.c:400:3: note: Loop condition is false.  Exiting loop
                    dev_err(hdev->dev,
                    ^
    drivers/misc/habanalabs/common/command_buffer.c:403:3: note: Control jumps to line 420
                    goto out;
                    ^
    drivers/misc/habanalabs/common/command_buffer.c:421:2: note: Returning without writing to '*device_va'
            return rc;
            ^
    drivers/misc/habanalabs/common/command_buffer.c:464:8: note: Returning from 'hl_cb_info'
                    rc = hl_cb_info(hdev, &hpriv->cb_mgr, args->in.cb_handle,
                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    drivers/misc/habanalabs/common/command_buffer.c:471:7: note: Assuming the condition is true
                    if (args->in.flags & HL_CB_FLAGS_GET_DEVICE_VA)
                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    drivers/misc/habanalabs/common/command_buffer.c:471:3: note: Taking true branch
                    if (args->in.flags & HL_CB_FLAGS_GET_DEVICE_VA)
                    ^
    drivers/misc/habanalabs/common/command_buffer.c:472:24: note: Assigned value is garbage or undefined
                            args->out.device_va = device_va;
                                                ^ ~~~~~~~~~

vim +472 drivers/misc/habanalabs/common/command_buffer.c

f44afb5b5a5d04 drivers/misc/habanalabs/common/command_buffer.c Tomer Tayar    2020-09-02  423
be5d926b5c1043 drivers/misc/habanalabs/command_buffer.c        Oded Gabbay    2019-02-16  424  int hl_cb_ioctl(struct hl_fpriv *hpriv, void *data)
be5d926b5c1043 drivers/misc/habanalabs/command_buffer.c        Oded Gabbay    2019-02-16  425  {
be5d926b5c1043 drivers/misc/habanalabs/command_buffer.c        Oded Gabbay    2019-02-16  426  	union hl_cb_args *args = data;
be5d926b5c1043 drivers/misc/habanalabs/command_buffer.c        Oded Gabbay    2019-02-16  427  	struct hl_device *hdev = hpriv->hdev;
66a76401c50b26 drivers/misc/habanalabs/common/command_buffer.c Ofir Bitton    2020-10-05  428  	enum hl_device_status status;
b9d31cada7d9f1 drivers/misc/habanalabs/common/command_buffer.c farah kassabri 2021-11-02  429  	u64 handle = 0, device_va;
f44afb5b5a5d04 drivers/misc/habanalabs/common/command_buffer.c Tomer Tayar    2020-09-02  430  	u32 usage_cnt = 0;
be5d926b5c1043 drivers/misc/habanalabs/command_buffer.c        Oded Gabbay    2019-02-16  431  	int rc;
be5d926b5c1043 drivers/misc/habanalabs/command_buffer.c        Oded Gabbay    2019-02-16  432
66a76401c50b26 drivers/misc/habanalabs/common/command_buffer.c Ofir Bitton    2020-10-05  433  	if (!hl_device_operational(hdev, &status)) {
3f5398cfbf051d drivers/misc/habanalabs/command_buffer.c        Oded Gabbay    2019-04-06  434  		dev_warn_ratelimited(hdev->dev,
3f5398cfbf051d drivers/misc/habanalabs/command_buffer.c        Oded Gabbay    2019-04-06  435  			"Device is %s. Can't execute CB IOCTL\n",
66a76401c50b26 drivers/misc/habanalabs/common/command_buffer.c Ofir Bitton    2020-10-05  436  			hdev->status[status]);
3f5398cfbf051d drivers/misc/habanalabs/command_buffer.c        Oded Gabbay    2019-04-06  437  		return -EBUSY;
3f5398cfbf051d drivers/misc/habanalabs/command_buffer.c        Oded Gabbay    2019-04-06  438  	}
3f5398cfbf051d drivers/misc/habanalabs/command_buffer.c        Oded Gabbay    2019-04-06  439
be5d926b5c1043 drivers/misc/habanalabs/command_buffer.c        Oded Gabbay    2019-02-16  440  	switch (args->in.op) {
be5d926b5c1043 drivers/misc/habanalabs/command_buffer.c        Oded Gabbay    2019-02-16  441  	case HL_CB_OP_CREATE:
39b425170d35ff drivers/misc/habanalabs/command_buffer.c        Oded Gabbay    2020-04-17  442  		if (args->in.cb_size > HL_MAX_CB_SIZE) {
39b425170d35ff drivers/misc/habanalabs/command_buffer.c        Oded Gabbay    2020-04-17  443  			dev_err(hdev->dev,
39b425170d35ff drivers/misc/habanalabs/command_buffer.c        Oded Gabbay    2020-04-17  444  				"User requested CB size %d must be less than %d\n",
39b425170d35ff drivers/misc/habanalabs/command_buffer.c        Oded Gabbay    2020-04-17  445  				args->in.cb_size, HL_MAX_CB_SIZE);
39b425170d35ff drivers/misc/habanalabs/command_buffer.c        Oded Gabbay    2020-04-17  446  			rc = -EINVAL;
39b425170d35ff drivers/misc/habanalabs/command_buffer.c        Oded Gabbay    2020-04-17  447  		} else {
fa8641a14f2841 drivers/misc/habanalabs/common/command_buffer.c Tomer Tayar    2020-09-07  448  			rc = hl_cb_create(hdev, &hpriv->cb_mgr, hpriv->ctx,
ef6a0f6caa4a5d drivers/misc/habanalabs/common/command_buffer.c Tomer Tayar    2020-07-09  449  					args->in.cb_size, false,
ef6a0f6caa4a5d drivers/misc/habanalabs/common/command_buffer.c Tomer Tayar    2020-07-09  450  					!!(args->in.flags & HL_CB_FLAGS_MAP),
ef6a0f6caa4a5d drivers/misc/habanalabs/common/command_buffer.c Tomer Tayar    2020-07-09  451  					&handle);
39b425170d35ff drivers/misc/habanalabs/command_buffer.c        Oded Gabbay    2020-04-17  452  		}
39b425170d35ff drivers/misc/habanalabs/command_buffer.c        Oded Gabbay    2020-04-17  453
be5d926b5c1043 drivers/misc/habanalabs/command_buffer.c        Oded Gabbay    2019-02-16  454  		memset(args, 0, sizeof(*args));
be5d926b5c1043 drivers/misc/habanalabs/command_buffer.c        Oded Gabbay    2019-02-16  455  		args->out.cb_handle = handle;
be5d926b5c1043 drivers/misc/habanalabs/command_buffer.c        Oded Gabbay    2019-02-16  456  		break;
39b425170d35ff drivers/misc/habanalabs/command_buffer.c        Oded Gabbay    2020-04-17  457
be5d926b5c1043 drivers/misc/habanalabs/command_buffer.c        Oded Gabbay    2019-02-16  458  	case HL_CB_OP_DESTROY:
be5d926b5c1043 drivers/misc/habanalabs/command_buffer.c        Oded Gabbay    2019-02-16  459  		rc = hl_cb_destroy(hdev, &hpriv->cb_mgr,
be5d926b5c1043 drivers/misc/habanalabs/command_buffer.c        Oded Gabbay    2019-02-16  460  					args->in.cb_handle);
be5d926b5c1043 drivers/misc/habanalabs/command_buffer.c        Oded Gabbay    2019-02-16  461  		break;
39b425170d35ff drivers/misc/habanalabs/command_buffer.c        Oded Gabbay    2020-04-17  462
f44afb5b5a5d04 drivers/misc/habanalabs/common/command_buffer.c Tomer Tayar    2020-09-02  463  	case HL_CB_OP_INFO:
f44afb5b5a5d04 drivers/misc/habanalabs/common/command_buffer.c Tomer Tayar    2020-09-02  464  		rc = hl_cb_info(hdev, &hpriv->cb_mgr, args->in.cb_handle,
b9d31cada7d9f1 drivers/misc/habanalabs/common/command_buffer.c farah kassabri 2021-11-02  465  				args->in.flags,
b9d31cada7d9f1 drivers/misc/habanalabs/common/command_buffer.c farah kassabri 2021-11-02  466  				&usage_cnt,
b9d31cada7d9f1 drivers/misc/habanalabs/common/command_buffer.c farah kassabri 2021-11-02  467  				&device_va);
b9d31cada7d9f1 drivers/misc/habanalabs/common/command_buffer.c farah kassabri 2021-11-02  468
b9d31cada7d9f1 drivers/misc/habanalabs/common/command_buffer.c farah kassabri 2021-11-02  469  		memset(&args->out, 0, sizeof(args->out));
b9d31cada7d9f1 drivers/misc/habanalabs/common/command_buffer.c farah kassabri 2021-11-02  470
b9d31cada7d9f1 drivers/misc/habanalabs/common/command_buffer.c farah kassabri 2021-11-02  471  		if (args->in.flags & HL_CB_FLAGS_GET_DEVICE_VA)
b9d31cada7d9f1 drivers/misc/habanalabs/common/command_buffer.c farah kassabri 2021-11-02 @472  			args->out.device_va = device_va;
b9d31cada7d9f1 drivers/misc/habanalabs/common/command_buffer.c farah kassabri 2021-11-02  473  		else
f44afb5b5a5d04 drivers/misc/habanalabs/common/command_buffer.c Tomer Tayar    2020-09-02  474  			args->out.usage_cnt = usage_cnt;
f44afb5b5a5d04 drivers/misc/habanalabs/common/command_buffer.c Tomer Tayar    2020-09-02  475  		break;
f44afb5b5a5d04 drivers/misc/habanalabs/common/command_buffer.c Tomer Tayar    2020-09-02  476
be5d926b5c1043 drivers/misc/habanalabs/command_buffer.c        Oded Gabbay    2019-02-16  477  	default:
be5d926b5c1043 drivers/misc/habanalabs/command_buffer.c        Oded Gabbay    2019-02-16  478  		rc = -ENOTTY;
be5d926b5c1043 drivers/misc/habanalabs/command_buffer.c        Oded Gabbay    2019-02-16  479  		break;
be5d926b5c1043 drivers/misc/habanalabs/command_buffer.c        Oded Gabbay    2019-02-16  480  	}
be5d926b5c1043 drivers/misc/habanalabs/command_buffer.c        Oded Gabbay    2019-02-16  481
be5d926b5c1043 drivers/misc/habanalabs/command_buffer.c        Oded Gabbay    2019-02-16  482  	return rc;
be5d926b5c1043 drivers/misc/habanalabs/command_buffer.c        Oded Gabbay    2019-02-16  483  }
be5d926b5c1043 drivers/misc/habanalabs/command_buffer.c        Oded Gabbay    2019-02-16  484

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
