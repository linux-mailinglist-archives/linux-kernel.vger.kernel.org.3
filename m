Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDFCA538A49
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 05:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243735AbiEaDyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 23:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238235AbiEaDyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 23:54:02 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB9DB93996
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 20:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653969241; x=1685505241;
  h=message-id:date:to:cc:from:subject:
   content-transfer-encoding:mime-version;
  bh=PVvSgBon64Tdk8v630dDgqo2odeOG0nGMWB/ByA53zA=;
  b=LLPSqMaf46mH0uvpgivyvKuy7JDjaHvJEg2E3QDlmqvz5O9KyFgABf1o
   r/IDB+767OyTiUvFWhlq0IZwKckjkLe1qtLTEzfW7MmW3uHYpSdXzDRa7
   LrACRdGwCqoLVYta092T/8s04hzv2jTo0fu4NlXJ263DEe1ouBva7eHWW
   xHashZIljw4yWLSr2GHiRU8xOo+ycPk7kZpjtuWxcERiCHCC9gUDJ9Iel
   16NoTfk3FIukH8+IGXUcHVzcXSczwpt8/WzcNnI9rmwy7+Q/sdGBkIDUd
   lmBqiLoaLldNo0CYRkSaUzH1XMFQiWr9gDgAjEHqbo+cI7axihD9q/eaF
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10363"; a="275215506"
X-IronPort-AV: E=Sophos;i="5.91,264,1647327600"; 
   d="scan'208";a="275215506"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2022 20:54:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,264,1647327600"; 
   d="scan'208";a="551585572"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga006.jf.intel.com with ESMTP; 30 May 2022 20:54:00 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 30 May 2022 20:53:59 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 30 May 2022 20:53:59 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 30 May 2022 20:53:59 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 30 May 2022 20:53:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R1q75bkz16HJeSDwH39kbyA+V0Ualqto6gm1gNhjPO3oS6XXPy78zqvF94MseZ4AZmchTmCL85cO8+6AXSo2bLrQxNj9csArZLd8EoBr1dAAAKYBgsruHAZBUmA68n4JFVjXqWIliC8MvadSoLzz1OCgJcfia0jSwjcn5rVKS0qRX8p3/1xqnhbuboukru6/o3w3klWfvV5rno7GPkcS6b4vHty/pdX2jZf9nDTRhXE22a2tsUh3WC8K1J3ERInfvszwkxJUICQ52zMGtvfD6BO1/JBnX7CA6n4IfGt/wWnaKd9wkEeoKMhdXEhnutWVXXktT3FaotXHPw5+GOuFHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PVvSgBon64Tdk8v630dDgqo2odeOG0nGMWB/ByA53zA=;
 b=ii7hhs/MzK+n+8LJmb6BBzHSONdlNaNmi4AsIoW3KMW5KOS+R9jLCuxMB4JAntIhR19fzBJoNQoAn02SIAM3nSQNS/GMbS80Wr3tB+XytloaSXpMyoryx/ZqKYuvU4i146NK1edBJugrH2D/iYuLBHwdeucpPgHaNko1ogkI6mGHkSFFWVVCkWW4goB0zJfzAcSOUoIsMkWW0p66S8IhhoTtDCVvW4204k6ytguS3+U3fP1CpEG5/88+toSWexLGaAQ0/vz+2KojGKW39foB3gF9kXPN1vRPY0KlRKTnjFxxSabjoE2/AjngfuUeN9ThF4jg+gvraMzHcjufLzTewA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5933.namprd11.prod.outlook.com (2603:10b6:303:16a::15)
 by DM6PR11MB3452.namprd11.prod.outlook.com (2603:10b6:5:9::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.13; Tue, 31 May 2022 03:53:58 +0000
Received: from MW4PR11MB5933.namprd11.prod.outlook.com
 ([fe80::1169:fc9:c1ef:248e]) by MW4PR11MB5933.namprd11.prod.outlook.com
 ([fe80::1169:fc9:c1ef:248e%9]) with mapi id 15.20.5293.019; Tue, 31 May 2022
 03:53:58 +0000
Message-ID: <d13eec5d-ee87-2207-05a4-1c7732bca4cd@intel.com>
Date:   Tue, 31 May 2022 11:53:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
Content-Language: en-US
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC:     <kbuild-all@lists.01.org>, kernel test robot <lkp@intel.com>,
        <lkp@lists.01.org>, Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>
From:   Yujie Liu <yujie.liu@intel.com>
Subject: [0-Day CI notification] kconfig dependency checking tool (kismet)
 enabled in kernel test robot
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK0PR03CA0119.apcprd03.prod.outlook.com
 (2603:1096:203:b0::35) To MW4PR11MB5933.namprd11.prod.outlook.com
 (2603:10b6:303:16a::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 129caa85-82d6-43ce-e00d-08da42b93087
X-MS-TrafficTypeDiagnostic: DM6PR11MB3452:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM6PR11MB3452007405D8BA8C568EE7E3FBDC9@DM6PR11MB3452.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VO6hvCLGfjEPjlbIJFJ8Iw7Ili1RlGqHBHeg38TdxeNhJqhSD9wvAbaQeDZ3JxIJlfZiHHsY2+o4DnR/H0PjCoI9S36bqfcfmoZJLt6a/B6QKFjNjV0f8qyd8YvM4l7a/VZuhp7nwk7K6mkUYBl9FoCrvGal16SxJR0/Z3feTUept/eXflIiXH5tMqbTd0nRBbP8HM0dFnLusv7U6pYXe13hYHOJ4sD4Y236ynlcIdInJDJRcFbGbFITPEEykCYLX8fhL0Q/rPVXJjEGKxpVGLgdlxfnkHzJktcPyzykdNfM4Wjy9mtt928DiIimrnQhBT9rP3JVAN8T5yMLmSr+sJoLW/DOxVnjqh5snZpbUfuIOFIdEVzV7/1HAahvYDaOGeGIJ9mP/0pjHqBSg1nZySObXu7fFMdH/4KmIHgNxoR6TjIAqdTJfQCuVtuJF0RRgNqGSCKA+IDaI5uoVO8MnrrXMP6vULleQ0UmWyCKREyc5D2UF1YyYQYvNSVOfjYuqd8lajaiQmgFSL9K0oiGA2p6b6rKoG3hC5OntD5MVfZKHff4XAjT8ySdABvmtfycSHqcIrLbi48sDZC0ArKLQhtoUmH2TlKgWU/kSPj5DzEW+ZTxoMuDimMRvjy/MvqLtBnPvWByK8ZuFmvWL85yZgxVPdh8E6Z59//FcL2AWXiSqIUqb1VlOs5IXmAm0WB+izNedm8UgbcaPlAUQrmWVPHEYI20jsUCP7in6Yq1jEqsSZNZrsl8MKrO0igGpqAp+KBmRFtOJqCU89RtsOXknEvY+mrcmZGSiP4YgkCy63Jvj/ml3dMDnDet3qZlsYsFQiWjmccDxMHGr576PhcyRcvfnKmnDYdTwbN+yGdIFNI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5933.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(4744005)(44832011)(5660300002)(8936002)(31696002)(508600001)(6506007)(86362001)(966005)(26005)(6512007)(6666004)(2906002)(82960400001)(66556008)(2616005)(38100700002)(186003)(66946007)(83380400001)(31686004)(316002)(36756003)(4326008)(6916009)(54906003)(8676002)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXViMTMvRjRBS253VU84a1BLQlRlVHF5SThvdndiT1FsZVNVTDh5RGxValVR?=
 =?utf-8?B?Zmliblo0WkIxMnJsVDRvRGN4MW10KzFYUGo2KzFsam1JZnIrWHJ2ZUhrRitK?=
 =?utf-8?B?aHhJMHRLYXU5NUtCTXpCT1dJTjNuTHlZWkJ2dlk2RVRKSEF6ditjNmtUSlpo?=
 =?utf-8?B?QU5ndDhSTHZCbmFjVUpIZUt2bEJNMGNNc3FkRDMxQUZYWjN3MFZQcmpRcmJX?=
 =?utf-8?B?YUhWQzFrcDBEdzFVZm9xTWxYT1RTY2I2cDFNeU9kQ2szUDYxQlN5UkRiSEgx?=
 =?utf-8?B?bVZma05OUkx2VWtXVmNUaWJjNExMKzY0RllQNTMvQXNQc2hPQ1JQUi83WU9N?=
 =?utf-8?B?SzU5WkpuKzI1NkhKd2Q0ejh2b2EwY0cwdlZ0VUNNWTdsb2h6amx1TDMxN3Jj?=
 =?utf-8?B?d0hjcEFzeG8ybWNtV1RLVDBybTlQVjVVeHhHdHJwWmRCTTFPc05na0tHbWwx?=
 =?utf-8?B?VTMyVXVFRTZKNHIyNU9zUlhZMGg4Y25RUGJQWmYxOGtzT2pyRms4b1E0a2FQ?=
 =?utf-8?B?dzlTbWV3VlpYNFcvL1U5SlNaOFJlTzhRNmJVQUo4Ky9GQ2JsdGIyM0J3b3FB?=
 =?utf-8?B?eG01dWV3Z2tKZHN5ZXBReU1HQVNVSWhpeEZ3TGJsZkpnVkppMlM2UlQ1T3Mz?=
 =?utf-8?B?VU5Ld3Fvc1l3MWRIS2ZjaUk4VUIzOHl3ajNUV284V2Y4ZVcwUWVvWDJDdU9s?=
 =?utf-8?B?d3FJM3hrTTZxSG9EQ040TWZUL2VNaFNXWXVoS3d4Mk9qYys2Nm9vYndqL2Zm?=
 =?utf-8?B?bGx2QjRSc3Z5UjQ5RDJuaURnV0VrUHZnUjdad01YM3NyRGlmb3kxbjdrMmRE?=
 =?utf-8?B?dnpzNXpqc1VWUTRaWEVxRUpzRXZqUUt5TEtKMlFUQmdPRnlNWlA0TEY2Q2JQ?=
 =?utf-8?B?em85WU9oRjAvemdFUDJKY3ZXaXMzOGtBaVJSTmlWdElCell2cnVvdGk5RWhR?=
 =?utf-8?B?THd5YTltaHdJL1VOUlZ0SUIvdUsyRzZkZDcyNmZvaTFLdW1oK0I2U1lXNnNL?=
 =?utf-8?B?VndHSENvQlNrb0d4KysvM1RSc0NLOUU4L1RqUXJRTmVWeE1QV1hPcVZBc29z?=
 =?utf-8?B?YmJ6emgzMytqQWlMajFob1k5MXVIYmkrZlcwMzJtaDIwaDJrSU16ZmpxNlRM?=
 =?utf-8?B?cytNdlAzZmRuRlg0NDZSQVFOck9VNEdDNndoRFg2Um9jU0RTQVlQMzR4Qy9n?=
 =?utf-8?B?RmgwSmdseFF1WEVsczR4QkNwaFJiY21tbWhvdUhMMUJ5K2tPL1ZaNUtqZm91?=
 =?utf-8?B?eWJhaXNhc2hQVUplSUxnQWc0YU9aR0Rpa2FSdVpxZVp4eVVhMXpNUS9sb1pH?=
 =?utf-8?B?Q2lJTVYrbVo2M0YvNm5URU01KytJSUE1SjhEQWlEdG9EMHpHeFZ3ZGN4RUhR?=
 =?utf-8?B?Mmx1RHVjVDZkM2F5TXNLbkRwQnVhT1FPWGFUbVZmaFZiTEhEK3R0QUpaM0dj?=
 =?utf-8?B?VXFxL05EQU0ySDZKZUE3emdNUG1Udzl4d1hKS1U3T2NIVHc1aGNUbERTSTVF?=
 =?utf-8?B?R0g0TFg1aEVxNW81SS9PRS9nd1l5YWVEdDJHUnRaVGZxL3NKbUl6Y1FjdkEy?=
 =?utf-8?B?VjlYTUhHNXAxZlg0MGlYN0hoSnpZUmlCU0lHdzM3dENxM1dkeDZ3YVlianRw?=
 =?utf-8?B?dTNFbTFHcWcrZjEydER4ZEI4cDBQZkJiWExGUTJVN0dqc0xWNktsRmN6Q2NC?=
 =?utf-8?B?ZFdUYS9WYlVZODk4cUoyK29ZbENhNTBoRHlFT0NNN3k3Sy9xRVNGWVFGMGJu?=
 =?utf-8?B?eThBMnU5QnR4OFZ1WXJISEZ3Tzh5MVJjMTkyV0gzdUV4aXdmZ0ZldHc5QlNW?=
 =?utf-8?B?aWVOTy8zSHZhamEvNysyamxwQ0FUNS94azVIVVl5dExzUndCR2FleTFqZ285?=
 =?utf-8?B?cTVIOUdtSS94UDlXOWo0U1liTS9OU2N4YmpsVFF3c205U0tRdC9TMWRZVlNR?=
 =?utf-8?B?djkydUUvMER2bWhTVi9yNXRYNWd5WjUrRmI1dmRURDlyejZpOFZzQ0dXRUha?=
 =?utf-8?B?OUpsWGJURmJVK2JXOW5Gc2VHM29Dc0dQZEVSdXZ3L2IzclhxMktCL0ovbnA0?=
 =?utf-8?B?UC9NVGdJRHlLdXhocVArRnFQeW1HWUttZHpnR0hlUUMwM2g2TVRNT0hFb0JC?=
 =?utf-8?B?Mk85UG1YWlcwbktuUnp0WmhpUkRmR05DQm9kaG9tVnlmUU5EcGJ1VFVIWjlI?=
 =?utf-8?B?QURDTDZKUytnMGk1VG9FRE05c3ZnVFFFMHQzWFhxTE1iS0hTNUFKNzI2OU1j?=
 =?utf-8?B?dzdBQjV6QWoxZWQrcTlKeEJSb00rcUM2Z1dlY1NIcnRWeXZKTjFrZmpFRVZR?=
 =?utf-8?B?VXN0WFc1aHM2ck1HZmNCcmMyeExIMlpDUjFVNWg0YyswSlB2czU3b1NEM0pF?=
 =?utf-8?Q?rV8uamVpipxQbVnw=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 129caa85-82d6-43ce-e00d-08da42b93087
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5933.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2022 03:53:57.9609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YAyg9k1uU68gSBIn24DrzCqAbLMz5gmXl722pujFuJRiyl06MpGB6I9M+CUT1K+SuSgzwEjCJU8oWn0yRf9Z9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3452
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all, this is Yujie from 0-Day CI test service. Recently, we have enabled kismet
as a new static analysis tool in the test robot in collaboration with the maintainers
of kismet. This tool will check for unmet dependency bugs in Kconfig specifications
due to reverse dependencies overriding direct dependencies. Here are some examples
of reports we have sent out:

https://lore.kernel.org/lkml/202205212023.U2plpfsA-lkp@intel.com/
https://lore.kernel.org/lkml/202205261808.Ob6yfFnu-lkp@intel.com/
https://lore.kernel.org/lkml/70a880bb-2f7c-c997-113e-247cdd93269d@intel.com/

Kismet is a component of Kmax Tool Suite hosted at https://github.com/paulgazz/kmax.
Thanks to the support from the main developers of this project and the feedback from
all the users. Any suggestions are welcomed to help us improve our test flow and
provide a better service.

Thanks.
