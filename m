Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C08C5B1F8D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 15:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbiIHNqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 09:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbiIHNqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 09:46:42 -0400
Received: from esa1.hc3370-68.iphmx.com (esa1.hc3370-68.iphmx.com [216.71.145.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52733E2900
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 06:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1662644799;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=bWQyVwu6u3+tkLFzT8Es85/mha6K3f/9GHYIoluCpEE=;
  b=ARMVFjCxkOxCREFLL7NIvlD7EzemV/IkHDb529iBPCmudHIz4MDN5t3W
   MaN0HhdenpppmQfT4DGIy0Qqq7IakUw5wc/oLYjmRiQfo2G0Xze+36OSO
   6HkCTuWBmAVrcw/54bYwQzPlT0JixFkEpz2YwM+8XbDqqKOn7Dr3kS9TG
   8=;
X-IronPort-RemoteIP: 104.47.66.47
X-IronPort-MID: 80503264
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:TCWj9aiOaePm9ggWR5pteJzeX161FRAKZh0ujC45NGQN5FlHY01je
 htvCDiFP/2MZzDwfd4kat6yoBtUvJfXmN9gTVc+qy1kRC0b9cadCdqndUqhZCn6wu8v7a5EA
 2fyTvGacajYm1eF/k/F3oDJ9CU6j+fQLlbFILasEjhrQgN5QzsWhxtmmuoo6qZlmtH8CA6W0
 T/Ii5S31GSNhnglaQr414rZ8Ek15KWq6GtC1rADTasjUGH2xiF94K03fcldH1OgKqFIE+izQ
 fr0zb3R1gs1KD90V7tJOp6iGqE7aua60Tqm0xK6aID76vR2nQQg075TCRYpQRw/ZwNlPTxG4
 I4lWZSYEW/FN0BX8QgXe0Ew/ypWZcWq9FJbSJQWXAP6I0DuKhPRL/tS4E4eP9UgyMZsXHpy0
 scpKGAjZwi+heG53+fuIgVsrpxLwMjDGqo64ysl6A6DSPEsTNbEXrnA4sJe0HEonMdSEP3CZ
 s0fLz1ycBDHZB4JMVASYH48tL7w2j+jLHsG9hTJ+sLb4ECKpOB1+JHrPMDYZZqhQsJNk1zDj
 mnH4374ElcRM9n3JT+toirx3rSVw3+TtIQ6GaG0raNNrw2pzG0wUw8ZFgqljOi+oxvrMz5YA
 wlOksY0loAq/VOiSJ/+QhixujiLowYAUvJUEusn+EeMzLbZ50CSAW1sZiZMdNE8puc3QzIw3
 1OElt+vAiZg2JWVRX+S8bqYoBuoNCQVJHNEbigBJSMf6tfqrYUbjR/VSNtnVqmvgbXdATjuz
 jSisSMhwb4B5eYX2KGr1VTGhS+wvJ/PTx5z6gi/dmek6Ax+TJSoa4yh9R7Q6vMoBIyBZlCFv
 XUCy46S4YgmAZiTmWqNSeMWEbeB4/eDLS2agFhzEp1n/DOok1ajZYl48iBiI10vOcEBERf5M
 BH7ug5L4pJXenywYsdfZ4O3FtRvzqX6E9nhfu7bY8AIYZVrcgKDuiZ0aia402nznQ4smKckN
 JGzcMCwAHJcAqNipAdaXM8Y2L4vgyUhn2XaQMmhywz9iebBInmIVb0CLV2CKPgj67+JqxnU9
 NAZMNaWzxJYU6v1ZSy/HZMvEG3m5EMTXfjew/G7vMbZSua6MAnN08Ps/I4=
IronPort-HdrOrdr: A9a23:/CGoUa80ClaJ+g+iq9Buk+F7db1zdoMgy1knxilNoENuH/Bwxv
 rFoB1E73TJYW4qKQodcdDpAtjifZtFnaQFrLX5To3SJjUO31HYYL2KjLGSiQEIfheTygcz79
 YGT0ETMrzN5B1B/L7HCWqDYpkdKbu8gcaVbI7lph8DIz2CKZsQljuRYTzrcHGeMTM2YabRY6
 Dsg/avyQDBRV0nKuCAQlUVVenKoNPG0Lj8ZwQdOhIh4A6SyRu19b/TCXGjr1YjegIK5Y1n3X
 nOkgT/6Knmmeq80AXg22ja6IkTsMf9y+FEGNeHhqEuW3XRY0eTFcdcso+5zXUISdKUmRIXeR
 730lAd1vFImjHsl6eO0F3QMkfboW8TAjTZuCKlaDPY0LDErXQBeoR8bMtiA2XkAwBLhqAC7I
 tbm22erJZZFhXGgWD04MXJTQhjkg6urWMlivN7tQ0XbWIyUs4nkWUkxjIiLL4QWCbhrIw3Gu
 hnC8/RoP5QbFOBdnjc+m1i2salUHg/FgqPBhFqgL3f7xFG2HRii0cIzs0WmXkNsJo7Vplf/u
 zBdqBljqtHQMMaZb90QO0BXcy0AGrQRg+kChPbHX33UKUcf37doZ/+57s4oOmsZZwT1ZM33I
 /MVVtJ3FRCD34Gyff+qaGj3iq9MFlVBw6du/22z6IJyYHUVf7sLTCJTkwono+pv+gfa/erKc
 qOBA==
X-IronPort-AV: E=Sophos;i="5.93,300,1654574400"; 
   d="scan'208";a="80503264"
Received: from mail-mw2nam12lp2047.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.47])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Sep 2022 09:46:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gbkaMzjpX8NyTTo1E/8f7hBDbZCCqlYO5dfAFx7u6h2MVnmILvilSRHUrnXMldUW187gnHkDMhzUAG5aFEFmSPXvfdpwo3MyUQNHvXncrl0AvYNP5wxjUjX9rJvNditA9JGlf/6UiIlwpCBoJ4jYQD3HWsJQAYtdwxpN31+lUvczfet7z/HhcXtCG6bdODw85GObfzMuu/Zqsdap0kXfXeDw6n/g/IksyrrGxQHUozsj6ELzu7cZnRqcUNGFYsO0TjB9KUI9AMENIZMgtt7OEAW0re8FnIRZYUx9lBNVHINGg2eifA8AYis03z0c96Y0yNGqY4dDhUqj92YFNkfrSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bWQyVwu6u3+tkLFzT8Es85/mha6K3f/9GHYIoluCpEE=;
 b=n+G045rwq2iJLy53UgaVccz96NpV1KHjZjtrcfvxnAyxxo/yWduEuI/aUrIG2C6U7w2qsf01enDgNAd5xLIsWOJicqLUcgsrTm4hnTvbm1548xu4AUk5OBEWcMGVn+NEKfqIBGH8u5VJVRqZohs1WueJYzlOYohJVHe59McJA+gcMrxaLAMcPiH0y7HQtgEFhv1xu/9Jr07DWszQYJ64dLeC5+WkbvB7pOTbXQyDPMV6j1xoxLYNWPGwXvxJNpWVPKc0wc6zkw2LypVUsKPd3sgP/TxI5VAJGLkX3Ul3hnRLDtuJ0Bzo/as32e8cUO7cpN+O0BRRjYJ3BW5in+WnxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bWQyVwu6u3+tkLFzT8Es85/mha6K3f/9GHYIoluCpEE=;
 b=olGvhsLhndDWgQqXAov0S2QMfXbhc+TQ8/SSIW8VtSJUqba5VyVu3DHjOBacjs30FtyjTb649oJ4sMqBSW3NG9G8ix9ksnKC8RcZ2Pgm/sBKGvQ44EhhWDCG9Y9sFiK4YW3d5qce7QDoayRO+Dg0GKtIPF+UInKjjeOvvdywwDo=
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by PH7PR03MB6862.namprd03.prod.outlook.com (2603:10b6:510:153::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.17; Thu, 8 Sep
 2022 13:46:34 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::b9c9:c866:817c:60dd]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::b9c9:c866:817c:60dd%4]) with mapi id 15.20.5588.018; Thu, 8 Sep 2022
 13:46:34 +0000
