Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B6451F415
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 08:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234573AbiEIF7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 01:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235146AbiEIF4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 01:56:06 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827C8128176
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 22:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652075533; x=1683611533;
  h=message-id:date:subject:references:from:to:cc:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5qbCqjA5b2qUIodPn1yFP9NCrsudDlIgPbDXUuSxqjo=;
  b=NfKho2XLGAV34/+ENQ+ziITMptBJ1tXoa025y2zDxZzg+JEO3oJ+Uo+3
   0IM9ORTtKEj/GYmFvtHOqRx4GPUwKYAoaH34qmEBDsqEJnIMKzw6fNJXe
   UiHCawwlBzDXros2lUiAoNbTNSP5evK1Q11ywyo0gRkBHivqf9ajaCcAH
   I55qTSPK6hZWgaZKR9a9mqkrTh62c4LGI2PiqpN0VnJak7YZUG8h/0N5A
   GvmHCHFQuhk26HLYf+p9OEybzb65xJzbDJ/2zqlEKKurX82aZVU3U4C6X
   mhc3ilWkjlKzdm9mUozqH5KA+JVVR5EXxD4Nm0SZwQ2+IpsYolW8Wa2AA
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10341"; a="269086189"
X-IronPort-AV: E=Sophos;i="5.91,210,1647327600"; 
   d="scan'208";a="269086189"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2022 22:49:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,210,1647327600"; 
   d="scan'208";a="601795290"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP; 08 May 2022 22:49:57 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sun, 8 May 2022 22:49:57 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Sun, 8 May 2022 22:49:57 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Sun, 8 May 2022 22:49:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kdrCw4+rK2R+nQVVi21zu1uLCVj+NsLpC/r/i7roixlF0SqT4m3uV2kAXu1kOqq6EjXx7+h1WlEckfIrSNNJyvIN4wVlYI0b8Biz5iwhe5hcSvJ/y9XlRc85lAX9hkOJVYWx9KWGNPksXtlrbgPfZQHG28HKztAF0mEkj92y/Pc2Z1zpzbrAjHUBVvHh8DFQ2c0zPKJSPfMdFw3buU1GZIQmnJYKCjxcEVNaco7HMHYTmCN1hx7ZxS2ROI3ghnqkd/IvKfGc/m9zsmzERRylgAqeC/nJXrb+aG3V0cLun9UPg1zvYp9Bg8Fj861t8eynGbF1GUxAuGh/sX7Gd1vQBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HKznUDvMI0NEKq+BJLxyAfnDMRxMxv7wO/P1NV3f250=;
 b=KMtIhNB/0gLD2mcWYMKTU7PyjPS+SQjWhYIwnKi9ec9303Pbkptblo0RVs7oWt+VB/sBDY4rj21ezTWHRfbPfhPLOpaUjc3LntDFdi6hhW6zERAuuEBD9Y1w6mOm4vAWLOvv1gaBTSpd/PiGlkAELNnwCsAb1F6GcrEwHkbyNjXvM80NfUhDKoajJy3IkoMFLxcWOQlX1wRP5Mr+bgK80JZPe1UZmcJAsW5aSvqwmSvp2QGtGaeYvjO9oLvnyHLVPKJDHniqWy4TeTeVSjc+avj59IA2bi1k6f9xhulEVI7rPEnNeMoT7iX8bkhnxb6ePhepB1l8CZ1F2dbcjB/GQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5933.namprd11.prod.outlook.com (2603:10b6:303:16a::15)
 by CY4PR11MB1734.namprd11.prod.outlook.com (2603:10b6:903:125::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Mon, 9 May
 2022 05:49:55 +0000
Received: from MW4PR11MB5933.namprd11.prod.outlook.com
 ([fe80::91fc:35fb:9ebc:81ec]) by MW4PR11MB5933.namprd11.prod.outlook.com
 ([fe80::91fc:35fb:9ebc:81ec%5]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 05:49:54 +0000
Message-ID: <d4052784-255e-8000-8e8e-e5e29108f39a@intel.com>
Date:   Mon, 9 May 2022 13:49:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.0
Subject: [lunn:dsa-ci 22/47] drivers/net/phy/mdio_bus.c:710:9: warning: The
 expression is an uninitialized value. The computed value will also be garbage
 [clang-analyzer-core.uninitialized.Assign]
References: <202205042049.SwDh4zxv-lkp@intel.com>
Content-Language: en-US
From:   kernel test robot <yujie.liu@intel.com>
To:     Andrew Lunn <andrew@lunn.ch>
CC:     <llvm@lists.linux.dev>, <kbuild-all@lists.01.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <202205042049.SwDh4zxv-lkp@intel.com>
X-Forwarded-Message-Id: <202205042049.SwDh4zxv-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK2PR02CA0210.apcprd02.prod.outlook.com
 (2603:1096:201:20::22) To MW4PR11MB5933.namprd11.prod.outlook.com
 (2603:10b6:303:16a::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63000257-7c82-434f-dfd0-08da317fbe18
X-MS-TrafficTypeDiagnostic: CY4PR11MB1734:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <CY4PR11MB1734A73A580358FD94807639FBC69@CY4PR11MB1734.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vp6rKK+YEjCj+/fqq4FHimoV5sHDtVAVoh3PGjRmuBmD7TR2/UQTiib/L2vBAmmK2az8Ny7YlFS7CTqH+aMZANBVhgcjgwjXkTaiq+3lM89byFa1mTb8l6L5n996pdjkE4K4LyN2BfoLGejMfZW0WME4YxTtFdsJMQjnq39swdTRo8Aiv/vlQTOyXU6/l2DHc869xRYOjcio2j+AyEq5fAJ5VSw4n06cD1ZojtLqTuefX9Db65cNjARnadjspHyfTTG7B0Wvf6eGmloNOR+qpjbz/y05jBr2f9HZZ6YIqJqWaFOA7L3vEoJpQYacscd8GMAbAQ+mls9TtCnM/CwZqWFa5uOYixnGBKb0aaMhQroMMvSW8EPLhYIVCUrkjvjlGKSMsorliLuIgEi+bNYoDr5iPFXvQqciBBHFyCXRGoWOnQcdlCh4iSMkgVpyT48GcSRlRXelWrlAEUh7alwhLHVurP70R3vwMLUotmxYbN5RvkUGf4p76nKZSQKLAJBzoRf2RXwTX3nZ4gnWgH1GMbQ30fEtwpsgmLzjndVqLFLGnTFrvUs5DvV0o8S7GEXCbXG4g3rRtQHA7j4mvdhCPPGTLXVkAEmDtssrjl8hBAgJlhQubUsZzSJBC8iTEw5j79nJovoCqA/2we8dfUFlAdmb2cVboJYrXuKUn81iaYXFPWJ5onEGxEkgh/jmtGLB+W2thArIwykn64R3f5YaPMDQetOeFNhyOqMS1Dvrpn3n9K57OpZXsn8TGWtMAWJt/dIINvDOGZpsZ1lCb/T/Fw64Qk7PA7XZICLGB7LPa3RzMWczjJixMqninKNiKUok5ri7obfWjA/on6THsdGB/WmOKGbmRE47a0g683Ko2eI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5933.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(83380400001)(31696002)(2616005)(82960400001)(8936002)(8676002)(66946007)(66556008)(4326008)(66476007)(6916009)(31686004)(38100700002)(30864003)(6512007)(966005)(6486002)(26005)(508600001)(4001150100001)(2906002)(5660300002)(6666004)(186003)(6506007)(86362001)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVh3ZjhDa3FIWEdkRktVWDl3KzVmdnVLajlwYTJDWlVxQ3VsK3FHN0pFajl1?=
 =?utf-8?B?VW9Tc3QvTU5URGJyWFQvRXo3U2lIY1lhSWRPdmhvLzc2VmovU3lrUlF3akF1?=
 =?utf-8?B?SjNEVlRFeUc5MDQrR1pBSm9SS2JWcmhDR1RGSnFUMDVrUi9pMzRZYVYzdVZw?=
 =?utf-8?B?SXgya29jSUtWUUM2U2s0ck1mRVZTcjhveHE2Q0luUTVJczlMY2NOeGlwN3Jv?=
 =?utf-8?B?WW1za0RCN3NQQjJ1eVVhajAxaTNyQjFtMXpEbk93WmNzd1ArUjdyVklEY0xP?=
 =?utf-8?B?aEEydTZYcGF1cTZPZHd3ZzZLRHdSUzA4aUFWcjVhU01sckZIYW5mNE5Sa04y?=
 =?utf-8?B?ZnJSUWwwN1BSRXVlMDVEQ0FOOWFUVVRRV1pMenhVMjc0d1oyNHE1dERzRUFw?=
 =?utf-8?B?TWVWTmpQYkRjVjlISmpQdnhaVnVraUJCNlVJdzhUTjdGZnpIYitIdU1XR2Z3?=
 =?utf-8?B?LytDSXZhMjd2VHFWMmhyZERLamhtaUtqOHErSTEzdm4yeDNGejBseTVNcjNR?=
 =?utf-8?B?T2VGUnRxN0kvWDkyUDlHK3BZQVBYWjdyc0hoZ1BuSm9yQjAvSHIvblFhdU5a?=
 =?utf-8?B?d3BHbzBYSGIyRlh5VnFyc1Izbnl3UjdGb0Y5UGVkMWFCUjF2cTNpRGZZYUw4?=
 =?utf-8?B?VUk2aFJjVVcyekUrampjbHJ5MFR2bkl1NVd6MVZyVCsrTnBkUTVWcTVDVGYx?=
 =?utf-8?B?a3IyT3ZvNk1YMnRseXNkMGl0MGp0VzdhUHVsbUVRVWkwejd5NGtRR25mUEdZ?=
 =?utf-8?B?cGkvL0tYS2draGFqVXovb00zNm9lbTAxeWZmYS9XNENDajhPVk5sUmJDaUFR?=
 =?utf-8?B?MVNQbXZyeHlkV3J6NndxZEFuTHA4dzV4R2xFZ2UrUVEvRkJQajg2eFFuWHhK?=
 =?utf-8?B?SnZEUHk5Y0hQdWNJa1dueG1sazg2aE8xMHBHUGVVWkRYV2xHeGtyUUVmQVM3?=
 =?utf-8?B?YWgyMFE3UnNoOGJVRW0vYjRmbTlVandBWHI5V2lYQnJ0aStiMUplQWQzbW9B?=
 =?utf-8?B?ZytZYXJkSTJRREd6VmlrRXVzR09XTTNySk5RWjdDR1MvNVBLdGpwNjh5S3J6?=
 =?utf-8?B?blZYV1F1ajhaQTBVTEJDTTlIYzlURGdlRHdTc3VBc1FVQzFvSCt1WEdVamw3?=
 =?utf-8?B?U0Q0RUVGc2pCaVF2NFowcVdoanIzcldiVWZxbTVvbHptS1FPemM4TGsxYVM4?=
 =?utf-8?B?bmFFd0I5ZENBbWFyQlc2TDFwUEkxWUZKU2dmNng0dGNPK2h5ZUM0THNsZlk2?=
 =?utf-8?B?cytNRzI3NVBKN0RVT2hpNXpsZFMybE9tZERsUlpUMGhTUkkwLyt4bUVxYlVP?=
 =?utf-8?B?aEdybHE5Z1JIRFVJVE5XRm9EWU5FNzBYMWR4d1pHZmlGaHk3U1pFSnF0cTNm?=
 =?utf-8?B?aHZEVUU1UkhMakM1ZmRoOTJRdnZhQ1dDS3dyMjUxVjVldG1haUR6RzN4a1dK?=
 =?utf-8?B?TjBUMTd1T3grVzQ5MUVETkNUTEkvakVySC9iTlFmczM5cjJqM2hZaHcwa05z?=
 =?utf-8?B?OE5od0pPdW5PMllVbzc2MDFKNUdLWHZGQXFIdzBWK0pkUTNPb0VYQ1ZhYWlY?=
 =?utf-8?B?YzN3NUl2TkhOMnFLaVVYaGdTWXh1amgxQTlqZFIwMEswUnBkdHErMXhFWVA3?=
 =?utf-8?B?djZtbE0yOU5PUlpFTno0YVgzTXRwbWNjWkFVRmpIYkVxWUlGa2lhNzZrUnM4?=
 =?utf-8?B?MzFBams0K29LV0R6cytIcmwyTmN5Sjg4UFEvYzFTelR5K0RqYTIvWXlBNjJB?=
 =?utf-8?B?ZkRyVnZ1eUIzZTYzWFMzb29HcmJZYityVFhabmNKRlFHRHNyREhMYVJtK1Zx?=
 =?utf-8?B?amQxQitwYlBXcXpTYjZ2MTN0emxzcGVOdkFhMzRvU204RWhtOWpYK2pwNnJq?=
 =?utf-8?B?UU9YcXJRWFNnVklkQ0V0anBxdjFGUFk0bCtjbEltOENwZVNKWEhpY2ptQi95?=
 =?utf-8?B?WWZQYkkxN1VkR3hETUx5eDFPSncrMHlBRnR3WkFmUUtycm9xbnlVR0cwdUVL?=
 =?utf-8?B?bHFpb2d5QjlhaW1taHJVUk11U0c2b1EwM2Jwb3FRdlIyamF3TXRwMXFMOFRK?=
 =?utf-8?B?OXpVY1E0N1ZTQVJRVmwzWlcyOGVwa3F2T3M1SldTZTdldCtpYkNWNXZaamNY?=
 =?utf-8?B?RTk2dDFEWmpEV1ZmTE9PaXZBbGRPVVJyYmtzZXRoT3hJbEN4L3V2VzNFN1pv?=
 =?utf-8?B?V1ZkMWhpdHJBYnRaMFdXN0M2enFFdmRZeUhVdDhpU2VlMCtnYVYyTVlTcGx6?=
 =?utf-8?B?aFVSN3BsWUU3MjA3ZnlqT0xLWG9kRnJIL0xlSFNTVmNMR2pzZUJBWUR6WTR1?=
 =?utf-8?B?ZVRnejBnN1pPM2Y1ZkxQd1J5eE9HNWk5Y09PYnNXWTltYy9UTVEwUT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 63000257-7c82-434f-dfd0-08da317fbe18
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5933.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 05:49:54.9223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a2qjcCCumoyjiedGLdY831e2ncatxj4gVmvYSWXEUz3CiE8fFTKmKqnss6Xpx2+GcGCNXkpLJLwdv8V9prl76Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1734
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

tree:   https://github.com/lunn/linux.git dsa-ci
head:   1149273e5c97f04e2255421372a8a30c75c0b842
commit: e582444c20a13a52eabf1d982d1f7e96344be2a8 [22/47] net: mdiobus: Rework scanning of bus ready for quirks
config: i386-randconfig-c001 (https://download.01.org/0day-ci/archive/20220504/202205042049.SwDh4zxv-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 09325d36061e42b495d1f4c7e933e260eac260ed)
reproduce (this is a W=1 build):
         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
         chmod +x ~/bin/make.cross
         # https://github.com/lunn/linux/commit/e582444c20a13a52eabf1d982d1f7e96344be2a8
         git remote add lunn https://github.com/lunn/linux.git
         git fetch --no-tags lunn dsa-ci
         git checkout e582444c20a13a52eabf1d982d1f7e96344be2a8
         # save the config file
         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=i386 clang-analyzer

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <yujie.liu@intel.com>


clang-analyzer warnings: (new ones prefixed by >>)

 >> drivers/net/phy/mdio_bus.c:710:9: warning: The expression is an uninitialized value. The computed value will also be garbage [clang-analyzer-core.uninitialized.Assign]
            while (--i >= 0) {
                   ^ ~
    drivers/net/phy/mdio_bus.c:621:6: note: 'i' declared without an initial value
            int i, err;
                ^

vim +710 drivers/net/phy/mdio_bus.c

4ed8df519849887 Andrew Lunn            2022-04-20  603
b3df0da886ffdb3 Randy Dunlap           2007-03-06  604  /**
59f069789c98678 Russell King           2015-09-25  605   * __mdiobus_register - bring up all the PHYs on a given bus and attach them to bus
b3df0da886ffdb3 Randy Dunlap           2007-03-06  606   * @bus: target mii_bus
59f069789c98678 Russell King           2015-09-25  607   * @owner: module containing bus accessor functions
e13934563db0470 Andy Fleming           2005-08-24  608   *
b3df0da886ffdb3 Randy Dunlap           2007-03-06  609   * Description: Called by a bus driver to bring up all the PHYs
59f069789c98678 Russell King           2015-09-25  610   *   on a given bus, and attach them to the bus. Drivers should use
59f069789c98678 Russell King           2015-09-25  611   *   mdiobus_register() rather than __mdiobus_register() unless they
f89df3f381f1e12 Andrew Lunn            2016-01-06  612   *   need to pass a specific owner module. MDIO devices which are not
fec76125baf7390 Peng Li                2021-03-30  613   *   PHYs will not be brought up by this function. They are expected
f89df3f381f1e12 Andrew Lunn            2016-01-06  614   *   to be explicitly listed in DT and instantiated by of_mdiobus_register().
b3df0da886ffdb3 Randy Dunlap           2007-03-06  615   *
b3df0da886ffdb3 Randy Dunlap           2007-03-06  616   * Returns 0 on success or < 0 on error.
e13934563db0470 Andy Fleming           2005-08-24  617   */
3e3aaf649416988 Russell King           2015-09-24  618  int __mdiobus_register(struct mii_bus *bus, struct module *owner)
e13934563db0470 Andy Fleming           2005-08-24  619  {
711fdba37a3dd7e Andrew Lunn            2016-01-06  620  	struct mdio_device *mdiodev;
161c8d2f50109b4 Krzysztof Halasa       2008-12-25 @621  	int i, err;
69226896ad636b9 Roger Quadros          2017-04-21  622  	struct gpio_desc *gpiod;
e13934563db0470 Andy Fleming           2005-08-24  623
effd7e805c90de8 Andrew Lunn            2022-04-02  624  	if (NULL == bus || NULL == bus->name)
effd7e805c90de8 Andrew Lunn            2022-04-02  625  		return -EINVAL;
effd7e805c90de8 Andrew Lunn            2022-04-02  626
effd7e805c90de8 Andrew Lunn            2022-04-02  627  	if (!bus->read != !bus->write)
effd7e805c90de8 Andrew Lunn            2022-04-02  628  		return -EINVAL;
effd7e805c90de8 Andrew Lunn            2022-04-02  629
effd7e805c90de8 Andrew Lunn            2022-04-02  630  	if (!bus->read_c45 != !bus->write_c45)
effd7e805c90de8 Andrew Lunn            2022-04-02  631  		return -EINVAL;
effd7e805c90de8 Andrew Lunn            2022-04-02  632
effd7e805c90de8 Andrew Lunn            2022-04-02  633  	if (!bus->read && !bus->read_c45)
e13934563db0470 Andy Fleming           2005-08-24  634  		return -EINVAL;
e13934563db0470 Andy Fleming           2005-08-24  635
04f41c68f18886a Saravana Kannan        2021-09-15  636  	if (bus->parent && bus->parent->of_node)
04f41c68f18886a Saravana Kannan        2021-09-15  637  		bus->parent->of_node->fwnode.flags |=
04f41c68f18886a Saravana Kannan        2021-09-15  638  					FWNODE_FLAG_NEEDS_CHILD_BOUND_ON_ADD;
04f41c68f18886a Saravana Kannan        2021-09-15  639
867ae8a7993b26f Florian Fainelli       2021-11-17  640  	WARN(bus->state != MDIOBUS_ALLOCATED &&
867ae8a7993b26f Florian Fainelli       2021-11-17  641  	     bus->state != MDIOBUS_UNREGISTERED,
867ae8a7993b26f Florian Fainelli       2021-11-17  642  	     "%s: not in ALLOCATED or UNREGISTERED state\n", bus->id);
46abc02175b3c24 Lennert Buytenhek      2008-10-08  643
3e3aaf649416988 Russell King           2015-09-24  644  	bus->owner = owner;
46abc02175b3c24 Lennert Buytenhek      2008-10-08  645  	bus->dev.parent = bus->parent;
46abc02175b3c24 Lennert Buytenhek      2008-10-08  646  	bus->dev.class = &mdio_bus_class;
46abc02175b3c24 Lennert Buytenhek      2008-10-08  647  	bus->dev.groups = NULL;
036b66879addb28 Stephen Hemminger      2009-02-26  648  	dev_set_name(&bus->dev, "%s", bus->id);
46abc02175b3c24 Lennert Buytenhek      2008-10-08  649
ca6e11c337daf79 Pavel Skripkin         2021-09-30  650  	/* We need to set state to MDIOBUS_UNREGISTERED to correctly release
ca6e11c337daf79 Pavel Skripkin         2021-09-30  651  	 * the device in mdiobus_free()
ca6e11c337daf79 Pavel Skripkin         2021-09-30  652  	 *
ca6e11c337daf79 Pavel Skripkin         2021-09-30  653  	 * State will be updated later in this function in case of success
ca6e11c337daf79 Pavel Skripkin         2021-09-30  654  	 */
ca6e11c337daf79 Pavel Skripkin         2021-09-30  655  	bus->state = MDIOBUS_UNREGISTERED;
ca6e11c337daf79 Pavel Skripkin         2021-09-30  656
46abc02175b3c24 Lennert Buytenhek      2008-10-08  657  	err = device_register(&bus->dev);
46abc02175b3c24 Lennert Buytenhek      2008-10-08  658  	if (err) {
8d242488ce4627d Joe Perches            2012-06-09  659  		pr_err("mii_bus %s failed to register\n", bus->id);
46abc02175b3c24 Lennert Buytenhek      2008-10-08  660  		return -EINVAL;
46abc02175b3c24 Lennert Buytenhek      2008-10-08  661  	}
46abc02175b3c24 Lennert Buytenhek      2008-10-08  662
d1e7fe4d92742dd Adrian Bunk            2008-02-20  663  	mutex_init(&bus->mdio_lock);
6349084746ff4f5 Michael Walle          2020-05-06  664  	mutex_init(&bus->shared_lock);
d1e7fe4d92742dd Adrian Bunk            2008-02-20  665
e0183b974d3008a Mike Looijmans         2021-02-02  666  	/* assert bus level PHY GPIO reset */
e0183b974d3008a Mike Looijmans         2021-02-02  667  	gpiod = devm_gpiod_get_optional(&bus->dev, "reset", GPIOD_OUT_HIGH);
69226896ad636b9 Roger Quadros          2017-04-21  668  	if (IS_ERR(gpiod)) {
0a12ad592955619 Grygorii Strashko      2020-11-19  669  		err = dev_err_probe(&bus->dev, PTR_ERR(gpiod),
0a12ad592955619 Grygorii Strashko      2020-11-19  670  				    "mii_bus %s couldn't get reset GPIO\n",
69226896ad636b9 Roger Quadros          2017-04-21  671  				    bus->id);
e40e2a2e78664fa Thomas Petazzoni       2019-01-16  672  		device_del(&bus->dev);
0a12ad592955619 Grygorii Strashko      2020-11-19  673  		return err;
fe0e4052fb11d5c Sergei Shtylyov        2017-06-12  674  	} else	if (gpiod) {
d396e84c56047b3 Sergei Shtylyov        2017-06-12  675  		bus->reset_gpiod = gpiod;
6259e0f5478d7a7 Bruno Thomsen          2020-07-30  676  		fsleep(bus->reset_delay_us);
69226896ad636b9 Roger Quadros          2017-04-21  677  		gpiod_set_value_cansleep(gpiod, 0);
bb3831294cd5075 Bruno Thomsen          2020-07-30  678  		if (bus->reset_post_delay_us > 0)
bb3831294cd5075 Bruno Thomsen          2020-07-30  679  			fsleep(bus->reset_post_delay_us);
69226896ad636b9 Roger Quadros          2017-04-21  680  	}
69226896ad636b9 Roger Quadros          2017-04-21  681
c290d1ab12d3385 Florian Fainelli       2020-04-18  682  	if (bus->reset) {
c290d1ab12d3385 Florian Fainelli       2020-04-18  683  		err = bus->reset(bus);
c290d1ab12d3385 Florian Fainelli       2020-04-18  684  		if (err)
c290d1ab12d3385 Florian Fainelli       2020-04-18  685  			goto error_reset_gpiod;
c290d1ab12d3385 Florian Fainelli       2020-04-18  686  	}
df0c8d911abf6ba Florian Fainelli       2017-05-11  687
e582444c20a13a5 Andrew Lunn            2022-04-20  688  	if (bus->probe_capabilities == MDIOBUS_NO_CAP ||
e582444c20a13a5 Andrew Lunn            2022-04-20  689  	    bus->probe_capabilities == MDIOBUS_C22 ||
e582444c20a13a5 Andrew Lunn            2022-04-20  690  	    bus->probe_capabilities == MDIOBUS_C22_C45) {
e582444c20a13a5 Andrew Lunn            2022-04-20  691  		err = mdiobus_scan_bus_c22(bus);
e582444c20a13a5 Andrew Lunn            2022-04-20  692  		if (err)
161c8d2f50109b4 Krzysztof Halasa       2008-12-25  693  			goto error;
161c8d2f50109b4 Krzysztof Halasa       2008-12-25  694  	}
e582444c20a13a5 Andrew Lunn            2022-04-20  695
e582444c20a13a5 Andrew Lunn            2022-04-20  696  	if (bus->probe_capabilities == MDIOBUS_C45 ||
e582444c20a13a5 Andrew Lunn            2022-04-20  697  	    bus->probe_capabilities == MDIOBUS_C22_C45) {
e582444c20a13a5 Andrew Lunn            2022-04-20  698  		err = mdiobus_scan_bus_c45(bus);
e582444c20a13a5 Andrew Lunn            2022-04-20  699  		if (err)
e582444c20a13a5 Andrew Lunn            2022-04-20  700  			goto error;
64b1c2b42b555ef Herbert Valerio Riedel 2006-05-10  701  	}
f896424cbc61225 Matt Porter            2005-11-02  702
d0281a56b00c63a Florian Fainelli       2017-03-28  703  	mdiobus_setup_mdiodev_from_board_info(bus, mdiobus_create_device);
648ea0134069cda Florian Fainelli       2017-02-04  704
e8e5752dc0a56a0 Krzysztof Halasa       2008-12-17  705  	bus->state = MDIOBUS_REGISTERED;
7590fc6f80ac2cb Florian Fainelli       2022-01-03  706  	dev_dbg(&bus->dev, "probed\n");
161c8d2f50109b4 Krzysztof Halasa       2008-12-25  707  	return 0;
e13934563db0470 Andy Fleming           2005-08-24  708
161c8d2f50109b4 Krzysztof Halasa       2008-12-25  709  error:
161c8d2f50109b4 Krzysztof Halasa       2008-12-25 @710  	while (--i >= 0) {
711fdba37a3dd7e Andrew Lunn            2016-01-06  711  		mdiodev = bus->mdio_map[i];
711fdba37a3dd7e Andrew Lunn            2016-01-06  712  		if (!mdiodev)
711fdba37a3dd7e Andrew Lunn            2016-01-06  713  			continue;
711fdba37a3dd7e Andrew Lunn            2016-01-06  714
711fdba37a3dd7e Andrew Lunn            2016-01-06  715  		mdiodev->device_remove(mdiodev);
711fdba37a3dd7e Andrew Lunn            2016-01-06  716  		mdiodev->device_free(mdiodev);
161c8d2f50109b4 Krzysztof Halasa       2008-12-25  717  	}
c290d1ab12d3385 Florian Fainelli       2020-04-18  718  error_reset_gpiod:
69226896ad636b9 Roger Quadros          2017-04-21  719  	/* Put PHYs in RESET to save power */
a010a2f6540ecc3 Florian Fainelli       2017-09-08  720  	if (bus->reset_gpiod)
d396e84c56047b3 Sergei Shtylyov        2017-06-12  721  		gpiod_set_value_cansleep(bus->reset_gpiod, 1);
69226896ad636b9 Roger Quadros          2017-04-21  722
161c8d2f50109b4 Krzysztof Halasa       2008-12-25  723  	device_del(&bus->dev);
4fd5f812c23c7de Lennert Buytenhek      2008-08-26  724  	return err;
4fd5f812c23c7de Lennert Buytenhek      2008-08-26  725  }
3e3aaf649416988 Russell King           2015-09-24  726  EXPORT_SYMBOL(__mdiobus_register);
4fd5f812c23c7de Lennert Buytenhek      2008-08-26  727

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
