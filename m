Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3794506B57
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 13:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351614AbiDSLpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 07:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351798AbiDSLpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 07:45:30 -0400
Received: from esa3.hc3370-68.iphmx.com (esa3.hc3370-68.iphmx.com [216.71.145.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B0A27B37
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 04:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1650368539;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qcSjmxtDOAjsYOSIkWfBt4XvmdTtGb2BWbNkcowgQ6o=;
  b=ISd7aCiSPIwVKh1qgQn31pJxq6tvEIdFl1aj/7FSpFRRUBmvyRF9mrnv
   8u3TWPr8K7N2/N/vGo4zCJseZ826HBZSO7cgl2niGrW0O/oX+bKNqlUaz
   Zgwbz8L/kFD6G/t89ZeSa3RkCBfjKnlQDMeHeA/wTma06ZghdnskoG3YC
   Y=;
X-IronPort-RemoteIP: 104.47.70.101
X-IronPort-MID: 69399794
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:Pdt3LavPAf7MRJHJ4Ayf1sz+FefnVNZfMUV32f8akzHdYApBsoF/q
 tZmKW6DPqzcM2v9fdhzady1pElSupTdmtMySFdv+Ho0FClE+JbJXdiXEBz9bniYRiHhoOOLz
 Cm8hv3odp1coqr0/0/1WlTZhSAgk/nOHNIQMcacUsxLbVYMpBwJ1FQyw4bVvqYy2YLjW1/U6
 IuryyHiEATNNwBcYzp8B52r8HuDjNyq0N/PlgVjDRzjlAa2e0g9VPrzF4noR5fLatA88tqBb
 /TC1NmEElbxpH/BPD8HfoHTKSXmSpaKVeSHZ+E/t6KK2nCurQRquko32WZ1he66RFxlkvgoo
 Oihu6BcRi80A6vioLUjSCN2LBB0Oaoa3ZbYK1uW5Jn7I03uKxMAwt1IJWRvZcgy3LkyBmtDs
 /sFNDoKcxaPwfqsx662QfVtgcJlK9T3OIQYuTdryjSx4fQOGMifBfmVo4AAmm5o36iiHt6HD
 yYdQRNpYA7NfFtkPVAPBYhltOypmmP+Y3tTr1f9Sa8fvTmInV0ugeSF3Nz9IvmPR/13uXmhu
 0XJ/j3kJCkBEN7E8G/Qmp6rrqqV9c/hY6oQDLq58/RtjXWJy2ATAQFQXly+ydGp2hCWWN9FL
 UEQvC00osAa7EG3Q8Pvdxy+rmSNshMVV5xXCeJSwAWMzLfEpgWUHG4JShZfZ9E88sw7Xzon0
 hmOhdyBLTllvbuYUlqG66yZ6zigUQAfKnUDfmkDVhcf5Mf4o5AbiQjGRdJuVqWyi7XdGz7qx
 CuRhDMjnLhVhskOv42g5kzOiT+oopnPTyY26x/RU2bj6Rl2DKa1aort5VXF4PJoKIeCUkLHr
 HUCg9KZ7u0FEdeKjiPlfQkWNLSg5vLAOjuDh1dqRsEl7270oyflep1M6jZjIksvKtwDZTLif
 E7Uv0VW+YNXO3ypK6RwZupdFvgX8EQpLvy9Pti8UzaESsEZmNOvlM22WXOt4g==
IronPort-HdrOrdr: A9a23:4lXt6aniA7N8LDFeHrddo+S9nV/pDfN1iWdD5ihNYBxZY6Wkfp
 +V8cjzhCWftN9OYhodcIi7SdK9qXO1z+8X3WGIVY3SEDUOy1HYVr2KirGSjAEIeheOu9K1sJ
 0NT0EQMqyWMbEXt6fHCUyDYq4dKbq8ge6VbIXlvhFQpGhRAskOgTuRSDzra3GeLzM2Z6bRYa
 Dsgvav0ADQHEj/AP7aOlA1G8z44/HbnpPvZhALQzQ97hOVsD+u4LnmVzCFwxY3SVp0sPcf2F
 mAtza8yrSosvm9xBOZ/XTU9Y5qlNzozcYGLNCQi/ISNi7nhm+TFcdcsvy5zXIISdOUmRIXee
 r30lAd1gNImjXsl1SO0F7QMs/boW8TAjHZuAelaDDY0LHErXoBerZ8bMRiA1rkAgMbza9BOO
 gg5RPni7NHSRzHhyjz/N7OSlVjkVe1u2MrlaoJg2VYSpZ2Us4YkWUzxjIiLH47JlOy1GnnKp
 gdMOjMoPJNNV+KZXHQuWdihNSqQ3QoBx+DBkwPoNac3TRalG1wixJw/r1Uol4QsJYmD5VU7e
 XNNapl0LlIU88NdKp4QOMMW9G+BGDBSQ/FdGiSPVPkHqcaPG+lke+93JwloOWxPJAYxpo7n5
 rMFFteqG4pYkrrTdaD2ZVamyq9N1lVnQ6dvv22y6IJyoEUHoCbQBFrYGpe4PeIsrEYHtDRXe
 q1NdZfH+LjRFGebLp04w==
X-IronPort-AV: E=Sophos;i="5.90,272,1643691600"; 
   d="scan'208";a="69399794"
Received: from mail-bn7nam10lp2101.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.101])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Apr 2022 07:42:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HkMD9vSZPzzp7S6b41xgGUKBloVIn19S88uk2DAMk7Jm5sMYClpVSqbeWGsTnLNMR38QBf0CJQPtob+D1y/YwRLeDvyNDxX6s/0ezAYhN7/bhIuIrzL0l6UaCHpbsKxRKHIXy6kMkYMgcXjjl+tG//KAVnkJTTUm0oItYGOJ/XZ80Nelpn+70l5npBHTH3iVxdv1y2WyQN5Zdb12r4bC1GiA5iByccEiJtp02qtI+XHfJMfczq8gfneCumxuostUvsIuHNRaXMGDRXvRdRieRid7dJvQeOs2mDgWuqbnDiecp9cpysx1AzKmYOCbPH9kYnxl9jRxyhS/gk/Tt+aSvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qcSjmxtDOAjsYOSIkWfBt4XvmdTtGb2BWbNkcowgQ6o=;
 b=SFnpoIgApVF5roWbU7QLexA5/dhlkJoeyO/Kr6p2xFr80bxrk5du9UNBy1/THHhCyU0bHV/cG1Pj0qdwee3tgGzfvZ3P1mcMkFFcNFjKC4bUlIOrUFIb8MKBjsai5NAT7RJsGeXZ4vyeuICrB5XP1cN7zR0MYbVD1l2fa0sndQyjyZ5LcmDfKfAOvy9w687JuF7HqIn81ZkFUDfAVgY3+9j9p0WcNeFFSSLYk8O63Cj5UogIdHq+uMS5WYmTQOmF7hs2dLk/ridznun3OanEnieDZxn/eciaLNTjmuDP9Hpqtmq+haebgGgH6GO6SMf6mAQOuYc6vKOdtL21wqeMSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qcSjmxtDOAjsYOSIkWfBt4XvmdTtGb2BWbNkcowgQ6o=;
 b=pTqckYFOUsai9RsPyloa+5Yv7l69BYAoM3TkG19Jw1FYti174AMIYUuhk1EBy3/twXT9DgM3Ak1GOHmaBhM24dsW36v36uJ2ZkRBXJUKEUdxYlktYK09W8AZlUknp+PcH6NQ2pY6nhgnZl0YHtFDPJqAnxlbcMd1tr56YR0oFsI=
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by CO1PR03MB5922.namprd03.prod.outlook.com (2603:10b6:303:6d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Tue, 19 Apr
 2022 11:42:12 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::ac51:a410:14d4:de37]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::ac51:a410:14d4:de37%6]) with mapi id 15.20.5164.025; Tue, 19 Apr 2022
 11:42:12 +0000
