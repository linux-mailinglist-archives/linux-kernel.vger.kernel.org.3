Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 266B159C1EB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 16:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235111AbiHVOwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 10:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbiHVOv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 10:51:59 -0400
Received: from esa4.hc3370-68.iphmx.com (esa4.hc3370-68.iphmx.com [216.71.155.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C907637FB3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 07:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1661179917;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=K3hZ9p0WYC2wVpatN7hYEI+hHQvx/y40Ku+AJV0lefQ=;
  b=L/jKloBf2F0JxiYClhbv4RHF51SzhJCS/ySL+hoG0GsFR0otP6kpKal+
   4MMEHTz6CEbdbISSze77cDc2GsZAZWqPSZTLnGeULzsjmQhssXwzxR/RT
   N9Qr3AEk59q9oi0zPwLKB/vK40OrkFunwNlDv+qzXGak1mnSijAAe+g6J
   8=;
X-IronPort-RemoteIP: 104.47.59.173
X-IronPort-MID: 81168878
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:d8YoQKs6WfbXQsA21m6yVrdz9OfnVN5fMUV32f8akzHdYApBsoF/q
 tZmKWrQPfqOMGf8LosjO4W08E4EupXcxoU3SgZqpS4wRipD+JbJXdiXEBz9bniYRiHhoOOLz
 Cm8hv3odp1coqr0/0/1WlTZhSAgk/vOHtIQMcacUghpXwhoVSw9vhxqnu89k+ZAjMOwRgiAo
 rsemeWGULOe82MyYzl8B56r8ks15qyi4mlA5DTSWNgQ1LPgvyhNZH4gDfnZw0vQGuF8AuO8T
 uDf+7C1lkuxE8AFU47Nfh7TKyXmc5aKVeS8oiM+t5uK23CukhcawKcjXMfwXG8M49m/c3Kd/
 /0W3XC4YV9B0qQhA43xWTEAe811FfUuFLMqvRFTGCFcpqHLWyKE/hlgMK05FZdC3v5MEGx1y
 adCJwoqNECRrMzs7r3uH4GAhux7RCXqFKU2nyg6iB38U7MhS52FRLjW79hF2jt2ntpJAfvVe
 8seb3xocQjEZBpMfFwQDfrSns/x3iW5L2Ie9QPT/PVsi4TQ5FUZPLzFGdzZYNGVA+5SmV6Vv
 Dnu9GXlGBAKcteYzFJp91r837aRzXOkCOr+EpW56NBQx0W2nFY4GQQfT1TghuunsG2xDoc3x
 0s8v3BGQbIJ3FSmUtTnTTW5pnCetxIRUtYWFPc1gCmOw6yS5weQAGcsSj9HdcxgtckqSDhs3
 ViM9/vgDjlimKeYRXKU6vGfqjbaESwUK3ISICwJVw0I5/H9r4wpyBHCVNBuFOiylNKdMTj0z
 iCDqiQznfMIjc8Q16a6+3jDgjSxtt7ISBI44kPcWWfNxgp6TIqkYZG4r1nd8ftEao2eSzGpv
 nkNncaT6u9IApiKvC2LXOgJWrqu4p643Cb0hFduG9wt8mqr8nv6J4RIumghfwFuL9oOfiLvb
 AnLowRN6ZRPPXysK6hqf4a2DMdsxq/lfTj4as3pghN1SsAZXGe6EOtGPCZ8A0iFfJAQrJwC
IronPort-HdrOrdr: A9a23:NMKyZ6pDWsEH04uhyBVlG7YaV5uIL9V00zEX/kB9WHVpm5Oj+v
 xGzc5w6farsl0ssSkb6Ku90KnpewK+yXbsibNhcItKLzOWwldAS7sSobcKogeQUREWk9Qw6U
 4OSdkYNDSdNzlHZIPBkXGF+rUbsZa6GcKT9IHjJh5WJGkEBZ2IrT0JczpzeXcGJjWucKBJcK
 Z0kfA3wgZIF052Uu2LQl0+G8TTrdzCk5zrJTQcAQQ81QWIhTS0rJbnDhmxxH4lInJy6IZn1V
 KAvx3y562lvf3+4ATbzXXv45Nfn8ak4sdfBfaLltMeJlzX+0aVjcVaKv6/VQIO0aSSAWUR4Z
 3xStAbToNOAkbqDyOISN3Wqk/dOXgVmibfIBSj8AbeSITCNU4H4ox69Mxkm1LimjQdVJsX6t
 M140uJ85VQFh/OhyL7+pzBUAxrjFO9pT44nfcUlGE3a/pWVFZ9l/1pwKpuKuZ3IAvqrIQ8VO
 V+BsDV4/hbNVuccnDCp2FqhNihRG46EBuKSlUL/pX96UkcoFlpi08DgMAPlHYJ85wwD5FC+u
 TfK6xt0LVDVNUfY65xDPoIBcG3FmvOSxTRN3/6GyWuKIgXf3bW75Ln6rQ84++nPJQO0ZspgZ
 zEFEhVsGYjEnieffFmHKc7hywlbF/NLQgFkPsulqSRkoeMN4bDIGmEVE0kldemrrEWHtDbMs
 zDSq5rPw==
X-IronPort-AV: E=Sophos;i="5.93,255,1654574400"; 
   d="scan'208";a="81168878"
Received: from mail-dm6nam12lp2173.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.173])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Aug 2022 10:51:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TLnpY+rJ/KNnqXTfUFl+DKA/N4BPGJe6IFh9IZXZTXG4cXDSyMZ9Yji2jn2CL5Nqh0/KFtg8+RajsWDYZDLAnwQBJleEWTj7DzpYvCLMDpAUgAz67b1lX/rPMOBIrrXBAa8BzmW+bl2jR0nwkpmE80dgLvAfcww0XdSQcYtgIBdnk3HkbTXULNzMTpdQRQ198KVltSElQqY5GKY4Qff4NWkUGbynbiK+7wbBdYc7otOTV2K7TxMmMH/xglMLSUODeQwnLUPWfOvSROqfj2ML4ETQARuBSqZacmXqdFe4wWcYN/dXXTyQ4o5CBIUzAzwvv1IJeCyvQAmbf41EJXiy0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K3hZ9p0WYC2wVpatN7hYEI+hHQvx/y40Ku+AJV0lefQ=;
 b=UNyzOC4k9Im2u9joNH4LBY2R7z0qZRUZJ4xvFa5ghJlPEcLceMhb/g6BeY6YVd/RbxXeVtsHHwvHjoc/MsmcRIaVdl020nkXFsUqqQRdgAabaEXmYHTqIyWwisK32RwmnM8ud1qTcpyTv1qJTpswMLiLrofOx399BuqkMlOKFVXmzKtlEr2sFpbZZcI7XZzaKH4cXNDsUxqdO5xL0vxD+3b9hh9ILx4lQYu4KXaHMmRMuphLmaslyGCOQcyDqRtQs6Z3whboepFhRMPiLzGsZRiWv2uapeU/26NrzKE/4QeCmwNt+qQjNMFG0/JDwp30ckwcCsQcWV9365qqqHVovg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K3hZ9p0WYC2wVpatN7hYEI+hHQvx/y40Ku+AJV0lefQ=;
 b=UI/B4jpW3ydqQDKapSQxXXUguACcYluxu0QsFc4/Y7151LtusJrl9xnWfgcSB5aeXrWIicJ2Gs7vCfQ8V2t+Y/KEXFwJIGAMUSWMZSZQ7hrE9gzJTJkAb9eEyKoR/ydq1GiLfC6y4Xlpwh/KuP5pkshHaGFPKw0Pc6pYwn6up8s=
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by MW4PR03MB6668.namprd03.prod.outlook.com (2603:10b6:303:123::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.19; Mon, 22 Aug
 2022 14:51:52 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::b9c9:c866:817c:60dd]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::b9c9:c866:817c:60dd%4]) with mapi id 15.20.5546.022; Mon, 22 Aug 2022
 14:51:52 +0000
