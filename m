Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39F9D57FCD9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 12:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234359AbiGYKDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 06:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233325AbiGYKDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 06:03:44 -0400
Received: from esa3.hc3370-68.iphmx.com (esa3.hc3370-68.iphmx.com [216.71.145.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B311706F
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 03:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1658743422;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=6Lt2GgxNPsKiOQY6yDwIBYB4wb+bQmMpmZwN5uWlm2Q=;
  b=RYtszie4z0NTK2ZatW9ZtTtxkFzrTHY4oN5ZEhVBBYPoknWKfD1PPYzS
   dgq3fEkcZJXVKMluG/hMDOJgBAIGfp/WQQn1UbXwONpAq+DgGWyINAG11
   FF2/F3VJziSK2WXhoGBLP5yTcLw7h4xFSsb4S7V4NXAdZ2tlzL7eCkeXu
   E=;
X-IronPort-RemoteIP: 104.47.57.174
X-IronPort-MID: 76543497
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:T64oFK3G0IIG9H55q/bD5f9xkn2cJEfYwER7XKvMYLTBsI5bpzIBn
 GMZW22POavfYzakfo1za9njp04H78PdytA2TlY5pC1hF35El5HIVI+TRqvS04J+DSFhoGZPt
 Zh2hgzodZhsJpPkjk7xdOKn9RGQ7InQLpLkEunIJyttcgFtTSYlmHpLlvUwx4VlmrBVOSvU0
 T/Ji5CZaQTNNwJcaDpOsfrc8k435ZwehRtD1rAATaET1LPhvyF94KI3fcmZM3b+S49IKe+2L
 86rIGaRpz6xE78FU7tJo56jGqE4aue60Tum0xK6b5OKkBlazhHe545gXBYqheW7vB3S9zx54
 I0lWZVd0m7FNIWU8AgWe0Ew/y2TocSqUVIISJSymZX78qHIT5fj665PA29rGqoow+tmHHkN7
 b8fAiAJbR/W0opawJrjIgVtruIKCZCyea865DRnxzyfCus6S5feRamM/cVfwDo7msFJG7DZe
 tYdbj1sKh/HZnWjOH9OUM54wLju2ya5KmIEwL6WjfNfD2z77gV33f7IOd7cftWMSO1en1qCp
 3KA9GP8av0fHIPBlGberiPz7gPJtRLyRpMtPoK+zKEpoXup/z0YDCMEUHLu9JFVjWb7AbqzM
 Xc88C00rLN081e3VN7jRB6piHmetxUYVpxbFOhSwAWMzLfEpgWUHG4JShZfZ9E88sw7Xzon0
 hmOhdyBLSxitviZRGyQ8p+QrCiuIm4FIGkafygGQAAZpd75r+kbjB3VSc14OLWoldCzEjb1q
 xiWoywur7ESi9MXzaK9/ECBjz/Ejp3ISAEyzh/aUmKs8kVyY4vNT4awwVHf7PtGfMCVQzGps
 HEalo6e5eYVAJelkC2LXfVLHbe16vLDOzrZ6XZ/T8cJ9Dm3/XOnO4dK71lWJF9gGtQVZTjzJ
 kTUvGt5/4RPNXGnaat2ZYOZCMkwy6XkU9P/WZj8ad5DYYN4cgOdyz1/fk6b323rk08EnLk2P
 NGQdsPEJXMaBLVhwRK/Qu4P1rltyi1W7WHZSI3/zh+n+aGDf3PTQrAAWHOFaeQ46uWHoQPa2
 9dZK8aOjR5YVYXDjjL/9IcSKRUGKCY9DJWv8shPLLfcfkxhBX0rDOLXzfU5YYt5kq9Jl+DOu
 HagRktfz1m5jnrCQemXVk1ehHrUdc4XhRoG0eYEYT5EB1BLjV6T0Zoi
IronPort-HdrOrdr: A9a23:oSxD2q8QvlFcFfJjAapuk+F0db1zdoMgy1knxilNoENuH/Bwxv
 rFoB1E73TJYW4qKQodcdDpAtjifZtFnaQFq7X5To3SJjUO31HYYb2KjLGSiAEIfheTygcz79
 YGT0ETMrzN5B1B/L7HCWqDYpodKbu8gcaVbI7lph8DIz2CKZsQljuRYTzrcHGeMTM2YabRY6
 Dsg/avyQDBRV0nKuCAQlUVVenKoNPG0Lj8ZwQdOhIh4A6SyRu19b/TCXGjr1kjegIK5Y1n3X
 nOkgT/6Knmmeq80AXg22ja6IkTsMf9y+FEGNeHhqEuW3TRY0eTFcRcso+5zXIISdKUmRMXeR
 730lMd1vFImjDsl6eO0FzQMkfboXATAjTZuCKlaDPY0LDErXQBeoV8bMtiA2Tkwltls9dm3K
 1R2WWF85JREBPbhSz4o8PFThdwiyOP0AwfeMMo/ghiuLElGchshJ1a+FkQHIYLHSr85oxiGO
 5yDNvE7PITdV+BdXjWsmRm3dTpBx0Ib1+7a1lHvtbQ3yldnXh/wUddzMsDnm0Y/JZ4T5Vf/e
 zLPqlhibkLRM4LaqB2AvsHXKKMeyXwaAOJNHjXLUXsFakBNX6Io5nr4K8t7OXvY5AMxItaou
 W1bLqZjx9BR6vDM7z+4HQQyGGyfIyUZ0Wc9uhOo55kp7b7WL3ndSWeVVFGqbrSn8ki
X-IronPort-AV: E=Sophos;i="5.93,192,1654574400"; 
   d="scan'208";a="76543497"
Received: from mail-dm6nam11lp2174.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.174])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Jul 2022 06:03:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZEXdpcaoJisglOJeG5MBQHtJq3pnd8UBLNMNXZmIdBp4qsvJnUh2FtlDhWKEnh1kAlfdNWyve8bYsclb1DzXR7NCqXWXpgThbFnLZ1gZmZmAOcDZ/8c9A0IVCVtcOtN7s2scjiW7l0pj2D8Ldys1gzD1PEXxohlhEZQSrjZgk7BJGTWPSOkHEt79g9w34Rbhg9AIg7bs7X0ReOJ/46EIBEErAyRCHpeIkWgpql7wsrH715wzGwg9S+7h4gprrwGn/hDlhHytq5dAokA4eRjxmxf0FRqA4pI6bV1hWK/IyOLfUcqYJ18+wiJ4gselplxYEQptxYBvCJs0XuW6KJLSDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Lt2GgxNPsKiOQY6yDwIBYB4wb+bQmMpmZwN5uWlm2Q=;
 b=bCDQjsunsU8HtuxF+AAYxy+Wj5LfTEgx0DDQpB+rlooNqMqlcbSIaaaKQuEQjjrMAXktU3Y+i5YoUBWvIYD8rpXipPx3aXgBP8ouRCl03fHn4W0IpQJ7thtwYTOOAAogm6CZkQngAnb27wyZ8YB77j8WlmibuvSZEBpS2RjsvnHSY1AzwwdOflK464TkO7PblZwtJL/NoVI1HuqRNHAmI0d+3hAXhx5yds+TzeS7GYN7cLMxkXJVuJw6EtujVy3CBe5oUSoYltuZ6YnFLAkwdCh+H8nTZ6GEUvpSOoxYdf1wvYJNxKjCkHKfnDsILaNExnbFj9Mdkjf/yxpJb24+ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Lt2GgxNPsKiOQY6yDwIBYB4wb+bQmMpmZwN5uWlm2Q=;
 b=ucxVVOh3LWMATdffNwmfzuy+agNbzQT8VlV8G5VNq0lA8IvgHG5IpN94MI2NbHsySts+h8NIu8LEqRYIJ4VFE8PpWPVL/IZJNWM/EhzAHPapK6E44/7Lqv+nnqjSHfRNTRgcOMuOTTQ2xDPILx+fng4KgxPUv38bn/GvaN8DUtI=
