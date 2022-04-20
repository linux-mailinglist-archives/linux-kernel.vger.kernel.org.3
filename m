Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39761508C01
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 17:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380187AbiDTPZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 11:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238152AbiDTPZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 11:25:23 -0400
Received: from esa6.hc3370-68.iphmx.com (esa6.hc3370-68.iphmx.com [216.71.155.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88AB945797
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 08:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1650468156;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ajc7tNbbGPWIctUbbCGk2QBq3ugT/V+TsK8nwL4vgrc=;
  b=MLl/Zgvg/ub8id7C6duvefCkmMDddf9158ZojHzv6M604Hel4Md7j207
   CB/HdZuOlwlbpiPEMf4cOQ1ToMJJzlnL76RrLnOOgK0ZKvEKd2CLIWKAW
   QXGIXaMOjoHV3SN/bhxjYFoa9frGhe3n43J+d7IFKIJ5YJLGo5hZnL33b
   s=;
X-IronPort-RemoteIP: 104.47.56.48
X-IronPort-MID: 69400021
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:7bcSHq3hIXaFvO0AavbD5e9wkn2cJEfYwER7XKvMYLTBsI5bpzVSy
 jNOWT2CPfnYZWqhLt8ibYyypB4O6MXQn4VlGQFtpC1hF35El5HIVI+TRqvS04J+DSFhoGZPt
 Zh2hgzodZhsJpPkjk7xdOCn9xGQ7InQLlbGILes1htZGEk1EE/NtTo5w7Rj2tIy2YDja++wk
 YiaT/P3aQfNNwFcagr424rbwP+4lK2v0N+wlgVWicFj5DcypVFMZH4sDfjZw0/DaptVBoaHq
 9Prl9lVyI97EyAFUbtJmp6jGqEDryW70QKm0hK6UID66vROS7BbPg/W+5PwZG8O4whlkeydx
 /11lsyNVxoTIZHDo/UiWTVTF3FZfup/reqvzXiX6aR/zmXgWl60mbBCKRpzOocVvOFqHWtJ6
 PoUbigXaQyOjP63x7T9TfRwgsMkL4/gO4Z3VnNIlGmFS6p5B82dBfmajTNb9G5YasRmNPDSf
 ccGLxFoawzNeUZnMVYLEpMu2uyvgxETdhUG+Q7N/fJtugA/yiQh9ZvDaOTyJOa0Yu5phEzCv
 m7r9UnAV0Ry2Nu3jGDtHmiXru3AhyTgQ6oJCaa1sPVthTW71mEVTREbS1a/if24kVKlHcJSL
 VQO/SgjprR081akJvH5XhulsDuHswQaVt54DeI38keOx7DS7gLfAXILJhZLb8Ynr4kxXiAw0
 UGSnMLBAiZmu7mYD3ma89+8tiiuMCIYKWsDYy4sTgYf5dTn5oYpgXryos1LFae0ipj5HGr2y
 jXS8ywm3e1P3YgMyrmx+k3Bj3S0vJ/VQwUp5wLRGGW48gd+Y43jbIutgbTG0ct9wE+iZgHpl
 BA5dwK2toji0bnlePSxfdgw
IronPort-HdrOrdr: A9a23:ywEnaa+2CbB9/t0GwkFuk+GBdr1zdoMgy1knxilNoENuH/Bwxv
 rFoB1E73TJYW4qKQodcdDpAtjifZtFnaQFrbX5To3SJjUO31HYY72KjLGSjgEIfheTygcz79
 YGT0ETMrzN5B1B/L7HCWqDYpgdKbu8gcaVbI7lph8DIz2CKZsQljuRYTzrcHGeMTM2YabRY6
 Dsg/avyQDBRV0nKuCAQlUVVenKoNPG0Lj8ZwQdOhIh4A6SyRu19b/TCXGjr1cjegIK5Y1n3X
 nOkgT/6Knmmeq80AXg22ja6IkTsMf9y+FEGNeHhqEuW3bRY0eTFcZcso+5zXQISdKUmREXeR
 730lEd1vFImjbsl6eO0ELQMkfboW4TAjTZuCKlaDPY0LDErXQBeot8bMtiA2XkAwBLhqAC7I
 tbm22erJZZFhXGgWD04MXJTQhjkg6urWMlivN7tQ0WbWIyUs4mkWUkxjIdLH7AJlOJ1Kk3VO
 11SM3M7vdfdl2XK3jfo2l02dSpGnA+BA2PTEQOstGcl2E+pgEy82IIgMgE2nsQ/pM0TJdJo+
 zCL6RzjblLCssbd7h0CusNSda+TmbNXRXPOmSPJkmPLtBNB1vd75rspLkl7uCjf5IFiJM0hZ
 TaSVtd8XU/fkr/YPf+q6GjMiq9NFlVcQ6duv22vaIJy4EUbICbQhGrWRQpj9aqpekZD4nSR+
 uzUagmdsPeEQ==
X-IronPort-AV: E=Sophos;i="5.90,276,1643691600"; 
   d="scan'208";a="69400021"
Received: from mail-dm3nam07lp2048.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.48])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Apr 2022 11:22:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DXeE8/WtlgPbw+XeWo7px7IbI8n1w3T3Q63A5sSiK+fFq1tMMOkW7RDrFNePkGsmFMSQzNQ2C/PUn+0Pa89TLCisK7Hqw/Kgm+Fpwu30itiRrn4aECVnsVU2i1wDP1/Kzk+S8QNpff5DjR6lzsaAZUfcrJzrVOpq/z0qVH/IdEIwa0EU9hBjHtGaeVCd21jFuVQouyWKB29FizWkkAe9d5Yo2QV3qO4yDFjMNZU0mBIMBVXHbp818qmZMaohzHr0cuYpQ4iMVcHqUrnvc4ivEwp+AFwPLYsnI62q2MCTDGFacr1/7Kv/NcSU8sGhh4t4pS78BJT0pC9vZ4g5cYtPig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ajc7tNbbGPWIctUbbCGk2QBq3ugT/V+TsK8nwL4vgrc=;
 b=R0yOzXoFNJbbCfj1ekVvIj8b/4pZskk+Xpbs1R1OV1G3q+PQflOpAtQhzVMsZHU2aj7DGPBbRDChC82b0b7da+DPffXO0a9UPb7H8SJ4/EszEB8wV/Azfzly+fZzcqa5GnLFrdkRF7XZm/4shv6yLClKNPXBUQFENt7CX2EchjzGZhN5H1aFLgflbLUUdtqMYrRRJyjLe+qzaYQlStOMgqHPJQ6KLZOziTQ/FnqHmonnjY9PFDKg/wJILCfDu/3Wecm+OqPlFJoG0jXu+zYa6AFcn8e/eIpDfefjLJjFOuOGUwaMHiVGtOkTzE1Fy8NgR1AT6HALPG87NYCQHO+ymg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ajc7tNbbGPWIctUbbCGk2QBq3ugT/V+TsK8nwL4vgrc=;
 b=qaLCf5kiwf735s4Ap7tm0Dwk6dB5lUgN21xyvPH4ojlFdxfoge07YNlusDas1vVMmG/JgBwnz2vrb9U+JlvIhWReD6oHNI3EHkS/cj5trRwdGU5QgGY0jRCrvBdw+i7SUPH4gCbdvxtZSxNyuq8VqGTYLvl0J4+nyVzbpigQZL8=
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by BYAPR03MB4181.namprd03.prod.outlook.com (2603:10b6:a03:7d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 15:22:32 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::ac51:a410:14d4:de37]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::ac51:a410:14d4:de37%6]) with mapi id 15.20.5186.014; Wed, 20 Apr 2022
 15:22:32 +0000
