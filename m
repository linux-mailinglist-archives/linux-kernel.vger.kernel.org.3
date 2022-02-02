Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E829E4A7A02
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 22:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347431AbiBBVHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 16:07:42 -0500
Received: from esa1.hc3370-68.iphmx.com ([216.71.145.142]:57435 "EHLO
        esa1.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237323AbiBBVHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 16:07:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1643836061;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zpLrYB8dNQCPlEsgFLGKaGshe8Z8BMaNPvtxtwk+89I=;
  b=RQsJahOe7IcrcTQDi+epdRZS/LkNtVMfhpt0WQgj3Nn7+f40ZIvOnZ6a
   exO9WtynezrtmlwY1mA5HteBrLoJ3vDgSgSjhlX+oj5O5tKWQJbM/ftO4
   niOo6JLl94qA5wc4OwL5gEB9Tjnp3z6arvOCbVz8UQChN5yXeJlhVn4nZ
   A=;
Authentication-Results: esa1.hc3370-68.iphmx.com; dkim=pass (signature verified) header.i=@citrix.onmicrosoft.com
IronPort-SDR: 5XqYr8h2GVEp+byRDudqnzLxyQeyh3pby9vuj47Z3gV0M3kuQBxbeYwPLU8CAMPLNigFc9Tai1
 spXXh/4Rht67vJ66kTsIxGGfDKxxQf2C1LTCVynt9niQ469K3nW9DkySxrH1a7blJYClWvHG+z
 0nXBj9M8JgPef+ldz2mt/NNsDhqXp5RYOB1SqDJ84Azo769gSMIvmhTFfeWscSxM8Za7ipOqsS
 s0ABHNuKhH7qtdxV+GCSW7fl8aGhN+zP6M51BlyIoBY4R6ktxXWI4vqI1wicMI4io3KJ3Prva1
 Lhrwh1zmX+Pfh2jblQ98xui2
X-SBRS: 5.2
X-MesageID: 63768349
X-Ironport-Server: esa1.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.83
X-Policy: $RELAYED
IronPort-Data: A9a23:O2o35Kv5Nh0zH6LCZPD3PPMf8efnVFVYMUV32f8akzHdYApBsoF/q
 tZmKWqGP6mMMWGgfIt3ati3/UhUupWDnYVqQVZqryA9RihB+JbJXdiXEBz9bniYRiHhoOOLz
 Cm8hv3odp1coqr0/0/1WlTZQP0VOZigHtIQMsadUsxKbVIiGHdJZS5LwbZj2NYy2YLhWWthh
 PupyyHhEA79s9JLGjp8B5Kr8HuDa9yr5Vv0FnRnDRx6lAe2e0s9VfrzFonoR5fMeaFGH/bSe
 gr25OrRElU1XfsaIojNfr7TKiXmS1NJVOSEoiI+t6OK2nCuqsGuu0qS2TV1hUp/0l20c95NJ
 Npl5b6RZCAFEaL2t/0fVBl9HhpCPZR/0eqSSZS/mZT7I0zudnLtx7NlDV0sPJ1e8eFyaY1M3
 aVGcnZXNEnF3r/ohuLgIgVvrp1LwM3DFYUToHx/ixreCu4rW8vrSKTW/95Imjw3g6iiGN6AP
 JVHOWEzPXwsZTVGMFc2D7wfxd2o3HWjaRFbrHS5gaAotj27IAtZj+G2bYu9lsaxbdRTg0qVo
 mfP+Uz5CxsTMtXZwDvt2n6oh+XChybyXqoSHbex8PcsiVz77ncUGhAMVHO7qPOwjEf4UtM3A
 0IX8zE1pKIo9WSrR9P0WRT+qX/slh0RX9BZAcU64QuEzKOS6gfxLm8OTyJdb9oOtMY8TDojk
 FaI9/vtBDpyoPiWRGib+7O8szy/I24WIHUEaCtCShEKi/Hhp5s/nzrXUdBiFqHzlczuBTz12
 Fiiqyc3jb8anOYI2r+98FSBhCijzrDGVAM65QX/WmOj8xN3Y5Oja4W06F/dq/FaI+6xR0OHs
 FANgc6S5qYCAPmweDelGbtXWuvzvrDcbWOa0QUH84QdGyqFq1yCUKd8zz5EC15rNcYhdATVY
 HbqkFYEjHNMB0eCYahyaoO3Ls0ly6n8CNjoPszpgspyjotZL1Heonw3DaKE9yW0yRV3z/ljU
 XuOWZv0VR4n5bJbIC1argv3+Zsi3WgAyGzaXvgXJDz3gOPFNBZ5pVroWWZij9zVDovY8W05E
 P4FbqNmLimzt8WlOkHqHXY7dwxiEJTCLcmeRzZrXuCCOBF6P2oqFuXcx7gsE6Q8wfgOybuRr
 yDgAxEIoLYauZEgAV7SAk2PlZu1BcovxZ7FFXBE0amUN4gLPt/0sfZ3m2ofdrg77u1zpcOYv
 NFeE/hs9s9nE2ydkxxENMGVhNU7KHyD2FzSVwL4PmlXV8MwFmThp46/FiOypXZmM8ZCnZZky
 1FW/lmFEcNrqsULJJu+Vc9DOHvq7CVExbIvAxCVSjSREW21mLVXx+XKpqZfC+kHKAnZxyvc0
 ACTABwCovLKrZNz+97M7Z1oZa/yewenNkYFTWTd85isMizWojiqzYNaCb7adjHBTmLkvq6lY
 LwNnf37NfQGmndMspZ9TOk3nf5vuYO3qu8I1BlgEVXKc0+vVuFqLE6Z0JQdraZK3LJY51e7A
 xrd5tlANLyVE8r5C1pNdhE9Z+GO2KhMyDnf5Pg4Omvg4ypz8ObVWEleJUDU2idcMKF0IMUux
 uJ44Jwa7Am2ixwLNNeaj38LqzTQfyJYC6h+78MUGo7mjAYv22puW52EB3+k+oyLZvVNLlIuf
 m2eip3diukO3UHFaXcySyTAhLIPmZQUtRlW51YePFDVyMHdj/o60RANozQ6SgNZkkdO3+5pY
 zU5MkR0IeOF/ityhdgFVGepQlkTCBqc80336l0IiGyGEBX4Cj2TdDUwabSX4UQU02NAZTwKr
 riXxVHsXSvuYMysjDA5XlRoqqC7QNF8nuEYdBtLwyhR80EGXAfY
IronPort-HdrOrdr: A9a23:Mf8nT6H7AhTjE4MqpLqFTJHXdLJyesId70hD6qkvc3Nom52j+/
 xGws536fatskdtZJkh8erwXZVp2RvnhNBICPoqTMuftW7dySqVxeBZnMTfKljbdREWmdQtrJ
 uIH5IOa+EYSGIK9/oSgzPIU+rIouP3iJxA7N22pxwGLGFXguNbnnxE426gYxdLrWJ9dP4E/e
 +nl6x6Tk2bCBMqh6qAdxs4dtmGg+eOuIPtYBYACRJiwhKJlymU5LnzFAXd9gsCUhtUqI1Ssl
 Ttokjc3OGOovu7whjT2yv49JJNgubszdNFGYilltUVEDPxkQylDb4RGYFq/QpF5d1H2mxa1+
 UkkC1QefibLEmhJ11dlCGdnzUIFgxes0MKh2Xo2kcL6vaJOw7SQ/Ax+76xNCGptnbI9esMoJ
 6ilQiixutqJAKFkyLn69fSURZ20kKyvHo5iOYWy2dSSI0EddZq3MYiFW5uYd899RjBmcsa+S
 hVfbXhzecTdUnfY2HSv2FpztDpVnMvHg2eSkxHvsCOyTBZkH1w0kNdnaUk7zs93YN4T4MB6/
 XPM6xumr0LRsgKbbhlDONERcesEGTCTR/FLWrXK1X6E6MMPW7LtvfMkfgIzfDvfIZNwIo5mZ
 zHXl8dvWkue1j2AcnLx5FP+gClehT1Yd0s8LAp23FUgMyPeFPbC1z1dLl1qbrSnxw2OLyvZ8
 qO
X-IronPort-AV: E=Sophos;i="5.88,337,1635220800"; 
   d="scan'208";a="63768349"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ORmd2n0mqLoAW1X6Bkx23MGUmoVpubmrr0uecx3xOQAOVhwmJVI5oK6taFac3bp9p3gU8vIvEACiCajNm8KizPCzcK+VYKXU/dAXCvE6tGpAQ8MBpxXr6AUbjKVoB/uzULqMcuPUGvyoDPnV6Y0v/bXFyesMIv5c3uj5QaZscCfkPA3GUj7Y+ZCy5mc5UIDKNLnOtZJwdRgcRbKl8wo291djEDgw2xCpl+/eF4kkwZsB0wllIb/DiffLcHvymqGnPrqKLDWIjqkSk/GdsdvK2eb8yFIrBHo3983CxkFU5aqQmz1IHKaiFpvHvO6j6t1l1yF8nwFwMYZMKWZLqYESyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zpLrYB8dNQCPlEsgFLGKaGshe8Z8BMaNPvtxtwk+89I=;
 b=jHPZBKTdsG+6p7qFaoh59eMC4njoeaqS+VL7j5y1+7RCnDUMnUdlmynaF+mWBkZzthBy6Ue7qIvjD/eTnvfnZERDgFrS5rYDlYjSNIEtMYQbWUCuQhj+y89m12J+4u20pWKvpKZb2IWSM6Q+cQRfylVFoI9YeFoSN4+pauuFkqk893sDGtwh0h9CQUT+6DgqsrEugcCpjfh+26ffkgg8ST2kYZ+TTi+y+iiv49t4qbz5zVm065tMBy2sypEGaA67nwKogVMqbbCB/ELbIepXPX/mu23qYFd99PDJPCrVI2zkian62nTC+beXTCER7XXVb2e0m1MHBOl7Iz60iWxpqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zpLrYB8dNQCPlEsgFLGKaGshe8Z8BMaNPvtxtwk+89I=;
 b=goiPTnKMNP7CldOmXjRf16c6zIFDHdP0fhwN+yHSD4V6uVt4DiEfjW8XGWtM+/sSAk3XlkofnCplxRBjoRM1Rt2uh3GDZ1YeZ1TXTG5fyAUzvaRuaqZkY9eWleebxCcx0SS6lOSoT6QVJiZie+IdVc/emFBS7eNUszGA2OpHZsM=
From:   Andrew Cooper <Andrew.Cooper3@citrix.com>
To:     Jordy Zomer <jordy@pwning.systems>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Oded Gabbay <ogabbay@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Ofir Bitton <obitton@habana.ai>,
        Dani Liberman <dliberman@habana.ai>,
        Yuri Nudelman <ynudelman@habana.ai>,
        Sagiv Ozeri <sozeri@habana.ai>, Koby Elbaz <kelbaz@habana.ai>,
        farah kassabri <fkassabri@habana.ai>
Subject: Re: [PATCHv3] habanalabs: fix potential spectre v1 gadgets
Thread-Topic: [PATCHv3] habanalabs: fix potential spectre v1 gadgets
Thread-Index: AQHYGHQ8JXzLCfBVAkqBRfpXY3G8L6yAvx4A
Date:   Wed, 2 Feb 2022 21:01:14 +0000
Message-ID: <ff3ea1f6-0e4b-1dc9-de46-1d70bd730b0b@citrix.com>
References: <YfrVOylHQYqjiWJ5@kroah.com>
 <20220202191104.3526448-1-jordy@pwning.systems>
In-Reply-To: <20220202191104.3526448-1-jordy@pwning.systems>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a0cf4573-793c-4fb3-9280-08d9e68f2695
x-ms-traffictypediagnostic: MN2PR03MB5248:EE_
x-microsoft-antispam-prvs: <MN2PR03MB5248ED87B5C4D323BA5B5C8BBA279@MN2PR03MB5248.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k7drfyydWDxYn0jAaiCvuS+xErXASVoxSJ6qU+XtajOHviCEe//GmJdhWILnQd43EvIZJu09JLXdMZJz3rXSiFvZUTABeB9LkMbT6BHlJnCBazmjnR9wXkXTzqioleoPt/j8gFjPVfIKju4Nfh+LW1CETAqtOh4DfNSnYev/vPUlSdzeBs0sepvgvg3c8un0xlyiQL0tm0iriWi7eDsE93jMNd5slxOH2MgdrNKSmpxf7XZnY0qfWBhTsNiSm4WTG57rAWAkgrr8HBx4DnxVOqs4UzTLKjgntsQMC7nlFOWyWEcqd4bK6/NgVxK4Ps56319XUGbyiRKwhBc4qJVwjAS3R/nn2MleD9B9WRaBx3SRkAC63vXBHW/ivs4TtCiTNhvuANpGIfYpVEvm29QUK081yWpcDhBCiDUrviXYmaN+4ZXC4mttH6REVciKvzOCihj29qqXRNDkVM57phAkPbHitf62QOARRyKHhqwcrzQ0LevuoE7ePRSPrRzXkMzf7ckgPd2oD6jG0lW/+Oj9HpoI5i0arXw0ttMHePWCksJDDHu5drpXXBv8G/8rd1hmfViTsq+jkJ7PIBxexuo5fZ/k/HjZZxNC2fhhKi8M91COm7xSKRwZU1YihehAttQbaFiQd9hUGqEduaSjjcTzGYXti+e6AGmqGO30P3JVJKJADGamsOl3Tw/Biys7H17Wqj8WtlGqTwcRTNyKHZ3ENjA1M9XgDDQRQksZsTP+iBwwcohpH9IUvtBXMRPQ98Ag0ZUjlshYIpPBCh5l872s7A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(86362001)(5660300002)(31696002)(7416002)(122000001)(82960400001)(38070700005)(6512007)(316002)(6506007)(2906002)(110136005)(508600001)(71200400001)(31686004)(8936002)(8676002)(53546011)(66446008)(66476007)(2616005)(64756008)(4326008)(54906003)(76116006)(66556008)(26005)(91956017)(83380400001)(36756003)(186003)(66946007)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a3NXWFZzMmNrY1FheWw5RzQrSjlPQjdLWkhhRVVGT3RqaWNWWGZtZWpjbytK?=
 =?utf-8?B?SFNXdkp6NUJjcHduUXVGQWFKK1M0aFVQajk0T1paN1ZOQ1VURDNVTm5SWEVG?=
 =?utf-8?B?d0h3VXhnVFExY2c1STJpMXdjL1psZmRIVFR3MFplT0Ezb3hld3VFblRIcjh2?=
 =?utf-8?B?QU03OFR5SVp2TzAzRG55a09jVTYvMm41TUJmT0RjRFFwbDg5SGtQdTJCVmlG?=
 =?utf-8?B?M3hVamN3dUlwZUVzT0k3RFF6UHBZcWVablBOMDlMSnpTMTFTNU1KTEptZWI3?=
 =?utf-8?B?d3FkbUM4S3JDU1M0L09UdVhBbEF6TytwS1FhdUFOVE5iT09kOG5ybGVYVEVO?=
 =?utf-8?B?K25WMnRVTzBxSHEzQWJSZlU4ZEdPaVhRSk9rMytRa2VaY0lMMFRzbXRiUkFz?=
 =?utf-8?B?N3JqcWxVUW9GMUsvZ2ZvTFVZVjdvVHA3UU5FcHJXK2w5YXF1SWpMbk80SzRo?=
 =?utf-8?B?RCtWWjRwRDVLMDA2dlJySTk4dUlRbnFza2VYYW14QzRzYkw0MzVFdXBwQVhY?=
 =?utf-8?B?R2Z2Q2szcGRYRFVpbEduUkVLU3NoenpkYVB5cnRKb1FzQktWMk0zY01YaE5W?=
 =?utf-8?B?TnE0a1lWOFM0b3RMT2VzUDRQQXJQTGZ0YXFQbkgxRHhMd0NFZnZyR0lVSWxu?=
 =?utf-8?B?ZWNJd2lNaTVwWTZnTlNLcE5xSVJYU3h0R1pkbXNNWTloZk11N1dvODRVclNS?=
 =?utf-8?B?MmZjeDVFd25icVN3VVNWcmhnZW1rNWc0NkFMd2JFRzQxbnpTdkVoQTFhRmVV?=
 =?utf-8?B?UEJKUWpYaFdRdCtoRklQUXEvRFRWTklGcm55bmlXaW9vUU5CeU5CRSthcXJi?=
 =?utf-8?B?RkE3RnFZZlZxemZxRndkQklwaFBEV0xJdnViK3UvSGFITGIwRHoyVmtiK2RG?=
 =?utf-8?B?UE5CZWJER2ZCOTkrbHhTTG9OM0QrejZOS3ZtRXJyc1BwdC9ma3RZbXFhb2hN?=
 =?utf-8?B?a3luME02R1dlcXU4NHZvWVFrNmxBTGh0SVBvZDhuNnNpV2RmL2FHaTQvcjk0?=
 =?utf-8?B?NXVmNGNFL01xSDhBVXRBWW84MVdxREpwRDVBTkpCNm14aGF6QzRqem92YWRO?=
 =?utf-8?B?dmdLeCsvN041c3lsVVc0NXRMaFJ3QnQ5eUNOQlhnb0N5cEptdFVIbUJMOFAz?=
 =?utf-8?B?NUQxSTRWeGI0blpnUU5qWnZYcHB3azAxdUlrSEIwK1pUa0x2V2Z0OXJqRmZu?=
 =?utf-8?B?U2R2MkFDNHZZWUhlVEFjbkF3SGZYMlBPVEwzRlcxN3lRSE1tWGxxbmxPaTha?=
 =?utf-8?B?TjZQZVgrZzVTTUVGVGhFemo4bUtRRU0wLyt2ajFvV0xNRERCUm11TnF1RzVu?=
 =?utf-8?B?ZzVGRGNrYTBhUU0zeEFnc1JzNXVIcEJ6cE1kUzczWEs4Q0JtOWZjZjhFalVJ?=
 =?utf-8?B?TVdNTWNxUm1KNGZEWlQvTENUVVpRZTl5NFRHdzNXWDNWNENKazc2NGVtYXds?=
 =?utf-8?B?VEVKVG5OMjRpRjJlYjFGL2xqWjczczlEWisrbXQzMENPVFUyaDk0T3MrUHR2?=
 =?utf-8?B?bXpKYTVIMEplYjRXdFl6TGxFYVc2SnhKY1cxdzFKVkltSWE5MUZ3TWtCZHVS?=
 =?utf-8?B?NS9FU2piMjZNYjRJVTRJT1lGL0tMS3phb2FtODdEQkhTazhXV1g2Y2tVblFU?=
 =?utf-8?B?OGxxTitULyszcGh2Wm5WcGJQWFJwSi9DdjFjUGFxN0t3dFQ2L05BZGlYUyts?=
 =?utf-8?B?NkNBSWszYzc0YnBqMGpkNHJoeVJuYkJOQmJlVVBxdm9YWGRwbmkzcTE3OFQx?=
 =?utf-8?B?MU13Q0dJb2o1SXNKd3lVZzlRMk1LSmcrR0RjZjd0c29Ld2I0ZU5JL1FZNWJv?=
 =?utf-8?B?UXVjL1IzZDB0b29hNUdXQ2YvN3EwNStNa3lqUTMwRkx6U0tTVEk5MXlWdWtw?=
 =?utf-8?B?VVBiZ09iKzBLb3F3L2IzdXJTa3hMY1hJMXJaVkJETStzNzc0aUt2Z0YzQ2I4?=
 =?utf-8?B?Rkx5ZjErZUExOGc5anBYc0dob3VOSzExR3o3c3d1YmIxSkxSOEZ4YjZ5Ymkz?=
 =?utf-8?B?K3BLVFRvSWxtOFpCVXhYWGdPbnNhOHJ6Zkk5U29Ec3hWVk50NFNXUWE2WDR2?=
 =?utf-8?B?RjhpSDdrbDJZcW5WZU5tMVV3MmV2VXRPZ0VUeGhPaTFGVzRMV2FDQUVwWnpm?=
 =?utf-8?B?WUxwbjk5Wkh6eE1WanpvR004QnU5MDhGL0xUQmt1dU9PRTVBUDFsRjdMMGg3?=
 =?utf-8?B?c0ZLY2NWeFNqOGFVWXU1TDZOUjJaOVZDeFczdUlvQjlLa1pJcjM0NElVY3dY?=
 =?utf-8?B?aE9BeXZ5Y09QNUZ6bDllaGtvNFpRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D73035E018C8B249B56D06947DE91E6A@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0cf4573-793c-4fb3-9280-08d9e68f2695
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 21:01:15.0746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KluZ5YR+WgnVfDMitfO/+semPS7L9+U7LaH/85mXVHdRJrF6BOOUrpisrZ5BYVDhJvZ+7oKEqGe5Oo4V+I5QfQkPlwm5d3+oY6gcjHS0HnU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5248
X-OriginatorOrg: citrix.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDIvMDIvMjAyMiAxOToxMSwgSm9yZHkgWm9tZXIgd3JvdGU6DQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL21pc2MvaGFiYW5hbGFicy9jb21tb24vaGFiYW5hbGFic19pb2N0bC5jIGIvZHJpdmVy
cy9taXNjL2hhYmFuYWxhYnMvY29tbW9uL2hhYmFuYWxhYnNfaW9jdGwuYw0KPiBpbmRleCAzYmEz
YThmZmRhM2UuLmMxY2RmNzEyYTEwZCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9taXNjL2hhYmFu
YWxhYnMvY29tbW9uL2hhYmFuYWxhYnNfaW9jdGwuYw0KPiArKysgYi9kcml2ZXJzL21pc2MvaGFi
YW5hbGFicy9jb21tb24vaGFiYW5hbGFic19pb2N0bC5jDQo+IEBAIC04NDksNiArODUwLDcgQEAg
bG9uZyBobF9pb2N0bChzdHJ1Y3QgZmlsZSAqZmlsZXAsIHVuc2lnbmVkIGludCBjbWQsIHVuc2ln
bmVkIGxvbmcgYXJnKQ0KPiAgCX0NCj4gIA0KPiAgCWlmICgobnIgPj0gSExfQ09NTUFORF9TVEFS
VCkgJiYgKG5yIDwgSExfQ09NTUFORF9FTkQpKSB7DQo+ICsJCW5yID0gYXJyYXlfaW5kZXhfbm9z
cGVjKG5yLCBITF9DT01NQU5EX0VORCk7DQo+ICAJCWlvY3RsID0gJmhsX2lvY3Rsc1tucl07DQo+
ICAJfSBlbHNlIHsNCj4gIAkJZGV2X2VycihoZGV2LT5kZXYsICJpbnZhbGlkIGlvY3RsOiBwaWQ9
JWQsIG5yPTB4JTAyeFxuIiwNCj4gQEAgLTg3Miw2ICs4NzQsNyBAQCBsb25nIGhsX2lvY3RsX2Nv
bnRyb2woc3RydWN0IGZpbGUgKmZpbGVwLCB1bnNpZ25lZCBpbnQgY21kLCB1bnNpZ25lZCBsb25n
IGFyZykNCj4gIAl9DQo+ICANCj4gIAlpZiAobnIgPT0gX0lPQ19OUihITF9JT0NUTF9JTkZPKSkg
ew0KPiArCQluciA9IGFycmF5X2luZGV4X25vc3BlYyhuciwgX0lPQ19OUihITF9JT0NUTF9JTkZP
KSsxKTsNCj4gIAkJaW9jdGwgPSAmaGxfaW9jdGxzX2NvbnRyb2xbbnJdOw0KPiAgCX0gZWxzZSB7
DQo+ICAJCWRldl9lcnIoaGRldi0+ZGV2X2N0cmwsICJpbnZhbGlkIGlvY3RsOiBwaWQ9JWQsIG5y
PTB4JTAyeFxuIiwNCg0KU29ycnkgZm9yIGp1bXBpbmcgaW4gdGhlIG1pZGRsZSBoZXJlLCBidXQg
YXJyYXlfaW5kZXhfbm9zcGVjKCkgaXMNCmZpbmlja3kgdG8gdXNlLCBhbmQgYm90aCBleGFtcGxl
cyBoZXJlIGRvbid0IHF1aXRlIGJlaGF2ZSBhcyBpbnRlbmRlZC4NCg0KKEluIHJldmVyc2Ugb3Jk
ZXIpLCBmaXJzdCwgYW55IGNvbXBldGVudCBjb21waWxlciB3aWxsIHR1cm46DQoNCsKgwqDCoCBp
ZiAobnIgPT0gX0lPQ19OUihITF9JT0NUTF9JTkZPKSkgew0KwqDCoCDCoMKgwqDCoCBpb2N0bCA9
ICZobF9pb2N0bHNfY29udHJvbFtucl07DQoNCmludG8NCg0KwqDCoCDCoMKgwqDCoCBpb2N0bCA9
ICZobF9pb2N0bHNfY29udHJvbFtfSU9DX05SKEhMX0lPQ1RMX0lORk8pXTsNCg0Kd2hpY2ggY2Fu
IGJlIGV2YWx1YXRlZCBhdCBjb21waWxlIHRpbWUgd2l0aG91dCByZWZlcmVuY2UgdG8gbnIuwqAg
QnkNCnVzaW5nIGFycmF5X2luZGV4X25vc3BlYygpLCB5b3UgaW5oaWJpdCB0aGlzIG9wdGltaXNh
dGlvbiwgZm9yY2luZyB0aGUNCmxvYWQgdG8gYmUgZGVwZW5kZW50IG9uIG5yLCBhbmQgd2l0aCB0
aGUgZXh0cmEgbG9naWMgdG8gdHJ5IGFuZCBtYWtlIG5yDQpiZSBzYWZlLg0KDQoNClNlY29uZCwg
YXJyYXlfaW5kZXhfbm9zcGVjKG5yLCBITF9DT01NQU5EX0VORCk7IG9ubHkgcHJvdGVjdHMgdGhl
IHVwcGVyDQpib3VuZC7CoCBJbiB0aGlzIGNhc2UsIHRoZSB2YWxpZCBsb3dlciBib3VuZCBpcyBu
b3QgemVyby4NCg0KaS5lLiB3aGlsZSB5b3UndmUgcHJldmVudGVkIGFuIE9vQiByZWFkIG9mIHRo
ZSBobF9pb2N0bHNbXSBhcnJheSBhcyBhDQp3aG9sZSwgdGhlcmUgaXMgc3RpbGwgYSBTcGVjdHJl
LXYxIGdhZGdldCB3aGVyZSB5b3UgY2FuIHNwZWN1bGF0aXZlbHkNCmNvbnRpbnVlIHVzaW5nICZo
bF9pb2N0bHNbMF0gd2hpY2ggaXMgb3V0IG9mIGJvdW5kcyBmcm9tIHRoZSBsb2dpYydzDQpwb2lu
dCBvZiB2aWV3Lg0KDQpPbmUgZml4IGlzIHRvIHVzZToNCg0KwqAgwqAgbnIgPSBITF9DT01NQU5E
X1NUQVJUICsNCsKgwqDCoMKgwqDCoMKgIGFycmF5X2luZGV4X25vc3BlYyhuciwgSExfQ09NTUFO
RF9FTkQgLSBITF9DT01NQU5EX1NUQVJUKTsNCg0Kd2hpbGUgYW5vdGhlciBpcyB0byBjb25maXJt
IHRoYXQgdGhlIHN1YnNlcXVlbnQgbG9naWMgaXMgc2FmZSB0bw0KY29uZnVzZWQtZGVwdXR5IHBy
b2JsZW1zLsKgIFRoaXMgYW5hbHlzaXMgcHJvYmFibHkgbmVlZHMgZG9pbmcgYW55d2F5IGFzDQp0
aGVyZSBhcmUgbXVsdGlwbGUgaW9jdGwgaW1wbGVtZW50YXRpb25zIHRoYXQgY2FuIGJlIHNlbGVj
dGVkLg0KDQp+QW5kcmV3DQo=