Received: from DM5PR03MB3386.namprd03.prod.outlook.com (2603:10b6:4:46::36) by
 CH2PR03MB5287.namprd03.prod.outlook.com (2603:10b6:610:9e::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5458.19; Mon, 25 Jul 2022 10:03:39 +0000
Received: from DM5PR03MB3386.namprd03.prod.outlook.com
 ([fe80::81f3:95a3:4853:a11f]) by DM5PR03MB3386.namprd03.prod.outlook.com
 ([fe80::81f3:95a3:4853:a11f%7]) with mapi id 15.20.5458.024; Mon, 25 Jul 2022
 10:03:39 +0000
From:   Jane Malalane <Jane.Malalane@citrix.com>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Xen-devel <xen-devel@lists.xenproject.org>
CC:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Maximilian Heyne <mheyne@amazon.de>,
        Jan Beulich <jbeulich@suse.com>,
        Colin Ian King <colin.king@intel.com>
Subject: Re: [PATCH] x86/xen: Add support for HVMOP_set_evtchn_upcall_vector
Thread-Topic: [PATCH] x86/xen: Add support for HVMOP_set_evtchn_upcall_vector
Thread-Index: AQHYlTod5hgtPAUSGEuMopkQlGVYGq189b0AgAImowCAABm4gIAAOBkAgARvxACAAFS4gIAKvnyA
Date:   Mon, 25 Jul 2022 10:03:39 +0000
Message-ID: <b0124d4d-32c9-01d3-36e7-9890ea990fdf@citrix.com>
References: <20220711152230.17749-1-jane.malalane@citrix.com>
 <272ea76d-0099-873e-b8a8-1cc43b7b1e11@oracle.com>
 <0b5ec408-197c-7e34-28d8-7505e1f031df@citrix.com>
 <01cc9e39-242a-3cbf-13b3-cb3ecccd5737@citrix.com>
 <3be61417-6e58-1d9f-dd3c-7de00daa8d0a@oracle.com>
 <c9aafc28-e93f-ebe4-b591-0edab4efdf2b@citrix.com>
 <41198c6c-22ad-1530-793a-e557f3c09415@oracle.com>
In-Reply-To: <41198c6c-22ad-1530-793a-e557f3c09415@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 03871609-416f-4617-7d4c-08da6e24f283
x-ms-traffictypediagnostic: CH2PR03MB5287:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I6+usgarUexbQ7EZmVmMgMSPmHpT9x81vTXhxhgooYKNy/L/Nb0rehqHGuFNYAYTl76Z0Vog7H7S0T4i1Hf88boaigGa2smbXY0giy4YaDGNhejXxuEUtrqmWcHRnAj92+9IoH3ODIflS4ZekpQcVIXyb39ZkHO/5NiCvGcNZhgYsYQbgyYmspqpvqN8wTNRwEOmzsRSPiVYoVv4GhNGBpV08W1ADrvqsrmVP1QAz0amWhhUqk10Ooed8dxj9Kug2x82eaH4MSspcDZv5PejC+TBbAXcQGZPDwxwDPj7XC2pmODYqeIxJeUH2Yqum91z/0wtrmGrN/nLonzFXYQL5M7uwnoTuIAMfCohwGRxkljHycN75Viz77teS3yIGmHoyltStg1n0G+v6RU6zjp3yzSIsbQqcobIUixfEyfKBhJLcd3qdsgJHjlf7AS7PD48ixuNXnAp6Th5yohtv/Jdh0WjtyPQn5+LQJlgEhk2R3bAv+oq4DfaOf1DEkCePdng2SmO1WV0ff9X74lDPFuIDfoLj3qwHSdayp91LRgGjrwEVdFJWuoWZtvN7L5j5pr7NaqU+CxkrLnuSal9Ah9kdVTU8mh9+kpOTYpTMqaLLmPzlNZv1osQWULCequ/0Id5Gwk2IgA2okOTdtRgR/LgP8Fsgt1i8k5EdqQIcvSv1QiOBDOCTlNKJ+Nbt595d7bgShj8CkFbQD/8CVGU09hnlHFe+nglwQchvMUtDPduJQHrqwqBwLoB47w708uJGTVas2lCVlIdkZZuVF7dwdJJeNx7A23fpb2BYFPfToSbAjW6yKocEwV4bPRyyZYm0y9yxhWQeb2rxhwYl8RSsfxWAA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR03MB3386.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(346002)(376002)(39860400002)(136003)(36756003)(53546011)(83380400001)(186003)(66476007)(66556008)(54906003)(66946007)(71200400001)(76116006)(110136005)(91956017)(8676002)(64756008)(4326008)(31686004)(66446008)(2906002)(6512007)(26005)(2616005)(38070700005)(38100700002)(86362001)(6486002)(6506007)(122000001)(5660300002)(7416002)(316002)(41300700001)(478600001)(82960400001)(8936002)(31696002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z0pwbkViMFB6ZlRYMmNtRFRQYnp4eWQxM3hTa1pSZjFHYXNVWWwxaXJpZDFS?=
 =?utf-8?B?eDRhdmFMc0pUakFWZmh1bkY0VjhBSjkxSDIxa3V4TkZnc3FJMzhmR2NaeTgw?=
 =?utf-8?B?OFRvREdVcGUrRnpEZTh2TnNhWXFOOElpZmRDOW9Md2hDS0FSN0dYQm12Qk4x?=
 =?utf-8?B?YUFwQkFzK2RwcWYxeFZZemt5YjIrRFpWOHZGcHg1cGpackRidUZHeUJJY1JU?=
 =?utf-8?B?NEgxdjEySjhKdDZlUm5YVDExSEdVU1h0bzhlbndQS2hBZ3QwWHhOTXRxR3FF?=
 =?utf-8?B?OHY0Ly9FUkppQUdZL0dWbVB1bTZRaVYvK2N1K3YxOE5RWkRVb3d3Z05ZclB4?=
 =?utf-8?B?cmk0Tlo2aHR4WVEwTDlEdU9odGdxT0dIWklUWEo0U3huYTRvb1JSQnBHUlJP?=
 =?utf-8?B?cHoxQjVGbmloQk56cWdoOU1oRXZGNkJDZmdIL0MydVNWckpzUU9VaWJ4eWhF?=
 =?utf-8?B?UUhUVDVkU2NtQ3lKQ05EMDc2SFlFK0ZuSWQ0WkN2ZEZ6eDdvMkhtcnhkQUZG?=
 =?utf-8?B?cmMxbzFuTmtxeTVYd2w0Q0Jla2pFV3pxdUo1WGFDaFlxMkVGT1hKOVVVQUc3?=
 =?utf-8?B?WWdHVFZtMXBtTWRGOUtSdDhzLzh1SUFQamgyNjdMdTVvZXZqc0d4MDA2LzJH?=
 =?utf-8?B?aUJ4aXZSOWJDMmJLek1JbG1iVjVzcHRCc0FQY3ZFRkFYSlRkcjhSSkRENm5Q?=
 =?utf-8?B?SUhVcXVCSElRUm1yZ04raXVOb3lmOHJGZlJnbTRPemFVR3VNekw2MmtJU0Fw?=
 =?utf-8?B?VWcrbDBTY053QnZHMnF2dll5dHVoV1lCUmFWSmxrN0JuRk14WE5ITkxkSHNm?=
 =?utf-8?B?em5PaW1zOTlBUUF3ZS8zNkhrbXpoSmZGMXYrT21kSUptcmo2aTdWWkN5UW11?=
 =?utf-8?B?VWRJY2RJUUkzK05jQUczNmFWcmtNNk96MFExb2o2bnRwNVRubjdrYnBvSk4x?=
 =?utf-8?B?UWpLemRjbEp1a2RYd015UE1NTUVQQjgzQzJVVmo3MmYySTJ3K1A3L3VuYW8v?=
 =?utf-8?B?b1c1NDlYWW1lMGVtS0pZZVFSZjlHMjIwRUYrRDdGOFRrUVplWkp6QzFoczZG?=
 =?utf-8?B?YzBJUUJFcnh1RlZ1UHVrT2FHQlhmdkhxVnhJZlp0TGxrUU5KZWdISVpwN3pu?=
 =?utf-8?B?NFpMNUZkQ1ppYXU5eWc5YlZZL21VUHlncEtKUThFejhSNVJkWC9yaGpMK21l?=
 =?utf-8?B?T1JIbFdldHFGYTZwSFRaZ1B5azlacTFYcm1KRFcvdHJONWhRczdzZkJSTFB3?=
 =?utf-8?B?WUxpNUlDNTZiMzc4MjF3ZmNnYzJzNXNXNTVicUJST0N5K2cvRkUwVjlyN0tW?=
 =?utf-8?B?REhvRmFBYkRsTW1kR0FVcE1MaGNqZUVlTU1oQlJpblcxemlUR2MxMzhmMlFw?=
 =?utf-8?B?MzlRSXBMZ09wanRKTmcvR2VKWjI2a25CN1BvVU1qR0UwWnVrNFlJUlBWbis1?=
 =?utf-8?B?bDJKVmk5bHkrcG5GMEg4UTlUWGd3Q0wyVUhZeGxYcm1MbEs4a2t3d1NQM3px?=
 =?utf-8?B?b1pCUU1Ea1d1S0NRQUtzWHBycG1PS0hYSXhqUW50dXpaelhWdFNJZCtHQVZS?=
 =?utf-8?B?T0c0bEtKR2c3QVFiNU02QktaNm54YWtVU05Md0g4MVhtNHZOWXpLaFAwb0VY?=
 =?utf-8?B?QktuOWVEcUI5SktxMi9vVk1RZXY2RU1HV3IwWXI4MHJaVFRJdVM2UWRESktW?=
 =?utf-8?B?NkxMVFVpdnJMWi9CamhENEI3WDV4OEhsMVl0L3cyYXFuOXJQQ000aW5qNEdp?=
 =?utf-8?B?UCtHb3dvYm05Z043Q2RxVlpwT0VlU0FlMEZWeGJ1dlIwWG1TWVlhcHpqV3hx?=
 =?utf-8?B?d1Vrb3lpTlRYclh2VlVnbStmV21obHZEYUZTKzNIWFZGbmpma3RoWnZ3UmZV?=
 =?utf-8?B?TXROUDV3alpTUzNaanhBUFRIRHBnZVBYMFN4RFN5cGxSV3R2VTJwTTJ3S2Vi?=
 =?utf-8?B?dEdwS1IrUzUzWTR3czJiMDdGamo2elVzQmttVFMyVWJ3T0ZneVRHM1ZKK1Bs?=
 =?utf-8?B?TlRFZjRQb2pVdk9JcDkzeHNHL3N3NGVkK3lUVEVzN3ZsT1RhSER1cFJvUkxH?=
 =?utf-8?B?Zm5QOVFwWDdHNmVPK3hNSU5GRWJXaHhQSGZxeGI2blNaVS80N3hwbCtIMW5a?=
 =?utf-8?B?cnRId3dUUnZsZTFlRFRlTEdyNnVJYUtRWU1tVksvWENRSGhHV0w1TVVLRmI4?=
 =?utf-8?B?bmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9A1A336A688148479378394BF185E815@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR03MB3386.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03871609-416f-4617-7d4c-08da6e24f283
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2022 10:03:39.2459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 14RqiQ7b9zvbeGRoR6HSe0tptABx8THT0B62uNFKb/FRHI7fN6DmdxgV7J/QspSe2Zd6cDTr2UiTvDQGR+AOswlAUblBOaVMuFg6YS7jW7k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5287
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTgvMDcvMjAyMiAxNDo1OSwgQm9yaXMgT3N0cm92c2t5IHdyb3RlOg0KPiANCj4gT24gNy8x
OC8yMiA0OjU2IEFNLCBBbmRyZXcgQ29vcGVyIHdyb3RlOg0KPj4gT24gMTUvMDcvMjAyMiAxNDox
MCwgQm9yaXMgT3N0cm92c2t5IHdyb3RlOg0KPj4+IE9uIDcvMTUvMjIgNTo1MCBBTSwgQW5kcmV3
IENvb3BlciB3cm90ZToNCj4+Pj4gT24gMTUvMDcvMjAyMiAwOToxOCwgSmFuZSBNYWxhbGFuZSB3
cm90ZToNCj4+Pj4+IE9uIDE0LzA3LzIwMjIgMDA6MjcsIEJvcmlzIE9zdHJvdnNreSB3cm90ZToN
Cj4+Pj4+Pj4gwqDCoMKgwqDCoMKgwqAgeGVuX2h2bV9zbXBfaW5pdCgpOw0KPj4+Pj4+PiDCoMKg
wqDCoMKgwqDCoCBXQVJOX09OKHhlbl9jcHVocF9zZXR1cCh4ZW5fY3B1X3VwX3ByZXBhcmVfaHZt
LA0KPj4+Pj4+PiB4ZW5fY3B1X2RlYWRfaHZtKSk7DQo+Pj4+Pj4+IGRpZmYgLS1naXQgYS9hcmNo
L3g4Ni94ZW4vc3VzcGVuZF9odm0uYyBiL2FyY2gveDg2L3hlbi9zdXNwZW5kX2h2bS5jDQo+Pj4+
Pj4+IGluZGV4IDlkNTQ4YjBjNzcyZi4uYmU2NmUwMjdlZjI4IDEwMDY0NA0KPj4+Pj4+PiAtLS0g
YS9hcmNoL3g4Ni94ZW4vc3VzcGVuZF9odm0uYw0KPj4+Pj4+PiArKysgYi9hcmNoL3g4Ni94ZW4v
c3VzcGVuZF9odm0uYw0KPj4+Pj4+PiBAQCAtNSw2ICs1LDcgQEANCj4+Pj4+Pj4gwqDCoMKgICNp
bmNsdWRlIDx4ZW4vaHZtLmg+DQo+Pj4+Pj4+IMKgwqDCoCAjaW5jbHVkZSA8eGVuL2ZlYXR1cmVz
Lmg+DQo+Pj4+Pj4+IMKgwqDCoCAjaW5jbHVkZSA8eGVuL2ludGVyZmFjZS9mZWF0dXJlcy5oPg0K
Pj4+Pj4+PiArI2luY2x1ZGUgPHhlbi9ldmVudHMuaD4NCj4+Pj4+Pj4gwqDCoMKgICNpbmNsdWRl
ICJ4ZW4tb3BzLmgiDQo+Pj4+Pj4+IEBAIC0xNCw2ICsxNSwyMyBAQCB2b2lkIHhlbl9odm1fcG9z
dF9zdXNwZW5kKGludCBzdXNwZW5kX2NhbmNlbGxlZCkNCj4+Pj4+Pj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB4ZW5faHZtX2luaXRfc2hhcmVkX2luZm8oKTsNCj4+Pj4+Pj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB4ZW5fdmNwdV9yZXN0b3JlKCk7DQo+Pj4+Pj4+IMKgwqDCoMKgwqDCoMKgIH0N
Cj4+Pj4+Pj4gLcKgwqDCoCB4ZW5fc2V0dXBfY2FsbGJhY2tfdmVjdG9yKCk7DQo+Pj4+Pj4+ICvC
oMKgwqAgaWYgKHhlbl9hY2tfdXBjYWxsKSB7DQo+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCB1bnNp
Z25lZCBpbnQgY3B1Ow0KPj4+Pj4+PiArDQo+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCBmb3JfZWFj
aF9vbmxpbmVfY3B1KGNwdSkgew0KPj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB4ZW5f
aHZtX2V2dGNobl91cGNhbGxfdmVjdG9yX3Qgb3AgPSB7DQo+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAudmVjdG9yID0gSFlQRVJWSVNPUl9DQUxMQkFDS19W
RUNUT1IsDQo+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAu
dmNwdSA9IHBlcl9jcHUoeGVuX3ZjcHVfaWQsIGNwdSksDQo+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIH07DQo+Pj4+Pj4+ICsNCj4+Pj4+Pj4gKyAgICAgICAgICAgIA0KPj4+Pj4+PiBC
VUdfT04oSFlQRVJWSVNPUl9odm1fb3AoSFZNT1Bfc2V0X2V2dGNobl91cGNhbGxfdmVjdG9yLA0K
Pj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
ICZvcCkpOw0KPj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBUcmljayB0b29sc3Rh
Y2sgdG8gdGhpbmsgd2UgYXJlIGVubGlnaHRlbmVkLiAqLw0KPj4+Pj4+PiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBpZiAoIWNwdSkNCj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBCVUdfT04oeGVuX3NldF9jYWxsYmFja192aWEoMSkpOw0KPj4+Pj4+IFdoYXQgYXJlIHlv
dSB0cnlpbmcgdG8gbWFrZSB0aGUgdG9vbHN0YWNrIGF3YXJlIG9mPyBUaGF0IHdlIGhhdmUgKmEq
DQo+Pj4+Pj4gY2FsbGJhY2sgKGVpdGhlciBnbG9iYWwgb3IgcGVyY3B1KT8NCj4+Pj4+IFllcywg
c3BlY2lmaWNhbGx5IGZvciB0aGUgY2hlY2sgaW4gbGlieGxfX2RvbWFpbl9wdmNvbnRyb2xfYXZh
aWxhYmxlLg0KPj4+PiBBbmQgb3RoZXJzLg0KPj4+Pg0KPj4+PiBUaGlzIGlzIGFsbCBhIGdpYW50
IGJvZGdlLCBidXQgYmFzaWNhbGx5IGEgbG90IG9mIHRvb2xpbmcgdXNlcyB0aGUNCj4+Pj4gbm9u
LXplcm8tbmVzcyBvZiB0aGUgQ0FMTEJBQ0tfVklBIHBhcmFtIHRvIGRldGVybWluZSB3aGV0aGVy
IHRoZSBWTSBoYXMNCj4+Pj4gWGVuLWF3YXJlIGRyaXZlcnMgbG9hZGVkIG9yIG5vdC4NCj4+Pj4N
Cj4+Pj4gVGhlIHZhbHVlIDEgaXMgYSBDQUxMQkFDS19WSUEgdmFsdWUgd2hpY2ggZW5jb2RlcyBH
U0kgMSwgYW5kIHRoZSBvbmx5DQo+Pj4+IHJlYXNvbiB0aGlzIGRvZXNuJ3QgZXhwbG9kZSBldmVy
eXdoZXJlIGlzIGJlY2F1c2UgdGhlDQo+Pj4+IGV2dGNobl91cGNhbGxfdmVjdG9yIHJlZ2lzdHJh
dGlvbiB0YWtlcyBwcmlvcml0eSBvdmVyIEdTSSBkZWxpdmVyeS4NCj4+Pj4NCj4+Pj4gVGhpcyBp
cyBkZWNhZGVzIG9mIHRlY2ggZGVidCBwaWxlZCBvbiB0b3Agb2YgdGVjaCBkZWJ0Lg0KPj4+DQo+
Pj4gRmVlbHMgbGlrZSBpdCAoc2V0dGluZyB0aGUgY2FsbGJhY2sgcGFyYW1ldGVyKSBpcyBzb21l
dGhpbmcgdGhhdCB0aGUNCj4+PiBoeXBlcnZpc29yIHNob3VsZCBkbyAtLS0gbm8gbmVlZCB0byBl
eHBvc2UgZ3Vlc3RzIHRvIHRoaXMuDQo+PiBTZW5zaWJsZSBvciBub3QsIGl0IGlzIHRoZSBBQkku
DQo+Pg0KPj4gTGludXggc3RpbGwgbmVlZHMgdG8gd29yayAobmljZWx5KSB3aXRoIG9sZGVyIFhl
bidzIGluIHRoZSB3b3JsZCwgYW5kIHdlDQo+PiBjYW4ndCBqdXN0IHJldHJvZml0IGEgY2hhbmdl
IGluIHRoZSBoeXBlcnZpc29yIHdoaWNoIHNheXMgImJ0dywgdGhpcyBBQkkNCj4+IHdlJ3ZlIGp1
c3QgY2hhbmdlZCBub3cgaGFzIGEgc2lkZSBlZmZlY3Qgb2YgbW9kaWZ5aW5nIGEgZmllbGQgdGhh
dCB5b3UNCj4+IGFsc28gbG9naWNhbGx5IG93biIuDQo+IA0KPiANCj4gVGhlIGh5cGVyY2FsbCBo
YXMgYmVlbiBhcm91bmQgZm9yIGEgd2hpbGUgc28gSSB1bmRlcnN0YW5kIEFCSSBjb25jZXJucyAN
Cj4gdGhlcmUgYnV0IFhFTl9IVk1fQ1BVSURfVVBDQUxMX1ZFQ1RPUiB3YXMgaW50cm9kdWNlZCBv
bmx5IGEgbW9udGggYWdvLiANCj4gV2h5IG5vdCB0aWUgcHJlc2VuY2Ugb2YgdGhpcyBiaXQgdG8g
bm8gbG9uZ2VyIGhhdmluZyB0byBleHBsaWNpdGx5IHNldCANCj4gdGhlIGNhbGxiYWNrIGZpZWxk
Pw0KPiANCkFueSBvdGhlciBvcGluaW9ucyBvbiB0aGlzPw0KDQooaS5lLiwgY2FsbGluZyB4ZW5f
c2V0X2NhbGxiYWNrX3ZpYSgxKSBhZnRlciANCkhWTU9QX3NldF9ldnRjaG5fdXBjYWxsX3ZlY3Rv
ciBPUiBub3QgZXhwb3NpbmcgdGhpcyB0byBndWVzdHMgYW5kIA0KaW5zdGVhZCBoYXZpbmcgWGVu
IGNhbGwgdGhpcyBmdW5jdGlvbiAoaW4gaHZtb3Bfc2V0X2V2dGNobl91cGNhbGxfdmVjdG9yIA0K
bWF5YmUpIGFuZCB0aWVpbmcgaXRzIHByZXNlbnNlIHRvIFhFTl9IVk1fQ1BVSURfVVBDQUxMX1ZF
Q1RPUiB3aGljaCB3YXMgDQpyZWNlbnRseSBhZGRlZCkNCg0KVGhhbmsgeW91LA0KDQpKYW5lLg==