From:   Andrew Cooper <Andrew.Cooper3@citrix.com>
To:     Juergen Gross <jgross@suse.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: Re: [PATCH 18/18] xen/xenbus: eliminate xenbus_grant_ring()
Thread-Topic: [PATCH 18/18] xen/xenbus: eliminate xenbus_grant_ring()
Thread-Index: AQHYVMkyGaYzhccwwkWCnGeb0Tf8nKz461YA
Date:   Wed, 20 Apr 2022 15:22:32 +0000
Message-ID: <fdc5675e-7766-2144-8f56-a49faab9631a@citrix.com>
References: <20220420150942.31235-1-jgross@suse.com>
 <20220420150942.31235-19-jgross@suse.com>
In-Reply-To: <20220420150942.31235-19-jgross@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bba60d3f-9a84-4d28-e368-08da22e1970f
x-ms-traffictypediagnostic: BYAPR03MB4181:EE_
x-microsoft-antispam-prvs: <BYAPR03MB4181306827CC220B964F2297BAF59@BYAPR03MB4181.namprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O65np1h+M0gzluCzYQNORH1WbE3wu0LrlDNMYICvTuAH/R6C6KftH9hhWZ8XCz4OEEWKee5P/d3ZAMnWWdupEIkLnuBTwA9u6NhUgZt4yOCvuTiCtQ4Gh/IoqtWp+IcLP5ikJI11KXohHyW52k7ZaSo3+81Fjt8LMmYhV1NDWs8tYQgLasDmTTbxLmV65EQdZzQq5FufzKaoy89yAm1fPsdJig0pzMBSFHJEGasG2taxLoDxYMFOVZOH7+Z+F7DLAtCwXDMnrTFXR2eIANBpoAUvDIpXYrWCZAh5CxlB3+J/BdhvfzmpjYohvOQMWX1U1AmL6Xp18xUpWGJMRCBJr/unoei4AOsWsfal8dgQg0KRmg925+OtV3+RcGePEc7E2iYon110XadqpwAUCZlofvrnH4gRg5aAgP81l7fjbnO7Sgnw6T6j+QeBiOZ6QqP/zlre2kSX+TVNWveeQccBD2T6zjeIjjr2nGIfYvb/kdq9ll+kPkGAnWEics0q6guQI9tKGEinY64RQbAT83MHtqHnS9kv45XF0S1DpyWOF/BvsANliUAMClYcLL1K1KTqsfRrtN5UeiD/MBEANbLWdABL0pOE27p1mAq4OwFls8OW1SQ3iAWYMWIUzsoziWEqXdnO49RXR1xHV9lZwiib4pqhL+d2yKyIkC7PHhcZXJkeWWwLI4hToSlU0ZLvmw2SX+iS3vfTx9n867ytaw9F7JFCes8FJsMsMOgGew50NwZ37U9+gJ7PjWbN+cUi00omDFg+LpvH5mNbQ928KPzj7iK1h2dnG4+/CkS+ShBpkVbe+hRfJMqCBexKUSAKDtYg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(508600001)(4326008)(83380400001)(66946007)(8676002)(66556008)(6486002)(66476007)(66446008)(64756008)(110136005)(2616005)(82960400001)(38100700002)(316002)(38070700005)(54906003)(5660300002)(36756003)(8936002)(31696002)(6506007)(6512007)(86362001)(26005)(31686004)(53546011)(4744005)(122000001)(186003)(91956017)(76116006)(71200400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V1JaWndZNFpQbUs0Y01Uekdtem5tNE5selVIdHE4eFZjalpibDBON1JGVlpo?=
 =?utf-8?B?R0JLd3VVOWI2Uk0xT2J6aGlSVkhxN1EyY09tRVlkMzl4RmJsZzZ1VFRHaUVI?=
 =?utf-8?B?NDllSzN1d09ZcVZUY01QdFkzZCs4b0RJZzZaWmJYbmFpMnlXWTVRK3U5QUdQ?=
 =?utf-8?B?QU53aTE4VTZZTlVPWkhDSW4xZnR2NjZ2Nmdsc2ZvdEdlc2I1VTZ1eUZJMnNW?=
 =?utf-8?B?cFNIUlhWWEVCRlNXZ05RQ00vYjZNOEhjQmZDZHdmVmpNZnpkZkVnOTJmdURq?=
 =?utf-8?B?bE1WZEVYa2JtSStBaFpIVVphRTA1Wnp6NHBYdEhaRm56dmVmd3NTeU1mSEp2?=
 =?utf-8?B?TFFIdTRWSkRWWFI0Y0JyTXZTeVArQjV4eEhoR0kzcnJPL2toVmloZnBaTGRo?=
 =?utf-8?B?T2tBT09hYi9EU3c2NUZESWp6VExMRXh5SzRTbzV6TTlnYUJkbzFpbW02em9B?=
 =?utf-8?B?VGR4NkgwOHd2bUdXSDUrOGNlMWtHNzhDZkF1aEZDY21DR3pvTHNWN3BhWW90?=
 =?utf-8?B?UnlyU0VWNzZyQlBuT2Z3T2cwYWhkUDFMOGpQdFFGMWo4ZmJNWGRmeWJIenlr?=
 =?utf-8?B?UWM3QkdNcDFXV3ZsZ2QvNzVBQUJWM3FBUHhiazlKSDhEcTc5WjFaTFU3eU9U?=
 =?utf-8?B?bmNubmpQYmdFZ05hQWMxNGNDdjBjSnRIU2tMTkhDc01jc3FISEZOWW9oRHBo?=
 =?utf-8?B?MWtYNDFkNVFPMUp4VUlROFJIZHZ5Zmk1N3JlSTREQ2ZJempKS3Q1QzNuUWpO?=
 =?utf-8?B?UVpZbndIRXA1UmF4S2IvWkl4VVhKdnhhV1hqT01EcDVtYXlPaEtaSnFIVjZq?=
 =?utf-8?B?OXdLTUgzNTRmWm5kNW43ZU9vaXBhWHRmZU1kajBzZG9mYkdUblhPZ1ptdHlE?=
 =?utf-8?B?MjRvZ2h5QUVab0pkNkplVktvckxmL05rVVBYQjRJOVNOTWdqKy9iSmNyR2Q1?=
 =?utf-8?B?V2xJWGhDVTNMVUQxOEdSeE40eHlKYTJ0SU1FRCtMSFdzVFhYRFJIdzZxSll0?=
 =?utf-8?B?UStYbGRyM04vU1FEeUpZTExvVlRhKzhvWHRQRlFvTDRDdG1qejVYZmVzTVJL?=
 =?utf-8?B?ZDFxNXBLMG5ZMjNYRXhDc0RYdFUyR01OTW9mMC9qZGNxVGFSbWpqc1NNSXMy?=
 =?utf-8?B?Q3QybEt3OTRhV3VpSHhKYmNpOFlTTU1Qem5oNklSSWV1Wlpvc0MrY2VUTkk3?=
 =?utf-8?B?Y2h0cHJtQW9UVWg3Vnd3M1VKSU12U0NKNzFreDkrbU1JR25IOG1MVTFNVlVJ?=
 =?utf-8?B?aTVBN1I0MkNuWXpYVjZ6ZThzQXVqTHNzNzNZNGFmODZZVDUyV2NtUWdHR29w?=
 =?utf-8?B?VHF3QnVZd1luUG5LZVduWnRPWnNhdi92THNnTVpVcStvbWhBNitQTG01RC9G?=
 =?utf-8?B?a1lwSjJadGg3Vk1rRzU3bFZVSC9NV2RwMEM0ZXJYMzh6SndQamlkc3djUnh3?=
 =?utf-8?B?YklZZjZ1L3E4SS9RYk9YM0U1ODF3a3dwRUtrcy9iYjBzV3NrY0h4ZXczWkQz?=
 =?utf-8?B?SFBiZUF5MEM2ekRQUkNpd2VHUWd1N2lEYnE1NHJwZnpBQlkyMWp0MWxNRUs5?=
 =?utf-8?B?aGRCUVdDbWNOdGlBSEw1WDhjblg2YmxpTmVZNFdsYjQ2Tk9FZW0zYVpBL005?=
 =?utf-8?B?L0o2b2IxOEtoUzJTcENQQkJOUTBUWHdKOGxEVWlSY0dPMXpQWkh5ejhyTGRt?=
 =?utf-8?B?VWF3Q0RUWktaanFUVGljaTJFTHZNV2NJUWR0NnVLVmc5Vm5hU0R1Vng4RmVR?=
 =?utf-8?B?SW5JUC84enF4NFcyRFRSbXRuVC9WeURIL09HNGxndFptT2hXckdrS2ZhOTVH?=
 =?utf-8?B?ekdScFByUTUzYXF5TCszMVFaZ2NkKzdwNWJhNnhYRFg4RkVsK0tmQi9UZlJK?=
 =?utf-8?B?dmJXK004STM1T3drcGwwU01kaVl2K2lWTEQ3UXN0c3I1ZGFhL2xENnZ1ek1T?=
 =?utf-8?B?MkZSSWJDdEphaEVuMmxHVzFCWG5CRU0wUUFMdmNSM0E4dVhJVjUyNEE0dDBh?=
 =?utf-8?B?STZyZ2ZOYlF2OEpla29Yc29XVEFiR24wdWVMMVRMc3l4SHErN2V5YnVqU05v?=
 =?utf-8?B?VUkwb1FDZ1lKNXkxenp2VExBeHBmZDBXd241SEt0YS9la0tTMWpYUlVEVzYy?=
 =?utf-8?B?Z1hHWEt2a3FRMkJnQW05RkhoS3I1K0tjOEhHYXJ1SnM3WnN5d3lvVHZKNGJk?=
 =?utf-8?B?SW81OUhWVDF0bmhXajVndlJmTnN0NndySVEvaDBFZVpnNklYZ2tXQnJCT1Aw?=
 =?utf-8?B?aEc1L1loOFo1MnU2OWQ2dGZzV1dNa1g1ajlMZU5DRW5hOXY3dFlzS2RUQmVj?=
 =?utf-8?B?ZGh5ZGJ4bmVEcisyNEY4aTBuOEFGK29KeTBDRG55YjlkSnJCOVBidz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <22CCBF37A861C04FA021C24F492FD183@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bba60d3f-9a84-4d28-e368-08da22e1970f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2022 15:22:32.3420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x+kJ6Ki1wyEGof7r6nFPuy/9s7955Ho4xPbBHA6TXSoJBv/IO5FkqOCxKyUUr/OAs15eZjdYJjN6yEOVEHCsHRAQnbx6EF63kJ6xx5TI6aI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4181
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAvMDQvMjAyMiAxNjowOSwgSnVlcmdlbiBHcm9zcyB3cm90ZToNCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMveGVuL3hlbmJ1cy94ZW5idXNfY2xpZW50LmMgYi9kcml2ZXJzL3hlbi94ZW5idXMv
eGVuYnVzX2NsaWVudC5jDQo+IGluZGV4IDFhMmUwZDk0Y2NkMS4uN2IxZjdmODZiNmU1IDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL3hlbi94ZW5idXMveGVuYnVzX2NsaWVudC5jDQo+ICsrKyBiL2Ry
aXZlcnMveGVuL3hlbmJ1cy94ZW5idXNfY2xpZW50LmMNCj4gQEAgLTQzMyw5ICszOTAsMjQgQEAg
aW50IHhlbmJ1c19zZXR1cF9yaW5nKHN0cnVjdCB4ZW5idXNfZGV2aWNlICpkZXYsIGdmcF90IGdm
cCwgdm9pZCAqKnZhZGRyLA0KPiAgCQlnb3RvIGVycjsNCj4gIAl9DQo+ICANCj4gLQlyZXQgPSB4
ZW5idXNfZ3JhbnRfcmluZyhkZXYsICp2YWRkciwgbnJfcGFnZXMsIGdyZWZzKTsNCj4gLQlpZiAo
cmV0KQ0KPiArCXJldCA9IGdudHRhYl9hbGxvY19ncmFudF9yZWZlcmVuY2VzKG5yX3BhZ2VzLCAm
Z3JlZl9oZWFkKTsNCj4gKwlpZiAocmV0KSB7DQo+ICsJCXhlbmJ1c19kZXZfZmF0YWwoZGV2LCBy
ZXQsICJncmFudGluZyBhY2Nlc3MgdG8gcmluZyBwYWdlIik7DQoNCkNhbiB3ZSB0YWtlIHRoZSBv
cHBvcnR1bml0eSB0byB1bmJyZWFrIHRoaXMgZXJyb3IgbWVzc2FnZT/CoCAiJXUgcmluZyBwYWdl
cyIuDQoNCn5BbmRyZXcNCg==
