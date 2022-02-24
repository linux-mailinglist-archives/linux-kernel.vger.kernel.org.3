Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18EA54C3407
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 18:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbiBXRvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 12:51:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiBXRvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 12:51:47 -0500
Received: from esa1.hc3370-68.iphmx.com (esa1.hc3370-68.iphmx.com [216.71.145.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D071D9B51
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 09:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1645725077;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8W8PCo4hUsj9kichOSM+KWCxaMDV+GcM83bK7fnLUFs=;
  b=OCWTbUuwNQI4lSSTVGxHxWBJZgNa5xlZl6jsX0SeO0bWRtvvNwRirNv0
   wRCQ/1zTxhmHxLZa7c+yxsiPgLUV4Js4KBatnXmSVmvrUfkzLREkRSFYu
   UPVzhoxO4kS9iEUOUSbzMEkl2uZ3esKPygMsSmSorZy5q1ebVYoIpBI2a
   E=;
Authentication-Results: esa1.hc3370-68.iphmx.com; dkim=pass (signature verified) header.i=@citrix.onmicrosoft.com
X-SBRS: 5.1
X-MesageID: 65338857
X-Ironport-Server: esa1.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.83
X-Policy: $RELAYED
IronPort-Data: A9a23:kyI7R6OJQhNDI+7vrR2QkMFynXyQoLVcMsEvi/4bfWQNrUor0jAPy
 mZNWm7VPKqJZzP0ftl3bd+0ph4PsJ6Bz9NrGwto+SlhQUwRpJueD7x1DKtR0wB+jCHnZBg6h
 ynLQoCYdKjYdleF+lH1dOKJQUBUjclkfJKlYAL/En03FFcMpBsJ00o5wbZj2NIw2rBVPivW0
 T/Mi5yHULOa82Yc3lI8s8pvfzs24ZweEBtB1rAPTagjUG32zhH5P7pGTU2FFFPqQ5E8IwKPb
 72rIIdVXI/u10xF5tuNyt4Xe6CRK1LYFVDmZnF+A8BOjvXez8CbP2lS2Pc0MC9qZzu1c99Z6
 e1OqJ+UTBwVH/P1udwaeSh4NA5UMvgTkFPHCSDXXc27ykTHdz3nwul0DVFwNoodkgp1KTgQr
 7pCcmlLN03dwbLtqF64YrAEasALBc/nJo4A/FpnyinUF60OSpHfWaTao9Rf2V/cg+gQQK2FN
 5pENlKDajzqUjhXEEgILK4kp9eSgyDDWWJyo3G88P9fD2/7k1UqjemF3MDuUtWOVN5OlwCdp
 2bM4n7/KhAcKNGbjzGC9xqEg+bVnmXhRZ4WHbu03vdwhRuYwWl7IAYfUFqnpv2ng0izXfpQL
 Esb/idopq83nGSuRNT7UgaQu2Ofs1gXSbJ4Guk3+AyMjLHI6hyeGG8FUjlfQNMjvc4yAzct0
 zehmtPoHzVquaG9Sn+H8LqQ6zSoNkA9N2gZeSIIUSMK5N7vpYAoyBXVQb5LE6O4ldbyHjLYy
 DCQqy0/mrBVitQEv425+lnAqzWyq4LFVA8r6x3WTHCsqAh+YeaNd9z2wVvW9/BNKMCeVFbpl
 GAJh8WE/sgPC5+XnSCASelLG6umj96FMjmanVloG4IJ+DGk+nrldodViBl4KEpyO9sAfz7ke
 lT7tgRW65teenCtaMdfZ4O3FtRvzqX6E9nhfu7bY8AIYZVrcgKDuiZ0aia43XjqkU0mlqwXI
 5qXcc+wS30dDMxaICGeHrlHl+Vxn2ZnmD2VFcuTIwmbPaS2RUaWVLQhNUCyT74AzZuDijT11
 Pl1OJ7fo/lAa9HWbi7S+I8VCFkFK3knGJz7w/Bqmv6/zhlOQz94VaKIqV81U8k8xvkOyL+Ul
 p2ochIAkDLCaWv7xRJmg5yJQJfmRt5BoH0yJkTA1n74iiF4Me5DAEryHqbbnIXLFsQ+lZaYr
 NFfIq1s58ijrBydpVzxirGn8eRfmOyD317mAsZcSGFXk2RcbwLI4MT4WQDk6TMDCCG63eNn/
 eH9iF+BHcBYGFw5ZCozVB5J5wnv1ZT6sLgvN3Yk3/EJIBm8mGSUA3aZYgALzzEkdkyYm2ryO
 /e+ChYEv+jdy7LZA/GS7Z1oW7yBSrMkdmIDRjGzxe/vaUHyozryqacdAb3gVW2MCwvJFFCKO
 Lw9IwfUa6Zcwj6ncuNUTt5W8E7Jz4Gx/+QDllw8Rh0mrT2DU9tdH5VP5uEW3oVlzb5FowqmH
 EWJ/9hRI7KSP835VlUWIWIYgi6rj5n4RhG6ASwJHXjH
IronPort-HdrOrdr: A9a23:kEARn64S3avjTVmLmwPXwWaBI+orL9Y04lQ7vn2ZFiY7TiXIra
 yTdaoguCMc0AxhJU3Jmbi7Scy9qeu1z+873WBjB8bfYOCAghrnEGgC1/qv/9SEIUPDH4FmpN
 5dmsRFeb7N5B1B/LzHCWqDYpcdKbu8gdiVbI7lph8HJ2ALV0gj1XYDNu/yKDwseOAsP+tcKH
 Po3Lsgm9PWQwVxUi3UPAhmY8Hz4/nw0L72ax8PABAqrCOUiymz1bL8Gx+Emj8DTjJm294ZgC
 j4uj28wp/mn+Cwyxfa2WOWxY9RgsHdxtxKA9HJotQJKw/rlh2jaO1aKv6/VXEO0aOSAWQR4Z
 3xSiQbToNOArTqDyeISC7WqkzdOfAVmibfIBGj8CPeSIfCNU0H4oJ69Pxkm13imhAdVZhHod
 J2NyjyjesnMTrQ2Cv6/NTGTBdsiw69pmcji/caizhFXZIZc6I5l/1VwKp5KuZIIMvB0vFuLA
 CuNrCp2N9GNVeBK3zJtGhmx9KhGnw1AxedW0AH/siYySJfknx1x1YRgJV3pAZMyLstD51fo+
 jUOKVhk79DCscQcKJmHe8EBc+6EHbETx7AOH+bZV7nCKYEMXTQrIOf2sR+2Mi6PJgTiJcikp
 XIV11V8WY0ZkL1EMWLmIZG9xjcKV/NKwgFCvsukKSRloeMNoYDaxfzO2zGu/HQ1skiPg==
X-IronPort-AV: E=Sophos;i="5.90,134,1643691600"; 
   d="scan'208";a="65338857"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PUadToblucgMU7K2tNqeo/x8pKFmswzkhsbiUWTRy/l2/mq31KJ2Z+CpTGgvzybaHl1TU2RGJVgo9wlU6cx/qf1KdyD/D68f3RiHttPfpIrjwwMyKc7zeg9x7WTPdq5uaWb1uoAsLC6MGFIB4ljO2a3evT2CkoddF/X+wA9T02uujJsQ1RRLy+C6HHQ1LqDU+sKQ7DSdzCn2+m7x85rCBZiHoZhzDSqYgmGFFXZpxsNSRD0VEhGcg7CQg04m6V2vY5c6zazV3bWSCM4cIsDE14mRnScu3L1zROd3pp+VwottsX6Yq2q46zhXff4zJ0yEkSO2DUbVS1nZNKCO9+F4Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8W8PCo4hUsj9kichOSM+KWCxaMDV+GcM83bK7fnLUFs=;
 b=Kr/MtKFBZ/6/l8ZtLCZUcy2XGlKCylMnli4nuVo3/SC6wZD57EtQPLlVlYaYs9YeN2qM0jRvaZs7aELqat6duZr/e/g9xYQh9cwmRPD9Uze2PUxur0GclpAtJlMq1kFD85TOjTb0VBSP74E4fq7/HMOhOGpZSWwJUoWWEynooPFLCEtE9Eagna3BOXOcRz0Na4VITi3YTQ5sa0ZLO6wpd/DyHKUZshGhMYLUIrQEvbYdQchCKpsD2Gl80V2KPhoQsl80It0htN89lYLwJyXQP3+iw52E+bfpNFvN93nGRO9CQtU2tMeYoiMQHNJngZQPwGgNp3Yr5nQdEnTku3xxig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8W8PCo4hUsj9kichOSM+KWCxaMDV+GcM83bK7fnLUFs=;
 b=uctNJLrJDM/ILcLdK1qIwa9m1SGpmvkup4SLHaQkkDpxAXyuVDzTN+7I2p1d6wmVqYsxp4dsfMgB8jD3+qAmFRVSp43bj5ss+tqFUHFcCaUO2Wn4w2d7eGdAot+wgdf77t6Y+pcfn4qORM6Yxgzbcr9SAY2KuwHwVI92kgV2D78=
From:   Andrew Cooper <Andrew.Cooper3@citrix.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "joao@overdrivepizza.com" <joao@overdrivepizza.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "samitolvanen@google.com" <samitolvanen@google.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alyssa.milburn@intel.com" <alyssa.milburn@intel.com>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>
Subject: Re: [PATCH v2 27/39] x86/entry,xen: Early rewrite of
 restore_regs_and_return_to_kernel()
Thread-Topic: [PATCH v2 27/39] x86/entry,xen: Early rewrite of
 restore_regs_and_return_to_kernel()
Thread-Index: AQHYKZJOTotqHMrzE0WLxKdveZ3Wu6yi+xWA
Date:   Thu, 24 Feb 2022 17:51:13 +0000
Message-ID: <1e61971e-c782-2b8c-41fc-4ae17fb35037@citrix.com>
References: <20220224145138.952963315@infradead.org>
 <20220224151323.601401399@infradead.org>
In-Reply-To: <20220224151323.601401399@infradead.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2867aabc-5cc9-4374-3389-08d9f7be3fc8
x-ms-traffictypediagnostic: BLAPR03MB5380:EE_
x-microsoft-antispam-prvs: <BLAPR03MB5380C4F9962179361D75F4D3BA3D9@BLAPR03MB5380.namprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8fHIXotWBuBgU8pXDgwuIoVAzN7eDdhHIzuk9a+CGH8XHXky6GtLM35D651uqERES14wk032R7LE1sy9ldQxw9NjRFXDimXccsuJiDpsz7kHudKOWECwRQ5cXSnLIsSc/RtDBWql109hdnlRZSl6G+CtKvnHUw9PIMD4D+QvV0vFo6dlj0ogsQ1P1XeIA0zr1o8s7dZ4KwEZrUWPi/yBqRMDOJgrxV5SA2F6TCcurDcnMBgk2w11S/cIvnbDVEnzhxd91eF0y+WMhhhOu9bC201h/UUSOmpJP/Po8lPmLbl8kuwN2SBwWOdyJgQ0Ys5rnxGeQmlW7FCekoOBgOb2pGPklJPbiqLbnNljc949yDOsNGwFuitV2C3agyVKITlOZOj0+iN+BTPvZ2KighMLRFBicLM0C24pLNDDVItuCO4p8yW0AU/6xf2aSW6+b29t7wwxoFehnHm2s4U0FI5cYMPzIRKaeA/9/eVp48fG7io/IbMSYVz2IvA12iM/ZPZfsB3TthtRCDbEVv6h50FHIVKzbvMIh8N+LCcNlrh+snQC0+U6EuE+Zae1apGCb++wWN10GJ4HdoRMJpVxKoNc5lJqeaMRmhc24ywOlGluhj3eciWbozJltk/XK8PU2dy7YTzF/ffYZAMFSgXs6NsPMFxNeeeQX58GpXrBGl2R15AmQlcRzzzdJ73u8ciM1N/C2Of/nD0SYSWrcjTJZvo2EFAh6J8bqfNxv2gatDmei0D/FhUTOTNv3UAQU+ml/VO8fRUl7Ce7Bb3FkR500Xx0hw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(82960400001)(7416002)(86362001)(110136005)(8936002)(91956017)(5660300002)(66446008)(4744005)(64756008)(66946007)(66556008)(6512007)(76116006)(122000001)(6506007)(31696002)(54906003)(53546011)(4326008)(38100700002)(66476007)(8676002)(186003)(83380400001)(26005)(36756003)(107886003)(38070700005)(2906002)(2616005)(508600001)(6486002)(71200400001)(31686004)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cE1kNUJOK3ZsQmJxeU9JTk1Ha1NBT0k5aHJFekduRXNMT0pQcXBqaUFZdzN1?=
 =?utf-8?B?aThYcGhCSEF0Zk1rNUJZRWRVdWNDV20rTEhFSGQzWVRmcDlRd25JMkprZlo1?=
 =?utf-8?B?OUlRaGNyb2NtU1ExalRVR0pJQ1ltU3FhaTZWQnN2VFBudk8xQUlrZzNUK3NE?=
 =?utf-8?B?YjUzbTR6TE82cDdQODZLbW1RZWJyVWRSUFVkY3Vac0RYUHZLUnFXSTd3cHRo?=
 =?utf-8?B?bnlreWFPQkhuZUVob3NkMHhhQVJwK1Exbmd2eGsvZXdvMlkzOHdxdkRsVWxR?=
 =?utf-8?B?WjZVQWpaNHc5cGc4YVhhTWdMamdKWXNjYXZXajN0RHZHeDVsV0NYVE4zQnhx?=
 =?utf-8?B?NktudEttTWgzeWpjNnV4UXp0RVBOaUthaTEwRnVhNGJMeExRN0UzaWE3THdo?=
 =?utf-8?B?S1VSMmdCWWg4OFBEM1JUL1pYOHVjaEkrZ1JmNVBCNDRjdzZwc2F0SUpSbVJx?=
 =?utf-8?B?VVNIdlVkbWk3bU9jbFhpclF1V2RqUVYwWDVOUVVlZ08zalFVbDM1MEp2dE1a?=
 =?utf-8?B?dVFMQlBmNDk5c09HcFZZZmsvcG5rNzVsU1hPSU5LMjBXZkhESEdSOG5NTVhJ?=
 =?utf-8?B?QlVJU3JCSWpaS2JpR0VYc3RYOTBpWW5oZUwvZE9TaWZ5Y0R0VXpmQ1Nmajg4?=
 =?utf-8?B?Qzh5amxtS0RRaFp2TVM1S2F5ZU5rMEtVZUFaMUN3U3BqZjBFa2d6dXY0cFM3?=
 =?utf-8?B?NlNlZGNmMjRRSEliMkEyNGFiUzBWTzhiLy9HL3llTnNPQVhZOVcyQU5yd2Ft?=
 =?utf-8?B?SGllaVRhVFlBYkVRU2VmVURIMkFNdlBaNkozR25VdnY3U3RGOWRXWE8yUnBT?=
 =?utf-8?B?Mk9DU0JLT21iYWdyckZRcU1LVTN3Yk5IOUxQYU1XeVI4R2tMVExiMDdvUzY1?=
 =?utf-8?B?ekc2OFBZK3h3L2JWdXJBYi9FSTlnSEVKY1B5MkRIVkp5Y2gydExweE9GR1Q1?=
 =?utf-8?B?ZUFBYXJXcDZYdU9nWWI5cG4vVTFKbFkvQy9YbC9obzF0YUxXdDh0UmNvMjFX?=
 =?utf-8?B?SGo4cTVlSmpOOVUyRHR3K0l4a0pja3hJSncxVUgzdlgvUWVSVmNVeStlalhp?=
 =?utf-8?B?Z0lEMEZLWDBqMTlBUlA5aTBrL2Q2dmRrMzVwZVZ4ZnE1Mmx4UjZ1dXdMdEFD?=
 =?utf-8?B?bmlFRTliYlF0aS9qeHVmcldxcng3am5rKy9LckVkNFl3R1lGeFFzUjM1a1o5?=
 =?utf-8?B?ZWhzNnhaMVVkZmxiNDdjbDkxUlhXYStPK09OSFBBNkhkNjhyYStjaDVpL3RU?=
 =?utf-8?B?SkxKNGI2bDJBakJoQThEdGJ4VWJMVEN1OWdBZHRhM1dBYVU3eW80cCt1eGtp?=
 =?utf-8?B?NHViUnVFY3RTSmtLYjZ1UGh1eFNjajczOW9MOW16Y1ViakpjQ3IvbGtRU1g5?=
 =?utf-8?B?eXRTL1UrOWFLd0s0dUd5MGw2YldMUWNhOXkrbkZ0OFh6NC9sNm1qVDFraTFN?=
 =?utf-8?B?RS9ybjNONkxUVzZFTENxR2lZUXMzVE9aZys5MnVxcXZnczYwL1JsV3R4UDRp?=
 =?utf-8?B?TUNFdCtERm96TVNpWXlLS3RNS2pyY241MzlLZXNoVmhBZmV4ZWpjT0gyVGhj?=
 =?utf-8?B?NjY0MkNpcFE5MHQwS3EwWXZ2UmM3Q2hFcTJVQ0Y0cHJjTTBMalU1RzdiOE5D?=
 =?utf-8?B?RTJkUkI0Vmx1cHhRaCtjdWowalVXUi9aY3hNYzdQUUFBU1JCOS9oY2NIbUxL?=
 =?utf-8?B?c0FPSHQ2MGkvS0dCUVNKYjFoU2YvNXhGMDBFUklZcnBrRkZGY2s0OTNjNGlY?=
 =?utf-8?B?Tlc2ODYrQ3AwMEVnRWY2SzVqRXByM3hLdTJSSUY3NGFKUjM0bnlVU2tTRENw?=
 =?utf-8?B?WjNHUk9VY0phbUZxTnZOM2pkYXJFYURRblArVVVua1NvSDA1S3RyUmJZbU94?=
 =?utf-8?B?bHZTZWtLZHQ0VHFwU0dGcGdkWU1ZUzlnd0ZTbGFkUXhlWXlMc3AvYVluTnVV?=
 =?utf-8?B?eFI0MSsybnZiL0R2N3hwQ3Ivc3dvOUlhMytKQnFxTTFMNHQ5dGJBWXVOMGYw?=
 =?utf-8?B?TjkxS3dPNDVDNjJ1UUxoU2tvQUZ2djJJSzRTWnlmNzNCYXE1UU83Ri9jWS9Y?=
 =?utf-8?B?YVRFT3lsYTJMTk1UaFY2UlFCTURKZzB4d09FN2E4enVUY2ZoUm1BZWhTbXhw?=
 =?utf-8?B?VzVwY0llakVZRCt4L3o0YlVpQnMwYTVraWhPWHN6d0Q1UzBJVEJjdkpWVFZi?=
 =?utf-8?B?eW8zVWMzL05YZXNzMUludUN0cm5aS0VrZHoxZjlyY0hsSWpOdnJIc2hkYjhI?=
 =?utf-8?B?SkR2NEFPSUgxNEJGTTNSbFpHYjR3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FDD26027BF119D41AF32D5495410596D@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2867aabc-5cc9-4374-3389-08d9f7be3fc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2022 17:51:13.4473
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HH5RiqS1fZNLbDjXFpILTpxFF5Vtppq2p0s5ZNiWC8bG/s5lEvk8ZwIFPoyKjU0xwZi1MrY2c9Rg2xZ/27osvw5Hf49/luA6L5WgJtpbLQo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR03MB5380
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

T24gMjQvMDIvMjAyMiAxNDo1MiwgUGV0ZXIgWmlqbHN0cmEgd3JvdGU6DQo+IEJ5IGRvaW5nIGFu
IGVhcmx5IHJld3JpdGUgb2YgJ2ptcCBuYXRpdmVfaXJldGAgaW4NCj4gcmVzdG9yZV9yZWdzX2Fu
ZF9yZXR1cm5fdG9fa2VybmVsKCkgd2UgY2FuIGdldCByaWQgb2YgdGhlIGxhc3QNCj4gSU5URVJS
VVBUX1JFVFVSTiB1c2VyIGFuZCBwYXJhdmlydF9pcmV0Lg0KPg0KPiBTdWdnZXN0ZWQtYnk6IEFu
ZHJldyBDb29wZXIgPEFuZHJldy5Db29wZXIzQGNpdHJpeC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6
IFBldGVyIFppamxzdHJhIChJbnRlbCkgPHBldGVyekBpbmZyYWRlYWQub3JnPg0KDQpBcyBhbiBv
YnNlcnZhdGlvbiwgaWYgeW91IG1vdmUgdGhpcyBlYXJsaWVyIGluIHRoZSBzZXJpZXMsIHlvdSds
bCByZWR1Y2UNCnRoZSBjaHVybiBieSBub3QgbmVlZGluZyB0byB0YWtlIG91dCBFTkRCUnMgd2hp
Y2ggeW91IGluc2VydGVkIHByZXZpb3VzbHkuDQoNClBhdGNoZXMgMjUtMjcgYWxsIGxvb2sgbGlr
ZSB0aGUgY2FuIGJlIHByZXJlcXVpc2l0ZXMsIGFoZWFkIG9mIHBhdGNoIDUuDQoNCn5BbmRyZXcN
Cg==
