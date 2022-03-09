Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32DA4D30A3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 14:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233392AbiCIN6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 08:58:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233372AbiCIN6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 08:58:11 -0500
Received: from esa3.hc3370-68.iphmx.com (esa3.hc3370-68.iphmx.com [216.71.145.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EEA217CC41
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 05:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1646834232;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=AAPCkPZiMZXMMmYGv5zUQql0hnG7JuDZlKsXRAEuoTE=;
  b=h4lKFHJX1dMy95CXOtPguYLGS2RE6Ta7j2IxiDW/VATra15zcSyKSi8V
   J+9CDZJeG6TPz0m1ZXdXt/XF27auW1R85HC3ciLxaWU/ntWvDC4rBZzCv
   5zXZ5wOU1jNnrqFJq4ZF5zOiPLz6f1noy0qNNZJvRPqOWOyI2uy80unH3
   4=;
Authentication-Results: esa3.hc3370-68.iphmx.com; dkim=pass (signature verified) header.i=@citrix.onmicrosoft.com
X-SBRS: 5.1
X-MesageID: 65816160
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.83
X-Policy: $RELAYED
IronPort-Data: A9a23:/1mGb68T+qmJgxOW46dFDrUDt3mTJUtcMsCJ2f8bNWPcYEJGY0x3z
 zYbDWmHaf2MNmegfdBxPdvioR8Fu8PdydBrTVE6qyA8E34SpcT7XtnIdU2Y0wF+jyHgoOCLy
 +1EN7Es+ehtFie0Si+Fa+Sn9T8mvU2xbuKU5NTsY0idfic5DnZ54f5fs7Rh2NQw2oDoW1nlV
 e7a+KUzBnf0g1aYDUpMg06zgEsHUCPa4W5wUvQWPJinjXeG/5UnJMt3yZKZdhMUdrJ8DO+iL
 9sv+Znilo/vE7XBPfv++lrzWhVirrc/pmFigFIOM0SpqkAqSiDfTs/XnRfTAKtao2zhojx/9
 DlCnceieF0lY/fhpP42Cx12DgEkbO5p0rCSdBBTseTLp6HHW37lwvEoB0AqJ4wIvO1wBAmi9
 9RBdmpLNErawbvrnvTrEYGAhex6RCXvFKoZtmtt0nfyCvE+TIqYa67L+cVZzHE7gcUm8fP2O
 ZdJMGQ2MkyojxtnNm4oBZhisL6RuHTGVz17jQ+b/olr/D2GpOB2+Oe0a4eEEjCQfu1cmleDv
 WuA+mX9CAwAMvSezyaI9jSngeqntSbyQoFUDqCk8vdsjHWa3GlVAxoTPXOgqPy4lkm6RdtZJ
 ko89S0poqw/skesS7HVWhe1pnOflgUBQNcWGP9SwAiJx7rZ4kCCGmEeSSBGacAhquc5QDUr0
 hmCmNaBLTlvsaecTHuB3rSZtzW/PW4SN2BqTTUDVhcI78XLr4Y0ghfOVZBkCqHdpt74FCr7x
 DeJhCM+nbIWjNMOkaKh8jjvgTWlobDOUAMv6h/WQG+97xFrbciuYInAwUiLs95DIZyfQ13Hu
 2IL8+CG4fwDF4OllSqDWuwBEbilofGfP1X0gVxrWYUm8DC203GmdIFUpjp5IS9BNMoJYjb0Z
 EnStBlKzJBUO3SuYOl8ZIfZI8Ary7XwUNfoTPbZavJQbZVrMgyK5idjYQiXxW+FuEo0lqA6M
 5CWWdyhAXYTFeJsyz/eegsG+eZ1nGZknzqVHM2liUT8uVaDWJKLYewXAQGCM7oU0Lmv+AH77
 vYFZoil4RoKBYUSfRLr2YIUKFkLK10yCpb3t9Fbe4a/H+Z2JI0yI6SPmO18IuSJi4wQz76Vp
 S/lBie03XKi3SWvFOmcVpx0hFoDt75bpGlzAyEjNE3AN5MLMdf2t/d3m3fakNAaGA1fIRxcE
 qFtlyaoWK0nptH7F9I1N8eVQGtKLkjDuO52F3D5CAXThrY5L+AzxvfqfxH06A4FBTetuM01r
 tWIj12HH8VdG14yUJqKNppDKm9dW1BHyIqeuGOSfrFulLjEqtA2e0QdcNdsSy3zFfkz7mTDj
 FvHafvpjeLMv5U04LH0aVOs9O+U/x9FNhMCRQHztO/uXQGDpzbL6dIQAY6gIGGGPEupqfrKW
 Amg56ylWBHxtA0R6NQU/ncC5f9W2uYDUJcBl1U6RiqXNwr3Yl6iS1HftfRyWmR27uYxkSO9W
 16V+8kcPrOMOcj/F0UWKhZjZeOGvcz4UBGLtJzZ/G2SCPdLwYe6
IronPort-HdrOrdr: A9a23:GB1TXKGQbVgDjcuGpLqFRpHXdLJyesId70hD6qkvc3Nom52j+/
 xGws536fatskdtZJkh8erwXZVp2RvnhNFICPoqTMuftW7dySWVxeBZnMffKljbdREWmdQtrJ
 uIH5IOa+EYSGIK9/oSgzPIUurIouP3iJxA7N22pxwGLGFXguNbnnxE426gYxZLrWJ9dP4E/e
 +nl6x6Tk2bCBMqh6qAdxs4dtmGg+eOuIPtYBYACRJiwhKJlymU5LnzFAXd9gsCUhtUqI1SsV
 Ttokjc3OGOovu7whjT2yv49JJNgubszdNFGYilltUVEDPxkQylDb4RGIFq/QpF4t1H2mxa1O
 UkkC1QePibLEmhOF1dlCGdnjUIFgxeskMKh2Xo2UcL6vaJOw7SQ/Ax+76xNCGpsXbI9esMoJ
 6ilQiixutqJAKFkyLn69fSURZ20kKyvHo5iOYWy2dSSI0EddZq3MciFW5uYd499RjBmcga+S
 hVfbXhzecTdUnfY2HSv2FpztDpVnMvHg2eSkxHvsCOyTBZkH1w0kNdnaUk7zo93YN4T4MB6/
 XPM6xumr0LRsgKbbhlDONERcesEGTCTR/FLWrXK1X6E6MMPW7LtvfMkf8IzfDvfIZNwIo5mZ
 zHXl8dvWkue1j2AcnLx5FP+gClehTKYd0s8LAo23FUgMyPeFOwC1zxdLkHqbrUn8ki
X-IronPort-AV: E=Sophos;i="5.90,167,1643691600"; 
   d="scan'208";a="65816160"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PSFxiW+4XRPEOPPkwBRmfqjjv4N6gWX6YmMbDHJXT9TkrDlu0MmHE0C1/BMkdqzy+cnMfDb52kC7S8uUjpOQIX0IBoG97YHU/p9GDG+zcnYpjcrtQHNjRKPhtYAmAAMVjueStSuH4Tcq1Oi63xldik8zUm9AOq0AL6dQ96G0ugQwOyMO5JgyyH0DBQx8IZrhqypAO7BZyIGnmTd+g4NwDy+Er0Nxj9XAXI8xGR6xQeT8CPRBjVEK+YwtZNr3VX8oNZ2bXhx2Ch031L17HEg0Mw1EHpEl0Vm7laZPsbUUKGEtj+z7TU8DHImPLJ/wjDJeMfvgkw5Q5HyqQOlIK3VJsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AAPCkPZiMZXMMmYGv5zUQql0hnG7JuDZlKsXRAEuoTE=;
 b=MTR2wabL6puC7YkPo6RZlnHClI96hDH+2E6KRos6Zlq9dPWLTVF0QAzAdEAlBtYpOJAAPaoNmKSSLNNF650CpOndrgojkVnS99P0xqAuxWI1vSz95sQFiTZ5tTipxzjnBBjtqqRPXfURyoWh0awMo7EcXupimOTtm2Tw/10W2cvsj9xAfRWNMyJidLMy+4PBKUfZfc0zWPscnc3bHvumoo0FB5cOHHU68BUikXcKJXcOF9JJ+fOIo/QfP0WUeuuU8i4dDB0jNG6XGQE3KeCmxPZ8Sp93eyvlbqSejtd1y59JyOec2UTlpdhtMuNqrOyKaXZRxf4exHnVwI9yo+qBJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AAPCkPZiMZXMMmYGv5zUQql0hnG7JuDZlKsXRAEuoTE=;
 b=gSx23MlsENW99ZZ2J7fQlBE7lzJZw4QpMaB8w7Vb4wpui0CDyUEfD+Q+T/GGrRB1y6zyaT3qC9n0Gw6hVu+/MUE0zraJ4S3dz6LUpEPZ7qEDH38o7pCa73LeSlYWcRHYjjl+EoFTXxsDAKcLTkrpId43zD6FjuUNfn0XIE5hGB8=
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
        "alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>
Subject: Re: [PATCH v4 24/45] x86/ibt: Add IBT feature, MSR and #CP handling
Thread-Topic: [PATCH v4 24/45] x86/ibt: Add IBT feature, MSR and #CP handling
Thread-Index: AQHYMwT1U++taeQ1xUi0CQ+gQFzQLay3FQOA
Date:   Wed, 9 Mar 2022 13:56:51 +0000
Message-ID: <2f1617ff-1665-1814-9c0b-5188d0794ac2@citrix.com>
References: <20220308153011.021123062@infradead.org>
 <20220308154318.582331711@infradead.org>
In-Reply-To: <20220308154318.582331711@infradead.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 616611d0-89c2-4814-8a1c-08da01d4a98e
x-ms-traffictypediagnostic: DM5PR03MB2457:EE_
x-microsoft-antispam-prvs: <DM5PR03MB24573A58C64296AE4B3EE32CBA0A9@DM5PR03MB2457.namprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RhrgA5EDX0lWqWjfrk3CioVh3M7ReUlgDpS6L1TIiO/JlzcQyGInUt1TfMRiPbMjLx0/ARfOklTDYe4lohN9gOY0VPY2c4L0JZMjRhLwNYQNr2pbEl/q/cQdDNSg3TQD9l14Njv56bhbMgN3UXVW/U0AYN3cvf9EGptwykRO+8Y+G6vf9sUzCTTfqdd7aSJf4unGqVgkCeJ8nsU5PcbBAqgfdrOB/NigH2e2MNsQQnKZM130353F38hMHQ0eJVHUlJ0FaWlkvSLF6gskoEnONiKhPDLejkRMOfzw6vVGgHkBxIxBK6b8rEVcNRCfiK4IXB1la9gQrmv8XCAiMYTtv+zIl9Py8Nj6HuHXVQNNOOxKasZXPwnifSculiN5hVt+rHD62Xqc416fVTygvQGGqVUeOmPhGfvMNXyo1GoivGIcvzTUjs4THDPCann6vcR6vJ2nq6wJwh9u5nbj6esW93VXMhXOTIimHc7eHvYCRLpnitT9zDqyCxSvr+lBcHwvMKquNSdL4D1trTslmYHi7DgZJyQnB7ViLlxZQY36cHm3WvoL5nEKv2lqEdH00zsuLuJF8a+0yL37HbG97VZrY7yiT4U+MdGFRhbUWIWzXAAtVx5LzccRYDwcWMSt+pk1g7ZHgT7AE/ZWHgeTq49gY02/uIKW/WzvrHIh8c3H/gpAMTef2tV2CKcFNfXOuacWFYIMY6vlsQ1n2/7pa2IkZ7oSdTGuZwqW4hHb/ijI2pGdW1uYJVKxqcWe5grmkHQwlXjuW34/KfRwn5ubAVmwMQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(82960400001)(54906003)(122000001)(38070700005)(83380400001)(31696002)(86362001)(66556008)(66946007)(66446008)(76116006)(66476007)(64756008)(91956017)(8676002)(4326008)(5660300002)(110136005)(316002)(36756003)(7416002)(31686004)(38100700002)(8936002)(2906002)(6506007)(53546011)(6512007)(26005)(2616005)(186003)(508600001)(71200400001)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?czhYbnlibnhadVVEODYxZzA1Q3lCTy9RTTRuS1htVE1xQm1FeGlQN3E5VS9Q?=
 =?utf-8?B?TGV0RDNZOEovZ0ovZDZGczRQQ0tJdW51NHNBYnNaWmE2QUl1cTZKQ0Nrb2Jz?=
 =?utf-8?B?SWVQYVhKSGNVWjg1elVDOWpuN2RIdXo5REgvdVMxQkJyUXJ0VDdHYTJUODhF?=
 =?utf-8?B?a1NGYi9INFpqN1dYOXFpWklVSGxhcTJTVHBRYS9NWXc1WFoxOWI2NW00WDhk?=
 =?utf-8?B?WitHSGhqUDcrdndCaUZ0K091UjFJcS93ZU4xdXV2cithNmR0V1RjUG9CQWlK?=
 =?utf-8?B?RU5JeGFGUDk2WHFPOXFRdTEyYnhobzBLSitacGR3aUNOdmFjQVZseEFON2JR?=
 =?utf-8?B?WGdvczI5M2NMS1ZqMWVyWGJZdmhWa3pFVkt0RDVrRnNJTXpJeGwxK2xENURS?=
 =?utf-8?B?WnBZVnpxTWdnSk9Cc1grZC84VHluT0dVTFNsY3ZqeUdFSmJudHJ4VUlaeWhI?=
 =?utf-8?B?MkNvZkhnUWpTOVZoK3doVFpybE1XdmRURmZGejZ2YnlEZFo0azJmZ1JlUEpa?=
 =?utf-8?B?QWQ2by9heUNFdzdvT0EwLzR3aXZzVnk1a2N6MXQ4YS9SNmE0T1B2OS9IUld4?=
 =?utf-8?B?TlBzd3hwZHBVUktqdlF3dVU1VXhJa2U4eHVJbDkyd1JtdDBEaGNacGdZdHlt?=
 =?utf-8?B?L3BJaFFreU5mUUtGaHdXblhHY1JFMngwRU1LNGUvcEdSNktBNkhmUEQxT20z?=
 =?utf-8?B?eUJOM2V2ZVBGZ1ZSWDE3MXpzSWZCNGNwVjljQy9JRDRIdzQ4ZGhsQ20wbUlN?=
 =?utf-8?B?RTB4TlJqSkJvOWlYdllMOFJGL284R3JMNXNwT2h0S2VWTis4cTRVdGl6OW9r?=
 =?utf-8?B?VkRyQzEvSUt1blp3WFR6aEtaTURwL3lBOENQb3hDMzAzRDhmenp2S2M5ZUJn?=
 =?utf-8?B?ZmhydGx1eEJUMWtZSml3d1p4L2pBWVBqNVExRXdGeC9TQk1Kdlhid3dVeHNC?=
 =?utf-8?B?VWFBdXZmVDVSb3JOMUJHR1lkamk1UDE0T1M4ZHd6ME0zK1RZMThTVmpaeXZm?=
 =?utf-8?B?dWVpNzI0REFUeEZsMkg0dXI5aDJQM0gwWG5xNGxSVmpYbHZVdEdhWEh1OUhx?=
 =?utf-8?B?QnB5OXhhS2w4YlRxcXBncWozYXdHNmVSZ1J0dnhKU1diU1F0VS9kbGRDeE5M?=
 =?utf-8?B?RmlOSWlCcFVuN0RsbFFUSkRQVVJEYTk1bUZiZUpCdTNEa05FRlBOdEhENE9y?=
 =?utf-8?B?SGJrQmxYcno1b21RMkRWeTdMNmFnZ1l1NSsvZ3NRZ1BtaFRXYTVtMWQ3Vm1U?=
 =?utf-8?B?blpIU2toR3lHTVZnYU9mNjlpRXJVejBtdWUxQ0k5YkxTNzJkRDVPNitndlFV?=
 =?utf-8?B?L0lMWW1tT1NQekt0QTN4bDlwMDhPWjN4RmlXYU9IVGhjcVpEV0JFS1k4SXBx?=
 =?utf-8?B?dEtjejljVXk0QW1zRzZyazlMbG9Wdmh2RUpIQlJIWFBGR3h0OWdFc3d1UkpZ?=
 =?utf-8?B?alB5LzZsNTZyMVMzdWVnWktmblorTXVNaUJ1TjRMUjlyalpGSnhUdk1Qbk8z?=
 =?utf-8?B?TWNkSGFFSTNpOFplVU5VQ0xiNjZyWDZyUmQvM3pFSkN1REM5VS9GV0ZnaXo1?=
 =?utf-8?B?Y2tDT1k2bzJKd0JBeE4rVndka25sRHlyakNnaGtGa0kwaGlqaXVQSlFYaENL?=
 =?utf-8?B?NVQ5aXBnNVN5WW82eEp1R1pZWjJlc3E0NjAxVWs5UTRyZ2pRSzdNc0RGUUpF?=
 =?utf-8?B?THJFUmxJbXpkOERzS3diQ0VVeDZNUXQ4Vi9kZHpJM1R2cU4vZlFyNERIYmY2?=
 =?utf-8?B?K3JDQXFIVU1xaGtpSGVQaWJlc0pxQ2hCSVRsRXB2SXRZNGZYSzU2WU9EdFVt?=
 =?utf-8?B?Q2ozWURHV1duUjhxb3ZGY0RoSXJ2RFVIZkExeEJzaHRFR3NCTHR1S2ttMUVn?=
 =?utf-8?B?WWhRTlpza1RtUWE1bTd1b2tYY3VKaUgvSkR1b2VaSWJpNnV4bmRZaXNubnFL?=
 =?utf-8?B?WVlDc2ZWMmlzeTY3Q0xmMkR5QWVZT1dCOC9XNlBXK1F5NVU0V3QxUkxHVUs5?=
 =?utf-8?B?bjYzdzdnMUFIU1ZDSVRXUmp1U09NaXd4MlZ1S2JZRS9MVmQ4VzdaUzdkRUYy?=
 =?utf-8?B?UlNzYWVIeHZtL0NSeCsxUHVxUG5OZEUxRllnR0wxK3FkMm9DQkpmTHQvOVND?=
 =?utf-8?B?dFA3WkZ0aGowaW5vaTVJQ2VFdGpYRHY4MmsxM0M5bk5zQVhTZmFpOW5hZk11?=
 =?utf-8?B?a2hkTWRsU05odWZQREpCTGhQUzhCK25Fd1hHeC9oTXNUcGhGNmR2dm4raWh0?=
 =?utf-8?B?M2g2UXk1WXVZM0I3ZW5vTUpFZi9nPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E770D5FD7C97F1409863DD88909ED3AF@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 616611d0-89c2-4814-8a1c-08da01d4a98e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2022 13:56:51.4169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R1QXWQsBqKhHSslXQQdwJ7Ge3skuygSqbjZ5Z/H3Z3qqoeIcFfSQ691bt54CO74TFcPLS2HDhYmRfgLEGprjuOfHkPwmMTkJBhRHauRtmps=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB2457
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

T24gMDgvMDMvMjAyMiAxNTozMCwgUGV0ZXIgWmlqbHN0cmEgd3JvdGU6DQo+IC0tLSBhL2FyY2gv
eDg2L2tlcm5lbC9jcHUvY29tbW9uLmMNCj4gKysrIGIvYXJjaC94ODYva2VybmVsL2NwdS9jb21t
b24uYw0KPiBAQCAtNTkyLDYgKzU5NCwyNCBAQCBzdGF0aWMgX19pbml0IGludCBzZXR1cF9kaXNh
YmxlX3BrdShjaGFyDQo+ICBfX3NldHVwKCJub3BrdSIsIHNldHVwX2Rpc2FibGVfcGt1KTsNCj4g
ICNlbmRpZiAvKiBDT05GSUdfWDg2XzY0ICovDQo+ICANCj4gK3N0YXRpYyBfX2Fsd2F5c19pbmxp
bmUgdm9pZCBzZXR1cF9jZXQoc3RydWN0IGNwdWluZm9feDg2ICpjKQ0KPiArew0KPiArCXU2NCBt
c3IgPSBDRVRfRU5EQlJfRU47DQo+ICsNCj4gKwlpZiAoIUhBU19LRVJORUxfSUJUIHx8DQo+ICsJ
ICAgICFjcHVfZmVhdHVyZV9lbmFibGVkKFg4Nl9GRUFUVVJFX0lCVCkpDQo+ICsJCXJldHVybjsN
Cj4gKw0KPiArCXdybXNybChNU1JfSUEzMl9TX0NFVCwgbXNyKTsNCj4gKwljcjRfc2V0X2JpdHMo
WDg2X0NSNF9DRVQpOw0KPiArDQo+ICsJaWYgKCFpYnRfc2VsZnRlc3QoKSkgew0KPiArCQlwcl9l
cnIoIklCVCBzZWxmdGVzdDogRmFpbGVkIVxuIik7DQo+ICsJCXNldHVwX2NsZWFyX2NwdV9jYXAo
WDg2X0ZFQVRVUkVfSUJUKTsNCg0KVGhpcyBwYXRoIHdhbnRzIHRvIGNsZWFyIENSNC5DRVQgb3Ig
TVNSX1NfQ0VULCBvciBib3RoLg0KDQo+ICsJCXJldHVybjsNCj4gKwl9DQo+ICt9DQo+ICsNCj4g
IC8qDQo+ICAgKiBTb21lIENQVSBmZWF0dXJlcyBkZXBlbmQgb24gaGlnaGVyIENQVUlEIGxldmVs
cywgd2hpY2ggbWF5IG5vdCBhbHdheXMNCj4gICAqIGJlIGF2YWlsYWJsZSBkdWUgdG8gQ1BVSUQg
bGV2ZWwgY2FwcGluZyBvciBicm9rZW4gdmlydHVhbGl6YXRpb24NCj4gLS0tIGEvYXJjaC94ODYv
a2VybmVsL3RyYXBzLmMNCj4gKysrIGIvYXJjaC94ODYva2VybmVsL3RyYXBzLmMNCj4gQEAgLTIx
MCw2ICsyMTAsODAgQEAgREVGSU5FX0lEVEVOVFJZKGV4Y19vdmVyZmxvdykNCj4gIAlkb19lcnJv
cl90cmFwKHJlZ3MsIDAsICJvdmVyZmxvdyIsIFg4Nl9UUkFQX09GLCBTSUdTRUdWLCAwLCBOVUxM
KTsNCj4gIH0NCj4gIA0KPiArI2lmZGVmIENPTkZJR19YODZfS0VSTkVMX0lCVA0KPiArDQo+ICtz
dGF0aWMgX19yb19hZnRlcl9pbml0IGJvb2wgaWJ0X2ZhdGFsID0gdHJ1ZTsNCj4gKw0KPiArdm9p
ZCBpYnRfc2VsZnRlc3RfaXAodm9pZCk7IC8qIGNvZGUgbGFiZWwgZGVmaW5lZCBpbiBhc20gYmVs
b3cgKi8NCj4gKw0KPiArZW51bSBjcF9lcnJvcl9jb2RlIHsNCj4gKwlDUF9FQyAgICAgICAgPSAo
MSA8PCAxNSkgLSAxLA0KPiArDQo+ICsJQ1BfUkVUICAgICAgID0gMSwNCj4gKwlDUF9JUkVUICAg
ICAgPSAyLA0KPiArCUNQX0VOREJSICAgICA9IDMsDQo+ICsJQ1BfUlNUUk9SU1NQID0gNCwNCj4g
KwlDUF9TRVRTU0JTWSAgPSA1LA0KPiArDQo+ICsJQ1BfRU5DTAkgICAgID0gMSA8PCAxNSwNCj4g
K307DQo+ICsNCj4gK0RFRklORV9JRFRFTlRSWV9FUlJPUkNPREUoZXhjX2NvbnRyb2xfcHJvdGVj
dGlvbikNCj4gK3sNCj4gKwlpZiAoIWNwdV9mZWF0dXJlX2VuYWJsZWQoWDg2X0ZFQVRVUkVfSUJU
KSkgew0KPiArCQlwcl9lcnIoIlVuZXhwZWN0ZWQgI0NQXG4iKTsNCj4gKwkJQlVHKCk7DQo+ICsJ
fQ0KPiArDQo+ICsJaWYgKFdBUk5fT05fT05DRSh1c2VyX21vZGUocmVncykgfHwgKGVycm9yX2Nv
ZGUgJiBDUF9FQykgIT0gQ1BfRU5EQlIpKQ0KPiArCQlyZXR1cm47DQoNCklzIHRoaXMgd2lzZT/C
oCAjQ1AgaXMgYSBmYXVsdCwgc28gdGhpcyB3aWxsIGxpdmVsb2NrLg0KDQp1c2VyX21vZGUoKSB3
YW50cyB0byB0dXJuIGludG8gYW4gb29wcy7CoCBLZXJuZWwgcHJvYmFibHkgd2FudHMgdG8gZm9s
ZA0KaW50byB0aGUgVW5leHBlY3RlZCAjQ1AgcGF0aCwgYnV0IGRlZmluaXRlbHkgcHJpbnQgdGhl
IGVycm9yIGNvZGUuDQoNCn5BbmRyZXcNCg0KPiArDQo+ICsJaWYgKHVubGlrZWx5KHJlZ3MtPmlw
ID09ICh1bnNpZ25lZCBsb25nKWlidF9zZWxmdGVzdF9pcCkpIHsNCj4gKwkJcmVncy0+YXggPSAw
Ow0KPiArCQlyZXR1cm47DQo+ICsJfQ0KPiArDQo+ICsJcHJfZXJyKCJNaXNzaW5nIEVOREJSOiAl
cFNcbiIsICh2b2lkICopaW5zdHJ1Y3Rpb25fcG9pbnRlcihyZWdzKSk7DQo+ICsJaWYgKCFpYnRf
ZmF0YWwpIHsNCj4gKwkJcHJpbnRrKEtFUk5fREVGQVVMVCBDVVRfSEVSRSk7DQo+ICsJCV9fd2Fy
bihfX0ZJTEVfXywgX19MSU5FX18sICh2b2lkICopcmVncy0+aXAsIFRBSU5UX1dBUk4sIHJlZ3Ms
IE5VTEwpOw0KPiArCQlyZXR1cm47DQo+ICsJfQ0KPiArCUJVRygpOw0KPiArfQ0KPiArDQo+ICti
b29sIGlidF9zZWxmdGVzdCh2b2lkKQ0KPiArew0KPiArCXVuc2lnbmVkIGxvbmcgcmV0Ow0KPiAr
DQo+ICsJYXNtICgiCWxlYSBpYnRfc2VsZnRlc3RfaXAoJSVyaXApLCAlJXJheFxuXHQiDQo+ICsJ
ICAgICBBTk5PVEFURV9SRVRQT0xJTkVfU0FGRQ0KPiArCSAgICAgIglqbXAgKiUlcmF4XG5cdCIN
Cj4gKwkgICAgICJpYnRfc2VsZnRlc3RfaXA6XG5cdCINCj4gKwkgICAgIFVOV0lORF9ISU5UX0ZV
TkMNCj4gKwkgICAgIEFOTk9UQVRFX05PRU5EQlINCj4gKwkgICAgICIJbm9wXG5cdCINCj4gKw0K
PiArCSAgICAgOiAiPWEiIChyZXQpIDogOiAibWVtb3J5Iik7DQo+ICsNCj4gKwlyZXR1cm4gIXJl
dDsNCj4gK30NCj4gKw0KPiArc3RhdGljIGludCBfX2luaXQgaWJ0X3NldHVwKGNoYXIgKnN0cikN
Cj4gK3sNCj4gKwlpZiAoIXN0cmNtcChzdHIsICJvZmYiKSkNCj4gKwkJc2V0dXBfY2xlYXJfY3B1
X2NhcChYODZfRkVBVFVSRV9JQlQpOw0KPiArDQo+ICsJaWYgKCFzdHJjbXAoc3RyLCAid2FybiIp
KQ0KPiArCQlpYnRfZmF0YWwgPSBmYWxzZTsNCj4gKw0KPiArCXJldHVybiAxOw0KPiArfQ0KPiAr
DQo+ICtfX3NldHVwKCJpYnQ9IiwgaWJ0X3NldHVwKTsNCj4gKw0KPiArI2VuZGlmIC8qIENPTkZJ
R19YODZfS0VSTkVMX0lCVCAqLw0KPiArDQo+ICAjaWZkZWYgQ09ORklHX1g4Nl9GMDBGX0JVRw0K
PiAgdm9pZCBoYW5kbGVfaW52YWxpZF9vcChzdHJ1Y3QgcHRfcmVncyAqcmVncykNCj4gICNlbHNl
DQo+DQo+DQoNCg==