From:   Andrew Cooper <Andrew.Cooper3@citrix.com>
To:     Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH] x86/cpu: Avoid writing MSR_IA32_TSX_CTRL when writing it
 is not supported
Thread-Topic: [PATCH] x86/cpu: Avoid writing MSR_IA32_TSX_CTRL when writing it
 is not supported
Thread-Index: AQHYwkHHCzBeZjOWqECnhF3StKRjaa3TBEyAgAG0zYCAANUzgA==
Date:   Thu, 8 Sep 2022 13:46:34 +0000
Message-ID: <6049e5bc-122f-5b4c-c1dc-0591eccf3525@citrix.com>
References: <20220906201743.436091-1-hdegoede@redhat.com>
 <YxexAl+i+6MGjf7K@hirez.programming.kicks-ass.net>
 <6ff23930-325b-4207-12fc-4d8fd5bea1ff@redhat.com>
 <Yxe09Bk7tNwa6OsO@hirez.programming.kicks-ass.net>
 <c076b593-815b-f7b2-4eab-9d2087580a71@citrix.com>
 <20220908010329.rhetlp6plqlaiegf@desk>
In-Reply-To: <20220908010329.rhetlp6plqlaiegf@desk>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 78ffc5fa-ad3c-4ca4-ffab-08da91a08b40
x-ms-traffictypediagnostic: PH7PR03MB6862:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qunyF+C0kkPR+Qo2PLjtxUNtnkfjl+LDkKcEHLRM8mLOzo6QnFKkLIiA2uXNlDspddxMt9bgU0QZdYV5MTyddsf8ONotmPbhl81FDoxt7BBLEGXTui0LN+2S3h3VjiIJI/5DfXu6uLaYKQSOfRpWuZJCwvtjPFbyNlYSV5KmbYpxNKt7HyIO+7AEWUEQh0yNw0Btw92m7jIzPwhNleuYLXydnMtZ3LN+HB3pXMEx3dm7zN2lSM89byVoE/RQPRVcq8nxw8vvpYeTzvmEImE/FHkSbKehsmnsUXlekgy8quR7Lj2GmMtvSqNmCbJ4bT8FalXBVLto0QCInYvTowoAGafIFghHI6E9YFfZSh966r5lz/07wb3Mtp09GctQABB3MkaDqqa9pv7goDYz+mu+bFTI9g9Oyf3EXbcbnOcTbds7m1DSo4mslc/qsGiPwv7vn6Zpx7SEhRLwjx/dps9fVT9R3q0htOrFJLZ1yHgIFjcJK8wbht6ZE+6maPJMFAiqJpcyOa8dwTcNa1Xcy12KwgJPEOCv1hewlfILeMVK2JoDhcAitOXFfWayZgi7V2xWCh1Ku7LSkw7qV0l0z/I3Qqb1vYYgGdfNWxUTErslDc+9UCdymtfYwM/e8yL4VfSm2vJ2R/foeth6noxzq151DW2zeCZ0nFz9tv52Dbp4VHMjvd4dxdh0JieiXhzk3RYBgUK7G837iLz9ioMNtj5iOndKeJ6+hUAsy96u0syX4+aadofNrgv6fwULwxt2HKRmHF9IGe/xzsuiGons3Z8JJtEQAvoZShgCM+CVJ795upXSvnR9bRE0bwG5alOBwiSQmDqZrfA+O/PlYCwzDJT9CQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(396003)(376002)(346002)(366004)(8676002)(316002)(83380400001)(53546011)(478600001)(54906003)(6512007)(6506007)(26005)(36756003)(38070700005)(31696002)(5660300002)(86362001)(6916009)(2906002)(7416002)(8936002)(82960400001)(91956017)(66446008)(66946007)(66556008)(64756008)(76116006)(66476007)(122000001)(31686004)(41300700001)(71200400001)(186003)(4326008)(6486002)(2616005)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TEVOc0JLRlUzZGpYdWwxdHQ3L3F0WTNjbnBqRDRTV3VhUmxNTWoxZ0cyS2pz?=
 =?utf-8?B?VkxwOTZtdWp0S0lSU3lYYllOa3htdFA4d0xGM3JqaUJuUU4wM25zU213SnRR?=
 =?utf-8?B?Z245bGxDMDB3b1RFRTg5YVZZcjZjV1pGVm9PN0M5MXZFOVhKT3JjamdpQ0VI?=
 =?utf-8?B?SjVPcUpjQmtKaDVCM21yQnZCRFd5RFJTMzRCT3prTWpXMVorckNKVkRLa0N6?=
 =?utf-8?B?NGFVUHBjVEdaQmlyMzlXSzNjSVR4czhKRjdBVTduN0dGaUxpOHFjYlhzeEpm?=
 =?utf-8?B?S0dQd1o2THMwNXBmWUZONjhPekRmOXByNFRxTFdHSjhvZXJKOUZiTm90RFBa?=
 =?utf-8?B?dWxaNUFtaGYzZkxnY3FLWTdIWXBRc3duSCs4N3dzY1hRSGEya2JUbGlGU28r?=
 =?utf-8?B?emQ4SS9CbStlQ2cxRGtjR25jVWxlRi8vcVlJZnZOZmFaVlBXUy9tclAvQ2dq?=
 =?utf-8?B?dldFeWpWTWhvWTcyaHg3a1BOK3VacHdiQm5ER1lLTHhMQzFkYjJsTUdUc3ZS?=
 =?utf-8?B?d3k4Z21VUjJjT0lvMUVwUndCWXh4L29MbjlxY0dYNTN5Z2JkUFROc2RCMi91?=
 =?utf-8?B?SEwwelVtcERRT2dGdHZSdHBjNFhmb1hQZk1PQmFtS3N6RjRGNU9KNHQ2S2w4?=
 =?utf-8?B?cFZDd1NhaUdBQ3FQT0N6Uk5scVhHYUVRaEtNMFBoY1g1ajJUVFJmVEh3WTBx?=
 =?utf-8?B?M25UUUE2RENWM0RHUERoKzQrczVLQy9TeXcvZjY5a3plbGtvS2hRRjNCY3Rt?=
 =?utf-8?B?UVNuenowUk1WUlphckxGVHhTbldsSUQ3UUg3bDFpbnhLOWFOS2ZsQjNXNnVD?=
 =?utf-8?B?L0VsaUdQZ2pGT0I1TDhKayszSmdHbVloa3NrUmxMMVJOTll2N09MUVp6VzhW?=
 =?utf-8?B?N1p4dVVDVnZGNkUvZ0xWNURBS2c1Q24weUxMbm8rdGZoaklpa1djVW44NkUy?=
 =?utf-8?B?Uyt4V3VSbGtWM2RDcFFoUGFxSVNsT0hXZ1VUaktZSGMyQy9KMHYvSmFNUksr?=
 =?utf-8?B?dFFXWWxIRmxQVHdreSszcW9scExOcml6c0xpb1M5MWFweGRySkQwSWNEVFdy?=
 =?utf-8?B?YUtHM2JMR241Z1A1OE0vRXNBd3hTckZVUVowUXUybXVrcXcvdkNzbTZ6OVVN?=
 =?utf-8?B?WVIrMU5sbEsyc0pxT0Rncm9pMkQrRy9ObWw2T0lRRUd3WnBJaWFHSDdlcFpY?=
 =?utf-8?B?cEdQMjBxRVRvcEdoTVJ3dG5aOUVBR1B0SGVhTTlxeXZWSlhFWDREUG1WQ2VD?=
 =?utf-8?B?WFVPcktPNzJJQmZiZHBkUnJaRTFmM25VKzNXQ2FOTkk2b0d1NVl0VDBrRXNr?=
 =?utf-8?B?djd3R1JaZFVFVGxpak03ZjdwTmp4WktPRTdZYXNYTlJ2QnNJOUhpOFJ2YXgr?=
 =?utf-8?B?ZFhyQ2xrcnBQR24rWnFGSDFzWDRuZ1dwK0c2WXhWVkNzV0RyczU0QjdHSHpV?=
 =?utf-8?B?c3JQcHlSbGo2MHZVL3dGK1djRlZjaVpTNzZmeFBVbngvMzR2ZG5VSW96Tmtm?=
 =?utf-8?B?RTBvaGNJcFlDcXJtYTQ0Z0Z0N1k4TFE0bHZEdVlRc2hWc1VkUFNRTUxJc0dC?=
 =?utf-8?B?eVJKV1hmVEtOek9waHNTTVdJY0VBUGRsYzFJQnBWR1FLdVpyQWV4cFo4V2hW?=
 =?utf-8?B?Z0grYXpSN0hIblpyVmZQc3J0Um8rWEtPam8rRGt2L05hcE9lWVBaT0kxRzBQ?=
 =?utf-8?B?ck9OdUwvZTJQd1RGQVlkclZ5d3ZaYzlxSTFvdTVDSk5CUmhGUnJQTjNwTi9P?=
 =?utf-8?B?VWd4NTB3RldTbFR3TUg4VEhLalZvRk9VeGlRWkE5OU52SVl0Z043c2dzemNs?=
 =?utf-8?B?clVoWFhVdmZZR1g0VHdRak10N2ZlbXQ5eDZhd2NKYi80eGRETWpNTWdnZUxp?=
 =?utf-8?B?TWxOUUtTaEh2bW93VFk1ZjhKRHptUzhHVGhuRkxxVzJDQ2VDbWlYV1daRHFN?=
 =?utf-8?B?U0dCaURWUkNXT1pGOWNzMmc3MmJuVGxtbnRYZGJTTEJ3d09jREo1cW12aHZt?=
 =?utf-8?B?TkNuVEx2dmhCQXJ5YVlLWENna0FYVGVpUEJ0QVZyWktBUm1WK0FWM0RMVi9W?=
 =?utf-8?B?RHhFVFJTMlpsMHMvdnVjandYT2FYcnR2U3hwQTJMeHhxTEY3b1E0OWw3Si9s?=
 =?utf-8?Q?fkWXOv5sidUgRxisH+QzgOMPs?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <454DA3FA8A6F244EA9EAE7C1E56624FD@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78ffc5fa-ad3c-4ca4-ffab-08da91a08b40
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 13:46:34.2809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Td9v6WjjeDxjRqfULL+8uuqiQ16vgWvs+U6EH2B1kJcejZrtT+93dQVk0Rv3HpCmOzrkbS92W/3+wr91cWEANUV71+P5/fwPBrEMILdIhJM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB6862
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDgvMDkvMjAyMiAwMjowMywgUGF3YW4gR3VwdGEgd3JvdGU6DQo+IE9uIFR1ZSwgU2VwIDA2
LCAyMDIyIGF0IDExOjAwOjA4UE0gKzAwMDAsIEFuZHJldyBDb29wZXIgd3JvdGU6DQo+PiBPbiAw
Ni8wOS8yMDIyIDIyOjAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToNCj4+PiBPbiBUdWUsIFNlcCAw
NiwgMjAyMiBhdCAxMDo1Njo0N1BNICswMjAwLCBIYW5zIGRlIEdvZWRlIHdyb3RlOg0KPj4+PiBI
aSwNCj4+Pj4NCj4+Pj4gT24gOS82LzIyIDIyOjQzLCBQZXRlciBaaWpsc3RyYSB3cm90ZToNCj4+
Pj4+IE9uIFR1ZSwgU2VwIDA2LCAyMDIyIGF0IDEwOjE3OjQzUE0gKzAyMDAsIEhhbnMgZGUgR29l
ZGUgd3JvdGU6DQo+Pj4+Pj4gT24gYW4gSW50ZWwgQXRvbSBOMjYwMCAoYW5kIHByZXN1bWFibGUg
b3RoZXIgQ2VkYXIgVHJhaWwgbW9kZWxzKQ0KPj4+Pj4+IE1TUl9JQTMyX1RTWF9DVFJMIGNhbiBi
ZSByZWFkLCBjYXVzaW5nIHNhdmVkX21zci52YWxpZCB0byBiZSBzZXQgZm9yIGl0DQo+Pj4+Pj4g
YnkgbXNyX2J1aWxkX2NvbnRleHQoKS4NCj4+Pj4+Pg0KPj4+Pj4+IFRoaXMgY2F1c2VzIHJlc3Rv
cmVfcHJvY2Vzc29yX3N0YXRlKCkgdG8gdHJ5IGFuZCByZXN0b3JlIGl0LCBidXQgd3JpdGluZw0K
Pj4+Pj4+IHRoaXMgTVNSIGlzIG5vdCBhbGxvd2VkIG9uIHRoZSBJbnRlbCBBdG9tIE4yNjAwIGxl
YWRpbmcgdG86DQo+Pj4+PiBGV0lXLCB2aXJ0IHRlbmRzIHRvIGRvIHRoaXMgc2FtZSB0aGluZyBh
IGxvdC4gVGhleSdsbCBhbGxvdyByZWFkaW5nDQo+Pj4+PiByYW5kb20gTVNScyBhbmQgb25seSBm
YWlsIG9uIHdyaXRlLg0KPj4+PiBSaWdodC4gU28gSSBndWVzcyBJIHNob3VsZCBzZW5kIGEgdjIg
d2l0aCBhbiB1cGRhdGVkIGNvbW1pdA0KPj4+PiBtZXNzYWdlIG1lbnRpb25pbmcgdGhpcyA/DQo+
Pj4gTmFoLCBqdXN0IHNheWluZyB0aGlzIGlzIGEgc29tZXdoYXQgY29tbW9uIHBhdHRlcm4gd2l0
aCBNU1JzLg0KPj4+DQo+Pj4gVGhlIGJlc3Qgb25lcyBhcmUgdGhlIG9uZSB3aGVyZSB3cml0aW5n
IHRoZSB2YWx1ZSByZWFkIGlzIGludmFsaWQgOi8gb3INCj4+PiB0aG9zZSB3aG8gYWxzbyBzaWxl
bnRseSBlYXQgYSAwIHdyaXRlIGp1c3QgZm9yIGdpZ2dsZXMuIEx1Y2tpbHkgdGhhdA0KPj4+IGRv
ZXNuJ3QgaGFwcGVuIG9mdGVuLg0KPj4gU2V2ZXJhbCBjb21tZW50cy7CoCBGaXJzdCBvZiBhbGws
IE1TUl9UU1hfQ1RSTCBpcyBhIGZ1bGx5IHJlYWQvd3JpdGUNCj4+IE1TUi7CoCBJZiB2aXJ0IGlz
IGRvaW5nIHRoaXMgd3JvbmcsIGZpeCB0aGUgaHlwZXJ2aXNvci7CoCBCdXQgdGhpcyBkb2Vzbid0
DQo+PiBsb29rIHZpcnQgcmVsYXRlZD8NCj4+DQo+PiBNb3JlIGltcG9ydGFudGx5LCBNU1JfVFNY
X0NUUkwgZG9lcyBub3QgcGxhdXNpYmx5IGV4aXN0IG9uIGFuIEF0b20NCj4+IE4yNjAwLCBhcyBp
dCBpcyBtb3JlIHRoYW4gYSBkZWNhZGUgb2xkLg0KPj4NCj4+IE1TUl9UU1hfQ1RSTCB3YXMgcmV0
cm9maXR0ZWQgaW4gbWljcm9jb2RlIHRvIHRoZSBNRFNfTk8sIFRBQS12dWxuZXJhYmxlDQo+PiBD
UFVzIHdoaWNoIGlzIGEgdmVyeSBuYXJyb3cgcmFuZ2UgZnJvbSBhYm91dCAxIHF1YXJ0ZXIgb2Yg
MjAxOSB3aGljaA0KPj4gaW5jbHVkZXMgQ2FzY2FkZSBMYWtlLCBhbmQgdGhlbiBpbmNsdWRlZCBh
cmNoaXRlY3R1cmFsbHkgb24gc3Vic2VxdWVudA0KPj4gcGFydHMgd2hpY2ggc3VwcG9ydCBUU1gu
DQo+Pg0KPj4gcG1fc2F2ZV9zcGVjX21zcigpIGlzIHRvdGFsbHkgYnJva2VuLsKgIEl0J3MgcG9r
aW5nIE1TUnMgYmxpbmRseSB3aXRob3V0DQo+PiBjaGVja2luZyB0aGUgZW51bWVyYXRpb24gb2Yg
dGhlIGNhcGFiaWxpdHkgZmlyc3QuDQo+IHBtX3NhdmVfc3BlY19tc3IoKSByZWxpZXMgb24gdmFs
aWQtbXNyLWNoZWNrIGluIGJ1aWxkX21zcl9jb250ZXh0KCksIGJ1dA0KPiBvYnZpb3VzbHkgaXQg
aXMgbm90IHdvcmtpbmcgaW4gdGhpcyBwYXJ0aWN1bGFyIGNhc2UuDQo+DQo+IERvZXMgYWRkaW5n
IHRoZSBlbnVtZXJhdGlvbiBjaGVjayBhcyBiZWxvdyBsb29rcyBva2F5Og0KPg0KPiAoSSBhbSBu
b3Qgc3VyZSBpZiBJIGdvdCB0aGUgZW51bWVyYXRpb24gcmlnaHQgZm9yIE1TUl9BTUQ2NF9MU19D
RkcpLg0KDQpmYW1pbHkgPj0gMHgxMCAmJiBmYW1pbHkgPD0gMHgxOA0KDQo+DQo+IC0tLQ0KPiBk
aWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVkZS9hc20vY3B1LmggYi9hcmNoL3g4Ni9pbmNsdWRl
L2FzbS9jcHUuaA0KPiBpbmRleCA4Y2JmNjIzZjBlY2YuLmE3NTBjMWExOTY0YiAxMDA2NDQNCj4g
LS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20vY3B1LmgNCj4gKysrIGIvYXJjaC94ODYvaW5jbHVk
ZS9hc20vY3B1LmgNCj4gQEAgLTc2LDYgKzc2LDggQEAgc3RhdGljIGlubGluZSB2b2lkIGluaXRf
aWEzMl9mZWF0X2N0bChzdHJ1Y3QgY3B1aW5mb194ODYgKmMpIHt9DQo+ICANCj4gIGV4dGVybiBf
X25vZW5kYnIgdm9pZCBjZXRfZGlzYWJsZSh2b2lkKTsNCj4gIA0KPiArZXh0ZXJuIGJvb2wgc3Bl
Y19tc3JfdmFsaWQodTMyIG1zcl9pZCk7DQo+ICsNCj4gIHN0cnVjdCB1Y29kZV9jcHVfaW5mbzsN
Cj4gIA0KPiAgaW50IGludGVsX2NwdV9jb2xsZWN0X2luZm8oc3RydWN0IHVjb2RlX2NwdV9pbmZv
ICp1Y2kpOw0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2NwdS9jb21tb24uYyBiL2Fy
Y2gveDg2L2tlcm5lbC9jcHUvY29tbW9uLmMNCj4gaW5kZXggM2U1MDhmMjM5MDk4Li43NDMwYTM2
ZmQ3YWUgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9jcHUvY29tbW9uLmMNCj4gKysr
IGIvYXJjaC94ODYva2VybmVsL2NwdS9jb21tb24uYw0KPiBAQCAtMTI3OCw2ICsxMjc4LDI2IEBA
IHN0YXRpYyBib29sIF9faW5pdCBjcHVfbWF0Y2hlcyhjb25zdCBzdHJ1Y3QgeDg2X2NwdV9pZCAq
dGFibGUsIHVuc2lnbmVkIGxvbmcgd2hpDQo+ICAJcmV0dXJuIG0gJiYgISEobS0+ZHJpdmVyX2Rh
dGEgJiB3aGljaCk7DQo+ICB9DQo+ICANCj4gK2Jvb2wgc3BlY19tc3JfdmFsaWQodTMyIG1zcl9p
ZCkNCj4gK3sNCj4gKwl1NjQgaWEzMl9jYXAgPSB4ODZfcmVhZF9hcmNoX2NhcF9tc3IoKTsNCj4g
Kw0KPiArCXN3aXRjaCAobXNyX2lkKSB7DQo+ICsJY2FzZSBNU1JfSUEzMl9TUEVDX0NUUkw6DQo+
ICsJCXJldHVybiBib290X2NwdV9oYXMoWDg2X0ZFQVRVUkVfTVNSX1NQRUNfQ1RSTCk7DQo+ICsJ
Y2FzZSBNU1JfSUEzMl9UU1hfQ1RSTDoNCj4gKwkJcmV0dXJuICEhKGlhMzJfY2FwICYgQVJDSF9D
QVBfVFNYX0NUUkxfTVNSKTsNCj4gKwljYXNlIE1TUl9UU1hfRk9SQ0VfQUJPUlQ6DQo+ICsJCXJl
dHVybiBib290X2NwdV9oYXMoWDg2X0ZFQVRVUkVfVFNYX0ZPUkNFX0FCT1JUKTsNCj4gKwljYXNl
IE1TUl9JQTMyX01DVV9PUFRfQ1RSTDoNCj4gKwkJcmV0dXJuIGJvb3RfY3B1X2hhcyhYODZfRkVB
VFVSRV9TUkJEU19DVFJMKTsNCj4gKwljYXNlIE1TUl9BTUQ2NF9MU19DRkc6DQo+ICsJCXJldHVy
biBib290X2NwdV9oYXMoWDg2X0ZFQVRVUkVfTFNfQ0ZHX1NTQkQpOw0KPiArCX0NCj4gKw0KPiAr
CXJldHVybiBmYWxzZTsNCj4gK30NCj4gKw0KPiAgdTY0IHg4Nl9yZWFkX2FyY2hfY2FwX21zcih2
b2lkKQ0KPiAgew0KPiAgCXU2NCBpYTMyX2NhcCA9IDA7DQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4
Ni9wb3dlci9jcHUuYyBiL2FyY2gveDg2L3Bvd2VyL2NwdS5jDQo+IGluZGV4IGJiMTc2YzcyODkx
Yy4uOGRiNzNmNzk4MmM3IDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9wb3dlci9jcHUuYw0KPiAr
KysgYi9hcmNoL3g4Ni9wb3dlci9jcHUuYw0KPiBAQCAtNTIwLDggKzUyMCwxMiBAQCBzdGF0aWMg
dm9pZCBwbV9zYXZlX3NwZWNfbXNyKHZvaWQpDQo+ICAJCU1TUl9JQTMyX01DVV9PUFRfQ1RSTCwN
Cj4gIAkJTVNSX0FNRDY0X0xTX0NGRywNCg0KQ2hlY2tpbmcgdGhlIGVudW1lcmF0aW9ucyBpcyBk
ZWZpbml0ZWx5IGFuIGltcHJvdmVtZW50LCBidXQgdGhpcyB3YW50cw0KdG8gYmVjb21lIGEgdHVw
bGUgbGlzdCBvZiB7IG1zciwgZmxhZyB9IHNvIGl0IGNhbid0IGdldCBvdXQgb2Ygc3luYy4NCg0K
RXhjZXB0IHR3byBvZiB0aGUgb3B0aW9ucyBhcmVuJ3Qgc2ltcGxlIGJpdHMuwqAgVGhlIGNvbnRl
bnRzIG9mDQpNU1JfQVJDSF9DQVBTIG91Z2h0IHRvIGJlY29tZSBmZWF0dXJlIGJpdHMgYmVjYXVz
ZSBpdCdzIGEgQ1BVSUQgZmVhdHVyZQ0KbGVhZiBpbiBkaXNndWlzZS4NCg0KQU1EIExTX0NGRyBp
cyBtb3JlIGNvbXBsaWNhdGVkLCBiZWNhdXNlIHRoZSBkaXNwYXRjaCBzZXJpYWxpc2luZyBiaXQN
Cm5lZWRzIHNldHRpbmcgdW5pbGF0ZXJhbGx5IChmYW1pbGllcyAweDEwLCAweDEyIHRocnUgMHgx
OCksIGJ1dCB0aGUgU1NCRA0KY29udHJvbCBvdWdodCB0byByZXNvbHZlIG9uIHRoZSBuZXh0IGNv
bnRleHQgc3dpdGNoLg0KDQp+QW5kcmV3DQo=
