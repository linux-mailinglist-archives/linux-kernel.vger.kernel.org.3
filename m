Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 974DA4CBC1D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 12:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232616AbiCCLHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 06:07:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbiCCLHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 06:07:33 -0500
Received: from esa3.hc3370-68.iphmx.com (esa3.hc3370-68.iphmx.com [216.71.145.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C0617C431
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 03:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1646305608;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=tP2bdoh+Q++RCTar1O6XPXepqx+a7R6mr81tZg3SCq0=;
  b=IyivGJg00Vr60MWs5dn7GawRfFZFSN22pCQifNDUGPoSkIb7Wsyj0OUV
   kdlLPb+bmoZWUQmLIKQkTfBu0bJenwwNXwFldFah7Nk076GiaEEyqOjBf
   gdObY5bzVeAIH+rsVl8Xdh8s4zac5bWGrm1GqoAshI6hSPPVN96FvbegG
   o=;
Authentication-Results: esa3.hc3370-68.iphmx.com; dkim=pass (signature verified) header.i=@citrix.onmicrosoft.com
X-SBRS: 5.1
X-MesageID: 65377443
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.83
X-Policy: $RELAYED
IronPort-Data: A9a23:rk/SuKz/O5aYn7v22xN6t+cDwSrEfRIJ4+MujC+fZmUNrF6WrkVSn
 zRJWD/XbPfeZmOmKIp1YYri9koDscPXzYRnQAdo/yAxQypGp/SeCIXCJC8cHc8zwu4v7q5Dx
 59DAjUVBJlsFhcwnj/0bv656yMUOZigHtIQMsadUsxKbVIiGX9JZS5LwbZj2NYz2YPhWmthh
 PupyyHhEA79s9JLGjp8B5Kr8HuDa9yr5Vv0FnRnDRx6lAe2e0s9VfrzFonoR5fMeaFGH/bSe
 gr25OrRElU1XfsaIojNfr7TKiXmS1NJVOSEoiI+t6OK2nCuqsGuu0qS2TV1hUp/0l20c95NJ
 NplubK0ZFkoZIn1kr4FYTxfPx5ZH4NbweqSSZS/mZT7I0zudnLtx7NlDV0sPJ1e8eFyaY1M3
 aVGcnZXNEnF3r/ohuLgIgVvrp1LwM3DFYUToHx/ixreCu4rW8vrSKTW/95Imjw3g6iiGN6AO
 pFGNmYzN3wsZTVTBQtPKqoRo92aoX7ZVGBKkE/PqfMotj27IAtZj+G2bYu9lsaxbcBchEXev
 H/a+23/DjkTLtnZwj2Amlq3j+rOgST/RosUGbuQ+fltj1megGcUDXU+Vla2uvK+jU2WUNJFL
 EkV5y9oqrI9nGSiSsjmRBT+pX+AtAMGXfJRFfE37EeGza+8yw+dC3gJT3hadNU8s9ExRCAty
 HeGmtroAXpkt7j9YXed962dqDquESsYN2kPYWkDVwRty8Pku50+gg7nQdFkHKu0lZvyAz6Y6
 zaGoTM3mrEVjMMRzI20+lfIhz/qrZ/MJiYltlv/XW+/6A59Iom/aOSA8VXH4OxSBIefQEOIs
 HUNl46Z9u9mJZSHmSqAW80WAaqkof2XWBXehldoN54/+i6h4X+9cJhR8iN3YkxuN64sfT7vf
 V+Wug5L4pJXFGWlYLUxYI+rDckui6/6GrzNVOjTb99EZZVZbgKL/ChyI0WX2gjFkEoo1704P
 pOAWcmpBHceT69gyVKLq/w1iOFxgHpknCWKGM69n0/PPaeiiGC9RZkBHQWPNMQA5vmckiDS3
 +l4FeWX8kAKOAHhWRX//YkWJFEMCHE0A5HqtsBaHtK+zhpa9HIJUKGIn+54E2Bxt+EMz7qTo
 CnhMqNN4Aen3RX6xRO2hmePgV8FdbJ2tjoFMCMlJj5EMFBzMN/0vM/zm3baFITLFdCPL9YpF
 5HpmO3aW5yjrwgrHRxHN/ERS6Q4KXyWafqmZXbNXdTGV8cIq/b10tHlZBDz0yIFEzC6s8Azy
 5X5iF+FG8ZdG1U5U5uPAB5K879XlSJH8A6VdxGVSuS/hW22qNQ6Q8APpqVfzz4wxeXrmWLBi
 lf+7eYwrujRuY4lmOQldojfx7pF59BWRxIAd0GCtO7eHXCDogKLnN8ROM7VLGu1fD6lp82fi
 RB9kqiU3Asvxw0R7eKR0t9DkMoD2jcYj+QCn1Q8QS6SNAzD53EJCiDu4PSjf5Zln9dxkQC3R
 liO6p9dP7CIM9niC1kfOEwuaeHr6B3esmC6ASgdSKki2BJKwQ==
IronPort-HdrOrdr: A9a23:YglE6KiAr161l05qrdO4i4LbrHBQX3R13DAbv31ZSRFFG/FwyP
 rAoB1L73PJYWgqNU3IwerwRZVpQRvnhPtICRF4B8bsYOCUghrVEGgE1/qt/9SAIVyzygc578
 ldmsdFeaTN5DRB/KXHCUyDYqwdKbq8geGVbIXlvg9QpGhRAskKhWYYNu/YKDwMeOAvP+tjKH
 P23Lsim9PUQwVwUi3NPAhjYwGsnayoqLvWJTo9QzI34giHij2lrJTgFQKD4xsYWzRThZ8/7G
 nsiWXCl+WemsD+7iWZ+37Y7pxQltek4MBEHtawhs8cLSipohq0Zb5mR6aJsFkO0aKSARcR4Z
 vxSiUbToBOAkDqDyaISNzWqk/dOQMVmjrfIJmj8CLeSILCNWoH4oF69P1km1PimjQdVZdHof
 h2Niuixupq5VmrplWN2/HYEx5tjUa6unwkjKoaiGFeS5IXbPtLoZUY5149KuZKIMvW0vFvLA
 BVNrCV2B+WSyLvU1nJ+m10hNC8VHU6GRmLBkAEp8yOyjBT2HR01VERysATlmoJsMtVcegI28
 3UdqBz0L1eRM4faqxwQO8HXMusE2TIBRbBKnibL1jrHLwOf3jNt5n06rMo4/zCQu1D8LIi3J
 DaFF9Iv287fEzjTcWIwZ1Q6xjIBH6wWDz8o/sukaSReoeMM4YDHRfzOmzGyfHQ0Mn3KverLs
 qOBA==
X-IronPort-AV: E=Sophos;i="5.90,151,1643691600"; 
   d="scan'208";a="65377443"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jjRpyMBVb6cZwey1pi8aulKy0AHtONe5NYTOzq1LJ2YUGyIqsgu4rSLDt8Tk0yNz3/+XUdTiu4zs1J2Bu3qiJdrXAlbDZG3GsvTPQCI3dImGTciqzBW3PpDCoio583Skk4CCeRYv2ZR/TXFuRn6hpcEc5VJcDZ0RJckXjoLbHTaiZZ1qOmJp1YItU2WR2hESSnqb1GfOZSkJM/INzsOOsjfhlv7BQ3H9EPXJAMbC2zYccNGDYSjEweE0wAksB95CULHnZKxuEUUF+3Y4GiBdx/+YoZ5KIGMr3a96h2LOGXCUetv1jZ/9rXYfwraZNb6TX8sJ//RSDTz8Lq/50pBplA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tP2bdoh+Q++RCTar1O6XPXepqx+a7R6mr81tZg3SCq0=;
 b=hmInEs/0NBENopbP+CSbYG3K2koQdviEcBSE3qGycY+WU3xDTg+Rc7LdwY8jZu9Py51VAvreQdx2Gv+wYNiAoZuUUFmlUtJSOjfRVxg7lLVUqQXOq92hipSpK73hSFMgut7lwK8cEJyFLdKgrBeHmZ4UN74oo/TDeiFeu8ZKTQ9duCqF6amxuKFTzimtu4OKbEaf6Dr61XXf5AOjQDGIlApIwt0BakF63QbTJPJi9LVs7uUO6+pYMYR/Vl48QIDn45moSJJGr7N42YBvx7W8KCIPhWbi4kbU18ppTFaVSVyTKyuLMkEuLetTfkHT8luuZD9CPp0kn2C9Oza8uETbKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tP2bdoh+Q++RCTar1O6XPXepqx+a7R6mr81tZg3SCq0=;
 b=thDTPfvvjpspty4v+NaXpedID9DDguzfhwy64Fdt0VhV5LkVly+OwRony4MT6Txdor9gRoD3EynyX7IM1ywsuD/Bs/a2BTO58Fb25KDcGxsmb9DMplBFQpo5SlWfwNo7alI2k2JcLb7N0WG8w3cM0sAKA+hfVVeL+tfhdEf4J/c=
From:   Andrew Cooper <Andrew.Cooper3@citrix.com>
To:     Miroslav Benes <mbenes@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "joao@overdrivepizza.com" <joao@overdrivepizza.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "samitolvanen@google.com" <samitolvanen@google.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alyssa.milburn@intel.com" <alyssa.milburn@intel.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>
Subject: Re: [PATCH v2 33/39] objtool: Add IBT/ENDBR decoding
Thread-Topic: [PATCH v2 33/39] objtool: Add IBT/ENDBR decoding
Thread-Index: AQHYKZIahNP/FRSbLkOjNS1iJfvOTqythsIAgAADoAA=
Date:   Thu, 3 Mar 2022 11:06:43 +0000
Message-ID: <aa6076af-0f7c-ae48-4eb4-8bf2e3f0ed06@citrix.com>
References: <20220224145138.952963315@infradead.org>
 <20220224151323.959862564@infradead.org>
 <alpine.LSU.2.21.2203031138040.704@pobox.suse.cz>
In-Reply-To: <alpine.LSU.2.21.2203031138040.704@pobox.suse.cz>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a8fe5971-269d-4162-d7af-08d9fd05e6cc
x-ms-traffictypediagnostic: MW4PR03MB6649:EE_
x-microsoft-antispam-prvs: <MW4PR03MB6649FA88CFAAE4F5F1E2A236BA049@MW4PR03MB6649.namprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y8NkhFBXrZWjYgk411YpjsfwFUeLuvw2za8mypfyp3NQsP0b/pMdEAI0VXQ5osWdWsSZ42rO2Fb2KnFNBKDqfNIBKA7XlujvXb8sx2hv4dioVRg5+kpc+8AOXz1Y1mh1Ciqcv9aAn1cr3lR+NRZyD3tIXyBug65rSQvtcRm0iVpqBhCOWKPPrztZzja3aKIk3OT0r1yq/CCPVt6ns09thW1xFga/eSyW8yWGMLZ5ah2N1dYtNxe10G5a3pPYw+wJfH/aQhSUo+sBw1Mzc9g4yW/popgsHMr3cHZmNITvnlDm57meohrcmkcsVwGZ1CJe7hL2KHoamBt+lDiKvCYVTAu9s+v4eYvIAqWF0uG58NNTWASUvi+OfUcCA8WKdHwMOxfTTR7d2qyuC8Fwik1R4c4+9ozawWW5rukEkiSRN/xu0FtQwfYk/O51ieyHT6nYekhFm0+QcOChJlIfE/CtYfp7TFSUgvFiWH+Z+3kX5kBwMifwH/5ESJ1UEZ4mWc5CljRaMAhzqRMpl4aoNgxplJVwtHBVKvjulUAxO1KnbIBOBbOIX2Bw5ok2+J/wRpvzK40xJDoFZ/2Yc5vGynJOmmb6QWNq2OBkUN2lpEUMjAMa/YnPHEcaLzCb6zuUngHL0D3ggaOytq2KVJJua0G5bxhz9xM+riEwrbyPo5mOOEsQ8lTRPMcRR34pqi9YYAnZy/QxBee9M4mMW8eY6OtAGEeX4MRSspBx+2EUs2Mj5YzJqqzwfAHUuV0sqZm9p2buhzkjNsZGrUeMUVPRAwCRmA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(82960400001)(6506007)(53546011)(122000001)(66476007)(66446008)(64756008)(66556008)(8676002)(4326008)(6512007)(186003)(26005)(508600001)(8936002)(31696002)(71200400001)(5660300002)(86362001)(6486002)(38100700002)(2906002)(38070700005)(66946007)(7416002)(83380400001)(31686004)(316002)(2616005)(36756003)(110136005)(54906003)(91956017)(76116006)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NHVwN1dnOTlkY0NIalBDL0JXMTN5VGJyUExkditrNkMyTWwzaTE5aDMzQ1U4?=
 =?utf-8?B?c2hQazBkSkk0dExUV2kvdXJraDUra1VHbTJpNnV0SDNodXFDejdEaXhtTHdG?=
 =?utf-8?B?dVRYaFFseGdnOC91UThXRXhTc0pGbzNBeU1FdXU1UFU0TDNEQjJaOVJhdmRS?=
 =?utf-8?B?ZDdCNkQ3QTFaZlBmZEJ0NDhFaml5bHZOeVg5cC9HTldDRXBySnhUTXlXVVkr?=
 =?utf-8?B?QnpMSzZNOEdkWUI1VVBuckU1R0pMTmsycFE5aERQTGpqbkdCc2NQRkxncXVk?=
 =?utf-8?B?YTVPNEx2NGo0VlllS3NHMWV4dEFaMUpNQi9HL01xbC84ZytPMVo0U204SVBC?=
 =?utf-8?B?N1p1MFhCS2xyOVFVdFd5QmdncWxPcXRaQ3RYTzAyYmJtS3hGVzFMYWRjSEdq?=
 =?utf-8?B?dlp1TkVRanQzKzJuWU5JWWlMamV4UUQ4K09hL05yNGJLVDdITmhpMVlvbjNp?=
 =?utf-8?B?ZGd5SHBwOU5UQSsxamZDbXBLU05mcWtYdTBQNEF0NGhJcFZQaU5HeDNjMGZJ?=
 =?utf-8?B?MFozL1J0V200ckxhNkZsL1krcDJYSDRVWC9icFg0djB4em9LZG5NVTR3WXhS?=
 =?utf-8?B?amJkNkMvOTAvVE5wOFBhaldQTGNSRDNoRmFoWGtJaTlxeFJvQXNxZG8vcUVW?=
 =?utf-8?B?c01MMWlYdFZTYkVrTGVJenNOTEZONHRabHdYSGhnNGZENVJHK1NvU0haek9n?=
 =?utf-8?B?Um9Wd09EQXVaQkRTVTRrUUwrcUlSZEV4NnBsVzlNSjV2UFFSZUNYeGFtc2NV?=
 =?utf-8?B?Zjc5S21FTmdtM2N0b200NHJTR2hMQXo3ZytyYWswTmRFQnVHUDF5TWxWVzdx?=
 =?utf-8?B?N1BjOVVYWS9ibWsrZ216UElaMm11ZVR5aHZYV1hKb0FvOGVtY3MzUEI0b25N?=
 =?utf-8?B?RmhIK1NzbWZkcHZ2RGhSV0VrRC93cnJqWFFLMEplbFhEdVhmTmg1Q0M0ZlhL?=
 =?utf-8?B?bGFZUjhzYlF5WXpkVTl4bmQvSnhqSVRVMm5MZ3dJRmNLY0g3UVRWeFE1Mk9H?=
 =?utf-8?B?c3k3aDJoNFBtUWZJNGJrR1NkWUNVcWpmSUVsWjdiczdPdnpZeTVuYWxtTnA3?=
 =?utf-8?B?WWNQMUlMRTdtLzVtZDRlZjVIV2IweUwrMm4yQnJ0MExlbnYxeEVxajJnM1F5?=
 =?utf-8?B?R3VhS1g2Q3YwNFMrUFJrWWZ4SHhCeXNWRlcvZndpN3lPQkRQNGVleUEzNTJS?=
 =?utf-8?B?Nk9BUlA3dHVKSzBjcUI2K2FoSHphUVhpcE1hRUFiS1M2Y09UZFBTRHJVNDgv?=
 =?utf-8?B?UW5PWVVMR3Ayd3hGSjdJM09pUi9EMjlZTUFLK3dHOExVYUtONWxjaUE5cjNt?=
 =?utf-8?B?QTJ2SDhNdmo1bERzL3FqUWNPOTdRN1YwR0dRaUsySzVHeVhqZ1lwNStoL0tW?=
 =?utf-8?B?ak5yaEh3U2RFYzZlVjl2aXZEU1I1d3ROYUtQVXR3eURyOURjY1JqS25XcXJv?=
 =?utf-8?B?cStqSm5JMzVqMkMxMGoxU0w1VmdzR3ZRTU9vTURacG5tVWdrdStHeGc5VW4v?=
 =?utf-8?B?Tk42azN5b0JWWFBjV2xZUW1vWkRhQ0d6MS9DVmF1a2xCRDlkTlJYS2ZkWjhl?=
 =?utf-8?B?R0R0Y0dRZk5jbERLbE1hQVFxbnNJUU4rZVloSkdkdStzVWJyeTQ5bnFBNk5r?=
 =?utf-8?B?UWlia2cyVGlicjB1c3I1cjJVWGR4bGE5L1JTbmFScktXMi9UTVVPSkRqMStL?=
 =?utf-8?B?RVR1THFad3lWTWhCMVFldWhSeVB0SUlRSTlNQ0k5UjEwb0pxeEJyZS9tWEcw?=
 =?utf-8?B?TXJmd1NUOEFvNWRydUtYWStIK3BuM282TXMwaytjWjhqMmU3MDZQaG5oVXA2?=
 =?utf-8?B?U0c3czNRWTR0VDVoRm9HSFpZK3l1L051blFxNGhMeGVNWXZmTVNzQ0JucWta?=
 =?utf-8?B?andLbmIxTlFyNmNhTEVCMlNWNngrWVhKNnZaOG5DQUU1cWRXTFA0YytlcDFm?=
 =?utf-8?B?RlBRMXNYMWQvb2lQUmZUdWJOMkRweHJQQWxqWlhXSmJEY1NTZm9mNTgzckpT?=
 =?utf-8?B?RXUwTk1pMHRLWVNxelZkdkVGOE0yQ0kya1lJTi9scW5rMk1MZ3RWOHgyWlg4?=
 =?utf-8?B?djNES1RHMXkrYytGTG1LRFZTS1B2YTRlWi9SeHdTQ1hSKzBaUWsvOHArdHNi?=
 =?utf-8?B?RHF1b0pTdzdmSGhabHVXNEVrNGd0MEJUcHJCcmhzZzdYVHo4c2x6T3RqRGg4?=
 =?utf-8?B?RWZ6T2lMbnpZdTNZelNMWXRNOGZJL2FXdThFNkh6ckxycVZvNkljQ3BsV1hs?=
 =?utf-8?B?RGFXUW4vRDAyanFtR2ExdGNJeHZnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D5ED414AD0F9F64E9F3EB8B762060666@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8fe5971-269d-4162-d7af-08d9fd05e6cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2022 11:06:43.1765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m7LngI6hyyng8KZEJD/7j5DNjU+486sg1Un1FH4XEXwQg8HpAyz/7gfea6Fv8DOxDNiHWAPs+L+U1eEWbbpGmeyu9qyfkc6GzOw6K1oT6Bk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6649
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

T24gMDMvMDMvMjAyMiAxMDo1MywgTWlyb3NsYXYgQmVuZXMgd3JvdGU6DQo+IEhpLA0KPg0KPiBP
biBUaHUsIDI0IEZlYiAyMDIyLCBQZXRlciBaaWpsc3RyYSB3cm90ZToNCj4NCj4+IERlY29kZSBF
TkRCUiBpbnN0cnVjdGlvbnMgYW5kIFdBUk4gYWJvdXQgTk9UUkFDSyBwcmVmaXhlcy4NCj4gSSBn
dWVzcyBpdCBoYXMgYmVlbiBhbHJlYWR5IG1lbnRpb25lZCBzb21ld2hlcmUsIGJ1dCBjb3VsZCB5
b3UgZXhwbGFpbiANCj4gTk9UUkFDSyBwcmVmaXggaGVyZSwgcGxlYXNlPyBJZiBJIHVuZGVyc3Rh
bmQgaXQgcmlnaHQsIGl0IGRpc2FibGVzIElCVCBmb3IgDQo+IHRoZSBpbmRpcmVjdCBicmFuY2gg
aW5zdHJ1Y3Rpb24gbWVhbmluZyB0aGF0IGl0cyB0YXJnZXQgZG9lcyBub3QgaGF2ZSB0byANCj4g
c3RhcnQgd2l0aCBFTkRCUj8NCg0KQ0VULUlCVCBoYXMgbG9hZHMgb2YgZ2V0LW91dCBjbGF1c2Vz
LsKgIFRoZSBOT1RSQUNLIHByZWZpeCBpcyBvbmU7IHRoZQ0KbGVnYWN5IGNvZGUgYml0bWFwIChp
bXBsaWNpdCBOT1RSQUNLIGZvciB3aG9sZSBsaWJyYXJpZXMpIGlzIGFub3RoZXIuDQoNCkFuZCB5
ZXMgLSB0aGUgcHVycG9zZSBvZiBOT1RSQUNLIGlzIHRvIGV4ZW1wdCBhIHNwZWNpZmljIGluZGly
ZWN0IGJyYW5jaA0KZnJvbSBjaGVja3MuDQoNCkdDQyBjYW4gZW1pdCBOT1RSQUNLJ2QgY2FsbHMg
aW4gc29tZSBjYXNlcyB3aGVuIGUuZy4gdGhlIHByb2dyYW1tZXINCmxhdW5kZXJzIGEgZnVuY3Rp
b24gcG9pbnRlciB0aHJvdWdoICh2b2lkICopLCBvciB3aGVuDQpfX2F0dHJpYnV0ZV9fKChub19j
Zl9jaGVjaykpIGlzIHVzZWQgZXhwbGljaXRseS4NCg0KDQpFYWNoIG9mIHRoZSBnZXQtb3V0IGNs
YXVzZXMgaGFzIHNlcGFyYXRlIGVuYWJsZSBiaXRzLCBhcyBlYWNoIG9mIHRoZW0NCnJlZHVjZXMg
c2VjdXJpdHkuwqAgSW4gdGhpcyBzZXJpZXMsIExpbnV4IHNldHMgTVNSX1NfQ0VULkVOREJSX0VO
IGJ1dA0Kc3BlY2lmaWNhbGx5IGRvZXMgbm90IHNldCBOT1RSQUNLX0VOLCBzbyBOT1RSQUNLIHBy
ZWZpeGVzIHdpbGwgYmUNCmlnbm9yZWQgYW5kIHN1ZmZlciAjQ1AgaWYgZW5jb3VudGVyZWQuDQoN
Cn5BbmRyZXcNCg==