From:   Andrew Cooper <Andrew.Cooper3@citrix.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH v2 06/25] x86/xen: Add ANNOTATE_ENDBR to startup_xen()
Thread-Topic: [PATCH v2 06/25] x86/xen: Add ANNOTATE_ENDBR to startup_xen()
Thread-Index: AQHYU0SHTqWJMApeME+vJqcoJU7NiKz3HnsA
Date:   Tue, 19 Apr 2022 11:42:12 +0000
Message-ID: <b94cbac6-0a4d-8e4a-ec58-bbd46e385d45@citrix.com>
References: <cover.1650300597.git.jpoimboe@redhat.com>
 <a87bd48b06d11ec4b98122a429e71e489b4e48c3.1650300597.git.jpoimboe@redhat.com>
In-Reply-To: <a87bd48b06d11ec4b98122a429e71e489b4e48c3.1650300597.git.jpoimboe@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a583dfb-0bea-4305-c9c0-08da21f9a504
x-ms-traffictypediagnostic: CO1PR03MB5922:EE_
x-microsoft-antispam-prvs: <CO1PR03MB59228D13F48F381A9950B475BAF29@CO1PR03MB5922.namprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8DJcbLeDFxHR4R0qBsGht7bl4BcEvMipS8WCEDc+r1SDVI//jvAnUz6zgPIuIpM1Fwdj52kUR8OYW1SbgTkT17/qjqq8VS0XSgBfhdebpC6sb2s2iNmsiJhd8sQ5UaERqyXA79gOrPZM8iXa1rEpJz9s2WHqkpOXQHqz1ZMeB615HHrGKqQJKr40U2ZUMM8A5vQyMnGfgDSfsOi3I0+e0gjUcOaWT4a2dlJfexcODCDPn4a4USGhSnwgeKNYT66tAwC8W8vyhWI0lGUFqwkaQBjx3P3Qy2yl84X+S+ZvZqkFk4rFr2XE/GFtvYuHsqAp30lvcDqj1Zs+zDWL6OkRtdqrgRhY65rJzRY82P0DiC8d5xDGOIpzFWm17bQHsCFpB8Bklk7NO9vWFC8Nl+8ts/9odYlsBPp0WitTZgRpQ6rwJ9UaJYoy4tbF0aaIgwvYGyXxHFFQEy3CYSEfIxAptkGCjqBh3S+S3Sui7AidJHQlxP+jwl8JqEoVOiv7x5l8jOqpLmf4byILoj79FCevmezHrn/KVNZ92ewafEEJhVrLZD6TIYeiWJdIEHFFvH/qn2V11zhQHO1Q3CZM3kO5+I3E5FZwWX3MIFLrw8FOHfb8iHq/umQLRnkRll+MYZiH4TvTn/i876kNiQ3PB8Rsx/XSzuD5bGEIB7p5os7kxlg0L+kGA4kTpMQQlXsibdEdFepEhQVeAzN2+eDYnZkGt+x6IyAdxKOqUC/2v7kQVe7rAn8EJ5he+ZmmW74GwTiOryp6XrLEJ/bVrCQVC2MaaQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(8676002)(76116006)(66946007)(91956017)(31696002)(86362001)(66476007)(66556008)(4326008)(8936002)(66446008)(5660300002)(38100700002)(122000001)(4744005)(64756008)(38070700005)(82960400001)(83380400001)(6512007)(6506007)(508600001)(53546011)(26005)(186003)(110136005)(316002)(54906003)(6486002)(71200400001)(2616005)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NytCbWlGSDQ1N0tOM2VhSnFXVjBGRHlwNElFTFJLSVRBNDR3L0Z6YXNIYlU4?=
 =?utf-8?B?ekNrUktxVFZSaWpNUHdNbHdQRzBsSFZadmJ4R3Y3V0NtbHZ1RjVMYUpZOHVJ?=
 =?utf-8?B?VTFVNG9mVHArYm5tbGw1dVZzMnQ0NnRaMUVtMUhlNTk1RVJoSExROTRqU1Z4?=
 =?utf-8?B?WXVpK1hGT2w0MDVYcFNUQXd6NU1EbXNwTkhudnJLMzk3YTNlbFRIcWNzcVJK?=
 =?utf-8?B?NEtycTFYb0x0MFp6V2N5bkx0MGgxS1Y0dFVEeUlZSFltSG9mQitzRlkvbGth?=
 =?utf-8?B?bHArRmdNcUtqcGYyM2plNVJ0VGR5WFk1SWRlU3BZVG5HeG92bUEya3gvd0tx?=
 =?utf-8?B?d09JZkx0V3BNaFJDQ3htV0lGakx4eUZnNmtPejNHOHAxdU9WVERvcU1yYWFz?=
 =?utf-8?B?NkowNXRodWxBTmNkdG0vQjNlUlg0SVlmSU5WRGlTdyswemJra1FVNVI0Ym1x?=
 =?utf-8?B?L1N1cTlBcVpjYjBjaEYrVzJDNXMwQTVQOTREdHc1ZmZNbU5rQnhPZEU3UUl4?=
 =?utf-8?B?d3BrQXhMaXBYYmpTVExKcTlsam9DN1dMT2tySEQ0UVN2ekdQMXdsMWlkZUpH?=
 =?utf-8?B?c3FKUVRDeUluN2Q3LzNMRmFMcEdzQzlGK0ZEQnVnNkp0VGtSV0tHQm55b1pW?=
 =?utf-8?B?dnRWODVqRDJhWTBNUVlvOTBnNlV5V0hMY3hCYVhmNGgyT01HOWxkQmlSdUFl?=
 =?utf-8?B?YmlQMjhkOVhGN2M5dlhNL2RTVERtK254STc3Y0ZpTW5PaG1KZlA1ajhZQzVz?=
 =?utf-8?B?U1hON1dOSUhPZk1WMXNXYUw5UG1iY2JZVFpUMEVhc2pNSnA0eUY1WVdUTmZB?=
 =?utf-8?B?UXIxQTV0eTRHTjRDUG9ONUYwell6V211ck9PVHJwdU1HL1FwbUlpU3dTVkRa?=
 =?utf-8?B?Q2NlTnJrRXZjUFFDOVRjYW45NEM1WDJJNjZGQjhLR0xiS1R3NUZZdUdsU2xm?=
 =?utf-8?B?VXVhMnpFbUxWcE5zYXdqR0RUMGxaeGt0S3RQWkY5RXhtNytLaXBTNVBYNVlG?=
 =?utf-8?B?d3N0eXZpc3pEdWFOeVhQZGQxMHRYMThaRmpPbXFqZGJvZVlWc20xNGVjWi95?=
 =?utf-8?B?RmFoR2dIQ3ljQy81eWZHcUtIbW5UZ2cvcWp3T0w0dFFiRE0zK0J2RlZoUTRn?=
 =?utf-8?B?cFhjK0ZjTk5LZDZ0ajMzWk96allWQTQ1RlBDL0dMbVRBOUgrK3F5aTUzQnY2?=
 =?utf-8?B?MzlvN1hRZEtITWJQS1U5VTJpTStWU0xteFBGNVVNdEhTNDk0UktqRDBmRUVp?=
 =?utf-8?B?VFJwWDNDaWRhUnZsMXRwdHpvbkNPRnUwdGpwckRjK1RRMTM2NWk0WkVJS1VN?=
 =?utf-8?B?VGNuZ0hhM1JDdTA0dEVoVkQ1MzFZUmoxUjVkTnVwb0hTVCsvS3VBcFFubE9G?=
 =?utf-8?B?WXFORy9odUZLTFQyRnE4TjRhTmlqbjNBUWo5Z2taK0NmcDJoS2w2ekRBVEpk?=
 =?utf-8?B?dzhoSWVnZFFjNmxXODRocjBiR01uQlplcjhSM2FEajdUb3JEZ2IxSDlZcThE?=
 =?utf-8?B?QkJzM2pRNVQ3NCs4b1p2emxvQWptaUpjbXJJdnFHQVVKSmIxWDhRYS8rdXla?=
 =?utf-8?B?NkM5QS9IUGgzVnM1MzZlTjhPWmVOZU93czExNCtJMENqVUFwaEJTZmV3R2RR?=
 =?utf-8?B?azNHbFlLQis4VTA0K3NvVUd1V2ovYS9aOGt0RnRVamlyQ0k5bitEUE5PWEh3?=
 =?utf-8?B?WlVNYy9oOE1IbElxTnpuUlhyRWxpK3NuR0hwWXpTVnZmTGtTOUx6TU81WGtw?=
 =?utf-8?B?VzkzZWpqZFdWWis3VzBrUFRmSEhNMnprZDRmZ0xTQnlGWUQ3YWVST1BZS0F3?=
 =?utf-8?B?NTkwczBadnRjWmx4UUxldzUvd1VsN1hZYkh5UzhyT2FLWUVTM0hObVV1Y09m?=
 =?utf-8?B?ekgrYTBOL3pUQ0Y4d1BGSEQ2UnI5UzA5ZWk0V1g3S25pM0lKblAyT2NiandB?=
 =?utf-8?B?aHlhK0pIMkNhSzU1MnFvYjRXMTN3cUZQbXFhUS9aWEZLY2gzRkJPWG9WRnFY?=
 =?utf-8?B?WGFsUjlXaUVYc0hDZVpKSjMvZHVaYnZHbENYNVpJdE9PbGY0MXpta2hTRVUv?=
 =?utf-8?B?OEs1ZVBzVXpJcTA0R1VVMm0xdFcxK0NIZkFreVpTbGt6dit1amE0RHg1bkpm?=
 =?utf-8?B?ancrTXovUzA4OTJkSFNYQUZOWDlFS0doYjBGV2dkWmphU0Yrc1FZaGFhenVS?=
 =?utf-8?B?K3pKWEF6Ykp4K2hkazM3eEN1K1VwWGtUNUNJZUQ1RHJBdGpQWjRHeTB3VklU?=
 =?utf-8?B?K2tJdFZrQ2lIaGlFWkZMRjdEUmFWWUVZSEQ4bTNESVc1c2RrYjMvaXBqN3gy?=
 =?utf-8?B?c2l3TTBzcnpHTFVNaFl6c0RIVERmc1hFVlIwaXNOT3ByazNPL0pHUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D3CB7422250AFC4189676580C0D65D81@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a583dfb-0bea-4305-c9c0-08da21f9a504
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2022 11:42:12.4693
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iaAKoIdXYqA4c+NRlQIaFpnurO+X3peEWi5tBP/J0C1belDvdQBg4MU4lGhYQ1UIYgmvGqwOr3i50g48V7Y0lu05Ah0oUTocd1NH6eyXNhE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR03MB5922
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTgvMDQvMjAyMiAxNzo1MCwgSm9zaCBQb2ltYm9ldWYgd3JvdGU6DQo+IFRoZSBzdGFydHVw
X3hlbigpIGtlcm5lbCBlbnRyeSBwb2ludCBpcyByZWZlcmVuY2VkIGJ5IHRoZSAiLm5vdGUuWGVu
Ig0KPiBzZWN0aW9uLCBidXQgaXMgcHJlc3VtYWJseSBub3QgaW5kaXJlY3QtYnJhbmNoZWQgdG8u
DQoNCkl0J3MgdGhlIHJlYWwgZW50cnlwb2ludCBvZiB0aGUgVk0uwqAgSXQncyAiZ290IHRvIiBi
eSBzZXR0aW5nICVyaXANCmR1cmluZyB2Y3B1IHNldHVwLg0KDQpXZSBjb3VsZCBpbiBwcmluY2lw
bGUgc3VwcG9ydCBzdGFydGluZyBhIFBWIFZNIHdpdGggQ0VUIGFjdGl2ZSwgYnV0IHRoYXQNCnNv
dW5kcyBsaWtlIGFuIGVub3Jtb3VzIHF1YW50aXR5IG9mIGVmZm9ydCBmb3IgdmVyeSBsaXR0bGUg
Z2Fpbi7CoCBDRVQNCmZvciBYZW4gUFYgcmVxdWlyZXMgcGFyYXZpcnQgYW55d2F5IChiZWNhdXNl
IHRoZSBrZXJuZWwgcnVucyBpbiBDUEwhPTApDQpzbyBkZWNpc2lvbnMgbGlrZSB0aGlzIGNhbiB3
YWl0IHVudGlsIHNvbWVvbmUgZmVlbHMgbGlrZSBkb2luZyB0aGUgd29yay4NCg0KPiAgIEFkZCBB
Tk5PVEFURV9FTkRCUg0KPiB0byBzaWxlbmNlIGZ1dHVyZSBvYmp0b29sIHdhcm5pbmdzLg0KPg0K
PiBDYzogQm9yaXMgT3N0cm92c2t5IDxib3Jpcy5vc3Ryb3Zza3lAb3JhY2xlLmNvbT4NCj4gQ2M6
IEp1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT4NCj4gQ2M6IFN0ZWZhbm8gU3RhYmVsbGlu
aSA8c3N0YWJlbGxpbmlAa2VybmVsLm9yZz4NCj4gQ2M6IHhlbi1kZXZlbEBsaXN0cy54ZW5wcm9q
ZWN0Lm9yZw0KPiBTaWduZWQtb2ZmLWJ5OiBKb3NoIFBvaW1ib2V1ZiA8anBvaW1ib2VAcmVkaGF0
LmNvbT4NCg0KRldJVywgUmV2aWV3ZWQtYnk6IEFuZHJldyBDb29wZXIgPGFuZHJldy5jb29wZXIz
QGNpdHJpeC5jb20+LCBwcmVmZXJhYmx5DQp3aXRoIHRoZSBjb21taXQgbWVzc2FnZSB0d2Vha2Vk
IHRvIHJlbW92ZSB0aGUgdW5jZXJ0YWludHkuDQoNCn5BbmRyZXcNCg==
