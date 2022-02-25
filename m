Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D524C4137
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 10:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239001AbiBYJXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 04:23:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235990AbiBYJXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 04:23:12 -0500
Received: from esa1.hc3370-68.iphmx.com (esa1.hc3370-68.iphmx.com [216.71.145.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71204FDF98
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 01:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1645780959;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Ov1lMpUy3mz+XYBi+3VQevvNSEvU65+EqTrc8JnQTO8=;
  b=R4gHBVRx+yMNtqyREejy/CCiByxmQ137hVQzT6H0r71UzQG83/4UCQy+
   Bz3ravIQBTRwuNWmaysZYMNV53O/mR9YC1MF18oXjrl9zCOnelsPCxdC1
   zqsnN9fhVoiP472v9CuK4UqqbEEz00aWxG5ybbeIuWRLpGSRezSx+4Uxu
   w=;
Authentication-Results: esa1.hc3370-68.iphmx.com; dkim=pass (signature verified) header.i=@citrix.onmicrosoft.com
X-SBRS: 5.1
X-MesageID: 65386817
X-Ironport-Server: esa1.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.83
X-Policy: $RELAYED
IronPort-Data: A9a23:WB4YUKNob8fg3GvvrR2RkMFynXyQoLVcMsEvi/4bfWQNrUoq3jIGy
 moaXmyAaK2LNzHweYglPYS/9R9S75HVmoQxSwto+SlhQUwRpJueD7x1DKtR0wB+jCHnZBg6h
 ynLQoCYdKjYdleF+lH1dOKJQUBUjclkfJKlYAL/En03FFcMpBsJ00o5wbZj2NMw27BVPivW0
 T/Mi5yHULOa82Yc3lI8s8pvfzs24ZweEBtB1rAPTagjUG32zhH5P7pGTU2FFFPqQ5E8IwKPb
 72rIIdVXI/u10xF5tuNyt4Xe6CRK1LYFVDmZnF+A8BOjvXez8CbP2lS2Pc0MC9qZzu1c99Z1
 9RriI2LGCUQB/f0tvYxYxoHAwU9MvgTkFPHCSDXXc27ykTHdz3nwul0DVFwNoodkgp1KTgQr
 7pCcmlLN03dwbLtqF64YrAEasALBc/nJo4A/FpnyinUF60OSpHfWaTao9Rf2V/cg+gQQK2OO
 ZpANlKDajzHOBpBeQcJDKgbwtj3p3f8XhZRkm2s8P9fD2/7k1UqjemF3MDuUtWOVN5OlwCdp
 2bM4n7/KhAcKNGbjzGC9xqEg+bVnmXhRZ4WHbu03vdwhRuYwWl7IAYfUFqnpv2ng0izXfpQL
 Esb/idopq83nGSuRNT7UgaQu2Ofs1gXSbJ4Guk3+AyMjLHI6hyeGG8FUjlfQNMjvc4yAzct0
 zehmtPoHzVquaG9Sn+H8LqQ6zSoNkA9N2gZeSIIUSMK5N7vpYAoyBXVQb5LFqK4ldToHTfxz
 iqRhCc5gLoXgIgA0KDT1UCX3Rqvq4LPQwpz4R/YNkq94x90fpyNZoqm81HX4P9MaoGDQTGpv
 3UJgMOZ6+MmBpGXkymMXeBLG6umj96HNzTbqVlxEoMt7TWz9maib5JZpjp5IS9BNscCZC+sY
 0LJvw5VzIFcMWHsbqJtZY+1TcMwwsDIF8ziV/XeaddmeJV9dAabuippYCa432Lp1lQrlqUkE
 ZieeMeoS30dDMxaICGeHrlHl+Vxn2ZnmD2VFcuTIwmbPaS2e3+zdKY+YXm3V7oBwrGokAaK4
 /IcOJ7fo/lAa9HWbi7S+I8VCFkFK3knGJz7w/Bqmv6/zhlOQz94VaKIqV81U8k8xvkOyL+Ul
 p2ochIAkDLCaWv7xRJmg5yJQJfmRt5BoH0yJkTA1n74iiF4Me5DAEryHqbbnIXLFsQ/nJaYr
 NFfIq1s58ijrBydqlzxirGn8eRfmOyD317mAsZcSGFXk2RcbwLI4MT4WQDk6TMDCCG63eNn/
 eH9iV+CHcdbH1w6ZCozVB5J5wng1ZT6sLgvN3Yk3/EJIBm8mGSUA3aZYgALzzEkdkyYm2ryO
 /e+ChYEv+jdy7LZA/GS7Z1oW7yBSrMkdmIDRjGzxe/vaUHyozryqacdAb3gVW2MCwvJFFCKO
 Lw9IwfUa6Zcwj6ncuNUTt5W8E7Jz4C39u8Ck189Ry2jgpbCIuoIH0RqFPJn78Vl7rRYpRG3S
 gSI/NxbMq+OI8TrDBgaIw9NUwhJ/a98duX6hRjtHHjH2Q==
IronPort-HdrOrdr: A9a23:vccbtqH1/m7qrK6opLqFRpHXdLJyesId70hD6qkvc3Nom52j+/
 xGws536fatskdtZJkh8erwXZVp2RvnhNFICPoqTMuftW7dySWVxeBZnMffKljbdREWmdQtrJ
 uIH5IOa+EYSGIK9/oSgzPIUurIouP3iJxA7N22pxwGLGFXguNbnnxE426gYxZLrWJ9dP4E/e
 +nl6x6Tk2bCBMqh6qAdxs4dtmGg+eOuIPtYBYACRJiwhKJlymU5LnzFAXd9gsCUhtUqI1SsV
 Ttokjc3OGOovu7whjT2yv49JJNgubszdNFGYilltUVEDPxkQylDb4RGIFq/QpF4t1H2mxa1O
 UkkC1QePibLEmhOF1dlCGdnjUIFgxeskMKh2Xo2UcL6vaJOw7SQ/Ax+76xNCGpsXbI9esMoJ
 6ilQiixutqJAKFkyLn69fSURZ20kKyvHo5iOYWy2dSSI0EddZq3MciFW5uYd499RjBmcga+S
 hVfbXhzecTdUnfY2HSv2FpztDpVnMvHg2eSkxHvsCOyTBZkH1w0kNdnaUk7zo93YN4T4MB6/
 XPM6xumr0LRsgKbbhlDONERcesEGTCTR/FLWrXK1X6E6MMPW7LtvfMkf8IzfDvfIZNwIo5mZ
 zHXl8dvWkue1j2AcnLx5FP+gClehTKYd0s8LAo23FUgMyPeFOwC1zxdLkHqbrUn8ki
X-IronPort-AV: E=Sophos;i="5.90,136,1643691600"; 
   d="scan'208";a="65386817"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P3TDpXlWWKwbGPNVhJov4sMrkg0j3e/S1MYHeudD4Dhv+tEMGMwyvMF3ioeJkQjvMMqjAXT9EnLLfswxvDzor437fUuDAkN1OoAqmqoCQ0mtFRwrCpFFFfS1MB+iyncL9W8bsECU0KXkghD5BbDEIQ30LOdrirIUfUlaHxnWQ0HIMjXrEyuOpyA4UOG1rpxDJh7B2qVWxJEusg+1z3CGTp4u/h5WuIZM/ezdzgEYtNsduqLEVFAQFJ2sZPh082hONd3iTZmjBtj4znCwbV6iEHKPJJhe/NqRUW2kzeKrWcCi+HOAfzctgKVa3/Q+n5MF0HyL9E95az9dwcf7X/qB+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ov1lMpUy3mz+XYBi+3VQevvNSEvU65+EqTrc8JnQTO8=;
 b=g2rleWODwhRfeGQJQaZOjpl86YCbuxT6wEZQ65lLkttwZuY3Cxb7Kb2rtdbWm6ruHIPz5ELGO5+D+gpXB9bGd3j96xG7RzCijbIWNXt8HHMFq/4ztzG3CNi1+YtzsWl7GFeut8QwGJrawUBkbrqLWMuYtFbzmYXWWBaEwuDl06mNnz0X74PswNbGZ9bkrmwngU4a85CFyxFUx9Or0BF+XWVFQhEdFmMM7tzJx/1RTlUrGTdaPaSWXwwI3f0Dokc1T6xJdYXfBHxRZIWj5DgIEYYojgIlPAzphi4rmiSNW4sCkOECXPV/fOdkN9xYxc7WZf51c/cywpiB/kxBcldeag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ov1lMpUy3mz+XYBi+3VQevvNSEvU65+EqTrc8JnQTO8=;
 b=mwg5m3FodxpnJFSKLHl3bCuwOVmO40Yrs2c7InNwAty6mr76I03CN799/U4zyMoEusJtf+w0eUo253AVItfCNRTWX6fSpnlOrJ0bN1hW23rL3wNWy9ZJhGYC4qJSXhhGh08E9Ff7KWzbSVfYIPPxvLYbHEfsVSZtvxWt8cRRC3c=
From:   Andrew Cooper <Andrew.Cooper3@citrix.com>
To:     Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "joao@overdrivepizza.com" <joao@overdrivepizza.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "samitolvanen@google.com" <samitolvanen@google.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alyssa.milburn@intel.com" <alyssa.milburn@intel.com>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>
Subject: Re: [PATCH v2 07/39] x86/entry: Sprinkle ENDBR dust
Thread-Topic: [PATCH v2 07/39] x86/entry: Sprinkle ENDBR dust
Thread-Index: AQHYKZJHgdlV9pc6ak2ALVc+FYKirqyjbheAgACRK4A=
Date:   Fri, 25 Feb 2022 09:22:26 +0000
Message-ID: <64f2f090-682e-17af-5ecf-e9dca4f2c76e@citrix.com>
References: <20220224145138.952963315@infradead.org>
 <20220224151322.423131356@infradead.org> <202202241638.B89211A@keescook>
In-Reply-To: <202202241638.B89211A@keescook>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2d673bb0-bc54-49fd-9b00-08d9f8405695
x-ms-traffictypediagnostic: BYAPR03MB3592:EE_
x-microsoft-antispam-prvs: <BYAPR03MB3592EAC11911E733E85B9680BA3E9@BYAPR03MB3592.namprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MxHTEi0diG3o2An2L9vNe0GtJ0RaZxzQKw7AzU1wbaImZicrC8mTJEbpqbn4G/Lue8rKh/mFEvzcVgUm8KZn/Sq8IQOCHhVeW5RjjN3aKDscpe22pmgcyBfcYloaY4YL43rKZIFRikT9sclrupVeJbh9+xwTUBY9wMQ9BIbRdI/mi1LvyNbOSBMeNgiijplUmhwMQfSmTi7MYU41TRCfwUnAj9qdflGMFFSqfklplKvzvz9pJd9xK4K6u8eW1I3OE9hODoXeWbXQjEQGFKZjK+QniOCmlX1/P/RPoNn1INh1U2GEu0jkXFx8QJtITQv6ivN9ugdY+sGBHAi0AafsEj48pR8Eyj9MW3dpgZmQFxqHpcwim8AwdUAJnKj0QpJAcohavf8SAcpadBSUzEWYm04kRO6+8gBCcEQtEEszcmLJtmKqsmpbFI9IZilL2IE6eakXEE1B69Z0NtTcHAVE6GZtRxQNPC0oNHPlqOfFFJpaoH6rHYdzdh6sYjOYaZ4mCc1g604XKDlr9QKqKMvZA2lc4baxai/cG6o6GnJPDjmyKf4sK0R3KAELZbRl+AnstfGm7yeBhCaQ3j9sHndYY8bns6jG7bT8srlgt7RIyR4zrpsvPelFGapLDnPbSYRK5ujnxQOFudwJe+YZXJMtJHLmuEZpeIGZH1XjoF/24aOLuLUZLn+D5B181FgTMsBhKxuTWPpU6JVjyCh+8m4ICHry7C6i4wD/76sndCO1Xm3VT9WRy/ucHnt4hiwERq9M2vNjvTrb4W5RUoQwgkXsbQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(53546011)(91956017)(7416002)(6486002)(6512007)(38070700005)(6506007)(71200400001)(31696002)(107886003)(2616005)(508600001)(66946007)(5660300002)(86362001)(316002)(38100700002)(82960400001)(54906003)(110136005)(26005)(122000001)(66556008)(66476007)(66446008)(64756008)(76116006)(83380400001)(36756003)(31686004)(8676002)(186003)(4326008)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RkRrbEo3dVZKY0NZVndFMXI4YjZBNUVKc0RsVUEwLytEUTF4Z0VPenVPUUdX?=
 =?utf-8?B?RUdaKzQrWlBhVGJ0UDBCNVQ3NlR4MjRBSlVZbmkvWFJRT0JLSVVzMGd5YjJD?=
 =?utf-8?B?bmh6SThKNHZMN0M3b2p5aVhOa3djUWRPOWpnUEZiUk0rdjNKZ0JQVGo2dlNU?=
 =?utf-8?B?Z0VkQmpzSjVQVkFLV21kUTRsanFqbTdVaGNnVTRXY210UncrQzdmaHNKZ1I4?=
 =?utf-8?B?WmFPTXpvb0hrMUpkcWVxNGpUdHppS0dhOUF5Ri8yYm1rMG9vTGZXeVExR3hX?=
 =?utf-8?B?bFplWE5zbys3Q0VtTXpvR254V0NTRnZlSlBhNGlmNUdoeE0vTDgvb1hJVjFZ?=
 =?utf-8?B?dSthSVcybmppOUZOeWZNTklQamVoYlJ0ZlRzWUlkcFZGNzk0NVY1UENNRlEz?=
 =?utf-8?B?U2ZTZCtMSmEyRWkzUWlNT2IxSnNLU3cwSzhvY0VPTVFPcGlJYjVsZ3RWUit3?=
 =?utf-8?B?VU8xYWozaTRjNVliYUNMYVllSWhmeUN6eGZPTUNsNzFBbHcyK0xOWjR1U3c5?=
 =?utf-8?B?bnpOVmdOZkFSSHIva1ZKN0lBcnVzaFFPbi9RYm1GVWtBWkhJYTV5NlI4eEoy?=
 =?utf-8?B?cjRqS3dRNzlyNjN3KzRSVHBrQTRHT3hkQ3BMRDFubHJKMlpMOEQzYTRWMDFB?=
 =?utf-8?B?enhVTTlVYldwWkJTNmUwWmxKWE5DOWVhR2VLdHVOMkZjN0ZrUkRoWmMxSWZ2?=
 =?utf-8?B?bFpiNGN4eFJXNlZXNGxLd3VZSVdBbVFYQkRKNm1GZE1LNGtrYUtsN3JrZlV6?=
 =?utf-8?B?Ryt0WkhjVkFFYlhLemJCZ2hTeU1iWXdOY3JydXhMbVRmNm9lQ01tQ25LZzE1?=
 =?utf-8?B?L0RHRm4rNEtYb2lxUjJUVDEvQjhRWUJHMUc2bzRSN0MwcXp4dnFQNlpMK3RS?=
 =?utf-8?B?RTFndGkzTENmbytaakVWQnhDVktPaDdKLzg4bEdFZmdwbW1STHRGZm0xTFN4?=
 =?utf-8?B?RFNPUS96dlFYWlJybTkwWStBandzbkV2eVZSblBrbnFRV2ZqNCt4Tm9qQlVv?=
 =?utf-8?B?S0phLzVkaWhPYWxPNTBNWVVYUUlveFcvdVJldVU5UEF4LzBxUUkvcklFeUpj?=
 =?utf-8?B?STFNcS9Yc2RkUitvOW16dU95dWFHNHBqL2x1WnZoTm9DajNaMVB3QzFjUzA4?=
 =?utf-8?B?aXZBdXdNeEpxVnAyR0Z2VnZmaURld1BEdE9ycnI5MHFkcXdJRncwWHM3M0hv?=
 =?utf-8?B?MUV6dnFKTUZSMHdndVhxYkM2QS91UHE5dnZoSDNoaWlrZmlIOURkaXF6UlJM?=
 =?utf-8?B?QWsvbEVGSmVRNFU5NzhpV1k3SkpVcTZOSGltVk1hS3lIZE9rbVQ4Q2JiRWpU?=
 =?utf-8?B?RTQzY05qUDN2ajhsQ2JodVdzeUJHRHkxb1VDdHBuRWhCZUlZbXdna3NYTFQy?=
 =?utf-8?B?YllEdi9GUnBGY3BjZmtuSFJuQUJXNGNNNzhZTEE0QmN6R2l1N1cwT3FaSE54?=
 =?utf-8?B?OTI3SGYzM0p0b05rWnJRRVo4V2NhZ0laRkY4T1BwckdTRC8zNnJBYXN1WE9E?=
 =?utf-8?B?UjMxeC84OGYxVys2aVFzY1p4Z21oeFNzWjRNczV5cTk0Z0RnMTg0QmpETjBY?=
 =?utf-8?B?cWZoRHVoK2MvRnIxdjV3YjcxYlNpckYzWENpK3JPRmk4a2RSY0tEMjJldHZP?=
 =?utf-8?B?a3ExWUV4YXJidmM2U0ZWSkM5SVBvWVA0dDAzL2oyWDhwdGZNbDlERkVLcmhi?=
 =?utf-8?B?VEtaNWc1RW1INWdkZ3Zhbll2cU0wZG4wMEhVc2tRakg1VXdTOTdxU2VDeUZz?=
 =?utf-8?B?MVBkTmE5WmFTazZlRHVOK1RpK1dZT0o0YmE1VlhWVFFrc0dIdmdrUmZxZHZJ?=
 =?utf-8?B?NTA4S2NQOEhaRXRLQ3R6d3hCM0REUUh1N0dyenJYN2EzWWhYaWthQTIzempo?=
 =?utf-8?B?VzArT3owbFp4a3ZlMGhLMysxTTYvS2gxbnhwSkEvd2ZsTzF0cUxJcDJjb3p3?=
 =?utf-8?B?NUozRnc2cGt6VXlGT1FYcVFEQW1PcVJza0p5d0QrdWZ6UDhYL0tLMExuaTF3?=
 =?utf-8?B?Q1FYeWxGa0tPcDdUcEUrNUR6WVRjSTk1ajF1bGFTbHFkQ2J5bzFQVmc3bjV1?=
 =?utf-8?B?allOU25LY0FjdWhPWFNWU2JYTG4vWXkydjd2N3hFZE1NbTRkZW1qYjlmazBK?=
 =?utf-8?B?RE5VbUlpZEpIQmNoR2owbThGbEpXTmdhelBHejRTcHcvQ3hKbjIvMk5DaEFs?=
 =?utf-8?B?SGo3Rjc4YmM5d09xZ1RDci9LTU9RcHBIY3RrcnNNamNWdzZVUE9OMy9lcDQ1?=
 =?utf-8?B?cnVTL0hCVkd1ZzFmdlJnZFF2Y2xRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <927EC462D220D44190FA6F3E3A5044BA@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d673bb0-bc54-49fd-9b00-08d9f8405695
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2022 09:22:26.3251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AqzArsZzBB0BNwPe/nm1AMRpnRpcGHAnGJvNXIW3g/7llN+3ZpXoTJyCM97WbemOLzktMg6ZPnlW/33zNDHxPkJrQtXt7+BgOufHzTCScmU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3592
X-OriginatorOrg: citrix.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjUvMDIvMjAyMiAwMDo0MiwgS2VlcyBDb29rIHdyb3RlOg0KPiBPbiBUaHUsIEZlYiAyNCwg
MjAyMiBhdCAwMzo1MTo0NVBNICswMTAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToNCj4+IFRoZSBT
WVNDQUxMIGVudHJ5IHBvaW50cyBhcmUgZm91bmQgdGhyb3VnaCB0YWtpbmcgdGhlaXIgcmVzcGVj
dGl2ZQ0KPj4gYWRkcmVzcyBpbiBvcmRlciB0byBwcm9ncmFtIHRoZW0gaW4gdGhlIE1TUnMsIHdo
aWxlIHRoZSBleGNlcHRpb24NCj4+IGVudHJ5IHBvaW50cyBhcmUgZm91bmQgdGhyb3VnaCBVTldJ
TkRfSElOVF9JUkVUX1JFR1MuDQo+IFN0dXBpZCBxdWVzdGlvbjogZG9lcyBDRVQgY29uc2lkZXIg
ZXhjZXB0aW9uIGFuZCBzeXNjYWxsIGVudHJ5IHBvaW50cyB0bw0KPiBiZSBpbmRpcmVjdCBjYWxs
cz8gKEkgd291bGQgZXhwZWN0IHNvLCBidXQgdGhleSdyZSBldmVyIHNvIHNsaWdodGx5DQo+IGRp
ZmZlcmVudGx5IGV4ZWN1dGVkLi4uKQ0KDQpZZXMgaXQgZG9lcy7CoCBXaGF0IGhhcHBlbnMgaXMg
dGhhdCBvbiByaW5nIHRyYW5zaXRpb24sIG1pY3JvY29kZSBmb3JjZXMNCnRoZSBXQUlULUZPUi1F
TkRCUiBzdGF0ZS4NCg0KRm9yIElEVCBlbnRyaWVzLCB0aGlzIHByb3RlY3RzIGFnYWluc3QgYSBz
aW5nbGUgc3RyYXkgd3JpdGUgaGlqYWNraW5nDQpjb250cm9sIGZsb3cuDQoNClNZU0NBTEwvU1lT
RU5URVIgaW4gcHJpbmNpcGxlIGRvbid0IG5lZWQgdG8gYmUsIElNTy7CoCBUaGV5J3JlIHJvb3Rl
ZCBpbg0KTVNScyByYXRoZXIgdGhhbiBSQU0sIGFuZCBpZiBhbiBhdHRhY2tlciBoYXMgaGlqYWNr
ZWQgdGhlIHN5c3RlbSBlbm91Z2gNCnRvIGNoYW5nZSB0aG9zZSwgdGhlbiB0aGUgYWJzZW5jZSBv
ZiBFTkRCUiBpcyBub3QgZ29pbmcgdG8gc2F2ZSB5b3UuDQoNCkhvd2V2ZXIsIGZyb20gYSBjb25z
aXN0ZW5jeSBhbmQgaW1wbGVtZW50YXRpb24gcG9pbnQgb2YgdmlldywgeW91IGRvbid0DQp3YW50
IHRvIGJlIHNwZWNpYWwgY2FzaW5nIGhvdyBhIHJpbmcgdHJhbnNpdGlvbiB3YXMgdHJpZ2dlcmVk
Lg0KDQp+QW5kcmV3DQo=
