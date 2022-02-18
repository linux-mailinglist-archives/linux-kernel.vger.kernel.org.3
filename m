Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 598794BC2C1
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 00:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234688AbiBRXHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 18:07:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiBRXHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 18:07:41 -0500
Received: from esa5.hc3370-68.iphmx.com (esa5.hc3370-68.iphmx.com [216.71.155.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441205717A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 15:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1645225642;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/Z1vmXezx1Tjuph05ctlsZAYElxNul+y7mi+yXo4CII=;
  b=aT2aXkiTQQxsMY1xdrCQVzUF75fcye+6liGUCgMqfH6XV79+QS4vXMdp
   KSYFrFHt+ImIlf3gDegSg+EpAbzOPTnE1kyl7dvfMudHWXBX3kpR63lxJ
   NUE5mPCw5gY+6oqID2trZvr1n4rFD85dwB9Bpbu7D7vf8lqI167pr9Xq2
   o=;
Authentication-Results: esa5.hc3370-68.iphmx.com; dkim=pass (signature verified) header.i=@citrix.onmicrosoft.com
X-SBRS: 5.1
X-MesageID: 63995124
X-Ironport-Server: esa5.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.83
X-Policy: $RELAYED
IronPort-Data: A9a23:xYgiCatugNNDpKqI9JL2c+Ss0+fnVClZMUV32f8akzHdYApBsoF/q
 tZmKWzXbPmOYGD2edokPouy8EkHscPRmNVmSwU6rSswRn8b+JbJXdiXEBz9bniYRiHhoOOLz
 Cm8hv3odp1coqr0/0/1WlTZhSAgk/nOHNIQMcacUsxLbVYMpBwJ1FQzy4bVvqYy2YLjW1nU6
 YupyyHiEATNNwBcYzp8B52r8HuDjNyq0N/PlgVjDRzjlAa2e0g9VPrzF4noR5fLatA88tqBb
 /TC1NmEElbxpH/BPD8HfoHTKSXmSpaKVeSHZ+E/t6KK2nCurQRquko32WZ1he66RFxlkvgoo
 Oihu6BcRi8JMZCWxvoldCNHOC9OJrFk3rjGfFyg5Jn7I03uKxMAwt1rBUAye4YZ5vx2ESdF8
 vlwxDIlN07ZwbjsmfTiF7cq1p9LwMrDZevzvllJyz3DAOlgapfEW6jQvvdT3Ssqh9AIFvHbD
 yYcQWQ0PUWdOkcTUrsRIIpntcKwiSnTSGxBo0Okne1nxDmKlSUkhdABN/KKI4fXFK25hH2wv
 WvD/nj+Bg8TMtGZ4TWC9X2oi6nEmiaTcIEfGaaz8flpqFaT3GsWCQATE1yhrpGRjEKzQNtCL
 0oV9zA1hac180OvQ5/2WBjQiHqZohk0WNdKFeA+rgaXxcL86gKIHXMNCDtAbNY7rskeRDo22
 1vPlNTsbRRquaeWD2iA6rOdqz+aMDIQa2QFYEcsSQoD/smmo4wpiB/LZshsHbTzjdDvHzz0h
 TeQo0AWhbIaiuYMyaih8UrGnT+0p4rbR0g+4QC/dnL1sCt6aZSjaoju7kLUhd5YIZqUVEupv
 X4KgcGS4ekCS5aXm0SlQuoXG6qyz+2YKzCaillqd7Ej7zOs/nSkcKhK7T1+LVsvOcEBERfpY
 kuVpQRW4IR7M36jbKsxaIW0Y/nG1oC5S46jDKqNKIMTPN4hL2dr4R2Ce2aw0F23zlYUtpsgE
 pmratqOK3EbVIB4mW/eq/gm7ZcnwSU3xGX2TJ/9zgi63bf2WEN5WYvpI3PVMLlnsfrsTBH9t
 o8GapDUk0k3vPjWP3GPmbP/O2zmOpTS6Xrej8VMPtCOLQN9cI3KI6+AmOhxE2CJckk8qwspw
 p1fchIAoLYcrSeeQelvVpyFQOmzNXqYhShmVRHAxX7yhxAejX+Htc/zjacfc7g97/BExvVpV
 fQDcMjoKq0RFmmdomxGM8Og9d0KmPGXaeSmZXbNjN8XJcMIeuA00oW8IluHGNcmVUJbSvfSU
 5X/j1iGEPLvtixpDdrMaeLH8r9ClSN1pQ6GZGOReoM7UBy1qOBCcnWt5tdqc5BkAUiSnVOyi
 lfJaSr0UMGQ+ufZBvGS3vvax2poesMjdndn857zt+jubnCCpjL5qWKCOc7RFQ3guKrP0PzKT
 c1ezu3mMe1Bm1BPsoFmFK1sw7547Nzqz4K2BCw+dJkXRzxH0o9dH0Q=
IronPort-HdrOrdr: A9a23:0hvhq6PILWeCIcBcT2f155DYdb4zR+YMi2TDiHoedfUFSKOlfp
 6V8MjzjSWE9Ar4WBkb6LS90DHpewKcyXcH2/hvAV7EZninhILIFvAt0WKG+Vzd8kLFh5ZgPM
 tbAspD4ZjLfCVHZKXBkUqF+rQbsaK6GcmT7I+0pRoMPGJXguNbnn1E426gYxBLrWJ9dP0E/e
 +nl7N6Tk2bCBIqh6qAdxw4dtmGg+eOuIPtYBYACRJiwhKJlymU5LnzFAXd9gsCUhtUqI1Ss1
 Ttokjc3OGOovu7whjT2yv49JJNgubszdNFGYilltUVEDPxkQylDb4RHoFq/QpF5N1H2mxa1u
 UkkC1QZvibLEmhJl1dlCGdnDUIFgxesEMKh2Xo20cL6vaJOg7SQ/Ax9L6xNCGpt3bI9esMo5
 6ilQiixupqJAKFkyLn69fSURZ20kKyvHo5iOYWy2dSSI0EddZq3MEiFW5uYdw99RjBmcoa+S
 hVfbbhzecTdUnfY2HSv2FpztDpVnMvHg2eSkxHvsCOyTBZkH1w0kNdnaUk7zg93YN4T4MB6/
 XPM6xumr0LRsgKbbhlDONERcesEGTCTR/FLWrXK1X6E6MMPW7LtvfMkfkIzfDvfIZNwIo5mZ
 zHXl8dvWkue1j2AcnLx5FP+gClehT0Yd0s8LAW23FUgMyIeFPbC1z0dLl1qbrTnxw2OLyuZ8
 qO
X-IronPort-AV: E=Sophos;i="5.88,380,1635220800"; 
   d="scan'208";a="63995124"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=arU/owJmrTxsxBbiogMTOM52Exzy9PixW0LrJ3ELLpwEjSpHeL8qHXgyguHAVp7G8XTdpn0uPznQ7A2ObM1idMRCDoAQ6JVa+HOXFZcG47IXnhoqcmsYKm+d5/y6/Vx4xq70IYI0Hf9IM+hJemykPfMyK5qVv/40bjaMMi6pKo6A8VRCbciQvXMieeya8VLxFZoXjnNN3mUIPbBdBTdZ1mdBxM+vVWDqByftPnzFc7h4Sxi8HuxgsHkBG9rORTMf4sG4BJ015gnT9W7w/RHr5IH0d7PN7p0qyVOcjJep7H6ZBZOxKfHQ+i6RwhTm6NsKe+1G6J6Ofi35lDi9zaLP3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Z1vmXezx1Tjuph05ctlsZAYElxNul+y7mi+yXo4CII=;
 b=jv2bzJOsS0GClts9bkEnqInzxqgtda+MjYLCp6KvI5sFlnf8URz3B8AjNGxCU8LmPg0ai0uApzg+fIkB2RDkFoPraQTHw7krcH2PxdCf4+qHMuPSnZ2tL2Wczf97E9jR++b9qxxqVzUgcHASERwlbqLCT9m+QxcuvKwp1Orc/uHnlkJcZxpZSNZXV+CgbOTw1KeiRbojGVv1lnBRziLs+NqHWmg8WwrdOIA5fjKMyPgB6r+63QqGEKySyv5AYlvouh91K9rv6i2n1kBZnuhjQ2YN9hom2s3Mk+JMo4Ki3gZHQy/hTn5cWNtgQDz6tJzvAoZg0uLJ6dUg6vcwcnPR1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Z1vmXezx1Tjuph05ctlsZAYElxNul+y7mi+yXo4CII=;
 b=u3SVfafS/eWTDDmDIN7SxyaGrUBLslD1wf+A8Q8P1OEWGugg6H4O4UEM+mW+AUmc5PLCke9pQNlPiaNstRP11TJ+5yY5qyygIYZMKFj/DpHwtuR62BB9/Xjxl364LYm6/2UWUerfxZ+BK0dkKApagYdKSJEajuvfLMRmADKCFQA=
From:   Andrew Cooper <Andrew.Cooper3@citrix.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "joao@overdrivepizza.com" <joao@overdrivepizza.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "samitolvanen@google.com" <samitolvanen@google.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alyssa.milburn@intel.com" <alyssa.milburn@intel.com>,
        Juergen Gross <jgross@suse.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 19/29] x86/ibt,xen: Annotate away warnings
Thread-Topic: [PATCH 19/29] x86/ibt,xen: Annotate away warnings
Thread-Index: AQHYJOtF0PxQ5A3Nl02XV1uCkBqpcayZwUeAgAALTwCAACIbAA==
Date:   Fri, 18 Feb 2022 23:07:15 +0000
Message-ID: <47e22369-2ba5-cde6-0f69-5694a517167c@citrix.com>
References: <20220218164902.008644515@infradead.org>
 <20220218171409.696743603@infradead.org>
 <e5b93f0a-a28c-8c63-0193-4b4d0db509ab@citrix.com>
 <YhAKBrTiQwFkocez@hirez.programming.kicks-ass.net>
In-Reply-To: <YhAKBrTiQwFkocez@hirez.programming.kicks-ass.net>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1af386fc-a67f-4df1-b098-08d9f333676d
x-ms-traffictypediagnostic: BN9PR03MB6170:EE_
x-microsoft-antispam-prvs: <BN9PR03MB6170B3A2A8095C9633F906F8BA379@BN9PR03MB6170.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ivBcyuOYfYO8B07m3eb0FboYZ0Z9kLfsabNn/M57qE9lV8l/5IL6v7/J2DZOpizhjclzJQmq6RksQZ+WscFpJmWpi43hyYoQGD8lydt+VrgVW6iMErTHf2ZfA5hvk15qcfUo+dpVpteI19/URkWZTqEohOsiNNvNzmpo42YWq+217+58jH04G/WQ9RD5iiJWE0c/kKc0/djdByP7CBOxcyc7K2GNjUaVXpFw1f6yeegdh1wwuFwaHhDx5+Iz4rERe9cTFZy3ynGWEpQhCvvMzZ2pFqVFpmqPkybhjcIeyYiptSQ8ORZj6LNNX8Omzx0tGFj4GKp94dgaCvaVtCaWbMlLeTVjse+pMaI0ZZ2kI7H/f5YtF42m2XjNhNeeSL5uXQMFUlgimYAzh70nXC+x02r7rcIc8JfiCtOzx/KL6qXZ0dMWAP3BtC1L3+Xsx5DOKTfTegEbb32jlIpywqi5AuFQ09v/yKFKOe7sVh2Gx7s7Ary+S2IwT56S4g7AET542ZhuHmawySiTQFJaZEaIQIz6ooA75tGGN//TsrvQkyj40eQirtJB78ptnYZtncg54GvfMONZqHslo/hQGc7sbBgHFV21jdwV7yA1Txk7IiYteGDMfrRHKzjHIusjcezvI2iC7fplMiW5XEYIlmNw+mzKad4Rd+mweIZ5xNNgeXChQOQmUWvEBtV7ttw9XxwA2rqRPwg2pmr9lZOuWdZnhn7nJ50ygwvar5M3LV+runpQtDchjpTW5cA/oqvSj3275XzTQ0nD+P8uSvybBi/R9Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR03MB3618.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(91956017)(186003)(26005)(76116006)(71200400001)(31686004)(53546011)(508600001)(6506007)(6512007)(54906003)(122000001)(316002)(6916009)(36756003)(6486002)(8936002)(7416002)(2906002)(38070700005)(66946007)(82960400001)(83380400001)(86362001)(66446008)(8676002)(64756008)(66476007)(66556008)(4326008)(31696002)(5660300002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SFRHS05COCsyVnI3NXNBekNhL29HNWNXSmZJOTNLcnpDS1ppcERaOFlLV2dO?=
 =?utf-8?B?alJMYy9hNENKYUQwNTFGWVZhVEpMZjJvSTMyM0xVVy9TM29mMllwRyt6MUlD?=
 =?utf-8?B?WUx4ZzRrdEZxRGh4N28yd1hvWHNRUldqeUQ4WENHeWxiK3Z3WVI3NSszODFM?=
 =?utf-8?B?RllyclFBQXo1dzlQMFB1ZitqbmlrS0k5UndudVR2NGJURmdaRk4wTUtGaTBx?=
 =?utf-8?B?ci9pZ0pFV0djTktqYktDTzdrY2gzeTZUQkZ6ZmM3OXZyZUx6STl6MDlCeEMv?=
 =?utf-8?B?TFNQTXNSTHBQdlNsUThZVEpKaUN1NDRrc05Pd3VrMWRkelRiY3pGNXNsQXVM?=
 =?utf-8?B?VGJ6SXA3bFhNOEFqOGplemU4bS9Kb2U2UDRRVVBQdG5Jd085bEV4RHlTSzZj?=
 =?utf-8?B?dWZCdXBrNHRZVUs5TjdGYWhWRDBvdFVVcUN5aEN6R0NQKzVmTCtRN01ZMkty?=
 =?utf-8?B?bWhFeU9maVNKOFB4SGFEZy9pbktTZXFYQjZpZXdRTUlURXVwRFJSeXczVk1E?=
 =?utf-8?B?Mkx0OUk3SWs5bCtCNmhCbkdlZnk5bTdHQ3ZiT052R3BML2R2eHR5WEhjSmJ3?=
 =?utf-8?B?bmlrM1BYZFhLK3JsMHdKVW82dzNSbnN1RXZqb0tsWlFiRlRrWDlYUGFGNHVK?=
 =?utf-8?B?bklNYm1jM1FLZUVNU3p6elhaQ1BnUm9RbVl2dlVUZlBvQ0M2MVMyVE93OWJN?=
 =?utf-8?B?aE1jSk4wZDBJdFJ6Z1pqOXdBSE1HOUdETndkV0d1VUpWQkh6dWJkQis1R3VR?=
 =?utf-8?B?RFRuaktIYTNwRVUzdkY4bWRlZFNtUHc4a2wyeXh6UHpQWWFpRng1eHZlZUFl?=
 =?utf-8?B?OGR0aWxja2QxcWcwWkV2ZHpKRUsxdUJxZnRYaHdQcW1adldrSEloOEtWOXJR?=
 =?utf-8?B?cDZEVlJmTkN5RkNUNWNnV2dnQmk4TXNKdlhJeGhLZXJhbGF6V3J0c0FscTQx?=
 =?utf-8?B?cUdTcGhCZjAzdjhqZEZyUngzdDdnRUlKTUM5N0swTWhIY3pOelBRZVh3R21P?=
 =?utf-8?B?QWlkeUdRUndIVnk0OVdHb0V4NkJrZVg2VlhxeDVtWGJ0WG0xYi91RVFhNHIx?=
 =?utf-8?B?RjdQc2l1SStFeE5SUmExVjFqanU1bXBxMXZ0RFZPM3ByTzZndTVScUNBTHNp?=
 =?utf-8?B?d0k3ZXErQTB3UlB3NVFucHRvOWk5ZVNyTzRqdG90dTkzT21tMTFzK25FUGJs?=
 =?utf-8?B?SU5NbktzL2NhcGJuYVpnUC9LWHM4UzZoSnhWaUFHcVA0YjZaT0RDek9OMVhl?=
 =?utf-8?B?UDE5bnFTWWRQU0lxdEh0T1FRR1pPeE5SRE0yUmtHbHhWTDVYRllaOHM4YzRu?=
 =?utf-8?B?dTc2RnVxd3FWVEdzSkhxN1JiUklneGZuTFRXMTRTTzkyb3Zmd1N2Vk93SVZR?=
 =?utf-8?B?dXBmM29odG5sK1VTTWtyQ1BxU0xTbjl4RGNTemhuRWVKanVtRDh0cmx3dzVR?=
 =?utf-8?B?eUR3RUhTbWt6bUVSK1RlN2NrMlNvWmtrZXN6YjdGWlprK2dIZTB3STdHdW1v?=
 =?utf-8?B?RTNBL1RnblV5ME1VbThOZFlHRmx5ZzJScHVLZTdQSXdjb3pDQkZkSXAza1pK?=
 =?utf-8?B?eDBPVTh1S1RQaEpsdjlNU3dkbTJOaXBRWElMd0hDWENFNzRUeHlicEtJQzhE?=
 =?utf-8?B?SUZlR0doUEFLbi9TYlpvVGxEc2pCQ2ROb2l3WXFEblZKK05mK1B3ejdTb21W?=
 =?utf-8?B?eStvZ1Fpb0Q5RXZsS1ppMUtVYTlWN01qeU5ZdE93eWU5TlRDRVk2NWU2WjZO?=
 =?utf-8?B?V0oxYkJWL29ndWFGaWlXT0RIY1E3ME9Ib3ZmL3drRGx4N1A4WGpVOE9nQWpG?=
 =?utf-8?B?a1BYckZ6SU9PUkk0cHlGM1ZVdUVHU3FLS3cyeWN3SlU3WC90cEhzMi9KRnpy?=
 =?utf-8?B?ME0xNGkwcW0yZlAyYUM1cVd1NTJubTJ6ZFBuU0F6c2UyeFhBY1FKSEZ6cldF?=
 =?utf-8?B?V3VlWU1mQTZxeG9ZSjg3UDZENTJnMmhDSFkwSytHaVQvS0xkdzZ4Y3IvUG5X?=
 =?utf-8?B?QjRVYXFiV0JycmZrdlFQRjNLZ1d5U0N5VUpRRHBON1ErbmhLbEpZMlhoUmNY?=
 =?utf-8?B?am4ya1loZjJ0aWEwK3pWZmdBeFRnRmllVERoUlRLOFdBQUJ2WCtXR0VJKzRj?=
 =?utf-8?B?WC9weEViSDdYNGk5ZWVpRkdMb2l2RmNtYVkzWXdkc3RvY0tNRlNVaGszaWhn?=
 =?utf-8?B?Vk0yZ2EyK216K21kaWlkSW42bWwrOHI2aGkzSG16Z0RtMEF0TVorVnpYNU9U?=
 =?utf-8?B?Z3A5bS90OWg0bys3RmFDT2tBSDVnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <60B0BEE55A48D44E94F306BF31A057ED@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR03MB3618.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1af386fc-a67f-4df1-b098-08d9f333676d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2022 23:07:15.2665
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mstfCdg09rLSW97iLsdmSzuDGFsPirDP3vjAeQqlftMjgfEK60PJlmZs0hV0toNXcYmEGtfaWkIaTeD3KxbvTT/dBd8h9642zOfnrdZKUMY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR03MB6170
X-OriginatorOrg: citrix.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTgvMDIvMjAyMiAyMTowNSwgUGV0ZXIgWmlqbHN0cmEgd3JvdGU6DQo+IE9uIEZyaSwgRmVi
IDE4LCAyMDIyIGF0IDA4OjI0OjQxUE0gKzAwMDAsIEFuZHJldyBDb29wZXIgd3JvdGU6DQo+PiBh
dCBhIG1pbmltdW0sIGFuZCBwb3NzaWJseSBhbHNvOg0KPj4NCj4+IGRpZmYgLS1naXQgYS9hcmNo
L3g4Ni94ZW4veGVuLWFzbS5TIGIvYXJjaC94ODYveGVuL3hlbi1hc20uUw0KPj4gaW5kZXggNDQ0
ZDgyNDc3NWY2Li45NmRiNWM1MGE2ZTcgMTAwNjQ0DQo+PiAtLS0gYS9hcmNoL3g4Ni94ZW4veGVu
LWFzbS5TDQo+PiArKysgYi9hcmNoL3g4Ni94ZW4veGVuLWFzbS5TDQo+PiBAQCAtMTI0LDcgKzEy
NCw3IEBAIFNZTV9DT0RFX1NUQVJUKHhlbl9cbmFtZSkNCj4+IMKgwqDCoMKgwqDCoMKgIFVOV0lO
RF9ISU5UX0VNUFRZDQo+PiDCoMKgwqDCoMKgwqDCoCBwb3AgJXJjeA0KPj4gwqDCoMKgwqDCoMKg
wqAgcG9wICVyMTENCj4+IC3CoMKgwqDCoMKgwqAgam1wwqAgXG5hbWUNCj4+ICvCoMKgwqDCoMKg
wqAgam1wwqAgXG5hbWUgKyA0ICogSVNfRU5BQkxFRChDT05GSUdfWDg2X0lCVCkNCj4+IMKgU1lN
X0NPREVfRU5EKHhlbl9cbmFtZSkNCj4+IMKgX0FTTV9OT0tQUk9CRSh4ZW5fXG5hbWUpDQo+PiDC
oC5lbmRtDQo+IG9ianRvb2wgd2lsbCBkbyB0aGF0IGZvciB5b3UsIGl0IHdpbGwgcmV3cml0ZSBh
bGwgZGlyZWN0IGptcC9jYWxsIHRvDQo+IGVuZGJyLg0KDQpBaCAtIGdyZWF0Lg0KDQo+IFNvbWV0
aGluZyBsaWtlIHNvIHRoZW4/DQoNCkxvb2tzIHBsYXVzaWJsZSzCoCBhbHRob3VnaCBKdWVyZ2Vu
IHdvdWxkIGJlIGEgYmV0dGVyIHBlcnNvbiB0byBqdWRnZS4NCg0KDQpBYm91dCBwYXJhdmlydF9p
cmV0LCB0aGlzIGlzIGFsbCB3YXkgbW9yZSBjb21wbGljYXRlZCB0aGFuIGl0IG5lZWRzIHRvIGJl
Lg0KDQpDdXJyZW50bHksIHRoZXJlIGFyZSB0d28gdXNlcnMgb2YgSU5URVJSVVBUX1JFVFVSTi4N
Cg0KVGhlIGZpcnN0LCBpbiBzd2FwZ3NfcmVzdG9yZV9yZWdzX2FuZF9yZXR1cm5fdG9fdXNlcm1v
ZGUsIGlzIG5ldmVyIGdvaW5nDQp0byBleGVjdXRlIHVudGlsIHBhdGNoaW5nIGlzIGNvbXBsZXRl
LCBhbmQgaXMgYWxyZWFkeSBiZWhpbmQgYW4NCmFsdGVybmF0aXZlIGNhdXNpbmcgWEVOUFYgdG8g
Z28gYSBkaWZmZXJlbnQgd2F5LCB3aGljaCBtZWFucyB0aGF0Og0KDQpkaWZmIC0tZ2l0IGEvYXJj
aC94ODYvZW50cnkvZW50cnlfNjQuUyBiL2FyY2gveDg2L2VudHJ5L2VudHJ5XzY0LlMNCmluZGV4
IDk3YjFmODRiYjUzZi4uZjlhMDIxZTc2ODhhIDEwMDY0NA0KLS0tIGEvYXJjaC94ODYvZW50cnkv
ZW50cnlfNjQuUw0KKysrIGIvYXJjaC94ODYvZW50cnkvZW50cnlfNjQuUw0KQEAgLTYwOCw4ICs2
MDgsOCBAQA0KU1lNX0lOTkVSX0xBQkVMKHN3YXBnc19yZXN0b3JlX3JlZ3NfYW5kX3JldHVybl90
b191c2VybW9kZSwgU1lNX0xfR0xPQkFMKQ0KwqANCsKgwqDCoMKgwqDCoMKgIC8qIFJlc3RvcmUg
UkRJLiAqLw0KwqDCoMKgwqDCoMKgwqAgcG9wccKgwqDCoCAlcmRpDQotwqDCoMKgwqDCoMKgIFNX
QVBHUw0KLcKgwqDCoMKgwqDCoCBJTlRFUlJVUFRfUkVUVVJODQorwqDCoMKgwqDCoMKgIHN3YXBn
cw0KK8KgwqDCoMKgwqDCoCBqbXDCoMKgwqDCoCBuYXRpdmVfaXJldA0KwqANCsKgDQrCoFNZTV9J
Tk5FUl9MQUJFTChyZXN0b3JlX3JlZ3NfYW5kX3JldHVybl90b19rZXJuZWwsIFNZTV9MX0dMT0JB
TCkNCg0KaXMgY29ycmVjdCBBRkFJQ1QuwqAgKFRhbmdlbnQ7IHRoZW4gRVNQRklYNjQgY2FuIGJl
IHNpbXBsaWZpZWQgYmVjYXVzZQ0Kb25seSB0aGUgcmV0dXJuLXRvLXVzZXIgcGF0aCBuZWVkcyB0
aGUgTERUIGNoZWNrLCBzbyB0aGUgZW50ZXIvZXhpdCB1c2VyDQpzdGF0ZSBjYW4gYmUgZHJvcHBl
ZC4pDQoNCg0KVGhhdCBsZWF2ZXMgdGhlIHNpbmdsZSBJTlRFUlJVUFRfUkVUVVJOIGluDQpyZXN0
b3JlX3JlZ3NfYW5kX3JldHVybl90b19rZXJuZWwuwqAgWGVuIFBWIGlzIGFuIGVhc3kgZW52aXJv
bm1lbnQgdG8NCnN0YXJ0IHVwIGluLCBzbzoNCg0KZGlmZiAtLWdpdCBhL2FyY2gveDg2L2VudHJ5
L2VudHJ5XzY0LlMgYi9hcmNoL3g4Ni9lbnRyeS9lbnRyeV82NC5TDQppbmRleCA5N2IxZjg0YmI1
M2YuLmE5ZTc4NDZjYzE3NiAxMDA2NDQNCi0tLSBhL2FyY2gveDg2L2VudHJ5L2VudHJ5XzY0LlMN
CisrKyBiL2FyY2gveDg2L2VudHJ5L2VudHJ5XzY0LlMNCkBAIC02MjYsNyArNjI2LDEwIEBAIFNZ
TV9JTk5FUl9MQUJFTChyZXN0b3JlX3JlZ3NfYW5kX3JldHVybl90b19rZXJuZWwsDQpTWU1fTF9H
TE9CQUwpDQrCoMKgwqDCoMKgwqDCoMKgICogQVJDSF9IQVNfTUVNQkFSUklFUl9TWU5DX0NPUkUg
cmVseSBvbiBJUkVUIGNvcmUgc2VyaWFsaXphdGlvbg0KwqDCoMKgwqDCoMKgwqDCoCAqIHdoZW4g
cmV0dXJuaW5nIGZyb20gSVBJIGhhbmRsZXIuDQrCoMKgwqDCoMKgwqDCoMKgICovDQotwqDCoMKg
wqDCoMKgIElOVEVSUlVQVF9SRVRVUk4NCisjaWZkZWYgQ09ORklHX1hFTl9QVg0KK2Vhcmx5X2ly
ZXRfcGF0Y2g6DQorI2VuZGlmDQorwqDCoMKgwqDCoMKgwqAgam1wIG5hdGl2ZV9pcmV0DQrCoA0K
wqBTWU1fSU5ORVJfTEFCRUxfQUxJR04obmF0aXZlX2lyZXQsIFNZTV9MX0dMT0JBTCkNCsKgwqDC
oMKgwqDCoMKgIFVOV0lORF9ISU5UX0lSRVRfUkVHUw0KZGlmZiAtLWdpdCBhL2FyY2gveDg2L3hl
bi94ZW4taGVhZC5TIGIvYXJjaC94ODYveGVuL3hlbi1oZWFkLlMNCmluZGV4IDZhNjQ0OTZlZGVm
Yi4uMzFmMTM2MzI4Yzg0IDEwMDY0NA0KLS0tIGEvYXJjaC94ODYveGVuL3hlbi1oZWFkLlMNCisr
KyBiL2FyY2gveDg2L3hlbi94ZW4taGVhZC5TDQpAQCAtNjYsNiArNjYsMTAgQEAgU1lNX0NPREVf
U1RBUlQoc3RhcnR1cF94ZW4pDQrCoMKgwqDCoMKgwqDCoCBjZHENCsKgwqDCoMKgwqDCoMKgIHdy
bXNyDQrCoA0KK8KgwqDCoMKgwqDCoCBtb3bCoMKgwqDCoCAkbmF0aXZlX2lyZXQsICVyYXgNCivC
oMKgwqDCoMKgwqAgc3ViwqDCoMKgwqAgJHhlbl9pcmV0LCAlcmF4DQorwqDCoMKgwqDCoMKgIGFk
ZMKgwqDCoMKgICVlYXgsIDEgKyBlYXJseV9pcmV0X3BhdGNoDQorDQrCoMKgwqDCoMKgwqDCoCBj
YWxsIHhlbl9zdGFydF9rZXJuZWwNCsKgU1lNX0NPREVfRU5EKHN0YXJ0dXBfeGVuKQ0KwqDCoMKg
wqDCoMKgwqAgX19GSU5JVA0KDQpyZWFsbHkgc2hvdWxkIGJlIGdvb2QgZW5vdWdoIHRvIGRyb3Ag
SU5URVJSVVBUX1JFVFVSTiBhbmQgcGFyYXZpcnRfaXJldA0KZW50aXJlbHkuDQoNCk9idmlvdXNs
eSwgdGhhdCdzIHZlcnkgaGFja3ksIGFuZCBtaWdodCBiZXR0ZXIgYmUgZXhwcmVzc2VkIGxpa2U6
DQoNCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9lbnRyeS9lbnRyeV82NC5TIGIvYXJjaC94ODYvZW50
cnkvZW50cnlfNjQuUw0KaW5kZXggOTdiMWY4NGJiNTNmLi5hZjM3MWU0ZjBkZGEgMTAwNjQ0DQot
LS0gYS9hcmNoL3g4Ni9lbnRyeS9lbnRyeV82NC5TDQorKysgYi9hcmNoL3g4Ni9lbnRyeS9lbnRy
eV82NC5TDQpAQCAtNjI2LDcgKzYyNiw3IEBAIFNZTV9JTk5FUl9MQUJFTChyZXN0b3JlX3JlZ3Nf
YW5kX3JldHVybl90b19rZXJuZWwsDQpTWU1fTF9HTE9CQUwpDQrCoMKgwqDCoMKgwqDCoMKgICog
QVJDSF9IQVNfTUVNQkFSUklFUl9TWU5DX0NPUkUgcmVseSBvbiBJUkVUIGNvcmUgc2VyaWFsaXph
dGlvbg0KwqDCoMKgwqDCoMKgwqDCoCAqIHdoZW4gcmV0dXJuaW5nIGZyb20gSVBJIGhhbmRsZXIu
DQrCoMKgwqDCoMKgwqDCoMKgICovDQotwqDCoMKgwqDCoMKgIElOVEVSUlVQVF9SRVRVUk4NCivC
oMKgwqDCoMKgwqAgRUFSTFlfQUxURVJOQVRJVkUgImptcCBuYXRpdmVfaXJldCIsICJqbXAgeGVu
X2lyZXQiLA0KWDg2X0ZFQVRVUkVfWEVOUFYNCsKgDQrCoFNZTV9JTk5FUl9MQUJFTF9BTElHTihu
YXRpdmVfaXJldCwgU1lNX0xfR0xPQkFMKQ0KwqDCoMKgwqDCoMKgwqAgVU5XSU5EX0hJTlRfSVJF
VF9SRUdTDQoNCm9yIHNvLCBidXQgbXkgcG9pbnQgaXMgdGhhdCB0aGUgZWFybHkgWGVuIGNvZGUs
IGlmIGl0IGNhbiBpZGVudGlmeSB0aGlzDQpwYXRjaCBwb2ludCBzZXBhcmF0ZSB0byB0aGUgbGlz
dCBvZiBldmVyeXRoaW5nLCBjYW4gZWFzaWx5IGFycmFuZ2UgZm9yDQppdCB0byBiZSBtb2RpZmll
ZCBiZWZvcmUgSFlQRVJDQUxMX3NldF90cmFwX3RhYmxlIChYZW4gUFYncyBMSURUKSwgYW5kDQp0
aGVuIHJldHVybl90b19rZXJuZWwgaXMgaW4gaXRzIGZ1bGx5IGNvbmZpZ3VyZWQgc3RhdGUgKHBh
cmF2aXJ0IG9yDQpvdGhlcndpc2UpIGJlZm9yZSBpbnRlcnJ1cHRzL2V4Y2VwdGlvbnMgY2FuIGJl
IHRha2VuLg0KDQp+QW5kcmV3DQo=