From:   Andrew Cooper <Andrew.Cooper3@citrix.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        "Liang, Kan" <kan.liang@linux.intel.com>
CC:     "acme@redhat.com" <acme@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        Jianfeng Gao <jianfeng.gao@intel.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>
Subject: Re: [RESEND PATCH] perf/x86/intel: Fix unchecked MSR access error for
 Alder Lake N
Thread-Topic: [RESEND PATCH] perf/x86/intel: Fix unchecked MSR access error
 for Alder Lake N
Thread-Index: AQHYtjUKeLNr1GxFEEKNk49r/4qW7q27AQMA
Date:   Mon, 22 Aug 2022 14:51:52 +0000
Message-ID: <67900295-0f6c-51be-2daa-eb39eb6c5ef4@citrix.com>
References: <20220818181530.2355034-1-kan.liang@linux.intel.com>
 <Yv+ggf6PRjL8Eio1@worktop.programming.kicks-ass.net>
 <80eea4f7-bb1e-ebb9-37db-9317b8d9c28f@linux.intel.com>
 <YwOVJO05Ge8V9y5i@worktop.programming.kicks-ass.net>
In-Reply-To: <YwOVJO05Ge8V9y5i@worktop.programming.kicks-ass.net>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 07424b5e-fabf-4d8f-ee2a-08da844dd998
x-ms-traffictypediagnostic: MW4PR03MB6668:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l8VfbsDZHguhjEaS75VbrjL8wzSut9JayvpC9ybR2+wa5csAPDCU47aBtP2a7nMI9n5EwSU+JV4uPoPVj0GYVPk2LNXYixijkt0kkU0k+YrzqPHd3HHeTZPVI2OgD6teLFXizRmY6aYLzUK8SN5DvtLLLliy2uedmbOvh0xvwK+UJKGDoUP6+c2i+Ap5CqCLo2NlCOGYSY/rlsMrNWV3XrYwue877VazDXlUzbFEAjcbVKBUX4WbsTIP9cUCFEs/YgeiMlzAWraCeXhkfsPQA4oqdW0cNnglutmxBRPlnCGPlUxcl8iEkw/2uLtCRNWhWyaE83Ux/4mnTvzSaWykAwHmY4pHvS5xTQH6n1ac+k+oh8OSuDBhGvtUHz/9uHffxgn1NzcCwbpG0em+2VcT0mTxccecuwAe6guqdQa9lBmtNalcUHc8dkG1SQOAYtdpCiZ4iThZPZE8TqJ13PcLG+b79uBsLAfxKvnoRMYCZhNRjQECh6O3Vs6gCTokiitaNE69uHUOuf2CaVIfZKsO1BeImhrS5qRWT0l78VdOKHpwBvwDj0MROzEEz8HuL0FJMoszNxPrtEapsp3gK52y316eNgv7yITP8y/bZf+lPR0DEUe4tGW/e4aXqCjp0ZDIJLmVM9Sk2d56JFPPz2VNQGGbxMOyAU1U+G6oSaZCtXzLlc/PMm93Kzek6GpnYLfJcS3Ak6Y9Lnf+ek4PFfEXRUF4Xcvfg9Jt4PSwETuZUYs2qm/xp1d910F8YcYlDMbILfgnOLel15jWcbqdnhYtH7aEkj73Uc15hw8L0jyHbJPWvhWY7zXzH4/tTZdl2LEYzso31DcPgkFwdGiLNOdZMA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(346002)(39860400002)(136003)(366004)(41300700001)(66946007)(6486002)(71200400001)(91956017)(76116006)(107886003)(110136005)(316002)(478600001)(4326008)(64756008)(66476007)(8676002)(31686004)(8936002)(2906002)(36756003)(66446008)(66556008)(54906003)(26005)(38070700005)(53546011)(6512007)(2616005)(86362001)(31696002)(186003)(6506007)(122000001)(5660300002)(83380400001)(38100700002)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UzA1MllDaS9Yb2ZCOUNRWlI0R282UkxUNjZKVnJKNW9xdXZMREhud0p3Nnpx?=
 =?utf-8?B?ZXpoMkozVXB2N2l0NEMzdlROWVhCcXJWNmdIMlI3VTdHTHJyV3Y3R3pIRmFK?=
 =?utf-8?B?ZDhPdlZhcFJ1OU5Xd3hLSDlNN1QxRG9Rc2lzRGlZN3pvZ1J5OFJWeVRsUm9J?=
 =?utf-8?B?TE9hQStYS0E2SFAyVDZZa1hib0ZXcm00c29TSTNtRHFJSkNXNnVLeWJleHY1?=
 =?utf-8?B?bndtS1F6djkrOHJrM3NQUDRxak1RWHRQdDE3ZGxlVkdCZmJWLzlGaksxakts?=
 =?utf-8?B?RnBnUUtJcDdOQUYvU1Mvd05uKzdobVJ1Yy9iR2ZuNEpGampkQXU2dFRqYm5m?=
 =?utf-8?B?cXZQYkNscXpBdzFVK29KYjJoTEpnZ09Bd0o5RzVCdDZGMklGQWpWQXc4NGYy?=
 =?utf-8?B?dkNHSVdTTlZUZ2plb0F3a1FRakdDSEJ2dllyMkZwd3VJdVVuL09MVklmUGNW?=
 =?utf-8?B?aCtRQkorZW5maGNMYURyOG5TdmlHc05hOU5HQXViTG5hRUJSeFNNZy9jdDZy?=
 =?utf-8?B?TnJPaVZ4TElrN2NRZXdWNVhFaEJXUDFIV1FXWXgyYS9oaklSUmRaNGxobWE3?=
 =?utf-8?B?SGRqbndhY1Z0amtHMWRXT1BIY0wrdTdKbHZCQlI2SXJLVXI2S0dXdXZCdyti?=
 =?utf-8?B?WlFwcEoxVVR5RzVPdWh3ZGFhM1lzU3RpYlN2VUhxYzlOcE41ckQ5RVlGQ1JD?=
 =?utf-8?B?dURxblNCdmRKb09TQ0k2eThleDFmTjlRUGRwV3hKZEYvaS9EbzZvdEc4bm8z?=
 =?utf-8?B?bzFHTXoyNndPdTdvdFBKV1p5blN3RHBaSkVhbWFFUUxZQVpvcVBQb0VDSGpp?=
 =?utf-8?B?SGtyYVlIM0kxVEtQeVR1aFQvd2x2Z3BEQ1R5UmgyWVI5MnZ5WGlhT2ZITjJi?=
 =?utf-8?B?V09wbWFiOFhKY2h5R2JvWGZ4NG9sM3ZmNEhVS3VSSm5nalcyUFg2SmRORGJj?=
 =?utf-8?B?WkkvWWd3UkFJTGlPek9ZRmNocG5LdHBua2RURVVOcmdoSG9IOHcyODRwSVo0?=
 =?utf-8?B?aVM2UmZtV1pYbmJmTVNER2dRY2RyYU5zK2ZDRmZxalJMdUZ1VDlGN1oyL1Jv?=
 =?utf-8?B?RzBSTHJlRkZEQ0V3U1Nmc1hEaGVjYVg0dFFNNmh4SkRwZHI3a054ZFBQWXYv?=
 =?utf-8?B?UlhzcHlXZFF1WFlBNjZRWWVtcnlxakMxK3hsaTAwVm0rU0lMdTlIVEN2aElv?=
 =?utf-8?B?MnRBVG5QL2VlZHhMeHBLRDFqRTMzMjdCbkZialdsYnFoM3l1WEM4ai9sak9S?=
 =?utf-8?B?blc1anl0NEdkdUFsVUZpM0tlV2FvWElFVnRndnFPVGtiMmdsTjdGaVk3a2gx?=
 =?utf-8?B?TU1sQlFxOUdyTmpxUVc0eXRzVTlFM3NSbzJxaFFJV0xOa3pScG5qMjhuVjc1?=
 =?utf-8?B?eG1nWGNPVkFrUWZsU2lmZTZ6bmV0NkNYNlFTY204dGRQckVUT3RYQ3laZkJ2?=
 =?utf-8?B?cVNKZmF4Zkh2N0Z4djd0eXRZaTRMbnEzL1l5NmZyWVlvS0QwZXZLMmFHOEtN?=
 =?utf-8?B?QnlVdFFaOUFMaktVZ1QvYmFSU2xSNWwzOTM2aTdBaGlnOE41b1RhWVNtdmRa?=
 =?utf-8?B?Y3R5N1c0VU80QW50MWV6VTR2ZGYwOFgrRzY4YzJ0Rk1PNDhobTZIMGphUmdK?=
 =?utf-8?B?R3p2WFJCY0tCTk1Yc3oxVkxhZUhWWjY2S3hxTjlrQ1hpZ251ci84V0ZwbXMr?=
 =?utf-8?B?bnJ0TDdOci9mWnJvd09KWmY2aVhRaVZxSWtqVGQ4TFpsTDRTOGNqYUNwbm12?=
 =?utf-8?B?aW8vSXNHUWlHWThxQnpuMEVLWnBodFFieHRQZEN5L0REdFZJTVFZRktnQi9j?=
 =?utf-8?B?L2dGN3lsZENHd0VLcnhJa0x6NzMxSGlPc3U3OUxjcVZyNVVMeTFEK3FXb1Iy?=
 =?utf-8?B?elAzR0NTMTZmUHVrQTRqU0FpN0xrQ2FBblhmY2VwQlAzL0Q3R0s3clVHVlJS?=
 =?utf-8?B?bkorWTdJbVViT09oRjdCcGJJbmNlZmNzMFlpekJiQUxnOWhsVldyeWJ4RjFu?=
 =?utf-8?B?YlUyUjVTM2pYendFckloY2lJWnVLaFVDcXZtOWFPVjNoT1pETzVWMFRsc1pN?=
 =?utf-8?B?cmVmdytJVUxxakZ4dDF4dW5lcHdZdmVuL2V5NnM3R1RoSVg3M0pjNzZnMmNR?=
 =?utf-8?Q?luTpU6nN1dKf0mVxhHYdz9oMk?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4456A4103510834CBAE4C06D8CF39A49@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07424b5e-fabf-4d8f-ee2a-08da844dd998
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 14:51:52.3904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6wTeV1j/B6mOtxABP21Q1UIpZj95J1qs4NgTtDgGgyTIguB+YMh6g1r7aMoA/L2jYp6t9jpxaUmIkxWY9DC46WM15B4rDIqTaN1bQytnMHI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6668
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjIvMDgvMjAyMiAxNTozOSwgUGV0ZXIgWmlqbHN0cmEgd3JvdGU6DQo+IE9uIE1vbiwgQXVn
IDIyLCAyMDIyIGF0IDA5OjI4OjMxQU0gLTA0MDAsIExpYW5nLCBLYW4gd3JvdGU6DQo+Pg0KPj4g
T24gMjAyMi0wOC0xOSAxMDozOCBhLm0uLCBQZXRlciBaaWpsc3RyYSB3cm90ZToNCj4+PiBPbiBU
aHUsIEF1ZyAxOCwgMjAyMiBhdCAxMToxNTozMEFNIC0wNzAwLCBrYW4ubGlhbmdAbGludXguaW50
ZWwuY29tIHdyb3RlOg0KPj4+PiBGcm9tOiBLYW4gTGlhbmcgPGthbi5saWFuZ0BsaW51eC5pbnRl
bC5jb20+DQo+Pj4+DQo+Pj4+IEZvciBzb21lIEFsZGVyIExha2UgTiBtYWNoaW5lLCB0aGUgYmVs
b3cgdW5jaGVja2VkIE1TUiBhY2Nlc3MgZXJyb3IgbWF5IGJlDQo+Pj4+IHRyaWdnZXJlZC4NCj4+
Pj4NCj4+Pj4gWyAwLjA4ODAxN10gcmN1OiBIaWVyYXJjaGljYWwgU1JDVSBpbXBsZW1lbnRhdGlv
bi4NCj4+Pj4gWyAwLjA4ODAxN10gdW5jaGVja2VkIE1TUiBhY2Nlc3MgZXJyb3I6IFdSTVNSIHRv
IDB4MzhmICh0cmllZCB0byB3cml0ZQ0KPj4+PiAweDAwMDEwMDBmMDAwMDAwM2YpIGF0IHJJUDog
MHhmZmZmZmZmZmI1Njg0ZGU4IChuYXRpdmVfd3JpdGVfbXNyKzB4OC8weDMwKQ0KPj4+PiBbIDAu
MDg4MDE3XSBDYWxsIFRyYWNlOg0KPj4+PiBbIDAuMDg4MDE3XSA8VEFTSz4NCj4+Pj4gWyAwLjA4
ODAxN10gX19pbnRlbF9wbXVfZW5hYmxlX2FsbC5jb25zdHByb3AuNDYrMHg0YS8weGEwDQo+Pj4g
RldJVywgSSBzZWVtIHRvIGdldCB0aGUgc2FtZSBlcnJvciB3aGVuIGJvb3RpbmcgS1ZNIG9uIG15
IEFETC4gSSdtDQo+Pj4gZmFpcmx5IHN1cmUgdGhlIHdob2xlIENQVUlEIHZzIHZDUFUgdGhpbmcg
aXMgYSB0cmFpbndyZWNrLg0KPj4gV2Ugd2lsbCBlbmhhbmNlIHRoZSBDUFVJRCB0byBhZGRyZXNz
IHRoZSBpc3N1ZXMuIEhvcGVmdWxseSwgd2UgY2FuIGhhdmUNCj4+IHRoZW0gc3VwcG9ydGVkIGlu
IHRoZSBuZXh0IGdlbmVyYXRpb24uDQo+Pg0KPiBIb3cgYWJvdXQgdGhpcz8NCg0KTEdUTS4NCg0K
SXQncyBub3QgZXZlbiBqdXN0IHVhcmNoIHByb2JsZW1zLsKgIFRoZXJlIGFyZSBhcmNoIHByb2Js
ZW1zIHRvbywgbGlrZQ0KdGhlIGZhY3QgdGhhdCBQIGFuZCBFIGNvcmVzIGRpc2FncmVlIG9uIGxp
bmVhciB2cyBlZmZlY3RpdmUgYWRkcmVzc2VzLA0KbnVtYmVyIG9mIGNvdW50ZXJzLCBldGMuDQoN
Cn5BbmRyZXcNCg==
