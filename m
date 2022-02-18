Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF83C4BC125
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 21:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239439AbiBRUZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 15:25:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbiBRUZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 15:25:06 -0500
Received: from esa5.hc3370-68.iphmx.com (esa5.hc3370-68.iphmx.com [216.71.155.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463BEF3923
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 12:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1645215887;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/l9WzlJ7oUVUW4UyCwXE0eOXg+k4gjqlQE/KgF3ywxw=;
  b=dgr9kkQRT4C6mHMtekzi2pd86NXZcxduB7kKu/WHyzHpADMAQ//tLOQ3
   Jm0CpECxrzFtBxBAObuAXZop0atzbUBZ37s693HCeWFPnj+ixSMy/2Nlw
   RpRGATYhR4Wgm9BSKV2u0weXASjqhlLcvrZtiSCJ7s1+gdQ5IgsgQxyeF
   w=;
Authentication-Results: esa5.hc3370-68.iphmx.com; dkim=pass (signature verified) header.i=@citrix.onmicrosoft.com
X-SBRS: 5.1
X-MesageID: 63987247
X-Ironport-Server: esa5.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.83
X-Policy: $RELAYED
IronPort-Data: A9a23:tUjmrak+5EArpQF7clQGGnbo5gztIURdPkR7XQ2eYbSJt1+Wr1Gzt
 xIXXDvSM6uDZjf9Lo93aNjl9UlVscLQzIVgGQU/qS9hEiMWpZLJC+rCIxarNUt+DCFioGGLT
 Sk6QoOdRCzhZiaE/n9BCpC48T8kk/vgqoPUUIYoAAgoLeNfYHpn2UILd9IR2NYy24DjWlPV4
 7senuWEULOb828sWo4rw/rrRCNH5JwebxtB4zTSzdgS1LPvvyF94KA3fMldHFOhKmVgJcaoR
 v6r8V2M1jixEyHBqD+Suu2TnkUiGtY+NOUV45Zcc/DKbhNq/kTe3kunXRa1hIg+ZzihxrhMJ
 NtxWZOYEy4QYqGdw+okckdkAntjJ/xd8qHgPi3q2SCT5xWun3rExvxvCAc9PJEC+/YxCmZLn
 RAaAGlTNFbZ3bvwme/lDLk37iggBJCD0Ic3k3ds1zzGS90hRojOWf7i7t5ExjYgwMtJGJ4yY
 uJHMms/M06cPHWjPH8JFcI5n7e4j0DibhZksGOyuPNs+E7qmVkZPL/Fb4OOJ43iqd9utkWVq
 3nN+GP6KhoaLtuayCeAtHW2iYfnmy/2Q4sPELu5++RxqFKUwWMXBVsdUl7Tif24jFOuHtFSM
 UoZ/gIwoqUosk+mVN/wW1u/unHslhcYSsFLGqs/6QWH17DSywefGmUACDVGbbQOscYsRnowy
 0ONltXlLTV1tfueTnf13qydqDKuPiwLJGkPYwcLSgwK59Slq4Y25jrNSd9kOKmrg8f5AzDuz
 iiLvjo3wb4UiKYjx/Xl1VPKmTShot7OVAFdzh3aQm+//Ct4YoC/boCl4FSd6uxPRK6bQUOGp
 2MsgNWF4aYFCpTlvC6VR+QIFrakz+yIPD3VnRhkGJxJ3zSv/zi/eodU+xlxIU5oNoAPfjqBX
 aPIkVoPvtkJZiLsNPIpJdLqYyg38UT+PY7Mb6zYP4FAW7kvSB7d4Ts/fkSO+H+4xSDAjpoDE
 ZucdM+tC1MTBqJm0Ce6So8h7FM7+swt7TiNHM6mlnxLxZLbPSfIEuldbDNie8hktPvsnenDz
 zpI2yJmIT17Wfa2XCTY+JV7wbsifSliXsCeRyC6m4e+zuta9IMJV665LVAJIdUNc0FpegHgp
 yDVtqhwkgeXuJE/AV/WAk2PkZu2NXqFkVo1PDY3IXGj0GU5bICk4c83LsVrIOB9qLQykaAtF
 ZHpnvls5NwWG1wrHBxHMPHAQHFKLkz31WpiwQL+CNTAQ3KQb1OQoYK1Fuce3CIPEjC2paMDT
 06IjWvmrW44b106Vq7+Mav3p3vo5CR1sL8iDiPgf4gIEG2xodcCFsAEpqJuSy36AU6YnWXyO
 sf/KUpwmNQhVKdvroGS3Pjc993B/ikXNhMyIlQ3JI2ebEHy1mGi3ZVBQKCPezXcX3nz46Kse
 aNeyPSUDRHNtA8iX1ZUe1qz8Z8D2g==
IronPort-HdrOrdr: A9a23:NIkKHaiDL7byFGM5hSMsErMrUXBQX3x13DAbv31ZSRFFG/FwyP
 rBoB1L73DJYWgqNE3IwerwRJVpQRvnhPpICRF4B8biYOCUghrWEGgE1/qj/9SAIVyxygc578
 ZdmsdFeaXN5DRB/KTHCUyDYqsdKbq8geOVbIXlvgxQpGhRAskKhWoYe2Wm+w9NNXN77PICZc
 ehD6F81l2dkAEsH72G7w4+Lo7+TrPw5ffbSC9DIyRixBiFjDuu5rK/OQOfxA0iXzRGxqpn2X
 TZkiTij5/T8c2T+1v57Sv+/p5WkNzuxp9oH8qXkPUYLT3ql0KBeJlhYbufpzo4ydvfrWrC0e
 O85yvIDf4DrU85TVvF+CcFHDOQiArG3kWSjmNwR0GT+vARCghKUfapzrgpDCcxo3BQze2Ulp
 g7g15x/qAnfi8p1k7Glqj1fgAvmUyurXU4l+kPy3RZTIsFcbdU6ZcS5UVPDf47bW/HAa0cYa
 JT5fvnlbxrmJKhHgfkl3gqxMbpUmU4Hx+ATERHssuJ0yJOlHQ8y0cD3sQQknoJ6Zp4EvB/lq
 v5G7UtkKsLQt4dbKp7CutEScyrCnbVSRaJNG6JO1zoGKwOJnqIoZ/q57c+4v2sZfUzvdcPsY
 WEVEkduX85ekroB8HL1JpX8grVSGH4RjjpwtE23ekwhlQ9fsujDcSuciFaryKQmYRoPiSAYY
 fABHt/OY6WEVfT
X-IronPort-AV: E=Sophos;i="5.88,379,1635220800"; 
   d="scan'208";a="63987247"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i24wyqP2Gh+ldRMNbapP2slsN4/87G65D2zL3DM922LX5vKZw9cRQ6zaAY87byowvYfrmiDuO7bb+069NsqBILmXIEI65Gmtju9UsW0qs9fZlpoqy5Vb4FiiH6vwtHX6Udiqmxdx8muJD6Wm3fcNmHRQfzL/6Dz55YemBEkiSNqIsXFrVscjuU3TzQMCCqnHhN0amJ1RM4MhHXZ6wM4gCUv22xFSvs2CXTdoQTobtiufRuqVBUGzwm/7BWFhA5Z0D+BqT5K1VsAJtJFmBozXq8IuyQGUMhyPfPVwFTuzJAmx4pKtp9x9gcT84/U3HSLy3UWAG+534ohb3cDIlzsJlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/l9WzlJ7oUVUW4UyCwXE0eOXg+k4gjqlQE/KgF3ywxw=;
 b=Z/bfxRT0NUL9+/+zvwJnJzypKdK/CwhV/ofdTJkV5A1yky5WDzxHXNvmZxm7Cj4MJXA2NFc24RMGKv+kTNO5Nm2kU+aEmFXp6drU83xbo7FOvXlm9RhW746Xpux4qxp+NykthU6nEZAMkuQ78WkUZyu3hDqGxERQQ+kGXE+nH6d8ORfFTUhw/5FSVyZ3B/f3GL+NBGNhUw46NeH62/8VPLmISj0j0lc1sMEjEBABU2482nyFttOsyl7s2oLLQplwEZ9FmgKvJ4ePkM2vvSC1Oqc9Peg4BWwUXXWbiSHvGzPNYvOcKZdCTlhHs0FGoDjUuGMgq818SxYcX0S2ufle/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/l9WzlJ7oUVUW4UyCwXE0eOXg+k4gjqlQE/KgF3ywxw=;
 b=qKP2fRBM7dZunI2mXj48T5ELSNuTiCwT2rUbEFtRykR/u32Hsz3HU6Or4dPkfnD24HygYfHi8tvtW5/obUnID6SXg/OniYE/jo7234eNm2hmKPn3qXVAhSQYaLGnuscoiwbGO3TeZcoOtK3wd8d6Pt11Ipf7EVrRvgqn5X3TWR4=
From:   Andrew Cooper <Andrew.Cooper3@citrix.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "joao@overdrivepizza.com" <joao@overdrivepizza.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "Juergen Gross" <jgross@suse.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "samitolvanen@google.com" <samitolvanen@google.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alyssa.milburn@intel.com" <alyssa.milburn@intel.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>
Subject: Re: [PATCH 19/29] x86/ibt,xen: Annotate away warnings
Thread-Topic: [PATCH 19/29] x86/ibt,xen: Annotate away warnings
Thread-Index: AQHYJOtF0PxQ5A3Nl02XV1uCkBqpcayZwUeA
Date:   Fri, 18 Feb 2022 20:24:41 +0000
Message-ID: <e5b93f0a-a28c-8c63-0193-4b4d0db509ab@citrix.com>
References: <20220218164902.008644515@infradead.org>
 <20220218171409.696743603@infradead.org>
In-Reply-To: <20220218171409.696743603@infradead.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f63d1845-a7f1-4daf-7df4-08d9f31cb208
x-ms-traffictypediagnostic: CH2PR03MB5272:EE_
x-microsoft-antispam-prvs: <CH2PR03MB5272001061EF78D4C105F1C6BA379@CH2PR03MB5272.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vNmJW43T0EWmQYRf6wZhY6qTNvJnyhuedsXmFGEQySDbZNgy9DMhl/cpw6hyYKw/A2rKOMY3ZkpV1bp6lDvBe2ieZH8i937X9XPUITWi1/lyruAb2OkriMS0U36K/H9b/Q/vtTE5DwieRnPOUfwe3RecaF+E/f8kLyN28fOzi7jRq9iGWWTCF4KSMkbhgi2h38ZzBtPUVI1l20lvuuRtffggb8a8QJQtuPwPfo68K+xwwDQ/Dea54fMY7cpveqG4hoOPiq8WagW7SOLrrP72dFxKlOy+yCijmCNRkYMH+QZGjMw/NUxUxgL4dI+7fzhmAM+8Oem8nSiUci8SMrkWLGNX6yw+Ga67Moyy8bpGIsm2n5bC9p7yttF+5FaBkRcSk4OBZ7bfiTWtT8yOrvj92edz3KQpyIEfOwApk91a/P0sUEnkq/2mjiAXJl0CWF43oRvQMywNzFQFkkUnzrDTS8bj+POV8osg8AU4MGl5sPi99y4114c7njvuCZ45qntbp8AzgIPmgNyhYwWrChP5UJIIuvs4eXyVEqMMsV8m2h9ZZAG7Fy6tCD2dGc1JQM+AL5/1D2kx7Tf7buuBeCVLhYwxWdWHQgGLeCKkzk//dmAFBWzrbpq8cMYMhvxpvGym5S6tVYw84p7Gq73/DEYFW18bLGM2Ll1xFCnXe2DUgZp7DBsOfj91KxZF5NpNcD8Cdlr226OKjqJHHGyFiloQj+12KJMNpG80XF9qAkwHsNSAXFB4zhaA037PHr+pA3o83M9PoBpOSsALsOZWDKc8Cg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(91956017)(76116006)(38100700002)(8676002)(2906002)(86362001)(64756008)(66446008)(508600001)(66476007)(8936002)(66946007)(83380400001)(5660300002)(122000001)(82960400001)(7416002)(38070700005)(66556008)(31696002)(107886003)(186003)(26005)(2616005)(71200400001)(6512007)(53546011)(6506007)(6486002)(36756003)(316002)(54906003)(110136005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bGsyVjVGbEI4YmJLV0U4STVaMGdXSTd4eFdOaEVNTHRsYzhRN0J6Q1hMQThL?=
 =?utf-8?B?d3E2enZ3NkZHelhPRDQ5MG11bmlrUWRwSTlteDlwM29TQ0YwaEJGTk4xMWZv?=
 =?utf-8?B?bFltR2p0NGFZbU9sVjBCelI2VlJrRVJ2NHU1OWJVaGlMbCs4NDFabmNveVJn?=
 =?utf-8?B?aVJKZ0Vxc1owbVJXMUc0SjBkd0U1dEN0Z3dkQTM2WkRFNjlkYWY5NGRMMUc1?=
 =?utf-8?B?ZVlDd3lGa0M3dFhqUjYrZndIckxJamZKMHRGNHNqTllCaXlhQVRMVDV2RDVR?=
 =?utf-8?B?ZGlST2Q0ckk5M3ZLMGQwNWd2WjhleVd5LzlFeVUydnB4MVkrcmlYUkVhUUdw?=
 =?utf-8?B?blJtbFdNUzRidmh4Yzl4WmJPYVpYclF5emg3dEdWRlRiREJoL2ltSi9wdURI?=
 =?utf-8?B?bUwwMFdoS3YrSGI1UEZQSjVZY3hwZGdoS04yKzkrTjhZSjBMOStGbVBpVHdN?=
 =?utf-8?B?Syt2RzdRSTFqMGtIcS9yTm1GRDFnaTB4RjVCMGcrdkJUNVl6UE9FdVdmY3hx?=
 =?utf-8?B?YnlUamRpWVM3OThaM3doTzQ3NjNKaVp5NTRrTGI1TURtalpVVDJLeEhXOEJz?=
 =?utf-8?B?ZkdsUVdPSStzajRHczRsUjNMWE9xRis0MXJrTXY5QUYxMHZqaW5VMWYyTDRU?=
 =?utf-8?B?L0NKMUdDQ1Jwdi9ZdHkwNVh1NWpEdVlEWGxTckFubnMxUXp5TSszZFRyR3k3?=
 =?utf-8?B?b1BhTjFUQTZMMXMvckxiaEdjdkFsSFV4NzBraUxCdW84MjZCYS9IWmovV2I5?=
 =?utf-8?B?RXh4MGFmSVl3V3FVMGRVNDF3Z1VGdFRwUVVqYnZLSjJ5Sjd0SXc2UmpNamlY?=
 =?utf-8?B?QW5wVjc5NlVzTXJCMnRIWGdFRVR6L3hZV0gxa2VQMC9iV0pueE5wazJXRnQ0?=
 =?utf-8?B?UXF4cW50aHU5WDV3M2QwNk5JVjBkNlpxSWt3ZkZoK2tZMEVnOFlEWXdRSjJl?=
 =?utf-8?B?cVB2eEZoWFVZTjZabDFTUVpHVFFmZmtPUlM2bkQ3bUhVb0lFWDE3UlZYeXIx?=
 =?utf-8?B?OVRNcGRtNCtEQVFaQXg0WnltZFRGY1d4dU9wam5KOFQ3QmRiOVQ0OVRJK25O?=
 =?utf-8?B?UUViby85UWpHeEZZcHViUmVFZ1V6RmpJM2JkaTZpdFVicFJkRVprWi9pcWNz?=
 =?utf-8?B?WnB6ODRyUG52MW1ZcS94WXJaSXM1YU10bGNFS1V5WFV1SVhEeWhqRzJ5K1Bn?=
 =?utf-8?B?dEc0NGxCWG82ZkJJSFA0aEYvRmRmNFFTTVdyeGN5TFNIbEhidGtyRVRERHlJ?=
 =?utf-8?B?K1dpOFRyaWNjc2pZVDBZTk5BMTJFNVBKTm9GQlFRU0w3YnU3K1JWZFMrM0ls?=
 =?utf-8?B?VFRiUnY3SUsxU2VQODllUElBWitDMGJwZFVtSXdIZHVIOFU0QmJQVUphUit3?=
 =?utf-8?B?amNRck5iM2xtcDhDN2k3R2pwcStLekUwcWFPd1hQNHVocTdCTWJGTWxGdThX?=
 =?utf-8?B?WTB5SmtuQ1JROExPK0g3eC9zKzZyeENTdlFBZzUxNUVuNjMrR0o0KzFZVzJE?=
 =?utf-8?B?bFlVTzgrYlpMejhDdVhVc3FCU050M2ltRE1tVHRvZzFkRGNHV1I3N1NvOGNS?=
 =?utf-8?B?Y2lFU1hxWVlGTlBDSGFVUTlQSjVITE5FMGp1MTBKQjhXOEp1TmdDd2hMNG9Y?=
 =?utf-8?B?UDhmWUo2NDRLY0lJVkJSTldUc1h3V3hhZVh0TzdQdTl6U29xVk43ZXdOY2ho?=
 =?utf-8?B?dHBpMWljNUhJOWZjVVJyT0ErUzRxVmZvTEkvY05ibXpwOUdmaEhsdWhxWVRw?=
 =?utf-8?B?V0pxVk1TSkdHSVRxWVlPUU9YazlhN0JkaWlBclNzTWFVMTdFNG9KZHJFYkdZ?=
 =?utf-8?B?aE8vOEpSV0VpK0d4bk1xZmlVSm9hMzVVWUlqTTVWeXAvcThxS0N0K2hxVHQ5?=
 =?utf-8?B?UTE0MW5JTUxQMGpyalZ5dVovUmZiVnREWlI5ODVKOWVQWGVFNlBwMXk2aEVv?=
 =?utf-8?B?bk90Q3duUE4vWnp3R1lmTVRnRmJ0WDJWZlFJb2ZVMTIyWHBQVHp2ajdaMWRD?=
 =?utf-8?B?OURIU3JuMUZMd0lOSXJpNkVkTGNIMFNDZ0lkQzVVZFBWekR3K3Q3NklZeHBk?=
 =?utf-8?B?bjlkcjlKcnp3azRYcmlQemN2U3hYcUZpOE1QenBTSDJTck54Y3RaTktFRVVE?=
 =?utf-8?B?M1pGNi8vNWd3cVg3Y1A0ZDgxVmdzaTQ5NmpQTUVoRUpIdkdPV2xMRkZwTnF4?=
 =?utf-8?B?S3dHeUdKT2lxRDBIc2c4Wm1uYVpqNEwwQnNTTUd5RlBNVTFPVWVzSVczcDhq?=
 =?utf-8?B?bE4raEdodHU1VGl3ZkR1TDQ4NnJnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2220F610F874B944988092A65E989549@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f63d1845-a7f1-4daf-7df4-08d9f31cb208
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2022 20:24:41.9920
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RGRbU1JHnsMyd/I+YQ5JP3hKx8gR9hQWeY55VTX1TpVsflmPKY9Z6TjEL5WDWoTGVzvpY3Lop1ZJ3yQJxKlCIFbgxbAGKtKJjWqdcDmA4z0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5272
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

T24gMTgvMDIvMjAyMiAxNjo0OSwgUGV0ZXIgWmlqbHN0cmEgd3JvdGU6DQo+IFRoZSB4ZW5faXJl
dCBFTkRCUiBpcyBuZWVkZWQgZm9yIHByZS1hbHRlcm5hdGl2ZSBjb2RlIGNhbGxpbmcgdGhlDQo+
IHB2X29wcyB1c2luZyBpbmRpcmVjdCBjYWxscy4NCj4NCj4gVGhlIHJlc3QgbG9vayBsaWtlIGh5
cGVydmlzb3IgZW50cnkgcG9pbnRzIHdoaWNoIHdpbGwgYmUgSVJFVCBsaWtlDQo+IHRyYW5zZmVy
cyBhbmQgYXMgc3VjaCBkb24ndCBuZWVkIEVOREJSLg0KDQpUaGF0J3MgdXAgZm9yIGRlYmF0ZS7C
oCBNZWNoYW5pY2FsbHksIHllcyAtIHRoZXkncmUgSVJFVCBvciBTWVNFUkVULg0KDQpMb2dpY2Fs
bHkgaG93ZXZlciwgdGhleSdyZSBlbnRyeXBvaW50cyByZWdpc3RlcmVkIHdpdGggWGVuLCBzbyBm
b2xsb3dpbmcNCnRoZSBzcGVjLCBYZW4gb3VnaHQgdG8gZm9yY2UgV0FJVC1GT1ItRU5EQlIuDQoN
Ck9yIHdlIGNvdWxkIGFyZ3VlIHRoYXQgc2FpZCBlbnRyeXBvaW50cyBhcmUgcmVnaXN0ZXJlZCBp
biBYZW4uDQoNClRoZSBjYXNlIGZvciBFTkRCUiBmb3IgdGhlIElEVCB2ZWN0b3JzIGlzIHF1aXRl
IG9idmlvdXNseSAtIGEgc3RyYXkNCndyaXRlIGludG8gdGhlIElEVCBjYW4gbW9kaWZ5IHRoZSBl
bnRyeXBvaW50LCBhbmQgRU5EQlIgbGltaXRzIGFuDQphdHRhY2tlcidzIGNob2ljZXMuDQoNCk9U
T0gsIHRoZSBTWVNDQUxMIGFuZCBTWVNFTlRFUiBlbnRyeXBvaW50cyBhcmUgbGF0Y2hlZCBpbiBN
U1JzLCBhbmQgaWYNCnlvdSd2ZSBnb3QgYSBzdWZmaWNpZW50bHkgbGFyZ2Ugc2VjdXJpdHkgaG9s
ZSB0aGF0IHRoZSBhdHRhY2tlciBjYW4NCndyaXRlIHRoZXNlIE1TUnMsIHlvdSBoYXZlIGFscmVh
ZHkgbG9zdC7CoCBJJ20gbm90IGF3YXJlIG9mIGFueSBleHRyYQ0Kc2VjdXJpdHkgeW91IGdldCBm
cm9tIGZvcmNpbmcgV0FJVC1GT1ItRU5EQlIgaW4gdGhlIFNZU0NBTEwvU1lTRU5URVINCmZsb3cs
IGFuZCBzdXNwZWN0IGl0IHdhcyBsaWtlIHRoYXQganVzdCBmb3IgY29uc2lzdGVuY3kuDQoNClVu
ZGVyIFhlbiBQViwgYWxsIGVudHJ5cG9pbnRzIGFyZSBjb25maWd1cmVkIGJ5IGV4cGxpY2l0IGh5
cGVyY2FsbCwgbm90DQp2aWEgYSBzaGFyZWQgbWVtb3J5IHN0cnVjdHVyZSwgc28gYmV0dGVyIG1h
dGNoIHRoZSBNU1IgbW9kZWwgZm9yDQpuYXRpdmUuwqAgSSBjb3VsZCBwcm9iYWJseSBiZSBhcmd1
ZWQgYXdheSBmcm9tIGhhdmluZyBhIFJNVyBvZiBNU1JfVV9DRVQNCmluIHRoZSBldmVudCBkZWxp
dmVyeSBmYXN0cGF0aC4NCg0KDQpJJ2QgYmUgdGVtcHRlZCB0byBsZWF2ZSB0aGUgRU5EQlIncyBp
bi7CoCBJdCBmZWVscyBsaWtlIGEgc2FmZXIgZGVmYXVsdA0KdW50aWwgd2UgZmlndXJlIG91dCBo
b3cgdG8gcGFyYXZpcnQgSUJUIHByb3Blcmx5Lg0KDQo+IFRoZSBoeXBlcmNhbGwgcGFnZSBjb21l
cyBmcm9tIHRoZSBoeXBlcnZpc29yLCB0aGVyZSBtaWdodCBvciBtaWdodCBub3QNCj4gYmUgRU5E
QlIgdGhlcmUsIG5vdCBvdXIgcHJvYmxlbS4NCg0KWGVuIHdpbGwgbWFrZSBzdXJlIHRoYXQgdGhl
IGh5cGVyY2FsbCBwYWdlIGNvbnRhaW5zIEVOREJSJ3MgaWYgQ0VULUlCVA0KaXMgYXZhaWxhYmxl
IGZvciB0aGUgZ3Vlc3QgdG8gdXNlLsKgIFBlcmhhcHMuLi4NCg0KPiAtLS0gYS9hcmNoL3g4Ni94
ZW4veGVuLWhlYWQuUw0KPiArKysgYi9hcmNoL3g4Ni94ZW4veGVuLWhlYWQuUw0KPiBAQCAtMjUs
OCArMjUsOCBAQA0KPiAgU1lNX0NPREVfU1RBUlQoaHlwZXJjYWxsX3BhZ2UpDQo+ICAJLnJlcHQg
KFBBR0VfU0laRSAvIDMyKQ0KPiAgCQlVTldJTkRfSElOVF9GVU5DDQo+IC0JCS5za2lwIDMxLCAw
eDkwDQo+IC0JCVJFVA0KPiArCQlBTk5PVEFURV9OT0VOREJSDQo+ICsJCS5za2lwIDMyLCAweGNj
DQoNCi8vIFhlbiB3cml0ZXMgdGhlIGh5cGVyY2FsbCBwYWdlLCBhbmQgd2lsbCBzb3J0IG91dCBF
TkRCUg0KDQo/DQoNCkFsc28sIHNvbWV3aGVyZSBpbiB0aGlzIHNlcmllcyBuZWVkczoNCg0KZGlm
ZiAtLWdpdCBhL2FyY2gveDg2L3hlbi9lbmxpZ2h0ZW5fcHYuYyBiL2FyY2gveDg2L3hlbi9lbmxp
Z2h0ZW5fcHYuYw0KaW5kZXggNTAwNGZlYjE2NzgzLi5lMzBmNzcyNjRlZTYgMTAwNjQ0DQotLS0g
YS9hcmNoL3g4Ni94ZW4vZW5saWdodGVuX3B2LmMNCisrKyBiL2FyY2gveDg2L3hlbi9lbmxpZ2h0
ZW5fcHYuYw0KQEAgLTYyNCw2ICs2MjQsNyBAQCBzdGF0aWMgc3RydWN0IHRyYXBfYXJyYXlfZW50
cnkgdHJhcF9hcnJheVtdID0gew0KwqDCoMKgwqDCoMKgwqAgVFJBUF9FTlRSWShleGNfY29wcm9j
ZXNzb3JfZXJyb3IswqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmYWxzZSApLA0KwqDCoMKg
wqDCoMKgwqAgVFJBUF9FTlRSWShleGNfYWxpZ25tZW50X2NoZWNrLMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGZhbHNlICksDQrCoMKgwqDCoMKgwqDCoCBUUkFQX0VOVFJZKGV4Y19z
aW1kX2NvcHJvY2Vzc29yX2Vycm9yLMKgwqDCoMKgwqDCoMKgwqDCoCBmYWxzZSApLA0KK8KgwqDC
oMKgwqDCoCBUUkFQX0VOVFJZKGV4Y19jb250cm9sX3Byb3RlY3Rpb24swqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgZmFsc2UgKSwNCsKgfTsNCsKgDQrCoHN0YXRpYyBib29sIF9fcmVmIGdldF90
cmFwX2FkZHIodm9pZCAqKmFkZHIsIHVuc2lnbmVkIGludCBpc3QpDQpkaWZmIC0tZ2l0IGEvYXJj
aC94ODYveGVuL3hlbi1hc20uUyBiL2FyY2gveDg2L3hlbi94ZW4tYXNtLlMNCmluZGV4IDQ0NGQ4
MjQ3NzVmNi4uNmYwNzdhZWRkNTYxIDEwMDY0NA0KLS0tIGEvYXJjaC94ODYveGVuL3hlbi1hc20u
Uw0KKysrIGIvYXJjaC94ODYveGVuL3hlbi1hc20uUw0KQEAgLTE0Nyw2ICsxNDcsNyBAQCB4ZW5f
cHZfdHJhcCBhc21fZXhjX3BhZ2VfZmF1bHQNCsKgeGVuX3B2X3RyYXAgYXNtX2V4Y19zcHVyaW91
c19pbnRlcnJ1cHRfYnVnDQrCoHhlbl9wdl90cmFwIGFzbV9leGNfY29wcm9jZXNzb3JfZXJyb3IN
CsKgeGVuX3B2X3RyYXAgYXNtX2V4Y19hbGlnbm1lbnRfY2hlY2sNCit4ZW5fcHZfdHJhcCBhc21f
ZXhjX2NvbnRyb2xfcHJvdGVjdGlvbg0KwqAjaWZkZWYgQ09ORklHX1g4Nl9NQ0UNCsKgeGVuX3B2
X3RyYXAgYXNtX3hlbnB2X2V4Y19tYWNoaW5lX2NoZWNrDQrCoCNlbmRpZiAvKiBDT05GSUdfWDg2
X01DRSAqLw0KDQphdCBhIG1pbmltdW0sIGFuZCBwb3NzaWJseSBhbHNvOg0KDQpkaWZmIC0tZ2l0
IGEvYXJjaC94ODYveGVuL3hlbi1hc20uUyBiL2FyY2gveDg2L3hlbi94ZW4tYXNtLlMNCmluZGV4
IDQ0NGQ4MjQ3NzVmNi4uOTZkYjVjNTBhNmU3IDEwMDY0NA0KLS0tIGEvYXJjaC94ODYveGVuL3hl
bi1hc20uUw0KKysrIGIvYXJjaC94ODYveGVuL3hlbi1hc20uUw0KQEAgLTEyNCw3ICsxMjQsNyBA
QCBTWU1fQ09ERV9TVEFSVCh4ZW5fXG5hbWUpDQrCoMKgwqDCoMKgwqDCoCBVTldJTkRfSElOVF9F
TVBUWQ0KwqDCoMKgwqDCoMKgwqAgcG9wICVyY3gNCsKgwqDCoMKgwqDCoMKgIHBvcCAlcjExDQot
wqDCoMKgwqDCoMKgIGptcMKgIFxuYW1lDQorwqDCoMKgwqDCoMKgIGptcMKgIFxuYW1lICsgNCAq
IElTX0VOQUJMRUQoQ09ORklHX1g4Nl9JQlQpDQrCoFNZTV9DT0RFX0VORCh4ZW5fXG5hbWUpDQrC
oF9BU01fTk9LUFJPQkUoeGVuX1xuYW1lKQ0KwqAuZW5kbQ0KDQooRW50aXJlbHkgdW50ZXN0ZWQu
KQ0KDQp+QW5kcmV3DQo=
